<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/emscls.asp" -->
<%
Dim areaCode : areaCode = requestCheckVar(request("areaCode"),2)
Dim oems : SET oems = New CEms

if (areaCode<>"") then
    oems.FRectCurrPage = 1
    oems.FRectPageSize = 100
    oems.FRectEmsAreaCode  = areaCode
    oems.GetWeightPriceList
end if

dim i
dim iCols : iCols=2
dim iRows : iRows = oems.FResultCount\iCols
if (oems.FResultCount\iCols<>oems.FResultCount/iCols) then iRows=iRows+1
%>
<div class="ct tMar35">
	<h5 class="crRed fs15 bPad05">EMS 중량/지역별 요금</h5>
	<p>제 <%= areaCode %>지역 중량별 요금</p>
</div>
<table class="baseTable orderForm lastLine tMar15">
<caption>EMS 중량/지역별 요금</caption>
<colgroup>
	<col width="25%" /> <col width="25%" /> <col width="25%" /> <col width="*" />
</colgroup>
<thead>
<tr>
	<th scope="row">중량 (Kg)</th>
	<th scope="row">EMS 요금 (원)</th>
	<th scope="row" class="borderLine">중량 (Kg)</th>
	<th scope="row">EMS 요금 (원)</th>
</tr>
</thead>
<tbody>
<tr>
<% for i=0 to iRows-1 %>
<tr>
	<td><%= CLng(oems.FItemList(i).FWeightLimit/1000*10)/10 %></td>
	<td><%= FormatNumber(oems.FItemList(i).FemsPrice,0) %></td>
<% if oems.FResultCount>iRows+i then %>
	<td><%= CLng(oems.FItemList(iRows+i).FWeightLimit/1000*10)/10 %></td>
	<td><%= FormatNumber(oems.FItemList(iRows+i).FemsPrice,0) %></td>
<% else %>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
<% end if %>
</tr>
<% next %>
</tr>
</tbody>
</table>
<%
SET oems = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->