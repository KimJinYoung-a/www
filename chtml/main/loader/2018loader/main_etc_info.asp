<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/shopping/offshopcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
			<div class="section etc-info">
				<div class="inner-cont">
					<div class="group group1">
						<%' 공지사항 //%>
						<!-- #include virtual="/chtml/main/new_idx_notice.html" -->
						<!-- 매장안내 -->
						<%
						dim offshoplist, ix
						Set  offshoplist = New COffShop
						offshoplist.GetOffShopList
						%>
						<div class="article store">
							<h2>매장안내 <!-- <span class="icoV18 ico-new"></span>새 매장 있을경우 ico-new--></h2>
							<a href="http://www.10x10.co.kr/offshop/index.asp?shopid=streetshop011" class="btn-linkV18 link2" target="_blank">more <span></span></a>
							<% If offshoplist.FResultCount >0 Then %>
							<ul>
								<% For ix=0 To offshoplist.FResultCount-1 %>
								<li><a href="http://www.10x10.co.kr/offshop/index.asp?shopid=<%=offshoplist.FItemList(ix).FShopID%>" target="_blank"><%=offshoplist.FItemList(ix).FShopName%></a></li>
								<% Next %>
							</ul>
							<% End If %>
						</div>
						<% Set  offshoplist = Nothing %>
					</div>
					<div class="group group2">
						<!-- 서비스 -->
						<div class="article service">
							<h2>서비스</h2>
							<ul>
								<li><a href="<%=SSLUrl%>/giftcard/"><b>텐바이텐 기프트카드</b></a></li>
								<li><a href="/offshop/point/card_service.asp" target="_blank">텐바이텐 멤버십카드</a></li>
								<li><a href="/shoppingtoday/gift_recommend.asp">선물포장 서비스</a></li>
								<li class="tPad25"><a href="/cscenter/thanks10x10.asp?gaparam=main_menu_thanks">고마워 텐바이텐</a></li>
								<li class="tPad25"><a href="/gift/gifticon/"><b>기프티콘 상품교환</b></a></li>
								<li><a href="" onclick="popMailling_InMain();return false;">비회원 메일 신청</a></li>
							</ul>
						</div>
					</div>
					<div class="group group3">
						<!-- 회원혜택 -->
						<div class="article benefit">
							<h2>회원혜택</h2>
							<ul>
								<li><a href="/shoppingtoday/couponshop.asp">쿠폰북</a></li>
								<li><a href="/cscenter/membershipGuide/">회원등급별 혜택</a></li>
							</ul>
						</div>
						<!-- JOIN US -->
						<div class="article join-us">
							<h2>JOIN US!</h2>
							<p>지금 텐바이텐 가입하면<br /><strong class="color-red">무료배송 + 45,000원 쿠폰</strong></p>
							<a href="/member/join.asp" class="btn-linkV18 link1 fs12"><b>회원가입 하기</b> <span></span></a>
						</div>
					</div>
					<div class="group group4">
						<!-- SNS -->
						<div class="article tenten-sns">
							<h2>SNS</h2>
							<ul>
								<li class="instagram"><a href="https://instagram.com/your10x10/" target="_blank"><span class="icoV18"></span>인스타그램</a></li>
								<li class="facebook"><a href="https://www.facebook.com/your10x10" target="_blank"><span class="icoV18"></span>페이스북</a></li>
								<li class="youtube"><a href="https://www.youtube.com/user/10x10x2010/" target="_blank"><span class="icoV18"></span>유튜브</a></li>
							</ul>
						</div>
						<!-- 모바일 -->
						<div class="article mobile">
							<h2>모바일</h2>
							<div class="overHidden" style="padding-bottom:3px;">
								<div class="qrcode ftLt"><img src="http://fiximage.10x10.co.kr/web2018/main/img_qrcode.png?v=1.1" alt="" /></div>
								<div class="ftRt">
									<a href="https://play.google.com/store/apps/details?id=kr.tenbyten.shopping" target="_blank"><img src="http://fiximage.10x10.co.kr/web2018/main/btn_google_play.png?v=1.1" alt="Google play" /></a>
									<a href="https://itunes.apple.com/kr/app/tenbaiten/id864817011?mt=8" target="_blank"><img src="http://fiximage.10x10.co.kr/web2018/main/btn_app_store.png?v=1.2" alt="APP STORE" /></a>
								</div>
							</div>
							<a href="/event/appdown/" class="btn-linkV18 link1 fs12"><b>앱 다운 받고 쿠폰 받으세요</b> <span></span></a>
						</div>
					</div>
				</div>
			</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->