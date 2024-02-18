<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/chtml/inipay/fun_Installment.asp" -->
<%
Dim refip
refip = request.ServerVariables("HTTP_REFERER")

Dim para : para = request("para")

If (InStr(refip, "10x10.co.kr") < 1) Then
	response.write "not valid Referer"
	response.end
End if

Dim imatchDate : imatchDate = Left(now(),10)
If (para="on") then
    CALL ReMakeInstallMentHtml(imatchDate)
end if
Dim BufStr
BufStr = getInstallMentHtml(imatchDate)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language='javascript'>
function AssignReal(){
    if (confirm('적용하시겠습니까?')){
        document.frmRmk.para.value="on";
        document.frmRmk.submit();
    }
}
</script>
<div class="wrap">
	<div class="container">
		<div id="contentWrap">
            <div class="payMethodWrap" id="i_paymethod" name="i_paymethod">
<table class="baseTable orderForm payForm tMar10">
	<caption>결제 수단 입력</caption>
	<colgroup>
		<col width="32%" /><col width="" /><col width="32%;" />
	</colgroup>
	<thead>
	<tr>
		<td colspan="3">
			<span><input type="radio" class="radio" id="payMethod01" /> <label for="payMethod01"><strong>신용카드</strong></label></span>
			<span><input type="radio" class="radio" id="payMethod02" /> <label for="payMethod02"><strong>실시간 계좌이체</strong></label></span>
			<span><input type="radio" class="radio" id="payMethod03" /> <label for="payMethod03"><strong>무통장 입금(가상계좌)</strong></label></span>
			<span><input type="radio" class="radio" id="payMethod04" /> <label for="payMethod04"><strong>휴대폰 결제</strong></label></span>
		</td>
	</tr>
	</thead>
	<tbody>
	<!-- 신용카드 선택의 경우 -->
	<tr>
		<td class="vTop">
		<%
		    On Error resume Next
            IF application("Svr_Info")="Dev" THEN
                server.Execute "/chtml/inipay/html/inc_installment_TEST.html"
            ELSE
                server.Execute "/chtml/inipay/html/inc_installment.html"
            ENd IF
            On Error Goto 0
        %>
		</td>
		<td >==&gt;</td>
		<td class="lBdr1 vTop">
    <%
    response.write BufStr
    %>
        </td>
    </tr>
    <tr>
        <td colspan="3" >
        <p>** 1일 단위로 자동 생성됩니다.</p>
        <p>** 실시간 적용 하시려면 <input type="button" class="btnGrn btnS1" onClick="AssignReal();" value="실시간적용"> 을 누르세요.</p>
        </td>
    </tr>
    </tbody>
</table>
        </div>
    </div>
    </div>
</div>
<form name="frmRmk" method="get" action="">
<input type="hidden" name="para" value="">
</form>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->