<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 판타스틱 쿠폰듀오 WWW
' History : 2016-05-17 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, couponcnt, getbonuscoupon

IF application("Svr_Info") = "Dev" THEN
	eCode = 66132
	getbonuscoupon = 2788
Else
	eCode = 70575
	getbonuscoupon = 860
End If

couponcnt = getbonuscoupontotalcount(getbonuscoupon, "", "", "")

%>
<style type="text/css">
img {vertical-align:top;}

.fantasticCouponDuo button {background-color:transparent;}
.couponArea {position:relative; width:1140px; min-height:982px; background:#4d3074 url(http://webimage.10x10.co.kr/eventIMG/2016/70575/bg_purple.jpg) no-repeat 50% 0;}
.couponArea .btnGroup {position:relative; margin-top:52px; padding-bottom:74px;}
.couponArea .btnGroup .soldout {position:absolute; top:8px; left:93px;}
.couponArea .btnGroup .close {position:absolute; top:-51px; left:306px; z-index:5;}
.couponArea .btnGroup .close {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.8s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.noti {position:relative; padding:45px 0 44px; background-color:#f8f8f8; text-align:left;}
.noti h3 {position:absolute; top:56px; left:100px;}
.noti ul {margin-left:271px; padding-left:45px; border-left:1px solid #fff;}
.noti ul li {position:relative; margin-top:7px; padding-left:10px; color:#777; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#777;}
</style>

<script type="text/javascript">

function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #05/23/2016 23:59:59# then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/coupon/couponshop_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('쿠폰이 발급 되었습니다.\n오늘 하루 텐바이텐에서 사용하세요! ');
				return false;
			}else if (str1[0] == "12"){
				alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
				return false;
			}else if (str1[0] == "13"){
				alert('이미 다운로드 받으셨습니다.');
				return false;
			}else if (str1[0] == "02"){
				alert('로그인 후 쿠폰을 받을 수 있습니다!');
				return false;
			}else if (str1[0] == "01"){
				alert('잘못된 접속입니다.');
				return false;
			}else if (str1[0] == "00"){
				alert('정상적인 경로가 아닙니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 쿠폰을 받을 수 있습니다!")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}
</script>

<div class="evt70020 fantasticCouponDuo">
	<div class="couponArea">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/70575/tit_fantastic_duo_coupon.jpg" alt="판타스틱 쿠폰듀오 환상적인 할인을 도와드릴, 쿠폰 콜라보레이션 기회를 놓치지 마세요!" /></h2>
		<div class="coupon">
			<% if couponcnt >= 30000 then %>
				<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70575/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다" /></p>
			<% else %>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70575/img_coupon_v1.png" alt="6만원 이상 구매 시 사용 가능한 만원 쿠폰, 20만원 이상 구매시 사용 가능한 삼만원 쿠폰 사용기간은 5월 23일 하루 입니다." /></p>
				<div class="btnGroup">
					<button type="button" onclick="jsevtDownCoupon('evtsel,evtsel','860,861'); return false;" class="btnDownloadAll"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70575/btn_download_all.png" alt="쿠폰 한번에 다운받기" /></button>
					<% if couponcnt >= 25000 then %>
						<strong class="close"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70575/ico_close.png" alt="마감임박" /></strong>
					<% end if %>
				</div>
			<% end if %>
		</div>
	</div>

	<div class="appdownJoin">
		<img src="http://webimage.10x10.co.kr/eventIMG/2016/70575/txt_app_join.png" alt="" usemap="#link" />
		<map name="link" id="link">
			<area shape="rect" coords="119,53,458,155" href="/event/appdown/" alt="텐바이텐 앱 설치 아직이신가요? 텐바이텐 앱 다운" />
			<area shape="rect" coords="683,56,1020,155" href="/member/join.asp" alt="텐바이텐에 처음오셨나요? 회원가입하고 구매하러 가기!" />
		</map>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70575/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li><span></span>이벤트는 ID 당 1일 1회만 참여할 수 있습니다.</li>
			<li><span></span>지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
			<li><span></span>쿠폰은 05/23(월) 23시 59분 59초에 종료됩니다.</li>
			<li><span></span>주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
			<li><span></span>이벤트는 조기 마감 될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->