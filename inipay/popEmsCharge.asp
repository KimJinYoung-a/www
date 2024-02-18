<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/emscls.asp" -->

<%
strPageTitle = "텐바이텐 10X10 : EMS 지역요금 보기"		'페이지 타이틀 (필수)

Dim cCode : cCode = requestCheckVar(request("cCode"),2)
Dim emsareaCode, emsMaxWeight, i

Dim oems : SET oems = New CEms
Dim fiximgPath

Dim oemsArea : SET oemsArea = New CEms
oemsArea.FRectCurrPage = 1
oemsArea.FRectPageSize = 200
oemsArea.FRectisUsing  = "Y"
oemsArea.GetServiceAreaList

for i=0 to oemsArea.FResultcount-1
    if (UCASE(oemsArea.FItemList(i).FcountryCode)=UCASE(cCode)) then
        emsareaCode = oemsArea.FItemList(i).FemsAreaCode
        emsMaxWeight = oemsArea.FItemList(i).FemsMaxWeight
        Exit for
    end if
Next

if (emsareaCode<>"") then
    oems.FRectCurrPage = 1
    oems.FRectPageSize = 100
    oems.FRectEmsAreaCode  = emsareaCode
    oems.GetWeightPriceList
end if

'이미지 경로 지정(SSL 처리)
if request.ServerVariables("SERVER_PORT_SECURE")<>1 then
	fiximgPath = "http://fiximage.10x10.co.kr"
else
	fiximgPath = "/fiximage"
end if


Dim AreaAddStr

IF (emsareaCode="A") then
    AreaAddStr = " (특정1)"
elseif (emsareaCode="B") then
    AreaAddStr = " (특정2)"
elseif (emsareaCode="C") then
    AreaAddStr = " (특정3)"
elseif (emsareaCode="D") then
    AreaAddStr = " (특정4)"
elseif (emsareaCode="E") then
    AreaAddStr = " (특정5)"
elseif (emsareaCode="F") then
    AreaAddStr = " (특정6)"
end if

Dim Cols : Cols = 2
Dim Rows
Rows = CLNG(oems.FResultCount/2)


%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language='javascript'>
function resetCountryCode(comp){
    if (comp.value!=''){
        location.href='?cCode='+comp.value;
    }
}
</script>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup_ssl.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/inipay/tit_ems_fee.gif" alt="EMS 지역요금 보기" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="emsWrap">
					<form action="">
					<fieldset>
					<legend>EMS 배송 국가 선택</legend>
						<div class="box5 ct tPad20 bPad20">
							<select name="countryCode" title="배송 국가를 선택해 주세요." class="optSelect" style="width:338px; height:20px;" onChange="resetCountryCode(this)";>
								<% for i=0 to oemsArea.FREsultCount-1 %>
    							<option value="<%= oemsArea.FItemList(i).FcountryCode %>" <%=CHKIIF(UCASE(oemsArea.FItemList(i).FcountryCode)=UCASE(cCode),"selected","")%> ><%= oemsArea.FItemList(i).FcountryNameKr %>(<%= oemsArea.FItemList(i).FcountryNameEn %>)</option>
    							<% next %>
							</select>
						</div>

						<table class="baseTable orderForm tMar10">
						<caption>요금적용지역 및 제한중량</caption>
						<colgroup>
							<col width="25%" /> <col width="25%" /> <col width="25%" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">요금적용지역</th>
							<td class="lt removeLine"><%=emsareaCode%> <%=AreaAddStr%> 지역</td>
							<th scope="row">제한중량</th>
							<td class="lt removeLine"><%=emsMaxWeight/1000%>KG</td>
						</tr>
						</tbody>
						</table>
					</fieldset>
					</form>
				</div>

				<div class="orderWrap emsWrap">
					<div class="ct tMar35">
						<h2 class="crRed fs15 bPad05">EMS 중량/지역별 요금</h2>
						<p>제 <%= emsareaCode %> <%=AreaAddStr%> 지역 중량별 요금</p>
					</div>

					<table class="baseTable orderForm lastLine tMar15">
					<caption>EMS 중량/지역별 요금</caption>
					<colgroup>
						<col width="25%" /> <col width="25%" /> <col width="25%" /> <col width="*" />
					</colgroup>
					<thead>
					<tr>
						<th scope="row">중량 (Kg)</th>
						<th scope="row">EMS 요금 (원)</th>
						<th scope="row" class="borderLine">중량 (Kg)</th>
						<th scope="row">EMS 요금 (원)</th>
					</tr>
					</thead>
					<tbody>
					<% for i=0 to Rows-1 %>
					<tr>
						<td><%= CLng(oems.FItemList(i).FWeightLimit/1000*100)/100 %></td>
						<td><%= FormatNumber(oems.FItemList(i).FemsPrice,0) %></td>
						<% if (Rows+i<oems.FResultCount) then %>
						<td class="borderLine"><%= CLng(oems.FItemList(Rows+i).FWeightLimit/1000*100)/100 %></td>
						<td><%= FormatNumber(oems.FItemList(Rows+i).FemsPrice,0) %></td>
						<% else %>
						<td class="borderLine"></td>
						<td></td>
						<% end if %>
					</tr>
                    <% next %>
					</tbody>
					</table>
				</div>
				<!-- //content -->
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>

<%
SET oemsArea = Nothing
SET oems = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->