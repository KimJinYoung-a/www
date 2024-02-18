<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'#######################################################
'	History	:  2009.10.08 한용민 생성
'	Description : 비회원 메일링 서비스 신청 팝업
'#######################################################

%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<%
dim username , usermail
	username = requestCheckVar(request("username"),32)		
	usermail = requestCheckVar(request("usermail"),128)
%>

<script language="javascript">

	function jsOnLoad(){
		window.resizeTo(390,420);
	}
		
</script>
</head>

<!-----  팝업창크기 375x340px ----->
<body topmargin=0 leftmargin=0  onLoad="jsOnLoad();">
<table width="375" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td><img src="http://fiximage.10x10.co.kr/web2009/mailing/bemail_img2.gif"></td>
</tr>
<tr>
	<td height="90" align="center" valign="top" style="padding-top:20px;">
		<table width="90%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left" style="padding-bottom:5px; border-bottom:1px solid #eaeaea;">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="70"><img src="http://fiximage.10x10.co.kr/web2009/mailing/bemail_name.gif"></td>
					<td class="gray11px02b"><%=username%></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="left" style="padding:5px 0 5px 0; border-bottom:1px solid #eaeaea;">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="70"><img src="http://fiximage.10x10.co.kr/web2009/mailing/bemail_email.gif"></td>
					<td class="gray11px02b"><%=usermail%></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td height="90" valign="top" style="padding-left:17px"><img src="http://fiximage.10x10.co.kr/web2009/mailing/bemail_img3.gif" width="316" height="82"></td>
</tr>
<tr>
	<td height="90" align="center" valign="top" style="padding-top:12px;"><a href="javascript:self.close();" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2009/mailing/bemail_ok.gif" width="58" height="24"></a></td>
</tr>
</table>
</body>
</html>
<!-- #include virtual="/lib/poptailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
