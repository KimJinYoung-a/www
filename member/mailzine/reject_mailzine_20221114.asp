<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
'#######################################################
'	History	:  2014.10.22 허진원 생성
'	Description : 메일링 서비스 수신거부 간소화 페이지
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/base64_u.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 메일진 수신거부"

	'// 이전페이지 내용 접수
	Dim vRef, vPostId, vMail, vName, vTable, tmpArr, tmpKey, lp, vEncMail, vMId
	vRef = request.ServerVariables("HTTP_REFERER")
	vMId = request("M_ID")

	'Test
	'' http://tmailer.10x10.co.kr/Check.html?TV9JRD1rb2J1bGFAZGF1bS5uZXQ=&U1RZUEU9TUFTUw==&TElTVF9UQUJMRT1FTVNfTUFTU19TRU5EX0xJU1RfMTA=&UE9TVF9JRD0yMDE0MTAyMTAwMDAz&VEM9MjAxNDEwMjg=&S0lORD1D&Q0lEPTAyNQ==&URL=http://www.10x10.co.kr/member/mailzine/reject_mailzine.asp
	'vRef = "http://tmailer.10x10.co.kr/Check.html?TV9JRD1rb2J1bGFAZGF1bS5uZXQ=&U1RZUEU9TUFTUw==&TElTVF9UQUJMRT1FTVNfTUFTU19TRU5EX0xJU1RfMTA=&UE9TVF9JRD0yMDE0MTAyMTAwMDAz&VEM9MjAxNDEwMjg=&S0lORD1D&Q0lEPTAyNQ==&URL=http://www.10x10.co.kr/my10x10/"

	if InStr(vRef,"10x10.co.kr")<1 then
		Call Alert_Close("잘못된 접속입니다. E01")
		dbget.Close: response.end
	end if
	
	'리퍼 분해
	tmpArr = right(vRef,len(vRef)-inStr(vRef,"?"))
	tmpArr = split(tmpArr,"&")

	On Error Resume Next
	For lp=0 to ubound(tmpArr)
		tmpKey = trim(strAnsi2Unicode(Base64decode(strUnicode2Ansi(trim(tmpArr(lp))))))			'(특수코드지원용 > base64_u.asp)
		if inStr(tmpKey,"M_ID")>0 then vMail = right(tmpKey,len(tmpKey)-inStr(tmpKey,"="))
		'if inStr(tmpKey,"LIST_TABLE")>0 then vTable = right(tmpKey,len(tmpKey)-inStr(tmpKey,"="))
		'if inStr(tmpKey,"POST_ID")>0 then vPostId = right(tmpKey,len(tmpKey)-inStr(tmpKey,"="))
	Next
	On Error Goto 0

	if vMail="" and vMId<>"" then
		vMail = trim(vMId)
	end if

	if vMail<>"" then
		vEncMail = Server.UrlEncode(tenEnc(vMail))
	end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
function fnReject() {
	$.ajax({
		url: "reject_mailzine_proc.asp?um=<%=vEncMail%>",
		cache: false,
		success: function(message) {
			switch(message) {
				case "E01" :
					alert("잘못된 접속입니다. (Err.01)"); break;
				case "E02" :
					alert("잘못된 접속입니다. (Err.02)"); break;
				case "E03" :
					alert("잘못된 이메일입니다. (Err.03)"); break;
				case "E04" :
					alert("잘못된 이메일입니다. (Err.04)"); break;
				case "E05" :
					alert("이미 수신 거부 신청이 되어있습니다."); break;
				case "OK" :
					$("#lyrForm").hide();
					$("#lyrComplete").show();
					break;
			}
		}
		,error: function(err) {
			//alert(err.responseText);
		}
	});
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
		<!-- // 본문 시작 //-->
		<% if vMail<>"" then %>
			<div id="lyrForm" class="mailReject">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/common/tit_mail_reject.gif" alt="텐바이텐 이메일 수신거부 페이지" /></h2>
				<div class="mailRejectCont">
					<p><img src="http://fiximage.10x10.co.kr/web2013/common/txt01_mail_reject.gif" alt="수신거부로 설정하시면 텐바이텐에서 발송하는 이벤트정보를 받아보실 수 없습니다." /></p>
					<p class="tPad20"><img src="http://fiximage.10x10.co.kr/web2013/common/txt02_mail_reject.gif" alt="이메일 수신 거부와 관계없이 약관안내 및 서비스내용 주문/배송, 회사의 주요 정책 관련 변경에 따른 안내 메일은 정상적으로 발송 됩니다." /></p>
					<p class="tPad40"><span class="fs18 fb crRed" style="line-height:1;"><%=vMail%></span> <img src="http://fiximage.10x10.co.kr/web2013/common/txt03_mail_reject.gif" alt="의 메일 구독을 취소하시겠습니까?" /></p>
				</div>
				<div class="btnArea tPad30">
					<a href="" onclick="fnReject(); return false;" class="btn btnW160 btnB1 btnRed">예</a>
					<a href="/" class="btn btnW160 btnB1 btnGry">아니오</a>
				</div>
			</div>

			<div id="lyrComplete" class="mailReject" style="display:none;">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/common/tit_mail_reject.gif" alt="텐바이텐 이메일 수신거부 페이지" /></h2>
				<div class="mailRejectCont">
					<p><img src="http://fiximage.10x10.co.kr/web2013/common/txt04_mail_reject_1.gif" alt="텐바이텐 이메일 수신거부 처리완료" /></p>
					<p class="tMar30 cr888">
						<%=year(date)&"년 " & month(date)&"월 " & day(date)&"일"%> 수신거부 처리되었습니다.<br />
						메일 수신 여부 설정은 개인정보 페이지를 통해 직접 변경하실 수 있습니다.
					</p>
				</div>
				<div class="btnArea tPad30">
					<a href="/my10x10/userinfo/confirmuser.asp" class="btn btnW160 btnB1 btnRed">변경하기</a>
				</div>
			</div>
		<% else %>
			<div class="mailReject">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/common/tit_mail_reject.gif" alt="텐바이텐 이메일 수신거부 페이지" /></h2>
				<div class="mailRejectCont">
					<p><img src="http://fiximage.10x10.co.kr/web2013/common/txt07_mail_reject.gif" alt="신규가입 후 하루가 지나지 않은 경우," /></p>
					<p class="tPad07" style="height:20px">
						<img src="http://fiximage.10x10.co.kr/web2013/common/txt08_mail_reject.gif" alt="로그인 후" /> <a href="/my10x10/userinfo/confirmuser.asp"><img src="http://fiximage.10x10.co.kr/web2013/common/txt10_mail_reject.gif" alt="마이텐바이텐 > 개인정보수정" /></a> <img src="http://fiximage.10x10.co.kr/web2013/common/txt09_mail_reject.gif" alt="에서 수신 거부가 가능합니다." /></p>
					<p class="tMar44"><img src="http://fiximage.10x10.co.kr/web2013/common/txt06_mail_reject.gif" alt="확인을 누르면 마이페이지로 이동합니다." /></p>
				</div>
				<div class="btnArea tPad30">
					<a href="/my10x10/" class="btn btnW160 btnB1 btnRed">확인</a>
				</div>
			</div>
		<% end if %>
		<!-- // 본문 끝 //-->
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->