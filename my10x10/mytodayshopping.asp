<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 최근 본 상품"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
	strPageDesc = "조금 전 본 상품을 다시 찾아볼수 있습니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 최근 본 상품"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/mytodayshopping.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/db/dbEVTopen.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/todayshoppingcls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
Const MAX_TODAYVIEW_ITEMCOUNT = 40

dim userid, page, vDisp, pagesize, SortMethod, OrderType, vSellYN, iLp
userid      = GetLoginUserID
page        = requestCheckVar(request("page"),9)
vDisp       = requestCheckVar(request("disp"),18)
pagesize    = requestCheckVar(request("pagesize"),9)
SortMethod  = requestCheckVar(request("SortMethod"),10)
OrderType   = requestCheckVar(request("OrderType"),10)
vSellYN		= requestCheckVar(request("sellyn"),1)

if page="" then page=1
if pagesize="" then pagesize="12"


dim myTodayShopping
set myTodayShopping = new CTodayShopping
myTodayShopping.FPageSize        = pagesize
myTodayShopping.FCurrpage        = page
myTodayShopping.FScrollCount     = 10
myTodayShopping.FRectSortMethod  = SortMethod
myTodayShopping.FRectOrderType   = OrderType
myTodayShopping.FRectSellYN		 = vSellYN
myTodayShopping.FRectDisp         = vDisp
myTodayShopping.FRectUserID      = userid

if userid<>"" then
    myTodayShopping.getMyTodayViewListNew
end if


dim i,j, lp,ix
dim Cols, Rows
Cols = 4
Rows = CLng(myTodayShopping.FResultCount \ Cols)

if (myTodayShopping.FResultCount mod Cols>0) then Rows=Rows+1

dim ooption, optionBoxHtml
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript">
$(function(){
	// layer popup
	$('.addInfo').hover(function(){
		$(this).next('.contLyr').toggle();
	});
});

function SwapCate(){
	frmItem.submit();
}

function goOnlySell(){
	frmItem.sellyn.value = "Y";
	frmItem.submit();
}

function goReCookies(){
	var frm = document.SubmitFrm;
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
    else
    {
    	frmCoo.itemid.value = frm.bagarray.value;
    	frmCoo.submit();
    }
}

// 상품목록 리플레시
function chgItemList(sm,cl){
	var frm = document.frmItem;
	frm.action="mytodayshopping.asp";
	frm.SortMethod.value=sm;
	frm.cdL.value=cl;
	frm.submit();
}

// 상품목록 페이지 이동
function goPage(pg){
	var frm = document.frmItem;
	frm.action="mytodayshopping.asp";
	frm.page.value=pg;
	frm.submit();
}

function SelectAll(frm,bool){
    if (frm==undefined) return;

    for (i = 0; i < frm.elements.length; i++) {
        var e = frm.elements[i];
        if ((e.type=='checkbox')&&(!e.disabled)) { e.checked = bool; }
    }
}

function Add2Favorate(frm){
    if (frm.bagarray==undefined) return;
	var dealcheck=false;
    var buf = "";

    frm.bagarray.value = "";
    for (i = 0; i < frm.elements.length; i++) {
		var e = frm.elements[i];

		if ((e.type == 'checkbox') && (e.checked == true)) {
			if(frm.elements[i].value!="0")
			{
				frm.bagarray.value = frm.bagarray.value + frm.elements[i].value + ",";
			}
			if(frm.elements[i].value=="0" && dealcheck==false){
				dealcheck=true;
			}
			if(frm.elements[i].value=="0"){
				frm.elements[i].checked = false;
			}
		}
    }

    if (frm.bagarray.value == "" && dealcheck==false) {
        alert("선택된 상품이 없습니다.");
        return;
	}
	else if (frm.bagarray.value == "" && dealcheck==true) {
		alert("딜상품의 위시는 상품 화면에서만 가능합니다. 확인 버튼을 누르시면 선택에서 제외합니다.");
        return;
    }

	if(dealcheck){
		alert("딜상품의 위시는 상품 화면에서만 가능합니다. 확인 버튼을 누르시면 선택에서 제외합니다.");
	}

    if (confirm("선택된 상품을 위시리스트에 등록 하시겠습니까?") == true) {
        frm.mode.value = "AddFavItems";
        frm.target="FavWin";
        frm.action = "/my10x10/popMyFavorite.asp";
        window.open('' ,'FavWin','width=380,height=300,scrollbars=no,resizable=no');
        frm.submit();
    }
}


function myTodayShoppingDel()
{

	var frm = document.SubmitFrm;
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
    else
    {
    	$("#Ditemid").val(frm.bagarray.value);
		$.ajax({
			type:"GET",
			url:"act_mytodayshopping.asp",
			data: $("#frmDelMTS").serialize(),
			dataType: "text",
			async:false,
			cache:true,
			success : function(Data, textStatus, jqXHR){
					//$str = $(Data);
					//res = Data.split("||");
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								if (Data=="ok")
								{
									document.location.reload();
								}

							} else {
								//alert("상품이 없습니다.");
							}
						}
					}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("잘못된 접근 입니다.");
				//var str;
				//for(var i in jqXHR)
				//{
				//	 if(jqXHR.hasOwnProperty(i))
				//	{
				//		str += jqXHR[i];
				//	}
				//}
				//alert(str);
				//document.location.reload();
				return false;
			}
		});

    }
}


function Add2Shoppingbag(frm){
    var frmBaguni = document.frmBaguni;

    if (frm.bagarray==undefined) return;

    var buf = "";
	var dealcheck=false;

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
            if ((frm.elements.length > (i+3)) && (frm.elements[i + 3].type != 'select-one') && (frm.elements[i].value!="0")) {
                    frm.bagarray.value = frm.bagarray.value + e.value + ",0000,1|";
            } else if (frm.elements.length <= (i+3)) {
                    frm.bagarray.value = frm.bagarray.value + e.value + ",0000,1|";
            }
			if(frm.elements[i].value=="0" && dealcheck==false){
				dealcheck=true;
			}
			if(frm.elements[i].value=="0"){
				frm.elements[i].checked = false;
			}
        }
        if ((e.type == "select-one") && (frm.elements[i-3].type == "checkbox") && (frm.elements[i-3].checked==true) && (frm.elements[i].value!="0")) {
            // 옵션이 있는 경우
            if (e.selectedIndex == 0) { alert("옵션을 선택하세요."); e.focus(); return; }
            if (e[e.selectedIndex].id == "S") { alert("품절된 옵션은 구매하실 수 없습니다."); return; }
            frm.bagarray.value = frm.bagarray.value + frm.elements[i - 3].value + "," + e[e.selectedIndex].value + ",1|";
			if(frm.elements[i].value=="0" && dealcheck==false){
				dealcheck=true;
			}
			if(frm.elements[i].value=="0"){
				frm.elements[i].checked = false;
			}
		}
    }

    if (frm.bagarray.value == "" && dealcheck==false) {
        alert("선택된 상품이 없습니다.");
        return;
	}
	else if (frm.bagarray.value == "" && dealcheck==true) {
		alert("딜상품의 장바구니 담기는 상품 화면에서만 가능합니다. 확인 버튼을 누르시면 선택에서 제외합니다.");
        return;
    }

	if(dealcheck){
		alert("딜상품의 장바구니 담기는 상품 화면에서만 가능합니다. 확인 버튼을 누르시면 선택에서 제외합니다.");
	}

    if (confirm("선택하신 상품을 장바구니에 추가하시겠습니까?") == true) {
        frmBaguni.mode.value = "arr";
        frmBaguni.bagarr.value = frm.bagarray.value;
        frmBaguni.action = "/inipay/shoppingbag_process.asp";

        frmBaguni.submit();
    }
}
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
	<form name="frmBaguni" method="post">
	<input type="hidden" name="mode" value="arr">
	<input type="hidden" name="bagarr" value="">
	</form>
	<form name="frmCoo" method="post" action="mytoday_recookies.asp" target="iframerecookies">
	<input type="hidden" name="itemid" value="">
	</form>
	<form name="frmDelMTS" id="frmDelMTS" method="post">
		<input type="hidden" name="Ditemid" id="Ditemid" value="">
		<input type="hidden" name="Duserid" id="Duserid" value="<%=tenEnc(getEncLoginUserId)%>">
	</form>
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_recently_item.png" alt="최근 본 상품" /></h3>
						<ul class="list">
							<li>고객님께서 최근 보신 상품을 모아둔 곳입니다.</li>
							<li>최근 본 상품 내역은 15일간 보관되며, 내역 삭제 시 복구되지 않으므로 유의해주시길 바랍니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<div class="myWishWrap">
							<div class="titleArea">
								<div class="option">
									<a href="javascript:Add2Favorate(document.SubmitFrm)" class="btn btnS2 btnWhite btnW90 rMar05"><span class="fn btnWish">위시 담기</span></a>
									<a href="javascript:Add2Shoppingbag(document.SubmitFrm)" class="btn btnS2 btnRed"><span class="fn">장바구니 담기</span></a>
								</div>
							</div>

							<form name="frmItem" method="get" onsubmit="return;" action="">
							<input type="hidden" name="page" value="">
							<input type="hidden" name="sellyn" value="<%=vSellYN%>">
							<div class="favorOption">
								<div class="ftLt">
									<span>
										<input type="checkbox" class="check" name="checkbox" id="checkbox" onclick="SelectAll(SubmitFrm,this.checked);" />
										<label for="selectAll">전체선택</label>
									</span>
									<!--a href="javascript:goReCookies();" class="btn btnS2 btnGrylight fn">삭제</a-->
									<a href="" onclick="myTodayShoppingDel();return false;" class="btn btnS2 btnGrylight fn">삭제</a>
								</div>
								<div class="ftRt">
									<a href="javascript:goOnlySell();" class="btn btnS2 btnGry2 rMar05"><span class="fn">품절상품 제외보기</span></a>
									<select title="카테고리 선택" class="optSelect2" style="width:123px;" name="disp" onChange="SwapCate();">
										<%=CategorySelectBoxOption(vDisp)%>
									</select>

									<!--select title="정렬방식 선택" class="optSelect2 lMar05" style="width:113px;" name="ordertype" onchange="this.form.submit();">
										<option value="new" <% if orderType="new" then response.write "selected" %>>신상품순</option>
										<option value="fav" <% if orderType="fav" then response.write "selected" %>>베스트상품순</option>
										<option value="highprice" <% if orderType="highprice" then response.write "selected" %>>높은가격순</option>
										<option value="lowprice" <% if orderType="lowprice" then response.write "selected" %>>낮은가격순</option>
									</select-->
								</div>
							</div>
							</form>

							<!-- 리스트 -->
							<div class="pdtWrap pdt150V15">
							<form name="SubmitFrm" method="post" action="" onsubmit="return false;" >
							<input type="hidden" name="mode" value="arr">
							<input type="hidden" name="bagarray" value="">
							<input type="hidden" name="sitename" value="10x10">
								<ul class="pdtList myWishList">
								<% If (myTodayShopping.FResultCount < 1) Then %>
								<% else
									for i = 0 to myTodayShopping.FResultCount-1
								%>
									<% If myTodayShopping.FItemList(i).FItemDiv="21" Then %>
									<li class="deal-item">
									<% Else %>
									<li <%=chkiif(myTodayShopping.FItemList(i).isSoldOut,"class=""soldOut""","")%>>
									<% End If %>
										<% If myTodayShopping.FItemList(i).FItemDiv="21" Then %>
										<input type="checkbox" class="check" name="itemid" value="<%= myTodayShopping.FItemList(i).FItemID %>" />
										<div class="pdtBox">
											<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
											<div class="pdtPhoto">
												<a href="/deal/deal.asp?itemid=<%= myTodayShopping.FItemList(i).FItemID %>">
													<span class="soldOutMask"></span>
													<img src="<%=getThumbImgFromURL(myTodayShopping.FItemList(i).FImageIcon2,"150","150","true","false")%>" alt="<%= Replace(myTodayShopping.FItemList(i).FItemName,"""","") %>" />
												</a>
											</div>
											<div class="pdtInfo">
												<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= myTodayShopping.FItemList(i).FMakerid %>"><%= myTodayShopping.FItemList(i).FBrandName %></a></p>
												<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%= myTodayShopping.FItemList(i).FItemID %>"><%= myTodayShopping.FItemList(i).FItemName %></a></p>
												<% IF myTodayShopping.FItemList(i).FOptioncnt="" Or myTodayShopping.FItemList(i).FOptioncnt="0" then %>
													<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myTodayShopping.FItemList(i).getRealPrice,0) & chkIIF(myTodayShopping.FItemList(i).IsMileShopitem,"Point","원")%>~</span></p>
												<% Else %>
													<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myTodayShopping.FItemList(i).getRealPrice,0)%>원~</span> <strong class="cRd0V15">[<%=myTodayShopping.FItemList(i).FOptioncnt%>%]</strong></p>
												<% End If %>
												<p class="pdtStTag tPad05">
													<input type="hidden" name="itemoption" value="">
													<% if (myTodayShopping.FItemList(i).IsSoldOut) then %>
													<input type="hidden" name="itemea" value="0">
													<% else %>
													<input type="hidden" name="itemea" value="1">
													<% end if %>
													<% IF myTodayShopping.FItemList(i).isSoldOut Then %>
														<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
													<% else %>
														<% IF myTodayShopping.FItemList(i).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /><% end if %>
														<% IF not(myTodayShopping.FItemList(i).FOptioncnt="" Or myTodayShopping.FItemList(i).FOptioncnt="0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /><% end if %>
														<!-- <% IF myTodayShopping.FItemList(i).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /><% end if %>-->
														<% IF myTodayShopping.FItemList(i).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /><% end if %>
													<% end if %>
												</p>
											</div>
										</div>
										<% Else %>
										<input type="checkbox" class="check" name="itemid" value="<%= myTodayShopping.FItemList(i).FItemID %>" />
										<div class="pdtBox">
											<div class="pdtPhoto">
												<a href="/shopping/category_prd.asp?itemid=<%= myTodayShopping.FItemList(i).FItemID %>">
													<span class="soldOutMask"></span>
													<img src="<%=getThumbImgFromURL(myTodayShopping.FItemList(i).FImageIcon2,"150","150","true","false")%>" alt="<%= Replace(myTodayShopping.FItemList(i).FItemName,"""","") %>" />
												</a>
											</div>
											<div class="pdtInfo">
												<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= myTodayShopping.FItemList(i).FMakerid %>"><%= myTodayShopping.FItemList(i).FBrandName %></a></p>
												<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= myTodayShopping.FItemList(i).FItemID %>"><%= myTodayShopping.FItemList(i).FItemName %></a></p>
												<% if myTodayShopping.FItemList(i).IsSaleItem or myTodayShopping.FItemList(i).isCouponItem Then %>
													<% IF myTodayShopping.FItemList(i).IsSaleItem then %>
													<p class="pdtPrice"><span class="txtML"><%=FormatNumber(myTodayShopping.FItemList(i).getOrgPrice,0)%>원</span></p>
													<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myTodayShopping.FItemList(i).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=myTodayShopping.FItemList(i).getSalePro%>]</strong></p>
													<% End If %>
													<% IF myTodayShopping.FItemList(i).IsCouponItem Then %>
														<% if Not(myTodayShopping.FItemList(i).IsFreeBeasongCoupon() or myTodayShopping.FItemList(i).IsSaleItem) Then %>
													<p class="pdtPrice"><span class="txtML"><%=FormatNumber(myTodayShopping.FItemList(i).getOrgPrice,0)%>원</span></p>
														<% end If %>
													<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myTodayShopping.FItemList(i).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=myTodayShopping.FItemList(i).GetCouponDiscountStr%>]</strong></p>
													<% End If %>
												<% Else %>
													<p class="pdtPrice"><span class="finalP"><%=FormatNumber(myTodayShopping.FItemList(i).getRealPrice,0) & chkIIF(myTodayShopping.FItemList(i).IsMileShopitem,"Point","원")%></span></p>
												<% End If %>
												<p class="pdtStTag tPad05">
													<input type="hidden" name="itemoption" value="">
													<% if (myTodayShopping.FItemList(i).IsSoldOut) then %>
													<input type="hidden" name="itemea" value="0">
													<% else %>
													<input type="hidden" name="itemea" value="1">
													<% end if %>
													<% IF myTodayShopping.FItemList(i).isSoldOut Then %>
														<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
													<% else %>
														<% IF myTodayShopping.FItemList(i).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /><% end if %>
														<% IF myTodayShopping.FItemList(i).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /><% end if %>
														<% IF myTodayShopping.FItemList(i).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /><% end if %>
														<% IF myTodayShopping.FItemList(i).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /><% end if %>
														<% IF myTodayShopping.FItemList(i).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /><% end if %>
														<% IF myTodayShopping.FItemList(i).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /><% end if %>
													<% end if %>
												</p>

											</div>
											<p class="wishOpt">
												<%
													optionBoxHtml = ""
													''품절시 제외.
													If (myTodayShopping.FItemList(i).IsItemOptionExists) and (Not myTodayShopping.FItemList(i).IsSoldOut) then
														if (myTodayShopping.FItemList(i).Fdeliverytype="6") then ''현장수령 한정표시 안함.
															optionBoxHtml = getOneTypeOptionBoxDpLimitHtml(myTodayShopping.FItemList(i).FItemID,myTodayShopping.FItemList(i).IsSoldOut,"class=""optSelect2"" style=""width:100%;""",false)
														else
															optionBoxHtml = getOneTypeOptionBoxHtml(myTodayShopping.FItemList(i).FItemID,myTodayShopping.FItemList(i).IsSoldOut,"class=""optSelect2"" style=""width:100%;""")
														end if
													End If

													response.write optionBoxHtml
												%>
											</p>
											<ul class="pdtActionV15">
												<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=myTodayShopping.FItemList(i).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
												<li class="postView"><a href="" <%=chkIIF(myTodayShopping.FItemList(i).Fevalcnt>0,"onclick=""popEvaluate('" & myTodayShopping.FItemList(i).FItemid & "');return false;""","onclick=""return false;""")%>><span><%=FormatNumber(myTodayShopping.FItemList(i).Fevalcnt,0)%></span></a></li>
												<li class="wishView"><a href="" onclick="TnAddFavorite('<%=myTodayShopping.FItemList(i).FItemid %>');return false;"><span><%=FormatNumber(myTodayShopping.FItemList(i).FfavCount,0)%></span></a></li>
											</ul>
										</div>
										<% End If %>
									</li>
								<% next
								end if
								%>
								</ul>
							</form>
							</div>
							<div class="pageWrapV15 tMar20">
							<%= fnDisplayPaging_New_nottextboxdirect(myTodayShopping.FcurrPage, myTodayShopping.FtotalCount, myTodayShopping.FPageSize, 5, "goPage") %>
							</div>
						</div>
					</form>
					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<iframe name="iframerecookies" src="" width="0" height="0"></iframe>
</body>
</html>
<%
set myTodayShopping = Nothing
%>
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->