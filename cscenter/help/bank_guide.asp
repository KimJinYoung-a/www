<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% const MenuSelect = "09" %>
<!-- #include virtual="/lib/header.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<table width="960" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
    <td><img src="http://fiximage.10x10.co.kr/web2008/cscenter/cs_top.gif" width="960" height="162" border="0" usemap="#Quick_service" /></td>
</tr>
<tr>
    <td bgcolor="#F6F6F5" style="padding:15 5 25 5"><!-- ☜ 메인프레임 여백 조정 -->
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="206" align="left" valign="top">
			<!-- CS left 시작-->
			<!-- #include virtual ="/lib/leftmenu/left_cscenter.asp" -->
			<!--left 끝-->
			</td>
			<td valign="top">
			<!-- // 입금확인 및 계좌안내 시작 // -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" style="border:1px solid #D4E4D1">
				<tr>
					<td align="right">
						<table width="750" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" style="border-bottom:1px dotted #C1C1C1"><img src="http://fiximage.10x10.co.kr/web2008/my10x10/order_guide_top.gif" width="750" height="190"></td>
						</tr>
						<tr>
							<td valign="top" style="padding:40 0 0 0">
								<table width="750" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td align="left"><img src="http://fiximage.10x10.co.kr/web2008/my10x10/order_guide_image1.gif" width="231" height="29"></td>
								</tr>
								<tr>
									<td style="padding:10 0 21 20">텐바이텐은 두가지 방법으로 결제가 가능하며, 고객님의 정보는 안전하게 보호되고 있습니다.</td>
								</tr>
								<tr>
									<td style="border-top:1px solid #C3C3C3">
										<table width="750" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="135" height="60" align="right" bgcolor="F8F8F8" style="padding:0 10 0 0; border-bottom:1px solid #E5E5E5; border-right:1px solid #C3C3C3"><img src="http://fiximage.10x10.co.kr/web2008/my10x10/order_guide_card_01.gif" width="109" height="27"></td>
											<td height="60" style="padding:0 0 0 10; border-bottom:1px solid #E5E5E5"><img src="http://fiximage.10x10.co.kr/web2008/my10x10/order_guide_card_02.gif" width="522" height="27"></td>
										</tr>
										<tr>
											<td width="135" height="150" align="right" bgcolor="F8F8F8" style="padding:0 10 0 0; border-bottom:1px solid #C3C3C3; border-right:1px solid #C3C3C3"><img src="http://fiximage.10x10.co.kr/web2008/my10x10/order_guide_mu_01.gif" width="109" height="27"></td>
											<td height="150" style="padding:0 0 0 10; border-bottom:1px solid #C3C3C3"><img src="http://fiximage.10x10.co.kr/web2008/my10x10/order_guide_mu_02.gif" width="470" height="138"></td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td style="Padding-top:30">
								<table width="750" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td align="left"><img src="http://fiximage.10x10.co.kr/web2008/my10x10/order_guide_image2.gif" width="231" height="29"></td>
								</tr>
								<tr>
									<td style="padding:10 0 21 20">고객님의 주문은 실시간 주문관리 시스템으로 사이트상의 <FONT color=#FF6405>&lt;주문 및 배송조회&gt;</font>에서 언제나 조회가 가능하며,<br>각 단계별로 <FONT color=#FF6405>&lt;이메일&gt;</font>로 진행상황을 알려드립니다.</td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			<!-- // 입금확인 및 계좌안내 끝 // -->
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<map name="Quick_service">
	<area shape="rect" coords="3,4,447,157" href="/cscenter/" onFocus="this.blur();">
	<area shape="rect" coords="486,52,610,145" href="cs_service.html" onFocus="this.blur();">
	<area shape="rect" coords="616,52,726,145" href="/my10x10/order/myorderlist.asp" onFocus="this.blur();">
	<area shape="rect" coords="730,52,831,145" href="cs_sub04.html" onFocus="this.blur();">
	<area shape="rect" coords="835,50,947,145" href="#" onFocus="this.blur();" onClick="MM_openBrWindow('event.html','','scrollbars=yes,width=520,height=600')">
</map>
<!-- #include virtual="/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->