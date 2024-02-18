<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
response.redirect SSLUrl & "https://www.10x10.co.kr/giftcard/"
dbget.close
response.end

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : GIFT 카드 안내"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script>

window.onload = function() {
	self.focus();
}

</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incCsHeader.asp" -->
			<div class="csContent">
				<!-- #include virtual="/lib/inc/incCsLnb.asp" -->

				<!-- content -->
				<div class="content">
					<div class="giftcard">
						<div class="subHeader">
							<h3><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_gift_card.gif" alt="텐바이텐 Gift 카드" /></h3>
							<p>무슨 선물을 할까 늘 고민인 당신,<br /> 간편하고 실속있는 텐바이텐 Gift 카드로 마음을 전해보세요</p>
							<p class="cr999">* 이메일 전송시 카드 디자인 선택 가능</p>
							<div class="ico"><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_gift_card.jpg" alt="" /></div>
						</div>

						<div class="section">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_gift_card_define.gif" alt="텐바이텐 Gift 카드란?" /></h4>
							<p class="bPad15">받으시는 분의 휴대폰으로 인증번호가 전송되며, 사용 등록 후 현금처럼 사용 하실 수 있는 금액권 Gift 카드 입니다.</p>
							<div class="box">
								<table>
								<caption>텐바이텐 GIFT 카드 안내</caption>
								<colgroup>
									<col width="60" /> <col width="*" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">전송방법</th>
									<td>모바일로 인증번호 전송 (이메일 전송 선택 가능)</td>
								</tr>
								<tr>
									<th scope="row">구매처</th>
									<td>텐바이텐 온라인 쇼핑몰</td>
								</tr>
								<tr>
									<th scope="row">사용처</th>
									<td>텐바이텐 온라인 쇼핑몰, 텐바이텐 LIFE STYLE SHOP (대학로점, 김포롯데점, 일산점, 제주점) <a href="/offshop/shopinfo.asp?shopid=streetshop011" class="linkBtn highlight" title="오프라인 매장 정보"><strong>오프라인 매장 정보</strong></a></td>
								</tr>
								<tr>
									<th scope="row">판매금액</th>
									<td>1만원 / 2만원 / 3만원 / 5만원 / 8만원 / 10만원 / 15만원 / 20만원 / 30만원</td>
								</tr>
								</tbody>
								</table>
							</div>
							<div class="btnArea">
								<a href="/my10x10/giftcard/giftcardRegist.asp" class="btn btnS1 btnGry btnW130" title="온라인 사용 등록"><span class="whiteArr01">온라인 사용 등록</span></a>
								<a href="/shopping/giftcard/giftcard.asp?cardid=101" class="btn btnS1 btnRed btnW130" title="구매하러 가기"><span class="whiteArr01">구매하러 가기</span></a>
							</div>
						</div>

						<div class="section">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_gift_card_buy.gif" alt="Gift 카드 구매 방법" /></h4>
							<ol class="process">
								<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_buy_01.gif" alt="카드 금액 선택 후 주문하기" /></li>
								<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_buy_02.gif" alt="전송 정보 입력 : 보내는 사람, 받는 사람 정보 및 메시지 작성. 선택사항 이메일 전송 여부 선택. 전송 정보 입력, 이미지 선택 및 메시지 작성" /></li>
								<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_buy_03.gif" alt="결제 정보 입력" /></li>
								<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_buy_04.gif" alt="구매완료 : 결제 완료시, 입력한 정보로 인증번호 자동발송" /></li>
							</ol>
							<ul class="box">
								<li>- Gift 카드는 다른 일반 상품과 함께 구매가 안되는 단독 구매 상품으로, 한 주문에 하나의 Gift 카드만 구매 가능합니다.</li>
								<li>- Gift 카드 구매는 무기명 선불카드를 구매하는 것이므로 모든 결제수단이 비과세로 구분됩니다.<br /> 현금영수증, 세금계산서 증빙서류는 발급이 불가하며,  선물 받은 사람이 카드를 사용할 때 현금영수증 발행이 가능 합니다.</li>
								<li>- Gift 카드는 신용카드, 무통장입금, 실시간 계좌이체와 같은 기존의 결제 수단으로 구매가 가능하나 쿠폰, 마일리지, 예치금 등의 사용은 제한되어 있습니다.</li>
								<li>- Gift 카드의 <em>유효기간은 구매일로부터 5년</em>입니다.</li>
								<li>- 인(人)당 월 구매한도는 100만원입니다.</li>
							</ul>
						</div>

						<div class="section">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_gift_card_use.gif" alt="Gift 카드 사용방법" /></h4>
							<div class="process">
								<h5><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_gift_card_online.gif" alt="온라인 사용방법" /></h5>
								<ol>
									<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_use_online_01.gif" alt="인증번호 수신" /></li>
									<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_use_online_02.gif" alt="인증번호 등록 : 마이텐바이텐&gt;GIFT 카드&gt; 카드 등록 및 내역에서 인증번호 등록" /></li>
									<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_use_online_03.gif" alt="원하는 상품 주문하기" /></li>
									<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_use_online_04.gif" alt="상품 결제 하기 : 결제시, 할인 정보&gt;GIFT 카드에서 사용 가능" /></li>
								</ol>
							</div>
							<ul class="box">
								<li>- 전송 받으신 인증번호를 텐바이텐 온라인 로그인 후 <a href="/my10x10/giftcard/giftcardRegist.asp" title="온라인 사용 등록 및 내역"><strong>마이텐바이텐&gt;Gift 카드&gt;온라인 사용 등록 및 내역</strong></a> 에서 인증번호를 등록합니다.</li>
								<li>- 인증번호 등록 후 상품 구매시 결제 페이지에서 Gift 카드 금액을 현금처럼 사용할 수 있으며, 다른 결제 수단과 중복으로 사용 가능합니다.</li>
								<li>- 횟수에 관계없이 금액을 여러번 나누어서 사용할 수 있으며, 여러 개의 Gift 카드를 등록하신 경우, 등록 순서에 따라 순차적으로 사용됩니다.</li>
							</ul>

							<div class="process tPad30">
								<h5><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_gift_card_offline.gif" alt="오프라인 사용방법" /></h5>
								<ol>
									<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_use_offline_01.gif" alt="인증번호 수신" /></li>
									<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_use_offline_02.gif" alt="인증번호 등록 : 마이텐바이텐 &gt; GIFT 카드 &gt; 카드 등록 및 내역에서 인증번호 등록" /></li>
									<li><img src="http://fiximage.10x10.co.kr/web2013/cscenter/img_process_use_offline_03.gif" alt="간단한 본인 확인 후 상품 결제" /></li>
								</ol>
							</div>

							<ul class="box">
								<li>- 전송 받은 인증번호를 텐바이텐 온라인 로그인 후 <a href="/my10x10/giftcard/giftcardRegist.asp" title="온라인 사용 등록 및 내역"><strong>마이텐바이텐&gt;Gift 카드&gt;온라인 사용 등록 및 내역</strong></a>에서 인증번호를 등록합니다.</li>
								<li>- 온라인에서 인증번호를 등록 후 오프라인 매장에서 결제 시, 인증번호를 제시 하시면 간단한 본인확인 절차를 거친 후 사용 가능합니다.</li>
								<li>- 횟수에 관계없이 금액을 여러 번 나누어서 사용할 수 있으며 다른 결제수단과 중복으로 사용 가능합니다.</li>
							</ul>
						</div>

						<div class="section">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_caution.gif" alt="유의사항" /></h4>
							<ul class="box">
								<li>- 받는 분의 정보를 잘못 입력한 경우 또는 받는 분이 인증번호를 잊어버렸을 경우, 카드 사용 등록 전이면 <a href="/my10x10/giftcard/giftcardOrderlist.asp" title="카드 주문내역"><strong>마이텐바이텐&gt;Gift 카드&gt;카드 주문내역</strong></a>에서 2회까지 재전송이 가능합니다.</li>
								<li>- 새로운 인증번호 받기로 재전송을 하신 경우 이전에 전송된 인증번호는 무효처리 됩니다.</li>
								<li>- 온라인 쇼핑몰 사용 후 남은 금액을 오프라인 매장에서 사용 가능하며, 오프라인 매장에서 사용 후 남은 금액을 온라인 쇼핑몰에서도 사용 가능합니다.</li>
							</ul>
						</div>

						<div class="section">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_refund_rule.gif" alt="환불 규정" /></h4>
							<ul class="box">
								<li>- <span class="crRed">사용 유효기간이 지난 경우 환불 처리가 불가 합니다. (유효기간 : 구매일로부터 5년)</span></li>
								<li>- <em>환불은 구매일로부터 7일 이내</em>에 가능하며, 받는 사람이 카드 사용 등록이 완료되었거나 오프라인매장에서 일부 금액을 사용한 경우 환불이 되지 않습니다.</li>
								<li>- 받는 분의 정보를 잘못 입력하여 타 사용자가 카드 사용 등록을 하였거나 오프라인 매장에서 사용한 경우 환불이 불가하며 텐바이텐은 책임을 지지 않습니다.</li>
								<li>- Gift 카드 금액이 1만원 초과일 경우 100분의 60 이상, 1만원 이하일 경우 100분의 80 이상 사용을 하면 남은 금액은 온라인 예치금으로 전환이 가능합니다.</li>
							</ul>
						</div>
					</div>
				</div>
				<!-- //content -->

				<!-- #include virtual="/lib/inc/incCsQuickmenu.asp" -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
