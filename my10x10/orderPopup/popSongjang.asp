<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 운송장번호 입력"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


Dim mode	: mode = req("mode","")

Dim CsAsID	: CsAsID = req("asId","")

Dim songjangDiv	: songjangDiv = req("songjangDiv","")
Dim songjangNo	: songjangNo  = req("songjangNo","")
Dim sendSongjangNo	: sendSongjangNo  = req("sendSongjangNo","")

If mode = "SONGJANG" Then

	dim mycslist
	set mycslist = new CCSASList
	mycslist.FRectCsAsID = CsAsID

	if IsUserLoginOK() then
		mycslist.FRectUserID = getEncLoginUserID()
		mycslist.InputSongjangNo songjangDiv, songjangNo
	elseif IsGuestLoginOK() then
		mycslist.FRectOrderserial = GetGuestLoginOrderserial()
		mycslist.InputSongjangNo songjangDiv, songjangNo
	end if
	Set mycslist = Nothing

	response.write "<script>" & vbCrLf
	response.write "alert('등록되었습니다.');" & vbCrLf
	response.write "opener.location.reload();" & vbCrLf
	response.write "window.close();" & vbCrLf
	response.write "</script>" & vbCrLf
	dbget.close()	:	response.End
End If



Sub drawSelectBoxDeliverCompany(selectBoxName,selectedId)
   dim tmp_str,query1
   %><select class="select" name="<%=selectBoxName%>">
     <option value='' <%if selectedId="" then response.write " selected"%>>선택</option><%
   query1 = " select top 100 divcd,divname from [db_order].[dbo].tbl_songjang_div where isUsing='Y' "
   query1 = query1 + " order by divcd"
   rsget.Open query1,dbget,1

   if  not rsget.EOF  then
       rsget.Movefirst

       do until rsget.EOF
           if Trim(Lcase(selectedId)) = Trim(Lcase(rsget("divcd"))) then
               tmp_str = " selected"
           end if
           response.write("<option value='"&rsget("divcd")&"' "&tmp_str&">" & "" & replace(db2html(rsget("divname")),"'","") &  "</option>")
           tmp_str = ""
           rsget.MoveNext
       loop
   end if
   rsget.close
   response.write("</select>")
End Sub

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script>
function jsSubmit()
{
	var frm = document.frmWrite;
	var sendSongjangNo = "<%= sendSongjangNo %>";

	if (!frm.songjangDiv.value)
	{
		alert("택배회사를 선택해 주세요.");
		frm.songjangDiv.focus();
		return;
	}
	if (!frm.songjangNo.value || frm.songjangNo.value.length < 8)
	{
		alert("송장번호를 입력해 주세요.");
		frm.songjangNo.focus();
		return;
	}

	// 공백제거
	frm.songjangNo.value = frm.songjangNo.value.replace(/\s/g, "");

	if ((sendSongjangNo.length >= 8) && (sendSongjangNo == frm.songjangNo.value)) {
		alert("상품배송시의 송장번호를 입력하셨습니다.\n\n반품을 하시면서 받으신 [반품 송장번호] 를 입력하세요.");
		frm.songjangNo.focus();
		return;
	}

	frm.submit();
}
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_invoice.gif" alt="운송장 등록" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<fieldset>
						<legend>운송장 등록</legend>

						<form name="frmWrite" action="popSongjang.asp">
						<input type="hidden" name="mode" value="SONGJANG">
						<input type="hidden" name="asId" value="<%=CsAsID%>">

						<table class="baseTable rowTable docForm">
						<caption class="visible">반품하신 택배의 운송장번호를 등록해주세요.</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="deliveryCompany">택배사</label></th>
							<td>
								<%Call drawSelectBoxDeliverCompany("songjangDiv",songjangDiv)%>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="invoiceNumber">운송장번호</label></th>
							<td>
								<input type="text" name="songjangNo" id="invoiceNumber" value="<%=songjangNo%>" class="txtInp" style="width:185px;" />
							</td>
						</tr>
						</tbody>
						</table>
						</form>

						<div class="btnArea ct tPad20">
							<input type="button" class="btn btnS1 btnRed btnW100" onClick="jsSubmit()" value="등록" />
							<button type="button" class="btn btnS1 btnGry btnW100" onClick="window.close()">취소</button>
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
<!-- #include virtual="/lib/db/dbclose.asp" -->
