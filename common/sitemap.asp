<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  사이트맵
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/sitemaster/sitemap_cls.asp" -->

<%
dim odispcate, i, tmpcatecode, rowend, vLM_Hot

'//전시카테고리 2뎁스 전체 내역 가져오기
set odispcate = new csitemap
	odispcate.getdispCategory_2depth_all_notpaging
%>
<!-- #include virtual="/lib/inc/head.asp" -->
</head>
<body>
<div id="sitemapWrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="sitemapHgroupV15">
				<div class="inner">
					<h2><img src="http://fiximage.10x10.co.kr/web2015/common/tit_quick_shopping.png" alt="QUICK SHOPPING" /></h2>
					<p><img src="http://fiximage.10x10.co.kr/web2015/common/txt_quick_shopping.png" alt="쉽고 편리하게 필요한 서비스를 찾아보세요!" /></p>
				</div>
			</div>

			<!-- sitemap -->
			<div class="sitemapV15">
					<div class="inner">
						<!-- category -->
						<div class="grid grid1 categoryMap">
							<h3><img src="http://fiximage.10x10.co.kr/web2015/common/tit_sitemap_category.png" alt="CATEGORY" /></h3>
							<% for i = 0 to odispcate.FResultCount -1 %>
								<% if odispcate.FItemList(i).fdepth = "1" then %>
									<% if cstr(tmpcatecode)<>cstr(left(odispcate.FItemList(i).fcatecode,3)) and i<>0 then %>
											</ul>
										</div>
									<% End If %>
									<div class="row">
										<h4><%= odispcate.FItemList(i).fcatename %></h4>
											<ul class="fourth">
								<% End If %>
								<% if odispcate.FItemList(i).fdepth = "2" then %>
									<li><a href="/shopping/category_list.asp?disp=<%= odispcate.FItemList(i).fcatecode %>"><%= odispcate.FItemList(i).fcatename %> <span class='icoHot' style='display:none;' id='maphotdisp<%=odispcate.FItemList(i).fcatecode%>'><img src='http://fiximage.10x10.co.kr/web2013/common/ico_hot.gif' alt='HOT' /></span> <span class='icoNew' <% If odispcate.FItemList(i).fisNew="o" Then %><% Else %>style='display:none;'<% End If %>><img src='http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif' alt='New' /></span></a></li>
								<% End If %>
								<% if cstr(odispcate.FResultCount)=cstr(i+1) then %>
										</ul>
									</div>
								<% end if %>
								<% tmpcatecode = cstr(left(odispcate.FItemList(i).fcatecode,3)) %>
								<%
									'### HOT 카테고리
									If InStr((","&Application("comp_cate_hot")&","),(","&odispcate.FItemList(i).fcatecode&",")) > 0 Then
										vLM_Hot = vLM_Hot & "$('#maphotdisp"&odispcate.FItemList(i).fcatecode&"').show();" & vbCrLf
									End IF
								%>
							<% Next %>
						</div>

						<div class="grid grid2">
							<!-- shopping -->
							<div class="row shoppingMap">
								<h3><img src="http://fiximage.10x10.co.kr/web2015/common/tit_sitemap_shopping.png" alt="SHOPPING" /></h3>
								<ul class="third">
									<li><a href="/shoppingtoday/shoppingchance_newitem.asp">NEW</a></li>
									<li><a href="/award/awardlist.asp">BEST</a></li>
									<li><a href="/shoppingtoday/shoppingchance_saleitem.asp">SALE</a></li>
									<li><a href="/street/">BRAND</a></li>
									<li><a href="/shoppingtoday/shoppingchance_allevent.asp">EVENT</a></li>
									<li><a href="/my10x10/popularwish.asp">WISH</a></li>
									<!--li><a href="/guidebook/dayand.asp" class="fn">DAY&amp;</a></li-->
									<li><a href="/shoppingtoday/couponshop.asp" class="fn">쿠폰북</a></li>
									<li><a href="/shoppingtoday/shoppingchance_mailzine.asp" class="fn">메일진</a></li>
									<li><a href="/bestreview/bestreview_main.asp" class="fn">BEST REVIEW</a></li>
									<li><a href="/culturestation/" class="fn">컬쳐스테이션</a></li>
									<li><a href="/hitchhiker/" class="fn">히치하이커</a></li>
								</ul>
							</div>

							<!-- play -->
							<div class="row playingMap">
								<h3 class="over"><a href="/playing/"><img src="http://fiximage.10x10.co.kr/web2016/common/tit_sitemap_playing.png" alt="PLAYing" /></a></h3>
								<ul class="third">
									<li><a href="/playing/list.asp?cate=thing">THING.</a></li>
									<li><a href="/playing/list.asp?cate=talk">TALK</a></li>
									<li><a href="/playing/list.asp?cate=inspi">!NSPIRATION</a></li>
								</ul>
							</div>

							<!-- gift -->
							<div class="row giftMap">
								<h3 class="over"><a href="/gift/talk/"><img src="http://fiximage.10x10.co.kr/web2015/common/tit_sitemap_gift.png" alt="GIFT" /></a></h3>
								<ul class="third">
									<li><a href="/gift/talk/">GIFT TALK</a></li>
									<li><a href="/gift/hint/">GIFT HINT <!--span class="icoNew"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif" alt="New" /></span--></a></li>
									<li><a href="/gift/WRAPPING.asp">WRAPPING</a></li>
								</ul>
							</div>

							<!-- my10x10 -->
							<div class="row my10x10Map">
								<h3 class="over"><a href="/my10x10/"><img src="http://fiximage.10x10.co.kr/web2015/common/tit_sitemap_my10x10.png" alt="MY10X10" /></a></h3>
								<div class="column half">
									<h4>MY쇼핑리스트</h4>
									<ul>
										<li><a href="/my10x10/order/myorderlist.asp">주문배송조회</a></li>
										<li><a href="/my10x10/order/order_info_edit_detail.asp">주문정보변경</a></li>
										<li><a href="/my10x10/order/order_cancel_detail.asp">주문취소</a></li>
										<li><a href="/my10x10/order/order_return_detail.asp">반품/환불</a></li>
										<li><a href="/my10x10/order/document_issue.asp">증빙서류발급</a></li>
										<li><a href="/my10x10/order/order_cslist.asp">내가 신청한 서비스</a></li>
									</ul>
								</div>
								<div class="column half">
									<h4>MY쇼핑혜택</h4>
									<ul>
										<li><a href="/my10x10/couponbook.asp">쿠폰/보너스 쿠폰</a></li>
										<li><a href="/my10x10/mymileage.asp">마일리지 현황</a></li>
										<li><a href="/my10x10/myTenCash.asp">예치금 관리</a></li>
										<!-- li><a href="/my10x10/special_corner.asp">우수회원 전용코너</a></li -->
										<li><a href="/my10x10/mileage_shop.asp">마일리지샵</a></li>
										<li><a href="/my10x10/special_info.asp">회원혜택 보기</a></li>
									</ul>
								</div>
								<div class="clearFix"></div>
								<div class="column half">
									<h4>MY쇼핑활동</h4>
									<ul>
										<li><a href="/my10x10/qna/myqnalist.asp">1:1 상담</a></li>
										<li><a href="/my10x10/myitemqna.asp">상품 Q&amp;A</a></li>
										<li><a href="/my10x10/goodsusing.asp">상품후기</a></li>
										<li><a href="/my10x10/order/order_myItemList.asp">내가 구매한 상품 <span class="icoNew"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif" alt="New" /></span></a></li>
										<li><a href="/my10x10/myeventmaster.asp">당첨안내</a></li>
										<li><a href="/my10x10/giftcard/">GIFT 카드</a></li>
									</ul>
								</div>
								<div class="column half">
									<h4>MY관심목록</h4>
									<ul>
										<li><a href="/my10x10/mywishlist.asp">위시</a></li>
										<li><a href="/my10x10/myzzimbrand.asp">찜브랜드</a></li>
										<!--li><a href="/my10x10/myfavorite_dayand.asp">관심 Day&amp;</a></li-->
										<!--<li><a href="/my10x10/myfavorite_play.asp">관심 PLAY</a></li>//-->
										<li><a href="/my10x10/myfavorite_event.asp">관심 이벤트</a></li>
										<li><a href="/my10x10/mytodayshopping.asp">오늘 본 상품</a></li>
									</ul>
								</div>
								<div class="column half">
									<h4>MY회원정보</h4>
									<ul>
										<li><a href="/my10x10/userinfo/confirmuser.asp">개인정보수정</a></li>
										<li><a href="/my10x10/MyAddress/MyAddressList.asp">나의 주소록</a></li>
										<li><a href="/my10x10/MyAnniversary/myAnniversaryList.asp">나의 기념일</a></li>
										<li><a href="/my10x10/userinfo/withdrawal.asp">회원탈퇴</a></li>
									</ul>
								</div>
							</div>

							<!-- cs center -->
							<div class="row cscenterMap">
								<h3 class="over"><a href="/cscenter/"><img src="http://fiximage.10x10.co.kr/web2015/common/tit_sitemap_cs.png" alt="CS CENTER" /></a></h3>
								<div class="column third">
									<h4><a href="/cscenter/faq/faqList.asp?selectfaq=1">주문FAQ</a></h4>
									<ul>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F001">주문/결제</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F002">배송</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F003">주문변경/취소</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F004">반품/교환</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F005">환불</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F006">증빙서류</a></li>
									</ul>
								</div>
								<div class="column third">
									<h4><a href="/cscenter/faq/faqList.asp?selectfaq=2">회원FAQ</a></h4>
									<ul>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F007">회원정보</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F008">텐바이텐 멤버쉽</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F009">결제방법</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F010">마일리지/<br /> 상품쿠폰/할인권</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F011">상품문의</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F012">이벤트/사은품</a></li>
									</ul>
								</div>
								<div class="column third">
									<h4><a href="/cscenter/faq/faqList.asp?selectfaq=3">기타FAQ</a></h4>
									<ul>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F013">오프라인</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F014">사이트이용/장애</a></li>
										<li><a href="/cscenter/faq/faqList.asp?divcd=F015">기타</a></li>
									</ul>
								</div>
								<ul class="third typeIco">
									<li class="ico1"><a href="/cscenter/oversea/emsIntro.asp"><span></span>해외배송안내</a></li>
									<li class="ico2"><a href="/offshop/point/card_service.asp"><span></span>POINT1010카드</a></li>
									<li class="ico3"><a href="/gift/gifticon/"><span></span>기프티콘 상품교환</a></li>
									<li class="ico4"><a href="/cscenter/giftcard/"><span></span>GIFT카드 안내</a></li>
									<li class="ico5"><a href="/common/online_banking_list.asp" onclick="window.open(this.href, 'popDepositor', 'width=395, height=685, scrollbars=auto,resizable=yes'); return false;"><span></span>입금자를 찾습니다</a></li>
								</ul>
							</div>

							<!-- company -->
							<div class="row companyMap">
								<h3 class="over"><a href="http://company.10x10.co.kr/" onclick="window.open(this.href, 'popDepositor', 'width=1024, height=768, scrollbars=auto,resizable=yes'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/tit_sitemap_company.png" alt="COMPANY" /></a></h3>
								<ul class="half">
									<li><a href="http://company.10x10.co.kr/company_01.htm" onclick="window.open(this.href, 'popDepositor', 'width=1024, height=768, scrollbars=yes,resizable=yes'); return false;">텐바이텐 소개</a></li>
									<li><a href="http://company.10x10.co.kr/recruit_01.htm" onclick="window.open(this.href, 'popDepositor', 'width=1024, height=768, scrollbars=yes,resizable=yes'); return false;">채용정보</a></li>
									<li><a href="http://company.10x10.co.kr/inquiry_write.asp" onclick="window.open(this.href, 'popDepositor', 'width=1024, height=768, scrollbars=yes,resizable=yes'); return false;">입점문의</a></li>
									<li><a href="http://company.10x10.co.kr/alliance_write.asp" onclick="window.open(this.href, 'popDepositor', 'width=1024, height=768, scrollbars=yes,resizable=yes'); return false;">제휴광고</a></li>
									<li><a href="/offshop/" onclick="window.open(this.href, 'popDepositor', 'width=1024, height=768, scrollbars=auto,resizable=yes'); return false;">오프라인점 안내</a></li>
									<!-- 2017.10.1 서비스 종료
									<li><a href="http://www.thefingers.co.kr" target="_blank">더핑거스</a></li>
									-->
								</ul>
							</div>
						</div>
					</div>
			</div>
			<!-- //sitemap -->

		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<%
	response.write "<script>"&vLM_Hot&"</script> "
%>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->