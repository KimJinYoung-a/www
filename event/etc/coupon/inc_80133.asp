<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 발뮤다 쿠폰
' History : 2017-08-28 정태훈
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
	eCode = 66419
	getbonuscoupon1 = 2852
Else
	eCode = 80133
	getbonuscoupon1 = 12788'10,000/60,000
End If

couponcnt1=0
couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
%>
<style>
.evt80133 {position:relative;}
.coupon {position:relative;}
.coupon .btnDownload {position:absolute; left:50%; top:368px; z-index:5; margin-left:-219px; background:none;}
.coupon .lastday {position:absolute; right:280px; top:-20px; z-index:5;}
.coupon .hurry {position:absolute; right:300px; top:340px; z-index:30; animation:bounce 1s 20;}
.coupon .soldout {position:absolute; left:50%; top:375px; z-index:10; margin-left:-205px;}
.cpLayer {display:none; position:absolute; left:0; top:0; z-index:100; width:100%; height:100%; background-color:rgba(13, 13, 13, 0.6);}
.cpLayer .layerCont {position:absolute; left:50%; top:245px; margin-left:-227px;}
.cpLayer .layerCont .btnClose {position:absolute; right:0; top:0; width:75px; height:66px; background-color:transparent; text-indent:-999em;}
.evtNoti {position:relative; padding:55px 0 55px 424px; text-align:left; background:#384e85 url(http://webimage.10x10.co.kr/eventIMG/2017/80133/bg_blue.png)no-repeat;}
.evtNoti h3 {position:absolute; left:150px; top:50%; margin-top:-14px;}
.evtNoti ul {padding:0 0 0 0;}
.evtNoti li {padding:3px 0; color:#fff;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50%
</style>
<script type="text/javascript">
$(function(){
	//$(".cpLayer").hide();
	$(".btnDownload").click(function(){
		
	});
	$(".btnClose").click(function(){
		$(".cpLayer").hide();
	});
});

function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #08/30/2017 23:59:59# then %>
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
				event.preventDefault();
				$(".cpLayer").fadeIn();
				return false;
			}else if (str1[0] == "12"){
				alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
				return false;
			}else if (str1[0] == "13"){
				alert('이미 쿠폰이 발급되었습니다.\n8월 30일 자정까지 사용해주세요.');
				return false;
			}else if (str1[0] == "02"){
				alert('로그인 후 쿠폰을 받으실 수 있습니다!');
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
		if(confirm("로그인 후 쿠폰을 받으실 수 있습니다!")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}

</script>
						<div class="evt80133">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/80133/tit_coupon_v2.png" alt="오직 2일 동안만 발뮤다 쿠폰" /></h2>
							
							<div class="coupon">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/80133/img_prd.png" alt="BALMUDA 전상품 10% 할인 사용기간은 8월 29일 부터 8월 30일입니다." usemap="#prdMap"/></p>
								<map name="prdMap" id="prdMap">
									<area  alt="포트" title="" href="/shopping/category_prd.asp?itemid=1710848" shape="rect" coords="195,184,410,332" style="outline:none;" target="_self" />
									<area  alt="토스트기" title="" href="/shopping/category_prd.asp?itemid=1404416" shape="rect" coords="702,235,870,335" style="outline:none;" target="_self" />
									<area  alt="가습기" title="" href="/shopping/category_prd.asp?itemid=1198132" shape="poly" coords="819,130,924,132,983,209,946,325,870,324,870,249,805,239,796,195" style="outline:none;" target="_self" />
								</map>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/80133/bg_blue2.png" alt="" usemap="#moreMap" />
								<% If now() > #08/29/2017 23:59:59# And now() < #08/30/2017 23:59:59# then %><span class="lastday"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80133/txt_last_day.png" alt="오늘이 마지막날" /></span><% End If %>
								<a href="" class="btnDownload"  onclick="jsevtDownCoupon('prd,','<%= getbonuscoupon1 %>,'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80133/btn_donwload.png" alt="쿠폰 다운받기" /></a>
								<% If couponcnt1 >= 10000 Then %>
								<p class="hurry"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80133/txt_soon.png" alt="마감임박" /></p>
								<% End If %>
								<map name="moreMap" id="moreMap">
									<area  alt="발뮤다상품보러가기" title="" href="#groupBar1" shape="rect" coords="472,131,678,222" style="outline:none;" target="_self" />
								</map>
							</div>
							<!-- 팝업 -->
							<div class="cpLayer">
								<div class="layerCont">
									<a href="/street/street_brand_sub06.asp?makerid=itspace"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80133/img_pop_up.png" alt="쿠폰이 발급되었습니다! 8/30일 까지 사용해주세요. 발뮤다 제품 보러가기" /></a>
									<button type="button" class="btnClose">닫기</button>
								</div>
							</div>
							<% If IsUserLoginOK() Then %>
							<div>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/80133/btn_go_2.png" alt="" usemap="#downMap2"/>
								<map name="downMap2">
									<area shape="rect" coords="595,34,976,169" href="/event/appdown/" alt="텐바이텐 APP 다운받기">
								</map>
							</div>
							<% else %>
							<div>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/80133/btn_go_1.png" alt="" usemap="#downMap"/>
								<map name="downMap">
									<area shape="rect" coords="113,30,457,170" href="/event/appdown/" alt="텐바이텐 APP 다운받기">
									<area shape="rect" coords="679,30,1030,170" href="/member/join.asp" alt="회원가입하러 가기">
								</map>
							</div>
							<% end if %>
							<div class="evtNoti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80133/tit_noti.png" alt="이벤트 유의사항 " /></h3>
								<ul>
									<li>- 이벤트는 ID 당 1회만 참여할 수 있습니다. </li>
									<li>- 쿠폰은 8/30 23시59분59초에 종료됩니다.</li>
									<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
									<li>- 해당 브랜드 상품 소진 시 이벤트가 조기 종료될 수 있습니다.</li>
								</ul>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->