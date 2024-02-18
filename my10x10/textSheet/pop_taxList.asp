<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/classes/cscenter/taxsheet_cls.asp"-->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 세금계산서 발급요청"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


Dim orderserial
Dim oBusi, i, lp
Dim userId, TotalCount

orderserial = Request("orderserial")
userid = GetLoginUserID


'// 내용 접수
set oBusi = new CBusi
oBusi.FRectuserId = userid

''비회원 추가 200905
if (userid="") and (orderserial<>"") then
	oBusi.FRectorderserial = orderserial
end if

oBusi.GetBusiList

TotalCount = oBusi.FTotalCount

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="javascript">

// 전송폼 검사
function chkForm() {
	var frm = document.frm_write;
	var chkSel=0;

	if(!frm.BusiIdx) {
		alert('먼저 사업자를 등록해 주세요.');
		return;
	}


	if(frm.BusiIdx.length) {
		for(i=0;i<frm.BusiIdx.length;i++) {
			if(frm.BusiIdx[i].checked)
				chkSel++;
		}
	} else {
		if(frm.BusiIdx.checked) {
			chkSel++;
		}
	}

	if(chkSel==0) {
		alert("사업자등록증을 선택해주십시오.");
		return;
	}

	frm.mode.value="select";
	frm.submit();
}

resizeTo(640,560);

</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_tax_issue.gif" alt="세금계산서 발급요청" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<ul class="list bPad30">
						<li>결제일 기준으로 익월 5일까지 결제월의 세금계산서 발급이 가능합니다.<br /> (예: 5월 12일 구매시 6월 5일까지 발급요청 가능)</li>
						<li>공급받을 사업자등록증을 선택하신 후 담당자 정보를 입력하시면 세금계산서를 발급받으실 수 있습니다.</li>
					</ul>

					<fieldset>
					<legend>공급받을 사업자등록증 선택</legend>
						<div class="delivery">
							<h2>공급받을 사업자등록증 선택하기</h2>
							<a href="pop_taxWrite.asp?orderserial=<%=orderserial%>" class="btn btnS2 btnRed"><span class="fn">사업자등록증 추가하기</span></a>
						</div>
						<form name="frm_write" method="POST" action="doTaxOrder.asp">
						<input type="hidden" name="mode" value="">
						<input type="hidden" name="orderserial" value="<%=orderserial%>">
						<table class="baseTable">
						<caption>공급받을 사업자등록증 목록</caption>
						<colgroup>
							<col width="50" /> <col width="110" /> <col width="*" /> <col width="100" /> <col width="100" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">선택</th>
							<th scope="col">사업자등록번호</th>
							<th scope="col">상호명</th>
							<th scope="col">대표자</th>
							<th scope="col">등록일</th>
						</tr>
						</thead>
						<tbody>
<%
if TotalCount>0 then
	for i=0 to TotalCount-1
%>
						<tr>
							<td><input type="radio" name="BusiIdx" value="<%=oBusi.FBusiList(i).FBusiIdx%>" title="<%=oBusi.FBusiList(i).FBusiNo%>"></td>
							<td><%=oBusi.FBusiList(i).FBusiNo%></td>
							<td><%=db2html(oBusi.FBusiList(i).FBusiName)%></td>
							<td><%=db2html(oBusi.FBusiList(i).FBusiCEOName)%></td>
							<td><%=FormatDate(oBusi.FBusiList(i).Fregdate,"0000/00/00")%></td>
						</tr>
<%
	next
else
%>
						<tr>
							<td colspan="5">사업자 등록증 발행내역이 없습니다.</td>
						</tr>
<%
end if
%>
						</tbody>
						</table>
						</form>

						<div class="btnArea ct tPad20">
							<input type="button" class="btn btnS1 btnRed btnW100" onClick="chkForm();" value="발급요청" />
							<a href="javascript:window.close();" class="btn btnS1 btnGry btnW100">취소</a>
						</div>
					</fieldset>

				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%
set oBusi = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
