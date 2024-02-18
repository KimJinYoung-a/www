<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/JSON2.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<%
Dim catecode, itemid, abparam

	itemid = requestCheckVar(request("itemid"),9)	'상품코드
	catecode = requestCheckVar(request("catecode"),20)	'카테고리 코드
	abparam = requestCheckVar(request("ab"),10)	        'ab
	if (abparam<>"") then abparam = "ab="&abparam

	'// 카테고리 베스트
	'- 2015.03.30 : 허진원 생성
	dim oCBDoc,iLp, ichk
	set oCBDoc = new SearchItemCls
		oCBDoc.FRectSortMethod	= "be"		'인기상품
		oCBDoc.FRectSearchFlag = "n"			'일반상품
		oCBDoc.FRectSearchItemDiv = "n"		'기본 카테고리만
		oCBDoc.FRectSearchCateDep = "T"		'하위 카테고리 포함
		oCBDoc.FRectCateCode	= catecode
		oCBDoc.FCurrPage = 1
		oCBDoc.FPageSize = 51					'50개 접수
		oCBDoc.FScrollCount = 5
		oCBDoc.FListDiv = "list"				'상품목록
		oCBDoc.FLogsAccept = False			'로그 기록안함
		oCBDoc.FAddLogRemove = true			'추가로그 기록안함
		oCBDoc.FSellScope= "Y"				'판매중인 상품만
		oCBDoc.getSearchList

	If oCBDoc.FResultCount > 0 Then
		ichk = 1
%>
<div class="pdtListBoxV17a" id="detail07">
	<!-- best -->
	<div class="titWrap">
		<h3 class="ftLt"><%=CategoryNameUseLeftMenuDB(catecode)%> BEST</h3>
		<span class="ftLt">카테고리 인기 상품</span>
	</div>
	<div class="itemContainerV17a">
		<div id="rcmdPrd01" class="itemContV15">
			<ul class="pdtList">
		<%
					For iLp=0 To oCBDoc.FResultCount-1
						if cStr(oCBDoc.FItemList(iLp).Fitemid)<>cStr(itemid) then	'현재보는 상품이 아니면 표시
							
		%>
				<li>
					<p class="pdtPhoto">
					<a href="/shopping/category_prd.asp?itemid=<%= oCBDoc.FItemList(iLp).Fitemid %>&rc=item_cate_<%=ichk%><%=CHKIIF(abparam<>"","&"&abparam,"")%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_bestitem_in_product','idx|itemid','<%= iLp + 1 %>|<%= oCBDoc.FItemList(iLp).Fitemid %>')">
					<img src="<%=oCBDoc.FItemList(iLp).FImageIcon2%>" alt="<%=Replace(oCBDoc.FItemList(iLp).FitemName,"""","")%>" /></a></p>
					<p class="pdtBrand tPad15"><a href="/street/street_brand.asp?makerid=<%= oCBDoc.FItemList(iLp).FMakerid %>&rc=item_cate_<%=ichk%><%=CHKIIF(abparam<>"","&"&abparam,"")%>"><%= oCBDoc.FItemList(iLp).FBrandName %></a></p>
					<p class="pdtName tPad05"><a href="/shopping/category_prd.asp?itemid=<%= oCBDoc.FItemList(iLp).Fitemid %>&rc=item_cate_<%=ichk%><%=CHKIIF(abparam<>"","&"&abparam,"")%>"><%=chrbyte(oCBDoc.FItemList(iLp).FitemName,12,"Y")%></a></p>
					<p class="pdtPrice tPad05">
						<strong><% = FormatNumber(oCBDoc.FItemList(iLp).getRealPrice,0) & chkIIF(oCBDoc.FItemList(iLp).IsMileShopitem,"Point","원")%></strong>
						<% If oCBDoc.FItemList(iLp).IsSaleItem Then %>
						<strong class="cRd0V15">[<% = oCBDoc.FItemList(iLp).getSalePro %>]</strong>
						<% end if %>
					</p>
				</li>
		<%
						ichk = ichk+1
						end if
						if ichk>100 then Exit For
					Next
		%>
			</ul>
		</div>
	</div>
	<a href="<%=SSLUrl%>/shopping/category_list.asp?srm=be&disp=<%=catecode%>&rc=item_cate_0<%=CHKIIF(abparam<>"","&"&abparam,"")%>" class="more"><span>more</span> &gt;</a>
</div>
<%
	End if

	set oCBDoc = Nothing
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->
