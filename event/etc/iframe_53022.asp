<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : ##신한카드 패밀리카드(W)
' History : 2014.06.26 유태욱
'####################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/etc/event53022Cls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<%
dim cEvent, eCode
dim smssubscriptcount, usercell, userid
	eCode=getevt_code
	userid = getloginuserid()
smssubscriptcount=0
usercell=""

set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode
set cEvent = nothing

smssubscriptcount = getevent_subscriptexistscount(eCode, userid, "SMS_W", "", "")
usercell = getusercell(userid)
%>

<style type="text/css">
.evt53022 {position:relative; text-align:center;}
.evt53022 .appDownload {height:504px; background:url(http://webimage.10x10.co.kr/eventIMG/2014/53022/bg_app_down.gif) left top no-repeat;}
.evt53022 .appDownload h3 {padding:58px 0; }
.evt53022 .appDownload h4 {padding:23px 0 45px;}
.evt53022 .appDownload .goWrap {overflow:hidden; padding:0 0 0 113px;}
.evt53022 .appDownload .goQrCode,
.evt53022 .appDownload .goUrl {float:left; width:421px; height:262px; padding:0 15px 0 0; margin-right:54px; background:url(http://webimage.10x10.co.kr/eventIMG/2014/53022/bg_box.png) left top no-repeat;}
.evt53022 .appDownload .goQrCode h4 {margin-bottom:14px;}
.evt53022 .appDownload .goUrl .inpTel {margin:0 auto 15px; width:293px; height:33px; padding-top:5px; border:1px solid #90e9e2; background:#f5f5f5;}
.evt53022 .appDownload .goUrl .inpTel input {text-align:center; font-size:14px; width:280px; height:28px; line-height:28px; font-family:verdana; background:#f5f5f5;}
</style>

<script type="text/javascript">
function jsSubmitsms(frm){
	<% If IsUserLoginOK() Then %>
		<% If now() > #07/31/2014 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% if smssubscriptcount < 3 then %>
				if(frm.usercellnum.value =="로그인 해주세요. (1일 3회)"){
					jsChklogin('<%=IsUserLoginOK%>');
					return false;
				}
				if (frm.usercellnum.value == ''){
					alert("휴대폰 번호가 정확하지 않습니다.\n마이텐바이텐에서 개인정보를 수정해 주세요.!");
					return;
				}
			   		frm.mode.value="addsms";
					frm.action="/event/etc/doEventSubscript53022.asp";
					frm.target="evtFrmProc";
					frm.submit();
				return;
			<% else %>
				alert("메세지는 3회까지 발송 가능 합니다.");
				return;
			<% end if %>
		<% End If %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}
</script>
</head>
<body>
	<!-- 신한카드 이벤트 -->
	<div class="evt53022">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2014/53022/tit_shinhan_card.jpg" alt="어서오세요, 텐바이텐 입니다! - LG/GS/LS/LIG 그룹 패밀리 회원들을 위한 신규 서비스 텐바이텐 5% 청구할인" /></h2>
		<div>
			<img src="http://webimage.10x10.co.kr/eventIMG/2014/53022/img_popular_product.jpg" alt="텐바이텐에서는 이런 상품들이 사랑받고 있어요!" usemap="#map01" />
			<map name="map01" id="map01">
				<area shape="circle" coords="270,229,125" href="/shopping/category_prd.asp?itemid=1047275" target="_top" alt="여행용 다용도 파우치" />
				<area shape="circle" coords="568,229,125" href="/shopping/category_prd.asp?itemid=882296" target="_top" alt="아이코닉 행키" />
				<area shape="circle" coords="869,230,124" href="/shopping/category_prd.asp?itemid=1059954" target="_top" alt="샌드위치 시계" />
				<area shape="circle" coords="268,553,127" href="/shopping/category_prd.asp?itemid=880438" target="_top" alt="스키니 3단 우산" />
				<area shape="circle" coords="568,553,127" href="/shopping/category_prd.asp?itemid=742608" target="_top" alt="플라워 프레그런스" />
				<area shape="circle" coords="865,553,126" href="/shopping/category_prd.asp?itemid=933537" target="_top" alt="데스크매트" />
			</map>
		</div>
		<div class="appDownload">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2014/53022/tit_app_download.png" alt="텐바이텐 앱을 만나보세요! 가장 트렌디하고 스타일리시한 텐바이텐 쇼핑을 텐바이텐 앱에서 즐기실 수 잉ㅆ습니다." /></h3>
			<div class="goWrap">
				<div class="goQrCode">
					<h4><img src="http://webimage.10x10.co.kr/eventIMG/2014/53022/tit_qr_code.gif" alt="QR코드 찍어서 설치하기" /></h4>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2014/53022/img_qr_code.gif" alt="스마트폰의 스캔어플을 이용해 QR코드를 찍어주세요. 안드로이드 마켓 혹은 앱스토어에서 텐바이텐을 검색해주세요!" /></p>
				</div>

				<form name="evtfrm" action="" onsubmit="return false;" method="post" style="margin:0px;">
				<input type="hidden" name="mode">
				<!-- url 받아서 설치하기 -->
				<div class="goUrl">
					<h4><img src="http://webimage.10x10.co.kr/eventIMG/2014/53022/tit_url.gif" alt="메시지로 URL받아서 설치하기" /></h4>

					<p class="inpTel"><input type="text" name="usercellnum" readonly value="<%IF NOT IsUserLoginOK THEN%>로그인 해주세요. (1일 3회)<% else %><%=usercell%><%END IF%>" /></p>
					<p><input type="image" onclick="jsSubmitsms(evtfrm); return false;" src="http://webimage.10x10.co.kr/eventIMG/2014/53022/btn_url.gif" alt="URL 받기" /></p>
					<p class="tPad25"><img src="http://webimage.10x10.co.kr/eventIMG/2014/53022/txt_send.gif" alt="등록된 번호로 전송되며, 비용은 무료입니다." /></p>
				</div>
				<!--//url 받아서 설치하기 -->
				</form>
			</div>
		</div>
	</div>
	<!-- //신한카드 이벤트 -->
	<form name="evtFrm1" action="" onsubmit="return false;" method="post" style="margin:0px;">
		<input type="hidden" name="mode">
	</form>
	<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->