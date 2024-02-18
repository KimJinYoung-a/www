<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
Dim eCode, userid, vQuery
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "63791"
Else
	eCode   =  "63798"
End If

userid = getloginuserid()

Dim strSql, enterCnt, sakuraCnt, overseasCnt, i, totalCnt

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		enterCnt = rsget(0)
	End IF
	rsget.close

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		totalCnt = rsget(0)
	End IF
	rsget.close

	i = 0

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundHeadWrap {width:100%; background:#ebeae8;}
.groundCont {padding-bottom:0; background:#f6f5f5;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:130px 20px 60px;}
img {vertical-align:top;}
.laundryCont {position:relative; width:1140px; margin:0 auto;}
.intro {height:927px; background:#f0efec url(http://webimage.10x10.co.kr/play/ground/20150622/bg_intro.png) 50% 0 no-repeat;}
.intro .tit {position:absolute; left:50%; top:346px; margin-left:-390px; width:782px; overflow:hidden;}
.intro .tit p {position:relative; height:119px; margin-bottom:35px;}
.intro .tit span {display:inline-block; position:absolute; top:0;  margin-left:-20px; opacity:0; z-index:50;}
.intro .tit span.t01 {left:0; margin-left:-10px;}
.intro .tit span.t02 {left:108px;}
.intro .tit span.t03 {left:197px;}
.intro .tit span.t04 {left:712px;}
.intro .tit span.t05 {left:0;}
.intro .tit span.t06 {left:108px;}
.intro .tit span.t07 {left:197px;}
.intro .tit span.t08 {left:305px;}
.intro .tit span.t09 {left:408px;}
.intro .tit span.t10 {left:515px;}
.intro .tit span.t11 {left:619px;}
.intro .tit span.t12 {left:712px;}
.intro .tit span.wave {display:block; left:305px; top:14px; width:0; height:89px; opacity:1; margin:0; background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_wave.png) 0 50% repeat-x;}
.purpose {height:550px; background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_pattern.gif) 0 0 repeat;}
.purpose .laundryCont div {padding:107px 0 0 63px;}
.purpose .goLaundry {display:block; position:absolute; right:40px; top:234px; width:233px; height:237px; background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_btn_go.png) 0 0 no-repeat;}
.purpose .goLaundry span {display:block; position:absolute; left:40px; top:90px; width:137px; height:60px; background:url(http://webimage.10x10.co.kr/play/ground/20150622/txt_go_laundry.gif) 0 0 no-repeat; text-indent:-9999px;}
.interview .section { border-bottom:2px solid #000; background:#fff;}
.interview .section .laundryCont {height:647px;}
.interview .storyA .laundryCont {background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_interview01.jpg) 100% 0 no-repeat;}
.interview .storyB .laundryCont {background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_interview02.jpg) 0 0 no-repeat;}
.interview .section p {position:absolute; opacity:0; margin-left:10px;}
.interview .storyA p {left:63px; top:191px;}
.interview .storyB p {left:842px; top:179px;}
.package {text-align:center;}
.package .txt {position:relative; padding:62px 0; background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_pattern02.gif) 0 0 repeat;}
.package .arrow {display:inline-block; position:absolute; left:50%; bottom:-19px; z-index:30;}
.composition {height:1782px; padding:138px 0 0; background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_package_info.jpg) 50% -1px no-repeat;}
.composition h3 {position:relative; width:846px; height:194px; margin:0 auto;}
.composition h3 p {position:absolute; left:0; top:0;}
.composition ul {overflow:hidden; width:1130px; margin:0 auto; padding-top:80px;}
.composition li {float:left; padding:0 27px;}
.composition .line {margin:38px auto 37px; width:782px; height:152px;}
.composition .line div {height:8px; background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_line02.png) 0 0 no-repeat;}
.composition .box {width:790px; margin:0 auto;}
.composition .box div {opacity:0;}
.composition .box p {text-align:right; padding-top:14px;}
.slide {position:relative; width:100%;}
.slide img {width:100%;}
.slide .slidesjs-pagination {overflow:hidden; position:absolute; bottom:65px; left:50%; width:260px; height:13px; margin-left:-128px; z-index:30;}
.slide .slidesjs-pagination li {float:left; padding:0 15px;}
.slide .slidesjs-pagination li a {display:inline-block; width:13px; height:13px; background:url(http://webimage.10x10.co.kr/play/ground/20150622/btn_pagination.png); text-indent:-9999px;}
.slide .slidesjs-pagination li a.active {background-position:100% 0;}
.applyPackage {padding:100px 0; background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_pattern.gif) 0 0 repeat;}
.applyPackage .laundryCont {overflow:hidden;}
.applyPackage .ftRt {padding-top:40px;}
.applyPackage .btnApply {position:relative; width:311px; height:289px; background:url(http://webimage.10x10.co.kr/play/ground/20150622/btn_apply.png) 0 0 no-repeat;}
.applyPackage .btnApply a {display:block; position:absolute; left:30px; top:85px; width:160px; height:160px; text-indent:-9999px;}
.laundryList {padding:120px 0; text-align:center; background:#fff url(http://webimage.10x10.co.kr/play/ground/20150622/bg_line.gif) 0 289px repeat-x;}
.laundryList .total {padding-bottom:118px;}
.laundryList .total strong {display:inline-block; position:relative; top:-2px; padding:0 5px 0 13px; font-size:50px; line-height:44px; color:#242424; vertical-align:middle; font-family:helvetica; font-weight:normal;}
.laundryList .total img {vertical-align:middle;}
.laundryList ul {position:relative; height:245px;}
.laundryList li {position:absolute; top:0; width:240px; height:245px; font-size:13px; color:#000;}
.laundryList li .bg {position:absolute; left:0; top:0; width:240px; height:245px; background-position:0 0; background-repeat:no-repeat;}
.laundryList li.s01 .bg {background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_shirt01.png)}
.laundryList li.s02 .bg {background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_shirt02.png)}
.laundryList li.s03 .bg {background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_shirt03.png)}
.laundryList li.s04 .bg {background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_shirt04.png)}
.laundryList li.shirt01 {left:16px;}
.laundryList li.shirt02 {left:306px;}
.laundryList li.shirt03 {left:595px;}
.laundryList li.shirt04 {left:885px;}
.laundryList li .num {padding:77px 0 48px;}
.laundryList li .writer strong {display:block; padding-bottom:3px; color:#d32a2a;}
.brandStory .laundryCont {width:1020px; padding-top:130px;}
.brandStory h3 {padding-bottom:24px;}
.brandStory .detergentInfo {overflow:hidden; height:473px; padding:1px; background:url(http://webimage.10x10.co.kr/play/ground/20150622/bg_box.gif) 0 0 no-repeat;}
.brandStory .detergentInfo .ftLt {width:509px;}
.brandStory .detergentInfo .ftRt {width:508px;}
.brandStory .detergentInfo .pdt {position:relative; cursor:pointer;}
.brandStory .detergentInfo .pdt .on {display:none; position:absolute; left:0; top:0;}
.brandStory .detergentInfo .pdt .on a {display:block; position:absolute; left:50%; top:50%; margin:-136px 0 0 -136px;}

/* animation */
.laundryList li.shirt01 .bg {-webkit-animation: swinging 4s ease-in-out 0s infinite; -moz-animation: swinging 4s ease-in-out 0s infinite;  -ms-animation: swinging 4s ease-in-out 0s infinite;}
.laundryList li.shirt02 .bg {-webkit-animation: swinging 6s ease-in-out 0s infinite; -moz-animation: swinging 6s ease-in-out 0s infinite; -ms-animation: swinging 6s ease-in-out 0s infinite;}
.laundryList li.shirt03 .bg {-webkit-animation: swinging 9s ease-in-out 0s infinite; -moz-animation: swinging 9s ease-in-out 0s infinite; -ms-animation: swinging 9s ease-in-out 0s infinite;}
.laundryList li.shirt04 .bg {-webkit-animation: swinging 5s ease-in-out 0s infinite; -moz-animation: swinging 5s ease-in-out 0s infinite; -ms-animation: swinging 5s ease-in-out 0s infinite;}
@-webkit-keyframes swinging {0% {-webkit-transform:rotate(0);} 40%{-webkit-transform:rotate(-2deg);} 75%{-webkit-transform:rotate(2deg);} 100%{-webkit-transform:rotate(0);}}
@-moz-keyframes swinging {0%{-moz-transform:rotate(0);} 40%{-moz-transform:rotate(-2deg);} 75%{-moz-transform:rotate(2deg);} 100%{-moz-transform:rotate(0);}}
@-ms-keyframes swinging {0%{-ms-transform:rotate(0);} 40%{-ms-transform:rotate(-2deg);} 75%{-ms-transform:rotate(2deg);} 100%{-ms-transform:rotate(0);}}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">

function jsSubmit11(){
	<% if Not(IsUserLoginOK) then %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
	document.frmcom.submit();
}


function jsSubmit(){
	<% if Not(IsUserLoginOK) then %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
	var rstStr = $.ajax({
		type: "POST",
		url: "/play/groundsub/doEventSubscript63798.asp",
		dataType: "text",
		async: false
	}).responseText;
	if (rstStr!=""){
		var enterCnt;
		var strArray;
		strArray = rstStr.split('!/!');

		if (strArray[0]=="01")
		{
			$("#uCnt").empty().html(strArray[1]);
			$("#uCleaning").empty();
			$("#uCleaning").html(""+strArray[2]+"");
			$('.laundryList li:nth-child(1)').addClass('shirt01');
			$('.laundryList li:nth-child(2)').addClass('shirt02');
			$('.laundryList li:nth-child(3)').addClass('shirt03');
			$('.laundryList li:nth-child(4)').addClass('shirt04');
			var randomMan = [ 's01', 's02', 's03', 's04'];
			var manSort = randomMan.sort(function(){
				return Math.random() - Math.random();
			});
			$('.laundryList li').each( function(index,item){
				$(this).addClass(manSort[index]);
			});
			return false;
		}
		else
		{
			alert(strArray[1]);
			return false;
		}
	}else{
		alert('관리자에게 문의');
		return false;
	}
}

$(function(){
	$('.slide').slidesjs({
		width:"1919",
		height:"1005",
		navigation:false,
		pagination:{effect:"fade"},
		play: {interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:600, crossfade:true}
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
	function intro () {
		$('.intro .tit .t01').animate({"margin-left":"0", "opacity":"1"}, 600);
		$('.intro .tit .t02').delay(300).animate({"margin-left":"0", "opacity":"1"}, 800);
		$('.intro .tit .t03').delay(400).animate({"margin-left":"0", "opacity":"1"}, 800);
		$('.intro .tit .wave').delay(500).animate({"width":"378px"}, 1800);
		$('.intro .tit .t04').delay(2100).animate({"margin-left":"0", "opacity":"1"}, 800);
		$('.intro .tit .t05').delay(2800).animate({"margin-left":"0", "opacity":"1"}, 800);
		$('.intro .tit .t06').delay(2900).animate({"margin-left":"0", "opacity":"1"}, 800);
		$('.intro .tit .t07').delay(3000).animate({"margin-left":"0", "opacity":"1"}, 800);
		$('.intro .tit .t08').delay(3100).animate({"margin-left":"0", "opacity":"1"}, 800);
		$('.intro .tit .t09').delay(3200).animate({"margin-left":"0", "opacity":"1"}, 800);
		$('.intro .tit .t10').delay(3300).animate({"margin-left":"0", "opacity":"1"}, 800);
		$('.intro .tit .t11').delay(3400).animate({"margin-left":"0", "opacity":"1"}, 800);
		$('.intro .tit .t12').delay(3500).animate({"margin-left":"0", "opacity":"1"}, 800);
	}
	function shakeTitle (){
		conChk = 1;
		$('.composition h3 p').effect( "bounce", {times:2}, 1000);
	}
	$(".goLaundry").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
	$('.laundryList li:nth-child(1)').addClass('shirt01');
	$('.laundryList li:nth-child(2)').addClass('shirt02');
	$('.laundryList li:nth-child(3)').addClass('shirt03');
	$('.laundryList li:nth-child(4)').addClass('shirt04');
	$('.btnApply a').click(function(){
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 1200);
		$('.laundryList li').animate({"margin-left":"-10px", "opacity":"0"}, 500);
		$('.laundryList li.shirt01').delay(100).animate({"margin-left":"0px", "opacity":"1"}, 300);
		$('.laundryList li.shirt02').delay(300).animate({"margin-left":"0px", "opacity":"1"}, 300);
		$('.laundryList li.shirt03').delay(450).animate({"margin-left":"0px", "opacity":"1"}, 300);
		$('.laundryList li.shirt04').delay(650).animate({"margin-left":"0px", "opacity":"1"}, 300);
		return false;
	});
	var randomMan = [ 's01', 's02', 's03', 's04'];
	var manSort = randomMan.sort(function(){
		return Math.random() - Math.random();
	});
	$('.laundryList li').each( function(index,item){
		$(this).addClass(manSort[index]);
	});

	// brand story
	$('.detergentInfo .pdt').mouseover(function(){
		$(this).children('.on').fadeIn(300);
	});
	$('.detergentInfo .pdt').mouseleave(function(){
		$(this).children('.on').fadeOut(200);
	});
	var conChk = 0;
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 400 ) {
			intro();
		}
		if (scrollTop > 1900 ) {
			$('.interview .storyA p').animate({"margin-left":"0", "opacity":"1"}, 700);
		}
		if (scrollTop > 2500 ) {
			$('.interview .storyB p').animate({"margin-left":"0", "opacity":"1"}, 700);
		}
		if (scrollTop > 3600 ) {
			if (conChk==0){
				shakeTitle();
			}
		}
		if (scrollTop > 4050 ) {
			$('.composition .line div').animate({"height":"152px"}, 1500);
			$('.composition .box div').delay(1500).animate({"opacity":"1"}, 1000);
		}
	});
});
var scrollSpeed =15;
var current = 0;
var direction = 'h';
function bgscroll(){
	current -= 1;
	$('.wave').css("backgroundPosition", (direction == 'h') ? current+"px 0" : "0 " + current+"px");
}
setInterval("bgscroll()", scrollSpeed);

</script>
</head>
<body>

		<!-- T-SHIRTS #3 -->
		<div class="playGr20150622">
			<div class="intro">
				<div class="laundryCont">
					<div class="tit">
						<p>
							<span class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_p.png" alt="P" /></span>
							<span class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_l.png" alt="L" /></span>
							<span class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_a.png" alt="A" /></span>
							<span class="wave"></span>
							<span class="t04"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_y.png" alt="Y" /></span>
						</p>
						<p>
							<span class="t05"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_10x10.png" alt="10X10" /></span>
							<span class="t06"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_l.png" alt="L" /></span>
							<span class="t07"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_a.png" alt="A" /></span>
							<span class="t08"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_u.png" alt="U" /></span>
							<span class="t09"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_n.png" alt="N" /></span>
							<span class="t10"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_d.png" alt="D" /></span>
							<span class="t11"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_r.png" alt="R" /></span>
							<span class="t12"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_y02.png" alt="Y" /></span>
						</p>
					</div>
				</div>
			</div>
			<div class="purpose">
				<div class="laundryCont">
					<div><p><img src="http://webimage.10x10.co.kr/play/ground/20150622/txt_purpose.png" alt="PLAY LAUNDRY" /></p></div>
					<a href="#applyPackage" class="goLaundry"><span>빨래하러 가기</span></a>
				</div>
			</div>
			<div class="interview">
				<div class="section storyA">
					<div class="laundryCont">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150622/txt_interview01.gif" alt="빨래는 해도 해도 부족하다." /></p>
					</div>
				</div>
				<div class="section storyB">
					<div class="laundryCont">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150622/txt_interview02.gif" alt="빨래는 어렵다." /></p>
					</div>
				</div>
			</div>
			<div class="package">
				<div class="txt">
					<div class="laundryCont">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150622/txt_play_laundry.png" alt="" /></p>
					</div>
					<span class="arrow"><img src="http://webimage.10x10.co.kr/play/ground/20150622/blt_arrow.png" alt="" /></span>
				</div>
				<div class="composition">
					<h3><p><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_package.png" alt="내가 못살아 진짜 PACKAGE" /></p></h3>
					<ul>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_composition01.png" alt="누구보다 정성스러웠던 엄마 손 세제" /></li>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_composition02.png" alt="한없이 부드러웠던 엄마 마음 유연제" /></li>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_composition03.png" alt="포근하게 안아주던 엄마 품 세탁망" /></li>
					</ul>
					<div class="line"><div></div></div>
					<div class="box">
						<div><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_package.jpg" alt="패키지 이미지" /></div>
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150622/txt_package_info_v2.png" alt="패키지에는 테크 간편시트, 아로마시트, 세탁망이 담겨 있습니다." /></p>
					</div>
				</div>
			</div>
			<div class="slide">
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_slide01.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_slide02.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_slide03.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_slide04.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_slide05.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_slide06.jpg" alt="" /></div>
			</div>

			<%' 패키지 신청하기 %>
			<div class="applyPackage" id="applyPackage">
				<div class="laundryCont">
					<div class="ftLt">
						<h3><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_event.png" alt="EVENT" /></h3>
						<p style="padding:38px 0 53px 0;"><img src="http://webimage.10x10.co.kr/play/ground/20150622/txt_event.png" alt="알찬 구성의 '내가 못살아 진짜' PACKAGE로 빨래 하시겠습니까? 추첨을 통해 50분께 패키지를 드립니다." /></p>
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150622/txt_date.png" alt="이벤트 기간 : 2015.06.22~07.06/당첨자발표 : 2015.07.07" /></p>
					</div>
					<div class="ftRt">
						<p class="btnApply"><a href="#blank" onclick="jsSubmit();return false;">신청하기</a></p>
					</div>
				</div>
				<div id="blank"></div>
			</div>
			<div class="laundryList">
				<div class="laundryCont">
					<p class="total">
						<img src="http://webimage.10x10.co.kr/play/ground/20150622/txt_total01.gif" alt="지금까지" />
						<strong><span id="uCnt"><%=enterCnt%></span></strong><img src="http://webimage.10x10.co.kr/play/ground/20150622/txt_total02.gif" alt="명이 빨래를 신청하셨습니다." />
					</p>
					<ul id="uCleaning">
					<%
						vQuery = " Select top 4 * From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' order by sub_idx desc "
						rsget.Open vQuery,dbget,1
						IF Not rsget.Eof Then
							Do Until rsget.eof
					%>
						<li>
							<p class='num'>NO.<% If i = 0 Then response.write totalCnt Else response.write totalCnt - i%></p>
							<p class='writer'><strong><%=printUserId(rsget("userid"),2,"*")%></strong><img src='http://webimage.10x10.co.kr/play/ground/20150622/txt_laundry.gif' alt='님의 빨래' /></p>
							<div class='bg'></div>
						</li> 
					<%
							rsget.movenext
							i = i + 1
							Loop
						End IF
						rsget.close
					%>

					</ul>
				</div>
			</div>
			<%'// 패키지 신청하기 %>
			<div class="brandStory">
				<div class="laundryCont">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_brand_story.gif" alt="BRAND STORY" /></h3>
					<p class="bPad30"><img src="http://webimage.10x10.co.kr/play/ground/20150622/tit_lg_care.gif" alt="LG생활건강-고객의 아름다움과 꿈을 실현하는 최고의 생활문화기업" /></p>
					<div class="detergentInfo">
						<div class="pdt ftLt">
							<img src="http://webimage.10x10.co.kr/play/ground/20150622/img_detergent01.jpg" alt="삶아 빤 듯 깨끗! 테크로 빨면 깨끗!" />
							<p class="on">
								<a href="http://www.beliving.co.kr/web/product/productList.jsp?cate=PD0100&brand=PD0101" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20150622/btn_go_lgcare01.png" alt="테크의 다른제품 구경가기" /></a>
								<span><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_detergent01_over.jpg" alt="테크" /></span>
							</p>
						</div>
						<div class="pdt ftRt">
							<img src="http://webimage.10x10.co.kr/play/ground/20150622/img_detergent02.jpg" alt="대한민국 1등 섬유유연제 샤프란" />
							<p class="on">
								<a href="http://www.beliving.co.kr/web/product/productList.jsp?cate=PD0200&brand=PD0201" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20150622/btn_go_lgcare02.png" alt="샤프란의 다른제품 구경가기" /></a>
								<span><img src="http://webimage.10x10.co.kr/play/ground/20150622/img_detergent02_over.jpg" alt="샤프란" /></span>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- // T-SHIRTS #3 -->

</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->