<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
'###########################################################
' Description :  기프트톡 쓰기
' History : 2015.02.17 유태욱 디자인 및 기능 변경
'###########################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/gift/giftCls.asp" -->
<!-- #include virtual="/gift/Underconstruction_gift.asp" -->
<%
	Dim i, j, vTalkIdx, vKeyword, vSort, vIsSearch, vCount, vIsMine, vStoryItem
	Dim vContents, vItemCount, vItemID, vIsItemDetail, vRequestItemID, vIsRequest

	vIsItemDetail = requestCheckVar(Request.form("isitemdetail"),1)
	vRequestItemID = requestCheckVar(Request.form("ritemid"),10)

	Dim cTalk, vArrKey
	SET cTalk = New CGiftTalk
	cTalk.FRectUseYN = "y"
	'vArrKey = cTalk.fnGiftTalkKeywordList()
	SET cTalk = Nothing

	If vItemCount = "" Then vItemCount = "0" End If
	If vItemID = "" Then vItemID = "," End If
	If vKeyword = "" Then vKeyword = "," End If

	'### 상품상세에서 넘어올때.
	IF vIsItemDetail = "o" AND vRequestItemID <> "" Then
		If isNumeric(vRequestItemID) = True Then
			vItemCount = 1
			vItemID = "," & vRequestItemID & ","
			vIsRequest = "o"
		End If
	End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">
<!-- #include file="./inc_Javascript.asp" -->

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

	jsTalkRightListFirst("<%=CHKIIF(vIsRequest="o","","first")%>");
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
			url: "/gift/talk/itemselect_ajax.asp?itemid=<%=vRequestItemID%>&nowitem=,&nowcnt=0",
			cache: false,
			success: function(message)
			{
				$("#itemselectarea").empty().append(message);
			}
	});
}
</script>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
</head>
<body>
<div id="giftWrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container giftSection">
		<div id="contentWrap">
			<!-- for dev msg : 기프트 공통 탑 -->
			<div class="head">
				<!-- #include virtual="/gift/inc_gift_menu.asp" -->
			</div>
			<!-- //기프트 공통 탑 -->

			<div class="navgift">
				<div class="hgroup talkwrite">
					<h3><img src="http://fiximage.10x10.co.kr/web2013/gift/tit_gift_talk_write.png" alt="GIFT TALK 쓰기" /></h3>
					<p><span></span>선물이 고민된다면, <strong>GIFT TALK</strong>을 작성해보세요!</p>
				</div>
				<ul class="aside">
					<!-- for dev msg : 현재 보고 있는 페이지에 a에 클래스 on 붙여주세요 -->
					<li><a href="/gift/talk/mytalk.asp">MY TALK</a></li>
					<li><a href="" onclick="goWriteTalk(); return false;" class="on">TALK 쓰기</a></li>
				</ul>
			</div>

			<div class="writeTalk">
				<!-- 질문 내용 및 상품 선택 -->
				<div class="write">
					<div class="inner">
						<div id="field" class="field">
							<form name="talkfrm" action="/gift/talk/save_giftTalk.asp" method="post" style="margin:0px;" target="iframeproc">
							<input type="hidden" name="talkidx" value="<%=vTalkIdx%>">
							<input type="hidden" name="gubun" value="i">
							<input type="hidden" name="useyn" value="y">
							<input type="hidden" name="keyword" id="keyword" value="<%=vKeyword%>">
								<fieldset>
									<div class="question">
										<h4>GIFT TALK 내용</h4>
										<div class="limited"><span>1</span>/100</div>
										<textarea class="writeFrm" name="contents" cols="60" rows="5" title="질문내용 작성"><% If vContents = "" Then %>100자 이내로 작성해주세요.<%=vbCrLf%>(톡과 관련 없는 글은 사전통보 없이 관리자에 의해 삭제 될 수 있습니다.)<% Else Response.Write vContents End If %></textarea>
										<p class="report">
											<strong><span>※</span> 상품 및 주문/배송등의 문의사항은 고객행복센터(☎1644-6030) 또는 1:1 문의하기를 이용해주세요.</strong>
											<a href="/my10x10/qna/myqnalist.asp">1:1 문의하기</a>
										</p>
									</div>

									<div class="goods">
										<h4>상품을 선택해주세요</h4>

										<div class="addwrap" id="itemselectarea">
										</div>

										<p class="noti">1가지 상품 선택 시, 해당 상품에 대한 찬성 또는 반대 투표가<br /> 2가지 상품 선택 시, 둘 중 어떤 상품이 더 좋은지에 대한 양자택일 투표가 진행됩니다.</p>
									</div>

									<div class="btnWrap">
										<input type="reset" value="취소하기" onclick="javascript:history.back();"class="btn btnB1" />
										<input type="submit" value="등록하기" onClick="jsTalkWriteSave(); return false;" class="btn btnB1" />
									</div>
								</fieldset>
							<input type="hidden" name="itemcount" value="<%=vItemCount%>">
							<input type="hidden" name="itemid" id="itemid" value="<%=vItemID%>">
							</form>
						</div>
					</div>
				</div>

				<!-- 빠른 상품 찾기 -->
				<div class="find" id="write_right">
				</div>
				<iframe src="about:blank" name="iframeproc" frameborder="0" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0"></iframe>
			</div>

		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->