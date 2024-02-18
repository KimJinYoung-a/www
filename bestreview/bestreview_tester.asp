<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	strPageTitle = "텐바이텐 10X10 : 베스트 리뷰 - 테스터후기"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls_B.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	dim page, sortDiv, bdgUid, bdgBno, arrUserid
	dim oEval, lp, lp2
	Dim catecode

	catecode = RequestCheckVar(request("disp"),3)
	sortDiv = RequestCheckVar(Request("sortDiv"),16)
	page = RequestCheckVar(Request("page"),9)

	if page="" then page=1
	if sortDiv="" then sortDiv="pnt"	'new:신상 / pnt:평점 / bst:인기상품 / cnt:갯수

	set oEval = new CSpecial
	oEval.FCurrpage = page
	oEval.FScrollCount = 10
	oEval.FRectSort = sortDiv
	oEval.FRectCateCode = catecode
	oEval.FPageSize = 8
	oEval.FRectMode = "item"
	oEval.FRegdateS = Left(dateAdd("m",-9,now()),10) 	''검색 느림 날짜 조건 추가 /eastone
	''oEval.FRegdateS = Left(dateAdd("yyyy",-4,date()),10)
	oEval.FRegdateE = Left(dateAdd("d",+1,now()),10)   	''검색 느림 날짜 조건 추가 /eastone
	
	oEval.GetTesterReviewAllList

%>
<script type="text/javascript">
function goPage(pg) {
	document.frmMove.page.value=pg;
	document.frmMove.submit();
}

$(function(){
	$('.bestReview .pdtList li:nth-child(even) .pdtBox').css('padding-left','64px');
});
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap">
			<div class="hotHgroupV19 bg-orange">
				<div class="tab-area">
					<ul>
						<li><a href="/award/awardlist.asp?atype=g&disp=<%=catecode%>">베스트 셀러</a></li>
						<li class="on"><a href="#">베스트 리뷰</a></li>
					</ul>
				</div>
				<h2>BEST REVIEW</h2>
				<div class="grpSubWrapV19">
					<ul>
						<li class="nav1"><a href="/bestreview/bestreview_main.asp?disp=<%=catecode%>">상품후기</a></li>
						<li class="nav2"><a href="/bestreview/bestreview_photo.asp?disp=<%=catecode%>">포토후기</a></li>
						<li class="nav3 on"><a href="/bestreview/bestreview_tester.asp?disp=<%=catecode%>">테스터후기</a></li>
					</ul>
				</div>
			</div>
			<div class="snb-bar">
				<div class="snbbar-inner">
					<div class="btn-ctgr"><span><%=fnSelectCategoryName(catecode)%></span></div>
				</div>
				<div class="lnbHotV19">
					<div class="inner">
						<ul>
							<li class="<%= chkIIF(catecode="","on","") %>"><a href="bestreview_tester.asp?sortDiv=<%=sortDiv%>">전체 카테고리</a></li>
							<%=fnAwardBestCategoryLI(catecode,"/bestreview/bestreview_tester.asp?sortDiv="&sortDiv&"&")%>
						</ul>
					</div>
				</div>
			</div>
			<div class="hotSectionV15 bestReviewV15">
				<div class="hotArticleV15">
					<div class="ctgyWrapV15">
					<% If oEval.FTotalCount > 0 Then %>
						<div class="pdtWrap reviewListV15 photoReviewWrap">
							<ul class="pdtList">
							<%
							'사용자 아이디 모음 생성(for Badge)
							For lp = 0 To oEval.FResultCount-1
								arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oEval.FItemList(lp).FUserID) & "''"
							Next
						
							'뱃지 목록 접수(순서 랜덤)
							Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")
							
							dim tmpPdtPhotoImg							
							For lp=0 To (oEval.FResultCount-1)								
								tmpPdtPhotoImg = getThumbImgFromURL(chkIIF(oEval.FItemList(lp).FImageIcon1<>"",oEval.FItemList(lp).FImageIcon1,oEval.FItemList(lp).FImageIcon2),400,400,"true","false")
							%>
								<li <% IF oEval.FItemList(lp).isSoldOut Then response.write "class='soldOut'" %>>
									<div class="reviewBoxV15">
										<p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoints%>.png" alt="별<%=oEval.FItemList(lp).FPoints%>개" /></p>
										<div class="reviewTxt">
											<% = chrbyte(oEval.FItemList(lp).Fcontents,75,"Y") %>
										</div>
										<div class="reviewWriteV15">
											<p>
												<%=getUserBadgeIcon(oEval.FItemList(lp).FUserID,bdgUid,bdgBno,3)%>
											</p>
											<p><% = printUserId(oEval.FItemList(lp).Fuserid,2,"*") %></p>
											<p><% = FormatDate(oEval.FItemList(lp).FBRWriteRegdate,"0000/00/00") %></p>
										</div>
										<a href="" onclick="popTestEvaluate('<%=oEval.FItemList(lp).FItemid%>'); return false;" class="more1V15">상품 전체 리뷰보기</a>
										<div class="pdtPhoto">										
											<a href="#">
											<% if not (oEval.FItemList(lp).FImageIcon1 = "" and oEval.FItemList(lp).FImageIcon2 = "") then %>											
												<img src="<%=tmpPdtPhotoImg%>" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" />
											<% end if %>	
											</a>
										</div>
									</div>
									<div class="pdtBox">
										<div class="pdtPhoto">
											<a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%>"><span <% IF oEval.FItemList(lp).isSoldOut Then response.write "class='soldOutMask'" %>></span><img src="<%=oEval.FItemList(lp).FImageList120%>" width="120px" height="120px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
										</div>
										<div class="pdtInfo">
											<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oEval.FItemList(lp).FMakerId%>"><%=oEval.FItemList(lp).Fbrandname%></a></p>
											<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%>"><%=oEval.FItemList(lp).Fitemname%></a></p>
											<p class="pdtPrice">
											<%
												if oEval.FItemList(lp).IsSaleItem or oEval.FItemList(lp).isCouponItem Then
													Response.Write "<span class=""txtML"">" & FormatNumber(oEval.FItemList(lp).getOrgPrice,0) & "원</p>"
													IF oEval.FItemList(lp).IsSaleItem then
														Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
														Response.Write " <strong class=""cRd0V15""> [" & oEval.FItemList(lp).getSalePro & "]</strong>"
													End IF
													IF oEval.FItemList(lp).IsCouponItem then
														Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).GetCouponAssignPrice,0) & "원</span>"
														Response.Write " <strong class=""crGrn""> [" & oEval.FItemList(lp).GetCouponDiscountStr & "]</strong>"
													End IF
												Else
													Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
												End if
											%>
												<span class="pdtStTag">
													<% IF oEval.FItemList(lp).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
													<% IF oEval.FItemList(lp).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
													<% IF oEval.FItemList(lp).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
													<% IF oEval.FItemList(lp).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
													<% IF oEval.FItemList(lp).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
													<% IF oEval.FItemList(lp).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
												</span>
											</p>
										</div>
										<ul class="pdtActionV15">
											<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oEval.FItemList(lp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
											<li class="postView"><a href="" <%=chkIIF(oEval.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oEval.FItemList(lp).FItemid & "'); return false;""","")%>><span><%=oEval.FItemList(lp).FEvalcnt%></span></a></li>
											<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oEval.FItemList(lp).FItemid %>'); return false;"><span><%= oEval.FItemList(lp).FfavCount %></span></a></li>
										</ul>
									</div>
								</li>
							<% next %>
							</ul>
						</div>
					<% else %>
						<div class="pdtWrap noReviewV15">
							<p><img src="http://fiximage.10x10.co.kr/web2015/shopping/best_review_none3.png" alt="" /></p>
							<p class="tPad15">앗! 작성된 테스터후기가 없습니다.</p>
						</div>
					<% end if %>
						<div class="pageWrapV15 tMar20">
							<%= fnDisplayPaging_New(page,oEval.FTotalCount,oEval.FPageSize,10,"goPage") %>
						</div>
					</div>
				</div>
				<form name="frmMove" method="GET" action="<%=CurrURL()%>" style="margin:0px;">
				<input type="hidden" name="disp" value="<%=catecode%>">
				<input type="hidden" name="sortDiv" value="<%=sortDiv%>">
				<input type="hidden" name="page" value="1">
				</form>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% set oEval = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->