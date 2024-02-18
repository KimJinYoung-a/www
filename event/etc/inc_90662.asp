<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  캣앤 독 이벤트 90662
' History : 2018-11-23 최종원 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, couponIdx

IF application("Svr_Info") = "Dev" THEN
	eCode = "89195"
	couponIdx = "2889"
Else
	eCode = "90662"
	couponIdx = "1107"	
End If


%>
<style type="text/css">
.mania-day .topic {position:relative; background-color:#EBC659;}
.mania-day .label {position:absolute; top:36px; left:50%; z-index:25; margin-left:-92px;}
.mania-day .slide {position:absolute; bottom:0; right:71px; z-index:10; width:540px; height:593px;}
#slideshow div {position:absolute; top:0; right:0; z-index:8; opacity:0.0;}
#slideshow div.active {z-index:10; opacity:1.0;}
#slideshow div.last-active {z-index:9;}
.mania-day .together {background-color:#d8f078;}
.rotate-animation {backface-visibility:visible; animation:rotate-animation 1.5s; animation-fill-mode:both;}
.evt90662 .bnr-img img{margin-top: -20px;}
@keyframes rotate-animation {
	0% {transform: scale(0) rotate(-180deg); opacity:0;}
	50% {transform: scale(1) rotate(0deg); opacity:1;}
	70% {transform: scale(0.8) rotate(0deg);}
	100% {transform: scale(1) rotate(0deg);}
}

</style>
<script type="text/javascript">
/* 참고 url http://jsfiddle.net/EX77j/3/ */
var isStopped = false;
function slideSwitch() {
if (!isStopped) {
	var $active = $("#slideshow div.active");
	if ($active.length == 0) $active = $("#slideshow div:last");
	var $next = $active.next().length ? $active.next() : $("#slideshow div:first");
	$active.addClass("last-active");
	$next.css({		
	}).addClass("active").animate({		
		}, 0, function() {
		$active.removeClass("active last-active");
	});
}
}
$(function() {
setInterval(function() {
	slideSwitch();
}, 800);

$("#slideshow").hover(function() {
	isStopped = true;
}, function() {
	isStopped = false;
});
});
</script>
<script type="text/javascript">
function jsDownCoupon(stype,idx){
	<% if Not(IsUserLoginOK) then %>
		jsEventLogin();
	<% else %>
	$.ajax({
		type: "post",
		url: "/shoppingtoday/act_couponshop_process.asp",
		data: "idx="+idx+"&stype="+stype,
		cache: false,
		success: function(message) {
			if(typeof(message)=="object") {
				if(message.response=="Ok") {
					alert(message.message);
				} else {
					alert(message.message);
				}
			} else {
				alert("처리중 오류가 발생했습니다.");
			}
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
	<% end if %>
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
</script>
						<!-- [카테고리데이] 카테고리 데이 cat and dog : 90662 -->
						<div class="evt90662 mania-day">
							<div class="topic">
								<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90662/tit_img.png" alt="매월 마지막 주는 CAT&DOG DAY" /></h2>
								<h3 class="label rotate-animation"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90662/tit_today.png" alt="오늘의 카테고리 CAT&DOG" /></h3>
								<div id="slideshow" class="slide">
									<div class="active"><a href="/shopping/category_prd.asp?itemid=1889071&pEtr=90662"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90662/img_item_01.png" alt="[Disney] PUPPYPADDING (Mickey/Pooh)" /></a></div>
									<div><a href="/shopping/category_prd.asp?itemid=2117551&pEtr=90662"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90662/img_item_02.png" alt="고양이 반자동 화장실" /></a></div>
									<div><a href="/shopping/category_prd.asp?itemid=1427197&pEtr=90662"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90662/img_item_03.png" alt="padding - pink" /></a></div>
									<div><a href="/shopping/category_prd.asp?itemid=1173759&pEtr=90662"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90662/img_item_04.png" alt="와일드와시 센스티브 코트 샴푸" /></a></div>
									<div><a href="/shopping/category_prd.asp?itemid=1690940&pEtr=90662"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90662/img_item_05.png" alt="울리 베스트 강아지옷/강아지패딩" /></a></div>
								</div>
							</div>
							<div class="together">
								<div class="brand">
									<img src="http://webimage.10x10.co.kr/fixevent/event/2018/90662/txt_brand.png" alt="" usemap="#brandlink" />
                                    <map name="brandlink" id="brandlink">
                                        <area alt="wangzzang로 이동" href="/street/street_brand_sub06.asp?makerid=wangzzang" shape="rect" coords="70,0,318,66" onfocus="this.blur();" />
                                        <area alt="arrr로 이동" href="/street/street_brand_sub06.asp?makerid=arrr" shape="rect" coords="318,0,464,66" onfocus="this.blur();" />
                                        <area alt="awesomekidz로 이동" href="/street/street_brand_sub06.asp?makerid=awesomekidz" shape="rect" coords="464,0,700,66" onfocus="this.blur();" />
                                        <area alt="woolly02로 이동" href="/street/street_brand_sub06.asp?makerid=woolly02" shape="rect" coords="700,0,873,66" onfocus="this.blur();" />
                                        <area alt="biteme로 이동" href="/street/street_brand_sub06.asp?makerid=biteme" shape="rect" coords="873,0,1070,66" onfocus="this.blur();" />
                                    </map>
								</div>
								<div class="event">
									<img src="http://webimage.10x10.co.kr/fixevent/event/2018/90662/bnr_event.png" alt="매니아를 위한 CAT&DOG 특가 이벤트" usemap="#evtlink" />
                                    <map name="evtlink" id="evtlink">
                                        <area alt="이번 겨울도 부탁해! SNIFF" href="/event/eventmain.asp?eventid=90736" shape="rect" coords="68,117,298,442" onfocus="this.blur();" />
                                        <area alt="반려견의 마음을 이해하는 Bodeum" href="/event/eventmain.asp?eventid=89726" shape="rect" coords="325,117,555,442" onfocus="this.blur();" />
                                        <area alt="따뜻한 겨울을 준비하는 멋멍" href="/event/eventmain.asp?eventid=90351" shape="rect" coords="583,117,813,442" onfocus="this.blur();" />
                                        <area alt="영양맞춤 사료 로얄캐닌" href="/event/eventmain.asp?eventid=90762" shape="rect" coords="839,117,1069,442" onfocus="this.blur();" />
                                    </map>
                                </div>
                                <div class="bnr-img">
                                    <a href="" onclick="jsDownCoupon('event','<%=couponIdx%>');return false;"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90662/brn_coupon.png" alt="COUPON EVENT"></a>
                                </div>
							</div>
						</div>
						<!-- [카테고리데이] 카테고리 데이 cat and dog : 90662 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->