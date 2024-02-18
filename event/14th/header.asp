<style type="text/css">
/* 14th anniversary common */
img {vertical-align:top;}
#contentWrap {padding-top:0;}
.gnbWrapV15 {height:38px;}

.anniversary14th {background-color:#fff;}
.anniversary14th .head {position:relative; background:#d8f1fb url(http://webimage.10x10.co.kr/eventIMG/2015/14th/bg_pattern_sky.png) repeat 50% 0;}
.anniversary14th .head .hwrap {height:234px; padding-top:66px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/bg_wave_pattern.png) repeat-x 50% 100%;}
.anniversary14th .head .hwrap .date {position:absolute; top:24px; left:50%; margin-left:422px;}
.anniversary14th .head .tree {position:absolute; top:108px; left:50%; margin-left:396px;}
.anniversary14th .head .tree .leaf01 {position:absolute; top:71px; left:-2px;}
.anniversary14th .head .tree .leaf02 {position:absolute; top:131px; left:92px;}
.anniversary14th .head .cloud01 {position:absolute; top:162px; left:50%; margin-left:-505px;}
.anniversary14th .head .cloud02 {position:absolute; top:45px; left:50%; margin-left:310px;}
.anniversary14th .head .tree .leaf01 {animation:swing01 5s ease-in-out 0s infinite;}
.anniversary14th .head .tree .leaf02 {animation:swing02 7s ease-in-out 0s infinite;}
@keyframes swing01 {
	0% {transform:rotate(0);}
	50% {transform:translate(3px,3px) rotate(-15deg);}
	100% {transform:rotate(0);}
}
@keyframes swing02 {
	0% {transform:rotate(0);}
	50% {transform:translate(1px,3px) rotate(10deg);}
	100% {transform:rotate(0);}
}
.navigator {position:relative; z-index:10; height:93px; border-bottom:1px solid #e3ebee; background-color:#fff;}
.navigator ul {position:absolute; top:-31px; left:50%; overflow:hidden; width:970px; margin-left:-482px;}
.navigator ul li {float:left; width:194px; height:154px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/bg_nav_line.png) no-repeat 100% 55px;}
.navigator ul li a {display:block; width:100%; height:100%;}
.navigator ul li a {overflow:hidden; display:block; position:relative; height:154px; color:#fff; font-size:11px; line-height:154px; text-align:center; text-indent:-999em;}
.navigator ul li a:hover {animation-iteration-count:infinite; animation-duration:0.6s; animation-name:bounce;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-5px; animation-timing-function:ease-in;}
}
.navigator ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/bg_nav_v1.png) no-repeat 0 0;}
.navigator ul li a:hover span {background-position:0 -154px;}
.navigator ul li.nav2 a span {background-position:-194px 0;}
.navigator ul li.nav2 a:hover span {background-position:-194px -154px;}
.navigator ul li.nav2 a.on span {background-position:-194px 100%;}
.navigator ul li.nav3 a span {background-position:-388px 0;}
.navigator ul li.nav3 a:hover span {background-position:-388px -154px;}
.navigator ul li.nav3 a.on span {background-position:-388px 100%;}
.navigator ul li.nav4 a span {background-position:-582px 0;}
.navigator ul li.nav4 a:hover span {background-position:-582px -154px;}
.navigator ul li.nav4 a.on span {background-position:-582px 100%;}
.navigator ul li.nav5 {background:none;}
.navigator ul li.nav5 a span {background-position:100% 0;}
.navigator ul li.nav5 a:hover span {background-position:100% -154px;}
.navigator ul li.nav5 a.on span {background-position:100% 100%;}
</style>

<div class="head">
	<div class="hwrap">
		<%' for dev msg : 메인페이지으로 링크 %>
		<h2><a href="/event/14th/"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/tit_14th.png" alt="14th anniversary 잘한다 잘한다 자란다" /></a></h2>
		<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/txt_date.png" alt="열네번째 생일을 맞는 텐바이텐의 성장 프로젝트 이벤트는 2015년 10월 10일부터 26일까지 진행합니다." /></p>
		<div class="tree">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/img_tree.png" alt="" />
			<span class="leaf01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/img_leaf_01.png" alt="" /></span>
			<span class="leaf02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/img_leaf_02.png" alt="" /></span>
		</div>
		<span class="cloud01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/img_cloud_01.png" alt="" /></span>
		<span class="cloud02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/img_cloud_02.png" alt="" /></span>
	</div>
	<div class="navigator">
		<ul>
			<%' for dev msg : 현재 페이지 선택시 a에 클래스 on 붙여주세요. 첫번째 탭은 메인페이지으로만 링크되며 클래스 on붙지 않아요 %>
			<%
				'// 파일명 기준으로 해당 클래스에 on 함
				Dim vMenuOnFnm14Th, vSTempValue
				vSTempValue = Request.ServerVariables("PATH_INFO")
				vMenuOnFnm14Th = Split(vSTempValue, "/")
			%>
			<li class="nav1"><a href="/event/14th/"><span></span>14주년 메인으로</a></li>
			<li class="nav2"><a href="/event/14th/gift.asp" <% If lcase(vMenuOnFnm14Th(3))=lcase("gift.asp") Then %> class="on" <% End If %>><span></span>생일엔 선물</a></li>
			<li class="nav3"><a href="/event/14th/coaster.asp" <% If lcase(vMenuOnFnm14Th(3))=lcase("coaster.asp") Then %> class="on" <% End If %>><span></span>다함께 코.스.터!</a></li>
			<li class="nav4"><a href="/event/14th/shoppingstyle.asp" <% If lcase(vMenuOnFnm14Th(3))=lcase("shoppingstyle.asp") Then %> class="on" <% End If %>><span></span>쇼핑, 그것이 알고싶다!</a></li>
			<li class="nav5"><a href="/event/14th/shop.asp" <% If lcase(vMenuOnFnm14Th(3))=lcase("shop.asp") Then %> class="on" <% End If %>><span></span>습격자들</a></li>
		</ul>
	</div>
</div>
<script type="text/javascript">
$(function(){
	/* cloud move */
	function cloud() {
		$(".cloud01").animate({"margin-left":"-505px"},1500).animate({"margin-left":"-515px"},1500, cloud);
		$(".cloud02").animate({"margin-left":"310px"},2000).animate({"margin-left":"325px"},2000, cloud);
	}
	cloud();
});
</script>
