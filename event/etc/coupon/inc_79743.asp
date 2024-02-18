<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 쿠폰으로 카트탈출
' History : 2017-08-09 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->

<%
dim eCode, couponcnt1, couponcnt2,  getbonuscoupon1, getbonuscoupon2, getbonuscoupon3

IF application("Svr_Info") = "Dev" THEN
	eCode = 66409
	getbonuscoupon1 = 2852
	getbonuscoupon2 = 2853
Else
	eCode = 79743
	getbonuscoupon1 = 995	'10,000/60,000
	getbonuscoupon2 = 996	'15,000/100,000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")
%>
<style>
.evt79743 {background:#0f4402 url(http://webimage.10x10.co.kr/eventIMG/2017/79743/bg_section_1.jpg) repeat 0 0;}
.evt79743 .inner {position:relative; width:1140px; margin:0 auto;}
.evt79743 .inner:after {visibility:hidden; display:block; clear:both; height:0; content:'';}
.evt78862 .lastday {position:absolute; top:118px; right:252px;}
.section1 {height:957px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79743/bg_topic.jpg) no-repeat 50% 0;}
.section1 h2 {position:absolute; left:50%; top:323px; z-index:20; margin-left:-185px;}
.section1 .face {position:absolute; left:50%; top:41px; width:320px; height:310px; margin-left:-160px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79743/img_gorilla.gif) no-repeat 0 0;}
.section1 p {position:absolute; left:50%; z-index:10;}
.section1 .cp1 {top:416px; margin-left:-584px; animation:bounce 4.5s 30;}
.section1 .cp2 {top:270px; margin-left:240px; animation:bounce2 4.5s 30;}
.section1 .download {top:618px; margin-left:-186px; padding-right:0; background:none;}
.section1 .lastday {top:63px; margin-left:150px;}
.section1 .hurry {top:567px; z-index:20; margin-left:128px;}
.section1 .soldout {top:613px; margin-left:-185px;}
.section2 {background:url(http://webimage.10x10.co.kr/eventIMG/2017/79743/bg_section_2.jpg) repeat 0 0;}
.section2 a {float:left;}
.evtNoti {position:relative; padding:55px 0; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79743/bg_section_3.jpg) repeat 0 0;}
.evtNoti h3 {position:absolute; left:87px; top:50%; margin-top:-13px;}
.evtNoti ul {overflow:hidden; padding-left:313px;}
.evtNoti li {padding-bottom:3px; color:#fff;}
.evtNoti a {position:absolute; left:50%; top:-12px; margin-left:160px;}
@keyframes bounce {
	from to {transform:translateY(0);}
	50% {transform:translateY(-140px);}
}
@keyframes bounce2 {
	from to {transform:translateY(0);}
	50% {transform:translateY(90px);}
}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #08/22/2017 23:59:59# then %>
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
				alert('쿠폰이 발급 되었습니다.\n8월 22일 자정까지 사용하세요.');
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
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>
	<!-- 카트탈출 -->
	<div class="evt79743">
		<div class="section section1">
			<div class="inner">
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/tit_cart.png" alt="쿠폰으로 카트탈출" /></h2>
				<div class="face"></div>
				<div class="coupon">
					<p class="cp1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/img_coupon_1_v2.png" alt="6만원 이상 구매 시 1만원 할인" /></p>
					<p class="cp2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/img_coupon_2_v2.png" alt="10만원 이상 구매 시 1만5천원 할인" /></p>
				</div>
				<!-- 다운로드 -->
				<p class="download">
					<% if couponcnt1 < 30000 then %> 
						<a href="" onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;" ><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/btn_download.png" alt="쿠폰 한번에 다운받기" /></a>
					<% else %>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다." />
					<% end if %>
				</p>

				<% if date() >= "2017-08-22" then %>
					<p class="lastday"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/txt_last.png" alt="오늘이 마지막 날" /></p>
				<% end if %>
				
				<% if couponcnt1 >= 20000 and couponcnt1 < 30000 then %>
					<p class="hurry"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/txt_hurry.png" alt="마감임박" /></p>
				<% end if %>
			</div>
		</div>
		<div class="section section2">
			<div class="inner">
				<% If IsUserLoginOK() Then %>
					<a href="/event/appdown/"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/btn_app_2.jpg" alt="텐바이텐 APP 다운받기" /></a>
				<% else %>
					<a href="/event/appdown/"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/btn_app.jpg" alt="텐바이텐 APP 다운받기" /></a>
					<a href="/member/join.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/btn_join.jpg" alt="회원가입하러 가기" /></a>
				<% end if %>
			</div>
		</div>
		<div class="evtNoti">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/tit_noti.png" alt="이벤트 유의사항 " /></h3>
				<ul>
					<li>- 이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
					<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
					<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
					<li>- 쿠폰은 8/22(화) 23시 59분 59초에 종료됩니다.</li>
					<li>- 이벤트는 조기 마감될 수 있습니다.</li>
				</ul>
				<a href="/event/eventmain.asp?eventid=79832"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/bnr_dyson.jpg" alt="다다이슨 이벤트 바로가기" /></a>
			</div>
		</div>
	</div>
	<!--// 카트탈출 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->