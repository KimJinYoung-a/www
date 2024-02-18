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
' Description : PLAY 31-1 W 찰떡식물
' History : 2016-06-03 원승현 생성
'####################################################
Dim eCode , userid , strSql , pagereload , totcnt, suncnt, sansecnt, hubcnt, maricnt
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66145
Else
	eCode   =  71150
End If

	'// 총 참여수를 가져온다.
	strSql = "select "
	strSql = strSql & " count(*) "
	strSql = strSql & " from db_event.dbo.tbl_event_subscript"
	strSql = strSql & "	where evt_code = '"& eCode &"' " 
	rsget.Open strSql,dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		totcnt = rsget(0)
	End IF
	rsget.close()

	'// 각 항목별 참여수를 가져온다.
	'// 1-선인장, 2-산세베리아, 3-허브, 4-마리모
	strSql = "select "
	strSql = strSql & " count(*) "
	strSql = strSql & " from db_event.dbo.tbl_event_subscript"
	strSql = strSql & "	where evt_code = '"& eCode &"' And sub_opt2=1 " 
	rsget.Open strSql,dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		suncnt = rsget(0)
	End IF
	rsget.close()

	strSql = "select "
	strSql = strSql & " count(*) "
	strSql = strSql & " from db_event.dbo.tbl_event_subscript"
	strSql = strSql & "	where evt_code = '"& eCode &"' And sub_opt2=2 " 
	rsget.Open strSql,dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		sansecnt = rsget(0)
	End IF
	rsget.close()

	strSql = "select "
	strSql = strSql & " count(*) "
	strSql = strSql & " from db_event.dbo.tbl_event_subscript"
	strSql = strSql & "	where evt_code = '"& eCode &"' And sub_opt2=3 " 
	rsget.Open strSql,dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		hubcnt = rsget(0)
	End IF
	rsget.close()

	strSql = "select "
	strSql = strSql & " count(*) "
	strSql = strSql & " from db_event.dbo.tbl_event_subscript"
	strSql = strSql & "	where evt_code = '"& eCode &"' And sub_opt2=4 " 
	rsget.Open strSql,dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		maricnt = rsget(0)
	End IF
	rsget.close()

Dim snpTitle, snpLink, snpPre, snpTag, snpTag2
	snpTitle = Server.URLEncode("[텐바이텐]식물에 물 주고 찰떡 식물 알아보기!")
	snpLink = Server.URLEncode("http://www.10x10.co.kr/play/playGround.asp?gidx=31&gcidx=126")
	snpPre = Server.URLEncode("텐바이텐")
	snpTag = Server.URLEncode("텐바이텐 " & Replace("#30 서른 한 번째 이야기 WATER"," ",""))
	snpTag2 = Server.URLEncode("#텐바이텐 #10x10 #찰떡식물")

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background:#d5dae0;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}
img {vertical-align:top;}
.waterCont {position:relative; width:1140px; margin:0 auto; text-align:center;}
.txtGrn {color:#60782b !important;}
.intro {position:relative; height:945px; background:#f2f4f4 url(http://webimage.10x10.co.kr/play/ground/20160606/bg_intro.jpg) 50% 0 no-repeat;}
.intro h2 {position:absolute; left:50%; top:186px; width:350px; margin-left:-175px;}
.intro h2 span {position:absolute; top:0;}
.intro h2 .letter01 {left:0;}
.intro h2 .letter02 {right:0;}
.intro .deco {position:absolute; left:50%; top:308px; margin-left:-11px;}
.intro .feat {position:absolute; left:50%; top:374px; margin-left:-69px;}
.drink {position:relative; height:268px; background:#89857f url(http://webimage.10x10.co.kr/play/ground/20160606/bg_drink.jpg) 50% 0 no-repeat;}
.drink p {position:absolute; left:50%; top:0; margin-left:-350px;}
.purpose {position:relative; height:1045px; background:#c7c6c4 url(http://webimage.10x10.co.kr/play/ground/20160606/bg_purpose.jpg) 50% 0 no-repeat;}
.purpose p {position:absolute; right:-14px; top:278px; z-index:20;}
.purpose .btnFind {display:block; position:absolute; right:175px; top:630px; z-index:30; background:transparent;}
.findMyPlant .question {position:relative; z-index:10; width:1400px; margin:-98px auto 0; padding:60px 0 128px; background:#fff; text-align:center;}
.findMyPlant .question .section {position:relative; width:545px; height:450px; margin:0 auto 150px; padding-left:735px; text-align:left;}
.findMyPlant .question .txt {width:320px; padding:160px 0 30px; border-bottom:1px solid #eee;}
.findMyPlant .question .waterdrop {padding-top:38px;}
.findMyPlant .question .waterdrop .number {padding-bottom:28px;}
.findMyPlant .question .waterdrop .number strong {padding:0 6px 0 16px; color:#2ed5c8; font:bold 29px/24px arial;}
.findMyPlant .question .selectDrop {overflow:hidden;}
.findMyPlant .question .selectDrop span {float:left; width:29px; height:37px; margin-right:25px; background:url(http://webimage.10x10.co.kr/play/ground/20160606/bg_water.png) no-repeat 0 100%; cursor:pointer;}
.findMyPlant .question .selectDrop span.on {background-position:0 0;}
.findMyPlant .question .question01 {background:url(http://webimage.10x10.co.kr/play/ground/20160606/bg_question_01.jpg) no-repeat 0 0;}
.findMyPlant .question .question02 {width:1053px; padding-left:227px;background:url(http://webimage.10x10.co.kr/play/ground/20160606/bg_question_02.jpg) no-repeat 100% 0;}
.findMyPlant .question .question03 {padding-top:47px; margin-bottom:118px; background:url(http://webimage.10x10.co.kr/play/ground/20160606/bg_question_03.jpg) no-repeat 0 0; margin-bottom:128px;}
.findMyPlant .question .arrow {position:absolute;}
.findMyPlant .question .question02 .arrow {top:-92px; right:416px;}
.findMyPlant .question .question03 .arrow {top:-56px; left:342px;}
.findMyPlant .question01 .deco {position:absolute; left:732px; bottom:7px;}
.findMyPlant .result {overflow:hidden; position:relative; height:0; transition:height 1s .1s; background:#ededee;}
.findMyPlant .result.viewResult {height:945px;}
.findMyPlant .result .waterCont {height:945px;}
.findMyPlant .result > div {height:945px; background-position:50% 0; background-repeat:no-repeat;}
.findMyPlant .result01 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160606/img_result_cactus.jpg);}
.findMyPlant .result02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160606/img_result_sansevieria.jpg);}
.findMyPlant .result03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160606/img_result_marimo.jpg);}
.findMyPlant .result04 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160606/img_result_herb.jpg);}
.findMyPlant .result .plantIs {position:absolute; top:274px; z-index:30;}
.findMyPlant .result01 .plantIs {left:102px;}
.findMyPlant .result02 .plantIs {left:375px;}
.findMyPlant .result03 .plantIs {left:104px;}
.findMyPlant .result04 .plantIs {left:419px;}
.findMyPlant .result .tip {position:absolute; right:-20px; bottom:90px; z-index:30;}
.findMyPlant .result .goItem {display:block; position:absolute; width:500px; height:650px; z-index:30; background:url(http://webimage.10x10.co.kr/play/ground/20160606/bg_blank.png) 0 0 repeat; text-indent:-999em;}
.findMyPlant .result01 .goItem {right:120px; top:200px;}
.findMyPlant .result02 .goItem {left:55px; top:100px; height:700px;}
.findMyPlant .result03 .goItem {right:-30px; top:150px; width:600px;}
.findMyPlant .result04 .goItem {left:60px; top:100px;}
.findMyPlant .btnAgain {position:absolute; left:50%; top:755px; margin-left:-524px;}
.findMyPlant .btnFacebook {position:absolute; left:50%; top:755px; margin-left:-400px;}
.othersPlant {background:#1a130a url(http://webimage.10x10.co.kr/play/ground/20160606/bg_others.jpg) no-repeat 50% 0;}
.othersPlant .waterCont {width:1280px;}
.othersPlant h3 {padding:108px 0 72px;}
.othersPlant ul {overflow:hidden; padding-bottom:72px;}
.othersPlant li {position:relative; float:left;}
.othersPlant li p {position:absolute; left:0; top:92px; width:100%; font-size:17px; line-height:1; font-weight:bold; color:#ec5439;}
.othersPlant .total {padding:88px 0 84px; text-align:center; background:#3cded1;}
.othersPlant .total strong {padding:0 3px 0 5px; color:#fff; font-size:27px; line-height:26px; font-family:arial;}
.bounce {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1.5s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:linear;}
	50% {margin-top:5px; animation-timing-function:linear;}
}
</style>
<script type="text/javascript">
$(function(){
	$('.question01 .selectDrop span').each(function(index){
		$(this).on('click', function(){
			<% if Not(IsUserLoginOK) then %>
				jsChklogin('<%=IsUserLoginOK%>');
				return false;
			<% end if %>
			<% if not(left(now(), 10)>="2016-06-03" And left(now(), 10) < "2016-09-01") then %>
				alert("이벤트 응모 기간이 아닙니다.");
				return false;
			<% end if %>
			$('.question01 .selectDrop span').addClass('on');
			$('.question01 .selectDrop span:gt('+index+')').removeClass('on');
			var rate1 = index+1; //클릭한 물방울 갯수
			$(".question01 .number strong").text(rate1)
			return false;
		});
	});
	$('.question02 .selectDrop span').each(function(index){
		$(this).on('click', function(){
			<% if Not(IsUserLoginOK) then %>
				jsChklogin('<%=IsUserLoginOK%>');
				return false;
			<% end if %>
			<% if not(left(now(), 10)>="2016-06-03" And left(now(), 10) < "2016-09-01") then %>
				alert("이벤트 응모 기간이 아닙니다.");
				return false;
			<% end if %>
			$('.question02 .selectDrop span').addClass('on');
			$('.question02 .selectDrop span:gt('+index+')').removeClass('on');
			var rate2 = index+1; //클릭한 물방울 갯수
			$(".question02 .number strong").text(rate2)
			return false;
		});
	});
	$('.question03 .selectDrop span').each(function(index){
		$(this).on('click', function(){
			<% if Not(IsUserLoginOK) then %>
				jsChklogin('<%=IsUserLoginOK%>');
				return false;
			<% end if %>
			<% if not(left(now(), 10)>="2016-06-03" And left(now(), 10) < "2016-09-01") then %>
				alert("이벤트 응모 기간이 아닙니다.");
				return false;
			<% end if %>
			$('.question03 .selectDrop span').addClass('on');
			$('.question03 .selectDrop span:gt('+index+')').removeClass('on');
			var rate3 = index+1; //클릭한 물방울 갯수
			$(".question03 .number strong").text(rate3)
			$("#qAnswer").val(rate3);
			return false;
		});
	});
	$(".btnAgain").css({"margin-top":"-5px","opacity":"0"});
	$(".btnFacebook").css({"margin-top":"-5px","opacity":"0"});
	$(".question .btnResult").click(function(){
		$(".result").addClass("viewResult");
		$(".btnAgain").delay(1800).animate({"margin-top":"0","opacity":"1"},600);
		$(".btnFacebook").delay(1800).animate({"margin-top":"0","opacity":"1"},600);
	});
	$(".result .btnAgain").click(function(){
		$(".selectDrop span").removeClass("on");
		$(".selectDrop span:first-child").addClass("on");
		$(".question .number strong").text("1");
		$(".result").removeClass("viewResult");
		$(".btnAgain").delay(1000).animate({"margin-top":"-5px","opacity":"0"},600);
		$(".result01").hide();
		$(".result02").hide();
		$(".result03").hide();
		$(".result04").hide();
		$("#qAnswer").val('1');
		$(".btnResult").show();
	});
	$(".btnFind").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},700);
	});

	// title animation
	$(".intro h2 .letter01").css({"margin-left":"-20px","opacity":"0"});
	$(".intro h2 .letter02").css({"margin-right":"-20px","opacity":"0"});
	$(".intro .deco").css({"margin-top":"-10px","opacity":"0"});
	$(".intro .feat").css({"opacity":"0"});
	function titleAnimation() {
		$(".intro h2 .letter01").delay(100).animate({"margin-left":"5px","opacity":"1"},600);
		$(".intro h2 .letter02").delay(100).animate({"margin-right":"5px","opacity":"1"},600);
		$(".intro .deco").delay(500).animate({"margin-top":"5px","opacity":"1"},600);
		$(".intro .feat").delay(1000).animate({"opacity":"1"},600);
	}
	
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 400 ){
			titleAnimation();
		}
		if (scrollTop > 2700 ){
			$('.question01 .deco').delay(1100).fadeOut(50);
		}
	});
});

function goPlants()
{
	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% end if %>
	<% if not(left(now(), 10)>="2016-06-03" And left(now(), 10) < "2016-09-01") then %>
		alert("이벤트 응모 기간이 아닙니다.");
		return false;
	<% end if %>

	$(".btnResult").hide();

	$.ajax({
		type:"GET",
		url:"/play/groundsub/doEventSubscript71150.asp",
		data: $("#frmSbS").serialize(),
		dataType: "text",
		async:false,
		cache:true,
		success : function(Data, textStatus, jqXHR){
			if (jqXHR.readyState == 4) {
				if (jqXHR.status == 200) {
					if(Data!="") {
						var str;
						for(var i in Data)
						{
							 if(Data.hasOwnProperty(i))
							{
								str += Data[i];
							}
						}
						str = str.replace("undefined","");
						res = str.split("|");
						if (res[0]=="OK")
						{
							$('.result0'+res[1]).show();
							$("#sun").empty().html(res[2]);
							$("#sanse").empty().html(res[3]);
							$("#hub").empty().html(res[4]);
							$("#mari").empty().html(res[5]);
							$("#totalcnt").empty().html(res[6]);
							window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},700);
						}
						else
						{
							errorMsg = res[1].replace(">?n", "\n");
							alert(errorMsg );
							parent.location.reload();
							return false;
						}
					} else {
						alert("잘못된 접근 입니다.");
						parent.location.reload();
						return false;
					}
				}
			}
		},
		error:function(jqXHR, textStatus, errorThrown){
			alert("잘못된 접근 입니다.");
			var str;
			for(var i in jqXHR)
			{
				 if(jqXHR.hasOwnProperty(i))
				{
					str += jqXHR[i];
				}
			}
			alert(str);
			parent.location.reload();
			return false;
		}
	});
}
//-->
</script>
<%' 수작업 영역 시작 %>
<div class="groundCont">
	<div class="grArea">

		<%' WATER #1 찰떡식물 %>
		<div class="playGr20160606">
			<div class="intro">
				<h2>
					<span class="letter01"><img src="http://webimage.10x10.co.kr/play/ground/20160606/tit_plant_01.png" alt="찰떡" /></span>
					<span class="letter02"><img src="http://webimage.10x10.co.kr/play/ground/20160606/tit_plant_02.png" alt="식물" /></span>
				</h2>
				<span class="deco"><img src="http://webimage.10x10.co.kr/play/ground/20160606/bg_drop.png" alt="" /></span>
				<p class="feat"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_feat.png" alt="feat.water" /></p>
			</div>
			<div class="drink">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_drink.gif" alt="여러분은 물을 얼마나 마시나요?" /></p>
			</div>
			<div class="purpose">
				<div class="waterCont">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_purpose.png" alt="WATER &amp; PLANT - 우리에게 일상의 휴식과 같은 물은 식물에게는 따뜻한 관심이자 전부이기도 합니다. 이번주 PLAY에서는 서로 없어서는 안될 존재, 물과 식물에 대해 이야기하려고 합니다. 나의 하루의 이야기로 한 방울씩 물을 조합하세요, 그에 어울리는 식물을 찾아드립니다!" /></p>
					<a href="#findMyPlant" class="btnFind btnGo bounce"><img src="http://webimage.10x10.co.kr/play/ground/20160606/btn_find.png" alt="찰떡식물 찾아보기" /></a>
				</div>
			</div>

			<%' 나에게 맞는 식물찾기 %>
			<div id="findMyPlant" class="findMyPlant">
				<div class="question">
					<%' q1 %>
					<div class="section question01">
						<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_question_01.png" alt="01.오늘 하루, 바쁜 일상 속 하늘을 몇 번이나 올려다 보았나요?" /></p>
						<div class="waterdrop">
							<p class="number"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_morning.png" alt="아침 햇살" /><strong>1</strong><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_drop.png" alt="방울" /></p>
							<div class="selectWrap">
								<div class="selectDrop">
									<span class="on"></span>
									<span></span>
									<span></span>
									<span></span>
									<span></span>
								</div>
								<div class="deco"><img src="http://webimage.10x10.co.kr/play/ground/20160606/img_drop.gif" alt="" /></div>
							</div>
						</div>
					</div>

					<%' q2 %>
					<div class="section question02">
						<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_question_02.png" alt="02.오늘 하루, 만났던 사람들에게 따뜻한 한마디를 얼마나 건넸나요?" /></p>
						<div class="waterdrop">
							<p class="number"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_friendly.png" alt="다정한 관심" /><strong>1</strong><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_drop.png" alt="방울" /></p>
							<div class="selectWrap">
								<div class="selectDrop">
									<span class="on"></span>
									<span></span>
									<span></span>
									<span></span>
									<span></span>
								</div>
							</div>
						</div>
						<span class="arrow"><img src="http://webimage.10x10.co.kr/play/ground/20160606/ico_arrow.gif" alt="" /></span>
					</div>

					<%' q3 %>
					<div class="section question03">
						<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_question_03.png" alt="03.오늘 하루, 답답한 마음 물 몇 잔으로 시원하게 쓸어 내리셨나요?" /></p>
						<div class="waterdrop">
							<p class="number"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_water.png" alt="시원한 물" /><strong>1</strong><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_drop.png" alt="방울" /></p>
							<div class="selectWrap">
								<div class="selectDrop">
									<span class="on"></span>
									<span></span>
									<span></span>
									<span></span>
									<span></span>
								</div>
							</div>
						</div>
						<span class="arrow"><img src="http://webimage.10x10.co.kr/play/ground/20160606/ico_arrow.gif" alt="" /></span>
					</div>
					<a href="#result" class="btnResult btnGo" onclick="goPlants();return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160606/btn_result.png" alt="결과보기" /></a>
				</div>

				<%' 결과 %>
				<div id="result" class="section result">
					<%' 선인장 %>
					<div class="result01" style="display:none">
						<div class="waterCont">
							<p class="plantIs"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_result_cactus.png" alt="나의 찰떡식물 선인장" /></p>
							<p class="tip"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_tip_cactus.png" alt="TIP:물은 흙이 말랐을 때 가끔씩 시간차로 나눠 여러 번!/선인장 줄기에는 물이 닿지 않게 화분 가장자리에!" /></p>
							<a href="/event/eventmain.asp?eventid=71150#groupBar1" class="goItem" target="_blank">선인장 상품 더보기</a>
						</div>
					</div>

					<%' 산세베리아 %>
					<div class="result02" style="display:none">
						<div class="waterCont">
							<p class="plantIs"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_result_sansevieria.png" alt="나의 찰떡식물 산세베리아" /></p>
							<p class="tip"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_tip_sansevieria.png" alt="TIP:물은 흙이 말랐을 때 한 달에 한 번만!/물이 흐를 때까지 주고, 고인 물은 20분 뒤 버리기" /></p>
							<a href="/event/eventmain.asp?eventid=71150#groupBar2" class="goItem" target="_blank">산세베리아 상품 더보기</a>
						</div>
					</div>

					<%' 마리모 %>
					<div class="result03" style="display:none">
						<div class="waterCont">
							<p class="plantIs"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_result_marimo.png" alt="나의 찰떡식물 마리모" /></p>
							<p class="tip"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_tip_marimo.png" alt="TIP:마리모에 적정온도 25도 물을 자주 갈아주세요/물을 갈아줄 땐 자갈도 같이 깨끗이 씻어주세요!" /></p>
							<a href="/event/eventmain.asp?eventid=71150#groupBar3" class="goItem" target="_blank">마리모 상품 더보기</a>
						</div>
					</div>

					<%' 허브 %>
					<div class="result04" style="display:none">
						<div class="waterCont">
							<p class="plantIs"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_result_herb.png" alt="나의 찰떡식물 허브" /></p>
							<p class="tip"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_tip_herb.png" alt="TIP:물은 흙이 말랐을 때 한 번에 흠뻑!/물이 잎에 닿으면 햇빛에 잎이 탈 수 있어 잎에 닿지 않게! " /></p>
							<a href="/event/eventmain.asp?eventid=71150#groupBar4" class="goItem" target="_blank">허브 상품 더보기</a>
						</div>
					</div>

					<a href="#findMyPlant" class="btnAgain btnGo bounce"><img src="http://webimage.10x10.co.kr/play/ground/20160606/btn_again.png" alt="다시하기" /></a>
					<a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;" class="btnFacebook bounce"><img src="http://webimage.10x10.co.kr/play/ground/20160606/btn_facebook.png" alt="페이스북 공유하기" /></a>
				</div>
			</div>
			<%'// 나에게 맞는 식물찾기 %>

			<%' 다른사람 찰떡식물 %>
			<div class="othersPlant">
				<div class="waterCont">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20160606/tit_others_plant.png" alt="다른 사람들의 찰떡식물은?" /></h3>
					<ul>
						<li>
							<div><img src="http://webimage.10x10.co.kr/play/ground/20160606/img_others_cactus.jpg" alt="선인장" /></div>
							<p><span id="sun"><%=FormatNumber(suncnt, 0)%></span>명</p>
						</li>
						<li>
							<div><img src="http://webimage.10x10.co.kr/play/ground/20160606/img_others_sansevieria.jpg" alt="산세베리아" /></div>
							<p class="txtGrn"><span id="sanse"><%=FormatNumber(sansecnt, 0)%></span>명</p>
						</li>
						<li>
							<div><img src="http://webimage.10x10.co.kr/play/ground/20160606/img_others_marimo.jpg" alt="마리모" /></div>
							<p><span id="mari"><%=FormatNumber(maricnt, 0)%></span>명</p>
						</li>
						<li>
							<div><img src="http://webimage.10x10.co.kr/play/ground/20160606/img_others_herb.jpg" alt="허브" /></div>
							<p class="txtGrn"><span id="hub"><%=FormatNumber(hubcnt, 0)%></span>명</p>
						</li>
					</ul>
				</div>
				<p class="total"><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_total.png" alt="총" /> <strong><span id="totalcnt"><%=FormatNumber(totcnt, 0)%></span></strong><img src="http://webimage.10x10.co.kr/play/ground/20160606/txt_apply.png" alt="명이 찰떡 식물 테스트에 참여했습니다." /></p>
			</div>
			<%'// 다른사람 찰떡식물 %>
		</div>

<%' 수작업 영역 끝 %>
<form method="post" name="frmSbS" id="frmSbS">
	<input type="hidden" name="qAnswer" id="qAnswer" value="1">
	<input type="hidden" name="mode" value="add">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->