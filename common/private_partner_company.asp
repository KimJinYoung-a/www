<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
'	History	:  2020.07.03 한용민 생성
'	Description : 개인정보의 위탁 현황 - 그 외 협력사
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/partner/private_cls.asp" -->
<%
'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "개인정보의 위탁 현황 - 그 외 협력사"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

dim page, opartner, i
    page = requestCheckVar(getNumeric(request("page")),10)

if page="" then page=1

set opartner = New Cprivate
    opartner.FPageSize = 30
    opartner.FCurrPage = page
    opartner.Getprivate_partner_companyList
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/JavaScript">

function goPage(page) {
    location.replace("/common/private_partner_company.asp?page="+page);
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
				<h1><img src="http://fiximage.10x10.co.kr/web2020/common/txt_1.gif" alt="개인정보의 위탁 현황 - 그 외 협력사" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="boardList">
					<table>
					<caption>협력사 목록</caption>
					<colgroup>
						<col width="*" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col">협력사명</th>
					</tr>
					</thead>
					<tbody>
					<% if opartner.FResultCount < 1 then %>
					<tr>
						<td>내역이 없습니다.</td>
					</tr>
					<% else %>
					<% for i=0 to opartner.FResultCount -1 %>
					<tr>
						<td><% = opartner.FItemList(i).fcompany_name %></td>
					</tr>
					<% next %>
                    <% end if %>
					</tbody>
					</table>

					<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(opartner.FcurrPage, opartner.FtotalCount, opartner.FPageSize, 5, "goPage") %></div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>

<%
set opartner=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
