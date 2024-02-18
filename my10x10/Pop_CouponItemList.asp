<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_itemcouponcls.asp"-->
<!-- #include virtual="/lib/classes/enjoy/couponshopcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 쿠폰적용 상품보기"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim itemcouponidx
dim ocouponitemlist
dim page, makerid,sailyn
dim ctab
dim vDisp : vDisp = getNumeric(requestCheckVar(request("disp"),15))
itemcouponidx = getNumeric(RequestCheckVar(Request("itemcouponidx"),8))
makerid = RequestCheckVar(request("makerid"),32)
page = getNumeric(RequestCheckVar(request("page"),8))
sailyn = RequestCheckVar(request("sailyn"),1)
ctab = RequestCheckVar(request("tab"),2)

if itemcouponidx="" then itemcouponidx=0
if page="" then page=1


set ocouponitemlist = new CItemCouponMaster
ocouponitemlist.FPageSize=20
ocouponitemlist.FCurrPage=page
ocouponitemlist.FRectItemCouponIdx = itemcouponidx
ocouponitemlist.FRectCateCode		= vDisp
ocouponitemlist.GetItemCouponItemListCaChe
''ocouponitemlist.GetItemCouponItemList

dim i, lp

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>
function changeCate(a){
	document.frm.page.value = 1;
	document.frm.disp.value = a;
	document.frm.submit();
}

<%
	If ocouponitemlist.FTotalCount = 0 Then
%>
		alert('적용가능한 상품이 없습니다.');
		window.close();
		</script>
<%
		dbget.close()
		Response.End
	End If
%>

function goPage(page){
	frm.page.value=page;
	frm.disp.value ="<%=vDisp%>";
	frm.submit();
}

function TnGotoProduct(itemid){
    opener.TnGotoProduct(itemid);
}
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_coupon_product_list.gif" alt="쿠폰 적용상품 보기" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<!-- 쿠폰 -->
				<% if (ocouponitemlist.FResultCount>0) then %>
				<div class="coupArea">
					<div class="couponBox sizeTye01">
						<div class="box">
							<div class="title">
								<span class="tag green">
									<% IF ocouponitemlist.FItemList(0).Fitemcoupontype = 3 THEN	'쿠폰타입(무료배송) %>
										<img src='http://fiximage.10x10.co.kr/web2013/common/cp_green_freeship.png' alt='무료배송' />
									<% ELSE %>
										<%=FnCouponValueView("prd",CLng(ocouponitemlist.FItemList(0).Fitemcouponvalue),ocouponitemlist.FItemList(0).Fitemcoupontype)%>
									<% END IF %>
								</span>
							</div>
							<div class="account">
								<ul>
									<li class="name"><%=ocouponitemlist.FItemList(0).Fitemcouponname%></li>
									<li class="date"><%=formatDate(ocouponitemlist.FItemList(0).Fitemcouponstartdate,"0000.00.00")%>~<%=Left(formatDate(ocouponitemlist.FItemList(0).Fitemcouponenddate,"0000.00.00 00:00:00"),16)%> 까지</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<% end if %>
				<!-- //쿠폰 -->

				<div class="productList">
					<div class="overHidden">
						<h2 class="ftLt">쿠폰적용상품 : <strong><%= ocouponitemlist.FTotalCount %></strong>개</h2>
						<div class="ftRt tPad15">
							<%
								'정렬상자 호출; sDisp:전시카테고리, sType:확장여부, sCallback:콜백함수명 (via functions.asp)
								''Call fnPrntDispCateNaviV17CouponList(vDisp,"F","changeCate", itemcouponidx)
								Call fnPrntDispCateNaviV17CouponListCaChe(vDisp,"F","changeCate", itemcouponidx)
							%>
						</div>
					</div>

					<table class="baseTable">
					<colgroup>
						<col width="90" /> <col width="70" /> <col width="*" /> <col width="90" /> <col width="90" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col">상품코드</th>
						<th colspan="2" scope="col">상품명</th>
						<th scope="col">판매가</th>
						<th scope="col">쿠폰적용가</th>
					</tr>
					</thead>
					<tbody>
					<%	if ocouponitemlist.FResultCount > 0 then %>
						<% for i=0 to ocouponitemlist.FResultCount - 1 %>
							<tr>
								<td><%= ocouponitemlist.FitemList(i).FItemID %></td>
								<td><a href="/shopping/category_prd.asp?itemid=<%= ocouponitemlist.FitemList(i).FItemID %>" target="_blank" title="상품페이지 보기"><img src="<%= ocouponitemlist.FitemList(i).FSmallimage %>" width="50" height="50" alt="<%= ocouponitemlist.FitemList(i).FItemName %>" /></a></td>
								<td class="lt">
									<div><a href="/street/street_brand.asp?makerid=<%= ocouponitemlist.FitemList(i).FMakerid %>" target="_blank" title="브랜드샵 열기">[<%= ocouponitemlist.FitemList(i).FMakerid %>]</a></div>
									<div><a href="/shopping/category_prd.asp?itemid=<%= ocouponitemlist.FitemList(i).FItemID %>" target="_blank" title="상품페이지 보기"><%= ocouponitemlist.FitemList(i).FItemName %></a></div>
								</td>
								<td><%= FormatNumber(ocouponitemlist.FitemList(i).FSellcash,0) %>원</td>
								<td><strong class="crGrn"><%= FormatNumber(ocouponitemlist.FitemList(i).GetCouponSellcash,0) %>원</strong></td>
							</tr>
						<% next %>
					<% else %>
						<tr>
							<td colspan="5">적용가능한 상품이 없습니다</td>
						</tr>
					<% end if %>
					</tbody>
					</table>

					<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(page,ocouponitemlist.FTotalCount,20,10,"goPage") %></div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>

	<form name="frm" method="get" id="frm" action="">
		<input type="hidden" name="page" value="">
		<input type="hidden" name="itemcouponidx" value="<%= itemcouponidx %>">
		<input type="hidden" name="disp" value="<%= vDisp%>">
	</form>

</body>
</html>
<%

set ocouponitemlist = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
