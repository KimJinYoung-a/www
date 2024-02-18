<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<%
	Dim TargetDay	: TargetDay = getNumeric(requestCheckVar(Request.form("tgd"),2))		'요청 일짜
	Dim isSoldOut	: isSoldOut = requestCheckVar(Request.form("sold"),1)					'품절여부
	if isSoldOut="" then : isSoldOut="N"

	'// 기준 날짜 설정
	if TargetDay="" then TargetDay = cStr(day(date))
	if cint(TargetDay)>day(date) then TargetDay = cStr(day(date))
	if cint(TargetDay)<13 then TargetDay = "13"
	if cint(TargetDay)>24 then TargetDay = "24"
%>
	<!-- 날짜별 상품 -->
	<div class="brandbox">
	<% if isSoldOut="Y" then %>
		<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/tit_soldout_brand.png" alt="ON SOLD OUT" /></h4>
	<% else %>
		<% if cint(TargetDay)=day(date) then %>
		<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/tit_today_brand.png" alt="TODAY&apos;S BRAND" /></h4>
		<% else %>
		<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/tit_on_sale_brand.png" alt="ON SALE" /></h4>
		<% end if %>
	<% end if %>
	<% Select Case TargetDay %>
		<%	Case "13" %>
		<div class="item1">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_brand_01_01.png" alt="ROOM, ET" usemap="#allview1" />
			<map name="allview1" id="allview1">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=roomet2010" alt="ROOM, ET 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_brand_01_02.png" alt="75,000원 &rarr; 31,900원 60%" usemap="#itemlink1" />
			<map name="itemlink1" id="itemlink1">
				<area shape="circle" coords="218,193,130" href="/shopping/category_prd.asp?itemid=324873" alt="상큼한 런던 스툴" />
				<area shape="circle" coords="538,192,131" href="/shopping/category_prd.asp?itemid=1112585" alt="엘바 좌식 테이블" />
				<area shape="circle" coords="857,191,130" href="/shopping/category_prd.asp?itemid=1234356" alt="메이 원목 벽시계 꿀맛 사은품" />
			</map>
		</div>
		<%	Case "14" %>
		<div class="item2">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_brand_02_01.png" alt="iriver" usemap="#allview2" />
			<map name="allview2" id="allview2">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=iriver01" alt="iriver 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_brand_02_02.png" alt="51,200원 &rarr; 30,900원 40%" usemap="#itemlink2" />
			<map name="itemlink2" id="itemlink2">
				<area shape="circle" coords="353,192,132" href="/shopping/category_prd.asp?itemid=1091239" alt="블루투스 스피커" />
				<area shape="circle" coords="714,192,131" href="/shopping/category_prd.asp?itemid=965008" alt="이어폰" />
				<area shape="circle" coords="252,631,110" href="/shopping/category_prd.asp?itemid=596727" alt="스마트펜 꿀맛 사은품" />
				<area shape="circle" coords="533,630,109" href="/shopping/category_prd.asp?itemid=898771" alt="보조 배터리 꿀맛 사은품" />
				<!--area shape="circle" coords="813,629,109" href="/shopping/category_prd.asp?itemid=898771" alt="칫솔 살균기 꿀맛 사은품" /-->
			</map>
		</div>
		<%	Case "15" %>
		<div class="item3">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_brand_03_01.png" alt="SNURK" usemap="#allview3" />
			<map name="allview3" id="allview3">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=snurk" alt="SNURK 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_brand_03_02.png" alt="143,000원 &rarr; 49,900원 65%" usemap="#itemlink3" />
			<map name="itemlink3" id="itemlink3">
				<area shape="circle" coords="323,213,151" href="/shopping/category_prd.asp?itemid=920191" alt="Astronaut Single" />
				<area shape="circle" coords="743,212,150" href="/shopping/category_prd.asp?itemid=1222026" alt="Twirre Printed Bag 깜작 선물! 100분 랜덤 선물!" />
			</map>
		</div>
		<%	Case "16" %>
		<div class="item4">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_coleman_01.png" alt="COLEMAN" usemap="#allview4" />
			<map name="allview4" id="allview4">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=colemanshop" alt="COLEMAN 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_coleman_02.png" alt="56,170원 &rarr; 49,900원 11%" usemap="#itemlink4" />
			<map name="itemlink4" id="itemlink4">
				<area shape="circle" coords="213,263,91" href="/shopping/category_prd.asp?itemid=1231836" alt="펀 체어 싱글/페스웨이브" />
				<area shape="circle" coords="213,541,90" href="/shopping/category_prd.asp?itemid=1231838" alt="암 체어 그린" />
				<area shape="circle" coords="212,822,91" href="/shopping/category_prd.asp?itemid=1239134" alt="펀체어 더블폴리지 블루" />
				<area shape="circle" coords="212,1101,90" href="/shopping/category_prd.asp?itemid=1239133" alt="펀체어 더블폴리지 핑크" />
				<area shape="circle" coords="533,261,91" href="/shopping/category_prd.asp?itemid=1231941" alt="팝업 박스" />
				<area shape="circle" coords="532,541,90" href="/shopping/category_prd.asp?itemid=1231950" alt="행잉 체인" />
				<area shape="circle" coords="534,823,90" href="/shopping/category_prd.asp?itemid=1231291" alt="런치 쿨러 5L" />
				<area shape="circle" coords="534,1102,91" href="/shopping/category_prd.asp?itemid=1231987" alt="쁘띠 레저 시트" />
				<area shape="circle" coords="853,262,90" href="/shopping/category_prd.asp?itemid=1237072" alt="꿀맛 사은품 4가지 상품 중 랜덤 발송 마이 캠프 랜턴" />
				<area shape="circle" coords="854,541,90" href="/shopping/category_prd.asp?itemid=1243486" alt="꿀맛 사은품 4가지 상품 중 랜덤 발송 LED 스트링 라이트" />
				<area shape="circle" coords="853,823,90" href="/shopping/category_prd.asp?itemid=1243489" alt="꿀맛 사은품 4가지 상품 중 랜덤 발송 가랜드 스트링 라이트 핑" />
				<area shape="circle" coords="854,1102,91" href="/shopping/category_prd.asp?itemid=1243490" alt="꿀맛 사은품 4가지 상품 중 랜덤 발송 가랜드 스트링 라이트 블루" />
			</map>
		</div>
		<%	Case "17" %>
		<div class="item5">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_bomann_01.png" alt="BOMANN" usemap="#allview5" />
			<map name="allview5" id="allview5">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=imir72" alt="BOMANN 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_bomann_02.png" alt="59,000원 &rarr; 29,900원 70%" usemap="#itemlink5" />
			<map name="itemlink5" id="itemlink5">
				<area shape="circle" coords="324,212,150" href="/shopping/category_prd.asp?itemid=1007309" alt="스테인레스 무선주전자 커피포트" />
				<area shape="circle" coords="743,212,149" href="/shopping/category_prd.asp?itemid=1127320" alt="토스터기" />
			</map>
		</div>
		<%	Case "18" %>
		<div class="item6">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_fashionbox_01.png" alt="FASHIONBOX" />
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_fashionbox_02.png" alt="82,300원 &rarr; 29,900원 64%" usemap="#itemlink6" />
			<map name="itemlink6" id="itemlink6">
				<area shape="circle" coords="224,212,121" href="/shopping/category_prd.asp?itemid=1215158" alt="u.t pigment eco bag" />
				<area shape="circle" coords="533,211,120" href="/street/street_brand_sub06.asp?rect=&prvtxt=&rstxt=&extxt=&sflag=n&dispCate=&cpg=1&chkr=False&chke=False&makerid=modernday&sscp=N&psz=35&srm=be&iccd=&styleCd=&attribCd=&icoSize=M&arrCate=116102&deliType=&minPrc=&maxPrc=&lstDiv=brand&slidecode=5&shopview=1" alt="라비에벨파우치 M" />
				<area shape="circle" coords="843,211,119" href="/street/street_brand_sub06.asp?rect=&prvtxt=&rstxt=&extxt=&sflag=n&dispCate=&cpg=1&chkr=False&chke=False&makerid=modernday&sscp=N&psz=35&srm=be&iccd=&styleCd=&attribCd=&icoSize=M&arrCate=116102&deliType=&minPrc=&maxPrc=&lstDiv=brand&slidecode=5&shopview=1" alt="라비에벨파우치 S" />
				<area shape="circle" coords="405,579,120" href="/street/street_brand_sub06.asp?makerid=moree01" alt="모리 실팔찌" />
				<area shape="circle" coords="713,579,120" href="/shopping/category_prd.asp?itemid=1239583" alt="20분 랜덤 증정 MARC BY MARC JACOBS MBM1316 베이커 (203866)" />
			</map>
		</div>
		<%	Case "19" %>
		<div class="item7">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_instax_01.png" alt="INSTAX" usemap="#allview7" />
			<map name="allview7" id="allview7">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=instax" alt="INSTAX 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_instax_02.png" alt="12가지 상품 중 랜덤으로 발송 148,600원 &rarr; 49,900원 66%" usemap="#itemlink7" />
			<map name="itemlink7" id="itemlink7">
				<area shape="circle" coords="213,188,91" href="/shopping/category_prd.asp?itemid=1039511" alt="와이파이 프린터" />
				<area shape="circle" coords="423,189,91" href="/shopping/category_prd.asp?itemid=1206145" alt="미니 헬로키티 SET" />
				<area shape="circle" coords="633,189,91" href="/shopping/category_prd.asp?itemid=822736" alt="인스탁스 mini25 Cath kidston Pink" />
				<area shape="circle" coords="841,188,90" href="/shopping/category_prd.asp?itemid=822728" alt="인스탁스 mini25 Cath kidston Mint" />
				<area shape="circle" coords="212,467,90" href="/shopping/category_prd.asp?itemid=610087" alt="인스탁스 리락쿠마 패키지" />
				<area shape="circle" coords="423,469,91" href="/shopping/category_prd.asp?itemid=1206210" alt="mini 8 윈터 패키지" />
				<area shape="circle" coords="634,468,90" href="/shopping/category_prd.asp?itemid=1118570" alt="인스탁스 미니 8 키키라라" />
				<area shape="circle" coords="844,467,91" href="/shopping/category_prd.asp?itemid=1118571" alt="인스탁스 미니 8 푸우" />
				<area shape="circle" coords="212,748,89" href="/shopping/category_prd.asp?itemid=770217" alt="인스탁스 미니 8 라즈베리" />
				<area shape="circle" coords="422,748,90" href="/shopping/category_prd.asp?itemid=770217" alt="인스탁스 미니 8 그레이프" />
				<area shape="circle" coords="634,748,90" href="/shopping/category_prd.asp?itemid=742565" alt="인스탁스 미니 25 핑크" />
				<area shape="circle" coords="842,747,90" href="/shopping/category_prd.asp?itemid=742565" alt="인스탁스 미니 25 블루" />
			</map>
		</div>
		<%	Case "20" %>
		<div class="item8">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_playmobil_01.png" alt="Playmobil" usemap="#allview8" />
			<map name="allview8" id="allview8">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=Playmobil" alt="Playmobil 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_playmobil_02.png" alt="40가지 상품 중 7가지를 랜덤으로 발송 40,000원 &rarr; 19,900원 50%" usemap="#itemlink8" />
			<map name="itemlink8" id="itemlink8">
				<area shape="circle" coords="273,237,109" href="/shopping/category_prd.asp?itemid=1234865" alt="송아지와 농장아가씨" />
				<area shape="circle" coords="533,237,111" href="/shopping/category_prd.asp?itemid=1234860" alt="엄마와 아이들" />
				<area shape="circle" coords="794,238,111" href="/shopping/category_prd.asp?itemid=1234859" alt="해적과 보물상자" />
				<area shape="circle" coords="271,557,110" href="/shopping/category_prd.asp?itemid=1234853" alt="연주하는 피에로" />
				<area shape="circle" coords="531,557,111" href="/shopping/category_prd.asp?itemid=1234861" alt="공주와 마네킨" />
				<area shape="circle" coords="794,557,109" href="/shopping/category_prd.asp?itemid=1234855" alt="소녀와 염소" />
				<area shape="circle" coords="273,877,109" href="/shopping/category_prd.asp?itemid=1041892" alt="천사와 악마" />
				<area shape="circle" coords="533,876,110" href="/shopping/category_prd.asp?itemid=927334" alt="건축가와 모형" />
				<area shape="circle" coords="794,878,109" href="/shopping/category_prd.asp?itemid=1041889" alt="늑대와 사냥꾼" />
			</map>
		</div>
		<%	Case "21" %>
		<div class="item9">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_mybeans_01.png" alt="마이빈스" usemap="#allview9" />
			<map name="allview9" id="allview9">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=mybeans10" alt="마이빈스 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_mybeans_02.png" alt="18,000원 &rarr; 9,900원 45%" usemap="#itemlink9" />
			<map name="itemlink9" id="itemlink9">
				<area shape="circle" coords="233,251,110" href="/shopping/category_prd.asp?itemid=995520" alt="마이빈스 더치커피 500ml 와인병" />
				<area shape="circle" coords="527,252,110" href="/shopping/category_prd.asp?itemid=995513" alt="마이빈스 더치커피 500ml 보르미올리병" />
				<area shape="circle" coords="853,252,111" href="/shopping/category_prd.asp?itemid=1171539" alt="꿀맛 사은품 써모머그 엄브렐러 보틀" />
			</map>
		</div>
		<%	Case "22" %>
		<div class="item10">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_lamy_01.png" alt="LAMY" usemap="#allview10" />
			<map name="allview10" id="allview10">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=lamy2" alt="LAMY 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_lamy_02.png" alt="Lamy Safari Special edition 2015 네온 라임 만년필과 꿀맛 사은품 Lamy 잉크카트리지 54,000원 &rarr; 43,740원 19%" usemap="#itemlink10" />
			<!--map name="itemlink10" id="itemlink10">
				<area shape="circle" coords="325,213,151" href="/shopping/category_prd.asp?itemid=1251730" alt="Lamy Safari Special edition 2015 네온 라임 만년필" />
				<area shape="circle" coords="743,213,151" href="/shopping/category_prd.asp?itemid=295222" alt="꿀맛 사은품 Lamy 잉크카트리지" />
			</map-->
		</div>
		<%	Case "23" %>
		<div class="item11">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_method_01.png" alt="METHOD" usemap="#allview11" />
			<map name="allview11" id="allview11">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=dhlrodls" alt="METHOD 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_method_02.png" alt="27,700원 &rarr; 12,900원 53%" usemap="#itemlink11" />
			<map name="itemlink11" id="itemlink11">
				<!--area shape="circle" coords="162,152,91" href="/shopping/category_prd.asp?itemid=" alt="주방세제 안티박클리너" /-->
				<area shape="circle" coords="411,152,90" href="/shopping/category_prd.asp?itemid=1084108" alt="욕실용 세정제" />
				<!--area shape="circle" coords="657,152,91" href="/shopping/category_prd.asp?itemid=" alt="주방세제 파워디쉬폼 레몬민트" /-->
				<area shape="circle" coords="903,152,90" href="/shopping/category_prd.asp?itemid=1084728" alt="꿀맛 사은품 핸드워시 후레쉬커런트" />
			</map>
		</div>
		<%	Case "24" %>
		<div class="item12">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_iconic_01.png" alt="ICONIC" usemap="#allview12" />
			<map name="allview12" id="allview12">
				<area shape="rect" coords="929,53,1025,76" href="/street/street_brand_sub06.asp?makerid=iconic" alt="ICONIC 전상품 보기" />
			</map>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/img_iconic_02.png" alt="11가지 상품 중 6가지를 랜덤으로 발송 40,000원 &rarr; 19,900원 50%" usemap="#itemlink12" />
			<map name="itemlink12" id="itemlink12">
				<area shape="circle" coords="213,206,91" href="/shopping/category_prd.asp?itemid=1220259" alt="투웨이 파스텔펜" />
				<area shape="circle" coords="423,208,91" href="/shopping/category_prd.asp?itemid=897948" alt="투웨이 데코펜" />
				<area shape="circle" coords="634,208,91" href="/shopping/category_prd.asp?itemid=699617" alt="컬러 트윈펜" />
				<area shape="circle" coords="843,207,91" href="/shopping/category_prd.asp?itemid=521683" alt="북마크세트" />
				<area shape="circle" coords="213,486,91" href="/shopping/category_prd.asp?itemid=882296" alt="에브리데이 행키" />
				<area shape="circle" coords="423,487,91" href="/shopping/category_prd.asp?itemid=1053770" alt="에브리데이 행키 v.2" />
				<area shape="circle" coords="631,487,91" href="/shopping/category_prd.asp?itemid=860504" alt="스윙 카드포켓" />
				<area shape="circle" coords="843,485,91" href="/shopping/category_prd.asp?itemid=860503" alt="크로스 넥스트랩" />
				<area shape="circle" coords="322,768,91" href="/shopping/category_prd.asp?itemid=484618" alt="슬림 포켓 v.2" />
				<area shape="circle" coords="533,767,90" href="/shopping/category_prd.asp?itemid=500681" alt="레트로 뱃지" />
				<area shape="circle" coords="743,766,90" href="/shopping/category_prd.asp?itemid=776819" alt="클래식 빗거울" />
			</map>
		</div>
	<% End Select %>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60832/txt_get_only_app.png" alt="본 상품은 텐바이텐 APP에서만 구매하실 수 있습니다. 한정수량이므로 조기에 소진될 수 있으니, 서둘러 주세요! " /></p>
	</div>
