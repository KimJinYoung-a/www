<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  2015오픈이벤트 새로고침
' History : 2015.04.09 유태욱 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 사월의 꿀 맛 - 새로고침"		'페이지 타이틀 (필수)
	strPageDesc = "당신의 달콤한 쇼핑 라이프를 위해! 사월의 꿀 맛. 당신의 더 나은 쇼핑을 위해 - 새로고침"		'페이지 설명
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2015/60829/m/tit_april_honey.gif"		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/event/2015openevent/refresh.asp"			'페이지 URL(SNS 퍼가기용)

Dim eCode, userid, sub_idx, i, renloop
	eCode=getevt_code
	userid = getloginuserid()
Dim iCPerCnt, iCPageSize, iCCurrpage
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호

function getnowdate()
	dim nowdate
	
	nowdate = date()
'	nowdate = "2015-04-13"
	
	getnowdate = nowdate
end function

function getevt_code()
	dim evt_code
	
	IF application("Svr_Info") = "Dev" THEN
		evt_code   =  60742
	Else
		evt_code   =  60835
	End If

	getevt_code = evt_code
end function

IF iCCurrpage = "" THEN iCCurrpage = 1
iCPageSize = 12
iCPerCnt = 10		'보여지는 페이지 간격

dim ccomment
set ccomment = new Cevent_etc_common_list
	ccomment.FPageSize        = iCPageSize
	ccomment.FCurrpage        = iCCurrpage
	ccomment.FScrollCount     = iCPerCnt
	ccomment.frectordertype="new"
	ccomment.frectevt_code      	= eCode
	ccomment.frectsub_opt1			= eCode
	ccomment.event_subscript_paging
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* 2015 open event common style */
#eventDetailV15 .gnbWrapV15 {height:38px;}
#eventDetailV15 #contentWrap {padding-top:0; padding-bottom:127px;}
.eventContV15 .tMar15 {margin-top:0;}
.aprilHoney {background:#fff url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_wave.png) repeat-x 50% 0;}
.honeyHead {position:relative; width:1140px; margin:0 auto; text-align:left; z-index:25;}
.honeyHead .hgroup {position:absolute; top:22px; left:0;}
.honeyHead .hgroup p {visibility:hidden; width:0; height:0;}
.honeyHead ul {overflow:hidden; width:656px; margin-left:484px;}
.honeyHead ul li {float:left; width:131px;}
.honeyHead ul li.nav5 {width:132px;}
.honeyHead ul li a {overflow:hidden; display:block; position:relative; height:191px; font-size:11px; line-height:191px; text-align:center;}
.honeyHead ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_nav_12pm.png) no-repeat 0 0;}
.honeyHead ul li.nav1 a:hover span {background-position:0 -191px;}
.honeyHead ul li.nav2 a span {background-position:-131px 0;}
.honeyHead ul li.nav2 a:hover span {background-position:-131px -191px;}
.honeyHead ul li.nav2 a.on span {background-position:-131px 100%;}
.honeyHead ul li.nav3 a span {background-position:-262px 0;}
.honeyHead ul li.nav3 a:hover span {background-position:-262px -191px;}
.honeyHead ul li.nav3 a.on span {background-position:-262px 100%;}
.honeyHead ul li.nav4 a span {background-position:-393px 0;}
.honeyHead ul li.nav4 a:hover span {background-position:-393px -191px;}
.honeyHead ul li.nav4 a.on span {background-position:-393px 100%;}
.honeyHead ul li.nav5 {position:relative;}
.honeyHead ul li.nav5 a span {background-position:100% 0;}
.honeyHead ul li.nav5 a:hover span {background-position:100% -191px;}
.honeyHead ul li.nav5 a.on span {background-position:100% 100%;}
.honeyHead ul li.nav5 .hTag {position:absolute; top:9px; left:77px;}
.honeyHead ul li.nav5:hover .hTag {-webkit-animation-name: bounce; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; -moz-animation-name: bounce; -moz-animation-iteration-count: infinite; -moz-animation-duration:0.5s; -ms-animation-name: bounce; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function: ease-out;}
	50% {margin-top:8px; -webkit-animation-timing-function: ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function: ease-out;}
	50% {margin-top:8px; animation-timing-function: ease-in;}
}
.honeySection {padding-top:70px; background-color:#fff;}

/* 새로고침 */
.refreshCont {position:relative; width:1140px; margin:0 auto;}
.refreshHead {position:relative; padding-top:75px; margin-top:-15px; z-index:20; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60835/bg_head.gif) left top repeat-x;}
.refreshHead .deco {position:absolute; left:0; top:0; display:block; width:100%; height:15px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_wave.png) repeat-x 50% bottom;}
.refreshHead .refreshCont {height:248px; padding-bottom:80px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60835/bg_head_arrow.gif) center bottom no-repeat;}
.refreshHead .refreshCont h2 {position:relative; width:580px; height:160px; margin:0 auto;}
.refreshHead .refreshCont h2 span {display:block; position:absolute; top:0; z-index:30;}
.refreshHead .refreshCont h2 span.t01 {left:0;}
.refreshHead .refreshCont h2 span.t02 {left:140px;}
.refreshHead .refreshCont h2 span.t03 {left:280px;}
.refreshHead .refreshCont h2 span.t04 {left:420px;}
.refreshHead .refreshCont h2 .icon {position:absolute; left:535px; bottom:2px; width:105px; height:105px; z-index:30; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60835/bg_refresh_icon.png) left top no-repeat;}
.refreshHead .refreshCont h2 .icon em {display:inline-block;width:105px; height:105px;}
.renewalGuide li {padding:65px 0;}
.renewalGuide li.bgBlue {background-color:#f6fdff;}
.renewalComment {padding-bottom:130px;}
.renewalComment .leaveMsg {height:388px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60835/bg_comment_head.gif) left top repeat-x;}
.renewalComment .leaveMsg h3 {padding-top:40px;}
.renewalComment .writeArea {overflow:hidden; width:860px; margin:0 auto; padding:30px 0 18px;}
.renewalComment .writeArea textarea {float:left; width:658px; height:50px; padding:10px; border:1px solid #efbe1e; background:#fff;}
.renewalComment .writeArea .btnSubmit {float:right;}
.messageList {overflow:hidden; padding-top:50px;}
.messageList ul {overflow:hidden; margin-right:-36px;}
.messageList li {position:relative; float:left; width:350px; height:300px; margin:0 36px 40px 0; font-size:11px; text-align:left; background-position:left top; background-repeat:no-repeat;}
.messageList li.type01 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60835/bg_comment01.gif);}
.messageList li.type02 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60835/bg_comment02.gif);}
.messageList li.type03 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60835/bg_comment03.gif);}
.messageList li.type04 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60835/bg_comment04.gif);}
.messageList li.type05 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60835/bg_comment05.gif);}
.messageList li p {position:absolute;}
.messageList li .num {left:57px; top:62px; color:#777;}
.messageList li .msg {left:57px; top:95px; width:235px; line-height:22px; color:#000;}
.messageList li .writer {right:52px; top:230px; color:#666;}
.messageList li .writer span {position:relative; padding-left:8px; margin-left:2px;}
.messageList li .writer span.date:after {content:' '; display:inline-block; position:absolute; left:0; top:1px; width:1px; height:9px; background:#666;}
.messageList li .del {right:57px; top:57px;}

.refreshHead .refreshCont h2 .icon em {-webkit-animation-duration:4000ms; -webkit-animation-iteration-count: infinite; -webkit-animation-timing-function: linear; -moz-animation-duration:4000ms; -moz-animation-iteration-count: infinite; -moz-animation-timing-function: linear; -ms-animation-duration:4000ms; -ms-animation-iteration-count: infinite; -ms-animation-timing-function: linear; animation-duration:4000ms; animation-iteration-count: infinite; animation-timing-function: linear; animation-name:spin; -webkit-animation-name:spin; -moz-animation-name: spin; -ms-animation-name: spin;}
@-ms-keyframes spin {from {-ms-transform: rotate(0deg);} to {-ms-transform: rotate(360deg);}}
@-moz-keyframes spin {from { -moz-transform: rotate(0deg);} to { -moz-transform: rotate(360deg);}}
@-webkit-keyframes spin {from { -webkit-transform: rotate(0deg);} to { -webkit-transform: rotate(360deg);}}
@keyframes spin {from {transform:rotate(0deg);} to { transform:rotate(-360deg);}}
</style>
<script type="text/javascript">
$(function(){
	function moveFlower () {
		$(".honeyHead .hgroup h2").animate({"margin-top":"0"},1000).animate({"margin-top":"3px"},1000, moveFlower);
	}
	//moveFlower();

	moveTit();
	function moveTit() {
		$(".refreshCont h2 span.t01").delay(500).effect( "bounce", {times:3}, 900);
		$(".refreshCont h2 span.t02").delay(900).effect( "bounce", {times:3}, 900);
		$(".refreshCont h2 span.t03").delay(1400).effect( "bounce", {times:3}, 900);
		$(".refreshCont h2 span.t04").delay(1900).effect( "bounce", {times:3}, 900);
	}
	setInterval(function() {
		moveTit();
	},5000);
});

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If Now() > #04/24/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If getnowdate>="2015-04-13" and getnowdate<"2015-04-25" Then %>
				if(frm.txtcomm.value =="로그인 후 글을 남길 수 있습니다."){
					jsChklogin('<%=IsUserLoginOK%>');
					return false;
				}
				if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 200 || frm.txtcomm.value == '코멘트를 입력해 주세요.(100자 이내)'){
					alert("코맨트가 없거나 제한길이를 초과하였습니다. 100자 까지 작성 가능합니다.");
					frm.txtcomm.focus();
					return;
				}

		   		frm.mode.value="addcomment";
				frm.action="doEventSubscript60835.asp";
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

function jsGoComPage(iP){
	//	document.frmcomm.iCC.value = iP;
	//	document.frmcomm.submit();
	$.ajax({
		url: "act_refreshComment.asp",
		data: "iCC="+iP,
		type:"POST",
		cache: false,
		async: false,
		success: function(message) {
			$(".messageList").empty().html(message);
			$('html,body').animate({scrollTop: $(".messageList").offset().top},'fast');
		}
		,error: function(err) {
			alert(err.responseText);
		}
	});
}

function jsDelComment(sub_idx)	{
	if(confirm("삭제하시겠습니까?")){
		frmcomm.sub_idx.value = sub_idx;
		frmcomm.mode.value="delcomment";
		frmcomm.action="doEventSubscript60835.asp";
		frmcomm.target="evtFrmProc";
   		frmcomm.submit();
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	if(frmcomm.txtcomm.value =="100자 미만으로 남겨주세요."){
		frmcomm.txtcomm.value ="";
	}
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap" style="padding-top:0; padding-bottom:0;">
			<div class="eventWrapV15">
				<!--
				<div class="evtHead snsArea">
					<dl class="evtSelect ftLt">
						<dt><span>이벤트 더보기</span></dt>
						<dd>
							<ul>
								<li><strong>엔조이 이벤트 전체 보기</strong></li>
								<li>나는 모은다 고로 존재한다</li>
								<li>일년 열두달 매고 싶은, 플래그쉽 플래그쉽</li>
								<li>시어버터 보습막을 입자</li>
								<li>전국민 블루투스 키보드</li>
								<li>데스크도 여름 정리가 필요해 필요해 필요해</li>
								<li>지금 놀이터 갈래요!</li>
								<li>ELLY FACTORY</li>
								<li>폴프랭크 카메라</li>
								<li>폴프랭크 카메라</li>
								<li>폴프랭크 카메라</li>
							</ul>
						</dd>
					</dl>
					<div class="ftRt">
						<a href="" class="ftLt btn btnS2 btnGrylight"><em class="gryArr01">브랜드 전상품 보기</em></a>
						<div class="sns lMar10">
							<ul>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
							</ul>
							<div class="favoriteAct myFavor"><strong>123</strong></div>
						</div>
					</div>
				</div> 
				-->
				<div class="eventContV15">
					<div class="contF contW">
						<!-- 2015 RENEWAL 사월의 꿀 맛 -->
						<div class="aprilHoney">
							<!-- #include virtual="/event/2015openevent/inc_header.asp" --> 

							<!-- 새로고침 -->
							<div class="refreshTenten">
								<div class="refreshHead">
									<span class="deco"></span>
									<div class="refreshCont">
										<p class="bPad20"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/txt_for_you.png" alt="당신의 더 나은 쇼핑을 위해" /></p>
										<h2>
											<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/tit_refresh01.png" alt="새" /></span>
											<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/tit_refresh02.png" alt="로" /></span>
											<span class="t03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/tit_refresh03.png" alt="고" /></span>
											<span class="t04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/tit_refresh04.png" alt="침" /></span>
											<p class="icon"><em><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/icon_refresh.png" alt="" /></em></p>
										</h2>
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/txt_renewal_tenten.png" alt="따뜻한 봄을 맞아 새 옷을 입은 텐바이텐을 한 눈에! 축하 코멘트 남기고 100마일리지 받으세요~" /></p>
									</div>
								</div>
								<div class="renewalGuide">
									<ol>
										<li><p class="refreshCont"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/img_refresh_guide01.jpg" alt="01. 좋은 건 크게보세요!" /></p></li>
										<li class="bgBlue"><p class="refreshCont"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/img_refresh_guide02.jpg" alt="02. 당신만을 위해 준비했어요~" /></p></li>
										<li>
											<p class="refreshCont"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/img_refresh_guide03.jpg" alt="03. 행복한 식생활을 응원합니다!" usemap="#link01" /></p>
											<map name="link01" id="link01">
												<area shape="rect" coords="981,509,1132,539" href="/shopping/category_main.asp?disp=119" alt="푸드 카테고리 바로가기" target="_top" />
											</map>
										</li>
										<li class="bgBlue">
											<p class="refreshCont"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/img_refresh_guide04.jpg" alt="04. 마음을 전하세요!" usemap="#link02" /></p>
											<map name="link02" id="link02">
												<area shape="rect" coords="1024,509,1132,538" href="/gift/talk/" alt="GIFT 바로가기" target="_top" />
											</map>
										</li>
									</ol>
								</div>

								<div class="renewalComment">
								<form name="frmcomm" action="" onsubmit="return false;" method="post" style="margin:0px;">
								<input type="hidden" name="mode">
								<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
								<input type="hidden" name="sub_idx">
									<div class="leaveMsg">
										<div class="refreshCont">
											<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/tit_comment_event.png" alt="COMMENT EVENT 텐바이텐의 봄맞이 리뉴얼 개편! 괜찮아요?" /></h3>
											<div class="writeArea">
												<textarea name="txtcomm" id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" ><% IF NOT IsUserLoginOK THEN %>로그인 후 글을 남길 수 있습니다.<% else %>100자 미만으로 남겨주세요.<%END IF%></textarea>
												<input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/60835/btn_submit.gif" onclick="jsSubmitComment(frmcomm); return false;" alt="등록하기" class="btnSubmit" />
											</div>
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/txt_caution.gif" alt="댓글의 수에 상관없이 마일리지는 1회만 적립됩니다./부적절한 댓글은 통보 없이 삭제 됩니다./칭찬해주시면 더 좋아요! (기획팀이 손톱을 뜯으며 긴장하고 있어요.)" /></p>
										</div>
									</div>
								</form>
									<div class="messageList refreshCont">
									<% IF ccomment.ftotalcount>0 THEN %>
										<ul>
										<%
										for i = 0 to ccomment.fresultcount - 1
											randomize
											renloop=int(Rnd*5)+1
										%>
											<li class="type0<%= renloop %>">
												<p class="num">NO.<%=ccomment.FTotalCount-i-(ccomment.FPageSize*(ccomment.FCurrPage-1))%></p>
												<p class="msg"><%=ReplaceBracket(ccomment.FItemList(i).fsub_opt3)%></p>
												<p class="writer">
													<span><%=printUserId(ccomment.FItemList(i).fuserid,2,"*")%></span>
													<span class="date"><%=FormatDate(ccomment.FItemList(i).fregdate,"0000-00-00")%></span>
												</p>
												<% if ((userid = ccomment.FItemList(i).fuserid) or (userid = "10x10")) and ( ccomment.FItemList(i).fuserid<>"") then %>
													<p class="del"><a href="" onclick="jsDelComment('<%= ccomment.FItemList(i).fsub_idx %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/btn_delete.gif" alt="삭제" /></a></p>
												<% end if %>
											</li>
										<% next %>
										</ul>
									<% end if %>
										<div class="pageWrapV15 tMar20">
											<%= fnDisplayPaging_New(ccomment.FCurrpage, ccomment.ftotalcount, ccomment.FPageSize, ccomment.FScrollCount,"jsGoComPage") %>
										</div>
									</div>
								</div>
							</div>
							<!--// 새로고침 -->
						</div>
						<!--// 2015 RENEWAL 사월의 꿀 맛 -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width="0" height="0"></iframe>
</body>
</html>
<% set ccomment = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->