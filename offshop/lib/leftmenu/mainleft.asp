<!-- #include virtual="/lib/inc_const.asp" -->
<%
	Dim ClsMainLeftBanner, vPointMainLeftBannerImg, vPointMainLeftBannerLink
	SET ClsMainLeftBanner = NEW COffshopPoint1010
	ClsMainLeftBanner.fnGetMainLeftBanner()
	vPointMainLeftBannerImg  = ClsMainLeftBanner.FImageURL
	vPointMainLeftBannerLink = db2html(ClsMainLeftBanner.FLinkURL)
	SET ClsMainLeftBanner = nothing
	vPointMainLeftBannerImg = staticImgUrl & "/main/" & vPointMainLeftBannerImg
%>
<table width="140" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td valign="top" height="360">
	<!--tag플래시--><!--2010.02.01 한용민추가  이미지없는경우 출력안되게 임시 변경-->
		<div align="center" style="position:absolute; width:210px; height:370px; top: 79px; margin-left:-44px;">
		<% if right(vPointMainLeftBannerImg,5) <> "main/" then %><a href="<%=vPointMainLeftBannerLink%>" onFocus="blur()"><img src="<%=vPointMainLeftBannerImg%>"></a><% end if %></div>
	</td>
</tr>
<tr>
	<td align="center">
	<!--포인트1010 배너, 메뉴-->
		<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/bn_point1010.gif" usemap="#Map"></td>
		</tr>
		</table>
		<map name="Map">
			<area shape="rect" coords="7,94,68,114" href="/offshop/point/card_reg.asp" onFocus="blur()">
			<% If GetLoginUserID() = "" Then %>
			<area shape="rect" coords="71,93,130,114" href="javascript:goPointLogin();" onFocus="blur()">
			<% Else %>
			<area shape="rect" coords="71,93,130,114" href="/offshop/point/point_switch.asp" onFocus="blur()">
			<% End If %>
			<area shape="rect" coords="5,3,134,90" href="/offshop/point/card_service.asp" onFocus="blur()">
		</map>
	</td>
</tr>
<tr>
	<td height="100" valign="top"><div style="display:none; position:absolute; width:200px; height:200px; margin-left:-69px; margin-top:12px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/object_left.png" class="png24"></div></td>
</tr>
</table>
<script language="javascript">
function goPointLogin()
{
	alert('로그인을 하세요.');
	location.href='/offshop/point/point_login.asp?reurl=/offshop/point/point_switch.asp';
}
</script>