<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [컬쳐] 책! 책! 책! Check! Check! Check! 
' History : 2015.05.21 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->

<%
dim nowdate
dim eCode, ename, userid, sub_idx, i, intCLoop, leaficonimg
	userid = getloginuserid()
dim iCPerCnt, iCPageSize, iCCurrpage
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호

	nowdate = date()
'	nowdate = "2015-05-22"		'''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  61790
	Else
		eCode   =  62550
	End If

	IF iCCurrpage = "" THEN iCCurrpage = 1
	iCPageSize = 16		' 한페이지에 보여지는 댓글 수
	iCPerCnt = 10		'한페이지에 보여지는 페이징번호 1~10
	
	dim ccomment, cEvent
	set ccomment = new Cevent_etc_common_list
		ccomment.FPageSize        = iCPageSize
		ccomment.FCurrpage        = iCCurrpage
		ccomment.FScrollCount     = iCPerCnt
		ccomment.event_subscript_one
		ccomment.frectordertype="new"
		ccomment.frectevt_code    = eCode
		ccomment.event_subscript_paging
	
	set cEvent = new ClsEvtCont
		cEvent.FECode = eCode
		cEvent.fnGetEvent
		
		eCode		= cEvent.FECode	
		ename		= cEvent.FEName
	set cEvent = nothing
%>
<style type="text/css">
img {vertical-align:top;}
body {background-color:#fff;}
.evt62550 {background:#fff url(http://webimage.10x10.co.kr/eventIMG/2015/62550/bg_btm_v1.png) no-repeat 0 1001px; text-align:center;}
.evt62550 .topic {height:293px; padding-top:84px;}
.evt62550 .topic h1 {position:relative; width:839px; height:199px; margin:0 auto;}
.evt62550 .topic h1 span {position:absolute; display:block; background-color:transparent; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/62550/bg_topic.png); background-repeat:no-repeat;}
.letter1, .letter2, .letter3 {top:0; width:107px; height:54px; background-position:-266px 0; text-indent:-999em;}
.letter4, .letter5, .letter6 {top:77px; width:279px; height:113px; background-position:0 -77px; text-indent:-999em}
.letter1 {left:265px;}
.letter2 {left:372px;}
.letter3 {left:480px;}
.letter4 {left:0;}
.letter5 {left:280px;}
.letter6 {left:557px; background-position:-556px -77px;}
.letter7 {top:51px; right:100px;}
.letter7 { -webkit-animation-name:bounce; -webkit-animation-iteration-count:5; -webkit-animation-duration:1s; -moz-animation-name:bounce; -moz-animation-iteration-count:5; -moz-animation-duration:1s; -ms-animation-name:bounce; -ms-animation-iteration-count:5; -ms-animation-duration:1s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:7px; -webkit-animation-timing-function:ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:7px; animation-timing-function:ease-in;}
}

.take1 {background:url(http://webimage.10x10.co.kr/eventIMG/2015/62550/bg_top.png) no-repeat 0 0;}
.checkpoint1 {height:564px;}
.checkpoint1 .article {padding-top:25px;}
.checkpoint1 .article ul {width:990px; margin:0 auto;}
.checkpoint1 .article ul:after {content:' '; display:block; clear:both;}
.checkpoint1 .article ul li { float:left;}
.checkpoint1 .article ul li a {display:block; position:relative; width:198px; height:60px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/62550/bg_check_point_01.png) no-repeat 0 0; line-height:60px; text-align:center; text-indent:-999em;}
.checkpoint1 .article ul li .deco {display:none; position:absolute; top:-45px; left:108px; text-indent:0;}
.checkpoint1 .article ul li.genre2 .deco {left:88px;}
.checkpoint1 .article ul li.genre3 .deco {left:67px;}
.checkpoint1 .article ul li.genre4 .deco {left:48px;}
.checkpoint1 .article ul li.genre5 .deco {left:23px;}
.checkpoint1 .article ul li .on .deco {display:block; -webkit-animation-name:updown; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.7s; -moz-animation-name:updown; -moz-animation-iteration-count:infinite; -moz-animation-duration:0.7s; -ms-animation-name:updown; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.7s;}
@-webkit-keyframes updown {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:3px; -webkit-animation-timing-function:ease-in;}
}
@keyframes updown {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:3px; animation-timing-function:ease-in;}
}

.checkpoint1 .article ul li.genre2 a {background-position:-198px 0;}
.checkpoint1 .article ul li.genre3 a {background-position:-396px 0;}
.checkpoint1 .article ul li.genre4 a {background-position:-594px 0;}
.checkpoint1 .article ul li.genre5 a {background-position:100% 0;}
.checkpoint1 .article ul li.genre1 a:hover, .checkpoint1 .article ul li.genre1 .on {background-position:0 -60px;}
.checkpoint1 .article ul li.genre2 a:hover, .checkpoint1 .article ul li.genre2 .on {background-position:-198px -60px;}
.checkpoint1 .article ul li.genre3 a:hover, .checkpoint1 .article ul li.genre3 .on {background-position:-396px -60px;}
.checkpoint1 .article ul li.genre4 a:hover, .checkpoint1 .article ul li.genre4 .on {background-position:-594px -60px;}
.checkpoint1 .article ul li.genre5 a:hover, .checkpoint1 .article ul li.genre5 .on {background-position:100% -60px;}
.tabcont {height:336px;}

.checkpoint2 {height:230px; padding-top:53px;}
.checkpoint2 ul {width:933px; margin:32px auto 0;}
.checkpoint2 ul:after {content:' '; display:block; clear:both;}
.checkpoint2 ul li {float:left;}
.checkpoint2 ul li button {position:relative; width:310px; height:108px; background-color:transparent; font-size:11px; line-height:108px; text-align:center;}
.checkpoint2 ul li button .area {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/62550/bg_check_point_02.png) no-repeat 0 0;}
.checkpoint2 ul li.plan2 button .area {background-position:-310px 0;}
.checkpoint2 ul li.plan3 button .area {background-position:100% 0;}
.checkpoint2 ul li .deco {display:none; position:absolute; top:-29px; right:10px;}
.checkpoint2 ul li .on .deco {display:block; -webkit-animation-name:updown; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.7s; -moz-animation-name:updown; -moz-animation-iteration-count:infinite; -moz-animation-duration:0.7s; -ms-animation-name:updown; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.7s;}

.checkpoint3 {height:349px; padding-top:45px;}
.itext {width:832px; height:69px; margin:23px auto 28px; padding:17px 0 0 68px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/62550/bg_input.png) no-repeat 0 0; text-align:left;}
.itext input {width:535px; height:45px; padding:0 0 0 61px; border-bottom:1px solid #ccc; color:#bfbfbf; font-size:24px; font-family:'돋움', 'Dotum', 'Verdana'; line-height:45px;}
.itext input:focus {color:#000;}

.noti {position:relative; padding-bottom:48px; text-align:left;}
.noti h2 {position:absolute; top:0; left:120px;}
.noti ul {overflow:hidden; padding-left:290px;}
.noti ul li {float:left; width:410px; margin-bottom:5px; padding-left:15px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/62550/blt_arrow.png) no-repeat 0 2px; color:#000; font-size:11px; line-height:1.5em;}

.commentlist {overflow:hidden; width:1160px; margin-right:-20px; padding-top:42px; padding-bottom:35px;}
.commentlist .desc {float:left; width:271px; height:222px; margin:0 19px 20px 0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/62550/bg_comment.png); background-repeat:no-repeat;}
.commentlist .desc1 {background-position:-289px 0;}
.commentlist .desc2 {background-position:-579px 0;}
.commentlist .desc3 {background-position:0 0;}
.commentlist .desc .id, .commentlist .desc p {color:#000; font-size:14px; font-family:'돋움', 'Dotum', 'Verdana'; line-height:1.438em;}
.commentlist .desc .id {display:block; width:200px; padding-top:60px; padding-left:44px;}
.commentlist .desc p {overflow:hidden; width:200px; height:28px; margin-top:12px; padding-left:44px; font-size:17px; font-weight:bold; line-height:26px; letter-spacing:-0.08em; text-align:center;}
.pageMove {display:none;}
</style>
<script type="text/javascript">

function jsSubmitComment(frm){      //코멘트 입력
	<% If IsUserLoginOK() Then %>
		<% If Now() > #05/29/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If nowdate>="2015-05-22" and nowdate<"2015-05-30" Then %>
				if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 20 || frm.txtcomm.value == '잠을 줄여서라도(10자 이하로 써주세요)'){
					alert("코멘트가 없거나 제한길이를 초과하였습니다.(10자 이하로 써주세요)");
					frm.txtcomm.focus();
					return;
				}

				//책 선택
				var selectvaluebook
				if($("#cont1").attr("class") == "on"){
					selectvaluebook = "1";
				}else if ($("#cont2").attr("class") == "on"){
					selectvaluebook = "2";
				}else if ($("#cont3").attr("class") == "on"){
					selectvaluebook = "3";
				}else if ($("#cont4").attr("class") == "on"){
					selectvaluebook = "4";
				}else if ($("#cont5").attr("class") == "on"){
					selectvaluebook = "5";
				}else{
					selectvaluebook = "1";
				}

				//책 수량 선택
				var selectvaluecount
				if($("#count1").attr("class") == "on"){
					selectvaluecount = "1";
				}else if ($("#count2").attr("class") == "on"){
					selectvaluecount = "2";
				}else if ($("#count3").attr("class") == "on"){
					selectvaluecount = "3";
				}else{
					selectvaluebook = "1";
				}
		   		frm.mode.value="addcomment";
		   		frm.book.value=selectvaluebook;
		   		frm.bookcount.value=selectvaluecount;
				frm.action="/event/etc/doeventsubscript/doEventSubscript62550.asp";
				frm.target="evtFrmProc";
				frm.submit();
				return;
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>				
		<% End If %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function jsDelComment(sub_idx)	{
	if(confirm("삭제하시겠습니까?")){
		frmcomm.sub_idx.value = sub_idx;
		frmcomm.mode.value="delcomment";
		frmcomm.action="/event/etc/doeventsubscript/doEventSubscript62550.asp";
		frmcomm.target="evtFrmProc";
   		frmcomm.submit();
	}
}

function jsGoComPage(iP){
	document.frmcomm.iCC.value = iP;
	document.frmcomm.submit();
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}
	
	if (frmcomm.txtcomm.value == '잠을 줄여서라도(10자 이하로 써주세요)'){
		frmcomm.txtcomm.value='';
	}
}
</script>

</head>
<body>
	<!-- iframe -->
	<div class="evt62550">
		<div class="take1">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/txt_date.png" alt="이벤트 기간은 5월 22일부터 5월 29일까지며 당첨자 발표는 6월 1일 입니다." /></p>
			<div class="topic">
				<h1>
					<span class="letter1">책!</span>
					<span class="letter2">책!</span>
					<span class="letter3">책!</span>
					<span class="letter4">Check!</span>
					<span class="letter5">Check!</span>
					<span class="letter6">Check!</span>
					<span class="letter7"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/ico_check_01.png" alt="" /></span>
				</h1>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/txt_get_book.png" alt="올해 초에 세운 독서계획, 얼마나 지키셨나요? 독서계획을 다시 체크하고, 150분께 드리는 텐바이텐의 도서 선물도 받아가세요!" /></p>
			</div>

			<!-- Check Point 1 -->
			<div class="checkpoint1">
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/tit_check_point_01.png" alt="Check Point 1 내가 좋아하는 도서 장르는?" /></h2>
				<div class="article">
					<!-- for dev msg : 장르 탭입니다. 활성화 표시는 a에 클래스 "on"입니다. -->
					<ul>
						<li class="genre1">
							<a href="#cont1" id="cont1">소설<span class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/ico_check_02.png" alt="" /></span></a>
						</li>
						<li class="genre2">
							<a href="#cont2" id="cont2">취미<span class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/ico_check_02.png" alt="" /></span></a>
						</li>
						<li class="genre3">
							<a href="#cont3" id="cont3">여행<span class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/ico_check_02.png" alt="" /></span></a>
						</li>
						<li class="genre4">
							<a href="#cont4" id="cont4">에세이<span class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/ico_check_02.png" alt="" /></span></a>
						</li>
						<li class="genre5">
							<a href="#cont5" id="cont5">인문<span class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/ico_check_02.png" alt="" /></span></a>
						</li>
					</ul>
					<div class="tabcont">
						<div id="cont1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/img_book_01.jpg" alt="" /></div>
						<div id="cont2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/img_book_02.jpg" alt="" /></div>
						<div id="cont3"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/img_book_03.jpg" alt="" /></div>
						<div id="cont4"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/img_book_04.jpg" alt="" /></div>
						<div id="cont5"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/img_book_05.jpg" alt="" /></div>
					</div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/txt_note.png" alt="제공되는 도서는, 위와 같은 장르의 다른 도서가 발송될 수 있습니다." /></p>
				</div>
			</div>

			<!-- Check Point 2 -->
			<div class="checkpoint2">
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/tit_check_point_02.png" alt="Check Point 2 연말까지 당신의 계획을 체크해 주세요!" /></h2>
				<!-- for dev msg : 계획 체크 부분입니다. 활성화 표시는 button에 클래스 "on"입니다. -->
				<ul>
					<li class="plan1">
						<button type="button" id="count1"><span class="area"></span>나는 12월 31일까지 한 달에 1권 씩 7권을 <span class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/ico_check_02.png" alt="" /></span></button>
					</li>
					<li class="plan2">
						<button type="button" id="count2"><span class="area"></span>나는 12월 31일까지 한 달에 2권 씩 14권을 <span class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/ico_check_02.png" alt="" /></span></button>
					</li>
					<li class="plan3">
						<button type="button" id="count3"><span class="area"></span>나는 12월 31일까지 한 달에 3권 씩 21권을 <span class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/ico_check_02.png" alt="" /></span></button>
					</li>
				</ul>
			</div>

			<!-- Check Point 3 -->
			<div class="checkpoint3">
				<form name="frmcomm" action="" onsubmit="return false;" method="post" style="margin:0px;">
				<input type="hidden" name="mode">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
				<input type="hidden" name="book">
				<input type="hidden" name="bookcount">
					<fieldset>
					<legend>나의 독서 계획 작성하기</legend>
						<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/tit_check_point_03.png" alt="Check Point 3" /></h2>
						<div class="itext">
							<input type="text" title="독서 계획 작성하기" name="txtcomm" id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <% IF NOT(IsUserLoginOK) THEN %>readonly<% END IF %> value="<% IF NOT IsUserLoginOK THEN %>로그인 후 글을 남길 수 있습니다.<% else %>잠을 줄여서라도(10자 이하로 써주세요)<% END IF %>" />
						</div>
						<input type="image" onclick="jsSubmitComment(frmcomm); return false;" src="http://webimage.10x10.co.kr/eventIMG/2015/62550/btn_submit.png" alt="나의 독서계획 등록하기" />
					</fieldset>
				</form>
			</div>
		</div>

		<div class="noti">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/62550/tit_noti.png" alt="이벤트 유의사항" /></h2>
			<ul>
				<li>본 이벤트는 로그인 후 참여 가능합니다.</li>
				<li>본 이벤트는 텐바이텐 PC WEB에서만 참여 가능합니다.</li>
				<li>본 이벤트는 ID당 한 번씩 응모가 가능합니다.</li>
				<li>당첨자 발표는 6월 1일 텐바이텐 공지사항으로 확인 가능합니다.</li>
				<li>당첨 후, 상품을 받기 위해선 &apos;마이페이지&apos;에서 주소 입력을 하셔야 합니다.</li>
				<li>상품으로 발송되는 도서들은 랜덤 발송 됩니다.</li>
			</ul>
		</div>

		<!-- comment list -->
		<% IF ccomment.ftotalcount>0 THEN %>
		<div class="take2">
			<div class="commentlist">
				<!-- for dev msg : <div class="desc">...</div> 한묶음입니다. 한 페이지당 8개씩 보여주세요! Check Point 2 선택에 따라 배경 클래스명 넣어주세요 desc1~desc3 -->
				<% for i = 0 to ccomment.fresultcount - 1 %>
					<div class="desc desc<%= ccomment.FItemList(i).fsub_opt2 %>">
						<strong class="id"><%= printUserId(ccomment.FItemList(i).fuserid,2,"*") %>님</strong>
						<p><%= ReplaceBracket(ccomment.FItemList(i).fsub_opt3) %></p>
					</div>
				<% next %>
			</div>

			<!-- paging -->
			<%= fnDisplayPaging_New(ccomment.FCurrpage, ccomment.ftotalcount, ccomment.FPageSize, ccomment.FScrollCount,"jsGoComPage") %>
		</div>
		<% end if %>
	</div>
	<!-- //iframe -->
<script type="text/javascript">
$(function(){
	/* tab */
	$(".checkpoint1 ul li:first-child a").addClass("on");
	$(".tabcont").find("div").hide();
	$(".tabcont").find("div:first").show();
	
	$(".checkpoint1 ul li a").click(function(){
		$(".checkpoint1 ul li a").removeClass("on");
		$(this).addClass("on");
		var thisCont = $(this).attr("href");
		$(".tabcont").find("div").hide();
		$(".tabcont").find(thisCont).show();
		return false;
	});

	$(".checkpoint2 ul li:first-child button").addClass("on");
	$(".checkpoint2 ul li button").click(function(){
		$(".checkpoint2 ul li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});

	animation();
	$(".topic span").css({"opacity":"0"});
	$(".topic .letter4, .topic .letter5, .topic .letter6").css({"margin-top":"10px"});
	function animation () {
		$(".topic .letter1").delay(100).animate({"opacity":"1"},300);
		$(".topic .letter2").delay(400).animate({"opacity":"1"},300);
		$(".topic .letter3").delay(800).animate({"opacity":"1"},300);
		$(".topic .letter4").delay(1200).animate({"opacity":"1", "margin-top":"0"},500);
		$(".topic .letter5").delay(1600).animate({"opacity":"1", "margin-top":"0"},500);
		$(".topic .letter6").delay(2000).animate({"opacity":"1", "margin-top":"0"},500);
		$(".topic .letter7").delay(2500).animate({"opacity":"1"},500);
	}

	<% if Request("iCC")<>"" then %>
		window.parent.$('html,body').animate({scrollTop:$('.take2').offset().top+300}, 300);
	<% end if %>
});
</script>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width="0" height="0"></iframe>
</body>
</html>
<% set ccomment=nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->