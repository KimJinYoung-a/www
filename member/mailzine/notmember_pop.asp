<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'#######################################################
'	History	:  2009.10.08 한용민 생성
'	Description : 비회원 메일링 서비스 신청 팝업
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="javascript">
	<% If IsUserLoginOK Then %>
		alert("이미 회원가입이 되어있습니다.");
		self.close();
	<% End If %>

	//저장
	function reg(){		
		if(!frm_member.yn.checked){
			alert('약관에 동의해 주셔야 텐바이텐 서비스를 이용하실수 있습니다.');
		}else if(frm_member.username.value==''){
			alert('성명을 입력해주세요');
			frm_member.username.focus();
		}else if(frm_member.usermail1.value==''){
			alert('메일주소를 입력해주세요');
			frm_member.usermail1.focus();			
		}else if(frm_member.usermail2.value==''){
			alert('메일주소를 입력해주세요');			
			frm_member.usermail2.focus();		
		}else if(frm_member.usermail2.value.indexOf(".")==-1){
			alert('메일주소를 정확히 입력해주세요');			
			frm_member.usermail2.focus();	
		}else{
			frm_member.action = 'notmember_process.asp';
			frm_member.target='view';			
			frm_member.submit();
		}	
			
	}	
	
	//메일주소 선택
	function chdomain(chdomainname){
		frm_member.usermail2.value=chdomainname;
	}

	function jsOnLoad(){
		window.resizeTo(650,900);
	}
		
</script>

</head>
<body onLoad="jsOnLoad();">
	<form name="frm_member" method="post" style="margin:0px;">
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/main/pop_tit_mail.gif" alt="비회원 정보수집 동의 및 메일링 서비스 신청" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<p class="fs12"><strong>본 메일링 서비스 신청은 비회원을 위한 서비스입니다.</strong></p>
					<p class="tPad10">비회원으로 텐바이텐 메일링 서비스를 받으시려면, 아래 개인정보 수집 항목을 확인 후 동의하셔야 합니다.<br />회원이신 경우, <span class="crRed">마이텐바이텐 &gt; 개인정보수정</span>에서 이메일 수정 및 수신여부 설정이 가능합니다.</p>
					<div class="nonMemAgree">
						<ol>
							<li>1. 수집하는 개인정보 항목<br />- e-mail, 성명</li>
							<li>
								2. 수집목적
								<ol>
									<li>① e-mail : 메일링 서비스의 제공, 고지의 전달, 불만처리 안내 등 원활한 의사소통 경로의 확보</li>
									<li>② 성명 : 고지의 전달, 메일링 서비스의 정확한 제공 정보 확보</li>
								</ol>
							</li>
							<li>3. 개인정보 보유기간<br />- 메일링 서비스 해제 신청 전까지</li>
							<li>4. 비회원 메일링 서비스 수신 시 제공하신 모든 정보는 상기 목적에 필요한 용도 이외로는 사용되지 않습니다.<br />기타 자세한 사항은 ‘개인정보취급방침’을 참고하여 주시기 바랍니다.</li>
							<li>5. 메일링 수신해지를 원하시면 비회원으로 받으신 텐바이텐 메일링 페이지 내의 수신 거부 절차를 <br />통하여 해지하여 주시기 바랍니다.</li>
						</ol>
					</div>
					<p><input type="checkbox" name="yn" class="check" id="agree" /> <label for="agree"><strong>위의 '개인정보 수집 항목'에 동의합니다.</strong></label></p>
					<div class="emailApplicate tMar25">
						<fieldset>
							<legend>이메일 신청 폼</legend>
							<dl class="frmType">
								<dt><label for="memName">성명</label></dt>
								<dd><input type="text" name="username" id="memName" class="txtInp offInput" /></dd>
							</dl>
							<dl class="frmType">
								<dt><label for="mail01">메일주소</label></dt>
								<dd>
									<p>
										<input type="text" name="usermail1" id="mail01" class="txtInp offInput" style="width:100px;" /> @ <input type="text" name="usermail2" id="mail02" class="txtInp offInput" style="width:100px;" />
										<select class="select" onchange="chdomain(this.value);">
											<option value="">직접입력</option>
				                            <option value="hanmail.net" >hanmail.net</option>
				                            <option value="naver.com" >naver.com</option>
				                            <option value="hotmail.com" >hotmail.com</option>
				                            <option value="yahoo.co.kr" >yahoo.co.kr</option>
				                            <option value="hanmir.com" >hanmir.com</option>
				                            <option value="paran.com" >paran.com</option>
				                            <option value="lycos.co.kr" >lycos.co.kr</option>
				                            <option value="nate.com" >nate.com</option>
				                            <option value="dreamwiz.com" >dreamwiz.com</option>
				                            <option value="korea.com" >korea.com</option>
				                            <option value="netian.com" >netian.com</option>
				                            <option value="freechal.com" >freechal.com</option>
				                            <option value="msn.com" >msn.com</option>
				                           	<option value="gmail.com" >gmail.com</option>											
										</select>
									</p>
									<input type="hidden" name="chk_10x10" value="Y">
									<!--
									<p class="tPad10">
										<span><input type="checkbox" name="chk_10x10" value="Y" checked id="tenAgree" class="check" /> <label for="tenAgree">텐바이텐</label></span>
										<span class="lPad10"><input type="checkbox" name="chk_fingers" value="Y" checked id="academyAgree" class="check" /> <label for="academyAgree">더핑거스 아카데미</label></span>
									</p>
									-->
									<p class="tPad15 cr6aa7cc">텐바이텐의 다양한 할인혜택과 이벤트/신상품 등의 정보를 <br />빠르게 만나실 수 있습니다.</p>
								</dd>
							</dl>
						</fieldset>
					</div>
					<p class="ct tPad20">
						<a href="" onclick="reg(); return false;" class="btn btnM2 btnRed btnW185">메일링 서비스 신청하기</a>
					</p>
				</div>
				<!-- //content -->
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2 " onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
	</form>
	<iframe name="view" id="view" frameborder=0 width=0 height=0></iframe>
</body>
</html>

<!-- #include virtual="/lib/poptailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
