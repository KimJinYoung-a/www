<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/incForceSSL.asp" -->
<%
	Dim userid, testlink
	userid = GetLoginUserID

	If (userid<>"") Then
		response.redirect "/"
		response.end
	End If
	
	''기존쿠키가 남아 있는경우.
	dim iiAddLogs
	If (request.Cookies("tinfo")("userid")<>"") Then
		'' 현재도메인의 쿠키가 남아 있을경우.(쿠키를 밖을때 도메인을 지정하지 않으면 해당도메인명의 쿠키가 밖힌다.)
		iiAddLogs = "r=snexpire8"
		if (request.ServerVariables("QUERY_STRING")<>"") then iiAddLogs="&"&iiAddLogs
		response.AppendToLog iiAddLogs&"&"

		'response.Cookies("tinfo").domain = ""
		'response.Cookies("tinfo") = ""
		'response.Cookies("tinfo").Expires = Date - 1
		'response.redirect "/"
	End If
	
	If (request.Cookies("tinfo")("shix")<>"") Then
		'' 현재도메인의 쿠키가 남아 있을경우.(쿠키를 밖을때 도메인을 지정하지 않으면 해당도메인명의 쿠키가 밖힌다.)
		iiAddLogs = "r=snexpire7"
		if (request.ServerVariables("QUERY_STRING")<>"") then iiAddLogs="&"&iiAddLogs
		response.AppendToLog iiAddLogs&"&"

		'response.Cookies("tinfo").domain = ""
		'response.Cookies("tinfo") = ""
		'response.Cookies("tinfo").Expires = Date - 1
		'response.redirect "/"
	End If


	''vType : G : 비회원 로그인포함, B : 장바구니 비회원주문 포함.
	Dim vType, vSvname, vOgTitle
	vType = requestCheckVar(request("vType"),1)
	vSvname = request.ServerVariables("SERVER_NAME")

	IF (application("Svr_Info") = "Dev") or (application("Svr_Info") = "staging") THEN
'		testlink = "_ytw"
	else
		if vSvname <> "www.10x10.co.kr" Then
			'If Trim(vSvname) <> "10x10.co.kr" Then ''2018/08/19 주석처리
				response.redirect("https://www.10x10.co.kr/login/loginpage.asp?vType=G")
			'End If
		end if
	end if

	Dim strBackPath, strGetData, strPostData
	strBackPath = ReplaceRequestSpecialChar(request("backpath"))
	strBackPath = Replace(strBackPath,"^^","&")
	strGetData	= ReplaceRequestSpecialChar(request("strGD"))
	strPostData = ReplaceRequestSpecialChar(request("strPD"))


'	if instr(strBackPath,"/login/loginpage_2017.asp")>0 then strBackPath="/"

	vSavedID = tenDec(request.cookies("mSave")("SAVED_ID"))

	'// 페이지 타이틀, 설명 및 오픈그래프 메타태그 작성
	strPageTitle = "텐바이텐 10X10 : 로그인"	'페이지 타이틀 (필수)
	Select Case lcase(strBackPath)
		Case "/my10x10/order/myorderlist.asp"
			vOgTitle = "[텐바이텐] 주문 내역 조회"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_orderList_v1.jpg"
			strPageDesc = "주문내역 조회가 가능합니다."
		Case "/my10x10/goodsusing.asp"
			vOgTitle = "[텐바이텐] 상품후기"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_shopping_v1.jpg"
			strPageDesc = "후기를 기다리는 상품이 있어요."
		Case "/inipay/shoppingbag.asp"
			vOgTitle = "[텐바이텐] 장바구니 바로가기"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_shopping_v1.jpg"
			strPageDesc = "당신의 결제를 기다리는 상품을 만나러 갈 시간입니다!"
		Case "/my10x10/qna/myqnalist.asp"
			vOgTitle = "[텐바이텐] 1:1 상담 신청"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_help_v1.jpg"
			strPageDesc = "도움이 필요하시다면 찾아주세요!"
		Case "/my10x10/myitemqna.asp"
			vOgTitle = "[텐바이텐] 상품 Q&A"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_help_v1.jpg"
			strPageDesc = "조금 더 상세한 상품안내가 필요하시다면 문의주세요"
		Case "/my10x10/order/order_info_edit_detail.asp"
			vOgTitle = "[텐바이텐] 주문 정보 변경"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_orderList_v1.jpg"
			strPageDesc = "구매자정보 / 배송지정보 /주문제작상품문구 등을 변경하실 수 있습니다."
		Case "/my10x10/order/order_cancel_detail.asp"
			vOgTitle = "[텐바이텐] 주문 취소"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_orderList_v1.jpg"
			strPageDesc = "주문취소접수(Web)와 취소내역을 조회할수 있습니다."
		Case "/my10x10/order/order_return_detail.asp"
			vOgTitle = "[텐바이텐] 반품 신청"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_orderList_v1.jpg"
			strPageDesc = "반품 접수 및 신청내역 조회가 가능합니다."
		Case "/my10x10/order/document_issue.asp"
			vOgTitle = "[텐바이텐] 증빙서류발급"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_service_v1.jpg"
			strPageDesc = "현금영수증, 결제영수증 등을 확인 할수 있습니다."
		Case "/my10x10/order/order_cslist.asp"
			vOgTitle = "[텐바이텐] 내가 신청한 서비스"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_service_v1.jpg"
			strPageDesc = "교환, 반품, 주문변경 등을 조회할수 있습니다."
		Case "/my10x10/myeventmaster.asp"
			vOgTitle = "[텐바이텐] 내가 참여한 이벤트"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_service_v1.jpg"
			strPageDesc = "참여한 이벤트를 확인 할 수 있습니다."
		Case "/my10x10/userinfo/confirmuser.asp"
			vOgTitle = "[텐바이텐] 회원 정보 변경"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_member_v1.jpg"
			strPageDesc = "나의 정보를 수정 할 수 있습니다."
		Case "/my10x10/special_info.asp"
			vOgTitle = "[텐바이텐] 회원 등급 조회"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_member_v1.jpg"
			strPageDesc = "이번달 회원등급은?"
		Case "/my10x10/couponbook.asp"
			vOgTitle = "[텐바이텐] 쿠폰 조회"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_money_v1.jpg"
			strPageDesc = "보유한 쿠폰을 확인하세요!"
		Case "/my10x10/mymileage.asp"
			vOgTitle = "[텐바이텐] 마일리지 조회"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_money_v1.jpg"
			strPageDesc = "내 마일리지는 얼마나 적립되어 있을까요?"
		Case "/my10x10/mytencash.asp"
			vOgTitle = "[텐바이텐] 예치금 조회"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_money_v1.jpg"
			strPageDesc = "예치금 잔액 조회가 가능합니다."
		Case "/my10x10/giftcard/giftcardorderlist.asp"
			vOgTitle = "[텐바이텐] 기프트카드 조회"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_money_v1.jpg"
			strPageDesc = "기프트카드의 조회가 가능합니다."
		Case "/my10x10/mywishlist.asp"
			vOgTitle = "[텐바이텐] 위시"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
			strPageDesc = "관심 상품을 다시한번 확인 하세요!"
		Case "/my10x10/myzzimbrand.asp"
			vOgTitle = "[텐바이텐] 찜브랜드"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
			strPageDesc = "내가 애정하는 브랜드는?"
		Case "/my10x10/myfavorite_event.asp"
			vOgTitle = "[텐바이텐] 관심 이벤트"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
			strPageDesc = "참여하고 싶은 이벤트가 있으시군요^^"
		Case "/my10x10/myaddress/myaddresslist.asp"
			vOgTitle = "[텐바이텐] 나의 주소록"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
			strPageDesc = "자주 사용하는 배송지를 등록할수 있어요!"
		Case "/my10x10/myanniversary/myanniversarylist.asp"
			vOgTitle = "[텐바이텐] 나의 기념일"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
			strPageDesc = "소중한 사람들의 기념일을 등록하세요!"
		Case "/my10x10/mytodayshopping.asp"
			vOgTitle = "[텐바이텐] 최근 본 상품"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
			strPageDesc = "조금 전 본 상품을 다시 찾아볼수 있습니다."
		Case "/my10x10/myalarmhistory.asp"
			vOgTitle = "[텐바이텐] 입고알림신청내역"
			strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
			strPageDesc = "맘에드는 상품의 재입고 알림을 신청하세요!"
	End Select

	if strPageImage<>"" then
		strHeaderAddMetaTag = "<meta property=""og:title"" content=""" & vOgTitle & """ />" & vbCrLf &_
							"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
							"<meta property=""og:url"" content=""" & SSLUrl & strBackPath & """ />" & vbCrLf &_
							"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
	end if
%>
<!-- #include virtual="/lib/inc/head_ssl.asp" -->
<%
	'// refferer가 없으면 생성
	if strBackPath="" and request.ServerVariables("HTTP_REFERER")<>"" then
 		strBackPath 	= replace(request.ServerVariables("HTTP_REFERER"),wwwUrl,"")
 		strBackPath 	= replace(strBackPath,replace(wwwUrl,"www.",""),"")
 		strBackPath 	= replace(strBackPath,SSLUrl,"")
 		strBackPath 	= replace(strBackPath,replace(SSLUrl,"www.",""),"")

		strBackPath 	= replace(strBackPath,www1Url,"")
		strBackPath 	= replace(strBackPath,replace(www1Url,"http://","https://"),"")
	end if
	if instr(strBackPath,"/join.asp")>0 then strBackPath="/"
%>
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

function fnPopSNSLogin(snsgb,wd,hi) {
	var snsbackpath = '<%=strBackPath%>';
	var popWidth = wd;
	var popHeight = hi;
	var snspopHeight
	if (snsgb=="nv"){
		snspopHeight = "4"
	}else if (snsgb=="fb" || snsgb=="gl"){
		snspopHeight = "0.2"
	}else if (snsgb=="ka"){
		snspopHeight = "1"
	}
	var winWidth = document.body.clientWidth;
	var winHeight = document.body.clientHeight;
	var winX	= window.screenX || window.screenLeft || 0;
	var winY	= window.screenY || window.screenTop || 0;
	var popupX = (winX + (winWidth - popWidth) / 2)- (wd / 4);
	var popupY = (winY + (winHeight - popHeight) / 2)- (hi / snspopHeight);
	var popup = window.open("/login/mainsnslogin<%=testlink%>.asp?snsdiv="+snsgb+"&pggb=id&snsbackpath="+snsbackpath,"","width="+wd+", height="+hi+", left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);
}
</script>
</head>
<body>
<div class="wrap loginV17">
	<!-- #include virtual="/lib/inc/incHeader_ssl.asp" -->
	<div class="container">
		<div id="contentWrap">
			<!--<h2><img src="/fiximage/web2013/login/tit_login.png" alt="LOGIN" class="pngFix" /></h2>
			<p class="tPad10"><img src="/fiximage/web2013/login/cmt_login.png" alt="생활감성채널 텐바이텐에 오신 것을 환영합니다." class="pngFix" /></p>-->
			
			<!-- 로그인 배너영역 -->
			<% server.Execute("/login/login_banner.asp") %>
			<!-- 2022 다이어리스토리 배너 -->
		<!--	<div style="margin-left:612px; margin-bottom:30px;">
				<a href="/diarystory2022/"><img src="http://fiximage.10x10.co.kr/web2021/diary2022/bnr_diary2021_login.png" alt="DIARY STORY 2022" /></a>
			</div> -->

			<div class="formBoxV17">
				<div class="overHidden">
					<!-- 회원 로그인 -->
					<div class="group type1">
					<form name="frmLogin2" method="post" action="">
					<input type="hidden" name="backpath" value="<%=strBackPath%>">
					<input type="hidden" name="strGD" value="<%=strGetData%>">
					<input type="hidden" name="strPD" value="<%=strPostData%>">
						<h3>회원 로그인</h3>
						<p class="tip">가입하신 텐바이텐 아이디와 비밀번호를 입력해주세요.<br />비밀번호는 대소문자를 구분합니다.</p>
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
							<p class="ftLt saveId"><input type="checkbox" name="saved_id" id="saveId2" value="o" checked="checked" <%=chkIIF(vSavedID<>"","checked","")%> class="check" /> <label for="saveId2">아이디 저장</label></p>
							<p class="ftRt"><a href="/member/forget.asp">아이디/비밀번호 찾기 &gt;</a></p>
						</div>

						<div class="snsLogin">
							<h4 class="title">다음 계정으로 로그인 / 회원가입</h4>
							<ul class="sns-accountV20">
								<li class="kakao"><a href="" onclick="fnPopSNSLogin('ka','470','570');return false;" class="icon kakao"><i></i><span class="text">카카오톡</span></a></li>	
								<!--<li class="apple"><a href=""><i class="icon"></i><span class="text">애플</span></a></li>-->
								<li class="google"><a href="" onclick="fnPopSNSLogin('gl','410','420');return false;" class="icon google"><i></i><span class="text">구글</span></a></li>
								<li class="naver"><a href="" onclick="fnPopSNSLogin('nv','400','800');return false;" class="icon naver"><i></i><span class="text">네이버</span></a></li>
								<li class="facebook"><a href="" onclick="fnPopSNSLogin('fb','410','300');return false;" class="icon facebook"><i></i><span class="text">페이스북</span></a></li>
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
						<h3>비회원 로그인</h3>
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
							<div style="padding-top:57px;">
								<p class="cRd0V15 bPad15">아직 텐바이텐 회원이 아니세요?</p>
								<a href="/member/join.asp" class="btn btnB1 btnWhite">텐바이텐 회원가입</a>
							</div>
						</div>
						<!--// for dev msg : 주문/배송조회 선택했을 경우 -->

						<!-- for dev msg : 비회원 주문하기 선택했을 경우 -->
						<div class="case2" style="display:<%=chkIIF(vType="B","","none")%>;">
							<p class="nonMemOdr box3">비회원으로 구매하실 경우,<br />쿠폰 사용 및 마일리지 적립 등의 혜택은<br />받으실 수 없습니다. </p>
							<p class="tPad15"><a href="javascript:TnDoBaguniGuestLogin(document.frmLogin4);" class="btn btnB1 btnGry">비회원 주문</a></p>
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
	document.getElementById("loginPw").focus();
	$("#loginPw").prev("label").addClass("hide");
}else{
	 document.frmLogin2.userid.focus();
}

</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->