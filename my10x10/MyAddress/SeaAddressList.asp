<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/orderCls/clsMyAddress.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
Dim openerYN	: openerYN	= requestCheckVar(req("openerYN","N"),10)

Dim tabListURL	: tabListURL = "popOldAddressList.asp"
Dim conListURL	: conListURL = "popSeaAddressList.asp"
Dim conSaveURL	: conSaveURL = "popSeaAddressSave.asp"
Dim conProcURL	: conProcURL = "popAddressProc.asp"

Dim i
dim userid: userid = getEncLoginUserID ''GetLoginUserID

Dim page		: page			= requestCheckVar(req("page",1),10)

Dim qString
qString = "openerYN=" & openerYN
conProcURL = conProcURL & "?" & qString & "&page=" & page
conSaveURL = conSaveURL & "?" & qString & "&page=" & page
conListURL = conListURL & "?" & qString
tabListURL = tabListURL & "?" & qString

Dim obj	: Set obj = new clsMyAddress

obj.CurrPage	= page

obj.GetList "", ""

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
	<div class="container my10x10Wrap skinBlue">
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
						<legend>나의 해외 주소록</legend>
							<div class="searchField">
								<div class="word address">
									<strong>배송주소 선택</strong>
									<a href="MyAddressList.asp" class="link">국내</a>
									<a href="SeaAddressList.asp" class="link current">해외</a>
								</div>
								<div class="option">
									<a href="<%=conSaveURL%>&openerYN=N" onclick="popMyAddress(this.href);return false;" onFocus="blur()" class="btn btnS2 btnRed fn">주소록 추가하기</a>
								</div>
							</div>

							<table class="baseTable">
							<caption>나의 해외 주소록</caption>
							<colgroup>
								<col width="120" /> <col width="88" /> <col width="*" /> <col width="110" /> <col width="110" /> <col width="130" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">배송지명</th>
								<th scope="col">수령인</th>
								<th scope="col">주소</th>
								<th scope="col">국가명</th>
								<th scope="col">전화번호</th>
								<th scope="col">관리</th>
							</tr>
							</thead>
							<tbody>
							<% For i = 1 To UBound(obj.Items) %>
							<tr>
								<td><%=obj.Items(i).reqPlace%></td>
								<td><%=obj.Items(i).reqName%></td>
								<td class="lt">
								<% If openerYN = "" Then %>
									<a href="javascript:openerFill('<%=obj.Items(i).countryCode%>','<%=obj.Items(i).reqName%>','<%=obj.Items(i).reqZipcode%>','<%=obj.Items(i).reqZipaddr%>','<%=obj.Items(i).reqAddress%>','<%=obj.Items(i).reqPhone%>','<%=obj.Items(i).reqHp%>','<%=obj.Items(i).reqEmail%>','<%=obj.Items(i).emsAreaCode%>','<%=obj.Items(i).countryNameEn%>','<%=obj.Items(i).countryNameKr%>');">
									<%=obj.Items(i).reqZipaddr%> <%=obj.Items(i).reqAddress%>
									</a>
								<% Else %>
									<%=obj.Items(i).reqZipaddr%> <%=obj.Items(i).reqAddress%>
								<% End If %>
								</td>
								<td><%=obj.Items(i).countryNameEn%></td>
								<td><%=obj.Items(i).reqPhone%></td>
								<td>
									<a onclick="popMyAddress(this.href);return false;" href="<%=conSaveURL%>&idx=<%=obj.Items(i).idx%>&openerYN=N" onFocus="blur()" class="btn btnS2 btnGry2 fn">수정</a>
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