<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  play 나도작가
' History : 2015.01.09 원승현 생성
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
<!-- #include virtual="/play/groundsub/event58509Cls.asp" -->
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

	iCPageSize = 100000		'한 페이지의 보여지는 열의 수
	iCPerCnt = 100000		'보여지는 페이지 간격

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	if isMyComm="Y" then cEComment.FUserID = GetLoginUserID

	arrCList = cEComment.fnGetCommentASC		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = Nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>

<style type="text/css">
.iamwriter {}
.section1 {padding:38px 0 70px; background:#f9e66e url(http://webimage.10x10.co.kr/play/ground/20150112/bg_top.png) repeat-y 50% 0;}
.section1 .topic .bg {min-height:607px; }
.section1 .topic {overflow:hidden; position:relative; z-index:5; min-width:1140px; min-height:607px;}
.section1 .topic .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/play/ground/20150112/bg_iam_writer_v1.png) no-repeat 50% 0;}
.section1 .topic .desc {width:1140px; margin:10px auto 0;}

.section2 {background:#f9e66e url(http://webimage.10x10.co.kr/play/ground/20150112/bg_top.png) repeat-y 50% 0;}
.section2 h2 {height:196px; background:url(http://webimage.10x10.co.kr/play/ground/20150112/bg_dashed_line.png) repeat-x 50% 100%; text-align:center;}
.story .article {background-repeat:no-repeat; background-position:50% 0;}
.story .article .group {position:relative; width:1140px; margin:0 auto;}
.story .article1 {height:710px; background-color:#d8f7fa; background-image:url(http://webimage.10x10.co.kr/play/ground/20150112/bg_sky.png);}
.story .article1 p {top:157px; left:679px;}
.story .article2 {height:700px; background-color:#f78b7d; background-image:url(http://webimage.10x10.co.kr/play/ground/20150112/bg_orange.png);}
.story .article2 p {top:171px; left:170px;}
.story .article3 {height:740px; background-color:#3d5a75; background-image:url(http://webimage.10x10.co.kr/play/ground/20150112/bg_dark_blue.png);}
.story .article3 p {top:161px; left:395px;}
.story .article4 {height:710px; background-color:#fbde65; background-image:url(http://webimage.10x10.co.kr/play/ground/20150112/bg_yellow.png);}
.story .article4 p {top:132px; left:70px;}
.story .article5 {height:730px; background-color:#b670ba; background-image:url(http://webimage.10x10.co.kr/play/ground/20150112/bg_purple.png);}
.story .article5 p {top:137px; left:695px;}
.story .article p, .story .article span {position:absolute;}
.story .article .animation1 {top:91px; left:625px;}
.story .article .animation2 {top:227px; left:146px;}
.story .article .animation3 {top:472px; left:1px;}
.story .article .animation4 {top:442px; left:399px;}
.story .article .animation5 {top:216px; left:473px;}
.story .article .animation6 {top:397px; left:328px;}
.story .article .animation7 {top:88px; left:439px;}
.story .article .animation8 {top:278px; left:358px;}
.story .article .animation9 {top:401px; left:600px;}

.section3 {padding-top:6px; background:#7dfaaf url(http://webimage.10x10.co.kr/play/ground/20150112/bg_dashed_line_green.png) repeat-x 50% 0;}
.wishwrap {padding-top:210px; background:#7dfaaf url(http://webimage.10x10.co.kr/play/ground/20150112/bg_green.png) repeat-y 50% 0;}
.wish {width:1098px; height:1064px; margin:0 auto; background:url(http://webimage.10x10.co.kr/play/ground/20150112/bg_box.png) no-repeat 50% 0;}
.fiction {position:relative; width:940px; margin:0 auto; padding-top:150px;}
.fiction h2 {position:absolute; top:-131px; left:50%; margin-left:-317px;}
.wishlist {height:438px; padding-top:27px; background:url(http://webimage.10x10.co.kr/play/ground/20150112/bg_round_box_01.png) no-repeat 50% 0;}
.wishlist ul {overflow:auto; position:relative; width:866px; height:400px; margin:0 auto;}
.wishlist ul li {position:relative; margin-right:10px; padding:12px 10px; border-bottom:1px solid #fbdd65; font-size:12px; line-height:1.313em;}
.wishlist .no, .fiction .id {color:#09d892;}
.wishlist .no {padding-right:8px; font-weight:bold;}
.wishlist em {color:#555; font-family:'Dotum', 'Verdana';}
.wishlist em img {margin-top:-4px; margin-left:4px; vertical-align:middle;}
.wishlist .id {position:absolute; top:14px; right:0; padding-right:10px;}
.wishlist .btndel {height:11px; padding-right:10px; padding-left:4px; border-left:1px solid #fbdd65; background:#fff url(http://webimage.10x10.co.kr/play/ground/20150112/btn_del.png) no-repeat 100% 50%; background-color:transparent; color:#09d892; font-size:11px; font-family:'Dotum', 'Verdana'; font-weight:bold; text-decoration:underline;}

.field {position:relative; padding:0 9px; text-align:left;}
.field .itext {width:653px; height:80px; margin-left:68px; padding-left:40px; background:url(http://webimage.10x10.co.kr/play/ground/20150112/bg_round_box_02.png) no-repeat 50% 0; text-align:left;}
.field .itext input {width:607px; margin-top:30px; *margin-left:-68px; padding:0 2px 2px; border-bottom:1px solid #2fd6b8; color:#555; font-size:12px; font-family:'Dotum', 'Verdana'; line-height:1.5em;}
.field .submit {position:absolute; top:198px; right:100px;}
.field p {margin-top:11px; margin-left:110px; padding-left:11px; background:url(http://webimage.10x10.co.kr/play/ground/20150112/blt_arrow.png) no-repeat 0 4px; color:#f6b037; font-size:11px; font-family:'Dotum', 'Verdana'; line-height:1.5em;}
</style>
<script type="text/javascript">



function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	if(frmcom.txtcomm.value =="다음 이야기를 써주세요. (50자 이내)"){
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


		if(frmcom.txtcomm.value =="다음 이야기를 써주세요. (50자 이내)"){
			frmcom.txtcomm.value ="";
		}

		if(!frmcom.txtcomm.value){
			alert("다음 이야기를 입력해주세요");
			frmcom.txtcomm.focus();
			return false;
		}
		if (GetByteLength(frmcom.txtcomm.value) > 100){
			alert("다음 이야기가 제한길이를 초과하였습니다. 50자 까지 작성 가능합니다.");
			frmcom.txtcomm.focus();
			return;
		}

		frmcom.action='/play/groundsub/doEventSubscript58509.asp';
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
			document.frmdelcom.action='/play/groundsub/doEventSubscript58509.asp';
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


<div class="playGr20150112">
	<div class="iamwriter">
		<div class="section section1">
			<div class="topic">
				<div class="bg"></div>
				<div class="desc">
					<h1>나도 작가</h1>
					<p>텐바이텐 PLAY에서는 컴퓨터, 모바일 폰의 자판을 펜으로 활용하여 재밌는 이야기를 만들어 보고자 합니다.</p>
					<p>우리 모두 소설 작가! 다 함께 만들어가는 엉뚱 발랄 끝을 알 수 없는 이야기! 재치만점 여러분의 상상력을 발휘하여 소설 &lt;아기양의 지혜&gt;를 완성해 주세요! 추첨을 통해 5분께, 라미 만년필을 선물로 드립니다.</p>
					<p>응모가 종료되었습니다.</p>
				</div>
			</div>
		</div>

		<div class="section section2">
			<div class="story">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150112/tit_sheep.png" alt="아기양의 지혜" /></h2>
				<div class="article article1">
					<div class="group">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150112/txt_story_01.png" alt="어느 화창한 날, 양치기는 양들을 데리고 들판으로 나가 한가롭게 풀을 뜯고 있었어요." /></p>
						<span class="animation1"><img src="http://webimage.10x10.co.kr/play/ground/20150112/img_butterfly_01.gif" alt="" /></span>
						<span class="animation2"><img src="http://webimage.10x10.co.kr/play/ground/20150112/img_butterfly_02.gif" alt="" /></span>
						<span class="animation3"><img src="http://webimage.10x10.co.kr/play/ground/20150112/img_sheep_01.gif" alt="" /></span>
						<span class="animation4"><img src="http://webimage.10x10.co.kr/play/ground/20150112/img_sheep_02.gif" alt="" /></span>
					</div>
				</div>

				<div class="article article2">
					<div class="group">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150112/txt_story_02.png" alt="아기 양은 맛있는 풀을 찾아 여기저기 헤매다 길을 잃어버리고 말았어요." /></p>
						<span class="animation5"><img src="http://webimage.10x10.co.kr/play/ground/20150112/img_sheep_03.gif" alt="" /></span>
					</div>
				</div>

				<div class="article article3">
					<div class="group">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150112/txt_story_03.png" alt="그러다가 날이 저물어 형제 무리의 길을 찾을 수가 없었어요. &quot;도대체, 여긴 어디야&quot;" /></p>
						<span class="animation6"><img src="http://webimage.10x10.co.kr/play/ground/20150112/img_sheep_04.gif" alt="" /></span>
					</div>
				</div>

				<div class="article article4">
					<div class="group">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150112/txt_story_04.png" alt="그때 갑자기 어두운 수풀에서 늑대가 나타났어요. &quot;허허허 포동포동한 아기 양이라니! &quot; 늑대는 입맛을 다시며 아기 양에게 다가갔어요." /></p>
						<span class="animation7"><img src="http://webimage.10x10.co.kr/play/ground/20150112/img_wolf_01.gif" alt="" /></span>
					</div>
				</div>

				<div class="article article5">
					<div class="group">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150112/txt_story_05.png" alt="정신을 똑바로 차린 아기 양은 늑대에게 말했어요. &quot;늑대님, 저를 잡아먹으실 건가요?&quot; &quot;당연하지!&quot;" /></p>
						<span class="animation8"><img src="http://webimage.10x10.co.kr/play/ground/20150112/img_wolf_02.gif" alt="" /></span>
						<span class="animation9"><img src="http://webimage.10x10.co.kr/play/ground/20150112/img_sheep_05.gif" alt="" /></span>
					</div>
				</div>
			</div>
		</div>


		<div class="section section3">
			<div class="wishwrap">
				<div class="wish">
					<!-- list -->

					<div class="fiction">
						<h2><img src="http://webimage.10x10.co.kr/play/ground/20150112/tit_wish.png" alt="아기 양은 침착한 목소리로 늑대에게 말했어요. &quot;하지만 마지막 소원이 있어요, 늑대님&quot; 그 소원은…" /></h2>
						<% IF isArray(arrCList) THEN %>
						<div class="wishlist">
							<ul>
								<%' for dev msg : 제일 먼저 쓴 글부터 보입니다.%>
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
									<span class="no"><%=i+1%>.</span>
									<em><%= tmpcommenttext %> <% If arrCList(8,i) <> "W" Then %><img src="http://webimage.10x10.co.kr/play/ground/20150112/ico_mobile.png" alt="모바일에서 작성" /><% End If %></em> 
									<span class="id"><%=printUserId(arrCList(2,i),2,"*")%> <% if ((GetLoginUserID = arrCList(2,i)) or (GetLoginUserID = "10x10")) and ( arrCList(2,i)<>"") then %> <button type="butotn" class="btndel" onclick="jsDelComment('<% = arrCList(0,i) %>');return false;">삭제</button><% End If %></span>
								</li>
								<% Next %>
							</ul>
						</div>
						<% End If %>
					</div>


					<!-- comment form -->
					<a name="commentField"></a>
					<div class="field">
						<h2><img src="http://webimage.10x10.co.kr/play/ground/20150112/tit_write.png" alt="다음 소설 한줄을 이어주세요" /></h2>
							<form name="frmcom" method="post" style="margin:0px;">
							<input type="hidden" name="eventid" value="<%=eCode%>">
							<input type="hidden" name="bidx" value="<%=bidx%>">
							<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
							<input type="hidden" name="iCTot" value="">
							<input type="hidden" name="mode" value="add">
							<input type="hidden" name="spoint" value="0">
							<input type="hidden" name="isMC" value="<%=isMyComm%>">
								<fieldset>
								<legend>다음 이야기 쓰기</legend>
									<div class="itext"><input type="text" title="다음 이야기 입력" name="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT IsUserLoginOK THEN%>value="로그인 후 글을 남길 수 있습니다."<% else %>value="다음 이야기를 써주세요. (50자 이내)"<%END IF%>  <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> maxlength="50" /></div>
									<div class="submit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20150112/btn_submit.png" alt="소설쓰기" onclick="jsSubmitComment(); return false;" /></div>
								</fieldset>
						</form>
						<form name="frmdelcom" method="post" style="margin:0px;">
						<input type="hidden" name="eventid" value="<%=eCode%>">
						<input type="hidden" name="bidx" value="<%=bidx%>">
						<input type="hidden" name="Cidx" value="">
						<input type="hidden" name="mode" value="del">
						</form>					
						<p>저작권 침해, 반사회적, 음란성, 명예훼손 등의 게시물은 통보없이 삭제될 수 있습니다.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%' for dev msg : 바디 끝나기전에 스크립트 넣어주세요 %>
<script type="text/javascript">
$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 800){
			show1()
		}
		if (scrollTop > 1300){
			show2()
		}
		if (scrollTop > 1900){
			show3()
		}
		if (scrollTop > 3000){
			show4()
		}
		if (scrollTop > 3900){
			show5()
		}
	});

	$(".article1 p").css({"opacity":"0"});
	$(".article2 p").css({"opacity":"0"});
	$(".article3 p").css({"opacity":"0"});
	$(".article4 p").css({"opacity":"0"});
	$(".article5 p").css({"opacity":"0"});
	function show1() {
		$(".article1 p").delay(600).animate({"opacity":"1"},500);
	}
	function show2() {
		$(".article2 p").delay(500).animate({"opacity":"1"},500);
	}
	function show3() {
		$(".article3 p").delay(500).animate({"opacity":"1"},500);
	}
	function show4() {
		$(".article4 p").delay(300).animate({"opacity":"1"},500);
	}
	function show5() {
		$(".article5 p").delay(300).animate({"opacity":"1"},500);
	}
});
$(document).ready(function(){
	$(".wishlist ul").scrollTop($(".wishlist ul")[0].scrollHeight);
});
</script>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->