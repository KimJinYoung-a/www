<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2019 다꾸페이지
' History : 2018-10-31 원승현 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2019/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2019/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/diarystory2019/daccu.asp"
			REsponse.End
		end if
	end if
end if

%>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(function(){
	// amplitude init
	fnAmplitudeEventMultiPropertiesAction('view_diary_daccu','','');
});
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2019">
		<div id="contentWrap" class="daccu">
			<!-- #include virtual="/diarystory2019/inc/head.asp" -->
			<div class="diary-content">
				<!-- 가장 최근 section에만 new 를 붙여주세요 (개발X) -->
				<!-- vol22 (96769) -->
				<div class="section typeB new">
					<div class="info">
						<h3>나키’s 감성 가득 다꾸<i></i></h3>
						<p>빈티지 아이템을 활용해 감성적인 다꾸를 즐겨보자! </p>
						<a href="/shopping/category_prd.asp?itemid=2328829" class="repesent-item" style="top:192px; left:-90px;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_item_0.png" alt="Plain note 103 : grid note"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=1027391"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_item_1.png" alt="타자체 알파벳 소문자 세트"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1148996"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_item_2.png" alt="Vintage Book Pages"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2257070"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_item_3.png" alt="SPLICE STAMP BSS-001002"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1643953"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_item_4.png" alt="촉촉한 pigment inkpad - Fog"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=96769" class="vod-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol21 (95898) -->
				<div class="section typeA">
					<div class="info">
						<h3>보쨘의 상큼달큼 다꾸!<i></i></h3>
						<p>옐로우 컬러가 눈에 쏙 들어오는 다꾸를 배워보자</p>
						<a href="/shopping/category_prd.asp?itemid=2125874" class="repesent-item" style="top:192px; right:-130px;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95898/img_item_0.png" alt="LEEGONG 사각사각 메모지"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2312151"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95898/img_item_1.png" alt="O-ssum for deco 8종"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2125874"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95898/img_item_2.png" alt="LEEGONG 사각사각 메모지"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2369957"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95898/img_item_3.png" alt="Big Heart Sticker (20ea)"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1900766"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95898/img_item_4.png" alt="리무버 스티커 01~08"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=95898" class="vod-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95898/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>
				
				<!-- vol20 (95779) -->
				<div class="section typeB">
					<div class="info">
						<h3>밥팅’s 핑크 다꾸의 모든 것<i></i></h3>
						<p>핑크 핑크한 다꾸의 모든 것, 밥팅과 함께 알아보자!</p>
						<a href="/shopping/category_prd.asp?itemid=2268480" class="repesent-item" style="top:181px; left:-66px;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95779/img_item_0.png" alt="A5 하드 육공 모눈 노트 후르츠시리즈"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2268480"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95779/img_item_1.png" alt="A5 하드 육공 모눈 노트 후르츠시리즈"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2111471"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95779/img_item_2.png" alt="A5 컬러 Half 리필속지 30page"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2381233"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95779/img_item_3.png" alt="메모패드 핑크가든"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2014296"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95779/img_item_4.png" alt="마스킹테이프 TWINKLE YOUTH CLUB"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=95779" class="vod-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95779/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol18 (94995) -->
				<div class="section typeA">
					<div class="info">
						<h3>유튜버 망고펜슬<i></i></h3>
						<p>헬로키티X망고펜슬 비밀일기장 언박싱!</p>
						<a href="/shopping/category_prd.asp?itemid=2358150" class="repesent-item" style="top:185px; left:428px;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_item_0.png" alt="HELLO KITTY CHARMING CLUB Secret Diary"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2358153"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_item_1.png" alt="HELLO KITTY CHARMING CLUB Secret Diary"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2358158"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_item_2.png" alt="HELLO KITTY CHARMING CLUB Stationery Pack"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2358154"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_item_3.png" alt="HELLO KITTY CHARMING CLUB Key Holder"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2358157"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_item_4.png" alt="HELLO KITTY CHARMING CLUB Mint Pouch"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=94995" class="vod-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol19 (95454) -->
				<div class="section typeB">
					<div class="info">
						<h3>츄삐’s 여름 휴가 계획<i></i></h3>
						<p>츄삐가 꾸미는 여름 휴가 계획, 알차게 꾸미는 방법을 배워보자</p>
						<a href="/shopping/category_prd.asp?itemid=2108400" class="repesent-item" style="top:150px; left:-70px;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95454/img_item_0.png" alt="A5 글리터 커버"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2294506"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95454/img_item_1.png" alt="페이퍼 스티커"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1978153"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95454/img_item_2.png" alt="루카랩 썸머 마스킹테이프"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2095395"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95454/img_item_3.png" alt="젤리빈 알로하 메모지"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1843749"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95454/img_item_4.png" alt="제브라 사라사클립 스누피 캐릭터 젤잉크펜"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=95454" class="vod-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95454/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol15 (93796) -->
				<div class="section typeA">
					<div class="info">
						<h3>유튜버 망고펜슬<i></i></h3>
						<p>망고펜슬과 함께 디즈니 다꾸 용품 구경하고 이벤트 참여하자!</p>
						<a href="/shopping/category_prd.asp?itemid=2080162" class="repesent-item" style="top:190px; left:456px;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93796/img_item_0.png" alt="위니 더 푸 핸디스티키노트"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2209031"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93796/img_item_1.png" alt="홀로그램 포스터 6공노트"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2209033"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93796/img_item_2.png" alt="포스터 6공노트"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2191086"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93796/img_item_3.png" alt="페이스스티커"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2000210"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93796/img_item_4.png" alt="투명 스티커"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=93796" class="vod-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93796/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol17 (93887) -->
				<div class="section typeB">
					<div class="info">
						<h3>유튜버 하영, 디즈니 언박싱<i></i></h3>
						<p>디즈니 언박싱 영상도 구경하고 코멘트 이벤트도 참여하자!</p>
						<a href="/shopping/category_prd.asp?itemid=2157871" class="repesent-item" style="top:170px; left:-100px;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93887/img_item_0.png" alt=""></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2209031"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93887/img_item_1.png" alt="홀로그램 포스터 6공노트"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2209033"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93887/img_item_2.png" alt="포스터 6공노트"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2241214"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93887/img_item_3.png" alt="마스킹테이프 알라딘"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2202120"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93887/img_item_4.png" alt="프린세스 스티커 세트"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=93887" class="vod-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93887/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol16 (93883) -->
				<div class="section typeA">
					<div class="info">
						<h3>유튜버 츄삐의 다꾸 방법!<i></i></h3>
						<p>세상에.. 디즈니 다꾸템으로 이렇게까지 다꾸할 수 있었어?</p>
						<a href="/shopping/category_prd.asp?itemid=2100299" class="repesent-item" style="top:192px; left:489px;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93883/img_item_0.png" alt="클립보드"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2209031"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93883/img_item_1.png" alt="홀로그램 포스터 6공노트"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2209033"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93883/img_item_2.png" alt="포스터 6공노트"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2202120"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93883/img_item_3.png" alt="프린세스 스티커 세트"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2157875"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93883/img_item_4.png" alt="위클리플래너 패드"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=93883" class="vod-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93883/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol14 (92235) -->
				<div class="section typeB">
					<div class="info">
						<h3>다꾸, 6공의 감성<i></i></h3>
						<p>다꾸채널 마지막편. 우리가 기억하는 올해의 다이어리</p>
						<a href="/event/eventmain.asp?eventid=92235" class="repesent-item" style="top:198px; left:-75px;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92235/img_item_0.png" alt=""></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2139609"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92235/img_item_1.png" alt="A5 다이어리 하드커버 바인더"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2153306"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92235/img_item_2.png" alt="다이어리 포스트카드 A5"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1945359"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92235/img_item_3.png" alt="컬러 무드 스티커 S (13mm)"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1900766"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92235/img_item_4.png" alt="그리고 여행 메모패드 (계획형)"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=92235" class="vod-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92235/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol13 (91894) -->
				<div class="section typeA">
					<div class="info">
						<h3>마테백과사전 vol.3<i></i></h3>
						<p>다이어리 꾸미기 필수템! 마스킹테이프를 알아보자</p>
						<a href="/event/eventmain.asp?eventid=91894" class="repesent-item" style="top:160px; right:-70px;"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91894/img_item_0.png" alt=""></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2019312"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91894/img_item_1.png" alt="SMILE"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1934385"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91894/img_item_2.png" alt="반데 하트 Trois 마스킹테이프 BDA269"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1931015"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91894/img_item_3.png" alt="축하할 일이 너무 많아 / 마스킹테이프"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2146909"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91894/img_item_4.png" alt="MASKING TAPE_MOONLIGHT 01"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=91894" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91894/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol12 (91292) -->
				<div class="section typeB">
					<div class="info">
						<h3>텐텐 문방구는 처음이지?<i></i></h3>
						<p>DIY와 뽀시래기의 천국 &lt;텐텐 문방구&gt;에 놀러오세요! </p>
						<a href="/shopping/category_prd.asp?itemid=2111986" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2111986');" class="repesent-item" style="top:160px; left:-70px;"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91292/img_item_0.png" alt="[텐텐문방구] 다이어리 스타터 패키지"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2139609" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2139609');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91292/img_item_1.png" alt="[텐텐문방구] A5 다이어리 하드커버 바인더"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2108400" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2108400');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91292/img_item_2.png" alt="[텐텐문방구] A5 글리터 커버 (6공다이어리용/7종)"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2139535" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2139535');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91292/img_item_3.png" alt="[텐텐문방구] A5 플래너 리필속지 12종"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2053629" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2053629');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91292/img_item_4.png" alt="체리 레드 리본 키링"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=91292" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','91292');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91292/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol11 (90871) -->
				<div class="section typeA">
					<div class="info">
						<h3>데일리라이크’s PICK<i></i></h3>
						<p>데일리라이크 디자이너는 어떤 다꾸를 할까?</p>
						<a href="/shopping/category_prd.asp?itemid=2104144" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2104144');" class="repesent-item" style="top:221px; left:421px;"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90871/img_item_0.png" alt="2019 메이크 잇 카운트 투데이"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2104140" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2104140');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90871/img_item_1.png" alt="2019 킵 더 메모리"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2155157" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2155157');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90871/img_item_2.png" alt="텐바이텐 단독 마스킹 테이프 크리스마스 9P set 파우치 증정"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2103759" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2103759');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90871/img_item_3.png" alt="한정 Masking tape 10p set - 02 Go to picnic"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2104155" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2104155');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90871/img_item_4.png" alt="데일리 스티커 41~52번"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=90871" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','90871');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90871/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol10 (90879) -->
				<div class="section typeB">
					<div class="info">
						<h3>유투버 밥팅’s PICK<i></i></h3>
						<p>다이어리 꾸미기 필수템! 마스킹테이프를 알아보자</p>
						<a href="/shopping/category_prd.asp?itemid=2102877" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2102877');" class="repesent-item" style="left:-70px;"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90879/img_item_0.png" alt="아이코닉 라이블리 다이어리 "></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2110037" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2110037');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90879/img_item_1.png" alt="[LEEGONG] 글리터 만년다이어리-RASPBERRY SHOWER ver."></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1987971" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1987971');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90879/img_item_2.png" alt="123 STICKER (2sheets)"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1307820" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1307820');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90879/img_item_3.png" alt="아이코닉 투웨이 레트로펜"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1921247" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1921247');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90879/img_item_4.png" alt="[디즈니] 위니더푸 메모패드"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=90879" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','90879');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90879/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol09 (90718) -->
				<div class="section typeA">
					<div class="info">
						<h3>신비한 마테백과사전<i></i></h3>
						<p>다이어리 꾸미기 필수템! 마스킹테이프를 알아보자</p>
						<a href="/shopping/category_prd.asp?itemid=1918718" class="repesent-item" style="top:221px; left:421px;"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90718/img_item_0.png" alt="반 고흐 아몬드 나무 마스킹테이프"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=1672720"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90718/img_item_1.png" alt="크리스털 멀티 테이프 디스펜서"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1989887"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90718/img_item_2.png" alt="루다정한 마테 작심한주_30mm"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2025283"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90718/img_item_3.png" alt="카운트다운 마스킹테이프"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1934383"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90718/img_item_4.png" alt="반데 아네모네 부케 마스킹테이프 BDA271"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=90718" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90718/img_vod_thumb.gif?v=1.01" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>
				
				<!-- vol08 (90582) -->
				<div class="section typeB ">
					<div class="info">
						<h3>다꾸 STEP 1. 마스킹테이프<i></i></h3>
						<p>그것이 알고싶다 1탄, 마스킹테이프를 알아보자!</p>
						<a href="/shopping/category_prd.asp?itemid=2022145" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2022145');" class="repesent-item" style="left:-85px;"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90582/img_item_0.png" alt="Masking tape slim 2p - 05 Cherry"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=1826459" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1826459');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90582/img_item_1.png" alt="COTTON 100 FABRIC TAPE 1.0"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2058116" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2058116');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90582/img_item_2.png" alt="루카랩 홀로홀로 마스킹테이프 세트"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2089747" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2089747');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90582/img_item_3.png" alt="하찮은 공룡들 마스킹테이프"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1725359" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1725359');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90582/img_item_4.png" alt="KBP masking tape"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=90582" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','90582');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90582/img_vod_thumb.gif" alt="다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol07 (90249) -->
				<div class="section typeA">
					<div class="info">
						<h3>라이브워크’s PICK<i></i></h3>
						<p>BEST 감성다이어리 &lt;깊은시간 다이어리&gt; 디자이너의 다꾸!</p>
						<a href="/shopping/category_prd.asp?itemid=2094207" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2094207');" class="repesent-item"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90249/img_item_0.png" alt="깊은시간 다이어리 ver.2 라지 (만년형)"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2094205" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2094205');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90249/img_item_1.png" alt="깊은시간 기록장 - 원고지"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1990735" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1990735');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90249/img_item_2.png" alt="시화 PAPER TAPE"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1598270" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1598270');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90249/img_item_3.png" alt="트윈플러스펜 10COLOR"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1990732" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1990732');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90249/img_item_4.png" alt="Proust PAPER TAPE"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=90249" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','90249');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90249/img_vod_thumb.gif" alt="라이브워크 다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol06 (90070) -->
				<div class="section typeB">
					<div class="info">
						<h3>소담한작업실’s PICK<i></i></h3>
						<p>루카랩 다이어리와 다꾸 용품을 구경해보자!</p>
						<a href="/shopping/category_prd.asp?itemid=1872460" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1872460');" class="repesent-item"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90070/img_item_0.png" alt="루카랩 레트로 비디오 모눈노트 스페셜 에디션"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2094202" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2094202');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90070/img_item_1.png" alt="2019 아젠다 다이어리 L (날짜형)"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2058116" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2058116');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90070/img_item_2.png" alt="루카랩 홀로홀로 마스킹테이프 세트"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1663318" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1663318');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90070/img_item_3.png" alt="Label Sticker Pack-26 Space"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=456071" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','456071');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90070/img_item_4.png" alt="SIGNO DX 0.38mm 젤잉크펜 (19컬러)"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=90070" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','90070');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90070/img_vod_thumb.gif" alt="소담한작업실 다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol05 (89818) -->
				<div class="section typeA">
					<div class="info">
						<h3>너도밤나무’s PICK <i></i></h3>
						<p>빈티지 다꾸 셀럽 너도밤나무! 오래도록 남기고픈 나만의 기록</p>
						<a href="/shopping/category_prd.asp?itemid=1487793" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1487793');" class="repesent-item"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89818/img_item_0.png" alt="트래블러스노트 오리지널 사이즈 (카멜)"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2097268" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2097268');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89818/img_item_1.png" alt="2019 MD노트 다이어리 하루 한 페이지 (L)"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2053221" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2053221');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89818/img_item_2.png" alt="[MU] PRINT-ON STICKERS BPOP-001018"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2033714" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2033714');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89818/img_item_3.png" alt="인스탁스 쉐어 SP-3"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1867776" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1867776');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89818/img_item_4.png" alt="카발리니 빈티지 스탬프 세트-Par Avion"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=89818" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','89818');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89818/img_vod_thumb.gif" alt="너도밤나무 다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol04 (89817) -->
				<div class="section typeB">
					<div class="info">
						<h3>초은’s PICK<i></i></h3>
						<p>아기자기한 드로잉 다꾸 입문자?! 초은작가님과 함께해요!</p>
						<a href="/shopping/category_prd.asp?itemid=2085679" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2085679');" class="repesent-item"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89817/img_item_0.png" alt="2019 Wish diary ver.4"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=730936" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','730936');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89817/img_item_1.png" alt="프리즈마 유성색연필 48색"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2052716" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2052716');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89817/img_item_2.png" alt="Masking tape single - 129 Yoga"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=989795" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','989795');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89817/img_item_3.png" alt="쁘띠데코 스티커 베이직"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2087165" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2087165');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89817/img_item_4.png" alt="Tomorrow is better than today."></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=89817" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','89817');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89817/img_vod_thumb.gif" alt="초은 다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol03 (89628) -->
				<div class="section typeA">
					<div class="info">
						<h3>달밍’s PICK <i></i></h3>
						<p>비온뒤 6공 다이어리와 다꾸 용품을 구경해보자!</p>
						<a href="/shopping/category_prd.asp?itemid=2087688" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2087688');" class="repesent-item"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89628/img_item_0.png" alt="A5 핼리데이 데코 포켓 다이어리"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2087691" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2087691');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89628/img_item_1.png" alt="2019 별별일상 트윙클 에디션"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2078372" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2078372');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89628/img_item_2.png" alt="[LEEGONG] 만년 다이어리 - RUDDY PEACH VER."></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1678575" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1678575');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89628/img_item_3.png" alt="[AIUEO] Masking tape katanuki - FRUITS MIX"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2067979" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2067979');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89628/img_item_4.png" alt="Cassette Card Set_Pink Pop"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=89628" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','89628');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89628/img_vod_thumb.gif" alt="달밍 다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol02 (89423) -->
				<div class="section typeB">
					<div class="info">
						<h3>망고펜슬’s PICK<i></i></h3>
						<p>이공 만년 다이어리와 다꾸 용품을 구경해보자!</p>
						<a href="/shopping/category_prd.asp?itemid=2078373" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2078373');" class="repesent-item"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89423/img_item_0.png" alt="[LEEGONG] 만년 다이어리 - SNOW LAVENDER VER."></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2054049" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2054049');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89423/img_item_1.png" alt="[루카랩] 샤이닝 젤 스틱 3set"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1945359" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1945359');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89423/img_item_2.png" alt="컬러 무드 스티커 S (13mm)"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1800105" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1800105');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89423/img_item_3.png" alt="review list S"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=1571865" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','1571865');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89423/img_item_4.png" alt="12 Month Diary - 루카랩X캠퍼 에디션"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=89423" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','89423');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89423/img_vod_thumb.gif" alt="망고펜슬 다꾸채널 이벤트 페이지로 이동"></a>
				</div>

				<!-- vol01 (89316) -->
				<div class="section typeA">
					<div class="info">
						<h3>다이애나’s PICK <i></i></h3>
						<p>루카랩 홀로홀로 다이어리와 다꾸 용품을 구경해보자!</p>
						<a href="/shopping/category_prd.asp?itemid=2088180" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2088180');" class="repesent-item"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89316/img_item_0.png" alt="[날짜형] 2019 홀로홀로 다이어리 A5 - 홀로그램 에디션"></a>
						<ul>
							<li><a href="/shopping/category_prd.asp?itemid=2074976" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2074976');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89316/img_item_1.png" alt="2019피넛 데일리/레드 L"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2054048" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2054048');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89316/img_item_2.png" alt="자문자답 다이어리 (일러스트 버전)"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2052713" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2052713');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89316/img_item_3.png" alt="Masking tape single - 126 Lake"></a></li>
							<li><a href="/shopping/category_prd.asp?itemid=2037974" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_item','itemid','2037974');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89316/img_item_4.png" alt="kitty memo"></a></li>
						</ul>
					</div>
					<a href="/event/eventmain.asp?eventid=89316" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_event','eventid','89316');" class="vod-thumb"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89316/img_vod_thumb.gif" alt="다이애나 다꾸채널 이벤트 페이지로 이동"></a>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->