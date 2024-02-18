<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' PLAY #14 Audio_이 순간, 당신은 어떤 노래를 듣고 있나요. 
' 2014-11-07 이종화 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21356
Else
	eCode   =  56366
End If

dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 15		'한 페이지의 보여지는 열의 수
	iCPerCnt = 10		'보여지는 페이지 간격

	'선택범위 리플개수 접수
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iSelTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

	Dim rencolor
	 
	randomize

	rencolor=int(Rnd*30)+1

%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
.section {overflow:hidden; min-width:1140px;}
.section .copyright {margin-top:13px; padding-right:20px; color:#888; line-height:1.25em; text-align:right;}
.section .copyright em {border-bottom:1px solid #81b9d5; color:#81b9d5;}

.section1 {position:relative; background-color:#fff;}
.section1 .heading {position:absolute; right:22%; bottom:15%; z-index:10;}
.section1 .heading span {display:block;}
.section1 .heading span:first-child {margin-bottom:50px;}
.section1 .movie {overflow:hidden; position:relative; z-index:5; height:0; padding-bottom:56.25%; background:#000;}
.section1 .movie iframe {position:absolute; top:0; left:0; width:100%; height:100%}
.section1 .copyright a {color:#81b9d5;}
.section2 {padding:193px 0; background-color:#fff; text-align:center;}
.section3 {position:relative; height:946px; background:#62645c url(http://webimage.10x10.co.kr/play/ground/20141110/bg_music.jpg) no-repeat 50% 0; background-size:100% 946px;}
.section3 .now1 {position:absolute; top:10%; left:20%; z-index:10;}
.section3 .now2 {position:absolute; right:15%; bottom:12%; z-index:10;}
.section3 .play {position:absolute; right:15.3%; bottom:28%; z-index:10;}
.section3 .bg {position:absolute; top:0; right:0; z-index:5; width:43%;}
.section4 {padding:420px 0; background-color:#fff; text-align:center;}
.section4 .time {color:#484848; font-family:'Courier New'; font-size:140px; line-height:1.375em; letter-spacing:-20px;}
.section4 .time span img {vertical-align:middle;}
.section5 {padding:206px 0 15px; background:url(http://webimage.10x10.co.kr/play/ground/20141110/bg_line_pattern.gif) repeat 0 0;}
.section5 .copyright {margin-top:175px;}
.comment-evt {width:1140px; margin:0 auto;}
.comment-evt .desc {position:relative;}
.comment-evt .desc h2 {margin-bottom:45px;}
.comment-evt .desc p {margin-top:25px;}
.comment-evt .desc .date {position:absolute; top:63px; right:0;}
.comment-evt .field {margin-top:133px;}
.comment-evt .field .itext {float:left; width:320px;}
.comment-evt .field .itext input {width:220px; height:60px; margin-top:38px; padding:0 20px; background:url(http://webimage.10x10.co.kr/play/ground/20141110/bg_input_text.png) no-repeat 0 0; color:#888; font-size:15px; font-family:'Dotum', 'Verdana'; line-height:60px;}
.comment-evt .btn-submit input {margin-top:145px;}
.section6 {background-color:#fff;}
.comment-list {width:1140px; margin:0 auto; padding:10px 0 70px;}
.comment-list ul {overflow:hidden; width:1200px; margin-right:-30px; margin-left:-30px;}
.comment-list ul li {float:left; position:relative; width:230px; height:200px; margin:60px 5px 0; text-align:center;}
.comment-list ul li span, .comment-list ul li strong, .comment-list ul li em {display:block;}
.comment-list ul li .thumb img {width:130px; height:130px;}
.comment-list ul li .thumb:hover img {transform: scale(0.95);}
.comment-list ul li .now {margin-top:17px; color:#81b9d5; line-height:1.25em;}
.comment-list ul li .song, .comment-list ul li .date {font-size:11px; font-family:'Dotum', 'Verdana'; line-height:1.25em;}
.comment-list ul li .now, .comment-list ul li .song {overflow:hidden; width:230px; text-overflow:ellipsis; white-space:nowrap;}
.comment-list ul li .song {margin-top:2px;color:#333;}
.comment-list ul li .date {margin-top:5px; color:#888;}
.comment-list ul li .date img {margin-right:5px; vertical-align:middle;}
.comment-list ul li .btnDel {position:absolute; right:50px; top:0; width:30px; height:30px; background:url(http://webimage.10x10.co.kr/play/ground/20141110/btn_del.png) no-repeat 0 0; text-indent:-999em;}
.comment-list .paging {margin-top:70px;}
.comment-list .paging a {height:20px; border:0; line-height:20px;}
.comment-list .paging a.current span {color:#81b9d5;}
.comment-list .paging a:hover {background-color:transparent;}
.comment-list .paging a span {height:20px; margin:0 10px; padding:0; color:#333; font-size:15px; font-family:'Verdana', 'Dotum';}
.comment-list .paging a.arrow span {width:20px; background-image:url(http://webimage.10x10.co.kr/play/ground/20141110/btn_paging.gif);}
.comment-list .paging a.first span {background-position:0 0;}
.comment-list .paging a.prev span {background-position:-40px 0;}
.comment-list .paging a.next span {background-position:-70px 0;}
.comment-list .paging a.end span {background-position:-90px 0;}
.animated {-webkit-animation-duration:3s; animation-duration:3s; -webkit-animation-fill-mode:both; animation-fill-mode:both;}
/* FadeIn animation */
@-webkit-keyframes fadeIn {
	0% {opacity:0.5;}
	100% {opacity:1;}
}
@keyframes fadeIn {
	0% {opacity:0.5;}
	100% {opacity:1;}
}
.fadeIn {-webkit-animation-name: fadeIn; animation-name: fadeIn; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
</style>
<script type="text/javascript">
$(function(){
	$(".section1 .heading .show1").css({"opacity":"0"});
	$(".section1 .heading .show2").css({"opacity":"0"});
	$(".section1 .heading .show3").css({"opacity":"0"});
	$(".section1 .heading .show4").css({"opacity":"0"});

	$(".section3 .bg").animate({width:"0"}, 500);

	function showText() {
		$(".section1 .heading .show1").delay(300).animate({"opacity":"1"},500);
		$(".section1 .heading .show2").delay(400).animate({"opacity":"1"},1500);
		$(".section1 .heading .show3").delay(500).animate({"opacity":"1"},2500);
		$(".section1 .heading .show4").delay(600).animate({"opacity":"1"},3500);
	}

	function showBg() {
		$(".section3 .bg").delay(300).animate({width:"43%"}, 1000);
	}

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop < 300){
			showText();
		}
		if (scrollTop > 2000){
			showBg();
		}
	});
});
</script>
<script type="text/javascript">
<!--
 	function jsGoComPage(iP){
		document.frmcom.iCC.value = iP;
		document.frmcom.iCTot.value = "<%=iCTotCnt%>";
		document.frmcom.submit();
	}

function jsSubmitComment(frm){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   if(!frm.qtext1.value){
	    alert("지금 상태를 입력해주세요");
		document.frmcom.qtext1.value="";
	    frm.qtext1.focus();
	    return false;
	   }

	   if(!frm.qtext2.value){
	    alert("가수명을 입력해주세요");
		document.frmcom.qtext2.value="";
	    frm.qtext2.focus();
	    return false;
	   }

	   if(!frm.qtext3.value){
	    alert("노래명을 입력해주세요");
		document.frmcom.qtext3.value="";
	    frm.qtext3.focus();
	    return false;
	   }

	   frm.action = "doEventSubscript56366.asp";
	   return true;
	}

	function jsDelComment(cidx)	{
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
	   		document.frmdelcom.submit();
		}
	}

	function jsChklogin11(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.qtext1.value =="1번째"){
				document.frmcom.qtext1.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChklogin22(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.qtext2.value =="2번째"){
				document.frmcom.qtext2.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChklogin33(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.qtext3.value =="3번째"){
				document.frmcom.qtext3.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsDelComment(cidx)	{
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
	   		document.frmdelcom.submit();
		}
	}

//-->
</script>
<script>
var minus_second = 0;
var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
var today=new Date(<%=Year(now)%>, <%=Month(now)-1%>, <%=Day(now)%>, <%=Hour(now)%>, <%=Minute(now)%>, <%=Second(now)%>);

function countdown(){
	today = new Date(Date.parse(today) + (1000+minus_second));	//서버시간에 1초씩 증가
	var todayy=today.getYear()

	if(todayy < 1000)
		todayy+=1900
		

		var todaym=today.getMonth()
		var todayd=today.getDate()
		var todayh=today.getHours()
		var todaymin=today.getMinutes()
		var todaysec=today.getSeconds()
		var todaystring=montharray[todaym]+" "+todayd+", "+todayy+" "+todayh+":"+todaymin+":"+todaysec
		var apname = "";

		if(todayh < 0)
		{
			$("#lyrCounter").hide();
			return;
		}

		//am pm 설정
		if(todayh > 12 && todayh < 24 ) {
			apname = " pm"
			todayh = todayh - 12;
		}else{
			apname = " am"
		}

		if(todayh < 10) {
			todayh = "0" + todayh;
		}

		if(todaymin < 10) {
			todaymin = "0" + todaymin;
		}
		if(todaysec < 10) {
			todaysec = "0" + todaysec;
		}

		$("#lyrCounter").html(todayh +" <span><img src='http://webimage.10x10.co.kr/play/ground/20141110/ico_colon.gif' alt=':' /></span> "+ todaymin +" <span><img src='http://webimage.10x10.co.kr/play/ground/20141110/ico_colon.gif' alt=':' /></span> "+ todaysec + apname);
	
		minus_second = minus_second + 1;

	setTimeout("countdown()",1000)
}

$(function(){
	countdown();
});

</script>
<div class="playGr20141110">
	<div class="this-moment">
		<div id="section1" class="section section1">
			<h1 class="heading">
				<span class="show1"><img src="http://webimage.10x10.co.kr/play/ground/20141110/tit_this_moment_music_01.png" alt="이 순간," /></span>
				<span class="show2"><img src="http://webimage.10x10.co.kr/play/ground/20141110/tit_this_moment_music_02.png" alt="당신은" /></span>
				<span class="show3"><img src="http://webimage.10x10.co.kr/play/ground/20141110/tit_this_moment_music_03.png" alt="어떤 노래를" /></span>
				<span class="show4"><img src="http://webimage.10x10.co.kr/play/ground/20141110/tit_this_moment_music_04.png" alt="듣고 있나요?" /></span>
			</h1>
			<div class="movie">
				<!-- for dev msg : 아침6시~오후2시 -->
				<% If hour(now) >= 6 And hour(now) < 14 Then %>
				<iframe src="//player.vimeo.com/video/111078071?autoplay=1&loop=1;" frameborder="0" title="" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
				<!-- for dev msg : 오후2시~오후10시 -->
				<% elseIf hour(now) >= 14 And hour(now) < 22 Then %>
				<iframe src="//player.vimeo.com/video/111078749?autoplay=1&loop=1;" frameborder="0" title="" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
				<!-- for dev msg : 오후10시~아침6시 -->
				<% elseIf hour(now) >= 22 And hour(now) < 6 Then %>
				<iframe src="//player.vimeo.com/video/111078230?autoplay=1&loop=1;" frameborder="0" title="" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
				<% End If %>
			</div>
			<p class="copyright">작품 <a href="http://vimeo.com/94706446" target="_blank" title="Time Remapper 풀 버전 보기 새창"><em>&lt;Time Remapper&gt;</em></a> Bruno Wang</p>
		</div>

		<div id="section2" class="section section2">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20141110/txt_with_good_music.gif" alt="Every time with good music in our life 해와 달이 뜨고 지는, 하루를 보내는 순간순간 우리는 좋은 노래들과 함께 합니다." /></p>
		</div>

		<div id="section-3" class="section section3">
			<p class="now1"><strong><img src="http://webimage.10x10.co.kr/play/ground/20141110/txt_now_music_01.png" alt="지금, PLAY 페이지에 머물러 있는 당신은..." /></strong></p>
			<p class="now2"><img src="http://webimage.10x10.co.kr/play/ground/20141110/txt_now_music_02.png" alt=" 하루의 시간을 보내면서 어떤 노래들을 듣고 있는지 궁금해졌습니다. 그리고 함께 듣고 싶어졌습니다. 지금 보고 있는 이 웹 페이지는 큰 라디오가 됩니다. 여러분은 이 시간만큼은 최고의 DJ가 되어 이 공간을 함께 하고 있는 사람들에게 좋은 노래들을 선곡하고 공유해 주세요 :)" /></p>
			<span class="play"><img src="http://webimage.10x10.co.kr/play/ground/20141110/btn_play.gif" alt="" /></span>
			<div class="bg"><img src="http://webimage.10x10.co.kr/play/ground/20141110/bg_blue.png" alt="" /></div>
		</div>

		<!-- time -->
		<div id="section4" class="section section4">
			<div class="time" id="lyrCounter"></div>
		</div>

		<!-- comment event -->
		<div id="section5" class="section section5">
			<div class="comment-evt">
				<div class="desc">
					<h2><img src="http://webimage.10x10.co.kr/play/ground/20141110/tit_comment_event.png" alt="코멘트 이벤트" /></h2>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141110/txt_music_share.png" alt="당신이 지금 이 순간, 함께 듣고 싶은 노래를 공유해 주세요." /></p>
					<p><a href="/shopping/category_prd.asp?itemid=1091239"><img src="http://webimage.10x10.co.kr/play/ground/20141110/txt_gift.png" alt="추첨을 통해 5분께 언제나 가까이에서 음악과 함께 하실 수 있는 아이리버 블루투스 스피커를 선물로 드립니다." /></a></p>
					<p class="date"><img src="http://webimage.10x10.co.kr/play/ground/20141110/txt_date.png" alt="이벤트 기간은 2014년 11월 10일부터 11월 19일까지며, 당첨자 발표는 2014년 11월 21일입니다." /></p>
				</div>

				<div class="field">
					<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>"/>
					<input type="hidden" name="bidx" value="<%=bidx%>"/>
					<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
					<input type="hidden" name="iCTot" value=""/>
					<input type="hidden" name="mode" value="add"/>
					<input type="hidden" name="spoint" value="<%=rencolor%>">
					<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
						<fieldset>
						<legend>지금 이 순간 함께 듣고 싶은 노래 추천하기</legend>
							<div class="itext">
								<label for="putitem01"><img src="http://webimage.10x10.co.kr/play/ground/20141110/txt_label_now.png" alt="나, 지금" /></label>
								<input type="text" id="putitem01" name="qtext1" value="" placeholder="잠이 안 오는 이 순간" onClick="jsChklogin11('<%=IsUserLoginOK%>');"/>
							</div>
							<div class="itext">
								<label for="putitem02"><img src="http://webimage.10x10.co.kr/play/ground/20141110/txt_label_musician.png" alt="이 가수의" /></label>
								<input type="text" id="putitem02" name="qtext2" value="" placeholder="브로콜리너마저" onClick="jsChklogin22('<%=IsUserLoginOK%>');"/>
							</div>
							<div class="itext">
								<label for="putitem03"><img src="http://webimage.10x10.co.kr/play/ground/20141110/txt_label_song.png" alt="이 노래를" /></label>
								<input type="text" id="putitem03" name="qtext3" value="" placeholder="보편적인 노래" onClick="jsChklogin33('<%=IsUserLoginOK%>');"/>
							</div>
							<div class="btn-submit">
								<input type="image" src="http://webimage.10x10.co.kr/play/ground/20141110/btn_recommend.png" alt="추천하기" class="animated fadeIn" />
							</div>
						</fieldset>
					</form>
					<form name="frmdelcom" method="post" action="/event/lib/comment_process.asp" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>">
					<input type="hidden" name="bidx" value="<%=bidx%>">
					<input type="hidden" name="Cidx" value="">
					<input type="hidden" name="mode" value="del">
					<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
					</form>
				</div>
			</div>
			<% IF isArray(arrCList) THEN %>
			<p class="copyright">텐바이텐 감성매거진 <em>&lt;HITCHHIKER&gt;</em>의 사진</p>
			<% End If %>
		</div>

		<% IF isArray(arrCList) THEN %>
		<!-- comment list -->
		<div id="section6" class="section section6">
			<div class="comment-list">
				<ul>
					<% For intCLoop = 0 To UBound(arrCList,2) %>
					<% 
							Dim opt1 , opt2 , opt3
							If arrCList(1,intCLoop) <> "" then
								opt1 = SplitValue(arrCList(1,intCLoop),"//",0)
								opt2 = SplitValue(arrCList(1,intCLoop),"//",1)
								opt3 = SplitValue(arrCList(1,intCLoop),"//",2)
							End If 
					%>
					<li>
						<span class="thumb"><img src="http://webimage.10x10.co.kr/play/ground/20141110/img_album_<%=chkiif(arrCList(3,intCLoop)<10,"0"&arrCList(3,intCLoop),arrCList(3,intCLoop))%>.jpg" width="130" height="130" alt="" /></span>
						<strong class="now"><%=opt1%></strong>
						<em class="song"><%=opt2%> - <%=opt3%></em>
						<span class="date"><% If arrCList(8,intCLoop) = "M"  then%><img src="http://webimage.10x10.co.kr/play/ground/20141110/ico_mobile.gif" alt="모바일에서 작성된 글" /><% End If %>&nbsp;<%=printUserId(arrCList(2,intCLoop),2,"*")%> / <%=formatdate(arrCList(4,intCLoop),"00:00")%></span>
						<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
						<button type="button" class="btnDel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');">삭제</button>
						<% end if %>
					</li>
					<% Next %>
				</ul>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
			</div>
		</div>
		<% End If %>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->