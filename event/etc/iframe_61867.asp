<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 꽃보다 예쁜 우리 엄마 
' History : 2015.04.24 유태욱
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->

<%
dim currenttime
	currenttime =  now()
	'currenttime = #04/24/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  61761
Else
	eCode   =  61867
End If

dim userid, commentcount, i
	userid = getloginuserid()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 8		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 8		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	
	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
.evt61867 {background-color:#fff; text-align:center;}
.evt61867 .article {height:1663px; background:#faf5ef url(http://webimage.10x10.co.kr/eventIMG/2015/61867/bg_illust.png) no-repeat 50% 0;}
.evt61867 .article .inner {overflow:hidden; width:1140px; margin:0 auto; padding-bottom:120px;}
.evt61867 .article .inner .col {float:left;}
.evt61867 .article .inner .col1 {position:relative; width:670px;}
.evt61867 .article .inner .col2 {position:relative; width:470px;}
.evt61867 .article .inner .col1 {padding-top:627px;}
.evt61867 .article .inner .col1 h1 {position:absolute; top:102px; left:103px; width:189px; height:412px;}
.evt61867 .article .inner .col1 h1 span {position:absolute; top:0; height:412px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61867/tit_mom.png) no-repeat 0 0; text-indent:-999em;}
.evt61867 .article .inner .col1 h1 .letter1 {left:0; width:94px;}
.evt61867 .article .inner .col1 h1 .letter2 {right:0; width:95px; background-position:100% 0;}
.evt61867 .article .inner .col2 .leaf {position:absolute; top:305px; right:40px;}
.option {padding-top:25px; padding-right:25px; text-align:right;}
.option a {margin-right:5px;}
.article .col1 .desc {position:absolute; top:230px; left:375px;}
.article .row {position:relative; width:1140px; margin:0 auto; text-align:left;}
.article .row p {margin-left:60px;}
.row .flower {position:absolute; bottom:-130px; right:-305px; z-index:5;}

.rolling {position:relative; width:547px; height:379px; margin-left:54px; padding:11px 0 20px 10px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61867/bg_slide_box.png) no-repeat 0 0; text-align:left;}
.postit {position:absolute; left:260px; top:-37px; z-index:50;}
.slide-wrap {position:relative; width:540px;}
.slide {height:379px;}
.slide img {height:379px;}
.slide .slidesjs-navigation {position:absolute; top:180px; width:21px; height:35px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61867/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:-28px; background-position:0 0;}
.slide .slidesjs-next {right:-28px; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:-41px; left:50%; z-index:50; width:140px; margin-left:-70px;}
.slidesjs-pagination li {float:left; padding:0 11px;}
.slidesjs-pagination li a {display:block; width:13px; height:13px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61867/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:100% 0;}

.commentevt {position:relative; width:1140px; margin:57px auto 0;}
.field {position:absolute; top:70px; left:532px; width:608px; text-align:left;}
.field ul {overflow:hidden; width:456px;}
.field ul li {float:left; width:50%; text-align:center;}
.field ul li label {display:block; margin-bottom:13px;}
.field textarea {width:404px; height:116px; margin-top:17px; padding:20px; border:1px solid #d7cdc1; line-height:1.5em;}
.field .btnsubmit {position:absolute; top:75px; right:60px;}
.field p {margin-top:10px; padding-left:250px;}

.commentlist {overflow:hidden; width:1127px; margin:0 auto; padding:55px 0 15px 13px;}
.commentlist .col {float:left; position:relative; width:256px; height:256px; margin:0 12px 60px; background-repeat:no-repeat; background-position:50% 100%; font-size:11px; color:#545454; text-align:center;}
.commentlist .col .no {display:block; padding-top:52px; margin-bottom:14px;}
.commentlist .col .no span {color:#7f7f7f; font-weight:normal;}
.commentlist .col .id {display:block; margin-top:20px;}
.commentlist .col .id img {vertical-align:middle;}
.commentlist .col .msg {line-height:1.688em; word-break:break-all;}
.commentlist .col1 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/61867/bg_comment_box_01.png);}
.commentlist .col2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/61867/bg_comment_box_02.png);}
.commentlist .col3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/61867/bg_comment_box_03.png);}
.commentlist .col4 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/61867/bg_comment_box_04.png);}
.btndel {position:absolute; top:32px; right:35px; width:23px; height:23px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61867/btn_del.png) no-repeat 50% 0; text-indent:-999em;}

/* tiny scrollbar */
.scrollbarwrap {width:158px; margin:0 auto;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:150px; height:86px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#d7e1a1;}
.scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#d7e1a1;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#8c9e29; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
.noSelect {user-select:none; -o-user-select:none; -moz-user-select:none; -khtml-user-select:none; -webkit-user-select:none;}

.pageWrapV15 {width:1140px; margin:0 auto; *margin:60px auto 0;}

/* animation effect */
.leaf {-webkit-animation: swinging 30s ease-in-out 0s infinite; -moz-animation: swinging 30s ease-in-out 0s infinite; -ms-animation: swinging 30s ease-in-out 0s infinite;}
@-webkit-keyframes swinging {
	0% { -webkit-transform: rotate(0); }
	10% { -webkit-transform: translate(10px,0px) rotate(-5deg); }
	15% { -webkit-transform: translate(-15px,0px) rotate(5deg); }
	20% { -webkit-transform: translate(15px,0px) rotate(-6deg); }
	30% { -webkit-transform: translate(15px,0px) rotate(-4deg); }
	40% { -webkit-transform: translate(5px,0px) rotate(-2deg); }
	100% { -webkit-transform: rotate(0); }
}
@-moz-keyframes swinging {
	0% { -moz-transform: rotate(0); }
	10% { -moz-transform: translate(10px,0px) rotate(-5deg); }
	15% { -moz-transform: translate(-15px,0px) rotate(5deg); }
	20% { -moz-transform: translate(15px,0px) rotate(-6deg); }
	30% { -moz-transform: translate(15px,0px) rotate(-4deg); }
	40% { -moz-transform: translate(5px,0px) rotate(-2deg); }
	70% { -moz-transform: translate(0px,0px) rotate(0); }
	100% { -moz-transform: rotate(0); }
}
@-ms-keyframes swinging {
	0% { -ms-transform: rotate(0); }
	10% { -ms-transform: translate(10px,0px) rotate(-5deg); }
	15% { -ms-transform: translate(-15px,0px) rotate(5deg); }
	20% { -ms-transform: translate(15px,0px) rotate(-6deg); }
	30% { -ms-transform: translate(15px,0px) rotate(-4deg); }
	40% { -ms-transform: translate(5px,0px) rotate(-2deg); }
	70% { -ms-transform: translate(0px,0px) rotate(0); }
	100% { -ms-transform: rotate(0); }
}
</style>
<script type="text/javascript">

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2015-04-24" and left(currenttime,10)<"2015-05-01" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>5 then %>
				alert("이벤트는 5회까지 응모하실수 있습니다.\n5월 1일(금) 당첨자 발표를 기다려 주세요!");
				return false;
			<% else %>
				var tmpdateval='';
				for (var i=0; i < frm.dateval.length; i++){
					if (frm.dateval[i].checked){
						tmpdateval = frm.dateval[i].value;
					}
				}
				if (tmpdateval==''){
					alert('촬영을원하는 날짜를 선택해 주세요.');
					return false;
				}
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 400 || frm.txtcomm1.value == '원하는 날짜를 선택하고 엄마와 나의 이야기를 들려주세요 : ) (200자 이내)'){
					alert("원하는 날짜를 선택하고\n엄마와 나의 이야기를 들려주세요.\n200자 까지 작성 가능합니다.");
					frm.txtcomm1.focus();
					return false;
				}

			   frm.txtcomm.value = tmpdateval + "|!/" +frm.txtcomm1.value
			   frm.action = "/event/lib/comment_process.asp";
			   frm.submit();
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}

function jsDelComment(cidx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.Cidx.value = cidx;
   		document.frmdelcom.submit();
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	}

	if (frmcom.txtcomm1.value == '원하는 날짜를 선택하고 엄마와 나의 이야기를 들려주세요 : ) (200자 이내)'){
		frmcom.txtcomm1.value = '';
	}
}

//내코멘트 보기
function fnMyComment() {
	document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.frmcom.iCC.value=1;
	document.frmcom.submit();
}

</script>
</head>
<body>
<!-- iframe -->
<div class="evt61867">
	<div class="article">
		<div class="inner">
			<div class="col col1">
				<h1>
					<span class="letter1">꽃보다 예쁜</span>
					<span class="letter2">우리 엄마</span>
				</h1>
				<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/txt_still_beautiful.png" alt="여전히 아름다운 엄마와 딸의 추억 만들기" /></p>

				<div class="rolling">
					<span class="postit"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/img_post_it.png" alt="" /></span>
					<div class="slide-wrap">
						<div id="slide1" class="slide">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/img_slide_01.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/img_slide_02.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/img_slide_03.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/img_slide_04.jpg" alt="" />
						</div>
					</div>
				</div>
			</div>

			<div class="col col2">
				<div id="option" class="option">
					<a href="#commentevt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/btn_comment.png" alt="코멘트 남기러 가기" /></a>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/ico_only.png" alt="오직 텐바이텐에서만 만나실 수 있습니다." /></span>
				</div>
				<span class="leaf"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/img_leaf.png" alt="" /></span>
				<p style="margin-top:350px;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/txt_collabo.png" alt="텐바이텐 PLAY GROUND 5월 주제는 우리를 설레게 하는, 달콤하고 아름다운 꽃 FLOWER 입니다. 세상에는 수많은 꽃들이 있습니다. 텐바이텐 플레이는 꽃처럼 아름다운 것에 대해 생각하다 ’엄마’를 떠올렸습니다. 언제나, 그 자리에서 지친 일상에 좋은 향기가 되어주는 우리 엄마. 흔히 친구, 남자친구 또는 새로 맞이하는 남편과 추억을 담는 화보. 이번만큼은 여전히 아름답게 피고 있는 엄마와의 화보를 촬영해드립니다. 우리의 프로젝트를 함께 해 줄 엄마와 딸을 기다립니다" /></p>
				<p style="margin-top:47px;">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/txt_lalasnap.png" alt="랄라스냅은 남는 건 사진뿐이라는 슬로건 아래 기존 웨딩 촬영과는 차별화된 촬영으로 특별한 날을 아름다운 추억으로 남겨드립니다. 일대일 맞춤으로 스페셜한 웨딩 촬영을 추구하며, 빈티지한 색감과 동화 같은 콘셉트로 꽃과 함께 하는 스냅사진을 전문적으로 촬영합니다." usemap="#sitelink" />
					<map name="sitelink" id="sitelink">
						<area shape="rect" coords="206,170,314,190" href="http://www.lalasnap.com/xe/" target="_blank" title="새창" alt="랄라스냅 홈페이지 바로가기" />
						<area shape="rect" coords="205,195,305,214" href="http://lalasnap_.blog.me" target="_blank" title="새창" alt="랄라스냅 블로그 바로가기" />
					</map>
				</p>
			</div>
		</div>

		<div class="row">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/txt_way.png" alt="촬영 가능한 날짜를 선택 후 사연과 함께 응모를 하시면 당첨발표 후 사전미팅이 진행됩니다. 사진 촬영 진행 및 간단한 인터뷰를 한 후 촬영 내용을 바탕으로 텐바이텐 PLAY 컨텐츠로 5월 11일 오픈 예정입니다." /></p>
			<p style="margin-top:75px;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/txt_noti.png" alt="본 이벤트는 화보사진과 메이킹 영상, 간단한 인터뷰 내용이 추후 PLAY 컨텐츠 제작에 활용되는 것’에 동의해주셔야 합니다. 최종 노출 사진은 당첨자와의 협의하에 선정됩니다. 스냅사진 촬영 시 메이킹영상 촬영이 함께 진행될 예정입니다. 엄마와 딸의 촬영을 원칙으로 하되, 신청자의 구분은 없습니다. 촬영일 5일 전까지만 취소가 가능하며, 신청하신 해당 날짜에는 취소 및 변경이 불가능합니다. 촬영지는 야외로 예정되어 있으나, 우천시 실내 스튜디오에서 진행됩니다. 촬영 시간은 최소 약 3시간이 소요될 예정입니다. 당첨자는 촬영 전 사전미팅을 필수로 하며, 미팅 일시는 추후 협의하여 진행합니다." /></p>
			<span class="flower"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/img_flower.png" alt="" /></span>
		</div>
	</div>

	<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="com_egC" value="<%=com_egCode%>">
	<input type="hidden" name="bidx" value="<%=bidx%>">
	<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
	<input type="hidden" name="iCTot" value="">
	<input type="hidden" name="mode" value="add">
	<input type="hidden" name="spoint" value="0">
	<input type="hidden" name="isMC" value="<%=isMyComm%>">
	<input type="hidden" name="txtcomm">
	<!-- comment event -->
	<div id="commentevt" class="commentevt">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/txt_comment_event.png" alt="아름다운 엄머와 딸의 향기로운 추억 만들기 화보 촬영을 원하는 날짜를 선택하고 엄마와 나의 이야기를 들려주세요! 당첨된 모녀 한 쌍에게 화보를 촬영해 드립니다 이벤트 기간은 2015월 4월 24일 금요일부터 4월 30일 목요일 까지며 첨자 발표는 2015년 5월 1일 금요일입니다." ></p>
		<div class="field">
			<fieldset>
			<legend>화보 촬영을 원하는 날짜를 선택하고 엄마와 나의 이야기 쓰기</legend>
				<ul>
					<li>
						<label for="selectDate01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/txt_label_01.png" alt="5월 8일 금요일" /></label>
						<input type="radio" name="dateval" value="1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" id="selectDate01" name="" />
					</li>
					<li>
						<label for="selectDate02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/txt_label_02.png" alt="5월 10일 일요일" /></label>
						<input type="radio" name="dateval" value="2" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" id="selectDate02" name="" />
					</li>
				</ul>
				<textarea name="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="60" rows="5" title="엄마와 나의 이야기 쓰기"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>원하는 날짜를 선택하고 엄마와 나의 이야기를 들려주세요 : ) (200자 이내)<%END IF%></textarea>
				<div class="btnsubmit"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/61867/btn_submit.png" onclick="jsSubmitComment(frmcom); return false;" alt="응모하기" /></div>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/txt_check.png" alt="꼭 공지사항을 확인 후 응모 부탁드립니다!" /></p>
			</fieldset>
		</div>
	</div>
	</form>
	<!-- comment list -->
	<div class="commentlist">
		<%
		IF isArray(arrCList) THEN
			dim rndNo : rndNo = 1
			
			For intCLoop = 0 To UBound(arrCList,2)
			
			randomize
			rndNo = Int((4 * Rnd) + 1)
		%>
		<% '<!-- for dev msg : <div class="col">...</div>이 한 묶음입니다. col1 ~ col4 랜덤으로 클래스명 뿌려주세요 --> %>
		<% '<!-- for dev msg : 한페이지당 8개 --> %>
		<div class="col col<%=rndNo%>">
			<strong class="no">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%>
				<span>l</span>
				<% if isarray(split(arrCList(1,intCLoop),"|!/")) then %>
					<% if ubound(split(arrCList(1,intCLoop),"|!/")) > 0 then %>
						<% if ReplaceBracket(db2html( split(arrCList(1,intCLoop),"|!/")(0) )) = 1 then response.write "5월8일" else response.write "5월10일" %>
					<% end if %>
				<% end if %>
			</strong>
			<div class="scrollbarwrap">
				<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
				<div class="viewport">
					<div class="overview">
						<!-- for dev msg : 코멘트 글 -->
						<p class="msg">
							<% if isarray(split(arrCList(1,intCLoop),"|!/")) then %>
								<% if ubound(split(arrCList(1,intCLoop),"|!/")) > 0 then %>
									<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"|!/")(1) ))%>
								<% end if %>
							<% end if %>
						</p>
					</div>
				</div>
			</div>
			<span class="id">
				<% If arrCList(8,i) <> "W" Then %>
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/61867/ico_mobile.png" alt="모바일에서 작성" />
				<% end if %>
				<%=printUserId(arrCList(2,intCLoop),2,"*")%>
			</span>
			<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
				<button type="button"onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;" class="btndel">삭제</button>
			<% end if %>
		</div>
		<%
			Next
		end if
		%>	
	</div>

	<% IF isArray(arrCList) THEN %>
		<div class="pageWrapV15 tMar20">
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
	<% end if %>

	<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="com_egC" value="<%=com_egCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="Cidx" value="">
		<input type="hidden" name="mode" value="del">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
	</form>

</div>
<!-- for dev msg : 스크립트 꼭 넣어주세요! -->
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});

$(function(){
	/* skip to comment */
	$("#option a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});

	/* label select */
	$(".commentevt ul li label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});

	/* slide */
	$('#slide1').slidesjs({
		width:"540",
		height:"379",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:1500, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide1').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$(".article h1 .letter1").css({"width":"0", "margin-top":"-20px"});
	$(".article h1 .letter2").css({"width":"0", "margin-top":"30px"});
	$(".article .desc").css({"opacity":"0", "margin-top":"30px"});
	function showtext () {
		$(".article h1 .letter1").delay(100).animate({"width":"94px", "margin-top":"0"},800);
		$(".article h1 .letter2").delay(1000).animate({"width":"95px", "margin-top":"0"},800);
		$(".article .desc").delay(1800).animate({"opacity":"1", "margin-top":"0"},1000);
	}
	showtext();

	function moving () {
		$(".flower").animate({"margin-bottom":"-10px"},1000).animate({"margin-bottom":"0"},3000, moving);
	}
	moving();
});
</script>
</body>
</html>
<!-- #include virtual="/lib/poptailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->