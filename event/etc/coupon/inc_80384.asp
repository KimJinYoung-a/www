<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 한가위 한수위쿠폰
' History : 2017-09-12 정태훈
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
	eCode = 66427
	getbonuscoupon1 = 2852
	getbonuscoupon2 = 2853
Else
	eCode = 80384
	getbonuscoupon1 = 998	'10,000/60,000
	getbonuscoupon2 = 999	'15,000/100,000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")
%>
<style>
.evt80384 {position:relative;}
.evt80384 .lastday {position:absolute; right:264px; top:112px; z-index:5;}
.evt80384 .coupon {position:relative;}
.evt80384 .coupon .btnDownload {position:absolute; left:50%; top:278px; z-index:5; margin-left:-200px; background:none;}
.evt80384 .coupon .hurry {position:absolute; right:344px; top:248px; z-index:30; animation:bounce 1s 20;}
.evt80384 .coupon .soldout {position:absolute; left:50%; top:278px; z-index:10; margin-left:-200px;}
.evtNoti {position:relative; padding:50px 0 60px 335px; text-align:left; background-color:#3b3b3b;}
.evtNoti h3 {position:absolute; left:118px; top:50%; margin-top:-10px;}
.evtNoti ul {padding-left:90px; border-left:solid 1px #767676;}
.evtNoti li {padding:3px 0; color:#fff;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-8px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #09/19/2017 23:59:59# then %>
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
				alert('쿠폰이 발급 되었습니다.\n9월 19일 자정까지 사용하세요.');
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
						<div class="evt80384">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/80384/tit_coupon_v2.jpg" alt="한수위 쿠폰" /></h2>
							<% if date() >= "2017-09-19" then %>
							<span class="lastday"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80384/txt_last_day.png" alt="오늘이 마지막날" /></span>
							<% end if %>
							<div class="coupon">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/80384/img_coupon.jpg" alt="6만원 이상 구매시 10,000원 사용기간은 9월 18일 부터 19일 까지 입니다." /></p>
								<% if couponcnt1 < 30000 then %>
								<a href=""  onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;"  class="btnDownload"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80384/btn_donwload.png" alt="쿠폰 한번에 다운받기" /></a>
								<% else %>
								<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80384/txt_sold_out.png" alt="쿠폰이 모두 소진되었습니다." /></p>
								<% end if %>
								<% if couponcnt1 >= 20000 and couponcnt1 < 30000 then %>
								<p class="hurry"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80384/txt_hurry.png" alt="마감임박" /></p>
								<% end if %>
							</div>
							<% If IsUserLoginOK() Then %>
							<div>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/80384/btn_go_2.jpg" alt="" usemap="#downMap2"/>
								<map name="downMap2">
									<area shape="rect" coords="595,34,976,169" href="/event/appdown/" alt="텐바이텐 APP 다운받기">
								</map>
							</div>
							<% else %>
							<div>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/80384/btn_go_1.jpg" alt="" usemap="#downMap"/>
								<map name="downMap">
									<area shape="rect" coords="113,30,457,170" href="/event/appdown/" alt="텐바이텐 APP 다운받기">
									<area shape="rect" coords="679,30,1030,170" href="/member/join.asp" alt="회원가입하러 가기">
								</map>
							</div>
							<% end if %>
							<div class="evtNoti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80384/tit_noti.png" alt="이벤트 유의사항 " /></h3>
								<ul>
									<li>-  이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
									<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
									<li>- 폰은 9/19(화) 23시 59분 59초에 종료됩니다.</li>
									<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
									<li>- 이벤트는 조기 마감될 수 있습니다.</li>
								</ul>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->