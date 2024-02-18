<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/cscenter/bankingcls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 입금자를 찾습니다."		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim nbank,ix,page
dim searchtext, searchitem

searchtext = requestCheckVar(request("searchtext"),20)
searchitem = requestCheckVar(request("searchitem"),10)
page = requestCheckVar(request("page"),9)
if page = "" then page=1

'response.write CDate(searchtext)

if (searchitem="dt") then
    On Error Resume Next
        searchtext = CStr(CDate(searchtext))
        If (Err) then
            searchtext = ""
            searchitem = ""
        end if
    On Error Goto 0
end if

set nbank = New CBanking
nbank.FPageSize = 5
nbank.FCurrPage = page
nbank.FScrollCount = 5
nbank.FRectSearchText = searchtext
nbank.FRectSearch = searchitem
nbank.GetBankingList


dim bankingdate
bankingdate = DateSerial(year(now),month(now)-2,01)

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="JavaScript">

function goPage(page) {
    location.href="?page=" + page;
}

window.onload = function() {
	self.focus();
}

</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_find_depositor.gif" alt="입금자를 찾습니다." /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="depositorMsg">
					<p>아래 명단에서 입금내역을 확인하신 분은 연락주세요. <br /> 신속하게 처리해 드리겠습니다.</p>
					<strong><img src="http://fiximage.10x10.co.kr/web2013/cscenter/txt_cs_tel_big.gif" alt="1644-6030" /></strong>
					<a href="mailto:customer@10x10.co.kr" class="email"><strong>customer@10x10.co.kr</strong></a>
					<p class="note"><em><%= left(bankingdate,4) %>년 <%= mid(bankingdate,6,2) %>월 <%= mid(bankingdate,9,2) %>일 이후</em>의 내역이 표시됩니다. <br />
					그 이전에 입금하신 내용이 있을 경우,<br />
					고객센터로 연락 부탁 드립니다.</p>
				</div>
				<div class="boardList">
					<table>
					<caption>입금자 목록</caption>
					<colgroup>
						<col width="60" /> <col width="80" /> <col width="80" /> <col width="*" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">입금일자</th>
						<th scope="col">입금은행</th>
						<th scope="col">입금자명</th>
					</tr>
					</thead>
					<tbody>
					<% if nbank.FResultCount < 1 then %>
					<tr>
						<td colspan="4">내역이 없습니다.</td>
					</tr>
					<% end if %>
					<% for ix=0 to nbank.FResultCount -1 %>
					<tr>
						<td><% = (nbank.FTotalCount - (nbank.FPageSize * nbank.FPCount))- ix %></td>
						<td><% = FormatDateTime(nbank.FItemList(ix).Fbankdate,2) %></td>
						<td><% = nbank.FItemList(ix).Ftenbank %></td>
						<td><% = nbank.FItemList(ix).Fjukyo %></td>
					</tr>
					<% next %>
					</tbody>
					</table>

					<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(nbank.FcurrPage, nbank.FtotalCount, nbank.FPageSize, 5, "goPage") %></div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<% set nbank = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
