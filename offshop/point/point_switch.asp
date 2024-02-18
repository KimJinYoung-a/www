<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/point_switch.asp
' Description : 오프라인샾 point1010 포인트 전환
' History : 2009.07.17 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->
<!-- #include virtual="/offshop/lib/leftmenu/point_loginchk.asp" -->

<%
	If GetLoginUserID() = "" Then
		Response.Write "<script>location.href='point_login.asp?reurl=/offshop/point/point_switch.asp';</script>"
		Response.End
	End If
	
	Dim ClsOSPoint, vPoint, arrPoint, intN
	set ClsOSPoint = new COffshopPoint1010
		ClsOSPoint.FCardNo = vCardNo
		arrPoint = ClsOSPoint.fnGetCardInfo
	set ClsOSPoint = nothing
	vPoint = 0
%>

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
					<td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub05_tit.gif" style="margin-left:10px;"></td>
				</tr>
				<tr>
					<td style="padding:30px 0;" align="center">
						<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="center">
								<table width="660" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><div id="cardImage"></div></td>
									<td align="center">
										<table border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center">
												<%
													Dim vCardImage
													IF isArray(arrPoint) THEN
														For intN =0 To UBound(arrPoint,2)
															If Left(arrPoint(0,intN),4) = "1010" Then
																vCardImage = "card_01.gif"
																'Response.Write "POINT1010 "
															ElseIf Left(arrPoint(0,intN),5) = "32531" Then
																vCardImage = "card_03.gif"
																'Response.Write "아이띵소 "
															Else
																vCardImage = "card_02.gif"
																'Response.Write "오프라인 "
															End If
												%>
															<span class='card_black'>CARD NO. <%=arrPoint(0,intN)%></span><br>
												<%
															vPoint = vPoint + arrPoint(1,intN)
														Next
														
														If intN > 1 Then
															vCardImage = "card_04.gif"
														End If
													End If
												%>
											</td>
										</tr>
										<tr>
											<td style="padding-top:20px;" align="center"><img src="http://fiximage.10x10.co.kr/tenbytenshop/pop_mileage_point.gif" width="122" height="16"></td>
										</tr>
										<tr>
											<td style="padding-top:7px;" align="center"><div style="height:30"><span class="point_bold"><%=FormatNumber(vPoint,0)%></span> <span class="point">point</span></div></td>
										</tr>
										<tr>
											<td style="padding-top:20px;" align="center"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_mileage.gif" width="129" height="24" onClick="Off2On()" style="cursor:pointer"></td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="center" style="padding-top:25px;">
								<table width="660" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="25" bgcolor="#efefef" style="padding-left:10px;" class="space3px">전환가능한 포인트를 확인하신 후, <strong>[온라인 마일리지로 전환]</strong>버튼을 누르시고, 원하는 포인트만큼 마일리지로 전환하시면 됩니다.</td>
								</tr>
								<tr>
									<td style="padding-top:50px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub05_tit01.gif" width="303" height="16"></td>
								</tr>
								<tr>
									<td style="padding-top:15px;">텐바이텐 온라인 쇼핑몰 및 POINT1010의 회원가입이 동시에 되어 있는 경우,<br>
									POINT1010의 포인트를 <strong>마일리지로 전환</strong>(1포인트=1마일리지)하여, <strong>온라인 쇼핑몰 구매시 사용가능</strong>합니다.<br>
									(단, 온라인 쇼핑몰에서 일정금액 이상 구매시 사용 가능합니다.)<br>
									<br>
									<span class="red">한번 전환된 마일리지는 다시 POINT1010 포인트로 전환 불가능하니, 이점 유의하시기 바랍니다.</span><br>
									<br>
									먼저 POINT1010에만 가입하셨더라도, 온라인쇼핑몰에 회원가입을 하시면, 마일리지 전환이 가능합니다</td>
								</tr>
								<tr>
									<td style="padding-top:15px;">
										<% If GetLoginUserID() = "" Then %>
										<a href="/member/join.asp" target="_blank"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_regi.gif" width="129" height="24"></a>
										<% End If %>
									</td>
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
</table>
<script language="javascript">
//document.getElementById("point1").innerHTML = "<span class='point_bold'><%=FormatNumber(vPoint,0)%></span> <span class='point'>point</span>";

<% If vCardImage = "" Then vCardImage = "card_01.gif" End If %>
document.getElementById("cardImage").innerHTML = "<img src='http://fiximage.10x10.co.kr/tenbytenshop/<%=vCardImage%>'>"

function Off2On(){
<% If GetLoginUserID() <> "" Then %>
	<% If vPoint > 0 Then %>
		var popwin = window.open('/my10x10/Pop_offmile2online.asp','offmile2online','width=400,height=340,left=400,top=200,scrollbars=no,resizable=no');
		popwin.focus();
	<% Else %>
	alert("전환할 마일리지가 없습니다.");
	return;
	<% End If %>
<% Else %>
	alert("온라인 쇼핑몰 회원가입을 하셔야 합니다.");
<% End If %>
}
</script>
<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->