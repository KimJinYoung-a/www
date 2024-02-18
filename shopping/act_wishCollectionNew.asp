<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<!-- #include virtual="/lib/db/dbAppWishopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/JSON2.asp" -->


<%
	dim oWishColItem, chkHT, itemid, catecode, rcpUid, vPrdList, vMtdList, mtv, tmpArr
	dim lp, vIid, vMtd(), vLnk(), IValue
	ReDim vMtd(4), vLnk(4)

	itemid = requestCheckVar(request("itemid"),9)	'상품코드

	'//클래스 선언
	set oWishColItem = New CAutoCategory
	oWishColItem.FRectItemId = itemid

	'// 텐바이텐 위시콜렉션 목록
	oWishColItem.GetTogetherWishCollection

	if oWishColItem.FResultCount>0 Then
%>
<% If oWishColItem.FResultCount >= 3 Then %>
<div class="pdtListBoxV17a" id="detail07">
	<div class="titWrap">
		<h3 class="ftLt"><img src="http://fiximage.10x10.co.kr/web2017/shopping/tab_youlikeit.png" alt="MAYBE YOU LIKE IT!" /></h3>
		<span class="ftLt">이 상품을 위시한 다른 고객님들의 위시 상품</span>
	</div>
	<div class="itemContainerV17a">
		<div id="rcmdPrd01" class="itemContV15">
			<ul class="pdtList">
			<%	For lp = 0 To oWishColItem.FResultCount - 1 %>
			<% if lp>9 then Exit For %>
				<li>
					<p class="pdtPhoto">
						<a href="/shopping/category_prd.asp?itemid=<%= oWishColItem.FItemList(lp).Fitemid %>&rc=item_wish_<%=lp+1%>"><img src="<%=oWishColItem.FItemList(lp).FIcon1Image %>" width="120px" height="120px" alt="<%=oWishColItem.FItemList(lp).FItemName%>" /></a>
					</p>
					<p class="pdtBrand tPad15"><a href="/street/street_brand.asp?makerid=<%=oWishColItem.FItemList(lp).FMakerID%>&rc=item_wish_<%=lp+1%>"><%=oWishColItem.FItemList(lp).FBrandName%></a></p>
					<p class="pdtName tPad05">
						<a href="/shopping/category_prd.asp?itemid=<%= oWishColItem.FItemList(lp).Fitemid %>&rc=item_wish_<%=lp+1%>"><%=chrbyte(oWishColItem.FItemList(lp).FItemName, 12, "Y")%></a>
					</p>
					<p class="pdtPrice tPad05"><strong><% = FormatNumber(oWishColItem.FItemList(lp).getRealPrice,0) %>원</strong>
					<% IF oWishColItem.FItemList(lp).IsSaleItem Then %>
						<strong class="cRd0V15">[<% = oWishColItem.FItemList(lp).getSalePro %>]</strong>
					<% End If %>
					</p>
				</li>
			<%	next %>
			</ul>
		</div>
	</div>
</div>
<% End If %>
<%
	end if
	set oWishColItem = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbCTclose.asp" -->
<!-- #include virtual="/lib/db/dbAppWishclose.asp" -->