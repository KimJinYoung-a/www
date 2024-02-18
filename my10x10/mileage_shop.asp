<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_mileageshopitemcls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<%
	'//for Developers
	'//commlib.asp, tenEncUtil.asp는 head.asp에 포함되어있으므로 페이지내에 넣지 않도록 합시다.

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 마일리지 샵"		'페이지 타이틀 (필수)
	strPageDesc = "마이텐바이텐 - 마일리지샵"		'페이지 설명
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'// 마일리지 샵 상품
dim oMileageShop
dim userid
 userid      = getEncLoginUserID

set oMileageShop = new CMileageShop
oMileageShop.FPageSize=30

oMileageShop.GetMileageShopItemList

dim i

dim availtotalMile,oMileage
availtotalMile = 0

'// 마일리지 정보
set oMileage = new TenPoint
oMileage.FRectUserID = userid
if (userid<>"") then
    oMileage.getTotalMileage
    availtotalMile = oMileage.FTotalMileage
end if

if availtotalMile<1 then availtotalMile=0
%>
<script>
	//마일리지샵 상품 추가
	function AddMileItem(mfrm){
		var frm = document.frmBaguni;
		var iitemoption
		if(mfrm.item_option) {
			iitemoption = mfrm.item_option.value;
		} else {
			iitemoption = "0000";
		}

		if(iitemoption=="") {
			alert("옵션을 선택해주세요.");
			return;
		}

		frm.mode.value      = "add";
		frm.itemid.value    =mfrm.itemid.value;
		frm.itemoption.value =iitemoption;
		frm.itemea.value    =1;
		frm.submit();
	}
</script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
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
				<div class="myContent">
					<div class="titleSection subTitle">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_mileage_shop.gif" alt="마일리지샵" /></h3>
						<h4><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_mileage_shop_add.gif" alt="MILEAGE SHOP 텐바이텐의 또 다른 선물, 마일리지샵" /></h4>
						<ul class="list bulletDot">
							<li>마일리지샵 상품은 텐바이텐 배송 상품과 함께 구매하셔야 하며, 한 상품당 하나씩만 구매하실 수 있습니다.</li>
						</ul>
						<div class="ico"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_mileage_shop.gif" alt="" /></div>
					</div>

					<div class="mySection">
						<div class="myWishWrap">
							<!-- 리스트 -->
							<div class="pdtWrap pdt150V15">
								<ul class="pdtList mileageShop">
									<%if (oMileageShop.FResultCount>0) then%>
									<% for i=0 to oMileageShop.FResultCount-1 %>
									<li <%=chkiif(omileageshop.FItemList(i).IsSoldOut,"class=""soldOut""","")%>>
										<form name="mFrm<%=i+1%>" style="margin:0px;">
										<input type="hidden" name="itemid" value="<%= omileageshop.FItemList(i).FItemID %>" />
										<div class="pdtBox">
											<div class="pdtPhoto">
												<a href="" onclick="TnGotoProduct('<%= omileageshop.FItemList(i).FItemID %>'); return false;">
													<span class="soldOutMask"></span>
													<img src="<%=getThumbImgFromURL(omileageshop.FItemList(i).FIcon1Image,"150","150","true","false")%>" alt="<%= Replace(Replace(oMileageShop.FItemList(i).FItemName,"[마일리지샵]",""),"[마일리지샵]","") %>" />
												</a>
											</div>
											<div class="pdtInfo">
												<p class="pdtName tPad07"><a href="" onclick="TnGotoProduct('<%= omileageshop.FItemList(i).FItemID %>'); return false;"><%= Replace(Replace(oMileageShop.FItemList(i).FItemName,"[마일리지샵]",""),"[마일리지샵]","") %></a></p>
												<p class="pdtPrice"><span class="finalP"><%= FormatNumber(oMileageShop.FItemList(i).getMileageCash,0) %> Point</span></p>
											</div>
											<p class="wishOpt">
												<%
													dim optionBoxHtml
													optionBoxHtml = ""
													''품절시 제외.
													If (omileageshop.FItemList(i).IsItemOptionExists) and (Not omileageshop.FItemList(i).IsSoldOut) then
														optionBoxHtml = getOneTypeOptionBoxHtml(omileageshop.FItemList(i).FItemID,omileageshop.FItemList(i).IsSoldOut,"class=""optSelect2"" title=""옵션을 선택해주세요"" style=""width:100%;""")
													End If

													response.write optionBoxHtml
												%>
											</p>
											<% if omileageshop.FItemList(i).IsSoldOut then %>
											<div class="cartBtn">
												<img src="http://fiximage.10x10.co.kr/web2008/shoppingbag/soldout_sbasket02.gif" width="100" height="29" border="0">
											</div>
											<% elseif (availtotalMile<omileageshop.FItemList(i).getMileageCash) then %>
											<div class="cartBtn">
												<a href="#" onclick="alert('마일리지샵 상품을 구매하실 수 있는 마일리지가 부족합니다. 현재 마일리지 : <%= formatnumber(availtotalMile,0) %>'); return false;" class="btn btnM2 btnWhite btnW150">장바구니</a>
											</div>
											<% else %>
											<div class="cartBtn">
												<a href="#" onclick="AddMileItem(document.mFrm<%=i+1%>); return false;" class="btn btnM2 btnWhite btnW150" title="장바구니에 담고 장바구니 페이지로 이동하기">장바구니</a>
											</div>
											<% end if %>
											<ul class="pdtActionV15">
												<li class="largeView"><a href="" onclick="ZoomItemInfo('<%= omileageshop.FItemList(i).FItemID %>');return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
												<li class="postView"><a href="" onclick="popEvaluate('<%= omileageshop.FItemList(i).FItemID %>');return false;"><span><%= FormatNumber(omileageshop.FItemList(i).Fevalcnt,0) %></span></a></li>
												<li class="wishView"><a href="" onclick="TnAddFavorite('<% = omileageshop.FItemList(i).FItemID%>');"><span><%= FormatNumber(omileageshop.FItemList(i).FFavCount,0) %></span></a></li>
											</ul>
										</div>
										</form>
									</li>
									<% next %>
									<% Else %>
									<li><div class="pdtBox">등록된 내역이 없습니다.</div></li>
									<% End If %>
								</ul>
							</div>
							<!-- //리스트 -->
							<!-- <div class="paging tMar30">
								<a href="" class="first arrow"><span>맨 처음 페이2013-08-22지로 이동</span></a>
								<a href="" class="prev arrow"><span>이전페이지로 이동</span></a>
								<a href=""><span>1</span></a>
								<a href=""><span>2</span></a>
								<a href=""><span>3</span></a>
								<a href="" class="current"><span>4</span></a>
								<a href=""><span>5</span></a>
								<a href=""><span>6</span></a>
								<a href=""><span>7</span></a>
								<a href=""><span>8</span></a>
								<a href=""><span>9</span></a>
								<a href=""><span>10</span></a>
								<a href="" class="next arrow"><span>다음 페이지로 이동</span></a>
								<a href="" class="end arrow"><span>맨 마지막 페이지로 이동</span></a>
							</div> -->
						</div>
					</div>
				</div>
				<!--// content -->
				<form name="frmBaguni" method="post" action="/inipay/shoppingbag_process.asp" onsubmit="return false;" style="margin:0px;">
				<input type="hidden" name="mode" value="">
				<input type="hidden" name="sitename" value="10x10">
				<input type="hidden" name="itemid" value="">
				<input type="hidden" name="itemoption" value="">
				<input type="hidden" name="itemea" value="">
				</form>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
set oMileage = Nothing
set oMileageShop = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
