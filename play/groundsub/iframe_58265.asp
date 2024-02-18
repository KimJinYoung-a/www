<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  play PEN_KEEP MY MEMORY
' History : 2015.01.02 원승현 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/play/groundsub/event58265Cls.asp" -->
<%
dim eCode
	eCode   =  getevt_code()

dim commentexistscount, userid, i
commentexistscount=0
userid = getloginuserid()

if userid<>"" then
	commentexistscount=getcommentexistscount(userid, eCode, "", "", "", "Y")
end if

dim com_egCode, bidx, isMyComm
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	
	isMyComm	= requestCheckVar(request("isMC"),1)
	
	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 10		'한 페이지의 보여지는 열의 수
	iCPerCnt = 10		'보여지는 페이지 간격

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	if isMyComm="Y" then cEComment.FUserID = GetLoginUserID

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>

<style type="text/css">
.movie {width:1140px; margin:0 auto; padding-top:34px;}
.movie .bnr {padding:19px 18px 19px 0; text-align:right;}
.movie iframe {margin-left:-1px;}

.topic {width:1140px; height:875px; margin:0 auto; padding-top:70px; text-align:center;}
.topic h1 {margin-top:30px;}
.topic .desc {position:relative; width:323px; margin:0 auto;}
.topic .desc p {margin-top:56px;}
.desc .animated1 {position:absolute; top:97px; left:107px;}
.desc .animated2 {position:absolute; top:85px; left:295px;}
.desc .animated3 {position:absolute; top:203px; left:60px;}
.desc .animated4 {position:absolute; top:237px; left:165px;}
.desc .animated5 {position:absolute; top:335px; left:10px;}
.desc .animated6 {position:absolute; top:470px; left:229px;}

.write {width:1140px; height:930px; margin:0 auto; padding-top:50px; text-align:center;}
.write .field {position:relative; width:790px; margin:39px auto 0;}
.write .field .itext {width:480px; padding:30px 42px 25px; border:3px solid #5787a0;}
.write .field .itext input {width:472px; padding:0 4px 2px; border-bottom:1px solid #fff; background-color:transparent; color:#000; font-size:12px; line-height:1.5em;}
.write .field .submit {position:absolute; top:0; right:0;}

.commentlist {width:770px; margin:39px auto 0; padding:10px; background-color:rgba(211,216,217,0.6); *background-color:#cbd0d1;}
.commentlist {background-color:#cbd0d1\9;}
.commentlist .inner {padding:28px 40px 40px; background-color:#fff;}
.commentlist .inner ul li {position:relative; padding:10px 50px 10px 0; border-bottom:1px solid #ddd; text-align:left;}
.commentlist .inner ul li span {margin-right:2px; padding-right:10px; background:url(http://webimage.10x10.co.kr/play/ground/20150105/blt_colon.gif) no-repeat 100% 50%; color:#777; }
.commentlist .inner ul li span em {height:15px; margin-right:4px; padding:0 6px 1px; border-radius:10px; background-color:#b1d1da; color:#fff; font-size:11px; font-weight:bold; line-height:16px;}
.commentlist .inner ul li strong {color:#6dadbf; font-size:12px; font-weight:normal; line-height:1.25em; word-wrap:break-word;}
.commentlist .inner ul li strong img {margin-left:4px; vertical-align:middle;}
.commentlist .inner .paging {margin-top:20px;}
.pageWrapV15 .pageMove {display:none;}
.btndel {position:absolute; top:12px; right:0; height:13px; padding-right:14px; padding-left:7px; border-left:1px solid #bbb; background:#fff url(http://webimage.10x10.co.kr/play/ground/20150105/btn_del.gif) no-repeat 100% 50%; color:#bbb; font-size:12px; line-height:1.375em;}
</style>
<script type="text/javascript">

$(function(){
	jQuery(window.parent).scroll(function(){
		var scrollTop = jQuery(document.parent).scrollTop();
		console.log("scrollTop : " + scrollTop);
		if (scrollTop < 1500 ) {
			show();
		}
	});

	$(".desc .animated1").animate({width:"0"}, 500);
	$(".desc .animated2").css({"opacity":"0"});
	$(".desc .animated3").animate({width:"0"}, 500);
	$(".desc .animated4").css({"opacity":"0"});
	$(".desc .animated5").css({"opacity":"0"});
	$(".desc .animated6").animate({width:"0"}, 500);

	function show() {
		$(".desc .animated1").delay(500).animate({width:"133px"}, 500);
		$(".desc .animated2").delay(600).animate({"opacity":"1"},1800)
		$(".desc .animated3").delay(500).animate({width:"206px"}, 2000);
		$(".desc .animated4").delay(700).animate({"opacity":"1"},3500);
		$(".desc .animated5").delay(900).animate({"opacity":"1"},4200);
		$(".desc .animated6").delay(500).animate({width:"106px"}, 4500);
	}
});

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	if(frmcom.txtcomm.value =="내가 좋아 하는 말 (40자 이내)"){
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
		<% if commentexistscount>=5 then %>
//			alert('한아이디당 5회 까지만 참여가 가능 합니다.');
//			return;
		<% end if %>


		if(frmcom.txtcomm.value =="내가 좋아 하는 말 (40자 이내)"){
			frmcom.txtcomm.value ="";
		}

		if(!frmcom.txtcomm.value){
			alert("코멘트를 입력해주세요");
			frmcom.txtcomm.focus();
			return false;
		}
		if (GetByteLength(frmcom.txtcomm.value) > 80){
			alert("코맨트가 제한길이를 초과하였습니다. 40자 까지 작성 가능합니다.");
			frmcom.txtcomm.focus();
			return;
		}

		frmcom.action='/play/groundsub/doEventSubscript58265.asp';
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
			document.frmdelcom.action='/play/groundsub/doEventSubscript58265.asp';
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
<div class="playGr20150115">
	<div class="memory">
		<div class="movie">
			<div class="bnr"><a href="http://www.better-taste.com/" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20150105/img_bnr_bts.gif" alt="프로덕션 Better Taste Stuido" /></a></div>
			<iframe src="//player.vimeo.com/video/115775467" width="1140" height="642" frameborder="0" title="Keep My Memory" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
		</div>

		<div class="topic">
			<span><img src="http://webimage.10x10.co.kr/play/ground/20150105/ico_pen.png" alt="" /></span>
			<h1><img src="http://webimage.10x10.co.kr/play/ground/20150105/tit_keep_my_memory.png" alt="Keep My Memory" /></h1>
			<div class="desc">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150105/txt_topic_01.png" alt="우리가 살아가는 순간순간이 누군가 써주는 원고와 같다면 어떨까요." /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150105/txt_topic_02.png" alt="플레이 열여섯 번째 주제는 쓱싹쓱싹 나와 가장 가까운 곳에서 기록자 역할을 해주는 펜입니다." /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150105/txt_topic_03.png" alt="우리는 많은 순간 펜과 함께합니다. 순간의 기억들을 잡아두기 위해 펜을 잡기도 하고 잊지 않아야 할 곳에 한 번 더 체크를 해 두기도 하고 말로 하기는 어려운 말들을 대신 전하기도 합니다." /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150105/txt_topic_04.png" alt="플레이에서는 우리의 일상 속에서 펜과 함께 기록되고 있는 순간, 글자들을 담아보았습니다." /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150105/txt_topic_05.png" alt="여러분의 새로운 시작과 앞으로의 나날들이 행복한 이야기들로만 기록되어 지길 바랍니다." /></p>
				<span class="animated1"><img src="http://webimage.10x10.co.kr/play/ground/20150105/img_wave_line.png" alt="" /></span>
				<span class="animated2"><img src="http://webimage.10x10.co.kr/play/ground/20150105/img_circle.png" alt="" /></span>
				<span class="animated3"><img src="http://webimage.10x10.co.kr/play/ground/20150105/img_line.png" alt="" /></span>
				<span class="animated4"><img src="http://webimage.10x10.co.kr/play/ground/20150105/img_star.png" alt="" /></span>
				<span class="animated5"><img src="http://webimage.10x10.co.kr/play/ground/20150105/img_play.png" alt="" /></span>
				<span class="animated6"><img src="http://webimage.10x10.co.kr/play/ground/20150105/img_smile.png" alt="" /></span>
			</div>
		</div>

		<div class="write">
			<h2><img src="http://webimage.10x10.co.kr/play/ground/20150105/tit_like_write.png" alt="당신이 좋아하는 말을 기록해주세요." /></h2>
			<!-- comment form -->
			<div class="field">
				<form name="frmcom" method="post" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
				<input type="hidden" name="iCTot" value="">
				<input type="hidden" name="mode" value="add">
				<input type="hidden" name="spoint" value="0">
				<input type="hidden" name="isMC" value="<%=isMyComm%>">
					<fieldset>
					<legend>당신이 좋아하는 말 쓰기</legend>
						<div class="itext"><input type="text" name="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" title="좋아하는 말 입력" <%IF NOT IsUserLoginOK THEN%>value="로그인 후 글을 남길 수 있습니다."<% else %>value="내가 좋아 하는 말 (40자 이내)"<%END IF%>  <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> maxlength="35"/></div>
						<div class="submit"><input type="image" onclick="jsSubmitComment(); return false;" src="http://webimage.10x10.co.kr/play/ground/20150105/btn_submit.gif" alt="기록하기" /></div>
					</fieldset>
				</form>
				<form name="frmdelcom" method="post" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="Cidx" value="">
				<input type="hidden" name="mode" value="del">
				</form>					
			</div>
			<!-- comment list -->
			<% IF isArray(arrCList) THEN %>
				<div class="commentlist">
					<div class="inner">
						<ul>
							<%' for dev msg : 한페이지당 10개 보여주세요. %>
							<%
							dim tmpcomment, tmpcommentgubun , tmpcommenttext
							For i = 0 To UBound(arrCList,2)
							
							tmpcomment = ReplaceBracket(db2html(arrCList(1,i)))
							tmpcomment = split(tmpcomment,"!@#")
							if isarray(tmpcomment) then
								tmpcommentgubun=tmpcomment(0)
								tmpcommenttext=tmpcomment(1)
							end if
							%>
							<li>
								<span><em>No.<%=iCTotCnt-i-(iCPageSize*(iCCurrpage-1))%></em> <%=printUserId(arrCList(2,i),2,"*")%>의 기록</span>
								<strong><%= tmpcommenttext %> <% If arrCList(8,i) <> "W" Then %><img src="http://webimage.10x10.co.kr/play/ground/20150105/ico_mobile.gif" alt="모바일에서 작성" /><% End If %></strong>
								<% if ((GetLoginUserID = arrCList(2,i)) or (GetLoginUserID = "10x10")) and ( arrCList(2,i)<>"") then %>
									<button type="butotn" onclick="jsDelComment('<% = arrCList(0,i) %>');return false;" class="btndel">삭제</button>
								<% End If %>

							</li>
							<% Next %>
						</ul>

						<!-- paging -->
						<div class="pageWrapV15">
							<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
						</div>
					</div>
				</div>
			<% Else %>
			<% End If %>
		</div>
	</div>
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->