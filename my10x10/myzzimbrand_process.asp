<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2009.04.15 한용민 2008프론트이동/수정/추가
'	Description : 찜브랜드
'#######################################################
%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->

<%
dim backurl, userid , makerid, mode
	makerid = requestCheckVar(request.Form("makerid"),32)
	mode       = requestCheckVar(request.Form("mode"),32)
	userid = getEncLoginUserID
	backurl = request.ServerVariables("HTTP_REFERER")
	If backurl = "" Then
		backurl = "http://www.10x10.co.kr"
	End IF

	if InStr(LCase(backurl),"10x10.co.kr") < 0 then response.redirect backurl
	if makerid="" then response.redirect backurl

'// 로그인 체크 //
if Not(IsUserLoginOK) then
	Call Alert_return("로그인하셔야 사용할 수 있습니다.")
	Response.End
end if

'// 디비 쿼리용으로 변환 한다.
'// 맨마지막 , 제거
makerid = left(makerid,len(makerid)-1)
'// 중간 , 를 ',' 으로 변환
makerid =  replace(makerid,",","','")
'// 젤 앞과 젤뒤에  ' 삽입
makerid = "'"&makerid&"'"

dim sqlStr

if mode="del" then

    sqlStr = "DELETE FROM [db_my10x10].[dbo].[tbl_mybrand] " + VbCrlf
    sqlStr = sqlStr + " WHERE userid='"& userid &"'" + VbCrlf
    sqlStr = sqlStr + " and makerid in ("& makerid &")" + VbCrlf

    'response.write sqlStr&"<br>"
    dbget.execute sqlStr
end if

'==============================================================================
'찜브랜드 쿠키 재작성 - 필요 없음.
'dim zzimbrand_name_list, zzimbrand_makerid_list
'
'zzimbrand_name_list = ""
'zzimbrand_makerid_list = ""
'sqlStr = "select top 10 z.makerid, c.socname "
'sqlStr = sqlStr + " from [db_my10x10].[dbo].tbl_mybrand z, [db_user].[dbo].tbl_user_c c "
'sqlStr = sqlStr + " where 1 = 1 "
'sqlStr = sqlStr + " and z.makerid = c.userid "
'sqlStr = sqlStr + " and z.userid = '" + userid + "' "
'sqlStr = sqlStr + " order by z.regdate desc "
'rsget.Open sqlStr,dbget,1
'if rsget.RecordCount>0 then
'	do until rsget.eof
'		if (zzimbrand_name_list = "") then
'		    zzimbrand_name_list = db2html(rsget("socname"))
'		    zzimbrand_makerid_list = rsget("makerid")
'		else
'		    zzimbrand_name_list = zzimbrand_name_list + "|" + db2html(rsget("socname"))
'		    zzimbrand_makerid_list = zzimbrand_makerid_list + "|" + rsget("makerid")
'		end if
'		rsget.moveNext
'	loop
'end if
'rsget.close
'
'response.cookies("zzimbrand_name_list") = zzimbrand_name_list
'response.cookies("zzimbrand_makerid_list") = zzimbrand_makerid_list

'==============================================================================
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->

<script language="javascript">
	alert('삭제되었습니다');
	parent.location.reload()
</script>
