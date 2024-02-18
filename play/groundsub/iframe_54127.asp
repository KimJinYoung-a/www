<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'#### 2014-08-06 이종화 작성 ###################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21257
Else
	eCode   =  54127
End If

dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	'그룹 번호(엣지1, 초식2, 연하3)

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 12		'한 페이지의 보여지는 열의 수
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

	rencolor=int(Rnd*4)+1
%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
img {vertical-align:top;}
.desertIsland {}
.desertIsland .sectionA {position:relative; border-bottom:1px solid #fafafa; background-color:#f6f6f6; text-align:center;}
.desertIsland .sectionA .topic {position:absolute; top:85px; left:50%; width:660px; margin-left:-330px;}
.desertIsland .sectionA .topic p {margin-top:5px;}
.desertIsland .sectionA .visual img {width:100%;}
.desertIsland .sectionA .desc {position:relative; width:1140px; margin:0 auto; padding:128px 0 140px; text-align:left;}
.desertIsland .sectionA .desc p {margin-left:76px;}
.desertIsland .sectionA .desc .btnPut {position:absolute; top:129px; right:77px;}
/* sectionB */
.desertIsland .sectionB {padding:133px 0 161px; background-color:#fff; text-align:center;}
.desertIsland .sectionB h4 {position:relative; width:703px; margin:0 auto 8px;}
.desertIsland .sectionB h4 span {position:absolute; top:0; right:153px;}
.desertIsland .sectionB {overflow:hidden;}
.desertIsland .slideBag {width:1140px; margin:0 auto; padding-top:60px;}
.desertIsland .slide {overflow:visible !important; position:relative; height:850px;}
.desertIsland .slide .slidesjs-navigation {position:absolute; z-index:10; width:82px; height:163px; background-image:url(http://webimage.10x10.co.kr/play/ground/20140811/btn_nav.png); background-repeat:no-repeat; text-indent:-999em;}
.desertIsland .slide .slidesjs-previous,
.desertIsland .slide .slidesjs-next {*display:none; top:50%; margin-top:-81px; color:#fff; font-size:24px; text-shadow:0 0 5px #000;}
.desertIsland .slide .slidesjs-previous {left:-90px; background-position:0 0;}
.desertIsland .slide .slidesjs-next {right:-90px;  background-position:100% 0;}
.desertIsland .slidesjs-pagination {overflow:hidden; width:275px; margin:0 auto; padding-top:40px;}
.desertIsland .slidesjs-pagination li {float:left; margin-right:1px;}
.desertIsland .slidesjs-pagination li a {display:block; width:54px; height:7px; background-image:url(http://webimage.10x10.co.kr/play/ground/20140811/btn_paging.gif); background-repeat:no-repeat; background-position:0 0; text-indent:-999em;}
.desertIsland .slidesjs-pagination li a.active {background-position:0 100%;}
.desertIsland .people {overflow:hidden;}
.desertIsland .people .inbag {float:left; margin-bottom:20px; margin-left:20px; position:relative; color:#fff; text-align:left; cursor:pointer;}
.desertIsland .people .inbag .over {position:absolute; top:0; left:0; width:232px; height:229px; padding:33px 10px 0 18px;}
.desertIsland .people .inbag .red {background:#ff0000 url(http://webimage.10x10.co.kr/play/ground/20140811/bg_over_effect_red.gif) no-repeat 0 0;}
.desertIsland .people .inbag .yellow {background:#ff8a00 url(http://webimage.10x10.co.kr/play/ground/20140811/bg_over_effect_yellow.gif) no-repeat 0 0;}
.desertIsland .people .inbag .green {background:#00c03f url(http://webimage.10x10.co.kr/play/ground/20140811/bg_over_effect_green.gif) no-repeat 0 0;}
.desertIsland .people .inbag .brown {background:#8b2d10 url(http://webimage.10x10.co.kr/play/ground/20140811/bg_over_effect_brown.gif) no-repeat 0 0;}
.desertIsland .people .inbag strong {font-size:15px; font-family:'Dotum', 'Verdana';}
.desertIsland .people .inbag ul {margin-top:35px;}
.desertIsland .people .inbag ul li {margin-top:10px; font-size:11px; line-height:1.8em;}
.desertIsland .people .inbag ul li strong {display:block;}
.desertIsland .people .inbag .letter {letter-spacing:-0.05em;}
/* sectionC */
.desertIsland .sectionC {border-top:1px solid #fafafa; background-color:#f6f6f6;}
.desertIsland .sectionC .group {width:1140px; margin:0 auto; padding-top:124px;}
.desertIsland .sectionC .group .partA {position:relative; background-color:#fff;}
.desertIsland .sectionC .group .partA .desc {padding:42px 76px 33px 74px;}
.desertIsland .sectionC .group .partA h4 {margin-bottom:52px; text-align:center;}
.desertIsland .sectionC .group .partA .btnGo {position:absolute; top:100px; right:288px;}
.desertIsland .sectionC .group .partA .iText {width:196px; height:32px; margin-right:25px; padding:0 10px; background:url(http://webimage.10x10.co.kr/play/ground/20140811/bg_input_text.gif) 0 0 repeat; font-size:12px; font-weight:bold; line-height:32px;}
.desertIsland .sectionC .group .partA .item {position:relative; padding:0 0 56px 74px;}
.desertIsland .sectionC .group .partA .item p {position:absolute; bottom:30px; left:74px;}
.desertIsland .sectionC .group .partA label {margin-right:3px;}
.desertIsland .sectionC .group .partA .btnSubmit {position:absolute; top:-96px; right:75px;}
.desertIsland .sectionC .paging {margin-top:77px;}
.desertIsland .sectionC .paging a {background-color:transparent;}
.bagList {overflow:hidden; padding-top:41px; padding-left:75px;}
.bagList .bag {float:left; position:relative; width:153px; height:126px; margin-top:41px; margin-right:67px; padding:43px 22px 0 22px;}
.bagList .bag1 {background:url(http://webimage.10x10.co.kr/play/ground/20140811/bg_bag_red.gif) no-repeat 0 0;}
.bagList .bag2 {background:url(http://webimage.10x10.co.kr/play/ground/20140811/bg_bag_yellow.gif) no-repeat 0 0;}
.bagList .bag3 {background:url(http://webimage.10x10.co.kr/play/ground/20140811/bg_bag_green.gif) no-repeat 0 0;}
.bagList .bag4 {background:url(http://webimage.10x10.co.kr/play/ground/20140811/bg_bag_brown.gif) no-repeat 0 0;}
.bagList .bag ul {height:85px;}
.bagList .bag ul li {margin-top:10px; color:#000; font-size:14px; font-family:'Dotum', 'Verdana'; font-weight:bold; line-height:1.125em;}
.bagList .bag .writer {*margin-top:12px; color:#5e5e5e; font-size:11px; font-family:'Dotum', 'Verdana'; line-height:1.25em; text-align:right;}
.bagList .bag .writer span {padding-left:3px; font-weight:bold;}
.bagList .bag .writer img {vertical-align:middle;}
.bagList .bag .btnDel {position:absolute; right:19px; bottom:32px; width:32px; height:15px; background:url(http://webimage.10x10.co.kr/play/ground/20140811/btn_del.gif) no-repeat 0 0; text-indent:-999em;}
.animated {-webkit-animation-duration:5s; animation-duration:5s; -webkit-animation-fill-mode:both; animation-fill-mode:both;}
/* Bounce animation */
@-webkit-keyframes bounce {
	0%, 20%, 50%, 80%, 100% {-webkit-transform: translateY(0);}
	40% {-webkit-transform: translateY(-10px);}
	60% {-webkit-transform: translateY(-5px);}
}
@keyframes bounce {
	0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-10px);}
	60% {transform: translateY(-5px);}
}
.bounce {-webkit-animation-name:bounce; animation-name:bounce; -webkit-animation-iteration-count:3; animation-iteration-count:3;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".btnPut a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop :3100},800);
	});

	$(".slide").slidesjs({
		width:"1140",
		height:"830",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play: {interval:8000, effect:"fade", auto:false},
		effect:{fade: {speed:500, crossfade:true}}
	});

	$(".desertIsland .people .inbag .over").hide();
	$(".desertIsland .people .inbag").mouseover(function(){
		$(this).find(".over").slideDown();
	});
	$(".desertIsland .people .inbag").mouseleave(function(){
		$(this).find(".over").slideUp();
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

	   if(!frm.qtext1.value||frm.qtext1.value=="1번째"){
	    alert("가방에 넣을 것을 입력해주세요");
		document.frmcom.qtext1.value="";
	    frm.qtext1.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.qtext1.value)>21){
			alert('10자 까지 가능합니다.');
	    frm.qtext1.focus();
	    return false;
		}

	   if(!frm.qtext2.value||frm.qtext2.value=="2번째"){
	    alert("가방에 넣을 것을 입력해주세요");
		document.frmcom.qtext2.value="";
	    frm.qtext2.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.qtext2.value)>21){
			alert('10자 까지 가능합니다.');
	    frm.qtext2.focus();
	    return false;
		}

	   if(!frm.qtext3.value||frm.qtext3.value=="3번째"){
	    alert("가방에 넣을 것을 입력해주세요");
		document.frmcom.qtext3.value="";
	    frm.qtext3.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.qtext3.value)>21){
			alert('10자 까지 가능합니다.');
	    frm.qtext3.focus();
	    return false;
		}

	   frm.action = "doEventSubscript54127.asp";
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

	function jsChkUnblur11()
	{
		if(document.frmcom.qtext1.value ==""){
			document.frmcom.qtext1.value="1번째";
		}
	}

	function jsChkUnblur22()
	{
		if(document.frmcom.qtext2.value ==""){
			document.frmcom.qtext2.value="2번째";
		}
	}

	function jsChkUnblur33()
	{
		if(document.frmcom.qtext3.value ==""){
			document.frmcom.qtext3.value="3번째";
		}
	}

//-->
</script>
<div class="playGr20140811">
	<div class="desertIsland">
		<div class="section sectionA">
			<div class="topic">
				<h3><img src="http://webimage.10x10.co.kr/play/ground/20140811/tit_desert_island.png" alt="무인도로 가는 가방" /></h3>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_only_three_items.png" alt="당신은 곧 무인도로 가게 됩니다. 허락된 것은 가방 하나와 그 안에 넣어갈 세 가지의 어떤 것뿐!" /></p>
			</div>
			<div class="visual"><img src="http://webimage.10x10.co.kr/play/ground/20140811/img_main_visual.gif" alt="" /></div>
			<div class="desc">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_put_your_bag_01.gif" alt="PLAY 에서는 모두에게 주어진 똑같은 가방이지만, 사람마다 무인도로 가는 이 가방 안에 어떤 것들을 담아갈지 궁금해졌습니다. 똑같은 가방이지만, 담는 것에 따라 똑같지 않은 가방! 다양한 직업과 나이의 60여명의 사람들에게 들어 본, 무인도로 가는 가방에 담긴 이야기 그리고 당신에게 듣고 싶은 이야기! " /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_put_your_bag_02.gif" alt="무인도로 가는 이 가방안에 딱 세 가지만 담아갈 수 있다면, 어떤 것을 담아 가시겠어요?" /></p>
				<div class="btnPut"><a href="#comment"><img src="http://webimage.10x10.co.kr/play/ground/20140811/btn_put_bag.gif" alt="가방에 담으러 가기" /></a></div>
			</div>
		</div>

		<div class="section sectionB">
			<h4>
				<img src="http://webimage.10x10.co.kr/play/ground/20140811/tit_60_peoples.gif" alt="60명의 사람들에게 들어 본, 무인도로 가는 가방에 담긴 이야기" />
				<span class="animated bounce"><img src="http://webimage.10x10.co.kr/play/ground/20140811/ico_bag.gif" alt="" /></span>
			</h4>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_more_story.gif" alt="마우스를 올리면 더 많은 이야기를 확인할 수 있어요! " /></p>

			<div class="slideBag">
				<div class="slide">
					<!-- slide1 -->
					<div class="people">
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_01.gif" alt="RADIO, STRING, SUNBED" />
							<div class="over brown">
								<strong>ㅂ ㅅ ㅈ / 32 / 제품디자이너</strong>
								<ul>
									<li><strong>1.RADIO</strong> 장시간의 무음은 참을 수 없음</li>
									<li><strong>2.STRING</strong> 매듭공예, 손뜨개로 여러가지를 제작함</li>
									<li><strong>3.SUNBED</strong> 취침,태닝,사색 등 다용도로 사용가능</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_02.gif" alt="대형마트, 언니, 우리집" />
							<div class="over yellow">
								<strong>최현정 / 26 / 제품디자이너</strong>
								<ul>
									<li><strong>1.대형마트</strong> 모두 다 있음. 의식주를 한번에 해결!</li>
									<li><strong>2.언니</strong> 최대한 지금 환경과 흡사하게!</li>
									<li><strong>3.우리집</strong> 가장 편안한 공간,가장 좋아하는 곳</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_03.gif" alt="랜턴 모기장, 텐트, 스노쿨링 장비세트" />
							<div class="over red">
								<strong>움지기 / 29 / 컨텐츠기획자</strong>
								<ul>
									<li><strong>1.랜턴</strong> 어둡고 깜깜한 밤. 낭만 있으려고</li>
									<li><strong>2.모기장 텐트</strong> 수 많은 벌레들에게서 나를 보호!</li>
									<li><strong>3.스노쿨링 장비세트</strong> 바다에서 종일 놀아도 지루하지 않도록</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_04.gif" alt="지식인 서버 컴퓨터, 우리 엄마, 약통" />
							<div class="over brown">
								<strong>girl / 38 / 웹퍼블리셔</strong>
								<ul>
									<li><strong>1.지식인 서버 컴퓨터</strong> 지식인은 다 해결 가능할 것 같아서</li>
									<li><strong>2.우리 엄마</strong> 우리 엄마는 슈퍼우먼! 만능이니깐</li>
									<li><strong>3.약통</strong> 살아 남으려면 아프지 말아야 할 것!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_05.gif" alt="이연희, 카메라, 핸드폰" />
							<div class="over yellow">
								<strong>손경민 / 30 / 마케터</strong>
								<ul>
									<li><strong>1.이연희</strong> 무인도에서 나를 선택할 수 밖에 없는 상황</li>
									<li><strong>2.카메라</strong> 우리의 결혼 사진을 남겨야 하니까</li>
									<li><strong>3.핸드폰</strong> 인스타그램에 올려서 증명해야 하니까</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_06.gif" alt="우리집 개님, 말 많은 광희, 일기장" />
							<div class="over brown">
								<strong>굼벵이 / 27 / 디자이너</strong>
								<ul>
									<li><strong>1.우리집 개님</strong> 나를 지켜줄 수 있도록 ! </li>
									<li><strong>2.말 많은 광희</strong> 처음봐도 절친 같다는 말 많은 광희와!</li>
									<li><strong>3.일기장</strong> 그간의 일을 기록. 돌아와서 할 일을 기록!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_07.gif" alt="여자친구, 빔 프로젝트, 맥주 BAR" />
							<div class="over green">
								<strong>정동 / 31 / 텍스타일디자이너</strong>
								<ul>
									<li><strong>1.여자친구</strong> 함께 하면 외롭지 않을 나의 사랑!</li>
									<li><strong>2.DVD</strong> DVD를 볼 수 있는 빔 프로젝트 매일 하루에 한편씩 영화관람</li>
									<li><strong>3.맥주 BAR </strong> 시원한 맥주를 빼 놓을 수 없지!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_08.gif" alt="요트, 휴대용 바닷물 정수기, 엄마" />
							<div class="over red">
								<strong>Molly / 28 / MD</strong>
								<ul>
									<li><strong>1.요트</strong> 어디든 이용할 수 있어서!</li>
									<li><strong>2.엄마 </strong> 음식도, 잘 곳도, 친구도 되어 줄 거니까</li>
									<li><strong>3.휴대용 바닷물 정수기</strong> 마실 수 있는 물을 만들어 먹으려고</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_09.gif" alt="도라에몽, 정수기, 어디로든 통할 수 있는 문" />
							<div class="over green">
								<strong>써니 / 24 / 웹디자이너</strong>
								<ul>
									<li><strong>1.도라에몽</strong> 4차원 주머니가 있는 도라에몽!</li>
									<li><strong>2.정수기</strong> 물이 없으면 인간이 죽기 때문에..</li>
									<li><strong>3.어디로든 통할 수 있는 문</strong> 무인도에 있다가도 어디로든 왔다 갔다 !</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_10.gif" alt="해충퇴치약, 맥주, 우리집 반려견 희몽이" />
							<div class="over brown">
								<strong>오미자 / 25 / 스타일리스트</strong>
								<ul>
									<li><strong>1.해충퇴치약</strong> 느긋하게 여유를 위한 필수 아이템!</li>
									<li><strong>2.맥주</strong> 바다가 있는 곳에 맥주가 빠질 쏘냐!</li>
									<li><strong>3.우리집 반려견 희몽이</strong> 무인도에서 언니랑 신나게 뛰어 놀자!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_11.gif" alt="트위터, 박원, 이태리 타올" />
							<div class="over red">
								<strong class="letter">귀염돌이 / 29.5 / 마케팅담당자</strong>
								<ul>
									<li><strong>1.트위터</strong> 매일매일 일기도 쓰고 사람들과 소통도 하고!</li>
									<li><strong>2.박원</strong> 현실에선 못 만나니 무인도에서도 같이!</li>
									<li><strong>3.이태리 타올</strong> 1 주일에 한번씩 때는 밀어줘야 개운!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_12.gif" alt="자수세트, 아이폰, 대X항공" />
							<div class="over yellow">
								<strong>촤촤 / 28 / MD</strong>
								<ul>
									<li><strong>1.자수세트</strong> 실컷 자수만 하고 싶은 요즘!</li>
									<li><strong>2.아이폰 </strong> 무인도생활을 인스타그램에 공개할 예정</li>
									<li><strong>3.대X항공</strong> 하늘을 나는 호텔 A380 어느 곳이든!</li>
								</ul>
							</div>
						</div>
					</div>

					<!-- slide2 -->
					<div class="people">
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_13.gif" alt="텐트, 만능툴, 라이터" />
							<div class="over yellow">
								<strong>똥자루 / 30 / 직장인</strong>
								<ul>
									<li><strong>1.텐트</strong> 안정적인 쉴 곳 확보</li>
									<li><strong>2.만능툴</strong> 의식주를 해결할 수 있는 도구</li>
									<li><strong>3.라이터</strong> 살아가기 위해 꼭 필요한 불</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_14.gif" alt="노예 1, 노예 2, 노예 3" />
							<div class="over green">
								<strong>303호 대장 / 58 / 회사원</strong>
								<ul>
									<li><strong>1.노예 1</strong> </li>
									<li><strong>2.노예 2</strong> </li>
									<li><strong>3.노예 3</strong> 무인도에 가면 외롭고, 일이 많을 테니까 노예를 데리고 가겠다. 거기서 왕이 되야지</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_15.gif" alt="카메라, 푹신하고 아주 큰 베개, 용기" />
							<div class="over red">
								<strong>안선생 / 29 / 포토그래퍼</strong>
								<ul>
									<li><strong>1.카메라</strong> 가장 열정적이고 즐겁게 할 수 있는 매개체</li>
									<li><strong>2.푹신하고 아주 큰 베개</strong> 베개 없이는 숙면을 취하기 힘듬!</li>
									<li><strong>3.용기</strong> 새로운 세상을 개척하기 위해 품어야 할 용기!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_16.gif" alt="오리배, 짜X게티, 하얀천" />
							<div class="over yellow">
								<strong>괜찮이 / 29 / 디자이너</strong>
								<ul>
									<li><strong>1.오리배</strong> 잠을 잘 수 있는 보금자리</li>
									<li><strong>2.짜X게티</strong> 희망의 식량 !</li>
									<li><strong>3.하얀천 </strong> 하얀천과 바람만 있음 어디든 갈 수 있어! (참고 꽃보다 남자 지후 선배)</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_17.gif" alt="맥가이버칼, 침대, 남친" />
							<div class="over brown">
								<strong>안취해 / 30 / VM</strong>
								<ul>
									<li><strong>1.맥가이버칼</strong> 수렴, 채취 생존도구</li>
									<li><strong>2.침대</strong> 잠자는 시간 만큼은 편안하게!</li>
									<li><strong>3.남친</strong> 혼자 있으면 외로우니깐</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_18.gif" alt="엄마, 강아지, 김병만 아저씨" />
							<div class="over red">
								<strong>ㄱ ㄱ ㅁ / 27 / 스타일리스트</strong>
								<ul>
									<li><strong>1.엄마</strong> 무인도에 여행을 간 것처럼 신나게!</li>
									<li><strong>2.강아지</strong> 강아지와 함께 마음껏 뛰어 놀아야지</li>
									<li><strong>3.김병만 아저씨</strong> 엄마랑 강아지랑 놀고 있으면 일을 해줄 것!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_19.gif" alt="흰천, 라면스프, 맥가이버칼" />
							<div class="over brown">
								<strong>드리머빈 / 29 / MD</strong>
								<ul>
									<li><strong>1.흰천</strong> 흰천, 바람만 있으면 어디든 갈 수 있으니!</li>
									<li><strong>2.라면스프</strong> 너와 함께면 코코넛이 무우로 느껴질 껄!</li>
									<li><strong>3.맥가이버칼</strong> 조금만 현실적이게 필요하니까...</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_20.gif" alt="타임머신, 순간이동기술, 캠핑용품" />
							<div class="over green">
								<strong>덤덤 / 41 / 회사원</strong>
								<ul>
									<li><strong>1.타임머신</strong> 남들 모르게 나쁜 짓을 많이 하려고?</li>
									<li><strong>2.순간이동기술</strong> 가끔은 바깥으로 나와주시는 센스 !</li>
									<li><strong>3.캠핑용품</strong> 먹고 살아야 하기에...</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_21.gif" alt="류승룡, 이진욱, 방수카메라" />
							<div class="over yellow">
								<strong>김은콩 / 29 / 목수 VMD</strong>
								<ul>
									<li><strong>1.류승룡</strong> 그가 나온 영화를 봤다면 모셔갈 이유가 충분!</li>
									<li><strong>2.이진욱</strong> 무인도에 행복하고 싶어요. 두 남자 사이에서</li>
									<li><strong>3.방수카메라</strong> 두 분과 함께 기념을 많이 남기려고</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_22.gif" alt="기초 영어문법책, 라면스프, 정말 좋은 담요" />
							<div class="over brown">
								<strong>ㅇㅅㅇ / 28 / 직장인</strong>
								<ul>
									<li><strong>1.영어문법책 (기초)</strong> 무료한 무인도. 미뤘던 영어공부 시작!</li>
									<li><strong>2.라면스프</strong> 낯선음식도 고향화시키는 무적의 라면스프</li>
									<li><strong>3.(정말 좋은) 담요 </strong> 별 구경을 밤새 하려면 정말 좋은 담요가 필요!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_23.gif" alt="서바이벌키트, 그림도구, 캠핑용품" />
							<div class="over green">
								<strong>코불아 / 40 / 프로그래머</strong>
								<ul>
									<li><strong>1.서바이벌키트</strong> 야생! 칼, 라이터, 밧줄 등 살기 위한 것들</li>
									<li><strong>2.그림도구</strong> 이번 기회에 그림이나 그려보세!</li>
									<li><strong>3.캠핑용품</strong> 땅바닥에서 그냥 잘 순 없으니깐!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_24.gif" alt="남자친구, 고양이, 살아남기 책" />
							<div class="over red">
								<strong>아름 / 30 / 스타일리스트</strong>
								<ul>
									<li><strong>1.남자친구</strong> 나 대신 이것저것 해야 하니깐!</li>
									<li><strong>2.고양이</strong> 집에만 있으니 무인도를 구경시켜 주고 싶어서</li>
									<li><strong>3.살아남기 책</strong> 나,남자친구,고양이 모두 살아남아야 하니깐!</li>
								</ul>
							</div>
						</div>
					</div>

					<!-- slide3 -->
					<div class="people">
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_25.gif" alt="튜브, 닳지 않는 연필&amp;스케치북 세트, 극세사 이불" />
							<div class="over brown">
								<strong>정유진 / 26 / AMD</strong>
								<ul>
									<li><strong>1.튜브</strong> 바다에서 물놀이를 하지 않으면 아쉬워요!</li>
									<li><strong class="letter">2.닳지 않는 연필&amp;스케치북 세트</strong> 연필과 종이만 있다면 나는 외롭지 않다</li>
									<li><strong>3.극세사 이불</strong> 배는 항상 따뜻해야 잠이 더 잘 와요!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_26.gif" alt="공구박스, 둘리, 아프리카 원주민" />
							<div class="over yellow">
								<strong>나수겸 / 26 / AMD</strong>
								<ul>
									<li><strong>1.공구박스</strong> 생존에 필요한 공구박스!</li>
									<li><strong>2.둘리</strong> 둘리의 초능력이 있으면 못할 것이 없을 듯!</li>
									<li><strong>3.아프리카 원주민</strong> 원주민을 앞세워 무인도를 정복할 예정!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_27.gif" alt="라디오, &apos;테이큰’&apos;에 나오는 아빠, " />
							<div class="over red">
								<strong>조재희 / 26 / 웹 디자이너</strong>
								<ul>
									<li><strong>1.라디오</strong> 너무 조용해 무서울 것 같으니, 라디오가 딱!</li>
									<li><strong>2.&apos;테이큰&apos;에 나오는 아빠</strong> 못하는 게 없는 주인공. 무엇이든 척척할 것 같다.</li>
									<li><strong>3.영어책</strong> 테이큰아빠랑 소통해야 하니까. 영어 회화책!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_28.gif" alt="아이언맨 수트, 텔레포트, 발전기" />
							<div class="over brown">
								<strong>김정수 / 28 / 회사원</strong>
								<ul>
									<li><strong>1.아이언맨 수트</strong> 사냥, 무거운 짐을 책임</li>
									<li><strong>2.텔레포트</strong> 빠른 이동을 위한 텔레포트!</li>
									<li><strong>3.발전기</strong> 수트와 텔레포트를 가동시킬 전력장치</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_29.gif" alt="여자친구, 남자백성, 여자백성" />
							<div class="over green">
								<strong>박군 / 27 / 웹디자이너</strong>
								<ul>
									<li><strong>1.여자친구</strong> 나만의 나라를 만들거니깐 왕비가 필요!</li>
									<li><strong>2.남자백성</strong> 맛있는 요리를 해줄 남자 백성!</li>
									<li><strong>3.여자백성</strong> 집 지을 사람 필요! 남자백성1과 함께 할 여자</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_30.gif" alt="페이스북, 인스타그램, 로드무비" />
							<div class="over red">
								<strong>몽당몽당 / 27 / 디자이너</strong>
								<ul>
									<li><strong>1.페이스북</strong> </li>
									<li><strong>2.인스타그램</strong> </li>
									<li><strong>3.로드무비</strong> 낭만이 가득한 무인도의 푸른밤을 위해 필요한 3가지! 살어리 살어리랏다!  낭만이랑 전자파 먹고 무인도에 살어리랏다</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_31.gif" alt="봄이, 뚱이, 봄이와 뚱이의 사료" />
							<div class="over yellow">
								<strong>소현 / 27 / 웹 디자이너</strong>
								<ul>
									<li><strong>1.봄이</strong> </li>
									<li><strong>2.뚱이</strong> 봄이와 뚱이 (강아지)는 내 삶의 활력소 때와 장소를 가리지 않고 날 항상 웃게 해준다</li>
									<li><strong>3.봄이와 뚱이의 사료 </strong> 나를 웃게 해주는 착한 아이들의 사료 !</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_32.gif" alt="고양이, 마법의 양탄자, 초코케익" />
							<div class="over green">
								<strong>문보현 / 25 / 웹 디자이너</strong>
								<ul>
									<li><strong>1.고양이</strong> 걱정은 사라지고 안심할 수 있을 것 같다!</li>
									<li><strong>2.마법의 양탄자</strong> 보고싶은 남자친구와 가족을 보러 가끔 다녀올 것!</li>
									<li class="letter"><strong>3.초코케익</strong> 달달한 케익 한 조각처럼 단순한 행복을 마음껏!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_33.gif" alt="스노쿨링 장비, 암탉, 김병만" />
							<div class="over brown">
								<strong>여혜진 / 25 / VMD</strong>
								<ul>
									<li><strong>1.스노쿨링 장비</strong> 무인도 청정해안에서 스노쿨링을 즐기고 싶다.</li>
									<li><strong>2.암탉</strong> 암탉과 계란, 삶에 결핍된 영양소 채우기!</li>
									<li><strong>3.김병만</strong> 참 훌륭한 사람이다</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_34.gif" alt="라디오, 랜턴, 침낭" />
							<div class="over brown">
								<strong>R / 30 / 회사원</strong>
								<ul>
									<li class="letter"><strong>1.라디오</strong> 외로울테니까 사람 사는 이야기라도 들으려고!</li>
									<li><strong>2.랜턴</strong> 밤에는 무서우니깐 환하게!</li>
									<li><strong>3.침낭</strong> 아무것도 안하고 눈만 꿈뻑꿈뻑하고 쉬고 싶어서!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_35.gif" alt="오늘 처음 본 남자, 마법지팡이, 순간이동 리모콘" />
							<div class="over green">
								<strong>이유선 / 25 / MD</strong>
								<ul>
									<li><strong>1.오늘 처음 본 남자</strong> 예측불허! 아는 사람보단 모르는 사람! 여자보단 남자!</li>
									<li><strong>2.마법지팡이</strong> 먹고 싶은 게 너무 많아서 마법 지팡이</li>
									<li><strong>3.순간이동 리모콘</strong> 버튼 한 번이면 서울로 갈 수 있음!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_36.gif" alt="숫소, 암소, 남동생" />
							<div class="over brown">
								<strong>최희종 / 26 / 편집디자이너</strong>
								<ul>
									<li><strong>1.숫소</strong> </li>
									<li><strong>2.암소</strong> 숫소와 암소로 소떼를 만들고, 좋아하는 소고기, 치즈, 우유를 마음껏 먹는다</li>
									<li><strong>3.남동생</strong> 모든 잡다한 일은 군필자 남동생에게!</li>
								</ul>
							</div>
						</div>
					</div>

					<!-- slide4 -->
					<div class="people">
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_37.gif" alt="소지섭, 피아노, 고스톱" />
							<div class="over brown">
								<strong>익명 / 37 / 무직</strong>
								<ul>
									<li><strong>1.소지섭</strong> 애인을 데려가고 싶으니, 가장 적당한 사람!</li>
									<li><strong>2.피아노</strong> 세기에 기록될 작곡을 하여야 겠다. 로맨틱하기까지…</li>
									<li class="letter"><strong>3.고스톱</strong> 치매 예방에 좋기도 하고, 소지섭과 맞고 예정!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_38.gif" alt="텐바이텐, 바비큐 기계, 경비행기" />
							<div class="over red">
								<strong>winnie / 43 / 회사원</strong>
								<ul>
									<li><strong>1.텐바이텐</strong> 무인도에 회사건물과 직원을 통째로 옮기기!</li>
									<li><strong>2.바비큐 기계</strong> 고기를 준다고 해야 직원들이 움직이므로 &quot;필수&quot;</li>
									<li><strong>3.경비행기</strong> 섬이 답답하면 육지로 마실을 나가야 함!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_39.gif" alt="만화책 전권 15권, 망원경, 스케치북 &amp; 연필 지우개 SET" />
							<div class="over yellow">
								<strong>형동 / 32 / 마케터</strong>
								<ul>
									<li><strong>1.만화책 전권 (15권)</strong> 해변에서 누워서 만화책을 보고 싶어!</li>
									<li><strong>2.망원경</strong> 배 오는지도 보고, 별도 보고!</li>
									<li><strong>3.스케치북 &amp; 연필 지우개 SET</strong> 그림 일기를 쓰고 싶어서</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_40.gif" alt="노트북, 잭스페로우, 윌슨" />
							<div class="over green">
								<strong>이종화 / 34 / 웹프로그래머</strong>
								<ul>
									<li><strong>1.노트북</strong> 노트북이 있으면 모든 배송 OK</li>
									<li><strong>2.잭스페로우</strong> 심심하니 해적 이야기를 들려줄 사람이 필요!</li>
									<li><strong>3.윌슨</strong> 무인도니깐 톰행크스 케이스어웨이가 생각나서!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_41.gif" alt="천체망원경, 칼, 정수 여과기" />
							<div class="over red">
								<strong>자이언트 베이비 / 24 / 마케터</strong>
								<ul>
									<li><strong>1.천체망원경</strong> 누워서 무인도의 수많은 별을 보려고!</li>
									<li><strong>2.칼</strong> 먹을 때 그리고 돌에 글을 남길 수 있어서!</li>
									<li><strong>3.정수기</strong> 염분에 목숨을 잃을 수도 있겠다는 생각에 CHOICE!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_42.gif" alt="라디오, 파라솔, 돈데크만" />
							<div class="over green">
								<strong>Yu / 26 / 회사원</strong>
								<ul>
									<li><strong>1.라디오</strong> 2시의 컬투쇼를 들으며 한바탕 웃고 싶음</li>
									<li><strong>2.파라솔</strong> 파라솔 아래에서 탁 트인 바다를 눈에 담고 느끼기 위해</li>
									<li class="letter"><strong>3.돈데크만</strong> 나만의 아지트, 오랫동안 이곳을 시간탐험하려고</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_43.gif" alt="일기장, 기타, 전용기티켓" />
							<div class="over yellow">
								<strong>홍홍 / 26 / 개미</strong>
								<ul>
									<li><strong>1.일기장</strong> 나의 생존기를 기록해 나오자마자 책을 출간</li>
									<li><strong>2.기타</strong> 기타를 뚱땅 거리며 외로움과 무서움을 달래기 위해</li>
									<li><strong>3.전용기티켓</strong> 1년 후에 나를 데릴러 올 전용기 티켓</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_44.gif" alt="텐트, 성냥, 잭스페로우럼" />
							<div class="over red">
								<strong>이보리 / 32 / 회사원</strong>
								<ul>
									<li><strong>1.텐트</strong> 이 한 몸 비바람 피할 수 있는 텐트</li>
									<li><strong>2.성냥</strong> 식중독에 걸리지 않으려면 불은 필수!</li>
									<li><strong>3.잭스페로우럼</strong> 캐리비안의 해적 잭스페로우가 마시는 &apos;럼&apos;</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_45.gif" alt="1986배속암탉, 김병만, 요술램프지니" />
							<div class="over yellow">
								<strong>이지선 / 28 / MD</strong>
								<ul>
									<li><strong>1.1986배속암탉</strong> 아낌없이 주는 닭은 별별곳을 다 먹을 수 있음</li>
									<li><strong>2.김병만</strong> 생존 전문가! 어려움 해결! 말벗까지!</li>
									<li><strong>3.요술램프지니</strong> 소원은 딱 3개. 마지막 소원은 소원을 리필!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_46.gif" alt="나의 반려견 보리, 카메라, 도라에몽" />
							<div class="over red">
								<strong>100KAE / 25 / AMD</strong>
								<ul>
									<li><strong>1.나의 반려견 보리</strong> 나보다 나를 더 좋아해주는 반려견!</li>
									<li><strong>2.카메라</strong> 순수 그대로의 자연환경을 남기고 싶다</li>
									<li><strong>3.도라에몽</strong> 도라에몽의 무궁무진한 주머니만 있다면!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_47.gif" alt="고양이, 스마트폰, 물" />
							<div class="over green">
								<strong>횬서 / 29 / 고양이 집사</strong>
								<ul>
									<li><strong>1.고양이(히릿)</strong> 나를 엄마라고 생각하는 고양이와 함께 </li>
									<li><strong>2.스마트폰</strong> 세상과 나를 이어주는 연결고리</li>
									<li><strong>3.물</strong> 바닷물은 너무 짜니까</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_48.gif" alt="불, 고양이, 남자친구" />
							<div class="over brown">
								<strong>보헤미안 / 30 / MD</strong>
								<ul>
									<li><strong>1.불</strong> 음식을 먹어야 해서</li>
									<li><strong>2.고양이</strong> 외롭지 않을 것 같아서</li>
									<li><strong>3.남자친구</strong> 집을 짓거나,힘 쓸 사람이 필요해서</li>
								</ul>
							</div>
						</div>
					</div>

					<!-- slide5 -->
					<div class="people">
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_49.gif" alt="핸드폰, 만수르, 헬기" />
							<div class="over green">
								<strong>강준구 / 36 / 프로그래머</strong>
								<ul>
									<li><strong>1.핸드폰</strong> 일단 외부와 연락이 되어야 한다!</li>
									<li><strong>2.만수르</strong> 무인도를 궁전 또는 초호화 리조트로!</li>
									<li><strong>3.헬기</strong> 핸드폰이 안 터질 경우를 대비 헬기를 준비!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_50.gif" alt="스위스 나이프, Book, 비닐" />
							<div class="over red">
								<strong>파블로 로또리 / 33 / 탐험가</strong>
								<ul>
									<li><strong>1.스위스 나이프</strong> 사냥도구 필요함</li>
									<li><strong>2.무인도에서 살아남기 책</strong> 살기 위해서(부록 : 무인도 요리책)</li>
									<li><strong>3.비닐</strong> 비와 증류수를 얻기 위해서</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_51.gif" alt="왕곰돌이, 누룩, 공유" />
							<div class="over yellow">
								<strong>모화요 / 26 / MD</strong>
								<ul>
									<li><strong>1.왕곰돌이</strong> 나만의 윌이 필요!</li>
									<li><strong>2.누룩</strong> 맨 정신 NO !친환경 술을 제조!</li>
									<li><strong>3.공유</strong> 쓸쓸한 무인도! 공유와 공유!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_52.gif" alt="낚시대, 서바이벌키트, 드래곤볼" />
							<div class="over brown">
								<strong>원승현 / 34 / 회사원</strong>
								<ul>
									<li><strong>1.낚시대</strong> 먹고 살아야 함</li>
									<li><strong>2.서바이벌키트</strong> 역시 먹고 살아야 됨</li>
									<li><strong>3.드래곤볼</strong> 뭐든 들어주는 단 한가지의 소원</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_53.gif" alt="낚시대, 나이프, 태양열자동차" />
							<div class="over red">
								<strong>한용민 / 33 / 프로그래머</strong>
								<ul>
									<li><strong>1.낚시대</strong> 먹고 살기 위해서 물고기라도 잡아야….</li>
									<li><strong>2.나이프</strong> 물고기 손질, 나무라도 벨 수 있게 !</li>
									<li><strong>3.태양열자동차</strong> 심심하니 장난감이 필요함!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_54.gif" alt="7000PCS퍼즐, 체중계, 거위털이불" />
							<div class="over green">
								<strong>박민경 / 31 / 디자이너</strong>
								<ul>
									<li><strong>1.7000PCS퍼즐</strong> 한 두개씩 맞추면서 세월과 시간을!</li>
									<li><strong>2.체중계</strong> 미모의 여성 무인도에서 발견!</li>
									<li><strong>3.거위털이불</strong> 잠은 보약! 깔고 덮고 최고급 이불</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_55.gif" alt="비행기, 만수르, 여진구" />
							<div class="over brown">
								<strong>강희양 / 25 / 회사원</strong>
								<ul>
									<li><strong>1.비행기</strong> 무인도를 여행지로!</li>
									<li><strong>2.만수르</strong> 편한 무인도 여행을 할 수 있도록</li>
									<li><strong>3.여진구</strong> 외로우니 보고만 있어도 좋을 것!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_56.gif" alt="우리집 귀요미 슈, 남친, 엄마" />
							<div class="over brown">
								<strong>강혜정 / 안알랴줌 / 디자이너</strong>
								<ul>
									<li><strong>1.우리집 귀요미 슈</strong> 서로 없으면 안되기 때문에!</li>
									<li><strong>2.남친</strong> 무인도를 로맨틱 아일랜드로 만들어 줄 사람!</li>
									<li><strong>3.엄마</strong> 내가 무인도에 가면 가장 걱정할 테니까!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_57.gif" alt="김전일, 코난, 그리고 범인" />
							<div class="over green">
								<strong>킴주희 / 이팔청춘 / 디자이너</strong>
								<ul>
									<li><strong>1.김전일</strong> </li>
									<li><strong>2.코난</strong> </li>
									<li><strong>3.그리고 범인</strong> 사상 최대의 최고의 SHOW 소년 탐정 둘과 범인1 그리고 나 쫒고 쫒기는 추리전을 찍어야지 2014 블록버스터 스릴러작!커밍순!</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_58.gif" alt="아빠, 김여사, 언니들" />
							<div class="over brown">
								<strong>쪼쪼 / 28 / 회사원</strong>
								<ul>
									<li><strong>1.아빠</strong> 김병만 버금가는 맥가이버.</li>
									<li><strong>2.김여사</strong> 아빠의 삶의 낙! 보너스로 함께</li>
									<li><strong>3.언니들</strong> 없다면 내 삶이 즐겁지 않을 것</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_59.gif" alt="남자친구, 핸드폰, 야식집책자" />
							<div class="over yellow">
								<strong class="letter">팬 지오디님 / 방년 26세! / 비밀</strong>
								<ul>
									<li><strong>1.남자친구</strong> 심심! 사랑은 하고 살아야 하니까!</li>
									<li><strong>2.핸드폰</strong> 세상 돌아가는 건 알아야 하니깐!</li>
									<li><strong>3.야식집 책자</strong> 식욕은 없어지지 않을거니까</li>
								</ul>
							</div>
						</div>
						<div class="inbag">
							<img src="http://webimage.10x10.co.kr/play/ground/20140811/img_in_bag_60.gif" alt="지팡이, 가방, 소중한 사람" />
							<div class="over red">
								<strong>김도희 / 30 / 텐바이텐 점장님</strong>
								<ul>
									<li><strong>1.해리포터의 지팡이</strong> 근처의 물건(필요에 의한) 소환 가능</li>
									<li><strong>2.헤르미온느 가방</strong> 텐트, 옷 등 크기와 상관없이 모두 담을 수 있음</li>
									<li class="letter"><strong>3.가장 소중한 사람</strong> 만날 수 없었던 가장 이상적인 좋아하는 사람!</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="comment" class="section sectionC">
			<div class="group">
				<div class="part partA">
					<div class="desc">
						<h4><img src="http://webimage.10x10.co.kr/play/ground/20140811/tit_commnet_event.gif" alt="코멘트 이벤트" /></h3>
						<p><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_put_three_items.gif" alt="무인도로 가는 가방에 넣을 세 가지를 담아 보세요!" /></p>
						<p><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_gift_bag.gif" alt="재치 있는 답변을 남겨주신 3분을 추첨해 지구를 한 바퀴 도는 여행을 위한 어스백(랜덤)을 선물로 드립니다." /></p>
						<div class="btnGo"><a href="/shopping/category_prd.asp?itemid=374734" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140811/img_gift_bag.gif" alt="어스백 상품 보러가기" /></a></div>
					</div>

					<div class="item">
						<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
						<input type="hidden" name="eventid" value="<%=eCode%>">
						<input type="hidden" name="bidx" value="<%=bidx%>">
						<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
						<input type="hidden" name="iCTot" value="">
						<input type="hidden" name="mode" value="add">
						<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
						<input type="hidden" name="spoint" value="<%=rencolor%>">
							<fieldset>
							<legend>가방에 넣을 세가지 아이템 작성하기</legend>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_wirte_tenwords.gif" alt="※ 각각 10자 이내로 작성해 주세요 :)" /></p>
								<label for="putitem01"><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_num_01.gif" alt="첫번째 아이템 입력" /></label>
								<input type="text" id="putitem01" maxlength="10" class="iText" name="qtext1" value="" onClick="jsChklogin11('<%=IsUserLoginOK%>');"/>
								<label for="putitem02"><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_num_02.gif" alt="두번째 아이템 입력" /></label>
								<input type="text" id="putitem02" maxlength="10" class="iText" name="qtext2" value="" onClick="jsChklogin22('<%=IsUserLoginOK%>');"/>
								<label for="putitem03"><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_num_03.gif" alt="세번째 아이템 입력" /></label>
								<input type="text" id="putitem03" maxlength="10" class="iText" name="qtext3" value="" onClick="jsChklogin33('<%=IsUserLoginOK%>');"/>
								<div class="btnSubmit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20140811/btn_submit.gif" alt="가방에 담기" /></div>
							</fieldset>
						</form>
						<form name="frmdelcom" method="post" action="doEventSubscript54127.asp" style="margin:0px;">
						<input type="hidden" name="eventid" value="<%=eCode%>">
						<input type="hidden" name="bidx" value="<%=bidx%>">
						<input type="hidden" name="Cidx" value="">
						<input type="hidden" name="mode" value="del">
						<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
						</form>
					</div>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140811/txt_date.gif" alt="이벤트 기간은 2014년 8월 11일부터 17일까지이며, 당첨자 발표는 2014년 8월 19일 입니다." /></p>
				</div>
				
				<% IF isArray(arrCList) THEN %>
				<div class="part partB">
					<div class="bagList">
						<% 
							Dim opt1 , opt2 , opt3
							For intCLoop = 0 To UBound(arrCList,2)

							If arrCList(1,intCLoop) <> "" then
								opt1 = SplitValue(arrCList(1,intCLoop),"//",0)
								opt2 = SplitValue(arrCList(1,intCLoop),"//",1)
								opt3 = SplitValue(arrCList(1,intCLoop),"//",2)
							End If 
						%>
						<div class="bag bag<%=arrCList(3,intCLoop)%>">
							<ul>
								<li><%=opt1%></li>
								<li><%=opt2%></li>
								<li><%=opt3%></li>
							</ul>
							<div class="writer"><% If arrCList(8,intCLoop) = "M"  then%><img src="http://webimage.10x10.co.kr/play/ground/20140811/ico_mobile.gif" alt="모바일에서 작성" /><% End If %><span><%=printUserId(arrCList(2,intCLoop),2,"*")%></span>님 <span>No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span></div>
							<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
							<button type="button" class="btnDel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;">삭제</button>
							<% end if %>
						</div>
						<% Next %>
					</div>
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				</div>
				<% End If %>
			</div>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->