<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim currentdate
	currentdate = date()
%>
<style type="text/css">
.hidden {visibility:hidden; width:0; height:0;}
</style>
</head>
<body>
<h1 class="hidden">크리스마스 일주일 단독 특가</h1>
<div class="itemList">
	<!-- 1주차 -->
	<% If currentdate <= "2016-11-27" Then %>
	<div class="item01">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74314/img_item_01_01.png" alt="텐바이텐 크리스마스 단독 에디션 상품" usemap="#itemlink01" /></p>
		<map name="itemlink01" id="itemlink01">
			<area shape="rect" coords="109,221,550,577" href="/shopping/category_prd.asp?itemid=1601929&Etr=74313" target="_top" alt="메모리 래인 캔들워머 크리스마스 에디션" />
			<area shape="rect" coords="590,220,1033,575" href="/shopping/category_prd.asp?itemid=1601916&Etr=74313" target="_top" alt="크리스마스 스노우볼 캔들" />
			<area shape="rect" coords="138,631,389,953" href="/shopping/category_prd.asp?itemid=1603439&Etr=74313" target="_top" alt="목화 윈터 디퓨저" />
			<area shape="rect" coords="447,630,696,944" href="/shopping/category_prd.asp?itemid=1603555&Etr=74313" target="_top" alt="크리스마스 월트리 데코 세트" />
			<area shape="rect" coords="754,630,1001,945" href="/shopping/category_prd.asp?itemid=1395718&Etr=74313" target="_top" alt="윈터 원더랜드 세트" />
		</map>
	</div>

	<div class="item02">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74314/img_item_01_02.png" alt="크리스마스 일주일 단독 특가 2016년 11월 21일부터 27일까지" usemap="#itemlink02" /></p>
		<map name="itemlink02" id="itemlink02">
			<area shape="rect" coords="28,118,223,393" href="/shopping/category_prd.asp?itemid=1603771&Etr=74313" target="_top" alt="북유럽 패턴 스칸디나비아 박스트리 Set" />
			<area shape="rect" coords="250,119,446,397" href="/shopping/category_prd.asp?itemid=1602488&Etr=74313" target="_top" alt="크리스마스 프레임 트리와 오너먼트 Set" />
			<area shape="rect" coords="473,116,672,396" href="/shopping/category_prd.asp?itemid=1596196&Etr=74313" target="_top" alt="샤인 스타 화이트트리 테이블 조명" />
			<area shape="rect" coords="693,116,892,394" href="/shopping/category_prd.asp?itemid=1594249&Etr=74313" target="_top" alt="코타쥬 캔들홀더" />
			<area shape="rect" coords="915,117,1112,392" href="/shopping/category_prd.asp?itemid=1404956&Etr=74313" target="_top" alt="램플로우 스노우" />
			<area shape="rect" coords="27,433,221,709" href="/shopping/category_prd.asp?itemid=1603329&Etr=74313" target="_top" alt="샤인 골드 조명 리스" />
			<area shape="rect" coords="251,431,444,713" href="/shopping/category_prd.asp?itemid=1599655&Etr=74313" target="_top" alt="크리스마스 오너먼트 가란드" />
			<area shape="rect" coords="476,432,671,712" href="/shopping/category_prd.asp?itemid=1588766&Etr=74313" target="_top" alt="패브릭 행잉 크리스마스 트리 패브릭 포스터" />
			<area shape="rect" coords="695,434,890,704" href="/shopping/category_prd.asp?itemid=1382914&Etr=74313" target="_top" alt="포근포근 양털 스탠딩장식" />
			<area shape="rect" coords="916,434,1115,706" href="/shopping/category_prd.asp?itemid=971895&Etr=74313" target="_top" alt="눈꽃 보티브 소이캔들" />
		</map>
	</div>

	<!-- 2주차 -->
	<% ElseIf currentdate >= "2016-11-28" AND currentdate <= "2016-12-04" Then %>
	<div class="item01">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74314/img_item_01_01.png" alt="텐바이텐 크리스마스 단독 에디션 상품" usemap="#itemlink01" /></p>
		<map name="itemlink01" id="itemlink01">
			<area shape="rect" coords="109,221,550,577" href="/shopping/category_prd.asp?itemid=1601929&Etr=74313" target="_top" alt="메모리 래인 캔들워머 크리스마스 에디션" />
			<area shape="rect" coords="590,220,1033,575" href="/shopping/category_prd.asp?itemid=1601916&Etr=74313" target="_top" alt="크리스마스 스노우볼 캔들" />
			<area shape="rect" coords="138,631,389,953" href="/shopping/category_prd.asp?itemid=1603439&Etr=74313" target="_top" alt="목화 윈터 디퓨저" />
			<area shape="rect" coords="447,630,696,944" href="/shopping/category_prd.asp?itemid=1603555&Etr=74313" target="_top" alt="크리스마스 월트리 데코 세트" />
			<area shape="rect" coords="754,630,1001,945" href="/shopping/category_prd.asp?itemid=1395718&Etr=74313" target="_top" alt="윈터 원더랜드 세트" />
		</map>
	</div>

	<div class="item02">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74314/img_item_02_02.png" alt="크리스마스 일주일 단독 특가 2016년 11월 28일부터 12월 4일까지" usemap="#itemlink02" /></p>
		<map name="itemlink02" id="itemlink02">
			<area shape="rect" coords="28,118,223,393" href="/shopping/category_prd.asp?itemid=1590287&Etr=74313" target="_top" alt="안개 &amp; 목화 투플레이스 전구SET" />
			<area shape="rect" coords="250,119,446,397" href="/shopping/category_prd.asp?itemid=1606934&Etr=74313" target="_top" alt="스윗 핑크장식 스노우 디자인 트리 SET" />
			<area shape="rect" coords="473,116,672,396" href="/shopping/category_prd.asp?itemid=1375250&Etr=74313" target="_top" alt="블루밍앤미 파스텔 울 트리" />
			<area shape="rect" coords="693,116,892,394" href="/shopping/category_prd.asp?itemid=1380085&Etr=74313" target="_top" alt="사슴 웜 무드 램프 + 수은전지용 배터리" />
			<area shape="rect" coords="915,117,1112,392" href="/shopping/category_prd.asp?itemid=1609514&Etr=74313" target="_top" alt="블루밍앤미 코튼볼 무드 조명" />
			<area shape="rect" coords="27,433,221,709" href="/shopping/category_prd.asp?itemid=1359347&Etr=74313" target="_top" alt="Cotton Flower 글라스 돔 세트" />
			<area shape="rect" coords="251,431,444,713" href="/shopping/category_prd.asp?itemid=1042797&Etr=74313" target="_top" alt="Hand made 호두까기 스코틀랜드 군악병 30cm" />
			<area shape="rect" coords="476,432,671,712" href="/shopping/category_prd.asp?itemid=1604626&Etr=74313" target="_top" alt="코튼볼 라이트 월트리" />
			<area shape="rect" coords="695,434,890,704" href="/shopping/category_prd.asp?itemid=1601874&Etr=74313" target="_top" alt="우드랜드 돌 스노우돔" />
			<area shape="rect" coords="916,434,1115,706" href="/shopping/category_prd.asp?itemid=1166354&Etr=74313" target="_top" alt="크리스마스장식 입체트리 우드 오르골" />
		</map>
	</div>

	<!-- 3주차 -->
	<% ElseIf currentdate >= "2016-12-05" AND currentdate <= "2016-12-11" Then %>
	<div class="item01">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74314/img_item_01_01_v1.png" alt="텐바이텐 크리스마스 단독 에디션 상품" usemap="#itemlink01" /></p>
		<map name="itemlink01" id="itemlink01">
			<area shape="rect" coords="109,221,550,577" href="/shopping/category_prd.asp?itemid=1601929&Etr=74313" target="_top" alt="메모리 래인 캔들워머 크리스마스 에디션" />
			<area shape="rect" coords="590,220,1033,575" href="/shopping/category_prd.asp?itemid=1601916&Etr=74313" target="_top" alt="크리스마스 스노우볼 캔들" />
			<area shape="rect" coords="138,631,389,953" href="/shopping/category_prd.asp?itemid=1603439&Etr=74313" target="_top" alt="목화 윈터 디퓨저" />
			<area shape="rect" coords="447,630,696,944" href="/shopping/category_prd.asp?itemid=1603555&Etr=74313" target="_top" alt="크리스마스 월트리 데코 세트" />
			<area shape="rect" coords="754,630,1001,945" href="/shopping/category_prd.asp?itemid=1395718&Etr=74313" target="_top" alt="윈터 원더랜드 세트" />
		</map>
	</div>

	<div class="item02">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74314/img_item_02_03_v1.png" alt="크리스마스 일주일 단독 특가 2016년 12월 5일부터 12월 11일까지" usemap="#itemlink02" /></p>
		<map name="itemlink02" id="itemlink02">
			<area shape="rect" coords="28,118,223,393" href="/shopping/category_prd.asp?itemid=1607711&Etr=74313" target="_top" alt="양모 펠트 테이블 트리" />
			<area shape="rect" coords="250,119,446,397" href="/shopping/category_prd.asp?itemid=1588651&Etr=74313" target="_top" alt="윈터 빈티지 솔방울 리스 소" />
			<area shape="rect" coords="473,116,672,396" href="/shopping/category_prd.asp?itemid=1391693&Etr=74313" target="_top" alt="윈터 핑크 울 볼 리스" />
			<area shape="rect" coords="693,116,892,394" href="/shopping/category_prd.asp?itemid=1611752&Etr=74313" target="_top" alt="코튼볼 전구 앤 스노우 디자인 트리 Set" />
			<area shape="rect" coords="915,117,1112,392" href="/shopping/category_prd.asp?itemid=1600157&Etr=74313" target="_top" alt="나뭇가지와 패브릭트리" />
			<area shape="rect" coords="27,433,221,709" href="/shopping/category_prd.asp?itemid=1398726&Etr=74313" target="_top" alt="Nordic Camp 노르딕캠프 소이캔들" />
			<area shape="rect" coords="251,431,444,713" href="/shopping/category_prd.asp?itemid=1133659&Etr=74313" target="_top" alt="WOOD LIGHT DECO SHADOW TOWN" />
			<area shape="rect" coords="476,432,671,712" href="/shopping/category_prd.asp?itemid=1609319&Etr=74313" target="_top" alt="트리 LED 조명 화이트" />
			<area shape="rect" coords="695,434,890,704" href="/shopping/category_prd.asp?itemid=1160627&Etr=74313" target="_top" alt="크리스마스에 눈이 내리면 조명" />
			<area shape="rect" coords="916,434,1115,706" href="/shopping/category_prd.asp?itemid=1612590&Etr=74313" target="_top" alt="위시 크리스마스 브랜치월트리" />
		</map>
	</div>

	<!-- 4주차 -->
	<% ElseIf currentdate >= "2016-12-12" AND currentdate <= "2016-12-18" Then %>
	<div class="item01">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74314/img_item_01_01_v2.png" alt="텐바이텐 크리스마스 단독 에디션 상품" usemap="#itemlink01" /></p>
		<map name="itemlink01" id="itemlink01">
			<area shape="rect" coords="109,221,550,577" href="/shopping/category_prd.asp?itemid=1601929&Etr=74313" target="_top" alt="메모리 래인 캔들워머 크리스마스 에디션" />
			<area shape="rect" coords="590,220,1033,575" href="/shopping/category_prd.asp?itemid=1601916&Etr=74313" target="_top" alt="크리스마스 스노우볼 캔들" />
			<area shape="rect" coords="138,631,389,953" href="/shopping/category_prd.asp?itemid=1603439&Etr=74313" target="_top" alt="목화 윈터 디퓨저" />
			<area shape="rect" coords="447,630,696,944" href="/shopping/category_prd.asp?itemid=1603555&Etr=74313" target="_top" alt="크리스마스 월트리 데코 세트" />
			<area shape="rect" coords="754,630,1001,945" href="/shopping/category_prd.asp?itemid=1395718&Etr=74313" target="_top" alt="윈터 원더랜드 세트" />
		</map>
	</div>

	<div class="item02">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74314/img_item_02_04.png" alt="크리스마스 일주일 단독 특가 2016년 12월 12일부터 12월 18일까지" usemap="#itemlink02" /></p>
		<map name="itemlink02" id="itemlink02">
			<area shape="rect" coords="28,118,223,393" href="/shopping/category_prd.asp?itemid=1613921&Etr=74313" target="_top" alt="화이트 크리스마스 그린 디자인트리 set 60cm" />
			<area shape="rect" coords="250,119,446,397" href="/shopping/category_prd.asp?itemid=1613922&Etr=74313" target="_top" alt="화이트 크리스마스 그린 디자인트리 set 90cm" />
			<area shape="rect" coords="473,116,672,396" href="/shopping/category_prd.asp?itemid=1611751&Etr=74313" target="_top" alt="튼볼 전구 앤 스노우 디자인 트리 set 60cm" />
			<area shape="rect" coords="693,116,892,394" href="/shopping/category_prd.asp?itemid=1603329&Etr=74313" target="_top" alt="샤인 골드 조명 리스" />
			<area shape="rect" coords="915,117,1112,392" href="/shopping/category_prd.asp?itemid=1596195&Etr=74313" target="_top" alt="화이트 트리 테이블 앤 오너먼트 조명" />
			<area shape="rect" coords="27,433,221,709" href="/shopping/category_prd.asp?itemid=1154076&Etr=74313" target="_top" alt="윈터 테이블 오너먼트" />
			<area shape="rect" coords="251,431,444,713" href="/shopping/category_prd.asp?itemid=1583965&Etr=74313" target="_top" alt="DIY 종이소품 크리스마스 메세지 천사들" />
			<area shape="rect" coords="476,432,671,712" href="/shopping/category_prd.asp?itemid=1402726&Etr=74313" target="_top" alt="산타 루돌프 라이트 가랜드" />
			<area shape="rect" coords="695,434,890,704" href="/shopping/category_prd.asp?itemid=1387543&Etr=74313" target="_top" alt="북유럽 브론즈골드 유리병" />
			<area shape="rect" coords="916,434,1115,706" href="/shopping/category_prd.asp?itemid=1607187&Etr=74313" target="_top" alt="프렌치 트리 130" />
		</map>
	</div>

	<!-- 5주차 -->
	<% ElseIf currentdate >= "2016-12-19" Then %>
	<div class="item01">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74314/img_item_01_01_v2.png" alt="텐바이텐 크리스마스 단독 에디션 상품" usemap="#itemlink01" /></p>
		<map name="itemlink01" id="itemlink01">
			<area shape="rect" coords="109,221,550,577" href="/shopping/category_prd.asp?itemid=1601929&Etr=74313" target="_top" alt="메모리 래인 캔들워머 크리스마스 에디션" />
			<area shape="rect" coords="590,220,1033,575" href="/shopping/category_prd.asp?itemid=1601916&Etr=74313" target="_top" alt="크리스마스 스노우볼 캔들" />
			<area shape="rect" coords="138,631,389,953" href="/shopping/category_prd.asp?itemid=1603439&Etr=74313" target="_top" alt="목화 윈터 디퓨저" />
			<area shape="rect" coords="447,630,696,944" href="/shopping/category_prd.asp?itemid=1603555&Etr=74313" target="_top" alt="크리스마스 월트리 데코 세트" />
			<area shape="rect" coords="754,630,1001,945" href="/shopping/category_prd.asp?itemid=1395718&Etr=74313" target="_top" alt="윈터 원더랜드 세트" />
		</map>
	</div>

	<div class="item02">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74314/img_item_02_05.png" alt="크리스마스 일주일 단독 특가 2016년 12월 19일부터 12월 25일까지" usemap="#itemlink02" /></p>
		<map name="itemlink02" id="itemlink02">
			<area shape="rect" coords="28,118,223,393" href="/shopping/category_prd.asp?itemid=1611750&Etr=74313" target="_top" alt="코튼볼 전구 앤 스노우 디자인 트리 Set 150cm" />
			<area shape="rect" coords="250,119,446,397" href="/shopping/category_prd.asp?itemid=1609514&Etr=74313" target="_top" alt="코튼볼 무드 조명 20구" />
			<area shape="rect" coords="473,116,672,396" href="/shopping/category_prd.asp?itemid=1590287&Etr=74313" target="_top" alt="안개 앤 목화 투플레이스 전구 Set" />
			<area shape="rect" coords="693,116,892,394" href="/shopping/category_prd.asp?itemid=1278817&Etr=74313" target="_top" alt="눈꽃 전구 건전지용" />
			<area shape="rect" coords="915,117,1112,392" href="/shopping/category_prd.asp?itemid=1623326&Etr=74313" target="_top" alt="목화 스윗 윈터 조명 리스" />
			<area shape="rect" coords="27,433,221,709" href="/shopping/category_prd.asp?itemid=1403621&Etr=74313" target="_top" alt=" 눈꽃 라이트 월트리세트 전구포함" />
			<area shape="rect" coords="251,431,444,713" href="/shopping/category_prd.asp?itemid=1615185&Etr=74313" target="_top" alt="반디 유리돔 USB LED 전구 무드등" />
			<area shape="rect" coords="476,432,671,712" href="/shopping/category_prd.asp?itemid=1588766&Etr=74313" target="_top" alt="패브릭 행잉 크리스마스 트리" />
			<area shape="rect" coords="695,434,890,704" href="/shopping/category_prd.asp?itemid=770308&Etr=74313" target="_top" alt="X-MAS특집 Christmas Moonlight 야광달빛스티커" />
			<area shape="rect" coords="916,434,1115,706" href="/shopping/category_prd.asp?itemid=1308640&Etr=74313" target="_top" alt="기상예측 유리병 Tempo drop" />
		</map>
	</div>
	<% End If %>
</div>
</body>
</html>