<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2017 Super Cool Festival
' History : 2017-06-23 정태훈
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
	eCode = 66352
	getbonuscoupon1 = 2847
	getbonuscoupon2 = 2848
'	getbonuscoupon3 = 0000
Else
	eCode = 78705
	getbonuscoupon1 = 12599	'10000/60000
	getbonuscoupon2 = 12598	'15000/100000
'	getbonuscoupon3 = 000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")
%>
<style>
.coolFestival {background:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/bg_sand.png) repeat 0 0;}
.coolFestival .inner {position:relative; width:1140px; margin:0 auto;}
.coolFestival .shareSns {text-align:left; background:#005189;}
.coolFestival .shareSns p {padding:70px 0 70px 65px;}
.coolFestival .shareSns a {position:absolute; top:50%; margin-top:-30px;}
.coolFestival .shareSns a.btnFb {right:60px;}
.coolFestival .shareSns a.btnTw {right:290px;}
.justCoolday {height:168px; text-align:left; background-color:#1c97ff;}
.justCoolday .just {padding:75px 26px 0 142px;}
.justCoolday .itemInfo {position:absolute; left:512px; top:24px; width:450px; height:75px; padding:42px 0 0 150px;}
.justCoolday .itemInfo .thumb {position:absolute; left:0; top:0; width:117px; height:110px; text-align:center; padding-top:7px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/bg_round.png) repeat 0 0;}
.justCoolday .itemInfo .btnBuy {position:absolute; right:0; top:50%; margin-top:-23px;}
.justCoolday .itemInfo p {font-size:12px; font-weight:bold;}
.justCoolday .itemInfo .name {overflow:hidden; color:#fff; width:240px; text-overflow:ellipsis; white-space:nowrap;}
.justCoolday .itemInfo .price {color:#fff600;}
.justCoolday .itemInfo .price s {font-size:11px; color:#fff; font-weight:normal;}
.coolCont {position:relative; padding-top:333px;}
.coolCont .title {position:absolute; left:50%; top:82px; z-index:30; width:1252px; height:255px; margin-left:-626px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/bg_head.png) no-repeat 0 90px;}
.coolCont .title h2 {position:relative; margin:26px 0;}
.coolCont .title .date {margin-top:30px;}
.coolCont .festival {position:relative; height:1170px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/bg_sea.jpg) repeat 0 0; animation:move8 5s 20;}
.coolCont .festival:after {content:''; display:inline-block; position:absolute; left:50%; top:-5px; z-index:10; width:2100px; height:170px; margin-left:-1050px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/bg_wave.png) no-repeat 0 0; animation:move7 5s 20;}
.coolCont .festival .inner {height:100%;}
.coolCont .festival .deco {position:absolute; z-index:20; background-position:0 0; background-repeat:no-repeat;}
.coolCont .festival .deco1 {left:-122px; top:18px; width:91px; height:47px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/img_deco_1.png);}
.coolCont .festival .deco2 {right:-120px; top:10px; width:125px; height:106px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/img_deco_2.png);animation:move3 5.5s 50;}
.coolCont .festival .deco3 {left:-164px; top:387px; width:230px; height:146px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/img_deco_3.png); animation:move6 3s 20;}
.coolCont .festival .deco4 {left:-147px; bottom:243px; width:146px; height:166px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/img_deco_4.png);}
.coolCont .festival .deco5 {right:-83px; bottom:313px; width:118px; height:122px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/img_deco_5.png); animation:move5 15s 20;}
.coolCont .festival li {position:absolute; z-index:20;}
.coolCont .festival li span {position:absolute; z-index:20; background-position:0 0; background-repeat:no-repeat;}
.coolCont .festival li.section1 {left:25px; top:-31px; cursor:pointer;}
.coolCont .festival li.section2 {left:649px; top:92px;}
.coolCont .festival li.section3 {left:68px; top:385px;}
.coolCont .festival li.section4 {left:411px; top:385px;}
.coolCont .festival li.section5 {left:754px; top:385px;}
.coolCont .festival li.section6 {left:67px; bottom:98px;}
.coolCont .festival li.section1 span {left:220px; top:293px; width:262px; height:64px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/btn_download.png);}
.coolCont .festival li.section1:hover span {animation:move1 1s ease-in-out 50;}
.coolCont .festival li.section2 span {left:50px; top:35px; width:87px; height:114px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/img_fan.png); animation:move2 2s ease-in-out forwards 50; transform-origin:50% 100%;}
.coolCont .festival li.section3 span {left:142px; top:122px; width:102px; height:39px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/img_sale.png); animation:move1 1.5s ease-out 50;}
.coolCont .festival li.section4 span {left:10px; top:10px; width:295px; height:222px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/img_deco_event2.gif); background-position:0 100%;}
.coolCont .festival li.section5 span {left:87px; top:48px; width:242px; height:121px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/img_flamingo.png); animation:move4 3s 50;}
.coolCont .festival li.section6 span {right:48px; top:48px; width:135px; height:135px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78705/btn_discount.png); animation:move1 1s ease-out 50;}
.couponCont { position:fixed; left:50% !important; top:50% !important; z-index:99999; width:711px; height:545px; margin:-300px 0 0 -355px;}
.couponCont button {display:inline-block; position:absolute; right:-30px; top:67px; background:transparent; outline:none; transform:rotate(0); transition:all .3s;}
.couponCont button:hover {margin:-1px 0 0 0; transform:rotate(90deg);}
@keyframes move1{
	from,to {transform:translateY(0);}
	50% {transform:translateY(5px);}
}
@keyframes move2{
	from,to{transform:rotate(-6deg);}
	50%{transform:rotate(6deg);}
}
@keyframes move3{
	from,to {margin:0;}
	50% {margin:-15px 0 0 15px;}
}
@keyframes move4{
	from {margin-left:0;}
	30% {margin-left:-5px;}
	60% {margin-left:5px;}
	to {margin-left:0;}
}
@keyframes move5{
	from,to {margin:0; transform:rotate(0);}
	50% {margin:0 -40px -50px 0; transform:rotate(360deg);}
}
@keyframes move6{
	from,to {transform:scale(1);}
	50% {transform:scale(1.1);}
}
@keyframes move7 {
	from {top:-5px;}
	30% {top:-15px;}
	60% {top:-20px;}
	to {top:-5px;}
}
@keyframes move8 {
	from,to {background-position:0 0; background-size:2099px 1590px;}
	50% {background-position:10px -5px; background-size:2130px 1630px;}
}
@keyframes move9{
	from,to {margin-top:0; transform:scale(1);}
	50% {margin-top:-5px; transform:scale(1.03);}
}
</style>
<script type="text/javascript">
$(function(){
	titleAnimation()
	$(".title h2").css({"top":"20px", "opacity":"0"});
	function titleAnimation() {
		$(".title h2").delay(100).animate({"top":"0", "opacity":"1"},1500);
	}
});
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #07/05/2017 23:59:59# then %>
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
				alert('쿠폰이 발급되었습니다.');
				return false;
			}else if (str1[0] == "12"){
				alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
				return false;
			}else if (str1[0] == "13"){
				alert('이미 발급 받으셨습니다. 이벤트는 ID당 1회만 참여 할 수 있습니다.');
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
<%
Dim ix, dateNum, CountArr, StartDate, ItemCode
Dim arrStartDate, arrItemCode, oItem
StartDate = "2017-06-26,2017-06-27,2017-06-28,2017-06-29,2017-06-30,2017-07-01,2017-07-02,2017-07-03,2017-07-04,2017-07-05"
ItemCode = "1523832,1141232,1523842,1740217,1523834,1641124,1641124,1516362,1638449,1543558"

arrStartDate = Split(StartDate,",")
arrItemCode = Split(ItemCode,",")
CountArr = ubound(arrStartDate)

For ix=0 To CountArr-1
	If arrStartDate(ix)=left(now(),10) Then
		dateNum=ix
	End If
Next

set oItem = new CatePrdCls
oItem.GetItemData arrItemCode(dateNum)
%>
<!-- COOL FESTIVAL-->
<div class="evt78705 coolFestival">
	<div class="justCoolday">
		<a href="/shopping/category_prd.asp?itemid=<%=oItem.Prd.FItemid%>">
			<div class="inner">
				<p class="just"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/txt_cool_price.png" alt="오늘 하루만 시원한 가격!" /></p>
				<!-- JUST COOL ITEM (10일동안 매일 매일 바뀌는 부분) -->
				<div class="itemInfo">
					<div class="thumb"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/img_cool_item_<%=dateNum+1%>.png " alt="" /></div>
					<p class="name"><%=oItem.Prd.Fitemname%></p>
					<p class="price">
					<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN%>
					<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원")%></s>
					<% Else %>
					<%= FormatNumber(oItem.Prd.getOrgPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원")%>
					<% End If %>
					<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN
						Response.Write FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원") & " ["
						If oItem.Prd.FOrgprice = 0 Then
							Response.Write "0%]"
						Else
							Response.Write CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) & "%]"
						End If
					End If %>
					</p>
					<span class="btnBuy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/btn_buy.png" alt="구매하러가기" /></span>
				</div>
				<!--// JUST COOL ITEM -->
			</div>
		</a>
	</div>
	<div class="coolCont">
		<div class="title">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/txt_cool.png" alt="일상에 유쾌하고 시원함을 드려요!" /></p>
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/tit_super_cool.png" alt="SUPER COOL" /></h2>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/txt_festival.png" alt="FESTIVAL" /></p>
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/txt_date.png" alt="기간 : 2017.06.26 ~ 07.05" /></p>
		</div>
		<div class="festival">
			<div class="inner">
				<ul>
					<li class="section1"><div onclick="viewPoupLayer('modal',$('#couponLayer').html());return false;"><span></span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/img_coupon.png" alt="최대 20% 할인쿠폰 받기" /></div></li>
					<li class="section2"><a href="/event/eventmain.asp?eventid=78732"><!--<span></span>--><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/img_gift_v2.png" alt="구매사은품 - 5만원 이상 구매시 곰손풍기 증정" /></a></li>
					<li class="section3"><a href="/event/eventmain.asp?eventid=78825"><span></span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/img_event_1_v2.png" alt="COOL SALE!" /></a></li>
					<li class="section4"><a href="/event/eventmain.asp?eventid=78682"><span></span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/img_event_2.png" alt="썸머 컬러픽" /></a></li>
					<li class="section5"><a href="/event/eventmain.asp?eventid=78728"><span></span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/img_event_3.png" alt="SWIMMING, PLAY, ENJOY!" /></a></li>
					<li class="section6"><a href="/event/eventmain.asp?eventid=78681"><span></span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/img_payco.png" alt="페이코 즉시할인" /></a></li>
				</ul>
				<div class="deco deco1"></div>
				<div class="deco deco2"></div>
				<div class="deco deco3"></div>
				<div class="deco deco4"></div>
				<div class="deco deco5"></div>
			</div>
			<!-- 쿠폰 다운로드 -->
			<div id="couponLayer" style="display:none;">
				<div class="couponCont">
					<button type="button" class="btnClose" onclick="ClosePopLayer();"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/btn_close.png" alt="닫기" /></button>
					<div>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/img_download.png" alt="쿠폰 다운로드 받기" usemap="#downloadMap" />
						<map name="downloadMap" id="downloadMap">
							<area shape="rect" onfocus="this.blur();" coords="87,255,631,478" href="#" alt="슈퍼 쿨 상품 20%/10% 할인쿠폰 한번에 다운받기" onclick="jsevtDownCoupon('prd,prd','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;" />
						</map>
					</div>
				</div>
			</div>
			<!--// 쿠폰 다운로드 -->
		</div>
<%
'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
dim snpTitle, snpLink, snpPre, snpTag, snpTag2
snpTitle = Server.URLEncode("SUPER COOL FESTIVAL")
snpLink = Server.URLEncode("http://10x10.co.kr/event/78705")
snpPre = Server.URLEncode("텐바이텐 이벤트")
snpTag = Server.URLEncode("텐바이텐 SUPERCOOLFESTIVAL")
snpTag2 = Server.URLEncode("#10x10")
''snpImg = Server.URLEncode(emimg)	'상단에서 생성
%>
		<div class="shareSns">
			<div class="inner">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/txt_share.png" alt="무더워지는 지금! 텐바이텐을 즐기면 기쁨이 두배!" /></p>
				<a href="" class="btnFb" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/btn_facebook.png" alt="페이스북 공유" /></a>
				<a href="" class="btnTw" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78705/btn_twitter.png" alt="트위터 공유" /></a>
			</div>
		</div>
	</div>
</div>
<!--// COOL FESTIVAL-->
<%
Set oItem = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->