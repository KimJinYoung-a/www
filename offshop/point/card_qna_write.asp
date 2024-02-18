<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/card_faq_view.asp
' Description : 오프라인샾 point1010 FAQ 보기
' History : 2009.07.21 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->
<!-- #include virtual="/offshop/lib/leftmenu/point_loginchk.asp" -->

<%
	If GetLoginUserID = "" Then
		Response.Write "<script>location.href='point_login.asp?reurl=/offshop/point/card_qna_write.asp';</script>"
		Response.End
	End If
	
	Dim vAction
	vAction = requestCheckVar(Request("action"),6)
	If vAction = "insert" Then
		Call Proc()
	End If
%>

<script language="javascript">
function checkform(frm1)
{
	if(frm1.title.value == "")
	{
		alert("제목을 입력하세요.");
		frm1.title.focus();
		return false;
	}
	if(frm1.contents.value == "")
	{
		alert("내용을 입력하세요.");
		frm1.contents.focus();
		return false;
	}
	if(frm1.usermail.value == "")
	{
		alert("이메일 주소를 입력하세요.");
		frm1.usermail.focus();
		return false;
	}
    if (!check_form_email(frm1.usermail.value)){
        alert("이메일 주소가 유효하지 않습니다.");
        frm1.usermail.focus();
        return false;
    }
    if (frm1.username.value.length<1) {
        alert("성함을 입력하세요.");
        frm1.username.focus();
        return false;
    }   
}

function check_form_email(email){
	var pos;
	pos = email.indexOf('@');
	if (pos < 0){				//@가 포함되어 있지 않음
		return(false);
	}else{
		
		pos = email.indexOf('@', pos + 1)
		if (pos >= 0)			//@가 두번이상 포함되어 있음
			return(false);
	}


	pos = email.indexOf('.');

	if (pos < 0){				//@가 포함되어 있지 않음
		return false;
    }
	return(true);
}
</script>

<form name="frm1" method="post" action="card_qna_process.asp" onSubmit="return checkform(this);">
<input type="hidden" name="action" value="insert">
<input type="hidden" name="qadiv" value="24">
<input type="hidden" name="mode" value="INS">
<input type="hidden" name="s_orderserial" value="">
<input type="hidden" name="s_itemid" value="">
<input type="hidden" name="orderserial" value="">
<input type="hidden" name="itemid" value="">


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
					<td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub04_tit01.gif" width="108" height="20" style="margin-left:10px;"></td>
				</tr>
				<tr>
					<td align="center">
						<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="210" style="background:url(http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub04_top02.gif) no-repeat;" valign="bottom"></td>
						</tr>
						<tr>
							<td height="330" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
										<tr>
											<td style="border-bottom:1px solid #eaeaea;" height="28" width="100" align="center" class="space3px">제목</td>
											<td style="border-bottom:1px solid #eaeaea;"><input type="text" name="title" value="" class="input_default" style="width:400px;" maxlength="200"></td>
										</tr>
										<tr>
											<td style="border-bottom:1px solid #eaeaea;" height="220" align="center" class="space3px">내용</td>
											<td style="border-bottom:1px solid #eaeaea;"><textarea name="contents" class="input_default" style="width:580px; height:200px;"></textarea></td>
										</tr>
										<tr>
											<td style="border-bottom:1px solid #eaeaea;" height="28" align="center" class="space3px">이메일주소</td>
											<td style="border-bottom:1px solid #eaeaea;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="220"><input type="text" name="usermail" class="input_default" style="width:210px;" value="<%= GetLoginUserEmail() %>" maxlength="200"></td>
													<td style="padding-left:20px;" class="space3px" width="40">성 함</td>
													<td>
														<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td><input type="text" name="username" class="input_default" style="width:100px;" value="<%=GetLoginUserName()%>" maxlength="50"></td>
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
									<td style="padding-top:10px" align="center">
										<table border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><input type="image" src="http://fiximage.10x10.co.kr/tenbytenshop/btn_question.gif" style="width:77;height:20;"></td>
											<td style="padding-left:5px;"><a href="/offshop/point/card_qna.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_cancel.gif" width="77" height="20"></a></td>
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

<%
Function Proc()
	Dim ClsOSPoint, vTitle, vContent, vEmail, vEmailYN, vMobile, vMobileYN
	vTitle 		= html2db(requestCheckVar(Request("title"),200))
	vContent 	= html2db(Request("contents"))
	vEmail 		= requestCheckVar(Request("email"),200)
	vEmailYN	= requestCheckVar(Request("emailyn"),1)
	vMobile		= requestCheckVar(Request("mobile1"),3) & "-" & requestCheckVar(Request("mobile2"),4) & "-" & requestCheckVar(Request("mobile3"),4)
	vMobileYN	= requestCheckVar(Request("mobileyn"),1)
	

	set ClsOSPoint = new COffshopPoint1010
		ClsOSPoint.FTitle		= vTitle
		ClsOSPoint.FContent		= vContent
		ClsOSPoint.FEmail		= vEmail
		ClsOSPoint.FEmailYN		= vEmailYN
		ClsOSPoint.FMobile		= vMobile
		ClsOSPoint.FMobileYN	= vMobileYN
		ClsOSPoint.fnPoint1010QnaInsert
	set ClsOSPoint = nothing
	
	Response.Write "<script>alert('저장되었습니다.');location.href='card_qna.asp';</script>"
	dbget.close
	Response.End
End Function
%>

<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->