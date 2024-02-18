<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : [뷰팁] 혹시.. 여신이세요?
' History : 2016-10-21 김진영 작성
' 어드민에 소스 넣을때 뭐뭐뭐.asp 뒤에 ?eventid=코드 꼭 넣으세요!!
'#######################################################################
Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)

	If vEventID = "73818" Then			'#01
		vStartNo = "0"
	ElseIf vEventID = "74302" Then			'#02
		vStartNo = "0"
	ElseIf vEventID = "75030" Then			'#03
		vStartNo = "0"
	ElseIf vEventID = "75628" Then			'#04
		vStartNo = "0"
	ElseIf vEventID = "76388" Then			'#05
		vStartNo = "1"
	ElseIf vEventID = "76773" Then			'#06
		vStartNo = "2"
	ElseIf vEventID = "77399" Then			'#07
		vStartNo = "3"
	ElseIf vEventID = "77959" Then			'#08
		vStartNo = "4"
	ElseIf vEventID = "78717" Then			'#08
		vStartNo = "5"
	ElseIf vEventID = "79914" Then			'#10
		vStartNo = "5"
	ElseIf vEventID = "79876" Then			'#11
		vStartNo = "6"
	ElseIf vEventID = "80676" Then			'#12
		vStartNo = "7"
	ElseIf vEventID = "81299" Then			'#13
		vStartNo = "8"
	ElseIf vEventID = "82001" Then			'#14
		vStartNo = "9"
	ElseIf vEventID = "82946" Then			'#15
		vStartNo = "10"
	End If

	Dim currentdate
	currentdate = date()
%>
<style>
/* iframe */
.navigator {position:relative; padding:0 33px;}
.navigator .swiper-container {width:905px; height:112px;}
.navigator li {float:left; width:20%; height:112px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/txt_soon.png) 50% 0 no-repeat;}
.navigator li span {display:none; position:relative; width:169px; height:98px; margin:0 auto; background-repeat:no-repeat; background-position:0 0;}
.navigator li a {display:none; position:relative; height:98px; text-indent:-999em;}
.navigator li.current a,.navigator li.current span  {display:block;}
.navigator li.open a,.navigator li.open span {display:block;}
.navigator li.nav01 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/nav_01.png);}
.navigator li.nav02 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/nav_02.png);}
.navigator li.nav03 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/nav_03.png);}
.navigator li.nav04 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/nav_04.png);}
.navigator li.nav05 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/nav_05.png);}
.navigator li.nav06 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/nav_06.jpg);}
.navigator li.nav07 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/nav_07.jpg);}
.navigator li.nav08 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/nav_08.jpg);}
.navigator li.nav09 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/nav_09.jpg);}
.navigator li.nav10 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/79340/nav_10.jpg);}
.navigator li.nav11 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/79876/nav_11.jpg);}
.navigator li.nav12 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80676/nav_12.jpg);}
.navigator li.nav13 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81299/nav_13.jpg);}
.navigator li.nav14 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/82001/nav_14.jpg);}
.navigator li.nav15 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/82946/nav_15.jpg);}
.navigator li.current span {background-position:0 100%;}
.navigator li.current a:after {content:''; display:inline-block; position:absolute; left:0; top:0; width:169px; height:112px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73818/bg_current.png) 0 0 no-repeat;}
.navigator .slideNav {position:absolute; top:35px; background:transparent;}
.navigator .btnPrev {left:0;}
.navigator .btnNext {right:0;}
</style>
<script>
$(function(){
	/* iframe(썸네일 5개 이상일때부터 스크립트 실행) */
	if ($('.navigator li').length > 5) {
		var beautyNav = new Swiper('.navigator .swiper-container',{
			initialSlide:<%=vStartNo%>,
			slidesPerView:5,
			speed:600,
			simulateTouch:true,
			nextButton:'.navigator .btnNext',
			prevButton:'.navigator .btnPrev'
		})
		$('.navigator .btnPrev').on('click', function(e){
			e.preventDefault();
			beautyNav.swipePrev();
		})
		$('.navigator .btnNext').on('click', function(e){
			e.preventDefault();
			beautyNav.swipeNext();
		});
	} else {
		$('.navigator .slideNav').hide();
	}
});
</script>
<div class="navigator">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' for dev msg :  현재페이지:current / 오픈:open 클래스 넣어주세요 %>
			<li class="swiper-slide nav01<%=CHKIIF(currentdate>="2016-10-21"," open","")%><%=CHKIIF(vEventID="73818"," current","")%>"><span><a href="/event/eventmain.asp?eventid=73818" target="_top">#01 데이트편</a></span></li>
			<li class="swiper-slide nav02<%=CHKIIF(currentdate>="2016-11-21"," open","")%><%=CHKIIF(vEventID="74302"," current","")%>"><span><a href="/event/eventmain.asp?eventid=74302" target="_top">#02 지각극복편</a></span></li>
			<li class="swiper-slide nav03<%=CHKIIF(currentdate>="2016-12-19"," open","")%><%=CHKIIF(vEventID="75030"," current","")%>"><span><a href="/event/eventmain.asp?eventid=75030" target="_top">#03 힐링 크리스마스편</a></span></li>
			<li class="swiper-slide nav04<%=CHKIIF(currentdate>="2017-01-16"," open","")%><%=CHKIIF(vEventID="75628"," current","")%>"><span><a href="/event/eventmain.asp?eventid=75628" target="_top">#04 볼륨편</a></span></li>
			<li class="swiper-slide nav05<%=CHKIIF(currentdate>="2017-02-27"," open","")%><%=CHKIIF(vEventID="76388"," current","")%>"><span><a href="/event/eventmain.asp?eventid=76388" target="_top">#05 독도지킴이 편</a></span></li>
			<li class="swiper-slide nav06<%=CHKIIF(currentdate>="2017-03-20"," open","")%><%=CHKIIF(vEventID="76773"," current","")%>"><span><a href="/event/eventmain.asp?eventid=76773" target="_top">#06 달콤한 비누편</a></span></li>
			<li class="swiper-slide nav07<%=CHKIIF(currentdate>="2017-04-17"," open","")%><%=CHKIIF(vEventID="77399"," current","")%>"><span><a href="/event/eventmain.asp?eventid=77399" target="_top">#07 달콤한 비누편</a></span></li>
			<li class="swiper-slide nav08<%=CHKIIF(currentdate>="2017-05-23"," open","")%><%=CHKIIF(vEventID="77959"," current","")%>"><span><a href="/event/eventmain.asp?eventid=77959" target="_top">#08 완벽한 다이어트편</a></span></li>
			<li class="swiper-slide nav09<%=CHKIIF(currentdate>="2017-06-26"," open","")%><%=CHKIIF(vEventID="78717"," current","")%>"><span><a href="/event/eventmain.asp?eventid=78717" target="_top">#09 휴가 필수품편</a></span></li>
			<li class="swiper-slide nav10<%=CHKIIF(currentdate>="2017-07-25"," open","")%><%=CHKIIF(vEventID="79914"," current","")%>"><span><a href="/event/eventmain.asp?eventid=79914" target="_top">#10 톡쏘는 클렌징편</a></span></li>
			<li class="swiper-slide nav11<%=CHKIIF(currentdate>="2017-08-22"," open","")%><%=CHKIIF(vEventID="79876"," current","")%>"><span><a href="/event/eventmain.asp?eventid=79876" target="_top">#11 진동 땅콩 마사지편</a></span></li>
			<li class="swiper-slide nav12<%=CHKIIF(currentdate>="2017-09-26"," open","")%><%=CHKIIF(vEventID="80676"," current","")%>"><span><a href="/event/eventmain.asp?eventid=80676" target="_top">#12 헤어 마스크편</a></span></li>
			<li class="swiper-slide nav13<%=CHKIIF(currentdate>="2017-10-25"," open","")%><%=CHKIIF(vEventID="81299"," current","")%>"><span><a href="/event/eventmain.asp?eventid=81299" target="_top">#13 헤어 브러쉬편</a></span></li>
			<li class="swiper-slide nav14<%=CHKIIF(currentdate>="2017-11-23"," open","")%><%=CHKIIF(vEventID="82001"," current","")%>"><span><a href="/event/eventmain.asp?eventid=82001" target="_top">#14 다리부종 편</a></span></li>
			<li class="swiper-slide nav15<%=CHKIIF(currentdate>="2017-12-21"," open","")%><%=CHKIIF(vEventID="82946"," current","")%>"><span><a href="/event/eventmain.asp?eventid=82946" target="_top">#15 배쓰밤 DIY편</a></span></li>
		</ul>
	</div>
	<button class="slideNav btnPrev"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73818/btn_prev.png" alt="이전" /></button>
	<button class="slideNav btnNext"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73818/btn_next.png" alt="다음" /></button>
</div>