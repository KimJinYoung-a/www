<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  컬쳐스테이션 #07. 바로 그, [진실공방]
' History : 2015.03.16 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->

<%
function getnowdate()
	dim nowdate
	
	nowdate = date()
'	nowdate = "2015-03-17"
	
	getnowdate = nowdate
end function

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21504
Else
	eCode   =  60284
End If


dim iCCurrpage, isMyComm, iCTotCnt, iCPerCnt, iCPageSize, cEComment, arrCList, iCTotalPage, com_egCode, bidx, tmponload, intCLoop
	'tmponload	= requestCheckVar(request("upin"),2)
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)
	'isMyComm	= requestCheckVar(request("isMC"),1)

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

com_egCode = 0
iCPerCnt = 10		'보여지는 페이지 간격
iCPageSize = 12
'iCCurrpage = 1

'데이터 가져오기
set cEComment = new ClsEvtComment

cEComment.FECode 		= eCode
'cEComment.FComGroupCode	= com_egCode
cEComment.FEBidx    	= bidx
cEComment.FCPage 		= iCCurrpage	'현재페이지
cEComment.FPSize 		= iCPageSize	'페이지 사이즈
'if isMyComm="Y" then cEComment.FUserID = GetLoginUserID
cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

arrCList = cEComment.fnGetComment		'리스트 가져오기
iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

dim commentexistscount, userid, i
commentexistscount=0
userid = getloginuserid()

if userid<>"" then
	commentexistscount=getcommentexistscount(userid, eCode, "", "", "", "Y")
end if

%>
<style type="text/css">
.evt60284 {text-align:center; background:#fff;}
.evt60284 img {vertical-align:top;}
.evt60284 .history {position:relative; width:100%;}
.evt60284 .history .movie {position:absolute; right:90px; bottom:15px; width:218px; height:145px;}
.evt60284 .history .movie iframe {width:218px; height:145px;}
.evt60284 .slideWrap {padding:70px 0 78px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60284/bg_dot.gif) left top repeat;}
.evt60284 .slideWrap h3 {padding-bottom:30px;}
.evt60284 .slide {overflow:visible !important; position:relative; width:823px; height:519px; margin-left:130px;}
.evt60284 .slide .slidesjs-pagination {position:absolute; right:-57px; top:50%; width:24px; height:222px; margin-top:-136px; padding:50px 0 0 10px; z-index:20; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60284/bg_pagination.png) left top no-repeat;}
.evt60284 .slide .slidesjs-pagination li {padding:8px 0;}
.evt60284 .slide .slidesjs-pagination li a {display:block; width:14px; height:13px; text-indent:-9999px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60284/btn_pagination.gif) left top no-repeat;}
.evt60284 .slide .slidesjs-pagination li a.active {background-position:right top;}
.evt60284 .slide .slidesjs-navigation {display:block; position:absolute; right:-53px; width:26px; height:20px; text-indent:-9999px; z-index:30;}
.evt60284 .slide .slidesjs-previous {top:140px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60284/btn_prev.gif) left top no-repeat;}
.evt60284 .slide .slidesjs-next {top:363px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60284/btn_next.gif) left top no-repeat;}
.evt60284 .inviteComment {padding:70px 0 50px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60284/bg_slash.gif) left top repeat;}
.evt60284 .inviteComment ul {overflow:hidden; width:960px; margin:0 auto; padding:35px 0 15px;}
.evt60284 .inviteComment li {float:left; width:230px; padding:0 5px;}
.evt60284 .inviteComment li label {display:block; margin-bottom:9px;}
.evt60284 .writeComment {overflow:hidden; width:950px; margin:0 auto;}
.evt60284 .writeComment textarea {float:left; width:796px; height:83px; border:1px solid #ccc; padding:15px; font-size:12px; color:#999;}
.evt60284 .writeComment .send {float:right;}
.evt60284 .inviteList {padding-top:74px;}
.evt60284 .inviteList ul {overflow:hidden; margin:0 0 50px -25px;}
.evt60284 .inviteList li {float:left; width:241px; height:189px; padding:28px 28px 0 92px; margin:0 0 15px 25px; text-align:left; color:#fff; font-size:11px;}
.evt60284 .inviteList li .num {}
.evt60284 .inviteList li .boxCont {overflow-y:auto; height:98px; padding:10px; margin:10px 0; color:#302f2f; font-size:12px; line-height:19px; background:#fff;}
.evt60284 .inviteList li .writeInfo {text-align:right; line-height:12px;}
.evt60284 .inviteList li .writeInfo span {padding:0 5px;}
.evt60284 .inviteList li.type01 {border:1px solid #7f5934; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60284/bg_cmt01.gif) 28px 27px no-repeat #8d663c;}
.evt60284 .inviteList li.type02 {border:1px solid #606060; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60284/bg_cmt02.gif) 29px 28px no-repeat #7b7b7b;}
.evt60284 .inviteList li.type03 {border:1px solid #743c2f; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60284/bg_cmt03.gif) 27px 28px no-repeat #8d4d3c;}
.evt60284 .inviteList li.type04 {border:1px solid #333; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60284/bg_cmt04.gif) 27px 27px no-repeat #3a3a3a;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">

$(function(){
	$(".slide").slidesjs({
		width:"823",
		height:"519",
		navigation:{effect:"fade"},
		pagination:{effect:"fade"},
		play: {interval:3700, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$(".goCmt").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});
});

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	if(frmcom.txtcomm.value =="배우 이천희와 함께 하는 <진/실/공/방>에 대한 기대평을 300자 미만으로 남겨주세요."){
		frmcom.txtcomm.value ="";
	}
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(){
	<% If IsUserLoginOK() Then %>
		<% If not( getnowdate>="2015-03-17" and getnowdate<"2015-04-10") Then %>
			alert('이벤트 응모 기간이 아닙니다.');
			return;
		<% end if %>
		<% if commentexistscount>=333 then %>
			alert('한 아이디당 1회까지만 참여할 수 있습니다.');
			return;
		<% end if %>

		var tmpgubun='';
		for (var i=0; i < frmcom.gubun.length ; i++){
			if (frmcom.gubun[i].checked){
				tmpgubun=frmcom.gubun[i].value;
			}
		} 
		if (tmpgubun==''){
			alert('궁금한점을 선택해주세요.');
			return;
		}
		if(frmcom.txtcomm.value =="배우 이천희와 함께 하는 <진/실/공/방>에 대한 기대평을 300자 미만으로 남겨주세요."){
			frmcom.txtcomm.value ="";
		}
		if(!frmcom.txtcomm.value){
			alert("코멘트가 없거나 제한길이를 초과 하였습니다.");
			frmcom.txtcomm.focus();
			return false;
		}
		if (GetByteLength(frmcom.txtcomm.value) > 600){
			alert("코맨트가 없거나 제한길이를 초과하였습니다. 300자 까지 작성 가능합니다.");
			frmcom.txtcomm.focus();
			return;
		}

		frmcom.action='/event/etc/doEventSubscript60284.asp';
		frmcom.submit();
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function jsDelComment(cidx)	{
	<% If IsUserLoginOK() Then %>
		if (cidx==""){
			alert('정상적인 경로가 아닙니다');
			return;
		}
		
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
			document.frmdelcom.action='/event/etc/doEventSubscript60284.asp';
	   		document.frmdelcom.submit();
		}
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}
</script>
</head>
<body>
<!-- 이천희X텐바이텐 진실공방 -->
<div class="evt60284">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/tit_leechunhee02.jpg" alt="이천희X텐바이텐 진실공방" /></h2>
	<div class="history">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/txt_history.jpg" alt="HISTORY : 작가 이천희" usemap="#goBook" /></p>
		<div class="movie"><iframe src="//player.vimeo.com/video/107132499" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe></div>
		<map name="goBook" id="goBook">
			<area shape="poly" coords="567,398,562,475,468,475,468,499,564,505,564,579,710,583,713,401" onfocus="this.blur();" href="/culturestation/culturestation_event.asp?evt_code=2812" />
		</map>
	</div>
	<div class="slideWrap">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/tit_furniture_man.png" alt="도서 가구만드는 남자 출간" /></h3>
		<div class="slide">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/img_slide01.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/img_slide02.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/img_slide03.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/img_slide04.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/img_slide05.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/img_slide06.jpg" alt="" /></div>
		</div>
	</div>

	<form name="frmcom" method="post" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="com_egC" value="<%=com_egCode%>">
	<input type="hidden" name="bidx" value="<%=bidx%>">
	<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
	<input type="hidden" name="iCTot" value="">
	<input type="hidden" name="mode" value="add">
	<input type="hidden" name="spoint" value="0">
	<input type="hidden" name="isMC" value="<%=isMyComm%>">
	<!-- 코멘트 작성 -->
	<div class="inviteComment">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/tit_comment_event02.png" alt="COMMENT EVENT" /></h3>
		<ul class="selectTheme">
			<li>
				<label for="tm01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/img_select01.gif" alt="가구에 대해 궁금해요!" /></label>
				<input type="radio" id="tm01"  name="gubun" value="1"/>
			</li>
			<li>
				<label for="tm02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/img_select02.gif" alt="취미에 대해 궁금해요!" /></label>
				<input type="radio" id="tm02"  name="gubun" value="2"/>
			</li>
			<li>
				<label for="tm03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/img_select03.gif" alt="스타일에 대해 궁금해요!" /></label>
				<input type="radio" id="tm03"  name="gubun" value="3"/>
			</li>
			<li>
				<label for="tm04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60284/img_select04.gif" alt="관계에 대해 궁금해요!" /></label>
				<input type="radio" id="tm04"  name="gubun" value="4"/>
			</li>
		</ul>
		<div class="writeComment">
			<textarea cols="30" rows="5" name="txtcomm" id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>배우 이천희와 함께 하는 &lt;진/실/공/방&gt;에 대한 기대평을 300자 미만으로 남겨주세요.<%END IF%></textarea>
			<input type="image" class="send" src="http://webimage.10x10.co.kr/eventIMG/2015/60284/btn_submit.gif" onclick="jsSubmitComment(); return false;" alt="코멘트 남기기" />
		</div>
	</div>
	<!--// 코멘트 작성 -->
	</form>

	<% IF isArray(arrCList) THEN %>
	<!-- 코멘트 목록 -->
	<div class="inviteList">
		<ul>
		<% For intCLoop = 0 To UBound(arrCList,2) %>
			<!-- 상단 질문 선택에 따라 클래스 type01~04 붙여주세요 -->
			<li class="type0<%=(arrCList(7,intCLoop))%>">
				<p class="num">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
				<div class="boxCont"><%=(arrCList(1,intCLoop))%></div>
				<p class="writeInfo"><%=formatdate(arrCList(4,intCLoop),"0000.00.00")%><span>|</span><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
			</li>
		<% next %>
		</ul>
	<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
	</div>
	<% end if %>
	<!--// 코멘트 목록 -->
</div>
<!-- // 이천희X텐바이텐 진실공방 -->
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->