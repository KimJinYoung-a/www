<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 쿠폰 인더 트랩
' History : 2016.02.17 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim systemyn, couponidx
dim subscriptcount, itemcouponcount
dim eCode, userid, currenttime, i, totalbonuscouponcount, totalbonuscouponcountusingy
	IF application("Svr_Info") = "Dev" THEN
		eCode = "66032"
		couponidx = "2768"
	Else
		eCode = "69218"
		couponidx = "826"
	End If

	currenttime = now()
'	currenttime = #02/22/2016 10:05:00#

	systemyn=TRUE		''	FALSE
	subscriptcount=0
	itemcouponcount=0
	userid = GetEncLoginUserID()
	
	totalbonuscouponcount = getbonuscoupontotalcount(couponidx, "", "","")
	totalbonuscouponcountusingy = getbonuscoupontotalcount(couponidx, "", "Y","")
	
	'//본인 참여 여부
	if userid<>"" then
		subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
		itemcouponcount = getbonuscouponexistscount(userid, couponidx, "", "", "")
	end if

%>
<style type="text/css">
img {vertical-align:top;}
.evt69218 {position:relative;}
.evt69218 button {background:transparent;}
.evt69218 .couponDown {position:relative;}
.evt69218 .couponDown .btnClick {overflow:hidden; position:absolute; top:0; left:50%; z-index:10; width:776px; height:454px; margin-left:-388px; text-indent:-999em;}
.evt69218 .couponDown .btnCoupon {display:none; position:absolute; top:44.6%; left:0; width:100%;}
.evt69218 .couponDown .deadline {position:absolute; top:30px; left:200px;}
.evt69218 .couponDown .soldout {position:absolute; top:0; left:0; z-index:15; width:100%; text-align:center;}
.evt69218 .btnInfo {position:relative;}
.evt69218 .btnInfo a {overflow:hidden; display:block; position:absolute; width:50%; height:100%; top:0; text-indent:-999em;}
.evt69218 .btnInfo a.btnApp {left:0;}
.evt69218 .btnInfo a.btnJoin {left:50%;}
.evt69218 .noti {padding:45px 55px; background-color:#e8e8e8;}
.evt69218 .noti dl {overflow:hidden;}
.evt69218 .noti dl dt, .noti dl dd {float:left; padding-left:45px;}
.evt69218 .noti dl dd li {padding:2px 0; color:#727272; text-align:left;}
.evt69218 .bounce {display:block; width:18px; height:22px; position:absolute; top:240px; right:285px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69218/ico_arrow.png) 50% 0 no-repeat; animation:bounce 1s infinite; -webkit-animation:bounce 1s infinite;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:3px; animation-timing-function:ease-in;}
}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:3px; -webkit-animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function jsSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not(left(currenttime,10)>="2016-02-18" and left(currenttime,10)<"2016-02-23") Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if  not(systemyn) then %>
				alert('잠시 후 다시 시도해 주세요.');
				return;
			<% else %>
				<% if totalbonuscouponcount < 30000 then %>
					<% if subscriptcount>0 or itemcouponcount>0 then %>
						alert("아이디당 한 번만 발급 가능 합니다.");
						return;
					<% else %>
						var result;
						$.ajax({
							type:"GET",
							url:"/event/etc/doeventsubscript/doEventSubscript69218.asp",
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
									alert('쿠폰이 발급되었습니다.\n금일 자정까지 사용해주세요!');
									return;
								}
								else if (result.ytcode=="999")
								{
									alert('오류가 발생했습니다.');
									return;
								}
							}
						});
					<% end if %>
				<% else %>
					alert('쿠폰이 모두 소진되었습니다.');
					return false;
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
	<div class="evt69218">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/69218/tit_trap.jpg" alt="10x10 쿠폰이벤트 쿠폰 인 더 트랩" /></h2>
		<div class="couponDown">
			<%''// for dev msg : 마감 임박 %>
			<% if hour(currenttime) >= 18 then %>
				<strong class="deadline"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69218/ico_deadline.png" alt="마감임박" /></strong>
			<% end if %>

			<%''// for dev msg : 쿠폰이 모두 소진 될 경우 보여주세요 %>
			<% if totalbonuscouponcount > 29999 then %>
				<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69218/img_finish.png" alt="쿠폰이 모두 소진되었습니다. 다음 기회에 이용해주세요" /></p>
			<% end if %>

			<button onclick="jsSubmit(); return false;" class="btnClick">쿠폰 받기</button>
			<span class="bounce"></span>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/69218/btn_trap.jpg" alt="10,000원 쿠폰 6만원 이상 구매시 사용" />
		</div>
		<div class="btnInfo">
			<a href="/event/appdown/" class="btnApp">텐바이텐 APP 다운</a>
			<a href="/member/join.asp" class="btnJoin">회원가입하고 구매하러 GO!</a>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/69218/btn_down.jpg" alt="텐바이텐 APP 설치 아직이신가요? / 텐바이텐에 처음오셨나요?" />
		</div>
		<div class="noti">
			<dl>
				<dt><img src="http://webimage.10x10.co.kr/eventIMG/2016/69218/tit_notice.jpg" alt="이벤트 유의사항" /></dt>
				<dd>
					<ul>
						<li>- 이벤트는 ID당 1일 1회만 참여할 수 있습니다.</li>
						<li>- 지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
						<li>- 쿠폰은 금일 02/22(월) 23시59분 종료됩니다.</li>
						<li>- 주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
						<li>- 이벤트는 조기 마감 될 수 있습니다.</li>
					</ul>
				</dd>
			</dl>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->