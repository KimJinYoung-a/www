<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 웨딩 빅세일
' History : 2017-09-29 김송이
'####################################################
%>

<style>
.evt80618 {background:#fde5d0 url(http://webimage.10x10.co.kr/eventIMG/2017/80618/bg_conts.jpg) 50% 0 no-repeat; text-align:center;}
.wd-head {position:relative; border-top:5px solid #f6b1a5;}
.wd-head .spe-price {padding:105px 0 20px; opacity:0;}
.wd-head h2 {opacity:0;}
.wd-head .subcp {padding:25px 0 70px; opacity:0;}
.wd-head .btn-wd{position:absolute; top:0; left:50%; margin-left:400px; opacity:0;}
.prd-list {padding:54px 0 210px; background: url(http://webimage.10x10.co.kr/eventIMG/2017/80618/bg_prd.png) 50% 0 no-repeat;}
.prd-list .prds {margin-top:100px;}
.special-brand .brands {padding:55px 0 127px;}
.swing{animation:swing 2.3s 100 forwards ease-in-out; transform-origin:50% 0;}
@keyframes swing { 0%,100%{transform:rotate(2deg);} 50% {transform:rotate(-2deg);}}
</style>
<script type="text/javascript">
$(function(){
	titleAnimation()
	$(".wd-head .spe-price").css({"opacity":"0"});
	$(".wd-head h2").css({"opacity":"0"});
	$(".wd-head .subcp").css({"opacity":"0"});
	$(".wd-head .btn-wd").css({"opacity":"0"});
	function titleAnimation() {
		$(".wd-head .spe-price").delay(100).animate({"opacity":"1"},900)
		$(".wd-head h2").delay(100).animate({"opacity":"1"},900)
		$(".wd-head .subcp").delay(500).animate({"opacity":"1"},1000)
		$(".wd-head .btn-wd").delay(600).animate({"opacity":"1"},800)
	}
});
</script>
<!-- 웨딩 기획전 (1 WEEK BIG SALE) -->
<div  class="evt80618 wedding-evt">
	<div class="wd-head">
		<p class="spe-price"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/txt_1week.png" alt="매주달라지는 특가" /></p>
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/tit_big_sale.png" alt="1WEEK BIG SALE" /></h2>
		<p class="subcp"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/txt_subcp.png" alt="혼수 · 집들이 선물 알뜰하게 마련하기!" /></p>
		<a href="/event/eventmain.asp?eventid=80615" class="btn-wd swing"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/bnr_go_wd.png" alt="신혼 하루 둘러보기" /></a>
	</div>

	<div class="prd-list">
		<% if date() < "2017-10-19" then %>
			<%' 1주차(1012~1018) %>
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/txt_date.png" alt="1주차 : 10.12~10.18" /></p>
			<div class="prds">
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/img_prd.jpg" alt="" usemap="#prd-map" />
				<map name="prd-map" id="prd-map">
					<area alt="컬러에디션 이동식 수납장 모음전" href="/shopping/category_prd.asp?itemid=1797558&pEtr=80618" shape="rect" coords="0,0,205,295" onfocus="this.blur();" />
					<area alt="Mini LED Clock 무아스 미니 LED 클락" href="/shopping/category_prd.asp?itemid=1557519&pEtr=80618" shape="rect" coords="246,0,451,295" onfocus="this.blur();" />
					<area alt="실리콘 냄비받침" href="/shopping/category_prd.asp?itemid=1715454&pEtr=80618" shape="rect" coords="505,0,710,295" onfocus="this.blur();" />
					<area alt="러셀홉스 올스텐 전기주전자" href="/shopping/category_prd.asp?itemid=1637438&pEtr=80618" shape="rect" coords="745,0,960,293" onfocus="this.blur();" />
					<area alt="심플블랙라인 호텔침구세트" href="/shopping/category_prd.asp?itemid=1784126&pEtr=80618" shape="rect" coords="0,365,215,658" onfocus="this.blur();" />
					<area alt="캔빌리지 원형수납장" href="/shopping/category_prd.asp?itemid=1260092&pEtr=80618" shape="rect" coords="245,366,460,659" onfocus="this.blur();" />
					<area alt="마켓비 RUSTA 장스탠드" href="/shopping/category_prd.asp?itemid=1729117&pEtr=80618" shape="rect" coords="498,369,713,662" onfocus="this.blur();" />
					<area alt="블루밍 브런치 2인세트" href="/shopping/category_prd.asp?itemid=1679197&pEtr=80618" shape="rect" coords="760,366,960,660" onfocus="this.blur();" />
					<area alt="2017년형 이메텍 전기요" href="/shopping/category_prd.asp?itemid=1562806&pEtr=80618" shape="rect" coords="0,741,219,1045" onfocus="this.blur();" />
					<area alt="런던의 오후 암막커튼 핑크베이지" href="/shopping/category_prd.asp?itemid=1207599&pEtr=80618" shape="rect" coords="234,735,476,1039" onfocus="this.blur();" />
					<area alt=" 노르딕원형테이블" href="/shopping/category_prd.asp?itemid=1566549&pEtr=80618" shape="rect" coords="504,734,712,1038" onfocus="this.blur();" />
					<area alt="NEW 숲속의 시간 디퓨저" href="/shopping/category_prd.asp?itemid=1662849&pEtr=80618" shape="rect" coords="742,735,960,1039" onfocus="this.blur();" />
					<area alt="모노데이ST 방수 식탁보" href="/shopping/category_prd.asp?itemid=1781978&pEtr=80618" shape="rect" coords="0,1109,202,1400" onfocus="this.blur();" />
					<area alt="[2017년신제품]다이슨 v6 코드프리 프로" href="/shopping/category_prd.asp?itemid=1757631&pEtr=80618" shape="rect" coords="247,1108,462,1400" onfocus="this.blur();" />
					<area alt="브리오신 집들이 선물세트" href="/shopping/category_prd.asp?itemid=1378730&pEtr=80618" shape="rect" coords="492,1113,714,1400" onfocus="this.blur();" />
					<area alt="씨익 LED 화장조명거울 무드 스탠드등" href="/shopping/category_prd.asp?itemid=1791841&pEtr=80618" shape="rect" coords="751,1111,960,1400" onfocus="this.blur();" />
				</map>
			</div>

		<% elseif date() >= "2017-10-19" and date() < "2017-10-26" then %>
			<%' 2주차(1019~1025) %>
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/txt_date_2.png" alt="2주차 : 10.19~10.25" /></p>
			<div class="prds">
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/img_prd_2_v2.jpg" alt="" usemap="#prd-map" />
				<map name="prd-map" id="prd-map">
					<area alt="클레어링 공기청정기 BF2025-GR" href="/shopping/category_prd.asp?itemid=1665813&pEtr=80618" shape="rect" coords="0,0,205,295" onfocus="this.blur();" />
					<area alt="무브 극세사 차렵침구" href="/shopping/category_prd.asp?itemid=1804962&pEtr=80618" shape="rect" coords="246,0,451,295" onfocus="this.blur();" />
					<area alt="프랑스브랜드 파벡스 온도계 전기주전자 커피포트" href="/shopping/category_prd.asp?itemid=1722666&pEtr=80618" shape="rect" coords="505,0,710,295" onfocus="this.blur();" />
					<area alt="제련공단 제련문고 철제 책장3단" href="/shopping/category_prd.asp?itemid=1787590&pEtr=80618" shape="rect" coords="745,0,960,293" onfocus="this.blur();" />
					<area alt="목화 윈터 디퓨저" href="/shopping/category_prd.asp?itemid=1603439&pEtr=80618" shape="rect" coords="0,365,215,658" onfocus="this.blur();" />
					<area alt="바이홈 세탁용품" href="/shopping/category_prd.asp?itemid=1731269&pEtr=80618" shape="rect" coords="245,366,460,659" onfocus="this.blur();" />
					<area alt="Rlovetea 사계절 롱티팟 1200ml" href="/shopping/category_prd.asp?itemid=1311289&pEtr=80618" shape="rect" coords="498,369,713,662" onfocus="this.blur();" />
					<area alt="스마트 LED 거울" href="/shopping/category_prd.asp?itemid=1755930&pEtr=80618" shape="rect" coords="760,366,960,660" onfocus="this.blur();" />
					<area alt="볼볼빈티지 멀티볼(파우더핑크)" href="/shopping/category_prd.asp?itemid=1783477&pEtr=80618" shape="rect" coords="0,741,219,1045" onfocus="this.blur();" />
					<area alt="마리데코 다용도 가방걸이 7칸" href="/shopping/category_prd.asp?itemid=1765328&pEtr=80618" shape="rect" coords="234,735,476,1039" onfocus="this.blur();" />
					<area alt="루나스퀘어 미니미(스마트폰 연동)" href="/shopping/category_prd.asp?itemid=1652378&pEtr=80618" shape="rect" coords="504,734,712,1038" onfocus="this.blur();" />
					<area alt="심플 무소음 벽시계" href="/shopping/category_prd.asp?itemid=1572520&pEtr=80618" shape="rect" coords="742,735,960,1039" onfocus="this.blur();" />
					<area alt="빈티지코튼 테이블냅킨" href="/shopping/category_prd.asp?itemid=1579690&pEtr=80618" shape="rect" coords="0,1109,202,1400" onfocus="this.blur();" />
					<area alt="러셀홉스 투슬라이스 토스터기" href="/shopping/category_prd.asp?itemid=1637881&pEtr=80618" shape="rect" coords="247,1108,462,1400" onfocus="this.blur();" />
					<area alt="드롱기 아이코나 커피머신" href="/shopping/category_prd.asp?itemid=1740531&pEtr=80618" shape="rect" coords="492,1113,714,1400" onfocus="this.blur();" />
					<area alt="모던드로잉 소프트 러그 베이지" href="/shopping/category_prd.asp?itemid=1771991&pEtr=80618" shape="rect" coords="751,1111,960,1400" onfocus="this.blur();" />
				</map>
			</div>

		<% elseif date() >= "2017-10-26" then %>
			<%' 3주차(1026~1101) %>
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/txt_date_3.png" alt="3주차 :10/23-11/1 " /></p>
			<div class="prds">
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/img_prd_3_v2.jpg" alt="" usemap="#prd-map" />
				<map name="prd-map" id="prd-map">
					<area alt="이불 속에 귤 까먹는 계절" href="/shopping/category_prd.asp?itemid=1562807&pEtr=80618" shape="rect" coords="0,0,205,295" onfocus="this.blur();" />
					<area alt="바켓속에 깔끔하게 저~장" href="/shopping/category_prd.asp?itemid=1696807&pEtr=80618" shape="rect" coords="246,0,451,295" onfocus="this.blur();" />
					<area alt="캔버스 판넬 카페 신혼집 인테리어 우주 문 액자 달 세트" href="/shopping/category_prd.asp?itemid=1184085&pEtr=80618" shape="rect" coords="505,0,710,295" onfocus="this.blur();" />
					<area alt="무드있는 분위기 맡겨만 주세요" href="/shopping/category_prd.asp?itemid=1400713&pEtr=80618" shape="rect" coords="745,0,960,293" onfocus="this.blur();" />
					<area alt="하나는 외로우니까 하나 더" href="/shopping/category_prd.asp?itemid=1782462&pEtr=80618" shape="rect" coords="0,365,215,658" onfocus="this.blur();" />
					<area alt="외출 전 매일 3초씩 " href="/shopping/category_prd.asp?itemid=1812399&pEtr=80618" shape="rect" coords="245,366,460,659" onfocus="this.blur();" />
					<area alt="너 하나 ♡ 나 하나" href="/shopping/category_prd.asp?itemid=1211213&pEtr=80618" shape="rect" coords="498,369,713,662" onfocus="this.blur();" />
					<area alt="겨울옷 모두 이곳에 쏙" href="/shopping/category_prd.asp?itemid=1608864&pEtr=80618" shape="rect" coords="760,366,960,660" onfocus="this.blur();" />
					<area alt="설레이던 첫 눈이 생각나요" href="/shopping/category_prd.asp?itemid=1783467&pEtr=80618" shape="rect" coords="0,741,219,1045" onfocus="this.blur();" />
					<area alt="찬란했던 찰나의 순간 담기" href="/shopping/category_prd.asp?itemid=256712&pEtr=80618" shape="rect" coords="234,735,476,1039" onfocus="this.blur();" />
					<area alt="따스함이 느껴지는 목화 한 다발" href="/shopping/category_prd.asp?itemid=1791637&pEtr=80618" shape="rect" coords="504,734,712,1038" onfocus="this.blur();" />
					<area alt="가을밤의무드를 책임지는 선향 " href="/shopping/category_prd.asp?itemid=1616744&pEtr=80618" shape="rect" coords="742,735,960,1039" onfocus="this.blur();" />
					<area alt="테이블에 빈티지 더하기" href="/shopping/category_prd.asp?itemid=1579689&pEtr=80618" shape="rect" coords="0,1109,202,1400" onfocus="this.blur();" />
					<area alt="따뜻한 한 잔으로 건네는 마음"href="/shopping/category_prd.asp?itemid=1613812&pEtr=80618" shape="rect" coords="247,1108,462,1400" onfocus="this.blur();" />
					<area alt="세탁물 보관도 깔끔하게" href="/shopping/category_prd.asp?itemid=1766272&pEtr=80618" shape="rect" coords="492,1113,714,1400" onfocus="this.blur();" />
					<area alt="식탁에 싱그러움을 얹히다" href="/shopping/category_prd.asp?itemid=1811784&pEtr=80618" shape="rect" coords="751,1111,960,1400" onfocus="this.blur();" />
				</map>
			</div>
		<% end if %>
	</div>

	<div class="special-brand">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/tit_brand.png" alt="이번주 특가 브랜드" /></h3>
		<% if date() < "2017-10-19" then %>
			<%' 1주차(1012~1018) %>
			<div class="brands">
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/img_brand.png" alt="" usemap="#brand-map" />
				<map name="brand-map" id="brand-map">
					<area  alt="monday house" href="#groupBar1" shape="rect" coords="0,0,281,174"  onfocus="this.blur();" />
					<area  alt="balmuda" href="#groupBar2" shape="rect" coords="287,0,567,174"  onfocus="this.blur();" />
					<area  alt="cocorico" href="#groupBar3" shape="rect" coords="573,0,853,174"  onfocus="this.blur();" />
					<area  alt="decoview" href="#groupBar4" shape="rect" coords="861,0,1140,174"  onfocus="this.blur();" />
				</map>
			</div>
		<% elseif date() >= "2017-10-19" and date() < "2017-10-26" then %>
			<%' 2주차(1019~1025) %>
			<div class="brands">
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/img_brand_2.png" alt="" usemap="#brand-map" />
				<map name="brand-map" id="ImageMapsCom-brand-map">
					<area  alt="CHALS FURNITURE" href="/street/street_brand_sub06.asp?makerid=chalsf1" shape="rect" coords="0,0,281,174"  onfocus="this.blur();" />
					<area  alt="DYSON" href="/street/street_brand_sub06.asp?makerid=gatevision" shape="rect" coords="287,0,567,174"  onfocus="this.blur();" />
					<area  alt="SSUEIM" href="/street/street_brand_sub06.asp?makerid=ssueim" shape="rect" coords="573,0,853,174"  onfocus="this.blur();" />
					<area  alt="LIMAS" href="/street/street_brand_sub06.asp?makerid=LIMAS" shape="rect" coords="861,0,1140,174"  onfocus="this.blur();" />
				</map>
			</div>
		<% elseif date() >= "2017-10-26" then %>
			<%' 3주차(1026~1101) %>
			<div class="brands">
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/80618/img_brand_3.png" alt="" usemap="#brand-map" />
				<map name="brand-map" id="ImageMapsCom-brand-map">
					<area alt="taccatacca " href="/street/street_brand_sub06.asp?makerid=taccatacca" shape="rect" coords="0,0,281,174"  onfocus="this.blur();" />
					<area alt="ionetech" href="/street/street_brand_sub06.asp?makerid=ionetech" shape="rect" coords="287,0,567,174"  onfocus="this.blur();" />
					<area alt="DAILYLIKE" href="/street/street_brand_sub06.asp?makerid=dailylike" shape="rect" coords="573,0,853,174"  onfocus="this.blur();" />
					<area alt="pandastick" href="/street/street_brand_sub06.asp?makerid=pandastick1" shape="rect" coords="861,0,1140,174"  onfocus="this.blur();" />
				</map>
			</div>
		<% end if %>
	</div>
</div>
<!--// 웨딩 기획전 (1 WEEK BIG SALE) -->
