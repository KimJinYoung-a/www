<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [컬쳐] 책! 책! 책! Check! Check! Check! 
' History : 2015.05.21 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->

<%
dim eCode, userid, eventnewexists, subscriptcount, getnewcouponid, couponnewcount
		IF application("Svr_Info") = "Dev" THEN
			eCode   =  62773
		Else
			eCode   =  62962
		End If
	userid = getloginuserid()
	
dim cEvent, emimg, ename
set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent

	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
set cEvent = nothing
%>
<style type="text/css">
img {vertical-align:top;}
.evt62962 {position:relative; width:1140px; height:1180px; background:#ffe7e7 url(http://webimage.10x10.co.kr/eventIMG/2015/62962/bg_pattern.png) no-repeat 0 0; text-align:center;}
.evt62962 ul li {position:absolute;}
.evt62962 ul li.coupon1 {top:375px; left:98px;}
.evt62962 ul li.coupon2 {top:435px; left:434px;}
.evt62962 ul li.coupon3 {top:375px; left:772px;}
.evt62962 .btnall {position:absolute; bottom:115px; left:397px; z-index:10; cursor:pointer;}
.evt62962 .btnall a:hover img {-webkit-animation-name:updown; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; -moz-animation-name:updown; -moz-animation-iteration-count:infinite; -moz-animation-duration:0.5s; -ms-animation-name:updown; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes updown {
	from, to{margin-bottom:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-bottom:-7px; -webkit-animation-timing-function:ease-in;}
}
@keyframes updown {
	from, to{margin-bottom:0; animation-timing-function:ease-out;}
	50% {margin-bottom:-7px; animation-timing-function:ease-in;}
}
.evt62962 .bnr {position:absolute; bottom:52px; left:87px}
</style>
<script type="text/javascript">
$(function(){
	animation();

	$(".evt62962 ul li").css({"opacity":"0", "margin-top":"5px"});
	function animation () {
		$(".evt62962 ul li.coupon1").delay(100).animate({"opacity":"1", "margin-top":"0"},700);
		$(".evt62962 ul li.coupon2").delay(600).animate({"opacity":"1", "margin-top":"0"},700);
		$(".evt62962 ul li.coupon3").delay(1200).animate({"opacity":"1", "margin-top":"0"},700);
	}
});


function jscoupion(coupongubun){
	if (coupongubun==''){
		alert('쿠폰구분이 없습니다.');
		return;
	}
	
	<% If IsUserLoginOK() Then %>
		<% If Now() > #05/28/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			evtFrm1.coupongubun.value=coupongubun;
			evtFrm1.mode.value="couponinsert";
			evtFrm1.submit();
		<% End If %>
	<% Else %>
		//alert('로그인을 하셔야 참여가 가능 합니다');
		//return;
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
<div class="evt62962">
	<h1><img src="http://webimage.10x10.co.kr/eventIMG/2015/62962/tit_coupon.png" alt="넣어두는 재미가 솔솔 넣어둬 넣어둬" /></p>
	<ul>
		<li class="coupon1"><a href="" onclick="jscoupion('1'); return false;" title="10% 할인 쿠폰 넣어두기"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62962/img_coupon_01.png" alt="내 마음이야 넣어둬 넣어둬 10% 할인쿠폰 만원 이상 구매시 사용가능" /></a></li>
		<li class="coupon2"><a href="" onclick="jscoupion('3'); return false;" title="5천원 할인 쿠폰 넣어두기"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62962/img_coupon_02.png" alt="오다 주웠다 넣어둬 넣어둬 오천원 쿠폰 3만원 이상 구매시 사용가능" /></a></li>
		<li class="coupon3"><a href="" onclick="jscoupion('7'); return false;" title="만원 할인 쿠폰 넣어두기"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62962/img_coupon_03.png" alt="거절은 거절한다 넣어둬 넣어둬 만원 쿠폰 7만원 이상 구매시 사용 가능" /></a></li>
	</ul>
	<div class="btnall"><a href="" onclick="jscoupion('all'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62962/btn_all.png" alt="쿠폰 한번에 넣어두기" /></a></div>
	<div class="bnr"><a href="/event/eventmain.asp?eventid=62702" title="이벤트 보러가기" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62962/img_bnr.png" alt="실속있는 당신을 위해 준비했습니다! 누구보다 합리적인 쇼핑! 임박상품을 한눈에 살펴보세요." /></a></div>
</div>
<form name="evtFrm1" action="/event/etc/doEventSubscript62962.asp" method="post" target="evtFrmProc" style="margin:0px;">
	<input type="hidden" name="mode">
	<input type="hidden" name="coupongubun">
</form>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->