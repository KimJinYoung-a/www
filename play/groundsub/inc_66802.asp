<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : play 스물다섯 번째 이야기 TOY
' History : 2015.10.15 한용민 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim currenttime
	currenttime =  now()
	'currenttime = #10/24/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64932
Else
	eCode   =  66802
End If

dim userid, i
	userid = GetEncLoginUserID()

dim subscriptexistscount, totsubscriptexistscount1, totsubscriptexistscount2, totsubscriptexistscount3, totsubscriptexistscount4, totsubscriptexistscount5
	subscriptexistscount=0
	totsubscriptexistscount1=0
	totsubscriptexistscount2=0
	totsubscriptexistscount3=0
	totsubscriptexistscount4=0
	totsubscriptexistscount5=0

if userid<>"" then
	subscriptexistscount = getevent_subscriptexistscount(eCode, userid, "", "", "")
end if

totsubscriptexistscount1 = getevent_subscripttotalcount(eCode, "", "1", "")
totsubscriptexistscount2 = getevent_subscripttotalcount(eCode, "", "2", "")
totsubscriptexistscount3 = getevent_subscripttotalcount(eCode, "", "3", "")
totsubscriptexistscount4 = getevent_subscripttotalcount(eCode, "", "4", "")
totsubscriptexistscount5 = getevent_subscripttotalcount(eCode, "", "5", "")
%>

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
img {vertical-align:top;}
.groundHeadWrap {width:100%; background:#e8e8e8;}
.groundCont {padding-bottom:0; text-align:center; background:#f0f0e8}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:65px 20px 60px;}
.playGr20151019 {overflow:hidden; text-align:center;}
.toyCont {position:relative; width:1140px; margin:0 auto;}
.intro {height:1058px; background:#192236 url(http://webimage.10x10.co.kr/play/ground/20151019/bg_dolldolldoll.jpg) 50% 0 no-repeat;}
.intro h3 {position:absolute; left:337px; top:100px; opacity:0; filter:alpha(opacity=0);}
.purpose {height:663px; padding-top:175px; background:#eae8db;}
.purpose img {display:inline-block; position:relative;}
.purpose .flag {position:relative; width:90px; height:47px; margin:0 auto;}
.purpose .flag span {position:absolute; top:0; opacity:0; filter:alpha(opacity=0);}
.purpose .flag .f01 {left:0; margin-left:10px;}
.purpose .flag .f02 {right:0; margin-right:10px;}
.purpose h4 {position:relative; top:-5px; padding:36px 0 60px; opacity:0; filter:alpha(opacity=0);}
.purpose p {padding-bottom:50px; opacity:0; filter:alpha(opacity=0);}
.dollRace {background:url(http://webimage.10x10.co.kr/play/ground/20151019/bg_noise.gif) 0 0 repeat;}
.dollRace h4 {padding:80px 0;}
.dollRace .slideWrap {position:relative; padding-top:425px; }
.dollRace .dollSlide {overflow:visible !important; width:100%; text-align:center; border-top:9px solid #1d741a;}
.dollRace .dollSlide .toyCont {position:static; width:100%;}
.dollRace .dollSlide .toyCont a {position:absolute; z-index:50;}
.dollRace .dollSlide .p01 a {left:22.3%; top:10%;}
.dollRace .dollSlide .p02 a {right:21.4%; top:13%;}
.dollRace .dollSlide .p03 a {left:22.3%; top:61%;}
.dollRace .dollSlide .p04 a {right:21.4%; top:13%;}
.dollRace .dollSlide .p05 a {right:21.4%; top:19.5%;}
.dollRace .dollSlide .pic {width:100%;}
.dollRace .dollSlide .slidesjs-pagination {overflow:hidden; position:absolute; left:50%; top:0; width:1120px; margin-left:-560px; z-index:100;}
.dollRace .dollSlide .slidesjs-pagination li {float:left; width:204px; height:321px; padding-right:14px; text-align:left;}
.dollRace .dollSlide .slidesjs-pagination li a {display:block; width:100%; height:321px; background-repeat:no-repeat; background-position:0 0; text-indent:-9999px;}
/*.dollRace .dollSlide .slidesjs-pagination li a:hover {width:209px; background-position:-204px 0;}*/
.dollRace .dollSlide .slidesjs-pagination li a.active {width:210px; background-position:-414px 0;}
.dollRace .dollSlide .slidesjs-pagination li.player01 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20151019/img_no1.gif);}
.dollRace .dollSlide .slidesjs-pagination li.player02 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20151019/img_no2.gif);}
.dollRace .dollSlide .slidesjs-pagination li.player03 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20151019/img_no3.gif);}
.dollRace .dollSlide .slidesjs-pagination li.player04 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20151019/img_no4.gif);}
.dollRace .dollSlide .slidesjs-pagination li.player05 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20151019/img_no5.gif);}
.playEvent {padding:130px 0 125px; text-align:center; background-image:url(http://webimage.10x10.co.kr/play/ground/20151019/bg_triangle.png),url(http://webimage.10x10.co.kr/play/ground/20151019/bg_triangle02.gif); background-repeat:no-repeat; background-position:0 0, 100% 100%; background-color:#f0efe7;}
.playEvent .package {padding:45px 0 92px;}
.playEvent .selectDoll ul {overflow:hidden; padding:0 0 75px 10px;}
.playEvent .selectDoll li {position:relative; float:left; width:214px; padding:0 5px;}
.playEvent .selectDoll li input {position:absolute; left:50%; top:278px; margin-left:-8px;}
.playEvent .selectDoll li label {display:block;}
.playEvent .selectDoll .count {padding-top:35px;}
.playEvent .selectDoll .count strong {font-size:28px; line-height:20px; color:#000; vertical-align:top; font-family:arial;}
.playEvent .selectDoll .count img {display:inline-block; padding:4px 0 0 6px;}
.comingsoon {position:relative; background:url(http://webimage.10x10.co.kr/play/ground/20151019/bg_square.gif) 0 0 repeat;}
.comingsoon .shadow {position:absolute; top:0; width:960px; height:174px; background-position:0 0; background-repeat:no-repeat;}
.comingsoon .lt {left:0; background-image:url(http://webimage.10x10.co.kr/play/ground/20151019/bg_shadow_lt.png)}
.comingsoon .rt {right:0; background-image:url(http://webimage.10x10.co.kr/play/ground/20151019/bg_shadow_rt.png)}
.raceResult {position:relative; padding:70px 0 125px; background:url(http://webimage.10x10.co.kr/play/ground/20151019/bg_square.gif) 0 0 repeat;}
.raceResult .tit {padding-bottom:60px;}
.resultBox {position:relative; width:1140px; height:584px; margin:0 auto; background:url(http://webimage.10x10.co.kr/play/ground/20151019/bg_result_box.png) 0 0 no-repeat; z-index:100;}
.resultBox .movie {width:480px; padding:84px 45px 0; text-align:left;}
.resultBox .movie iframe {width:480px; height:270px; margin-top:65px; vertical-align:top;}
.resultBox .winnerIs {position:absolute; left:693px; top:84px;}
.raceResult .shadow {position:absolute; top:0; width:960px; height:100%; background-position:0 0; background-size:960px 100%; background-repeat:no-repeat; z-index:90;}
.raceResult .lt {left:0; background-image:url(http://webimage.10x10.co.kr/play/ground/20151019/bg_shadow_lt.png)}
.raceResult .rt {right:0; background-image:url(http://webimage.10x10.co.kr/play/ground/20151019/bg_shadow_rt.png)}
</style>
<script type="text/javascript">

$(function(){
	//animation
	function purpose() {
		$('.flag .f01').animate({"margin-left":"0","opacity":"1"},900);
		$('.flag .f02').animate({"margin-right":"0","opacity":"1"},900);
		$('.purpose h4').delay(700).animate({"top":"0","opacity":"1"},800);
		$('.purpose .t01').delay(1200).animate({"opacity":"1"},1000);
		$('.purpose .t02').delay(1400).animate({"opacity":"1"},1000);
		$('.purpose .t03').delay(1600).animate({"opacity":"1"},1000);
	}
	$('.intro h3').animate({"top":"137px","opacity":"1"},1000);
	function moveTit() {
		$(".intro h3").animate({"margin-top":"2px"},50).animate({"margin-top":"0"},50, moveTit);
	}
	$(".intro h3").effect( "shake", { direction: "up", times:12, distance:2}, 1000 );
	$('.dollSlide').slidesjs({
		width:"1920",
		height:"1118",
		navigation:false,
		pagination:{effect:"fade"},
		play: {interval:5000, effect:"fade", auto:true},
		effect:{fade: {speed:1100, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.dollSlide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$('.slidesjs-pagination li:nth-child(1)').addClass('player01');
	$('.slidesjs-pagination li:nth-child(2)').addClass('player02');
	$('.slidesjs-pagination li:nth-child(3)').addClass('player03');
	$('.slidesjs-pagination li:nth-child(4)').addClass('player04');
	$('.slidesjs-pagination li:nth-child(5)').addClass('player05');
	$(".slidesjs-pagination li a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$('#dollSlide').offset().top}, 300);
	});
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1300 ) {
			purpose();
		}
	});
});

function gojoin(){
	<% If IsUserLoginOK Then %>
		<% if not( left(currenttime,10)>="2015-10-19" and left(currenttime,10)<"2015-10-29" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptexistscount > 4 then %>
				alert('이벤트는 5회까지 참여 가능 합니다.');
				return false;
			<% else %>
				var tmpgubunval ='';
				for(var i=0; i < frmcom.gubunval.length; i++){
					if (frmcom.gubunval[i].checked){
						tmpgubunval = frmcom.gubunval[i].value;
					}
				}
				if (tmpgubunval==''){
					alert('원하는 것을 선택해 주세요.');
					return false;
				}
				gubunval=tmpgubunval;

				var rstStr = $.ajax({
					type: "POST",
					url: "/play/groundsub/doEventSubscript66802.asp",
					data: "mode=add&gubunval="+gubunval,
					dataType: "text",
					async: false
				}).responseText;
				//alert(rstStr);
				if (rstStr == "SUCCESS"){
					alert('감사합니다. 참여가 완료 되었습니다!');
					location.reload();
					return false;
				}else if (rstStr == "USERNOT"){
					alert('로그인을 해주세요.');
					return false;
				}else if (rstStr == "DATENOT"){
					alert('이벤트 응모 기간이 아닙니다.');
					return false;
				}else if (rstStr == "END"){
					alert('이벤트는 5회까지 참여 가능 합니다.');
					return false;
				}else if (rstStr == "NOTVAL"){
					alert('원하는 것을 선택해 주세요.');
					return false;
				}else{
					alert('오류가 발생했습니다.');
					return false;
				}
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% end if %>
}

</script>
</head>
<body>

<% '<!-- 수작업 영역 시작 --> %>
<div class="groundCont">
	<div class="grArea"> 
		<!-- TOY #3 -->
		<div class="playGr20151019">
			
			<div class="dolldolldoll">
				<div class="intro">
					<div class="toyCont">
						<h3><img src="http://webimage.10x10.co.kr/play/ground/20151019/tit_dolldolldoll.png" alt="돌돌.DOLL" /></h3>
					</div>
				</div>
				<div class="purpose">
					<div class="toyCont">
						<div class="flag">
							<span class="f01"><img src="http://webimage.10x10.co.kr/play/ground/20151019/bg_flag01.png" alt="" /></span>
							<span class="f02"><img src="http://webimage.10x10.co.kr/play/ground/20151019/bg_flag02.png" alt="" /></span>
						</div>
						<h4><img src="http://webimage.10x10.co.kr/play/ground/20151019/tit_toy_race.gif" alt="텐바이텐배 태엽토이 레이스!" /></h4>
						<p class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_purpose01.gif" alt="째깍 째깍 태엽을 감으면 작은 장난감은 지이이익- 소리를 내며 부지런히 움직입니다. 제자리에서 춤을 추거나 앞으로 달려가거나 빙글빙글 돌기도 하죠" /></p>
						<p class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_purpose02.gif" alt="텐바이텐 플레이에서는 이 작은 태엽토이들의 귀여운 경주를 지켜보기로 했습니다." /></p>
						<p class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_purpose03.gif" alt="자! 그럼 돌돌 태엽이 감기면서 시작되는 태엽토이 레이스에서 승리로 이어질 응원을 펼쳐보세요!" /></p>
					</div>
				</div>
				<div class="dollRace">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_introduce.gif" alt="선수소개" /></h4>
					<div class="slideWrap">
						<div class="dollSlide" id="dollSlide">
							<div class="p01">
								<div class="toyCont"><a href="/shopping/category_prd.asp?itemid=1283470"><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_slide01.png" alt="선수1:설리" /></a></div>
								<img src="http://webimage.10x10.co.kr/play/ground/20151019/img_slide01.jpg" alt="" class="pic" />
							</div>
							<div class="p02">
								<div class="toyCont"><a href="/shopping/category_prd.asp?itemid=1283472"><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_slide02.png" alt="선수2:마이크" /></a></div>
								<img src="http://webimage.10x10.co.kr/play/ground/20151019/img_slide02.jpg" alt="" class="pic" />
							</div>
							<div class="p03">
								<div class="toyCont"><a href="/shopping/category_prd.asp?itemid=1283469"><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_slide03.png" alt="선수3:라이트닝맥퀸" /></a></div>
								<img src="http://webimage.10x10.co.kr/play/ground/20151019/img_slide03.jpg" alt="" class="pic" />
							</div>
							<div class="p04">
								<div class="toyCont"><a href="/shopping/category_prd.asp?itemid=1283464"><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_slide04.png" alt="선수4:우디" /></a></div>
								<img src="http://webimage.10x10.co.kr/play/ground/20151019/img_slide04.jpg" alt="" class="pic" />
							</div>
							<div class="p05">
								<div class="toyCont"><a href="/shopping/category_prd.asp?itemid=1283473"><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_slide05.png" alt="선수5:니모" /></a></div>
								<img src="http://webimage.10x10.co.kr/play/ground/20151019/img_slide05.jpg" alt="" class="pic" />
							</div>
						</div>
					</div>
				</div>
				<% '<!-- ★★개발영역★★ --> %>
				<form name="frmcom" method="get" onSubmit="return false;" style="margin:0px;">
				<div class="playEvent">
					<div class="toyCont">
						<h4><img src="http://webimage.10x10.co.kr/play/ground/20151019/tit_event.png" alt="누가 누가 이길까! 1등을 예상해보세요!!" /></h4>
						<div class="package"><img src="http://webimage.10x10.co.kr/play/ground/20151019/img_doll_set.jpg" alt="" /></div>
						<div class="selectDoll">
							<ul>
								<li>
									<label for="player01"><img src="http://webimage.10x10.co.kr/play/ground/20151019/img_player01.png" alt="선수1:설리" /></label>
									<input type="radio" name="gubunval" value="1" id="player01" />
									<p class="count"><strong><%= totsubscriptexistscount1 %></strong><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_count.png" alt="명이 응원 중입니다" /></p>
								</li>
								<li>
									<label for="player02"><img src="http://webimage.10x10.co.kr/play/ground/20151019/img_player02.png" alt="선수2:마이크" /></label>
									<input type="radio" name="gubunval" value="2" id="player02" />
									<p class="count"><strong><%= totsubscriptexistscount2 %></strong><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_count.png" alt="명이 응원 중입니다" /></p>
								</li>
								<li>
									<label for="player03"><img src="http://webimage.10x10.co.kr/play/ground/20151019/img_player03.png" alt="선수3:라이트닝맥퀸" /></label>
									<input type="radio" name="gubunval" value="3" id="player03" />
									<p class="count"><strong><%= totsubscriptexistscount3 %></strong><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_count.png" alt="명이 응원 중입니다" /></p>
								</li>
								<li>
									<label for="player04"><img src="http://webimage.10x10.co.kr/play/ground/20151019/img_player04.png" alt="선수4:우디" /></label>
									<input type="radio" name="gubunval" value="4" id="player04" />
									<p class="count"><strong><%= totsubscriptexistscount4 %></strong><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_count.png" alt="명이 응원 중입니다" /></p>
								</li>
								<li>
									<label for="player05"><img src="http://webimage.10x10.co.kr/play/ground/20151019/img_player05.png" alt="선수5:니모" /></label>
									<input type="radio" name="gubunval" value="5" id="player05" />
									<p class="count"><strong><%= totsubscriptexistscount5 %></strong><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_count.png" alt="명이 응원 중입니다" /></p>
								</li>
							</ul>
							<input type="image" onclick="gojoin(); return false;" src="http://webimage.10x10.co.kr/play/ground/20151019/btn_cheer.png" alt="응원하기" class="btnCheer" />
						</div>
					</div>
				</div>
				</form>
				<% '<!--// ★★개발영역★★ --> %>

				<% if left(currenttime,10) > "2015-10-23" then %>
					<% '<!-- 24일부터 커밍순대신 이걸로↓ --> %>
					<div class="raceResult">
						<p class="tit"><img src="http://webimage.10x10.co.kr/play/ground/20151019/tit_result.png" alt="텐바이텐배 태엽토이 레이스 우승자를 공개합니다!" /></p>
						<div class="resultBox">
							<div class="movie">
								<p class="ct"><img src="http://webimage.10x10.co.kr/play/ground/20151019/tit_movie.gif" alt="우승영상보기" /></p>
								<iframe src="//player.vimeo.com/video/143346064?loop=1;" frameborder="0" title="" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
							</div>
							<div class="winnerIs"><img src="http://webimage.10x10.co.kr/play/ground/20151019/winner.gif" alt="" /></div>
						</div>
						<div class="shadow lt"></div>
						<div class="shadow rt"></div>
					</div>
				<% else %>
					<div class="comingsoon">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151019/txt_coming_soon.png" alt="레이스 결과를 기대해주세요!! 10월 30일, 플레이 페이지에서 발표됩니다." /></p>
						<div class="shadow lt"></div>
						<div class="shadow rt"></div>
					</div>
				<% end if %>
			</div>
			
		</div>
		<!-- // TOY #3 -->
<% '<!-- 수작업 영역 끝 --> %>

<!-- #include virtual="/lib/db/dbclose.asp" -->