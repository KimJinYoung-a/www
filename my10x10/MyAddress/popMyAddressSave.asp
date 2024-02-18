<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/orderCls/clsMyAddress.asp" -->
<%
'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 나의 주소록 : 국내주소 신규등록"		'페이지 타이틀 (필수)
Dim openerYN	: openerYN	= req("openerYN","")

Dim conListURL	: conListURL = "popMyAddressList.asp"
Dim conProcURL	: conProcURL = "popAddressProc.asp"

Dim i

Dim page		: page			= req("page",1)
Dim countryCode	: countryCode	= "KR"

Dim qString
qString = "openerYN=" & openerYN & "&countryCode=" & countryCode
conProcURL = conProcURL & "?" & qString & "&page=" & page
conListURL = conListURL & "?" & qString & "&page=" & page

Dim obj	: Set obj = new clsMyAddress

obj.GetData req("idx","")

Dim zip, zip1, zip2
'zip = Split(obj.Item.reqZipcode,"-")
zip = obj.Item.reqZipcode
'If UBound(zip) >= 1 Then
'	zip1 = zip(0)
'	zip2 = zip(1)
'End If

Dim tel, tel1, tel2, tel3, tel4
tel = Split(obj.Item.reqPhone,"-")
If UBound(tel) >= 2 Then
	tel1 = tel(0)
	tel2 = tel(1)
	tel3 = tel(2)
End If

Dim hp, hp1, hp2, hp3
hp = Split(obj.Item.reqHp,"-")
If UBound(hp) >= 2 Then
	hp1 = hp(0)
	hp2 = hp(1)
	hp3 = hp(2)
End If

Dim fiximgPath
'이미지 경로 지정(SSL 처리)
if request.ServerVariables("SERVER_PORT_SECURE")<>1 then
	fiximgPath = "http://fiximage.10x10.co.kr"
else
	fiximgPath = "/fiximage"
end if

' 화면표시정보
Dim pageInfo1, pageInfo2, pageInfo3, pageInfo4
If req("idx","") = "" Then
	pageInfo1 = "INS"
	pageInfo2 = "주소 신규등록"
	pageInfo3 = "등록"
	pageInfo4 = "tit_my_address_domestic.gif"

Else
	pageInfo1 = "UPD"
	pageInfo2 = "주소 수정"
	pageInfo3 = "수정"
	pageInfo4 = "tit_addr_modify_domestic.gif"
End If
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script>

// 등록,수정,삭제 처리
function jsSubmit(mode)
{
	var f = document.frmWrite;
	if (!mode)
		if (f.idx.value=="")
			f.mode.value = "INS";
		else
			f.mode.value = "UPD";
	else
		f.mode.value = mode;

	if (!validField(f.countryCode, "국가를"))	return ;
	if (!validField(f.reqName, "수령인명을"))		return ;

		if (!validField(f.hp1, "휴대폰번호를"))	return ;
		if (!validField(f.hp2, "휴대폰번호를"))	return ;
		if (!validField(f.hp3, "휴대폰번호를"))	return ;

	//if (!validField(f.tel1, "전화번호를"))	return ;
	//if (!validField(f.tel2, "전화번호를"))	return ;
	//if (!validField(f.tel3, "전화번호를"))	return ;
	if (!validField(f.zip, "우편번호를"))	return ;
	//if (!validField(f.reqAddress, "상세주소를"))	return ;

	f.submit();

}

function searchZipcode(frmName, mode)
{
	var popwin = window.open('/common/searchzip_ka.asp?target=' + frmName + '&strMode=' + mode + '', 'popSearchZipcode'+mode, 'width=580,height=690,scrollbars=yes,resizable=yes');
	popwin.focus();
}

window.onload = function()
{
	popupResize(757);
}
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="<%=fiximgPath%>/web2013/my10x10/<%=pageInfo4%>" alt="나의 주소록" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="frmWrite" method="post" action="<%=conProcURL%>">
				<input type="hidden" name="mode">
				<input type="hidden" name="idx" value="<%=obj.Item.idx%>">
				<div class="mySection">
					<fieldset>
						<legend><%=pageInfo2%> 입력 폼</legend>
						<div class="delivery">
							<h2><%=pageInfo2%></h2>
							<% If openerYN = "" then %>
							<a href="<%=conListURL%>" class="btn btnS2 btnGry"><span class="whiteArr01 fn">나의 주소록 보기</span></a>
							<% End If %>
						</div>
						<table class="baseTable rowTable docForm">
						<caption><%=pageInfo2%></caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="deliveryName">배송지명</label></th>
							<td><input type="text" name="reqPlace" value="<%=doubleQuote(obj.Item.reqPlace)%>" id="deliveryName" class="txtInp" style="width:198px;" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="addressee">수령인명</label></th>
							<td><input type="text" name="reqName" value="<%=doubleQuote(obj.Item.reqName)%>" id="addressee" class="txtInp" style="width:198px;" /></td>
						</tr>
						<input type="hidden" name="countryCode" value="<%=countryCode%>" title="국가코드">
						<tr>
							<th scope="row">전화번호</th>
							<td>
								<select name="tel1" title="지역번호 선택" class="select" style="width:78px;">
									<option value="02" <% If CStr(tel1)="02" Then response.write "selected" %>>02</option>
									<option value="051" <% If CStr(tel1)="051" Then response.write "selected" %>>051</option>
									<option value="053" <% If CStr(tel1)="053" Then response.write "selected" %>>053</option>
									<option value="032" <% If CStr(tel1)="032" Then response.write "selected" %>>032</option>
									<option value="062" <% If CStr(tel1)="062" Then response.write "selected" %>>062</option>
									<option value="042" <% If CStr(tel1)="042" Then response.write "selected" %>>042</option>
									<option value="052" <% If CStr(tel1)="052" Then response.write "selected" %>>052</option>
									<option value="044" <% If CStr(tel1)="044" Then response.write "selected" %>>044</option>
									<option value="031" <% If CStr(tel1)="031" Then response.write "selected" %>>031</option>
									<option value="033" <% If CStr(tel1)="033" Then response.write "selected" %>>033</option>
									<option value="043" <% If CStr(tel1)="043" Then response.write "selected" %>>043</option>
									<option value="041" <% If CStr(tel1)="041" Then response.write "selected" %>>041</option>
									<option value="063" <% If CStr(tel1)="063" Then response.write "selected" %>>063</option>
									<option value="061" <% If CStr(tel1)="061" Then response.write "selected" %>>061</option>
									<option value="054" <% If CStr(tel1)="054" Then response.write "selected" %>>054</option>
									<option value="055" <% If CStr(tel1)="055" Then response.write "selected" %>>055</option>
									<option value="064" <% If CStr(tel1)="064" Then response.write "selected" %>>064</option>
									<option value="070" <% if CStr(tel1) = "070" Then response.write "Selected" %>>070</option>
									<option value="0502" <% if CStr(tel1) = "0502" Then response.write "Selected" %>>0502</option>
									<option value="0505" <% if CStr(tel1) = "0505" Then response.write "Selected" %>>0505</option>
									<option value="0506" <% if CStr(tel1) = "0506" Then response.write "Selected" %>>0506</option>
									<option value="0130" <% if CStr(tel1) = "0130" Then response.write "Selected" %>>0130</option>
									<option value="0303" <% if CStr(tel1) = "0303" Then response.write "Selected" %>>0303</option>
								</select>
								<span class="symbol">-</span>
								<input type="text" name="tel2" maxlength="4" value="<%=tel2%>" onkeydown="onlyNumber(this,event);" title="전화번호 앞자리 입력" class="txtInp" style="width:68px;" />
								<span class="symbol">-</span>
								<input type="text" name="tel3" maxlength="4" value="<%=tel3%>" onkeydown="onlyNumber(this,event);" title="전화번호 뒷자리 입력" class="txtInp" style="width:68px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">휴대전화번호</th>
							<td>
								<select name="hp1" title="휴대전화 앞자리 선택" class="select" style="width:78px;">
									<option value="010" <% If hp1=010 Then response.write "selected" %>>010</option>
									<option value="011" <% If hp1=011 Then response.write "selected" %>>011</option>
									<option value="016" <% If hp1=016 Then response.write "selected" %>>016</option>
									<option value="017" <% If hp1=017 Then response.write "selected" %>>017</option>
									<option value="018" <% If hp1=018 Then response.write "selected" %>>018</option>
									<option value="019" <% If hp1=019 Then response.write "selected" %>>019</option>
								</select>
								<span class="symbol">-</span>
								<input type="text" name="hp2" maxlength="4" value="<%=hp2%>" onkeydown="onlyNumber(this,event);" title="휴대전화 가운데자리 입력" class="txtInp" style="width:68px;" />
								<span class="symbol">-</span>
								<input type="text" name="hp3" maxlength="4" value="<%=hp3%>" onkeydown="onlyNumber(this,event);" title="휴대전화 뒷자리 입력" class="txtInp" style="width:68px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td>
								<div>
									<input type="text" name="zip" value="<%=zip%>" readonly title="우편번호" class="txtInp focusOn" style="width:60px;" />
									<a href="javascript:searchZipcode('frmWrite', 'MyAddress');" onFocus="blur()" class="btn btnS2 btnGry2 rMar05"><span class="fn">우편번호찾기</span></a>
								</div>
								<div class="tPad07">
									<input type="text" name="reqZipaddr" value="<%=doubleQuote(obj.Item.reqZipaddr)%>" title="기본주소" class="txtInp" style="width:390px;" />
								</div>
								<div class="tPad07">
									<input type="text" name="reqAddress" value="<%=doubleQuote(obj.Item.reqAddress)%>" title="상세주소" class="txtInp" style="width:390px;" />
								</div>
							</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad20">
							<input type="button" onclick="jsSubmit('<%=pageInfo1%>')" class="btn btnS1 btnRed btnW100" value="<%=pageInfo3%>" />
							<button type="button" onclick="window.close()" class="btn btnS1 btnGry btnW100">취소</button>
						</div>
					</fieldset>
				</div>
				</form>
				<!-- //content -->
			</div>
		</div>
<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->