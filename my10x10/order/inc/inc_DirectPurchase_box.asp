<%
	Dim oUniPassNumber
	Dim isGlobalDirectPurchaseOrder : isGlobalDirectPurchaseOrder = myorder.FOneItem.IsGlobalDirectPurchaseItemExists(myorderdetail)
	Dim isUniPassNumberEditEnable
	if (isGlobalDirectPurchaseOrder) then
	isUniPassNumberEditEnable = myorder.FOneItem.isUniPassNumberEditEnable(myorderdetail)

	oUniPassNumber = fnUniPassNumber(orderserial)
	'''If oUniPassNumber <> "" And Not isnull(oUniPassNumber) Then
%>
<div class="title">
	<h4>상품 통관 정보</h4>
</div>
<table class="baseTable rowTable">
<caption>상품 통관 정보</caption>
<colgroup>
	<col width="130" /> <col width="*" />
</colgroup>
<tbody>
<tr>
	<th scope="row">개인통관 고유부호</th>
	<td><%=oUniPassNumber%>
	    <% If isUniPassNumberEditEnable and CurrStateCnt3<1 and CurrStateCnt4<1 and CurrStateCnt5<1 Then %>
        <a href="/my10x10/orderPopup/popCustomsIDEdit.asp?orderserial=<%=orderserial%>&pflag=<%=pflag%>" title="새창에서 열림" onclick="window.open(this.href, 'popDepositor', 'width=700, height=500, scrollbars=yes'); return false;" class="btn btnS2 btnGry"><span class="fn">수정</span></a>
        <% End If %>
        * <font color="red">상품준비중(업체확인) 이후</font>에는 고객센터를 통해서만 수정이 가능합니다.
	</td>
</tr>
</tbody>
</table>
<%
	'''End If
	End If
%>
