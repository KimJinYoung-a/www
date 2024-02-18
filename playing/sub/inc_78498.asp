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
' Description : Playing Thing Vol.17 운세자판기
' History : 2017-06-15 원승현 생성
'####################################################
Dim eCode , userid, vDIdx, myresultcnt, totalcnt, commentcount, jnum, pagereload, sqlStr, chkResultVal
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66343
Else
	eCode   =  78498
End If

vDIdx = request("didx")
totalcnt = 0
myresultcnt = 0
userid	= getencLoginUserid()
totalcnt = getevent_subscripttotalcount(eCode,"","","")

chkResultVal = ""

if userid <> "" then 
	myresultcnt = getevent_subscriptexistscount(eCode,userid,"","","")
end If

If userid <> "" then
	commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")
Else
	commentcount = 0
End If 

vDIdx = request("didx")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 8		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 6		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 6		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	
	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1


sqlstr = "SELECT sub_opt3 FROM [db_event].[dbo].[tbl_event_subscript] WHERE  evt_code = '"& eCode &"' and userid= '"&userid&"' And convert(varchar(10), regdate, 120) = '"&Left(Now(), 10)&"'"
rsget.Open sqlstr, dbget, 1
	If Not(rsget.bof Or rsget.eof) Then
		chkResultVal = rsget("sub_opt3")
	Else
		chkResultVal = ""
	End If
rsget.close

%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.thingVol017 {text-align:center;}
button {background:none;}
.luckHead {height:812px; padding-top:150px; background:#9eefe5 url(http://webimage.10x10.co.kr/playing/thing/vol017/bg_tit.png) no-repeat 50% 0;}
.luckHead h2 {position:relative; width:287px; height:315px; margin:0 auto;}
.luckHead h2 span {position:absolute; top:0; left:0;display:inline-block; width:287px; height:50px; background:url(http://webimage.10x10.co.kr/playing/thing/vol017/tit_luck.png)no-repeat 0 0; text-indent:-999em;}
.luckHead h2 span.t2 {top:100px; height:215px; background-position:100% 100%;  animation:flip 1s;}
.luckHead p {padding:205px 0 45px;}
.luckHead button {animation:bounce1 .8s 30;}

/* pick / pickResult */
.pick {position:relative; height:1168px; background:#fdf5de url(http://webimage.10x10.co.kr/playing/thing/vol017/bg_pick.png) no-repeat 50% 100%;}
.pick h3 {padding-top:140px;}
.pick ul {overflow:hidden; width:1010px; height:577px; margin:0 auto; padding:38px 0 23px;}
.pick ul li {float:left;}
.pick ul li.shake {animation:shake 1s 10 forwards ease-in-out; transform-origin:50% 100%;}
.pick ul li:first-child {margin:29px 0 0 62px; }
.pick ul li:first-child + li {margin:0 35px 0 48px; animation-delay:.3s;}
.pick ul li:first-child + li + li{margin-top:32px;}
.pick ul li:first-child + li + li + li {clear:left; margin:-20px 0 0 175px; animation-delay:.3s;}
.pick ul li:first-child + li + li + li + li {margin:8px 48px 0 45px; animation-delay:.3s;}
.pick ul li:first-child + li + li + li + li + li{margin-top:-15px;}
.pick ul li button {position:relative; background:none;}
.pick ul li button span {display:none; position:absolute; top:0; left:0;}
.pick ul li button {display:inline-block; appearance:none;}
.pick ul li button:hover span {display:block;}
.pick ul li button.on span {display:block;}
.pick .btnPick {overflow:hidden; width:334px; height:91px;}
.pick .btnPick:hover img{margin-top:-91px;}
.pick .loading {position:absolute; top:0; left:0; width:100%; height:1168px; background:url(http://webimage.10x10.co.kr/playing/thing/vol017/bg_black.png) repeat 0 0;}
.pick .loading p{position:relative; padding-top:560px;}
.pick .loading p:after {content:''; display:inline-block; position:absolute; left:50%; top:590px; width:50px; height:55px; margin-left:-25px; background:url(http://webimage.10x10.co.kr/playing/thing/vol017/img_ball.png) 0 0 no-repeat; background-size:100% auto; animation:spin 1.5s 3;}
.pickResult {position:relative; height:786px; background:#f6eccd url(http://webimage.10x10.co.kr/playing/thing/vol017/bg_book.png) no-repeat 50% 190px;}
.pickResult .resultTit {height:63px; padding-top:74px;}
.pickResult .resultTit span {display:inline-block; position:absolute; top:75px; left:50%; margin-left:-68px;}
.pickResult span.userId {overflow:hidden; top:91px; width:300px; height:53px; margin-left:-378px; font-size:35px; text-align:right; color:#6f614d;}
.pickResult div{display:none; position:absolute; top:280px; left:50%; margin-left:-424px;}
.pickResult .pickResultTxt2 {margin-left:-438px;}
.pickResult div.on {display:inline-block;}

/* howTo */
.howTo {position:relative; height:325px;background:#6eddf5 url(http://webimage.10x10.co.kr/playing/thing/vol017/bg_blue.png) no-repeat 50% 0;}
.howTo p,
.howTo .btnHowto {position:absolute; top:107px; left:50%; margin-left:-356px;}
.howTo .btnHowto {overflow:hidden; width:341px; height:82px; top:136px; margin-left:116px;}
.howTo .btnHowto:hover img {margin-top:-82px;}
.howTo .howToTxt {position:absolute; top:-260px; width:100%; height:1143px; background:url(http://webimage.10x10.co.kr/playing/thing/vol017/bg_black.png) repeat 0 0;}
.howTo .howToTxt .rolling{position:relative; height:977px;}
.howTo .howToTxt .rolling .slidewrap {position:absolute; left:50%; top:260px; width:853px; height:607px; margin-left:-427px;}
.howTo .howToTxt .rolling .slidewrap .slidesjs-container,
.howTo .howToTxt .rolling .slidewrap .slidesjs-control,
.howTo .howToTxt .rolling .slidewrap .slidesjs-slide{width:100% !important; height:100% !important;}
.howTo .howToTxt .rolling .slidewrap .slide {position:relative; overflow:visible !important; width:100%; height:100%; }
.howTo .howToTxt .rolling .slidewrap .slide .slidesjs-navigation {display:none;}
.howTo .howToTxt .rolling .slidesjs-pagination {overflow:hidden; position:absolute; bottom:-40px; left:50%; z-index:50; width:70px; margin-left:-35px; text-align:center;}
.howTo .howToTxt .rolling .slidesjs-pagination li {display:inline-block; padding:0 10px;}
.howTo .howToTxt .rolling .slidesjs-pagination li a {display:inline-block; width:15px; height:15px; background:url(http://webimage.10x10.co.kr/playing/thing/vol017/btn_pagination_white.png) no-repeat 100% 0; text-indent:-999em;}
.howTo .howToTxt .rolling .slidesjs-pagination li .active {background-position:0 0;}
.howTo .howToTxt .btnClose {display:inline-block; position:absolute; top:305px; left:50%; margin-left:353px; width:40px; height:40px; z-index:20; text-indent:-999em;}
.howTo .howToTxt .rolling .next {position:absolute; bottom:50px; left:50%; width:303px; height:55px; margin-left:-158px; text-indent:-999em;}

/* event1 */
.event1 {height:798px; padding-top:110px; background-color:#40d6db;}
.event1 p {padding-bottom:75px;}

/* comment */
.comment {padding:115px 0 120px; background-color:#30cbd1;}
.comment .form .field {position:relative; width:1062px; height:583px; margin:50px auto 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol017/img_select.png) no-repeat 50% 0;}
.comment .form .field ul {overflow:hidden; float:left; width:500px; height:435px; padding:74px 80px;}
.comment .form .field ul li {float:left; width:133px; height:193px; margin-bottom:44px; text-align:center;}
.comment .form .field ul li.genre02,
.comment .form .field ul li.genre05{margin:0 52px 0 47px; }
.comment .form .field ul li.genre04 {clear:left;}
.comment .form .field ul li label {display:block; height:191px; margin-bottom:6px; cursor:pointer; }
.comment .form .field ul li label span{text-indent:-999em; margin-top:172px;}
.comment .form .field ul li input {vertical-align:top; border:solid 1px red;}
.comment .form .field ul li input[type='radio'] {display:none}
.comment .form .field ul li input[type='radio'] + label span {display:inline-block; width:20px; height:19px; background:url(http://webimage.10x10.co.kr/playing/thing/vol017/blt_radio.png) 0 0 no-repeat;)}
.comment .form .field ul li input[type='radio']:checked + label span {background-position:100% 100%;)
}
.comment .form .textarea {float:left; width:282px; margin:150px 0 0 20px;}
.comment .form .btnSubmit{position:absolute; right:118px; bottom:99px;}
.comment .textarea textarea {overflow:hidden; width:256px; height:230px; padding:0 13px; border:0; background-color:transparent; color:#000; font-size:15px; line-height:49px; text-align:left;}
.comment .textarea textarea::-input-placeholder {font-size:13px; color:#919191;}
.comment .textarea textarea::-webkit-input-placeholder {font-size:13px; color:#919191;}
.comment .textarea textarea::-moz-placeholder {font-size:13px; color:#919191;} /* firefox 19+ */
.comment .textarea textarea:-ms-input-placeholder {font-size:13px; color:#919191;} /* ie */
.comment .textarea .btnSubmit {position:absolute; top:82px; right:0px;}
.comment .deco {position:absolute; top:-32px; right:17px;}
.comment .deco.movePen {animation:movePen 3.5s 1;}
.commentList {margin-top:71px;}
.commentList ul {overflow:hidden; width:1347px; margin:0 auto;}
.commentList ul li {float:left; position:relative; width:410px; height:225px; margin:16px 16px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol017/bg_comment_list.png) no-repeat 0 0; font-size:12px; text-align:left;}
.commentList ul li.bg01 {background-position:0 0;}
.commentList ul li.bg02 {background-position:-438px 0;}
.commentList ul li.bg03 {background-position:100% 0;}
.commentList ul li.bg04 {background-position:0 100%;}
.commentList ul li.bg05 {background-position:-438px 100%;}
.commentList ul li.bg06 {background-position:100% 100%;}
.commentList ul li .writer {position:relative; margin:0 100px 0 80px;}
.commentList ul li .writer .id {color:#183651;}
.commentList ul li .writer .id span {font-weight:bold;}
.commentList ul li .writer .no {position:absolute; top:0; right:0; color:#72abad;}
.commentList ul li .btndel {position:absolute; top:-5px; right:35px;}
.commentList ul li .btndel img {transition:transform .7s ease;}
.commentList ul li .btndel:hover img {transform:rotate(-180deg);}
.commentList ul li  p {overflow:hidden; height:100px; margin:60px 91px 5px 80px; color:#6f6d6d; font-size:12px; line-height:20px;}
.pageWrapV15 {margin-top:60px;}
.pageWrapV15 .pageMove {display:none;}
.paging a {width:44px; height:34px; margin:0; border:0;}
.paging a span {height:34px; padding:0; color:#fff; font-family:Dotum, '돋움', Verdana; font-size:14px; line-height:34px;}
.paging a.current span {background:url(http://webimage.10x10.co.kr/playing/thing/vol017/btn_pagination.png) 50% 0 no-repeat;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging .first, .paging .end {display:none;}
.paging a.arrow span {background:none;}
.paging a.current span {color:#ffeedb; font-weight:normal;}
.paging .prev, 
.paging .next {background:url(http://webimage.10x10.co.kr/playing/thing/vol017/btn_pagination.png) 50% -34px no-repeat;}
.paging .next {background-position:50% 100%;}

.volume {width:1140px; margin:80px auto 0; background-color:#b8f0e9;}

@keyframes flip {
	from {transform: perspective(400px) rotate3d(1, 0, 0, 90deg); animation-timing-function: ease-in; opacity: 0;}
	40% {transform: perspective(400px) rotate3d(1, 0, 0, -20deg); opacity: 1;}
	60% {transform: perspective(400px) rotate3d(1, 0, 0, 20deg);}
	80% {transform: perspective(400px) rotate3d(1, 0, 0, -5deg);}
	to {transform: perspective(400px);}
}
@keyframes bounce1 {
	from,to {transform:translateY(0);}
	50% {transform:translateY(-8px);}
}

@keyframes shake {
	0%,100%{transform:rotate(5deg);}
	50% {transform:rotate(0deg);}
}
@keyframes movePen {
	from {top:34px; right: 220px;}
	45% {top:34px; right: 17px;}
	50% {top:77px; right: 220px;}
	95% {top:77px; right: 17px;}
	to {top:-32px; right: 17px;}
}
@keyframes spin {
	from {transform:rotate(0deg);} 
	to { transform:rotate(-360deg);}
}
</style>
<script style="text/javascript">

$(function(){
	/* 아래로 이동 */
	$('.luckHead button').click(function(){
		window.parent.$('html,body').animate({scrollTop:$(".pick").offset().top});
	});

	/* 뽑기 선택 */
	//$(".pick li:first-child button").addClass("on");
	$(".pick li button").click(function(){
		$(".pick li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});

	/* 로딩 */
	$(".pick .loading").hide();
	<% if chkResultVal="" then %>
		$(".pickResult").hide();
	<% end if %>

	/* pickResult */
	$('.pick ul li button').click(function(){
		if ( $(this).parent().hasClass("pick1")) {
			$("#pickSelectVal").val('pickResultTxt1');
		}
		if ( $(this).parent().hasClass("pick2")) {
			$("#pickSelectVal").val('pickResultTxt2');
		}
		if ( $(this).parent().hasClass("pick3")) {
			$("#pickSelectVal").val('pickResultTxt3');
		}
		if ( $(this).parent().hasClass("pick4")) {
			$("#pickSelectVal").val('pickResultTxt4');
		}
		if ( $(this).parent().hasClass("pick5")) {
			$("#pickSelectVal").val('pickResultTxt5');
		}
		if ( $(this).parent().hasClass("pick6")) {
			$("#pickSelectVal").val('pickResultTxt6');
		}
	});

	/* howTo */	
	$('.howToTxt').hide();
	$('.howTo .btnHowto').click(function(){
		setTimeout(function(){
			window.parent.$('html,body').animate({scrollTop:$(".howToTxt").offset().top+100});
		})
		$('.howToTxt').show();
		$("#slide01").slidesjs({
			//start:'1',
			width:"853",
			height:"607",
			pagination:{effect:"fade"},
			navigation:{effect:"fade"},
			play:{interval:5300, effect:"fade", auto:false},
			effect:{fade: {speed:800, crossfade:true}}
		});
		$('.howToTxt .next').click(function(){
			$('.howToTxt .rolling .slidesjs-pagination li:nth-child(2) a').click();
		});
		$('.howToTxt .btnClose').click(function(){
			$(".slidesjs-pagination li:nth-child(1) a").click();
			$('.howToTxt').hide();
			event.preventDefault();
			window.parent.$('html,body').animate({scrollTop:$(".event1").offset().top},500);
		});
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 3900) {
			$(".deco").addClass("movePen");
		}
	});

	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>

	$("#genreSelect li label").on("click", function(e){
		frmcom.spoint.value = $(this).attr("val");
	});

});

function jsplayingthingresult(){
	<% If IsUserLoginOK() Then %>
		$.ajax({
			type: "GET",
			url: "/playing/sub/doEventSubscript78498.asp",
			data: "mode=result&pickVal="+$("#pickSelectVal").val(),
			cache: false,
			success: function(str) {
				var str = str.replace("undefined","");
				var res = str.split("|");
				if (res[0]=="OK") {
					$(".pickResult div").removeClass("on");
					$(".pickResult").delay(1800).fadeIn();
					setTimeout(function(){
						window.parent.$('html,body').animate({scrollTop:$(".pickResult").offset().top},500);
					},1800)
					$(".pickResult ."+res[2]).addClass("on");
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
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
			return;
		}
		return false;
	<% end if %>
}

function thingSelectRound()
{
	<% if trim(chkResultVal)="" then %>
		<% If IsUserLoginOK() Then %>
			$.ajax({
				type: "GET",
				url: "/playing/sub/doEventSubscript78498.asp",
				data: "mode=evtchk",
				cache: false,
				success: function(str) {
					var str = str.replace("undefined","");
					var res = str.split("|");
					if (res[0]=="OK") {
						if (res[1]=="0")
						{
							setTimeout(function(){
								window.parent.$('html,body').animate({scrollTop:$(".pick .loading").offset().top+100},300);
							})
							$(".pick ul li").addClass("shake");
							$(".pick .loading").show();
							$(".pick .loading").delay(2000).fadeOut(100);
							setTimeout("jsplayingthingresult()", 400);
						}
						else
						{
							alert("하루에 하나만 볼 수 있습니다.\n내일 또 뽑아주세요!");
							return false;
						}

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
		<% else %>
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
				return;
			}
			return false;
		<% end if %>
	<% else %>
		alert("하루에 하나만 볼 수 있습니다.\n내일 또 뽑아주세요!");
		return false;
	<% end if %>
}


function pagedown(){
	window.$('html,body').animate({scrollTop:$(".commentList").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() >="2017-06-15" and date() < "2017-07-04" then %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (!frm.spoint.value){
					alert('원하는 장르를 선택해 주세요.');
					return false;
				}
			
				if(!frm.txtcomm.value){
					alert("기대평을 남겨주세요!");
					document.frmcom.txtcomm.value="";
					frm.txtcomm.focus();
					return false;
				}

				if (GetByteLength(frm.txtcomm.value) > 160){
					alert("제한길이를 초과하였습니다. 80자 까지 작성 가능합니다.");
					frm.txtcomm.focus();
					return false;
				}

				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
			return;
		}
		return false;
	<% End IF %>
}

function jsDelComment(cidx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.Cidx.value = cidx;
   		document.frmdelcom.submit();
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
			return;
		}
		return false;
	}
}

</script>
<div class="thingVol017 luckMachine">
	<div class="luckHead">
		<h2>
			<span class="t1">이번달 나의 행운은?</span>
			<span class="t2">운세자판기</span>
		</h2>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_intro.png" alt="어서오세요. PLAYing 운세 자판기에 오신걸 환영합니다. 원하는 단어를 선택하고 뽑으면 여러분의 행운의 메세지를 만날 수 있어요. 오늘의 운세를 책잇아웃~!" /></p>
		<button><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_below.png" alt="아래로" /></button>
	</div>
	<%' 운세 뽑기 %>
	<form name="SelectRound" id="SelectRound" method="get">
		<input type="hidden" name="pickSelectVal" id="pickSelectVal" value="pickResultTxt1">
	</form>
	<div class="pick">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_today_luck.png" alt="오늘의 운세 자판기 나의 마음을 머릿속에 떠올리세요. 그리고 지금, 현재 가장 끌리는 단어를 선택해 뽑아주세요! " /></h3>
		<ul>
			<li class="pick1">
				<button <% If Trim(chkResultVal)="pickResultTxt1" Or Trim(chkResultVal)="" Then %>class="on"<% End If %> onfocus="this.blur();">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_1.png" alt="감성" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_1_on.png" alt="감성선택" /></span>
				</button>
			</li>
			<li class="pick2">
				<button <% If Trim(chkResultVal)="pickResultTxt2" Then %>class="on"<% End If %> onfocus="this.blur();">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_2.png" alt="위로" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_2_on.png" alt="위로선택" /></span>
				</button>
			</li>
			<li class="pick3">
				<button <% If Trim(chkResultVal)="pickResultTxt3" Then %>class="on"<% End If %> onfocus="this.blur();">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_3.png" alt="열정" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_3_on.png" alt="열정" /></span>
				</button>
			</li>
			<li class="pick4">
				<button <% If Trim(chkResultVal)="pickResultTxt4" Then %>class="on"<% End If %> onfocus="this.blur();">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_4.png" alt="생각" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_4_on.png" alt="생각선택" /></span>
				</button>
			</li>
			<li class="pick5">
				<button <% If Trim(chkResultVal)="pickResultTxt5" Then %>class="on"<% End If %> onfocus="this.blur();">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_5.png" alt="목표" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_5_on.png" alt="목표" /></span>
				</button>
			</li>
			<li class="pick6">
				<button <% If Trim(chkResultVal)="pickResultTxt6" Then %>class="on"<% End If %> onfocus="this.blur();">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_6.png" alt="기회" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_pick_6_on.png" alt="기회선택" /></span>
				</button>
			</li>
		</ul>
		<button class="btnPick" onclick="thingSelectRound();return false;" onfocus="this.blur();"><img src="http://webimage.10x10.co.kr/playing/thing/vol017/btn_pick_v2.png" alt="뽑기 돌리기"/></button>
		<div class="loading" id="thinglyloding"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_loading_v2.png" alt="뽑는중" /></p></div>
	</div>
	<%' 운세 결과 %>

	<div class="pickResult">
		<p class="resultTit"><span class="userId"><%=printUserId(userid,2,"*")%></span><span><img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_result_v3.png" alt="운세 결과" /></span></p>
		<div class="pickResultTxt1 <% If Trim(chkResultVal)="pickResultTxt1" Then %>on<% End If %>">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_pick_result_1.png" alt="감성결과" />
		</div>

		<div class="pickResultTxt2 <% If Trim(chkResultVal)="pickResultTxt2" Then %>on<% End If %>">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_pick_result_2.png" alt="위로결과" />
		</div>

		<div class="pickResultTxt3 <% If Trim(chkResultVal)="pickResultTxt3" Then %>on<% End If %>">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_pick_result_3.png" alt="열정결과" />
		</div>

		<div class="pickResultTxt4 <% If Trim(chkResultVal)="pickResultTxt4" Then %>on<% End If %>">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_pick_result_4.png" alt="생각결과" />
		</div>

		<div class="pickResultTxt5 <% If Trim(chkResultVal)="pickResultTxt5" Then %>on<% End If %>">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_pick_result_5.png" alt="목표결과" />
		</div>

		<div class="pickResultTxt6 <% If Trim(chkResultVal)="pickResultTxt6" Then %>on<% End If %>">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_pick_result_6.png" alt="기회결과" />
		</div>
	</div>

	<%' 설렘 자판기 사용법 %>
	<div class="howTo">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol017/tit_luck_machine.png" alt="설렘 자판기를 아시나요?" /></p>
		<button class="btnHowto" onfocus="this.blur();"><img src="http://webimage.10x10.co.kr/playing/thing/vol017/btn_how_to_v3.png" alt="설렘 자판기 사용법" /></button>
		<div class="howToTxt">
			<div class="rolling">
				<div class="slidewrap">
					<div id="slide01" class="slide">
						<div><img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_how_to_1_v2.png" alt="" /><button class="next" onfocus="this.blur();">설렘자판기 이용방법 보기</button></div>
						<div><img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_how_to_2_v2.png" alt="텐바이텐 대학로 매장에 방문해주세요. (설렘 자판기가 있어요) 설렘 자판기에 금액을 지불하고 원하는 장르를 선택해주세요.선택한 장르의 책을 랜덤으로 받아요." /></div>
					</div>
				</div>
			</div>
			<a href="#" class="btnClose">닫기</a>
		</div>
	</div>
	<%' 이벤트1 %>
	<div class="event1">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol017/tit_event_1.png" alt="event1 대학로 매장에서 설렘 자판기를 이용해보세요! 대학로 매장에서 설렘 자판기를 이용 후 매장 카운터로 방문하면 책을 담을 수 있는 PLAYing 한정 책가방(에코백)을 드리고 있어요! 이벤트 응모기간은 2017년 6월 19일 부터 재고소진시 까지 진행됩니다." /></p>
		<div><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_event_gift.jpg" alt="" /></div>
	</div>
	<%' 이벤트2 (코멘트) %>
	<div class="event2 comment">
		<div class="form">
			<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="com_egC" value="<%=com_egCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
			<input type="hidden" name="iCTot" value="">
			<input type="hidden" name="mode" value="add">
			<input type="hidden" name="spoint">
			<input type="hidden" name="isMC" value="<%=isMyComm%>">
			<input type="hidden" name="pagereload" value="ON">
			<input type="hidden" name="gubunval">
				<fieldset>
				<legend>내가 원하는 장르를 선택하고 설렘 자판기에 대한 간단한 기대평 작성하기</legend>
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol017/tit_comment_v2.png" alt="내가 원하는 장르를 선택하고 설렘 자판기에 대한 간단한 기대평을 남겨주세요! 응모기간은 2017년 6월 19일 부터 7월 19일까지 진행됩니다. 당첨자 발표일은 2017년 7월 3일입니다." /></p>
					<div class="field">
						<ul id="genreSelect" class="genreSelect">
							<li class="genre01">
								<input type="radio" id="genre01" name="genre" checked/>
								<label for="genre01" val="1"><span>에세이</span></label>
							</li>
							<li class="genre02">
								<input type="radio" id="genre02" name="genre" />
								<label for="genre02" val="2"><span>시집</span></label>
							</li>
							<li class="genre03">
								<input type="radio" id="genre03" name="genre" />
								<label for="genre03" val="3"><span>지시교양</span></label>
							</li>
							<li class="genre04">
								<input type="radio" id="genre04" name="genre" />
								<label for="genre04" val="4"><span>로맨스 소설</span></label>
							</li>
							<li class="genre05">
								<input type="radio" id="genre05" name="genre" />
								<label for="genre05" val="5"><span>자기개발서</span></label>
							</li>
							<li class="genre06">
								<input type="radio" id="genre06" name="genre" />
								<label for="genre06" val="6"><span>랜덤</span></label>
							</li>
						</ul>

						<div class="textarea">
							<textarea cols="50" rows="6" title="설렘자판기에 대한 간단한 기대평 작성" placeholder="80자 이내로 입력해주세요!" id="txtcomm" name="txtcomm" onClick="jsCheckLimit();"></textarea>
						</div>
						<div class="btnSubmit"><input type="image" src="http://webimage.10x10.co.kr/playing/thing/vol017/btn_comment_v2.png" alt="기대평 남기기" onclick="jsSubmitComment(document.frmcom);return false;"/></div>
						<div class="deco"><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_deco_pencil.png" alt="" /></div>
					</div>
				</fieldset>
			</form>
			<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="com_egC" value="<%=com_egCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="Cidx" value="">
				<input type="hidden" name="mode" value="del">
				<input type="hidden" name="pagereload" value="ON">
			</form>
		</div>
		<%' comment list %>
		<% IF isArray(arrCList) THEN %>
		<div class="commentList">
			<ul>
				<%' for dev msg : 한페이지당 6개씩 보여주세요 선택한 카드에 따라 클래스명 bg01 ~ bg6 붙여주세요 %>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<li class="bg<%=chkiif(arrCList(3,intCLoop)<10,"0","")%><%=arrCList(3,intCLoop)%>">
					<p><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
					<div class="writer">
						<span class="id">
							<% If arrCList(8,intCLoop) <> "W" Then %><img src="http://webimage.10x10.co.kr/playing/thing/vol008/m/ico_mobile.png" alt="모바일에서 작성된 글" /><% End If %> <%=printUserId(arrCList(2,intCLoop),4,"*")%>
						</span>
						<span class="no">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
					</div>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<button type="button" class="btndel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" onfocus="this.blur();"><img src="http://webimage.10x10.co.kr/playing/thing/vol017/img_close.png" alt="내 글 삭제하기" /></button>
					<% End If %>
				</li>
				<% Next %>
			</ul>
			
			<%' pagination %>
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
		</div>
		<% End If %>
	</div>
	<%' volume %>
	<div class="seciton volume">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol017/txt_vol_17.png" alt="vol017 THING의 사물에 대한 생각 오늘의 운세를 뽑듯, 책으로 운세를 뽑으세요!" /></p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->