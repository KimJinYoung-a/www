<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 나의 주소록"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
	strPageDesc = "자주 사용하는 배송지를 등록할수 있어요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 나의 주소록"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/MyAddress/MyAddressList.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/orderCls/clsMyAddress.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'// 페이지 타이틀 및 페이지 설명 작성
Dim openerYN	: openerYN	= requestCheckVar(req("openerYN",""),10)

Dim tabListURL	: tabListURL = "popOldAddressList.asp"
Dim conListURL	: conListURL = "popMyAddressList.asp"
Dim conSaveURL	: conSaveURL = "popMyAddressSave.asp"
Dim conProcURL	: conProcURL = "popAddressProc.asp"

Dim i
dim userid: userid = getEncLoginUserID ''GetLoginUserID

Dim page		: page			= requestCheckVar(req("page",1),10)

Dim qString
qString = "openerYN=" & openerYN & "&countryCode=KR"
conProcURL = conProcURL & "?" & qString & "&page=" & page
conSaveURL = conSaveURL & "?" & qString & "&page=" & page
conListURL = conListURL & "?" & qString
tabListURL = tabListURL & "?" & qString

Dim obj	: Set obj = new clsMyAddress

obj.CurrPage	= page
obj.GetList "KR", ""

'네비바 내용 작성
'strMidNav = "MY 개인정보 > <b>나의 주소록</b>"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script>
function goPage(pg){
    location.href='?page='+pg;
}

function jsDelete(idx)
{
	if (confirm("이 주소를 삭제하시겠습니까?"))
	{
		location.href = "<%=conProcURL%>&mode=DEL&openerYN=N&idx=" + idx;
	}
}

function popMyAddress(url)
{
	window.open(url,'popMyAddress','width=700,height=500,scrollbars=no,resizable=no');
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_address.gif" alt="나의 주소록" /></h3>
						<ul class="list">
							<li>자주 사용하시는 배송지는 주소록에 등록 해 두시면 편리하게 이용하실 수 있습니다.</li>
							<li>국내 주소록과 해외주소록으로 나누어져 있으며 각 10개 까지 등록하실 수 있습니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<fieldset>
						<legend>나의 국내 주소록</legend>
							<div class="searchField">
								<div class="word address">
									<strong>배송주소 선택</strong>
									<a href="MyAddressList.asp" class="link current">국내</a>
									<a href="SeaAddressList.asp" class="link">해외</a>
								</div>
								<div class="option">
									<a href="<%=conSaveURL%>&openerYN=N" onclick="popMyAddress(this.href);return false;"  onFocus="blur()" class="btn btnS2 btnRed fn">주소록 추가하기</a>
								</div>
							</div>

							<table class="baseTable">
							<caption>나의 국내 주소록</caption>
							<colgroup>
								<col width="120" /> <col width="88" /> <col width="*" /> <col width="110" /> <col width="110" /> <col width="130" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">배송지명</th>
								<th scope="col">수령인</th>
								<th scope="col">주소</th>
								<th scope="col">휴대폰</th>
								<th scope="col">전화번호</th>
								<th scope="col">관리</th>
							</tr>
							</thead>
							<tbody>
					<% For i = 1 To UBound(obj.Items) %>
							<tr>
								<td><%=obj.Items(i).reqPlace%></td>
								<td><%=obj.Items(i).reqName%></td>
								<td class="lt"><%=obj.Items(i).reqZipaddr%> <%=obj.Items(i).reqAddress%></td>
								<td><%=obj.Items(i).reqHp%></td>
								<td><%=obj.Items(i).reqPhone%></td>
								<td>
									<a href="<%=conSaveURL%>&idx=<%=obj.Items(i).idx%>&openerYN=N" onclick="popMyAddress(this.href);return false;" onFocus="blur()" class="btn btnS2 btnGry2 fn">수정</a>
									<a href="javascript:jsDelete(<%=obj.Items(i).idx%>);" onFocus="blur()" class="btn btnS2 btnGry2 fn">삭제</a>
								</td>
							</tr>
					<% Next %>
					<% If UBound(obj.Items) = 0 Then %>
							<tr>
								<td colspan="6"><p class="noData fs12"><strong>등록된 나의 주소록이 없습니다.</strong></p></td>
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
<%
Set obj = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
