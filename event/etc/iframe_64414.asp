<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	Description : 수능 성적욕망 D-100
'	History	: 2015.07.14 원승현 생성
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
	Dim eCode, vDday

	IF application("Svr_Info") = "Dev" THEN
		eCode = "64828"
	Else
		eCode = "64414"
	End If


	vDday = DateDiff("d", Left(Now(), 10), "2015-11-12")


	If Len(Trim(vDday)) = 2 Then
		vDday = "0"&vDday
	ElseIf Len(Trim(vDday)) = 1 Then
		vDday = "00"&vDday
	Else
		vDday = vDday
	End If


%>

<!-- #include virtual="/lib/inc/head.asp" -->

<style type="text/css">
img {vertical-align:top;}
.evt64414 {position:relative;}
.colleageTest {position:relative; height:406px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/64414/bg_title.jpg) no-repeat 0 0;}
.colleageTest h2 {position:absolute; left:50%; top:175px; margin-left:-325px; z-index:50;}
.colleageTest .dDay {position:absolute; left:404px; top:61px; width:356px; height:170px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/64414/bg_dday.gif) no-repeat 0 0; z-index:40;}
.colleageTest .dDay div {position:absolute; left:0; top:0;}
.colleageTest .dDay .move {left:111px; z-index:70;}
.colleageTest .dDay .count {overflow:hidden; left:121px; width:207px; padding-top:36px; z-index:60;}
.colleageTest .dDay .count em {display:inline-block; float:left; width:69px; text-align:center;}
</style>
<script type="text/javascript">
	$(function(){
		$(".move").delay(800).hide(1);
		$(".goTrain").click(function(event){
			event.preventDefault();
			window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
		});
	});
</script>
</head>
<body>
<div class="contF">
	<!-- 수능성적욕망 -->
	<div class="evt64414">
		<div class="colleageTest">
			<div class="dDay">
				<div class="move"><img src="http://webimage.10x10.co.kr/eventIMG/2015/64414/txt_day.gif" alt="" /></div>
				<div class="count">
					<!-- 남은 날짜 불러오기(이미지0~9까지) -->
					<em><img src="http://webimage.10x10.co.kr/eventIMG/2015/64414/txt_num_<%=Left(vDday, 1)%>.png" alt="" /></em>
					<em><img src="http://webimage.10x10.co.kr/eventIMG/2015/64414/txt_num_<%=mid(vDday, 2, 1)%>.png" alt="" /></em>
					<em><img src="http://webimage.10x10.co.kr/eventIMG/2015/64414/txt_num_<%=right(vDday, 1)%>.png" alt="" /></em>
					<!--// 남은 날짜 불러오기 -->
				</div>
			</div>
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/64414/tit_test_score.png" alt="수능 성적욕망" /></h2>
		</div>
		<div>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/64414/img_timetable.jpg" alt="" usemap="#timetable" />
			<map name="timetable" id="timetable">
				<area shape="rect" coords="313,24,577,355" href="" onclick="parent.location.href='/event/eventmain.asp?eventid=64414#groupBar1';return false;" class="goTrain" alt="1교시 시간관리 영역"/>
				<area shape="rect" coords="644,55,862,324" href="" onclick="parent.location.href='/event/eventmain.asp?eventid=64414#groupBar2';return false;" class="goTrain" alt="2교시 정리습관 영역" target="_parent" />
				<area shape="rect" coords="865,279,1100,597" href="" onclick="parent.location.href='/event/eventmain.asp?eventid=64414#groupBar4';return false;" class="goTrain" alt="3교시 실전연습 영역" />
				<area shape="rect" coords="568,484,792,773" href="" onclick="parent.location.href='/event/eventmain.asp?eventid=64414#groupBar5';return false;" class="goTrain" alt="4교시 충분한숙면 영역" />
				<area shape="rect" coords="233,469,497,790" href="" onclick="parent.location.href='/event/eventmain.asp?eventid=64414#groupBar6';return false;" class="goTrain" alt="5교시 응원선물 영역" />
				<area shape="rect" coords="44,817,308,1134" href="" onclick="parent.location.href='/event/eventmain.asp?eventid=64414#groupBar3';return false;" class="goTrain" alt="6교시 응원편지 영역" />
				<area shape="rect" coords="804,888,1084,1009" href="/event/eventmain.asp?eventid=64807" alt="시험 걱정 NO! 저만 믿어요" target="_top" />
				<area shape="rect" coords="804,1037,1084,1156" href="/event/eventmain.asp?eventid=64861" alt="수능을 엿먹일 수험생 푸드" target="_top" />
			</map>
		</div>
	</div>
	<!--// 수능성적욕망 -->
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->