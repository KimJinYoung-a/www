<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : PLAY 29 W
' History : 2016-04-08 이종화 생성
'####################################################
Dim eCode , userid , strSql , totcnt , pagereload , totcntall
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66113
Else
	eCode   =  70358
End If

	pagereload	= requestCheckVar(request("pagereload"),2)
	userid = GetEncLoginUserID()

'// 이벤트 진행 여부
	strSql = "select "
	strSql = strSql & " count(*) "
	strSql = strSql & " from db_event.dbo.tbl_event_subscript"
	strSql = strSql & "	where evt_code = '"& eCode &"' " 
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		totcntall = rsget(0)
	End IF
	rsget.close()

If IsUserLoginOK Then 
	'// 이벤트 진행 여부
	strSql = "select "
	strSql = strSql & " count(*) "
	strSql = strSql & " from db_event.dbo.tbl_event_subscript"
	strSql = strSql & "	where userid = '"& userid &"' and evt_code = '"& eCode &"' " 
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		totcnt = rsget(0)
	End IF
	rsget.close()
End If

Dim snpTitle, snpLink, snpPre, snpTag, snpTag2
	snpTitle = Server.URLEncode("오분 분양중 5분의 여유가 필요한 당신에게,오분을 분양해드립니다.")
	snpLink = Server.URLEncode("http://www.10x10.co.kr/play/playGround.asp?gidx=29&gcidx=121")
	snpPre = Server.URLEncode("텐바이텐")
	snpTag = Server.URLEncode("텐바이텐 " & Replace("#29 스물아홉 번째 이야기 TIME"," ",""))
	snpTag2 = Server.URLEncode("#10x10")
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background:#fff3f2;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}

img {vertical-align:top;}

.fiveMinutes button {background-color:transparent;}

.topic {height:707px; background:#f26e61 url(http://webimage.10x10.co.kr/play/ground/20160425/bg_pattern_comb.png) repeat 0 0;}
.topic h3 {position:absolute; top:154px; left:50%; width:252px; height:399px; margin-left:-342px;}
.topic h3 span {position:absolute;}
.topic h3 .letter1 {top:0; left:0;}
.topic h3 .letter2,
.topic h3 .letter3,
.topic h3 .letter4,
.topic h3 .letter5 {width:125px; height:152px; background:url(http://webimage.10x10.co.kr/play/ground/20160425/tit_5_minutes.png) no-repeat 0 0; text-indent:-9999em;}
.topic h3 .letter2 {top:47px; left:1px;}
.topic h3 .letter3 {top:47px; right:1px; background-position:100% 0;}
.topic h3 .letter4 {top:207px; left:1px; background-position:0 100%;}
.topic h3 .letter5 {top:209px; right:8px; background-position:100% 100%;}
.topic h3 .letter6 {bottom:0; left:0;}
.topic .underline {animation-name:underline; animation-iteration-count:1; animation-duration:1.2s; animation-fill-mode:both; animation-delay:1s;}
@keyframes underline {
	0% {transform:scaleX(0);}
	100% {transform:scaleX(1);}
}

@keyframes pulse {
	0% {transform:scale(1.5);}
	100% {transform:scale(1);}
}
.pulse {animation-name:pulse; animation-duration:0.8s; animation-iteration-count:1; animation-delay:1.6s;}

.topic p {position:absolute; top:235px; left:50%; margin-left:-34px;}
.topic .close {position:absolute; top:392px; left:50%; margin-left:223px;}

.recommend {padding:80px 0 453px; text-align:center;}
.recommend h4 {position:relative; width:849px; height:86px; margin:0 auto;}
.recommend h4 span {position:absolute; bottom:0; left:0; width:100%; height:2px; background-color:#000;}
.recommend p {margin-top:47px;}

.kit {position:relative; height:700px; background:#f26e61 url(http://webimage.10x10.co.kr/play/ground/20160425/bg_pattern_comb.png) repeat 0 0;}
.slide {position:absolute; top:-340px; left:50%; width:1140px; height:730px; margin-left:-570px; padding:0 22px 22px 0; background:url(http://webimage.10x10.co.kr/play/ground/20160425/bg_box.png) no-repeat 0 0;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:107px; height:100px; margin-top:-50px; background:url(http://webimage.10x10.co.kr/play/ground/20160425/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:0;}
.slide .slidesjs-next {right:0; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:78px; left:50%; z-index:50; width:399px; margin-left:-200px;}
.slidesjs-pagination li {float:left; padding:0 6px;}
.slidesjs-pagination li a {display:block; width:45px; height:5px; background-color:#d7d7d7; transition:0.5s ease; text-indent:-999em;}
.slidesjs-pagination li a.active {background-color:#ef7063;}
.slide .desc {position:absolute; top:265px; left:50%; z-index:50; margin-left:-118px;}
.kit .intro {position:absolute; bottom:66px; left:50%; margin-left:-477px;}

.find {position:relative; height:932px; background:#f2f2f2 url(http://webimage.10x10.co.kr/play/ground/20160425/img_item.jpg) no-repeat 50% 0; text-align:center;}
.find h4 {position:absolute; top:144px; left:50%; margin-left:-495px;}

.apply {height:498px; padding-top:136px; background:#ffe3e0 url(http://webimage.10x10.co.kr/play/ground/20160425/bg_pattern_line.png) no-repeat 50% 0; text-align:center;}
.apply .btnApply {display:block; width:359px; margin:50px auto 0;}
.apply .applyAfter {position:relative;}
.apply .applyAfter span {position:absolute; top:0; left:0;}
.apply .btnApply span {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:1s; animation-fill-mode:both;}
@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}

.apply .count {margin-top:75px;}
.apply .count strong {margin:0 10px 0 19px; color:#f26e61; font-family:'Verdana'; font-size:30px; font-weight:normal; line-height:36px;}

.shareSns {position:relative; background-color:#f26e61; height:159px;}
.shareSns .line {position:absolute; top:0; left:0; width:100%; height:5px; background-color:#eb3b30;}
.shareSns .inner {border-top:5px solid #fff;}
.shareSns h4 {position:absolute; top:71px; left:50%; margin-left:-452px;}
.shareSns ul {overflow:hidden; position:absolute; top:55px; left:50%; margin-left:10px;}
.shareSns ul li {float:left; margin-right:2px;}
.shareSns ul li a:hover img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.7s;}
@keyframes bounce {
	from, to{margin-top:5px; animation-timing-function:ease-out;}
	50% {margin-top:0; animation-timing-function:ease-in;}
}

.floater {animation-name:floater; animation-timing-function:ease-in-out; animation-iteration-count:infinite; animation-duration:5s; animation-direction:alternate;}
@keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}
</style>
<script type="text/javascript">
$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 50 ) {
			animation();
		}
		if (scrollTop > 3600 ) {
			animation2();
		}
	});

	$("#animation h3 span").css({"opacity":"0"});
	$("#animation h3 .letter2").css({"top":"100px", "left":"30px", "opacity":"0"});
	$("#animation h3 .letter3").css({"top":"100px", "right":"30px", "opacity":"0"});
	$("#animation h3 .letter4").css({"top":"207px", "left":"30px", "opacity":"0"});
	$("#animation h3 .letter5").css({"top":"207px", "right":"30px", "opacity":"0"});
	$("#animation .close").css({"opacity":"0"});
	function animation () {
		$("#animation h3 .letter1").delay(600).animate({"opacity":"1"},800);
		$("#animation h3 .letter6").delay(600).animate({"opacity":"1"},800);
		$("#animation h3 .letter1").delay(10).addClass("underline");
		$("#animation h3 .letter6").delay(10).addClass("underline");
		$("#animation h3 .letter2").delay(10).animate({"top":"47px", "left":"1px", "opacity":"1"},800);
		$("#animation h3 .letter3").delay(10).animate({"top":"47px", "right":"8px", "opacity":"1"},800);
		$("#animation h3 .letter4").delay(10).animate({"top":"207px", "left":"1px", "opacity":"1"},800);
		$("#animation h3 .letter5").delay(10).animate({"top":"207px", "right":"8px", "opacity":"1"},800);
		$("#animation .close").delay(1300).animate({"opacity":"1"},1000);
		$("#animation .close").delay(10).addClass("pulse");
		$("#animation .close").delay(1000).effect("pulsate", {times:3},400);
	}

	$(".shareSns .line").css({"width":"0"});
	function animation2 () {
		$(".shareSns .line").delay(10).animate({"width":"100%"},1000);
	}

	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"730",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2300, effect:"fade", auto:true},
		effect:{fade: {speed:800}},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
});
</script>
<script type="text/javascript">
<!--
$(function(){
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#vote").offset().top}, 0);
}

function vote_play(){
	var frm = document.frmvote;
	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% end if %>

	<% If not(left(now(),10)>="2016-04-25" and left(now(),10)<"2016-05-04" ) Then %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% else %>
		<% if totcnt > 0 then %>
			alert("한 개의 아이디당 1회까지 응모가 가능 합니다.");
			return;
		<% else %>
			alert("분양이 완료 되었습니다.");
			frm.action = "/play/groundsub/doEventSubscript70358.asp";
			frm.target="frmproc";
			frm.submit();
			return;
		<% end if %>
	<% end if %>
}
//-->
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20160418 fiveMinutes">
			<div id="animation" class="topic">
				<h3>
					<span class="letter1"><img src="http://webimage.10x10.co.kr/play/ground/20160425/bg_line_bar.png" alt="" /></span>
					<span class="letter2">오</span>
					<span class="letter3">분</span>
					<span class="letter4">분</span>
					<span class="letter5">양</span>
					<span class="letter6"><img src="http://webimage.10x10.co.kr/play/ground/20160425/bg_line_bar.png" alt="" /></span>
				</h3>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160425/txt_need_time_v1.png" alt="절찬리에 오 분분 양 중 시간이 더 필요한 당신에게" /></p>
				<em class="close"><img src="http://webimage.10x10.co.kr/play/ground/20160425/txt_close.png" alt="마감임박" /></em>
			</div>

			<div class="recommend">
				<h4>
					<img src="http://webimage.10x10.co.kr/play/ground/20160425/tit_recomment.gif" alt="이런 분에게 추천합니다!" />
					<span></span>
				</h4>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160425/txt_recommend.png" alt="밥먹는 시간도 아껴서 5분이라도 더 자고 싶은 분, 에스컬레이터 속도가 답답해 기어이 걸어서 올라가는 분 가끔은 감쪽같이 앞머리만 감고 머리 감고 온 척 하는 분" /></p>
			</div>

			<div class="kit">
				<div id="slide" class="slide">
					<p><a href="/shopping/category_prd.asp?itemid=1450684&amp;pEtr=70358" title="간편한 식사 랩노쉬 상품보러 가기"><img src="http://webimage.10x10.co.kr/play/ground/20160425/img_slide_01_v1.jpg" alt="밥 먹는 시간이라도 다이어트" /></a></p>
					<p><a href="/shopping/category_prd.asp?itemid=724721&amp;pEtr=70358" title="프린시페샤 노트 브리즈 드라이샴푸 상품보러 가기"><img src="http://webimage.10x10.co.kr/play/ground/20160425/img_slide_02.jpg" alt="머리 감는 시간도 아까워. 드라이 샴푸" /></a></p>
					<p><a href="/shopping/category_prd.asp?itemid=1256190&amp;pEtr=70358" title="샤오미 보조배터리 상품보러 가기"><img src="http://webimage.10x10.co.kr/play/ground/20160425/img_slide_03.jpg" alt="오가는 길에 충전 100%" /></a></p>
					<p><a href="/shopping/category_prd.asp?itemid=1456177&amp;pEtr=70358" title="머리를 빨리 말려주는 아임굿즈 3분 장갑 상품보러 가기"><img src="http://webimage.10x10.co.kr/play/ground/20160425/img_slide_04.jpg" alt="누구보다 빠르게 남들과는 다르게" /></a></p>
					<p><a href="/shopping/category_prd.asp?itemid=1013727&amp;pEtr=70358" title="자일리톨이 함유된 1회용 씹는 칫솔 4개입 상품보러 가기"><img src="http://webimage.10x10.co.kr/play/ground/20160425/img_slide_05.jpg" alt="입안에만 넣으면 양치질 끝 !" /></a></p>
					<p><a href="/shopping/category_prd.asp?itemid=1438033&amp;pEtr=70358" title="파켈만 사과조각기 상품보러 가기"><img src="http://webimage.10x10.co.kr/play/ground/20160425/img_slide_06.jpg" alt="한번에 사과 나누고 시간도 나누고!" /></a></p>
					<p><a href="/giftcard/" title="기프트카드 페이지로 이동"><img src="http://webimage.10x10.co.kr/play/ground/20160425/img_slide_07.jpg" alt="고르기만 하면 되, 스피드한 결제!" /></a></p>
				</div>

				<p class="intro"><img src="http://webimage.10x10.co.kr/play/ground/20160425/txt_intro.png" alt="오분분양 키트의 특징은 시간 절약의 일등공신, 씽크빅 돋는 아이디어 상품, 사랑스러운 핑크빛 컬러" /></p>
			</div>

			<div class="find">
				<h4 class="floater"><img src="http://webimage.10x10.co.kr/play/ground/20160425/tit_find.png" alt="24시간이 모자란 당신께 오분의 여유를 찾아드립니다." /></h4>
				<img src="http://webimage.10x10.co.kr/play/ground/20160425/txt_item_v1.jpg" alt="" usemap="#itemlink" />
				<map name="itemlink" id="itemlink">
					<area shape="rect" coords="463,145,780,345" href="/shopping/category_prd.asp?itemid=1438033&pEtr=70358" alt="파켈만 사과조각기" />
					<area shape="rect" coords="817,228,1091,326" href="/shopping/category_prd.asp?itemid=1013727&pEtr=70358" alt="퍼지브러쉬 씹는 칫솔 4개입" />
					<area shape="rect" coords="793,334,978,457" href="/giftcard/" alt="텐바이텐 기프트카드 3만원 권" />
					<area shape="rect" coords="391,350,520,677" href="/shopping/category_prd.asp?itemid=1450684&pEtr=70358" alt="랩노쉬 쉐이크" />
					<area shape="rect" coords="568,370,721,596" href="/shopping/category_prd.asp?itemid=1256190&pEtr=70358" alt="샤오미 보조배터리 5000mAh" />
					<area shape="rect" coords="739,469,1096,840" href="/shopping/category_prd.asp?itemid=1456177&pEtr=70358" alt="아임굿즈 3분 헤어 장갑" />
					<area shape="rect" coords="522,599,725,761" href="/shopping/category_prd.asp?itemid=724721&pEtr=70358" alt="프린시페샤 드라이 샴푸" />
				</map>
			</div>

			<!-- 신청하기 -->
			<div class="apply">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160425/txt_apply.png" alt="소중한 시간을 세이브- 해드립니다. 지금 바로 신청하세요 ! 단 오분에게만 드리는 오분 분양권! 소중한 시간을 세이브- 해드립니다. 지금 바로 신청하세요 ! 오분분양 신청기간은 4월 25일부터 5월 3일까지며, 당첨자 발표는 5월 4일입니다." /></p>
				<% If totcnt > 0 Then %>
				<p class="btnApply applyAfter">
					<img src="http://webimage.10x10.co.kr/play/ground/20160425/btn_apply_done.png" alt="" />
					<span><img src="http://webimage.10x10.co.kr/play/ground/20160425/txt_apply_done.png" alt="분양이 신청되었습니다" /></span>
				</p>
				<% Else %>
				<button type="button" class="btnApply applyBefore" onclick="vote_play();"><img src="http://webimage.10x10.co.kr/play/ground/20160425/btn_apply.png" alt="오분분양 키트 신청하기" /></button>
				<% End If %>

				<p class="count">
					<img src="http://webimage.10x10.co.kr/play/ground/20160425/txt_count_01.png" alt="총"/>
					<strong><%=FormatNumber(totcntall,0)%></strong>
					<img src="http://webimage.10x10.co.kr/play/ground/20160425/txt_count_02.png" alt="명 분양 중"/>
				</p>
			</div>

			<div class="shareSns">
				<div class="line"></div>
				<div class="inner">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20160425/tit_sns.png" alt="오분분양 소식을 공유해주세요!" /></h4>
					<ul>
						<li><a href="#" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160425/btn_twitter.png" alt="트위터에 공유하기" /></a></li>
						<li><a href="#" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160425/btn_facebook.png" alt="페이스북에 공유하기" /></a></li>
					</ul>
				</div>
			</div>
		</div>
<form name="frmvote" method="post">
<input type="hidden" name="mode" value="add"/>
<input type="hidden" name="sub_opt1" id="sub_opt1" value=""/>
<input type="hidden" name="pagereload" value="ON"/>
</form>
<iframe id="frmproc" name="frmproc" frameborder="0" width=0 height=0></iframe>
<!-- #include virtual="/lib/db/dbclose.asp" -->