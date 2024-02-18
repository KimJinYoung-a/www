<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 60930 셋콤달콤
' History : 2015-04-13 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim set1,set2,set3,set4,set5
dim eCode, subscriptcount, userid, evtTotalCnt, sqlStr, cnt, totalcnt, appbannerclick
Dim returndate  : returndate = 	request("returndate")

	If returndate = "" Then returndate = Date()

	userid=getloginuserid()

IF application("Svr_Info") = "Dev" THEN
	eCode 		= "60743"
Else
	eCode 		= "60930"
End If

If userid="winnie" Or userid="gawisonten10" Or userid ="greenteenz" Or userid = "edojun" Or userid = "baboytw" Or userid = "tozzinet" Or userid = "motions" Then

Else
	response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
	response.End

End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.table {width:900px; margin:0 auto; font-family:'malgun gothic'; border-collapse:collapse;}
.table th {padding:12px 0; font-size:13px; font-weight:bold;  color:#fff; background:#444;}
.table td {padding:12px 3px; font-size:12px; border:1px solid #ddd; border-bottom:2px solid #ddd;}
.table td.lt {text-align:left; padding:12px 10px;}
.tBtn {display:inline-block; border:1px solid #2b90b6; background:#03a0db; padding:0 10px 2px; line-height:26px; height:26px; font-weight:bold; border-radius:5px; color:#fff !important;}
.tBtn:hover {text-decoration:none;}
.table td input {border:1px solid #ddd; height:30px; padding:0 3px; font-size:14px; color:#ec0d02; text-align:right;}
</style>
</head>
<body>
<p>&nbsp;</p>

<table style="margin:0 auto;text-align:center;">
	<tr>
		<td><strong>4월 13일<br></strong></td>
	</tr>
</table>
<table class="table" style="width:90%;">
	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>총 응모건수</strong></th>
		<th><strong>지니당첨자 (최대2996)</strong></th>
		<th><strong>커피 당첨자 (최대486)</strong></th>
		<th><strong>아이리버 당첨자 (최대13)</strong></th>
		<th><strong>닥터드레 당첨자 (최대1)</strong></th>
		<th><strong>앱전면배너클릭</strong></th>
	</tr>
		<tr bgcolor="#FFFFFF" align="center">
			<td bgcolor="">10936</td>
			<td bgcolor="">15228</td>
			<td bgcolor="">2500</td>
			<td bgcolor="">486</td>
			<td bgcolor="">13</td>
			<td bgcolor="">1</td>
			<td bgcolor="">8056</td>
		</tr>
</table>
<br>
<table style="margin:0 auto;text-align:center;">
	<tr>
		<td><strong>4월 14일<br></strong></td>
	</tr>
</table>
<table class="table" style="width:90%;">
	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>총 응모건수</strong></th>
		<th><strong>지니당첨자 (최대2500)</strong></th>
		<th><strong>커피 당첨자 (최대486)</strong></th>
		<th><strong>아이리버 당첨자 (최대13)</strong></th>
		<th><strong>닥터드레 당첨자 (최대1)</strong></th>
		<th><strong>앱전면배너클릭</strong></th>
	</tr>
		<tr bgcolor="#FFFFFF" align="center">
			<td bgcolor="">18796</td>
			<td bgcolor="">24912</td>
			<td bgcolor="">2500</td>
			<td bgcolor="">486</td>
			<td bgcolor="">13</td>
			<td bgcolor="">1</td>
			<td bgcolor="">11209</td>
		</tr>
</table>
<br>
<table style="margin:0 auto;text-align:center;">
	<tr>
		<td><strong>4월 15일<br></strong></td>
	</tr>
</table>
<table class="table" style="width:90%;">
	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>총 응모건수</strong></th>
		<th><strong>지니당첨자 (최대2004)</strong></th>
		<th><strong>커피 당첨자 (최대486)</strong></th>
		<th><strong>아이리버 당첨자 (최대13)</strong></th>
		<th><strong>닥터드레 당첨자 (최대1)</strong></th>
		<th><strong>앱전면배너클릭</strong></th>
	</tr>
		<tr bgcolor="#FFFFFF" align="center">
			<td bgcolor="">9587</td>
			<td bgcolor="">13950</td>
			<td bgcolor="">2004</td>
			<td bgcolor="">486</td>
			<td bgcolor="">13</td>
			<td bgcolor="">1</td>
			<td bgcolor="">11014</td>
		</tr>
</table>
<br>
<table style="margin:0 auto;text-align:center;">
	<tr>
		<td><strong>4월 16일 셋콤달콤<br></strong></td>
	</tr>
</table>
<table class="table" style="width:90%;">
	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>총 응모건수</strong></th>
		<th><strong>지니당첨자 (최대2996)</strong></th>
		<th><strong>커피 당첨자 (최대486)</strong></th>
		<th><strong>아이리버 당첨자 (최대13)</strong></th>
		<th><strong>닥터드레 당첨자 (최대1)</strong></th>
		<th><strong>앱전면배너클릭수</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">9404</td>
		<td bgcolor="">13946</td>
		<td bgcolor="">2996</td>
		<td bgcolor="">486</td>
		<td bgcolor="">13</td>
		<td bgcolor="">1</td>
		<td bgcolor="">10768</td>
	</tr>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->