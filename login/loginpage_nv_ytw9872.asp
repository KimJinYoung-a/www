<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/incForceSSL.asp" -->
<!-- #include virtual="/lib/inc/head_ssl.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 로그인"		'페이지 타이틀 (필수)

	Dim userid
	userid = GetLoginUserID

	If (userid<>"") Then
		response.redirect "/"
	End If

	''vType : G : 비회원 로그인포함, B : 장바구니 비회원주문 포함.
	Dim vType, vSvname
	vType = requestCheckVar(request("vType"),1)
	vSvname = request.ServerVariables("SERVER_NAME")

	if vSvname <> "www.10x10.co.kr" Then
		response.redirect("https://www.10x10.co.kr/login/loginpage_nv_ytw9872.asp?vType=G")
	end if

	Dim strBackPath, strGetData, strPostData
	strBackPath = ReplaceRequestSpecialChar(request("backpath"))
	strGetData  = ReplaceRequestSpecialChar(request("strGD"))
	strPostData = ReplaceRequestSpecialChar(request("strPD"))

	'// refferer가 없으면 생성
	if strBackPath="" and request.ServerVariables("HTTP_REFERER")<>"" then
   		strBackPath 	= replace(request.ServerVariables("HTTP_REFERER"),wwwUrl,"")
   		strBackPath 	= replace(strBackPath,replace(wwwUrl,"www.",""),"")
   		strBackPath 	= replace(strBackPath,SSLUrl,"")
   		strBackPath 	= replace(strBackPath,replace(SSLUrl,"www.",""),"")
	end if
'	if instr(strBackPath,"/login/loginpage_2017.asp")>0 then strBackPath="/"

	vSavedID = tenDec(request.cookies("mSave")("SAVED_ID"))
%>
<script type="text/javascript" src="/lib/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript">
$(function() {
	$('.flexFormV17 input').each(function() {
		var defaultVal = this.value;
		$(this).focus(function() {
			if(this.value == defaultVal){
				$(this).prev("label").addClass("hide");
			}
		});
		$(this).blur(function(){
			if(this.value == ''){
				$(this).prev("label").removeClass("hide");
			}
		});
	});
});

function TnCSlogin(frm){
	if (frm.userid.value.length<1) {
		alert('아이디를 입력하세요.');
		frm.userid.focus();
		return;
	}

	if (frm.userpass.value.length<1) {
		alert('패스워드를 입력하세요.');
		frm.userpass.focus();
		return;
	}
	frm.action = '<%=SSLUrl%>/login/dologin.asp';
	frm.submit();
}

function TnDoGuestLogin(frm){
	<% if vType="G" then %>
    if (frm.orderserial.value.length<1) {
    	alert('주문번호를 입력하세요.');
    	frm.orderserial.focus();
    	return;
    }

    if (frm.buyemail.value.length<1) {
    	alert('구매자이메일을 입력하세요.');
    	frm.buyemail.focus();
    	return;
    }

    frm.action = '<%=SSLUrl%>/login/doguestlogin.asp';
    frm.submit();
    <% else %>
    alert('회원 전용 서비스입니다.');
    <% end if %>
}

function TnDoBaguniGuestLogin(frm){
	frm.action = '<%=SSLUrl%>/login/dobagunilogin.asp';
	frm.submit();
}

function popNonmember() {
	var popNM = window.open("/inipay/pop_nonmember.asp","popNonMem","width=500,height=480");
	popNM.focus();
}

function viewAgree(){
	$(".nonMemAgr").show();
}

function chkAgreement() {
	var fag = document.frmLoginGuest.chkAgree;
	if(!(fag[0].checked||fag[1].checked)) {
		alert("비회원 정보수집 동의사항을 선택해주세요.")
	}
	if(fag[1].checked) {
		$(".nonMemAgr").hide();
	} else if(fag[0].checked) {
		TnDoBaguniGuestLogin(document.frmLogin4);
	}
}

function fnPopSNSLogin(snsgb,wd,hi) {
	var snsbackpath = '<%=strBackPath%>';
	var popWidth  = wd;
	var popHeight = hi;
	var winWidth  = document.body.clientWidth;
	var winHeight = document.body.clientHeight;
	var winX      = window.screenX || window.screenLeft || 0;
	var winY      = window.screenY || window.screenTop || 0;
	var popupX = (winX + (winWidth - popWidth) / 2)- (wd / 4);
	var popupY = (winY + (winHeight - popHeight) / 2)- (hi / 4);
	var popup = window.open("/login/mainsnslogin.asp?snsdiv="+snsgb+"&pggb=id&snsbackpath="+snsbackpath,"","width="+wd+", height="+hi+", left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);
}

</script>
</head>
<body>
<div class="wrap loginV17">
	<!-- #include virtual="/lib/inc/incHeader_ssl.asp" -->
	<div class="container">
		<div id="contentWrap">
			<h2><img src="/fiximage/web2013/login/tit_login.png" alt="LOGIN" class="pngFix" /></h2>
			<p class="tPad10"><img src="/fiximage/web2013/login/cmt_login.png" alt="생활감성채널 텐바이텐에 오신 것을 환영합니다." class="pngFix" /></p>

			<%
			dim NewUserEvtcode
			If Date() >= "2016-11-01" And Date() < "2016-12-01" Then	'11월 신규가입
				NewUserEvtcode = 73892
			elseif Date() >= "2016-12-01" And Date() < "2017-01-01" Then	'12월 신규가입
				NewUserEvtcode = 74620
			elseif Date() >= "2017-01-01" And Date() < "2017-02-01" Then	'1월 신규가입
				NewUserEvtcode = 75258
			elseif Date() >= "2017-02-01" And Date() < "2017-03-01" Then	'2월 신규가입
				NewUserEvtcode = 75890
			elseif Date() >= "2017-03-01" And Date() < "2017-04-01" Then	'3월 신규가입
				NewUserEvtcode = 76495
			elseif Date() >= "2017-05-01" And Date() < "2017-06-01" Then	'5월 신규가입
				NewUserEvtcode = 77665
			elseif Date() >= "2017-06-01" And Date() < "2017-07-01" Then	'6월 신규가입
				NewUserEvtcode = 78243
			end If
			%>
			<% if Date() >= "2017-05-01" then %>
				<div style="position:absolute; right:160px; top:46px;">
					<a href="/event/eventmain.asp?eventid=<%= NewUserEvtcode %>">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/70939/bnr_new_v1.png" alt="신규회원 쿠폰 받기 - 텐바이텐에 가입하는 모든 고객님께 드립니다." />
					</a>
				</div>
			<% end if %>
			
			<div class="formBoxV17">
				<div class="overHidden">
					<!-- 회원 로그인 -->
					<div class="group type1">
					<form name="frmLogin2" method="post" action="">
					<input type="hidden" name="backpath" value="<%=strBackPath%>">
					<input type="hidden" name="strGD" value="<%=strGetData%>">
					<input type="hidden" name="strPD" value="<%=strPostData%>">
						<h3><img src="/fiximage/web2013/login/stit_member.gif" alt="회원 로그인" /></h3>
						<p class="tip">가입하신 텐바이텐 아이디와 비밀번호를 입력해주세요.<br />비밀번호는 대소문자를 구분합니다.</p>
						<fieldset>
							<legend>회원 로그인</legend>
							<div class="flexFormV17 tPad15">
								<div><label for="loginId" class="hide">아이디</label><input type="text" name="userid" id="loginId" class="txtInp" maxlength="32" value="<%=vSavedID%>" autocomplete="off" onKeyPress="if (event.keyCode == 13) frmLogin2.userpass.focus();" /></div>
							</div>
							<div class="flexFormV17">
								<div><label for="loginPw">비밀번호</label><input type="password" name="userpass" id="loginPw" class="txtInp" maxlength="32" onKeyPress="if (event.keyCode == 13) TnCSlogin(frmLogin2);"  /></div>
							</div>
						</fieldset>
						
						<% if session("chkLoginLock") then %>
							<div class="loginLimitV15a">
								<p class="lmtMsg1">ID/PW 입력 오류로 인해 로그인이 <br />제한되었습니다.</p>
								<p class="fs11 tPad05 cr666">개인정보 보호를 위해 아래 항목을 입력해주세요.</p>
							</div>
							<div class="tPad05 bPad15">
								<script src="https://www.google.com/recaptcha/api.js" async defer></script>
								<div id="g-recaptcha" class="g-recaptcha" data-sitekey="6LdSrA8TAAAAAD0qwKkYWFQcex-VzjqJ6mbplGl6"></div>
								<style>
								.g-recaptcha {margin:0 auto; padding:0; transform:scale(0.92); -webkit-transform:scale(0.92); transform-origin:0 0; -webkit-transform-origin:0 0; zoom: 0.8\9;}
								</style>
							</div>
						<% end if %>

						<p class="tPad15"><a href="javascript:TnCSlogin(document.frmLogin2);" class="btn btnB1 btnRed">로그인</a></p>
						<div class="helpV17">
							<p class="ftLt saveId"><input type="checkbox" name="saved_id" id="saveId2" value="o" <%=chkIIF(vSavedID<>"","checked","")%> class="check" /> <label for="saveId2">아이디 저장</label></p>
							<p class="ftRt"><a href="/member/forget.asp">아이디/비밀번호 찾기 &gt;</a></p>
						</div>

						<div class="snsLogin">
							<h4 class="title"><img src="/fiximage/web2017/member/stit_sns.png" alt="SNS 로그인" /></h4>
							<a href="" onclick="fnPopSNSLogin('nv','400','800');return false;"><img src="/fiximage/web2017/member/btn_naver.png" alt="네이버 로그인" /></a>
							<ul class="btnSocialV17">
								<%' <li><a href="" onclick="fnPopSNSLogin('fb','410','300');return false;" class="icon facebook">Facebook</a></li> %>
								<%' <li><a href="" onclick="fnPopSNSLogin('nv','400','800');return false;" class="icon naver">NAVER</a></li> %>
								<%' <li><a href="javascript:alert('준비중 입니다');" class="icon kakao">kakao</a></li> %>
								<%' <li><a href="javascript:alert('준비중 입니다');" class="icon google">Google</a></li> %>
							</ul>
						</div>
					</form>
					</div>
					<!--// 회원 로그인 -->

					<!-- 비회원 로그인 -->
					<div class="group type2">
					<form name="frmLoginGuest" method="post" action="">
					<input type="hidden" name="backpath" value="<%=strBackPath%>">
					<input type="hidden" name="strGD" value="<%=strGetData%>">
					<input type="hidden" name="strPD" value="<%=strPostData%>">
						<h3><img src="/fiximage/web2013/login/stit_nonmem.gif" alt="비회원 로그인" /></h3>
						<p class="tPad07" style="padding-bottom:4px;">
							<span><input name="nmltype" type="radio" class="radio" id="delivery" <%=chkIIF(vType="G","checked=""checked""","disabled")%> /> <label for="delivery">주문배송조회</label></span>
							<span class="lPad20"><input name="nmltype" type="radio" class="radio" id="order" <%=chkIIF(vType="B","checked=""checked""","disabled")%> /> <label for="order">주문하기</label></span>
						</p>
						<!-- for dev msg : 주문/배송조회 선택했을 경우 -->
						<div class="case1">
							<fieldset style="display:<%=chkIIF(vType="B","none","")%>;">
								<legend>비회원 로그인</legend>
								<div class="flexFormV17 tPad15">
									<div><label for="odrNum">주문번호</label><input type="text" name="orderserial" id="odrNum" class="txtInp" maxlength="11" <%=chkIIF(vType="G","","disabled")%> autocomplete="off" onKeyPress="if (event.keyCode == 13) frmLoginGuest.buyemail.focus();" /></div>
								</div>
								<div class="flexFormV17">
									<div><label for="cstMail">주문고객 이메일</label><input type="password" name="buyemail" id="cstMail" class="txtInp" maxlength="128" <%=chkIIF(vType="G","","disabled")%> autocomplete="off" onKeyPress="if (event.keyCode == 13) TnDoGuestLogin(frmLoginGuest);" /></div>
								</div>
								<p class="tPad15"><a href="javascript:TnDoGuestLogin(document.frmLoginGuest);" class="btn btnB1 btnGry">주문배송조회</a></p>
							</fieldset>
							<div style="padding-top:49px;">
								<p class="cRd0V15 bPad15">아직 텐바이텐 회원이 아니세요?</p>
								<a href="/member/join.asp" class="btn btnB1 btnWhite">텐바이텐 회원가입</a>
							</div>
						</div>
						<!--// for dev msg : 주문/배송조회 선택했을 경우 -->

						<!-- for dev msg : 비회원 주문하기 선택했을 경우 -->
						<div class="case2" style="display:<%=chkIIF(vType="B","","none")%>;">
							<p class="nonMemOdr box3">비회원으로 구매하실 경우,<br />쿠폰 사용 및 마일리지 적립 등의 혜택은<br />받으실 수 없습니다. </p>
							<p class="tPad15"><a href="javascript:viewAgree()" class="btn btnB1 btnGry">비회원 주문</a></p>
						</div>
						<div class="nonMemAgr" style="display:none;">
							<h4 class="bPad10"><img src="/fiximage/web2013/login/stit_nonmem_agree.gif" alt="비회원 정보 수집 동의" /></h4>
							<p class="cmt">비회원으로 구매 시, 개인정보 수집항목을 확인 후 동의하셔야 합니다.</p>
							<div class="agrBox bdr1 boxScr">
								<ol>
									<li>1. 수집하는 개인정보 항목<br />- e-mail, 전화번호, 성명, 주소, 은행계좌번호</li>
									<li>2. 수집 목적
										<ol>
											<li>① e-mail, 전화번호: 고지의 전달. 불만처리나 주문/배송정보 안내 등 원활한 의사소통 경로의 확보.</li>
											<li>② 성명, 주소: 고지의 전달, 청구서, 정확한 상품 배송지의 확보.</li>
											<li>③ 은행계좌번호: 구매상품에 대한 환불시 확보.</li>
										</ol>
									</li>
								</ol>
							</div>
							<div class="overHidden">
								<p class="ftLt">위 내용에 동의하십니까?
									<span class="lPad20"><input type="radio" name="chkAgree" id="agreeY" class="check" value="Y"/> <label for="agreeY"><strong class="cr555">동의함</strong></label></span>
									<span class="lPad10"><input type="radio" name="chkAgree" id="agreeN" class="check" value="N"/> <label for="agreeN"><strong class="cr555">동의안함</strong></label></span>
								</p>
								<p class="ftRt"><a href="javascript:chkAgreement()" class="btn btnM1 btnGry btnW150">비회원 구매하기 &gt;</a></p>
							</div>
						</div>
					</form>
					<form name="frmLogin4" method="post" action="">
					<input type="hidden" name="backpath" value="<%=strBackPath%>">
					<input type="hidden" name="strGD" value="<%=strGetData%>">
					<input type="hidden" name="strPD" value="<%=strPostData%>">
					</form>
					</div>
					<!--// 비회원 로그인 -->
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter_ssl.asp" -->
</div>
<script type="text/javascript">

if (document.getElementById("saveId2").checked && document.frmLogin2.userid.value != "") {
	document.getElementById("loginPw2").focus();
}else{
	 document.frmLogin2.userid.focus();
}

</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->