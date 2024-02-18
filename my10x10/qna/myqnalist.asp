<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 1:1 상담
' History : 2015.05.27 이상구 생성
'			2016.03.25 한용민 수정(문의분야 모두 DB화 시킴)
'###########################################################
%>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 1:1 상담 신청"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_help_v1.jpg"
	strPageDesc = "도움이 필요하시다면 찾아주세요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 1:1 상담 신청"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/qna/myqnalist.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/cscenter/myqnacls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 1:1 상담"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

dim page, i, j, lp, tmpqadivname
dim userid: userid = getEncLoginUserID ''GetLoginUserID
	page = request("page")

if (page = "") then page = 1

dim boardqna
set boardqna = New CMyQNA
	boardqna.FCurrPage = page
	boardqna.FPageSize = 10
	boardqna.FScrollCount = 10

	if IsUserLoginOK() then
	    boardqna.FRectUserID = getEncLoginUserID ''GetLoginUserID
	elseif IsGuestLoginOK() then
	    boardqna.FRectOrderSerial = GetGuestLoginOrderserial()
	end if

	if (IsUserLoginOK() or IsGuestLoginOK()) then
		boardqna.GetMyQnaList
	end if

%>

<!-- #include virtual="/lib/inc/head.asp" -->

<script type="text/javascript">

$(function() {
	$(".myQnaList .answerView td").hide();
	$(".myQnaList .myQuestion").click(function () {
		// $(".myQnaList .answerView").hide();
		// $(this).parent().parent().next('.answerView').show();
		// $(this).parent().parent().next('.answerView').toggle();
		// $(this).parent().parent().next(".answerView").find("td").show();
		$(this).parent().parent().next(".answerView").find("td").toggle();
	});
});

function goPage(page){
    location.href = "?page=" + page;
}

//qna 삭제
function DelQna(id){
	var actfrm = document.actfrm;

	if (confirm('삭제 하시겠습니까')){
		actfrm.mode.value='DEL';
		actfrm.id.value=id;
		actfrm.submit();
	}
}

function PointQna(frm) {
	var actfrm = document.actfrm;

	actfrm.mode.value = 'PNT';
	actfrm.id.value = frm.id.value;
	actfrm.md5key.value = frm.md5key.value;
	actfrm.evalPoint.value = frm.evalPoint[getCheckedIndex(frm.evalPoint)].value;
	actfrm.submit();
}

</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_consult<%=CHKIIF(IsVIPUser()=True,"_vip","")%>.gif" alt="<%=CHKIIF(IsVIPUser()=True,"VIP ","")%>1:1 상담" /></h3>
						<ul class="list">
							<li>한번 등록한 상담내용은 수정이 불가능합니다. 수정을 원하시는 경우, 삭제 후 재등록 하셔야 합니다.</li>
							<li>1:1 상담은 24시간 신청가능하며 접수된 내용은 빠른 시간내에 답변을 드리도록 하겠습니다.</li>
							<li>문의하신 1:1 상담은 고객님의 메일로도 확인하실 수 있습니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<div class="myservice">
							<p><strong><%= boardqna.FTotalCount %>건의 상담내역이 있습니다.</strong></p>
							<a href="/my10x10/qna/myqnawrite.asp" onclick="window.open(this.href, 'popDepositor', 'width=925, height=800, scrollbars=yes'); return false;" class="btn btnS2 btnRed"><span class="fn"><%=CHKIIF(IsVIPUser()=True,"VIP ","")%>1:1 상담 신청하기</span></a>
						</div>

						<table class="baseTable myQnaList">
						<caption>내가 신청한 서비스 목록</caption>
						<colgroup>
							<col width="130" /> <col width="*" /> <col width="90" /> <col width="90" /> <col width="90" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">상담명</th>
							<th scope="col">등록일</th>
							<th scope="col">상태</th>
							<th scope="col">관리</th>
						</tr>
						</thead>
						<tbody>
							<% if boardqna.FResultCount < 1 then %>
								<tr>
									<td colspan="5">문의하신 <%=CHKIIF(IsVIPUser()=True,"VIP","")%> 1:1 상담 내역이 없습니다.</td>
								</tr>
							<% else %>
							<%
							for i = 0 to (boardqna.FResultCount - 1)

							if isarray(split(boardqna.FItemList(i).fqadivname,"!@#")) then
								if ubound(split(boardqna.FItemList(i).fqadivname,"!@#")) > 0 then
									tmpqadivname =  split(boardqna.FItemList(i).fqadivname,"!@#")(1)
								end if
							end if
							%>
								<tr>
									<td><%= tmpqadivname %></td>
									<td class="lt">
										<a href="#none" class="myQuestion">
											<%= stripHTML(boardqna.FItemList(i).Ftitle) %>
											<% if (boardqna.FItemList(i).Ftitle = "") then %>(제목없음)<% end if %>
										</a>
									</td>
									<td><%= Replace(Left(boardqna.FItemList(i).Fregdate,10), "-", "/") %></td>
									<td>
										<% if (boardqna.FItemList(i).Freplyuser <> "") then %>
											<em class="crRed">답변완료</em>
										<% else %>
											<em class="crMint">답변대기</em>
										<% end if %>
									</td>
									<td>
										<button type="button" class="btn btnS2 btnGry2" onClick="DelQna('<%= boardqna.FItemList(i).Fid %>');"><span class="fn">삭제</span></button>
									</td>
								</tr>
								<tr class="answerView">
									<td colspan="5" style="display:none;">
										<div class="qnaList">
											<div class="question">
												<strong class="title"><img src="http://fiximage.10x10.co.kr/web2013/shopping/ico_question.gif" alt="질문" /></strong>
												<div class="account">
													<p>
														<%= nl2br(stripHTML(boardqna.FItemList(i).Fcontents)) %>
														<% if Not IsNull(boardqna.FItemList(i).Fattach01) and (boardqna.FItemList(i).Fattach01 <> "") then %>
														<br /><br />(사진은 고객센터에 전달되었습니다.)
														<% end if %>
													</p>
												</div>
											</div>
											<div class="answer">
												<strong class="title"><img src="http://fiximage.10x10.co.kr/web2013/shopping/ico_answer.gif" alt="답변" /></strong>
												<div class="account">
													<% if (boardqna.FItemList(i).Freplyuser <> "") then %>
													<p><%= nl2br(stripHTML(boardqna.FItemList(i).Freplytitle)) %></p>
														<br><br>
														<p><%= nl2br(stripHTML(boardqna.FItemList(i).Freplycontents)) %></p>
													<% else %>
														<em class="crRed">답변준비중입니다.<br>빠른 시일내에 답변드리겠습니다. </em>
													<% end if %>
													</p>
												</div>
											</div>
										</div>
										<% if boardqna.FItemList(i).Freplydate<>"" and boardqna.FItemList(i).Freplydate>"2008-07-18" Then %>
										<form name="teneval<%= i %>" action="myqna_process.asp" target="_blank" method="post">
										<input type="hidden" name="mode" value="PNT">
										<input type="hidden" name="id" value="<%= boardqna.FItemList(i).Fid %>">
										<input type="hidden" name="md5key" value="<%'= boardqna.FItemList(i).Fmd5Key %>">
										<div class="satisfaction">
											<fieldset>
											<legend>답변 만족도 평가</legend>
												<p>
													<strong>답변이 만족스러우셨습니까?</strong><br />
													답변에 대한 만족도를 반영해 주십시오. 회원님의 평가를 반영하여 보다 좋은 서비스를 위해서 노력하겠습니다.
												</p>
												<div class="rating">
													<span><input type="radio" id="starPoint11" name="evalPoint" value="5" <%If boardqna.FItemList(i).Fevalpoint = "5" Or boardqna.FItemList(i).Fevalpoint = "0" Or boardqna.FItemList(i).Fevalpoint = "" Then response.write "checked" %> /> <label for="starPoint11"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_review_star05.png" alt="별5개" /></label></span>
													<span><input type="radio" id="starPoint12" name="evalPoint" value="4" <%If boardqna.FItemList(i).Fevalpoint = "4" Then response.write "checked" %> /> <label for="starPoint12"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_review_star04.png" alt="별4개" /></label></span>
													<span><input type="radio" id="starPoint13" name="evalPoint" value="3" <%If boardqna.FItemList(i).Fevalpoint = "3" Then response.write "checked" %> /> <label for="starPoint13"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_review_star03.png" alt="별3개" /></label></span>
													<span><input type="radio" id="starPoint14" name="evalPoint" value="2" <%If boardqna.FItemList(i).Fevalpoint = "2" Then response.write "checked" %> /> <label for="starPoint14"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_review_star02.png" alt="별2개" /></label></span>
													<span><input type="radio" id="starPoint15" name="evalPoint" value="1" <%If boardqna.FItemList(i).Fevalpoint = "1" Then response.write "checked" %> /> <label for="starPoint15"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_review_star01.png" alt="별1개" /></label></span>
												</div>
												<% if (boardqna.FItemList(i).FEvalPoint="0" or Isnull(boardqna.FItemList(i).FEvalPoint)) then %>
												<input type="button" value="평가하기" onClick="PointQna(teneval<%= i %>)" class="btn btnS2 btnRed fn" />
												<% end if %>
											</fieldset>
										</div>
										</form>
										<% end if %>
									</td>
								</tr>
							<% next %>
							<% end if %>
						</tbody>
						</table>

						<div class="bdrTop00">
							<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(boardqna.FcurrPage, boardqna.FtotalCount, boardqna.FPageSize, 10, "goPage") %></div>
						</div>
					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="actfrm" method="post" action="myqna_process.asp" onsubmit="return false;">
<input type="hidden" name="mode" value="">
<input type="hidden" name="id" value="">
<input type="hidden" name="md5key" value="">
<input type="hidden" name="evalPoint" value="">
</form>

</body>
</html>

<%
set boardqna = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
