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

	Dim userid, testlink
	userid = GetLoginUserID

	If (userid<>"") Then
		response.redirect "/biz/"
		response.end
	End If

    ''기존쿠키가 남아 있는경우.
	dim iiAddLogs
	If (request.Cookies("tinfo")("userid")<>"") Then
		'' 현재도메인의 쿠키가 남아 있을경우.(쿠키를 밖을때 도메인을 지정하지 않으면 해당도메인명의 쿠키가 밖힌다.)
		iiAddLogs = "r=snexpire8"
		if (request.ServerVariables("QUERY_STRING")<>"") then iiAddLogs="&"&iiAddLogs
		response.AppendToLog iiAddLogs&"&"
	End If

    If (request.Cookies("tinfo")("shix")<>"") Then
		'' 현재도메인의 쿠키가 남아 있을경우.(쿠키를 밖을때 도메인을 지정하지 않으면 해당도메인명의 쿠키가 밖힌다.)
		iiAddLogs = "r=snexpire7"
		if (request.ServerVariables("QUERY_STRING")<>"") then iiAddLogs="&"&iiAddLogs
		response.AppendToLog iiAddLogs&"&"
	End If

    Dim strBackPath, strGetData, strPostData
	strBackPath = ReplaceRequestSpecialChar(request("backpath"))
	strGetData	= ReplaceRequestSpecialChar(request("strGD"))
	strPostData = ReplaceRequestSpecialChar(request("strPD"))

	'// refferer가 없으면 생성
	if strBackPath="" and request.ServerVariables("HTTP_REFERER")<>"" then
 		strBackPath 	= replace(request.ServerVariables("HTTP_REFERER"),wwwUrl,"")
 		strBackPath 	= replace(strBackPath,replace(wwwUrl,"www.",""),"")
 		strBackPath 	= replace(strBackPath,SSLUrl,"")
 		strBackPath 	= replace(strBackPath,replace(SSLUrl,"www.",""),"")

		strBackPath 	= replace(strBackPath,www1Url,"")
		strBackPath 	= replace(strBackPath,replace(www1Url,"http://","https://"),"")
	end if

    vSavedID = tenDec(request.cookies("mSave")("SAVED_ID"))

    If Application("Svr_Info") = "staging" Then
        SSLUrl = "https://stgwww.10x10.co.kr"
    End If
%>
<script>

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
        frm.action = '<%=SSLUrl%>/biz/dologin.asp';
        frm.submit();
    }

</script>
<style>
.ftRt {padding-top:30px; float:none;}
.ftRt .link-forgot {display:block; text-align:center;}
.ftRt .talk-kakao {display:block; width:142px; height:38px; margin:8px auto 0;}
.ftRt .service-group {width:260px; height:38px;}
.ftRt .talk-kakao img,
.ftRt .service-group img {width:100%;}
</style>
</head>
<body>
<div class="wrap loginV17 tenBiz">
    <!-- #include virtual="/lib/inc/incHeader_ssl.asp" -->
    <div class="container">
		<div id="contentWrap">
            <div class="formBoxV17">
				<div class="overHidden">
					<!-- BIZ 로그인 -->
					<div class="group type1">
                        <form name="frmLogin2" method="post" action="">
                            <input type="hidden" name="backpath" value="<%=strBackPath%>">
                            <input type="hidden" name="strGD" value="<%=strGetData%>">
                            <input type="hidden" name="strPD" value="<%=strPostData%>">

                            <h3>BIZ 로그인</h3>
                            <p class="tip">텐바이텐 BIZ 아이디와 비밀번호를 입력해주세요.<br/>기존 텐바이텐 계정은 사용하실 수 없습니다.</p>
                            <fieldset>
                                <legend>회원 로그인</legend>
                                <div class="flexFormV17 tPad15">
                                    <div><label for="loginId" class="hide">아이디</label><input type="text" name="userid" id="loginId" class="txtInp" maxlength="32" value="<%=vSavedID%>" autocomplete="off" onKeyPress="if (event.keyCode == 13) frmLogin2.userpass.focus();" /></div>
                                </div>
                                <div class="flexFormV17">
                                    <div><label for="loginPw">비밀번호</label><input type="password" name="userpass" id="loginPw" class="txtInp" maxlength="32" autocomplete="off" onKeyPress="if (event.keyCode == 13) TnCSlogin(frmLogin2);" /></div>
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
							    <p class="ftRt">
                                    <a href="/cscenter/" class="link-forgot">계정정보 분실 시</a>
                                    <a href="http://pf.kakao.com/_xiAFPs/chat" target="_blank" class="talk-kakao"><img src="http://fiximage.10x10.co.kr/web2021/cscenter/btn_kakao_talk.png?v=2.1" alt="카카오 상담하기"></a>
                                </p>
                            </div>
                        </form>
					</div>
					<!--// BIZ 로그인 -->

					<!-- BIZ 회원가입 -->
					<div class="group type2">
						<h3>BIZ 회원가입</h3>
						<p class="tip">사업자 전용 쇼핑몰 텐바이텐 BIZ를 이용하시려면<br/>사업자 정보가 입력된 BIZ 계정이 필요합니다.</p>
						<div class="case1">
							<div class="members-step">
                                <div>
                                    <p>BIZ</p>
                                    <p>회원가입</p>
                                </div>
                                <div>
                                    <p>회원가입</p>
                                    <p>승인</p>
                                </div>
                                <div>
                                    <p>회원가입</p>
                                    <p>완료</p>
                                </div>
                            </div>
							<div>
								<a href="/member/join.asp?biz=Y" class="btn btnB1 btnWhite">텐바이텐 BIZ 회원가입</a>
							</div>
						</div>
					</div>
					<!--// BIZ 회원가입 -->
				</div>
			</div>
        </div>
    </div>
    <!-- #include virtual="/lib/inc/incFooter_ssl.asp" -->
</div>
<script>

if (document.getElementById("saveId2").checked && document.frmLogin2.userid.value != "") {
	document.getElementById("loginPw").focus();
	$("#loginPw").prev("label").addClass("hide");
}else{
	 document.frmLogin2.userid.focus();
}

</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->