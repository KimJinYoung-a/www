<%
	Dim vOrderBody: vOrderBody=""

''브랜드 공지 2017-02-03 유태욱
'브랜드 공지(일반,배송) 2017-01-31 유태욱 작업중
	
dim oBrandNotice
set oBrandNotice = new CatePrdCls
oBrandNotice.Frectmakerid=makerid
oBrandNotice.GetBrandNoticeData

	Dim vBrandNotice
	'if not(oItem.Prd.FDeliverytype = "1" or oItem.Prd.FDeliverytype = "4") then	'텐배가 아닐경우만 출력
		if oBrandNotice.FResultCount > 0 then
			For i= 0 to oBrandNotice.FResultCount-1
				vBrandNotice=""
				vBrandNotice = vBrandNotice & "	<div class="&chkIIF(oBrandNotice.FItem(i).FBrandNoticeGubun = 2,"""notiV17 notiDelivery""","""notiV17 notiGeneral""")&">" & vbCrLf
				vBrandNotice = vBrandNotice & "		<span class='ico'></span>" & vbCrLf
				vBrandNotice = vBrandNotice & "			<div class='texarea'>" & vbCrLf
				vBrandNotice = vBrandNotice & "			<div class='inner'>	"
				vBrandNotice = vBrandNotice & "				<h3>"&oBrandNotice.FItem(i).FBrandNoticeTitle&"</h3>" & vbCrLf
				vBrandNotice = vBrandNotice & "				<p>" & vbCrLf
				vBrandNotice = vBrandNotice & 					nl2br(oBrandNotice.FItem(i).FBrandNoticeText) & vbCrLf
				vBrandNotice = vBrandNotice & "				</p>" & vbCrLf
				vBrandNotice = vBrandNotice & "			</div>" & vbCrLf
				vBrandNotice = vBrandNotice & "		</div>" & vbCrLf
				vBrandNotice = vBrandNotice & "	</div>" & vbCrLf
				Response.Write vBrandNotice
			next
		End If
	'end if

	Set oBrandNotice = Nothing

	IF Not(oItem.Prd.FOrderComment="" or isNull(oItem.Prd.FOrderComment)) or Not(oItem.Prd.getDeliverNoticsStr="" or isNull(oItem.Prd.getDeliverNoticsStr)) or (oItem.Prd.FrequireMakeDay>0) THEN
		vOrderBody = vOrderBody & "	<h3>주문 주의사항</h3>" & vbCrLf
		vOrderBody = vOrderBody & "	<div class=""tPad10 fs11"">" & vbCrLf
		If (Not IsTicketItem) Then '티켓아닌경우 - 일반상품
			if Not(oItem.Prd.getDeliverNoticsStr="" or isNull(oItem.Prd.getDeliverNoticsStr)) then
				vOrderBody = vOrderBody & oItem.Prd.getDeliverNoticsStr & "<br /><br />" & vbCrLf
			end if
			if Not(oItem.Prd.FOrderComment="" or isNull(oItem.Prd.FOrderComment)) then
				vOrderBody = vOrderBody & nl2br(oItem.Prd.FOrderComment) & "<br /><br />" & vbCrLf
			end if
			if oItem.Prd.FrequireMakeDay>0 then
				vOrderBody = vOrderBody & "상품발송 전 <strong>상품제작 예상 기간은 " & oItem.Prd.FrequireMakeDay & "일</strong> 입니다." & vbCrLf
			end if
		Else
			vOrderBody = vOrderBody & oItem.Prd.getDeliverNoticsStr & "<br/><br/>"& vbCrLf
			vOrderBody = vOrderBody & nl2br(oItem.Prd.FOrderComment) & vbCrLf
		End If
		vOrderBody = vOrderBody & "	</div>" & vbCrLf
		Response.Write vOrderBody
	End If
%>