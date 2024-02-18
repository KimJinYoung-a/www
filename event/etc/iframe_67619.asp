<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 응답하라 보너스 쿠폰
' History : 2015-11-23 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid , strSql
Dim getbonuscoupon , getlimitcnt , currenttime
Dim totcnt1

	IF application("Svr_Info") = "Dev" THEN
		eCode = "65960"
	Else
		eCode = "67619"
	End If

	IF application("Svr_Info") = "Dev" THEN
		getbonuscoupon = "2751"
	Else
		getbonuscoupon = "796"
	End If

	userid = getEncLoginUserID()
	getlimitcnt = 30000		'50000
	currenttime = now()

dim bonuscouponcount, subscriptcount, totalsubscriptcount, totalbonuscouponcount
bonuscouponcount=0
subscriptcount=0
totalsubscriptcount=0
totalbonuscouponcount=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
	bonuscouponcount = getbonuscouponexistscount(userid, getbonuscoupon, "", "", "")
end if

'//전체 참여수
totalsubscriptcount = getevent_subscripttotalcount(eCode, "", "", "")
'//전체 쿠폰 발행수량
totalbonuscouponcount = getbonuscoupontotalcount(getbonuscoupon, "", "", "")
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
.evt67619 {position:relative;}
.deadline {position:absolute; left:204px; top:440px;}
.finish {position:absolute; left:50%; top:500px; width:699px; height:270px; padding-top:155px; margin-left:-349px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67619/bonus_finish_bg.png) 50% 50% no-repeat; text-align:center; font-size:30px; color:#fff; font-weight:bold;}
.noti {overflow:hidden; position:relative; height:213px;}
.noti ul {position:absolute; left:250px; top:45px;}
.noti ul li {position:relative; text-align:left; font-size:11px; color:#7a7a7a; margin:5px 0; padding-left:15px;}
.noti ul li:before {position:absolute; left:0; top:8px; width:5px; height:1px; background-color:#6e6e6e; content:'';}
.cpCheck {display:none; position:fixed; top:50% !important; left:50% !important; width:566px; height:558px; margin:-279px 0 0 -283px;}
.cpCheck > div {position:relative; width:100%; height:100%;}
.cpCheck .cpOk {overflow:hidden; position:absolute; left:50%; bottom:90px; width:70%; height:70px; margin-left:-35%; background-color:transparent; text-indent:-999em;}
</style>
<script type="text/javascript">

function layershow(){
	parent.viewPoupLayer('modal',$('#cpCheck').html());
}

function jseventSubmit(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10) = "2015-11-25") Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount>0 or bonuscouponcount>0 then %>
				alert("쿠폰은 한 개의 아이디당 한 번만 다운 받으실 수 있습니다.");
				return;
			<% else %>
				<% if totalsubscriptcount>=getlimitcnt or totalbonuscouponcount>=getlimitcnt then %>
					alert("죄송합니다. 쿠폰이 모두 소진 되었습니다.");
					return;
				<% else %>
					frm.action="/event/etc/doeventsubscript/doEventSubscript67619.asp";
					frm.target="evtFrmProc";
					frm.mode.value='coupon';
					frm.submit();
				<% end if %>
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}
</script>
</head>
<body>
<div class="evt67619">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/67619/bonus_tit.jpg" alt="응답하라 보너스쿠폰" /></h2>
	<% if totalsubscriptcount>=getlimitcnt or totalbonuscouponcount>=getlimitcnt then %>
	<div class="finish">
		<p style="color:#fef677;">쿠폰이 모두 소진되었습니다.</p>
		<p>다음 기회를 기다려주세요 : )</p>
	</div>
	<% else %>
		<% if ((getlimitcnt - totalsubscriptcount) < 5000) or ((getlimitcnt - totalbonuscouponcount) < 5000) then %>
			<span class="deadline"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67619/bonus_deadline.png" alt="마감임박" /></span>
		<% End If %>
	<% End If %>
	<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/67619/bonus_radio.gif" alt="" /></p>
	<p><a href="#cpCheck" onclick="jseventSubmit(evtFrm1);return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67619/bonus_btn.jpg" alt="쿠폰 확인하기" /></a></p>
	<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/67619/bonus_down.jpg" alt="텐바이텐 APP 설치 아직이신가요? 텐바이텐에 처음오셨나요?" usemap="#downMap" /></p>
	<map name="downMap" id="downMap">
		<area shape="rect" coords="65,100,506,200" href="/event/appdown/" target="_parent" alt="텐바이텐 APP 다운" />
		<area shape="rect" coords="639,100,1083,200" href="/member/join.asp" target="_parent" alt="회원가입하고 구매하러 Go" />
	</map>
	<div class="noti">
		<strong><img src="http://webimage.10x10.co.kr/eventIMG/2015/67619/bonus_noti.gif" alt="이벤트 유의사항" /></strong>
		<ul>
		  <li>이벤트는 ID 당 1일 1회만 참여할 수 있습니다.</li>
		  <li>지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
		  <li>쿠폰은 금일 11/25(수) 23시59분 종료됩니다.</li>
		  <li>주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
		  <li>이벤트는 조기 마감 될 수 있습니다.</li>
		</ul>
	</div>
	<div id="cpCheck">
		<div class="cpCheck window">
			<div style="position:relative; width:100%; height:100%;">
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/67619/bonus_cupon.png" alt="쿠폰이 발급되었습니다." />
				<button type="button" onclick="ClosePopLayer()" style="overflow:hidden; position:absolute; left:50%; bottom:95px; width:70%; height:70px; margin-left:-35%; background-color:transparent; text-indent:-999em;">확인</button>
			</div>
		</div>
	</div>
	<form name="evtFrm1" action="" onsubmit="return false;" method="post" style="margin:0px;height:0;">
	<input type="hidden" name="mode" />
	</form>
	<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width="0" height="0" style="display:none;"></iframe>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->