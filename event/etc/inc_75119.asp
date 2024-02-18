<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 설날에 만난 선물
' History : 2016.12.29 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, dday, nowdate, grcode
grcode = requestCheckVar(Request("eGc"),6)

nowdate = date()
'nowdate = "2017-01-08"

if grcode = "" then
	if nowdate = "2017-01-08" or nowdate = "2017-01-15" or nowdate = "2017-01-22" or nowdate = "2017-01-29" then
		grcode = "197628"
	else
		grcode = "197203"
	end if
end if

IF application("Svr_Info") = "Dev" THEN
	eCode = "66258"
Else
	eCode = "75119"
End If

dday = (right(nowdate,2)+5) mod 7
%>
<style type="text/css">
img {vertical-align:top;}

/* head */
.head {height:530px; position:relative; background: url(http://webimage.10x10.co.kr/eventIMG/2016/75119/bg_light_purple.png) repeat-x 50% 0;}
.head .title {padding-top:135px; background: url(http://webimage.10x10.co.kr/eventIMG/2016/75119/bg_mountains_v3.png) no-repeat 50% 0;}
.head .title h2 {position:relative; width:1140px; height:174px; margin:0 auto;}
.head .title h2 .letter{position:absolute; left:50%}
.head .title h2 .letter1{top:0; margin-left:-150px;}
.head .title h2 .letter2{top:48px; margin-left:-258px;}
.head .title h2 .letter3{top:157px; margin-left:-149px;}
.head .title h2 .titIco {position:absolute; top:10px; left:50%;}
.head .title h2 .titIco1 {margin-left:-338px;}
.head .title h2 .titIco2 {margin-left:210px; }
.head .title .date {padding-top:14px;}
.bnr ul {position:absolute; top:0; left:50%; margin-left:327px; overflow:hidden;}
.bnr ul li{float:left; margin:0 5px;}
.figure {padding-top:50px; position:relative;}
.figure .chicken {position:absolute; bottom:0; left:50%; margin-left:-260px; z-index:0; animation:moveUp 1.8s infinite;}
.figure .mountain {position:relative;  z-index:10;}
@keyframes moveUp {
from to {transform:translateY(0); animation-timing-function:ease-out;}
50% {transform:translateY(15px); animation-timing-function:ease-in;} 
}

/* navigator */
.navigator {height:95px; background: url(http://webimage.10x10.co.kr/eventIMG/2016/75119/bg_tb.png) repeat-x 50% 0;}
.navigator ul {width:1140px; margin:0 auto;}
.navigator ul li {position:relative; float:left; width:285px; height:95px; }
.navigator ul li a {display:block; position:relative; width:100%; height:100%; color:#fff; text-align:center;}
.navigator ul li a span { position:absolute; top:0; left:0; width:100%; height:100%; background: url(http://webimage.10x10.co.kr/eventIMG/2016/75119/img_nav_v2.png) no-repeat 0 0; cursor:pointer;}
.navigator ul li a:hover span, .navigator ul li a.on span {height:117px; background-position:0 100%;}
 {background-position:0 100%;}
.navigator ul li.nav2 a span {background-position:-285px 0;}
.navigator ul li.nav2 a:hover span, .navigator ul li.nav2 a.on span {background-position:-285px 100%}
.navigator ul li.nav3 a span {background-position:-570px 0;}
.navigator ul li.nav3 a:hover span, .navigator ul li.nav3 a.on span {background-position:-570px 100%}
.navigator ul li.nav4 a span {background-position:100% 0;}
.navigator ul li.nav4 a:hover span, .navigator ul li.nav4 a.on span {background-position:100% 100%;}
.navigator ul li.nav4 a .onlyWeek {display:inline-block; position:absolute; top:28px; left:192px; width:69px; height:33px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/75119/img_only_week.png) no-repeat 0 0; animation:flash 2.5s infinite;}
.navigator ul li.nav4 a:hover .onlyWeek, .navigator ul li.nav4 a.on .onlyWeek {animation:none;}
@keyframes flash {
	from, 50%, to {opacity: 1;}
	25%, 75% { opacity: 0.1;}
}

/* 탭1 main */
.main {margin-top:83px; height:793px; background:#d8d8d5 url(http://webimage.10x10.co.kr/eventIMG/2016/75119/bg_tb03_main.jpg) no-repeat 50% 0;}
.main h3 {padding-top:73px;}
.main .mainItemList {position:relative; }
.main .mainItemList li{position:absolute; top:95px; left:50%; margin-left:375px; animation:bounce2 1s infinite;}
.main .mainItemList li.item02,
.main .mainItemList li.item04,
.main .mainItemList li.item06,
.main .mainItemList li.item08,
.main .mainItemList li.item10 {animation-delay:.5s;}
.main .mainItemList li.item02{top:190px; margin-left:-28px;}
.main .mainItemList li.item03{top:245px; margin-left:-184px;}
.main .mainItemList li.item04{top:260px; margin-left:98px;}
.main .mainItemList li.item05{top:287px; margin-left:502px;}
.main .mainItemList li.item06{top:302px; margin-left:-486px;}
.main .mainItemList li.item07{top:375px; margin-left:283px;}
.main .mainItemList li.item08{top:371px; margin-left:6px;}
.main .mainItemList li.item09{top:420px; margin-left:-140px;}
.main .mainItemList li.item10{top:485px; margin-left:-270px;}
.main .mainItemList li.item11{top:475px; margin-left:132px;}
.main .mainItemList li a {position:relative; display:block; width:40px; height:40px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/75119/btn_cross.png) no-repeat 0 0; }
.main .mainItemList li a img {position:absolute; top:-25px; left:-105px; display:none;}
.main .mainItemList li.item02 a img {top:-10px; left:-84px;left:-105px;}
.main .mainItemList li.item03 a img {left:-107px;}
.main .mainItemList li.item04 a img {top:-20px; left:-67px;}
.main .mainItemList li.item05 a img {top:-9px; left:-30px;}
.main .mainItemList li.item06 a img {top:-20px; left:-170px;}
.main .mainItemList li.item07 a img {top:0; left:-100px;}
.main .mainItemList li.item08 a img {top:-5px; left:-70px;}
.main .mainItemList li.item09 a img {left:-5px;}
.main .mainItemList li.item10 a img {top:-10px; left:-250px;}
.main .mainItemList li.item11 a img {top:3px; left:-55px;}
.main .mainItemList li a:hover img {display:block;}
@keyframes bounce2 {
	from, to{transform:translateY(4px); animation-timing-function:ease-out;}
	50% {transform:translateY(0); animation-timing-function:ease-in;}
}
.recommendItemList {background-color:#f6f1e8; height:710px;}
.recommendItemList h4 {padding:87px 0 90px;}
.recommendItemList ul {width:1103px; margin:0 auto; overflow:hidden;}
.recommendItemList ul li {float:left; margin:0 33px;}
.praticalItemList {background-color:#f0e8e6; height:710px;}
.praticalItemList h4 {padding:95px 0 40px;}
.praticalItemList ul {width:1080px; margin:0 auto; overflow:hidden;}
.praticalItemList ul li {float:left; margin:0 30px;}

/* 탭2 main02 */
.main02 {margin-top:83px; height:793px; background:#d8d8d5 url(http://webimage.10x10.co.kr/eventIMG/2016/75119/bg_tb02_main.jpg) no-repeat 50% 0;}
.main02 h3 {padding-top:73px;}
.main02 .main02ItemList {position:relative; }
.main02 .main02ItemList li{position:absolute; top:100px; left:50%; margin-left:45px; animation:bounce 1s infinite;}
.main02 .main02ItemList li.item02,
.main02 .main02ItemList li.item04,
.main02 .main02ItemList li.item06,
.main02 .main02ItemList li.item08 {animation-delay:.5s;}
.main02 .main02ItemList li.item02{top:152px; margin-left:-320px;}
.main02 .main02ItemList li.item03{top:193px; margin-left:-2px;}
.main02 .main02ItemList li.item04{top:185px; margin-left:355px;}
.main02 .main02ItemList li.item05{top:240px; margin-left:551px;}
.main02 .main02ItemList li.item06{top:345px; margin-left:-444px;}
.main02 .main02ItemList li.item07{top:350px; margin-left:-55px;}
.main02 .main02ItemList li.item08{top:364px; margin-left:-306px}
.main02 .main02ItemList li a {position:relative; display:block; width:40px; height:40px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/75119/btn_cross.png) no-repeat 0 0;}
.main02 .main02ItemList li a img {position:absolute; top:-20px; left:-87px; display:none;}
.main02 .main02ItemList li.item02 a img {left:-130px;}
.main02 .main02ItemList li.item03 a img {left:-120px;}
.main02 .main02ItemList li.item04 a img {top:0px; left:-165px;}
.main02 .main02ItemList li.item05 a img {left:-117px;}
.main02 .main02ItemList li.item06 a img {left:-230px;}
.main02 .main02ItemList li.item07 a img {left:0px;}
.main02 .main02ItemList li.item08 a img {left:-5px;}
.main02 .main02ItemList li a:hover img {display:block;}
@keyframes bounce2 {
	from, to{transform:translateY(4px); animation-timing-function:ease-out;}
	50% {transform:translateY(0); animation-timing-function:ease-in;}
}
.recommendItemList02 {background-color:#f6f1e8; height:710px;}
.recommendItemList02 h4 {padding:87px 0 90px;}
.recommendItemList02 ul {width:1095px; margin:0 auto; overflow:hidden;}
.recommendItemList02 ul li {float:left; margin:0 35px;}
.praticalItemList02 {background-color:#f0e8e6; height:710px;}
.praticalItemList02 h4 {padding:95px 0 40px;}
.praticalItemList02 ul {width:1095px; margin:0 auto; overflow:hidden;}
.praticalItemList02 ul li {float:left; margin:0 30px;}

/* 탭3 class */
.class01 {margin-top:82px;}
.class01 h3 {background:#eeedeb url(http://webimage.10x10.co.kr/eventIMG/2016/75119/img_class_01.jpg) no-repeat 50% 0; padding:133px 0 460px;}
.class01 .classInfo, .class02 .classInfo {padding:84px 0 34px;}
.class02 {padding-bottom:100px;}
.class02 h3 {background: url(http://webimage.10x10.co.kr/eventIMG/2016/75119/img_class_02.jpg) no-repeat 50% 0; margin-top:100px; padding:118px 0 507px;}

/* 탭4 thisWeek */
.thisWeek {background:#fff; margin-top:82px;}
.thisWeek h3 {padding:105px 0 38px;}
.thisWeek p {position:relative;}
.thisWeek p .day {position:absolute; top:33px; left:50%; margin-left:48px; color:#ab4840; font-weight:bold; font-size:48px; line-height:55px;}
.itemList {overflow:hidden; width:1050px;  margin:42px auto 72px;}
.itemList li{float:left; width:282px; height:432px; margin:32px;}
.thisWeekBrand {overflow:hidden; padding-bottom:130px; background:#f4f4f4; }
.thisWeekBrand h3 {padding:107px 0 54px;}
.brandList {width:1140px; margin:0 auto;}
.brandList li {float:left; width:347px; height:230px;}
.brandList .brand02 {padding:0 49px;}

</style>
<script type="text/javascript">
/* title animation */
$(function(){
	animation();
	$("#animation .letter1").css({"margin-top":"-30px", "opacity":"0"});
	$("#animation .letter2").css({"margin-top":"50px", "opacity":"0"});
	$("#animation .titIco1").css({"margin-left":"-353px", "opacity":"0"});
	$("#animation .titIco2").css({"margin-left":"225px", "opacity":"0"});
	$(".figure .chicken").css({"bottom":"-50px", "opacity":"0"});
	function animation () {
		$("#animation .letter1").delay(200).animate({"margin-top":"0px", "opacity":"1"},1200);
		$("#animation .letter2").delay(200).animate({"margin-top":"0px", "opacity":"1"},1200);
		$("#animation .titIco1").delay(800).animate({"margin-left":"-303px", "opacity":"1",},1200);
		$("#animation .titIco2").delay(800).animate({"margin-left":"175px", "opacity":"1",},1200);
		$(".figure .chicken").delay(900).animate({"bottom":"0px", "opacity":"1",},1800);
	}
});
</script>
<% if grcode="197203" then %>
	<div class="evt75119">
		<!-- head -->
		<div class="head">
			<div class="title">
				<h2 id="animation">
					<span class="letter letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_2017.png" alt="2017" /></span>
					<span class="letter letter2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_new_year.png" alt="설날에 만난 선물" /></span>
					<span class="letter letter3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_sub.png" alt="오래오래 기억될 명절 선물을 찾아서" /></span>
					<span class="titIco titIco1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_icon_01.png" alt="" /></span>
					<span class="titIco titIco2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_icon_02.png" alt="" /></span>
				</h2>
				<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_date.png" alt="2017.1.2 - 1.23" /></p>
				<div class="bnr">
					<ul>
						<li class="bnr1"><a href="/event/eventmain.asp?eventid=75202"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_01.png" alt="새해 1등 선물 돈봉투" /></a></li>
						<li class="bnr2"><a href="/event/eventmain.asp?eventid=75173"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_02.png" alt="곱게 차려 입을 설빔" /></a></li>
						<li class="bnr3"><a href="/event/eventmain.asp?eventid=75200"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_03.png" alt="추억 찰칵 설 연휴여행" /></a></li>
					</ul>
				</div>
				<div class="figure">
					<span class="figure1 mountain"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_mountain.png" alt="" /></span>
					<span class="figure1 chicken"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_chicken.png" alt="" /></span>
				</div>
			</div>
			<div class="navigator">
				<ul>
					<li class="nav1"><a href="/event/eventmain.asp?eventid=75119&eGc=197203" <%=chkIIF(grcode="197203","class='on'","")%>><span></span>간직하기 좋은 명절 선물</a></li>
					<li class="nav2"><a href="/event/eventmain.asp?eventid=75119&eGc=197204" <%=chkIIF(grcode="197204","class='on'","")%>><span></span>함께 나누는 맛있는 음식</a></li>
					<li class="nav3"><a href="/event/eventmain.asp?eventid=75119&eGc=197627" <%=chkIIF(grcode="197627","class='on'","")%>><span></span>행복을 선물하는 베이킹 클래스</a></li>
					<li class="nav4"><a href="/event/eventmain.asp?eventid=75119&eGc=197628" <%=chkIIF(grcode="197628","class='on'","")%> ><span></span>후회 없는 특가선물<span class="onlyWeek"></span></a></li>
				</ul>
			</div>
		</div>
		<!-- // head-->
		<!-- main -->
		<div class="main">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_intro_01.png" alt="작년 설에 어떤 선물을 받았는지 기억나시나요?" /></h3>
			<ul class="mainItemList">
				<li class="item01"><a href="/shopping/category_prd.asp?itemid=1538445&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_01.png" alt="Seoulbund 한복앞치마 ATO (블루)"/></a></li>
				<li class="item02"><a href="/shopping/category_prd.asp?itemid=1628305&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_02.png" alt="SEOULBUND和 LA LUNE (Fusion)"/></a></li>
				<li class="item03"><a href="/shopping/category_prd.asp?itemid=1623726&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_03.png" alt="금수레 구운 소금 세트 1호"/></a></li>
				<li class="item04"><a href="/shopping/category_prd.asp?itemid=1510957&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_04.png" alt="JIA 스티머 미디움"/></a></li>
				<li class="item05"><a href="/shopping/category_prd.asp?itemid=1626955&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_05.png" alt="젠미 블루 세트"/></a></li>
				<li class="item06"><a href="/shopping/category_prd.asp?itemid=1627798&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_06.png" alt="프릳츠 콜드브루 x 유리잔 선물세트"/></a></li>
				<li class="item07"><a href="/shopping/category_prd.asp?itemid=1627799&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_07.png" alt="프릳츠 콜드브루 x 드립백 선물세트" /></a></li>
				<li class="item08"><a href="/shopping/category_prd.asp?itemid=1628306&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_08.png" alt="SEOULBUND和 소반트레이 정사각"/></a></li>
				<li class="item09"><a href="/shopping/category_prd.asp?itemid=1626954&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_09.png" alt="젠미야 티컵/소스 세트"/></a></li>
				<li class="item10"><a href="/shopping/category_prd.asp?itemid=1627047&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_10.png" alt="알디프 트라이앵글 티백 12입 샘플러 박스 No.1"/></a></li>
				<li class="item11"><a href="/shopping/category_prd.asp?itemid=1626956&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01_11.png" alt="젠미야 소서 세트"/></a></li>
			</ul>
		</div>
		<!-- //main -->
		<div class="recommendItemList">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_recommend_item.png" alt="이유있는 추천 상품" /></h4>
			<ul >
				<li><a href="/shopping/category_prd.asp?itemid=1612785&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_recommend_item_01_01.png" alt="액상차 우드패키지" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1600691&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_recommend_item_01_02.png" alt="클래식 나무상자 선물세트" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1626955&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_recommend_item_01_03.png" alt="젠미 블루 세트" /></a></li>
			</ul>
		</div>
		<div class="praticalItemList">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_practical_item.png" alt="실속있는 선물 세트" /></h4>
			<ul>
				<li><a href="/shopping/category_prd.asp?itemid=1556834&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_practical_item_01_01.png" alt="바닐라라떼 선물세트" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1628564&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_practical_item_01_02.png" alt="ALOHWA X mayiflower New year Box" /></a></li>
				<!-- 01/16 오전 9시 img_practical_item_01_03.png 이미지를 img_practical_item_01_03_v2.png로 교체 -->
				<% if date < "2017-01-16" then %>
					<li><a href="/shopping/category_prd.asp?itemid=1626461&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_practical_item_01_03.png" alt="새해기원 더치커피 선물세트 (250mlx4)" /></a></li>
				<% else %>
					<li><a href="/shopping/category_prd.asp?itemid=1626461&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_practical_item_01_03_v2.png" alt="새해기원 더치커피 선물세트 (250mlx4)" /></a></li>
				<% end if %>
			</ul>
		</div>
	</div>
<% elseif grcode="197204" then %>
	<div class="evt75119">
		<!-- head -->
		<div class="head">
			<div class="title">
				<h2 id="animation">
					<span class="letter letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_2017.png" alt="2017" /></span>
					<span class="letter letter2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_new_year.png" alt="설날에 만난 선물" /></span>
					<span class="letter letter3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_sub.png" alt="오래오래 기억될 명절 선물을 찾아서" /></span>
					<span class="titIco titIco1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_icon_01.png" alt="" /></span>
					<span class="titIco titIco2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_icon_02.png" alt="" /></span>
				</h2>
				<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_date.png" alt="2017.1.2 - 1.23" /></p>
				<div class="bnr">
					<ul>
						<li class="bnr1"><a href="/event/eventmain.asp?eventid=75202"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_01.png" alt="새해 1등 선물 돈봉투" /></a></li>
						<li class="bnr2"><a href="/event/eventmain.asp?eventid=75173"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_02.png" alt="곱게 차려 입을 설빔" /></a></li>
						<li class="bnr3"><a href="/event/eventmain.asp?eventid=75200"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_03.png" alt="추억 찰칵 설 연휴여행" /></a></li>
					</ul>
				</div>
				<div class="figure">
					<span class="figure1 mountain"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_mountain.png" alt="" /></span>
					<span class="figure1 chicken"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_chicken.png" alt="" /></span>
				</div>
			</div>
			<div class="navigator">
				<ul>
					<li class="nav1"><a href="/event/eventmain.asp?eventid=75119&eGc=197203" <%=chkIIF(grcode="197203","class='on'","")%>><span></span>간직하기 좋은 명절 선물</a></li>
					<li class="nav2"><a href="/event/eventmain.asp?eventid=75119&eGc=197204" <%=chkIIF(grcode="197204","class='on'","")%>><span></span>함께 나누는 맛있는 음식</a></li>
					<li class="nav3"><a href="/event/eventmain.asp?eventid=75119&eGc=197627" <%=chkIIF(grcode="197627","class='on'","")%>><span></span>행복을 선물하는 베이킹 클래스</a></li>
					<li class="nav4"><a href="/event/eventmain.asp?eventid=75119&eGc=197628" <%=chkIIF(grcode="197628","class='on'","")%> ><span></span>후회 없는 특가선물<span class="onlyWeek"></span></a></li>
				</ul>
			</div>
		</div>
		<!-- // head-->
		<!-- main02 -->
		<div class="main02">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_intro.png" alt="명절 선물의 고민을 바로 해결해 드립니다." /></h3>
			<ul class="main02ItemList">
				<li class="item01"><a href="/shopping/category_prd.asp?itemid=1627062&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_01.png" alt="다비채 전통패키지" /></a></li>
				<li class="item02"><a href="/shopping/category_prd.asp?itemid=1628564&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_02.png" alt="ALOHWA X mayiflower New year Box" /></a></li>
				<li class="item03"><a href="/shopping/category_prd.asp?itemid=1551323&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_03.png" alt="6종 과일칩 선물세트 (M)" /></a></li>
				<li class="item04"><a href="/shopping/category_prd.asp?itemid=1468740&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_04.png" alt="당산나무 집벌꿀 답례품 세트 (中)" /></a></li>
				<li class="item05"><a href="/shopping/category_prd.asp?itemid=1610726&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_05.png" alt="큐어비스호프 콜러 호박씨기름 500ml" /></a></li>
				<li class="item06"><a href="/shopping/category_prd.asp?itemid=1627047&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_06.png" alt="알디프 트라이앵글 티백 12입 샘플러 박스 No.1 " /></a></li>
				<li class="item07"><a href="/shopping/category_prd.asp?itemid=1628306&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_07.png" alt="SEOULBUND和 소반트레이 정사각" /></a></li>
				<li class="item08"><a href="/shopping/category_prd.asp?itemid=1253348&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_main_item_08.png" alt="마이빈스 더치한첩 (50mlx40포)" /></a></li>
			</ul>
		</div>
		<!-- //main02 -->
		<div class="recommendItemList02">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_recommend_item.png" alt="이유있는 추천상품" /></h4>
			<ul >
				<li><a href="/shopping/category_prd.asp?itemid=1630256&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_recommend_item_01.png" alt="설날 온가족 건강선물세트" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1548284&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_recommend_item_02.png" alt="마이빈스 풍성한병 (500ml)" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1443838&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_recommend_item_03.png" alt="명품 소꼬리 선물세트(3kg)" /></a></li>
			</ul>
		</div>
		<div class="praticalItemList02">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_practical_item.png" alt="실속있는 선물세트" /></h4>
			<ul>
				<li><a href="/shopping/category_prd.asp?itemid=1620838&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_practical_item_01.png" alt="판타스틱국수 6개들이 선물세트" /></a></li>
				<!-- 01/09 오전9시 img_practical_item_02.png를 img_practical_item_02_v3.png 로 교체 -->
				<!-- 01/16 오전9시 img_practical_item_02_v3.png 이미지를 img_practical_item_02_v4.png로 교체 -->
				<% if date < "2017-01-16" then %>
					<li><a href="/shopping/category_prd.asp?itemid=1616984&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_practical_item_02_v3.png" alt="꽃차 1+2 기획세트" /></a></li>
					<li><a href="/shopping/category_prd.asp?itemid=1620224&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_practical_item_03_v2.png" alt="일건식 아로니아즙 30포" /></a></li>
				<% else %>
					<li><a href="/shopping/category_prd.asp?itemid=1616984&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_practical_item_02_v4.png" alt="꽃차 1+2 기획세트" /></a></li>
					<li><a href="/shopping/category_prd.asp?itemid=1620224&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_practical_item_03_v3.png" alt="일건식 아로니아즙 30포" /></a></li>
				<% end if %>
				<!-- 01/09 오전9시 img_practical_item_03_v2.png 로 교체 -->
				<!-- 01/16 오전9시에  img_practical_item_03_v3.png 로 이미지 교체 -->
				
			</ul>
		</div>
	</div>
<% elseif grcode="197627" then %>
	<div class="evt75119">
		<!-- head -->
		<div class="head">
			<div class="title">
				<h2 id="animation">
					<span class="letter letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_2017.png" alt="2017" /></span>
					<span class="letter letter2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_new_year.png" alt="설날에 만난 선물" /></span>
					<span class="letter letter3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_sub.png" alt="오래오래 기억될 명절 선물을 찾아서" /></span>
					<span class="titIco titIco1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_icon_01.png" alt="" /></span>
					<span class="titIco titIco2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_icon_02.png" alt="" /></span>
				</h2>
				<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_date.png" alt="2017.1.2 - 1.23" /></p>
				<div class="bnr">
					<ul>
						<li class="bnr1"><a href="/event/eventmain.asp?eventid=75202"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_01.png" alt="새해 1등 선물 돈봉투" /></a></li>
						<li class="bnr2"><a href="/event/eventmain.asp?eventid=75173"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_02.png" alt="곱게 차려 입을 설빔" /></a></li>
						<li class="bnr3"><a href="/event/eventmain.asp?eventid=75200"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_03.png" alt="추억 찰칵 설 연휴여행" /></a></li>
					</ul>
				</div>
				<div class="figure">
					<span class="figure1 mountain"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_mountain.png" alt="" /></span>
					<span class="figure1 chicken"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_chicken.png" alt="" /></span>
				</div>
			</div>
			<div class="navigator">
				<ul>
					<li class="nav1"><a href="/event/eventmain.asp?eventid=75119&eGc=197203" <%=chkIIF(grcode="197203","class='on'","")%>><span></span>간직하기 좋은 명절 선물</a></li>
					<li class="nav2"><a href="/event/eventmain.asp?eventid=75119&eGc=197204" <%=chkIIF(grcode="197204","class='on'","")%>><span></span>함께 나누는 맛있는 음식</a></li>
					<li class="nav3"><a href="/event/eventmain.asp?eventid=75119&eGc=197627" <%=chkIIF(grcode="197627","class='on'","")%>><span></span>행복을 선물하는 베이킹 클래스</a></li>
					<li class="nav4"><a href="/event/eventmain.asp?eventid=75119&eGc=197628" <%=chkIIF(grcode="197628","class='on'","")%> ><span></span>후회 없는 특가선물<span class="onlyWeek"></span></a></li>
				</ul>
			</div>
		</div>
		<!-- // head-->
		<!-- contents -->
		<div class="class01">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_class_01.png" alt="class1 앙금 플라워 케이크" /></h3>
			<div class="classInfo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_class_01_details.png" alt="생화같은 리얼한 작약 부케 케이크 완성하기 & 고소한 흑임자 설기 만들어보기" /></div>
			<a href="/shopping/category_prd.asp?itemid=1627367&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/btn_go_class.png" alt="수업신청 하러가기" /></a>
		</div>
		<div class="class02">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_class_02.png" alt="class2 앙금 플라워 쿠키" /></h3>
			<div class="classInfo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_class_02_details.png" alt="장미 & 라넌큘러스 쿠키 만들어보기 (10~20개 /선물패키지 제공)" /></div>
			<a href="/shopping/category_prd.asp?itemid=1627399&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/btn_go_class.png" alt="수업신청 하러가기" /></a>
		</div>
		<!-- //contents -->
	</div>
<% elseif grcode="197628" then %>
	<!-- 2017 설날에 만난 선물 -->
	<div class="evt75119">
		<!-- head -->
		<div class="head">
			<div class="title">
				<h2 id="animation">
					<span class="letter letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_2017.png" alt="2017" /></span>
					<span class="letter letter2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_new_year.png" alt="설날에 만난 선물" /></span>
					<span class="letter letter3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/tit_sub.png" alt="오래오래 기억될 명절 선물을 찾아서" /></span>
					<span class="titIco titIco1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_icon_01.png" alt="" /></span>
					<span class="titIco titIco2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_icon_02.png" alt="" /></span>
				</h2>
				<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_date.png" alt="2017.1.2 - 1.23" /></p>
				<div class="bnr">
					<ul>
						<li class="bnr1"><a href="/event/eventmain.asp?eventid=75202"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_01.png" alt="새해 1등 선물 돈봉투" /></a></li>
						<li class="bnr2"><a href="/event/eventmain.asp?eventid=75173"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_02.png" alt="곱게 차려 입을 설빔" /></a></li>
						<li class="bnr3"><a href="/event/eventmain.asp?eventid=75200"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_bnr_03.png" alt="추억 찰칵 설 연휴여행" /></a></li>
					</ul>
				</div>
				<div class="figure">
					<span class="figure1 mountain"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_mountain.png" alt="" /></span>
					<span class="figure1 chicken"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_chicken.png" alt="" /></span>
				</div>
			</div>
			<div class="navigator">
				<ul>
					<li class="nav1"><a href="/event/eventmain.asp?eventid=75119&eGc=197203" <%=chkIIF(grcode="197203","class='on'","")%>><span></span>간직하기 좋은 명절 선물</a></li>
					<li class="nav2"><a href="/event/eventmain.asp?eventid=75119&eGc=197204" <%=chkIIF(grcode="197204","class='on'","")%>><span></span>함께 나누는 맛있는 음식</a></li>
					<li class="nav3"><a href="/event/eventmain.asp?eventid=75119&eGc=197627" <%=chkIIF(grcode="197627","class='on'","")%>><span></span>행복을 선물하는 베이킹 클래스</a></li>
					<li class="nav4"><a href="/event/eventmain.asp?eventid=75119&eGc=197628" <%=chkIIF(grcode="197628","class='on'","")%> ><span></span>후회 없는 특가선물<span class="onlyWeek"></span></a></li>
				</ul>
			</div>
		</div>
		<!-- //head-->

		<!-- thisWeek -->
		<div class="thisWeek">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_only_week.png" alt="오직 일주일 특가" /></h3>
			<%'' for dev msg 남은 특가 일수에 따라 class="day" 의 이미지를 변경해 주세요./ 이미지파일명은 "txt_num_남은 일수.png" 입니다.%>
			<!-- for dev msg 23일(마지막날) txt_d_day_count.png 이미지를 txt_d_day_last.png 로 교체해주세요. 그리고 class="day"를 숨겨주세요. -->
			<% if date >= "2017-01-23" then %>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_d_day_count_v2.png" alt="취향 저격 명절 선물 특가! #일 남았습니다." /><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_d_day_last.png" alt="dday" /></span></p>
			<% else %>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_d_day_count_v2.png" alt="취향 저격 명절 선물 특가! #일 남았습니다." /><span class="day"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/dday/txt_num_0<%=dday+1%>.png" alt="dday" /></span></p>
			<% end if %>
			
			<% if date <= "2017-01-08" then %>
				<%'' 1주차 %>
				<div class="thisWeekPrice">
					<ul class="itemList">
						<li><a href="/shopping/category_prd.asp?itemid=1285004&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_01_01.jpg" alt="닥터넛츠 오리지널 뉴 30개입 패키지" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1620226&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_01_02.jpg" alt="달콤하고 바삭한 맛군 달추칩" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1621594&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_01_03.jpg" alt="젠미야 블랙 선물세트" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1626462&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_01_04.jpg" alt="[마이빈스 더치커피] 새해기원 선물세트 (210mlx4병)" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1620012&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_01_05.jpg" alt="건강선물 맛있는수제차 패키지" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1552452&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_01_06.jpg" alt="향기로운 허니트리플-FRAGRANT HONEY TRIPLE SET" /></a></li>
					</ul>
				</div>
				<div class="thisWeekBrand">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_recommend.png" alt="금주의 추천 브랜드" /></h3>
					<ul class="brandList">
						<li><a href="/street/street_brand.asp?makerid=jcdelimeats"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_brand_01.jpg" alt="항상 맛있는 홍차를 마시는 습관 ALTDIF" /></a></li>
						<li class="brand02"><a href="/street/street_brand.asp?makerid=altdif"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_brand_02.jpg" alt="엄선한 육가공품 브랜드 JOHNCOOK DELI MEATS" /></a></li>
						<li><a href="/street/street_brand.asp?makerid=i2corp"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_brand_03.jpg" alt="상큼하게 즐기는 비타민구미 JOHNCOOK DELI MEATS" /></a></li>
					</ul>
				</div>
			<% elseif date >= "2017-01-09" and date <= "2017-01-15" then %>
				<%'' 2주차 %>
				<div class="thisWeekPrice">
					<ul class="itemList">
						<li><a href="/shopping/category_prd.asp?itemid=1616984&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_02_01_v2.jpg" alt="[꽃을담다] 꽃차 1+2 기획세트" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1620224&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_02_02.jpg" alt="일건식 아로니아즙 30포" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1632702&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_02_03.jpg" alt="현미 연강정 산자 선물세트" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1536909&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_02_04.jpg" alt="인테이크 힘내! 오렌지맛 멀티구미 (30일 섭취량, 252g×1병)" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1632380&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_02_05.jpg" alt="리틀스커피 PREMIUM 커피 선물세트" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1630094&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_02_06.jpg" alt="슈퍼너츠2종+슈퍼잼1종 선물세트" /></a></li>
					</ul>
				</div>
				<div class="thisWeekBrand">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_recommend.png" alt="금주의 추천 브랜드" /></h3>
					<ul class="brandList">
						<li><a href="/street/street_brand_sub06.asp?makerid=alohwa"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_brand_02_01.jpg" alt="꽃으로 당신의 삶을 향기롭게 ALOHWA" /></a></li>
						<li class="brand02"><a href="/street/street_brand_sub06.asp?makerid=zenmiyaofficial"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_brand_02_02.jpg" alt="맛있는 요리를 위한 소스와 키친아이템 ZENMIYA" /></a></li>
						<li><a href="/street/street_brand.asp?makerid=matgoon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_brand_02_03.jpg" alt="순수 자연의 맛 MATGOON" /></a></li>
					</ul>
				</div>
			<% elseif date >= "2017-01-16" and date <= "2017-01-23" then %>
				<%'' 3주차 %>
				<div class="thisWeekPrice">
					<ul class="itemList">
						<li><a href="/shopping/category_prd.asp?itemid=1626461&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_03_01.jpg" alt="[마이빈스 더치커피] 새해기원 선물세트 (250mlx4병)" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1417458&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_03_02.jpg" alt="[콜록콜록] 한첩 SET" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1547074&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_03_03.jpg" alt="인테이크 힘내 홍삼 젤리스틱 (30일 섭취량, 15gx30포)" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1558536&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_03_04.jpg" alt="프렌비 벌꿀 3종 -풍요로운 선물" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=1635627&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_03_05.jpg" alt=" sweet teatime 수제잼 선물세트" /></a></li>
						<li><a href="/shopping/category_prd.asp?itemid=915264&pEtr=75119"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_item_03_06.jpg" alt="[1+1]해일 명품감말랭이 선물세트-지함1호(감말랭이100g×6봉)2박스" /></a></li>
					</ul>
				</div>
				<div class="thisWeekBrand">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/txt_recommend.png" alt="금주의 추천 브랜드" /></h3>
					<ul class="brandList">
						<li><a href="/street/street_brand_sub06.asp?makerid=jamong10"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_brand_03_01.jpg" alt="SUPER JAM & NUTS" /></a></li>
						<li class="brand02"><a href="/street/street_brand_sub06.asp?makerid=sogobang"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_brand_03_02.jpg" alt="SOHADONG GOBANG" /></a></li>
						<li><a href="/street/street_brand.asp?makerid=mybeans10"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75119/img_brand_03_03.jpg" alt="MYBEANS" /></a></li>
					</ul>
				</div>
			<% end if %>
		</div>
		<!-- //thisWeek -->
	</div>
	<!-- //2017 설날에 만난 선물 -->
<% end if %>