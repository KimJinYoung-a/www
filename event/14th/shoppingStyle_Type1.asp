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
	'// 변수 선언 //
	Dim lp
	Dim atype, d


dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),9))
dim SortMet		: SortMet =  requestCheckVar(request("srm"),2)
dim searchFlag 	: searchFlag = "newitem"
dim CurrPage 	: CurrPage = getNumeric(requestCheckVar(request("cpg"),9))
dim catecode	: catecode = getNumeric(requestCheckVar(request("disp"),9))
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)

dim imgSz	: imgSz = chkIIF(icoSize="M",180,150)

Dim cntless : cntless  = True

if SortMet="" then SortMet="be"		'정렬 기본값 : 인기순

dim ListDiv,ColsSize,ScrollCount
dim cdlNpage
ListDiv="newlist"
ColsSize =6
ScrollCount = 10

d = 1

if CurrPage="" then CurrPage=1
if PageSize ="" then PageSize =35

dim oDoc,iLp
set oDoc = new SearchItemCls

oDoc.FListDiv 			= ListDiv
oDoc.FRectSortMethod	= SortMet
oDoc.FRectSearchFlag 	= searchFlag
oDoc.FPageSize 			= PageSize

oDoc.FCurrPage 			= CurrPage
oDoc.FSellScope			= "Y"
oDoc.FScrollCount 		= ScrollCount
oDoc.FRectSearchItemDiv ="D"
oDoc.FRectCateCode			= catecode

oDoc.getSearchList


%>


<%
IF oDoc.FResultCount >0 then
dim cdlNTotCnt, i, TotalCnt
dim maxLoop	,intLoop

TotalCnt = oDoc.FResultCount

	For i=0 To TotalCnt-1
		IF (i <= TotalCnt-1) Then
			If d < 9 Then
				If oDoc.FItemList(i).getRealPrice >= 10000 Then
%>
					<li <% IF oDoc.FItemList(i).isSoldOut Then response.write "soldOut" %>>
						<input type='checkbox' class='check' name="pdFavChk" value="<%=oDoc.FItemList(i).FItemID %>"/>
						<div class='pdtBox'>
							<div class='pdtPhoto'>
								<span class='soldOutMask'></span>
								<a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(i).FItemID %>" target="_blank">
									<img src='<% = oDoc.FItemList(i).FImageIcon1 %>' alt='<% = oDoc.FItemList(i).FItemName %>' />
								</a>
							</div>
							<div class='pdtInfo'>
								<p class='pdtName'><a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(i).FItemID %>" target="_blank"><%= chrbyte(oDoc.FItemList(i).FItemName, 10, "Y") %></a></p>
								<p class='pdtPrice'><span class='finalP'><%=FormatNumber(oDoc.FItemList(i).getRealPrice,0)%>원</span></p>
							</div>
						</div>
					</li>
<%
				End If
			end if
		End If

		If oDoc.FItemList(i).getRealPrice >= 10000 Then
			d = d + 1
		End If
	Next
End if
%>
<% set oDoc = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
