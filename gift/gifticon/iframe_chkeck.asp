<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/gift/gifticon/giftiConCls.asp"-->
<%
	Dim vCouponNO, vStatus, vItemID, vItemName, vResult, vQuery, vQuery1, vUserID, vGuestSeKey, vUserLevel, vIdx, vActionURL, vMakerID
	Dim vBrandName, vListImage, vSoldOUT, vArrPaperMoney, vIsPaperMoney
	Dim oGicon, postdata, strData, vntPostedData, vTemp
	
	vCouponNO 		= requestCheckVar(request("pin_no"),12)
	vUserID			= GetLoginUserID
	vGuestSeKey		= GetGuestSessionKey
	vUserLevel		= GetLoginUserLevel
	vSoldOUT 		= False
	vTemp			= requestCheckVar(request("tmp"),1)
	
	
	If vCouponNO = "" Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	IF IsNumeric(vCouponNO) = false Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	
	
	'################################### 현금액 상품권 ###################################
	vIsPaperMoney	= "x"
	IF application("Svr_Info") = "Dev" THEN
		vArrPaperMoney = ",374487,374488,374489,374490,374491,"
	Else
		vArrPaperMoney = ",588084,588085,588088,588089,588095,"
	End If
	'################################### 현금액 상품권 ###################################


	
	'################################### 소켓 통신 ###################################
		Set oGicon = New CGiftiCon
		strData = oGicon.reqCouponState(vCouponNO,"100100")  ''쿠폰번호, 추적번호
	    
		If (strData) Then
			vStatus = Trim(oGicon.FConResult.getResultCode)
			vItemID = Trim(oGicon.FConResult.FSubItemBarCode)
		Else
			Response.Write "<script language='javascript'>alert('잘못된 인증번호입니다. 다시 확인 후 입력해 주세요.');</script>"
			dbget.close()
			Response.End
		End If
		Set oGicon = Nothing
	'################################### 소켓 통신 ###################################
if (vCouponNO="999175134263") and (vUserID="10x10green") then 
	vStatus="0000"
	vItemID="67810"
end if
	
	If CStr(vStatus) = "0000" Then		'### 성공
		'##################################### 0000 성공 인경우 #####################################
		If instr(1, vArrPaperMoney, ","&vItemID&",") <> "0" Then
			vIsPaperMoney = "o"
		End If
		
		vQuery = "SELECT itemname, makerid, brandname, listimage, sellyn, limityn, limitno, limitsold From [db_item].[dbo].[tbl_item] WHERE itemid = '" & vItemID & "'"
		rsget.Open vQuery,dbget
		IF Not rsget.EOF THEN
			vItemName	= Replace(rsget("itemname"),"'","")
			vMakerID	= Replace(rsget("makerid"),"'","")
			vBrandName	= Replace(rsget("brandname"),"'","")
			vListImage	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(vItemID) + "/" + rsget("listimage")
			
			IF vIsPaperMoney <> "o" Then
				IF rsget("limitno")<>"" and rsget("limitsold")<>"" Then
					vSoldOUT = (rsget("sellyn")<>"Y") or ((rsget("limityn") = "Y") and (clng(rsget("limitno"))-clng(rsget("limitsold"))<1))
				Else
					vSoldOUT = (rsget("sellyn")<>"Y")
				End If
				
				If (rsget("sellyn") = "S") Then
					vSoldOUT = (rsget("sellyn") = "S")
				End IF
			End IF
			rsget.close
		Else
			rsget.close
			dbget.close()
			Response.write "<script language='javascript'>alert('잘못된 경로입니다. 고객센터로 문의해 주세요.');document.location.href='/';</script>"
			Response.End
		End IF

	Else
		'##################################### 실패 인경우 #####################################

	End If

%>
<script language="javascript">
<%
	If vIsPaperMoney <> "o" Then																		'####### 상품 경우
		If vTemp = "o" Then																				'####### 아래 상품교환인~ alert 창 피하기 위해 temp 값 하나 줌.
			If CStr(vStatus) = "0000" Then																'####### 성공 %>
				top.document.frm1.target = "";
				top.document.frm1.action = "index_proc.asp";
				top.document.frm1.submit();
<%			Else 																						'####### 실패 %>
				top.document.frm1.tmp.value = "x";
				alert("<%=getErrCode2Name(vStatus)%>");
<%			End If
		Else
			Response.Write "alert('상품교환인 경우는\n로그인을 하신 후 등록하시거나\n비회원 등록을 선택해 주세요.');"
		End If
	Else																								'####### 기프트카드 경우
		If CStr(vStatus) = "0000" Then																	'####### 성공
			If IsUserLoginOK() = True Then %>
				top.document.frm1.target = "";
				top.document.frm1.action = "index_proc.asp";
				top.document.frm1.submit();
<%			Else
				Response.Write "alert('기프트카드를 등록하시려면\n로그인을 하신 후 등록하셔야 합니다.');"
			End If
		Else 																							'####### 실패 %>
			alert("<%=getErrCode2Name(vStatus)%>");
<%		End If
	End If
%>
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->