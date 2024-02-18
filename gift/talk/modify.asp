<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
'###########################################################
' Description :  기프트
' History : 2015.02.25 유태욱 생성
'###########################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/gift/giftCls.asp" -->
<!-- #include virtual="/gift/Underconstruction_gift.asp" -->
<%
	'dim  vKeyword, vArrKey
	Dim i, j, vTalkIdx, vSort, vIsSearch, vCount, vIsMine, vStoryItem
	Dim vContents, vItemCount, vItemID, vTag, vItem, vUserID, vTheme, vItemTmp, vAjaxItemID, vAjaxNowItem, vAjaxNowCnt
	vUserID = GetLoginUserID
	vTalkIdx = requestCheckVar(Request("talkidx"),10)

	Dim cTalk
	SET cTalk = New CGiftTalk
		cTalk.FRectUseYN = "y"
		'vArrKey = cTalk.fnGiftTalkKeywordList()
		cTalk.FRectTalkIdx = vTalkIdx
		cTalk.FRectUserId = vUserID
		cTalk.FPageSize = 1
		cTalk.FCurrpage = 1
		cTalk.FRectUseYN = "y"
		'####### talkidx 로 상세 조회
		cTalk.sbGiftTalkList

		vCount = cTalk.FResultCount
		If vCount < 1 Then
			Response.Write "<script>alert('잘못된 경로입니다.');</script>"
			dbget.close()
			Response.End
		End IF

		vContents	= cTalk.FItemList(0).FContents
		vTheme		= cTalk.FItemList(0).FTheme
		'vTag		= fnTalkModifyKeySetting(cTalk.FItemList(0).FTag)
		vItem		= cTalk.FItemList(0).FItem
	SET cTalk = Nothing

	vItem = Right(vItem,Len(vItem)-5)

	If vTheme = "2" Then
		vItemCount = 2
		For j = LBound(Split(vItem,",item,")) To UBound(Split(vItem,",item,"))
			vItemTmp = Split(vItem,",item,")(j)
			vItemID = vItemID & Split(vItemTmp,"|blank|")(2)
			If j = 0 Then
				vItemID = vItemID & ","
				vAjaxNowItem = "," & Split(vItemTmp,"|blank|")(2) & ","
			Else
				vAjaxItemID = Split(vItemTmp,"|blank|")(2)
			End IF
		Next
		vItemID = "," & vItemID & ","
		vAjaxNowCnt = 1
	ElseIf vTheme = "1" Then
		vItemCount = 1
		vItemID = "," & Split(vItem,"|blank|")(2) & ","
		vAjaxNowItem = ","
		vAjaxItemID = Split(vItem,"|blank|")(2)
		vAjaxNowCnt = 0
	Else
		Response.Write "<script>alert('잘못된 경로입니다.');</script>"
		dbget.close()
		Response.End
	End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
body {background-color:#f4f7f7;}
.popWrap .popHeader {margin:25px 16px 10px 35px; padding-left:54px; background-color:#f4f7f7; background-image:url(http://fiximage.10x10.co.kr/web2013/gift/bg_sprite_gift.png); background-repeat:no-repeat; background-position:0 -1523px;}
.popWrap .popHeader h1 {margin-top:-14px; padding-bottom:10px; padding-left:6px; border-bottom:1px solid #ddd;}
.popContent {padding:0 0 15px;}
.writeTalk {width:100%; min-width:658px; margin:0 auto;}
.writeTalk .write {float:none; width:658px; margin:0 auto;}
.writeTalk .caseB .item {float:none; width:244px; margin:0 auto;}
.writeTalk .caseB .vote {width:240px;  margin:0 auto;}
</style>
<script type="text/javascript">
$(function(){
	function frmCount(val) {
		var len = val.value.length;
		if (len >= 201) {
			val.value = val.value.substring(0, 200);
		} else {
			$('.txtLimit span').text(len);
		}
	}
	frmCount($('.writeFrm').get(0));
	$('.writeFrm').keyup(function() {
		frmCount(this);
	});

	//jsTalkRightListFirst("");
	jsTalkModifySetting();
});

function jsItemCount(a){
	var tmp = talkfrm.itemcount.value;
	if(a == "+"){
		talkfrm.itemcount.value = parseInt(tmp) + 1;
	}else if(a == "-"){
		talkfrm.itemcount.value = parseInt(tmp) - 1;
	}
}

function jsTalkModifySetting(){
	$.ajax({
			url: "/gift/talk/itemselect_ajax.asp?itemid=<%=vAjaxItemID%>&nowitem=<%=vAjaxNowItem%>&nowcnt=<%=vAjaxNowCnt%>&ismodify=o",
			cache: false,
			success: function(message)
			{
				$("#itemselectarea").empty().append(message);
			}
	});
}
<!-- #include file="./inc_Javascript.asp" -->
</script>
</head>
<body>
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2013/gift/tit_talk_modify.png" alt="TALK 수정" /></h1>
		</div>
		<div class="popContent giftSection">

			<div class="writeTalk">
				<!-- 질문 내용 및 상품 선택 -->
				<div class="write">
					<div class="inner">
						<div id="field" class="field">
							<form name="talkfrm" action="/gift/talk/save_giftTalk.asp" method="post" style="margin:0px;">
							<input type="hidden" name="talkidx" value="<%=vTalkIdx%>">
							<input type="hidden" name="gubun" value="u">
							<input type="hidden" name="useyn" value="y">
								<fieldset>
									<div class="question">
										<h4>질문내용</h4>
										<div class="limited"><span>1</span>/100</div>
										<textarea class="writeFrm" name="contents"><% If vContents = "" Then %>200자 이내로 작성해주세요.<%=vbCrLf%>(톡과 관련 없는 글은 사전통보 없이 관리자에 의해 삭제 될 수 있습니다.)<% Else Response.Write vContents End If %></textarea>
									</div>

									<div class="goods">
										<h4>투표가 진행중인 톡은 상품을 수정 하실 수 없습니다.</h4>
										<div class="addwrap" id="itemselectarea">
											<!-- for dev msg : 투표가 진행 중인 상품 영역입니다. -->
										</div>
									</div>

									<div class="btnWrap">
										<input type="reset" onClick="window.close();" value="취소하기" class="btn btnB1" />
										<input type="submit" onClick="jsTalkWriteSave();" value="수정하기" class="btn btnB1" />
									</div>
								</fieldset>
							<input type="hidden" name="itemcount" value="<%=vItemCount%>">
							<input type="hidden" name="itemid" id="itemid" value="<%=vItemID%>">
							</form>
						</div>
					</div>
				</div>
			</div>
		<iframe src="about:blank" name="iframeproc" frameborder="0" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0"></iframe>
		</div>
	</div>
	<div class="popFooter">
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	/* 글자수 카운팅 */
	$("#field textarea").each(function() {
		var defaultVal = this.value;
		$(this).focus(function() {
			if(this.value == defaultVal){
				this.value = '';
			}
		});
		$(this).blur(function(){
			if(this.value == ''){
				this.value = defaultVal;
			}
		});
	});
	function frmCount(val) {
		var len = val.value.length;
		if (len >= 101) {
			val.value = val.value.substring(0, 100);
		} else {
			$("#field .limited span").text(len);
		}
	}
	$("#field textarea").keyup(function() {
		frmCount(this);
	});

	$("#field .caseC").append("<div class='line'></div>");
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->	