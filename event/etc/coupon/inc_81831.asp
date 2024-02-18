<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 월화쿠폰 시즌2
' History : 2017-11-03 정태훈
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
	eCode = 67456
	getbonuscoupon1 = 2852
	getbonuscoupon2 = 2853
Else
	eCode = 81831
	getbonuscoupon1 = 1011	'5,000/50,000
	getbonuscoupon2 = 1012	'10,000/90,000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")
%>
<style>
.evt81831 h2 {visibility:hidden; width:0; height:0;}
.coupon {position:relative;}
.coupon .btnDownload {position:absolute; left:50%;bottom:90px; z-index:10; margin-left:-190px;}
.coupon .hurry {position:absolute; left:718px; top:564px; z-index:20; animation:bounce 1s 20;}
.coupon .last {position:absolute; left:725px; top:75px; z-index:20;}
.coupon .soldout {position:absolute; left:50%; top:288px; z-index:30; margin-left:-418px;}
.evtNoti {position:relative; padding:40px 0 40px 297px; text-align:left; background:#b2693c;}
.evtNoti h3 {position:absolute; left:110px; top:50%; margin-top:-10px;}
.evtNoti ul {padding:0 0 0 60px; border-left:1px solid #c99677;}
.evtNoti li {padding:3px 0; color:#fff;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-8px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #11/07/2017 23:59:59# then %>
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
				alert('쿠폰이 발급 되었습니다.\n11월 07일 자정까지 사용하세요.');
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
						<div class="evt81831">
							<h2>월화쿠폰 - 월요일,화요일 단 이틀간 진행되는 달콤한 할인 혜택을 놓치지 마세요!</h2>
							<div class="coupon">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81831/img_coupon.png" alt="5만원이상 구매시 5,000할인, 9만원이상 구매시 10,000할인" /></p>
								<% if couponcnt1 >= 20000 and couponcnt1 < 30000 then %>
								<p class="hurry"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81831/txt_soon.png" alt="마감임박" /></p>
								<% end if %>
								<% if date() >= "2017-11-07" then %>
								<p class="last"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81831/txt_last.png" alt="오늘이 마지막 날" /></p>
								<% end if %>
								<% if couponcnt1 < 30000 then %>
								<a href="" onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;"  class="btnDownload"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81831/btn_download.png" alt="쿠폰 다운받기" /></a>
								<% else %>
								<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81831/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다. 다음기회를 기다려주세요" /></p>
								<% end if %>
							</div>
							<% If IsUserLoginOK() Then %>
							<div>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/81831/btn_go.png" alt="" usemap="#downMap"/>
								<map name="downMap">
									<area shape="rect" coords="113,46,457,151" href="/event/appdown/" alt="텐바이텐 APP 다운받기">
									<area shape="rect" coords="679,43,1030,149" href="/member/join.asp" alt="회원가입하러 가기">
								</map>
							</div>
							<% else %>
							<div>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/81831/btn_go.png" alt="" usemap="#downMap"/>
								<map name="downMap">
									<area shape="rect" coords="113,46,457,151" href="/event/appdown/" alt="텐바이텐 APP 다운받기">
									<area shape="rect" coords="679,43,1030,149" href="/member/join.asp" alt="회원가입하러 가기">
								</map>
							</div>
							<% end if %>
							<div>
								<a href="/diarystory2018/"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81831/img_diary.jpg" alt="2018 다이어리 이벤트 바로가기" /></a>
							</div>
							<div class="evtNoti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81831/tit_noti.png" alt="이벤트 유의사항 " /></h3>
								<ul>
									<li>- 이벤트는 ID당 1회만 참여할 수 있습니다.</li>
									<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능합니다.</li>
									<li>- 쿠폰은 11/7(화) 23시 59분 59초에 종료됩니다.</li>
									<li>- 주문한 상품에 따라 배송비용은 추가로 발생할 수 있습니다.</li>
									<li>- 이벤트는 조기 마감될 수 있습니다.</li>
								</ul>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->