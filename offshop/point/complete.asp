<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/card_service.asp
' Description : 오프라인샾 point1010 카드 발급/적립/사용방법
' History : 2009.07.17 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->


<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td width="170" style="padding-top:41px;" align="center" valign="top">
	<!-- // 왼쪽 메뉴 // -->
	<!-- #include virtual="/offshop/lib/leftmenu/point1010Left.asp" -->
	</td>
	<td width="790" style="padding-top: 30px;" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" width="760" valign="top">
				<table width="730" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/complete_tit.gif" style="margin-left:10px;"></td>
				</tr>
				<tr>
					<td align="center" valign="top">

						<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="center" style="padding-top:50px;">
								<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_join_complete.gif" width="400" height="205"></td>
								</tr>
								<tr>
									<td style="padding-top:30px;" align="center"><a href="/offshop/point/point_login.asp?reurl=/offshop/point/card_reg.asp"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_regicard.gif" width="183" height="32"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					
					</td>
				</tr>
				</table>
			</td>
			<td width="30" valign="top">
				<div style="position:absolute; width:55px; height:95px; top:115px; margin-left:10px;">
				<img src="http://fiximage.10x10.co.kr/tenbytenshop/object_sticker.gif" width="55" height="95">
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>
</form>
</table>
<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->