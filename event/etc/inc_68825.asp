<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 엄마쿠폰
' History : 2016.01.22 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, userid, currenttime, i, totalbonuscouponcount, totalbonuscouponcountusingy
	IF application("Svr_Info") = "Dev" THEN
		eCode = "66007"
	Else
		eCode = "68825"
	End If

currenttime = now()
'																					currenttime = #01/25/2016 10:05:00#

userid = GetEncLoginUserID()

dim couponidx
	IF application("Svr_Info") = "Dev" THEN
		couponidx = "2734"
	Else
		couponidx = "820"
	End If

dim subscriptcount, itemcouponcount
subscriptcount=0
itemcouponcount=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
	itemcouponcount = getbonuscouponexistscount(userid, couponidx, "", "", "")
end if
'response.write GetUserStrlarge(GetLoginUserLevel) & "/" & GetLoginUserLevel
totalbonuscouponcount = getbonuscoupontotalcount(couponidx, "", "","")
totalbonuscouponcountusingy = getbonuscoupontotalcount(couponidx, "", "Y","")
dim administrator
	administrator=TRUE

if GetEncLoginUserID="greenteenz" or GetEncLoginUserID="djjung" or GetEncLoginUserID="bborami" or GetEncLoginUserID="kyungae13" or GetEncLoginUserID="baboytw" then
	administrator=TRUE
end if

%>
<style type="text/css">
img {vertical-align:top;}
.evt68825 {position:relative; background:#fff;}
.getCoupon {position:relative;}
.getCoupon .btnCoupon {position:absolute; left:50%; bottom:72px; margin-left:-221px; background:transparent;}
.evtNoti {overflow:hidden; padding:55px 95px 40px; text-align:left; background:#f2f2f2;}
.evtNoti h3 {float:left; width:188px; text-align:left;}
.evtNoti ul {float:left; width:400px;}
.evtNoti ul li {font-size:11px; line-height:13px; padding-bottom:12px; color:#7a7a7a;}
#couponLayer {display:none; position:absolute; left:0; top:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68825/bg_mask.png) repeat 0 0;}
#couponLayer .cpCont {position:absolute; left:50%; top:425px; margin-left:-371px;}
#couponLayer .btnClose {position:absolute; left:50%; top:630px; margin-left:-131px; background:transparent;}
</style>
<script type="text/javascript">
$(function(){
	$("#couponLayer .btnClose").click(function(){
		$("#couponLayer").fadeOut();
	});
});

function jsSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-01-25" and left(currenttime,10)<"2016-01-26" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if totalbonuscouponcount < 35000 then %>
				<% if subscriptcount>0 or itemcouponcount>0 then %>
					alert("아이디당 한 번만 발급 가능 합니다.");
					return;
				<% else %>
					<% if not(administrator) then %>
						alert("잠시 후 다시 시도해 주세요.");
						return;
					<% else %>
						var result;
						$.ajax({
							type:"GET",
							url:"/event/etc/doeventsubscript/doEventSubscript68825.asp",
							data: "mode=coupondown",
							dataType: "text",
							async:false,
							success : function(Data){
								result = jQuery.parseJSON(Data);
								if (result.ytcode=="05")
								{
									alert('잠시 후 다시 시도해 주세요.');
									return;
								}
								else if (result.ytcode=="04")
								{
									alert('한 개의 아이디당 한 번만 발급 가능 합니다.');
									return;
								}
								else if (result.ytcode=="03")
								{
									alert('이벤트 응모 기간이 아닙니다.');
									return;
								}
								else if (result.ytcode=="02")
								{
									alert('로그인을 해주세요.');
									return;
								}
								else if (result.ytcode=="01")
								{
									alert('잘못된 접속입니다.');
									return;
								}
								else if (result.ytcode=="00")
								{
									alert('정상적인 경로가 아닙니다.');
									return;
								}
								else if (result.ytcode=="11")
								{
									$("#couponLayer").fadeIn();
									window.parent.$('html,body').animate({scrollTop:600}, 700);
									return false;
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
			<% else %>
				alert('쿠폰이 모두 소진되었습니다.');
				return false;
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
<div class="evt68825">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/68825/tit_mother_chance.png" alt="엄마쿠폰찬스" /></h2>
	<div class="getCoupon">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/68825/img_coupon.png" alt="6만원 이상 구매 시 1만원 할인쿠폰" /></p>
		<button class="btnCoupon" onclick="jsSubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68825/btn_coupon.png" alt="쿠폰받기" /></button>
	</div>
	<div class="couponLayer" id="couponLayer">
		<div class="cpCont">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/68825/img_layer_coupon.png" alt="쿠폰이 발급되었습니다!" /></p>
			<button class="btnClose" ><img src="http://webimage.10x10.co.kr/eventIMG/2016/68825/btn_confirm.png" alt="쿠폰받기" /></button>
		</div>
	</div>
	<% if userid = "greenteenz" OR userid = "cogusdk" OR userid = "helele223" OR userid = "baboytw" then %>
		<%= totalbonuscouponcount %><br>
		<%= totalbonuscouponcountusingy %>
	<% end if %>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/68825/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 이벤트는 ID당 1회만 참여할 수 있습니다.</li>
			<li>- 쿠폰의 발급 및 사용은 금일 23시 59분에 종료됩니다.</li>
			<li>- 주문한 상품에 따라 배송비용은 추가로 발생 할 수 있습니다.</li>
			<li>- 이벤트는 조기 마감 될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->