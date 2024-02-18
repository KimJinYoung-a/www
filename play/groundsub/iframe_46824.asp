<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'#### 2013-11-07 이종화 작성 ###################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21003
Else
	eCode   =  46824
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

	iCPageSize = 16		'한 페이지의 보여지는 열의 수
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

	   if(!frm.txtcomm.value||frm.txtcomm.value=="10자 이내"){
	    alert("코멘트를 입력해주세요");
		document.frmcom.txtcomm.value="";
	    frm.txtcomm.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.txtcomm.value)>50){
			alert('10자 이내');
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
			if(document.frmcom.txtcomm.value =="10자 이내"){
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
			document.frmcom.txtcomm.value="10자 이내";
		}
	}

	function Limit(obj)
	{
	   var maxLength = parseInt(obj.getAttribute("maxlength"));
	   if ( obj.value.length > maxLength ) {
		alert("10자 이내");
		obj.value = obj.value.substring(0,maxLength); //100자 이하 튕기기
		}
	}

//-->
</script>
<style type="text/css">
img {vertical-align:top;}
.groundCont {position:relative; background-color:#ede3d1; background-size:100% 288px; min-width:1140px;}
.groundCont .grArea {}
.groundCont .tagView {padding:60px 20px;}
.playGr1111 {padding:115px 0 70px 0;; background:#ede3d1 url(http://webimage.10x10.co.kr/play/ground/20131111/bg_line.gif) repeat-x left bottom;}
.playGr1111 .courageMsg {overflow:hidden; padding-top:74px;}
.playGr1111 .courageMsg h3 {float:left; width:375px;}
.playGr1111 .courageMsg .msg {float:left; width:765px; margin-top:-45px;}
.playGr1111 .courageMsg .msg h4 {margin-top:45px; padding-bottom:15px;}
.playGr1111 .courageMsg .msg .snsLink span {padding:0 6px;}
.playGr1111 .courageMsg .msg .snsLink img {vertical-align:top;}
.playGr1111 .courageMsg .msg .btnEvent {overflow:hidden; height:40px; margin-top:15px;}
.playGr1111 .courageMsg .msg .btnEvent a:hover img {margin-top:-40px;}
.playGr1111 .work {padding-top:90px;}
.playGr1111 .work ol {overflow:hidden; padding-top:15px;}
.playGr1111 .work ol li {float:left;}
.playGr1111 .work ol li img {vertical-align:top;}
.playGr1111 .detail {padding-top:100px;}
.playGr1111 .detail h3 {padding-bottom:11px; border-bottom:1px solid #decdae;}
.playGr1111 .detail .ex {padding:48px 0 50px 0; border-top:1px solid #f8f4ed;;}
.playGr1111 .slide {position:relative; width:1140px;}
.playGr1111 .slide .slidesjs-container {height:540px;}
.playGr1111 .slide .slidesjs-navigation {display:block; position:absolute; top:251px; z-index:200; width:20px; height:39px; text-indent:-999em;}
.playGr1111 .slide .slidesjs-previous {left:20px; background:url(http://webimage.10x10.co.kr/play/ground/20131111/btn_navigation.gif) left top no-repeat;}
.playGr1111 .slide .slidesjs-previous:hover {background:url(http://webimage.10x10.co.kr/play/ground/20131111/btn_navigation.gif) left bottom no-repeat;}
.playGr1111 .slide .slidesjs-next {right:20px; background:url(http://webimage.10x10.co.kr/play/ground/20131111/btn_navigation.gif) right top no-repeat;}
.playGr1111 .slide .slidesjs-next:hover {background:url(http://webimage.10x10.co.kr/play/ground/20131111/btn_navigation.gif) right bottom no-repeat;}
.playGr1111 .comment h3 {padding:120px 0 14px;}
.playGr1111 .commentForm {position:relative; padding:30px; border:6px solid #fff;}
.playGr1111 .commentForm .inputBox {padding:23px 0 24px;}
.playGr1111 .commentForm .inputBox input {border:0; color:#000; font-weight:bold;}
.playGr1111 .commentForm .inputBox .txtInp {width:505px; height:28px; margin-right:4px; border:1px solid #fff; line-height:30px;}
.playGr1111 .commentForm .inputBox .offInput {border:1px solid #fff;}
.playGr1111 .commentForm .inputBox .onInput {border:1px solid #fc8f76;}
.playGr1111 .commentForm .inputBox .btn {width:130px; height:40px; background-color:#f04a24; color:#fff;}
.playGr1111 .commentForm .inputBox .btn:hover, .playGr1111 .commentForm .inputBox .btn:focus {background-color:#d22f0a;}
.playGr1111 .commentForm .date {position:absolute; right:40px; top:108px; height:131px; padding-left:70px; border-left:1px solid #fff;}
.playGr1111 .commentForm .date li {padding-bottom:20px;}
.playGr1111 .commentList ul {overflow:hidden; width:1160px; margin-right:-20px; padding-bottom:70px;}
.playGr1111 .commentList ul li {float:left; width:270px; height:270px; margin:30px 20px 0 0; background:url(http://webimage.10x10.co.kr/play/ground/20131111/bg_comment_bowl.gif) no-repeat left top;}
.playGr1111 .commentList ul li .msg {width:200px; height:200px; margin:30px auto 25px; font-family:Batang, Verdana; color:#444; font-size:14px; text-align:center;}
.playGr1111 .commentList ul li .msg strong {display:table-cell; *display:block; width:100px; height:200px; padding:0 50px; *padding-top:70px; vertical-align:middle; word-break:break-all;}
.playGr1111 .commentList ul li .writer {color:#c89880; text-align:right;}
.playGr1111 .commentList ul li .writer em {font-weight:bold;}
.playGr1111 .comment .paging a, .playGr1111 .comment .paging a.arrow {background-color:#ede3d1;}
.playGr1111 .comment .paging a:hover {background-color:#ececec;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.slide').slidesjs({
		height:'540px',
		navigation: {effect: "slide"},
		pagination: {active:false},
		play: {interval:3000, effect: "slide", auto: true}
	});
});
</script>
<div class="playGr1111">
	<p><img src="http://webimage.10x10.co.kr/play/ground/20131111/txt_bowl_fill.gif" alt="당신의 용기를 채워 드릴게요 밤삼킨별 X TENBYTEN PROJECT" /></p>
	<div class="courageMsg">
		<h3><img src="http://webimage.10x10.co.kr/play/ground/20131111/tit_courage_message.gif" alt="COURAGE MESSAGE BOWL PROJECT 용기에 용기를 담다" /></h3>
		<div class="msg">
			<h4><img src="http://webimage.10x10.co.kr/play/ground/20131111/tit_message.gif" alt="용기에 용기를 담다." /></h4>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20131111/txt_message.gif" alt="캘리그라피 작가 밤삼킨별과 함께하는 용기 프로젝트. PLAY의 두 번째 프로젝트는 따뜻함을 채우는 그릇, 보울[bowl]입니다. 하루에도 몇 번을 채우고 비워내는 역할을 하는 보울. 힘이 들때 누군가 나에게 해줬던 작은 말 한마디가 큰 용기가 되었던 기억은 누구나 한번쯤 경험 해 보았을 것 입니다. 그 따스한 경험을 떠올릴 수 있도록 우리가 매일 마주보는 보울에 담아보는 것으로 이야기는 시작되었습니다. 국 한그릇, 면 한사발로 든든히 배를 채우고 마지막 메세지까지 당신의 마음을 따뜻하게 할 수 있다면 좋겠습니다. 지금 용기가 필요한 나 혹은 주변의 사람들에게 메시지를 전해보세요. 용기에 담긴 음식을 먹고 난 후 당신의 메시지를 기억할 것입니다." /></p>
			<h4><img src="http://webimage.10x10.co.kr/play/ground/20131111/tit_author.gif" alt="밤삼킨별 작가 김 효 정" /></h4>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20131111/txt_about_author.gif" alt="다정한 감성으로 글을 쓰고, 감성 가득한 사진을 찍고, 따뜻한 손글씨를 쓰고, 그림을 그리고, 강의를 하고, 전 세계를 일을 하러 떠나는 출장여행을 하고, 의미있는 일을 기쁜 마음으로 함께 하며, 부엉이를 찾아 모으는 감수성 충만한 여자. 열일곱살때부터 꿈꾸던 카페를 20년이 흘러 홍대 골목에 마켓 밤삼킨별이란 이름으로 오픈한 카페 주인. 이런 모든 것을 밤삼킨별이란 필명에 녹이며 온라인과 오프라인을 통해 글과 사진, 그리고 강연을 통해 나의 이야기지만, 우리 모두의 이야기를 하는 오래 좋아하는 것이 재주라면 재주인 사람." /></p>
			<div class="snsLink">
				<a href="http://facebook.com/bamsamkinbyul" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20131111/txt_facebook.gif" alt="페이스북 facebook.com/bamsamkinbyul" /></a>
				<span><img src="http://webimage.10x10.co.kr/play/ground/20131111/blt_hypen.gif" alt="" /></span>
				<a href="http://blog.naver.com/bamsamkinbul/" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20131111/txt_blog.gif" alt="블로그 blog.naver.com/bamsamkinbul" /></a>
			</div>
			<h4><img src="http://webimage.10x10.co.kr/play/ground/20131111/tit_event.gif" alt="참여 이벤트" /></h4>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20131111/txt_event.gif" alt="용기 가득 멋진 말을 작성해 주신 5분께 면기 안쪽 바닥 면에 밤삼킨별의 캘리가 새겨진 에디션 면기를 선물로 드립니다." /></p>
			<div class="btnEvent"><a href="#commentEvent"><img src="http://webimage.10x10.co.kr/play/ground/20131111/btn_comment_event.gif" alt="코멘트 이벤트 참여하기" /></a></div>
		</div>
	</div>

	<div class="work">
		<h3><img src="http://webimage.10x10.co.kr/play/ground/20131111/tit_work.gif" alt="WORK" /></h3>
		<ol>
			<li><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_work_01.jpg" alt="먼저 초벌해 놓은 동그란 보울을 준비합니다." /></li>
			<li><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_work_02.jpg" alt="보울에 들어갈 캘리그라피를 연습해 봅니다." /></li>
			<li><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_work_03.jpg" alt="동그란 보울에 정성을 담아 한 글자, 한 글자 용기를 새깁니다. " /></li>
			<li><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_work_04.jpg" alt="캘리그라피가 적힌 보울에 유약을 고르게 시유해줍니다" /></li>
			<li><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_work_05.jpg" alt="보울을 굽기 전에 유약이 잘 고르게 발라졌는지, 꼼꼼하게 고르게 손질하여 마무리 작업을 해줍니다." /></li>
			<li><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_work_06.jpg" alt="1250도의 뜨거운 가마에서 보울을 재벌을 하면 당신의 용기를 채울 보울이 완성됩니다. " /></li>
		</ol>
	</div>

	<div class="detail">
		<h3><img src="http://webimage.10x10.co.kr/play/ground/20131111/tit_detail.gif" alt="DETAIL [보울 사이즈 : 15x9x25cm]" /></h3>
		<div class="ex"><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_bowl.gif" alt="BOWL" /></div>

		<div class="slide">
			<div><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_slide_01.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_slide_02.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_slide_03.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20131111/img_slide_04.jpg" alt="" /></div>
		</div>
	</div>
	<div class="comment"  id="commentEvent">
		<h3><img src="http://webimage.10x10.co.kr/play/ground/20131111/tit_comment_event.gif" alt="COMMENT EVENT" /></h3>
		<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
		<input type="hidden" name="iCTot" value="">
		<input type="hidden" name="mode" value="add">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
		<fieldset>
		<legend>메시지 입력</legend>
			<div class="commentForm">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20131111/tit_comment_message.gif" alt="밤삼킨별의 캘리가 새겨진 edition bowl을 만들어 드립니다. 나 또는 지인에게 용기를 주는 메시지를 적어주세요. (10자 이내)" /></p>
				<div class="inputBox">
					<input type="text" name="txtcomm" title="메시지 입력" value="10자 이내" class="txtInp"  onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur()" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');return Limit(this);" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%>  autocomplete="off" maxlength="10"/>
					<input type="submit" value="신청하기" class="btn" />
				</div>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20131111/tit_comment_notice.gif" alt="용기 가득 멋진 말을 작성해 주신 5분께 면기 안쪽 바닥 면에 밤삼킨별의 캘리그라피가 새겨진 에디션 면기를 선물로 드립니다. 당첨자 발표 후 약 15일 이상의 제작기간이 소요 됩니다." /></p>
				<ul class="date">
					<li><img src="http://webimage.10x10.co.kr/play/ground/20131111/txt_date_01.gif" alt="기간 : 11.11 ~ 11.30" /></li>
					<li><img src="http://webimage.10x10.co.kr/play/ground/20131111/txt_date_02.gif" alt="당첨자발표 : 12.02" /></li>
					<li><img src="http://webimage.10x10.co.kr/play/ground/20131111/txt_date_03.gif" alt="배송일 : 12.23 [일괄배송]" /></li>
				</ul>
			</div>
		</fieldset>
		</form>
		<form name="frmdelcom" method="post" action="/event/lib/comment_process.asp" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="Cidx" value="">
		<input type="hidden" name="mode" value="del">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
		</form>
		<% IF isArray(arrCList) THEN %>
		<div class="commentList">
			<ul>
				<%For intCLoop = 0 To UBound(arrCList,2)%>
				<li>
					<p class="msg"><strong><%=db2html(arrCList(1,intCLoop))%></strong></p>
					<div class="writer"><span><%=printUserId(arrCList(2,intCLoop),2,"*")%>님</span> <em>No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></em>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<a href="javascript:jsDelComment('<% = arrCList(0,intCLoop) %>')"><img src="http://fiximage.10x10.co.kr/web2009/common/cmt_del.gif" width="19" height="11" style="padding-left:5px;" border="0"></a>
					<% end if %>
					</div>
				</li>
				<% Next %>
			</ul>
		</div>
		<% End If %>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->