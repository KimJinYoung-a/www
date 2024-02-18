<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 텐바이텐 고향사진전
' History : 2015.09.25 원승현 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->

<%
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64899
Else
	eCode   =  66369
End If

dim userid, i, vreload
	userid = getloginuserid()
	vreload	= requestCheckVar(Request("reload"),2)

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt, sqlstr
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 16	'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 16	'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'// sns데이터 총 카운팅 가져옴
sqlstr = "select count(*) "
sqlstr = sqlstr & " from [db_Appwish].[dbo].[tbl_snsSelectData]"
sqlstr = sqlstr & " Where evt_code="& eCode &""

'response.write sqlstr & "<br>"
rsCTget.Open sqlstr, dbCTget, adOpenForwardOnly, adLockReadOnly
	iCTotCnt = rsCTget(0)
rsCTget.close

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
/* scm 등록 부분 */
.groundWrap {width:100%; background:#f6dcbd url(http://webimage.10x10.co.kr/play/ground/20150928/bg_paper_top.jpg) no-repeat 50% 0; background-size:1920px auto !important;}
.groundCont {background:#fdfdfd url(http://webimage.10x10.co.kr/play/ground/20150928/bg_white_paper.jpg) repeat-y 50% 0;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:100px 20px 60px;}
/* scm 등록 부분 */

@import url(https://fonts.googleapis.com/css?family=Roboto:700,400);
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

img {vertical-align:top;}
.playGr20150928 {}
.topic {height:1397px; padding:199px 0 232px; background:#f6dcbd url(http://webimage.10x10.co.kr/play/ground/20150928/bg_paper_btm.jpg) no-repeat 50% 0; text-align:center;}
.topic .hwrap {position:relative; width:258px; height:662px; margin:0 auto; padding-bottom:232px; text-align:center;}
.topic .hwrap h3 {position:absolute; top:105px; left:50%; z-index:5; width:143px; height:423px; margin-left:-71px;}
.topic .hwrap h3 .letter1, .topic .hwrap h3 .letter2, .topic .hwrap h3 .letter3 {display:block; width:143px; background:url(http://webimage.10x10.co.kr/play/ground/20150928/tit_hometown_v2.png) no-repeat 50% 0; text-indent:-999em;}
.topic .hwrap h3 .letter1 {position:absolute; top:0; left:0; height:87px;}
.topic .hwrap h3 .letter2 {position:absolute; top:140px; left:0; height:106px; background-position:50% -132px;}
.topic .hwrap h3 .letter3 {position:absolute; top:290px; left:0;  z-index:5; height:106px; background-position:50% -285px;}
.topic .hwrap h3 .letter4 {position:absolute; top:358px; right:-20px; height:75px;}
.topic .hwrap h4 {position:absolute; top:637px; left:50%; margin-left:-120px;}
.square {position:absolute; top:0; left:0; width:258px; height:602px; background:url(http://webimage.10x10.co.kr/play/ground/20150928/bg_square.png) no-repeat 50% 0;}

.topic .your {position:relative; width:869px; margin:55px auto 0; min-height:184px; padding-top:134px; background:url(http://webimage.10x10.co.kr/play/ground/20150928/bg_line.png) no-repeat 50% 0; text-align:left;}
.topic .your .btngo {position:absolute; top:54px; right:0;}

.photo {padding:195px 0 190px; background-color:#7f81a3;}
.photo .inner {position:relative; width:790px; margin:0 auto; padding-left:252px;}
.photo h4 {position:absolute; top:0; left:0;}

.instagram {height:2524px; padding-bottom:76px; background:url(http://webimage.10x10.co.kr/play/ground/20150928/bg_road.png) no-repeat 50% 0;}
.instagramList {overflow:hidden; width:1172px; height:1688px; margin:0 auto; padding-top:483px;}
.instagramList li {float:left; width:227px; height:302px; margin:77px 13px 0; padding:20px; background:url(http://webimage.10x10.co.kr/play/ground/20150928/bg_photo_frame.png) no-repeat 50% 0;}
.instagramList li a {display:block;}
.instagramList li a:hover {text-decoration:none;}
.instagramList li .article {margin-top:17px; color:#404040; font-size:13px; font-family:'Roboto', 'Noto Sans KR', sans-serif;}
.instagramList li .article p {display:inline;}
.instagramList li .figure {overflow:hidden; width:228px; height:228px;}
.instagramList li a:hover {-webkit-animation-name: bounce; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:1s; animation-name: bounce; animation-iteration-count: infinite; animation-duration:1s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:-7px; -webkit-animation-timing-function:ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-7px; animation-timing-function:ease-in;}
}

.instagramList li .id {color:#396991; font-weight:bold;}
/*.instagramList li a .figure img {transition:transform 1s ease-in-out;}
.instagramList li a:hover .figure img {transform:scale(1.1);}*/

.pageWrapV15 {margin-top:77px;}
.pageWrapV15 .pageMove {display:none;}
.paging a.arrow, .paging a, .paging a.current {background-color:transparent;}
.paging a.current {border:1px solid #8a1eca;}
.paging a.current span {color:#8a1eca;}

.memory {height:162px; background:#9ca2dc url(http://webimage.10x10.co.kr/play/ground/20150928/bg_gradition.png) no-repeat 50% 0; text-align:center;}
.memory p {overflow:hidden; padding-top:71px; width:736px; margin:0 auto; animation:keyframes 7s steps(500) infinite;}
@keyframes keyframes{
	from {width:300px;}
}
</style>
<script>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20150928">
			<div class="topic">
				<div class="hwrap">
					<h3>
						<span class="letter1">내</span>
						<span class="letter2">고</span>
						<span class="letter3">향</span>
						<span class="letter4"><img src="http://webimage.10x10.co.kr/play/ground/20150928/txt_exhibition.png" alt="전" /></span>
					</h3>
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20150928/tit_hometown_sub.png" alt="내고향 사진전" /></h4>
					<div class="square"></div>
				</div>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150928/txt_today.png" alt="오늘은 추석입니다! 고향으로 떠나서 반가운 가족, 친구들과 만나셨나요? 혹은 일이 있어 미처 가지 못하셨나요? 자주 찾아가지 못하고 명절에만 만나는 고향이지만 언제나 같은 자리에서 그 모습 그대로 나를 반겨주는 기분입니다." /></p>
				<div class="your">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150928/txt_your_hometown.png" alt="여러분의 고향은 어디인가요? 플레이에서 이미 고향에 계신 분들은 내 고향 자랑도 하고, 가지 못하신 분들은 동향인 분들을 통해 나의 고향 소식을 만나보세요!" /></p>
					<div class="btngo"><a href="#instagram"><img src="http://webimage.10x10.co.kr/play/ground/20150928/btn_go.png" alt="고향으로 떠나기" /></a></div>
				</div>
			</div>

			<div class="photo">
				<div class="inner">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20150928/tit_photo_exhibition.png" alt="내고향 사진전" /></h4>
					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150928/txt_photo_exhibition.png" alt="전시 참여 방법 고향의 사진을 촬영하거나 앨범에 저장된 고향 사진을 선택합니다. 인스타그램에 #텐바이텐고향전 해시태그와 함께 업로드 해주세요!" /></p>
					</div>
				</div>
			</div>

			<% '<!-- 인스타그램 이미지 불러오기 --> %>
			<div class="instagram" id="instagram">
				<%
				sqlstr = "Select * From "
				sqlstr = sqlstr & " ( "
				sqlstr = sqlstr & " 	Select row_Number() over (order by idx desc) as rownum, snsid, link, img_low, img_thum, img_stand, text, snsuserid, snsusername, regdate "
				sqlstr = sqlstr & " 	From db_AppWish.dbo.tbl_snsSelectData "
				sqlstr = sqlstr & " 	Where evt_code="& eCode &""
				sqlstr = sqlstr & " ) as T "
				sqlstr = sqlstr & " Where RowNum between "&(iCCurrpage*iCPageSize)-15&" And "&iCCurrpage*iCPageSize&" "
				
				'response.write sqlstr & "<br>"
				rsCTget.Open sqlstr, dbCTget, adOpenForwardOnly, adLockReadOnly
				If Not(rsCTget.bof Or rsCTget.eof) Then
				%>
					<ul class="instagramList">
						<%
						Do Until rsCTget.eof
						%>
						<% '16개 뿌리기 %>
						<li>
							<a href="<%=rsCTget("link")%>" target="_blank">
								<div class="figure"><img src="<%=rsCTget("img_stand")%>" width="228" height="228" alt="" /></div>
								<div class="article"><span class="id"><%= printUserId(rsCTget("snsusername"),2,"*") %></span> <p><%=chrbyte(stripHTML(rsCTget("text")),28,"Y")%></p></div>
							</a>
						</li>
						<%
						rsCTget.movenext
						Loop
						%>
					</ul>
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,10,"jsGoComPage") %>
					</div>
				<%
				End If
				rsCTget.close
				%>
			</div>
			<% '<!--// 인스타그램 이미지 불러오기 --> %>
		<div class="memory">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150928/txt_memory.png" alt="언제나 그 자리에서 기다려주는 고향의 아름다움을 사진으로 남겨보세요! :)" /></p>
		</div>
	</div>
</div>

<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
	<input type="hidden" name="iCC" value="1">
	<input type="hidden" name="reload" value="ON">
	<input type="hidden" name="iCTot" value="<%= iCTotCnt %>">
</form>
<script type="text/javascript">
$(function(){
	$(".btngo a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 300 ) {
			titleAnimation();
		}
		if (scrollTop > 2000 ) {
			photoAnimation();
		}
		if (scrollTop > 3800 ) {
			instagramAnimation();
		}
	});

	$(".hwrap .square").css({"height":"0"});
	$(".hwrap h3 span").css({"opacity":"0"});
	$(".hwrap h3 .letter1").css({"top":"140px"});
	$(".hwrap h3 .letter3").css({"top":"140px"});
	$(".topic .hwrap h3 .letter4").css({"right":"-20px"});
	$(".hwrap h4").css({"top":"647px", "opacity":"0"});
	function titleAnimation(){
		$(".hwrap .square").delay(200).animate({"height":"602px"},800);
		$(".hwrap h3 .letter1").delay(1000).animate({"top":"0", "opacity":"1"},1500);
		$(".hwrap h3 .letter2").delay(1000).animate({"top":"140px", "opacity":"1"},1500);
		$(".hwrap h3 .letter3").delay(1000).animate({"top":"290px", "opacity":"1"},1500);
		$(".hwrap h3 .letter4").delay(1800).animate({"right":"-10px", "opacity":"1"},1500);
		$(".hwrap h4").delay(2500).animate({"top":"637px", "opacity":"1"},1500);
	};

	function moving () {
		$(".btngo").animate({"top":"54px"},700).animate({"top":"64px"},1000, moving);
	}
	moving();

	$(".photo h4").css({"left":"15px", "opacity":"0"});
	function photoAnimation(){
		$(".photo h4").delay(200).animate({"left":"0", "opacity":"1"},1500);
	}

	$(".instagramList li").css({"margin-top":"87px", "opacity":"0"});
	$(".instagramList li:nth-child(1), .instagramList li:nth-child(2), .instagramList li:nth-child(3), .instagramList li:nth-child(4)").css({"margin-top":"77px", "opacity":"1"});
	function instagramAnimation () {
		$(".instagramList li:nth-child(5), .instagramList li:nth-child(6), .instagramList li:nth-child(7), .instagramList li:nth-child(8)").delay(800).animate({"margin-top":"77px","opacity":"1"},550);
		$(".instagramList li:nth-child(9), .instagramList li:nth-child(10), .instagramList li:nth-child(11), .instagramList li:nth-child(12)").delay(1500).animate({"margin-top":"77px","opacity":"1"},550);
		$(".instagramList li:nth-child(13), .instagramList li:nth-child(14), .instagramList li:nth-child(15), .instagramList li:nth-child(16)").delay(2000).animate({"margin-top":"77px","opacity":"1"},550);
	}

	<% if vreload<>"" then %>
		$('html,body').animate({scrollTop: $("#instagram").offset().top},'slow');
	<% end if %>
});
</script>

<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbCTclose.asp" -->