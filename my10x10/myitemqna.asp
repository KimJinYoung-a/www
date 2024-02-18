<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 상품 Q&A"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_help_v1.jpg"
	strPageDesc = "조금 더 상세한 상품안내가 필요하시다면 문의주세요"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 상품 Q&A"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/myitemqna.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_item_qnacls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 상품 Q&A"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim userid, page, SortMethod
userid = getEncLoginUserID
page   = requestCheckVar(request("page"),9)
SortMethod = requestCheckVar(request("SortMethod"),16)

if page="" then page=1
if SortMethod="" then SortMethod="all"
if (page<1) then page=1

dim myitemqna
set myitemqna = new CItemQna
myitemqna.FPageSize = 5
myitemqna.FCurrpage = page
myitemqna.FRectUserID = userid

if SortMethod="fin" then
    myitemqna.FRectReplyYN = "Y"
end if

if userid<>"" then
    myitemqna.GetMyItemQnaList
end if


dim i, lp, tmpHP(3), tmpStr

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">

// 상품목록 리플레시
function chgItemList(sm){
	var frm = document.frmItem;
	frm.action="myitemqna.asp";
	frm.SortMethod.value=sm;
	frm.mode.value = "";
	frm.submit();
}

// 상품목록 페이지 이동
function goPage(pg){
	var frm = document.frmItem;
	frm.action="myitemqna.asp";
	frm.SortMethod.value="<%= SortMethod %>";
	frm.mode.value = "";
	frm.page.value=pg;
	frm.submit();
}

function validateEmail(email) {
	var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return re.test(email);
}

function validateHP(phone) {
	var re = /^[0-9]{2,4}-[0-9]{2,4}-[0-9]{2,4}$/;
	return re.test(phone);
}

// 상품 문의 수정
function editItemQna(frm) {
	if (frm.usermail.value != "") {
		if (validateEmail(frm.usermail.value) != true) {
			alert("올바른 이메일주소가 아닙니다.");
			frm.usermail.focus();
			return;
		}
	}

	if ((frm.userhp1.value != "") || (frm.userhp2.value != "") || (frm.userhp3.value != "")) {
		var hp = frm.userhp1.value + "-" + frm.userhp2.value + "-" + frm.userhp3.value;

		if ((validateHP(hp) != true) && (hp != "--")) {
			alert("잘못된 핸드폰번호입니다.");
			frm.userhp1.focus();
			return;
		}
	}

	if (frm.emailok.checked == true) {
		if (frm.usermail.value == "") {
			alert("이메일을 입력하세요.");
			frm.usermail.focus();
			 return;
		}
	}

//	if (frm.smsok.checked == true) {
//		if ((frm.userhp1.value == "") || (frm.userhp2.value == "") || (frm.userhp3.value == "")) {
//			alert("핸드폰번호를 입력하세요.");
//			frm.userhp1.focus();
//			 return;
//		}
//	}

	if (frm.contents.value == "") {
		alert("내용을 입력하세요.");
		frm.contents.focus();
		 return;
	}

	if (frm.qnaSecret.checked == true) {
		frm.secretyn.value = "Y";
	}else{
		frm.secretyn.value = "N";
	}
	
	if(confirm("상품문의를 수정 하시겠습니까?") == true) {
		frm.submit();
	}
}

// 상품 문의 삭제
function delItemQna(idx,iid){
	var frm = document.frmItem;
	if(confirm("상품문의를 삭제 하시겠습니까?")){
		frm.action="/my10x10/doitemqna.asp";
		frm.id.value = idx;
		frm.itemid.value = iid;
		frm.mode.value = "del";
		frm.submit();
	}
}

$(function() {
	$(".myQnaEdit").hide();
	$(".myItem .btnModify").click(function () {
		$(this).parent().parent().parent().parent().parent().next(".myQnaEdit").toggle();
		$("#secretyn").val('Y');
	});

	$(".btnArea .btnCancelEdit").click(function () {
		$(this).closest(".myQnaEdit").toggle();
	});
});

function jsQNACheck(v){
	if(v=="s") {
    	if($("#qnaSecret").is(":checked") == true){
    		$("#secretyn").val("Y");
    	}else if($("#qnaSecret").is(":checked") == false){
    		$("#secretyn").val("N");
    	}    		
    }
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_product_qna.gif" alt="상품 Q&amp;A" /></h3>
						<ul class="list">
							<li>상품페이지에서 문의하신 질문에 대한 답변을 편리하게 보실 수 있습니다.</li>
							<li>상품이미지나 상품명을 클릭하시면 상품 상세페이지로 이동하실 수 있습니다.</li>
							<li>답변이 완료된 사항은 수정을 하실 수 없습니다.</li>
						</ul>
					</div>

					<div class="mySection">

						<form name="frmItem" method="get" onsubmit="return;" action="">
						<input type="hidden" name="page" value="">
						<input type="hidden" name="mode" value="">
						<input type="hidden" name="itemid" value="">
						<input type="hidden" name="id" value="">
						<input type="hidden" name="SortMethod" value="<%= SortMethod %>">

						<div class="myservice">
							<p><strong><%= myitemqna.FTotalCount %>건의 상품문의가 있습니다.</strong></p>
							<select title="상품 Q&amp;A 정렬 옵션 선택" class="optSelect2" style="width:98px;" onchange="chgItemList(this.value);">
								<option value="all" <% if SortMethod="all" then Response.Write "selected" %>>전체</option>
								<option value="fin" <% if SortMethod="fin" then Response.Write "selected" %>>답변완료</option>
							</select>
						</div>

						</form>

						<div class="myItemList myQnaList">
							<%
							If (myitemqna.FResultCount > 0) Then
								for i=0 to myitemqna.FResultCount -1
							%>
							<div class="grouping">
								<div class="myItem">
									<div class="pdfInfo">
										<div class="pdtPhoto"><a href="javascript:TnGotoProduct('<%= myitemqna.FItemList(i).FItemId %>');" title="<%= myitemqna.FItemList(i).FItemName %> 상품 보러가기"><img src="<%= myitemqna.FItemList(i).FListImage %>" width="120" height="120" alt="" /></a></div>
										<p class="pdtBrand"><a href="javascript:GoToBrandShop('<%= myitemqna.FItemList(i).FmakerId %>');" title="<%= myitemqna.FItemList(i).FmakerId %> 브랜드 보러가기"><%= myitemqna.FItemList(i).FmakerId %></a></p>
										<p class="pdtName tPad10"><a href="javascript:TnGotoProduct('<%= myitemqna.FItemList(i).FItemId %>');" title="<%= myitemqna.FItemList(i).FItemName %> 상품 보러가기"><%= myitemqna.FItemList(i).FItemName %></a></p>
									</div>
									<div class="qnaList <%=chkIIF(myitemqna.FItemList(i).Fsecretyn="Y","secretV17","")%>" >
										<div class="question">
											<strong class="title"><img src="http://fiximage.10x10.co.kr/web2013/shopping/ico_question.gif" alt="질문" /></strong>
											<div class="account">
												<p><%= Nl2Br(myitemqna.FItemList(i).FContents) %></p>
												<div><%= FormatDate(myitemqna.FItemList(i).Fregdate,"0000/00/00") %></div>
												<div class="btnArea">
													<% if Not(myitemqna.FItemList(i).IsReplyOk) then %><a href="#" class="btn btnS2 btnGry2 btnModify" onClick="return false;"><span class="fn">수정</span></a><% end if %>
													<a href="#" class="btn btnS2 btnGry2" onClick="delItemQna('<%= myitemqna.FItemList(i).Fid %>','<%=myitemqna.FItemList(i).FItemId%>'); return false;"><span class="fn">삭제</span></a>
												</div>
											</div>
										</div>
										<div class="answer">
											<strong class="title"><img src="http://fiximage.10x10.co.kr/web2013/shopping/ico_answer.gif" alt="답변" /></strong>
											<div class="account">
												<% if myitemqna.FItemList(i).IsReplyOk then %>
													<p><%= Nl2Br(myitemqna.FItemList(i).FReplycontents) %></p>
												<% else %>
													<p><em class="crRed">빠른 시일 내에 답변 드리도록 하겠습니다.<br /> 감사합니다.</em></p>
												<% end if %>
											</div>
										</div>
									</div>
								</div>

								<div class="myQnaEdit">
									<div class="boardForm">
										<form name="frmItem<%= i %>" method="post" onsubmit="return false;" action="/my10x10/doitemqna.asp">
										<input type="hidden" name="page" value="<%= page %>">
										<input type="hidden" name="mode" value="modi">
										<input type="hidden" name="id" value="<%= myitemqna.FItemList(i).Fid %>">
										<input type="hidden" name="itemid" value="<%= myitemqna.FItemList(i).FItemId %>">
										<input type="hidden" name="SortMethod" value="<%= SortMethod %>">
										<fieldset>
										<legend>상품문의 입력 폼</legend>
											<table>
											<caption>상품문의 입력항목</caption>
											<colgroup>
												<col width="100" /><col width="" />
											</colgroup>
											<tbody>
											<tr>
												<th>답변받기</th>
												<td>
													<span class="rPad10">
														<input type="checkbox" class="check" name="emailok" value="Y" title="이메일(E-mail)로 답변받기" <% if (myitemqna.FItemList(i).Femailok = "Y") then %>checked<% end if %> />
														<strong>이메일(E-mail)</strong>
														<input type="text" title="이메일주소" name="usermail" value="<%= myitemqna.FItemList(i).Fusermail %>" class="txtInp emailInfo" />
													</span>
													<input type="hidden" id="secretyn" name="secretyn" value="<%= myitemqna.FItemList(i).Fsecretyn %>">
													<input type="checkbox" class="check" id="qnaSecret" name="qnaSecret" onclick="jsQNACheck('s');" value="<%= myitemqna.FItemList(i).Fsecretyn %>" <%=chkIIF(myitemqna.FItemList(i).Fsecretyn="Y","checked","")%> /> <label for="qnaSecret">비밀글로 문의하기</label>
													<!--
													<span class="lPad20">
														<input type="checkbox" class="check" name="smsok" value="Y" title="SMS로 답변알림" <% if (myitemqna.FItemList(i).Fsmsok = "Y") then %>checked<% end if %> />
														<strong>문자메세지(SMS)</strong>
													-->
														<%
														tmpHP(0) = ""
														tmpHP(1) = ""
														tmpHP(2) = ""
'														tmpStr = myitemqna.FItemList(i).Fuserhp
'
'														if (tmpStr <> "") and UBound(Split(tmpStr, "-")) = 2 then
'															tmpStr = Split(tmpStr, "-")
'
'															tmpHP(0) = tmpStr(0)
'															tmpHP(1) = tmpStr(1)
'															tmpHP(2) = tmpStr(2)
'														end if
														%>
														<input type="hidden" title="휴대전화 앞자리" name="userhp1" value="<%= tmpHP(0) %>" maxlength="4" class="txtInp ct" /> 
														<input type="hidden" title="휴대전화 가운데자리" name="userhp2" maxlength="4" value="<%= tmpHP(1) %>" class="txtInp ct" /> 
														<input type="hidden" title="휴대전화 뒷자리" name="userhp3" maxlength="4" value="<%= tmpHP(2) %>" class="txtInp ct" />
													<!--
													</span>
													-->
												</td>
											</tr>
											<tr>
												<th>내용</th>
												<td>
													<textarea title="내용을 입력하세요" name="contents" style="width:100%; height:100px;"><%= myitemqna.FItemList(i).FContents %></textarea>
												</td>
											</tr>
											</tbody>
											</table>
											<div class="btnArea ct">
												<a href="javascript:editItemQna(frmItem<%= i %>);" class="btn btnS1 btnRed btnW100">수정</a>
												<a href="#" class="btn btnS1 btnGry btnW100 btnCancelEdit" onClick="return false;">취소</a>
											</div>
										</fieldset>
										</form>
									</div>
								</div>
							</div>
							<%
								next
							else
							%>
							<p class="noData"><strong>문의하신 상품 Q&amp;A 내역이 없습니다.</strong></p>
							<% end if %>

						</div>

						<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(myitemqna.FcurrPage, myitemqna.FtotalCount, myitemqna.FPageSize, 10, "goPage") %></div>

					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%

set myitemqna = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
