<%
	Dim vNowPage, vNowON, ClsOSPoint111, vMemYuMu
	vNowPage = GetFileName()

	set ClsOSPoint111 = new COffshopPoint1010
		ClsOSPoint111.FUserID	= GetLoginUserID()
		ClsOSPoint111.fnGetMemberYuMu
		vMemYuMu = ClsOSPoint111.FGubun
	set ClsOSPoint111 = nothing
%>
<table width="140" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td height="349" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_title.gif" width="140" height="39"></td>
		</tr>
		<tr>
			<td style="padding-top:40px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu01.gif" width="140" height="21"></td>
						</tr>
						<tr>
							<%	If Left(vNowPage,8) = "card_reg" Then vNowON = "_on" Else vNowON = "" End If	%>
							<td style="padding-top:8px;">
							<a href="/offshop/point/card_reg.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu0101<%=vNowON%>.gif" width="140" height="22"></a><br>
							</td>
						</tr>
						<tr>
							<%	If vNowPage = "card_service" Then vNowON = "_on" Else vNowON = "" End If	%>
							<td>
						<a href="/offshop/point/card_service.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu0102<%=vNowON%>.gif" width="140" height="22"></a><br>
							</td>
						</tr>
			<!--			<tr>
							<%	If vNowPage = "card_shopguide" Then vNowON = "_on" Else vNowON = "" End If	%>
							<td>
							<a href="/offshop/point/card_shopguide.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu0103<%=vNowON%>.gif" width="140" height="22"></a>
							</td>
						</tr>		-->
						<tr>
							<%	If Left(vNowPage,8) = "card_faq" Then vNowON = "_on" Else vNowON = "" End If	%>
							<td>
							<a href="/offshop/point/card_faq.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu0104<%=vNowON%>.gif" width="140" height="22"></a>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="padding-top:24px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu01.gif" width="140" height="21"></td>
						</tr>
						<tr>
							<%	If vNowPage = "point_switch" Then vNowON = "_on" Else vNowON = "" End If	%>
							<td style="padding-top:8px;">
							<a href="/offshop/point/point_switch.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu0201<%=vNowON%>.gif" width="140" height="22"></a><br>
							</td>
						</tr>
						<tr>
							<%	If vNowPage = "point_search" Then vNowON = "_on" Else vNowON = "" End If	%>
							<td>
							<a href="/offshop/point/point_search.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu0202<%=vNowON%>.gif" width="140" height="22"></a><br>
							</td>
						</tr>
						<tr>
							<%	If Left(vNowPage,8) = "card_qna" Then vNowON = "_on" Else vNowON = "" End If	%>
							<td>
							<a href="/offshop/point/card_qna.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu0203<%=vNowON%>.gif" width="140" height="22"></a>
							</td>
						</tr>
						<% If GetLoginUserID() <> "" AND vMemYuMu = "o" Then %>
						<tr>
							<%	If vNowPage = "user_info" Then vNowON = "_on" Else vNowON = "" End If	%>
							<td>
							<!--<a href="/offshop/point/confirmuser.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu0204<%=vNowON%>.gif" width="140" height="22"></a>//-->
							<img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_menu0204.gif" width="140" height="22" onClick="myInfoReWrite('2')" style="cursor:pointer">
							</td>
						</tr>
						<% Else %>
						<tr height="26"><td></td></tr>
						<% End If %>
						</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td height="100" align="center">
	<% If GetLoginUserID() <> "" Then %>
		<img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_logout.gif" onClick="location.href='dologout.asp';" style="cursor:pointer">
	<% End If %>
	</td>
</tr>
<tr>
	<td height="100" valign="top"><div style="position:absolute; width:200px; height:200px; margin-left:-69px; margin-top:12px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/object_left.png" class="png24"></div></td>
</tr>
</table>
<script language="javascript">
function myInfoReWrite(gubun)
{
	var win;
	if(opener != null)
	{
		if(gubun == '1')
		{
			location.href = "/member/join.asp?pflag=o";
		}
		else if(gubun == '2')
		{
			location.href = "/my10x10/userinfo/confirmuser.asp?pflag=o";
		}
	}
	else
	{
		if(gubun == '1')
		{
			//win = window.open('/member/join.asp?pflag=o','10x10','width=1024,height=768,toolbar=yes, location=yes, directories=yes, status=yes, menubar=yes, scrollbars=yes, copyhistory=yes, resizable=yes');
			location.href = "/member/join.asp?pflag=o";
		}
		else if(gubun == '2')
		{
			//win = window.open('/my10x10/userinfo/confirmuser.asp?pflag=o','10x10','width=1024,height=768,toolbar=yes, location=yes, directories=yes, status=yes, menubar=yes, scrollbars=yes, copyhistory=yes, resizable=yes');
			location.href = "/my10x10/userinfo/confirmuser.asp?pflag=o";
		}
		//win.focus();
	}
}
</script>