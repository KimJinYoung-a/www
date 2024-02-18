<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 회원혜택 안내"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_member_v1.jpg"
	strPageDesc = "이번달 회원등급은?"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 회원 등급 조회"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/special_info.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myTenbytenInfoCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
'// 2018 회원등급 개편

'####### 회원등급 재조정 #######
Call getDBUserLevel2Cookie()
'####### 회원등급 재조정 #######

dim userid,myuserLevel, NextuserLevel
dim yyyymm, userlevel, BuyCount, BuySum
dim userlevel2, BuyCount2, BuySum2

userid = GetLoginUserID
myuserLevel = GetLoginUserLevel

'// 이번달 기준
dim oMyInfo2
set oMyInfo2 = new CMyTenByTenInfo
oMyInfo2.FRectUserID = userid
oMyInfo2.GetLastMonthUserLevelData
    yyyymm			= oMyInfo2.FOneItem.Fyyyymm
    userlevel2		= oMyInfo2.FOneItem.Fuserlevel
    BuyCount2		= oMyInfo2.FOneItem.FBuyCount
    BuySum2			= oMyInfo2.FOneItem.FBuySum
set oMyInfo2 = Nothing

'// 다음달 기준
dim oMyInfo
set oMyInfo = new CMyTenByTenInfo
oMyInfo.FRectUserID = userid
oMyInfo.getNextUserBaseInfoData
    userlevel		= oMyInfo.FOneItem.Fuserlevel
    BuyCount		= oMyInfo.FOneItem.FBuyCount
    BuySum			= oMyInfo.FOneItem.FBuySum
set oMyInfo = Nothing

'네비바 내용 작성
'strMidNav = "MY 쇼핑혜택 > <b>회원혜택 보기</b>"

	NextuserLevel = getUserLevelByQual(BuyCount,BuySum)			'조건으로 회원등급 확인

	if cStr(userlevel)="0" and cStr(NextuserLevel)="0" then NextuserLevel="0"	'WHITE
	if cStr(userlevel)="7" then NextuserLevel="7"		'STAFF
	if cStr(userlevel)="9" then NextuserLevel="9"		'BIZ
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>
<script type="text/javascript">
$(function(){
	// layer popup
	$.fn.layerOpen = function(options) {
		return this.each(function() {
			var $this = $(this);
			var $layer = $($this.attr("href") || null);
			$this.click(function() {
				$layer.attr("tabindex",0).show().focus();
				$layer.find(".close").one("click",function () {
					$layer.hide();
					$this.focus();
				});
			});
		});
	}
	$(".addInfo a").layerOpen();

	$(".memberTableV16 .contLyr").find(".close").one("click",function () {
		$(".contLyr").hide();
	});

	$('.my-grade .chart').easyPieChart({
		animate:3000,
		barColor: '#999', // 등급별 컬러: white #999 / red #ff5b73 / vip #5a88ff / vipgold #ffb400 / vvip #bd2edd / staff #000
		trackColor: '#ddd',
		scaleColor:false,
		lineCap:'squre',
		size:160,
		lineWidth:12,
		trackWidth:12
	});
});
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent membershipV18">
					<div class="titleSection">
						<h3>회원혜택 안내</h3>
						<p class="tMar15">최근 5개월간의 이용내역을 반영하여 단계가 결정되면 매월 1일 새로운 회원등급이 부여됩니다.<br />향후 우수고객 단계별 혜택 및 선정기준은 변경될 수 있습니다.</p>
					</div>

					<div class="mySection">
						<% If GetLoginUserID() <> "" Then %>
							<div class="my-grade <%=GetUserLevelCSSClass%>">
								<%' 등급별로 퍼센트 20 40 60 80 100 %>
								<%
									Dim levelPiePercent, compare1, compare2
									Dim NextuserLevel2
									NextuserLevel2 = getNextMayLevel(NextuserLevel)

									'// 등급업까지 남은 횟수 및 금액 비교
									compare1 = getRequireLevelUpBuyCountPercent(NextuserLevel2,BuyCount2) '// 횟수
									compare2 = getRequireLevelUpBuySumPercent(NextuserLevel2,BuySum2) '// 원

									If GetLoginUserLevel = 7 Then
										levelPiePercent = 100
									Else
										levelPiePercent = chkiif(compare1>=compare2,compare1,compare2)
									End If 
								%>
								<div class="chart" data-percent="<%=levelPiePercent%>"><div><em class="<%=GetUserLevelCSSClass%>"><%=GetUserLevelStr(GetLoginUserLevel())%></em></div></div>
								<p class="now"><%=GetLoginUserName%>님의 <%= month(date)%>월 회원등급은 <em class="<%=GetUserLevelCSSClass%>"><%=GetUserLevelStr(GetLoginUserLevel())%></em> 입니다.</p>
								<%

								%>
								<p class="expect">현재 <%= month(dateadd("m",1,date)) %>월 예상등급은 <em class="<%=GetUserNextLevelCSSClass(NextuserLevel)%>"><%=GetUserLevelStr(NextuserLevel)%></em>입니다.</p>
								<div class="history">
									<dl>
										<dt>나의 지난 5개월간 구매내역</dt>
										<dd>
											<ul>
												<li>기간 : <%= replace(dateAdd("m",-5,dateserial(Left(yyyymm,4),Right(yyyymm,2),1)),"-",".") %> ~ <%= replace(dateAdd("d",-1,dateserial(Left(yyyymm,4),Right(yyyymm,2),1)),"-",".") %></li>
												<li>구매횟수 : <%= FormatNumber(BuyCount2,0) %>회 (1만원 이상)</li>
												<li>구매금액 : <%= FormatNumber(BuySum2,0) %>원</li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>다음달에 <em class="<%=GetUserNextLevelCSSClass(NextuserLevel2)%>"><%= GetUserLevelStr(NextuserLevel2)%></em>회원이 되시려면?</dt>
										<dd>
											<ul>
												<% if NextuserLevel2<>"4" then %><li>필요한 주문횟수 : <%= getRequireLevelUpBuyCount(NextuserLevel2,BuyCount) %>회</li><% End If %>
												<li>필요한 결제금액 : <%= FormatNumber(getRequireLevelUpBuySum(NextuserLevel2,BuySum),0) %>원</li>
											</ul>
										</dd>
									</dl>
								</div>
								<ul class="dash-list">
									<li>- <%=chkIIF(NextuserLevel2<>"4","주문횟수 또는 결제금액 중 한 가지만","결제금액을")%> 만족하시면 다음 등급이 적용됩니다. (결제완료일자기준)</li>
									<li>- 기간 내 주문 후 기간 이후 입금 시 등급변경 될 수 있음</li>
									<li>- 취소/반품 시 예상등급과 다를 수 있음</li>
								</ul>
							</div>
						<% end if %>

						<div class="grade-standard tMar40">
							<h4>회원등급 기준</h4>
							<table>
							<colgroup>
								<col style="width:20%;" /> <col style="width:20%" /> <col style="width:20%;" /> <col style="width:20%" /> <col style="width:*;" />
							</colgroup>
							<thead>
							<tr>
								<th><strong class="g-vvip">VVIP</strong></th>
								<th><strong class="g-vipgold">VIP GOLD</strong></th>
								<th><strong class="g-vip">VIP</strong></th>
								<th><strong class="g-red">RED</strong></th>
								<th><strong class="g-white">WHITE</strong></th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td><div>결제 금액<br />300만원 이상</div></td>
								<td><div>주문 5회 이상<br />또는<br />결제 금액 50만원 이상</div></td>
								<td><div>주문 3회 이상<br />또는<br />결제 금액 20만원 이상</div></td>
								<td><div>주문 1회 이상<br />또는<br />결제 금액 10만원 이상</div></td>
								<td><div>신규가입 회원,<br />구매 경험이 없는 고객</div></td>
							</tr>
							</tbody>
							</table>
							<ul class="dash-list">
								<li>- VVIP 등급은, 주문횟수 관계 없이 구매금액 조건 충족 시 해당 등급이 적용됩니다.</li>
								<li>- 결제금액 또는 주문횟수 두 가지 중 한 가지 조건만 만족하면 해당 단계가 적용됩니다. (결제완료기준)</li>
								<li class="color-red">- 1만원 미만의 구매내역은 주문횟수로 계산되는 선정기준에서는 제외됩니다.<br />(쿠폰, 할인카드 등의 사용 후, 실제 결제금액이 1만원 기준으로 적용 : 결제금액 산정기준=실제 결제금액+마일리지 사용액+예치금+기프트카드)</li>
							</ul>
						</div>

						<div class="grade-benefit tMar40">
							<h4>회원등급별 혜택</h4>
							<table>
							<colgroup>
								<col style="width:*;" /> <col style="width:150px;" /> <col style="width:150px;" /> <col style="width:150px;" /> <col style="width:150px;" /> <col style="width:150px;" /> 
							</colgroup>
							<thead>
							<tr>
								<th></th>
								<th><strong class="g-vvip">VVIP</strong></th>
								<th><strong class="g-vipgold">VIP GOLD</strong></th>
								<th><strong class="g-vip">VIP</strong></th>
								<th><strong class="g-red">RED</strong></th>
								<th><strong class="g-white">WHITE</strong></th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<th>
									쿠폰
									<div class="addInfo">
										<a href="#bonusCoupon"><i class="more">?</i></a>
										<div id="bonusCoupon" class="contLyr">
											<div class="contLyrInner">
												<p class="title">보너스쿠폰 안내</p>
												<ul>
													<li>- 쿠폰 중 % 할인쿠폰은 이미 할인을 하는 상품, 일부 상품에 대해서 중복 적용이 되지 않습니다. (할인 적용이 안 되는 상품은, 장바구니에서 [%보너스쿠폰제외상품] 으로 표시 됩니다.)</li>
													<li>- 쿠폰은 유효기간이 정해져 있습니다.</li>
													<li>- 무료배송쿠폰은 텐바이텐 배송상품에 한해서 적용 됩니다. (업체조건배송상품 및 업체착불배송 상품 주문 시 해당 업체의 배송정책에 따라 배송비가 부과됩니다.)</li>
												</ul>
											</div>
										</div>
									</div>
								</th>
								<td class="vTop">
									<ul class="coupon-list">
										<li class="double">
											<div class="coupon">
												<div><em>10%</em>COUPON</div>
												<span class="num">x2</span>
											</div>
											<p>3만원 이상 구매 시<b>할인금액 제한 없음</b></p>
										</li>
										<li class="double">
											<div class="coupon">
												<div><em>5%</em>COUPON</div>
												<span class="num">x2</span>
											</div>
											<p>3만원 이상 구매 시<b>최대 2만원 할인</b></p>
										</li>
										<li>
											<div class="coupon">
												<div><em class="fs15">30,000원</em>COUPON</div>
											</div>
											<p>20만원 이상 구매 시</p>
										</li>
										<li>
											<div class="coupon">
												<div><em class="fs15">10,000원</em>COUPON</div>
											</div>
											<p>10만원 이상 구매 시</p>
										</li>
									</ul>
								</td>
								<td class="vTop">
									<ul class="coupon-list">
										<li>
											<div class="coupon">
												<div><em>10%</em>COUPON</div>
											</div>
											<p>3만원 이상 구매 시<b>최대 2만원 할인</b></p>
										</li>
										<li>
											<div class="coupon">
												<div><em>5%</em>COUPON</div>
											</div>
											<p>3만원 이상 구매 시<b>최대 1만원 할인</b></p>
										</li>
										<li>
											<div class="coupon">
												<div><em class="fs15">5,000원</em>COUPON</div>
											</div>
											<p>7만원 이상 구매 시</p>
										</li>
										<li class="double">
											<div class="coupon">
												<div><em class="fs15">무료배송</em>COUPON</div>
												<span class="num">x2</span>
											</div>
											<p>텐텐배송상품 구매 시</p>
										</li>
									</ul>
								</td>
								<td class="vTop">
									<ul class="coupon-list">
										<li>
											<div class="coupon">
												<div><em>5%</em>COUPON</div>
											</div>
											<p>3만원 이상 구매 시<b>최대 1만원 할인</b></p>
										</li>
										<li>
											<div class="coupon">
												<div><em>3%</em>COUPON</div>
											</div>
											<p>3만원 이상 구매 시<b>최대 1만원 할인</b></p>
										</li>
										<li>
											<div class="coupon">
												<div><em class="fs15">3,000원</em>COUPON</div>
											</div>
											<p>5만원 이상 구매 시</p>
										</li>
										<li class="double">
											<div class="coupon">
												<div><em class="fs15">무료배송</em>COUPON</div>
												<span class="num">x2</span>
											</div>
											<p>텐텐배송상품<br />1만원 이상 구매 시</p>
										</li>
									</ul>
								</td>
								<td class="vTop">
									<ul class="coupon-list">
										<li class="double">
											<div class="coupon">
												<div><em>5%</em>COUPON</div>
												<span class="num">x2</span>
											</div>
											<p>3만원 이상 구매 시<b>최대 1만원 할인</b></p>
										</li>
										<li>
											<div class="coupon">
												<div><em class="fs15">무료배송</em>COUPON</div>
											</div>
											<p>텐텐배송상품<br />1만원 이상 구매 시</p>
										</li>
									</ul>
								</td>
								<td class="vTop">
									<ul class="coupon-list">
										<li>
											<div class="coupon">
												<div><em class="fs15">2,000원</em>COUPON</div>
											</div>
											<p>5만원 이상 구매 시</p>
										</li>
										<li>
											<div class="coupon">
												<div><em class="fs15">무료배송</em>COUPON</div>
											</div>
											<p>텐텐배송상품<br />2만원 이상 구매 시</p>
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th>
									텐텐배송상품<br />배송비
									<div class="addInfo">
										<a href="#tenDelivery"><i class="more">?</i></a>
										<div id="tenDelivery" class="contLyr">
											<div class="contLyrInner">
												<p class="title">배송비혜택 안내</p>
												<ul>
													<li>- VIP 무료배송은 텐바이텐배송 상품에 한해서 적용이 됩니다. (업체조건배송 상품 및 업체착불배송 상품 주문 시 해당 업체의 배송정책에 따라 배송비가 부과됩니다.)</li>
													<li>- 배송비 기준 : 상품배송비는 텐바이텐배송/업체배송/업체조건배송/업체착불배송 4가지 기준으로 나누어 적용됩니다. (배송지역에 따른 구분은 해외배송, 군부대배송)</li>
												</ul>
												<table class="tMar15">
												<caption>배송비 기준 안내</caption>
												<colgroup>
													<col style="width:120px;" /> <col style="width:*;" />
												</colgroup>
												<tbody>
												<tr>
													<th>텐바이텐배송</th>
													<td>텐바이텐배송 상품 기준 구매금액이 3만원 미만인 경우 배송비는 2,500원 이며,<br /> 회원등급에 따라 배송비 무료 기준이 달라집니다.</td>
												</tr>
												<tr>
													<th>업체무료배송</th>
													<td>업체배송 상품은 회원등급과 구매금액에 상관없이 항상 무료배송 됩니다.</td>
												</tr>
												<tr>
													<th>업체조건배송</th>
													<td>업체개별배송 상품은 특정브랜드 배송기준에 따라 배송비가 적용됩니다.</td>
												</tr>
												<tr>
													<th>해외배송</th>
													<td>일부 해외반출이 불가한 상품을 제외한 텐바이텐배송 상품은 모두 해외배송이 가능합니다.<br />해외배송비는 우정사업본부의 EMS 기준에 따라 각 나라마다 다르게 책정이 되며 주문 시에 확인할수 있습니다.</td>
												</tr>
												<tr>
													<th style="background:#ffeeee;">군부대배송</th>
													<td>텐바이텐배송 상품은 군부대 배송이 가능합니다. 군부대 배송은 사서함이 포함된 주소로만 주문이 가능하며 우체국 택배 이용으로 구매금액과 상관없이 항상 3,000원의 배송비가 부과됩니다.</td>
												</tr>
												</tbody>
												</table>
												<p class="tPad10">- 텐바이텐배송 상품 중 배송비무료 상품을 구매할 경우 텐바이텐배송의 다른 상품도 무료혜택이 적용됩니다.</p>
											</div>
										</div>
									</div>
								</th>
								<td><strong>무료배송</strong></td>
								<td><strong>1만원 이상 구매 시<br />무료배송</strong></td>
								<td><strong>2만원 이상 구매 시<br />무료배송</strong></td>
								<td><strong>3만원 이상 구매 시<br />무료배송</strong></td>
								<td><strong>3만원 이상 구매 시<br />무료배송</strong></td>
							</tr>
							<tr>
								<th>상품구매<br />마일리지
									<div class="addInfo">
										<a href="#mileage"><i class="more">?</i></a>
										<div id="mileage" class="contLyr">
											<div class="contLyrInner">
												<p class="title">상품 구매 마일리지 적립 안내</p>
												<ul>
													<li>- 상품마다 마일리지 적립 기준이 상이할 수 있습니다.</li>
													<li>- 적립 마일리지는 상품의 판매가(할인 판매가) 기준으로 적용됩니다.</li>
												</ul>
											</div>
										</div>
									</div>
								</th>
								<td>주문금액의<br /><strong>1.3% 적립</strong></td>
								<td>주문금액의<br /><strong>1% 적립</strong></td>
								<td>주문금액의<br /><strong>1% 적립</strong></td>
								<td>주문금액의<br /><strong>0.5% 적립</strong></td>
								<td>주문금액의<br /><strong>0.5% 적립</strong></td>
							</tr>
							<tr>
								<th>
									생일축하<br />쿠폰
									<div class="addInfo">
										<a href="#specialCoupon"><i class="more">?</i></a>
										<div id="specialCoupon" class="contLyr">
											<div class="contLyrInner">
												<p class="title">생일축하 쿠폰 안내</p>
												<ul>
													<li>- 설정해놓으신 생일 일주일 전에 할인쿠폰을 발행해드립니다. (1년에 1회만 발급 / 발행일로부터 15일 동안 사용 가능)</li>
													<li>- 기한내 사용하지 못한 경우 소멸되며, 쿠폰 사용 후 주문 취소 및 반품 후에도 재발행되지 않습니다.</li>
												</ul>
											</div>
										</div>
									</div>
								</th>
								<td>
									<ul class="coupon-list">
										<li>
											<div class="coupon">
												<div><em class="fs15">5,000원</em>COUPON</div>
											</div>
											<p><% If Date() < "2020-03-01" Then %>3<% Else %>4<% End If %>만원 이상 구매 시</p>
										</li>
									</ul>
								</td>
								<td>
									<ul class="coupon-list">
										<li>
											<div class="coupon">
												<div><em class="fs15">5,000원</em>COUPON</div>
											</div>
											<p><% If Date() < "2020-03-01" Then %>3<% Else %>4<% End If %>만원 이상 구매 시</p>
										</li>
									</ul>
								</td>
								<td>
									<ul class="coupon-list">
										<li>
											<div class="coupon">
												<div><em class="fs15">5,000원</em>COUPON</div>
											</div>
											<p><% If Date() < "2020-03-01" Then %>3<% Else %>4<% End If %>만원 이상 구매 시</p>
										</li>
									</ul>
								</td>
								<td>
									<ul class="coupon-list">
										<li>
											<div class="coupon">
												<div><em class="fs15">5,000원</em>COUPON</div>
											</div>
											<p><% If Date() < "2020-03-01" Then %>3<% Else %>4<% End If %>만원 이상 구매 시</p>
										</li>
									</ul>
								</td>
								<td>
									<ul class="coupon-list">
										<li>
											<div class="coupon">
												<div><em class="fs15">5,000원</em>COUPON</div>
											</div>
											<p><% If Date() < "2020-03-01" Then %>3<% Else %>4<% End If %>만원 이상 구매 시</p>
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th>히치하이커<br />(격월 발행)</th>
								<td colspan="2" class="fs12"><a href="/hitchhiker/"><strong>무료제공<i class="more arrow">&gt;</i></strong><br />(홀수 달, 신청기간 내 주소확인 시 제공가능)</a></td>
								<td style="color:#5a88ff;">/</td>
								<td style="color:#ff5b73;">/</td>
								<td style="color:#999;">/</td>
							</tr>
							</tbody>
							</table>
						</div>
					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
