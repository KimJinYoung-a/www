<%@ codepage="65001" language="VBScript" %>
<%
'#######################################################
'	History	:  2009.08.12 한용민 생성
'			   2011.07.28 김진영 수정	
'	Description : 쿠폰
'#######################################################
%>

<script language="javascript">

	function pop_print(editor_no){
		var pop_print = window.open('coupon_print2.asp','pop_print','width=800,height=768,scrollbars=yes,resizable=yes');
		pop_print.focus();
	}

</script>

<body topmargin=0 leftmargin=0  onLoad="jsOnLoad();">
<table width="100%" border=0 cellpadding=0 cellspacing=0>
<tr>
	<td><img src="http://fiximage.10x10.co.kr/web2011/mail/coupon/gift_coupon0728.gif" usemap="#Map" border=0></td>
</tr>
</table>
</body>
<map name="Map" id="Map">
<area shape="rect" coords="10,221,584,448" href="javascript:pop_print();" onfocus="blur()">
</map>