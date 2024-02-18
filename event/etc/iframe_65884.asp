<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 스폰서 쿠폰
' History : 2015.09.03 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, userid, getbonuscoupon, currenttime, getlimitcnt
	IF application("Svr_Info") = "Dev" THEN
		eCode = "64877"
	Else
		eCode = "65884"
	End If
	IF application("Svr_Info") = "Dev" THEN
		getbonuscoupon = "2737"
	Else
		getbonuscoupon = "773"
	End If

	currenttime = now()
	'currenttime = #09/07/2015 14:05:00#

	userid = GetEncLoginUserID()
	getlimitcnt = 100000		'50000

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
.evt65884 {text-align:left; background:#fff;}
.couponDownload {position:relative; height:432px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65884/img_coupon_01.gif) 100% 0 no-repeat;}
.couponDownload p {position:absolute;}
.couponDownload .btnCpDown {left:352px; top:249px; width:435px; height:100px; z-index:30;}
.couponDownload .btnCpDown a {display:block; width:100%; height:100%; text-indent:-9999px;}
.couponDownload .finishSoon {left:249px; top:0; z-index:50;}
.couponDownload .soldout {left:289px; top:22px; z-index:40;}
.evtNoti {overflow:hidden; padding:42px 0 42px 113px; color:#917a70; background:#fff7ec;}
.evtNoti h3 {float:left; width:168px;}
.evtNoti .list {overflow:hidden; float:left; width:820px; line-height:24px; padding-left:38px;}
.evtNoti ul {float:left; width:50%;}
.evtNoti li {text-indent:-9px; padding-left:9px;}
</style>
<script type="text/javascript">

function jseventSubmit(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2015-09-05" and left(currenttime,10)<"2015-09-10" ) Then %>
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
						frm.action="/event/etc/doeventsubscript/doEventSubscript65884.asp";
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

<div class="evt65884">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/65884/tit_sponsor.gif" alt="스폰서 쿠폰" /></h2>

	<div class="couponDownload">
		<p class="btnCpDown"><a href="" onclick="jseventSubmit(evtFrm1); return false;">4만원 이상 구매시 1만원 할인쿠폰 다운받기</a></p>
		
		<% if totalsubscriptcount>=getlimitcnt or totalbonuscouponcount>=getlimitcnt then %>
			<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65884/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다. 다음 기회를 기다려주세요" /></p>
		<% else %>
			<% if ((getlimitcnt - totalsubscriptcount) < 5000) or ((getlimitcnt - totalbonuscouponcount) < 5000) then %>
				<p class="finishSoon"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65884/txt_finish_soon.png" alt="마감임박" /></p>
			<% end if %>
		<% end if %>
		
		<% if left(currenttime,10)="2015-09-09" then %>
			<div class="lastDay"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65884/img_coupon_02.gif" alt="오늘 밤 12시 쿠폰이 종료됩니다!" /></div>
		<% end if %>
	</div>

	<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65884/txt_special_stage.gif" alt="SPECIAL STAGE - 본 쿠폰을 사용하신 고객님께 9월 11일 특별한 5,000마일리지가 찾아갑니다!" /></p>
	<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/65884/btn_go.gif" alt="" usemap="#sponsorMap" /></div>
	<map name="sponsorMap" id="sponsorMap">
		<area shape="rect" coords="85,50,485,184" alt="텐바이텐 APP 다운받기" href="/event/appdown/" target="_top" />
		<area shape="rect" coords="658,50,1055,184" alt="회원가입하고 구매하러 가기" href="/member/join.asp" target="_top" />
	</map>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65884/tit_notice.gif" alt="이벤트 유의사항" /></h3>
		<div class="list">
			<ul>
				<li>- 본 이벤트는 선착순 한정수량으로 진행되어 조기 마감될 수 있습니다.</li>
				<li>- 이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
				<li>- 지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
				<li>- 쿠폰 사용은 9/9(수) 23시 59분 59초에 마감됩니다.</li>
				<li>- 주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
			</ul>
			<ul>
				<li>- 마일리지는 9월 11일 일괄지급 될 예정입니다.</li>
				<li>- 9월 11일에 지급되는 마일리지의 사용 기간은 14일<br />자정까지이며 기간 내에 사용하지 않을 시,<br />사전 통보없이 자동 소멸됩니다.</li>
			</ul>
		</div>
	</div>
</div>
<form name="evtFrm1" action="" onsubmit="return false;" method="post" style="margin:0px;">
	<input type="hidden" name="mode">
</form>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0 style="display:none;"></iframe>

</body>
</html>
<!-- #include virtual="/lib/poptailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->