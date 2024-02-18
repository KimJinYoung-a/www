<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2013.09.06 - 허진원 생성
'			:  2019.01.14 - 최종원 기프트카드 이미지 db관리
'	Description : e기프트카드 주문내역 상세
'#######################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_ordercls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardImageCls.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 텐바이텐 Gift카드 보기"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim IsValidOrder : IsValidOrder = False   '''정상 주문인가.
	Dim myorder, userid, i, giftorderserial
	userid = getEncLoginUserID()
	giftorderserial = requestCheckvar(request("idx"),15)

	set myorder = new cGiftcardOrder
	myorder.FUserID = userid
	myorder.Fgiftorderserial = giftorderserial
	myorder.getGiftcardOrderDetail
	
	
	If myorder.FResultcount > 0 Then
		IsValidOrder = true
	Else
		Response.Write "<script language='javascript'>alert('잘못된 주문번호 입니다.');</script>"
		dbget.close()
		Response.End
	End If
	
	if Not (myorder.FOneItem.IsValidOrder) then
	    Response.Write "<script language='javascript'>alert('취소된 주문이거나 정상 주문건이 아닙니다.');</script>"
	end if

	'designid에 해당하는 이미지 가져오기

	dim GiftCardImageClsObj, imageUrl 	

	set GiftCardImageClsObj = new GiftCardImageCls
	imageUrl = GiftCardImageClsObj.getCardImageUrl(myorder.FOneItem.FdesignId)

	if imageUrl = "" then
		imageUrl = "http://fiximage.10x10.co.kr/web2015/giftcard/img_giftcard_type_05.png"
	end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<style type="text/css">
@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}
.twinkle {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:2.5s; animation-fill-mode:both;}
</style>
</head>
<body>
<div class="heightgird giftcardViewV15a">
	<div class="popWrap">
		<div class="popContent">
			<div class="cardViewV15a">
				<div class="hGroup">
					<h1><img src="http://fiximage.10x10.co.kr/web2015/giftcard/tit_tenbyten_giftcard.png" alt="텐바이텐 기프트카드" /></h1>
					<div class="price"><%=FormatNumber(myorder.FOneItem.FcardSellCash,0)%><img src="http://fiximage.10x10.co.kr/web2015/giftcard/txt_won.png" alt="원" /></div>
					<div class="deco twinkle"><img src="http://fiximage.10x10.co.kr/web2015/giftcard/img_deco_pink.png" alt="" /></div>
				</div>
					<%
						'이미지 노출 영역												
						Dim vCardImg
						'이미지 가져오는 방식 변경 2019-01-14
						'구매(보낸) 날짜가 소스 변경날짜보다 이르다면 이전에 사용하던 로직 사용
						if FormatDateTime(myorder.FOneItem.FsendDate, 2) < "2019-01-14" then
							If myorder.FOneItem.FUserImage <> "" Then
								Response.Write "<div class=""design designTypeA"">"
								vCardImg = staticImgUrl & myorder.FOneItem.FUserImage
							Else
								Response.Write "<div class=""design"">"
								If myorder.FOneItem.FdesignId < 600 Then
									vCardImg = "http://fiximage.10x10.co.kr/web2015/giftcard/img_giftcard_type_05.png"
								Else
									if Right(CStr(myorder.FOneItem.FdesignId),2) > 46 then
										vCardImg = "http://fiximage.10x10.co.kr/web2018/giftcard/img_giftcard_type_" & Right(CStr(myorder.FOneItem.FdesignId),2) & ".png"
									Else
										vCardImg = "http://fiximage.10x10.co.kr/web2015/giftcard/img_giftcard_type_" & Right(CStr(myorder.FOneItem.FdesignId),2) & ".png"
									end if								
								End IF
							End IF						
						Else
							If myorder.FOneItem.FUserImage <> "" Then
								Response.Write "<div class=""design designTypeA"">"
								vCardImg = staticImgUrl & myorder.FOneItem.FUserImage
							Else
								Response.Write "<div class=""design"">"
								vCardImg = imageUrl								
							End IF						
						end if
					%>
					<img src="<%=vCardImg%>" width="374" height="226" alt="" />
					<div class="frame"></div>
				</div>

				<div class="giftcardMsg">
				<%=nl2br(CHKIIF(myorder.FOneItem.FMMSContent="",myorder.FOneItem.FemailContent,myorder.FOneItem.FMMSContent))%>
				</div>
			</div>
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
<% Set myorder = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->