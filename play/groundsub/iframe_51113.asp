<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'#### 2014-04-10 이종화 작성 play_sub ###################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21139
Else
	eCode   =  51113
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

	iCPageSize = 8		'한 페이지의 보여지는 열의 수
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

%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
img {vertical-align:top;}
.playGr20140414 {width:100%;}
.campingFestival {position:relative; height:2028px; background-color:#ddf5fb;}
.campingFestival .intro {position:relative; z-index:10; width:1140px; margin:0 auto; text-align:center;}
.campingFestival .intro h3 {padding-top:95px;}
.campingFestival .section {width:987px; height:740px; margin:60px auto 0; padding-top:70px; background:url(http://webimage.10x10.co.kr/play/ground/20140414/bg_box_01.png) left top no-repeat;}
.campingFestival .section .service {padding:70px 0 100px;}
.campingFestival .bgCamping {position:absolute; left:0; bottom:0; width:100%; z-index:5;}
.campingFestival .bgCamping img {width:100%; height:2028px;}
.campingFestival .brandSponsor {position:relative; z-index:50; width:985px; height:404px; margin:40px auto 0; padding-top:110px; background:url(http://webimage.10x10.co.kr/play/ground/20140414/bg_box_02.png) left top no-repeat; text-align:center;}
.campingFestival .brandSponsor p {padding-top:30px;}
.campingFestival .navigator {overflow:hidden; position:relative; z-index:50; width:786px; margin:30px auto 0;}
.campingFestival .navigator li {float:left; padding:0 59px;}

.aroundCampingFestival {width:100%; padding-bottom:160px; background:#f5f5f5 url(http://webimage.10x10.co.kr/play/ground/20140414/bg_wave.png) left bottom repeat-x; text-align:center;}
.aroundCampingFestival .bgPattern {padding-top:158px; background:#f5f5f5 url(http://webimage.10x10.co.kr/play/ground/20140414/bg_pattern.png) left top no-repeat;}
.aroundCampingFestival h3 {padding-bottom:90px;}
.aroundCampingFestival .intro {width:92%; min-width:1140px; margin:0 auto;}
.aroundCampingFestival .intro .section .row {overflow:hidden; width:100%; background-color:#fff;}
.aroundCampingFestival .intro .section .row .col {float:left; width:50%; *width:49%; min-height:300px;}
.aroundCampingFestival .intro .section .row .col .video {overflow:hidden; position:relative; height:0; padding-bottom:56.25%; background:#000;}
.aroundCampingFestival .intro .section .row .col .video iframe {position:absolute; top:0; left:0; width:100%; height:100%;}
.aroundCampingFestival .intro .section .row .col.enjoy p {padding-top:15%;}
.aroundCampingFestival .intro .section .row .col.enjoy .btnWrap {padding:5% 0 0;}
.aroundCampingFestival .intro .section .row .col.enjoy .btnWrap a {padding:0 15px;}
.aroundCampingFestival .intro .section .row .col.schedule p {padding-top:10%;}
.aroundCampingFestival .intro .section .row .col.musician p {padding-top:20%}

.slide {position:relative;}
.slide .slidesjs-container {}
.slide .slidesjs-slide img {width:100%;}
.slide .slidesjs-navigation {display:block; position:absolute; top:50%; z-index:200; width:23px; height:53px; margin-top:-26px; text-indent:-999em;}
.slide .slidesjs-previous {left:20px; background:url(http://webimage.10x10.co.kr/play/ground/20140414/btn_navigation.png) left top no-repeat;}
.slide .slidesjs-next {right:20px; background:url(http://webimage.10x10.co.kr/play/ground/20140414/btn_navigation.png) right top no-repeat;}

.commentEventWrap {position:relative; width:100%; height:1076px;}
.commentEventWrap .bgSky {position:absolute; left:0; bottom:0; width:100%; z-index:5;}
.commentEventWrap .bgSky img {width:100%; height:1076px;}
.commentEvent {position:relative; z-index:50; background:url(http://webimage.10x10.co.kr/play/ground/20140414/bg_hot_air_balloon.png) center 100px no-repeat;}
.commentEvent .section {width:1140px; margin:0 auto; text-align:center;}
.commentEvent .section h4 {padding-top:120px;}
.commentEvent .section p {padding-top:50px;}
.commentEvent .section .campingNote {overflow:hidden; width:1053px; height:121px; margin:60px 0 0 20px; background:url(http://webimage.10x10.co.kr/play/ground/20140414/txt_camping_note.png) left top no-repeat;}
.commentEvent .section .campingNote ul {text-indent:-999em;}
.commentEvent .commentField {position:relative; margin:58px 0 0 7px; padding:32px 44px 28px 663px; border:5px solid #ffc400; background-color:#fafeff; text-align:left;}
.commentEvent .commentField ul {overflow:hidden; position:absolute; left:35px; top:40px; margin-left:-24px; text-align:center;}
.commentEvent .commentField ul li {float:left; padding-left:24px;}
.commentEvent .commentField ul li label {display:block; margin-bottom:9px;}
.commentEvent .commentField p {padding-top:0;}
.commentEvent .commentField textarea {width:381px; height:90px; margin-top:18px; padding:15px; border:1px solid #e9e9e9; background-color:#f4f4f4; color:#333; font-size:12px;}
.commentEvent .etiquette {margin-top:10px; padding-left:13px; text-align:left;}
.commentEvent .etiquette li {margin-top:2px; padding-left:10px; background:url(http://webimage.10x10.co.kr/play/ground/20140414/blt_arrow.png) left 5px no-repeat; font-size:11px; font-family:Dotum;}
.commentEvent .btnSubmit {margin-top:60px;}
.commentEventList {overflow:hidden; width:1152px; margin:0 auto; padding:40px 0;}
.commentEventList .commnentArtcle {float:left; position:relative; width:230px; height:364px; margin:25px 25px 0 0; padding:20px 17px 0 16px; font-size:11px; font-family:Dotum;}
.commentEventList .commnentArtcle .description {margin-top:170px; height:90px; padding:20px 14px; background-color:#fff; color:#333; line-height:1.875em;}
.commentEventList .commnentArtcle .date span {color:#b2aba5; font-size:9px; padding-right:4px;}
.commentEventList .commnentArtcle .num {overflow:hidden;}
.commentEventList .commnentArtcle .num .icoMobile {float:left; display:block; width:15px; height:15px; text-indent:-999em;}
.commentEventList .commnentArtcle .num strong {float:left; padding-top:2px;}
.commentEventList .commnentArtcle .date {margin-top:17px; text-align:right;}
.commentEventList .commnentArtcle .btnDelete {position:absolute; right:9px; top:11px; width:9px; height:9px; background:url(http://webimage.10x10.co.kr/play/ground/20140414/btn_delete.png) left top no-repeat; text-indent:-999em;}
.commentEventList .commnentArtcle.bg01 {background:url(http://webimage.10x10.co.kr/play/ground/20140414/bg_comment_01.gif) left top no-repeat;}
.commentEventList .commnentArtcle.bg01 .num {color:#896e59;}
.commentEventList .commnentArtcle.bg01 .num .icoMobile {background:url(http://webimage.10x10.co.kr/play/ground/20140414/ico_mobile_01.png) left top no-repeat;}
.commentEventList .commnentArtcle.bg01 .date {color:#9c826e;}
.commentEventList .commnentArtcle.bg02 {background:url(http://webimage.10x10.co.kr/play/ground/20140414/bg_comment_02.gif) left top no-repeat;}
.commentEventList .commnentArtcle.bg02 .num {color:#81adad;}
.commentEventList .commnentArtcle.bg02 .num .icoMobile {background:url(http://webimage.10x10.co.kr/play/ground/20140414/ico_mobile_02.png) left top no-repeat;}
.commentEventList .commnentArtcle.bg02 .date {color:#81adad;}
.commentEventList .commnentArtcle.bg03 {background:url(http://webimage.10x10.co.kr/play/ground/20140414/bg_comment_03.gif) left top no-repeat;}
.commentEventList .commnentArtcle.bg03 .num {color:#899b7a;}
.commentEventList .commnentArtcle.bg03 .num .icoMobile {background:url(http://webimage.10x10.co.kr/play/ground/20140414/ico_mobile_03.png) left top no-repeat;}
.commentEventList .commnentArtcle.bg03 .date {color:#899b7a;}
.commentEventList .commnentArtcle.bg04 {background:url(http://webimage.10x10.co.kr/play/ground/20140414/bg_comment_04.gif) left top no-repeat;}
.commentEventList .commnentArtcle.bg04 .num {color:#b08aa1;}
.commentEventList .commnentArtcle.bg04 .num .icoMobile {background:url(http://webimage.10x10.co.kr/play/ground/20140414/ico_mobile_04.png) left top no-repeat;}
.commentEventList .commnentArtcle.bg04 .date {color:#b08aa1;}

.pageWrapV15 {width:1140px; margin:0 auto;}
</style>
<script type="text/javascript" src="http://www.10x10.co.kr/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	// Label Select
	$(".commentField label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});

	$(".navigator li a").mouseover(function(){
		var imgRollover = $(this).find("img").attr("src").replace("_off.png", "_on.png");
		$(this).find("img").attr("src", imgRollover);
	});

	$(".navigator li a").mouseleave(function(){
		var imgRollover = $(this).find("img").attr("src").replace("_on.png", "_off.png");
		$(this).find("img").attr("src", imgRollover);
	});

	// Go to Tab
	$(".navigator li.move a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});

	$('#slides').slidesjs({
		width:795,
		height:470,
		navigation: {effect: "fade"},
		pagination:false,
		play: {interval:3000, effect: "fade", auto: true, swap: false},
		effect: {fade: {speed:1500,crossfade: true}}
	});
	$('#slides02').slidesjs({
		width:795,
		height:450,
		navigation: {effect: "fade"},
		pagination:false,
		play: {interval:3000, effect: "fade", auto: true, swap: false},
		effect: {fade: {speed:1500,crossfade: true}}
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

	   
	   if(!(frm.spoint[0].checked||frm.spoint[1].checked||frm.spoint[2].checked||frm.spoint[3].checked)){
	    alert("텐트를 선택 해주세요");
	    return false;
	   }

	    if(!frm.txtcomm.value || frm.txtcomm.value == "100자 이내로 입력해주세요."){
	    alert("100자 이내로 입력해주세요.");
		document.frmcom.txtcomm.value="";
	    frm.txtcomm.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.txtcomm.value)>100){
			alert('100자 까지 가능합니다.');
	    frm.txtcomm.focus();
	    return false;
		}

	   frm.action = "/event/lib/comment_process.asp";
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
			if(document.frmcom.txtcomm.value == "100자 이내로 입력해주세요." ){
				document.frmcom.txtcomm.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChkUnblur()
	{
		if(document.frmcom.txtcomm.value ==""){
			document.frmcom.txtcomm.value = "100자 이내로 입력해주세요."
		}
	}

	function Limit(obj)
	{
	   var maxLength = parseInt(obj.getAttribute("maxlength"));
	   if ( obj.value.length > maxLength ) {
		alert("글자수는 100자 이내로 제한됩니다.");
		obj.value = obj.value.substring(0,maxLength); //100자 이하 튕기기
		}
	}

//-->
</script>
<div class="playGr20140414">
	<div class="sensibilityCamping">
		<div class="campingFestival">
			<div class="intro">
				<h3><img src="http://webimage.10x10.co.kr/play/ground/20140414/tit_camping_festival.png" alt="10X10 AROUND CAMPING FESTIVAL" /></h3>
				<div class="section">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140414/txt_camping.png" alt="캠핑! 가볍게 즐기고 싶나요? 텐바이텐과 어라운드가 만나 짐 없이 떠나는 감성 캠핑을 준비했어요!" /></p>
					<p class="service"><img src="http://webimage.10x10.co.kr/play/ground/20140414/txt_sensibility_camping.png" alt="텐바이텐이 준비한 짐 없이 떠나는 감성 캠핑! 1박 2일간 디자인 텐트 및 취사 도구, 소품 제공 + 어라운드 캠핑 프로그램 체험과 텐바이텐의 특별 사진 촬영 서비스 + 텐바이텐 스페셜 기프트 제공" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140414/txt_camping_msg.png" alt="짧아진 봄을 느끼기 위해 하루를 온전히 써 본적이 있나요? 초록의 기운을 즐기기 좋은 5월, AROUND와 텐바이텐의 PLAY가 만나 특별한 선물을 준비했답니다. 캠핑은 너무 해보고 싶지만 장비가 없어서 혹은 여유가 없어서 하지 못했던 분들을 위해 ’짐 없이 떠나는 감성 캠핑’에 초대합니다. 1박 2일 동안 디자인 텐트에서 잠들고, 모닥불 앞에서 잔잔한 공연을 들으며 꿈꿔왔던 캠핑의 낭만을 마음껏 펼치세요! 낯선 곳에서의 하룻밤은 우리에게 봄을 좀 더 선명하게, 아늑하게 할 거에요." /></p>
				</div>
			</div>

			<div class="brandSponsor" id="moveBrandSponsor">
				<h4><img src="http://webimage.10x10.co.kr/play/ground/20140414/tit_brand_sponsor.gif" alt="BRAND SPONSOR" /></h4>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140414/img_brand_sponsor.gif" alt="" usemap="#brandLink" /></p>
				<map name="brandLink" id="brandLink">
					<area shape="rect" coords="14,21,97,63" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=FIELDCANDY" target="_blank" title="새창" alt="LITTLE CAMPERS" />
					<area shape="rect" coords="148,20,242,60" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=coleman01" target="_blank" title="새창" alt="콜맨 coleman" />
					<area shape="rect" coords="299,10,393,69" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=anorak" target="_blank" title="새창" alt="아노락 anorak" />
					<area shape="rect" coords="440,20,553,60" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=THEMONSTERFACTORY" target="_blank" title="새창" alt="더몬스터팩토리 THEMONSTERFACTORY " />
					<area shape="rect" coords="589,21,703,60" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=extremo" target="_blank" title="새창" alt="아웃웰 OUTWELL" />
					<area shape="rect" coords="742,-1,830,77" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=urbanforest01" target="_blank" title="새창" alt="어반포레스트 urbanforest" />
					<area shape="rect" coords="8,95,87,169" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=jda2010" target="_blank" title="새창" alt="미니멀웍스" />
					<area shape="rect" coords="153,88,230,169" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=nudeaudio" target="_blank" title="새창" alt="누드오디오 nudeaudio" />
					<area shape="rect" coords="289,98,398,160" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=snowline" target="_blank" title="새창" alt="스노우 라인 snowline" />
					<area shape="rect" coords="462,96,533,170" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=alite" target="_blank" title="새창" alt="얼라이트 alite" />
					<!--area shape="rect" coords="607,91,690,175" href="" target="_blank" title="새창" alt="코오롱 x 스티키몬스터랩 KOLON X Sticky Monster Lab" /-->
					<area shape="rect" coords="745,108,836,156" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=instax" target="_blank" title="새창" alt="인스탁스 instax" />
					<area shape="rect" coords="5,200,89,256" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=MiiR" target="_blank" title="새창" alt="MiiR BOTTLES" />
					<area shape="rect" coords="116,202,239,253" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=BLUERIDGECHAIRWORKS" target="_blank" title="새창" alt="블루릿지체어 BLUE RIDGE CHAIR WORKS" />
					<area shape="rect" coords="271,202,335,262" href="/street/street_brand_sub06.asp?makerid=gravel01" target="_blank" title="새창" alt="그라벨 링크" />
					<area shape="rect" coords="376,197,471,261" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=ridgeline" target="_blank" title="새창" alt="RIDGE LINE" />
					<area shape="rect" coords="516,196,584,260" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=kupilka" target="_blank" title="새창" alt="KUPILKA" />
					<area shape="rect" coords="628,195,720,263" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=fuzzybrush" target="_blank" title="새창" alt="Fuzzy Brush" />
					<area shape="rect" coords="757,187,831,266" href="http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=kekki" target="_blank" title="새창" alt="Nordic Island" />
				</map>
			</div>

			<ul class="navigator">
				<li class="move"><a href="#moveCommentEvent"><img src="http://webimage.10x10.co.kr/play/ground/20140414/tab_01_off.png" alt="감성쇼핑 응모하기" /></a></li>
				<li><a href="/event/eventmain.asp?eventid=50814" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140414/tab_02_off.png" alt="참여 브랜드 기획전" /></a></li>
				<li><a href="/event/eventmain.asp?eventid=51140" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140414/tab_03_off.png" alt="티켓 구매하러 가기" /></a></li>
			</ul>
			<div class="bgCamping"><img src="http://webimage.10x10.co.kr/play/ground/20140414/bg_camping.jpg" alt="" /></div>
		</div>

		<div class="aroundCampingFestival">
			<div class="bgPattern">
				<h3><img src="http://webimage.10x10.co.kr/play/ground/20140414/tit_around_camping_festival.png" alt="AROUND CAMPING FESTIVAL" /></h3>
				<div class="intro">
					<div class="section">
						<div class="row">
							<div class="col">
								<div class="video">
									<iframe src="//player.vimeo.com/video/86954191" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen="" title="어라운드 캠핑 페스티발 동영상"></iframe>
								</div>
							</div>
							<div class="col enjoy">
								<p><img src="http://webimage.10x10.co.kr/play/ground/20140414/txt_enjoy_around.gif" alt="어라운드의 두 번째 축제가 열립니다. 친구와 연인 뿐만 아니라 아이들, 어른들이 함께 즐길 수 있는 캠핑 축제에요. 조금은 조용하게, 모두의 함성보다는 여기저기서 끊이지 않는 작은 대화와 웃음들로 채워갑니다. 운동화와 체크남방을 챙겨오세요. 아주 긴 하루 동안의 축제를 편안하게 즐기길 원합니다." /></p>
								<div class="btnWrap">
									<a href="http://www.aroundfestival.com/" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140414/btn_around_camping_festival.gif" alt="어라운드 캠핑 페스티벌" /></a>
									<a href="/street/street_brand_sub06.asp?makerid=connectdesign" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140414/btn_around.gif" alt="AROUND 보러가기" /></a>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col schedule">
								<p><img src="http://webimage.10x10.co.kr/play/ground/20140414/txt_schedule.gif" alt="SCHEDULE : SAT 5.3 우쿨렐레 교실 / 훌라 춤 배우기 / 해먹 체험장 / 방방 퐁퐁 / 작은 물놀이 / 장작패기 대결 / 미니 운동회 버스킹 공연 / 모닥불 공연 / 심야극장 SUN 5.4 아침을 깨우는 체조 / 향초만들기 / 아이들과 그림그리기 / 드림 캐쳐 만들기 / 텐트 갈란드 만들기 프레임 리스 만들기 / 플라워 카드 만들기 / 자수 티 코스터 만들기 / 데코 선반 만들기 / 원목접시 트랙 만들기 번팅 만들기 / 자수액자 만들기 / 플라워 책갈피 만들기 / 하디 와인 클래스 / 우쿨렐레 교실 / 우쿨렐레 교실 훌라 춤 배우기 / 해먹 체험장 / 방방 퐁퐁 / 작은 물놀이 / 장작패기 대결 / 미니 운동회 / 버스킹 공연 무대공연 / 모닥불공연 / 심야극장" /></p>
							</div>
							<div class="col">
								<div class="slide" id="slides">
									<div><img src="http://webimage.10x10.co.kr/play/ground/20140414/img_slide_01_01.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/play/ground/20140414/img_slide_01_02.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/play/ground/20140414/img_slide_01_03.jpg" alt="" /></div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<div class="slide" id="slides02">
									<div><img src="http://webimage.10x10.co.kr/play/ground/20140414/img_slide_02_01.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/play/ground/20140414/img_slide_02_02.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/play/ground/20140414/img_slide_02_03.jpg" alt="" /></div>
								</div>
							</div>
							<div class="col musician">
								<p><img src="http://webimage.10x10.co.kr/play/ground/20140414/txt_musician.gif" alt="MUSICIAN : 킹스턴 루디스카 / 타틀즈 / 윤영배 / 허니와 샘 / 리틀앤 더스로리안 / 5학년 1학기 / D9 / 물거품프로젝트" /></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Comment -->
		<div class="commentEventWrap" id="moveCommentEvent" >
			<div class="commentEvent">
				<div class="section">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20140414/tit_comment_event.png" alt="COMMENT EVENT" /></h4>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140414/txt_comment_event.png" alt="텐바이텐과 함께 감성캠핑을 떠나요! 응모해주신 분들 중 총 5팀을 선발하여, 감성 캠핑 1박 2일권을 보내드립니다." /></p>
					<div class="campingNote">
						<ul>
							<li>장소 : 양평 서종 문화 공원</li>
							<li>일자 : 2014.05.03 ~ 05.05</li>
							<li>응모 기간 : 2014.04.14 ~ 04.23 (10일간)</li>
							<li>당첨자 발표 : 2014.04.24(목요일)</li>
							<li>응모 방법 : 텐바이텐 웹 / 모바일 사이트 혹은 페이스 북 참여하기를 누르고 친구를 초대해 응모!</li>
							<li>참여 혜택 : 총 5팀을 선발 (동반 1인 포함) 1) 1박 2일간 디자인텐트 및 취사 도구.소품 제공, 2) 어라운드의 캠핑 프로그램 체험 + 텐바이텐의 특별 사진 촬영서비스, 3) 캠핑 사은품 스페셜 기프트 제공 ※단, 음식 및 세면도구는 개별 지참</li>
						</ul>
					</div>

					<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>">
					<input type="hidden" name="bidx" value="<%=bidx%>">
					<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
					<input type="hidden" name="iCTot" value="">
					<input type="hidden" name="mode" value="add">
					<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
					<fieldset>
						<legend>캠핑 가고 싶은 사람과 이유 작성하기</legend>
						<div class="commentField">
							<ul>
								<li>
									<label for="selectTent01"><img src="http://webimage.10x10.co.kr/play/ground/20140414/ico_tent_01.gif" alt="핑크 텐트" /></label>
									<input type="radio" id="selectTent01" name="spoint" value="1"/>
								</li>
								<li>
									<label for="selectTent02"><img src="http://webimage.10x10.co.kr/play/ground/20140414/ico_tent_02.gif" alt="땡땡이 텐트" /></label>
									<input type="radio" id="selectTent02" name="spoint" value="2"/>
								</li>
								<li>
									<label for="selectTent03"><img src="http://webimage.10x10.co.kr/play/ground/20140414/ico_tent_03.gif" alt="초록 텐트" /></label>
									<input type="radio" id="selectTent03" name="spoint" value="3"/>
								</li>
								<li>
									<label for="selectTent04"><img src="http://webimage.10x10.co.kr/play/ground/20140414/ico_tent_04.gif" alt="보라 텐트" /></label>
									<input type="radio" id="selectTent04" name="spoint" value="4"/>
								</li>
							</ul>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20140414/txt_select_tent.gif" alt="당신이 꿈꾸는 텐트를 선택하고, 함께 가고 싶은 사람과 그 이유를 적어 응모해주세요!" /></p>
							<textarea title="캠핑 가고 싶은 사람과 이유 입력" cols="60" rows="5" id="writearea" name="txtcomm" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur()" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');return Limit(this);" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%> autocomplete="off" maxlength="100">100자 이내로 입력해주세요.</textarea>
						</div>

						<ul class="etiquette">
							<li>ID당 1개의 코멘트를 남길 수 있습니다.</li>
							<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며 이벤트 참여에 제한을 받을 수 있습니다.</li>
						</ul>
						<div class="btnSubmit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20140414/btn_submit.png" alt="감성캠핑 응모하기" /></div>
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
			<div class="bgSky"><img src="http://webimage.10x10.co.kr/play/ground/20140414/bg_sky.gif" alt="" /></div>
		</div>
		<% IF isArray(arrCList) THEN %>
		<div class="commentEventList">
			<% For intCLoop = 0 To UBound(arrCList,2) %>
			<div class="commnentArtcle bg0<%=arrCList(3,intCLoop)%>">
				<div class="num">
					<% If arrCList(8,intCLoop) = "M"  then%>
					<span class="icoMobile">모바일에서 작성</span>
					<% End If %>
					<strong>no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></strong>
				</div>
				<p class="description"><%=nl2br(arrCList(1,intCLoop))%></p>
				<div class="date"><strong><%=printUserId(arrCList(2,intCLoop),2,"*")%></strong> <span>|</span><%=formatdate(arrCList(4,intCLoop),"0000.00.00")%></div>
				<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
				<button type="button" class="btnDelete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>')"><span>삭제</span></button>
				<% end if %>
			</div>
			<% Next %>
		</div>
		<% End If %>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
		<!-- //Comment -->
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->