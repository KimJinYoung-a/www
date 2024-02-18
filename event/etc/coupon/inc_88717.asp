<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2018 화요 쿠폰
' History : 2018-08-20 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, couponcnt
dim getbonuscoupon1, getbonuscoupon2, getbonuscoupon3, couponcnt1
dim totalbonuscouponcountusingy1, totalbonuscouponcountusingy2, totalbonuscouponcountusingy3

IF application("Svr_Info") = "Dev" THEN
	eCode = 68541
	getbonuscoupon1 = 2824
	getbonuscoupon2 = 2825
'	getbonuscoupon3 = 2798
Else
	eCode = 88717
	getbonuscoupon1 = 1074	'7000/50000
	getbonuscoupon2 = 1075	'15000/100000
'	getbonuscoupon3 = 879
End If

userid = getencloginuserid()

couponcnt=0
totalbonuscouponcountusingy1=0
totalbonuscouponcountusingy2=0
'totalbonuscouponcountusingy3=0

couponcnt = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")

%>
<style>
.evt88717 {position:relative; padding-top:105px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/88717/bg_tue_coupon.png) 50% 0 repeat-y;}
.evt88717 .coupon {position:relative; padding:60px 0;}
.evt88717 .cp-download {position:relative; height:180px;}
.evt88717 .cp-download a {position:absolute; left:50%; top:23px; z-index:10; margin-left:-181px; background:none; }
.evt88717 .cp-download span {position:absolute; left:50%; top:-26px; margin-left:135px; z-index:15; animation:bounce 1s 20;}
.evtNoti {position:relative; padding:55px 0 45px 486px; text-align:left; background:#122544;}
.evtNoti h3 {position:absolute; left:300px; top:55px;}
.evtNoti li {padding-bottom:12px; font-size:12px; line-height:1; color:#fff;}
@keyframes bounce {
	from to {transform:translateY(5px); animation-timing-function:ease-out;}
	50% {transform:translateY(-7px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If not(now() >= #08/21/2018 00:00:00# And now() < #08/22/2018 00:00:00#) then %>
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
				alert('쿠폰이 발급 되었습니다.\n오늘 하루 화끈하게 사용하세요! ');
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
<%' 화요쿠폰 %>
<div class="evt88717">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/88717/tit_tue_coupon.png" alt="화요쿠폰 - 오늘, 단 하루만 제공되는 쿠폰혜택 놓치지 마세요!" /></h2>
	<div class="coupon"><img src="http://webimage.10x10.co.kr/eventIMG/2018/88717/img_tue_coupon.png" alt="5만원 이상 구매 시 7천원, 10만원 이상 구매 시 1만5천원 할인쿠폰" /></div>
	<div class="cp-download">
		<%' 18시 이후부터 마감임박 시 노출 %>
		<% If now() >= #08/21/2018 18:00:00# then %>
			<span><img src="http://webimage.10x10.co.kr/eventIMG/2018/88717/img_coupon_deadline.png" alt="마감임박" /></span>
		<% End If %>
		<a href="" onclick="jsevtDownCoupon('evttosel,evttosel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/88717/btn_coupon_download.png" alt="쿠폰 한번에 다운받기" /></a>
	</div>
	</div>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/88717/tit_tue_noti.png" alt="이벤트 유의사항 " /></h3>
		<ul>
			<li>- 이벤트는 ID 당 1일 1회만 참여할 수 있습니다.</li>
			<li>- 쿠폰은 8/21(화) 23시 59분 59초에 종료됩니다.</li>
			<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
			<li>- 이벤트는 조기 마감될 수 있습니다.</li>
		</ul>
	</div>
</div>
<%'// 화요쿠폰 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->