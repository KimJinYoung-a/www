<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>

<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/header.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/member/iPin/nice.nuguya.oivs.asp" -->

<%
dim userid, userpass
userid = getEncLoginUserID
userpass = requestCheckVar(request.Form("userpass"),32)


'####### POINT1010 에서 넘어온건지 체크 #######
Dim pFlag, vParam
pFlag	= requestCheckVar(request("pflag"),1)
If pFlag = "o" Then
vParam	= "?pflag=o"
End If
If pFlag = "g" Then
	Response.Redirect "/offshop/point/point_search.asp"
	Response.End
End If
'####### POINT1010 에서 넘어온건지 체크 #######


''개인정보보호를 위해 패스워드로 한번더 Check
dim sqlStr, checkedPass, userdiv
dim Enc_userpass
checkedPass = false

dim EcChk : EcChk = TenDec(request.Cookies("tinfo")("EcChk"))

if (LCase(Session("InfoConfirmFlag"))<>LCase(userid)) and (LCase(EcChk)<>LCase(userid)) then
    ''패스워드없이 쿠키로만 들어온경우
    if (userpass="") then
        response.redirect "/my10x10/userinfo/confirmuser.asp" & vParam
        response.end    
    end if
    
    Enc_userpass = MD5(CStr(userpass))
    
    ''비암호화
    ''sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and userpass='" & userpass & "'"
    
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
        response.redirect wwwUrl & "/my10x10/userinfo/confirmuser.asp?errcode=1" & Replace(vParam,"?","&") & ""
        response.end    
    end if
    
    ''업체인경우 수정 불가
    if (userdiv="02") or (userdiv="03") then
        response.write "<script>alert('업체 및 기타권한은 이곳에서 수정하실 수 없습니다.');</script>"
        response.end  
    end if
    Session("InfoConfirmFlag") = userid
end if


dim myUserInfo
set myUserInfo = new CUserInfo
myUserInfo.FRectUserID = userid
if (userid<>"") then
    myUserInfo.GetUserData 
end if

dim oAllowsite
dim IsAcademyUsing
IsAcademyUsing = true  ''Default True

set oAllowsite = new CUserInfo
oAllowsite.FRectUserID = userid
oAllowsite.FRectSitegubun = "academy"
if (userid<>"") then
    oAllowsite.GetOneAllowSite 
    
    if (oAllowsite.FOneItem.Fsiteusing="N") then IsAcademyUsing=false
end if

set oAllowsite = Nothing

Dim arrEmail, E1, E2
IF myUserInfo.FOneItem.FUsermail  <> "" THEN
	arrEmail = split(myUserInfo.FOneItem.FUsermail,"@")
	if ubound(arrEmail)>0 then
		E1	= arrEmail(0)
		E2	= arrEmail(1)
	end if
END IF	

if (myUserInfo.FResultCount<1) then
    response.write "<script>alert('정보를 가져올 수 없습니다.');</script>"
    response.end
end if

'네비바 내용 작성
strMidNav = "MY 개인정보 > <b>개인정보 수정</b>"


	'#######################################################################################
	'#####	개인인증키(대체인증키;아이핀) 서비스				한국신용정보(주)
	'#######################################################################################
	'####### 실명인증 사용여부 ("N"으로하면 실명확인 없이 패스~) #######
	Dim rnflag
	rnflag	= "Y"
	Dim NiceId, SIKey, ReturnURL, pingInfo, strOrderNo
	'// 텐바이텐
	NiceId = "Ntenxten4"		'// 회원사 ID
	SIKey = "N0001N013276"		'// 사이트식별번호 12자리

	ReturnURL = wwwUrl & "/member/iPin/popIPinCheck_memmodify.asp?pFlag=" & pFlag '// 한국신용정보(주)로 부터 서비스처리 결과를 전달 받아 처리할 페이지
	On Error Resume Next
		pingInfo = getPingInfo()
		If Err.Number>0 Then
	        rnflag="N"
		end if
	on error Goto 0

	randomize(time())     
	strOrderNo = Replace(date, "-", "")  & round(rnd*(999999999999-100000000000)+100000000000)
	session("niceOrderNo") = strOrderNo
%>
<!--	==========================================================	-->
<!--	한국신용정보주식회사 처리 모듈                            	-->
<!--	==========================================================	-->
<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.msgg.utf8.js"></script>
<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script> 


<script language='javascript'>
$(document).unbind("dblclick");
function ModiImage(){
	window.open("/my10x10/lib/modiuserimage.asp","myimageedit",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=330,height=377');
}

function ChangeMyPass(frm){
	if (frm.oldpass.value.length<1){
		alert('기존 패스워드를 입력하세요.');
		frm.oldpass.focus();
		return;
	}

	if (frm.newpass1.value.length<6){
		alert('새로운 패스워드는 여섯글자 이상으로 입력하세요.');
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

// ---------- 아이핀 관련 스크립트
<% if pingInfo="" then %>
	alert( "한국신용정보(주)의 개인인증키 서비스가 점검중입니다.\n잠시후 다시 시도하시기 바랍니다.\n\n상태가 계속되면 사이트관리자에게 문의하십시오" );
<% end if %>	

function iPinValidate()
{
	var NiceId		= document.getElementById( "NiceId" );
	var PingInfo	= document.getElementById( "PingInfo" );
	var ReturnURL	= document.getElementById( "ReturnURL" );

	if ( NiceId.value == "" )
	{
		alert( getCheckMessage( "S60" ) );
		NiceId.focus();
		return false;
	}

	if ( PingInfo.value == "" )
	{
		alert( getCheckMessage( "S61" ) );
		return false;
	}

	if ( ReturnURL.value == "" )
	{
		alert( getCheckMessage( "S64" ) );
		ReturnURL.focus();
		return false;
	}

	return true;
}

function goIDCheck()
{
    var frmagree = document.frmagree;

	if ( iPinValidate() == true )
	{
		var strNiceId 	= document.getElementById( "NiceId" ).value;
		var strPingInfo	= document.getElementById( "PingInfo" ).value;
		var strOrderNo	= document.getElementById( "OrderNo" ).value;
		var strInqRsn	= document.getElementById( "InqRsn" ).value;
		var strReturnUrl= document.getElementById( "ReturnURL" ).value;
		var strSIKey 	= document.getElementById( "SIKey" ).value;

		document.reqForm.SendInfo.value = makeCertKeyInfoPA( strNiceId, strPingInfo, strOrderNo, strInqRsn, strReturnUrl, strSIKey );
		document.reqForm.ProcessType.value = strPersonalCertKey;

		var popupWindow = window.open( "", "popupCertKey", "top=100, left=200, status=0, width=417, height=490" );
		document.reqForm.target = "popupCertKey";
		document.reqForm.action = strCertKeyServiceUrl;
		document.reqForm.submit();
		popupWindow.focus();
	}

	return;
}

function ChangeMyInfo(frm){	
	if (frm.username.value.length<2){
		alert('이름을 입력해 주세요.');
		frm.username.focus();
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

 

	if (frm.userbirthday1.value.length!=4){
		alert('생년월일을 정확히 입력해주세요.');
		frm.userbirthday1.focus();
		return;
	}

	if (frm.userbirthday2.value.length!=2){
		alert('생년월일을 정확히 입력해주세요.');
		frm.userbirthday2.focus();
		return;
	}

	if (frm.userbirthday3.value.length!=2){
		alert('생년월일을 정확히 입력해주세요.');
		frm.userbirthday3.focus();
		return;
	}

	if (frm.oldpass.value.length < 1){
		alert('정보를 변경 하시려면 기존 비밀번호를 입력해주세요.');
		frm.oldpass.focus();
		return;
	}
    
    <% if (IsAcademyUsing) then %>
    if (frm.allow_other[1].checked){
        alert('핑거스 아케데미 서비스를 이용하지않음 으로 설정하실 경우 \n핑거스 아카데미 로그인 및 관련 서비스를 이용하실 수 없습니다.');
    }
    <% end if %>
    
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
<table border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
	<td width="960">
	<!----- 마이텐바이텐 타이틀 시작 ----->
	<!-- #include virtual ="/lib/topMenu/top_my10x10.asp" -->
	<!----- 마이텐바이텐 타이틀 끝 ----->
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="mar_top_20px">
      		<tr>
        		<td>
        			<table width="100%" border="0" cellspacing="0" cellpadding="0">
          			<tr>
					<td width="180" valign="top" style="padding-right:20px">
			            	<!----- 레프트 시작 ----->
			            	<!-- #include virtual ="/lib/leftmenu/left_my10x10.asp" -->
			            	<!----- 레프트 끝 ----->
			            	</td>
			            	<!----- Contents 시작 ----->
            <td width="780" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<!-- My10x10 메뉴 -->
					<!-- #include virtual ="/lib/topmenu/Menu_my10x10.asp" -->
					</td>
				</tr>
              <tr>
                <td class="pdd_top_30px">
				                      	<table width="100%" border="0" cellspacing="0" cellpadding="0">
				                          	<tr>
				                            	<td style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2010/mytenbyten/title_main18.gif"></td>
				                          	</tr>
				                          	<tr>
				                            	<td style="padding-bottom:20px;line-height:16px">고객님의 주소와 연락처 등 개인정보를 수정하실 수 있습니다.<br>
				                              		핸드폰 번호와 이메일은 한번 더 꼭 확인하셔서 주문하신 상품에 대한 배송 안내와 다양한 이벤트정보를 제공해 드리는<br>
				                              		SMS, 메일서비스 혜택을 받으시기 바랍니다.</td>
				                          	</tr>
				                        	</table>
							</td>
						</tr>
				              <tr>
				              	<td>
				              		<table width="100%" border="0" cellspacing="0" cellpadding="0">
				              		<form name="frmpass" method="post" action="<%=SSLUrl%>/my10x10/userinfo/membermodify_process.asp" >
				              		<input type="hidden" name="mode" value="passmodi">
				              		<input type="hidden" name="pflag" value="<%=pFlag%>">
				                          	<tr>
				                            	<td style="padding-bottom:5px;"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main18_01.gif" width="96" height="17"></td>
				                          	</tr>
				                          	<tr>
				                            	<td><!--비밀번호 수정 시작-->
				                              		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:solid 1px #eaeaea; border-top:solid 3px #be0808;">
				                                		<tr>
				                                  			<td width="150" height="31" style="border-bottom:solid 1px #eaeaea;" bgcolor="#fcf6f6"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main18_01_01.gif" width="58" height="11" class="table_20px"></td>
				                                  			<td width="610" style="padding-left:20px; border-bottom:solid 1px #eaeaea;"><input type="password" name="oldpass" maxlength="32" class="input_margin" style="width:120px;" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);">
				                                    			&nbsp;&nbsp;(기존 비밀번호 입력)</td>
				                                		</tr>
				                                		<tr>
				                                  			<td width="150" height="31" style="border-bottom:solid 1px #eaeaea;" bgcolor="#fcf6f6"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main18_01_02.gif" width="48" height="11" class="table_20px"></td>
				                                  			<td width="610" style="padding-left:20px; border-bottom:solid 1px #eaeaea;"><input  type="password" name="newpass1" maxlength="32" class="input_margin" style="width:120px;" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);">
				                                    			&nbsp;&nbsp;(새 비밀번호 입력, 공백없는 6~16자의 영문/숫자 조합)</td>
				                                		</tr>
				                                		<tr>
				                                  			<td width="150" height="31" bgcolor="#fcf6f6"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main18_01_03.gif" width="70" height="11" class="table_20px"></td>
				                                  			<td width="610" style="padding-left:20px;;"><input type="password"  name="newpass2"  maxlength="32"  class="input_margin" style="width:120px;" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);"></td>
				                                		</tr>
				                              		</table>
				                              		<!--비밀번호수정 끝-->
				                              	</td>
				                          	</tr>
				                          	<tr>
				                            	<td align="center" style="padding-top:12px;">
				                            		<table border="0" cellspacing="0" cellpadding="0">
				                                		<tr>
				                                  			<td><a href="javascript:ChangeMyPass(document.frmpass);" onfocus="this.blur()"><img src="http://fiximage.10x10.co.kr/web2009/order/btn_modiry02.gif" width="58" height="24"></a></td>
				                                  			<td style="padding-left:10px;"><a href="/my10x10/userinfo/confirmuser.asp" onfocus="this.blur()"><img src="http://fiximage.10x10.co.kr/web2009/order/btn_cancel02.gif" width="58" height="24"></a></td>
				                                		</tr>
				                              		</table>
				                              	</td>
				                          	</tr>
				                        	</form>
				                        	</table>
							</td>
						</tr>
						<% If myUserInfo.FOneItem.Fipincheck = "N" Then %>
						<tr><!-- ### 아이핀 인증 ### //-->
							<td style="padding-top:20px;"><img src="http://fiximage.10x10.co.kr/web2011/mytenbyten/tit_ipin.gif" width="176" height="17"></td>
						</tr>
						<tr>
							<td style="padding-top:5px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:solid 1px #eaeaea; border-top:solid 3px #be0808;">
								<tr>
									<td align="center" style="padding:20px 0;">아이핀(i-PIN)은 방송통신위원회에서 주관하는 주민등록번호 대체 수단으로 고객님의 주민등록번호 대신<br>
									아이핀 ID를 한국 신용정보㈜로부터 발급받아 본인 확인을 하는 서비스입니다.<br>
									<br>
									아이핀(i-PIN)으로 전환할 경우, <span class="black_11px_bold">고객님의 주민등록번호가 삭제</span>되며 아이핀 정보가 저장됩니다.<br>
									<img src="http://fiximage.10x10.co.kr/web2011/mytenbyten/btn_ipin.gif" width="262" height="41" style="margin-top:12px;cursor:pointer;" onclick="javascript:goIDCheck();"></td>
								</tr>
								<FORM id="reqForm" name="reqForm" method="POST" action="">
								<input class="small" type="hidden" id="SendInfo" name="SendInfo" >
								<input class="small" type="hidden" id="ProcessType" name="ProcessType" >
								</FORM>
								<FORM id="pageForm" name="pageForm" method="POST" action="">
								<INPUT type="hidden" id="NiceId" name="NiceId" value="<%= NiceId %>">
								<INPUT type="hidden" id="SIKey" name="SIKey" value="<%= SIKey %>">
								<INPUT type="hidden" id="PingInfo" name="PingInfo" value="<%= pingInfo %>">
								<INPUT type="hidden" id="ReturnURL" name="ReturnURL" value="<%= ReturnURL %>" >
								<input type="hidden" id="InqRsn" name="InqRsn" value="10">
								<input type="hidden" id="OrderNo" name="OrderNo" value="<%=strOrderNo%>">
								</form>
								</table>
							</td>
						</tr><!-- ### 아이핀 인증 ### //-->
						<% End If %>
				              <tr>
				              	<td style="padding-top:20px;">
				              		<table width="100%" border="0" cellspacing="0" cellpadding="0">
				                          	<tr>
				                            	<td style="padding-bottom:5px;"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main18_02.gif" width="96" height="17"></td>
				                          	</tr>
				                          	<tr>
				                            	<td><!--나의정보관리 시작-->
				                              		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-top:solid 3px #be0808;border-bottom:1px solid #eaeaea;">
				                              		<form name="frminfo" method="post" action="<%=SSLUrl%>/my10x10/userinfo/membermodify_process.asp" >
						      				<input type="hidden" name="mode" value="infomodi">
						      				<input type="hidden" name="pflag" value="<%=pFlag%>">
				                                		<tr>
				                                  			<td width="150" height="31" bgcolor="#fcf6f6" style="border-bottom:1px solid #eaeaea;"><img src="http://fiximage.10x10.co.kr/web2009/member/join_form_name.gif" width="19" height="11" class="table_20px"></td>
				                                  			<td width="610" style="border-bottom:1px solid #eaeaea;padding:3px 0 0 20px;">
                  												<input type="text" name="username" class="input_margin" value="<%= myUserInfo.FOneItem.FUserName %>" size=10 style="ime-mode:active" <% if GetLoginRealNameCheck="Y" then Response.Write "readonly" %>>
				                                  			</td>
				                                		</tr>
				                                		<tr>
				                                  			<td height="55" bgcolor="#fcf6f6" style="border-bottom:1px solid #eaeaea;"><img src="http://fiximage.10x10.co.kr/web2009/member/join_form_birth.gif" width="38" height="11" class="table_20px"></td>
				                                  			<td style="border-bottom:1px solid #eaeaea;padding:0 1px 0 20px;">
				                                  				<table border="0" cellspacing="0" cellpadding="0">
				                                      			<tr>
				                                        				<td>
				                                        					<select name="issolar"  id="select" class="input_default" style="width:50px;">
											                          <option value="Y" <% if myUserInfo.FOneItem.Fissolar="Y" then response.write "selected" %>>양력</option>
											                          <option value="N" <% if myUserInfo.FOneItem.Fissolar="N" then response.write "selected" %>>음력</option>
											                        </select>
				                   							 </td>
				                   							<td style="padding-left:8px;"><input name="userbirthday1" type="text" class="input_margin" style="width:50px;"  value="<%= SplitValue(myUserInfo.FOneItem.FBirthDay,"-",0) %>" maxlength="4"" />
							                                          &nbsp;&nbsp;년</td>
							                                        	<td style="padding-left:8px;"><input name="userbirthday2" type="text" class="input_margin" style="width:30px;" value="<%= SplitValue(myUserInfo.FOneItem.FBirthDay,"-",1) %>" maxlength="2" />
							                                          &nbsp;&nbsp;월</td>
							                                        	<td style="padding-left:8px;"><input name="userbirthday3" type="text" class="input_margin" style="width:30px;" value="<%= SplitValue(myUserInfo.FOneItem.FBirthDay,"-",2) %>" maxlength="2" />
							                                          &nbsp;&nbsp;일</td>		
							                                          <td width="200"></td>	                                        	
				                              				</tr>
				                                      			<tr>
				                                        				<td colspan="5" style="padding-top:5px;" class="red_11px">등록된 생일에 <strong>생일 축하 쿠폰</strong>을 선물로 드립니다. &nbsp; ( 생일축하쿠폰은 연1회 발급됩니다.)</td>
				                                      			</tr>
				                                    			</table>
				                                    		</td>
				                                		</tr>
				                                		<tr>
				                                  			<td height="80" bgcolor="#fcf6f6" style="border-bottom:1px solid #eaeaea;"><img src="http://fiximage.10x10.co.kr/web2009/member/join_form_add.gif" width="20" height="12" class="table_20px"></td>
				                                  			<td style="padding:0 0 0 20px;border-bottom:1px solid #eaeaea;">
				                                  				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				                                      			<tr> <!-- 주소 -->
				                                        				<td style="padding-bottom:3px;">
				                                        					<table border="0" cellspacing="0" cellpadding="0">
				                                            				<tr>
				                                              					<td><input  name="txZip1" value="<%= Left(myUserInfo.FOneItem.Fzipcode,3) %>" readonly  type="text" class="input_margin" style="width:30px;">
				                                                						-
				                                                						<input  name="txZip2" value="<%= Right(myUserInfo.FOneItem.Fzipcode,3) %>" readonly  type="text" class="input_margin" style="width:30px;"></td>
				                                              					<td style="padding:2px 0 0 7px;"><a href="javascript:TnFindZip('frminfo');" onfocus="this.blur()"><img src="http://fiximage.10x10.co.kr/web2009/member/btn_zip.gif" width="72" height="21"></a></td>
				                                            				</tr>
				                                          				</table>
				                                          			</td>
				                                      			</tr>
				                                      			<tr>
				                                        				<td><input  name="txAddr1" value="<%= myUserInfo.FOneItem.FAddress1 %>" readonly  type="text" class="input_margin" style="width:160px;">
								                                          &nbsp;
								                                          <input name="txAddr2" value="<%= myUserInfo.FOneItem.FAddress2 %>"  maxlength="80" style="ime-mode:active;width:290px;" type="text" class="input_margin" >
				                                        				</td>
				                                      			</tr>
				                                      			<tr>
				                                        				<td style="padding-top:5px;">주소(기본배송시)는 구입하신 상품이나 이벤트 경품등의 배송시 사용됩니다. 정확하게 입력하시기 바랍니다 </td>
				                                      			</tr>
				                                    			</table>
				                                    		</td>
				                                		</tr>
				                                		<tr> <!-- 이메일 -->
				                                  			<td height="125" bgcolor="#fcf6f6" style="border-bottom:1px solid #eaeaea;"><img src="http://fiximage.10x10.co.kr/web2009/member/join_form_email.gif" width="30" height="11" class="table_20px"></td>
				                                  			<td style="border-bottom:1px solid #eaeaea;padding:0 0 3px 20px;">
				                                  				<table border="0" cellspacing="0" cellpadding="0" width="100%">
				                                      			<tr>
				                                        				<td height="30"><input  name="txEmail1" type="text" value="<%=E1%>"  class="input_margin" style="width:95px;ime-mode:disabled" maxlength="32">
				                                        					@
				                                          				<input type="hidden" name="usermail" value="<%= myUserInfo.FOneItem.FUsermail %>">
							                                    		<input name="selfemail" type="text" class="input_margin" style="width:95px;ime-mode:disabled;" maxlength="80"  value="<%=E2%>">
							                                    		&nbsp;
							                                    		<select name="txEmail2" onchange="NewEmailChecker()"  style="border:1px #cccccc solid;font-family:dotum;COLOR:#888888;width:95px;position:relative;bottom:2px">
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
								                                          </select>      
				                                          			</td>
				                                      			</tr>
                                      							<tr>
                                        								<td height="20" style="padding-top:2px;">
                                        									<table border="0" cellspacing="0" cellpadding="0">
                                            								<tr>
                                              									<td><img src="http://fiximage.10x10.co.kr/web2009/member/bullet_grey.gif" align="absmiddle"></td>
                                              									<td style="padding-left:7px;" width="360">텐바이텐(10x10.co.kr)의 이메일 서비스를 받아보시겠습니까?</td>
                                              									<td>
                                              										<table border="0" cellspacing="0" cellpadding="0">
									                                                  <tr>
									                                                    <td style="padding-bottom:2px;"><input type="radio" name="email_10x10" value="Y" <%= ChkIIF(myUserInfo.FOneItem.Femail_10x10="Y","checked","") %>></td>
									                                                    <td style="padding-left:2px;">예</td>
									                                                    <td style="padding:0 0 2px 15px;"><input type="radio"  name="email_10x10" value="N" <%= ChkIIF(myUserInfo.FOneItem.Femail_10x10="Y","","checked") %> ></td>
									                                                    <td style="padding-left:2px;">아니오</td>
									                                                  </tr>
                                                										</table>
                                                									</td>
                                            								</tr>
                                          								</table>
                                          							</td>
                                      							</tr>
                                      							<tr>
                                        								<td height="20">
                                        									<table border="0" cellspacing="0" cellpadding="0">
                                            								<tr>
                                              									<td><img src="http://fiximage.10x10.co.kr/web2009/member/bullet_grey.gif" align="absmiddle"></td>
                                              									<td style="padding-left:7px;" width="360">핑거스(thefingers.co.kr)의 이메일 서비스를 받아보시겠습니까?</td>
                                              									<td>
                                              										<table border="0" cellspacing="0" cellpadding="0">
                                                  									<tr>
									                                                    <td style="padding-bottom:2px;"><input type="radio" name="email_way2way" value="Y" <%= ChkIIF(myUserInfo.FOneItem.Femail_way2way="Y","checked","") %> <%= ChkIIF(IsAcademyUsing,""," disabled") %> ></td>
									                                                    <td style="padding-left:2px;">예</td>
									                                                    <td style="padding:0 0 2px 15px;"><input type="radio" name="email_way2way" value="N" <%= ChkIIF(myUserInfo.FOneItem.Femail_way2way="Y","","checked") %> <%= ChkIIF(IsAcademyUsing,""," disabled") %> ></td>
									                                                    <td style="padding-left:2px;">아니오</td>
                                                  									</tr>
                                                										</table>
                                                									</td>
                                            								</tr>
                                          								</table>
                                          							</td>
                                      							</tr>
                                      							<%
                                      								Dim ClsOSPoint, vPoint1010UserSeq, vEmailPoint1010, vSMSPoint1010
                                      								set ClsOSPoint = new COffshopPoint1010
                                      									ClsOSPoint.FGubun = "1"
                                      									ClsOSPoint.FUserID = GetLoginUserID()
																		ClsOSPoint.fnGetMemberInfo
																		vPoint1010UserSeq	= ClsOSPoint.FUserSeq
																		vEmailPoint1010 	= ClsOSPoint.FEmailYN
																		vSMSPoint1010		= ClsOSPoint.FMobileYN
																	set ClsOSPoint = nothing
																	If vPoint1010UserSeq <> "" Then
                                      							%>
                                      							<input type="hidden" name="point1010_userseq" value="<%=vPoint1010UserSeq%>">
                                      							<tr>
                                        								<td height="20">
                                        									<table border="0" cellspacing="0" cellpadding="0">
                                            								<tr>
                                              									<td><img src="http://fiximage.10x10.co.kr/web2009/member/bullet_grey.gif" align="absmiddle"></td>
                                              									<td style="padding-left:7px;" width="360">POINT1010(텐바이텐가맹점)의 이메일 서비스를 받아보시겠습니까?</td>
                                              									<td>
                                              										<table border="0" cellspacing="0" cellpadding="0">
                                                  									<tr>
									                                                    <td style="padding-bottom:2px;"><input type="radio" name="email_point1010" value="Y" <%= ChkIIF(vEmailPoint1010="Y","checked","") %> ></td>
									                                                    <td style="padding-left:2px;">예</td>
									                                                    <td style="padding:0 0 2px 15px;"><input type="radio" name="email_point1010" value="N" <%= ChkIIF(vEmailPoint1010="N","checked","") %> ></td>
									                                                    <td style="padding-left:2px;">아니오</td>
                                                  									</tr>
                                                										</table>
                                                									</td>
                                            								</tr>
                                          								</table>
                                          							</td>
                                      							</tr>
                                      							<% End If %>
                                      							<tr>
                                        								<td style="padding:5px 0 0 10px;" class="skyblue_11px"><font style="line-height:14px;">이메일 수신동의를 하시면 다양한 할인혜택과 이벤트/신상품 등의 정보를 빠르게 만나실수 있습니다.<br>
                                          									단, 주문 및 배송관련 메일은 수신동의와 상관없이 자동 발송됩니다.</font></td>
                                      							</tr>
                                    							</table>
                                    						</td>
                                						</tr>
                                						<tr>
                                  							<td height="31" bgcolor="#fcf6f6" style="border-bottom:1px solid #eaeaea;"><img src="http://fiximage.10x10.co.kr/web2009/member/join_form_phone.gif" width="39" height="11" class="table_20px"></td>
                                  							<td style="border-bottom:1px solid #eaeaea;padding:0 1px 0 20px;"><input  name="userphone1"  value="<%= SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) %>" onkeyup="TnTabNumber('userphone1','userphone2',3);" maxlength="4" type="text" class="input_margin" style="width:40px;">
						                                    -
						                                    <input name="userphone2"  value="<%= SplitValue(myUserInfo.FOneItem.Fuserphone,"-",1) %>" onkeyup="TnTabNumber('userphone2','userphone3',4);"  maxlength="4" type="text" class="input_margin" style="width:40px;">
						                                    -
						                                    <input name="userphone3" value="<%= SplitValue(myUserInfo.FOneItem.Fuserphone,"-",2) %>"    maxlength="4"  type="text" class="input_margin" style="width:40px;">						                                      
											</td>
										</tr>
						                            <tr>
						                            	<td height="125" bgcolor="#fcf6f6" style="border-bottom:1px solid #eaeaea;"><img src="http://fiximage.10x10.co.kr/web2009/member/join_form_pmobile.gif" width="39" height="11" class="table_20px"></td>
						                                  	<td style="border-bottom:1px solid #eaeaea;padding:0 0 3px 20px;">
						                                  		<table border="0" cellspacing="0" cellpadding="0" width="100%">
						                                      	<tr>
						                                        		<td height="30">
						                                        			<input  name="usercell1"  value="<%= SplitValue(myUserInfo.FOneItem.Fusercell,"-",0) %>" onkeyup="TnTabNumber('usercell1','usercell2',3);" maxlength="4" type="text" class="input_margin" style="width:40px;">
									                                    -
									                                    <input name="usercell2"  value="<%= SplitValue(myUserInfo.FOneItem.Fusercell,"-",1) %>" onkeyup="TnTabNumber('usercell2','usercell3',4);"  maxlength="4" type="text" class="input_margin" style="width:40px;">
									                                    -
									                                    <input name="usercell3" value="<%= SplitValue(myUserInfo.FOneItem.Fusercell,"-",2) %>"    maxlength="4"  type="text" class="input_margin" style="width:40px;">
						                                          	</td>
						                                      	</tr>
												<tr>
						                                      		<td height="20" style="padding-top:2px;">
						                                      			<table border="0" cellspacing="0" cellpadding="0">
						                                            		<tr>
						                                              			<td><img src="http://fiximage.10x10.co.kr/web2009/member/bullet_grey.gif" align="absmiddle"></td>
						                                              			<td style="padding-left:7px;" width="360">텐바이텐(10x10.co.kr)의 SMS 문자서비스를 받아보시겠습니까?</td>
						                                              			<td>
						                                              				<table border="0" cellspacing="0" cellpadding="0">
									                                                  <tr>
									                                                    <td style="padding-bottom:2px;"><input type="radio" name="smsok" value="Y" <%= ChkIIF(myUserInfo.FOneItem.Fsmsok="Y","checked","") %>></td>
									                                                    <td style="padding-left:2px;">예</td>
									                                                    <td style="padding:0 0 2px 15px;"><input type="radio" name="smsok" value="N" <%= ChkIIF(myUserInfo.FOneItem.Fsmsok="Y","","checked") %>></td>
									                                                    <td style="padding-left:2px;">아니오</td>
									                                                  </tr>
						                                                				</table>
						                                                			</td>
						                                            		</tr>
						                                          		</table>
						                                          	</td>
						                                      	</tr>
						                                      	<tr>
						                                        		<td height="20">
						                                        			<table border="0" cellspacing="0" cellpadding="0">
						                                            		<tr>
						                                              			<td><img src="http://fiximage.10x10.co.kr/web2009/member/bullet_grey.gif" align="absmiddle"></td>
						                                              			<td style="padding-left:7px;" width="360">핑거스(thefingers.co.kr)의 SMS 문자서비스를 받아보시겠습니까?</td>
						                                              			<td>
						                                              				<table border="0" cellspacing="0" cellpadding="0">
									                                                  <tr>
									                                                    <td style="padding-bottom:2px;"><input type="radio"  name="smsok_fingers" value="Y" <%= ChkIIF(myUserInfo.FOneItem.Fsmsok_fingers="Y","checked","") %> <%= ChkIIF(IsAcademyUsing,""," disabled") %> ></td>
									                                                    <td style="padding-left:2px;">예</td>
									                                                    <td style="padding:0 0 2px 15px;"><input type="radio" name="smsok_fingers" value="N" <%= ChkIIF(myUserInfo.FOneItem.Fsmsok_fingers="Y","","checked") %> <%= ChkIIF(IsAcademyUsing,""," disabled") %>></td>
									                                                    <td style="padding-left:2px;">아니오</td>
									                                                  </tr>
						                                                				</table>
						                                                			</td>
						                                            		</tr>
						                                          		</table>
						                                          	</td>
						                                      	</tr>
						                                      	<% If vPoint1010UserSeq <> "" Then %>
						                                      	<tr>
						                                        		<td height="20">
						                                        			<table border="0" cellspacing="0" cellpadding="0">
						                                            		<tr>
						                                              			<td><img src="http://fiximage.10x10.co.kr/web2009/member/bullet_grey.gif" align="absmiddle"></td>
						                                              			<td style="padding-left:7px;" width="360">POINT1010(텐바이텐가맹점)의 SMS 문자서비스를 받아보시겠습니까?</td>
						                                              			<td>
						                                              				<table border="0" cellspacing="0" cellpadding="0">
									                                                  <tr>
									                                                    <td style="padding-bottom:2px;"><input type="radio"  name="smsok_point1010" value="Y" <%= ChkIIF(vSMSPoint1010="Y","checked","") %>></td>
									                                                    <td style="padding-left:2px;">예</td>
									                                                    <td style="padding:0 0 2px 15px;"><input type="radio" name="smsok_point1010" value="N" <%= ChkIIF(vSMSPoint1010="N","checked","") %>></td>
									                                                    <td style="padding-left:2px;">아니오</td>
									                                                  </tr>
						                                                				</table>
						                                                			</td>
						                                            		</tr>
						                                          		</table>
						                                          	</td>
						                                      	</tr>
						                                    	<% End If %>
						                                      	<tr>
						                                        		<td style="padding:5px 0 0 10px;" class="skyblue_11px"><font style="line-height:14px;">SMS 수신동의를 하시면 다양한 할인혜택과 이벤트/신상품 등의 정보를 빠르게 만나실수 있습니다.<br>
						                                          		단, 주문 및 배송관련 SMS는 수신동의와 상관없이 자동 발송됩니다.</font></td>
						                                      	</tr>
						                                    	</table>
											</td>
										</tr>
						                            <tr>
						                            	<td height="31" bgcolor="#fcf6f6" style="border-bottom:1px solid #eaeaea;"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main18_01_04.gif" width="69" height="11" class="table_20px"></td>
						                                  	<td style="border-bottom:1px solid #eaeaea;padding:0 1px 0 20px;">
						                                  		<table border="0" cellspacing="0" cellpadding="0">
						                                      	<tr>
						                                        		<td style="padding-left:7px;" width="240" class="bbstxt01">핑거스 아카데미 (www.thefingers.co.kr)</td>
						                                        		<td>
						                                        			<table border="0" cellspacing="0" cellpadding="0">
						                                            		<tr>
								                                              <td style="padding-bottom:2px;"><input type="radio" name="allow_other" value="Y" <%= chkIIF(IsAcademyUsing,"checked","") %> onClick="checkSiteComp(this);" ></td>
								                                              <td style="padding-left:2px;" class="bbstxt01">이용함</td>
								                                              <td style="padding:0 0 2px 15px;"><input type="radio" name="allow_other" value="N" <%= chkIIF(IsAcademyUsing,"","checked") %> onClick="checkSiteComp(this);" ></td>
								                                              <td style="padding-left:2px;" class="bbstxt01">이용하지않음</td>
						                                            		</tr>
						                                          		</table>
						                                          	</td>
						                                      	</tr>
						                                    	</table>
											</td>
										</tr>
						                            <tr>
						                            	<td height="31" bgcolor="#fcf6f6"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main18_01_01.gif" width="58" height="11" class="table_20px"></td>
						                                  	<td style="padding:0 1px 0 20px;"><input  type="password" name="oldpass"  class="input_margin" style="width:120px;" maxlength="32" onKeyPress="if (event.keyCode == 13) ChangeMyInfo(frminfo);">
						                                   	 &nbsp;&nbsp;(정보를 수정 하시려면 기존 비밀번호를 입력하시기 바랍니다.) </td>
										</tr>
						                            </table>
                              						<!--나의정보관리 끝-->
									</td>
                          					</tr>
                          					<tr>
                            					<td align="center" style="padding-top:12px;">
                            						<table border="0" cellspacing="0" cellpadding="0">
                                						<tr>
                                  							<td> <a href="javascript:ChangeMyInfo(document.frminfo);" onfocus="this.blur()"><img src="http://fiximage.10x10.co.kr/web2009/order/btn_modiry02.gif" width="58" height="24"></a></td>
                                  							<td style="padding-left:10px;"> <a href="/my10x10/userinfo/confirmuser.asp" onfocus="this.blur()"><img src="http://fiximage.10x10.co.kr/web2009/order/btn_cancel02.gif" width="58" height="24"></a></td>
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
	</td>
</tr>
</table>
<%
set myUserInfo = Nothing

%>
<!-- #include virtual="/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->