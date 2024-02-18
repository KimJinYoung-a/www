<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/_CategoryCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/JSON2.asp" -->
<%
	dim oHTBCItem, rtype, itemid, catecode
	dim lp, ix, iy

	itemid = requestCheckVar(request("itemid"),9)	'상품코드
	catecode = requestCheckVar(request("disp"),18)	'전시카테고리
    rtype = requestCheckVar(request("rtype"),10)	'타입
	dim currpage	:	currpage=getNumeric(requestCheckVar(request("cpg"),8)) '페이지
    currpage=currpage-1
	'//클래스 선언
	set oHTBCItem = New CAutoCategory
	oHTBCItem.FRectItemId = itemid
	oHTBCItem.FRectDisp = catecode
	if (rtype="1") then
        oHTBCItem.FRectHappyTogetherType = "v4"
    end if
	'// 텐바이텐 해피투게더 상품 목록
	oHTBCItem.GetCateRightHappyTogetherList

	ix=0+currpage*5
	iy= (currpage+1)*5-1
	if oHTBCItem.FResultCount>0 then
%>
<% If oHTBCItem.FResultCount >= 5 Then %>
	<%	For lp = ix To oHTBCItem.FResultCount - 1 %>
	<% if lp>iy then Exit For %>
		<li>
			<p class="pdtPhoto">
				<a href="/shopping/category_prd.asp?itemid=<%= oHTBCItem.FItemList(lp).Fitemid %>&rc=item_happy_<%=lp+1%>&disptype=<%=CHKIIF(rtype="1","n","g")%>"><img src="<%=getThumbImgFromURL(oHTBCItem.FItemList(lp).FIcon1Image,150,150,"true","false") %>" width="150px" height="150px" alt="<%=oHTBCItem.FItemList(lp).FItemName%>" /></a>
			</p>
			<p class="pdtBrand tPad15"><a href="/street/street_brand.asp?makerid=<%=oHTBCItem.FItemList(lp).FMakerID%>&rc=item_happy_<%=lp+1%>&disptype=<%=CHKIIF(rtype="1","n","g")%>"><%=oHTBCItem.FItemList(lp).FBrandName%></a></p>
			<p class="pdtName tPad05">
				<a href="/shopping/category_prd.asp?itemid=<%= oHTBCItem.FItemList(lp).Fitemid %>&rc=item_happy_<%=lp+1%>&disptype=<%=CHKIIF(rtype="1","n","g")%>"><%=chrbyte(oHTBCItem.FItemList(lp).FItemName, 12, "Y")%></a>
			</p>
			<p class="pdtPrice tPad05"><strong><% = FormatNumber(oHTBCItem.FItemList(lp).getRealPrice,0) & chkIIF(oHTBCItem.FItemList(lp).IsMileShopitem,"Point","원") %></strong>
			<% IF oHTBCItem.FItemList(lp).IsSaleItem Then %>
				<strong class="cRd0V15">[<% = oHTBCItem.FItemList(lp).getSalePro %>]</strong>
			<% End If %>
			</p>
		</li>
	<% next %>
<% End If %>
<%
	End If
	Set oHTBCItem = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->