<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  2015 텐바이텐X 멜로디 포레스트캠프 공식굿즈 런칭
' History : 2015.09.01 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim getnowdate, eCode, userid, sub_idx, i, intCLoop, subscriptcount, leaficonimg
dim iCPerCnt, iCPageSize, iCCurrpage
dim ename, emimg, blnitempriceyn
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  64873
	Else
		eCode   =  65806
	End If

	getnowdate = date()

	userid = GetEncLoginUserID()
	subscriptcount=0
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
	
IF iCCurrpage = "" THEN iCCurrpage = 1
iCPageSize = 6
iCPerCnt = 10		'보여지는 페이지 간격

dim cEvent
	set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode	
	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
	blnitempriceyn = cEvent.FItempriceYN	

	set cEvent = nothing

dim ccomment
set ccomment = new Cevent_etc_common_list
	ccomment.FPageSize        = iCPageSize
	ccomment.FCurrpage        = iCCurrpage
	ccomment.FScrollCount     = iCPerCnt
	ccomment.event_subscript_one
	ccomment.frectordertype="new"
	ccomment.frectevt_code    = eCode
	ccomment.event_subscript_paging
		
%>
<style type="text/css">
.contF {background-color:#fff !important;}
img {vertical-align:top;}
.evt65806 {background-color:#fff;}
.topic {position:relative; min-height:1450px; background:#ece0c8 url(http://webimage.10x10.co.kr/eventIMG/2015/65806/bg_music.jpg) no-repeat 50% 0;}
.topic .hgroup {height:510px;}
.topic h2 {position:absolute; top:92px; left:50%; width:1061px; height:252px; margin-left:-530px;}
.topic h2 span {position:absolute; width:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65806/tit_melody_forest.png) no-repeat 50% 0; text-indent:-999em;}
.topic h2 .letter1 {top:0; left:0; height:38px;}
.topic h2 .letter2 {top:95px; left:0; height:64px; background-position:0 -95px;}
.topic h2 .letter3 {top:195px; left:0; height:55px; background-position:0 -195px;}
.topic .story {position:absolute; top:369px; left:50%; width:1061px; height:49px; margin-left:-530px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65806/tit_melody_forest.png) no-repeat 50% 100%; text-indent:-999em;}
.topic .option {position:absolute; top:25px; left:50%; width:1140px; margin-left:-570px; text-align:right;}
.topic .option a {margin-right:9px;}

.artist {position:relative; padding-bottom:459px;}
.artist .navigator {position:absolute; bottom:0; left:50%; width:1453px; height:440px; margin-left:-726px;}
.artist .navigator ul li {position:absolute;}
.artist .navigator ul li.artist01 {top:50px; left:0;}
.artist .navigator ul li.artist02 {bottom:0; left:292px;}
.artist .navigator ul li.artist03 {top:50px; left:447px;}
.artist .navigator ul li.artist04 {top:30px; left:875px;}
.artist .navigator ul li.artist05 {bottom:0; right:0;}
.artist .moive {position:relative; width:1112px; height:482px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65806/bg_box.png) no-repeat 50% 0; text-align:left;}
.artist .moive .video {position:absolute; top:64px; left:64px;}
.artist .moive .desc {padding-top:64px; padding-left:595px;}
.artist .moive .desc p {margin-bottom:56px;}
.artist .moive .desc .btnHomepage {margin-left:7px;}
.artist .moive .desc .deco {position:absolute; top:316px; right:76px; width:115px; height:78px;}
.artist .moive .desc .deco .star {position:absolute; top:0; left:0;}
.artist .moive .desc .deco .tent {position:absolute; top:43px; left:22px;}

/* FadeIn animation */
@-webkit-keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}
.twinkle {animation-name:twinkle; -webkit-animation-name:twinkle; animation-iteration-count:infinite;  -webkit-animation-iteration-count:infinite; animation-duration:2s; -webkit-animation-duration:2s; animation-fill-mode:both;-webkit-animation-fill-mode:both;}


.officalMd {height:1460px; background:#3c4161 url(http://webimage.10x10.co.kr/eventIMG/2015/65806/bg_shine_v1.jpg) no-repeat 50% 0;}
.officalMd h3 {margin-bottom:70px; padding-top:128px;}

.commentevt .field {height:605px; background:#eee1d0 url(http://webimage.10x10.co.kr/eventIMG/2015/65806/bg_song_v1.png) no-repeat 50% 0;}
.commentevt .field .form {position:relative; width:1140px; height:460px; margin:0 auto; text-align:left;}
.commentevt .field .form h3 {margin-left:40px; padding-top:38px;}
.commentevt .field .form textarea {width:718px; height:118px; margin-top:-20px; margin-left:60px; padding:20px; border:1px solid #d0bfa8; color:#999; font-size:12px;}
.commentevt .field .form .btnsubmit {position:absolute; top:233px; right:132px;}

.commentevt .field .sns {margin-left:-1px;}

.commentlistWrap {width:1140px; margin:0 auto; padding-top:80px;}
.commentlist {position:relative; width:1140px;}
.commentlist:after {content:' '; display:block; clear:both;}
.commentlist .line {position:absolute; top:280px; left:10px; width:1120px; height:1px; background-color:#f4f1ec;}
.commentlist .commnet {float:left; position:relative; width:320px; height:260px; margin:0 10px 40px; padding:0 20px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65806/bg_comment_v1.png) no-repeat 50% 0;}
.commentlist .commnet .id {display:block; padding-top:33px; color:#141b66; font-size:12px; line-height:1.25em; text-align:right;}
.commentlist .commnet .letter {overflow-y:auto; width:300px; height:106px; margin-top:16px; padding:8px 10px; border:1px solid #e3d2bc; background-color:#fff; line-height:1.5em; text-align:left;}
.commentlist .commnet .date {position:relative; margin-top:40px; color:#898176; text-align:left;}
.commentlist .commnet .date em {font-weight:bold;}
.commentlist .commnet .date span {position:absolute; top:0; right:0;}
.commentlist .commnet .btndel {position:absolute; top:-14px; right:-13px; width:32px; height:32px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65806/btn_del.png) no-repeat 50% 0; text-indent:-999em;}

.pageWrapV15 {width:1140px; margin:0 auto; padding-top:40px; padding-bottom:20px; border-top:1px solid #f4f1ec;}
.pageWrapV15 .pageMove {display:none;}
</style>
<script type="text/javascript">
<% if Request("iCC") <> "" then %>
	$(function(){
		var val = $('#cmtdiv').offset();
		window.$('html,body').animate({scrollTop:$("#cmtdiv").offset().top}, 0);
	});
<% end if %>

function jsSubmitComment(frm){      //코멘트 입력
	<% If IsUserLoginOK() Then %>
		<% If Now() > #09/13/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If getnowdate>="2015-09-01" and getnowdate<="2015-09-13" Then %>
				<% if subscriptcount < 5 then %>
					
					if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 300 || frm.txtcomm.value == '당첨 확률을 높이고 댓글을 남겨주세요.'){
						alert("코멘트가 없거나 제한길이를 초과하였습니다. 150자 까지 작성 가능합니다.");
						frm.txtcomm.focus();
						return;
					}

			   		frm.mode.value="addcomment";
					frm.action="/event/etc/doEventSubscript65806.asp";
					frm.target="evtFrmProc";
					frm.submit();
					return;
				<% else %>
					alert("참여는 다섯번 가능 합니다.");
					return;
				<% end if %>
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
		frmcomm.action="/event/etc/doEventSubscript65806.asp";
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
	
	if (frmcomm.txtcomm.value == '당첨 확률을 높이고 댓글을 남겨주세요.'){
		frmcomm.txtcomm.value='';
	}
}

<%
	dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle = Server.URLEncode(ename)
	snpLink = Server.URLEncode("http://10x10.co.kr/event/" & ecode)
	snpPre = Server.URLEncode("텐바이텐 이벤트")
	snpTag = Server.URLEncode("텐바이텐 " & Replace(ename," ",""))
	snpTag2 = Server.URLEncode("#10x10")
	snpImg = Server.URLEncode(emimg)
%>

// sns카운팅
function getsnscnt(snsno) {
	var str = $.ajax({
		type: "GET",
		url: "/event/etc/doEventSubscript65806.asp",
		data: "mode=snscnt&snsno="+snsno,
		dataType: "text",
		async: false
	}).responseText;
	if(str=="tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(str=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else{
		alert('오류가 발생했습니다.');
		return false;
	}
}

// 동영상 선택
function getmovsel(movno) {
	$.ajax({
		type: "post",
		url: "/event/etc/doEventSubscript65806.asp",
		data: "mode=movie&movno="+movno,
		dataType: "html",
		success: function(data) {
		$("#listDiv").empty();
		$("#listDiv").html(data);
	    var val = $('#movieDiv').offset();
		window.$('html,body').animate({scrollTop:$("#movieDiv").offset().top}, 0);
		}
	});
}
</script>
	<div class="evt65806">
		<div id="topic" class="topic">
			<div class="hgroup">
				<h2>
					<span class="letter1">텐바이텐 X 멜로디포레스트캠프</span>
					<span class="letter2">MELODY FOREST CAMP</span>
					<span class="letter3">공식굿즈 런칭</span>
				</h2>
				<p class="story">가을 하늘 아래 우리의 이야기</p>
				<div id="option" class="option">
					<a href="#commentevt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/btn_comment.png" alt="코멘트 남기러 가기" /></a>
					<em><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/ico_only.png" alt="ONLY 텐바이텐" /></em>
				</div>
			</div>

			<div class="artist">
				<div class="navigator">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/txt_movie.png" alt="각각의 아티스트를 클릭하면 해당 아티스트의 영상을 확인할 수 있습니다." /></p>
					<ul>
						<li class="artist01"><a href="" onclick="getmovsel('edk'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/img_artist_01.png" alt="에디킴" /></a></li>
						<li class="artist02"><a href="" onclick="getmovsel('iu'); return false;" ><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/img_artist_02.png" alt="아이유" /></a></li>
						<li class="artist03"><a href="" onclick="getmovsel('yhe'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/img_artist_03.png" alt="양희은" /></a></li>
						<li class="artist04"><a href="" onclick="getmovsel('yjs'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/img_artist_04.png" alt="윤종신" /></a></li>
						<li class="artist05"><a href="" onclick="getmovsel('yhy'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/img_artist_05.png" alt="유희열" /></a></li>
					</ul>
				</div>
				<div class="moive" id="movieDiv">
					<div class="video" id="listDiv">
						<iframe src="https://www.youtube.com/embed/uixxC7T1uJs" width="480" height="300" frameborder="0" title="2015 멜로디 포레스트 캠프 아이유 라인업 공개!" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
					</div>

					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/txt_festival.png" alt="2015년 9월 20, 21일 양일간 자라섬에서 펼쳐지는 페스티벌은 남녀노소 모두가 쉽고 편하게 즐길 수 있는 국내 유일의 대중 음악 페스티벌입니다. 시원한 숲과 맑고 푸른 하늘과 청명한 공기, 반짝이는 별, 감동적인 음악까지 어우러지는 휴식을 경험해보세요." /></p>
						<a href="http://melodyforestcamp.com/" target="_blank" title="새창" class="btnHomepage"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/btn_homepage.png" alt="공식 홈페이지 바로가기" /></a>
						<div class="deco">
							<span class="star twinkle"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/img_star.png" alt="" /></span>
							<span class="tent"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/img_tent.png" alt="" /></span>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="officalMd">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/tit_offical_md.png" alt="텐바이텐 X 멜로디 포레스트 캠프 OFFICIAL MD" /></h3>
			<div class="item">
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/img_item_v1.png" alt="굿즈 총 6종" usemap="#itemlink" />
				<map name="itemlink" id="itemlink">
					<area shape="rect" coords="122,183,405,535" href="/shopping/category_prd.asp?itemid=1338945" target="_top" alt="나그랑 티셔츠" />
					<area shape="rect" coords="447,185,715,534" href="/shopping/category_prd.asp?itemid=1338947" target="_top" alt="에코백" />
					<area shape="rect" coords="765,185,1035,532" href="/shopping/category_prd.asp?itemid=1338946" target="_top" alt="피크닉 매트" />
					<area shape="rect" coords="118,592,407,953" href="/shopping/category_prd.asp?itemid=1338949" target="_top" alt="LED 조명" />
					<area shape="rect" coords="446,592,717,954" href="/shopping/category_prd.asp?itemid=1338948" target="_top" alt="캠핑머그" />
					<area shape="rect" coords="767,593,1036,953" href="/shopping/category_prd.asp?itemid=1338950" target="_top" alt="핀버튼" />
				</map>
			</div>
		</div>

		<!-- comment -->
		<div id="commentevt" class="commentevt">
			<div class="field">
				<div class="form">
					<form name="frmcomm" action="" onsubmit="return false;" method="post" style="margin:0px;">
					<input type="hidden" name="mode">
					<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
					<input type="hidden" name="sub_idx">
						<fieldset>
						<legend>멜로디 포레스트 캠프 2015 굿즈 기대평 쓰기</legend>
							<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/tit_comment_event.png" alt="COMMENT EVENT" /></h3>
							<textarea title="기대평 쓰기" cols="60" rows="5" name="txtcomm" id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>당첨 확률을 높이고 댓글을 남겨주세요.<%END IF%></textarea>
							<div class="btnsubmit"><input type="image" onclick="jsSubmitComment(frmcomm); return false;" src="http://webimage.10x10.co.kr/eventIMG/2015/65806/btn_submit.png" alt="응모하기" /></div>
						</fieldset>
					</form>
				</div>

				<div class="sns">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65806/txt_sns_v2.png" alt="본 이벤트를 SNS에 소문내주시고, 텐바이텐 X 멜로디 포레스트 캠프 굿즈 구매해 주세요!" usemap="#snslink" /></p>
					<map name="snslink" id="snslink">
						<area shape="rect" coords="670,31,751,111" href="" onclick="getsnscnt('fb'); return false;" alt="페이스북" />
						<area shape="rect" coords="758,32,831,113" href="" onclick="getsnscnt('tw'); return false;" alt="트위터" />
					</map>
				</div>
			</div>

			<%' commnet list %>
			<% IF ccomment.ftotalcount>0 THEN %>
			<div class="commentlistWrap" id="cmtdiv">
				<div class="commentlist">
					<div class="line"></div>
					<% for i = 0 to ccomment.fresultcount - 1 %>
						<div class="commnet">
							<strong class="id"><%=printUserId(ccomment.FItemList(i).fuserid,2,"*")%></strong>
							<div class="letter"><%=ReplaceBracket(ccomment.FItemList(i).fsub_opt3)%></div>
							<div class="date">
								<em>no.<%=ccomment.FTotalCount-i-(ccomment.FPageSize*(ccomment.FCurrPage-1))%></em>
								<span><%=FormatDate(ccomment.FItemList(i).fregdate,"0000-00-00")%></span>
							</div>
							<% ' for dev msg : 내가 쓴 글일 경우 삭제버튼 노출 %>
							<% if ((userid = ccomment.FItemList(i).fuserid) or (userid = "10x10")) and ( ccomment.FItemList(i).fuserid<>"") then %>
								<button type="button" onclick="jsDelComment('<%= ccomment.FItemList(i).fsub_idx %>'); return false;" class="btndel">내가 쓴 글 삭제하기</button>
							<% End If %>
							
							<%' for dev msg : 모바일에서 작성된 글일 경우 %>
							<% if ccomment.FItemList(i).fdevice <> "W" then %>
							<% end if %>
						</div>
					<% next %>
				</div>
			
				<!-- paging -->
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(ccomment.FCurrpage, ccomment.ftotalcount, ccomment.FPageSize, ccomment.FScrollCount,"jsGoComPage") %>
				</div>
			</div>
			<% end if %>
		</div>

	</div>
<script type="text/javascript">
$(function(){
	$("#option a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},1200);
	});

	titleAnimation();
	$("#topic .hgroup h2 span").css({"opacity":"0"});
	$("#topic .hgroup h2 .letter1").css({"top":"10px"});
	$("#topic .hgroup h2 .letter2").css({"top":"106px"});
	$("#topic .hgroup h2 .letter3").css({"top":"205px"});
	$("#topic .story").css({"top":"359px", "opacity":"0"});
	function titleAnimation() {
		$("#topic .hgroup h2 .letter1").delay(200).animate({"top":"0", "opacity":"1"},800);
		$("#topic .hgroup h2 .letter2").delay(800).animate({"top":"96px", "opacity":"1"},800);
		$("#topic .hgroup h2 .letter3").delay(1400).animate({"top":"195px", "opacity":"1"},800);
		$("#topic .hgroup p").delay(100).animate({"top":"369px", "opacity":"1"},600);
	}

	if ($(".commentlist .commnet").length > 4) {
		$(".line").show();
	} else {
		$(".line").hide();
	}
});
</script>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>
<% set ccomment=nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->