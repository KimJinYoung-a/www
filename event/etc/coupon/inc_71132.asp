<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 심장이 쿠폰쿠폰 WWW
' History : 2016-06-10 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, couponcnt, getbonuscoupon1, getbonuscoupon2, getbonuscoupon3

IF application("Svr_Info") = "Dev" THEN
	eCode = 66150
	getbonuscoupon1 = 2796
	getbonuscoupon2 = 2797
	getbonuscoupon3 = 2798
Else
	eCode = 71132
	getbonuscoupon1 = 869
	getbonuscoupon2 = 870
	getbonuscoupon3 = 871
End If

couponcnt=0
couponcnt = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")

%>
<style type="text/css">
img {vertical-align:top;}

.couponCoupon {background:#ffe7e2 url(http://webimage.10x10.co.kr/eventIMG/2016/71132/bg_heart.jpg) no-repeat 50% 0;}
.couponCoupon button {background-color:transparent;}

.topic {position:relative; height:973px;}
.topic h2 {position:absolute; top:128px; left:50%; margin-left:-245px;}
.topic .heart {position:absolute;}
.topic .heart1 {top:231px; left:346px;}
.topic .heart2 {top:280px; left:797px;}
.topic .heart img {animation-name:pulse; animation-duration:1.2s; animation-fill-mode:both; animation-iteration-count:infinite;}
.topic .heart2 img {animation-delay:1.8s;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(0.8);}
	100% {transform:scale(1);}
}
.topic .btnCoupon, .topic .soldout {position:absolute; top:445px; left:50%; margin-left:-486px;}
.topic .soldout {top:440px;}
.topic .close {position:absolute; top:-244px; left:180px;}
.topic .close .txt {position:absolute; top:0; left:0;}
.topic .close .txt img {animation-name:flash; animation-duration:2s; animation-fill-mode:both; animation-iteration-count:infinite;}
@keyframes flash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}

.noti {position:relative; padding:45px 0 44px; background-color:#f1f3e8; text-align:left;}
.noti h3 {position:absolute; top:56px; left:100px;}
.noti ul {margin-left:271px; padding-left:45px; border-left:1px solid #fff;}
.noti ul li {position:relative; margin-top:7px; padding-left:10px; color:#838771; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#838771;}
</style>
</head>
<script type="text/javascript">

function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #06/20/2016 23:59:59# then %>
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
	<div class="evt71132 couponCoupon">
		<div class="topic">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/71132/tit_coupon_coupon_v1.png" alt="심장이 쿠폰쿠폰 쿠폰을 향해 설레는 마음, 지금 붙잡으세요! 두근거리는 할인이 찾아갑니다!" /></h2>
			<span class="heart heart1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71132/img_heart_01.png" alt="" /></span>
			<span class="heart heart2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71132/img_heart_02.png" alt="" /></span>
			<% if couponcnt >= 30000 then %>
				<%'' for dev msg : 쿠폰 소진 시 보여주세요 %>
				<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71132/img_coupon_soldout_v1.png" alt="솔드아웃 쿠폰이 모두 소진되었습니다." /></p>
			<% else %>
				<%''  for dev msg : 쿠폰 소진 시 숨겨주세요  %>
				<div class="btnCoupon">
					<p>
						<button type="button" onclick="jsevtDownCoupon('evtsel,evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>,<%= getbonuscoupon3 %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71132/img_coupon_v1.png" alt="삼만원 이상 구매시 오천원 할인 쿠폰, 육만원 이상 구매시 만원 할인 쿠폰, 이십만원 구매시 3만원 할인 쿠폰 한번에 다운받기" /></button>
					</p>
					<%''  for dev msg : 쿠폰이 얼마 남아있지 않을때 보여주세요  %>
					<% if couponcnt >= 25000 then %>
						<strong class="close">
							<span class="ico"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71132/ico_close_heart.png" alt="" /></span>
							<span class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71132/ico_close_txt.png" alt="마감임박" /></span>
						</strong>
					<% end if %>
				</div>
			<% end if %>

		</div>

		<div class="appdownJoin">
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/71132/txt_app_join.png" alt="" usemap="#link" />
			<map name="link" id="link">
				<area shape="rect" coords="119,53,458,160" href="/event/appdown/" alt="텐바이텐 앱 설치 아직이신가요? 텐바이텐 앱 다운" />
				<area shape="rect" coords="683,56,1020,160" href="/member/join.asp" alt="텐바이텐에 처음오셨나요? 회원가입하고 구매하러 가기!" />
			</map>
		</div>

		<div class="noti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71132/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li><span></span>이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
				<li><span></span>지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
				<li><span></span>쿠폰은 06/20(월) 23시 59분 59초 종료됩니다.</li>
				<li><span></span>주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
				<li><span></span>이벤트는 조기 마감 될 수 있습니다.</li>
			</ul>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->