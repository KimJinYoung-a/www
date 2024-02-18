<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/badgelib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<style type="text/css">
.popContent {padding:0;}
.wishAction .action {padding:47px 0 59px; background-color:#f8f8f8; text-align:center;}
.wishAction .btn {width:138px; margin-top:29px; padding-right:0; padding-left:0;}
.wishAction .help {margin:29px 30px 0;}
</style>
</head>
<script type="text/javascript">
	function myFavoriteClose(gid)
	{
		if (gid!="2")
		{
			self.close();			
		}
	}
	function setSnsitemWish(itemid){
		if(itemid == ""){
			return false;
		}		
		$itemObj = $("[itemid="+itemid+"]", opener.document);		
		$itemObj.find(".btn-wish").addClass("on")
		var wishCnt = $itemObj.find(".wish-cnt").text()
		if($.isNumeric(wishCnt)){
			wishCnt++;
			$itemObj.find(".wish-cnt").text(wishCnt)
		}
	}
</script>
<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/lib/js/tenbytencommon.js"></script>
<%

dim i, sqlStr ,userid, bagarray, mode, itemid ,backurl,fidx,oldfidx ,arrList, intLoop, vOpenerChk, vTemp , vECode
 	userid  	= getEncLoginUserID
	bagarray	= Trim(requestCheckvar(request("bagarray"),1024))
	mode    	= requestCheckvar(request("mode"),16)
	itemid  	= requestCheckvar(request("itemid"),9)
	fidx		= requestCheckvar(request("fidx"),9)
	backurl =  requestCheckvar(request("backurl"),100)
	oldfidx	= requestCheckvar(request("oldfidx"),9)
	vOpenerChk	= requestCheckvar(request("op"),1)

if backurl ="" then backurl = request.ServerVariables("HTTP_REFERER")
dim myfavorite, vWishEventOX
vWishEventOX = "x"
'####### 위시리스트 이벤트용으로 구분값에 따라 데이터 처리.

set myfavorite = new CMyFavorite
	'---데이터 처리
	myfavorite.FRectUserID = userid
	myfavorite.FFolderIdx = fidx

	arrList = myfavorite.fnGetFolderList

'	If Now() > #02/11/2015 00:00:00# AND Now() < #02/23/2015 00:00:00# Then
'		IF isArray(arrList) THEN
'			For intLoop = 0 To UBound(arrList,2)
'				If trim(arrList(1,intLoop)) = "넣어둬 넣어둬" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
'					vWishEventOX = "o"
'				End If
'				If trim(arrList(1,intLoop)) = "넣어둬 넣어둬" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
'					vWishEventOX = "c"
'				End If
'			Next
'		End If
'	End If

	If Now() > #08/24/2015 00:00:00# AND Now() < #08/31/2015 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "내가 꿈꾸는 키친" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "64860"
						Else
							vECode = "65703"
						End If
				End If
				If trim(arrList(1,intLoop)) = "내가 꿈꾸는 키친" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "64860"
						Else
							vECode = "65703"
						End If
				End If
			Next
		End If
	End If

	If Now() > #08/31/2015 00:00:00# AND Now() < #09/07/2015 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "내가 꿈꾸는 서재" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "64866"
						Else
							vECode = "65808"
						End If
				End If
				If trim(arrList(1,intLoop)) = "내가 꿈꾸는 서재" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "64866"
						Else
							vECode = "65808"
						End If
				End If
			Next
		End If
	End If


	If Now() > #09/07/2015 00:00:00# AND Now() < #09/14/2015 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "내가 꿈꾸는 침실" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "64876"
						Else
							vECode = "65972"
						End If
				End If
				If trim(arrList(1,intLoop)) = "내가 꿈꾸는 침실" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "64876"
						Else
							vECode = "65972"
						End If
				End If
			Next
		End If
	End If

	If Now() > #09/14/2015 00:00:00# AND Now() < #09/21/2015 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "내가 꿈꾸는 거실" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "64881"
						Else
							vECode = "66102"
						End If
				End If
				If trim(arrList(1,intLoop)) = "내가 꿈꾸는 거실" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "64881"
						Else
							vECode = "66102"
						End If
				End If
			Next
		End If
	End If

	If Now() > #09/22/2015 00:00:00# AND Now() < #09/28/2015 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "달님" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "64894"
						Else
							vECode = "66331"
						End If
				End If
				If trim(arrList(1,intLoop)) = "달님" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "64894"
						Else
							vECode = "66331"
						End If
				End If
			Next
		End If
	End If

	If Now() > #11/05/2015 00:00:00# AND Now() < #11/14/2015 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "습격자들" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "65944"
						Else
							vECode = "67204"
						End If
				End If
				If trim(arrList(1,intLoop)) = "습격자들" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "65944"
						Else
							vECode = "67204"
						End If
				End If
			Next
		End If
	End If

	If Now() > #12/14/2015 00:00:00# AND Now() < #12/21/2015 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "크리스마스 선물" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "65981"
						Else
							vECode = "67490"
						End If
				End If
				If trim(arrList(1,intLoop)) = "크리스마스 선물" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "65981"
						Else
							vECode = "67490"
						End If
				End If
			Next
		End If
	End If

	If Now() > #12/28/2015 00:00:00# AND Now() < #01/04/2016 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "2016 소원수리" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "65994"
						Else
							vECode = "68315"
						End If
				End If
				If trim(arrList(1,intLoop)) = "2016 소원수리" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "65994"
						Else
							vECode = "68315"
						End If
				End If
			Next
		End If
	End If

	If Now() > #02/10/2016 10:00:00# AND Now() < #02/15/2016 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "오늘은 털날" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "66021"
						Else
							vECode = "68889"
						End If
				End If
				If trim(arrList(1,intLoop)) = "오늘은 털날" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
						IF application("Svr_Info") = "Dev" THEN
							vECode = "66021"
						Else
							vECode = "68889"
						End If
				End If
			Next
		End If
	End If

	If Now() > #04/04/2016 00:00:00# AND Now() < #04/08/2016 23:59:59# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "PROWISH 101" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "66096"
					Else
						vECode   =  "69919"
					End If
				End If
				If trim(arrList(1,intLoop)) = "PROWISH 101" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "66096"
					Else
						vECode   =  "69919"
					End If
				End If
			Next
		End If
	End If

	If Now() > #05/26/2016 00:00:00# AND Now() < #06/06/2016 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "또! 담아영" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "66139"
					Else
						vECode   =  "70923"
					End If
				End If
				If trim(arrList(1,intLoop)) = "또! 담아영" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "66139"
					Else
						vECode   =  "70923"
					End If
				End If
			Next
		End If
	End If

	If Now() > #09/08/2016 00:00:00# AND Now() < #09/26/2016 00:00:00# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "달님♥" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "66197"
					Else
						vECode   =  "72959"
					End If
				End If
				If trim(arrList(1,intLoop)) = "달님♥" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "66197"
					Else
						vECode   =  "72959"
					End If
				End If
			Next
		End If
	End If

	If Now() > #11/18/2016 00:00:00# and Now() < #12/18/2016 23:59:59# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "산타의 WISH" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "66238"
					Else
						vECode   =  "74319"
					End If
				End If
				If trim(arrList(1,intLoop)) = "산타의 WISH" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "66238"
					Else
						vECode   =  "74319"
					End If
				End If
			Next
		End If
	End If

	If Now() > #08/24/2017 00:00:00# and Now() < #09/03/2017 23:59:59# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "하트시그널" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "66418"
					Else
						vECode   =  "79963"
					End If
				End If
				If trim(arrList(1,intLoop)) = "하트시그널" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "66418"
					Else
						vECode   =  "79963"
					End If
				End If
			Next
		End If
	End If

	If Now() > #12/26/2019 00:00:00# and Now() < #01/12/2020 23:59:59# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "2020 소원템" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "90452"
					Else
						vECode   =  "99678"
					End If
				End If
				If trim(arrList(1,intLoop)) = "2020 소원템" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "90452"
					Else
						vECode   =  "99678"
					End If
				End If
			Next
		End If
	End If	

	If Now() > #12/23/2020 00:00:00# and Now() < #12/29/2020 23:59:59# Then
		IF isArray(arrList) THEN
			For intLoop = 0 To UBound(arrList,2)
				If trim(arrList(1,intLoop)) = "쓸데없는 선물" AND CStr(arrList(0,intLoop)) = CStr(fidx) Then
					vWishEventOX = "o"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "104280"
					Else
						vECode   =  "108614"
					End If
				End If
				If trim(arrList(1,intLoop)) = "쓸데없는 선물" AND CStr(arrList(0,intLoop)) = CStr(oldfidx) AND mode = "Change" Then
					vWishEventOX = "c"
					IF application("Svr_Info") = "Dev" THEN
						vECode   =  "104280"
					Else
						vECode   =  "108614"
					End If
				End If
			Next
		End If
	End If	

	if (mode = "DelFavItems") then
		myfavorite.selectdelete(bagarray)
		IF vWishEventOX = "o" Then
			myfavorite.FRectUserID	= userid
			myfavorite.FFolderIdx	= fidx
			myfavorite.Fevtcode	= vECode
			myfavorite.FItemID	= itemid
			myfavorite.fnWishListEventSave
		End IF
	elseif (mode= "AddFavItems") then
		myfavorite.selectedinsert(bagarray)
		'// 뱃지 카운트(위시 등록)
		Call MyBadge_CheckInsertBadgeLog(userid, "0004", "", bagarray, "")
		IF vWishEventOX = "o" Then
			myfavorite.FRectUserID	= userid
			myfavorite.FFolderIdx	= fidx
			myfavorite.Fevtcode	= vECode
			myfavorite.FItemID	= itemid
			myfavorite.fnWishListEventSave
		End If
		''2017/05/23 :: 위시 로그 추가==================================
		if (userid<>"") then
		    Dim bufBagArr : bufBagArr= split(bagarray,",")
		    if IsArray(bufBagArr) then
    		    for intloop = 0 to ubound(bufBagArr)
    		        if (bufBagArr(intLoop)<>"") then
    		            Call fnUserLogCheck("fav", userid, bufBagArr(intLoop), "", "arr", "pc")
    		        end if
    		    next
    		end if
		end if
		''==============================================================
	elseif (mode= "add") then
		myfavorite.iteminsert(itemid)
		'// 뱃지 카운트(위시 등록)
		Call MyBadge_CheckInsertBadgeLog(userid, "0004", "", itemid, "")
		IF vWishEventOX = "o" Then
			myfavorite.FRectUserID	= userid
			myfavorite.FFolderIdx	= fidx
			myfavorite.Fevtcode	= vECode
			myfavorite.FItemID	= itemid
			myfavorite.fnWishListEventSave
		End IF
		
		''2017/05/23 :: 위시 로그 추가==================================
		if (userid<>"") then
		    Call fnUserLogCheck("fav", userid, itemid, "", "", "pc")
		end if
		''==============================================================
	elseif(mode = "Change") then
		myfavorite.FOldFolderIdx		= oldfidx
		myfavorite.fnChangeFolder(bagarray)

		IF vWishEventOX = "c" Then
			vWishEventOX = "o"
			fidx = oldfidx
		End IF

		IF vWishEventOX = "o" Then
			myfavorite.FRectUserID	= userid
			myfavorite.FFolderIdx	= fidx
			myfavorite.Fevtcode	= vECode
			myfavorite.FItemID	= itemid
			myfavorite.fnWishListEventSave
		End IF
	end if

	'// 폴더 정보 업데이트
	myfavorite.fnUpdateFolderInfo

set myfavorite = nothing


Dim vQuery
If mode = "add" Then	'### 1개만 지울때 itemid만 넘어옴.
	bagarray = itemid
End IF
IF Left(bagarray,1) = "," Then		'### 끝에 , 일때 지워줌.
	bagarray = Right(bagarray,Len(bagarray)-1)
End IF
IF Right(bagarray,1) = "," Then		'### 끝에 , 일때 지워줌.
	bagarray = Left(bagarray,Len(bagarray)-1)
End IF

If Trim(bagarray) = "" Then
	dbget.close()
	response.end
End If

vQuery = "UPDATE R SET " & vbCrLf
vQuery = vQuery & " 	favcount = D.cnt " & vbCrLf
vQuery = vQuery & " FROM [db_item].[dbo].[tbl_item_Contents] AS R " & vbCrLf
vQuery = vQuery & " INNER JOIN " & vbCrLf
vQuery = vQuery & " ( " & vbCrLf
vQuery = vQuery & " 	SELECT itemid, count(itemid) AS cnt FROM [db_my10x10].[dbo].[tbl_myfavorite] where itemid in(" & bagarray & ") " & vbCrLf
vQuery = vQuery & " 	GROUP BY itemid " & vbCrLf
vQuery = vQuery & " ) AS D ON R.itemid = D.itemid " & vbCrLf
vQuery = vQuery & " where R.itemid in(" & bagarray & ") " & vbCrLf
'rw vQuery
dbget.Execute vQuery


if (mode = "DelFavItems") then
	response.write "<script>alert('위시리스트에서 삭제되었습니다.'); location.replace('" & backurl & "?fidx="&fidx&"');</script>"
	dbget.close()
	response.end
elseif(mode="Change") then
	response.write "<script>location.replace('" & backurl & "?fidx="&fidx&"');</script>"
	dbget.close()
	response.end
end if

%>

<%
	'// 위시액션 쿠폰발급
	Dim wishActionCouponChkValue
	'// 2015년 1월 18일까지 위시액션 쿠폰발급 일시중지(정다진 요청) ''2015/09/18 발급 중지 APP 에서 발행
	If (FALSE) and (Left(Now(), 10) >= "2015-01-19") Then
		wishActionCouponChkValue = Trim(fnWishActionCoupon(GetLoginUserID))
	Else
		wishActionCouponChkValue = "0"
	End If

	if backurl = "close" then
%>
<script type="text/javascript">
	//상품 목록 체크표시
	var $opObj = $("#wsIco<%=itemid%>,#PopwsIco<%=itemid%>",opener.document);
	var wcnt = $opObj.find("span").text().replace(/,/g,"");
	wcnt++;
	wcnt = setComma(wcnt);
	$opObj.find("span").text(wcnt);
	$opObj.addClass('myWishOn');
	// 창닫기
	//self.close();

	//위시 등록 후 페이지에 따라 분기처리
	if(opener){
		var parentDoc = opener.document;
		var currentUrl = parentDoc.location.href;	
		// sns인기템 : www.10x10.co.kr/snsitem/
		if(currentUrl.indexOf("snsitem")){	
			setSnsitemWish('<%=itemid%>');
		}		
	}	
	myFavoriteClose('<%=wishActionCouponChkValue%>');
</script>
<%
	else
%>
<script type="text/javascript">
	<% If vOpenerChk = "o" Then %>
	opener.close();
	opener.opener.top.location.href = "<%=backurl%>?fidx=<%=fidx%>";
	<% Else %>
	opener.top.location.href = "<%=backurl%>?fidx=<%=fidx%>";
	<% End If %>
	// 창닫기
	//self.close();
	myFavoriteClose('<%=wishActionCouponChkValue%>');
</script>
<%end if%>


<% If wishActionCouponChkValue = "2" Then %>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_wish_folder.gif" alt="위시 폴더" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="folderItem wishAction">
					<p class="action"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_wish_action_discount_02.gif" alt="지금 텐바이텐 APP에서만 사용할 수 있는 5% 할인쿠폰을 지급해드렸습니다. 24시간 이내 사용" /></p>
					<div class="btnArea ct">
						<button type="buttom" class="btn btnB3 btnRed" onClick="javascript:window.close();">확인</button>
					</div>

					<div class="help">
						<ul>
							<li>텐바이텐 APP에서만 사용가능합니다</li>
							<li>발급 기준 24시간이내 사용하지않으면 자동소멸됩니다.</li>
						</ul>
					</div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
<% End If %>


<!-- #include virtual="/lib/db/dbclose.asp" -->
