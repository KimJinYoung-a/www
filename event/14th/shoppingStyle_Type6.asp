<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->

<%
	Dim atype,catecode
	catecode = RequestCheckVar(request("disp"),3)
	atype = RequestCheckVar(request("atype"),1)
	if atype="" or atype="s" then atype="f" '2015-09-17 b -> f 변경 기본b
	Dim cntless : cntless  = true

	atype="g"

	Dim oaward
	set oaward = new CAWard
	oaward.FPageSize = 35
	oaward.FDisp1 = catecode

	oaward.FRectAwardgubun = atype
	oaward.GetNormalItemList

	If oaward.FResultCount < 3 and atype<>"s" Then
		cntless = false
		oaward.GetNormalItemList5down
	End if

	Dim i, d

	d = 1


%>


<%
	for i=0 to oaward.FPageSize-1
		If oaward.FResultCount>0 AND oaward.FResultCount > i Then
			If d < 9 Then
				If oaward.FItemList(i).getRealPrice >= 10000 Then
%>
					<li <% IF oaward.FItemList(i).isSoldOut Then response.write "soldOut" %>>
						<input type='checkbox' class='check' name="pdFavChk" value="<%=oaward.FItemList(i).FItemID %>"/>
						<div class='pdtBox'>
							<div class='pdtPhoto'>
								<span class='soldOutMask'></span>
								<a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemID %>" target="_blank">
									<img src='<%= oaward.FItemList(i).Ficon1image %>' alt='<% = oaward.FItemList(i).FItemName %>' />
								</a>
							</div>
							<div class='pdtInfo'>
								<p class='pdtName'><a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemID %>" target="_blank"><%= chrbyte(oaward.FItemList(i).FItemName,10,"Y") %></a></p>
								<p class='pdtPrice'><span class='finalP'><%=FormatNumber(oaward.FItemList(i).getRealPrice,0)%>원</span></p>
							</div>
						</div>
					</li>
<%
				End If
			end if
		End If

		If oaward.FItemList(i).getRealPrice >= 10000 Then
			d = d + 1
		End If
	Next
%>
<% set oaward = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
