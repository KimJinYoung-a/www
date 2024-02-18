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
'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 나의 주소록 : 국내 과거배송지"		'페이지 타이틀 (필수)
Dim openerYN	: openerYN	= req("openerYN","")
Dim sgubun : sgubun = requestCheckVar(req("sgubun",""),20)

Dim tabListURL
Dim conListURL	: conListURL = "popOldAddressList.asp"
Dim conProcURL	: conProcURL = "popAddressProc.asp"

Dim i

Dim page		: page			= req("page",1)
Dim countryCode	: countryCode	= req("countryCode","")

Dim fiximgPath
'이미지 경로 지정(SSL 처리)
if request.ServerVariables("SERVER_PORT_SECURE")<>1 then
	fiximgPath = "http://fiximage.10x10.co.kr"
else
	fiximgPath = "/fiximage"
end if

Dim backImage
If countryCode = "KR" Then
	tabListURL = "popMyAddressList.asp"
	backImage = fiximgPath & "/web2009/order/myadd_title.gif"
Else
	tabListURL = "popSeaAddressList.asp"
	backImage = fiximgPath & "/web2009/order/myadd_title_global.gif"
End If

Dim qString
qString = "openerYN=" & openerYN & "&countryCode=" & countryCode &"&sgubun="&sgubun
conProcURL = conProcURL & "?" & qString & "&page=" & page
conListURL = conListURL & "?" & qString
tabListURL = tabListURL & "?" & qString

Dim obj	: Set obj = new clsMyAddress

obj.CurrPage	= page

obj.GetList countryCode, "OLD"

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script>
function TnMovePage(icomp){
	document.frm.page.value=icomp;
	document.frm.submit();
}
function jsCopy(orderSerial)
{
	if (confirm("나의 주소록에 저장하시겠습니까?"))
	{
		location.href = "<%=conProcURL%>&mode=COPY&orderSerial=" + orderSerial;
	}
}

function openerFill(countryCode,reqName,reqZipcode,reqZipaddr,reqAddress,reqPhone,reqHp,reqEmail,emsAreaCode,countryNameEn,countryNameKr)
{
	var o = opener.document.frmorder;

	o.reqname.value	= reqName;
	o.txAddr1.value	= reqZipaddr;
	o.txAddr2.value	= reqAddress;

	if (countryCode=="KR")	// 국내배송정보
	{
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
	}
	else					// 해외배송정보
	{
		var tel	= reqPhone.split("-");
		o.reqphone1.value	= tel[0];
		o.reqphone2.value	= tel[1];
		o.reqphone3.value	= tel[2];
		o.reqphone4.value	= tel[3];

		o.countryCode.value	= countryCode;

		o.reqEmail.value	= reqEmail;
		o.reqZipcode.value	= reqZipcode;

		o.emsAreaCode.value	= emsAreaCode;
		o.countryNameEn.value	= countryNameEn;
		o.countryNameKr.value	= countryNameKr;

	}
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
					<ul class="list">
						<li>고객님께서 최근 6개월간 사용하신 배송지 정보입니다.</li>
						<li>해당 주소를 클릭하면 자동입력 됩니다.</li>
					</ul>
					<ul class="tabMenu addArrow tabReview tMar15">
						<li><a href="<%=tabListURL%>"><span>나의 주소록</span></a></li>
						<li><a href="<%=conListURL%>" class="on"><span>과거 배송지</span></a></li>
					</ul>
					<table class="baseTable tMar30">
					<caption>나의 주소록</caption>
					<colgroup>
						<col width="100" /> <col width="*" /> <col width="110" /> <col width="110" /> <col width="140" />
					</colgroup>
					<form name="frm" method="GET" action="">
					<input type="hidden" name="page" value="<%=page%>">
					<input type="hidden" name="openerYN" value="<%=openerYN%>">
					<input type="hidden" name="countryCode" value="<%=countryCode%>">
					<input type="hidden" name="sgubun" value="<%=sgubun%>">
					</form>
					<thead>
					<tr>
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
						<td><%=obj.Items(i).reqHp%></td>
						<td><%=obj.Items(i).reqPhone%></td>
						<td><a href="javascript:jsCopy('<%=obj.Items(i).orderSerial%>');" onFocus="blur()" class="btn btnS2 btnGry2 fn">나의 주소록에 저장</a></td>
					</tr>
				<% Next %>
				<% If UBound(obj.Items) = 0 Then %>
					<tr>
						<td colspan="5"><p class="noData"><strong>등록된 나의 과거배송지가 없습니다.</strong></p></td>
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