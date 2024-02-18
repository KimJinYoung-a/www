<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'==========================================================================
'	Description: 나의 기념일 리스트, 이영진
'	History: 2009.04.16
'==========================================================================
	Response.Expires = -1440
%>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 나의 기념일"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
	strPageDesc = "소중한 사람들의 기념일을 등록하세요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 나의 기념일"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/MyAnniversary/myAnniversaryList.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/clsMyAnniversary.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
Dim i
dim userid: userid = getEncLoginUserID ''GetLoginUserID

Dim page		: page			= requestCheckVar(req("page",1),10)

Dim obj	: Set obj = new clsMyAnniversary

obj.PageBlock	= 10
obj.PageSize	= 10
obj.CurrPage	= page

obj.FrontGetList

'네비바 내용 작성
'strMidNav = "MY 개인정보 > <b>나의 기념일</b>"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language="javascript">
function goPage(pg){
    location.href='?page='+pg;
}

function popAnniversarySave(idx)
{
	var url = "popAnniversarySave.asp?idx="+idx;
	window.open(url,"popAnniversarySave","width=640,height=560,left=400,top=200,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no");
}

function popAnniversaryView()
{
	var url = "popAnniversaryView.asp";
	window.open(url,"popAnniversaryView","width=640,height=560,left=400,top=200,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no");
}

// 삭제 처리
function jsDelete(idx)
{
	location.href = "popAnniversaryProc.asp?mode=DEL&idx="+idx;
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_anniversary.gif" alt="나의 기념일" /></h3>
						<ul class="list">
							<!-- <li>꼭 기억 해 두어야 할 기념일을 등록해 두시면 10일 전부터 로그인 하시면 기억하실 수 있도록 도와드립니다.</li> -->
							<li>나의 기념일은 내 생일을 포함, 최대 30개 까지 등록 가능합니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<fieldset>
						<legend>나의 기념일</legend>
							<div class="searchField">
								<p class="ftLt cr000 fs14"><strong>등록된 기념일이 <%=obj.TotalCount%>개 있습니다.</strong></p>
								<div class="option">
									<% If obj.TotalCount < 30 Then %>
									<a href="javascript:popAnniversarySave('');" class="btn btnS2 btnRed fn">기념일 추가하기</a>
									<% End If %>
								</div>
							</div>

							<table class="baseTable">
							<caption>나의 기념일 목록</caption>
							<colgroup>
								<col width="120" /> <col width="90" /> <col width="125" /> <col width="*" /> <col width="90" /> <col width="130" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">기념일명</th>
								<th scope="col">D-day</th>
								<th scope="col">날짜</th>
								<th scope="col">메모</th>
								<th scope="col">누적일자</th>
								<th scope="col">관리</th>
							</tr>
							</thead>
							<tbody>
						<% For i = 1 To UBound(obj.Items) %>
							<tr>
								<td class="<% If (obj.Items(i).getDecimalDay <=10 and obj.Items(i).getDecimalDay > -5) Then Response.write "crRed fb" %>"><%=obj.Items(i).title%></td>
								<td class="<% If (obj.Items(i).getDecimalDay <=10 and obj.Items(i).getDecimalDay > -5) Then Response.write "crRed fb" %>">
									<% If obj.Items(i).getDecimalDay < 0 Then %>
										-
									<% ElseIf obj.Items(i).getDecimalDay = 0 Then %>
										오늘
									<% Else %>
										D-<%=obj.Items(i).getDecimalDay %>
									<% End If %>
								</td>
								<td class="<% If (obj.Items(i).getDecimalDay <=10 and obj.Items(i).getDecimalDay > -5) Then Response.write "crRed fb" %>"><%=obj.Items(i).getSetDay%> (<%=obj.Items(i).dayTypeName%>)</td>
								<td class="lt"><%= obj.Items(i).memo%></td>
								<td>
									<% If obj.Items(i).getPassedDay < 0 Then %>
										-
									<% ElseIf obj.Items(i).getPassedDay = 0 Then %>
										오늘
									<% Else %>
										<%=obj.Items(i).getPassedDay %>일
									<% End If %>
								</td>
								<td>
									<a href="javascript:popAnniversarySave('<%=obj.Items(i).idx%>');" class="btn btnS2 btnGry2 fn">수정</a>
									<a href="javascript:jsDelete('<%=obj.Items(i).idx%>');" class="btn btnS2 btnGry2 fn">삭제</a>
								</td>
							</tr>
						<% Next %>
						<% If UBound(obj.Items) = 0 Then %>
							<tr>
								<td colspan="6"><p class="noData fs12"><strong>등록된 기념일이 없습니다.</strong></p></td>
							</tr>
						<% End If %>
							</tbody>
							</table>

							<div class="pageWrapV15 tMar20">
								<%= fnDisplayPaging_New_nottextboxdirect(obj.CurrPage, obj.TotalCount, obj.PageSize, obj.PageBlock, "goPage") %>
							</div>
						</fieldset>
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
<!-- #include virtual="/lib/db/dbclose.asp" -->
