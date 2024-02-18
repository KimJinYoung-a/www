<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'##################################################
' PageName : /offshop/point/card_shopguide.asp
' Description : 오프라인샾 point1010 가맹점안내
' History : 2009.07.17 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/offshop/lib/leftmenu/point_loginchk.asp" -->

<%
dim errcode
errcode = request("errcode")

%>
<script language='javascript'>
function TnConfirmlogin(frm){
	if(frm.membergubun.value == "1")
	{
		if (frm.userpass.value.length<1) {
			alert('패스워드를 입력하세요.');
			frm.userpass.focus();
			return;
		}
	}
	else if(frm.membergubun.value == "2")
	{
		if (frm.jumin1.value.length<1) {
			alert('주민등록번호를 입력하세요.');
			frm.jumin1.focus();
			return;
		}
		if (frm.jumin2.value.length<1) {
			alert('주민등록번호를 입력하세요.');
			frm.jumin2.focus();
			return;
		}
	}
	
	frm.action = '<%=SSLUrl%>/offshop/point/doConfirmUser.asp';
	frm.submit();
}

function gubun(a)
{
	if(div1.style.display == "none")
	{
		frmLoginConfirm.logingubun[a+1].checked = true;
	}
	else
	{
		frmLoginConfirm.logingubun[a-1].checked = true;
	}
	frmLoginConfirm.membergubun.value = a;
}

function jumin()
{
	if(frmLoginConfirm.jumin1.value.length > 5)
	{
		frmLoginConfirm.jumin2.focus();
	}
}
</script>
<script FOR="window" EVENT="onload" LANGUAGE="javascript">
if(frmLoginConfirm.membergubun.value == "1")
{
	document.frmLoginConfirm.userpass.focus();
}
</script>

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
					<td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub07_tit.gif" style="margin-left:10px;"></td>
				</tr>
				<tr>
					<td style="padding:30px 0;" align="center">
					
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="center" style="padding:20px;">
								<!--회원 비밀번호 확인 시작-->
								<table width="289" border="0" cellspacing="0" cellpadding="0">
								<form name="frmLoginConfirm" method="post" action="">
								<input type="hidden" name="membergubun" value="1">
								<tr>
									<td style="padding:25px 0 0 0;">
										<div id="div1" style="display:block">
										<!--온라인회원(아이디/패스워드)-->
										<table width="450" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input type="radio" name="logingubun" onClick="div1.style.display='block';div2.style.display='none';gubun(1);" checked></td>
													<td style="padding-left:10px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_sel_ten_on.gif" width="153" height="14" style="margin-top:2px;"></td>
													<td style="padding-left:25px;"><input type="radio" name="logingubun" onClick="div1.style.display='none';div2.style.display='block';gubun(2);"></td>
													<td style="padding-left:10px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_sel_po.gif" width="167" height="14" style="margin-top:2px;"></td>
												</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td style="padding-top:15px;">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td style="border:5px solid #eeeeee;padding-top:25;" height="150" align="center">
														<table border="0" cellspacing="0" cellpadding="0" width="385">
														<tr>
															<td align="center">
																<table width="320" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_sel_ten_msg.gif" height="27"></td>
																</tr>
																<tr>
																	<td height="110">
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td width="74"><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_ico_id.gif" width="29" height="11" style="margin-left:2px;"></td>
																			<td><input type="text" name="userid" value="<%= getLoginUserID %>" class="input_default" style="width:170px;" maxlength="50" tabindex="1"></td>
																			<td rowspan="3" width="74" align="right"><a href="javascript:TnConfirmlogin(document.frmLoginConfirm);"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_ok.gif" style="width:64;height:49;" tabindex="3"></a></td>
																		</tr>
																		<tr>
																			<td height="10"></td>
																			<td></td>
																		</tr>
																		<tr>
																			<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_ico_pw.gif" width="39" height="11" style="margin-left:2px;"></td>
																			<td><input type="password" name="userpass" class="input_default" style="width:170px;" maxlength="50" tabindex="2" onKeyPress="if (event.keyCode == 13) TnConfirmlogin(frmLoginConfirm);"></td>
																		</tr>
																		</table>
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
										</tr>
										</table><!--온라인회원(아이디/패스워드) 끝-->
										</div>
										<div id="div2" style="display:none">
										<!--포인트1010(카드번호/주민등록번호)-->
										<table width="450" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input type="radio" name="logingubun" onClick="div1.style.display='block';div2.style.display='none';gubun(1);"></td>
													<td style="padding-left:10px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_sel_ten.gif" width="153" height="14" style="margin-top:2px;"></td>
													<td style="padding-left:25px;"><input type="radio" name="logingubun" onClick="div1.style.display='none';div2.style.display='block';gubun(2);"></td>
													<td style="padding-left:10px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_sel_po_on.gif" width="167" height="14" style="margin-top:2px;"></td>
												</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td style="padding-top:15px;">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td style="border:5px solid #eeeeee;padding-top:25;" height="150" align="center">
														<table border="0" cellspacing="0" cellpadding="0" width="385">
														<tr>
															<td align="center">
																<table width="320" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_sel_po_msg.gif"></td>
																</tr>
																<tr>
																	<td height="110">
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td width="74"><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_ico_cn.gif" width="40" height="11" style="margin-left:2px;"></td>
																			<td><input type="text" name="cardno" value="<%=vCardNo%>" class="input_default" style="width:170px;" maxlength="16" tabindex="4"></td>
																			<td rowspan="3" width="74" align="right"><a href="javascript:TnConfirmlogin(document.frmLoginConfirm);"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_ok.gif" style="width:64;height:49;" tabindex="7"></a></td>
																		</tr>
																		<tr>
																			<td height="10"></td>
																			<td></td>
																		</tr>
																		<tr>
																			<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_ico_sn.gif" width="60" height="11" style="margin-left:2px;"></td>
																			<td><input type="text" name="jumin1" onkeyup="jumin()" class="input_default" style="width:80px;" maxlength="6" tabindex="5">&nbsp;-&nbsp;<input type="password" name="jumin2" class="input_default" style="width:80px;" maxlength="7" tabindex="6"></td>
																		</tr>
																		</table>
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
										</tr>
										</table>
										<!--포인트1010(카드번호/주민등록번호) 끝-->
										</div>
									</td>
								</tr>
								</form>
								</table>
								<!--회원 비밀번호 확인 끝-->
							</td>
						</tr>
						<% if (errcode="1") then %>
						<tr>
							<td  align="center">
							<font color="red">비밀번호 오류입니다.</font>
							</td>
						</tr>
						<% Elseif (errcode="2") then %>
						<tr>
							<td  align="center">
							<font color="red">카드번호와 주민등록 번호가 일치하지 않습니다.</font>
							</td>
						</tr>
						<% end if %>      
						<tr>
							<td align="center" style="padding-bottom:20px;">
								<table width="289" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td bgcolor="#f8f8f8" align="center" style="padding:15px;"><font class="red11px02" style="line-height:15px;">회원님의 정보를 안전하게 보호하기 위해<br>
									비밀번호를 다시 한 번 확인합니다.</font></td>
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

<% If errcode = "2" Then %>
<script language="javascript">
div1.style.display='none';
div2.style.display='block';
gubun(2);
</script>
<% End If %>

<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->