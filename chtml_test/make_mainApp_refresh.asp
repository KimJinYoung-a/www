<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'#######################################################
'	History	:  2009.04.17 한용민 2008프론트에서 이동
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
function RePlaceArrDate(appName,replaceData,replaceIDx)
    dim appDataArr

    appDataArr = Application(appName)

    if IsArray(appDataArr) then
        if (UBound(appDataArr)>=replaceIDx) then
            appDataArr(replaceIDx) = replaceData
            Application(appName) = appDataArr
        end if

    end if
end function


'// 유입경로 확인
dim refip
refip = request.ServerVariables("HTTP_REFERER")

if (InStr(refip,"10x10.co.kr")<1) then
	response.write "not valid Referer"
   response.end
end if

dim oKeyArr, i, cnt
dim poscode, allrefresh, idx
dim HeaderDataExsists, IdxDataExsists
dim appData, sqlStr

''=================================================
'    oKeyArr = Application("Key_header_Contents")
'    cnt = UBound(oKeyArr)+1
'    for i=0 to cnt-1
'        response.write oKeyArr(i) & "<br>"
'    next
'
'    oKeyArr = Application("Dat_header_Contents")
'    cnt = UBound(oKeyArr)+1
'    for i=0 to cnt-1
'        response.write oKeyArr(i) & "<br>"
'    next
'    response.end
''===================================================

'''poscode = requestCheckVar(Request("poscode"),32)
allrefresh = requestCheckVar(Request("allrefresh"),32)
idx = requestCheckVar(Request("idx"),9)


if (allrefresh="idx") then
    Application("chk_idx_Contents") = -1
elseif (allrefresh="header") then
    Application("chk_header_Contents") = -1
elseif (idx<>"") then
    sqlStr = "select top 1 c.*, p.*"
    sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_main_contents c"
    sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_main_contents_poscode p"
    sqlStr = sqlStr & " 	on c.poscode=p.poscode"
    sqlStr = sqlStr & " where c.idx=" & idx
    rsget.Open SqlStr, dbget, 1

	'// 실시간 적용시에는 어플리케이션 배열에 저장
    if Not rsget.Eof then
        poscode = rsget("poscode")
        appData = fnPasingStaticContents(rsget("linktype"),rsget("fixtype"),rsget("posVarName"),db2Html(rsget("imageUrl")),db2Html(rsget("linkUrl")),rsget("imagewidth"),rsget("imageheight"),db2Html(rsget("posname")))
    end if
    rsget.Close

    if (appData="") then
        response.write "Err - Not Valid Data"
        response.end
    end if
    oKeyArr = Application("Key_header_Contents")
    cnt = UBound(oKeyArr)+1
    for i=0 to cnt-1
        if (poscode=oKeyArr(i)) then
            HeaderDataExsists = true
            Exit For
        end if
    next

    if (HeaderDataExsists) then
        Call RePlaceArrDate("Dat_header_Contents",appData,i)
        ''response.write "OK"
    else
        oKeyArr = Application("Key_idx_Contents")
        cnt = UBound(oKeyArr)+1
        for i=0 to cnt-1
            if (poscode=oKeyArr(i)) then
                IdxDataExsists = true
                Exit For
            end if
        next

        if (IdxDataExsists) then
            Call RePlaceArrDate("Dat_idx_Contents",appData,i)
            ''response.write "OK"
        end if
    end if

    if (Not HeaderDataExsists) and (Not IdxDataExsists) then
        response.write "Err - Not Valid posCode"
        response.end
    end if
end if

%>
OK<br>
<!-- #include virtual="/lib/db/dbclose.asp" -->