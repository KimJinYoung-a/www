<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  <PLAY> 여행하듯 랄랄라
' History : 2014.07.03 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
Dim eCode, userid, sub_idx, i
	eCode=getevt_code
	userid = getloginuserid()
Dim iCPerCnt, iCPageSize, iCCurrpage
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	
function getnowdate()
	dim nowdate
	
	nowdate = date()
	'nowdate = "2014-07-07"
	
	getnowdate = nowdate
end function

function getevt_code()
	dim evt_code
	
	IF application("Svr_Info") = "Dev" THEN
		evt_code   =  21225
	Else
		evt_code   =  53346
	End If
	
	getevt_code = evt_code
end function

IF iCCurrpage = "" THEN iCCurrpage = 1
iCPageSize = 6
iCPerCnt = 10		'보여지는 페이지 간격
	
dim ccomment
set ccomment = new Cevent_etc_common_list
	ccomment.FPageSize        = iCPageSize
	ccomment.FCurrpage        = iCCurrpage
	ccomment.FScrollCount     = iCPerCnt
	ccomment.frectordertype="new"
	ccomment.frectevt_code      	= eCode
	ccomment.event_subscript_paging
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
.playGr20140707 {}
.bookConcert {background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_paper_ivory.gif) 50% 0 repeat;}
.bookConcert .section1 {background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_travel_head_area.jpg) 50% 0 no-repeat; background-size:100% 232px;}
.bookConcert .section1 .group {width:1140px; margin:0 auto; padding:72px 0 90px; text-align:center;}
.bookConcert .section1 p {margin-top:27px;}
.bookConcert .section1 .group1 {position:relative;}
.bookConcert .section1 .group1 h3 {*overflow:hidden;}
.bookConcert .section1 .group1 .illust {margin-top:144px; margin-bottom:93px;}
.bookConcert .section1 .group1 .btnGo {position:absolute; top:717px; left:204px;}
.bookConcert .section1 .group2 {padding-top:45px;}
.bookConcert .section1 .group2 ul {overflow:hidden; margin-top:100px; padding-left:70px;}
.bookConcert .section1 .group2 ul li {float:left; padding:0 56px;}
.bookConcert .section2 {padding:110px 0; background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_paper_sky.gif) 50% 0 repeat; text-align:center;}
.bookConcert .section2 .group {position:relative; width:1140px; margin:0 auto; min-height:500px; background-color:#fff;}
.bookConcert .section2 .group .icon {*display:none; position:absolute;}
.bookConcert .section2 .group1 {width:1138px; padding:30px 0 60px; border:1px solid #e6f2ef;}
.bookConcert .section2 .group1 .part {position:relative; margin-top:65px; padding-left:485px;}
.bookConcert .section2 .group1 .part .book {position:absolute; top:0; left:150px;}
.bookConcert .section2 .group1 .slide {overflow:visible !important; position:relative; width:500px; height:350px; margin:10px 0 30px;}
.bookConcert .section2 .group1 .slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:25px; height:25px; margin-top:-12px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/btn_nav.png); background-repeat:none; text-indent:-999em;}
.bookConcert .section2 .group1 .slide .slidesjs-previous {left:-40px; background-position:0 0;}
.bookConcert .section2 .group1 .slide .slidesjs-next {right:-40px; background-position:100% 0;}
.bookConcert .section2 .group1 .icon1 {top:165px; left:-255px;}
.bookConcert .section2 .group1 .icon2 {top:45px; right:-190px;}
.bookConcert .section2 .group2 .slide {position:relative;}
.bookConcert .section2 .group2 .slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:35px; height:52px; margin-top:-26px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/btn_nav_white.png); background-repeat:none; text-indent:-999em;}
.bookConcert .section2 .group2 .slide .slidesjs-previous {left:10px; background-position:0 0;}
.bookConcert .section2 .group2 .slide .slidesjs-next {right:10px; background-position:100% 0;}
.bookConcert .section2 .group2 .slidesjs-pagination {overflow:hidden; position:absolute; bottom:40px; left:465px; z-index:10;}
.bookConcert .section2 .group2 .slidesjs-pagination li {float:left; padding:0 2px;}
.bookConcert .section2 .group2 .slidesjs-pagination li a {display:block; width:26px; height:26px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/btn_paging.png) 0 0 no-repeat; text-indent:-999em;}
.bookConcert .section2 .group2 .slidesjs-pagination li a.active {background:url(http://webimage.10x10.co.kr/play/ground/20140707/btn_paging.png) 100% 0 no-repeat;}
.bookConcert .section2 .group2 .icon1 {top:295px; left:-280px;}
.bookConcert .section2 .group2 .icon2 {top:125px; right:-285px;}
.bookConcert .section2 .group3 {width:1138px; padding:50px 0 105px; border:1px solid #e6f2ef;}
.bookConcert .section2 .group3 .part {position:relative; margin-top:65px; padding-left:426px;}
.bookConcert .section2 .group3 .part .tourist {position:absolute; top:23px; left:107px;}
.bookConcert .section2 .group3 .part .tourist .social {margin-top:20px;}
.bookConcert .section2 .group3 .icon1 {top:295px; left:-305px;}
.bookConcert .section2 .group3 .icon2 {top:465px; right:-285px;}
.bookConcert .section3 {padding:115px 0 65px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_paper_yellow.gif) 50% 0 repeat;}
.bookConcert .section3 .group {width:1140px; margin:0 auto; text-align:center;}
.bookConcert .section3 .group1 .part {position:relative; width:870px; height:162px; margin:0 auto; padding-top:65px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_painting_box.png) 0 0 no-repeat; text-align:left;}
.bookConcert .section3 .group1 .part textarea {width:556px; height:70px; margin-left:105px; padding:10px 12px; border:1px solid #e8e7da; color:#999; font-size:13px; font-family:'Dotum', 'Verdana';}
.bookConcert .section3 .group1 .part .btnSubmit {position:absolute; top:63px; right:57px;}
.bookConcert .section3 .comment {position:relative; min-height:510px; margin-top:90px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_comment_road.png) 50% 100% no-repeat;}
.bookConcert .section3 .comment .area {position:relative; text-align:left;}
.bookConcert .section3 .comment .area .writer {position:relative; padding-top:15px; padding-left:30px; color:#fff;}
.bookConcert .section3 .comment .area .writer strong {padding-left:10px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/blt_dot.png) 0 5px no-repeat;}
.bookConcert .section3 .comment .area .writer strong img {vertical-align:middle;}
.bookConcert .section3 .comment .area .writer span {position:absolute; top:15px; right:35px;}
.bookConcert .section3 .comment .area p {overflow:auto; width:155px; height:90px; margin:25px auto 0; color:#555;}
.bookConcert .section3 .comment .area .btnDel {position:absolute; top:2px; right:0; width:21px; height:21px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/btn_del.png) 0 0 no-repeat; text-indent:-999em;}
.bookConcert .section3 .comment .area1 {position:absolute; top:0; left:55px; width:238px; height:184px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_comment_box_01.png) 50% 0 no-repeat;}
.bookConcert .section3 .comment .area2 {position:absolute; top:0; left:410px; width:242px; height:193px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_comment_box_02.png) 50% 0 no-repeat;}
.bookConcert .section3 .comment .area3 {position:absolute; top:0; right:135px; width:255px; height:195px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_comment_box_03.png) 50% 0 no-repeat;}
.bookConcert .section3 .comment .area4 {position:absolute; bottom:17px; left:150px; width:238px; height:184px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_comment_box_04.png) 50% 0 no-repeat;}
.bookConcert .section3 .comment .area5 {position:absolute; bottom:17px; left:510px; width:242px; height:193px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_comment_box_05.png) 50% 0 no-repeat;}
.bookConcert .section3 .comment .area6 {position:absolute; right:35px; bottom:17px; width:255px; height:195px; background:url(http://webimage.10x10.co.kr/play/ground/20140707/bg_comment_box_06.png) 50% 0 no-repeat;}
.bookConcert .section3 .group2 .guide {margin-top:70px;}
.bookConcert .section3 .group2 .guide span {display:inline-block; padding:0 5px 2px; border-bottom:1px solid #d9d9d9; color:#888;}
.bookConcert .section3 .group2 .guide span img {vertical-align:middle;}
.bookConcert .section3 .group2 .paging {margin-top:30px;}
.bookConcert .section3 .group2 .paging a {background-color:transparent;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
/*	$(".bookmark li a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});

	$(".bookConcert .btnGo a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});
*/
	$("#slide1").slidesjs({
		width:"500",
		height:"350",
		pagination:false,
		navigation:{effect:"fade"},
		effect:{
			fade: {speed:1000, crossfade:true}
		}
	});

	$("#slide2").slidesjs({
		width:"1140",
		height:"760",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		effect:{
			fade: {speed:1000, crossfade:true}
		},
		play: {auto:true, effect:"fade"}
	});
});


function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If Now() > #07/17/2014 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If getnowdate>="2014-07-07" and getnowdate<"2014-07-18" Then %>
				if(frm.txtcomm.value =="로그인 후 글을 남길 수 있습니다."){
					jsChklogin('<%=IsUserLoginOK%>');
					return false;
				}
				if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 300 || frm.txtcomm.value == '코멘트를 입력해 주세요.(300자 이내)'){
					alert("코맨트가 없거나 제한길이를 초과하였습니다. 300자 까지 작성 가능합니다.");
					frm.txtcomm.focus();
					return;
				}

		   		frm.mode.value="addcomment";
				frm.action="doEventSubscript53346.asp";
				frm.target="evtFrmProc";
				frm.submit();
				return;
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>				
		<% End If %>
	<% Else %>
		//alert('로그인을 하셔야 참여가 가능 합니다');
		//return;
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function jsGoComPage(iP){
	document.frmcomm.iCC.value = iP;
	document.frmcomm.submit();
}

function jsDelComment(sub_idx)	{
	if(confirm("삭제하시겠습니까?")){
		frmcomm.sub_idx.value = sub_idx;
		frmcomm.mode.value="delcomment";
		frmcomm.action="doEventSubscript53346.asp";
		frmcomm.target="evtFrmProc";
   		frmcomm.submit();
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}
	
	if (document.frmcomm.txtcomm.value == '코멘트를 입력해 주세요.(300자 이내)'){
		document.frmcomm.txtcomm.value='';
	}
}
</script>
</head>
<body>
	<div class="playGr20140707">
		<div class="bookConcert">
			<div class="section section1">
				<div class="group group1">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20140707/tit_book_concert.png" alt="책과 노래가 함께하는 북콘서트 여행하듯 랄랄라" /></h3>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_invite.png" alt="텐바이텐에서 만끽하는 도심 속 여름 여행, 그 설레는 시작에 당신을 초대합니다" /></p>
					<div class="illust"><img src="http://webimage.10x10.co.kr/play/ground/20140707/img_road_illust.png" alt="" /></div>
					<div class="btnGo"><a href="#comment"><img src="http://webimage.10x10.co.kr/play/ground/20140707/btn_go_comment.png" alt="북콘서트 기대평 쓰러가기" /></a></div>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_ground_topic_travel.png" alt="그라운드 열 번째 주제는 여행입니다. 때로는 직접 떠나는 여행이 아니어도, 누군가의 여행사진 그리고 이야기에 가슴 설레이고 행복해지곤 합니다. 황의정 작가의 여행에세이 여행하듯 랄랄라와 북콘서트를 기획했습니다. 이번 북 콘서트로 여러분도 여행하듯, 랄랄라 콧노래를 부를 수 있기를 바랍니다 : )" /></p>
				</div>

				<div class="group group2">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20140707/tit_book_concert_programe.png" alt="북 콘서트 프로그램" /></h4>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_date.png" alt="북 콘서트는 2014년 7월 24일 목요일 저녁 8시, 장소는 텐바이텐 대학로 라운지 2층에서 열립니다." /></p>
					<ul class="bookmark">
						<li><a href="#topic1"><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_program_01.png" alt="첫번째 &lt;끌림&gt;, &lt;바람이 분다 당신이 좋다&gt;의 이병률 시인과 함께 나눠보는 REAL 여행과 제주에 대한 이야기" /></a></li>
						<li><a href="#topic2"><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_program_02.png" alt="두번째 황의정 작가가 들려주는 생활 속 보석 찾기에 대한 이야기, 그리고 나만의 지우개 도장 만들기" /></a></li>
						<li><a href="#topic3"><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_program_03.png" alt="세번째 여행을 소재로 한 노래를 선보이는 혼성 10인조 밴드 투어리스트와 함께 부르는 여행의 설렘을 담은 노래!" /></a></li>
					</ul>
				</div>
			</div>

			<div class="section section2">
				<div id="topic1" class="group group1">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20140707/tit_book_lalala.png" alt="신간도서 &lt;여행하듯 랄랄라&gt;" /></h4>
					<div class="part">
						<p class="book">
							<a href="/culturestation/culturestation_event.asp?evt_code=2414" target="_blank" title="여행하듯 랄랄라 도서 보러가기 새창"><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_book_lalala.png" alt="여기, 저 푸른 초원 위에 그림같은 집을 짓고 사랑하는 우리 님과 한평생 살고 있는 부부, 아니 가족이 있습니다." /></a>
						</p>
						<div id="slide1" class="slide">
							<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_book_01.jpg" alt="좋아하는 것을 하지 못하고 산다면 그 자체로 빚더미일 것이다. 적어도 이 책에 가득한 삶의 방향들은 나에게 그 사실을 가르쳐주었다. 내가 살고  싶어하는 간절한 라이프스타일이 한 권의 이 책에 가득하다. 이병률 시인" />
							<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_book_02.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_book_03.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_book_04.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_book_05.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_book_06.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_book_07.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_book_08.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_book_09.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_book_10.jpg" alt="시간은 훌륭한 마감재다. 대단히 진귀한 물건이 아니더라도 일상의 하루하루가 쌓이면 언젠가 보석처럼 빛나기 마련이다." />
						</div>
					</div>
					<div class="icon icon1"><img src="http://webimage.10x10.co.kr/play/ground/20140707/ico_illust_01.png" alt="" /></div>
					<div class="icon icon2"><img src="http://webimage.10x10.co.kr/play/ground/20140707/ico_illust_02.png" alt="" /></div>
				</div>

				<div id="topic2" class="group group2">
					<div id="slide2" class="slide">
						<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_01.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_02.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_03.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_04.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_05.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_06.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20140707/img_slide_07.jpg" alt="" />
					</div>
					<div class="icon icon1"><img src="http://webimage.10x10.co.kr/play/ground/20140707/ico_illust_03.png" alt="" /></div>
					<div class="icon icon2"><img src="http://webimage.10x10.co.kr/play/ground/20140707/ico_illust_04.png" alt="" /></div>
				</div>

				<div id="topic3" class="group group3">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20140707/tit_band_tourist.png" alt="밴드 &lt;투어리스트&gt;" /></h4>
					<div class="part">
						<div class="tourist">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_band_tourist.png" alt="10명의 멤버가 매월 여행을 노래로 만드는 여행음악 프로젝트 팀. 2012년 데뷔 이후 대표곡으로는 나란한 걸음, 올레길 등이 있다." /></p>
							<div class="social">
								<a href="/culturestation/culturestation_event.asp?evt_code=2435" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140707/btn_go_album.png" alt="앨범 보러가기" /></a>
								<a href="https://www.facebook.com/MusicTour" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140707/btn_go_facebook.png" alt="페이스북" /></a>
								<a href="https://twitter.com/Music4Tour" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140707/btn_go_twitter.png" alt="트위터" /></a>
							</div>
						</div>
						<div class="youtube">
							<iframe src="//www.youtube.com/embed/LBAdUlsaSnc?list=UUHJs3ZQrJ2CdAUU67ThzYI" width="620" height="348" frameborder="0" title="투어리스트의 Walk Alongside" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
						</div>
					</div>
					<div class="icon icon1"><img src="http://webimage.10x10.co.kr/play/ground/20140707/ico_illust_05.png" alt="" /></div>
					<div class="icon icon2"><img src="http://webimage.10x10.co.kr/play/ground/20140707/ico_illust_06.png" alt="" /></div>
				</div>
			</div>

			<div id="comment" class="section section3">
				<div class="group group1">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_lalala.png" alt="책과 노래가 함께하는 북콘서트 여행하듯 랄랄라" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_leave_comment.png" alt="텐바이텐이 함께 하는 북콘서트 여행하듯 랄라라의 기대평을 남겨주세요. 30쌍을 추첨해 특별한 도심 속 여행을 선물합니다. Special gift도 준비되어 있어요." /></p>
					
					<form name="frmcomm" action="" onsubmit="return false;" method="post" style="margin:0px;">
					<input type="hidden" name="mode">
					<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
					<input type="hidden" name="sub_idx">
					<div class="part">
							<fieldset>
							<legend>콘서트 여행하듯 랄라라 기대명 쓰기</legend>
								<textarea name="txtcomm" title="코멘트 입력" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="60" rows="5" ><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>코멘트를 입력해 주세요.(300자 이내)<%END IF%></textarea>
								<div class="btnSubmit"><input type="image" onclick="jsSubmitComment(frmcomm); return false;" src="http://webimage.10x10.co.kr/play/ground/20140707/btn_submit.png" alt="이벤트 참여" /></div>
							</fieldset>
					</div>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140707/txt_info.png" alt="이벤트기간은 2014년 7월 7일 월요일부터 7월 17일 목요일까지이며, 당첨자 발표는 2014년 7월 18일 금요일에 합니다. 콘서트 일시는 2014년 7월 24일 목요일 저녁 8시이며, 장소는 텐바이텐 대학로 라운지 2층에서 열립니다." /></p>
				</div>

				<!-- comment -->
				<% IF ccomment.ftotalcount>0 THEN %>
				<div class="group group2">
					<div class="comment">
						<%
						for i = 0 to ccomment.fresultcount - 1
						%>
						<div class="area area<%= i + 1 %>">
							<div class="writer">
								<strong>
									<%=printUserId(ccomment.FItemList(i).fuserid,2,"*")%>
									<% if ccomment.FItemList(i).fdevice<>"W" then %>
										<img src="http://webimage.10x10.co.kr/play/ground/20140707/ico_mobile_white.png" alt="모바일" />
									<% end if %>
								</strong>	
								<span>no.<%=ccomment.FTotalCount-i-(ccomment.FPageSize*(ccomment.FCurrPage-1))%></span>
							</div>
							<p><%=ReplaceBracket(ccomment.FItemList(i).fsub_opt3)%></p>
							<% if ((userid = ccomment.FItemList(i).fuserid) or (userid = "10x10")) and ( ccomment.FItemList(i).fuserid<>"") then %>
								<button type="button" onclick="jsDelComment('<%= ccomment.FItemList(i).fsub_idx %>'); return false;" class="btnDel">삭제</button>
							<% end if %>
						</div>
						<%
						next
						%>
					</div>
					<p class="guide"><span><img src="http://webimage.10x10.co.kr/play/ground/20140707/ico_mobile_grey.png" alt="모바일" /> 아이콘은 모바일에서 작성한 코멘트입니다.</span></p>
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(ccomment.FCurrpage, ccomment.ftotalcount, ccomment.FPageSize, ccomment.FScrollCount,"jsGoComPage") %>
					</div>
				</div>
				<!-- //comment -->
				<% END IF %>
				</form>
			</div>
		</div>
	</div>
	<!-- 수작업 영역 끝 -->
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height="0"></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->