<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<% Response.Addheader "P3P","policyref=""/w3c/p3p.xml"", CP=""CONi NOI DSP LAW NID PHY ONL OUR IND COM"""%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/event/timesale/timesaleCls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성 /lib/inc/head.asp 삭제
''strPageTitle = "텐바이텐 10X10 : 장바구니 확인"		'페이지 타이틀 (필수)

''추가 로그 //2016/05/18 by eastone
function AppendLog_shoppingBagProc()
    dim iAddLogs
    ''if NOT (application("Svr_Info")="Dev") then exit function ''실서버 잠시 중지시.
        
    iAddLogs=request.Cookies("tinfo")("shix")
    if (iAddLogs="") then    
        iAddLogs=request.Cookies("shoppingbag")("GSSN")
    end if
    iAddLogs = "uk="&iAddLogs
    
    if (request.ServerVariables("QUERY_STRING")<>"") then iAddLogs="&"&iAddLogs
    
    iAddLogs=iAddLogs&"&ggsn="&fn_getGgsnCookie() ''2017/11/07 추가
    iAddLogs=iAddLogs&"&mode="&request.Form("mode")&"&rdsite="&request.cookies("rdsite")
    ''''&"&itemid="&request.Form("itemid")&"&itemoption="&request.Form("itemoption")&"&itemea="&request.Form("itemea")
    
    response.AppendToLog iAddLogs
    
end function


'' 사이트 구분
Const sitename = "10x10"

dim i, tmparr
dim userid, guestSessionID
userid = GetLoginUserID
guestSessionID = GetGuestSessionKey()

dim mode            : mode		    = requestCheckVar(request.Form("mode"),10)
dim itemid          : itemid		= requestCheckVar(request.Form("itemid"),9)
dim itemoption      : itemoption    = requestCheckVar(request.Form("itemoption"),4)
dim itemea          : itemea  	    = requestCheckVar(request.Form("itemea"),9)
dim bagarr          : bagarr	    = request.Form("bagarr")
dim requiredetail   : requiredetail = html2db(request.Form("requiredetail"))
dim chk_item        : chk_item      = request("chk_item")
dim bTp             : bTp           = request("bTp") ''dim jumundiv        : jumundiv      = request("jumundiv")  '' 2013/09 수정
dim ckdidx
dim vOpenerChk		: vOpenerChk	= requestCheckvar(request("op"),1)
dim countryCode     : countryCode   = requestCheckvar(request("countryCode"),2)
dim rentalmonth     : rentalmonth   = requestCheckvar(request("rentalmonth"),20)

if requestCheckVar(request("rdsite"),32)<>"" then
	if (request.cookies("rdsite")<>requestCheckVar(request("rdsite"),32)) then
		response.cookies("rdsite").domain = "10x10.co.kr"
		response.cookies("rdsite") = requestCheckVar(request("rdsite"),32)
		response.cookies("rddata") = requestCheckVar(request("rddate"),32)
	end if
end if

Dim tp : tp = requestCheckVar(request("tp"),10)   '' not post
Dim fc : fc = requestCheckVar(request.Form("fc"),10)

Dim ValidRet
Dim retBool, iErrMsg

if (itemid<>"") and (itemoption<>"") and (itemea<>"") and (mode="") then
    mode = "add"
end if

dim oShoppingBag
set oShoppingBag = new CShoppingBag
oShoppingBag.FRectUserID    = userid
oshoppingbag.FRectSessionID = guestSessionID
oShoppingBag.FRectSiteName  = sitename

dim NotValidItemExists, itemarr

'// 2015상단 헤더 장바구니 얼럿 자료 리셋 함수 출력 (ajax방식은 제외)
if tp<>"ajax" then
	Response.Write "<script>" & vbCrLf
	Response.Write "function fnDelCartAll() {" & vbCrLf
	Response.Write "	if(typeof(Storage) !== ""undefined"") {" & vbCrLf
	Response.Write "		sessionStorage.removeItem(""cart"");" & vbCrLf
	Response.Write "	}" & vbCrLf
	Response.Write "}" & vbCrLf
	Response.Write "</script>" & vbCrLf
end if

if itemid <> "" and not (mode="del" or mode="edit" or mode="DLARR") then
	itemid = request.Form("itemid")
	itemarr = chk_item
	if not isOnTimeProduct(userid,itemid,itemarr) then
		if tp="ajax" then
			Response.Write "0||0"
			dbget.close() : response.end
		else
			response.write "<script>alert('정상적인 경로로 접근해주세요.');</script>"
			response.write "<script>history.back();</script>"		
			dbget.close() : response.end
		end if
	end if
end if
if bagarr <> "" then
	itemarr = chk_item
	if not isOnTimeProduct(userid,bagarr,itemarr) then
		if tp="ajax" then
			Response.Write "0||0"
			dbget.close() : response.end
		else
			response.write "<script>alert('정상적인 경로로 접근해주세요.');</script>"
			response.write "<script>history.back();</script>"		
			dbget.close() : response.end
		end if
	end if
end if

'// 일단 급한대로 제한조건 때려넣고 추후 다시 구현 고민..
If itemid="3021200" or itemid="3020771" or itemid="3020770" or itemid="3021111" or itemid="3021135" or itemid="3021133" Then
	If now() >= #07/21/2020 00:00:00# and now() < #07/21/2020 18:00:00# Then
		response.write "<script>alert('정상적인 경로로 접근해주세요.');</script>"
		response.write "<script>history.back();</script>"		
		dbget.close() : response.end
	End If
	If now() >= #07/22/2020 00:00:00# and now() < #07/22/2020 18:00:00# Then
		response.write "<script>alert('정상적인 경로로 접근해주세요.');</script>"
		response.write "<script>history.back();</script>"		
		dbget.close() : response.end
	End If
	If now() >= #07/23/2020 00:00:00# and now() < #07/23/2020 18:00:00# Then
		response.write "<script>alert('정상적인 경로로 접근해주세요.');</script>"
		response.write "<script>history.back();</script>"		
		dbget.close() : response.end
	End If				
End If

if (mode="add") then
    if (itemid<>"") and (itemoption<>"") and (itemea<>"") then

        ValidRet = oshoppingbag.checkValidItem(itemid,itemoption)
        if (ValidRet=0) then
            if (tp<>"ajax") then
	            response.write "<script>alert('죄송합니다. 유효하지 않은 상품이거나 품절된 상품입니다.');</script>"
	            response.write "<script>history.back();</script>"
	        end if

            dbget.close() : response.end
        elseif (ValidRet=2) then
            ''동일한 상품이 이미 장바구니에 있을경우 : Confirm 후 담기
            if (fc<>"") then
                oshoppingbag.AddshoppingBagDB itemid,itemoption,itemea,requiredetail
                ValidRet = 1
                if (tp="pop") then
                    response.write "<script>self.close();</script>"
                    dbget.close() : response.end
                end if
            else
                oshoppingbag.AddshoppingBagDB itemid,itemoption,itemea,requiredetail
                ''response.write "<script>alert('동일상품이 존재..');</script>"
                ''dbget.close() : response.end
            end if
        else
            oshoppingbag.AddshoppingBagDB itemid,itemoption,itemea,requiredetail
            ValidRet = 1
        end if

        '// 장바구니에 상품을 담은 후 렌탈 상품일 경우 month값도 담는다.
        If Trim(rentalmonth) <> "" Then
            oshoppingbag.RentalProductBaguniUpdateMonth itemid,itemoption,itemea,rentalmonth
        End If		
    else
    	ValidRet = 9
    end if

elseif (mode="edit") then
    if (itemid<>"") and (itemoption<>"") and (itemea<>"") then
		oshoppingbag.EditshoppingBagDB itemid,itemoption,itemea
	end if

elseif (mode="arr") then
    ''''관심품목에서 담을때는 1개로..
    'response.write "bagarr=" & bagarr
    'response.end
    NotValidItemExists = false

	bagarr = split(bagarr,"|")

	for i=LBound(bagarr) to UBound(bagarr)
	    if Trim(bagarr(i))<>"" then
			tmparr = split(bagarr(i),",")
			if UBound(tmparr)>1 then
				if (tmparr(0)<>"") and (tmparr(1)<>"") and (tmparr(2)<>"") then
					if getNumeric(tmparr(2))="" then tmparr(2)=1
				    ValidRet = oshoppingbag.checkValidItem(tmparr(0),tmparr(1))

				    if ubound(tmparr)>2 then
				    	requiredetail = html2db(tmparr(3))  '''html2db 추가
				    else
				    	requiredetail = ""
				    end if

				    if (ValidRet=0) then
				        NotValidItemExists = true
				    elseif (ValidRet=2) then
	                    ''동일한 상품이 이미 장바구니에 있을경우 : Confirm 후 담기(X) ? or 1개로 조정
	                    'oshoppingbag.EditshoppingBagDB tmparr(0),tmparr(1),1
	                    oshoppingbag.AddshoppingBagDB tmparr(0),tmparr(1),tmparr(2),requiredetail
	                else
				        oshoppingbag.AddshoppingBagDB tmparr(0),tmparr(1),tmparr(2),requiredetail
				    end if
				end if
			end if
		end if
	next
	ValidRet=1
elseif (mode="del") then
	itemid = split(itemid,",")
	itemoption = split(itemoption,",")
	itemea = split(itemea,",")
	for i=LBound(itemid) to UBound(itemid)
	    if (Trim(itemid(i))<>"") and (Trim(itemoption(i))<>"") and (Trim(itemea(i))<>"") then
			oshoppingbag.EditshoppingBagDB Trim(itemid(i)),Trim(itemoption(i)),Trim(itemea(i))
		end if
	next

elseif (mode="DO1") then
	'// 일단 급한대로 제한조건 때려넣고 추후 다시 구현 고민..
	If itemid="3021200" or itemid="3020771" or itemid="3020770" or itemid="3021111" or itemid="3021135" or itemid="3021133" Then
		If now() >= #07/21/2020 00:00:00# and now() < #07/21/2020 18:00:00# Then
			response.write "<script>alert('정상적인 경로로 접근해주세요.');</script>"
			response.write "<script>history.back();</script>"		
			dbget.close() : response.end
		End If
		If now() >= #07/22/2020 00:00:00# and now() < #07/22/2020 18:00:00# Then
			response.write "<script>alert('정상적인 경로로 접근해주세요.');</script>"
			response.write "<script>history.back();</script>"		
			dbget.close() : response.end
		End If
		If now() >= #07/23/2020 00:00:00# and now() < #07/23/2020 18:00:00# Then
			response.write "<script>alert('정상적인 경로로 접근해주세요.');</script>"
			response.write "<script>history.back();</script>"		
			dbget.close() : response.end
		End If				
	End If
	
    ''바로 주문.(선택 초기화 > 해당상품 체크 > 주문페이지로 이동)
    if (itemid<>"") and (itemoption<>"") and (itemea<>"") then
		'선택 초기화
		call oshoppingbag.OrderCheckOutDefault

        '장바구니수 업데이트
        if oshoppingbag.checkValidItem(itemid,itemoption)=1 then
        	Call SetCartCount(GetCartCount+1)
        end if

    	'장바구니 담기
    	oshoppingbag.AddshoppingBagDB itemid,itemoption,itemea,requiredetail

        '// 장바구니에 상품을 담은 후 렌탈 상품일 경우 month값도 담는다.
        If Trim(rentalmonth) <> "" Then
            oshoppingbag.RentalProductBaguniUpdateMonth itemid,itemoption,itemea,rentalmonth
        End If				
    end if

    if (oshoppingbag.CheckOutOneItem(itemid,itemoption,itemea)) then
        dbget.close()
        'response.redirect SSLURL & "/inipay/UserInfo.asp"
        Call AppendLog_shoppingBagProc() ''2016/05/18 추가
        response.write "<script>fnDelCartAll(); top.location.replace('" & SSLURL & "/inipay/UserInfo.asp?bTp=" & bTp & CHKIIF(bTp="f" and countryCode<>"","&ctrCd="&countryCode,"") & "');</script>"
        response.end
    else
        response.write "<script>alert('죄송합니다. 유효하지 않은 상품이거나 품절된 상품입니다.');</script>"
        response.write "<script>history.back();</script>"

        dbget.close() : response.end
    end if

elseif (mode="DO2") then
	dim vAddItemCnt: vAddItemCnt=0
	dim vChkOutItem: vChkOutItem=false

	''바로 주문(배열)
	bagarr = split(bagarr,"|")

	'선택 초기화
	if UBound(bagarr)>0 then
		call oshoppingbag.OrderCheckOutDefault
	end if

	for i=LBound(bagarr) to UBound(bagarr)
	    if Trim(bagarr(i))<>"" then
			tmparr = split(bagarr(i),",")
			if UBound(tmparr)>1 then
				if (tmparr(0)<>"") and (tmparr(1)<>"") and (tmparr(2)<>"") then
					if getNumeric(tmparr(2))="" then tmparr(2)=1
				    ValidRet = oshoppingbag.checkValidItem(tmparr(0),tmparr(1))

				    if ubound(tmparr)>2 then
				    	requiredetail = html2db(tmparr(3))  '''html2db 추가
				    else
				    	requiredetail = ""
				    end if

				    if (ValidRet=2) then
	                    ''동일한 상품이 이미 장바구니에 있을경우
	                    ''oshoppingbag.EditshoppingBagDB tmparr(0),tmparr(1),tmparr(2)
	                    oshoppingbag.AddshoppingBagDB tmparr(0),tmparr(1),tmparr(2),requiredetail
	                else
				        oshoppingbag.AddshoppingBagDB tmparr(0),tmparr(1),tmparr(2),requiredetail
				        vAddItemCnt = vAddItemCnt + 1
				    end if

				    '장바구니 담기
				    if (oshoppingbag.CheckOutOneItem(tmparr(0),tmparr(1),tmparr(2))) then	vChkOutItem=true
				end if
			end if
		end if
	next

    '장바구니수 업데이트
    Call SetCartCount(GetCartCount+vAddItemCnt)

    if vChkOutItem then
        dbget.close()
        ''response.redirect SSLURL & "/inipay/UserInfo.asp"
        Call AppendLog_shoppingBagProc() ''2016/05/18 추가
        response.write "<script>fnDelCartAll(); top.location.replace('" & SSLURL & "/inipay/UserInfo.asp" & "');</script>"
        response.end
        
    else
        response.write "<script>alert('죄송합니다. 유효하지 않은 상품이거나 품절된 상품입니다.');</script>"
        response.write "<script>history.back();</script>"

        dbget.close() : response.end
    end if
elseif (mode="UPS") then
    ''바로 주문. onClickUpsell
    if (itemid<>"") and (itemoption<>"") and (itemea<>"") then
		'선택 초기화
		''call oshoppingbag.OrderCheckOutDefault

        '장바구니수 업데이트
        if oshoppingbag.checkValidItem(itemid,itemoption)=1 then
        	Call SetCartCount(GetCartCount+1)
        end if

    	'장바구니 담기
    	session("ssnupsell")="1"
    	oshoppingbag.AddshoppingBagDB itemid,itemoption,itemea,requiredetail
    end if

    if (oshoppingbag.CheckOutOneItem(itemid,itemoption,itemea)) then
        dbget.close()
        'response.redirect SSLURL & "/inipay/UserInfo.asp"
        Call AppendLog_shoppingBagProc() ''2016/05/18 추가
        response.write "<script>fnDelCartAll(); top.location.replace('" & SSLURL & "/inipay/UserInfo.asp?bTp=" & bTp & CHKIIF(bTp="f" and countryCode<>"","&ctrCd="&countryCode,"") & "');</script>"
        response.end
    else
        response.write "<script>alert('죄송합니다. 유효하지 않은 상품이거나 품절된 상품입니다.');</script>"
        response.write "<script>history.back();</script>"

        dbget.close() : response.end
    end if


elseif (mode="OCK") then
    ''선택상품 주문
    chk_item   = split(chk_item,",")
    itemid     = split(request.Form("itemid"),",")
    itemoption = split(request.Form("itemoption"),",")

    if IsArray(chk_item) then
        retBool = True
        ''다른상품 모두 초기화..
        If (Not oshoppingbag.OrderCheckOutDefault) then
	        retBool = false
	        iErrMsg = "장바구니 수정중 오류가 발생 하였습니다. Err-101"
	    end if

	    IF (retBool) then
            for i=LBound(chk_item) to UBound(chk_item)
                ckdidx = Trim(chk_item(i))
        	    if ckdidx<>"" then
        			if (Trim(itemid(ckdidx))<>"") and (Trim(itemoption(ckdidx))<>"") then
        			    If (Not oshoppingbag.CheckOutOneItem(Trim(itemid(ckdidx)),Trim(itemoption(ckdidx)),0)) then
        			        retBool= false
        			        iErrMsg = "장바구니 수정중 오류가 발생 하였습니다. 상품코드:"&Trim(itemid(ckdidx))
        			    end if
        			end if
        		end if
        	next
        End if
    end if

    IF (retBool) then
        Call AppendLog_shoppingBagProc() ''2016/05/18 추가
        if (bTp<>"")  then
            ''response.redirect SSLURL & "/inipay/UserInfo.asp?bTp=" & bTp & CHKIIF(bTp="f" and countryCode<>"","&ctrCd="&countryCode,"")
	        response.write "<script>fnDelCartAll(); top.location.replace('" & SSLURL & "/inipay/UserInfo.asp?bTp=" & bTp & CHKIIF(bTp="f" and countryCode<>"","&ctrCd="&countryCode,"") & "');</script>"
	        dbget.close() : response.end
        else
            ''response.redirect SSLURL & "/inipay/UserInfo.asp"
	        response.write "<script>fnDelCartAll(); top.location.replace('" & SSLURL & "/inipay/UserInfo.asp" & "');</script>"
	        dbget.close() : response.end
        end if
    Else
        response.write "<script>alert('"&iErrMsg&"');</script>"
        response.write "<script>history.back();</script>"

        dbget.close() : response.end
    End if
elseif (mode="ALK") then
    ''전체주문
    retBool = oshoppingbag.CheckOutALLItem

    IF (retBool) then
        Call AppendLog_shoppingBagProc() ''2016/05/18 추가
        if (bTp<>"") and (bTp<>"1") then
            'response.redirect SSLURL & "/inipay/UserInfo.asp?bTp=" & bTp & CHKIIF(bTp="f" and countryCode<>"","&ctrCd="&countryCode,"")
	        response.write "<script>fnDelCartAll(); top.location.replace('" & SSLURL & "/inipay/UserInfo.asp?bTp=" & bTp & CHKIIF(bTp="f" and countryCode<>"","&ctrCd="&countryCode,"") & "');</script>"
	        dbget.close() : response.end
        else
            ''response.redirect SSLURL & "/inipay/UserInfo.asp"
	        response.write "<script>fnDelCartAll(); top.location.replace('" & SSLURL & "/inipay/UserInfo.asp" & "');</script>"
	        dbget.close() : response.end
        end if
    Else
        iErrMsg = "장바구니 수정중 오류가 발생 하였습니다. Err-201"
        response.write "<script>alert('"&iErrMsg&"');</script>"
        response.write "<script>history.back();</script>"

        dbget.close() : response.end
    End if
elseif (mode="DLARR") then
    ''장바구니에서 삭제
    chk_item   = split(chk_item,",")
    itemid     = split(request.Form("itemid"),",")
    itemoption = split(request.Form("itemoption"),",")

    if IsArray(chk_item) then
        retBool = True
        for i=LBound(chk_item) to UBound(chk_item)
            ckdidx = Trim(chk_item(i))
    	    if ckdidx<>"" then
    			if (Trim(itemid(ckdidx))<>"") and (Trim(itemoption(ckdidx))<>"") then
    			     oshoppingbag.EditshoppingBagDB Trim(itemid(ckdidx)),Trim(itemoption(ckdidx)),0

    			end if
    		end if
    	next
    end if

else
    '' noparams
    response.write "<script>alert('No params : '"&mode&");</script>"

end if



Dim sBagCount : sBagCount = getDBCartCount
set oshoppingbag = Nothing

Call AppendLog_shoppingBagProc() ''2016/05/18 추가
%>

<%

''상품이 이미 존재하는경우 ShoppingBag.asp에서 pop  and (ValidRet<>2)
if (tp="ajax") then
	''ValidRet - 0:유효하지 않은 상품, 1:성공, 2:중복담김, 9:오류
	Call setCartCount(sBagCount)
	Response.Write ValidRet&"||"&sBagCount
elseif (tp="pop") then
%>
	<!DOCTYPE html>
	<html lang="ko">
	<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta property="og:title" content="텐바이텐 10X10 : 장바구니 확인" />
	<meta property="og:type" content="website" />
	<meta property="og:url" content="http://www.10x10.co.kr" />
	<link rel="stylesheet" type="text/css" href="/lib/css/default.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/common.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/content.css" />
    <link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
	<!--[if IE]>
		<link rel="stylesheet" type="text/css" href="/lib/css/preVst/ie.css" />
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="/lib/css/commonV15.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
    <link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
    <script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js"></script>
	    <script type="text/javascript">
	    opener.fnDelCartAll();

	    function TnShoppingBagList(){
	    	<% If vOpenerChk = "o" Then %>
	    	opener.close();
	    	opener.opener.document.location.href='/inipay/shoppingbag.asp';
	    	<% Else %>
	    	opener.document.location.href='/inipay/shoppingbag.asp';
	    	<% End If %>
	    	self.close();
	    }

	    function TnShoppingBagForceAdd(){
	        document.frmConfirm.submit();
	    }
	    </script>
	    <%
        ''장바구니 갯수 세팅.
        if (GetCartCount<>sBagCount) then
            Call setCartCount(sBagCount)
            if (tp<>"pop") then
                response.write "<script>if (document.all.ibgaCNT){document.all.ibgaCNT.innerHTML='"&sBagCount&"'};</script>"
            else
                response.write "<script>if (opener.document.all.ibgaCNT){opener.document.all.ibgaCNT.innerHTML='"&sBagCount&"'};</script>"
            end if
        end if
        %>
	</head>
	<div class="addCart">
		<p>
		<% if (mode="add") and (ValidRet=2) then %>
		<img src="http://fiximage.10x10.co.kr/web2013/cart/txt_double_cart.gif" alt="장바구니에 같은 상품이 있습니다. 추가하시겠습니까?" />
		<% else %>
		<img src="http://fiximage.10x10.co.kr/web2013/inipay/txt_product_add_to_cart.gif" alt="상품을 장바구니에 담았습니다." />
		<% end if %>
		</p>
		<div class="btnArea">
			<a href="" onclick="self.close();return false;" class="btn btnRed">쇼핑 계속하기</a>
			<% if (mode="add") and (ValidRet=2) then %>
			<a href="" onclick="TnShoppingBagForceAdd();return false;" class="btn btnWhite">장바구니 담기</a>
			<% else %>
			<a href="" onclick="TnShoppingBagList();return false;" class="btn btnWhite">장바구니 가기</a>
			<% end if %>
		</div>
	    <form name="frmConfirm" method="post">
	    <input type="hidden" name="mode" value="<%= mode %>">
	    <input type="hidden" name="tp" value="<%= tp %>">
	    <input type="hidden" name="fc" value="on">
	    <input type="hidden" name="itemid" value="<%= itemid %>">
	    <input type="hidden" name="itemoption" value="<%= itemoption %>">
	    <input type="hidden" name="itemea" value="<%= itemea %>">
	    <input type="hidden" name="requiredetail" value="<%= doubleQuote(requiredetail) %>">
	    <% If vOpenerChk = "o" Then %>
	    <input type="hidden" name="op" value="<%= vOpenerChk %>">
	    <% End If %>
	    </form>
	</div>
	<script type="text/javascript">
	$(function(){
		<% if (mode="add") and (ValidRet=2) then %>
		//팝업 리사이즈 (+20,50)
		resizeTo(410,280);
		<% else %>
		//팝업 리사이즈 (+20,50)
		resizeTo(400,330);
		<% end if %>
	});
	</script>
	</body>
</html>
<%
else
    if (ValidRet<>2) then
        dbget.close()

%>
        <script language='javascript'>
		<% If vOpenerChk = "o" Then %>
        opener.fnDelCartAll();
        opener.location.href = "ShoppingBag.asp";
        window.close();
		<% Else %>
        fnDelCartAll();
        location.href = "ShoppingBag.asp<%=CHKIIF(bTp<>"","?bTp="&bTp,"") %>";
		<% End If %>
        </script>
<%
        response.end
    else

%>
        <form name="frmCk" method="post" action="ShoppingBag.asp">
        <input type="hidden" name="chKdp" value="on">
        <input type="hidden" name="itemid" value="<%= itemid %>">
        <input type="hidden" name="itemoption" value="<%= itemoption %>">
        <input type="hidden" name="itemea" value="<%= itemea %>">
        <input type="hidden" name="requiredetail" value="<%= doubleQuote(requiredetail) %>">
        </form>
        <script language='javascript'>
		fnDelCartAll();
		<% If vOpenerChk = "o" Then %>
        document.frmCk.target = "category_list";
        document.frmCk.submit();
        window.close();
		<% Else %>
        document.frmCk.submit();
		<% End If %>
        </script>
<%
        dbget.close() : response.end
    end if
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->