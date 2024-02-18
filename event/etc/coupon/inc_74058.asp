<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 아는 쿠폰
' History : 2016-11-02 유태욱
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
	eCode = 66227
	getbonuscoupon1 = 2824
	getbonuscoupon2 = 2825
'	getbonuscoupon3 = 0000
Else
	eCode = 74058
	getbonuscoupon1 = 925	'10000/60000
	getbonuscoupon2 = 926	'30000/200000
'	getbonuscoupon3 = 000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode("나만 아는 쿠폰")
snpLink = Server.URLEncode("http://www.10x10.co.kr/event/" & ecode)
snpPre = Server.URLEncode("텐바이텐 이벤트")
snpTag = Server.URLEncode("텐바이텐 " & Replace("나만 아는 쿠폰"," ",""))
snpTag2 = Server.URLEncode("#10x10")

%>
<style type="text/css">
img {vertical-align:top;}

.evt74058 {position:relative;}
.evt74058 .iconFlash{position:absolute; top: 17%; right: 27%; }

.couponDownload {position:relative;}
.couponDownload .soldOut {position:absolute; top:240px; left:509px;animation:bounce 1s infinite;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
.evt74058 .coupon{overflow:hidden;}
.evt74058 .coupon div {float:left;}

.eventNotice {height:221px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74058/bg_notice.jpg) 50% 0;overflow: hidden;}
.eventNotice img, .eventNotice .notiContents {float:left;}
.eventNotice img {margin:90px 0 0 110px;}
.eventNotice ul {position:relative; margin:43px 0 0 70px; padding-left:60px; border-left: #fff 1px solid;}
.eventNotice ul li{color:#fff; font-size:12px; text-align: left; padding:3px 0;}

</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #11/08/2016 23:59:59# then %>
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
				alert('쿠폰이 발급 되었습니다.\n11월8일 자정까지 사용하세요.');
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

function getsnscnt(snsno) {
	if(snsno=="tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsno=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else{
		alert('오류가 발생했습니다.');
		return false;
	}
}
</script>
	<div class="evt74058">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/74058/tit_coupon.jpg" alt="나만 아는 쿠폰 11월의 마지막 할인 찬스! 쿠폰 다운 받고 알뜰하게 쇼핑하세요." /></h2>
		<div class="couponDownload">
			<% if couponcnt1 >= 28000 then %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/74058/txt_sold_out_coupons.jpg" alt="쿠폰이 모두 소진되었습니다. 다음기회를 기다려주세요." />
			<% else %>
				<a href="" <% if couponcnt1 < 28000 then %> onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;" <% end if %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/74058/txt_coupons.jpg" alt="6만원 이상 구매시 10,000원 쿠폰 20만원 이상 구매시 30000원 쿠폰 사용기간 : 11/7~8까지(2일간) 쿠폰 한번에 다운받기" /></a>
			<% end if %>
			
			<% if couponcnt1 >= 15000 and couponcnt1 < 28000 then %>
				<p class="soldOut"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74058/img_soldout_v2.png" alt="마감임박" /></p>
			<% end if %>
		</div>
		<div class="appJoin">
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/74058/btn_go.jpg" alt="" usemap="#Map"/>
				<map name="Map">
					<area shape="rect" coords="98,73,474,161" href="/event/appdown/">
					<area shape="rect" coords="675,72,1040,163" href="/member/join.asp">
					<area shape="rect" coords="501,221,742,305" href="#" onclick="getsnscnt('fb');return false;">
					<area shape="rect" coords="774,223,1009,304" href="#" onclick="getsnscnt('tw');return false;">
				</map>
		</div>
		<div class="eventNotice">
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/74058/txt_noti_v2.png" alt="이벤트 유의사항"/>
			<div class="notiContents">
				<ul>
					<li>- 이벤트는 ID당 1회만 참여할 수 있습니다. </li>
					<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능합니다.</li>
					<li>- 쿠폰은 11/8(화) 23시59분59초 종료됩니다.</li>
					<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
					<li>- 이벤트는 조기 마감될 수 있습니다.</li>
				</ul>
			</div>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->