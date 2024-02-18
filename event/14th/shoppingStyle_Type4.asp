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
Dim catecode, lp,sPercent, flo1, flo2, d
catecode = getNumeric(requestCheckVar(Request("disp"),3))
sPercent =	getNumeric(requestCheckVar(Request("sp"),2))
flo1 =	requestCheckVar(Request("flo1"),5) '// 무료배송
flo2 =	requestCheckVar(Request("flo2"),5) '// 한정판매
dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),9))
dim SortMet		: SortMet = requestCheckVar(request("srm"),2)
dim searchFlag 	: searchFlag = "sale"
dim CurrPage 	: CurrPage = getNumeric(requestCheckVar(request("cpg"),9))
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)

dim ListDiv,ColsSize,ScrollCount
dim cdlNpage
ListDiv="salelist"
ColsSize =6
ScrollCount = 10

'추가 이미지 사이즈
dim imgSz	: imgSz = chkIIF(icoSize="M",180,150)

d = 1

if SortMet="" then SortMet="be"
if CurrPage="" then CurrPage=1
if PageSize ="" then PageSize =32
'rw sPercent & "!"
dim oDoc,iLp
set oDoc = new SearchItemCls

oDoc.FListDiv 			= ListDiv
oDoc.FRectSortMethod	= SortMet
oDoc.FRectSearchFlag 	= searchFlag
oDoc.FPageSize 			= PageSize
oDoc.FRectCateCode		= catecode
oDoc.FisFreeBeasong		= flo1	'// 무료배송
oDoc.FisLimit			= flo2	'// 한정판매
'oDoc.FisTenOnly			= flo

oDoc.FCurrPage 			= CurrPage
oDoc.FSellScope 		= "Y"
oDoc.FScrollCount 		= ScrollCount

'할인률 적용
Select Case sPercent
	Case "99"
		oDoc.FSalePercentLow = "0"
		oDoc.FSalePercentHigh = "0.3"
	Case "70"
		oDoc.FSalePercentLow = "0.3"
		oDoc.FSalePercentHigh = "0.5"
	Case "50"
		oDoc.FSalePercentLow = "0.5"
		oDoc.FSalePercentHigh = "0.8"
	Case "20"
		oDoc.FSalePercentLow = "0.8"
		oDoc.FSalePercentHigh = "1"
end Select

oDoc.getSearchList


%>


<%
IF oDoc.FResultCount >0 then
dim i,TotalCnt
dim cdlNTotCnt, icolS,icolE, cdlNCols
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
