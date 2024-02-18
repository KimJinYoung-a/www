<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/card_reg.asp
' Description : 오프라인샾 point1010 카드등록
' History : 2009.07.17 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
	If GetLoginUserID() = "" Then
		Response.Write "<script>alert('로그인을 하세요.');location.href='point_login.asp?reurl=/offshop/point/card_reg_write.asp';</script>"
		Response.End
	End If
	
	Dim arrPoint, intN, ClsOSPoint, vSearching, vUserName, vSSN1, vSSN2, vUserID, vRegdate, vRealNameChk, vUseYN, vGubun, vHaveCardYN, vUserSeq
	vUserName	= requestCheckVar(Request("username"),20)
	vSSN1		= requestCheckVar(Request("userssn1"),6)
	vSSN2		= requestCheckVar(Request("userssn2"),7)
	vGubun		= requestCheckVar(Request("flag"),1)	'### 1은 동시가입, 2는 point1010 만 가입
	vHaveCardYN	= requestCheckVar(Request("havecardyn"),1)

	set ClsOSPoint = new COffshopPoint1010			
		ClsOSPoint.FUserName	= vUserName
		ClsOSPoint.FSSN1		= vSSN1
		ClsOSPoint.FSSN2		= vSSN2
		arrPoint = ClsOSPoint.fnGetUserSilMyung
		
		vUserID 		= ClsOSPoint.FUserID
		vUserName		= ClsOSPoint.FUserName
		vRegdate		= ClsOSPoint.FRegdate
		vRealNameChk	= ClsOSPoint.FRealNameChk
		vUserSeq		= ClsOSPoint.FUserSeq
		
	set ClsOSPoint = nothing
%>

<script language="javascript" SRC="/lib/js/confirm.js"></script>
<script type="text/javascript" src="/lib/js/ajax_List.js"></script>
<script language="javascript">
	
var chkID = false;

document.onkeydown = onKeyDown;
//엔터로  submit 체크
function onKeyDown( event )
{
	var e = event;
	if ( event == null ) e = window.event;
 if ( e.keyCode == 13 ) TnJoin10x10();
}

//아이디 중복확인	
function DuplicateIDCheck(comp){
	var id;
	id = comp.value;

	if (id == ''){
		return;
	}else if((id.length<3) || (id.length>16)){
		alert('아이디는 공백없는 3~15자의 영문/숫자 조합입니다.');
		comp.focus();
	}else{		
		initializeURL("/member/ajaxIdCheck.asp?id="+id);
	   	startRequest();
	}
}
	  
   initializeReturnFunction("processAjax()");
   initializeErrorFunction("onErrorAjax()");
        
    function processAjax(){    	
        var reTxt = xmlHttp.responseText;
        if (reTxt == "3"){
        	document.all.checkMsgID.innerHTML = "  (특수문자나 한글/한문은 사용불가능합니다.)";
        	chkID = false;
        	document.myinfoForm.txuserid.focus();
        }else if(reTxt == "2"){
        	document.all.checkMsgID.innerHTML = " <font class='red11pxb'>(이미 등록된 아이디 입니다.)</font>";
        	chkID = false;
        	document.myinfoForm.txuserid.focus();
        }else{
        	document.all.checkMsgID.innerHTML = "  (사용 가능합니다.)";
        	chkID = true;
        }
        
    }
    
    function onErrorAjax() {
            alert("ERROR : " + xmlHttp.status);
    }

    function jsChkID(comp){
    	if(chkID){
    		document.all.checkMsgID.innerHTML = " (공백없는 3~15자의 영문/숫자 조합) "
    		chkID = false;
    	}
    }

	/*
	 * 소문자로 변환 
	 * index를 지정할 경우 index길이만큼만 소문자로 변환
	 */
	function isToLowerCase(obj, index){

		if(typeof(index) != 'undefined' && index != ""){
			obj.value = 
				obj.value.substring(0, index).toLowerCase() 
				+ obj.value.substring(index, obj.value.length);
			return;
		}

		obj.value = obj.value.toLowerCase();
	}
	
	/*
	 * 이벤트 키코드 체크 
	 */
	function keyCodeCheck(event,id) {
		if(event.keyCode == 13){ 
			DuplicateIDCheck(id);
		}
	}	
function TnJoin10x10(){
	var frm = document.myinfoForm;
	
	if (frm.txCard1.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard1.focus();
		return ;
	}
	
	if (frm.txCard2.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard2.focus();
		return ;
	}
	
	if (frm.txCard3.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard3.focus();
		return ;
	}
	
	if (frm.txCard4.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard4.focus();
		return ;
	}
	
	if (frm.cardnochk.value == "x"){
		alert("카드번호 확인을 하세요.");
		return ;
	}
	
	<% If vGubun = "1" Then %>
	if(!chkID){		
		alert("아이디를 확인해주세요");				
	   	DuplicateIDCheck(frm.txuserid);	   	
	   	return;
	}
	<% End If %>
	
	if (validate(frm)==false) {
		return ;
	}
	
	<% If vGubun = "1" Then %>		 
	if (frm.txpass1.value!=frm.txpass2.value){
		alert("비밀번호가 일치하지 않습니다.");
		frm.txpass1.focus();
		return ;
	}
	<% End If %>

	if (frm.txEmail1.value.indexOf('@')>-1){
	    alert("@를 제외한 앞부분만 입력해주세요...");
		frm.txEmail1.focus();
		return ;
	}
	
	
	if (frm.txEmail2.value == ""){
		alert("이메일 도메인을 선택해주시거나 직접 입력해주세요...");
		frm.txEmail2.focus();
		return ;
	}
	
	if ((frm.txEmail2.value == "etc")&&(frm.selfemail.value.length<1)){
	    alert("이메일 도메인을 선택해주시거나 직접 입력해주세요...");
		frm.selfemail.focus();
		return ;
	}
	
	
	if( frm.txEmail2.value == "etc"){
	    frm.usermail.value = frm.txEmail1.value + '@' + frm.selfemail.value;
	}else{
	    frm.usermail.value = frm.txEmail1.value + frm.txEmail2.value;
	}
	
	if (!check_form_email(frm.usermail.value)){
        alert("이메일 주소가 유효하지 않습니다.");
		frm.selfemail.focus();
		return ;
    }
    
	var ret = confirm('텐바이텐 회원에 가입하시겠습니까?');
	if(ret){
		frm.submit();
	}
}

function jsCardnocheck(){

	var frm = document.myinfoForm;
	
	if (frm.txCard1.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard1.focus();
		return ;
	}
	
	if (frm.txCard2.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard2.focus();
		return ;
	}
	
	if (frm.txCard3.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard3.focus();
		return ;
	}
	
	if (frm.txCard4.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard4.focus();
		return ;
	}
	
	var cardno = frm.txCard1.value + frm.txCard2.value + frm.txCard3.value + frm.txCard4.value;
	iframeDB1.location.href = "iframe_card_check.asp?cardno="+cardno;
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

function enableEmail(frm){
	var emailok;
	emailok = (frm.email_way2way.checked)||(frm.email_10x10.checked);

	if (emailok){
		frm.emailno.checked = false;
		frm.emailok.value="Y";
	}else{
		frm.emailno.checked = true;
		frm.emailok.value="N";
	}

}

function TnTabNumber(thisform,target,num) {
   if (eval("document.myinfoForm." + thisform + ".value.length") == num) {
	  eval("document.myinfoForm." + target + ".focus()");
   }
}


<% If vGubun = "1" Then %>
function TnBirthAuto(){
  if (document.myinfoForm.txJumin1.value != ""){
	 if (document.myinfoForm.txJumin2.value.substr(0,1) == 1 || document.myinfoForm.txJumin2.value.substr(0,1) == 2){
		document.myinfoForm.txBirthday1.value = "19" + document.myinfoForm.txJumin1.value.substr(0,2);
	 }
	 else{
	 	document.myinfoForm.txBirthday1.value = "20" + document.myinfoForm.txJumin1.value.substr(0,2);
	 }
	 document.myinfoForm.txBirthday2.value = document.myinfoForm.txJumin1.value.substr(2,2);
	 document.myinfoForm.txBirthday3.value = document.myinfoForm.txJumin1.value.substr(4,2);
	 document.myinfoForm.txuserid.focus();
  }
}
<% End If %>

function NewEmailChecker(){
  var frm = document.myinfoForm;
  if( frm.txEmail2.value == "etc")  {
    //NewEmailEtc();
    frm.selfemail.style.display = '';
    frm.selfemail.focus();
  }else{
    frm.selfemail.style.display = 'none';
  }
  return;
}

function NewEmailEtc() {
  addr_etc = window.open("/member/lib/etc_email.asp", "win1","status=no,resizable=no,menubar=no,scrollbars=no,width=430,height=250");
  addr_etc.focus();
}


</script>

<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td width="170" style="padding-top:41px;" align="center" valign="top"><!-- // 왼쪽 메뉴 // -->
	<!-- #include virtual="/offshop/lib/leftmenu/point1010Left.asp" -->
	</td>
	<td width="790" style="padding-top: 30px;" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<form name="myinfoForm" method="post" action="<%=SSLUrl%>/offshop/point/dojoin.asp" >
		<input type="hidden" name="hideventid" value="">
		<input type="hidden" name="txName" value="<%=vUserName%>">
		<input type="hidden" name="txJumin1" value="<%= vSSN1 %>">
		<input type="hidden" name="txJumin2" value="<%= vSSN2 %>">
		<input type="hidden" name="flag" value="<%=vGubun%>">
		<input type="hidden" name="cardnochk" value="x">
		<input type="hidden" name="havecardyn" value="<%=vHaveCardYN%>">
		<input type="hidden" name="userseq" value="<%=vUserSeq%>">
		<tr>
			<td align="right" width="760" valign="top">
				<table width="730" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="20%"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub01_tit.gif" style="margin-left:10px;"></td>
							<td width="80%" align="right">
								<!--
								<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/process01.gif" height="13" hspace="5"></td>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/process_arrow.gif" width="6" height="10" hspace="5"></td>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/process03_on.gif" height="13" hspace="5"></td>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/process_arrow.gif" width="6" height="10" hspace="5"></td>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/process04.gif" height="13" hspace="5"></td>
								</tr>
								</table>
								//-->
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="padding:30 0 15 0;" align="center">
					
						<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="padding-bottom:3px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub01_tit07.gif" width="150" height="16"></td>
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
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input type="text" name="txCard1" id="[on,off,1,4][카드번호1]" class="input_default" style="width:60px;" maxlength="4">
													-
													<input type="text" name="txCard2" id="[on,off,1,4][카드번호2]" class="input_default" style="width:60px;" maxlength="4">
													-
													<input type="text" name="txCard3" id="[on,off,1,4][카드번호3]" class="input_default" style="width:60px;" maxlength="4">
													-
													<input type="text" name="txCard4" id="[on,off,1,4][카드번호4]" class="input_default" style="width:60px;" maxlength="4"></td>
													<td style="padding-left:5px;"><a href="javascript:jsCardnocheck();" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_card.gif" width="64" height="19"></a></td>
												</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">성명</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;" class="space3px"><%=vUserName%></td>
										</tr>
										<tr>
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">주민(외국인)등록번호</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;" class="space3px"><%=vSSN1%> - *******</td>
										</tr>
										<% If vGubun = "1" Then %>
										<!--온라인 동시 가입일 경우-->
										<tr>
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">생년월일</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
			                            		<table border="0" cellspacing="0" cellpadding="0">
			                                	<tr>
		                                  			<td><select name="txSolar" class="input_default" style="width:50px;">
                                  						<option value="Y" selected >양력</option>
                                  						<option value="N">음력</option>
                              							</select>
                              						</td>
                              						<td style="padding-left:8px;"><input name="txBirthday1" id="[on,on,4,4][태어난해]" type="text" class="input_default" style="width:50px;" maxlength="4">&nbsp;&nbsp;년</td>
				                                  	<td style="padding-left:8px;"><input name="txBirthday2" id="[on,on,2,2][태어난달]" maxlength="2" type="text" class="input_default" style="width:30px;">&nbsp;&nbsp;월</td>
				                                  	<td style="padding-left:8px;"><input name="txBirthday3" id="[on,on,2,2][태어난일]" maxlength="2" type="text" class="input_default" style="width:30px;">&nbsp;&nbsp;일</td>
												</tr>
			                              		</table>
											</td>
										</tr>
										<tr>
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px"><strong>회원아이디</strong></span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input type="text" name="txuserid" id="[on,off,3,16][아이디]" style="width:100px;ime-mode:disabled" class="input_default" maxlength="16" onKeyDown="keyCodeCheck(event,this);" onKeyUp="jsChkID(this);"  onClick="jsChkID(this);" onBlur="isToLowerCase(this, 0); DuplicateIDCheck(this);"></td>
													<td style="padding-left:5px;" class="space3px"><span id="checkMsgID" >(공백없는 3~15자의 영문/숫자 조합)</span>
													<!--중복아이디인경우<font class="red_bold">(이미 등록된 아이디 입니다.)</font>-->
													<!--사용가능한경우 (사용 가능합니다.)--></td>
												</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px"><strong>비밀번호</strong></span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input type="password" name="txpass1" id="[on,off,4,16][비밀번호]"  maxlength="16" class="input_default" style="width:100px;"></td>
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
													<td><input type="password" name="txpass2" id="[on,off,4,16][비밀번호 확인]"  maxlength="16" class="input_default" style="width:100px;"></td>
													<td style="padding-left:5px;" class="space3px">(비밀번호 재입력)
													<!--일치하지않는경우<font class="red_bold">(비밀번호가 일치하지 않습니다.)</font>-->
													<!--사용가능한경우 (비밀번호가 일치합니다.)--></td>
												</tr>
												</table>
											</td>
										</tr>
										<!--온라인 동시 가입일 경우-->
										<% Else %>
										<input type="hidden" name="txuserid" value="<%=vUserID%>">
										<% End If %>
										<tr>
											<td style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">이메일</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input name="txEmail1" id="[on,off,off,off][이메일]"  type="text" class="input_default" style="width:95px;ime-mode:disabled;" maxlength="32">
													@
													<input type="hidden" name="usermail" value="">
													<input name="selfemail" id="[off,off,off,off][직접입력]" type="text" class="input_default" style="width:95px;display:none;ime-mode:disabled;" maxlength="80">
													&nbsp;
													<select name="txEmail2" onchange="NewEmailChecker()" class="input_default" style="width:95px;;">
		                                                <option value="" selected>선택해 주세요</option>
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
		                                                <option value="etc">직접입력</option>
													</select></td>
												</tr>
												<tr>
													<td style="padding-top:10px;">
														<table border="0" cellspacing="0" cellpadding="0">
														<% If vGubun = "1" Then %>
														<!--온라인 동시 가입의 경우-->
														<tr>
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="350">텐바이텐(10x10.co.kr)의 이메일 서비스를 받아보시겠습니까?</td>
																	<td style="padding-left:10px;">
																		<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="padding-bottom:2px;"><input type="radio" name="email_10x10" value="Y" checked></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="email_10x10" value="N"></td>
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
																			<td style="padding-bottom:2px;"><input type="radio" name="email_way2way" value="Y" checked></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="email_way2way" value="N"></td>
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
																			<td style="padding-bottom:2px;"><input type="radio" name="email_point1010" value="Y" checked></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="email_point1010" value="N"></td>
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
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;"><input name="txPhone1" id="[on,on,2,3][전화번호1]"  type="text" class="input_default" style="width:40px;" onkeyup="TnTabNumber('txPhone1','txPhone2',3);"  maxlength="3">
											-
											<input name="txPhone2" id="[on,on,2,4][전화번호2]"  maxlength="4"  onkeyup="TnTabNumber('txPhone2','txPhone3',4);"  type="text" class="input_default" style="width:40px;">
											-
											<input name="txPhone3" id="[on,on,2,4][전화번호3]" maxlength="4"  onkeyup="TnTabNumber('txPhone3','txCell1',4);" type="text" class="input_default" style="width:40px;"></td>
										</tr>
										<tr>
											<td style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">휴대전화</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input name="txCell1" id="[on,on,2,3][핸드폰번호1]" maxlength="3" onkeyup="TnTabNumber('txCell1','txCell2',3);"  type="text" class="input_default" style="width:40px;">
													-
													<input name="txCell2" id="[on,on,2,4][핸드폰번호2]" maxlength="4" onkeyup="TnTabNumber('txCell2','txCell3',4);" type="text" class="input_default" style="width:40px;">
													-
													<input name="txCell3" id="[on,on,2,4][핸드폰번호3]" maxlength="4" type="text" class="input_default" style="width:40px;"></td>
												</tr>
												<tr>
													<td style="padding-top:10px;">
														<table border="0" cellspacing="0" cellpadding="0">
														<% If vGubun = "1" Then %>
														<!--온라인 동시 가입의 경우-->
														<tr>
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="350">텐바이텐(10x10.co.kr)의 SMS 문자서비스를 받아보시겠습니까?</td>
																	<td style="padding-left:10px;">
																		<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="padding-bottom:2px;"><input type="radio" name="smsok" value="Y" checked></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="smsok" value="N"></td>
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
																			<td style="padding-bottom:2px;"><input type="radio" name="smsok_fingers" value="Y" checked></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="smsok_fingers" value="N"></td>
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
																			<td style="padding-bottom:2px;"><input type="radio" name="smsok_point1010" value="Y" checked></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="smsok_point1010" value="N"></td>
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
															<td><input name="txZip1"  id="[on,on,3,3][우편번호1]" readonly  type="text" class="input_default" style="width:40px;">
															-
															<input name="txZip2"  id="[on,on,3,3][우편번호2]" readonly  type="text" class="input_default" style="width:40px;"></td>
															<td style="padding-left:5px;"><a href="javascript:TnFindZip('myinfoForm');"" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_post.gif" width="64" height="19"></a></td>
														</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td height="24"><input name="txAddr1" id="[on,off,1,64][주소1]" readonly type="text" class="input_default" style="width:200px;">
													&nbsp;<input name="txAddr2" id="[on,off,1,64][주소2]"   maxlength="80" type="text" class="input_default" style="width:200px;ime-mode:active"></td>
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
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center">
						<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><a href="/offshop/point/card_reg.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_regican.gif" width="82" height="23"></a></td>
							<td style="padding-left:5px;"><a href="javascript:TnJoin10x10()" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_regiok.gif" width="82" height="23"></a></td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</td>
			<td width="30" valign="top"><div style="position:absolute; width:55px; height:95px; top:115px; margin-left:10px;"> <img src="http://fiximage.10x10.co.kr/tenbytenshop/object_sticker.gif" width="55" height="95"> </div></td>
		</tr>
		</form>
		</table>
	</td>
</tr>
</table>
<% if (vSSN1 <> "") AND vGubun = "1" then %>
<script>
TnBirthAuto();
</script>
<% end if %>
<iframe name="iframeDB1" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" onload="resizeIfr(this, 10)"></iframe>
<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
