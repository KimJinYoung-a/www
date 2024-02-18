<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
'#### 2014-06-10 이종화 작성 play_sub ###################
	dim eCode, cnt, sqlStr, regdate , totalsum
	Dim totcnt1 , totcnt2 , totcnt3

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  21199
	Else
		eCode   =  52550
	End If

	If IsUserLoginOK Then
		'하루 1회 중복 응모 확인
		sqlStr="Select count(sub_idx) " &_
				" From db_event.dbo.tbl_event_subscript " &_
				" WHERE evt_code='" & eCode & "'" &_
				" and userid='" & GetLoginUserID() & "' and convert(varchar(10),regdate,120) = '" &  Left(now(),10) & "'"
		rsget.Open sqlStr,dbget,1
		cnt=rsget(0)
		rsget.Close

		'토탈 5회 중복 응모 확인
		sqlStr="Select count(sub_idx) " &_
				" From db_event.dbo.tbl_event_subscript " &_
				" WHERE evt_code='" & eCode & "'" &_
				" and userid='" & GetLoginUserID() & "'"
		rsget.Open sqlStr,dbget,1
		totalsum=rsget(0)
		rsget.Close

	End If

	sqlStr="Select count(case when sub_opt2 = 1 then sub_opt2 end) as totcnt1 " &_
			" , count(case when sub_opt2 = 2 then sub_opt2 end) as totcnt2 " &_
			" , count(case when sub_opt2 = 3 then sub_opt2 end) as totcnt3 " &_
			" From db_event.dbo.tbl_event_subscript " &_
			" WHERE evt_code='" & eCode & "'"

	rsget.Open sqlStr,dbget,1
		totcnt1 = rsget("totcnt1")
		totcnt2 = rsget("totcnt2")
		totcnt3 = rsget("totcnt3")
	rsget.Close
%>
<script>
	function checkform(frm) {
	<% if datediff("d",date(),"2014-06-30")>=0 then %>
		<% If IsUserLoginOK Then %>
			<% If cnt > 0 Then %>
					alert('하루에 1회 응모 가능 합니다.');
					return false;
			<% else %>
				<% If totalsum = 5 Then %>
					alert('최대 5회 응모 가능합니다.');
					return false;
				<% else %>
					if(!(frm.spoint[0].checked||frm.spoint[1].checked||frm.spoint[2].checked))
					{
						alert("히어로수를 골라주세요!");
						return false;
					}

					frm.action = "doEventSubscript52550.asp";
					return true;
				<% end if %>
			<% end if %>
		<% Else %>
		    jsChklogin('<%=IsUserLoginOK%>');
		<% End If %>
	<% else %>
			alert('이벤트가 종료되었습니다.');
			return;
	<% end if %>
	}
</script>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
img {vertical-align:top;}
.groundHeadWrap {background-color:#fff;}
.groundCont {min-width:1140px; margin-bottom:60px; padding-bottom:1px; border-top:1px solid #fff; background:url(http://webimage.10x10.co.kr/play/ground/20140616/bg_dash02.gif) left bottom repeat-x;}
.groundCont .tagView {width:1100px; margin:0 auto; padding:75px 20px 75px;}
.grArea {width:100%; background:url(http://webimage.10x10.co.kr/play/ground/20140616/bg_grid.gif) left bottom repeat;}
.playGr20140616 {text-align:center;}
.section {border-bottom:1px solid #fff; background:url(http://webimage.10x10.co.kr/play/ground/20140616/bg_grid.gif) left top repeat;}
.section .group {position:relative; width:1140px; margin:0 auto; padding:100px 0;}
.section .group p.cloud {position:absolute; left:-38px; top:224px;}
.section .group ul {overflow:hidden; width:1047px; padding-top:78px; margin:0 auto;}
.section .group ul li {float:left; width:309px; margin:0 20px; text-align:center;}
.section .group ul li label {display:block;}
.section .group ul li p {width:256px; margin:15px 0 23px 65px; padding-bottom:3px; color:#222; font-size:15px;}
.section .group ul li p strong {font-weight:normal; font-size:28px;}
.section .group ul li p em {font-weight:bold;}
.section .group ul li.hulk p {width:212px; border-bottom:4px solid #00a940;}
.section .group ul li.thor p {width:212px; border-bottom:4px solid #3ca2d6;}
.section .group ul li.ironman p {width:242px; margin-left:50px; border-bottom:4px solid #da5059;}
.section .group ul li.hulk p strong {color:#00a940;}
.section .group ul li.thor p strong {color:#3ca2d6;}
.section .group ul li.ironman p strong {color:#da5059;}
.section .group ul li input {margin-left:30px}
.section .group .btnSubmit {margin-top:63px; text-align:center;}
.heroHeadWrap {text-align:center; min-width:1240px; background:url(http://webimage.10x10.co.kr/play/ground/20140616/bg_dot.gif) left top repeat-x;}
.heroHead {position:relative; height:730px; padding-bottom:9px; background:url(http://webimage.10x10.co.kr/play/ground/20140616/bg_dash.gif) left bottom repeat-x;}
.heroHead p.leftBuilding {position:absolute; left:0; bottom:9px;}
.heroHead p.rightBuilding {position:absolute; right:0; bottom:9px;}
.heroHeadCont {position:relative; width:1140px; height:730px; margin:0 auto;}
.heroHeadCont h2 {padding:82px 0 0 83px;}
.heroHeadCont p {position:absolute;}
.heroHeadCont p.cloud {left:-162px; top:196px;}
.heroHeadCont p.arrow {left:50%; bottom:-31px; margin-left:-31px;}
.cartoon {padding:100px 0 142px; text-align:center; background-color:#fff;}
.slideWrap {padding:0 84px 200px; background-color:#fff;}
.slideWrap .slide {position:relative; overflow:visible !important; max-width:1360px; margin:0 auto; background:#fff;}
.slideWrap .slide img {width:100%;}
.slideWrap .slide .slidesjs-navigation {display:block; position:absolute; top:50%; z-index:10; width:42px; height:52px; margin-top:-93px; text-indent:-999em;}
.slideWrap .slide .slidesjs-previous {left:4px; background-image:url(http://webimage.10x10.co.kr/play/ground/20140616/btn_prev.gif);}
.slideWrap .slide .slidesjs-next {right:5px; background-image:url(http://webimage.10x10.co.kr/play/ground/20140616/btn_next.gif);}
.slideWrap .slide .slidesjs-pagination {overflow:hidden;  position:absolute; left:0; bottom:8%; z-index:200; width:100%;}
.slideWrap .slide .slidesjs-pagination li {display:inline-block; width:28px; padding:0 11px;}
.slideWrap .slide .slidesjs-pagination li a {display:block; width:28px; height:28px; background-position:left top; background-repeat:no-repeat; text-indent:-999em;}
.slideWrap .slide .slidesjs-pagination li a.active {background-position:left -28px;}
.slideWrap .slide .slidesjs-pagination li.n01 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20140616/txt_num01.gif);}
.slideWrap .slide .slidesjs-pagination li.n02 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20140616/txt_num02.gif);}
.slideWrap .slide .slidesjs-pagination li.n03 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20140616/txt_num03.gif);}
.slideWrap .slide .slidesjs-pagination li.n04 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20140616/txt_num04.gif);}
.slideWrap .slide .slidesjs-pagination li.n05 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20140616/txt_num05.gif);}
.kitInfo {padding:0 0 188px 10px; background:url(http://webimage.10x10.co.kr/play/ground/20140616/bg_dash02.gif) left bottom repeat-x #fff;}
.kitInfo ul {overflow:hidden; width:1340px; padding-bottom:159px; margin:0 auto;}
.kitInfo ul li {float:left; width:406px; padding:0 20px;}
.kitInfo ul li img {width:100%;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".slide").slidesjs({
		width:"1358",
		height:"885",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play: {interval:2300, effect:"fade", auto:true},
		effect:{fade: {speed:500, crossFade:true}}
	});

	// Label Select
	$("label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("n01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("n02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("n03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("n04");
	$(".slidesjs-pagination li:nth-child(5)").addClass("n05");
});
</script>
</head>
<body>
<div class="playGr20140616">
	<div class="hero">
		<div class="heroHeadWrap">
			<div class="heroHead">
				<div class="heroHeadCont">
					<h2><img src="http://webimage.10x10.co.kr/play/ground/20140616/tit_hero_water.png" alt="최강의 슈퍼 히어로수(水)가 모였다!" /></h2>
					<p class="cloud"><img src="http://webimage.10x10.co.kr/play/ground/20140616/bg_cloud.png" alt="" /></p>
					<p class="arrow"><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_arrow.png" alt="" /></p>
				</div>
				<p class="leftBuilding"><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_building_left.png" alt="" /></p>
				<p class="rightBuilding"><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_building_right.png" alt="" /></p>
			</div>
		</div>
		<div class="cartoon"><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_cartoon.jpg" alt="" /></div>
		<div class="slideWrap">
			<div class="slide">
				<div class="slideCont"><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_slide01.jpg" alt="" /></div>
				<div class="slideCont"><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_slide02.jpg" alt="" /></div>
				<div class="slideCont"><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_slide03.jpg" alt="" /></div>
				<div class="slideCont"><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_slide04.jpg" alt="" /></div>
				<div class="slideCont"><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_slide05.jpg" alt="" /></div>
			</div>
		</div>
		<div class="kitInfo">
			<ul>
				<li><p><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_hulk.png" alt="" /></p></li>
				<li><p><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_thor.png" alt="" /></p></li>
				<li><p><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_ironman.png" alt="" /></p></li>
			</ul>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140616/img_kit_info.png" alt="" /></p>
		</div>
		<!-- 응모하기 -->
		<div class="section">
			<div class="group">
				<form name="frm" method="POST" style="margin:0px;" onSubmit="return checkform(this);">
					<fieldset>
					<legend>나에게 필요한 영웅 선택하기</legend>
						<p class="cloud"><img src="http://webimage.10x10.co.kr/play/ground/20140616/bg_cloud02.png" alt="" /></p>
						<h3><img src="http://webimage.10x10.co.kr/play/ground/20140616/tit_help_hero.png" alt="도와줘요~ 히어로 水!" /></h3>
						<ul>
							<li class="hulk">
								<label for="hero01"><img src="http://webimage.10x10.co.kr/play/ground/20140616/ico_hero_01.png" alt="도와줘요~ 헐쿠" /></label>
								<p><strong><%=totcnt1%>명</strong>이<br /><em>헐쿠</em>의 도움을 필요로 합니다!</p>
								<input type="radio" id="hero01" name="spoint" value="1" />
							</li>
							<li class="thor">
								<label for="hero02"><img src="http://webimage.10x10.co.kr/play/ground/20140616/ico_hero_02.png" alt="도와줘요~ 쏘르" /></label>
								<p><strong><%=totcnt2%>명</strong>이<br /><em>쏘르</em>의 도움을 필요로 합니다!</p>
								<input type="radio" id="hero02" name="spoint" value="2" />
							</li>
							<li class="ironman">
								<label for="hero03"><img src="http://webimage.10x10.co.kr/play/ground/20140616/ico_hero_03.png" alt="도와줘요~ 아니언 맨" /></label>
								<p><strong><%=totcnt3%>명</strong>이<br /><em>아니언 맨</em>의 도움을 필요로 합니다!</p>
								<input type="radio" id="hero03" name="spoint" value="3" />
							</li>
						</ul>
						<div class="btnSubmit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20140616/btn_submit.gif" alt="응모하기" /></div>
					</fieldset>
				</form>
			</div>
		</div>
		<!-- //응모하기 -->
	</div>
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->