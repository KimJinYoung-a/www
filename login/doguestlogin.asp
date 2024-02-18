<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>

<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<% const midx = 0 %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%

dim backpath
dim strGetData, strPostData
dim orderserial, buyemail
dim dbbuyname, dbbuyemail
dim IsPassOK

IsPassOK = false

backpath 	= ReplaceRequestSpecialChar(request("backpath"))
strGetData  = ReplaceRequestSpecialChar(request("strGD"))
strPostData = ReplaceRequestSpecialChar(request("strPD"))
if strGetData <> "" then backpath = backpath&"?"&strGetData
	
orderserial = requestCheckVar(request("orderserial"),11)
buyemail = trim(requestCheckVar(request("buyemail"),128))

dim sqlStr, orderUSerID, sitename
sqlStr = " select top 1 idx, orderserial, buyname, buyphone, buyemail, userid as orderUSerID,sitename "
sqlStr = sqlStr + " from [db_order].[dbo].tbl_order_master "
sqlStr = sqlStr + " where (orderserial = '" + orderserial + "') and userDisplayYn='Y'"
rsget.Open sqlStr, dbget, 1

if not rsget.EOF then
	IsPassOK = true
    dbbuyname = trim(db2html(rsget("buyname")))
    dbbuyemail = trim(db2html(rsget("buyemail")))
    orderUSerID = db2html(rsget("orderUSerID"))             ''' 회원로그인 하여아함.. 2011 추가
    sitename   = rsget("sitename")                          ''' 제휴몰 주문건은 안됨.
end if
rsget.close


if (not IsPassOK) then
    response.write "<script>alert('주문정보가 없습니다. 입력내용을 확인하세요.');history.back();</script>"
    response.end
end if

''''2011 추가 by eastone-------------------------------------------------------------------------------
if (Left(request.ServerVariables("REMOTE_ADDR"),10)<>"61.252.133") then
    if (orderUSerID<>"") or (sitename<>"10x10") then
        response.write "<script>alert('주문정보가 올바르지 않거나. 비회원 주문건이 아닙니다.');history.back();</script>"
        response.end
    end if
end if


if ((IsPassOK) and (buyemail = dbbuyemail) ) then
        session("userid") = ""
        session("userdiv") = ""
        session("userlevel") = ""
        session("userorderserial") = orderserial
        session("username") = dbbuyname
        session("useremail") = dbbuyemail
else
        response.write "<script>alert('주문정보가 없습니다. 입력내용을 확인하세요.');history.back();</script>"
        response.end
end if


dim referer
referer = request.ServerVariables("HTTP_REFERER")

if (backpath = "") then    
    response.redirect referer
    dbget.Close:  response.end
else
%>	
	<form method="post" name="frmLogin" action="<%=SSLUrl & backpath%>" >
	<%	Call sbPostDataToHtml(strPostData) %>
	</form>
	<script language="javascript">
		document.frmLogin.submit();
	</script>
<% dbget.Close: 	response.end
end if


%>
<!-- #include virtual="/lib/db/dbclose.asp" -->