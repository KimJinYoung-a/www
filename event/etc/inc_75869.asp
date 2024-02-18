<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : tab1 : [컬쳐이벤트] 트롤 해피프로젝트
' History : 2017.01.31 원승현 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim eCode, vUserID, irdsite20, winItemChk, winItemStr, usrchkcnt, usrchkday, nowDate
Dim tab1eCode, tab2eCode, tab3eCode
Dim vSQL
irdsite20	= requestCheckVar(request("rdsite"), 32)
vUserID		= GetLoginUserID
nowDate = Left(Now(), 10)
'nowDate = "2017-02-03"

If application("Svr_Info") = "Dev" Then
	eCode			= "66273"
	tab1eCode		= "66274"
	tab2eCode		= "66275"

Else
	eCode			= "75869"
	tab1eCode		= "75841"
	tab2eCode		= "75871"
End If

'// 회원 응모 현황(갯수)
vSQL = ""
vSQL = vSQL & " SELECT count(userid) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code="& eCode &" and userid = '"&vUserID&"' "
rsget.Open vSQL, dbget, 1
	usrchkcnt = rsget(0)
rsget.close

'// 회원 일자별 응모 현황
vSQL = ""
vSQL = vSQL & " SELECT count(userid) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code="& eCode &" and userid = '"&vUserID&"' And convert(varchar(10), regdate, 120)='"&nowDate&"' "
rsget.Open vSQL, dbget, 1
	usrchkday = rsget(0)
rsget.close
%>
<style type="text/css">
.evt75869 {overflow:hidden; background:#81ce6b url(http://webimage.10x10.co.kr/eventIMG/2017/75869/bg_hill.jpg) no-repeat 50% 0;}
.evt75869 button {background:transparent;}
.evt75869 iframe {background:transparent;}
.trollHead {position:relative; width:1140px; height:362px; margin:0 auto 124px; text-align:center;}
.trollHead .date {text-align:left; padding-top:33px;}
.trollHead .with {padding-top:70px;}
.trollHead h2 {position:absolute; left:50%; top:132px; width:747px; height:147px; margin-left:-360px;}
.trollHead h2 span {position:absolute;}
.trollHead h2 span.t1 {left:0; top:3px;}
.trollHead h2 span.t2 {right:0; top:0;}
.trollHead .subcopy {position:absolute; left:50%; top:318px; margin-left:-206px;}
.trollHead .goCulture {position:absolute; right:0; top:0; animation:move2 50 2s;}
.event1 .findTroll {position:relative; width:1373px; height:703px; margin:15px auto 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/bg_ground.png) no-repeat 50% 100%;}
.event1 .findTroll .btnClick {position:absolute; left:50%; top:105px; z-index:30; width:300px; height:200px; animation:move2 infinite 1.2s; background-position:0 0; background-repeat:no-repeat; text-indent:-999em; outline:none;}
.event1 .findTroll.day00 .btnClick {margin-left:-150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/btn_click_01.png)}
.event1 .findTroll.day01 .btnClick {margin:20px 0 0 -345px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/btn_click_02.png)}
.event1 .findTroll.day02 .btnClick {margin:90px 0 0 40px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/btn_click_03.png)}
.event1 .findTroll.day03 .btnClick {margin-left:-510px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/btn_click_04.png)}
.event1 .findTroll.day04 .btnClick {margin:30px 0 0 200px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/btn_click_05.png)}
.event1 .findTroll .myTroll {position:absolute; left:190px; top:0; z-index:20;}
.event1 .findTroll .result {display:none; position:absolute; left:50%; top:75px; z-index:40; margin-left:-321px;}
.event1 .findTroll .result .btnFinish {display:block; position:absolute; left:50%; bottom:45px; width:300px; height:65px; margin-left:-150px; text-indent:-999em;}
.event2 {padding:120px 0 125px;}
.evtNoti {background:#6db958;}
.evtNoti .inner {width:1038px; margin:0 auto; padding:54px 0; text-align:left;}
.evtNoti ul {float:left; padding-top:13px;}
.evtNoti li {font-size:12px; line-height:27px;  color:#4a4949; text-indent:-10px; padding-left:10px;}
.preview {padding:88px 0 65px; text-align:left; background:#396f4b;}
.preview .inner {position:relative; width:1140px; margin:0 auto;}
.preview .swiper-container {width:544px; height:306px; padding-bottom:30px;}
.preview .swiper-slide {float:left; width:544px;}
.preview .swiper-slide iframe {width:544px; height:306px;}
.preview button {position:absolute; top:50%; z-index:10; margin-top:-42px;}
.preview button.btnPrev {left:9px;}
.preview button.btnNext {right:9px;}
.preview .pagination {position:absolute; left:0; bottom:0;  z-index:10; width:100%; text-align:center;}
.preview .pagination span {display:inline-block; width:10px; height:10px; margin:0 7px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/btn_pagination.png) no-repeat 0 0; cursor:pointer;}
.preview .pagination span.swiper-active-switch {background-position:100% 0;}
.preview .story {position:absolute; right:8px; top:0;}
.preview .copyright {position:absolute; right:0; bottom:-52px;}
@keyframes move2 {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function btnClose(){
	$(".event1 .findTroll .btnClick").hide();
	$(".event1 .findTroll #result").hide();
	document.location.reload();
}

function checkform(){
	var wrapHeight = $(document).height();
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
				return;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
		// 오픈시 바꿔야됨
		<% If nowDate >= "2017-02-01" And nowDate < "2017-02-13" Then %>
			$.ajax({
				type:"GET",
				url:"/event/etc/doEventSubscript75869.asp?mode=ins",
				dataType: "text",
				async:false,
				cache:false,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								for(var i in Data){
									 if(Data.hasOwnProperty(i)){
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
								if (res[0]=="OK"){
									$(".event1 .findTroll #result").empty().html(res[1]);
									$(".event1 .findTroll #result").show();
									window.parent.$('html,body').animate({scrollTop:$("#event1").offset().top}, 800);
								} else {
									errorMsg = res[1].replace(">?n", "\n");
									alert(errorMsg);
									document.location.reload();
									return false;
								}
							} else {
								alert("잘못된 접근 입니다.");
								document.location.reload();
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
					document.location.reload();
					return false;
				}
			});
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;				
		<% End If %>
	<% End If %>
}

$(function(){
	var evtSwiper = new Swiper('.preview .swiper-container',{
		loop:true,
		speed:800,
		pagination:'.preview .pagination',
		paginationClickable:true,
		nextButton:'.preview .btnNext',
		prevButton:'.preview .btnPrev'
	})
	$('.preview .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.preview .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});

	// animation
	$(".event1 .findTroll .btnClick").css({"opacity":"0"});
	$(".event1 .findTroll .myTroll").css({"margin-top":"20px","opacity":"0"});
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 800) {
			$(".event1 .findTroll .myTroll").delay(100).animate({"margin-top":"0", "opacity":"1"},1200);
			$(".event1 .findTroll .btnClick").delay(1400).animate({"opacity":"1"},600);
		}
	});
	titleAnimation()
	$(".trollHead h2 span.t1").css({"margin-left":"-30px", "opacity":"0"});
	$(".trollHead h2 span.t2").css({"margin-right":"-30px", "opacity":"0"});
	$(".trollHead .subcopy").css({"margin-top":"10px", "opacity":"0"});
	function titleAnimation() {
		$(".trollHead h2 span.t1").delay(100).animate({"margin-left":"0px", "opacity":"1"},800);
		$(".trollHead h2 span.t2").delay(100).animate({"margin-right":"0px", "opacity":"1"},800);
		$(".trollHead .subcopy").delay(800).animate({"margin-top":"0", "opacity":"1"},1000);
	}
});
</script>

<%' 트롤 해피 프로젝트 : 트롤의 행복을 찾아줘! %>
<div class="evt75869">
	<div class="trollHead">
		<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/txt_date_v2.png" alt="2017.02.01~02.12" /></p>
		<p class="with"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/txt_with.png" alt="10X10 | 트롤" /></p>
		<h2>
			<span class="t1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/tit_troll.png" alt="트롤" /></span>
			<span class="t2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/tit_happy.png" alt="해피 프로젝트" /></span>
		</h2>
		<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/txt_subcopy.png" alt="귀여운 행복의 요정 트롤들이 텐바이텐에 도착했어요! 이벤트를 통해 트롤들이 준비해온 행운의 선물을 받아가세요" /></p>
		<a href="/culturestation/" class="goCulture" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/btn_culture.png" alt="컬쳐스테이션 이벤트 더 보러가기" /></a>
	</div>
	<iframe id="iframe_troll" src="/event/etc/group/iframe_75869.asp?eventid=<%=eCode%>" width="1124" height="334" frameborder="0" scrolling="no" title="트롤 해피 프로젝트"></iframe>

	<%' event1 %>
	<div id="event1" class="event1">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/txt_event1.png" alt="EVENT1. 트롤의 행복을 찾아줘!" /></p>
		<div class="findTroll day0<%=usrchkcnt%>">
			<%' 응모완료후에는 클릭버튼 hidden %>
			<% If nowDate < "2017-02-13" Then %>
				<% If usrchkcnt < 5 Then %>
					<% If usrchkday < 1 Then %>
						<button type="button" class="btnClick" onclick="checkform();return false;">Click!</button>
					<% End If %>
				<% End If %>
			<% End If %>
			<div class="myTroll">
				<%' 출석횟수에 따라 이미지 00~05 %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/img_troll_on_0<%=usrchkcnt%>.png" alt="" />
			</div>
			<div id="result" class="result"></div>
		</div>
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/img_gift_v2.png" alt="트롤 오리지널 피규어 200명/트롤 전용 영화 예매권 50명/트롤 봉제 가방고리 50명" /></div>
	</div>
	<%'// event1 %>

	<%' event2 %>
	<div class="event2">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/txt_event2_v2.png" alt="EVENT2. 배송박스 속 파피를 찍어주세요!" /></p>
		<div style="padding-top:45px;">
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/txt_step.png" alt="1.텐바이텐 배송상품 쇼핑하기→2.배송박스 속 파피 인증샷 찍기→3.인스타그램에 업로드 #텐바이텐 #트롤" usemap="#step" />
			<map name="step" id="step">
				<area shape="rect" coords="23,5,233,138" href="/event/eventmain.asp?eventid=65618" alt="텐바이텐 배송상품 보러가기" onfocus="this.blur();" target="_blank" />
			</map>
		</div>
	</div>
	<%' event2 %>
	<div class="evtNoti">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<div class="overHidden">
				<ul style="width:654px;">
					<li>- 오직 텐바이텐 회원님을 위한 이벤트 입니다. (로그인 후 참여가능, 비회원 참여 불가)</li>
					<li>- 한 ID당 하루에 한 번만 참여할 수 있습니다.</li>
					<li>- 이벤트 참여 횟수가 많을수록 당첨확률은 올라갑니다.<br />(최대 5회 참여 가능. 참여 횟수가 낮아도 당첨 될 수 있습니다.)</li>
					<li>- event2 리플렛 이벤트의 당첨자 발표는 2월 24일 사이트 공지사항 및<br />인스타그램 계정 @your10x10 에서 진행될 예정입니다.</li>
					<li>- event2 리플렛 이벤트의 '트롤 리플렛'은 2월 2일 오후 텐텐배송 상품 주문 건 부터 삽입되어 발송 될 예정입니다.</li>
				</ul>
				<ul style="width:384px;">
					<li>- 이벤트 경품은 내부 사정에 의해 변경될 수 있습니다.</li>
					<li>- 당첨자와 수령자는 동일해야 하며, 양도는 불가합니다.</li>
					<li>- 정확한 발표를 위해 마이텐바이텐의 개인정보를 업데이트 해주세요.</li>
					<li>- 이벤트 종료 후 당첨된 경품의 교환 및 변경은 불가 합니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="preview">
		<div class="inner">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide video"><iframe src='http://serviceapi.rmcnmv.naver.com/flash/outKeyPlayer.nhn?vid=472E752AF6084910D5A9FBF819698EC52332&outKey=V1212b06a4f82fd460f698880c6dfa2b1982a73574be0b1339e4a8880c6dfa2b1982a&controlBarMovable=false&jsCallable=true&isAutoPlay=false&skinName=tvcast_white' frameborder='no' scrolling='no' marginwidth='0' marginheight='0' allowfullscreen></iframe></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/img_slide_01.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/img_slide_02.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/img_slide_03.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/img_slide_04.jpg" alt="" /></div>
				</div>
				<div class="pagination"></div>
				<button class="btnPrev"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/btn_prev.png" alt="이전" /></button>
				<button class="btnNext"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/btn_next.png" alt="다음" /></button>
			</div>
			<p class="story"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/txt_story.png" alt="머리카락 곤.두.서.게 행복한 요정들이 온다! 진짜 행복의 맛이 뭔지 보여줄게!" /></p>
			<p class="copyright"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/txt_copyright.png" alt="DreamWorks Trolls © 2015 DreamWorks Animation LLC. All Rights Reserved" /></p>
		</div>
	</div>
</div>
<%'// 트롤 해피 프로젝트 : 트롤의 행복을 찾아줘! %>

<!-- #include virtual="/lib/db/dbclose.asp" -->