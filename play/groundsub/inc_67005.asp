<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'########################################################
' PLAY #23 summer 5주차 
' 2015-08-28 이종화 작성
'########################################################
Dim eCode , sqlStr , userid , totcnt , iCTotCnt, pagereload
Dim rank(4) , seltoy(4) , selcnt(4)
pagereload	= requestCheckVar(request("pagereload"),2)

IF application("Svr_Info") = "Dev" THEN
	eCode   =  "64935"
Else
	eCode   =  "67005"
End If

userid = GetEncLoginUserID

If GetEncLoginUserID <> "" then
	sqlStr = "select count(*) from db_event.dbo.tbl_event_subscript where userid = '"& userid &"' and evt_code = '"& ecode &"' and datediff(day,regdate,getdate()) = 0 " 
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly 

	IF Not rsget.Eof Then
		totcnt = rsget(0)
	End IF
	rsget.close()
End If 

	sqlStr = "select count(*) from db_event.dbo.tbl_event_subscript where evt_code = '"& ecode &"' " 
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly 

	IF Not rsget.Eof Then
		iCTotCnt = rsget(0)
	End IF
	rsget.close()

	Dim ii : ii = 0
	Dim vi
	sqlStr = "select RANK() OVER (ORDER BY count(*) desc) as ranking "
	sqlStr = sqlStr & " , sub_opt1 , count(*) as totcnt "
	sqlStr = sqlStr & "	from db_event.dbo.tbl_event_subscript where evt_code = '"& ecode &"' " 
	sqlStr = sqlStr & "	group by sub_opt1 " 
	sqlStr = sqlStr & "	order by totcnt desc " 
	rsget.CursorLocation = adUseClient

	'response.write sqlStr & "<br>"
	rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
	If Not rsget.Eof Then
		Do Until rsget.eof
			rank(ii)	= rsget("ranking")
			seltoy(ii)	= rsget("sub_opt1")
			selcnt(ii)	= rsget("totcnt")
		ii = ii + 1
		rsget.movenext
		Loop
	End IF
	rsget.close

	for ii = 0 To 3
		For vi = 1 To 4
			If seltoy(ii) = "" And seltoy(ii) <> vi Then
				seltoy(ii) = vi
			End if
		next
	Next 
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.toyCont {position:relative; width:1140px; margin:0 auto;}
.imYourMan {position:relative; text-align:center;}
.imYourMan .txt {overflow:hidden; position:relative; margin:0 auto;}
.imYourMan .txt p {overflow:hidden;  position:absolute; width:100%;}
.imYourMan .txt span {display:block; position:absolute; left:0; width:0; margin-left:50%;}
.imYourMan .txt em {display:block;position:absolute; width:100%; height:100%;}
.imYourMan .txt p img {position:relative;}
.imYourMan .txt .t01 {top:0;}
.imYourMan .txt .t02 {height:45px; bottom:0;}
.imYourMan .txt .t02 img {top:-45px;}
.imYourMan .flower {position:absolute; bottom:-233px; right:27%; z-index:10;}
.intro {overflow:hidden; position:relative; height:939px; background:#fe9273;}
.intro h3 {position:absolute; width:269px; left:50%; top:303px; margin-left:-135px; z-index:50;}
.intro h3 span {display:inline-block; padding-bottom:36px; margin-left:15px; opacity:0; filter:alpha(opacity=0);}
.intro h3 span.t02 {margin-left:-15px;}
.intro .square {position:absolute; left:50%; top:196px; width:451px; height:546px; margin-left:-225px; background:url(http://webimage.10x10.co.kr/play/ground/20151026/bg_frame.png) 0 0 no-repeat; z-index:50; opacity:0; filter:alpha(opacity=0);}
.intro .lego {position:absolute; left:18%; bottom:0; z-index:40;}
.intro .hand {position:absolute; right:-20%; top:-6%; z-index:40; opacity:0; filter:alpha(opacity=0);}
.purpose {overflow:hidden; height:0; background:#fbfbf9 url(http://webimage.10x10.co.kr/play/ground/20151026/bg_shadow.gif) 0 0 repeat-x;}
.purpose .toyCont {overflow:hidden; width:930px; padding:62px 0 0 20px;}
.manual {padding:138px 0 114px; background:#fbfbf9 url(http://webimage.10x10.co.kr/play/ground/20151026/bg_heart.gif) 0 0 repeat;}
.manual .process {overflow:hidden; width:980px; margin:0 auto; padding:118px 0;}
.manual .process li {float:left; padding:0 50px;}
.manual .process li img {position:relative; left:-10px; opacity:0; filter:alpha(opacity=0);}
.manual .noti {position:relative; top:5px; opacity:0; filter:alpha(opacity=0);}
.selectToy {padding-top:68px; background:#f0f0f0;}
.selectToy .txt {width:598px; height:152px;}
.selectToy .txt .t01 {height:64px;}
.selectToy .txt .t01 img {bottom:-64px;}
.selectToy .txt span {top:82px; height:4px; background:url(http://webimage.10x10.co.kr/play/ground/20151026/bg_line01.gif) 50% 0 no-repeat;}
.selectToy .tabCont {position:relative;}
.selectToy .pic img {width:100%;}
.selectToy .pic a {display:block; position:absolute; left:50%; top:0; width:1200px; height:100%; margin-left:-600px; background:url(http://webimage.10x10.co.kr/play/ground/20151026/bg_blank.png) 0 0 repeat; z-index:50;}
.selectToy .toyStyle {padding-top:60px;}
.selectToy .toyStyle ul {overflow:hidden; width:1126px; margin:0 auto; padding-bottom:87px;}
.selectToy .toyStyle li {float:left; padding:0 15px;}
.selectToy .toyStyle li a {position:relative; display:block; width:251px; height:445px; background-image:url(http://webimage.10x10.co.kr/play/ground/20151026/img_toy_man.png); background-repeat:no-repeat;}
.selectToy .toyStyle li a span {display:none; width:244px; height:445px; background:url(http://webimage.10x10.co.kr/play/ground/20151026/bg_over.png) 1px 0 no-repeat; }
.selectToy .toyStyle li a span strong {overflow:hidden; display:block; height:31px; padding-top:185px;}
.selectToy .toyStyle li a span strong img {position:relative; top:31px;}
.selectToy .toyStyle li a.on span strong img {top:0 !important;}
.selectToy .toyStyle li a.on span,
.selectToy .toyStyle li a:hover span {display:block;}
.selectToy .toyStyle li.t01 a {background-position:0 0;}
.selectToy .toyStyle li.t02 a {background-position:-251px 0;}
.selectToy .toyStyle li.t03 a {background-position:-502px 0;}
.selectToy .toyStyle li.t04 a {background-position:-753px 0;}
.selectToy .tabCont .desc {position:absolute; text-align:left; z-index:60;}
.selectToy .tabCont .desc p {padding:0 0 50px 13px;}
.selectToy #toy01 .desc {left:24%; top:12%;}
.selectToy #toy02 .desc {left:60%; top:17%;}
.selectToy #toy03 .desc {left:24%; top:12%;}
.selectToy #toy04 .desc {left:60%; top:13%; text-align:right;}
.selectToy #toy04 .desc p {padding:0 4px 50px 0;}
.result {position:relative; padding-top:93px; font-family:tahoma; z-index:100;}
.result .txt {width:830px; height:145px;}
.result .txt span {top:73px; height:1px; background:#fff;}
.result .txt .t01 {height:50px;}
.result .txt .t01 img {bottom:-50px;}
.result ol {width:613px; margin:0 auto; padding-top:67px;}
.result ol li {position:relative; width:613px; height:87px; margin-bottom:10px; background:url(http://webimage.10x10.co.kr/play/ground/20151026/bg_rank02.png) 0 0 no-repeat;}
.result ol li .ranking {position:absolute; left:122px; top:31px; display:block; width:32px; height:22px; text-indent:-9999px; background-image:url(http://webimage.10x10.co.kr/play/ground/20151026/txt_ranking.png); background-repeat:no-repeat;}
.result ol li.rank01 {background-image:url(http://webimage.10x10.co.kr/play/ground/20151026/bg_rank01.png);}
.result ol li.rank01 .ranking {background-position:0 0;}
.result ol li.rank02 .ranking {background-position:0 -22px;}
.result ol li.rank03 .ranking {background-position:0 -44px;}
.result ol li.rank04 .ranking {background-position:0 -66px;}
.result ol li .count {display:inline-block; position:absolute; left:210px; top:29px; padding-left:28px; letter-spacing:background:url(http://webimage.10x10.co.kr/play/ground/20151026/txt_total01.png) 0 -57px no-repeat;}
.result ol li .count em {min-height:26px; padding-right:234px; font-size:27px; line-height:25px; color:#d5e4ff; background:url(http://webimage.10x10.co.kr/play/ground/20151026/txt_total02.png) 100% -53px no-repeat;}
.result ol li.rank01 .count {background-position:0 3px;}
.result ol li.rank01 .count em {color:#ec5b4f; background-position:100% 7px;}
.result ol li .thumb {display:inline-block; position:absolute; left:3px; top:3px; width:80px; height:80px; background-position:0 0; background-repeat:no-repeat;}
.result ol li.toy01 .thumb {background-image:url(http://webimage.10x10.co.kr/play/ground/20151026/img_thumb_toy01.png);}
.result ol li.toy02 .thumb {background-image:url(http://webimage.10x10.co.kr/play/ground/20151026/img_thumb_toy02.png);}
.result ol li.toy03 .thumb {background-image:url(http://webimage.10x10.co.kr/play/ground/20151026/img_thumb_toy03.png);}
.result ol li.toy04 .thumb {background-image:url(http://webimage.10x10.co.kr/play/ground/20151026/img_thumb_toy04.png);}
.result .total {display:inline-block; padding:40px 0 4px; border-bottom:3px solid #fff;}
.result .total em {position:relative; top:-2px; display:inline-block; font-size:34px; line-height:24px; padding:0 4px; color:#fff;}
@media all and (max-width:1800px){
	.intro .hand {right:-30% !important; top:9% !important;}
}
</style>
<script type="text/javascript">
<!--
 	function jsSubmitEvt(v){
		<% if Not(IsUserLoginOK) then %>
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return false;
			}
			return false;
		<% end if %>
	   
	   var frm = document.frmcom;
	   frm.spoint.value = v;
	   frm.action = "/play/groundsub/doeventsubscript67005.asp";
	   frm.submit();
	   return true;
	}

$(function(){
	$(".toyStyle ul").find("li:first a").addClass("on");
	$(".toyStyle li").click(function() {
		window.parent.$('html,body').animate({scrollTop:3800}, 300);
		$(this).siblings("li").find("a").removeClass("on");
		$(this).find("a").addClass("on");
		$(this).closest(".toyStyle ul").nextAll(".tabContainer:first").find(".tabCont").hide();
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).show();
		return false;
	});
	/*
	$('.toyStyle li a').mouseover(function(){
		$(this).find('span strong img').delay(100).animate({"top":"0"},300);
	});
	$('.toyStyle li').mouseleave(function(){
		$('.toyStyle li a span strong img').animate({"top":"31px"},50);
	});
	*/
	$('.toyStyle li a').mouseover(function(){
		$('.toyStyle li a.on span').css("display","none");
		$('.toyStyle li a.on span strong img').css("top","31px");
		$(this).css("display","block");
		$(this).find('span').css("display","block");
		$(this).find('span strong img').delay(100).animate({"top":"0"},300);
	});
	$('.toyStyle li').mouseleave(function(){
		$(this).find('span').css("display","none");
		$('.toyStyle li a span strong img').animate({"top":"31px"},50);
		$('.toyStyle li a.on span').css("display","block");
		$('.toyStyle li a.on span strong img').css("top","0");
	});
	//animation
	function intro() {
		$('.intro h3 span').delay(1000).animate({"margin-left":"0","opacity":"1"},1000);
		$('.intro .square').animate({"opacity":"1"},2000);
		$('.intro .hand').delay(1000).animate({"opacity":"1"},800).delay(100).animate({"right":"0","top":"9%"},1500);
	}
	function manual() {
		conChk = 1;
		$('.manual h4').effect("pulsate", {times:2},300 );
		$('.process .p01 img').delay(500).animate({"left":"0","opacity":"1"},500);
		$('.process .p02 img').delay(700).animate({"left":"0","opacity":"1"},500);
		$('.process .p03 img').delay(1000).animate({"left":"0","opacity":"1"},500);
		$('.manual .noti').delay(1500).animate({"top":"0","opacity":"1"},700);
	}
	function myType() {
		$('.selectToy .txt span').animate({"width":"100%","margin-left":"0","left":"0"},700);
		$('.selectToy .txt .t01 img').delay(700).animate({"bottom":"0"},700);
		$('.selectToy .txt .t02 img').delay(700).animate({"top":"0"},700);
	}
	function viewRank() {
		$('.result .txt span').animate({"width":"100%","margin-left":"0","left":"0"},700);
		$('.result .txt .t01 img').delay(700).animate({"bottom":"0"},700);
		$('.result .txt .t02 img').delay(700).animate({"top":"0"},700);
	}
	
	//$('.intro h3').animate({"top":"137px","opacity":"1"},1000);
	var conChk = 0;
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 300 ) {
			intro()
		}
		if (scrollTop > 1150 ) {
			$('.purpose').animate({"height":"305px"},800);
		}
		if (scrollTop > 1700 ) {
			if (conChk==0){
				manual();
			}
		}
		if (scrollTop > 2350 ) {
			myType()
		}
		if (scrollTop > 4200 ) {
			viewRank()
		}
	});

	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#mystudioEvt01").offset().top}, 0);
}

//-->
</script>
<div class="playGr20151026">
	<div class="imYourMan">
		<div class="intro">
			<h3>
				<span class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20151026/tit_im.png" alt="I'M" /></span>
				<span class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20151026/tit_your.png" alt="YOUR" /></span>
				<span class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20151026/tit_man.png" alt="MAN" /></span>
			</h3>
			<div class="square"></div>
			<div class="lego"><img src="http://webimage.10x10.co.kr/play/ground/20151026/img_lego.png" alt="" /></div>
			<div class="hand"><img src="http://webimage.10x10.co.kr/play/ground/20151026/img_hand.png" alt="" /></div>
		</div>
		<div class="purpose">
			<div class="toyCont">
				<p class="ftLt"><img src="http://webimage.10x10.co.kr/play/ground/20151026/tit_your_man.gif" alt="I'm Your Man" /></p>
				<p class="ftRt"><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_purpose.gif" alt="TOY로 찾아보는 내 남자 - 플레이에서는 여러분의 이상형을 찾기 위해 미팅을 준비했습니다! 우리의 '미팅男'들은 테이블 위에 자신만의 소지품을 올려두었습니다. 어떤 것을 선택하시겠어요? 4인 4색 멋지고 다양한 매력을 지닌 소지품 중 하나를 골라보세요!" /></p>
			</div>
		</div>
		<div class="manual">
			<h4><img src="http://webimage.10x10.co.kr/play/ground/20151026/tit_manual.png" alt="MEETING MANUAL" /></h4>
			<ul class="process">
				<li class="p01"><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_process01.png" alt="" /></li>
				<li class="p02"><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_process02.png" alt="" /></li>
				<li class="p03"><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_process03.png" alt="" /></li>
			</ul>
			<p class="noti"><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_noti.png" alt="" /></p>
		</div>
		<div class="selectToy">
			<div class="txt">
				<p class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_select01.gif" alt="과연 어떤 스타일의 남자일까요?" /></p>
				<p class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_select02.gif" alt="한가지 소지품을 골라보세요!" /></p>
				<span><em></em></span>
			</div>
			<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
				<input type="hidden" name="spoint" value=""/>
			</form>
			<div class="toyStyle">
				<ul>
					<li class="t01"><a href="#toy01"><span><strong><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_drone.png" alt="미니드론" /></strong></span></a></li>
					<li class="t02"><a href="#toy02"><span><strong><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_lamp.png" alt="토이조명" /></strong></span></a></li>
					<li class="t03"><a href="#toy03"><span><strong><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_gundam.png" alt="건담" /></strong></span></a></li>
					<li class="t04"><a href="#toy04"><span><strong><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_rc.png" alt="RC카" /></strong></span></a></li>
				</ul>
				<div class="tabContainer">
					<div id="toy01" class="tabCont">
						<div class="desc">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_toy_type01.png" alt="로맨틱한 남자" /></p>
							<input type="image" src="http://webimage.10x10.co.kr/play/ground/20151026/btn_date01.png" alt="데이트신청" class="btnDate" onclick="jsSubmitEvt(1);"/>
						</div>
						<div class="pic"><a href="/shopping/category_prd.asp?itemid=1335447"></a><img src="http://webimage.10x10.co.kr/play/ground/20151026/img_toy_type01.jpg" alt="" /></div>
					</div>
					<div id="toy02" class="tabCont">
						<div class="desc">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_toy_type02.png" alt="러블리한 남자" /></p>
							<input type="image" src="http://webimage.10x10.co.kr/play/ground/20151026/btn_date02.png" alt="데이트신청" class="btnDate" onclick="jsSubmitEvt(2);"/>
						</div>
						<div class="pic"><a href="/shopping/category_prd.asp?itemid=1119270"></a><img src="http://webimage.10x10.co.kr/play/ground/20151026/img_toy_type02.jpg" alt="" /></div>
					</div>
					<div id="toy03" class="tabCont">
						<div class="desc">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_toy_type03.png" alt="섬세한 남자" /></p>
							<input type="image" src="http://webimage.10x10.co.kr/play/ground/20151026/btn_date03.png" alt="데이트신청" class="btnDate" onclick="jsSubmitEvt(3);"/>
						</div>
						<div class="pic"><a href="/shopping/category_prd.asp?itemid=1285796"></a><img src="http://webimage.10x10.co.kr/play/ground/20151026/img_toy_type03.jpg" alt="" /></div>
					</div>
					<div id="toy04" class="tabCont">
						<div class="desc">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_toy_type04.png" alt="터프한 남자" /></p>
							<input type="image" src="http://webimage.10x10.co.kr/play/ground/20151026/btn_date04.png" alt="데이트신청" class="btnDate" onclick="jsSubmitEvt(4);"/>
						</div>
						<div class="pic"><a href="/shopping/category_prd.asp?itemid=1176066"></a><img src="http://webimage.10x10.co.kr/play/ground/20151026/img_toy_type04.jpg" alt="" /></div>
					</div>
				</div>
			</div>
		</div>
		<div class="result" id="mystudioEvt">
			<div class="txt">
				<p class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_who01.png" alt="어떤 남자에게 데이트 신청 하셨나요?" /></p>
				<p class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_who02.png" alt="미팅의 인기 순위를 공개합니다!" /></p>
				<span><em></em></span>
			</div>
			<ol>
				<li class="rank01 <% if selcnt(0)<>0 then %>toy0<%=seltoy(0)%><% end if %>" id="mystudioEvt01">
					<span class="thumb"></span>
					<span class="ranking">1위</span>
					<p class="count"><em><%=FormatNumber(selcnt(0),0)%></em></p>
				</li>
				<li class="rank02 <% if selcnt(1)<>0 then %>toy0<%=seltoy(1)%><% end if %>" id="mystudioEvt02">
					<span class="thumb"></span>
					<span class="ranking">2위</span>
					<p class="count"><em><%=FormatNumber(selcnt(1),0)%></em></p>
				</li>
				<li class="rank03 <% if selcnt(2)<>0 then %>toy0<%=seltoy(2)%><% end if %>" id="mystudioEvt03">
					<span class="thumb"></span>
					<span class="ranking">3위</span>
					<p class="count"><em><%=FormatNumber(selcnt(2),0)%></em></p>
				</li>
				<li class="rank04 <% if selcnt(3)<>0 then %>toy0<%=seltoy(3)%><% end if %>" id="mystudioEvt04">
					<span class="thumb"></span>
					<span class="ranking">4위</span>
					<p class="count"><em><%=FormatNumber(selcnt(3),0)%></em></p>
				</li>
			</ol>
			<p class="total" id="total">
				<img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_total_result01.png" alt="총" />
				<em><%=FormatNumber(iCTotCnt,0)%></em>
				<img src="http://webimage.10x10.co.kr/play/ground/20151026/txt_total_result02.png" alt="명이 데이트 신청을 했습니다." />
			</p>
		</div>
		<div class="flower"><img src="http://webimage.10x10.co.kr/play/ground/20151026/bg_flower.png" alt="" /></div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->