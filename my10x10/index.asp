<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbEVTopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/classes/street/sp_ZZimBrandCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/todayshoppingcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/util/myalarmlib.asp" -->
<%
Dim C_USEMyALARM : C_USEMyALARM=TRUE

dim i, j, k
dim tmpStr

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : MY TENBYTEN"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


'// ============================================================================
dim IsBSearch : IsBSearch = False ''비회원조회
if IsGuestLoginOK() then	IsBSearch = true

dim userid, page
userid = getEncLoginUserID ''GetLoginUserID
page   = requestCheckVar(request("page"),9)

if page="" then page=1

'// ============================================================================
'// 주문,배송조회
dim myorder
set myorder = new CMyOrder

myorder.FPageSize = 5				'// 5건
myorder.FCurrpage = 1
myorder.FRectUserID = userid
myorder.FRectSiteName = "10x10"
myorder.FrectSearchGubun = "normalorder"

if IsUserLoginOK() then
	myorder.GetMyOrderListProc
elseif IsGuestLoginOK() then
    myorder.FRectOrderserial = GetGuestLoginOrderserial()
	myorder.GetMyOrderListProc
end if


'// ============================================================================
dim oFavList1,oFavList2,oFavList3, EvList, MyAlarmList, MyAlarm_prev_yyyymmdd, MyAlarm_curr_yyyymmdd, MyAlarm_skip_noitem, MyAlarm_display_cnt, MyAlarm_display_MAX
dim dDayStr

dim returnResult : returnResult = False
dim resultRows, resultRow
dim display003or004
dim exist003, exist004
dim weekdayOfNow : weekdayOfNow = Weekday(Now(), 1)		'// 1 = vbSunday

if Not(IsBSearch) then

    ''MY WISH(관심품목)
    set oFavList1 = new CMyFavorite

    oFavList1.FPageSize = 4
    oFavList1.FCurrpage = 1
    oFavList1.FRectUserID = userid

    if (userid<>"") then
        oFavList1.getMyWishListNoFidx
    end if

 	''오늘본상품
    set oFavList2 = new CTodayShopping
    oFavList2.FRectUserID      = userid
    oFavList2.FPageSize        = 3
    oFavList2.FCurrpage        = 1
    oFavList2.FRectOrderType   = "new"
	oFavList2.FRectSellYN	   = "Y"

    if (userid<>"") then
        oFavList2.getMyTodayMainViewList
    end if

    ''찜브랜드
    set oFavList3 = new CMyZZimBrand
    oFavList3.FRectUserID = userid
    oFavList3.FPageSize  = 4
    oFavList3.FCurrPage  = 1

    if (userid<>"") then
        oFavList3.GetMyZzimBrand
    end if

 	''상품후기
	set EvList = new CEvaluateSearcher
	EvList.FRectUserID = Userid
	EvList.FPageSize = 1
	EvList.FCurrPage	= 1
	EvList.FRectEvaluatedYN="N"
	EvList.NotEvalutedItemTop1 ''NotEvalutedItemListNew ''후기 안쓰인 상품 가져오기 (빡셈 수정)

	''MY알림
	if (Not MyAlarm_IsExist_CheckDateCookie()) then
		returnResult = MyAlarm_CheckNewMyAlarm(GetLoginUserID(), GetLoginUserLevel())
	else
		returnResult = MyAlarm_IsExist_NewMyAlarmCookie()
	end if

	if (returnResult = True) then
		Call MyAlarm_SetNewMyAlarmAsRead(GetLoginUserID())
	end if

	MyAlarmList = MyAlarm_MyAlarmList_MAIN(GetLoginUserID(), GetLoginUserLevel())
	MyAlarm_curr_yyyymmdd = ""
	MyAlarm_prev_yyyymmdd = ""

	MyAlarm_display_cnt = 0
	MyAlarm_display_MAX = 6
else
	set oFavList1 = new CMyFavorite
	set oFavList2 = new CTodayShopping
	set oFavList3 = new CMyZZimBrand
	set EvList = new CEvaluateSearcher
end if

'// ============================================================================

	'RecoPick 스크립트 incFooter.asp에서 출력; 2014.10.17 원승현 추가
	RecoPickSCRIPT = "	recoPick('page', 'my10x10');"

%>
<!-- #include virtual="/lib/inc/head.asp" -->
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="my10x10V15">
				<h2><a href="/my10x10/"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_my10x10.png" alt="MY TENBYTEN" /></a></h2>

				<div class="my10x10MainV15">
					<!-- for dev msg : my10x10 menu -->
					<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->

					<div class="section section2">
						<!-- order list -->
						<div class="article orderV15">
							<h3>최근 주문내역</h3>
						<% if myorder.FResultCount > 0 then %>
							<div class="detail">
								<div class="thead"><span class="no">주문번호</span> <span class="goods">주문상품</span> <span class="condition">주문상태</span></div>
								<div id="orderV15" class="tbody">
								<%
									for i=0 to myorder.FResultCount-1
										tmpStr = myorder.FItemList(i).GetItemNames
										tmpStr = chrbyte(tmpStr,90,"Y")

										if (myorder.FItemList(i).FItemCount > 1) then
											tmpStr = tmpStr + " 외 " + CStr(myorder.FItemList(i).FItemCount - 1) + " 건"
										end if
								%>
									<div class="row">
										<div class="no"><a href=""><strong><%= myorder.FItemList(i).Forderserial %></strong><span></span></a></div>
										<div class="colgroup">
											<div class="col col1">
												<a href="/my10x10/order/myorderdetail.asp?idx=<%= myorder.FItemList(i).Forderserial %>">
													<span class="figure"><img src="http://fiximage.10x10.co.kr/images/spacer.gif" width="100" height="100" alt="img<%= myorder.FItemList(i).Forderserial %>" /></span>
													<strong class="pdtName"><%=tmpStr%></strong>
													<span class="date">주문일자 : <%= Replace(Left(myorder.FItemList(i).FRegdate,10), "-", "/") %></span>
													<span class="price">결제금액 : <%= FormatNumber(myorder.FItemList(i).FSubTotalPrice,0) %>원</span>
												</a>
											</div>
											<div class="col col2">
												<em class="<%=myorder.FItemList(i).GetIpkumDivColor%>"><%= myorder.FItemList(i).GetIpkumDivNameNew %></em>
												<div class="btnwrap">
												<% if (myorder.FItemList(i).IsWebOrderInfoEditEnable) or (myorder.FItemList(i).IsWebOrderCancelEnable) or (myorder.FItemList(i).IsWebOrderReturnEnable) or ((myorder.FItemList(i).Fjumundiv="9") and (myorder.FItemList(i).Flinkorderserial<>"")) then %>
													<% if (myorder.FItemList(i).IsWebOrderCancelEnable) then %>
														<a href="/my10x10/order/order_cancel_detail.asp?idx=<%=myorder.FItemList(i).Forderserial%>" class="btn btnS2 btnGrylight" title="주문취소"><span class="fn">주문취소</span></a>
													<% end if %>
													<% if (myorder.FItemList(i).IsWebOrderReturnEnable) then %>
														<a href="/my10x10/order/order_return_detail.asp?idx=<%=myorder.FItemList(i).Forderserial%>" class="btn btnS2 btnGrylight" title="반품접수"><span class="fn">반품접수</span></a>
													<% end if %>
													<% if (myorder.FItemList(i).IsWebOrderInfoEditEnable) then %>
														<a href="/my10x10/order/order_info_edit_detail.asp?idx=<%=myorder.FItemList(i).Forderserial%>" class="btn btnS2 btnGrylight" title="주문정보변경"><span class="fn">주문정보변경</span></a>
													<% end if %>
												<% end if %>
												</div>
											</div>
										</div>
									</div>
								<%
									next
								%>
								</div>
								<a href="/my10x10/order/myorderlist.asp" class="more" title="최근 주문내역 더보기"><span>more</span> &gt;</a>
							</div>
							<script type="text/javascript">
							$(function(){
								fnGetOrdImg('<%=myorder.FItemList(0).Forderserial%>',$("#orderV15 .row:first-child .colgroup .figure img"));
							});
							</script>
						<% else %>
							<div class="nodata">
								<p><img src="http://fiximage.10x10.co.kr/web2015/my10x10/txt_no_data_order.png" alt="최근 주문 상품이 없습니다" /></p>
								<a href="/award/awardlist.asp" class="btn btnS1 btnRed"><span class="whiteArr01 fn">BEST Seller 보기</span></a>
							</div>
						<% end if %>
						</div>
						<!-- // order list -->

						<!--my wish-->
						<div class="article wishV15">
							<h3>MY WISH</h3>
						<% if oFavList1.FResultCount>0 then %>
							<div class="detail">
								<ul class="pdtList">
								<% for i = 0 to oFavList1.FResultCount-1 %>
									<li>
										<a href="/shopping/category_prd.asp?itemid=<%= oFavList1.FItemList(i).FItemId %>" title="상품 페이지로 이동" class="figure"><img src="<%= getThumbImgFromURL(oFavList1.FItemList(i).FImageList120,106,106,"true","false") %>" width="106" height="106" alt="<%= replace(oFavList1.FItemList(i).FItemName,"""","") %>" /></a>
										<span class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%= oFavList1.FItemList(i).FMakerid %>" title="브랜드로 이동"><%=oFavList1.FItemList(i).FbrandName%></a></span>
										<span class="pdtName"><a href="/shopping/category_prd.asp?itemid=<%= oFavList1.FItemList(i).FItemId %>"><%= chrbyte(oFavList1.FItemList(i).FItemName,22,"Y") %></a></span>
										<span class="pdtStTag">
											<% IF oFavList1.FItemList(i).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
											<% IF oFavList1.FItemList(i).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
											<% IF oFavList1.FItemList(i).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
											<% IF oFavList1.FItemList(i).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
											<% IF oFavList1.FItemList(i).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
											<% IF oFavList1.FItemList(i).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
										</span>
									</li>
								<% Next %>
								</ul>
								<a href="/my10x10/mywishlist.asp" class="more" title="MY WISH 더보기"><span>more</span> &gt;</a>
							</div>
						<% else %>
							<div class="nodata">
								<p><img src="http://fiximage.10x10.co.kr/web2015/my10x10/txt_no_data_wish.png" alt="등록된 위시가 없습니다" /></p>
								<a href="/award/awardlist.asp?atype=f" class="btn btnS1 btnRed"><span class="whiteArr01 fn">BEST WISH 보기</span></a>
							</div>
						<% end if %>
						</div>
						<!--// my wish-->

						<!-- zzim brand -->
						<div class="article brandV15">
							<h3><span></span>찜브랜드</h3>
						<% if oFavList3.FResultCount > 0 then %>
							<div class="detail">
								<ul class="pdtList">
								<%
									for i = 0 to oFavList3.FResultCount-1
								%>
									<li>
										<a href="/street/street_brand.asp?makerid=<%= oFavList3.FItemList(i).FMakerid %>" title="브랜드 페이지로 이동">
											<span class="figure"><img src="<%= oFavList3.FItemList(i).FbasicImage %>" width="106" height="106" alt="<%= replace(oFavList3.FItemList(i).Fsocname,"""","") %>" /></span>
											<span class="pdtBrand eng"><%= oFavList3.FItemList(i).Fsocname %></span>
											<span class="pdtBrand ko"><%= oFavList3.FItemList(i).Fsocname_Kor %></span>
											<span class="pdtStTag">
											<% if (oFavList3.FItemList(i).Fnewflg = "Y") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /><% end if %>
											<% if (oFavList3.FItemList(i).Fsaleflg = "Y") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /><% end if %>
											</span>
										</a>
									</li>
								<%
									next
								%>
								</ul>
								<a href="/my10x10/myzzimbrand.asp" class="more" title="찜브랜드 더보기"><span>more</span> &gt;</a>
							</div>
						<% else %>
							<div class="nodata">
								<p><img src="http://fiximage.10x10.co.kr/web2015/my10x10/txt_no_data_brand.png" alt="등록된 찜 브랜드가 없습니다" /></p>
								<a href="/award/awardbrandlist.asp" class="btn btnS1 btnRed"><span class="whiteArr01 fn">BEST BRAND 보기</span></a>
							</div>
						<% end if %>
						</div>
						<!-- // zzim brand -->

						<!-- postscript -->
						<div class="article reviewV15">
							<h3>상품후기</h3>
						<%
							if EvList.FResultCount > 0 then
								'// 예상 적립 마일리지 계산
								Dim cMil, vMileValue, vMileArr
								vMileValue = 100		'기준 후기 마일리지 : 이벤트시 기준 변경
								Set cMil = New CEvaluateSearcher
								cMil.FRectUserID = Userid
								cMil.FRectMileage = vMileValue
								if (Userid<>"") then
								''  vMileArr = cMil.getEvaluatedTotalMileCnt  ''잠시대기 (빡셈)
							    end if
								Set cMil = Nothing
						%>
							<div class="detail">
							    <% if (FALSE) and isArray(vMileArr) then %>
								<p class="mileage">적립 예상 마일리지 (<%=vMileArr(0,0)%>건) <strong><%=FormatNumber(vMileArr(1,0),0)%> p</strong></p>
							    <% end if %>
								<div id="lyrEvalCont">
									<div class="pdtList">
										<a href="/shopping/category_prd.asp?itemid=<%= EvList.FItemList(0).FItemId %>" title="상품 페이지로 이동" class="figure"><img src="<%= getThumbImgFromURL(EvList.FItemList(0).FIcon2,106,106,"true","false") %>" width="106" height="106" alt="<%= Replace(EvList.FItemList(0).FItemName,"""","") %>" /></a>
										<span class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%= EvList.FItemList(0).FMakerid %>" title="브랜드로 이동"><%= EvList.FItemList(0).FMakerName %></a></span>
										<span class="pdtName"><a href="/shopping/category_prd.asp?itemid=<%= EvList.FItemList(0).FItemId %>"><%= EvList.FItemList(0).FItemName %></a></span>
										<% if EvList.FItemList(0).FEvalCnt=0 then %><strong class="saving cRd0V15">+200p적립</strong><% end if %>
										<a href="" class="btn btnS3 btnRed btnW80 fn" onclick="AddEval('<%= EvList.FItemList(0).FOrderSerial %>','<%= EvList.FItemList(0).FItemID %>','<%= EvList.FItemList(0).FItemOption %>');return false;" title="상품후기 쓰기">상품후기 쓰기</a>
									</div>
									<% if (FALSE) then %><!-- heavy -->
									<div class="pagination">
										<button type="button" onclick="return false;" class="prev">이전</button>
										<button type="button" onclick="fnGetMyEvalCont(2);return false;" class="next">다음</button>
										<span><em>1</em>/<%=EvList.FtotalCount%></span>
									</div>
								    <% end if %>
								</div>
								<a href="/my10x10/goodsusing.asp" class="more" title="상품후기 더보기"><span>more</span> &gt;</a>
							</div>
						<% else %>
							<div class="nodata">
								<p><img src="http://fiximage.10x10.co.kr/web2015/my10x10/txt_no_data_review.png" alt="작성할 상품후기가 없습니다" /></p>
								<a href="/bestreview/bestreview_main.asp" class="btn btnS1 btnRed"><span class="whiteArr01 fn">BEST REVIEW 보기</span></a>
							</div>
						<% end if %>
						</div>
						<!-- // postscript -->

						<!-- today product -->
						<div class="article latelyV15">
							<h3>최근 본 상품</h3>
						<%
							dim vImgSize
							if oFavList2.FResultCount > 0 then
						%>
							<div class="detail">
								<ul>
								<%
									for i = 0 to oFavList2.FResultCount-1
									vImgSize = chkIIF(i<2,76,160)
								%>
									<li <%=chkIIF(i=oFavList2.FResultCount-1,"class=""last""","")%>><a href="/shopping/category_prd.asp?itemid=<%= oFavList2.FItemList(i).FItemId %>" title="상품 페이지로 이동"><img src="<%= getThumbImgFromURL(oFavList2.FItemList(i).FImageBasic,vImgSize,vImgSize,"true","false") %>" width="<%=vImgSize%>" height="<%=vImgSize%>" alt="<%= Replace(oFavList2.FItemList(i).FItemName,"""","") %>" /></a></li>
								<% next %>
								</ul>
							</div>
							<a href="/my10x10/mytodayshopping.asp" class="more" title="최근 본 상품 더보기"><span>more</span> &gt;</a>
						<% else %>
							<div class="nodata">
								<p><img src="http://fiximage.10x10.co.kr/web2015/my10x10/txt_no_data_lately.png" alt="최근 본 상품이 없습니다." /></p>
							</div>
						<% end if %>
						</div>
						<!-- // today product -->
					</div>

					<div class="section section3">
						<div class="article alarmV15">
							<h3><span></span>MY 알림</h3>
							<div class="myAlarmV15">
								<% if (Not isArray(MyAlarmList)) then %>
								<div class="alarmListV15">
									<div class="almTodayV15">
										<p class="boxRd0V15"><%=FormatDate(now,"0000.00.00") & " (" & getWeekName(date) & ")" %></p>
									</div>
									<div class="alarmType01">
										<span class="figure"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_wish_cart.png" alt="" /></span>
										<p class="txtV15"><strong>관심 상품을 <br />위시 또는 장바구니에 담아보세요.</strong></p>
										<p class="tPad05">상품 관련 이벤트 소식이 있을 때 알려드려요.</p>
										<p class="tPad15"><a href="/my10x10/popularwish.asp" class="btn btnS2 btnRed"><em class="whiteArr01 fn">실시간 인기위시 보기</em></a></p>
									</div>
								</div>
								<%
								else
									MyAlarm_skip_noitem = False
									MyAlarm_display_cnt = 0

									for i = 0 To UBound(MyAlarmList,2)
										if (MyAlarm_display_cnt >= MyAlarm_display_MAX) then
											exit for
										end if

										MyAlarm_curr_yyyymmdd = MyAlarmList(14,i)
										if (MyAlarm_curr_yyyymmdd <> MyAlarm_prev_yyyymmdd) then
											if (MyAlarm_prev_yyyymmdd <> "") then
												%>
									</ul>
								</div>
												<%
											end if

											MyAlarm_prev_yyyymmdd = MyAlarm_curr_yyyymmdd
											MyAlarm_skip_noitem = False

											'// 장바구니 상품이벤트, 위시 상품이벤트 중 어떤걸 표시할지
											display003or004 = "000"
											exist003 = False
											exist004 = False
											weekdayOfNow = Weekday(CDate(MyAlarm_curr_yyyymmdd), 1)

											for j = 0 To UBound(MyAlarmList,2)
												if (MyAlarm_curr_yyyymmdd = MyAlarmList(14,j)) then
													Select Case MyAlarmList(1,j)
														Case "003"
															exist003 = True
															if (weekdayOfNow = 2) or (weekdayOfNow = 4) then
																display003or004 = "003"
															end if
														Case "004"
															exist004 = True
															if (weekdayOfNow <> 2) and (weekdayOfNow <> 4) then
																display003or004 = "004"
															end if
														Case Else
															''
													End Select
												end if
											next

											if (display003or004 = "000") then
												if (exist003 = True) then
													display003or004 = "003"
												end if

												if (exist004 = True) then
													display003or004 = "004"
												end if
											end if
									%>
								<div class="alarmListV15">
									<div class="almTodayV15">
										<p class="boxRd0V15"><%=FormatDate(CDate(MyAlarm_curr_yyyymmdd),"0000.00.00") & " (" & getWeekName(CDate(MyAlarm_curr_yyyymmdd)) & ")" %></p>
									</div>
									<ul class="alarmUnitV15">
									<%
										end if

										Select Case MyAlarmList(1,i)
											Case "000"
												''// 단체알림
												MyAlarm_skip_noitem = True
												MyAlarm_display_cnt = MyAlarm_display_cnt + 1
												%>
										<li class="mktIsuPartV15">
											<a href="<%= MyAlarmList(5,i) %>">
												<span class="alarmIcoV15"></span>
												<dl>
													<dt><%= MyAlarmList(2,i) %></dt>
													<dd><%= MyAlarmList(3,i) %></dd>
												</dl>
												<p><%= MyAlarmList(4,i) %></p>
											</a>
										</li>
												<%
											Case "001"
												''// 신규가입쿠폰
												MyAlarm_skip_noitem = True
												MyAlarm_display_cnt = MyAlarm_display_cnt + 1
												%>
										<li class="cuponPartV15">
											<a href="<%= MyAlarmList(5,i) %>">
												<span class="alarmIcoV15"></span>
												<dl>
													<dt><%= MyAlarmList(2,i) %></dt>
													<dd><%= MyAlarmList(3,i) %></dd>
												</dl>
												<p><%= MyAlarmList(4,i) %></p>
											</a>
										</li>
												<%
											Case "002"
												''// 쿠폰만료
												if (MyAlarm_curr_yyyymmdd = Left(Now(), 10)) then
													MyAlarm_skip_noitem = True
													MyAlarm_display_cnt = MyAlarm_display_cnt + 1
												%>
										<li class="cuponPartV15">
											<a href="<%= MyAlarmList(5,i) %>">
												<span class="alarmIcoV15"></span>
												<dl>
													<dt><%= MyAlarmList(2,i) %></dt>
													<dd><%= MyAlarmList(3,i) %></dd>
												</dl>
												<p><%= MyAlarmList(4,i) %></p>
											</a>
										</li>
												<%
												end if
											Case "003"
												''// 장바구니 상품 이벤트
												if display003or004 = "003" then
													MyAlarm_skip_noitem = True
													MyAlarm_display_cnt = MyAlarm_display_cnt + 1
												%>
										<li class="evtPartV15">
											<a href="<%= MyAlarmList(5,i) %>">
												<span class="alarmIcoV15"><img src="<%= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(MyAlarmList(11,i)) + "/" + MyAlarmList(13,i) %>" alt="<%= db2html(MyAlarmList(12,i)) %>" /></span>
												<p class="pdtStTag">
													<% if (MyAlarmList(10,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /><% end if %>
													<% if (MyAlarmList(9,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /><% end if %>
													<% if (MyAlarmList(11,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /><% end if %>
												</p>
												<dl>
													<dt><%= MyAlarmList(2,i) %></dt>
													<dd><%= MyAlarmList(3,i) %></dd>
												</dl>
												<p><%= MyAlarmList(4,i) %></p>
											</a>
										</li>
												<%
												end if
											Case "004"
												''// 위시 상품 이벤트
												if display003or004 = "004" then
													MyAlarm_skip_noitem = True
													MyAlarm_display_cnt = MyAlarm_display_cnt + 1
												%>
										<li class="evtPartV15">
											<a href="<%= MyAlarmList(5,i) %>">
												<span class="alarmIcoV15"><img src="<%= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(MyAlarmList(11,i)) + "/" + MyAlarmList(13,i) %>" alt="<%= db2html(MyAlarmList(12,i)) %>" /></span>
												<p class="pdtStTag">
													<% if (MyAlarmList(9,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /><% end if %>
													<% if (MyAlarmList(8,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /><% end if %>
													<% if (MyAlarmList(10,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /><% end if %>
												</p>
												<dl>
													<dt><%= MyAlarmList(2,i) %></dt>
													<dd><%= MyAlarmList(3,i) %></dd>
												</dl>
												<p><%= MyAlarmList(4,i) %></p>
											</a>
										</li>
												<%
												end if
											Case "005"
												''// 1:1 상담
												MyAlarm_skip_noitem = True
												MyAlarm_display_cnt = MyAlarm_display_cnt + 1
												%>
										<li class="csPartV15">
											<a href="<%= MyAlarmList(5,i) %>">
												<span class="alarmIcoV15"></span>
												<p><img src="http://fiximage.10x10.co.kr/web2015/common/tag_a_ok.gif" alt="답변완료" /></p>
												<dl>
													<dt><%= MyAlarmList(2,i) %></dt>
													<dd><%= MyAlarmList(3,i) %></dd>
												</dl>
												<p><%= MyAlarmList(4,i) %></p>
											</a>
										</li>
												<%
											Case "006"
												''// 상품 QnA
												MyAlarm_skip_noitem = True
												MyAlarm_display_cnt = MyAlarm_display_cnt + 1
												%>
										<li class="csPartV15">
											<a href="<%= MyAlarmList(5,i) %>">
												<span class="alarmIcoV15"></span>
												<p><img src="http://fiximage.10x10.co.kr/web2015/common/tag_a_ok.gif" alt="답변완료" /></p>
												<dl>
													<dt><%= MyAlarmList(2,i) %></dt>
													<dd><%= MyAlarmList(3,i) %></dd>
												</dl>
												<p><%= MyAlarmList(4,i) %></p>
											</a>
										</li>
												<%
											Case "007"
												''// 이벤트 당첨
												MyAlarm_skip_noitem = True
												MyAlarm_display_cnt = MyAlarm_display_cnt + 1
												%>
										<li class="winPartV15">
											<a href="<%= MyAlarmList(5,i) %>">
												<span class="alarmIcoV15"></span>
												<dl>
													<dt><%= MyAlarmList(2,i) %></dt>
													<dd><%= MyAlarmList(3,i) %></dd>
												</dl>
												<p><%= MyAlarmList(4,i) %></p>
											</a>
										</li>
												<%
											Case "901"
												''// 관심상품 없음
												if (MyAlarm_skip_noitem = False) then
													MyAlarm_display_cnt = MyAlarm_display_cnt + 1
												%>
										<li class="alarmType01">
											<span class="figure"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_wish_cart.png" alt="" /></span>
											<p class="txtV15"><strong>관심 상품을 위시 또는<br /> 장바구니에 담아보세요.</strong></p>
											<p class="tPad05">상품 관련 이벤트 소식이 있을 때<br /> 알려드려요.</p>
											<p class="tPad15"><a href="/my10x10/popularwish.asp" class="btn btnS2 btnRed"><em class="whiteArr01 fn">실시간 인기위시 보기</em></a></p>
										</li>
												<%
												end if
											Case "902"
												''// 관련이벤트 없음
												if (MyAlarm_skip_noitem = False) then
													MyAlarm_display_cnt = MyAlarm_display_cnt + 1
												%>
										<li class="alarmType01">
											<span class="figure"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_event.png" alt="" /></span>
											<p class="txtV15"><strong>추천 이벤트가 발견되지<br /> 않았습니다.</strong></p>
											<p class="tPad05">맘에 드는 관심 상품 수를<br /> 늘려보세요.</p>
											<p class="tPad15"><a href="/my10x10/popularwish.asp" class="btn btnS2 btnRed"><em class="whiteArr01 fn">실시간 인기위시 보기</em></a></p>
										</li>
												<%
												end if
											Case Else
												''
										End Select
									Next
								end if
									%>
									</ul>
								</div>
								<p class="expire">수신일로부터 5일이 지난 알림은 자동 삭제됩니다.</p>
							</div>
						</div>
						<p class="tPad10"><a href="/shoppingtoday/gift_recommend.asp?gaparam=my10x10_wrapping"><img src="http://fiximage.10x10.co.kr/web2017/my10x10/bnr_giftwrap.png" alt="텐바이텐 선물포장 서비스" /></a></p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<script type="text/javascript">
$(function(){
	/* 최근 주문내역 */
	$("#orderV15 .row .colgroup").hide();
	$("#orderV15 .row:first-child .colgroup").show();
	$("#orderV15 .row:first-child .no a").addClass("on");

	$("#orderV15 .row .no a").on("click", function() {
		$("#orderV15 .row .colgroup").hide();
		$("#orderV15 .row .no a").removeClass("on");
		$(this).parent().next().show();
		$(this).addClass("on");

		fnGetOrdImg($(this).find("strong").text(),$(this).parent().next().find(".figure img"));
		return false;

	});
});

//최근주문 이미지 출력
function fnGetOrdImg(ordsn,tgt) {
	if($(tgt).attr("src")=="http://fiximage.10x10.co.kr/images/spacer.gif") {
		$.ajax({
			url: "/my10x10/inc/act_getmyorderitemimage.asp?ordsn="+ordsn,
			cache: false,
			success: function(message) {
				if(message!=="") {
					$(tgt).attr("src",message);
				}
			}
			,error: function(err) {
				alert(err.responseText);
			}
		});
	}
}

// 후기 내용 접수
function fnGetMyEvalCont(pg) {
	$.ajax({
		url: "/my10x10/inc/act_getMyEvalContents.asp?page="+pg,
		cache: false,
		success: function(message) {
			if(message!=="") {
				$("#lyrEvalCont").html(message);
			}
		}
		,error: function(err) {
			alert(err.responseText);
		}
	});
}

</script>
</body>
</html>
<%

set oFavList1 = Nothing
set oFavList2 = Nothing
set oFavList3 = Nothing
set EvList = Nothing
%>
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
