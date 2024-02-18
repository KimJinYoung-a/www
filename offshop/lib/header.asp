<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title> 텐바이텐 10X10 = 감성채널 감성에너지</title>
<link REL="SHORTCUT ICON" href="http://fiximage.10x10.co.kr/icons/10x10.ico">
<link href="/lib/css/2009off.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" SRC="/lib/js/tenbytencommon.js"></script>
</head>
<%
If requestCheckVar(Request("shopid"),32) = "cafe002" Then		'//2011년 2월 1일 용만 추가
	response.write "<script>"
	response.write "	alert('2011년 2월 1일부로 취화선 영업은 종료 되었습니다\n\n그동안 이용해 주셔서 감사합니다')"
	response.write "</script>"				
end if

If requestCheckVar(Request("shopid"),32) = "streetshop091" Then		'//2012년 4월 6일 eastone 추가
	response.write "<script>"
	response.write "	alert('2012년 3월 말일로 홍대Cafe1010 영업은 종료 되었습니다\n\n그동안 이용해 주셔서 감사합니다')"
	response.write "</script>"				
end if
%>
<body background="http://fiximage.10x10.co.kr/tenbytenshop/bg.gif" style="margin:0">
<!--메인메뉴 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td style="padding:32px 0 5px 0;">
		<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td width="170" align="center"><a href="/offshop/" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/logo.gif" width="155" height="40"></a></td>
			<td width="790"  align="right" valign="bottom">
			<!--메뉴 플래시-->
			<%'	<script language="javascript">FlashEmbed("topMenu","/offshop/flash/top_menu.swf",550,30,"","Y");</script>	%>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding-left:5px;"><a href="http://www.10x10.co.kr/" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_online.gif"></a></td>
					<td width="132"><a href="/offshop/shopinfo.asp?shopid=streetshop011" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/menu_01<% If requestCheckVar(Request("shopid"),32) <> "streetshop091" AND Left(requestCheckVar(Request("shopid"),32),7) = "streets" Then %>_on<% End If %>.gif"></a></td>
					<td width="106"><a href="http://www.ithinkso.co.kr/" target="_blank" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/menu_02.png"></a></td>
					<!-- 2017.10.1 서비스 종료
					<td width="119"><a href="http://www.thefingers.co.kr/" target="_blank" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/menu_03_v1.gif"></a></td>
					-->
					<!--<td width="68"><a href="/offshop/shopinfo.asp?shopid=cafe002" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/menu_04<%' If requestCheckVar(Request("shopid"),32) = "cafe002" Then %>_on<%' End If %>.gif"></a></td>-->
					<!--<td width="115"><a href="/offshop/shopinfo.asp?shopid=streetshop091" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/menu_05<% If requestCheckVar(Request("shopid"),32) = "streetshop091" Then %>_on<% End If %>.gif"></a></td>-->
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<!--메인메뉴 끝-->
<table width="1000" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td height="721" valign="top" style="padding:20px 0 24px 0; background:url(http://fiximage.10x10.co.kr/tenbytenshop/main_bg.gif) no-repeat;">