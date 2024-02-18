<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- include virtual="/lib/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/ordercls/cashreceiptcls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 무통장 입금 현금영수증 발행"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim idx
idx = session("lastreceiptidx")

dim ocashreceipt
set ocashreceipt = new CCashReceipt
ocashreceipt.FRectIdx = idx
ocashreceipt.GetOneCashReceipt

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script>

function showreceipt(tid){
	var showreceiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/Cash_mCmReceipt.jsp?noTid=" + tid + "&clpaymethod=22";
	window.open(showreceiptUrl,"showreceipt","width=380,height=540, scrollbars=no,resizable=no");
}

//var openwin=window.open("childwin.html","childwin","width=299,height=149");
//openwin.close();

</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_cash_detail.gif" alt="현금영수증 발급내역" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<table class="baseTable rowTable docForm">
					<caption class="visible">고객님께서 요청하신 현금영수증 발급내용입니다.</caption>
					<colgroup>
						<col width="120" /> <col width="*" />
					</colgroup>
					<tbody>
					<tr>
						<th scope="row">발급결과</th>
						<td>
							<% IF ocashreceipt.FoneItem.FResultCode = "00" THEN %>
							성공
							<% else %>
							<strong class="crRed">발급실패</strong>
							<% end if %>
						</td>
					</tr>
					<tr>
						<th scope="row">결과내용</th>
						<td><%= ocashreceipt.FoneItem.Fresultmsg %></td>
					</tr>
					<tr>
						<th scope="row">승인번호</th>
						<td>
							<% IF ocashreceipt.FoneItem.FResultCode = "00" THEN %>
							<%= ocashreceipt.FoneItem.FResultCashNoAppl %>
							<% end if %>
						</td>
					</tr>
					<tr>
						<th scope="row">총 발급금액</th>
						<td>
							<% IF ocashreceipt.FoneItem.FResultCode = "00" THEN %>
							<strong class="crRed"><%= ocashreceipt.FoneItem.Fcr_price %></strong>원
							<% end if %>

						</td>
					</tr>
					<tr>
						<th scope="row">발행구분</th>
						<td>
							<%
							IF ocashreceipt.FoneItem.FResultCode = "00" THEN
								IF ocashreceipt.FoneItem.Fuseopt = "0" THEN
									response.write "소비자 소득공제용"
								ELSE
									response.write "사업자 지출증빙용"
								END IF
							end if
							%>
						</td>
					</tr>
					</tbody>
					</table>

					<div class="btnArea ct tPad20">
						<% IF ocashreceipt.FoneItem.FResultCode = "00" THEN %>
						<a href="javascript:window.close();" class="btn btnS1 btnRed btnW100">확인</a>
						<a href="javascript:showreceipt('<%= ocashreceipt.FoneItem.FTid %>')" class="btn btnS1 btnWhite btnW100">영수증 출력</a>
						<% else %>
						<a href="javascript:history.back();" class="btn btnS1 btnRed btnW100">재시도</a>
						<% end if %>
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
set ocashreceipt = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
