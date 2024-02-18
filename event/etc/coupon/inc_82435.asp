<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 핫쿠폰
' History : 2017-11-24 정태훈
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
dim eCode, couponcnt1,  getbonuscoupon1

IF application("Svr_Info") = "Dev" THEN
	eCode = 67465
	getbonuscoupon1 = 2862
Else
	eCode = 82435
	getbonuscoupon1 = 1015	'10,000/70,000
End If

couponcnt1=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
'couponcnt1=40000
%>
<style>
.coupon {position:relative;}
.coupon .btn-download {display:block; position:absolute; left:50%;top:0; z-index:20; width:800px; height:580px; margin-left:-400px; text-indent:-999em;}
.coupon .today {position:absolute; right:173px; top:-64px; z-index:10; animation:bounce 1s 20;}
.evtNoti {position:relative; padding:48px 0 48px 335px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2017/82435/bg_noti.png) repeat 0 0;}
.evtNoti h3 {position:absolute; left:115px; top:50%; margin-top:-10px;}
.evtNoti ul {padding:0 0 0 90px; border-left:1px solid #727272;}
.evtNoti li {padding:3px 0; color:#fff;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-8px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #11/27/2017 23:59:59# then %>
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
				alert('쿠폰이 발급 되었습니다.\n11월 27일 자정까지 사용하세요.');
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
						<div class="evt82435">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/82435/tit_hot_coupon.jpg" alt="이벤트 유의사항 " /></h2>
							<div class="coupon">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/82435/img_coupon.jpg" alt="5만원이상 구매시 5,000할인, 9만원이상 구매시 10,000할인" /></p>
								<% if couponcnt1 < 40000 then %>
								<a href="" onclick="jsevtDownCoupon('evtsel','<%= getbonuscoupon1 %>'); return false;" class="btn-download">쿠폰 다운받기</a>
								<% Else %>
								<a href="" onclick="alert('쿠폰이 모두 소진되었습니다. 다음기회를 기다려주세요.'); return false;" class="btn-download">쿠폰 다운받기</a>
								<% end if %>
								<p class="today"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82435/txt_today.png" alt="오늘 단 하루" /></p>
							</div>
							<div>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/82435/btn_go.png" alt="" usemap="#downMap" />
								<map name="downMap">
									<area shape="rect" coords="107,46,457,155" onfocus="this.blur();" href="/event/appdown/" alt="텐바이텐 APP 다운받기" />
									<area shape="rect" coords="679,42,1030,155" onfocus="this.blur();" href="/member/join.asp" alt="회원가입하러 가기" />
								</map>
							</div>
							<div class="evtNoti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82435/tit_noti.png" alt="이벤트 유의사항 " /></h3>
								<ul>
									<li>- 이벤트는 ID당 1회만 참여할 수 있습니다.</li>
									<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능합니다.</li>
									<li>- 쿠폰은 11/27(월) 23시 59분 59초에 종료됩니다.</li>
									<li>- 주문한 상품에 따라 배송비용은 추가로 발생할 수 있습니다.</li>
									<li>- 이벤트는 조기 마감될 수 있습니다.</li>
								</ul>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->