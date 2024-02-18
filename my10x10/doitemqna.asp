<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<%

dim boardqna
dim boarditem
dim id, itemid, mode, userid,username, title, qadiv, emailok, usermail, contents
dim makerid, cdl, brandname, userlevel,masterid, smsok, userhp
dim dispCate, secretyn

''질문구분 추가 - 카메라몰 :서동석
dim qna_comm_cd, groupcd

id = requestCheckVar(request("id"),9)
itemid = requestCheckVar(request("itemid"),9)
mode = requestCheckVar(request("mode"),9)
userid = getEncLoginUserID()
username = GetLoginUserName()
''title = requestCheckVar(request("title"),128)  ''사용안함
qadiv = requestCheckVar(request("qadiv"),9)
emailok = requestCheckVar(request("emailok"),9)
usermail = requestCheckVar(request("usermail"),128)
smsok = requestCheckVar(request("smsok"),1)
userhp = requestCheckVar(request("userhp1"),4) & "-" & requestCheckVar(request("userhp2"),4) & "-" & requestCheckVar(request("userhp3"),4)
contents = requestCheckVar(request("contents"),1024)
qna_comm_cd = requestCheckVar(request("qna_comm_cd"),4)
groupcd = requestCheckVar(request("groupcd"),9)
dispCate = requestCheckVar(request("disp"),18)

'2017-04-25 유태욱 추가(비밀 qna)
secretyn = requestCheckVar(request("secretyn"),1)

if (userhp = "--") then
	userhp = ""
end if


if checkNotValidHTML(contents) then
	response.write "<script>alert('not valid html');</script>"
	response.write "<script>history.back();</script>"
	dbget.Close
	response.end
end if

makerid = requestCheckVar(request("makerid"),32)
cdl = requestCheckVar(request("cdl"),3)
brandname = requestCheckVar(html2db(request("brandname")),64)
userlevel = CStr(GetLoginUserLevel())
masterid = requestCheckVar(request("masterid"),9)

dim sql
if (cdl="") or (makerid="") or (brandname="") then
	if (itemid<>"") then
		sql = "select top 1 makerid, cate_large, brandname from [db_item].[dbo].tbl_item" + VbCrlf
		sql = sql + " where itemid=" + CStr(itemid)

		rsget.Open sql, dbget, 1
		if Not rsget.Eof then
			makerid = rsget("makerid")
			cdl = rsget("cate_large")
			brandname = rsget("brandname")
		end if
		rsget.Close
	end if
end if

Select Case mode
	Case "write"
		sql = " insert into [db_cs].[dbo].tbl_my_item_qna"
		sql = sql + " (userid, username, cdl, dispCate, orderserial, "
		sql = sql + " qadiv, usermail, emailok, secretyn, userhp, smsok, contents, "
		sql = sql + " regdate, replyuser, replycontents, "
		sql = sql + " itemid, isusing, makerid, brandname,"
		if (qna_comm_cd<>"") then
			sql = sql + " qna_comm_cd,"
		end if
		sql = sql + "  userlevel) " + VbCRLF
		sql = sql + " values('" + userid + "'" + VbCRLF
		sql = sql + " ,'" + html2db(username) + "'" + VbCRLF
		sql = sql + " ,'" + cdl + "'" + VbCRLF
		sql = sql + " ,'" + dispCate + "'" + VbCRLF
		sql = sql + ", ''" + VbCRLF
		sql = sql + ", '" + Cstr(qadiv) + "'" + VbCRLF
		sql = sql + ", '" + html2db(usermail) + "'" + VbCRLF
		sql = sql + ", '" + emailok + "'" + VbCRLF
		sql = sql + ", '" + secretyn + "'" + VbCRLF
		sql = sql + ", '" + html2db(userhp) + "'" + VbCRLF
		sql = sql + ", '" + smsok + "'" + VbCRLF
		sql = sql + ", '" + html2db(contents) + "'" + VbCRLF
		sql = sql + ", getdate()" + VbCRLF
		sql = sql + ", ''" + VbCRLF
		sql = sql + ", ''" + VbCRLF
		sql = sql + ", " + Cstr(itemid) + " " + VbCRLF
		sql = sql + ",'Y'" + VbCRLF
		sql = sql + ", '" + makerid + "'" + VbCRLF
		sql = sql + ",'" + html2db(brandname) + "'" + VbCRLF
		if (qna_comm_cd<>"") then
			sql = sql + " ,'" + qna_comm_cd + "'" + VbCRLF
		end if
		sql = sql + ",'" + userlevel + "') " + VbCRLF

		sql = sql + " UPDATE db_item.dbo.tbl_item_contents set QnaCnt = QnaCnt +1 Where Itemid=" & Cstr(itemid)

		dbget.Execute sql
	Case "modi"
		sql = " update [db_cs].[dbo].tbl_my_item_qna Set "
		sql = sql + " usermail='" + html2db(usermail) + "'"
		sql = sql + " ,emailok='" + emailok + "'"
		sql = sql + " ,secretyn='" + secretyn + "'"
		sql = sql + " ,userhp='" + html2db(userhp) + "'"
		sql = sql + " ,smsok='" + smsok + "'"
		sql = sql + " ,contents='" + html2db(contents) + "'"
		sql = sql + " where userid='" + userid + "'" + VbCRLF
		sql = sql + " and id=" + id + "" + VbCRLF

		dbget.Execute sql
	Case "del"
		sql = " update [db_cs].[dbo].tbl_my_item_qna" + VbCRLF
		sql = sql + " set isusing='N'" + VbCRLF
		sql = sql + " where userid='" + userid + "'" + VbCRLF
		sql = sql + " and id=" + id + "" + VbCRLF

		sql = sql + " UPDATE db_item.dbo.tbl_item_contents set QnaCnt = QnaCnt -1 Where Itemid=" & Cstr(itemid)

		dbget.Execute sql
end Select

dim referer
referer = request.ServerVariables("HTTP_REFERER")

'if (mode = "write") then
'	response.write "<script>alert('문의가 등록되었습니다..');</script>"
'	response.write "<script>location.replace('" + Cstr(referer) + "');</script>"
'elseif  (mode = "del") then
'	response.write "<script>alert('삭제 되었습니다.');</script>"
'	response.write "<script>location.replace('" + Cstr(referer) + "');</script>"
'end if

if Not(referer="" or isNull(referer)) then
	if (InStr(referer,"category_prd.asp")>0) then referer = referer & "#detail04"
	response.redirect referer
else
	response.redirect "/shopping/category_prd.asp?itemid=" & Cstr(itemid)
end if
%>


<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/inc/incFooter.asp" -->