<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/orderCls/clsMyAddress.asp" -->
<!-- #include virtual="/lib/classes/ordercls/emscls.asp" -->
<%
Dim openerYN	: openerYN	= req("openerYN","")

Dim conListURL	: conListURL = "popSeaAddressList.asp"
Dim conProcURL	: conProcURL = "popAddressProc.asp"

Dim i

Dim page		: page			= req("page",1)

Dim qString
qString = "openerYN=" & openerYN
conProcURL = conProcURL & "?" & qString & "&page=" & page
conListURL = conListURL & "?" & qString & "&page=" & page

Dim obj	: Set obj = new clsMyAddress

obj.GetData req("idx","")

Dim tel, tel1, tel2, tel3, tel4
tel = Split(obj.Item.reqPhone,"-")
If UBound(tel) >= 3 Then
	tel1 = tel(0)
	tel2 = tel(1)
	tel3 = tel(2)
	tel4 = tel(3)
End If


Dim arrEmail, E1, E2
IF Doublequote(Obj.Item.Reqemail)  <> "" THEN
	arrEmail = split(doubleQuote(obj.Item.reqEmail),"@")
	if ubound(arrEmail)>0 then
		E1	= arrEmail(0)
		E2	= arrEmail(1)
	end if
END IF

''EMS 관련
Dim oems : SET oems = New CEms

oems.FRectCurrPage = 1
oems.FRectPageSize = 100
oems.FRectisUsing  = "Y"
oems.GetServiceAreaList

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
	pageInfo4 = "tit_addr_new_abroad.gif"
Else
	pageInfo1 = "UPD"
	pageInfo2 = "주소 수정"
	pageInfo3 = "수정"
	pageInfo4 = "tit_addr_modify_abroad.gif"
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script>
var chkEmail = false
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

	if (!validField(f.reqName, "수령인명을"))		return ;

//	if (f.txEmail1.value)
//		if (!validEmail(f.txEmail1))	return ;

	if (!validField(f.countryCode, "국가를"))	return ;

	if (!validField(f.tel3, "전화번호를"))	return ;
	if (!validField(f.tel4, "전화번호를"))	return ;
	if (!validField(f.reqZipcode, "우편번호를"))	return ;
	if (!validField(f.reqZipaddr, "도시 및 주 (City/State)를"))	return ;
	if (!validField(f.reqAddress, "상세주소 (Address)를"))	return ;

	if (!checkAsc(f.reqName.value))
	{
		alert("영문이나 숫자 부호만 입력하실 수 있습니다.");
		f.reqName.focus();
		return;
	}
	if (!checkAsc(f.reqZipcode.value))
	{
		alert("영문이나 숫자 부호만 입력하실 수 있습니다.");
		f.reqZipcode.focus();
		return;
	}
	if (!checkAsc(f.reqZipaddr.value))
	{
		alert("영문이나 숫자 부호만 입력하실 수 있습니다.");
		f.reqZipaddr.focus();
		return;
	}
	if (!checkAsc(f.reqAddress.value))
	{
		alert("영문이나 숫자 부호만 입력하실 수 있습니다.");
		f.reqAddress.focus();
		return;
	}
	f.submit();

}

function emsBoxChange(comp)
{
	var f = document.frmWrite;
    if (comp.value==''){
        f.countryCode.value = '';
        f.emsAreaCode.value = '';
    }else{
        f.countryCode.value = comp.value;
        f.emsAreaCode.value = comp[comp.selectedIndex].iAreaCode;
    }
}

// 이메일 폼 양식
function NewEmailChecker(){
	var frm = document.frmWrite;
	if( frm.txEmail2.value == "etc")  {
		frm.selfemail.style.display = '';
		frm.selfemail.focus();
	}else{
		frm.selfemail.style.display = 'none';
	}
	jsChkEmail();
	return;
}
function jsChkEmail(){
	if(chkEmail){
		$("#checkMsgEmail").html("이메일을 입력해주세요.");
		chkEmail = false;
	}
}
function keyCodeCheckEmail(event) {
	if(event.keyCode == 13){
		DuplicateEmailCheck();
	}
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
				<h1><img src="<%=fiximgPath%>/web2013/my10x10/<%=pageInfo4%>" alt="나의 주소록_해외배송" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="frmWrite" method="post" action="<%=conProcURL%>">
				<input type="hidden" name="mode">
				<input type="hidden" name="idx" value="<%=obj.Item.idx%>">
				<div class="mySection">
					<div class="delivery">
					<h2 class="tMar0"><%=pageInfo2%></h2>
						<% 'If openerYN = "" then %>
						<a href="<%=conListURL%>" class="btn btnS2 btnGry"><span class="whiteArr01 fn">나의 주소록 보기</span></a>
						<% 'End If %>
					</div>
					<ul class="list">
						<li><span class="crRed">해외 배송지 관련 모든 정보는 반드시 영문으로 작성하여 주시기 바랍니다.</span> (배송지명은 한글 가능)</li>
					</ul>
					<fieldset>
						<legend>주소 신규등록 입력 폼</legend>
						<table class="baseTable rowTable docForm tMar10">
						<caption>주소 신규등록</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="deliveryName">배송지명</label></th>
							<td><input type="text" name="reqPlace" value="<%=doubleQuote(obj.Item.reqPlace)%>" id="deliveryName" class="txtInp" style="width:300px;" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="addressee">수령인명</label></th>
							<td><input type="text" name="reqName" onkeyup="onlyAsc(this);" value="<%=doubleQuote(obj.Item.reqName)%>" id="addressee" class="txtInp" style="width:300px;IME-MODE:disabled;" /></td>
						</tr>
						<tr>
							<th scope="row">수령인 E-mail</th>
							<td>
								<input type="text" name="txEmail1" maxlength="32" onKeyDown="keyCodeCheckEmail(event);" onKeyUp="jsChkEmail();" onClick="jsChkEmail();" title="이메일 아이디 입력" value="<%=e1%>" class="txtInp focusOn" style="width:120px;ime-mode:disabled;" />
								<span class="symbol">@</span>
								<input type="hidden" name="usermail" value="<%= doubleQuote(obj.Item.reqEmail) %>">
								<input type="text" name="selfemail" onKeyDown="keyCodeCheckEmail(event);" onKeyUp="jsChkEmail();" onClick="jsChkEmail();" maxlength="80" title="이메일 직접 입력" value="<%=e2%>" class="txtInp" style="width:120px;ime-mode:disabled;" />
								<select name="txEmail2" title="이메일 서비스 선택" onchange="NewEmailChecker()" class="select emailSelect" style="width:102px;">
									<option value="etc">직접입력</option>
									<option value="@hanmail.net">hanmail.net</option>
									<option value="@naver.com">naver.com</option>
									<option value="@hotmail.com">hotmail.com</option>
									<option value="@yahoo.co.kr">yahoo.co.kr</option>
									<option value="@hanmir.com">hanmir.com</option>
									<option value="@paran.com">paran.com</option>
									<option value="@lycos.co.kr">lycos.co.kr</option>
									<option value="@nate.com">nate.com</option>
									<option value="@dreamwiz.com">dreamwiz.com</option>
									<option value="@korea.com">korea.com</option>
									<option value="@empal.com">empal.com</option>
									<option value="@netian.com">netian.com</option>
									<option value="@freechal.com">freechal.com</option>
									<option value="@msn.com">msn.com</option>
									<option value="@gmail.com">gmail.com</option>

								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="fs11"><label for="country">국가 선택</label></th>
							<td>
								<select title="배송 국가 선택" onChange="emsBoxChange(this);" id="country" class="select" style="width:320px;">
									<option>배송 국가 선택</option>
									<% for i=0 to oems.FREsultCount-1 %>
		                            <option value="<%= oems.FItemList(i).FcountryCode %>" iAreaCode="<%= oems.FItemList(i).FemsAreaCode %>" <%If oems.FItemList(i).FcountryCode = obj.Item.countryCode Then response.write "selected" %>><%= oems.FItemList(i).FcountryNameKr %>(<%= oems.FItemList(i).FcountryNameEn %>)</option>
		                     	     <% next %>
								</select>
								<input type="text" name="countryCode" value="<%=obj.Item.countryCode%>"  maxlength="2" readOnly class="txtRead box5 lh19" style="width:30px;" readonly />
								<input type="text" name="emsAreaCode" value="<%=obj.Item.emsAreaCode%>"  maxlength="1" readOnly class="txtRead box5 lh19" style="width:30px;" readonly />
							</td>
						</tr>
						<tr>
							<th scope="row" class="fs11"><strong>전화번호 <span class="crRed">*</span></strong><br />(Tel. NO)</th>
							<td>
								<input type="text" name="tel1" maxlength="4" value="<%=tel1%>" onkeydown="onlyNumber(this,event);" title="국가번호 입력" class="txtInp" style="width:40px;" />
								<span class="symbol">-</span>
								<input type="text" name="tel2" maxlength="4" value="<%=tel2%>" onkeydown="onlyNumber(this,event);" title="지역번호 입력" class="txtInp" style="width:40px;" />
								<span class="symbol">-</span>
								<input type="text" name="tel3" maxlength="4" value="<%=tel3%>" onkeydown="onlyNumber(this,event);" title="국번 입력" class="txtInp" style="width:40px;" />
								<span class="symbol">-</span>
								<input type="text" name="tel4" maxlength="4" value="<%=tel4%>" onkeydown="onlyNumber(this,event);" title="전화번호 입력" class="txtInp" style="width:40px;" />
								<span class="fs11 lPad05">(국가번호 - 지역번호 - 국번 - 전화번호)</span>
							</td>
						</tr>
						<tr>
							<th scope="row" class="fs11"><strong>우편번호 <span class="crRed">*</span></strong><br />(Zip code)</th>
							<td>
								<input type="text" name="reqZipcode" value="<%=obj.Item.reqZipcode%>" onkeyup="onlyAsc(this);" maxlength="20" title="우편번호 입력" class="txtInp" style="width:300px; IME-MODE:disabled;" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="fs11">도시 및 주<br />(City/State)</th>
							<td>
								<input type="text" name="reqZipaddr" value="<%=doubleQuote(obj.Item.reqZipaddr)%>" onkeyup="onlyAsc(this);" title="상세주소" class="txtInp" style="width:300px; IME-MODE:disabled;" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="fs11"><strong>상세주소 <span class="crRed">*</span></strong><br />(Address)</th>
							<td>
								<input type="text" name="reqAddress" value="<%=doubleQuote(obj.Item.reqAddress)%>" onkeyup="onlyAsc(this);" title="상세주소" class="txtInp" style="width:93%; IME-MODE:disabled;" />
							</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad20">
							<input type="button" onclick="jsSubmit('<%=pageInfo1%>')" class="btn btnS1 btnRed btnW100" value="<%= pageInfo3 %>" />
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