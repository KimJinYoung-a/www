<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  메인페이지
' History : 2015.04.06 원승현 생성
' History : 2016.03.23 유태욱 수정(CtrltestDate 추가), 메인 미리보기
'###########################################################
%>
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_chkExpireLogin.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
     '///// 모바일 접속시 모바일 페이지도 이동 /////
if Request("mfg")="pc" or session("mfg")="pc" then
	session("mfg") = "pc"
else
	if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
		Response.Redirect "http://m.10x10.co.kr"
		REsponse.End
	end if
end if

	Dim conIp, arrIp, tmpIp
	conIp = Request.ServerVariables("REMOTE_ADDR")
	arrIp = split(conIp,".")
	tmpIp = Num2Str(arrIp(0),3,"0","R") & Num2Str(arrIp(1),3,"0","R") & Num2Str(arrIp(2),3,"0","R") & Num2Str(arrIp(3),3,"0","R")

	if Not(tmpIp=>"115094163042" and tmpIp<="115094163045") and Not(tmpIp=>"061252133001" and tmpIp<="061252133127") and Not(tmpIp=>"061252143070" and tmpIp<="061252143072") and Not(tmpIp=>"192168001001" and tmpIp<="192168001256") and tmpIp<>"211206236117" then
		If Response.Buffer Then
			Response.Clear
			Response.Expires = 0
		End If
		Response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
		Response.End
	end if

	Dim topRndBannerNum, mdPickBannerNum, lookBannerNum, brandStreetNum, cultureStationNum

	'// 상단배너 랜덤 표시
	Randomize
	topRndBannerNum = int(Rnd*(3))+1
	mdPickBannerNum = int(Rnd*(3))+1
	lookBannerNum = Int(Rnd*(3))+1
	brandStreetNum = Int(Rnd*(3))+1
	cultureStationNum = Int(Rnd*(3))+1


''2016-03-22 유태욱
dim CtrltestDate
	CtrltestDate = requestCheckVar(Request("CtrltestDate"),32)

%>

<link rel="stylesheet" type="text/css" href="/lib/css/mainV15.css" />
<style type="text/css">
/* HELLO! 10X10 CHINA */
.helloChina {display:none; position:absolute; top:28px; left:0; z-index:2; width:100%; height:620px; background:#bd0b0b url(http://webimage.10x10.co.kr/eventIMG/2015/67697/bg_parttern.png) no-repeat 50% 0;}
#mainWrapV15 .helloChina {display:block;}
#mainWrapV15 .helloChina img {vertical-align:top;}
#mainWrapV15 .helloChina .inner {position:relative; width:1140px; margin:0 auto; padding-top:80px; text-align:center;}
#mainWrapV15 .helloChina .deco {position:absolute; top:30px; left:162px;}
#mainWrapV15 .helloChina .btnChina {margin-top:29px;}
#mainWrapV15 .helloChina .closeMsg {margin-top:20px; padding-right:15px; text-align:right;}
#mainWrapV15 .helloChina .closeMsg input {width:16px; height:16px; border:0; background-color:#fff;}
#mainWrapV15 .helloChina .closeMsg button {position:absolute; top:15px; right:15px; width:29px; height:29px; background-color:transparent;}
@-webkit-keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}
.twinkle {animation-name:twinkle; -webkit-animation-name:twinkle; animation-iteration-count:infinite;  -webkit-animation-iteration-count:infinite; animation-duration:3s; -webkit-animation-duration:3s; animation-fill-mode:both;-webkit-animation-fill-mode:both;}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>
$(function() {
	$('.topBnrSlideV15').slidesjs({
		width:1022,
		height:665,
		start:<%=topRndBannerNum%>,
		navigation:{active:false},
		pagination:{active:true, effect:"fade"},
		play:{active:false, interval:4000, effect:"fade", auto:false},
		effect:{
			fade:{speed:750, crossfade:true}
		}
	});

	//multi banner control
	$('.mainMultiSlideV15').slidesjs({
		width:650,
		height:398,
		navigation:{active:false},
		pagination:{active:true, effect:"fade"},
		play:{active:false, interval:4000, effect:"fade", auto:true, pauseOnHover:true},
		effect:{
			fade:{speed:750, crossfade:true}
		}
	});
	$('.mainMultiSlideV15 .slidesjs-pagination > li a').prepend("0");

	$('.mdPSlideV15').slidesjs({
		width:1015,
		height:566,
		start:<%=mdPickBannerNum%>,
		navigation:{active:true, effect:"fade"},
		pagination:{active:true, effect:"fade"},
		play:{active:false, interval:3500, effect:"fade", auto:false, pauseOnHover:true},
		effect:{
			fade:{speed:700, crossfade:true}
		}
	});

	$('.lookSlideV15').slidesjs({
		width:1124,
		height:628,
		start:<%=lookBannerNum%>,
		navigation:{active:false, effect:"fade"},
		pagination:{active:true, effect:"fade"},
		play:{active:false, interval:3500, effect:"fade", auto:false, pauseOnHover:true},
		effect:{
			fade:{speed:700, crossfade:true}
		}
	});
	$('.lookSlideV15 .slidesjs-pagination > li a').prepend("0");

	$('.brandSlideV15').slidesjs({
		width:1116,
		height:224,
		start:<%=brandStreetNum%>,
		navigation:{active:false, effect:"fade"},
		pagination:{active:true, effect:"fade"},
		play:{active:false, interval:3500, effect:"fade", auto:false, pauseOnHover:true},
		effect:{
			fade:{speed:700, crossfade:true}
		}
	});
	$('.brandSlideV15 .slidesjs-pagination > li a').prepend("0");

	$('.cultureSlideV15').slidesjs({
		width:870,
		height:236,
		start:<%=cultureStationNum%>,
		navigation:{active:true, effect:"fade"},
		pagination:{active:true, effect:"fade"},
		play:{active:false, interval:4000, effect:"fade", auto:false},
		effect:{
			fade:{speed:750, crossfade:true}
		}
	});

	//family page control
	$('.familySlideV15').slidesjs({
		width:330,
		height:152,
		start:1,
		navigation:{active:false},
		pagination:{active:true, effect:"fade"},
		play:{active:false, interval:5000, effect:"fade", auto:false},
		effect:{
			fade:{speed:700, crossfade:true}
		}
	});
	$('.familySlideV15 .slidesjs-pagination > li').eq(0).addClass("family00");
	$('.familySlideV15 .slidesjs-pagination > li').eq(1).addClass("family01");

	$('.imgOverV15').append('<em></em>');
	$('.imgOverV15').mouseenter(function(){
		$(this).find('em').show();
	});
	$('.imgOverV15').mouseleave(function(){
		$(this).find('em').hide();
	});

	$('.roundBnrV15 .bnrBasicV15').mouseenter(function(){
		$(this).find('.imgOverV15 em').show();
	});
	$('.roundBnrV15 .bnrBasicV15').mouseleave(function(){
		$(this).find('.imgOverV15 em').hide();
	});

	$('.topBnrV15 li').mouseenter(function(){
		$(this).find('.imgOverV15 em').show();
	});
	$('.topBnrV15 li').mouseleave(function(){
		$(this).find('.imgOverV15 em').hide();
	});

	$('.onlyBnr1V15').mouseenter(function(){
		$(this).find('.imgOverV15 em').show();
	});
	$('.onlyBnr1V15').mouseleave(function(){
		$(this).find('.imgOverV15 em').hide();
	});

	$('.issuItem').mouseenter(function(){
		$(this).find('.imgOverV15 em').show();
	});
	$('.issuItem').mouseleave(function(){
		$(this).find('.imgOverV15 em').hide();
	});

	$('.cultureListV15 li').mouseenter(function(){
		$(this).find('.imgOverV15 em').show();
	});
	$('.cultureListV15 li').mouseleave(function(){
		$(this).find('.imgOverV15 em').hide();
	});

	$('.topBnrSlideV15 li:last-child').addClass('playPaging');
	$('.mdPSlideV15 li:nth-child(4)').addClass('bestPaging');
	$('.mdPSlideV15 li:nth-child(5)').addClass('wishPaging');

	$("#issueSlider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		//position:0.0,
		startPosition:0.55
	});

	<%'' for dev msg : HELLO! 10X10 CHINA %>
	$("#helloChina .closeMsg button").click(function(){
		if(document.getElementById("ChnAnymore").checked){
			setChnCookie( "ChnPopcookieP", "done" , 24 ); 
		}
		$("#helloChina").slideUp();
	});
	<%''// for dev msg : HELLO! 10X10 CHINA %>

});

function PopupNewsSel(v) {
	if (v=="")
	{
		var popwin = window.open('/common/news_list.asp','popupnews', 'width=580,height=750,left=300,top=100,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no');
		popwin.focus();
	}
	else
	{
		if($('.mainListWrap .slidesjs-pagination .active').attr("data-slidesjs-item")=="1") {
			var popwin = window.open('/common/news_popup.asp?type=E&idx='+v,'popupnews', 'width=580,height=750,left=300,top=100,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no');
			popwin.focus();
		} else {
			var popwin = window.open('/common/news_popup.asp?type=A&idx='+v,'popupnews', 'width=580,height=750,left=300,top=100,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no');
			popwin.focus();
		}
	}
}

function setChnCookie( name, value, expirehours ) { 
	var todayDate = new Date(); 
	todayDate.setHours( todayDate.getHours() + expirehours ); 
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
}

</script>
</head>
<body>
<div class="wrap" id="mainWrapV15">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">

			<div class="section roundBnrV15">
				<%' 라운드 배너 %>
					<% server.Execute("/chtml_test/main/loader/main_round_banner_688.asp") %>
				<%'// 라운드 배너 %>

				<%' just1day %>
					<% server.Execute("/chtml_test/main/loader/just1day_banner_689.asp") %>
				<%'// just1day %>
			</div>

			<%' for dev msg : 앞의 3페이지중 랜덤 노출됩니다. 마지막 하늘색 페이징은 플레이 컨텐츠 노출됩니다. %>
			<div class="section topBnrV15">
				<div class="topBnrSlideV15">
					<%' set1 %>
						<% server.Execute("/chtml_test/main/loader/top_banner1_690.asp") %>
					<%' //set1 %>

					<%' set2 %>
						<% server.Execute("/chtml_test/main/loader/top_banner2_691.asp") %>
					<%' //set2 %>

					<%' set3 %>
						<% server.Execute("/chtml_test/main/loader/top_banner3_692.asp") %>
					<%' //set3 %>

					<%' set play  %>
						<% server.Execute("/chtml_test/main/loader/top_banner_play_693.asp") %>
					<%' //set play %>
				</div>
			</div>

			<div class="section multiSecV15">
				<%' multi left banner %>
				<div class="onlyBnr1V15">
					<% server.Execute("/chtml_test/main/loader/multi_left_banner_699.asp") %>
				</div>
				<%' //multi left banner %>

				<%' multi banner %>
				<div class="multiBnrV15">
					<% server.Execute("/chtml_test/main/loader/main_multi_694.asp") %>
				</div>
				<%' //multi banner %>
			</div>

			<%' for dev msg : 앞의 3페이지중 랜덤 노출됩니다. 베스트픽과 위시픽은 고정 %>
			<div class="section mdPickV15">
				<div class="mdPickBoxV15">
					<div class="mdPSlideV15">
						<% 'MD PICK %>
							<% server.Execute("/chtml/main/loader/mdpick2015.asp") %>
						<% '// MD PICK %>

						<% 'BEST AWARD %>
							<% server.Execute("/chtml/main/loader/bestaward.asp") %>
						<% '// BEST AWARD %>

						<% 'POPULAR WISH %>
							<% server.Execute("/chtml/main/loader/popularwish.asp") %>
						<% '// POPULAR WISH %>
					</div>
				</div>
			</div>

			<%' MD PICK 하단배너 %>
			<div class="section threeBnr01">
				<% server.Execute("/chtml_test/main/loader/MD_Down_Banner_695.asp") %>
			</div>
			<%'// MD PICK 하단배너 %>

			<%' 이슈별 넘버링 아이템 %>
			<div class="section issueV15">
				<% server.Execute("/chtml_test/main/loader/issue_Num_Item_696.asp") %>
			</div>
			<%'// 이슈별 넘버링 아이템 %>

			<div class="section lookV15"><%' for dev msg : 랜덤 노출됩니다. %>
				<h2><img src="http://fiximage.10x10.co.kr/web2015/main/tit_look.png" alt="LO-----OK!" /></h2>
				<div class="lookSlideV15">
					<%' LOOK 배너#1 %>
						<% server.Execute("/chtml_test/main/loader/look_banner1_705.asp") %>
					<%'// LOOK 배너#1 %>

					<%' LOOK 배너#2 %>
						<% server.Execute("/chtml_test/main/loader/look_banner2_704.asp") %>
					<%'// LOOK 배너#2 %>

					<%' LOOK 배너#3 %>
						<% server.Execute("/chtml_test/main/loader/look_banner3_697.asp") %>
					<%'// LOOK 배너#3 %>
				</div>
			</div>

			<div class="section brandV15"><%' for dev msg : 랜덤 노출됩니다. %>
				<h2><a href="/street/"><img src="http://fiximage.10x10.co.kr/web2015/main/tit_brand.png" alt="BRAND STREET" /></a></h2><%' for dev msg : 브랜드스트리트 메인으로 링크걸어주세요 %>
				<div class="brandSlideV15">
					<% server.Execute("/chtml_test/main/loader/brand_street_698.asp") %>
				</div>
			</div>


			<div class="cultureV15">
				<div class="cultureWrapV15">
					<h2><a href="/culturestation/"><img src="http://fiximage.10x10.co.kr/web2015/main/tit_culture.png" alt="CULTURE STATION" /></a></h2><%' for dev msg : 컬쳐스테이션 메인으로 링크걸어주세요 %>
					<div class="cultureSlideV15"><%' for dev msg : 슬라이드 랜덤 노출됩니다. %>
						<% ' 컬처스테이션 %>
							<% server.Execute("/chtml/main/loader/Culture12Banner.asp") %>
						<% '// 컬처스테이션 %>
					</div>
					<div class="cultureBnrV15">
						<div>
							<p><a href="/culturestation/culturestation_thanks10x10.asp?gaparam=main_menu_thanks"><span class="imgOverV15"><img src="http://fiximage.10x10.co.kr/web2015/main/btn_thanks.png" alt="고마워, 텐바이텐! - 고객님의 격려와 칭찬이 저희에게는 가장 소중합니다." /></span></a></p>
							<% server.Execute("/chtml/main/loader/CultureEditor.asp") %>
						</div>
						<dl>
							<dt><a href="/hitchhiker/?gaparam=main_menu_hitchhiker"><img src="http://fiximage.10x10.co.kr/web2015/main/tit_hitchhiker.png" alt="HITCH HIKER" /></a></dt><%' for dev msg : 히치하이커 페이지로 링크걸어주세요 %>
							<dd><%=AppTopVar(2)%></dd><%' for dev msg : 어드민 등록배너(9_히치하이커배너) / 배너명 alt값 속성에 넣어주세요 %>
						</dl>
						<div>
							<p><a href="/gift/talk/"><span class="imgOverV15"><%=AppTopVar(3)%></span></a></p>
							<p class="tMar12"><a href="/shoppingtoday/gift_recommend.asp"><span class="imgOverV15"><img src="http://fiximage.10x10.co.kr/web2015/main/btn_gift_wrapping.png" alt="당신의 마음까지 포장하세요 텐바이텐 선물포장 서비스" /></span></a></p>
						</div>
					</div>
				</div>
			</div>


			<div class="section etcWrapV15">
				<div class="boxUnit noticBoxV15">
					<%' 공지사항 //%>
					<!-- #include virtual="/chtml/main/idx_notice.html" -->

					<div class="etcLinkV15">
						<a href="<%=SSLUrl%>/giftcard/" class="giftCardLink">
							<p>텐바이텐<br />기프트 카드</p>
						</a>
						<a href="/gift/gifticon/" class="giftconLink">
							<p>기프티콘<br />상품교환</p>
						</a>
						<a href="/cscenter/oversea/emsIntro.asp" class="abroadLink">
							<p>텐바이텐<br />해외배송</p>
						</a>
					</div>
				</div>
				<div class="boxUnit svcBoxV15">
					<div class="benefitV15">
						<dl class="newMemV15">
							<dt><img src="http://fiximage.10x10.co.kr/web2015/main/tit_newmem_benefit.png" alt="텐바이텐 신규 회원혜택" /></dt>
							<dd>신규회원 가입시<br />무료배송 쿠폰+2,000원<br />할인 쿠폰 증정</dd>
							<dd><a href="/member/join.asp" class="btn btnS5 btnRed"><em class="fn whiteArr01">가입하기</em></a></dd>
						</dl>
						<dl class="katalkV15">
							<dt><img src="http://fiximage.10x10.co.kr/web2015/main/tit_katalk.png" alt="카카오톡 플러스친구" /></dt>
							<dd>주문 배송 및 다양한 혜택,<br />이벤트 정보를 제공하는<br />카카오톡 알림 서비스</dd>
							<dd><a href="/my10x10/userinfo/confirmuser.asp" class="btn btnS5 btnRed"><em class="fn whiteArr01">신청하기</em></a></dd>
						</dl>
					</div>
					<div class="mailRequestV15">
						<dl>
							<dt>비회원 메일진 신청</dt>
							<dd>
								<p>텐바이텐의 혜택, 이벤트 등의 정보를 <br />빠르게 만나실 수 있습니다.</p>
								<a href="" onclick="popMailling_InMain();return false;" class="btn btnS5 btnGry2 tMar05"><em class="fn whiteArr01">메일링 서비스 신청</em></a>
							</dd>
						</dl>
					</div>
				</div>
				<div class="boxUnit familyBoxV15">
					<div class="familySlideV15">
						<div class="storeV15">
							<div class="shopLinkV15">
								<ul>
									<li><a href="http://www.10x10.co.kr/offshop/shopinfo.asp?shopid=streetshop011&tabidx=1" target="_blank" class="goLinkV15">대학로점</a></li>
									<li><a href="http://www.10x10.co.kr/offshop/shopinfo.asp?shopid=streetshop018&tabidx=1" target="_blank" class="goLinkV15">김포롯데점</a></li>
									<li><a href="http://www.10x10.co.kr/offshop/shopinfo.asp?shopid=streetshop809&tabidx=1" target="_blank" class="goLinkV15">제주점</a></li>
									<li><a href="http://www.10x10.co.kr/offshop/shopinfo.asp?shopid=streetshop810&tabidx=1" target="_blank" class="goLinkV15">신제주점</a></li>
								</ul>
							</div>
							<%=AppTopVar(4)%>
						</div>
						<div class="academyV15"><%=AppTopVar(5)%></div>
					</div>
					<div class="etcBnrV15">
						<p class="cardInfoV15">
							<a href="/offshop/point/card_service.asp" target="_blank">
								<strong class="fs12">10X10 POINT CARD</strong>
								<span>발급/적립/사용방법</span>
							</a>
						</p>
						<p class="syrupV15">
							<a href="http://www.syrup.co.kr/" target="_blank">
								<strong>syrup 시럽</strong> 앱을 통해서 포인트 카드를 <br />발급 받을 수 있습니다.
							</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div itemscope itemtype="https://schema.org/WebSite" style="display:none;">
		<meta itemprop="url" content="http://www.10x10.co.kr/">
		<form itemprop="potentialAction" itemscope itemtype="https://schema.org/SearchAction">
			<meta itemprop="target" content="http://www.10x10.co.kr/search/search_result.asp?rect={search_term}&amp;gaparam=sitelinks_searchbox"/>
			<input itemprop="query-input" type="text" name="search_term" required/>
			<input type="submit"/>
		</form>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->