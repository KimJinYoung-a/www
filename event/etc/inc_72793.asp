<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 웨딩 빅세일
' History : 2016-09-23 유태욱
'####################################################
%>

<style type="text/css">
img {vertical-align:top;}
.smallWedding {background:#ffece4 url(http://webimage.10x10.co.kr/eventIMG/2016/72792/bg_flower_1.png) no-repeat 0 702px;}
.smallWedding .weddingContainer {padding:55px 0 50px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72792/bg_flower_2.png) no-repeat 100% 505px;}
.smallWedding .weddingHead {position:relative; width:770px; height:507px; margin:0 auto;}
.smallWedding .weddingHead .fwTrend {position:absolute; left:50%; top:40px; z-index:30; margin-left:-212px;}
.smallWedding .weddingHead h2 {position:absolute; left:50%; top:184px; z-index:50; margin-left:-178px;}
.smallWedding .weddingHead .flower {position:absolute; left:109px; top:0; z-index:50; width:209px; height:203px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72792/bg_title_flower_1.png) no-repeat 0 0;}
.smallWedding .weddingHead .goMembership {position:absolute; right:-195px; top:8px; z-index:50;}
.smallWedding .weddingHead .bg {position:absolute; z-index:20; left:0; top:0;  width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72792/bg_title_flower_2.png) no-repeat 50% 50%;}
.smallWedding .weddingNav {position:relative; width:1160px; margin:0 auto;}
.smallWedding .weddingNav .only {position:absolute; right:132px; top:-46px; z-index:50;}
.smallWedding .weddingContents {width:1160px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72792/bg_box.png) repeat-y 0 0;}
.smallWedding .weddingCont {/*background:url(http://webimage.10x10.co.kr/eventIMG/2016/72792/bg_box_top.png) no-repeat 0 0;*/}
.smallWedding .weddingCont .picture {padding-bottom:10px;}
.smallWedding .weddingCont .btm {height:60px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72792/bg_box_btm.png) no-repeat 0 0;}
.smallWedding .picture h3 {padding:60px 0;}
</style>
<script>
$(function(){
	titleAnimation()
	$(".weddingHead .bg").css({"opacity":"0"});
	$(".weddingHead h2").css({"margin-top":"-5px","opacity":"0"});
	function titleAnimation() {
		$(".weddingHead .bg").delay(10).animate({"opacity":"1"},2500);
		$(".weddingHead h2").delay(100).animate({"margin-top":"5px","opacity":"1"},600).animate({"margin-top":"0"},500);
	}

	$('.smallWedding .picture li a').mouseover(function(){
		$(this).children('span').fadeIn(100);
	});
	$('.smallWedding .picture li a').mouseleave(function(){
		$(this).children('span').fadeOut(100);
	});

	function swing1 () {
		$(".goMembership").animate({"margin-top":"-10px"},1000).animate({"margin-top":"0"},1000, swing1);
	}
	function swing2 () {
		$(".smallWedding .picture li").animate({"margin-top":"-5px"},800).animate({"margin-top":"0"},800, swing2);
	}
	swing1();
	swing2();
});
</script>
<!-- SMALL WEDDING -->
<div class="evt72793 smallWedding">
	<div class="weddingContainer">
		<div class="weddingHead">
			<p class="fwTrend"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72792/txt_wedding_trend.png" alt="2016 F/W WeddingTrend" /></p>
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/72792/tit_small_wedding.png" alt="SMALL WEDDING" /></h2>
			<p class="goMembership"><a href="/event/eventmain.asp?eventid=73007"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72792/btn_membershop.png" alt="웨딩멤버쉽 이벤트 바로가기" /></a></p>
			<div class="flower"></div>
			<div class="bg"></div>
		</div>
		<div class="weddingNav">
			<% if date() < "2016-09-26" then %>
				<%' 1주차(0916~0925) %>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72792/nav_3.png" alt="" usemap="#wdNav" /></p>

			<% elseif date() >= "2016-09-26" and date() < "2016-10-03" then %>
				<%' 2주차(0926~1002) %>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72792/nav_3_02.png" alt="" usemap="#wdNav" /></p>

			<% elseif date() >= "2016-10-03" and date() < "2016-10-10" then %>
				<%' 3주차(1003~1009) %>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72792/nav_3_03.png" alt="" usemap="#wdNav" /></p>

			<% elseif date() >= "2016-10-10" then %>
				<%' 4주차(1010~1016) %>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72792/nav_3_04.png" alt="" usemap="#wdNav" /></p>

			<% end if %>

			<map name="wdNav" id="wdNav">
				<area shape="rect" coords="10,5,390,92" href="/event/eventmain.asp?eventid=72794" onfocus="this.blur();" alt="WEDDING PARTY" />
				<area shape="rect" coords="391,5,771,92" href="/event/eventmain.asp?eventid=72792" onfocus="this.blur();" alt="SELF HOUSE" />
				<area shape="rect" coords="773,5,1149,92" href="/event/eventmain.asp?eventid=72793" onfocus="this.blur();" alt="BIG SALE" />
			</map>
			<span class="only"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72792/txt_only_1week.png" alt="단 일주일만 세일 " /></span>
		</div>
		<div class="weddingContents">
			<div class="weddingCont">
				<% if date() < "2016-09-26" then %>
					<%' 1주차(0916~0925) %>
					<div class="picture">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72793/tit_just.png" alt="JUST 1 WEEK" /></h3>
						<div>
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/72793/img_product_1.jpg" alt="" usemap="#itemMap" />
							<map name="itemMap" id="itemMap">
								<area shape="rect" coords="3,4,496,250" href="/shopping/category_prd.asp?itemid=1434357&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="508,5,998,248" href="/shopping/category_prd.asp?itemid=1545672&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="6,318,206,606" href="/shopping/category_prd.asp?itemid=1417796&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="268,314,471,607" href="/shopping/category_prd.asp?itemid=1512202&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="532,311,732,607" href="/shopping/category_prd.asp?itemid=1290289&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="796,308,994,605" href="/shopping/category_prd.asp?itemid=1410133&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="8,675,201,962" href="/shopping/category_prd.asp?itemid=742608&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="272,677,470,962" href="/shopping/category_prd.asp?itemid=1561416&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="532,673,731,963" href="/shopping/category_prd.asp?itemid=1256590&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="786,674,993,964" href="/shopping/category_prd.asp?itemid=830179&pEtr=72793" onfocus="this.blur();" alt="" />
							</map>
						</div>
					</div>

				<% elseif date() >= "2016-09-26" and date() < "2016-10-03" then %>
					<%' 2주차(0926~1002) %>
					<div class="picture">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72793/tit_just_2.png" alt="JUST 1 WEEK" /></h3>
						<div>
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/72793/img_product_2_v2.jpg" alt="" usemap="#itemMap2" />
							<map name="itemMap2" id="itemMap2">
								<area shape="rect" coords="10,60,218,356" href="/shopping/category_prd.asp?itemid=780011&pEtr=72793" onfocus="this.blur();" alt="스파클링 수국 글래스 세트" />
								<area shape="rect" coords="273,63,483,354" href="/shopping/category_prd.asp?itemid=1141911&pEtr=72793" onfocus="this.blur();" alt="[독일 보만] 컨벡션 오븐 22L CO4141" />
								<area shape="rect" coords="538,61,744,353" href="/shopping/category_prd.asp?itemid=1198132&pEtr=72793" onfocus="this.blur();" alt="발뮤다 레인 ERN-1000SD" />
								<area shape="rect" coords="804,62,1007,352" href="/shopping/category_prd.asp?itemid=1023508&pEtr=72793" onfocus="this.blur();" alt="뉴베니즈 2인 식탁세트/의자" />
								<area shape="rect" coords="14,420,213,712" href="/shopping/category_prd.asp?itemid=1536456&pEtr=72793" onfocus="this.blur();" alt="이동식 밀크 트롤리 - 더블5단" />
								<area shape="rect" coords="281,419,478,713" href="/shopping/category_prd.asp?itemid=1215400&pEtr=72793" onfocus="this.blur();" alt="트윈 스트라이프 앞치마(블랙)" />
								<area shape="rect" coords="539,423,749,709" href="/shopping/category_prd.asp?itemid=1325436&pEtr=72793" onfocus="this.blur();" alt="화이트&amp;블랙 책장" />
								<area shape="rect" coords="799,421,1013,712" href="/shopping/category_prd.asp?itemid=1241947&pEtr=72793" onfocus="this.blur();" alt="웨딩커플 조명" />
								<area shape="rect" coords="15,781,213,1078" href="/shopping/category_prd.asp?itemid=1564584&pEtr=72793" onfocus="this.blur();" alt="미니화장대의자" />
								<area shape="rect" coords="276,774,482,1072" href="/shopping/category_prd.asp?itemid=1045979&pEtr=72793" onfocus="this.blur();" alt="FACE TOWEL 벚꽃 Mix10" />
								<area shape="rect" coords="539,777,745,1070" href="/shopping/category_prd.asp?itemid=916562&pEtr=72793" onfocus="this.blur();" alt="프리미엄 빈티지 전신거울1200" />
								<area shape="rect" coords="800,779,1007,1074" href="/shopping/category_prd.asp?itemid=1304283&pEtr=72793" onfocus="this.blur();" alt="쿄토쿠사 2인 식기세트 13P" />
								<area shape="rect" coords="10,1140,215,1433" href="/shopping/category_prd.asp?itemid=255242&pEtr=72793" onfocus="this.blur();" alt="오토 플립 클락" />
								<area shape="rect" coords="277,1133,479,1430" href="/shopping/category_prd.asp?itemid=1202850&pEtr=72793" onfocus="this.blur();" alt="New 요시카와 까페스타일 휴지통 -프론트오픈" />
								<area shape="rect" coords="543,1134,742,1430" href="/shopping/category_prd.asp?itemid=1480527&pEtr=72793" onfocus="this.blur();" alt="AL 실리콘 다이닝 테이블매트" />
								<area shape="rect" coords="805,1137,1005,1429" href="/shopping/category_prd.asp?itemid=1340622&pEtr=72793" onfocus="this.blur();" alt="화이트모카 수납형 책상" />
								<area shape="rect" coords="10,1497,218,1785" href="/shopping/category_prd.asp?itemid=1425593&pEtr=72793" onfocus="this.blur();" alt="니코트 Satin 커트러리 2인세트 HoteL ver. 6P" />
								<area shape="rect" coords="277,1497,482,1786" href="/shopping/category_prd.asp?itemid=1349318&pEtr=72793" onfocus="this.blur();" alt="타공판 인테리어 수납보드 (화이트)" />
								<area shape="rect" coords="541,1497,742,1786" href="/shopping/category_prd.asp?itemid=1566966&pEtr=72793" onfocus="this.blur();" alt="워싱내츄럴콜렉션 밀로 퀼팅 스프레드 Q" />
								<area shape="rect" coords="803,1497,1006,1785" href="/shopping/category_prd.asp?itemid=748502&pEtr=72793" onfocus="this.blur();" alt="자작나무 이니셜 시계 땡글" />
							</map>
						</div>
					</div>

				<% elseif date() >= "2016-10-03" and date() < "2016-10-10" then %>
					<%' 3주차(1003~1009) %>
					<div class="picture">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72793/tit_just_3.png" alt="JUST 1 WEEK" /></h3>
						<div>
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/72793/img_product_3_v2.jpg" alt="" usemap="#itemMap3" />
							<map name="itemMap3" id="itemMap3">
								<area shape="rect" coords="10,60,218,356" href="/shopping/category_prd.asp?itemid=1260092&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="273,63,483,354" href="/shopping/category_prd.asp?itemid=1564558&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="538,61,744,353" href="/shopping/category_prd.asp?itemid=1509062&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="804,62,1007,352" href="/shopping/category_prd.asp?itemid=1419077&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="14,420,213,712" href="/shopping/category_prd.asp?itemid=1529913&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="281,419,478,713" href="/shopping/category_prd.asp?itemid=1528636&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="539,423,749,709" href="/shopping/category_prd.asp?itemid=1561969&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="799,421,1013,712" href="/shopping/category_prd.asp?itemid=77691&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="15,781,213,1078" href="/shopping/category_prd.asp?itemid=1200619&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="276,774,482,1072" href="/shopping/category_prd.asp?itemid=1378730&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="539,777,745,1070" href="/shopping/category_prd.asp?itemid=1566549&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="800,779,1007,1074" href="/shopping/category_prd.asp?itemid=1494292&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="10,1140,215,1433" href="/shopping/category_prd.asp?itemid=1562806&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="277,1133,479,1430" href="/shopping/category_prd.asp?itemid=1519207&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="543,1134,742,1430" href="/shopping/category_prd.asp?itemid=1380085&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="805,1137,1005,1429" href="/shopping/category_prd.asp?itemid=1311289&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="10,1497,218,1785" href="/shopping/category_prd.asp?itemid=767481&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="277,1497,482,1786" href="/shopping/category_prd.asp?itemid=1465642&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="541,1497,742,1786" href="/shopping/category_prd.asp?itemid=1365553&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="803,1497,1006,1785" href="/shopping/category_prd.asp?itemid=1542103&pEtr=72793" onfocus="this.blur();" alt="" />
							</map>
						</div>
					</div>

				<% elseif date() >= "2016-10-10" then %>
					<%' 4주차(1010~1016) %>
					<div class="picture">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72793/tit_just_4.png" alt="JUST 1 WEEK" /></h3>
						<div>
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/72793/img_product_4.jpg" alt="" usemap="#itemMap4" />
							<map name="itemMap4" id="itemMap4">
								<area shape="rect" coords="10,60,218,356" href="/shopping/category_prd.asp?itemid=1404416&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="273,63,483,354" href="/shopping/category_prd.asp?itemid=1392042&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="538,61,744,353" href="/shopping/category_prd.asp?itemid=1423466&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="804,62,1007,352" href="/shopping/category_prd.asp?itemid=1574216&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="14,420,213,712" href="/shopping/category_prd.asp?itemid=1566229&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="281,419,478,713" href="/shopping/category_prd.asp?itemid=1519226&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="539,423,749,709" href="/shopping/category_prd.asp?itemid=541973&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="799,421,1013,712" href="/shopping/category_prd.asp?itemid=1168270&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="15,781,213,1078" href="/shopping/category_prd.asp?itemid=1494253&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="276,774,482,1072" href="/shopping/category_prd.asp?itemid=1485267&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="539,777,745,1070" href="/shopping/category_prd.asp?itemid=1533368&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="800,779,1007,1074" href="/shopping/category_prd.asp?itemid=833528&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="10,1140,215,1433" href="/shopping/category_prd.asp?itemid=506570&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="277,1133,479,1430" href="/shopping/category_prd.asp?itemid=1519160&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="543,1134,742,1430" href="/shopping/category_prd.asp?itemid=1395644&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="805,1137,1005,1429" href="/shopping/category_prd.asp?itemid=1410139&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="10,1497,218,1785" href="/shopping/category_prd.asp?itemid=1545406&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="277,1497,482,1786" href="/shopping/category_prd.asp?itemid=1462744&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="541,1497,742,1786" href="/shopping/category_prd.asp?itemid=1513300&pEtr=72793" onfocus="this.blur();" alt="" />
								<area shape="rect" coords="803,1497,1006,1785" href="/shopping/category_prd.asp?itemid=1480527&pEtr=72793" onfocus="this.blur();" alt="" />
							</map>
						</div>
					</div>
				<% end if %>

				<div class="btm"></div>
			</div>
		</div>
	</div>
</div>
<!--// SMALL WEDDING -->
