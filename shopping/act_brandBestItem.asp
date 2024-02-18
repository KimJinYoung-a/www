<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/JSON2.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<%
Dim catecode, itemid, makerid, abparam
    itemid = requestCheckVar(request("itemid"),10)	    'itemid
	makerid = requestCheckVar(request("makerid"),32)	'makerid
	catecode = requestCheckVar(request("catecode"),18)	'카테고리 코드
	abparam = requestCheckVar(request("ab"),10)	        'ab
	if (abparam<>"") then abparam = "ab="&abparam
	    
	'' catecode = requestCheckVar(request("catecode"),20)	'카테고리 코드

	'// 카테고리 베스트
	'- 2015.03.30 : 허진원 생성
	dim oCBDoc,iLp, ichk, pArrList
	set oCBDoc = new SearchItemCls
		oCBDoc.FRectSortMethod	= "be"		'인기상품
		oCBDoc.FRectSearchFlag = "n"			'일반상품
		oCBDoc.FRectSearchItemDiv = "n"		'기본 카테고리만
		oCBDoc.FRectSearchCateDep = "T"		'하위 카테고리 포함
		oCBDoc.FRectMakerid = makerid
		oCBDoc.FRectCateCode	= LEFT(catecode,9)
		oCBDoc.FCurrPage = 1
		oCBDoc.FPageSize = 11					'N개 접수
		oCBDoc.FScrollCount = 5
		oCBDoc.FListDiv = "brand"				'상품목록
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
		<h3 class="ftLt"><%=oCBDoc.FItemList(0).FBrandName%> BEST</h3>
		<span class="ftLt">브랜드 인기 상품</span>
	</div>
	<div class="itemContainerV17a">
		<div id="rcmdPrd01" class="itemContV15">
			<ul class="pdtList">
		<%
					For iLp=0 To oCBDoc.FResultCount-1
						if cStr(oCBDoc.FItemList(iLp).Fitemid)<>cStr(itemid) then	'현재보는 상품이 아니면 표시
							pArrList = pArrList & oCBDoc.FItemList(iLp).Fitemid &","
		%>
				<li>
					<p class="pdtPhoto">
					<a href="/shopping/category_prd.asp?itemid=<%= oCBDoc.FItemList(iLp).Fitemid %>&rc=item_brand_<%=ichk%><%=CHKIIF(abparam<>"","&"&abparam,"")%>">
					<img src="<%=oCBDoc.FItemList(iLp).FImageIcon2%>" alt="<%=Replace(oCBDoc.FItemList(iLp).FitemName,"""","")%>" /></a></p>
					<p class="pdtBrand tPad15"><a href="/street/street_brand.asp?makerid=<%= oCBDoc.FItemList(iLp).FMakerid %>&rc=item_brand_<%=ichk%><%=CHKIIF(abparam<>"","&"&abparam,"")%>"><%= oCBDoc.FItemList(iLp).FBrandName %></a></p>
					<p class="pdtName tPad05"><a href="/shopping/category_prd.asp?itemid=<%= oCBDoc.FItemList(iLp).Fitemid %>&rc=item_brand_<%=ichk%><%=CHKIIF(abparam<>"","&"&abparam,"")%>"><%=chrbyte(oCBDoc.FItemList(iLp).FitemName,12,"Y")%></a></p>
					<p class="pdtPrice tPad05">
						<strong><% = FormatNumber(oCBDoc.FItemList(iLp).getRealPrice,0) & chkIIF(oCBDoc.FItemList(iLp).IsMileShopitem,"Point","원") %></strong>
						<% If oCBDoc.FItemList(iLp).IsSaleItem Then %>
						<strong class="cRd0V15">[<% = oCBDoc.FItemList(iLp).getSalePro %>]</strong>
						<% end if %>
					</p>
				</li>
		<%
						ichk = ichk+1
						end if
						if ichk>10 then Exit For
					Next
		%>
		
    		<% ''갯수가 적으면 2depth 높여 한번더 쿼리
    		if (ichk<11) then
                oCBDoc.FRectCateCode	= LEFT(catecode,3)
                oCBDoc.getSearchList
					For iLp=0 To oCBDoc.FResultCount-1
						if cStr(oCBDoc.FItemList(iLp).Fitemid)<>cStr(itemid) then	'현재보는 상품이 아니면 표시
							if (inStr(pArrList,(oCBDoc.FItemList(iLp).Fitemid&","))<1) then
        		%>
        				<li>
        					<p class="pdtPhoto">
        					<a href="/shopping/category_prd.asp?itemid=<%= oCBDoc.FItemList(iLp).Fitemid %>&rc=item_brand_<%=ichk%><%=CHKIIF(abparam<>"","&"&abparam,"")%>">
        					<img src="<%=oCBDoc.FItemList(iLp).FImageIcon2%>" alt="<%=Replace(oCBDoc.FItemList(iLp).FitemName,"""","")%>" /></a></p>
        					<p class="pdtBrand tPad15"><a href="/street/street_brand.asp?makerid=<%= oCBDoc.FItemList(iLp).FMakerid %>&rc=item_brand_<%=ichk%><%=CHKIIF(abparam<>"","&"&abparam,"")%>"><%= oCBDoc.FItemList(iLp).FBrandName %></a></p>
        					<p class="pdtName tPad05"><a href="/shopping/category_prd.asp?itemid=<%= oCBDoc.FItemList(iLp).Fitemid %>&rc=item_brand_<%=ichk%><%=CHKIIF(abparam<>"","&"&abparam,"")%>"><%=chrbyte(oCBDoc.FItemList(iLp).FitemName,12,"Y")%></a></p>
        					<p class="pdtPrice tPad05">
        						<strong><% = FormatNumber(oCBDoc.FItemList(iLp).getRealPrice,0) & chkIIF(oCBDoc.FItemList(iLp).IsMileShopitem,"Point","원") %></strong>
        						<% If oCBDoc.FItemList(iLp).IsSaleItem Then %>
        						<strong class="cRd0V15">[<% = oCBDoc.FItemList(iLp).getSalePro %>]</strong>
        						<% end if %>
        					</p>
        				</li>
        		<%
        						ichk = ichk+1
        					end if
        				end if
        				if ichk>10 then Exit For
        			Next
            end if
            %>
			</ul>
		</div>
	</div>
	<a href="/street/street_brand.asp?makerid=<%=makerid%>&rc=item_brand_0<%=CHKIIF(abparam<>"","&"&abparam,"")%>" class="more"><span>more</span> &gt;</a>
</div>
<%
	End if

	set oCBDoc = Nothing
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->
