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
' Play-sub 고양이를 빌려드립니다
' 2014-10-17 이종화 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21345
Else
	eCode   =  55765
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

	iCPageSize = 3		'한 페이지의 보여지는 열의 수
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
body {background-color:#e8e0cf;}
/* comment event */
.comment-evt {width:1140px; margin:0 auto; padding-top:191px; background-color:#e8e0cf; text-align:center;}
.comment-evt h1 {margin-bottom:26px;}
.self-test {position:relative; margin-top:30px; height:286px; background:url(http://webimage.10x10.co.kr/play/ground/20141020/bg_note.gif) no-repeat 0 0; text-align:left;}
.self-test p {text-align:center;}
.self-test ul {overflow:hidden; width:820px; margin-top:14px; padding-left:70px; text-align:left;}
.self-test ul li {float:left; width:388px; margin-top:18px;}
.self-test ul li input {margin-top:-3px; margin-right:5px; *margin-right:0; vertical-align:middle;}
.self-test ul li label img {vertical-align:middle;}
.self-test .copy-right {padding:12px 0 0 70px; text-align:left;}
.self-test .btn-submit {position:absolute; top:72px; right:80px;}
.comment-list {overflow:hidden; width:1185px; margin-right:-45px; padding-top:35px;}
.comment-list .article {float:left; position:relative; width:336px; height:274px; margin-right:45px; border:7px solid #fff;}
.comment-list .article .num {display:block; width:100px; height:40px; margin:0 auto; padding-top:3px; background:url(http://webimage.10x10.co.kr/play/ground/20141020/bg_num.gif) no-repeat 0 0; color:#c2ac94; font-size:11px;}
.comment-list .article .num img {vertical-align:middle;}
.comment-list .article .id {display:block; position:absolute; top:55px; left:0; width:130px; padding-right:4px; color:#555; text-align:right;}
.comment-list .article p {margin-top:12px;}
.comment-list .btnDel {position:absolute; top:-12px; right:-15px; width:21px; height:21px; background:url(http://webimage.10x10.co.kr/play/ground/20141020/btn_del.png) no-repeat 0 0; text-indent:-999em;}
.comment-list-wrap .note {margin-top:40px; text-align:center;}
.comment-list-wrap .note span {padding-bottom:2px; border-bottom:1px solid #c5bfb0; color:#888;}
.comment-list-wrap .note img {vertical-align:middle;}
.comment-list-wrap .paging {width:1140px; margin:30px auto 0;}
.comment-list-wrap .paging a {background-color:transparent;}
</style>
<script type="text/javascript">
$(function(){
	$(".cmtField label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});
	// Label Select
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

	   
		if(!(frm.catcheck[0].checked||frm.catcheck[1].checked||frm.catcheck[2].checked||frm.catcheck[3].checked||frm.catcheck[4].checked||frm.catcheck[5].checked||frm.catcheck[6].checked||frm.catcheck[7].checked||frm.catcheck[8].checked||frm.catcheck[9].checked)){
		alert("1개 이상 항목을 체크 해주세요");
		return false;
		}

		//합계
		var total = 0;
		for (var i=0; i < frm.catcheck.length; i++) {
			if (frm.catcheck[i].checked){
				total += parseInt(frm.catcheck[i].value);
			}
		}
		
		frm.spoint.value = total;
		frm.action = "doEventSubscript55765.asp";
		return true;
	}

	function jsDelComment(cidx)	{
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
	   		document.frmdelcom.submit();
		}
	}

//-->
</script>
<div class="comment-evt">
	<h1><img src="http://webimage.10x10.co.kr/play/ground/20141020/tit_comment_event.gif" alt="코멘트 이벤트" /></h1>
	<p><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_comment_event.gif" alt="고양이남, 고양이녀 레벨테스트를 해보세요 : ) 레벨 테스트를 하신 분들은 &quot;고양이를 빌려드립니다&quot; KIT에 자동 응모됩니다. 응모해주신 분들 중 추첨을 통해 10분에게 &quot;고양이를 빌려드립니다&quot; KIT를 선물로 드립니다. 이벤트 기간은 2014년 10월 20일부터 11월 3일까지며 당첨자 발표는 2014년 11월 5일입니다."/></p>
	<div class="self-test">
		<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>"/>
		<input type="hidden" name="bidx" value="<%=bidx%>"/>
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
		<input type="hidden" name="iCTot" value=""/>
		<input type="hidden" name="mode" value="add"/>
		<input type="hidden" name="spoint" value="0"/>
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
			<fieldset>
			<legend>나 이런적 있어! 해당 항목에 체크하기</legend>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_self_test_check.gif" alt="나 이런적 있어! 해당 항목에 체크하세요" /></p>
				<div class="cmtField">
				<ul>
					<li>
						<input type="checkbox" id="selftest01" name="catcheck" value="1"/>
						<label for="selftest01"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_label_self_test_check_01.png" alt="당신의 마음에 구멍난 곳이 있다." /></label>
					</li>
					<li>
						<input type="checkbox" id="selftest02" name="catcheck" value="1"/>
						<label for="selftest02"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_label_self_test_check_02.png" alt="도넛이 좋아서 홧김에 많이 산 적 있다." /></label>
					</li>
					<li>
						<input type="checkbox" id="selftest03" name="catcheck" value="1"/>
						<label for="selftest03"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_label_self_test_check_03.png" alt="혼자서 살고 있다 (혹은 직장 때문에 가족과 떨어져 살고있다.)" /></label>
					</li>
					<li>
						<input type="checkbox" id="selftest04" name="catcheck" value="1"/>
						<label for="selftest04"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_label_self_test_check_04.png" alt="고양이를 좋아한다. 혹은 고양이를 좋아하지 않는데도 고양이가 따라온다." /></label>
					</li>
					<li>
						<input type="checkbox" id="selftest05" name="catcheck" value="1"/>
						<label for="selftest05"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_label_self_test_check_05.png" alt="렌터카를 이용해 본 적이 있다." /></label>
					</li>
					<li>
						<input type="checkbox" id="selftest06" name="catcheck" value="1"/>
						<label for="selftest06"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_label_self_test_check_06.png" alt="올해야 말로 결혼! 하고 싶다고 생각한다." /></label>
					</li>
					<li>
						<input type="checkbox" id="selftest07" name="catcheck" value="1"/>
						<label for="selftest07"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_label_self_test_check_07.png" alt="할머니와의 추억을 소중히 한다." /></label>
					</li>
					<li>
						<input type="checkbox" id="selftest08" name="catcheck" value="1"/>
						<label for="selftest08"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_label_self_test_check_08.png" alt="아무도 모르지만, 사실은 어떤 사람한테 쫓기고 있다." /></label>
					</li>
					<li>
						<input type="checkbox" id="selftest09" name="catcheck" value="1"/>
						<label for="selftest09"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_label_self_test_check_09.png" alt="더운 날에는 역시 맥주라고 생각한다." /></label>
					</li>
					<li>
						<input type="checkbox" id="selftest10" name="catcheck" value="1"/>
						<label for="selftest10"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_label_self_test_check_10.png" alt="쉽게 잠들지 않는 밤이 많다. " /></label>
					</li>
				</ul>
				</div>
				<p class="copy-right"><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_self_test_copyright.gif" alt="출처는 고양이를 빌려드립니다 일본 공식 홈페이지입니다." /></p>

				<div class="btn-submit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20141020/btn_submit.png" alt="결과확인 KIT에 자동으로 응모됩니다." /></div>
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

	<% IF isArray(arrCList) THEN %>
	<div class="comment-list-wrap">
		<div class="comment-list">
			<% For intCLoop = 0 To UBound(arrCList,2) %>
			<div class="article">
				<span class="num"><% If arrCList(8,intCLoop) = "M"  then%><img src="http://webimage.10x10.co.kr/play/ground/20141020/ico_mobile_beige.gif" alt="모바일에서 작성된 글" /><% End If %> no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
				<strong class="id"><%=printUserId(arrCList(2,intCLoop),2,"*")%></strong>
				<% If arrCList(3,intCLoop) < 4 Then %>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_recomment_01.gif" alt="렌타네코 레벨 30퍼센트며, 당신에게는 아기 고양이 마미코짱이 제격입니다." /></p>
				<% ElseIf arrCList(3,intCLoop) > 3 And arrCList(3,intCLoop) < 8 then %>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_recomment_02.gif" alt="렌타네코 레벨 70퍼센트며, 행운을 부르는 마네키네코가 든든한 내편이 되어 줄 겁니다." /></p>
				<% ElseIf arrCList(3,intCLoop) > 7 Then %>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20141020/txt_recomment_03.gif" alt="렌타네코 레벨 100퍼센트며, 느긋하게 누워있는 우타마루 사부와 유유자적하게 이야기를 해보는 건 어떤
				지요!" /></p>
				<% End If %>
				<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
				<button type="button" class="btnDel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>')">삭제</button>
				<% end if %>
			</div>
			<% Next %>
		</div>
		<p class="note"><span><img src="http://webimage.10x10.co.kr/play/ground/20141020/ico_mobile_grey.gif" alt="모바일" /> 아이콘은 모바일에서 작성한 코멘트입니다.</span></p>

		<!-- paging -->
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
	</div>
	<% End If %>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->