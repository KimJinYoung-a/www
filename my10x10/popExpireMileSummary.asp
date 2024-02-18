<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_mileage_logcls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 소멸대상 마일리지"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

dim userid, yyyymmdd
userid = getEncLoginUserID()
yyyymmdd = requestCheckvar(request("yyyymmdd"),10)

if (yyyymmdd="") then
    yyyymmdd=Left(now(),4) & "-12-31"
end if


''현재 마일리지
dim myMileage
set myMileage = new TenPoint
myMileage.FRectUserID = userid
if (userid<>"") then
    myMileage.getTotalMileage
end if


''만료예정 마일리지 년도별 리스트
dim oExpireMile
set oExpireMile = new CMileageLog
oExpireMile.FRectUserid = userid
''''해당Expire 내역만 보여줄 경우
''oExpireMile.FRectExpireDate = yyyymmdd

if (userid<>"") then
    oExpireMile.getNextExpireMileageYearList
end if


''만료예정  마일리지 합계
dim oExpireMileTotal
set oExpireMileTotal = new CMileageLog
oExpireMileTotal.FRectUserid = userid
oExpireMileTotal.FRectExpireDate = yyyymmdd
if (userid<>"") then
    oExpireMileTotal.getNextExpireMileageSum
end if

dim i
dim Tot_GainMileage, Tot_YearMaySpendMileage, Tot_YearMayRemainMileage, Tot_realExpiredMileage

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_disappear_mileage.gif" alt="소멸대상 마일리지" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<ul class="list">
						<li>마일리지는 부여된 해로부터 5년 이내에 사용하셔야 합니다.</li>
						<li>마일리지는 부여된 순서로 사용되며 해당 기간 내에 사용하지 않을 경우, 잔여 마일리지는 1년 단위로 매해 12월 31일에 자동 소멸됩니다. 예) 2008년 적립 마일리지 4,500 / 사용 마일리지 4,000/ 잔여 마일리지 500인 경우<br />
						500포인트는 2013년 12월 31일에 자동 소멸됩니다.</li>
					</ul>
					<table class="baseTable tMar15">
					<caption>소멸대상 마일리지 목록</caption>
					<colgroup>
						<col width="110" /> <col width="110" /> <col width="110" /> <col width="110" /> <col width="110" /> <col width="*" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col">적립년도</th>
						<th scope="col">적립 마일리지</th>
						<th scope="col">사용</th>
						<th scope="col">소멸</th>
						<th scope="col">잔여</th>
						<th scope="col">소멸예정일</th>
					</tr>
					</thead>
					<tbody>
					<%
					if (oExpireMile.FResultCount>0) then
						for i=0 to oExpireMile.FResultCount-1
							Tot_GainMileage           = Tot_GainMileage + oExpireMile.FItemList(i).getGainMileage
							Tot_YearMaySpendMileage   = Tot_YearMaySpendMileage + oExpireMile.FItemList(i).getYearMaySpendMileage
							Tot_YearMayRemainMileage  = Tot_YearMayRemainMileage + oExpireMile.FItemList(i).getYearMayRemainMileage
							Tot_realExpiredMileage    = Tot_realExpiredMileage + oExpireMile.FItemList(i).FrealExpiredMileage
					%>
					<tr>
						<td><%=oExpireMile.FItemList(i).FRegYear %></td>
						<td><%=FormatNumber(oExpireMile.FItemList(i).getGainMileage,0) %></td>
						<td><%=FormatNumber(oExpireMile.FItemList(i).getYearMaySpendMileage,0) %></td>
						<td><%=FormatNumber(oExpireMile.FItemList(i).FrealExpiredMileage,0) %></td>
						<td><%=FormatNumber(oExpireMile.FItemList(i).getYearMayRemainMileage,0) %></td>
						<td><%= Replace(oExpireMile.FItemList(i).FExpiredate, "-", "/") %></td>
					</tr>
					<%
						next

						'' 현재 마일리지에서 역으로 계산.
						if (oExpireMile.FResultCount>0) and (oExpireMile.FRectExpireDate="") then
					%>
					<tr>
						<td><%= CStr(Year(Now) - 4) + " 년 이후 " %></td>
						<td><%= FormatNumber(myMileage.FTotJumunMileage+ myMileage.FAcademymileage + myMileage.FBonusMileage - Tot_GainMileage ,0) %></td>
						<td><%= FormatNumber(myMileage.FSpendMileage - Tot_YearMaySpendMileage,0) %></td>
						<!--td>0</td-->
						<td><%= FormatNumber(myMileage.FrealExpiredMileage - Tot_realExpiredMileage,0) %></td>
						<td><%= FormatNumber(myMileage.FTotalMileage - Tot_YearMayRemainMileage,0) %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><strong>합계</strong></td>
						<td><%= FormatNumber(myMileage.FTotJumunMileage + myMileage.FAcademymileage + myMileage.FBonusMileage,0) %></td>
						<td><%= FormatNumber(myMileage.FSpendMileage ,0) %></td>
						<td><%= FormatNumber(myMileage.FrealExpiredMileage ,0) %></td>
						<td><%= FormatNumber(myMileage.FTotalMileage,0) %></td>
						<td>&nbsp;</td>
					</tr>
					<%
						end if
					else
					%>
					<tr>
						<td colspan="6">소멸 대상 내역이 없습니다.</td>
					</tr>
					<%
					end if

					%>
					</tbody>
					</table>

					<p class="mileage fs12 tMar20"><%= oExpireMileTotal.FOneItem.getKorExpireDateStr %> 소멸 대상 마일리지 : <strong class="crRed"><%= FormatNumber(oExpireMileTotal.FOneItem.getMayExpireTotal,0) %></strong> Point </p>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%

set myMileage = Nothing
set oExpireMile = Nothing
set oExpireMileTotal = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
