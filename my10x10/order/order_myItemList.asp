<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/myOrderItemListCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	strPageTitle = "텐바이텐 10X10 : 내가 구매한 상품"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim userid, page, sortMtd, disp, i
userid = getEncLoginUserID ''GetLoginUserID
page   = getNumeric(requestCheckVar(request("page"),9))
sortMtd   = requestCheckVar(request("sort"),4)
disp   = getNumeric(requestCheckVar(request("disp"),3))

if page="" then page=1
if sortMtd="" then sortMtd="reg"			'정렬방법 (reg:구매순, best:인기상품순)

dim myorder
set myorder = new CMyOrderItem
myorder.FRectUserID	= userid
myorder.FPageSize	= 20
myorder.FCurrpage	= page
myorder.FRectSortMethod	= sortMtd
myorder.FRectDisp	= disp

if (userid<>"") then
    myorder.getMyOrderItemList
end if

%>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript">
function goPage(pg) {
	document.frm.page.value=pg;
	document.frm.submit();
}
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap skinBlue">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->

			<div class="my10x10">
				<!-- for dev msg : my10x10 menu -->
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->

				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_get.png" alt="내가 구매한 상품" /></h3>
						<ul class="list">
							<li>최근 6개월간 구매한 상품 리스트입니다.</li>
							<li>3회 이상 반복 구매한 상품은 &quot;MY PICK&quot; 라벨로 표시됩니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<div class="mygetV15">
							<div class="sorting">
								<p><strong>6개월간 구매한 상품 : <span class="cRd0V15"><%=formatNumber(myorder.FTotalCount,0)%>개</span></strong></p>
								<div class="option">
								<form name="frm" method="get" action="">
									<input type="hidden" name="page" value="">
									<select name="disp" title="카테고리 정렬 옵션" class="optSelect2" onchange="this.form.page=1; this.form.submit();">
										<%=CategorySelectBoxOption(disp)%>
									</select>
                                    <% if (FALSE) then %>
									<select name="sort" title="상품 정렬 옵션" class="optSelect2" onchange="this.form.page=1; this.form.submit();">
										<option value="reg">구매일자순</option>
										<option value="best">베스트상품순</option>
									</select>
								    <% end if %>
								</form>
								</div>
							</div>

							<!-- list -->
							<div class="pdtWrap pdt150V15">
							<%	If (myorder.FResultCount < 1) Then %>
								<p class="noData"><strong>최근 6개월간 구매하신 상품이 없거나 조건에 맞는 상품이 없습니다.</strong></p>
							<%
								Else
							%>
								<ul class="pdtList">
								<%	for i = 0 to myorder.FResultCount-1 %>
									<li <%=chkIIF(myorder.FItemList(i).IsSoldOut,"class=""soldOut""","")%>>
										<div class="pdtBox">
											<% if myorder.FItemList(i).ForderCnt>2 then %><strong class="pdtLabel"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_label_mypick.png" alt="MY PICK" /></strong><% end if %>
											<div class="pdtPhoto">
												<a href="/shopping/category_prd.asp?itemid=<%= myorder.FItemList(i).FItemId %>" title="상품 페이지로 이동"><span class="soldOutMask"></span><img src="<%= getThumbImgFromURL(myorder.FItemList(i).FImageBasic,150,150,"true","false") %>" width="150" height="150" alt="<%=replace(myorder.FItemList(i).FItemName,"""","")%>" /></a>
											</div>
											<div class="pdtInfo">
												<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= myorder.FItemList(i).FMakerid %>" title="브랜드로 이동"><%= myorder.FItemList(i).FBrandName %></a></p>
												<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= myorder.FItemList(i).FItemId %>" title="상품 페이지로 이동"><%= myorder.FItemList(i).FItemName %></a></p>
												<p class="pdtPrice">
													<span class="finalP"><%=FormatNumber(myorder.FItemList(i).getRealPrice,0)%>원</span>
													<% IF myorder.FItemList(i).IsSaleItem then %><strong class="crRed">[<%=myorder.FItemList(i).getSalePro%>]</strong><% end if %>
												</p>
												<% if myorder.FItemList(i).ForderOption<>"0000" then %><span class="pdtOption">구매옵션 | <%=myorder.FItemList(i).ForderOptionName%></span><% end if %>
												<span class="pdtDate">구매날짜 | <%=formatDate(myorder.FItemList(i).ForderDate,"0000.00.00")%></span>
											</div>
											<ul class="pdtActionV15">
												<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=myorder.FItemList(i).FItemid %>'); return false;" title="크게 보기"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
												<li class="postView"><a href="" onclick="<%=chkIIF(myorder.FItemList(i).FEvalCnt>0,"popEvaluate('" & myorder.FItemList(i).FItemid & "');","")%>return false;" title="상품후기 보기"><span><%=myorder.FItemList(i).FEvalCnt%></span></a></li>
												<li class="wishView"><a href="" onclick="TnAddFavorite('<%=myorder.FItemList(i).FItemid %>'); return false;" title="위시 담기"><span><%=myorder.FItemList(i).FfavCount%></span></a></li>
											</ul>
										</div>
									</li>
								<%	Next %>
								</ul>
							<%	end if %>
							</div>
							<!-- // list -->

							<!-- paging -->
							<div class="pageWrapV15 tMar20">
								<%= fnDisplayPaging_New_nottextboxdirect(myorder.FcurrPage, myorder.FtotalCount, myorder.FPageSize, 10, "goPage") %>
							</div>
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
<% set myorder = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->