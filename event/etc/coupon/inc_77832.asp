<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 장미쿠폰
' History : 2017-05-11 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, couponcnt1, couponcnt2,  getbonuscoupon1, getbonuscoupon2, getbonuscoupon3

IF application("Svr_Info") = "Dev" THEN
	eCode = 66326
	getbonuscoupon1 = 2841
	getbonuscoupon2 = 2842
'	getbonuscoupon3 = 0000
Else
	eCode = 77832
	getbonuscoupon1 = 976	'10000/60000
	getbonuscoupon2 = 977	'30000/200000
'	getbonuscoupon3 = 000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")
%>
<style>
.evt77832 {background:#f85e5e;}
.coupon {position:relative;}
.coupon span {position:absolute; top:-17px; left:50%; margin-left:-474px;}
.coupon .hurry {top:297px; margin-left:145px; animation:bounce 1s 20;} 
.evtNoti {position:relative; padding:35px 0 35px 312px; text-align:left; background:#f5f5f5;}
.evtNoti h3 {position:absolute; left:140px; top:50%; margin-top:-30px;}
.evtNoti ul {padding:0 0 0 60px; border-left:2px solid #e9e9e8;}
.evtNoti li {padding:6px 0; font-size:11px; line-height:12px; color:#7c7c7c;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-8px); animation-timing-function:ease-in;}
}

/* 추가 이벤트 배너 css */
.applyBox {display:none; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77832/bg_light_black.png) repeat; z-index:10;}
.applyBox .btnApply {position:relative; width:601px; margin: 350px auto 0; background-color:transparent; z-index:20;}
.applyBox .lyrClose {position:absolute; right:268px; top:388px; width:41px; height:41px; text-indent:-999em; z-index:30; background-color:transparent;}
</style>
<script type="text/javascript">
$(function(){
	$(".btnDetail").click(function(){
		$("#applyBox").show();
		event.preventDefault();
		var val = $('.applyBox').offset();
		$('html,body').animate({scrollTop:val.top+150},200);
	});
	$("#applyBox .lyrClose").click(function(){
		$("#applyBox").hide();
	});

});

function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #05/16/2017 23:59:59# then %>
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
				alert('쿠폰이 발급 되었습니다.\n5월16일 자정까지 사용하세요.');
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

function jsevtmile(stype){
	<% If IsUserLoginOK() Then %>
		<% If now() > #05/16/2017 01:00:00# then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/doeventsubscript/doEventSubscript77832.asp",
				data: "mode="+stype,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('신청이 완료 되었습니다.');
				return false;
			}else if (str1[0] == "12"){
				alert('마일리지로 결제한 후 신청해 주세요!');
				return false;
			}else if (str1[0] == "13"){
				alert('이미 신청 하셨습니다.');
				return false;
			}else if (str1[0] == "14"){
				alert('마일리지로 결제한 후에 신청해주세요!');
				return false;
			}else if (str1[0] == "16"){
				alert('본 이벤트는 5월 15일에 결제한 고객 대상으로 진행하는 이벤트입니다. 다음 기회에 참여해주세요 :)');
			}else if (str1[0] == "02"){
				alert('로그인 후 신청할 수 있습니다!');
				return false;
			}else if (str1[0] == "01"){
				alert('잘못된 접속입니다.');
				return false;
			}else if (str1[0] == "00"){
				alert('정상적인 경로가 아닙니다.');
				return false;
			}else if (str1[0] == "15"){
				alert('이벤트 기간이 아닙니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 신청할 수 있습니다!")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>
	<!-- 장미쿠폰 -->
	<div class="evt77832">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/77832/tit_rose.png" alt="장미쿠폰" /></h2>
		<div class="coupon">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/77832/txt_coupon_v2.png" alt="6만원이상 구매시 1만원할인, 10만원이상 구매시 15000원할인" /></p>
			<%'' 쿠폰소진 %>
			<% if couponcnt1 >= 30000 then %>
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/77832/txt_sold_out.png" alt="쿠폰이 모두 소진되었습니다. 다음기회를 기다려주세요!" /></span>
			<% end if %>

			<a href="" <% if couponcnt1 < 30000 then %> onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;" <% end if %>><img src="http://webimage.10x10.co.kr/eventIMG/2017/77832/btn_coupon_download.png" alt="쿠폰 다운받기" /></a>

			<%'' 마감임박 %>
			<% if couponcnt1 >= 20000 then %>
				<span class="hurry"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77832/txt_hurry_up.png" alt="마감임박" /></span>
			<% end if %>
		</div>
		<% if Not(Now() > #05/15/2017 10:00:00# And Now() < #05/16/2017 01:00:00#) then %>
		<% else %>
			<div>
				<button class="btnDetail"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77832/txt_mileage.jpg" alt="5월 15일 단 하루만! 사용한 마일리지 돌려받기 이벤트 자세히보기" /></button>
				<div id="applyBox" class="applyBox">
					<button type="button" onclick="jsevtmile('mile');" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77832/txt_apply.png" alt="5월 15일 오늘 하루 마일리지를 사용한 당신에게 사용한 마일리지의 15%를 돌려드립니다 신청하기" /></button>
					<button type="button" class="lyrClose">닫기</button>
				</div>
			</div>
		<% end if %>
		<div>
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/77832/img_down.png" alt="" usemap="#downMap"/>
			<map name="downMap">
				<area shape="rect" coords="140,71,430,151" href="/event/appdown/" alt="텐바이텐 APP 다운받기">
				<area shape="rect" coords="709,71,1000,150" href="/member/join.asp" alt="회원가입하러 가기">
			</map>
		</div>
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77832/tit_noti.png" alt="이벤트 유의사항 " /></h3>
			<ul>
				<li>- 이벤트는 ID당 1회만 참여할 수 있습니다</li>
				<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능합니다</li>
				<li>- 쿠폰은 5/16(화) 23시 59분 59초에 종료됩니다</li>
				<li>- 주문한 상품에 따라 배송비용은 추가로 발생할 수 있습니다</li>
				<li>- 이벤트는 조기 마감될 수 있습니다</li>
			</ul>
		</div>
	</div>
	<!--// 장미쿠폰 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->