<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<% Response.contentType = "text/xml; charset=UTF-8" %><?xml version="1.0" encoding="UTF-8" ?>
<result>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/classes/membercls/userloginclass.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
Function LoginLogSaveMobAuto(vUserID,vIsSuccess,vSiteDiv,vDevice,irefip,iggsn)
	Dim vQuery, ilgnGuid
	if (vIsSuccess="Y") then
	    ilgnGuid = iggsn
    end if
	vQuery = "INSERT INTO [db_log].[dbo].[tbl_loginLog_IDX](userid, isSuccess, referIP, siteDiv, chkDevice, lgnGuid) VALUES('" & vUserID & "', '" & vIsSuccess & "', '" & irefip & "', '" & vSiteDiv & "', '" & vDevice & "','"&ilgnGuid&"')"
	dbget.Execute vQuery
End Function

dim ouser
dim userid, userpass
dim isupche
Dim conIp, arrIp, tmpIp
Dim flgDevice, irefip, iggsn
conIp = Request.ServerVariables("REMOTE_ADDR")
arrIp = split(conIp,".")
tmpIp = Num2Str(arrIp(0),3,"0","R") & Num2Str(arrIp(1),3,"0","R") & Num2Str(arrIp(2),3,"0","R") & Num2Str(arrIp(3),3,"0","R")

'// 텐바이텐 서버가 아니면 종료
if Not(tmpIp=>"192168000082" and tmpIp<="192168000091") and Not(tmpIp=>"061252133001" and tmpIp<="061252133127") and Not(tmpIp=>"110093128082" and tmpIp<="110093128091") and Not(tmpIp="192168050002") then
	Response.Write "<error>잘못된 접속입니다.</error>" & vbCrLf
	Response.Write "</result>"
	dbget.Close(): Response.End
end if

on Error Resume Next
userid 		= requestCheckVar(tenDec(request.form("userid")),32)
userpass 	= requestCheckVar(tenDec(request.form("userpass")),32)
flgDevice	= requestCheckVar(request.form("device"),1)
irefip      = requestCheckVar(request.form("refip"),16) ''2017/11/07
iggsn       = requestCheckVar(request.form("iggsn"),40) ''2017/11/07

if userid<>"" and userpass<>"" then
	set ouser = new CTenUser
	ouser.FRectUserID = userid
	ouser.FRectPassWord = userpass
	ouser.LoginProc
	
	if (ouser.IsPassOk) then
		Response.Write "<username><![CDATA[" & ouser.FOneUser.FUserName & "]]></username>" & vbCrLf
		'Response.Write "<useremail><![CDATA[" & ouser.FOneUser.FUserEmail & "]]></useremail>" & vbCrLf
		Response.Write "<userdiv>" & ouser.FOneUser.FUserDiv & "</userdiv>" & vbCrLf
		Response.Write "<userlevel>" & ouser.FOneUser.FUserLevel & "</userlevel>" & vbCrLf
	    Response.Write "<realchk>" & ouser.FOneUser.FRealNameCheck & "</realchk>" & vbCrLf
	    Response.Write "<gender>" & ouser.FOneUser.FSexFlag & "</gender>" & vbCrLf

	    Response.Write "<coupon>" & ouser.FOneUser.FCouponCnt & "</coupon>" & vbCrLf
	    Response.Write "<mileage>" & ouser.FOneUser.FCurrentMileage & "</mileage>" & vbCrLf
	    Response.Write "<cartCnt>" & ouser.FOneUser.FBaguniCount & "</cartCnt>" & vbCrLf
	    Response.Write "<usericon><![CDATA[" & ouser.FOneUser.FUserIcon & "]]></usericon>" & vbCrLf
	    Response.Write "<usericonNo><![CDATA[" & ouser.FOneUser.FUserIconNo & "]]></usericonNo>" & vbCrLf

	    Response.Write "<currtencash>" & ouser.FOneUser.FCurrentTenCash & "</currtencash>" & vbCrLf
	    Response.Write "<currtengiftcard>" & ouser.FOneUser.FCurrentTenGiftCard & "</currtengiftcard>" & vbCrLf
	    Response.Write "<ordCnt>" & ouser.FOneUser.ForderCount & "</ordCnt>" & vbCrLf
	    'Response.Write "<ConfirmUser>" & ouser.FConfirmUser & "</ConfirmUser>" & vbCrLf
	
		Response.Write "<shix>" & HashTenID(ouser.FOneUser.FUserID) & "</shix>"  ''201212 추가


		''2017/11/07 비회원 식별관련.
        dim isqlStr : isqlStr = "db_user.[dbo].[usp_TEN_User_LastGUID_ADD] '"&userid&"','"&iggsn&"'"
        dbget.execute isqlStr
        
		'####### 로그인 로그 저장
    	Call LoginLogSaveMobAuto(userid,"Y","ten_m_auto",flgDevice,irefip,iggsn)
    else
    	Call LoginLogSaveMobAuto(userid,"N","ten_m_auto",flgDevice,irefip,iggsn)
	end if
end if

if Err<>0 then
	Response.Write "<error>" & Err.Description & "</error>"
end if
%>
</result>
<!-- #include virtual="/lib/db/dbclose.asp" -->