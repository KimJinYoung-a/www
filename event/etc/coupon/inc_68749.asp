<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 발렌타임 - 쿠폰
' History : 2016-01-27 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid , strSql
Dim getbonuscoupon1 , getbonuscoupon2 , getlimitcnt1, getlimitcnt2 , currenttime
Dim totcnt1 , totcoupon
Dim extratime , HH , MM

	IF application("Svr_Info") = "Dev" THEN
		eCode = "66016"
	Else
		eCode = "68749"
	End If

	IF application("Svr_Info") = "Dev" THEN
		getbonuscoupon1 = "2763"
		getbonuscoupon2 = "2764"
	Else
		getbonuscoupon1 = "818" '오전
		getbonuscoupon2 = "819" '오후
	End If

	userid = getEncLoginUserID()
	getlimitcnt1 = 3000		'3000
	getlimitcnt2 = 6000		'3000
	currenttime = now()

	If hour(now()) < 13 then
		totcoupon = getbonuscoupon1
	Else
		totcoupon = getbonuscoupon2
	End If 

dim bonuscouponcount1, subscriptcount1, totalsubscriptcount, totalbonuscouponcount1
dim bonuscouponcount2, totalbonuscouponcount2
Dim use_bonuscouponcount1 , use_bonuscouponcount2

bonuscouponcount1=0
subscriptcount1=0
totalsubscriptcount=0
totalbonuscouponcount1=0

bonuscouponcount2=0
totalbonuscouponcount2=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount1 = getevent_subscriptexistscount(eCode, userid, "", "", Date())
	bonuscouponcount1 = getbonuscouponexistscount(userid, getbonuscoupon1, "", "", "")
	use_bonuscouponcount1 = getbonuscouponexistscount(userid, getbonuscoupon1, "", "Y", Date())
	bonuscouponcount2 = getbonuscouponexistscount(userid, getbonuscoupon2, "", "", "")
	use_bonuscouponcount2 = getbonuscouponexistscount(userid, getbonuscoupon2, "", "Y", Date())
end if

'//전체 참여수
totalsubscriptcount = getevent_subscripttotalcount(eCode, Date(), totcoupon, "")
'//오늘 쿠폰 발행수량
totalbonuscouponcount1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", Date())
totalbonuscouponcount2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", Date())
%>
<style type="text/css">
img {vertical-align:top;}
.evt68749 {position:relative; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68749/bg_stripe.png) repeat-y 0 0;}
.valenTime {overflow:hidden; position:relative; padding:112px 146px 60px;}
.valenTime .getCoupon:after {content:' '; display:block; clear:both;}
.valenTime .deco {position:absolute; left:0; top:0; width:100%; height:82px; z-index:30; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68749/bg_deco.png) no-repeat 0 0;}
.valenTime .timeTab {float:left; padding-top:27px;}
.valenTime .timeTab li {width:252px; height:88px; margin-bottom:37px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68749/txt_tab.png) no-repeat 0 0; cursor:pointer;}
.valenTime .timeTab li.am9 {background-position:0 0;}
.valenTime .timeTab li.pm9 {background-position:0 100%;}
.valenTime .timeTab li span {display:none; width:252px; height:88px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68749/txt_tab.png) no-repeat 0 0; text-indent:-9999px;}
.valenTime .timeTab li.current span {display:block;}
.valenTime .timeTab li.am9 span {background-position:100% 0;}
.valenTime .timeTab li.pm9 span {background-position:100% 100%;}
.valenTime .timeCoupon {position:relative; float:right; padding-bottom:55px;}
.valenTime .timeCoupon .limit {position:absolute; right:-53px; top:-38px; z-index:20;}
.valenTime .timeCoupon .soldOut {position:absolute; left:0; top:0; z-index:10; width:514px; height:267px; background-position:0 0; background-repeat:no-repeat; text-indent:-9999px;}
.valenTime .timeCoupon .am9 .soldOut {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68749/txt_soon_01.png)}
.valenTime .timeCoupon .pm9 .soldOut {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68749/txt_soon_02.png)}
.valenTime .timeCoupon .soldOut.finish {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68749/txt_soon_03.png);}
.valenTime .btnCoupon {background:transparent;}
.evtNoti {overflow:hidden; padding:40px 100px; text-align:left; background:#8a6565;}
.evtNoti h3 {float:left; width:170px; padding-top:15px; text-align:left;}
.evtNoti ul {float:left; width:400px; padding-left:45px; border-left:1px solid #fff;}
.evtNoti ul li {font-size:12px; line-height:13px; padding-top:10px; color:#fff;}
.evtNoti ul li:first-child {padding-top:0;}
#couponLayer {display:none; position:absolute; left:0; top:0; z-index:100; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68749/bg_mask.png) repeat 0 0;}
#couponLayer .cpCont {position:absolute; left:50%; top:218px; margin-left:-243px;}
#couponLayer .cpCont strong {display:block; position:absolute; left:0; top:172px; width:100%; color:#ff5855; font-size:18px;}
#couponLayer .cpCont strong em {border-bottom:1px solid #ff5855;}
#couponLayer .timeCont {position:absolute; left:0; top:0; z-index:105;}
#couponLayer .btnConfirm {position:absolute; left:50%; top:434px; margin-left:-163px; background:transparent;}
#couponLayer .btnClose {position:absolute; right:38px; top:32px; z-index:110; background:transparent;}
</style>
<script type="text/javascript">
$(function(){
	$("#couponLayer .btnConfirm").click(function(){
		$("#couponLayer").fadeOut();
	});
	$("#couponLayer .btnClose").click(function(){
		$("#couponLayer").fadeOut();
	});
});

function jseventSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( Now() > #02/01/2016 00:00:00# and Now() < #02/03/2016 23:59:59# ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount1>0 or use_bonuscouponcount1>0 or use_bonuscouponcount2>0 then %>
				alert("쿠폰은 한 개의 아이디당 한 번만 다운 받으실 수 있습니다.");
				return;
			<% else %>
				<% if totalbonuscouponcount1>=getlimitcnt1 and totalbonuscouponcount2>=getlimitcnt2 then %>
					alert("죄송합니다. 쿠폰이 모두 소진 되었습니다.");
					return;
				<% else %>
					var result;
						$.ajax({
							type:"POST",
							url:"/event/etc/doeventsubscript/doEventSubscript68749.asp",
							data: "mode=coupon",
							dataType: "text",
							async: false,
							success : function(Data){
								result = jQuery.parseJSON(Data);
								if (result.rtcode=="05")
								{
									alert('잠시 후 다시 시도해 주세요.');
									return;
								}
								else if (result.rtcode=="04")
								{
									alert('한 개의 아이디당 한 번만 발급 가능 합니다.');
									return;
								}
								else if (result.rtcode=="03")
								{
									alert('이벤트 응모 기간이 아닙니다.');
									return;
								}
								else if (result.rtcode=="02")
								{
									alert('로그인을 해주세요.');
									return;
								}
								else if (result.rtcode=="01")
								{
									alert('잘못된 접속입니다.');
									return;
								}
								else if (result.rtcode=="00")
								{
									alert('정상적인 경로가 아닙니다.');
									return;
								}
								else if (result.rtcode=="06")
								{
									alert('이벤트 응모 시간이 아닙니다.');
									return;
								}
								else if (result.rtcode=="07")
								{
									alert('쿠폰이 모두 소진 되었습니다.');
									return;
								}
								else if (result.rtcode=="11")
								{
									$("#couponLayer").fadeIn();
									window.parent.$('html,body').animate({scrollTop:350}, 700);
								}
								else
								{
									alert('오류가 발생했습니다.');
									return false;
								}
							}
						});
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
<div class="evt68749">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/tit_valen_time.png" alt="발렌타임쿠폰" /></h2>
	<div class="valenTime">
		<div class="deco"></div>
		<div class="getCoupon">
			<div class="timeTab">
				<ul>
					<li onclick="" class="am9 <%=chkiif(hour(now())<12," current","")%>"><span>오전9시</span></li>
					<li onclick="" class="pm9 <%=chkiif(hour(now())>11," current","")%>"><span>오후9시</span></li>
				</ul>
			</div>
			<div class="timeCoupon">
				<p class="limit"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/txt_limit.png" alt="선착순 3,000명" /></p>
				<% If hour(now()) >= 9 and hour(now()) < 21  Then %>
				<div class="am9">
					<% if (hour(now()) >= 12 and hour(now()) < 21) Or (totalbonuscouponcount1>=getlimitcnt1) Or (Now() > #02/03/2016 23:59:59#) then %>
					<div class="soldOut <%=chkiif(Now() > #02/03/2016 23:59:59# ," finish","")%>"></div>
					<% End If %>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/img_coupon_01.png" alt="어디 가나?" /></div>
				</div>
				<% End if %>
				<% If hour(now()) >= 21 or hour(now()) < 9 Then %>
				<div class="pm9">
					<% if hour(now()) < 9 Or totalbonuscouponcount2>=getlimitcnt2 then %>
					<div class="soldOut <%=chkiif(Now() > #02/03/2016 23:59:59# ," finish","")%>"></div>
					<% End If %>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/img_coupon_02.png" alt="지금 몇쉬?" /></div>
				</div>
				<% End If %>
			</div>
		</div>
		<button class="btnCoupon" onclick="jseventSubmit();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/btn_coupon.png" alt="쿠폰받기" /></button>
	</div>
	<div class="couponLayer" id="couponLayer">
		<div class="cpCont">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/txt_bonus_coupon.png" alt="보너스쿠폰이 발급되었습니다!" /></p>
			<% If hour(now()) < 12 Then %>
			<%
				extratime = datediff("s",now(),Date()&" 오후 12:00:00")
				HH	=	fix(extratime / 3600) Mod 24
				MM	=	fix(extratime / 60) Mod 60
			%>
			<div class="timeCont am9">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/tit_coupon_01.png" alt="어디 가나" /></p>
				<strong>쿠폰 마감까지 <em><%=chkiif(HH=0,"",HH&"시간")%><%=chkiif(MM=0,"",MM&"분")%></em> 남았습니다.</strong>
			</div>
			<% Else %>
			<%
				extratime = datediff("s",now(),Date()+1&" 오전 00:00:00")
				HH	=	fix(extratime / 3600) Mod 24
				MM	=	fix(extratime / 60) Mod 60
			%>
			<div class="timeCont pm9">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/tit_coupon_02.png" alt="지금 몇쉬!" /></p>
				<strong>쿠폰 마감까지 <em><%=chkiif(HH=0,"",HH&"시간")%><%=chkiif(MM=0,"",MM&"분")%></em> 남았습니다.</strong>
			</div>
			<% End If %>
			<button class="btnConfirm"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/btn_confirm.png" alt="확인" /></button>
			<button class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/btn_close.png" alt="닫기" /></button>
		</div>
	</div>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/68749/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 이벤트는 ID당 1일 1회만 쿠폰을 발급받을 수 있습니다.</li>
			<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
			<li>- 발급받은 쿠폰에 따라 정오 / 자정에 종료됩니다.</li>
			<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
			<li>- 이벤트는 조기 마감 될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->