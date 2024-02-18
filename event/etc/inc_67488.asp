<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 크리스마스(참여1차) - 공유하기
' History : 2015-11-20 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->

<%
if date() >= "2015-12-07" then
	Response.Redirect "/event/eventmain.asp?eventid=67489"
end if

Dim eCode, userid, vTotalCount, sqlstr

userid = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
	eCode   =  65955
Else
	eCode   =  67488
End If

'// 총 카운트
sqlstr = "select count(*) "
sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
sqlstr = sqlstr & " where evt_code='"& eCode &"'  "
rsget.Open sqlstr, dbget, 1

If Not rsget.Eof Then
	vTotalCount = rsget(0)
End IF
rsget.close

''//슬라이드 번호 랜덤
Dim renloop
randomize
renloop=int(Rnd*3)+1 '3개

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg

dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode("[텐바이텐] 2015 크리스마스")
snpLink = Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre = Server.URLEncode("10x10 이벤트")

'기본 태그
snpTag = Server.URLEncode("텐바이텐")
snpTag2 = Server.URLEncode("#10x10")

%>
<style type="text/css">
/* 공통 */
img {vertical-align:top;}
.christmasCont {position:relative; width:1140px; margin:0 auto;}
.christmasHead {position:relative; height:488px; background:#d7d9db url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_head.png) no-repeat 50% 0;}
.christmasHead .date {position:absolute; right:23px; top:22px;}
.christmasHead h2 {position:absolute; left:50%; top:211px; width:662px; height:141px; margin-left:-319px;}
.christmasHead h2 span {display:inline-block; position:absolute; z-index:50;}
.christmasHead h2 span.t01 {left:0;}
.christmasHead h2 span.t02 {left:55px;}
.christmasHead h2 span.t03 {left:134px;}
.christmasHead h2 span.t04 {left:208px;}
.christmasHead h2 span.t05 {left:251px;}
.christmasHead h2 span.t06 {left:319px;}
.christmasHead h2 span.t07 {left:363px;}
.christmasHead h2 span.t08 {left:486px;}
.christmasHead h2 span.t09 {left:561px;}
.christmasHead h2 span.deco {position:absolute; left:16px; top:-2px; width:600px; height:60px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_txt_snow.png) no-repeat 0 0;}
.christmasHead p {position:absolute;}
.christmasHead p.gold {left:50%; top:88px; margin-left:-155px; z-index:40;}
.christmasHead p.year {left:50%; top:180px; margin-left:-88px;}
.christmasHead p.copy {left:50%; top:355px; margin-left:-153px;}
.christmasHead p.laurel {left:50%; top:62px;  z-index:35; width:333px; height:246px; margin-left:-166px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_laurel.png) no-repeat 0 0;}
.christmasHead .snow {position:absolute; left:50%; top:0; z-index:20; width:2000px; height:488px; margin-left:-1000px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_snow.png) repeat-y 0 0;}
.christmasHead .navigator {position:absolute; left:50%; bottom:-77px; z-index:50; width:1218px; height:112px; margin-left:-609px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_tab.png) no-repeat 0 0;}
.christmasHead .navigator ul {padding:6px 0 0 27px;}
.christmasHead .navigator ul:after {content:' '; display:block; clear:both;}
.christmasHead .navigator li {position:relative; float:left; width:282px; height:57px;}
.christmasHead .navigator li a {display:block; width:100%; height:100%; background-position:0 0; background-repeat:no-repeat; text-indent:-9999px;}
.christmasHead .navigator li.styling a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_styling.png);}
.christmasHead .navigator li.party a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_party.png);}
.christmasHead .navigator li.present a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_present.png);}
.christmasHead .navigator li.enjoy a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_enjoy.png);}
.christmasHead .navigator li.enjoy em {display:block; position:absolute; left:115px; top:-17px; width:62px; height:47px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/ico_apply.png) no-repeat 0 0; z-index:40;}
.christmasHead .navigator li.enjoy a:hover em {background-position:100% 0;}
.christmasHead .navigator ul li a:hover {background-position:0 -57px;}
.christmasHead .navigator ul li.current a {background-position:0 -114px;}
.christmasHead .navigator ul li.current a:after,
.christmasHead .navigator ul li a:hover:after {content:''; display:inline-block; position:absolute; left:0; top:-59px; width:282px; height:53px; }
.christmasHead .navigator ul li.current a:after  {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_tab_deco.png) !important;}
.christmasHead .navigator ul li a:hover:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_tab_deco_over.png);}
.christmasHead .navigator ul li.current.styling a:after,.christmasHead .navigator ul li.styling a:hover:after {height:71px; top:-77px; background-position:0 0;}
.christmasHead .navigator ul li.current.party a:after,.christmasHead .navigator ul li.party a:hover:after {background-position:0 -71px;}
.christmasHead .navigator ul li.current.present a:after,.christmasHead .navigator ul li.present a:hover:after {background-position:0 -124px;}
.christmasHead .navigator ul li.current.enjoy a:after,.christmasHead .navigator ul li.enjoy a:hover:after {background-position:0 -176px;}

/* 참여#1 */
.enjoyTogether {position:relative; padding-bottom:50px; margin-bottom:-116px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67488/bg_stripe.png) repeat 0 0;}
.enjoyTogether .enjoyV1 {padding-top:57px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67488/bg_snow.png) no-repeat 50% 0;}
.enjoyTogether .christmasCont {width:1180px; height:1308px; padding-top:56px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67488/bg_paper.png) no-repeat 0 0;}
.shareGoldmagic {width:1068px; height:516px; margin:0 auto;}
.shareGoldmagic .evtCont {padding:70px 0 37px;}
.shareGoldmagic .count {padding-top:15px;}
.shareGoldmagic .count strong {padding:0 2px 0 4px; color:#d60000; font-size:16px; line-height:15px; font-family:arial; vertical-align:top;}
.shareLayer {display:none;position:absolute; left:0; top:0; width:100%; height:100%; z-index:49; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67488/bg_mask.png) repeat 0 0;}
.shareLayer .layerCont {position:absolute; left:50%; top:15%; width:675px; height:331px; margin:0 0 0 -337px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67488/bg_layer.png) no-repeat 0 0;}
.shareLayer .layerCont p {padding:114px 0 33px;}
.shareLayer .goShare {overflow:hidden; width:310px; margin:0 auto;}
.shareLayer .goShare li {float:left; padding:0 8px;}
.shareLayer .btnClose {position:absolute; right:70px; top:70px; background:none;}
.hotItem {width:1068px; height:1225px; margin:0 auto;}
.hotItem h3 {padding:62px 0 44px;}
.hotItem .slide {overflow:visible !important; position:relative; width:954px; height:521px; margin:0 auto; text-align:center; background:#f8f8f8;}
.hotItem .slidesjs-pagination {overflow:hidden; position:absolute; bottom:-28px; left:50%; z-index:50; width:98px; margin-left:-48px;}
.hotItem .slidesjs-pagination li {float:left; padding:0 5px;}
.hotItem .slidesjs-pagination li a {display:block; width:22px; height:3px; background:#c3b4a1; text-indent:-999em;}
.hotItem .slidesjs-pagination li a.active {background:#000;}
</style>
<script>
$(function(){
	// titleAnimation
	$('.christmasHead p.laurel').css({"opacity":"0"});
	$('.christmasHead p.gold').css({"margin-top":"10px","opacity":"0"});
	$('.christmasHead p.year').css({"margin-top":"3px","opacity":"0"});
	$('.christmasHead h2 span').css({"opacity":"0"});
	$('.christmasHead h2 span.deco').css({"margin-top":"-3px","opacity":"0"});
	$('.christmasHead p.copy').css({"margin-top":"5px","opacity":"0"});
	function titleAnimation() {
		$('.christmasHead p.laurel').animate({"opacity":"1"},800);
		$('.christmasHead p.gold').delay(300).animate({"margin-top":"0","opacity":"1"},800);
		$('.christmasHead p.year').delay(800).animate({"margin-top":"0","opacity":"1"},800);
		$('.christmasHead h2 span.t01').delay(1500).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t02').delay(1800).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t03').delay(2100).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t04').delay(1900).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t05').delay(2300).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t06').delay(1600).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t07').delay(1700).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t08').delay(2000).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t09').delay(2200).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.deco').delay(2500).animate({"margin-top":"0","opacity":"1"},1500);
		$('.christmasHead p.copy').delay(3200).animate({"margin-top":"-4px","opacity":"1"},500).animate({"margin-top":"0"},500);
	}
	titleAnimation();
	function moveIcon () {
		$(".enjoy em").animate({"margin-top":"0"},500).animate({"margin-top":"3px"},500, moveIcon);
	}
	moveIcon();

	// hot item
	$(".slide").slidesjs({
		width:"954",
		height:"521",
		start:<%=renloop%>, // 슬라이드 스타트 넘버
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	// layer popup
	$('.btnShare').click(function(){
		$('.shareLayer').fadeIn(250);
		window.parent.$('html,body').animate({scrollTop:$('.enjoyTogether').offset().top}, 300);
	});
	$('.btnClose').click(function(){
		$('.shareLayer').fadeOut(250);
	});
});
/* snow */
var scrollSpeed =40;
var current = 0;
var direction = 'h';
function bgscroll(){
	current -= -1;
	$('.snow').css("backgroundPosition", (direction == 'h') ? "0 " + current+"px" : current+"px 0");
}
setInterval("bgscroll()", scrollSpeed);



function jsevtchk(sns){
	<% if Date() < "2015-11-23" or Date() > "2015-12-06" then %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% else %>
		if(sns =="kk"){
			alert('카카오톡은 모바일에서 가능합니다.');
			return false;
		}else if(sns =="ln"){
			alert('라인은 모바일에서 가능합니다.');
			return false;
		}else{
			var result;
			$.ajax({
				type:"GET",
				url:"/event/etc/doeventsubscript/doEventSubscript67488.asp",
				data: "mode=2015xmas&sns="+sns,
				dataType: "text",
				async:false,
				cache:false,
				success : function(Data){
					result = jQuery.parseJSON(Data);
					if (result.resultcode=="11")
					{
						if(sns=="tw") {
							popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
							return false;
						}else if(sns=="fb"){
							popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
							return false;
						}else if(sns=="kk"){
							alert('카카오톡은 모바일에서 가능합니다.');
							return false;
						}else if(sns=="ln"){
							alert('라인은 모바일에서 가능합니다.');
							return false;
						}else{
							alert('오류가 발생했습니다.');
							return false;
						}
					}
					else if (result.resultcode=="44")
					{
						if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
							var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
							winLogin.focus();
							return;
						}
					}
					else if (result.resultcode=="88")
					{
						alert("이벤트 기간이 아닙니다.");
						return;
					}
				}
			});
		}
	<% end if %>
}

function jsevtmochk(sns){
	if (sns=="kk"){
		alert('카카오톡은 모바일에서 가능합니다.');
		return false;
	}else if(sns=="ln"){
		alert('라인은 모바일에서 가능합니다.');
		return false;
	}else{
		alert('오류가 발생했습니다.');
		return false;
	}
}
</script>
	<div class="contF contW">
		<div class="christmas2015">
			<div class="christmasHead">
				<div class="christmasCont">
					<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/txt_date.png" alt="2015.11.23~12.25" /></p>
					<p class="gold"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_gold_magic.png" alt="GOLD MAGIC" /></p>
					<p class="laurel"></p>
					<p class="year"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_2015.png" alt="2015" /></p>
					<h2>
						<a href="/event/eventmain.asp?eventid=67483">
							<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_c.png" alt="C" /></span>
							<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_h.png" alt="H" /></span>
							<span class="t03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_r.png" alt="R" /></span>
							<span class="t04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_i.png" alt="I" /></span>
							<span class="t05"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_s.png" alt="S" /></span>
							<span class="t06"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_t.png" alt="T" /></span>
							<span class="t07"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_m.png" alt="M" /></span>
							<span class="t08"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_a.png" alt="A" /></span>
							<span class="t09"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_s.png" alt="S" /></span>
							<span class="deco"></span>
						</a>
					</h2>
					<p class="copy"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/txt_copy.png" alt="품격있는 컬러로 완성하는 크리스마스 데커레이션" /></p>
				</div>
				<div class="navigator">
					<ul>
						<li class="styling"><a href="/event/eventmain.asp?eventid=67483">CHRISTMAS STYLING</a></li>
						<li class="party"><a href="/event/eventmain.asp?eventid=67485">MAKE PARTY</a></li>
						<li class="present"><a href="/event/eventmain.asp?eventid=67487">SPECIAL PRESENT</a></li>
						<li class="enjoy current" onclick="return false;"><a href="">EVJOY TOGETHER<em>참여</em></a></li>
					</ul>
				</div>
				<div class="snow"></div>
			</div>
			<%''// 참여이벤트 #1 %>
			<div class="enjoyTogether">
				<div class="enjoyV1">
					<div class="christmasCont">
						<%''// 공유하기 %>
						<div class="shareGoldmagic">
							<p class="evtCont"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/tit_apply.png" alt="텐바이텐과 함께 하는 2015 크리스마스" /></p>
							<button class="btnShare"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/btn_share.png" alt="공유하기" /></button>
							<p class="count">
								<img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/txt_count_01.png" alt="지금까지" />
								<strong><%= vTotalCount %></strong><img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/txt_count_02.png" alt="명이 참여해 주셨습니다!" />
							</p>
						</div>
						<%''// 핫 아이템 %>
						<div class="hotItem">
							<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/tit_hot_item.png" alt="2015 CHRISTMAS HOT ITEMS" /></h3>
							<div class="slide">
								<div>
									<img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/img_item_01.jpg" alt="" usemap="#map01" />
									<map name="map01" id="map01">
										<area shape="rect" coords="11,13,464,214" href="/shopping/category_prd.asp?itemid=1382461" />
										<area shape="rect" coords="12,275,224,478" href="/shopping/category_prd.asp?itemid=1313573" />
										<area shape="rect" coords="253,274,463,478" href="/shopping/category_prd.asp?itemid=1164910" />
										<area shape="rect" coords="492,12,939,476" href="/shopping/category_prd.asp?itemid=1360932" />
									</map>
								</div>
								<div>
									<img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/img_item_02.jpg" alt="" usemap="#map02" />
									<map name="map02" id="map02">
										<area shape="rect" coords="11,13,464,214" href="/shopping/category_prd.asp?itemid=1377386" />
										<area shape="rect" coords="12,275,224,478" href="/shopping/category_prd.asp?itemid=1394378" />
										<area shape="rect" coords="253,274,463,478" href="/shopping/category_prd.asp?itemid=1391090" />
										<area shape="rect" coords="492,12,939,476" href="/shopping/category_prd.asp?itemid=1395256" />
									</map>
								</div>
								<div>
									<img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/img_item_03.jpg" alt="" usemap="#map03" />
									<map name="map03" id="map03">
										<area shape="rect" coords="11,13,464,214" href="/shopping/category_prd.asp?itemid=1394183" />
										<area shape="rect" coords="12,275,224,478" href="/shopping/category_prd.asp?itemid=1383404" />
										<area shape="rect" coords="253,274,463,478" href="/shopping/category_prd.asp?itemid=968645" />
										<area shape="rect" coords="492,12,939,476" href="/shopping/category_prd.asp?itemid=1382922" />
									</map>
								</div>
							</div>
						</div>

					</div>
				</div>
				<%''// 공유하기 레이어팝업 %>
				<div id="shareLayer" class="shareLayer">
					<div class="layerCont">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/txt_share.png" alt="sns 채널에 2개 이상 공유하시면 이벤트에 자동 응모됩니다!" /></p>
						<ul class="goShare">
							<li><a href="" onclick="jsevtchk('fb'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/ico_facebook.png" alt="페이스북" /></a></li>
							<li><a href="" onclick="jsevtchk('tw'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/ico_twitter.png" alt="트위터" /></a></li>
							<li><a href="" onclick="jsevtmochk('kk'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/ico_kakaotalk.png" alt="카카오톡" /></a></li>
							<li><a href="" onclick="jsevtmochk('ln'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/ico_line.png" alt="라인" /></a></li>
						</ul>
						<button class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67488/btn_close.png" alt="닫기" /></button>
					</div>
				</div>
				<%''// 공유하기 레이어팝업 %>
			</div>
			<%''// //참여이벤트 #1 %>
		</div>

	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->