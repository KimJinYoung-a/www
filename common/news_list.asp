<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/cscenter/BoardNoticecls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 공지사항"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_help_v1.jpg"
	strPageDesc = "텐바이텐 소식을 알려드립니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 공지사항"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/common/news_list.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf

dim oBoardNotice,noticeFix,idx,ntype

dim iPg,page,ibb

idx = requestCheckVar(request("idx"),9)
page = getNumeric(requestCheckVar(request("page"),9))
ntype = requestCheckVar(request("type"),2)			'(A: 전체, E:당첨안내, 01:전체공지,02:상품공지,03:이벤트공지,04:배송공지,05:당첨자공지,06:CultureStation)
if page = "" then page=1
'if ntype="" then ntype=""

IF (idx<>"") and (Not IsNumeric(idx)) then response.end


'// 공지사항 목록
set oBoardNotice = New cBoardNotice
oBoardNotice.FRectNoticeOrder =7
oBoardNotice.FPageSize = 10
oBoardNotice.FCurrPage = page
oBoardNotice.FRectNoticetype = chkIIF(ntype="A","",ntype)
oBoardNotice.FScrollCount = 5
oBoardNotice.getNoticsList

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
	self.location="/common/news_list.asp?type=<%=ntype%>&page=" + pg;
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
			<div class="newsV15">
				<ul class="filtering">
					<li><a href="?type=" <%=chkIIF(ntype="" or ntype="A","class=""on""","")%>>전체</a></li>
					<li><a href="?type=02" <%=chkIIF(ntype="02","class=""on""","")%>>안내</a></li>
					<li><a href="?type=04" <%=chkIIF(ntype="04","class=""on""","")%>>배송</a></li>
					<li><a href="?type=05" <%=chkIIF(ntype="05" or ntype="E","class=""on""","")%>>당첨자</a></li>
					<li><a href="?type=03" <%=chkIIF(ntype="03","class=""on""","")%>>이벤트</a></li>
					<li class="last"><a href="?type=06" <%=chkIIF(ntype="06","class=""on""","")%>>컬쳐스테이션</a></li>
				</ul>

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
						<tr>
							<td><%= oBoardNotice.FItemList(ibb).Fid %></td>
							<td class="lt"><a href="/common/news_popup.asp?idx=<%= oBoardNotice.FItemList(ibb).Fid %>&type=<%=ntype%>&page=<% =page %>"<%=CHKIIF(oBoardNotice.FItemList(ibb).FFixYn="Y"," class=""cRd0V15""","")%>>
							<%= chrbyte(oBoardNotice.FItemList(ibb).Ftitle,60,"Y") %>
							<% IF oBoardNotice.FItemList(ibb).IsNewNotics THEN %>
							<span class="icoNew"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif" alt="New"></span>
							<% end if %></a></td>
							<td><%=FormatDate(oBoardNotice.FItemList(ibb).Fyuhyostart,"0000.00.00")%></td>
						</tr>
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