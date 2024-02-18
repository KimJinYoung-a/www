<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : show me the coupon
' History : 2015.08.03 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, userid, getbonuscoupon, currenttime, getlimitcnt
	IF application("Svr_Info") = "Dev" THEN
		eCode = "64844"
	Else
		eCode = "65062"
	End If
	IF application("Svr_Info") = "Dev" THEN
		getbonuscoupon = "2729"
	Else
		getbonuscoupon = "759"
	End If

	currenttime = now()
	'currenttime = #08/05/2015 14:05:00#

	userid = getloginuserid()
	getlimitcnt = 60000

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

<style type="text/css">
img {vertical-align:top;}
.evt65062 {position:relative; width:1140px;}
.evt65062 .soldout {position:absolute; left:332px; top:477px;}
.evtNoti {padding:53px 89px 47px; margin-bottom:-20px; text-align:left; background:#ececec;}
.evtNoti h3 {padding-bottom:24px;}
.evtNoti li {padding:0 0 10px 15px; color:#5e5e5e; font-size:11px; line-height:12px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65062/blt_arrow.gif) no-repeat 0 0;}
</style>
<script type="text/javascript">

function jseventSubmit(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2015-08-05" and left(currenttime,10)<"2015-08-07" ) Then %>
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
					<% ' if Hour(currenttime) < 14 then %>
						//alert("쿠폰은 오후 2시부터 다운 받으실수 있습니다.");
						//return;
					<% ' else %>
						frm.action="/event/etc/doeventsubscript/doEventSubscript65062.asp";
						frm.target="evtFrmProc";
						frm.mode.value='couponreg';
						frm.submit();
					<% ' end if %>
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

<!-- show me the coupon -->
<div class="evt65062">
	<% if totalsubscriptcount>=getlimitcnt or totalbonuscouponcount>=getlimitcnt then %>
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/65062/img_showme_thecoupon.jpg" alt="SHOW ME THE COUPON" usemap="#Map" /></div>
		<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65062/txt_soldout_w.gif" alt="쿠폰이 모두 소진되었습니다. 다음 기회에 이용해주세요" /></p>
	<% else %>
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/65062/img_showme_thecoupon.jpg" alt="SHOW ME THE COUPON" usemap="#Map" /></div>
	<% end if %>

	<map name="Map" id="Map">
		<area shape="rect" coords="373,729,760,801" href="" onclick="jseventSubmit(evtFrm1); return false;" alt="DROP THE COUPON" />
		<area shape="rect" coords="94,1063,512,1147" href="/event/appdown/" target="_blank" alt="텐바이텐 APP 다운 받으러 GO!" />
		<area shape="rect" coords="630,1064,1044,1147" href="/member/join.asp" target="_top" alt="회원가입하고 구매하러 GO!" />
	</map>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65062/tit_notice.gif" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>이벤트는 ID당 1회만 참여할 수 있습니다.</li>
			<li>지급된 쿠폰은 텐바이텐에서만 사용가능합니다.</li>
			<li>쿠폰은 8/6(목) 23시 59분 종료됩니다.</li>
			<li>주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
			<li>이벤트는 조기 마감 될 수 있습니다.</li>
			<li>마일리지는 8월 10일 일괄지급 될 예정입니다.</li>
			<li>8월 10일에 지급되는 마일리지의 사용 기간은 12일 자정까지이며 기간 내에 사용하지 않을 시 사전 통보 없이 자동 소멸합니다.</li>
		</ul>
	</div>
</div>
<!--// show me the coupon -->
<form name="evtFrm1" action="" onsubmit="return false;" method="post" style="margin:0px;">
	<input type="hidden" name="mode">
</form>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>

<!-- #include virtual="/lib/db/dbclose.asp" -->