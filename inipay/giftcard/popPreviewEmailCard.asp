<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2011.10.08 허진원 생성
' 	Description : Gift카드 이메일 미리보기
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : gift카드 이메일 미리보기"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/MD5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCard_orderCls.asp" -->
<%
	dim cardid, cardOption, cardPrice, designid, buyname, emailTitle, emailContent, masterCardCode
	dim dsnType, dsnNum
	dim giftOrderSerial

	giftOrderSerial		= requestCheckVar(request("idx"),11)

	cardid		= requestCheckVar(request("cardid"),3)
	cardOption	= requestCheckVar(request("cardopt"),4)
	cardPrice	= requestCheckVar(request("cardPrice"),8)
	designid	= requestCheckVar(request("designid"),3)
	buyname		= requestCheckVar(request("buyname"),32)
	emailTitle	= request("emailTitle")
	emailContent= request("emailContent")

	'// 주문번호로 요청시 -> 주문내용 접수 : (/my10x10/giftcard/iframe_orderdetail.asp)
	if giftOrderSerial<>"" then
		dim myorder
		set myorder = new cGiftcardOrder
		myorder.FUserID = getEncLoginUserID()
		myorder.Fgiftorderserial = giftorderserial
		myorder.getGiftcardOrderDetail

		If myorder.FResultcount > 0 Then
			cardid		= myorder.FOneItem.FcardItemid
			cardOption	= myorder.FOneItem.FcardOption
			cardPrice	= myorder.FOneItem.Ftotalsum
			designid	= myorder.FOneItem.FdesignId
			buyname		= myorder.FOneItem.Fbuyname
			emailTitle	= myorder.FOneItem.FemailTitle
			emailContent= myorder.FOneItem.FemailContent
		end if

		set myorder = Nothing
	end if

	if designid = "" then designid="101"
	if masterCardCode="" then masterCardCode="****-****-****-****"
	if cardPrice="" then
		cardPrice = 0
	else
		cardPrice = cInt(cardPrice/10000)
	end if

	'디자인번호에서 타입과 번호 구함
	dsnType = left(designid,1)
	dsnNum = right(designid,2)
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
	<div class="heightgird giftcardView">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/shopping/pop_tit_card_sample.gif" alt="GIFT카드 메일 발송 예시" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<p><img src="http://webimage.10x10.co.kr/giftcard/eMail/10/E000101<%= designid %>.jpg" alt="당신에게 마음을 전합니다. 텐바이텐 Gift 카드" /></p>
				<!-- //content -->
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
