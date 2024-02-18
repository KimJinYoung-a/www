<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/shopping/offshopcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'매장 정보 가져오기
Dim offshoplist, ix
Set offshoplist = New COffShop
offshoplist.GetOffShopList
	'//for Developers
	'// commlib.asp, tenEncUtil.asp는 head.asp에 포함되어있으므로 페이지내에 넣지 않도록 합시다.

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 기프트카드안내"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_infomation_v1.jpg"
	strPageDesc = "무슨 선물을 할까 늘 고민인 당신, 기프트 카드로 마음을 전해보세요!"
	strPageKeyword = "giftcard, 기프트카드"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 기프트카드안내"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/giftcard/"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf

	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
		if Not(Request("mfg")="pc" or session("mfg")="pc") then
			if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
				Response.Redirect "https://m.10x10.co.kr/giftcard/"
				REsponse.End
			end if
		end if
	end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
</head>
<body>
<div id="giftcardWrapV15a" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->

	<div class="container giftcardIdxV18">
		<div id="contentWrap">
			<div class="hGroup">
				<h2>텐바이텐 <strong>기프트카드</strong></h2>
				<p>무슨 선물을 할까 늘 고민인 당신, 간편한 기프트 카드로 마음을 전해보세요.</p>
				<div class="btnGroupV18">
					<!-- for dev msg : GIFT 카드 선물&결제 페이지로 이동 -->
					<a href="<%=SSLUrl%>/giftcard/present.asp" class="btn-present">선물하기</a>
					<a href="<%=wwwUrl%>/my10x10/giftcard/giftcardRegist.asp" class="btn-register">인증번호 등록</a>
				</div>
			</div>
			<div class="visual">
				<span class="card1"><img src="http://fiximage.10x10.co.kr/web2018/giftcard/img_card_1.png" alt="" /></span>
				<span class="card2"><img src="http://fiximage.10x10.co.kr/web2018/giftcard/img_card_2.png" alt="" /></span>
				<span class="card3"><img src="http://fiximage.10x10.co.kr/web2018/giftcard/img_card_3.png" alt="" /></span>
			</div>

			<div class="sectionContent">
				<div class="column giftcardDefineV18">
					<dl>
						<dt>텐바이텐 <strong class="color-red">기프트카드란?</strong></dt>
						<dd>받으시는 분의 휴대폰으로 기프트카드 메세지가 전송되며, 사용 등록 후 현금처럼 사용 하실 수 있는 금액권 기프트카드 입니다.</dd>
					</dl>
					<div class="table">
						<table>
							<caption>텐바이텐 기프트카드 안내</caption>
							<tbody>
							<tr>
								<th scope="row">발행자<span></span></th>
								<td>텐바이텐</td>
							</tr>
							<tr>
								<th scope="row">유효기간<span></span></th>
								<td>구매일로부터 5년</td>
							</tr>
							<tr>
								<th scope="row">전송방법<span></span></th>
								<td>모바일 메시지 전송</td>
							</tr>
							<tr>
								<th scope="row">이용매장<span></span></th>
								<td>
									텐바이텐 온라인 및 오프라인 매장 (하단 기프트카드 사용처 참고)
								</td>
							</tr>
							<tr>
								<th scope="row">잔액환급조건<span></span></th>
								<td>기프트카드 금액이 1만원 초과일 경우 100분의 60 이상, 1만원 이하일 경우 100분의 80 이상 사용한 경우, 잔액 환급 가능</td>
							</tr>
							</tbody>
						</table>
					</div>

					<ul class="listTypeHypen">
						<li>- 기프트카드는 다른 일반 상품과 함께 구매가 되지 않는 단독 구매 상품으로, 한 주문에 하나의 카드만 구매 가능합니다.</li>
						<li>- 기프트카드 구매는 무기명 선불카드를 구매하는 것이므로 모든 결제수단이 비과세로 구분됩니다. 현금영수증, 세금계산서 증빙서류는 발급이 불가하며, 선물 받은 사람이 카드를 사용할 때 현금영수증 발행이 가능 합니다.</li>
						<li>- 기프트카드 선불카드이므로 결제 시 쿠폰, 마일리지, 예치금 등의 사용이 제한되어 있습니다.</li>
						<li>- 인(人)당 월 구매한도는 100만원입니다.</li>
					</ul>
				</div>

				<div class="column giftcardUsedV18">
					<h3>기프트카드 사용처</h3>
					<ul class="offshop">
						<li><a href="http://www.10x10.co.kr/" target="_blank"><strong class="color-red">텐바이텐 온라인</strong>Online, www.10X10.co.kr</a></li>
						<% If offshoplist.FResultCount >0 Then %>
						<% For ix=0 To offshoplist.FResultCount-1 %>
						<li><a href="/offshop/index.asp?shopid=<%=offshoplist.FItemList(ix).FShopID%>" target="_blank"><strong><%=offshoplist.FItemList(ix).FShopName%></strong><%=offshoplist.FItemList(ix).FEngName%></a></li>
						<% Next %>
						<% End If %>
					</ul>
				</div>

				<div class="column giftcardMethodV18">
					<h3>기프트카드 사용방법</h3>
					<div class="row">
						<div class="use">
							<h4>온라인<br />사용</h4>
							<ol class="step">
								<li>기프트카드<br /> 메시지 수신</li>
								<li>로그인 후<br /> 카드 등록</li>
								<li>상품결제시<br /> 사용</li>
							</ol>
							<ul class="listTypeHypen">
								<li>- 기프트카드 등록 후 상품 구매시 결제 페이지에서 기프트카드 금액을 현금처럼 사용할 수 있으며, 다른 결제 수단과 중복으로 사용 가능합니다.</li>
								<li>- 횟수에 관계없이 금액을 여러 번 나누어서 사용할 수 있으며 여러 개의 기프트 카드를 등록하신 경우, 등록 순서에 따라 순차적으로 사용됩니다.</li>
							</ul>
						</div>

						<div class="use right">
							<h4>오프라인<br />사용</h4>
							<ol class="step">
								<li>기프트카드<br /> 메시지 수신</li>
								<li>로그인 후<br /> 카드 등록</li>
								<li>오프라인 결제시<br /> 인증번호 제시</li>
							</ol>
							<ul class="listTypeHypen">
								<li>- 전송 받은 기프트카드 메시지를 통해 온라인 로그인 후 카드를 등록합니다.</li>
								<li>- 온라인 등록 후 오프라인 매장에서 결제 시, 인증번호를 제시하시면 간단한 본인확인 절차를 거친 후 사용 가능합니다.</li>
								<li>- 횟수에 관계없이 금액을 여러 번 나누어서 사용할 수 있으며 다른 결제수단과 중복으로 사용 가능합니다.</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="column giftcardNotiV18">
					<h3>유의사항 및 환불규정</h3>
					<div class="row">
						<div class="check">
							<h4>유의사항</h4>
							<ul class="listTypeHypen">
								<li>- 기프트카드의 사진 등록은 크롬, IE9 이상의 브라우저에서 지원 가능합니다.</li>
								<li>- 수신 정보를 잘못 입력했거나 메시지를 받지 못 했을 경우 카드 등록 전, 마이텐바이텐 &gt; 기프트카드 &gt; 카드 주문내역에서 2회까지 재전송 가능합니다.</li>
								<li>- 메시지 재전송시 기존 전송된 기프트카드의 인증번호는 무효 처리됩니다.</li>
								<li>- 온라인 쇼핑몰 사용 후 남은 금액을 오프라인 매장에서 사용 가능하며, 오프라인 매장에서 사용 후 남은 금액을 온라인 쇼핑몰에서도 사용 가능합니다.</li>
							</ul>
						</div>
						<div class="check right">
							<h4>환불규정</h4>
							<ul class="listTypeHypen">
								<li>- 사용 유효기간이 지난 경우 환불 처리가 불가 합니다.<br /> (유효기간 : 구매일로부터 5년)</li>
								<li>- 환불은 구매일로부터 7일 이내에 가능하며, 받는 사람이 카드 사용 등록이 완료 되었거나 오프라인매장에서 일부 금액을 사용한 경우 환불이 되지 않습니다.</li>
								<li>- 받는 분의 정보를 잘못 입력하여 타 사용자가 카드 사용 등록을 하였거나 오프라인 매장에서 사용한 경우 환불이 불가하며 텐바이텐은 책임을 지지 않습니다.</li>
							</ul>
						</div>
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