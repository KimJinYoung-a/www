<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'#######################################################
'	History	:  2009.10.08 한용민 생성
'	Description : 비회원 메일링 서비스 수신거부
'#######################################################

%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<script language="javascript">

	function jsOnLoad(){
		window.resizeTo(1024,768);
	}
		
</script>
</head>

<!-----  팝업창크기 440x330px ----->
<body topmargin=0 leftmargin=0  onLoad="jsOnLoad();">
<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td>
		<table width="960" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="245" style="padding:0 15px 0 15px;" valign="top">
				<table width="215" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><img src="http://fiximage.10x10.co.kr/web2009/member/member_title.gif" width="215" height="73"></td>
				</tr>
				<tr>
					<td style="padding-top:20px;">
						<table width="215" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="border-bottom: solid 1px #eaeaea;"><a href="http://www.10x10.co.kr/login/loginpage.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2009/member/leftmenu_01_on.gif" width="215" height="20"></a></td>
						</tr>
						<tr>
							<td style="border-bottom: solid 1px #eaeaea;"><a href="http://www.10x10.co.kr/member/forget.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2009/member/leftmenu_02.gif" width="215" height="20"></a></td>
						</tr>
						<tr>
							<td style="border-bottom: solid 1px #eaeaea;"><a href="http://www.10x10.co.kr/member/join.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2009/member/leftmenu_03.gif" width="215" height="20"></a></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="padding-top:25px;"><img src="http://fiximage.10x10.co.kr/web2009/member/left_customer.gif" width="215" height="172"></td>
				</tr>
				</table>
			</td>
			<td width="715" valign="top">
				<table width="715" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="border-bottom: solid 1px #af0a0a;"><img src="http://fiximage.10x10.co.kr/web2009/member/bemail_title.gif"></td>
				</tr>
				<tr>
					<td style="padding:25px 15px 0 15px;" align="center"><img src="http://fiximage.10x10.co.kr/web2009/member/bemail_c_copy.gif"></td>
				</tr>
				<tr>
					<td style="padding:35px 15px 0 0;" align="center"><img src="http://fiximage.10x10.co.kr/web2009/member/memberadvtg.gif" width="690" height="299"></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->