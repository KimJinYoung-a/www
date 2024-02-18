<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 텐큐베리감사 : 천백만원
' History : 2018-03-30 정태훈
'####################################################
Dim eCode, userid

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67498
Else
	eCode   =  85148
End If

userid = GetEncLoginUserID()

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[텐바이텐] 텐큐-천백만원!"
strPageKeyword = "[텐바이텐] 텐큐-천백만원!"
strPageDesc = "[텐바이텐] 이벤트 - 4월 정기세일 당첨자 총 1,001명에게 드려요 천백만원! 6만원 이상 쇼핑하고 행운의 기프트카드 주인공이 되어보세요!"
strPageUrl = "http://www.10x10.co.kr/event/tenq/giftcard.asp"


%>
<style type="text/css">
.ten-card {margin-top:-45px !important}
.ten-card .card-head {position:relative; height:1087px; background:#18cca0 url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85148/bg_card.jpg) no-repeat 50% 100%;}
.ten-card .card-head h2{padding:130px 0 500px;}
.ten-card .card-head span {position:absolute; top:350px; left:50%; animation:bounce .6s 500;}
.ten-card .card-head .winner1 {margin-left:-453px;}
.ten-card .card-head .winner2 {margin-left:246px; animation-delay:.3s;}
.ten-card .process {padding-bottom:93px; background-color:#fffb99;}
.ten-card .process p {padding:95px 0 60px;}
.ten-card .noti {padding:60px 0; background:#f89797;}
.ten-card .noti .inner{position:relative; width:1020px; margin:0 auto;}
.ten-card .noti h3 {position:absolute; left:70px; top:50%; margin-top:-14px;}
.ten-card .noti ul {padding-left:270px; text-align:left;}
.ten-card .noti li {color:#fff; padding:18px 0 0 11px; line-height:16px; text-indent:-11px;}
.ten-card .noti li:first-child {padding-top:0;}

@keyframes bounce {
	0%, 100% {transform:translateY(0);}
	50% {transform:translateY(-10px);}
}
</style>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15 tMar15">
					<div class="contF contW">
						<!-- 텐큐베리감사 : 천백만원! -->
						<div class="mEvt85145 tenq ten-card">
						<!-- #include virtual="/event/tenq/nav.asp" -->
							<div class="card-head">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85148/tit_giftcard.png" alt="당첨자 총 1,001명에게 드려요 천백만원!" /></h2>
								<span class="winner1"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85148/txt_winner_1.png" alt="당첨자 1명 100만원" /></span>
								<span class="winner2"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85148/txt_winner_2.png" alt="당첨자 1000명 1만원" /></span>
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85148/txt_all_1100.png" alt="" /></p>
							</div>
							<div class="process">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85148/txt_how_to.png" alt="참여방법:텐바이텐 배송상품 포함 6만원 이상 구매하고 텐바이텐 배송박스를 뜯어 카드 확인" /></p>
								<a href="/event/eventmain.asp?eventid=85321"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85148/btn_go_ten_ten.png" alt="" /></a>
							</div>
							<!-- 유의사항 -->
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85148/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>- 본 이벤트는 텐바이텐 회원님을 위한 혜택입니다.(비회원 구매 시, 증정 불가)</li>
										<li>- 기프트카드는 이벤트 기간 동안 구매한 텐텐배송 상품 중 무작위로 선출하여 발송 됩니다.</li>
										<li>- 텐바이텐 배송상품을 포함해서 구매 확정액이 6만원 이상이어야 이벤트 참여가 가능합니다.</li>
										<li>- 구매 확정액은 상품 쿠폰, 보너스 쿠폰 적용 후 결제한 금액이 6만원 이상이어야 합니다.(단일 주문건 구매 확정액)</li>
										<li>- 텐바이텐 Gift카드를 구매하신 경우에는 이벤트참여 조건이 되지 않습니다.</li>
										<li>- 구매자에게는 상품에 따라 세무신고에 필요한 개인정보를 요청할 수 있습니다. 제세공과금은 텐바이텐 부담입니다. </li>
										<li>- 환불이나 교환 시, 최종 구매가격이 6만원 미만일 경우 기프트카드와 함께 반품해야 합니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<!--// 텐큐베리감사 : 천백만원! -->
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