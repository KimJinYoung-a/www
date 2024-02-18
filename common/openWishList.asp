<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 공개용 위시리스트
' History : 2010.04.20 허진원 생성
'           2013.09.30 허진원 : 2013 리뉴얼
'###########################################################

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 오픈 위시리스트"		'페이지 타이틀 (필수)
strPageDesc = "내가 갖고 싶은 건 바로 이거야! 디자인전문 쇼핑몰 텐바이텐"		'페이지 설명
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/rndSerial.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	Dim fid, fidx, page, vDisp, pagesize, SortMethod, OrderType, userid, username, deliType, SellScope
	Dim optionBoxHtml

	fid			= requestCheckVar(request("fid"),12)
	page       	= requestCheckVar(request("page"),9)
	vDisp		= requestCheckVar(request("disp"),3)
	pagesize    = requestCheckVar(request("pagesize"),9)
	SortMethod  = requestCheckVar(request("SortMethod"),10)
	OrderType   = requestCheckVar(request("OrderType"),10)
	deliType	= requestCheckVar(request("deliType"),2)
	SellScope	= requestCheckVar(request("sscp"),1)			'품절상품 제외여부

	if page="" then page=1

	'상품 아이콘 사이즈에 따라 표시수 변경
	IF PageSize ="" then PageSize = 30

	'// 폴더번호 복호화
	fidx = rdmSerialDec(fid)

	if fidx="" then
		Call Alert_move("없거나 잘못된 번호입니다.","http://www.10x10.co.kr/")
		dbget.Close: response.End
	end if

	'// 폴더 공개여부 검사
	Call getFavoriteOpenFolder(fidx, userid, username)

	if userid="" or isNull(userid) then
		Call Alert_move("공개되지 않았거나 잘못된 번호입니다.","http://www.10x10.co.kr/")
		dbget.Close: response.End
	end if

	'// 폴더 상품 목록 접수
	dim myfavorite
	set myfavorite = new CMyFavorite
	myfavorite.FPageSize       	= pagesize
	myfavorite.FCurrpage       	= page
	myfavorite.FScrollCount    	= 10
	myfavorite.FRectOrderType  	= OrderType
	myfavorite.FRectSortMethod 	= SortMethod
	myfavorite.FRectDisp		= vDisp
	myfavorite.FRectUserID     	= userid
	myfavorite.FFolderIdx		= fidx
	myfavorite.FRectdeliType	= deliType
	myfavorite.FRectSellScope	= SellScope
	
	myfavorite.getMyWishList

	dim i,j, lp, ix
%>
<script type='text/javascript'>

function Add2Favorate(frm){
    if (frm.bagarray==undefined) return;
    
    var buf = "";
    
    frm.bagarray.value = "";
    for (i = 0; i < frm.elements.length; i++) {
		var e = frm.elements[i];
		if ((e.type == 'checkbox') && (e.checked == true)) {
		    frm.bagarray.value = frm.bagarray.value + frm.elements[i].value + ",";
		}
    }

    if (frm.bagarray.value == "") {
        alert("선택된 상품이 없습니다.");
        return;
    }

    if (confirm("선택된 상품을 관심품목에 등록 하시겠습니까?") == true) {
        frm.mode.value = "AddFavItems";
        frm.target="FavWin";
        frm.action = "/my10x10/popMyFavorite.asp";
        window.open('' ,'FavWin','width=380,height=300,scrollbars=no,resizable=no');
        frm.submit();
    }
}

//카테고리 검색
function SwapCate(comp){
	document.frmsearch.disp.value=comp;
	document.frmsearch.page.value=1;
	document.frmsearch.submit();
}


//정렬 검색
function orderitem(comp){
	frmsearch.page.value=1;
	frmsearch.submit();
}

// 상품목록 페이지 이동
function goPage(pg){
	frmsearch.page.value=pg;
	frmsearch.submit();
}

//장바구니 담기  
function Add2Shoppingbag(frm){
    var frmBaguni = document.frmBaguni;
    
    if (frm.bagarray==undefined) return;
    
    var buf = "";
    
    frm.bagarray.value = "";
    for (i = 0; i < frm.elements.length; i++) {
        var e = frm.elements[i];
        if ((e.type == 'checkbox') && (e.checked == true)) {
    		if ((frm.elements[i+2].type == 'hidden') && (frm.elements[i + 2].value=='0')){
            	alert("품절된 상품은 장바구니에 담을수 없습니다."); 
            	e.focus();
            	return;
            }

            // 옵션이 없는 경우
            if ((frm.elements.length > (i+3)) && (frm.elements[i + 3].type != 'select-one')) {
                    frm.bagarray.value = frm.bagarray.value + e.value + ",0000,1|";
            } else if (frm.elements.length <= (i+3)) {
                    frm.bagarray.value = frm.bagarray.value + e.value + ",0000,1|";
            }
        }
        if ((e.type == "select-one") && (frm.elements[i-3].type == "checkbox") && (frm.elements[i-3].checked==true)) {
            // 옵션이 있는 경우
            if (e.selectedIndex == 0) { alert("옵션을 선택하세요."); e.focus(); return; }
            if (e[e.selectedIndex].id == "S") { alert("품절된 옵션은 구매하실 수 없습니다."); return; }
            frm.bagarray.value = frm.bagarray.value + frm.elements[i - 3].value + "," + e[e.selectedIndex].value + ",1|";
        }

    }

    if (frm.bagarray.value == "") {
        alert("선택된 상품이 없습니다.");
        return;
    }

    if (confirm("선택하신 상품을 장바구니에 추가하시겠습니까?") == true) {
        frmBaguni.mode.value = "arr";
        frmBaguni.bagarr.value = frm.bagarray.value;
        frmBaguni.action = "/inipay/shoppingbag_process.asp";
        
        frmBaguni.submit();
    }
}

// 품절상품 보기 여부 변경
function swViewSoldout(sw) {
	var frm = document.frmsearch;
	frm.action="openWishList.asp";
	frm.page.value=1;
	frm.sscp.value=sw;
	frm.submit();
}

$(function(){
	$("#selectAll").click(function(){
		$(".myWishList input[name='itemid']").prop("checked",$(this).prop("checked"));
	});
});
</script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="openWish">
				<div class="myWishWrap">
					<h2><img src="http://fiximage.10x10.co.kr/web2013/my10x10/my_open_wish.jpg" alt="MY OPEN WISH 아직도 내가 좋아하는 것들을 모르겠어? 콕 찝어 알려줄게~ 내가 갖고 싶은건 바로 이거야" /></h2>
					<div class="titleArea">
						<h4><%=username%>님의 공개위시에 <strong class="crRed">총 <%=myfavorite.FTotalCount%>개</strong>의 상품이 있습니다.</h4>
						<div class="option">
							<a href="" class="btn btnS2 btnRed" onclick="Add2Shoppingbag(document.SubmitFrm);return false;"><span class="fn">장바구니 담기</span></a>
						</div>
					</div>

					<div class="favorOption">
					<form name="frmsearch" method="get" action="openWishList.asp">
					<input type="hidden" name="fid" value="<%=fid%>">
					<input type="hidden" name="page" value="1">
					<input type="hidden" name="sscp" value="<%=SellScope%>">
					<input type="hidden" name="disp" value="<%=vDisp%>">
					<input type="hidden" name="psz" value="<%=pagesize%>">
						<div class="ftLt">
							<span class="bulletNone">
								<input type="checkbox" class="check" id="selectAll" />
								<label for="selectAll">전체선택</label>
							</span>
						</div>
						<div class="ftRt">
							<a href="" onclick="swViewSoldout('<%=chkIIF(SellScope="Y","N","Y")%>');return false;" class="btn btnS2 btnGry2 rMar05"><span class="fn"><%=chkIIF(SellScope="Y","품절상품 포함보기","품절상품 제외보기")%></span></a>
							<select onChange="SwapCate(this.value);" title="카테고리 선택" class="optSelect2" style="width:123px;">
							<%=CategorySelectBoxOption(vDisp)%>
							</select>

							<select name="orderType" onchange="orderitem();" class="optSelect2 lMar05" style="width:113px;" title="정렬방식 선택">
								<option value="recent" <% if orderType="" or orderType="recent" then response.write "selected" %>>최근담은순</option>
								<option value="new" <% if orderType="new" then response.write "selected" %>>신상품순</option>
								<option value="fav" <% if orderType="fav" then response.write "selected" %>>베스트상품순</option>
								<option value="highprice" <% if orderType="highprice" then response.write "selected" %>>높은가격순</option>
								<option value="lowprice" <% if orderType="lowprice" then response.write "selected" %>>낮은가격순</option>
							</select>
						</div>
					</form>
					</div>

					<!-- 리스트 -->
					<div class="pdtWrap pdt150V15">
					<form name="SubmitFrm" method="post" action="" onsubmit="return false;" >
					<input type="hidden" name="mode" value="">
					<input type="hidden" name="bagarray" value="">
					<input type="hidden" name="fid" value="<%=fid%>">
					<input type="hidden" name="disp" value="<%=vDisp%>">
					<input type="hidden" name="page" value="<%=page%>">
					<% If (myfavorite.FResultCount < 1) Then %>
						<div class="noData" style="text-align:center;padding:100px 0;">
							<p><strong><%=chkIIF(vDisp="","등록된 상품이 없습니다.","조건에 맞는 상품이 없습니다.")%></strong></p>
							<a href="/my10x10/popularwish.asp" class="btnView"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/btn_view_wish.gif" alt="인기 위시 보러가기" /></a>
						</div>
					<% else %>
						<ul class="pdtList myWishList">
						<% for ix = 0 to myfavorite.FResultCount-1 %>
							<li <%=chkiif(myfavorite.FItemList(ix).IsSoldOut,"class=""soldOut""","")%>>
								<input type="checkbox" name="itemid" value="<%= myfavorite.FItemList(ix).FItemID %>" class="check" />
								<div class="pdtBox">
									<div class="pdtPhoto">
										<a href="/shopping/category_prd.asp?itemid=<%= myfavorite.FItemList(ix).FItemID %>">
											<span class="soldOutMask"></span>
											<img src="<% = myfavorite.FItemList(ix).FImageIcon2 %>" alt="<%= Replace(myfavorite.FItemList(ix).FItemName,"""","") %>" />
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= myfavorite.FItemList(ix).FMakerid %>"><%= myfavorite.FItemList(ix).FBrandName %></a></p>
										<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= myfavorite.FItemList(ix).FItemID %>"><%= myfavorite.FItemList(ix).FItemName %></a></p>
										<% if myfavorite.FItemList(ix).IsSaleItem or myfavorite.FItemList(ix).isCouponItem Then %>
											<% IF myfavorite.FItemList(ix).IsSaleItem then %>
											<p class="pdtPrice"><span class="txtML"><%=FormatNumber(myfavorite.FItemList(ix).getOrgPrice,0)%>원</span></p>
											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myfavorite.FItemList(ix).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=myfavorite.FItemList(ix).getSalePro%>]</strong></p>
											<% End If %>
											<% IF myfavorite.FItemList(ix).IsCouponItem Then %>
												<% if Not(myfavorite.FItemList(ix).IsFreeBeasongCoupon() or myfavorite.FItemList(ix).IsSaleItem) Then %>
											<p class="pdtPrice"><span class="txtML"><%=FormatNumber(myfavorite.FItemList(ix).getOrgPrice,0)%>원</span></p>
												<% end If %>
											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myfavorite.FItemList(ix).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=myfavorite.FItemList(ix).GetCouponDiscountStr%>]</strong></p>
											<% End If %>
										<% Else %>
											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myfavorite.FItemList(ix).getRealPrice,0) & chkIIF(myfavorite.FItemList(ix).IsMileShopitem,"Point","원")%></span></p>
										<% End If %>
										<p class="pdtStTag tPad05">
											<% IF myfavorite.FItemList(ix).isSoldOut Then %>
												<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
											<% else %>
												<% IF myfavorite.FItemList(ix).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /><% end if %>
												<% IF myfavorite.FItemList(ix).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /><% end if %>
												<% IF myfavorite.FItemList(ix).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /><% end if %>
												<% IF myfavorite.FItemList(ix).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /><% end if %>
												<% IF myfavorite.FItemList(ix).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /><% end if %>
												<% IF myfavorite.FItemList(ix).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /><% end if %>
											<% end if %>
										</p>
									</div>
									<p class="wishOpt">
										<input type="hidden" name="itemoption" value="">
										<% if (myfavorite.FItemList(ix).IsSoldOut) then %>
										<input type="hidden" name="itemea" value="0">
										<% else %>
										<input type="hidden" name="itemea" value="1">
										<% end if %>
										<%
											optionBoxHtml = ""
											''품절시 제외.
											If (myfavorite.FItemList(ix).IsItemOptionExists) and (Not myfavorite.FItemList(ix).IsSoldOut) then
												if (myfavorite.FItemList(ix).Fdeliverytype="6") then ''현장수령 한정표시 안함.
													optionBoxHtml = getOneTypeOptionBoxDpLimitHtml(myfavorite.FItemList(ix).FItemID,myfavorite.FItemList(ix).IsSoldOut,"class=""optSelect2"" style=""width:100%;""",false)
												else
													optionBoxHtml = getOneTypeOptionBoxHtml(myfavorite.FItemList(ix).FItemID,myfavorite.FItemList(ix).IsSoldOut,"class=""optSelect2"" style=""width:100%;""")
												end if
											End If

											response.write optionBoxHtml
										%>
									</p>
									<ul class="pdtActionV15">
										<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=myfavorite.FItemList(ix).FItemid %>');return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
										<li class="postView"><a href="" <%=chkIIF(myfavorite.FItemList(ix).FEvalCnt>0,"onclick=""popEvaluate('" & myfavorite.FItemList(ix).FItemid & "');return false;""","onclick=""return false;""")%>><span><%=formatNumber(myfavorite.FItemList(ix).FEvalCnt,0)%></span></a></li>
										<li class="wishView" id="wsIco<%=myfavorite.FItemList(ix).FItemid %>"><a href="" onclick="TnAddFavorite('<%=myfavorite.FItemList(ix).FItemid %>');return false;"><span><%=formatNumber(myfavorite.FItemList(ix).FfavCount,0)%></span></a></li>
									</ul>
								</div>
							</li>
						<% next %>
						</ul>
					<% end if %>
					</form>
					</div>
					<!-- //리스트 -->

					<!-- //Paging -->
					<div class="pageWrapV15 tMar20">
						<%= fnDisplayPaging_New(myfavorite.FcurrPage, myfavorite.FtotalCount, myfavorite.FPageSize, 10, "goPage") %>
					</div>

				</div>

				<ul class="note list01">
					<li>로그인 후, 공개 된 상품을 나의 위시에 보관할 수 있습니다.</li>
					<li>MY TENBYTEN &gt; MY 관심목록 &gt; 위시 &gt; 폴더 추가/수정에서 공개 설정이 가능하며, 공개 설정된 위시는 친구들과 공유하실 수 있습니다.</li>
				</ul>

				<div class="membershipAdvantage">
					<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_membership_advantage.gif" alt="텐바이텐의 남다른 회원혜택" /></h3>
					<ul>
						<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_membership_advantage_01.gif" alt="회원등급별 혜택 : 구매할수록 할인혜택은 Up! Up!" /></li>
						<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_membership_advantage_02.gif" alt="다양한 쿠폰 : 쿠폰으로 즐거운 쇼핑!" /></li>
						<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_membership_advantage_03.gif" alt="히치하이커 : 텐바이텐만의 감성매거진" /></li>
						<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_membership_advantage_04.gif" alt="마일리지 적립 : 상품구매, 상품평만 써도!" /></li>
						<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_membership_advantage_05.gif" alt="고객 사은 혜택 : 구매고객을 위한 사은품이 가득" /></li>
						<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_membership_advantage_06.gif" alt="이벤트 참여 : 상품에서 다양한 문화혜택까지" /></li>
						<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_membership_advantage_07.gif" alt="우수회원샵 : 회원등급에 따른 할인 혜택" /></li>
						<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_membership_advantage_08.gif" alt="마일리지샵 : 마일리지로만 살수있는 에디션상품" /></li>
					</ul>
				</div>

				<div class="btnArea tMar30 ct">
					<a href="/member/join.asp" class="btn btnB1 btnRed btnW185">텐바이텐 회원가입하기</a>
				</div>
			</div>
		</div>
	</div>
	<form name="frmBaguni" method="post">
		<input type="hidden" name="mode" value="arr">
		<input type="hidden" name="bagarr" value="">
	</form>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% set myfavorite = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->