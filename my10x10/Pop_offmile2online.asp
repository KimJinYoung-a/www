<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkpoplogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 온라인 마일리지로 전환"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim userid, ipoint, arrPoint, intN, vTotalCount
userid = getEncLoginUserID

set ipoint = new TenPoint
ipoint.FRectUserId = userid
arrPoint = ipoint.getOffShopMileagePop
vTotalCount = ipoint.FOffShopMileagePopCount
set ipoint = Nothing

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>

function MakeMile(frm){
	var offmile = eval("document.milefrm.point"+milefrm.cardno.value+".value");

	if (!IsDigit(frm.changrmile.value)){
		alert('숫자를 입력하세요.');
		frm.changrmile.focus();
		return;
	}


	if ((frm.changrmile.value*1>offmile*1)||(frm.changrmile.value*1<1)){
		alert('전환 하실 수 있는 마일리지는 ' + offmile + 'point 입니다.');
		frm.changrmile.focus();
		return;
	}

	if (confirm('전환 하시겠습니까?')){
		frm.submit();
	}
}

function IsDigit(v){
	for (var j=0; j < v.length; j++){
		if ((v.charAt(j) * 0 == 0) == false){
			return false;
		}
	}
	return true;
}

function NowPoint() {
	var frm = document.milefrm;

	document.all.nowpnt.innerHTML = eval("document.milefrm.point"+frm.cardno.value+".value") + " point";
	frm.changrmile.value = eval("document.milefrm.point"+frm.cardno.value+".value") + "";
}

$(document).ready(function() {
	NowPoint();
});


</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_mileage_change.gif" alt="온라인 마일리지로 전환" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<ul class="list">
						<li>온라인 마일리지는 <strong class="crRed">30,000원 이상</strong> 구매시 사용 가능합니다.</li>
						<li>한번 전환 한 마일리지는 다시 오프라인 마일리지로 전환 할 수 없습니다.</li>
					</ul>
					<form name="milefrm" method="post" action="/my10x10/Pop_offmile2online_process.asp">
					<fieldset>
						<legend>온라인 마일리지로 전환하기</legend>
						<table class="baseTable rowTable docForm tMar15">
						<caption>온라인 마일리지로 전환</caption>
						<colgroup>
							<col width="170" /> <col width="*" />
						</colgroup>
						<tbody>
						<% If vTotalCount > 1 Then %>
						<tr>
							<th scope="row">카드선택</th>
							<td>
								<select title="온라인 마일리지로 전환할 카드를 선택하세요" class="select ftVdana lPad10" style="width:208px;" name="cardno" onChange="NowPoint()">
							<%
								IF isArray(arrPoint) THEN
								For intN =0 To UBound(arrPoint,2)
							%>
									<option value="<%=arrPoint(0,intN)%>" <% If intN = 0 Then %>selected<% End If %>><%=arrPoint(0,intN)%></option>
							<%
								Next
								END IF
							%>
								</select>
							</td>
						</tr>
						<% else %>
						<tr>
							<th scope="row">카드번호</th>
							<td>
								<% if isArray(arrPoint) then %>
								<%= arrPoint(0,0) %>
								<input type="hidden" name="cardno" value="<%= arrPoint(0,0) %>">
								<% end if %>
							</td>
						</tr>
						<% end if %>
						<%
						if isArray(arrPoint) then
							for intN =0 To UBound(arrPoint,2)
								Response.Write "<input type='hidden' name='point" & arrPoint(0,intN) & "' value='" & arrPoint(1,intN) & "'>"
								Response.Write "<input type='hidden' name='regshopid" & arrPoint(0,intN) & "' value='" & arrPoint(2,intN) & "'>"
							next
						end if
						%>
						<tr>
							<th scope="row">현재 오프라인 마일리지</th>
							<td><strong class="rMar05"><div id="nowpnt"></div></strong></td>
						</tr>
						<tr>
							<th scope="row"><label for="changeMileage">전환할 마일리지</label></th>
							<td><input type="text" id="changeMileage" name=changrmile class="txtInp rMar05" style="width:58px;" /> point</td>
						</tr>
						</tbody>
						</table>
						</form>
						<div class="btnArea ct tPad20">
							<input type="button" class="btn btnS1 btnRed btnW100" value="확인" onClick="MakeMile(document.milefrm);" />
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
