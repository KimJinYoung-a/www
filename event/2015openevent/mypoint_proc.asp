<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim totmypoint , sqlStr
Dim userid : userid = GetLoginUserID()

'// 로그인 여부 확인 //
if userid="" or isNull(userid) then
	Response.Write	"<script>alert('마일리지를 확인 하려면 로그인이 필요합니다.');</script>"
	Response.Write	"<script>top.location.href='/login/login.asp?backpath=" & RefURLQ() & "';</script>"
	dbget.close()	:	response.End
end If

'// 토탈 마일리지 //
sqlStr = " select  " &VBCRLF
sqlStr = sqlStr & " isnull(sum(case " &VBCRLF
sqlStr = sqlStr & "	when g.chg_gift_code = '14769' then 2000 " &VBCRLF
sqlStr = sqlStr & "	when g.chg_gift_code = '14771' then 5000 " &VBCRLF
sqlStr = sqlStr & "	when g.chg_gift_code = '14773' then 10000 " &VBCRLF
sqlStr = sqlStr & "	end),0) as chg_gift_code " &VBCRLF
sqlStr = sqlStr & " from [db_order].[dbo].[tbl_order_master] as m " &VBCRLF
sqlStr = sqlStr & " inner join db_order.dbo.tbl_order_gift as g " &VBCRLF
sqlStr = sqlStr & " on m.orderserial = g.orderserial " &VBCRLF
sqlStr = sqlStr & " where m.userid <> '' and m.regdate between '2015-04-13 00:00:00' and '2015-04-24 23:59:59' " &VBCRLF
sqlStr = sqlStr & " AND m.ipkumdiv>3  AND m.jumundiv<>9 AND m.cancelyn='N' and m.sitename = '10x10' and m.userid <> '' " &VBCRLF
sqlStr = sqlStr & " and (m.subtotalprice+miletotalprice) >= 50000 " &VBCRLF
sqlStr = sqlStr & " and chg_gift_code in ('14769','14771','14773') " &VBCRLF
sqlStr = sqlStr & " and m.userid = '"& userid &"' "
rsget.Open sqlStr,dbget,1
	totmypoint = rsget(0)
rsget.Close

response.write "<strong id='totmypoint' value='"& FormatNumber(totmypoint,0) &"'></strong>"
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->