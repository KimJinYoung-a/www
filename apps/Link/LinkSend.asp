<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2019.10.17 한용민 생성
'	Description : 링크추적 페이지 이동 및 로그처리
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/rndSerial.asp"-->
<!-- #include virtual="/lib/chkDevice.asp"-->
<!-- #include virtual="/lib/inc_const.asp"-->
<%
dim key, sqlStr, linkidx, linkurl, strCont
	key = requestCheckVar(trim(request("key")),32)

if key="" or isnull(key)="" then
    Call Alert_move("비정상적인 접속입니다[0].","/")
    dbget.Close : Response.End
end if
linkidx = getNumeric(rdmSerialDec(key))
if linkidx="" or isnull(linkidx)="" then
    Call Alert_move("비정상적인 접속입니다[1].","/")
    dbget.Close : Response.End
end if

sqlStr = "select top 1" + vbcrlf
sqlStr = sqlStr & " linkidx, title, linkurl, isusing, viewcount, regdate, lastupdate, lastadminid" + vbcrlf
sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_Link_SendList with (nolock)" & vbcrlf
sqlStr = sqlStr & " where isusing='Y' and linkidx = " & linkidx & "" & vbcrlf

'response.write sqlStr & "<Br>"
rsget.CursorLocation = adUseClient
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
if  not rsget.EOF  then
    linkurl = rsget("linkurl")
end if
rsget.Close

if linkurl="" or isnull(linkurl)="" then
    Call Alert_move("삭제되었거나 없는 키 값입니다.\n텐바이텐 사이트로 이동합니다.","/")
    dbget.Close : Response.End
end if

'// 클릭수 저장
sqlStr = "Update db_sitemaster.dbo.tbl_Link_SendList" & vbCrLf
sqlStr = sqlStr & " set viewcount=viewcount+1 Where" & vbCrLf
sqlStr = sqlStr & " linkidx=" & linkidx & "" & vbCrLf

'response.write sqlStr & "<Br>"
dbget.Execute sqlStr

'// 로그 저장
sqlStr = "Insert into db_sitemaster.dbo.tbl_Link_SendLog (linkidx,refIP, DevDiv, BrowserInfo) values (" & vbCrLf
sqlStr = sqlStr & "" & linkidx & ",'" & request.ServerVariables("REMOTE_ADDR") & "','" & flgDevice & "','" & html2db(uAgent) & "'" & vbCrLf
sqlStr = sqlStr & ")" & vbCrLf

'response.write sqlStr & "<Br>"
dbget.Execute sqlStr

strCont = linkurl
response.Redirect strCont
dbget.Close : Response.End
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->