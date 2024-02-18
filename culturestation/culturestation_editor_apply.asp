<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2010.04.08 한용민 생성
'              2013.08.30 허진원 : 2013리뉴얼
'	Description : culturestation
'#######################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestationCls.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 컬쳐에디터 신청하기"		'페이지 타이틀 (필수)

	dim evt_type: evt_type="X"

	'// 로그인 회원 정보 접수
	Dim myUserInfo, vUserID, vUserName, vUserCell, vUserMail, listisusing
	vUserID = GetLoginUserID()
	Set myUserInfo = New CUserInfo
	myUserInfo.FRectUserID = vUserID
	if (vUserID <> "") then
	    myUserInfo.GetUserData 
	end if
	
	If (myUserInfo.FResultCount < 1) Then
	    Response.Write "<script>alert('정보를 가져올 수 없습니다.');</script>"
	    Response.End
	End If
	
	vUserName = myUserInfo.FOneItem.FUserName
	vUserCell = myUserInfo.FOneItem.Fusercell
	vUserMail = myUserInfo.FOneItem.FUsermail
	
	Dim arrEmail, E1, E2
	IF myUserInfo.FOneItem.FUsermail  <> "" THEN
		arrEmail = split(myUserInfo.FOneItem.FUsermail,"@")
		if ubound(arrEmail)>0 then
			E1	= arrEmail(0)
			E2	= arrEmail(1)
		end if
	END IF
	
	Set myUserInfo = Nothing
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
function ChangeMyInfo(frm){	

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

	if (frm.linkurl.value.length<1){
		alert('홈페이지(블로그) 주소를 입력해 주세요.');
		frm.linkurl.focus();
		return;
	}
	
	if (frm.whyapply.value.length<1){
		alert('신청이유를 입력해 주세요.');
		frm.whyapply.focus();
		return;
	}
 
	var ret = confirm('컬쳐 에디터를 신청하시겠습니까?');
	if (ret){
		frm.submit();
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
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container cultureStation">
		<div id="contentWrap">
			<div class="cultureHeader">
				<h2><a href="/culturestation/"><img src="http://fiximage.10x10.co.kr/web2013/culturestation/tit_culture.gif" alt="CULTURE STATION" /></a></h2>
				<p><img src="http://fiximage.10x10.co.kr/web2013/culturestation/txt_culture.gif" alt="감성을 채우는 문화정거장-컬쳐스테이션" /></p>
				<ul class="cultureNav">
					<li class="feel"><a href="/culturestation/?etype=0">느껴봐</a></li>
					<li class="read"><a href="/culturestation/?etype=1">읽어봐</a></li>
					<li class="editor current"><a href="culturestation_editor.asp">컬쳐에디터</a></li>
					<li class="thankyou"><a href="culturestation_thanks10x10.asp">고마워 텐바이텐</a></li>
				</ul>
			</div>
			<div class="cultureContent editorApply">
				<!-- #include virtual="/culturestation/inc_culturestation_leftmenu.asp" -->
				<div class="content">
				<form name="frminfo" method="post" action="/culturestation/culturestation_editor_apply_proc.asp" target="iframeDB">
				<input type="hidden" name="action" value="i">
					<div><img src="http://fiximage.10x10.co.kr/web2013/culturestation/img_editor.gif" alt="CULTURE EDITOR 신청하기 - 텐바이텐 컬쳐 에디터가 되어주세요. 컬쳐 에디터가 되시면 [컬쳐 에디터]에 포스팅하는 기회와 텐바이텐 1만원 기프트 카드를 선물로 드립니다." /></div>
					<div class="tblView">
						<fieldset>
							<legend>컬쳐 에디터 신청</legend>
							<table class="docForm">
							<caption>컬쳐 에디터 신청</caption>
							<colgroup>
								<col width="150" /> <col width="*" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">아이디</th>
								<td><%=vUserID%></td>
							</tr>
							<tr>
								<th scope="row">이름</th>
								<td><%=vUserName%></td>
							</tr>
							<tr>
								<th scope="row"><label for="apTel">연락처</label></th>
								<td>
									<input name="usercell1" type="text" title="연락처 앞자리 입력" id="apTel" class="txtInp focusOn" style= "height:18px; width:60px" value="<%= SplitValue(vUserCell,"-",0) %>" onkeyup="TnTabNumber('usercell1','usercell2',3);" maxlength="4">
									-
									<input name="usercell2" type="text" title="연락처 가운데 입력" class="txtInp focusOn" style= "height:18px; width:60px" value="<%= SplitValue(vUserCell,"-",1) %>" onkeyup="TnTabNumber('usercell2','usercell3',4);" maxlength="4">
									-
									<input name="usercell3" type="text" title="연락처 뒷자리 입력" class="txtInp focusOn" style= "height:18px; width:60px" value="<%= SplitValue(vUserCell,"-",2) %>" maxlength="4">
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="apMail">이메일</label></th>
								<td>
									<input type="text" id="apMail" title="이메일 아이디 입력" class="txtInp focusOn" name="txEmail1" style= "width:120px; ime-mode:disabled" value="<%=E1%>"  maxlength="32" />
									@
									<input type="hidden" name="usermail" value="<%= vUserMail %>">
									<input type="text" title="이메일 직접 입력" class="txtInp" name="selfemail" style= "height:18px; width:120px; ime-mode:disabled;" value="<%=E2%>" maxlength="80" />
									&nbsp;
									<select name="txEmail2" onchange="NewEmailChecker()" title="이메일 서비스 선택" class="select offInput">
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
								<th scope="row"><label for="apHomepage">홈페이지 (블로그)</label></th>
								<td>
									<input type="text" id="apHomepage" class="txtInp focusOn" name="linkurl" style="width:555px;" />
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="apReason">신청이유</label></th>
								<td>
									<textarea name="whyapply" id="apReason" style="width:565px; height:100px;"></textarea>
								</td>
							</tr>
							</tbody>
							</table>
						</fieldset>
					</div>
					<div class="btnArea ct tPad30">
						<a href="" onclick="ChangeMyInfo(document.frminfo);return false;" class="btn btnM1 btnRed btnW130" />신청하기</a>
						<a href="/culturestation/" class="btn btnM1 btnGry btnW130" />취소하기</a>
					</div>
				</form>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<iframe src="about:blank" name="iframeDB" frameborder="0" width="0" height="0"></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->