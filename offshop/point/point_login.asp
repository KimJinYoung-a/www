<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/point_login.asp
' Description : 오프라인샾 point1010 로그인
' History : 2009.07.20 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->

<%

%>

<script language="javascript">
function gubun(a)
{
	if(div1.style.display == "none")
	{
		frm1.logingubun[a+1].checked = true;
	}
	else
	{
		frm1.logingubun[a-1].checked = true;
	}
	frm1.membergubun.value = a;
}

function checkform(frm1)
{
	if(frm1.membergubun.value == "1")
	{
		if(frm1.userid.value == "")
		{
			alert("아이디를 입력하세요.");
			frm1.userid.focus();
			return false;
		}
		if(frm1.userpass.value == "")
		{
			alert("비밀번호를 입력하세요.");
			frm1.userpass.focus();
			return false;
		}
	}
	else if(frm1.membergubun.value == "2")
	{
		if(frm1.cardno.value == "")
		{
			alert("카드번호를 입력하세요.");
			frm1.cardno.focus();
			return false;
		}
		if(frm1.jumin1.value == "")
		{
			alert("주민등록번호를 입력하세요.");
			frm1.jumin1.focus();
			return false;
		}
		if(frm1.jumin2.value == "")
		{
			alert("주민등록번호를 입력하세요.");
			frm1.jumin2.focus();
			return false;
		}
	}
	frm1.submit();
}

function jumin11()
{
	if(frm1.jumin1.value.length > 5)
	{
		frm1.jumin2.focus();
	}
}
</script>

<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
<form name="frm1" method="post" action="<%=SSLUrl%>/offshop/dologin.asp" onSubmit="return checkform(this);">
<input type="hidden" name="reurl" value="<%=Request("reurl")%>">
<input type="hidden" name="membergubun" value="1">
<tr>
	<td width="170" style="padding-top:41px;" align="center" valign="top">
	<!-- // 왼쪽 메뉴 // -->
	<!-- #include virtual="/offshop/lib/leftmenu/point1010Left.asp" -->
	</td>
	<td width="790" style="padding-top: 30px;" valign="top">
	
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" width="760">
				<table width="730" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_tit.gif" style="margin-left:10px;"></td>
				</tr>
				<tr>
					<td style="padding:0px 0;" align="center">
						<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="center" style="padding-top:40px;"><!--온라인회원(아이디/패스워드)-->
								<table width="450" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td style="border:5px solid #eeeeee;" height="280" align="center">
												<table border="0" cellspacing="0" cellpadding="0" width="385">
												<tr>
													<td align="center" style="border-bottom:1px solid #e2e2e2;">
														<table width="320" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_sel_ten_msg.gif"></td>
														</tr>
														<tr>
															<td height="100">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="74"><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_ico_id.gif" width="29" height="11" style="margin-left:2px;"></td>
																	<td><input type="text" name="userid" class="input_default" style="width:170px;" maxlength="50" tabindex="1"></td>
																	<td rowspan="3" width="74" align="right"><input type="image" src="http://fiximage.10x10.co.kr/tenbytenshop/btn_ok.gif" style="width:64;height:49;" tabindex="3"></td>
																</tr>
																<tr>
																	<td height="10"></td>
																	<td></td>
																</tr>
																<tr>
																	<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/login_ico_pw.gif" width="39" height="11" style="margin-left:2px;"></td>
																	<td><input type="password" name="userpass" class="input_default" style="width:170px;" maxlength="50" tabindex="2"></td>
																</tr>
																</table>
															</td>
														</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td align="center" style="padding-top:30px;">
														<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td><a href="/member/forget.asp" target="_blank">아이디와 비밀번호를 잊으셨나요?</a></td>
															<td align="center"><img src="http://fiximage.10x10.co.kr/tenbytenshop/ico_bar.gif" width="1" height="10" align="absmiddle" hspace="10"></td>
															<td><a href="#" class="link_red11pxb" onClick="myInfoReWrite('1')">아직 회원이 아니세요?</a></td>
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
						<tr>
							<td style="padding-top:40px;" align="center">
								<table width="450" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>텐바이텐 회원이 아니신 고객님은 회원가입 후, 매장에서 발급받으신 POINT1010 카드를 등록하실 수 있습니다.</td>
								</tr>
								<tr>
									<td style="padding-top:10px;">이전에 텐바이텐 매장이나 아이띵소 매장에서 발급하신 카드는 2009년 12월 31일까지 적립 및 사용 가능하며, 
									POINT1010 카드 발급 및 등록시 구 카드의 포인트는 자동으로 신규 POINT1010 카드로 이관 적립됩니다.</td>
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

