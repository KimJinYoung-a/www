<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 사업자 등록증 신규등록"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


Dim orderserial
orderserial = Request("orderserial")

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="javascript">

// 전송폼 검사
function chkForm() {
	var f = document.frm_write;
	if(!chkNumeric(f.busiNo1.value)) {
		f.busiNo1.focus();
		return;
	}
	if(f.busiNo1.value.length<3) {
		alert("사업자등록번호 1번째 자리는 3자리 숫자입니다.");
		f.busiNo1.focus();
		return;
	}

	if(!chkNumeric(f.busiNo2.value)) {
		f.busiNo2.focus();
		return;
	}
	if(f.busiNo2.value.length<1) {
		alert("사업자등록번호 2번째 자리는 2자리 숫자입니다.");
		f.busiNo2.focus();
		return;
	}

	if(!chkNumeric(f.busiNo3.value)) {
		f.busiNo3.focus();
		return;
	}

	if(f.busiNo3.value.length<5) {
		alert("사업자등록번호 3번째 자리는 5자리 숫자입니다.");
		f.busiNo3.focus();
		return;
	}

	if(!check_busino(f.busiNo1.value + f.busiNo2.value + f.busiNo3.value)) {
		alert("올바른 사업자등록번호가 아닙니다.\n정확한 사업자등록번호를 입력해주십시오.");
		f.busiNo1.focus();
		return;
	}

	if(!f.busiName.value) {
		alert("상호명을 입력해주십시오.");
		f.busiName.focus();
		return;
	}

	if(!f.busiCEOName.value) {
		alert("대표자 성명을 입력해주십시오.");
		f.busiCEOName.focus();
		return;
	}

	if(!f.busiAddr.value) {
		alert("사업장 주소를 입력해주십시오.");
		f.busiAddr.focus();
		return;
	}

	if(!f.busiType.value) {
		alert("업태를 입력해주십시오.");
		f.busiType.focus();
		return;
	}

	if(!f.busiItem.value) {
		alert("종목을 입력해주십시오.");
		f.busiItem.focus();
		return;
	}

	if(confirm("입력하신 사업자등록증의 내용이 맞습니까?\n\n맞으면 [확인], 아니면 [취소]를 눌러주십시오.")) {
		f.mode.value="add";
		f.submit();
	}
}

// 숫자입력 검사
function chkNumeric(strNum)
{
	var chk=0;
	if(!strNum) {
		alert("사업자등록번호를 입력해주십시오.");
		return false;
	} else {
		for (var i = 0; i < strNum.length; i++) {
			ret = strNum.charCodeAt(i);
			if (!((ret > 47) && (ret < 58))) {
				chk++;
			}
		}

		if(chk>0) {
			alert("숫자만을 입력해주십시오.");
			return false;
		} else {
			return true;
		}
	}
}

// 사업자등록번호 체크
function check_busino(vencod) {
	var sum = 0;
	var getlist =new Array(10);
	var chkvalue =new Array("1","3","7","1","3","7","1","3","5");
	for(var i=0; i<10; i++) { getlist[i] = vencod.substring(i, i+1); }
	for(var i=0; i<9; i++) { sum += getlist[i]*chkvalue[i]; }
	sum = sum + parseInt((getlist[8]*5)/10);
	sidliy = sum % 10;
	sidchk = 0;
	if(sidliy != 0) { sidchk = 10 - sidliy; }
	else { sidchk = 0; }
	if(sidchk != getlist[9]) { return false; }
	return true;
}

resizeTo(640,620);

//-->
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_business_license_new.gif" alt="사업자등록증 신규등록" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<fieldset>
						<legend>사업자등록증 신규등록 폼</legend>

						<form name="frm_write" method="POST"  action="doTaxOrder.asp">
						<input type="hidden" name="mode" value="">
						<input type="hidden" name="orderserial" value="<%=orderserial%>">

						<table class="baseTable rowTable docForm">
						<caption class="visible">신규등록하기</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">사업자 번호</th>
							<td>
								<input type="text" title="사업자 번호 앞자리 입력" name="busiNo1" maxlength="3" class="txtInp focusOn" style="width:58px;" />
								<span class="symbol">-</span>
								<input type="text" title="사업자 번호 가운데 입력" name="busiNo2" maxlength="2" class="txtInp focusOn" style="width:38px;" />
								<span class="symbol">-</span>
								<input type="text" title="사업자 번호 뒷자리 입력" name="busiNo3" maxlength="5" class="txtInp focusOn" style="width:98px;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="storeName">상호명</label></th>
							<td>
								<input type="text" name="busiName" maxlength="20" id="storeName" class="txtInp focusOn" style="width:179px;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="businessCeo">대표자 성명</label></th>
							<td>
								<input type="text" name="busiCEOName" maxlength="16" id="businessCeo" class="txtInp focusOn" style="width:179px;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="businessAddress">사업장 주소</label></th>
							<td>
								<input type="text" name="busiAddr" maxlength="125" id="businessAddress" class="txtInp focusOn" style="width:388px;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="businessConditions">업태</label></th>
							<td>
								<input type="text" name="busiType" maxlength="25" id="businessConditions" class="txtInp focusOn" style="width:179px;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="businessField">종목</label></th>
							<td>
								<input type="text" name="busiItem" maxlength="25" id="businessField" class="txtInp focusOn" style="width:179px;" />
							</td>
						</tr>
						</tbody>
						</table>
						</form>

						<div class="btnArea ct tPad20">
							<input type="button" class="btn btnS1 btnRed btnW100" onClick="chkForm()" value="등록" />
							<button type="button" class="btn btnS1 btnGry btnW100" onClick="window.close();">취소</button>
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
