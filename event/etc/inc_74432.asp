<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : [플레이리뉴얼] everyday replaying
' History : 2016-11-18 원승현 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	dim oItem
	dim currenttime
		currenttime =  now()
	'	currenttime = #11/09/2016 09:00:00#

	dim eCode
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66239
	Else
		eCode   =  74432
	End If

	dim userid, commentcount, i
		userid = GetEncLoginUserID()

	commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

	dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
	dim iCTotCnt, arrCList,intCLoop, pagereload
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

	iCPerCnt = 10		'보여지는 페이지 간격
	'한 페이지의 보여지는 열의 수
	if blnFull then
		iCPageSize = 8		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
	else
		iCPageSize = 8		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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

	'// 플레잉 로고 응모여부 확인
	Dim vQuery, UserAppearChk
	vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And userid='"&userid&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		UserAppearChk = rsget(0)
	End IF
	rsget.close


	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
		if Not(Request("mfg")="pc" or session("mfg")="pc") then
			if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
				dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
				Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")	'### 모바일주소
				Response.End
			end if
		end if
	end If
	
	'// Facebook 오픈그래프 메타태그 작성
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 감성을 PLAYing!"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode&""" />" & vbCrLf
	
	strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""http://webimage.10x10.co.kr/eventIMG/2016/74432/m/img_kakao.jpg"" />" & vbCrLf &_
												"<link rel=""image_src"" href=""http://webimage.10x10.co.kr/eventIMG/2016/74432/m/img_kakao.jpg"" />" & vbCrLf

	strPageTitle = "[텐바이텐] 감성을 PLAYing!"
	strPageKeyword = "[텐바이텐] 감성을 PLAYing!"
	strPageDesc = "감성놀이터 PLAY가 감성 진행형 PLAYing[플레잉]으로 다시 태어났습니다!"


	'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
	Dim vTitle, vLink, vPre, vImg
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle	= Server.URLEncode("감성을 PLAYing!")
	snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
	snpPre		= Server.URLEncode("텐바이텐")

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.evt74432 {position:relative;}

.playEvtHead {width:100%; height:706px; background:#ffbe32 url(http://webimage.10x10.co.kr/eventIMG/2016//74432/bg_head.png) no-repeat 50% 0;}
.titWrap {position:relative; width:1140px; height:619px; margin:0 auto; padding-top:87px; background:url(http://webimage.10x10.co.kr/eventIMG/2016//74432/img_screen.png) no-repeat 50% 100%;}
.titWrap span {position:absolute; left:50%; top:156px; margin-left:202px;}
.titWrap p {position:absolute; left:0; top:50px;}
.titWrap .morePlay {position:absolute; left:50%; top:330px; margin-left:260px;}
.twist  {
	animation-name:twist ; animation-duration:1.1s; animation-fill-mode:both; animation-iteration-count:1; animation-delay:0s;
	-webkit-animation-name:twist ; -webkit-animation-duration:1.1s; -webkit-animation-fill-mode:both; -webkit-animation-iteration-count:1; -webkit-animation-delay:0s;
}
@keyframes twist {
	0% {transform:translateX(0%);}
	15% {transform:translateX(-15%);}
	30% {transform:translateX(10%);}
	45% {transform:translateX(-5%);}
	60% {transform:translateX(5%);}
	75% {transform:translateX(-2%);}
	100% {transform:translateX(0%);}
}
@-webkit-keyframes twist {
	0% {-webkit-transform:translateX(0%);}
	15% {-webkit-transform:translateX(-15%);}
	30% {-webkit-transform:translateX(10%);}
	45% {-webkit-transform:translateX(-5%);}
	60% {-webkit-transform:translateX(5%);}
	75% {-webkit-transform:translateX(-2%);}
	100% {-webkit-transform:translateX(0%);}
}

.newPlaying {position:relative; width:100%; height:270px; padding-top:40px; background-color:#ecab1d; text-align:center;}
.newPlaying ul {position:absolute; left:50%; top:97px; margin-left:-582px; overflow:hidden; width:1164px;}
.newPlaying ul li {overflow:hidden; float:left; width:194px; height:166px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016//74432/img_new_playing_off.png); background-repeat:no-repeat; text-indent:-999em; cursor:pointer;}
.newPlaying ul li:hover {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016//74432/img_new_playing_on.png);}
.newPlaying ul li.new01 {background-position:0 0;}
.newPlaying ul li.new02 {background-position:-194px 0;}
.newPlaying ul li.new03 {background-position:-388px 0;}
.newPlaying ul li.new04 {background-position:-582px 0;}
.newPlaying ul li.new05 {background-position:-776px 0;}
.newPlaying ul li.new06 {background-position:-970px 0;}

.playEvt1 {width:100%; height:579px; background:#f6f5ef url(http://webimage.10x10.co.kr/eventIMG/2016//74432/bg_evt1.png) repeat-x 50% 0;}
.logoSlt {overflow:hidden; text-align:center; padding:40px 0 60px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2016//74432/img_logo_box.png) no-repeat 50% 5px;}
.logoSlt li {display:inline-block; padding:0 20px; vertical-align:top;}
.logoSlt li input[type=radio] {margin:9px 10px 0 0;}

.lyrClose {overflow:hidden; position:absolute; z-index:50; width:40px; height:40px; text-indent:-999em; outline:none; background-color:transparent;}
.wrongInfo {display:none; position:fixed; top:50% !important; left:50% !important; width:394px; height:203px; margin:-101px 0 0 -197px;}
.wrongInfo > div {position:relative; width:100%; height:100%;}
.wrongInfo .lyrClose {right:0; top:0;}

/* comment */
.commentevet {width:100%; text-align:center; background-color:#fff;}
.commentevet .commentInput {width:100%; margin:0 auto; padding-bottom:30px; background-color:#fad860;}
.commentevet .form {width:1050px; margin:20px auto;}
.commentevet .form .choice {overflow:hidden; width:900px; margin:0 auto;}
.commentevet .form .choice li {float:left; width:150px; height:150px;}
.commentevet .form .choice li button {display:block; width:100%; height:100%; background-repeat:no-repeat; background-position:0 0; font-size:11px; text-indent:-999em; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016//74432/ico_playing.png); background-color:transparent; outline:none;}
.commentevet .form .choice li button.on {background-position:0 -150px;}
.commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.commentevet .form .choice li.ico2 button {background-position:-150px 0;}
.commentevet .form .choice li.ico2 button.on {background-position:-150px 100%;}
.commentevet .form .choice li.ico3 button {background-position:-300px 0;}
.commentevet .form .choice li.ico3 button.on {background-position:-300px 100%;}
.commentevet .form .choice li.ico4 button {background-position:-450px 0;}
.commentevet .form .choice li.ico4 button.on {background-position:-450px 100%;}
.commentevet .form .choice li.ico5 button {background-position:-600px 0;}
.commentevet .form .choice li.ico5 button.on {background-position:-600px 100%;}
.commentevet .form .choice li.ico6 button {background-position:-750px 0;}
.commentevet .form .choice li.ico6 button.on {background-position:-750px 100%;}

.commentevet textarea {width:1028px; height:78px; margin-top:10px; padding:10px; border:1px solid #ccc; background-color:#f5f5f5;}
.commentevet .note01 {margin-top:6px;}
.commentevet .note01 ul li {color:#888; text-align:left;}

.commentlist {width:1110px; margin:0 auto;}
.commentlist table {margin-top:10px; text-align:center;}
.commentlist table thead {display:none;}
.commentlist table th {display:block; visibility:hidden; width:0; height:0;}
.commentlist table th, .commentlist table td {border-bottom:1px solid #ddd; color:#777; font-size:11px; line-height:1.5em;}
.commentlist table td {padding:30px 0;}
.commentlist table td.lt {padding-right:10px;}
.commentlist table td em {font-weight:bold;}
.commentlist table td strong {display:block; width:150px; height:85px; background-repeat:no-repeat; background-position:0 -30px; text-indent:-999em; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016//74432/ico_playing.png); background-color:transparent; }
.commentlist table td .ico2 {background-position:-150px -30px;}
.commentlist table td .ico3 {background-position:-300px -30px;}
.commentlist table td .ico4 {background-position:-450px -30px;}
.commentlist table td .ico5 {background-position:-600px -30px;}
.commentlist table td .ico6 {background-position:-750px -30px;}
.commentlist table td .btndel {margin-top:3px; background-color:transparent;}

/* paging */
.pageWrapV15 {margin-top:20px;}

.goSns {overflow:hidden; position:absolute; left:50%; top:155px; width:45px; margin-left:527px;}
.goSns a {position:absolute; left:0; overflow:hidden; display:block; width:45px; height:45px; text-indent:-999em; z-index:50;}
.goSns a.fbLink {top:0;}
.goSns a.twLink {bottom:0;}
</style>
<script type="text/javascript">

var q_move ;
var q_top = 155;

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",200);
	<% end if %>

	var contH = $('.evt74432').outerHeight()-$('.commentevet').outerHeight() + 285;
	q_move = $(".goSns");
	$(window).scroll(function(){
		q_move.stop();
		var thisTop = $(document).scrollTop();
		if (thisTop >= 0 && thisTop <= contH) {
			q_move.animate({"top":$(document).scrollTop() + q_top + "px"},400);
		} else {
			q_move.css("top", contH);
		}
	});

	/* comment write ico select */
	$(".form .choice li:first-child button").addClass("on");
	frmcom.gubunval.value = '1';
	$(".form .choice li button").click(function(){
		frmcom.gubunval.value = $(this).val()
		$(".form .choice li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});
});


function goPlayLogSelect()
{
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-11-21" and left(currenttime,10)<"2016-12-05" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if UserAppearChk > 0 then %>
				alert('이미 응모가 완료 되었습니다.');
				return false;
			<% else %>
				if ($(':radio[name="playLg"]:checked').val()=="3")
				{
					$.ajax({
						type:"GET",
						url:"/event/etc/doEventSubscript74432.asp?mode=ins",
						dataType: "text",
						async:false,
						cache:true,
						success : function(Data, textStatus, jqXHR){
							if (jqXHR.readyState == 4) {
								if (jqXHR.status == 200) {
									if(Data!="") {
										res = Data.split("|");
										if (res[0]=="OK")
										{
											alert("응모가 완료되었습니다.");
											parent.location.reload();
											return false;
										}
										else
										{
											errorMsg = res[1].replace(">?n", "\n");
											alert(errorMsg);
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
				else if ($(':radio[name="playLg"]:checked').val()==undefined)
				{
					alert("플레잉의 새로운 로고를 선택해주세요.");
					return false;
				}
				else
				{
					viewPoupLayer('modal',$('#wrongInfo').html());return false;
				}
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
		}
		return false;
	<% End IF %>

}

function snschk(snsnum) {

	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=strPageTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="ka"){
		alert('잘못된 접속 입니다.');
		return false;
	}
}

function pagedown(){
	//document.getElementById('commentlist').scrollIntoView();
	window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-11-21" and left(currenttime,10)<"2016-12-05" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('가장 마음에 드는 코너를 선택해주세요.');
					return false;
				}
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 800){
					alert("코맨트를 남겨주세요.\n한글 400자 까지 작성 가능합니다.");
					frm.txtcomm1.focus();
					return false;
				}
				frm.txtcomm.value = frm.gubunval.value + '!@#' + frm.txtcomm1.value
				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
		}
		return false;
	}

	//if (frmcom.txtcomm.value == ''){
	//	frmcom.txtcomm.value = '';
	//}	
}

//내코멘트 보기
function fnMyComment() {
	document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.frmcom.iCC.value=1;
	document.frmcom.submit();
}
</script>

<%' 74432 everyday rePLAYing %>
<div class="evt74432">
	<div class="playEvtHead">
		<div class="titWrap">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/tit_playing.png" alt="리뉴얼 오픈 - EVERYDAY RePLAYing" /></h2>
			<span class="twist"><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/tit_ing.png" alt="ing" /></span>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/txt_date.png" alt="이벤트기간 : 2016.11.21 ~ 12.04" /></p>
			<a href="/playing/" class="morePlay"><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/btn_go_playing.png" alt="PLAYing 더보러가기" /></a>
		</div>
	</div>
	<div class="newPlaying">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/74432/txt_new_playing.png" alt="PLAYing 새 코너 알아보기" /></h3>
		<ul>
			<li class="new01">#THING.</li>
			<li class="new02">#!NSPIRATION</li>
			<li class="new03">#PLAYLIST</li>
			<li class="new04">#AZIT&</li>
			<li class="new05">#HOWHOW</li>
			<li class="new06">#COMMA,</li>
		</ul>
	</div>
	<div class="playEvt1">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/txt_evt1.png" alt="플레잉의 새로운 로고를 맞춰주세요!" usemap="#logoGiftMap" /></h3>
		<map name="logoGiftMap">
			<area shape="rect" coords="857,96,1097,257" href="/shopping/category_prd.asp?itemid=1164622" alt="리플렉트 에코 히터" />
		</map>
		<ul class="logoSlt">
			<li><label><input type="radio" id="playLg1" name="playLg" value="1"/><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/img_logo1.png" alt="PLAYing1" /></label></li>
			<li><label><input type="radio" id="playLg2" name="playLg" value="2"/><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/img_logo2.png" alt="PLAYing2" /></label></li>
			<li><label><input type="radio" id="playLg3" name="playLg" value="3"/><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/img_logo3.png" alt="PLAYing3" /></label></li>
			<li><label><input type="radio" id="playLg4" name="playLg" value="4"/><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/img_logo4.png" alt="PLAYing4" /></label></li>
		</ul>
		<% if UserAppearChk > 0 then %>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/btn_evt1_action_end.png" alt="응모완료" />
		<% Else %>
			<button type="button" onclick="goPlayLogSelect();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/btn_evt1_action.png" alt="응모하기" /></button>
		<% End If %>
		<p class="tMar20"><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/txt_evt1_hint.png" alt="힌트 : 즐거운 감성이 계속 순환된다는 의미. 감성진행형 PLAYing!" /></p>
	</div>
	<div id="wrongInfo">
		<div class="wrongInfo window">
			<div>
				<img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/lyr_wrong.png" alt="오답입니다 ㅠㅠ 좀더 둥글둥글한 플레잉 로고를 찾아주세요 :)" />
				<button type="button" onclick="ClosePopLayer()" class="lyrClose">닫기</button>
			</div>
		</div>
	</div>

	<%' sns share %>
	<div class="goSns">
		<a href="" onclick="snschk('fb');return false;" class="fbLink">Facebook</a>
		<a href="" onclick="snschk('tw');return false;" class="twLink">Twitter</a>
		<img src="http://webimage.10x10.co.kr/eventIMG/2016/74432/btn_sns.png" alt="" />
	</div>

	<%' comment %>
	<div class="commentevet">
		<div class="commentInput">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016//74432/txt_evt2.png" alt="새로워진 PLAYing을 축하해주세요" /></h3>
			<div class="form">
				<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="com_egC" value="<%=com_egCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
				<input type="hidden" name="iCTot" value="">
				<input type="hidden" name="mode" value="add">
				<input type="hidden" name="spoint" value="0">
				<input type="hidden" name="isMC" value="<%=isMyComm%>">
				<input type="hidden" name="pagereload" value="ON">
				<input type="hidden" name="txtcomm">
				<input type="hidden" name="gubunval">
					<fieldset>
					<legend>가장 마음에 드는 코너 선택하고 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">#THING.</button></li>
							<li class="ico2"><button type="button" value="2">#!NSPIRATION</button></li>
							<li class="ico3"><button type="button" value="3">#PLAYLIST</button></li>
							<li class="ico4"><button type="button" value="4">#AZIT&</button></li>
							<li class="ico5"><button type="button" value="5">#HOWHOW</button></li>
							<li class="ico6"><button type="button" value="6">#COMMA,</button></li>
						</ul>
						<textarea title="코멘트 작성" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
						<div class="note01 overHidden">
							<ul class="list01 ftLt">
								<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
								<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br>이벤트 참여에 제한을 받을 수 있습니다.</li>
							</ul>
							<input type="submit" class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기" onclick="jsSubmitComment(document.frmcom);return false;">
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
		</div>

		<%' commentlist %>
		<div class="commentlist" id="commentlist">
			<% IF isArray(arrCList) THEN %>
			<table>
				<caption>새로워진 PLAYing을 축하하는 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
				<colgroup>
					<col style="width:60px;" />
					<col style="width:150px;" />
					<col style="width:*;" />
					<col style="width:110px;" />
					<col style="width:120px;" />
				</colgroup>
				<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col"></th>
					<th scope="col">내용</th>
					<th scope="col">작성일자</th>
					<th scope="col">아이디</th>
				</tr>
				</thead>
				<tbody>
					<% For intCLoop = 0 To UBound(arrCList,2) %>
						<tr>
							<td>
								<em>
								<%
									If Len(iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)))=1 Then
										response.write "00"&iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))
									ElseIf Len(iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)))=2 Then
										response.write "0"&iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))
									Else
										response.write iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))
									End If
								%>
								</em>
							</td>
							<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
								<td>
									<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
										<% If split(arrCList(1,intCLoop),"!@#")(0)="1" Then %>
											#THING.
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
											#!NSPIRATION
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
											#PLAYLIST
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
											#AZIT&
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="5" Then %>
											#HOWHOW
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="6" Then %>
											#COMMA,
										<% End If %>
									</strong>
								</td>
							<% End If %>
							<td class="lt">
								<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
									<% if ubound(split(arrCList(1,intCLoop),"!@#")) > 0 then %>
										<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"!@#")(1) ))%>
									<% end if %>
								<% end if %>
							</td>
							<td><%= FormatDate(arrCList(4,intCLoop),"0000.00.00") %></td>
							<td>
								<em><%=printUserId(arrCList(2,intCLoop),2,"*")%></em>
								<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
									<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btndel"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제"></button>
								<% End If %>
								<% If arrCList(8,intCLoop) <> "W" Then %>
									<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
								<% End If %>
							</td>
						</tr>
					<% Next %>
				</tbody>
			</table>

			<%' paging %>
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>

			<% End If %>
		</div>
	</div>
</div>
<%'// 74432 everyday rePLAYing %>

<!-- #include virtual="/lib/db/dbclose.asp" -->