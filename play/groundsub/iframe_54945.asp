<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' Play-sub 안아줘요 셔츠맨!
' 2014-09-12 이종화 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21299
Else
	eCode   =  54945
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
<style type="text/css">
img {vertical-align:top;}
.shirtman .heading {position:relative; height:991px; background-color:#f6f6f6;}
.shirtman .heading .group {position:relative; z-index:10; width:1140px; margin:0 auto; padding-top:168px;}
.shirtman .heading .group h3 {padding:0 0 49px 151px; border-bottom:1px solid #e5e5e5;}
.shirtman .heading .group .define {position:relative; padding:56px 0 0 329px; border-top:1px solid #fff;}
.shirtman .heading .group .define .hug {position:absolute; top:58px; left:0;}
.shirtman .heading .group .define .btn-apply {position:absolute; top:87px; right:152px;}
.shirtman .heading .lonely {position:absolute; top:165px; left:0; z-index:5;}
.shirtman .full img {width:100%; min-width:1140px;}
.shirtman .about {position:relative; width:420px; margin:0 auto; padding:234px 0 260px 720px;}
.shirtman .about .figure {position:absolute; top:225px; left:92px;}
.shirtman .about h4 {margin-bottom:45px;}
.shirtman .about p {margin-top:37px;}
.shirtman .scene1 {position:relative;}
.shirtman .scene1 p {position:absolute; top:35%; left:19%;}
.shirtman .scene2 {position:relative;}
.shirtman .scene2 p {position:absolute; top:42%; left:52%;}
.shirtman .scene3 {position:relative;}
.shirtman .scene3 p {position:absolute; top:45%; left:19%;}
.shirtman .comment-event {position:relative; width:1140px; margin:0 auto; padding:133px 0 82px; text-align:center;}
.shirtman .comment-event h4 {margin-bottom:44px;}
.shirtman .comment-event p {margin-top:33px;}
.shirtman .comment-event ul {overflow:hidden; padding:60px 0 0 53px;}
.shirtman .comment-event ul li {float:left; padding:0 20px;}
.shirtman .comment-event ul li label {display:block; margin-top:16px;}
.shirtman .comment-event .write {position:absolute; right:0; bottom:160px; width:258px; height:180px; padding:25px 46px 35px 36px; background:url(http://webimage.10x10.co.kr/play/ground/20140915/bg_note.gif) no-repeat 0 0; text-align:left;}
.shirtman .comment-event .write textarea {overflow:hidden; width:258px; height:150px; margin:12px 0 0; padding:0; border:0; background-color:transparent; color:#999; font-size:12px; line-height:2em;}
.shirtman .comment-event .btn-submit {position:absolute; right:83px; bottom:110px;}
.shirtman .comment-list {padding-bottom:131px; background-color:#f6f6f6;}
.shirtman .comment-list .comment-shirt {overflow:hidden; width:1140px; margin:0 auto;}
.shirtman .comment-list .comment-shirt .shirt {float:left; position:relative; margin-top:70px; width:182px; height:310px; margin-right:57px; padding:10px 30px; background-repeat:no-repeat; background-position:0 0;}
.shirtman .comment-list .comment-shirt .color01 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140915/bg_shirt_01.gif);}
.shirtman .comment-list .comment-shirt .color02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140915/bg_shirt_02.gif);}
.shirtman .comment-list .comment-shirt .color03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140915/bg_shirt_03.gif);}
.shirtman .comment-list .comment-shirt .shirt .num {display:block; width:82px; height:115px; margin:0 auto; color:#fff; font-family:'Dotum', 'Verdana'; font-size:11px; text-align:center;}
.shirtman .comment-list .comment-shirt .shirt .num span {display:block;}
.shirtman .comment-list .comment-shirt .shirt .num img {margin-top:2px;}
.shirtman .comment-list .comment-shirt .shirt strong {display:block; color:#555; font-size:13px; font-family:'Dotum', 'Verdana'; text-align:right;}
.shirtman .comment-list .comment-shirt .shirt .reason {overflow:hidden; height:145px; margin-top:16px; color:#555; font-family:'Dotum', 'Verdana'; font-size:13px; line-height:1.313em;}
.shirtman .comment-list .comment-shirt .shirt .btnDel {position:absolute; right:-5px; top:15px; width:21px; height:21px; background:url(http://webimage.10x10.co.kr/play/ground/20140915/btn_del.png) no-repeat 0 0; text-indent:-999em;}
.shirtman .comment-list .note {margin-top:80px; text-align:center;}
.shirtman .comment-list .note span {padding-bottom:2px; border-bottom:1px solid #d9d9d9; color:#888;}
.shirtman .comment-list .note img {vertical-align:middle;}
.shirtman .comment-list .paging {width:1140px; margin:30px auto 0; padding-bottom:70px; border-bottom:1px solid #e8e8e8;}
.shirtman .comment-list .paging a {background-color:transparent;}
.pageWrapV15 {width:1140px; margin:0 auto;}
</style>
<script type="text/javascript">
$(function(){
	$(".cmtField label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});
	// Label Select

	$(".lonely").css("left", "0");
	function movinglonely() {
		$(".lonely").animate({"margin-left":"77px"},10000, movinglonely);
	}
	movinglonely();

	$(".btn-apply a img").hover(function() {
		$(this).stop().animate({marginTop: "5px"}, 200);
		},function(){
		$(this).stop().animate({marginTop: "0px"}, 300);
	});

	$(".comment-shirt .shirt:nth-child(4)").css("margin-right", "0");
	$(".comment-shirt .shirt:nth-child(8)").css("margin-right", "0");
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

	   
	   if(!(frm.spoint[0].checked||frm.spoint[1].checked||frm.spoint[2].checked)){
	    alert("셔츠맨을 선택 해주세요");
	    return false;
	   }

	    if(!frm.txtcomm.value || frm.txtcomm.value == "100자 이내로 입력해주세요." ){
	    alert("100자 이내로 입력해주세요.");
		document.frmcom.txtcomm.value="";
	    frm.txtcomm.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.txtcomm.value)>201){
			alert('100자 까지 가능합니다.');
	    frm.txtcomm.focus();
	    return false;
		}

	   frm.action = "doEventSubscript54945.asp";
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
<div class="playGr20140915">
	<div class="shirtman">
		<div class="section heading">
			<div class="group">
				<h3><img src="http://webimage.10x10.co.kr/play/ground/20140915/tit_shirt_man.png" alt="안아줘요 셔츠맨!" /></h3>
				<div class="define">
					<p class="hug"><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_define.png" alt="안다의 사전적 의미는 두 팔을 벌려 가슴 쪽으로 끌어당기거나 그렇게 하여 품 안에 있게 하다" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_shirtman.png" alt="당신을 힘껏 안아 줄 셔츠맨! 셔츠를 생각했을 때, 왠지 등과 어깨가 넓은 남자가 떠올랐어요. 그 셔츠맨은 내가 힘들거 나 외로울 때, 아무 이유 없이, 나를 꽈악 안아 주었으면 좋겠다고 생각이 들었죠. 언제나 옆에서 위로해 줄 것만 같은 따뜻하고 포근한 느낌. 그런 든든한 느낌이 좋았어요. 그래서 텐바이텐 PLAY는 안아줘요. 셔츠맨을 만들었습니다. 이 세상 외로운 누군가에게 주는 작은 위로, 셔츠맨. 텐바이텐이 한 땀 한 땀 제작한 셔츠-맨을 만나보세요! 당신을 두팔 벌려 꽈악 안아 드립니다! " /></p>
					<div class="btn-apply"><a href="#comment-event"><img src="http://webimage.10x10.co.kr/play/ground/20140915/btn_apply.png" alt="셔츠맨 신청하러 가기" /></a></div>
				</div>
			</div>
			<p class="lonely"><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_dont_be_lonely.png" alt="Don&apos;t be lonely" /></p>
		</div>

		<div class="section visual">
			<div class="full"><img src="http://webimage.10x10.co.kr/play/ground/20140915/img_hug_shirtman.jpg" alt="셔츠맨과 안고 있는 모습" /></div>
		</div>

		<div class="section about">
			<div class="figure"><img src="http://webimage.10x10.co.kr/play/ground/20140915/img_about_shirtman.jpg" alt="" /></div>
			<h4><img src="http://webimage.10x10.co.kr/play/ground/20140915/tit_about_shirtman.gif" alt="ABOUT SHIRTS MAN" /></h4>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_about_shirtman.gif" alt="셔츠맨은 듬직한 어깨와 넓은 가슴을 가진 남자이자, 포근함을 간직한 바디 필로우입니다. 허리까지 제작되어 있으며, 셔츠는 언제든 이상형에 맞게 바꿔줄 수 있어요" /></p>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_size_information.gif" alt="셔츠맨은 세로 100센치미터, 어깨 50센치미터이며 M사이즈 착용합니다. 사이즈는 조금씩 달라질 수 있습니다." /></p>
		</div>

		<div class="section scene1">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_scene_01.png" alt="마음껏 기대요 당신이 지치는 순간에는 언제나 옆에 함께 할 거예요" /></p>
			<div class="full"><img src="http://webimage.10x10.co.kr/play/ground/20140915/img_scene_01.jpg" alt="" /></div>
		</div>

		<div class="section scene2">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_scene_02.png" alt="어깨를 빌려줄게요 작은 휴식의 순간에도 조금 더 편히 쉴 수 있도록 든든한 어깨를 빌려줄게요" /></p>
			<div class="full"><img src="http://webimage.10x10.co.kr/play/ground/20140915/img_scene_02.jpg" alt="" /></div>
		</div>

		<div class="section scene3">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_scene_03.png" alt="안아줄게요 당신의 몸과 마음이 따뜻해질 수 있도록 당신을 꼬옥 안아 드릴게요" /></p>
			<div class="full"><img src="http://webimage.10x10.co.kr/play/ground/20140915/img_scene_03.jpg" alt="" /></div>
		</div>
		
		<!-- comment -->
		<div id="comment-event" class="section comment-event">
			<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>"/>
			<input type="hidden" name="bidx" value="<%=bidx%>"/>
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
			<input type="hidden" name="iCTot" value=""/>
			<input type="hidden" name="mode" value="add"/>
			<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
				<fieldset>
				<legend>나의 이상형 작성하기</legend>
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20140915/tit_comment_event.gif" alt="코멘트 이벤트" /></h4>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_comment_event.gif" alt="마음에 드는 셔츠맨을 선택하고, 자신의 이상형을 적어주세요!" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_gift.gif" alt="추첨을 통해 3분께 텐바이텐이 제작한 에디션 셔츠맨 바디필로우를 선물로 드립니다. 이벤트 기간은 2014년 9월 15일 월요일부터 9월 24일 수요일까지며, 당첨자 발표는 9월 26일 금요일입니다." /></p>
					<div class="cmtField">
					<ul>
						<li>
							<input type="radio" id="idealtype01" name="spoint" value="1" />
							<label for="idealtype01"><img src="http://webimage.10x10.co.kr/play/ground/20140915/ico_shirtman_01.jpg" alt="따뜻포근 자상셔츠맨" /></label>
						</li>
						<li>
							<input type="radio" id="idealtype02" name="spoint" value="2" />
							<label for="idealtype02"><img src="http://webimage.10x10.co.kr/play/ground/20140915/ico_shirtman_02.jpg" alt="위트폭발 애교셔츠맨" /></label>
						</li>
						<li>
							<input type="radio" id="idealtype03" name="spoint" value="3" />
							<label for="idealtype03"><img src="http://webimage.10x10.co.kr/play/ground/20140915/ico_shirtman_03.jpg" alt="남자냄새 의리셔츠맨" /></label>
						</li>
					</ul>
					</div>
					<div class="write">
						<strong><img src="http://webimage.10x10.co.kr/play/ground/20140915/txt_ideal_type.gif" alt="나의 이상형은..." /></strong>
						<textarea title="코멘트 작성" cols="50" rows="5" id="writearea" name="txtcomm" title="나의 이상형 작성" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur()" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');return Limit(this);" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%> autocomplete="off" maxlength="100">100자 이내로 입력해주세요.</textarea>
					</div>
					<div class="btn-submit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20140915/btn_submit.gif" alt="이벤트 응모하기" /></div>
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

		<!-- comment list -->
		
		<div class="section comment-list">
			<% IF isArray(arrCList) THEN %>
			<div class="comment-shirt">
				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<div class="shirt color0<%=arrCList(3,intCLoop)%>">
					<div class="num"><span>no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span><% If arrCList(8,intCLoop) = "M"  then%> <img src="http://webimage.10x10.co.kr/play/ground/20140915/ico_mobile_white.gif" alt="모바일 에서 작성된 글입니다." /><% End If %></div>
					<strong><%=printUserId(arrCList(2,intCLoop),2,"*")%></strong>
					<div class="reason">
						<%=nl2br(arrCList(1,intCLoop))%>
					</div>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<button type="button" class="btnDel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>')">삭제</button>
					<% end if %>
				</div>
				<% Next %>
			</div>

			<p class="note"><span><img src="http://webimage.10x10.co.kr/play/ground/20140915/ico_mobile_grey.gif" alt="모바일" /> 아이콘은 모바일에서 작성한 코멘트입니다.</span></p>

			<!-- paging -->
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
			<% End If %>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->