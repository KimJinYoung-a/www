<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/cscenter/BoardNoticecls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 공지사항"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

dim oBoardNotice,noticeFix,idx,ntype

dim iPg,page,ibb

idx = requestCheckVar(request("idx"),9)
page = getNumeric(requestCheckVar(request("page"),9))
ntype = requestCheckVar(request("type"),2)			'(A: 전체, E:당첨안내, 01:전체공지,02:상품공지,03:이벤트공지,04:배송공지,05:당첨자공지,06:CultureStation)
if page = "" then page=1
'if ntype="" then ntype="A"

IF (idx<>"") and (Not IsNumeric(idx)) then response.end


'// 공지사항 목록
set oBoardNotice = New cBoardNotice
oBoardNotice.FRectNoticeOrder =7
oBoardNotice.FPageSize = 9
oBoardNotice.FCurrPage = page
oBoardNotice.FRectNoticetype = chkIIF(ntype="A","",ntype)
oBoardNotice.FScrollCount = 5
oBoardNotice.getNoticsList

if idx = "" And oBoardNotice.FresultCount > 0 then
    idx = oBoardNotice.FItemList(0).Fid
end if

dim readnotice
set readnotice = New cBoardNotice
if idx <> "" then
    readnotice.FRectid = idx
	'// 공지사항 한개
    readnotice.getOneNotics()
end if

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
function GoParent(v){
	opener.location.href=v;
	self.close();
}

function TnMovePage(pg) {
	self.location="/common/news_popup.asp?idx=<%=idx%>&type=<%=ntype%>&page=" + pg;
}

window.onload = function() {
	self.focus();
}
</script>
</head>
<body>
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2015/popup/tit_notice.png" alt="NOTICE" /></h1>
		</div>
		<div class="popContent">
			<div class="newsViewV15">
				<%
				If readnotice.FresultCount > 0 then
					'// 유효기간이 지난 글은 브라인드 처리 (2008-01-17;허진원 추가)
					if readnotice.FOneItem.Fyuhyostart<=cStr(date()) and readnotice.FOneItem.Fyuhyoend>=cStr(date()) or GetLoginUserLevel=7 then
				%>
						<div class="hgroup">
							<h2><%= readnotice.FOneItem.Ftitle %></h2>
							<span class="date"><%= FormatDate(readnotice.FOneItem.Fyuhyostart,"0000.00.00") %></span>
							<span class="triangle"></span>
						</div>
						<div class="section">
							<%= nl2br(readnotice.FOneItem.Fcontents) %>
						</div>
					<% else %>
						<div class="hgroup">
							<h2>공지기간이 아직 안되었거나 이미 지난 글입니다.</h2>
							<span class="date"></span>
							<span class="triangle"></span>
						</div>
						<div class="section"></div>
				<%	end if
				end If %>
				<div class="btnList"><a href="/common/news_list.asp?type=<%=ntype%>"><span>리스트로 가기</span> &gt;</a></div>
				<div class="tableSkin1V15">
					<table>
						<caption>NOTICE 목록</caption>
						<colgroup>
							<col style="width:15%;" />
							<col style="width:*;" />
							<col style="width:15%;" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">등록일</th>
						</tr>
						</thead>
						<tbody>
						<% for ibb=0 to oBoardNotice.FResultCount -1 %>
							<% if oBoardNotice.FItemList(ibb).Fid = Cint(idx) Then '// 현재 보여지는 글 볼드 처리 %>
							<tr>
								<td><%= oBoardNotice.FItemList(ibb).Fid %></td>
								<td class="lt"><a href="?idx=<%= oBoardNotice.FItemList(ibb).Fid %>&type=<%=ntype%>&page=<% =page %>" class="fb"><%= chrbyte(oBoardNotice.FItemList(ibb).Ftitle,60,"Y") %>
								<% IF oBoardNotice.FItemList(ibb).IsNewNotics THEN %>
									<span class="icoNew"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif" alt="New"></span>
								<% end if %></a></td>
								<td><%=FormatDate(oBoardNotice.FItemList(ibb).Fyuhyostart,"0000.00.00")%></td>
							</tr>
							<% else %>
								<% if oBoardNotice.FItemList(ibb).FFixYn="Y" Then %>
								<tr>
									<td><%= oBoardNotice.FItemList(ibb).Fid %></td>
									<td class="lt"><a href="?idx=<%= oBoardNotice.FItemList(ibb).Fid %>&type=<%=ntype%>&page=<% =page %>" class="cRd0V15"><%= chrbyte(oBoardNotice.FItemList(ibb).Ftitle,60,"Y") %>
									<% IF oBoardNotice.FItemList(ibb).IsNewNotics THEN %>
										&nbsp;<span class="icoNew"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif" alt="New"></span>
									<% end if %></a></td>
									<td><%=FormatDate(oBoardNotice.FItemList(ibb).Fyuhyostart,"0000.00.00")%></td>
								</tr>
								<% else %>
								<tr>
									<td><%= oBoardNotice.FItemList(ibb).Fid %></td>
									<td class="lt"><a href="?idx=<%= oBoardNotice.FItemList(ibb).Fid %>&type=<%=ntype%>&page=<% =page %>"><%= chrbyte(oBoardNotice.FItemList(ibb).Ftitle,60,"Y") %>
									<% IF oBoardNotice.FItemList(ibb).IsNewNotics THEN %>
										&nbsp;<span class="icoNew"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif" alt="New"></span>
									<% end if %></a></td>
									<td><%=FormatDate(oBoardNotice.FItemList(ibb).Fyuhyostart,"0000.00.00")%></td>
								</tr>
								<% end if %>
							<% end if %>
						<% next %>
						</tbody>
					</table>
				</div>
				<div class="pageWrapV15 tMar20">
					<%= fnDisplayPaging_New_nottextboxdirect(oBoardNotice.FcurrPage,oBoardNotice.FtotalCount,oBoardNotice.FPageSize,5,"TnMovePage") %>
				</div>
			</div>
		</div>
	</div>
	<div class="popFooter">
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->