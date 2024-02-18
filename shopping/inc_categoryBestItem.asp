<%
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
		oCBDoc.FPageSize = 5					'5개 접수
		oCBDoc.FScrollCount = 5
		oCBDoc.FListDiv = "list"				'상품목록
		oCBDoc.FLogsAccept = False			'로그 기록안함
		oCBDoc.FAddLogRemove = true			'추가로그 기록안함
		oCBDoc.FSellScope= "Y"				'판매중인 상품만
		oCBDoc.getSearchList

	If oCBDoc.FResultCount > 0 Then
		ichk = 1
%>
	<a href="/shopping/category_list.asp?srm=be&disp=<%=catecode%>" class="more"><span>more</span> &gt;</a>
	<ul class="pdtList">
<%
			For iLp=0 To oCBDoc.FResultCount-1
				if cStr(oCBDoc.FItemList(iLp).Fitemid)<>cStr(itemid) then	'현재보는 상품이 아니면 표시
					
%>
		<li>
			<p class="pdtPhoto">
			<a href="/shopping/category_prd.asp?itemid=<%= oCBDoc.FItemList(iLp).Fitemid %>&rc=item_cate_<%=ichk%>">
			<!--a href="" onclick="goRecPickABTestH('<%=itemid%>','<%= oCBDoc.FItemList(iLp).Fitemid %>');return false;"-->
			<img src="<%=oCBDoc.FItemList(iLp).FImageIcon2%>" alt="<%=Replace(oCBDoc.FItemList(iLp).FitemName,"""","")%>" /></a></p>
			<p class="pdtBrand tPad15"><a href="/street/street_brand.asp?makerid=<%= oCBDoc.FItemList(iLp).FMakerid %>&rc=item_cate_<%=ichk%>"><%= oCBDoc.FItemList(iLp).FBrandName %></a></p>
			<p class="pdtName tPad05"><a href="/shopping/category_prd.asp?itemid=<%= oCBDoc.FItemList(iLp).Fitemid %>&rc=item_cate_<%=ichk%>"><%=chrbyte(oCBDoc.FItemList(iLp).FitemName,12,"Y")%></a></p>
			<p class="pdtPrice tPad05">
				<strong><% = FormatNumber(oCBDoc.FItemList(iLp).getRealPrice,0) %>원</strong>
				<% If oCBDoc.FItemList(iLp).IsSaleItem Then %>
				<strong class="cRd0V15">[<% = oCBDoc.FItemList(iLp).getSalePro %>]</strong>
				<% end if %>
			</p>
		</li>
<%
				ichk = ichk+1
				end if
				if ichk>4 then Exit For
			Next
%>
	</ul>
<%
		if ichk>1 then	'현재보는 상품 제외 1개 이상 있으면 박스 show
			Response.Write "<script>$('#recommenditem').show();</script>"
		end if
	
	End if

	set oCBDoc = Nothing
%>
<script>
function goRecPickABTestH(itid, fitid)
{
	try{
		recoPick('fetchUID', function (uid) {
			location.href='https://api.recopick.com/1/banner/86/pick?source='+itid+'&pick='+fitid+'&uid='+uid+'&method=10&channel=recopick_itemprd_self&reco_type=item-item';
		});
	} catch(e){
		location.href='https://api.recopick.com/1/banner/86/pick?source='+itid+'&pick='+fitid+'&uid=&method=10&channel=recopick_itemprd_self&reco_type=item-item';
	}
}
</script>