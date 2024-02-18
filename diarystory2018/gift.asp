<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2017 GIFT 페이지
' History : 2016.09.30 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2018/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2018/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/diarystory2018/gift.asp"
			REsponse.End
		end if
	end if
end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2018.css" />
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2018">
		<div id="contentWrap" class="diary-gift">
			<!-- #include virtual="/diarystory2018/inc/head.asp" -->
			<div class="diary-content">
				<h3 class="title"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tit_gift_2.png" alt="구매금액별 사은품 AND 무료배송" /></h3>
				<ul class="gift-item">
					<li><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_gift_1_sold.png" alt="1만원 이상 구매 시 마스킹테이프 랜덤 증정" /></li>
					<li><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_gift_2.png" alt="3만원 이상 구매 시 홀로그램 파일 증정" /></li>
					<li><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_gift_3.png" alt="5만원 이상 구매 시 메모판+자석 증정" /></li>
				</ul>
				<p class="brand-story"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_brand.png" alt="나의 생각과 일상을 기록하는 그곳, 텐바이텐 다이어리 스토리’  오직 텐바이텐에서 만나볼 수 있는 문라잇펀치로맨스와 새로운 콜라보 상품을 제작 했습니다." /></p>
				<p class="story1"></p>
				<p class="story2"></p>
				<div class="moonlight"></div>
				<div class="terms">
					<div class="bPad40"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_gift_tip.jpg" alt="사은품 유의사항" /></div>
					<a href="/event/eventmain.asp?eventid=80481"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/btn_ten_delivery.png" alt="텐바이텐 배송상품 보러가기" /></a>
				</div>
				<div class="noti">
					<div class="inner">
						<h3><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tit_noti.png" alt="사은품 유의사항" /></h3>
						<ul>
							<li>사은품 증정기간은 2017.10.16 ~ 2017.12.31입니다 . (한정수량으로 조기품절 될 수 있습니다.)</li>
							<li>2018 DIARY STORY 다이어리 포함 텐바이텐 배송상품 1/3/5만원 이상 구매시 증정됩니다. (쿠폰, 할인카드 등 사용 후 구매확정금액 기준)</li>
							<li>환불 및 교환으로 기준 금액 미만이 될 경우 사은품은 반품해 주셔야 합니다.</li>
							<li>모든 사은품의 옵션은 랜덤 증정 됩니다.</li>
							<li>다이어리 구매 개수에 관계없이 총 구매금액이 조건 충족 시 사은품이 증정됩니다.</li>
							<li>사은품 불량으로 인한 교환은 불가능 합니다.</li>
							<li>비회원 구매 시 사은품 증정에서 제외됩니다.</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->