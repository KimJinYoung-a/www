<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'####################################################
' Description : PLAYing 공감되면 투표해주세요!
' History : 2017-02-24 김진영 생성
'####################################################
Dim eCode, sqlStr, LoginUserid, vDIdx, myresultCnt, totalresultCnt
Dim totalex1y, totalex1n, totalex2y, totalex2n, totalex3y, totalex3n, totalex4y, totalex4n, totalex5y, totalex5n, totalex6y, totalex6n, totalex7y, totalex7n
Dim myex1, myex2, myex3, myex4, myex5, myex6, myex7
Dim pagereload
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66283
Else
	eCode   =  76299
End If

vDIdx = request("didx")
pagereload	= requestCheckVar(request("pagereload"),2)
LoginUserid	= getencLoginUserid()

'1. 로그인을 했다면 tbl_event_subscript에 ID가 있는 지 확인
If IsUserLoginOK() Then
	sqlStr = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' and userid = '" & LoginUserid & "' AND sub_opt1 = 'result' "
	rsget.Open sqlStr,dbget,1
	If not rsget.EOF Then
		myresultCnt = rsget(0)
	End If
	rsget.close
Else
	myresultCnt = 0
End If

'2. 전체 문항 카운트
sqlStr = ""
sqlStr = sqlStr & " SELECT "
sqlStr = sqlStr & " sum(CASE WHEN ex1 = 1 THEN 1 ELSE 0 END) as totalex1y "
sqlStr = sqlStr & " ,sum(CASE WHEN ex1 = 2 THEN 1 ELSE 0 END) as totalex1n "
sqlStr = sqlStr & " ,sum(CASE WHEN ex2 = 1 THEN 1 ELSE 0 END) as totalex2y "
sqlStr = sqlStr & " ,sum(CASE WHEN ex2 = 2 THEN 1 ELSE 0 END) as totalex2n "
sqlStr = sqlStr & " ,sum(CASE WHEN ex3 = 1 THEN 1 ELSE 0 END) as totalex3y "
sqlStr = sqlStr & " ,sum(CASE WHEN ex3 = 2 THEN 1 ELSE 0 END) as totalex3n "
sqlStr = sqlStr & " ,sum(CASE WHEN ex4 = 1 THEN 1 ELSE 0 END) as totalex4y "
sqlStr = sqlStr & " ,sum(CASE WHEN ex4 = 2 THEN 1 ELSE 0 END) as totalex4n "
sqlStr = sqlStr & " ,sum(CASE WHEN ex5 = 1 THEN 1 ELSE 0 END) as totalex5y "
sqlStr = sqlStr & " ,sum(CASE WHEN ex5 = 2 THEN 1 ELSE 0 END) as totalex5n "
sqlStr = sqlStr & " ,sum(CASE WHEN ex6 = 1 THEN 1 ELSE 0 END) as totalex6y "
sqlStr = sqlStr & " ,sum(CASE WHEN ex6 = 2 THEN 1 ELSE 0 END) as totalex6n "
sqlStr = sqlStr & " ,sum(CASE WHEN ex7 = 1 THEN 1 ELSE 0 END) as totalex7y "
sqlStr = sqlStr & " ,sum(CASE WHEN ex7 = 2 THEN 1 ELSE 0 END) as totalex7n "
sqlStr = sqlStr & " FROM db_temp.[dbo].[tbl_event_76299] "
rsget.Open sqlStr,dbget,1
If not rsget.EOF Then
	totalex1y = rsget("totalex1y")
	totalex1n = rsget("totalex1n")
	totalex2y = rsget("totalex2y")
	totalex2n = rsget("totalex2n")
	totalex3y = rsget("totalex3y")
	totalex3n = rsget("totalex3n")
	totalex4y = rsget("totalex4y")
	totalex4n = rsget("totalex4n")
	totalex5y = rsget("totalex5y")
	totalex5n = rsget("totalex5n")
	totalex6y = rsget("totalex6y")
	totalex6n = rsget("totalex6n")
	totalex7y = rsget("totalex7y")
	totalex7n = rsget("totalex7n")
End If
rsget.close

If IsNull(totalex1y) Then totalex1y = 0
If IsNull(totalex1n) Then totalex1n = 0
If IsNull(totalex2y) Then totalex2y = 0
If IsNull(totalex2n) Then totalex2n = 0
If IsNull(totalex3y) Then totalex3y = 0
If IsNull(totalex3n) Then totalex3n = 0
If IsNull(totalex4y) Then totalex4y = 0
If IsNull(totalex4n) Then totalex4n = 0
If IsNull(totalex5y) Then totalex5y = 0
If IsNull(totalex5n) Then totalex5n = 0
If IsNull(totalex6y) Then totalex6y = 0
If IsNull(totalex6n) Then totalex6n = 0
If IsNull(totalex7y) Then totalex7y = 0
If IsNull(totalex7n) Then totalex7n = 0

'3. 전체 참여자 카운트
sqlStr = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' AND sub_opt1 = 'result' "
rsget.Open sqlStr,dbget,1
If not rsget.EOF Then
	totalresultCnt = rsget(0)
End If
rsget.close

'4.내가 참여한 것 카운트
sqlStr = ""
sqlStr = sqlStr & " SELECT TOP 1 ex1, ex2, ex3, ex4, ex5, ex6, ex7 "
sqlStr = sqlStr & " FROM db_temp.[dbo].[tbl_event_76299] "
sqlStr = sqlStr & " where userid = '"&LoginUserid&"' "
rsget.Open sqlStr,dbget,1
If not rsget.EOF Then
	myex1 = rsget("ex1")
	myex2 = rsget("ex2")
	myex3 = rsget("ex3")
	myex4 = rsget("ex4")
	myex5 = rsget("ex5")
	myex6 = rsget("ex6")
	myex7 = rsget("ex7")
End If
rsget.close
%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.onlyMe {text-align:center;}
.onlyMe button {background-color:transparent; outline:none;}
.onlyMe .inner {position:relative; width:1140px; margin:0 auto;}
.onlyMe .intro {position:relative; height:834px; background:#954ba2 url(http://webimage.10x10.co.kr/playing/thing/vol009/bg_particle_01.gif) 50% 0 no-repeat;}
.onlyMe .intro .some {position:absolute; left:50%; top:87px; margin-left:-282px; }
.onlyMe .intro h3 {position:absolute; left:50%; top:158px; margin-left:-196px;}
.onlyMe .intro h3 .q {position:absolute; right:-78px; top:-16px; animation:bounce 1s 1.5s 5;}
.onlyMe .intro .purpose {position:absolute; left:50%; top:306px; margin-left:-146px;}
.onlyMe .intro .btnStart {position:absolute; left:50%; top:493px; margin-left:-163px; cursor:pointer;}
.onlyMe .sympathyTest {padding:55px 0 115px; background-color:#fafaf9;}
.onlyMe .sympathyTest .swiper-container {height:800px; padding-top:80px;}
.onlyMe .sympathyTest .swiper-slide {position:relative; float:left; width:1140px;}
.onlyMe .sympathyTest .swiper-slide img {height:auto;}
.onlyMe .sympathyTest .swiper-slide {width:1134px;}
.onlyMe .sympathyTest .btnNav {position:absolute; left:50%; top:392px; z-index:30;}
.onlyMe .sympathyTest .btnPrev {margin-left:-535px;}
.onlyMe .sympathyTest .btnNext {margin-left:510px;}
.onlyMe .sympathyTest .btnGroup {overflow:hidden; width:960px; margin:0 auto; padding-top:32px;}
.onlyMe .sympathyTest .btnGroup button {display:inline-block; overflow:hidden; position:relative; width:355px; height:90px; margin:0 12px; text-align:left; vertical-align:top;}
.onlyMe .sympathyTest .btnGroup button:hover img,
.onlyMe .sympathyTest .btnGroup button.current img {margin-top:-90px;}
.onlyMe .sympathyTest .count {overflow:hidden; width:760px; margin:0 auto; padding-top:12px;}
.onlyMe .sympathyTest .count p {float:left; width:50%;}
.onlyMe .sympathyTest .count strong {display:inline-block; height:34px; padding-left:28px; color:#959595; font-size:15px; line-height:34px; background:url(http://webimage.10x10.co.kr/playing/thing/vol009/ico_yes.png) 0 50% no-repeat;}
.onlyMe .sympathyTest .count .no strong {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol009/ico_no.png);}
.onlyMe .sympathyTest .scene03 .deco {overflow:hidden; position:absolute; left:50%; top:478px; z-index:20; width:960px; height:156px; margin-left:-480px;}
.onlyMe .sympathyTest .scene03 .deco span {position:absolute; left:50%;}
.onlyMe .sympathyTest .scene03 .deco .foot01 {bottom:0; z-index:20; width:265px; height:156px; margin-left:-132px; background:url(http://webimage.10x10.co.kr/playing/thing/vol009/img_foot_01.png) 0 0 no-repeat;}
.onlyMe .sympathyTest .scene03 .deco .foot02 {bottom:25px; z-index:10; width:394px; height:69px; margin-left:-197px; opacity:0; filter:alpha(opacity=0); background:url(http://webimage.10x10.co.kr/playing/thing/vol009/img_foot_02.png) 0 0 no-repeat;}
.onlyMe .finish {position:relative; height:207px; padding-top:498px; background:#4ebbc2 url(http://webimage.10x10.co.kr/playing/thing/vol009/bg_particle_02.gif) 50% 0 no-repeat;}
.onlyMe .finish .total {position:absolute; left:50%; top:88px; z-index:10; width:154px; height:98px; margin-left:57px; padding-top:25px; text-align:center; line-height:22px; background:url(http://webimage.10x10.co.kr/playing/thing/vol009/bg_balloon.png) no-repeat 0 0; background-size:100%;}
.onlyMe .finish .total img:first-child {position:relative; top:1px;}
.onlyMe .finish .total strong {padding:0 1px 0 4px; color:#fe3992; font:bold 19px/20px arial; vertical-align:top;}
.onlyMe .finish .btnApply {overflow:hidden; display:block; position:absolute; left:50%; top:103px; height:373px; margin-left:-133px;animation: swinging 2s ease-in-out forwards infinite;  cursor:pointer;}
.onlyMe .finish .btnApply.current img {margin-top:-373px;}
/*.onlyMe .finish .btnApply em {display:inline-block; position:absolute; left:15px; top:190px; width:187px; height:62px; background:url(http://webimage.10x10.co.kr/playing/thing/vol009/txt_apply.png) 0 0 no-repeat;}
.onlyMe .finish .btnApply.current {background-color:#4d0069;}
.onlyMe .finish .btnApply.current em {background-position:0 100%;}*/
.onlyMe .finish .addMore {position:absolute; left:0; top:0; z-index:40; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol009/bg_mask.png) 0 0 repeat;}
.onlyMe .finish .addMore p {padding-top:100px;}
.onlyMe .tip {padding:58px 0 96px; background:url(http://webimage.10x10.co.kr/playing/thing/vol009/bg_slash.png) 0 0 repeat;}
.onlyMe .tip div {position:relative; width:405px; margin:0 auto;}
.onlyMe .tip div span {position:absolute; width:22px; height:22px; background:url(http://webimage.10x10.co.kr/playing/thing/vol009/ico_check.png) 0 0 no-repeat; opacity:0; filter:alpha(opacity=0);}
.onlyMe .tip .chk01 {left:27px; top:93px;}
.onlyMe .tip .chk02 {left:-1px; top:137px;}
.onlyMe .tip .chk03 {left:6px; top:180px;}
.vol009 {text-align:center; background-color:#ff84bb;}

/* animation */
@keyframes bounce{
from to {transform:scale(1); animation-timing-function:ease-out;}
50% {transform:scale(1.1); animation-timing-function:ease-in;}
}
@keyframes swinging{
	from,to{transform:rotate(-3deg);}
	50%{transform:rotate(6deg)}
}
</style>
<script type="text/javascript">
$(function(){
	var position = $('.headerPlayV16').offset(); // 위치값
	$('html,body').animate({ scrollTop : position.top }, 100); // 이동
	$('.btnPrev').hide();
	var mySwiper = new Swiper('.sympathyTest .swiper-container',{
		loop:false,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:600,
		onSlideChangeStart: function (mySwiper){
			$(".scene03").find(".foot01").delay(10).animate({"height":"156px"},900);
			$(".scene03").find(".foot02").delay(10).animate({"margin-bottom":"-20px","opacity":"0"},900);
			$(".swiper-slide-active.scene03").find(".foot01").delay(30).animate({"height":"0"},700);
			$(".swiper-slide-active.scene03").find(".foot02").delay(200).animate({"margin-bottom":"0","opacity":"1"},900);
			$('.btnPrev').fadeIn(300);
			$('.btnNext').fadeIn(300);
			if ($('.swiper-slide-active').is(".scene01")) {
				$('.btnPrev').fadeOut(300);
			}
			if ($('.swiper-slide-active').is(".scene07")) {
				$('.btnNext').fadeOut(300);
			}
		}
	})
	$('.sympathyTest .btnPrev').on('click', function(e){
		e.preventDefault();
		mySwiper.swipePrev();
	});
	$('.sympathyTest .btnNext').on('click', function(e){
		e.preventDefault();
		mySwiper.swipeNext();
	});
	$(".intro .btnStart, .addMore a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(".sympathyTest .swiper-container").offset().top}, 800);
	});
	$(".scene07 .btnGroup button").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(".finish").offset().top}, 800);
	});

	<% if pagereload<>"" then %>
		window.parent.$('html,body').animate({scrollTop:$(".finish").offset().top}, 800);
	<% end if %>

	// title animation
	titleAnimation()
	$(".intro .some").css({"margin-top":"-10px","opacity":"0"});
	$(".intro h3").css({"margin-top":"-10px","opacity":"0"});
	function titleAnimation() {
		$(".intro .some").delay(100).animate({"margin-top":"10px", "opacity":"1"},400).animate({"margin-top":"0"},600);
		$(".intro h3").delay(600).animate({"margin-top":"10px", "opacity":"1"},400).animate({"margin-top":"0"},600);
	}

	$(".onlyMe .tip span").css({"margin-top":"5px","opacity":"0"});
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 2400 ) {
			$(".onlyMe .tip .chk01").delay(100).animate({"margin-top":"0", "opacity":"1"},500);
			$(".onlyMe .tip .chk02").delay(500).animate({"margin-top":"0", "opacity":"1"},500);
			$(".onlyMe .tip .chk03").delay(900).animate({"margin-top":"0", "opacity":"1"},500);
		}
	});
});

function jsplayingthing(num, sel){
<%
If myresultCnt > 0 Then
%>
	alert('이미 응모하였습니다.');
	return false;
<%
Else
%>
	var statYcnt = parseInt($("#ex"+sel+"ycnt").text());
	var statNcnt = parseInt($("#ex"+sel+"ncnt").text());

	if(sel == 1) {if($("#tmpex1").val()== num){num=0;$("#tmpex1").val(0);}else{$("#tmpex1").val(num);}}
	if(sel == 2) {if($("#tmpex2").val()== num){num=0;$("#tmpex2").val(0);}else{$("#tmpex2").val(num);}}
	if(sel == 3) {if($("#tmpex3").val()== num){num=0;$("#tmpex3").val(0);}else{$("#tmpex3").val(num);}}
	if(sel == 4) {if($("#tmpex4").val()== num){num=0;$("#tmpex4").val(0);}else{$("#tmpex4").val(num);}}
	if(sel == 5) {if($("#tmpex5").val()== num){num=0;$("#tmpex5").val(0);}else{$("#tmpex5").val(num);}}
	if(sel == 6) {if($("#tmpex6").val()== num){num=0;$("#tmpex6").val(0);}else{$("#tmpex6").val(num);}}
	if(sel == 7) {if($("#tmpex7").val()== num){num=0;$("#tmpex7").val(0);}else{$("#tmpex7").val(num);}}

<%
	If IsUserLoginOK() Then
		If date() >="2017-02-24" and date() <= "2017-03-12" Then
%>
		$.ajax({
			type: "GET",
			url: "/playing/sub/doEventSubscript76299.asp",
			data: "mode=add&num="+num+"&sel="+sel,
			cache: false,
			success: function(str) {
				str = str.replace("undefined","");
				res = str.split("|");
				if (res[0]=="OK") {
					if(num==1){
						if ($("#ex"+sel+"n").attr("class") == "btnN current" ){
							$("#ex"+sel+"ncnt").text(statNcnt - 1);
							$("#ex"+sel+"n").removeClass("current");
							$("#ex"+sel+"ycnt").text(statYcnt + 1);
							$("#ex"+sel+"y").addClass("current");
						}else if($("#ex"+sel+"y").attr("class") == "btnY current" ){
							$("#ex"+sel+"ycnt").text(statYcnt - 1);
							$("#ex"+sel+"y").removeClass("current");
						}else{
							$("#ex"+sel+"ycnt").text(statYcnt + 1);
							$("#ex"+sel+"y").addClass("current");
						}
					}else if(num==2){
						if ($("#ex"+sel+"y").attr("class") == "btnY current" ){
							$("#ex"+sel+"ycnt").text(statYcnt - 1);
							$("#ex"+sel+"y").removeClass("current");
							$("#ex"+sel+"ncnt").text(statNcnt + 1);
							$("#ex"+sel+"n").addClass("current");
						}else if($("#ex"+sel+"n").attr("class") == "btnN current" ){
							$("#ex"+sel+"ncnt").text(statNcnt - 1);
							$("#ex"+sel+"n").removeClass("current");
						}else{
							$("#ex"+sel+"ncnt").text(statNcnt + 1);
							$("#ex"+sel+"n").addClass("current");
						}
					}else{
						if ($("#ex"+sel+"y").attr("class") == "btnY current" ){
							$("#ex"+sel+"ycnt").text(statYcnt - 1);
							$("#ex"+sel+"y").removeClass("current");	
						}else{
							$("#ex"+sel+"ncnt").text(statNcnt - 1);
							$("#ex"+sel+"n").removeClass("current");	
						}
					}
				} else {
					errorMsg = res[1].replace(">?n", "\n");
					alert(errorMsg );
					return false;
				}
			}
			,error: function(err) {
				alert(err.responseText);
				console.log(err.responseText);
				alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
			}
		});
<%
		Else
%>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;			
<%
		End If
	Else
%>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
<%
	End If
End If
%>
}

function jsplayingthingresult(){
<%
If myresultCnt > 0 Then
%>
	alert('이미 응모하였습니다.');
	return false;
<%
End If 

If IsUserLoginOK() Then 
	If date() >="2017-02-24" and date() <= "2017-03-12" Then
%>
	$.ajax({
		type: "GET",
		url: "/playing/sub/doEventSubscript76299.asp",
		data: "mode=result",
		cache: false,
		success: function(str) {
			str = str.replace("undefined","");
			res = str.split("|");
			if (res[0]=="OK") {
				alert('응모가 완료 되었습니다!');
				document.frmcom.submit();
				//window.parent.$('html,body').animate({scrollTop:$(".finish").offset().top}, 800);
			}else if (res[0] !="OK" && res[1] == 'addvote') {
				$("#addMore").empty().html(res[2]);
				$("#addMore").show();
			} else {
				errorMsg = res[1].replace(">?n", "\n");
				alert(errorMsg );
				return false;
			}
		}
		,error: function(err) {
			console.log(err.responseText);
			alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요..");
		}
	});
<%
	Else
%>
		alert("이벤트 응모 기간이 아닙니다.");
		return false;	
<%
	End If
Else
%>
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
<%
End If
%>
}

function lyhide(){
	$("#addMore").hide();
}
</script>
<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
<input type="hidden" name="pagereload" value="on">
</form>
<div class="thingVol009 onlyMe">
	<div class="intro">
		<p class="some"><img src="http://webimage.10x10.co.kr/playing/thing/vol009/txt_sometimes.png" alt="나만 그래" /></p>
		<h3 >
			<img src="http://webimage.10x10.co.kr/playing/thing/vol009/tit_only_me.png" alt="나만 그래" />
			<span class="q"><img src="http://webimage.10x10.co.kr/playing/thing/vol009/tit_question.png" alt="?" /></span>
		</h3>
		<p class="purpose"><img src="http://webimage.10x10.co.kr/playing/thing/vol009/txt_purpose.png" alt="가끔 이렇지 않아? 나만 그래?라고 친구들과 공감가는 이야기 하지 않나요? 나와 같은 사람들이 얼마나 있는지 함께 공감하고 투표해주시면 기프트하크 2만원권을 드립니다" /></p>
		<div id="btnStart" class="btnStart"><a onclick="jsChklogin('<%=IsUserLoginOK%>');return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_start_v2.gif" alt="공감 START" /></a></div>
	</div>
	<div id="sympathyTest" class="sympathyTest">
	<input type="hidden" name="tmpex1" id="tmpex1" value="<%=myex1%>">
	<input type="hidden" name="tmpex2" id="tmpex2" value="<%=myex2%>">
	<input type="hidden" name="tmpex3" id="tmpex3" value="<%=myex3%>">
	<input type="hidden" name="tmpex4" id="tmpex4" value="<%=myex4%>">
	<input type="hidden" name="tmpex5" id="tmpex5" value="<%=myex5%>">
	<input type="hidden" name="tmpex6" id="tmpex6" value="<%=myex6%>">
	<input type="hidden" name="tmpex7" id="tmpex7" value="<%=myex7%>">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<%' 질문1 %>
				<div class="swiper-slide scene01">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol009/img_scene_01.gif" alt="01.핸드폰을 들고선 핸드폰을 찾은 적 있다!" /></p>
					<div class="btnGroup">
						<%' for dev msg : 선택시 클래스 current %>
						<button class="btnY<%= Chkiif(myex1=1, " current", "") %>" id="ex1y" onclick="jsplayingthing('1','1'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_yes_01.png" alt="YES 맞아! 나도그래" /></button>
						<button class="btnN<%= Chkiif(myex1=2, " current", "") %>" id="ex1n" onclick="jsplayingthing('2','1'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_no_01.png" alt="NO 아니..너만그래" /></button>
					</div>
					<div class="count">
						<p class="yes"><strong><span id="ex1ycnt"><%= totalex1y %></span>명</strong></p>
						<p class="no"><strong><span id="ex1ncnt"><%= totalex1n %></span>명</strong></p>
					</div>
				</div>
				<%' 질문2 %>
				<div class="swiper-slide scene02">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol009/img_scene_02_v1.gif" alt="02.여행 갈 때 꼭 필요하지 않은 많은 짐을 가져간다" /></p>
					<div class="btnGroup">
						<button class="btnY<%= Chkiif(myex2=1, " current", "") %>" id="ex2y" onclick="jsplayingthing('1','2'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_yes_02.png" alt="YES 맞아! 나도그래" /></button>
						<button class="btnN<%= Chkiif(myex2=2, " current", "") %>" id="ex2n" onclick="jsplayingthing('2','2'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_no_02.png" alt="NO 아니..너만그래" /></button>
					</div>
					<div class="count">
						<p class="yes"><strong><span id="ex2ycnt"><%= totalex2y %></span>명</strong></p>
						<p class="no"><strong><span id="ex2ncnt"><%= totalex2n %></span>명</strong></p>
					</div>
				</div>
				<%' 질문3 %>
				<div class="swiper-slide scene03">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol009/img_scene_03.gif" alt="03.이불 덮을 때 발은 요렇게 이불 속으로 넣는다" /></p>
					<div class="deco">
						<span class="foot01"></span>
						<span class="foot02"></span>
					</div>
					<div class="btnGroup">
						<button class="btnY<%= Chkiif(myex3=1, " current", "") %>" id="ex3y" onclick="jsplayingthing('1','3'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_yes_03.png" alt="YES 맞아! 나도그래" /></button>
						<button class="btnN<%= Chkiif(myex3=2, " current", "") %>" id="ex3n" onclick="jsplayingthing('2','3'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_no_03.png" alt="NO 아니..너만그래" /></button>
					</div>
					<div class="count">
						<p class="yes"><strong><span id="ex3ycnt"><%= totalex3y %></span>명</strong></p>
						<p class="no"><strong><span id="ex3ncnt"><%= totalex3n %></span>명</strong></p>
					</div>
				</div>
				<%' 질문4 %>
				<div class="swiper-slide scene04">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol009/img_scene_04.gif" alt="04.보도블럭이나 횡단보도 지나갈때 흰선만 밟는다" /></p>
					<div class="btnGroup">
						<button class="btnY<%= Chkiif(myex4=1, " current", "") %>" id="ex4y" onclick="jsplayingthing('1','4'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_yes_04.png" alt="YES 맞아! 나도그래" /></button>
						<button class="btnN<%= Chkiif(myex4=2, " current", "") %>" id="ex4n" onclick="jsplayingthing('2','4'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_no_04.png" alt="NO 아니..너만그래" /></button>
					</div>
					<div class="count">
						<p class="yes"><strong><span id="ex4ycnt"><%= totalex4y %></span>명</strong></p>
						<p class="no"><strong><span id="ex4ncnt"><%= totalex4n %></span>명</strong></p>
					</div>
				</div>
				<%' 질문5 %>
				<div class="swiper-slide scene05">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol009/img_scene_05.gif" alt="05." /></p>
					<div class="btnGroup">
						<button class="btnY<%= Chkiif(myex5=1, " current", "") %>" id="ex5y" onclick="jsplayingthing('1','5'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_yes_05.png" alt="YES 맞아! 나도그래" /></button>
						<button class="btnN<%= Chkiif(myex5=2, " current", "") %>" id="ex5n" onclick="jsplayingthing('2','5'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_no_05.png" alt="NO 아니..너만그래" /></button>
					</div>
					<div class="count">
						<p class="yes"><strong><span id="ex5ycnt"><%= totalex5y %></span>명</strong></p>
						<p class="no"><strong><span id="ex5ncnt"><%= totalex5n %></span>명</strong></p>
					</div>
				</div>
				<%' 질문6 %>
				<div class="swiper-slide scene06">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol009/img_scene_06.gif" alt="06." /></p>
					<div class="btnGroup">
						<button class="btnY<%= Chkiif(myex6=1, " current", "") %>" id="ex6y" onclick="jsplayingthing('1','6'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_yes_06.png" alt="YES 맞아! 나도그래" /></button>
						<button class="btnN<%= Chkiif(myex6=2, " current", "") %>" id="ex6n" onclick="jsplayingthing('2','6'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_no_06.png" alt="NO 아니..너만그래" /></button>
					</div>
					<div class="count">
						<p class="yes"><strong><span id="ex6ycnt"><%= totalex6y %></span>명</strong></p>
						<p class="no"><strong><span id="ex6ncnt"><%= totalex6n %></span>명</strong></p>
					</div>
				</div>
				<%' 질문7 %>
				<div class="swiper-slide scene07">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol009/img_scene_07_v1.gif" alt="07." /></p>
					<div class="btnGroup">
						<button class="btnY<%= Chkiif(myex7=1, " current", "") %>" id="ex7y" onclick="jsplayingthing('1','7'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_yes_07.png" alt="YES 맞아! 나도그래" /></button>
						<button class="btnN<%= Chkiif(myex7=2, " current", "") %>" id="ex7n" onclick="jsplayingthing('2','7'); return false;""><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_no_07.png" alt="NO 아니..너만그래" /></button>
					</div>
					<div class="count">
						<p class="yes"><strong><span id="ex7ycnt"><%= totalex7y %></span>명</strong></p>
						<p class="no"><strong><span id="ex7ncnt"><%= totalex7n %></span>명</strong></p>
					</div>
				</div>
			</div>
			<button type="button" class="btnNav btnPrev"><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_prev.png" alt="이전" /></button>
			<button type="button" class="btnNav btnNext"><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_next.png" alt="다음" /></button>
		</div>
	</div>
	<%' 응모하기(질문 5개이상 참여 시 응모가능) %>
	<div class="finish">
		<div class="total">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol009/txt_count_01.png" alt="총" />
			<strong><%= totalresultCnt %></strong><img src="http://webimage.10x10.co.kr/playing/thing/vol009/txt_count_02.png" alt="명이" /><br />
			<img src="http://webimage.10x10.co.kr/playing/thing/vol009/txt_count_03.png" alt="응모했습니다" />
		</div>
		<%' for dev msg : 질문 5개이상 참여시 버튼에 클래스 current 추가, 질문 5개 이하 참여시 addMore 영역 노출 %>
		<span class="btnApply<%= Chkiif(myresultCnt > 0, " current", "") %>" onclick="jsplayingthingresult(); return false;" id="bApply"><!--em></em--><img src="http://webimage.10x10.co.kr/playing/thing/vol009/btn_submit_v1.png" alt="응모하기" /></span>
		<div id="addMore" class="addMore" style="display:none;"></div>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol009/txt_event.png" alt="공감이야기에 투표를 해주시는 분들중 10분에게 추첨을 통해 기프트카드 2만원권을 드립니다." /></p>
	</div>
	<div class="tip">
		<div>
			<img src="http://webimage.10x10.co.kr/playing/thing/vol009/txt_tip.png" alt="당첨확률 높이는 TIP" />
			<span class="chk01"></span><span class="chk02"></span><span class="chk03"></span>
		</div>
	</div>
	<div class="vol009"><img src="http://webimage.10x10.co.kr/playing/thing/vol009/txt_vol009.png" alt="THING의 사물에 대한 생각 나의 금전감각에 따라 알맞는 가계부 쓰자!" /></div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->