<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/user_info.asp
' Description : 오프라인샾 point1010 개인정보수정
' History : 2009.07.17 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/offshop/lib/leftmenu/point_loginchk.asp" -->

<%
dim userid, userpass, vMemberGubun, jumin1, jumin2, vTmp_CardNo
userid = GetLoginUserID
userpass = requestCheckVar(request.Form("userpass"),32)
vMemberGubun = requestCheckVar(Request("membergubun"),1)

If vMemberGubun <> "1" AND vMemberGubun <> "2" THEN
	Response.Write "<script>alert('잘못된 접근입니다.');location.href='"&wwwUrl&"/offshop/';</script>"
	Response.End
END IF

''개인정보보호를 위해 패스워드로 한번더 Check
dim sqlStr, checkedPass, userdiv
dim Enc_userpass
checkedPass = false

If vMemberGubun = "1" Then
		userid = GetLoginUserID
		userpass = requestCheckVar(request.Form("userpass"),32)
		
		''개인정보보호를 위해 패스워드로 한번더 Check
		checkedPass = false

		if (Session("InfoConfirmFlag")<>userid) then
		    ''패스워드없이 쿠키로만 들어온경우
		    if (userpass="") then
		        response.redirect wwwUrl & "/offshop/point/confirmuser.asp"
		        response.end    
		    end if
		    
		    Enc_userpass = MD5(CStr(userpass))
		    
		    ''암호화 사용(MD5)
		    ''sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and Enc_userpass='" & Enc_userpass & "'"

		    ''암호화 사용(SHA256)
		    sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and Enc_userpass64='" & SHA256(Enc_userpass) & "'"

		    rsget.Open sqlStr, dbget, 1
		    if Not rsget.Eof then
		        checkedPass = true
		        userdiv = rsget("userdiv")
		    end if
		    rsget.close
		    
		    ''패스워드올바르지 않음
		    if (Not checkedPass) then
		        response.write "<script>location.replace('" & wwwUrl & "/offshop/point/confirmuser.asp?errcode=1');</script>"
		        response.end    
		    end if
		    
		    ''업체인경우 수정 불가
		    if (userdiv="02") or (userdiv="03") then
		        response.write "<script>alert('업체 및 기타권한은 이곳에서 수정하실 수 없습니다.');</script>"
		        response.end  
		    end if
		
			'// 세션처리후 회원정보 수정 페이지로 GoGo!
		    Session("InfoConfirmFlag") = userid
	    end if
		
ElseIf vMemberGubun = "2" Then
	vTmp_CardNo = requestCheckVar(Request("cardno"),16)
	jumin1 = requestCheckVar(Request("jumin1"),6)
	jumin2 = requestCheckVar(Request("jumin2"),7)
	
		''개인정보보호를 위해 패스워드로 한번더 Check

		checkedPass = false
		
		if (Session("InfoConfirmFlag1")<>vCardNo) then
		    ''패스워드없이 쿠키로만 들어온경우
		    if jumin1="" OR jumin2="" then
		        response.redirect wwwUrl & "/offshop/point/confirmuser.asp"
		        response.end    
		    end if
		    
		    Enc_jumin2 = MD5(CStr(jumin2))
		    
		    ''암호화 사용
			sqlStr = " SELECT Count(*) FROM [db_shop].[dbo].tbl_total_shop_card AS A " & _
					 "		INNER JOIN [db_shop].[dbo].tbl_total_shop_user AS B ON A.UserSeq = B.UserSeq " & _
					 "	WHERE A.CardNo = '" & vTmp_CardNo & "' AND B.Jumin1 = '" & jumin1 & "' AND B.Jumin2_Enc = '" & Enc_jumin2 & "' "
		    rsget.Open sqlStr, dbget, 1
		    if rsget(0) > 0 then
		        checkedPass = true
		    end if
		    rsget.close
		    
		    ''패스워드올바르지 않음
		    if (Not checkedPass) then
		        response.write "<script>location.replace('" & wwwUrl & "/offshop/point/confirmuser.asp?errcode=2');</script>"
		        response.end    
		    end if
	
			'// 세션처리후 회원정보 수정 페이지로 GoGo!
		    Session("InfoConfirmFlag1") = vTmp_CardNo
		elseif Session("InfoConfirmFlag1") = "" AND vCardNo = "" Then
	        response.write "<script>location.replace('" & wwwUrl & "/offshop/point/confirmuser.asp');</script>"
	        response.end
		end if
			
End If


Dim ClsOSPoint, arrPoint, vUserID, intN
Dim vUserSeq, vUserName, vJumin1, vEmail, vTenEYN, vFinEYN, vEmailYN, vTenSYN, vFinSYN, vSMSYN, vTelNo, vHpNo, vZipcode, vAddress, vAddressDetail

	SET ClsOSPoint = new COffshopPoint1010
	If vMemberGubun = "1" Then
		ClsOSPoint.FUserID = Session("InfoConfirmFlag")
	ElseIf vMemberGubun = "2" Then
		ClsOSPoint.FCardNo = Session("InfoConfirmFlag1")
	End If
	ClsOSPoint.FGubun = vMemberGubun
	arrPoint = ClsOSPoint.fnGetMemberInfo()
	
	vUserSeq 		= ClsOSPoint.FUserSeq
	vUserName		= ClsOSPoint.FUserName
	vJumin1		 	= ClsOSPoint.FSSN1
	vEmail	 		= ClsOSPoint.FEmail
	vTenEYN 		= ClsOSPoint.FTenEmailYN
	vFinEYN 		= ClsOSPoint.FFinEmailYN
	vEmailYN 		= ClsOSPoint.FEmailYN
	vTenSYN 		= ClsOSPoint.FTenMobileYN
	vFinSYN 		= ClsOSPoint.FFinMobileYN
	vSMSYN	 		= ClsOSPoint.FMobileYN
	vTelNo	 		= ClsOSPoint.FTelNo
	vHpNo	 		= ClsOSPoint.FHpNo
	vZipcode 		= ClsOSPoint.FZipCode
	vAddress 		= ClsOSPoint.FAddress
	vAddressDetail	= ClsOSPoint.FAddressDetail
	SET ClsOSPoint = nothing
	
	If vUserSeq = "" Then
	    response.write "<script>alert('정보를 가져올 수 없습니다.');</script>"
	    response.end
	End If
	
	vUserID = Session("InfoConfirmFlag")
	vCardNo = Session("InfoConfirmFlag1")
%>

<script language='javascript'>
function ModiImage(){
	window.open("/my10x10/lib/modiuserimage.asp","myimageedit",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=330,height=377');
}

function ChangeMyPass(frm){
	if (frm.oldpass.value.length<1){
		alert('기존 패스워드를 입력하세요.');
		frm.oldpass.focus();
		return;
	}

	if (frm.newpass1.value.length<4){
		alert('새로운 패스워드는 네글자 이상으로 입력하세요.');
		frm.newpass1.focus();
		return;
	}

	if (frm.newpass1.value!=frm.newpass2.value){
		alert('새로운 패스워드가 일치하지 않습니다.');
		frm.newpass1.focus();
		return;
	}

	var ret = confirm('패스워드를 수정하시겠습니까?');

	if(ret){
		frm.submit();
	}
}

function ChangeMyInfo(frm){	

	if (frm.txEmail1.value.length<1){
	    alert("이메일을 입력해주세요.");
		frm.txEmail1.focus();
		return ;
	}
		

	if (frm.txEmail1.value.indexOf('@')>-1){
	    alert("@를 제외한 앞부분만 입력해주세요.");
		frm.txEmail1.focus();
		return ;
	}
			
			
	if ((frm.txEmail2.value == "etc")&&(frm.selfemail.value.length<1)){
	    alert("이메일 도메인을 선택해주시거나 직접 입력해주세요.");
		frm.selfemail.focus();
		return ;
	}
	
	if( frm.txEmail2.value == "etc"){
	    frm.usermail.value = frm.txEmail1.value + '@' + frm.selfemail.value;
	}else{
	    frm.usermail.value = frm.txEmail1.value + frm.txEmail2.value;
	}


	if (frm.userphone1.value.length<2){
		alert('전화번호1을 입력해 주세요.');
		frm.userphone1.focus();
		return;
	}

	if (frm.userphone2.value.length<2){
		alert('전화번호2을 입력해 주세요.');
		frm.userphone2.focus();
		return;
	}

	if (frm.userphone3.value.length<2){
		alert('전화번호3을 입력해 주세요.');
		frm.userphone3.focus();
		return;
	}

	if (frm.usercell1.value.length<2){
		alert('핸드폰번호1을 입력해 주세요.');
		frm.usercell1.focus();
		return;
	}

	if (frm.usercell2.value.length<2){
		alert('핸드폰번호2을 입력해 주세요.');
		frm.usercell2.focus();
		return;
	}

	if (frm.usercell3.value.length<2){
		alert('핸드폰번호3을 입력해 주세요.');
		frm.usercell3.focus();
		return;
	}


	if (frm.txZip2.value.length<3){
		alert('우편번호를 입력해 주세요.');
		frm.txZip2.focus();
		return;
	}

	if (frm.txAddr2.value.length<1){
		alert('나머지 주소를 입력해 주세요.');
		frm.txAddr2.focus();
		return;
	}
	if (GetByteLength(frm.txAddr2.value)>80){
		alert('나머지 주소가 너무 깁니다. 80byte이내로 작성해주세요.\n※한글 1글자는 2byte입니다.');
		frm.txAddr2.focus();
		return;
	}

	var ret = confirm('정보를 수정 하시겠습니까?');
	if (ret){
		frm.submit();
	}
}

function checkSiteComp(comp){
    var frm = comp.form;
    
    
    
    if (comp.value=="Y"){
        
        frm.email_way2way[0].disabled = false;
        frm.email_way2way[1].disabled = false;
        
        frm.smsok_fingers[0].disabled = false;
        frm.smsok_fingers[1].disabled = false;
    }else{
        frm.email_way2way[1].checked = true;
        frm.email_way2way[0].disabled = true;
        frm.email_way2way[1].disabled = true;
        
        frm.smsok_fingers[1].checked = true;
        frm.smsok_fingers[0].disabled = true;
        frm.smsok_fingers[1].disabled = true;
        
    }
}

function disableEmail(frm, comp){
	if (comp.checked){
		frm.email_way2way.checked = false;
		frm.email_10x10.checked = false;
		frm.emailok.value="N";
	}else{
		frm.email_way2way.checked = true;
		frm.email_10x10.checked = true;
		frm.emailok.value="Y";
	}
}


function TnTabNumber(thisform,target,num) {
   if (eval("document.frminfo." + thisform + ".value.length") == num) {
	  eval("document.frminfo." + target + ".focus()");
   }
}

function NewEmailChecker(){
  var frm = document.frminfo;
  if( frm.txEmail2.value == "etc")  {
    frm.selfemail.style.display = '';
    frm.selfemail.focus();
  }else{
    frm.selfemail.style.display = 'none';
  }
  return;
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
                <form name="frminfo" method="post" action="<%=SSLUrl%>/offshop/point/membermodify_process.asp" >
      			<input type="hidden" name="mode" value="infomodi">
      			<input type="hidden" name="membergubun" value="<%=vMemberGubun%>">
      			<input type="hidden" name="userseq" value="<%=vUserSeq%>">
				<tr>
					<td style="padding:30px 0;" align="center">
						<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="padding-bottom:10px;"><span class="222"><strong>텐바이텐 온라인 쇼핑몰 회원일 경우, 수정하신 회원정보가 같이 업데이트 됨을 알려드립니다.</strong></span></td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px solid #eaeaea; border-top: 1px solid #eaeaea;">
										<tr>
											<td width="150" height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px"><font class="red_bold">카드번호</font></span></td>
											<td width="550" style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
											<%
												IF isArray(arrPoint) THEN
													For intN =0 To UBound(arrPoint,2)
											%>
													<span class="red"><%=arrPoint(0,intN)%></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<%
													Next
												END IF
											%>
											</td>
										</tr>
										<tr>
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">성명</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;" class="space3px"><%=vUserName%></td>
										</tr>
										<tr>
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">주민(외국인)등록번호</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;" class="space3px"><%=vJumin1%> - *******</td>
										</tr>
										<% If vMemberGubun = "1" Then %>
										<!--form name="frmpass" method="post" action="<%=SSLUrl%>/my10x10/userinfo/membermodify_process.asp" -->
										<!--온라인 동시 가입일 경우-->
										<tr>
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px"><strong>회원아이디</strong></span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;"><%=vUserID%></td>
										</tr>
										<tr>
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px"><strong>비밀번호</strong></span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input type="password" name="oldpass" class="input_default" style="width:100px;" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);"></td>
													<td style="padding-left:5px;" class="space3px">(공백없는 4~16자의 영문/숫자 조합)</td>
												</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px"><strong>비밀번호확인</strong></span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input type="text" name="newpass1" class="input_default" style="width:100px;" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);"></td>
													<td style="padding-left:5px;" class="space3px">(비밀번호 재입력)
													<!--일치하지않는경우<font class="red_bold">(비밀번호가 일치하지 않습니다.)</font>-->
													<!--사용가능한경우 (비밀번호가 일치합니다.)--></td>
												</tr>
												</table>
											</td>
										</tr>
										<!--온라인 동시 가입일 경우-->
										<!-- /form -->
										<% End If %>
										<tr>
											<td height="110" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">이메일</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<%
													Dim arrEmail, E1, E2
													IF vEmail  <> "" THEN
														arrEmail = split(vEmail,"@")
														E1	= arrEmail(0)
														E2	= arrEmail(1)
													END IF
												%>
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input name="txEmail1" type="text" class="input_default" style="width:95px;ime-mode:disabled" maxlength="32" value="<%=E1%>">
													@
													<input type="hidden" name="usermail" value="<%=vEmail%>">
													<input name="selfemail" type="text" class="input_default" style="width:95px;display:;ime-mode:disabled;" maxlength="80" value="<%=E2%>">
													&nbsp;
													<select name="txEmail2" onchange="NewEmailChecker()" class="input_default" style="width:95px;;">
														<option value="etc">직접입력</option>
														<option value="@hanmail.net" >hanmail.net</option>
														<option value="@naver.com" >naver.com</option>
														<option value="@hotmail.com" >hotmail.com</option>
														<option value="@yahoo.co.kr" >yahoo.co.kr</option>
														<option value="@hanmir.com" >hanmir.com</option>
														<option value="@paran.com" >paran.com</option>
														<option value="@lycos.co.kr" >lycos.co.kr</option>
														<option value="@nate.com" >nate.com</option>
														<option value="@dreamwiz.com" >dreamwiz.com</option>
														<option value="@korea.com" >korea.com</option>
														<option value="@empal.com" >empal.com</option>
														<option value="@netian.com" >netian.com</option>
														<option value="@freechal.com" >freechal.com</option>
														<option value="@msn.com" >msn.com</option>
														<option value="@gmail.com" >gmail.com</option>
													</select></td>
												</tr>
												<tr>
													<td style="padding-top:10px;">
														<table border="0" cellspacing="0" cellpadding="0">
														<% If vMemberGubun = "1" Then %>
														<!--온라인 동시 가입의 경우-->
														<tr>
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="350">텐바이텐(10x10.co.kr)의 이메일 서비스를 받아보시겠습니까?</td>
																	<td style="padding-left:10px;">
																		<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="padding-bottom:2px;"><input type="radio" name="email_10x10" value="Y" <% If vTenEYN = "Y" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="email_10x10" value="N" <% If vTenEYN = "N" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">아니오</td>
																		</tr>
																		</table>
																	</td>
																</tr>
																</table>
															</td>
														</tr>
														<tr>
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="350">핑거스(thefingers.co.kr)의 이메일 서비스를 받아보시겠습니까?</td>
																	<td style="padding-left:10px;">
																		<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="padding-bottom:2px;"><input type="radio" name="email_way2way" value="Y" <% If vFinEYN = "Y" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="email_way2way" value="N" <% If vFinEYN = "N" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">아니오</td>
																		</tr>
																		</table>
																	</td>
																</tr>
																</table>
															</td>
														</tr>
														<!--온라인 동시 가입의 경우-->
														<% End If %>
														<tr>
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="350">POINT1010(텐바이텐가맹점)의 이메일 서비스를 받아보시겠습니까?</td>
																	<td style="padding-left:10px;">
																		<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="padding-bottom:2px;"><input type="radio" name="emailyn" value="Y" <% If vEmailYN = "Y" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="emailyn" value="N" <% If vEmailYN = "N" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">아니오</td>
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
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">전화번호</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;"><input type="text" name="userphone1" onkeyup="TnTabNumber('userphone1','userphone2',3);" maxlength="4" class="input_default" style="width:40px;" value="<%=SplitValue(vTelNo,"-",0)%>">
											-
											<input type="text" name="userphone2" class="input_default" onkeyup="TnTabNumber('userphone2','userphone3',4);"  maxlength="4" style="width:40px;" value="<%=SplitValue(vTelNo,"-",1)%>">
											-
											<input type="text" name="userphone3" class="input_default" maxlength="4" style="width:40px;" value="<%=SplitValue(vTelNo,"-",2)%>"></td>
										</tr>
										<tr>
											<td height="110" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">휴대전화</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input type="text" name="usercell1" onkeyup="TnTabNumber('usercell1','usercell2',3);" maxlength="4" class="input_default" style="width:40px;" value="<%=SplitValue(vHpNo,"-",0)%>">
													-
													<input type="text" name="usercell2" onkeyup="TnTabNumber('usercell2','usercell3',4);"  maxlength="4" class="input_default" style="width:40px;" value="<%=SplitValue(vHpNo,"-",1)%>">
													-
													<input type="text" name="usercell3" maxlength="4" class="input_default" style="width:40px;" value="<%=SplitValue(vHpNo,"-",2)%>"></td>
												</tr>
												<tr>
													<td style="padding-top:10px;">
														<table border="0" cellspacing="0" cellpadding="0">
														<% If vMemberGubun = "1" Then %>
														<!--온라인 동시 가입의 경우-->
														<tr>
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="350">텐바이텐(10x10.co.kr)의 SMS 문자서비스를 받아보시겠습니까?</td>
																	<td style="padding-left:10px;">
																		<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="padding-bottom:2px;"><input type="radio" name="smsok" value="Y" <% If vTenSYN = "Y" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="smsok" value="N" <% If vTenSYN = "N" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">아니오</td>
																		</tr>
																		</table>
																	</td>
																</tr>
																</table>
															</td>
														</tr>
														<tr>
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="350">핑거스(thefingers.co.kr)의 SMS 문자서비스를 받아보시겠습니까?</td>
																	<td style="padding-left:10px;">
																		<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="padding-bottom:2px;"><input type="radio" name="smsok_fingers" value="Y" <% If vFinSYN = "Y" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="smsok_fingers" value="N" <% If vFinSYN = "N" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">아니오</td>
																		</tr>
																		</table>
																	</td>
																</tr>
																</table>
															</td>
														</tr>
														<!--온라인 동시 가입의 경우-->
														<% End If %>
														<tr>
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="350">POINT1010(텐바이텐가맹점)의 SMS 문자서비스를 받아보시겠습니까?</td>
																	<td style="padding-left:10px;">
																		<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="padding-bottom:2px;"><input type="radio" name="psmsyn" value="Y" <% If vSMSYN = "Y" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="psmsyn" value="N" <% If vSMSYN = "N" Then %>checked<% End If %>></td>
																			<td style="padding-left:2px;">아니오</td>
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
											<td height="58" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">주소</span></td>
											<td style="padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="24">
														<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td><input type="text" name="txZip1" class="input_default" style="width:40px;" value="<%= Left(vZipcode,3) %>" readonly>
															-
															<input type="text" name="txZip2"  class="input_default" style="width:40px;" value="<%= Right(vZipcode,3) %>" readonly></td>
															<td style="padding-left:5px;"><a href="javascript:TnFindZip('frminfo');" onfocus="this.blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_post.gif" width="64" height="19"></a></td>
														</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td height="24"><input type="text" name="txAddr1" class="input_default" style="width:200px;" value="<%=vAddress%>" readonly>
													&nbsp;
													<input type="text" name="txAddr2" maxlength="80" class="input_default" style="width:200px;" value="<%=vAddressDetail%>"></td>
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
							<td style="padding-top:10px;" align="center">
								<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><a href="/my10x10/userinfo/confirmuser.asp" onfocus="this.blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_bcancel.gif" width="82" height="23"></a></td>
									<td style="padding-left:5px;"><a href="javascript:ChangeMyInfo(document.frminfo);" onfocus="this.blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_bok.gif" width="82" height="23"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</form>
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