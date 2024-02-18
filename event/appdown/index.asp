<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  텐바이텐 APP 다운로드 & 쿠폰 다운로드
' History : 2014-09-30 이종화 생성
'			2016-01-19 이종화 리뉴얼
'           2017-09-18 허진원 리뉴얼
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/event/appdown/appdownCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, rstWishItem, rstWishCnt
dim cEvent, cEvent50277, intI, iTotCnt, rstArrItemid, blnitempriceyn, sBadges, smssubscriptcount, usercell, userid
Dim itemordercheck
itemordercheck = True  '// 구매이력 있음

	eCode  = getevt_code
	userid = getloginuserid()

iTotCnt=0
rstArrItemid=""
rstWishItem=""
rstWishCnt=""
intI = 0
smssubscriptcount=0
usercell=""

smssubscriptcount = getevent_subscriptexistscount(eCode, userid, "SMS_W", "", "")
usercell = getusercell(userid)

	dim cnt, sqlStr
	dim	couponid

	IF application("Svr_Info") = "Dev" THEN
		couponid   =  2761 '2016년
	Else
		couponid   =  1060 '2018년
	End If

	If IsUserLoginOK Then
		'쿠폰 발급 여부 확인
		sqlStr = " Select count(*) as cnt " &VBCRLF
		sqlStr = sqlStr & " From [db_user].dbo.tbl_user_coupon " &VBCRLF
		sqlStr = sqlStr & " WHERE  masteridx = " & couponid & "" &VBCRLF
		sqlStr = sqlStr & " and userid='" & userid & "'"
		rsget.Open sqlStr,dbget,1
			cnt=rsget(0)
		rsget.Close
	End If

	
	'// 구매 이력 유무
	itemordercheck = fnUserGetOrderCheck(userid,"APP")
%>
<style type="text/css">
.tentenapp button {background-color:transparent;}
.tentenapp {position:relative; height:1077px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/appdown/bg_appdown.jpg) no-repeat 50% 0;}
.tentenapp .topic {position:relative; height:810px;}
.tentenapp .topic h2 {position:absolute; top:129px; left:110px;}
.tentenapp .topic p {position:absolute; top:526px; right:110px;}
.tentenapp .article {display:none; position:relative; padding:62px 40px; text-align:left; background-color:#3c3e4b;}
.tentenapp .article:after {position:absolute; left:50%; top:45px; bottom:45px; width:1px; margin-left:97px; border-right:1px dashed #656c78; content:'';}
.tentenapp .article .appDownload {width:626px; text-align:center;}
.tentenapp .article .appDownload .sms .iText {margin-top:22px;}
.tentenapp .article .appDownload .sms .iText input {width:316px; height:42px; border:0; background-color:#fff; color:#868685; font-family:'Dotum', 'Verdana'; font-size:15px; font-weight:bold; line-height:42px; text-align:center;}
.tentenapp .article .appDownload .sms p {margin-top:9px;}
.tentenapp .article .appDownload .sms .btnSubmit {margin-top:25px;}
.tentenapp .article .qr {position:absolute; left:50%; top:62px; margin-left:225px;}
.tentenapp .article .qr p {margin-top:33px;}
.tentenapp .coupon {display:none; position:relative; text-align:left;}
.tentenapp .coupon .btnCoupon {position:absolute; top:118px; right:82px;}

.shareSns {position:absolute; top:80px; right:50px;}
.shareSns ul li a {display:block; position:relative; width:67px; height:64px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/app/bg_sns.png) no-repeat 0 0; color:#39599f; text-align:center;}
.shareSns ul li a span {visibility:hidden; position:absolute; top:7px; right:70px; width:100px; height:30px; border:4px solid #fff; background:rgba(255,255,255,0.3); text-shadow:1px 1px 1px rgba(0, 0, 0, 0.1); border-radius:5px; font-size:11px; line-height:30px;}
.shareSns ul li a span {transform:translate(35px) rotate(25deg) scale(1.5); transition:all 0.3s ease-in-out;}
.shareSns ul li a span:after {visibility:hidden; content:' '; position:absolute; top:10px; right:-10px; width:0; height:0; border-top:5px solid transparent; border-bottom:5px solid transparent; border-left:5px solid rgba(255,255,255,0.3);}
.shareSns ul li a:hover {text-decoration:none;}
.shareSns ul li a:hover span {visibility:visible; opacity:0.9; transform:translate(0px) rotate(0deg) scale(1);}
.shareSns ul li a:hover span:after {visibility:visible; border-left:6px solid rgba(255,255,255,0.9);}
.shareSns ul li.facebook {height:67px;}
.shareSns ul li.facebook a span {top:10px;}
.shareSns ul li.twitter a {color:#45b0e3; background-position:0 -67px;}
.shareSns ul li.pinterest a {color:#bd0a1e; background-position:0 100%;}
</style>
<script>
function checkform(frm) {
<% If IsUserLoginOK()Then %>
	<% If cnt > 0 Then %>
			alert('ID당 1회 발급 사용 가능합니다.');
			return;
	<% else %>
			<%'// 앱 구매 이력이 없을경우 %>
			<% if not(itemordercheck) then %>
				frm.action = "/event/appdown/doEventSubscript_appCoupon.asp";
				frm.submit();
			<% else %>
				alert('죄송합니다.\nAPP에서 구매 이력이 없으신 고객을 위한 이벤트 입니다.');
				return;
			<% end if %>
	<% end if %>
<% Else %>
	jsChklogin('<%=IsUserLoginOK%>');
<% End If %>
}

function jsSubmitsms(frm){
	<% If IsUserLoginOK() Then %>
		<% If Now() > #12/31/2017 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If getnowdate>="2016-01-01" and getnowdate<"2017-12-31" Then %>
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
					frm.action="/event/appdown/doEventSubscript_appdown.asp";
					frm.target="evtFrmProc";
					frm.submit();
					return;
				<% else %>
					alert("메세지는 3회까지 발송 가능 합니다.");
					return;
				<% end if %>
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>				
		<% End If %>
	<% Else %>
		jsChklogin('<%=IsUserLoginOK%>');
	<% End IF %>
}	
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="eventContV15">
				<div class="contF">
					<div class="contF">

						<div class="tentenapp">
							<div class="topic">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/appdown/tit_tenten_app.png" alt="지금 텐바이텐 앱 다운받고 다양한 혜택 받으세요" /></h2>
								<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/appdown/txt_mobile.png" alt="10X10을 모바일에서도 만나세요" /></p>
							</div>
							<div class="qr"><img src="//webimage.10x10.co.kr/fixevent/event/2020/appdown/img_qr.png" alt="QR 코드를 통해 텐바이텐 APP 다운받기" /></div>

							<div class="article">
								<div class="appDownload">
									<div class="desc sms">
										<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/appdown/tit_sms.png" alt="앱 설치주소 메시지 받기" /></h3>
										<form name="evtfrm" action="" onsubmit="return false;" method="post" style="margin:0px;">
										<input type="hidden" name="mode"/>
											<fieldset>
											<legend>앱 설치주소 문자 메시지로 받기</legend>
												<!-- for dev msg : 로그인 전에는 로그인 해주세요. (1일 3회) 메시지 보여주세요 -->
												<div class="iText"><input type="text" title="휴대폰 번호 입력" name="usercellnum" readonly title="휴대폰 번호 입력" value="<%IF NOT IsUserLoginOK THEN%>로그인 해주세요. (1일 3회)<% else %><%=usercell%><%END IF%>" /></div>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/appdown/txt_free.png" alt="등록된 번호로 전송되며, 비용은 무료입니다." /></p>
												<div class="btnSubmit"><input type="image" onclick="jsSubmitsms(evtfrm); return false;" src="http://webimage.10x10.co.kr/eventIMG/2017/appdown/btn_sms.png" alt="문자 보내기" /></div>
											</fieldset>
										</form>
									</div>

									<div class="desc qr">
										<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/appdown/tit_qrcode.png" alt="QR 코드로 받기" /></h3>
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/appdown/img_qrcode.png" alt="텐바이텐 앱 QR 코드" /></p>
									</div>
								</div>
							</div>

							<form name="frm" method="POST" style="margin:0px;">
							<div class="coupon">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/appdown/img_tenten_coupon_v2.png" alt="신규설치 시 앱전용 3천원쿠폰 즉시 지급! 3만원 이상 구매시 사용가능합니다. 단, 다운로드 후 24시간 이내에 사용하셔야 하며, 아이디당 1회 사용가능합니다." /></p>
								<div class="btnCoupon">
									<button type="button" onclick="checkform(frm);"><img src="http://webimage.10x10.co.kr/eventIMG/2017/appdown/btn_coupon_v2.png" alt="쿠폰 다운받기" /></button>
								</div>
							</div>
							</form>

						<%
							'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
							dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
							snpTitle = Server.URLEncode("텐바이텐 APP 다운 이벤트")
							snpLink = Server.URLEncode("http://www.10x10.co.kr/event/appdown/")
							snpPre = Server.URLEncode("텐바이텐 이벤트")
							snpTag = Server.URLEncode("텐바이텐 APP 다운 이벤트")
							snpTag2 = Server.URLEncode("#10x10")
							snpImg = Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2016/app/m/img_kakao.png")
						%>
							<div class="shareSns">
								<ul>
									<li class="facebook"><a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><span>페이스북</span></a></li>
									<li class="twitter"><a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');return false;"><span>트위터</span></a></li>
									<li class="pinterest"><a href="" onclick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>');return false;"><span>핀터레스트</span></a></li>
								</ul>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->