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
Dim openerYN	: openerYN	= requestCheckVar(req("openerYN",""),2)
Dim countryCode : countryCode = requestCheckVar(req("countryCode",""),4)
Dim sgubun : sgubun = requestCheckVar(req("sgubun",""),20)

Dim tabListURL	: tabListURL = "popOldAddressList.asp"
Dim conListURL	: conListURL = "popMyAddressList.asp"
Dim conSaveURL	: conSaveURL = "popMyAddressSave.asp"
Dim conProcURL	: conProcURL = "popAddressProc.asp"

Dim i

Dim page		: page			= requestCheckVar(req("page",1),2)

Dim qString
qString = "openerYN=" & openerYN & "&countryCode=KR&sgubun="&sgubun
conProcURL = conProcURL & "?" & qString & "&page=" & page
conSaveURL = conSaveURL & "?" & qString & "&page=" & page
conListURL = conListURL & "?" & qString
tabListURL = tabListURL & "?" & qString

Dim obj	: Set obj = new clsMyAddress

obj.CurrPage	= page

obj.GetList "KR", ""

Dim fiximgPath
'이미지 경로 지정(SSL 처리)
if request.ServerVariables("SERVER_PORT_SECURE")<>1 then
	fiximgPath = "http://fiximage.10x10.co.kr"
else
	fiximgPath = "/fiximage"
end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script>
function TnMovePage(icomp){
	document.frm.page.value=icomp;
	document.frm.submit();
}
function jsDelete(idx)
{
	if (confirm("이 주소를 삭제하시겠습니까?"))
	{
		location.href = "<%=conProcURL%>&mode=DEL&idx=" + idx;
	}
}

function openerFill(countryCode,reqName,reqZipcode,reqZipaddr,reqAddress,reqPhone,reqHp,reqEmail,emsAreaCode,countryNameEn,countryNameKr)
{
		var o = opener.document.frmorder;

		o.reqname.value	= reqName;
		o.txAddr1.value	= reqZipaddr;
		o.txAddr2.value	= reqAddress;

		// 국내배송정보
		var tel	= reqPhone.split("-");
		o.reqphone1.value	= tel[0];
		o.reqphone2.value	= tel[1];
		o.reqphone3.value	= tel[2];

		var hp	= reqHp.split("-");
		o.reqhp1.value	= hp[0];
		o.reqhp2.value	= hp[1];
		o.reqhp3.value	= hp[2];

		var zip	= reqZipcode;
		o.txZip.value = zip;

	window.close();
}

window.onload = function()
{
	popupResize(780);
}
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_address_popup.gif" alt="나의 주소록" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
				<% If openerYN = "" Then %>
					<a href="popMyAddressList.asp" onFocus="blur()">국내</a>
					<a href="popSeaAddressList.asp" onFocus="blur()">해외</a>
				<% End If %>
					<ul class="list">
						<li>주소록 관리는 마이텐바이텐에서도 가능합니다.</li>
						<li>해당 주소를 클릭하면 자동입력 됩니다.</li>
					</ul>
					<div class="sorting">
						<ul class="tabMenu addArrow tabReview tMar15">
							<li><a href="popMyAddressList.asp" class="on"><span>나의 주소록</span></a></li>
							<li><a href="<%=tabListURL%>"><span>과거 배송지</span></a></li>
						</ul>
						<div class="option">
							<a href="<%=conSaveURL%>" class="btn btnS2 btnRed fn">신규등록</a>
						</div>
					</div>
					<form name="frm" method="GET" action="">
					<input type="hidden" name="page" value="<%=page%>">
					<input type="hidden" name="openerYN" value="<%=openerYN%>">
					<input type="hidden" name="countryCode" value="<%=countryCode%>">
					<input type="hidden" name="sgubun" value="<%=sgubun%>">
					</form>
					<table class="baseTable tMar30">
					<caption>나의 주소록</caption>
					<colgroup>
						<col width="80" /> <col width="100" /> <col width="*" /> <col width="110" /> <col width="110" /> <col width="120" />
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
						<td class="lt">
						<% If openerYN = "" Then %>
							<a href="javascript:openerFill('<%=obj.Items(i).countryCode%>','<%=obj.Items(i).reqName%>','<%=obj.Items(i).reqZipcode%>','<%=obj.Items(i).reqZipaddr%>','<%=obj.Items(i).reqAddress%>','<%=obj.Items(i).reqPhone%>','<%=obj.Items(i).reqHp%>','<%=obj.Items(i).reqEmail%>','<%=obj.Items(i).emsAreaCode%>','<%=obj.Items(i).countryNameEn%>','<%=obj.Items(i).countryNameKr%>');">
							<%=obj.Items(i).reqZipaddr%> <%= obj.Items(i).reqAddress %>
							</a>
						<% Else %>
							<%=obj.Items(i).reqZipaddr%> <%= obj.Items(i).reqAddress %>
						<% End If %>
						</td>
						<td><%=obj.Items(i).reqHp%></td>
						<td><%=obj.Items(i).reqPhone%></td>
						<td>
							<a href="<%=conSaveURL%>&idx=<%=obj.Items(i).idx%>" class="btn btnS2 btnGry2 fn">수정</a>
							<a href="javascript:jsDelete(<%=obj.Items(i).idx%>);" class="btn btnS2 btnGry2 fn">삭제</a>
						</td>
					</tr>
				<% Next %>
				<% If UBound(obj.Items) = 0 Then %>
					<tr>
						<td colspan="6"><p class="noData"><strong>등록된 나의 주소록이 없습니다.</strong></p></td>
					</tr>
				<% End If %>
					</tbody>
					</table>

					<div class="pageWrapV15 tMar20 bPad10">
						<%= fnDisplayPaging_New_nottextboxdirect(obj.CurrPage,obj.TotalCount,obj.PageSize,10,"TnMovePage") %>
					</div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%
Set obj = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
