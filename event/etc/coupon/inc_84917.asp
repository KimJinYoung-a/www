<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2018 봄 쿠폰
' History : 2018-03-02 허진원
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
	eCode = 67512
	getbonuscoupon1 = 2872
	getbonuscoupon2 = 2873
Else
	eCode = 84917
	getbonuscoupon1 = 1035
	getbonuscoupon2 = 1036
End If

'// 쿠폰 카운트
couponcnt = getbonuscoupontotalcount(getbonuscoupon1&","&getbonuscoupon2, "", "", "")
%>
<style>
.noti {position:relative; padding:35px 0 35px 297px; background:#333;}
.noti h3 {position:absolute; left:110px; top:50%; margin-top:-10px;}
.noti ul {text-align:left; padding:10px 0 10px 50px; color:#fff; line-height:23px; border-left:1px solid #5c5c5c;}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% if couponcnt <= 50000 then %>
		<% If IsUserLoginOK() Then %>
			<% If now() > #03/05/2018 00:00:00# and now() < #03/06/2018 23:59:59# then %>
				var str = $.ajax({
					type: "POST",
					url: "/event/etc/coupon/couponshop_process.asp",
					data: "mode=cpok&stype="+stype+"&idx="+idx,
					dataType: "text",
					async: false
				}).responseText;
				var str1 = str.split("||")
				if (str1[0] == "11"){
					alert('쿠폰이 발급 되었습니다.\n3월 6일 자정까지 사용하세요. ');
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
	<% else %>
		alert('쿠폰이 모두 소진되었습니다.');
		return false;
	<% end if %>
}
</script>
<div class="evt84917">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/84917/tit_coupon.jpg" alt="봄쿠폰 - 여러분의 봄 쇼핑을 지원합니다! 쿠폰 다운받고 쇼핑의 꽃을 피우세요!" /></h2>
	<a href="" onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84917/img_coupon.jpg" alt="6만원 이상 구매 시 10,000원, 20만원 이상 구매 시 30,000원 할인 쿠폰 다운받기" /></a>
	<div class="appJoin">
		<img src="http://webimage.10x10.co.kr/eventIMG/2018/84917/btn_go.jpg" alt="" usemap="#Map"/>
		<map name="Map">
			<area shape="rect" coords="98,76,475,196" onfocus="this.blur();" href="/event/appdown/" alt="텐바이텐 APP 다운받기" />
			<area shape="rect" coords="675,79,1044,196" onfocus="this.blur();" href="/member/join.asp" alt="회원가입하러 가기" />
		</map>
	</div>
	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/84917/tit_noti.png" alt="이벤트 유의사항"/></h3>
		<ul>
			<li>- 이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
			<li style="color:#fffea7;">- 지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
			<li>- 쿠폰은 3/6(화) 23시 59분 59초에 종료됩니다.</li>
			<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
			<li>- 이벤트는 조기 마감될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->