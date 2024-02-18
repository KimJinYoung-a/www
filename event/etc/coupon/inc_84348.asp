<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 복덩이쿠폰
' History : 2018-02-02 이종화
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, couponcnt , getbonuscoupon1, getbonuscoupon2

IF application("Svr_Info") = "Dev" THEN
	eCode = 67456
	getbonuscoupon1 = 2852
	getbonuscoupon2 = 2853
Else
	eCode = 84348
	getbonuscoupon1 = 1031
	getbonuscoupon2 = 1032
End If

'// 쿠폰 카운트
couponcnt = getbonuscoupontotalcount(getbonuscoupon1&","&getbonuscoupon2, "", "", "")
%>
<style>
.coupon {position:relative;}
.coupon a {display:block; position:absolute; left:100px;top:0; z-index:20; width:940px; height:430px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84348/bg_blank.png) repeat 0 0; text-indent:-999em;}
.noti {position:relative; padding:45px 0 45px 297px; text-align:left; background:#333;}
.noti h3 {position:absolute; left:110px; top:50%; margin-top:-10px;}
.noti ul {padding:0 0 0 50px; border-left:1px solid #5c5c5c;}
.noti li {padding:2px 0; color:#fff;}
.noti li span {color:#ffd631;}
.noti a {position:absolute; right:25px; top:24px;}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #02/05/2018 00:00:00# and now() < #02/06/2018 23:59:59# then %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/coupon/couponshop_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('쿠폰이 발급 되었습니다.\n2월 6일 자정까지 사용하세요. ');
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
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return;
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
<div class="evt84348">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/84348/tit_coupon.png" alt="복덩이 쿠폰" /></h2>
	<div class="coupon">
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84348/img_coupon.png" alt="7만원 이상 구매 시 1만원, 15만원 이상 구매 시 2만원 할인쿠폰" /></div>
		<a href="" onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;">쿠폰 전체 다운받기</a>
	</div>
	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/84348/tit_noti.png" alt="이벤트 유의사항 " /></h3>
		<ul>
			<li>- 이벤트는 ID 당 1회만 참여할 수 있습니다. </li>
			<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
			<li>- <span>쿠폰은 2/6(화) 23시 59분 59초에 종료됩니다.</span></li>
			<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
			<li>- 이벤트는 조기 마감될 수 있습니다. </li>
		</ul>
		<a href="/playing/view.asp?didx=205"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84348/bnr_playing.jpg" alt="진짜 복덩이 분양해보세요! 복덩이 분양받으러 가기" /></a>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->