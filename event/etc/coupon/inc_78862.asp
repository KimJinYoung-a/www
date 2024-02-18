<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2017 바캉스 쿠폰팩
' History : 2017-07-06 유태욱
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
	eCode = 66383
	getbonuscoupon1 = 2849
	getbonuscoupon2 = 2850
'	getbonuscoupon3 = 0000
Else
	eCode = 78862
	getbonuscoupon1 = 991	'10000/60000
	getbonuscoupon2 = 992	'30000/200000
'	getbonuscoupon3 = 000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")
%>
<style>
.evt78862 {position:relative;}
.evt78862 .lastday {position:absolute; top:118px; right:252px;}
.coupon {position:relative;}
.coupon .btnDownload {position:absolute; left:50%;bottom:90px; z-index:10; margin-left:-190px; padding:0; animation:bounce 1s 20; background:none;}
.coupon .hurry {position:absolute; left:718px; top:350px; z-index:20;}
.coupon .soldout {position:absolute; left:50%; top:-30px; z-index:30; margin-left:-468px;}
.evtNoti {position:relative; padding:40px 0 40px 297px; text-align:left; background:#008fb8;}
.evtNoti h3 {position:absolute; left:110px; top:50%; margin-top:-10px;}
.evtNoti ul {padding:0 0 0 60px; border-left:1px solid #4db1cd;}
.evtNoti li {padding:3px 0; color:#fff;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-8px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #07/11/2017 23:59:59# then %>
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
				alert('쿠폰이 발급 되었습니다.\n7월 11일 자정까지 사용하세요.');
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
	<!-- 바캉스 쿠폰팩 -->
	<div class="evt78862">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/78862/tit_coupon_pack.jpg" alt="바캉스 쿠폰팩" /></h2>
		<% if date() = "2017-07-11" then %>
			<span class="lastday"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78862/txt_last_day.png" alt="오늘이 마지막날" /></span>
		<% end if %>
		
		<div class="coupon">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78862/img_coupon.jpg" alt="6만원이상 구매시 10,000할인, 10만원이상 구매시 15,000할인" /></p>
			<a href="" <% if couponcnt1 < 30000 then %> onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;" <% end if %> class="btnDownload"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78862/btn_download.png" alt="쿠폰 다운받기" /></a>
			
			<% if couponcnt1 >= 20000 then %>
				<p class="hurry"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78862/txt_soon.png" alt="마감임박" /></p>
			<% end if %>
			
			<% if couponcnt1 >= 30000 then %>
				<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78862/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다. 다음기회를 기다려주세요" /></p>
			<% end if %>
		</div>
		<div>
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/78862/btn_go.jpg" alt="" usemap="#downMap"/>
			<map name="downMap">
				<area shape="rect" coords="113,46,457,151" href="/event/appdown/" alt="텐바이텐 APP 다운받기">
				<area shape="rect" coords="679,43,1030,149" href="/member/join.asp" alt="회원가입하러 가기">
			</map>
		</div>
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78862/tit_noti.png" alt="이벤트 유의사항 " /></h3>
			<ul>
				<li>- 이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
				<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
				<li>- 쿠폰은 7/11(화) 23시 59분 59초에 종료됩니다.</li>
				<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
				<li>- 이벤트는 조기 마감될 수 있습니다.</li>
			</ul>
		</div>
	</div>
	<!--// 바캉스 쿠폰팩 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->