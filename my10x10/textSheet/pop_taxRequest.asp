<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/classes/cscenter/taxsheet_cls.asp"-->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 세금계산서 발급요청"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


Dim orderserial, BusiIdx
Dim oBusi, i, lp
Dim userId, TotalCount

orderserial = Request("orderserial")
BusiIdx = Request("BusiIdx")
userid = GetLoginUserID


'// 내용 접수
set oBusi = new CBusi
oBusi.FRectBusiIdx = BusiIdx
oBusi.FRectorderserial = orderserial
oBusi.FRectuserid = userid

oBusi.GetBusiRead

Dim repTel : repTel = Replace(oBusi.FBusiList(0).Fusercell," ","")
Dim repTel1, repTel2, repTel3
repTel1 = SplitValue(repTel,"-",0)
repTel2 = SplitValue(repTel,"-",1)
repTel3 = SplitValue(repTel,"-",2)

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="javascript">

// 전송폼 검사
function chkForm()
{
	var frm = document.frm_write;

	if(!frm.repName.value)
	{
		alert("담당자 이름을 입력해주십시오.");
		frm.repName.focus();
		return ;
	}

	if(!frm.repTel1.value){
		alert("담당자 전화번호를 입력해주십시오.");
		frm.repTel1.focus();
		return ;
	}

	if(!frm.repTel2.value){
		alert("담당자 전화번호를 입력해주십시오.");
		frm.repTel2.focus();
		return ;
	}

	if(!frm.repTel3.value){
		alert("담당자 전화번호를 입력해주십시오.");
		frm.repTel3.focus();
		return ;
	}

	if(!frm.repEmail.value)
	{
		alert("담당자 이메일을 입력해주십시오.");
		frm.repEmail.focus();
		return ;
	}

	if(confirm("작성하신 내용이 맞습니까?\n\n맞으면 [확인], 아니면 [취소]를 눌러주십시오."))
	{
		frm.mode.value="request";
		frm.submit();
	}
}

resizeTo(810,800);

</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_tax_issue.gif" alt="세금계산서 발급요청" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->

				<form name="frm_write" method="POST" action="doTaxOrder.asp">
				<input type="hidden" name="mode" value="">
				<input type="hidden" name="orderserial" value="<%=orderserial%>">
				<input type="hidden" name="BusiIdx" value="<%=BusiIdx%>">
				<!-- 정산내용 -->
				<input type="hidden" name="orderIdx" value="<%=db2html(oBusi.FBusiList(0).ForderIdx)%>">
				<input type="hidden" name="itemname" value="<%=db2html(oBusi.FBusiList(0).FitemName)%>">
				<input type="hidden" name="totalPrice" value="<%=oBusi.FBusiList(0).FtotalPrice%>">
				<input type="hidden" name="totalTax" value="<%=oBusi.FBusiList(0).FtotalTax%>">

				<div class="mySection">
					<fieldset>
					<legend>세금계산서 발급요청</legend>
						<div class="taxWrap">
							<table class="baseTable rowTable docForm first">
							<caption class="visible">공급자</caption>
							<colgroup>
								<col width="120" /> <col width="*" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">등록번호</th>
								<td class="fs11">211-87-00620</td>
							</tr>
							<tr>
								<th scope="row">상호</th>
								<td class="fs11">(주)텐바이텐</td>
							</tr>
							<tr>
								<th scope="row">대표자</th>
								<td class="fs11">최은희</td>
							</tr>
							<tr>
								<th scope="row">사업장 주소</th>
								<td class="fs11">서울시 종로구 대학로 57 홍익대학교 대학로캠퍼스 교육동 14층 (주)텐바이텐</td>
							</tr>
							<tr>
								<th scope="row">업태</th>
								<td class="fs11">서비스 외</td>
							</tr>
							<tr>
								<th scope="row">종목</th>
								<td class="fs11">전자상거래 외</td>
							</tr>
							</tbody>
							</table>

							<table class="baseTable rowTable docForm">
							<caption class="visible">공급받는자</caption>
							<colgroup>
								<col width="120" /> <col width="*" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">등록번호</th>
								<td class="fs11"><%=oBusi.FBusiList(0).FbusiNo%></td>
							</tr>
							<tr>
								<th scope="row">상호</th>
								<td class="fs11"><%=db2html(oBusi.FBusiList(0).FbusiName)%></td>
							</tr>
							<tr>
								<th scope="row">대표자</th>
								<td class="fs11"><%=db2html(oBusi.FBusiList(0).FbusiCEOName)%></td>
							</tr>
							<tr>
								<th scope="row">사업장 주소</th>
								<td class="fs11"><%=db2html(oBusi.FBusiList(0).FbusiAddr)%></td>
							</tr>
							<tr>
								<th scope="row">업태</th>
								<td class="fs11"><%=db2html(oBusi.FBusiList(0).FbusiType)%></td>
							</tr>
							<tr>
								<th scope="row">종목</th>
								<td class="fs11"><%=db2html(oBusi.FBusiList(0).FbusiItem)%></td>
							</tr>
							</tbody>
							</table>
						</div>

						<table class="baseTable rowTable docForm tMar30">
						<caption class="visible">정산내용</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">품목</th>
							<td class="fs11"><%=db2html(oBusi.FBusiList(0).FitemName)%></td>
						</tr>
						<tr>
							<th scope="row">발행금액</th>
							<td class="fs12"><strong class="crRed"><%=FormatNumber(oBusi.FBusiList(0).FtotalPrice,0)%></strong>원 (공급가 : <%=FormatNumber(oBusi.FBusiList(0).FtotalPrice-oBusi.FBusiList(0).FtotalTax,0)%>원 / 부가세 : <%=FormatNumber(oBusi.FBusiList(0).FtotalTax,0)%>원)</td>
						</tr>
						<tr>
							<th scope="row">발행일</th>
							<td class="fs11">
								<strong><%= FormatDate(oBusi.FBusiList(0).getMayTaxDate, "0000/00/00") %></strong>
								<input type="hidden" name="isueDate" value="<%= oBusi.FBusiList(0).getMayTaxDate %>">
							</td>
						</tr>
						</tbody>
						</table>

						<table class="baseTable rowTable docForm tMar30">
						<caption class="visible">담당자 정보입력</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="staffName">담당자 이름</label></th>
							<td><input type="text" name="repName" id="staffName" value="<%=db2html(oBusi.FBusiList(0).Fusername)%>" maxlength="16" class="txtInp focusOn" style="width:118px;" /></td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td>
								<input type="text" name="repTel1" title="연락처 앞자리 입력" value="<%= repTel1 %>" maxlength="3" class="txtInp" style="width:48px;" />
								<span class="symbol">-</span>
								<input type="text" name="repTel2" title="연락처 가운데자리 입력" value="<%= repTel2 %>" maxlength="4" class="txtInp" style="width:48px;" />
								<span class="symbol">-</span>
								<input type="text" name="repTel3" title="전화번호 뒷자리 입력" value="<%= repTel3 %>" maxlength="4" class="txtInp" style="width:48px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">이메일주소</th>
							<td>
								<input type="text" name="repEmail" title="이메일 아이디 입력" value="<%= db2html(oBusi.FBusiList(0).Fusermail) %>" maxlength="125" class="txtInp focusOn" style="width:250px;" />
							</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad20">
							<input type="button" class="btn btnS1 btnRed btnW100" onClick="chkForm();" value="발급요청" />
							<a href="javascript:window.close();" class="btn btnS1 btnGry btnW100">취소</a>
						</div>
					</fieldset>

				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%

set oBusi = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
