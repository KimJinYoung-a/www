<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>

<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>

<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/offshop/lib/leftmenu/point_loginchk.asp" -->

<%
dim userid, userpass, vMemberGubun, jumin1, jumin2, vTmp_CardNo
dim sqlStr, checkedPass, userdiv
dim Enc_userpass, Enc_jumin2

vMemberGubun = requestCheckVar(Request("membergubun"),1)

If vMemberGubun = "1" Then
		userid = GetLoginUserID
		userpass = requestCheckVar(request.Form("userpass"),32)
		
		''개인정보보호를 위해 패스워드로 한번더 Check
		checkedPass = false

		'''if (Session("InfoConfirmFlag")<>userid) then
		    ''패스워드없이 쿠키로만 들어온경우
		    if (userpass="") then
		        response.redirect wwwUrl & "/offshop/point/confirmuser.asp"
		        response.end    
		    end if
		    
		    Enc_userpass = MD5(CStr(userpass))
		    
		    ''비암호화
		    ''sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and userpass='" & userpass & "'"
		    
		    ''암호화 사용(MD5)
		    ''sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and Enc_userpass='" & Enc_userpass & "'"

		    ''암호화 사용(SHA256)
		    sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and Enc_userpass64='" & SHA256(Enc_userpass) & "'"
		    
		    rsget.Open sqlStr, dbget, 1
		    if Not rsget.Eof then
		        checkedPass = true
		        userdiv = rsget("userdiv")
		    end if
		    rsget.close
		    
		    ''패스워드올바르지 않음
		    if (Not checkedPass) then
		        response.write "<script>location.replace('" & wwwUrl & "/offshop/point/confirmuser.asp?errcode=1');</script>"
		        'response.redirect wwwUrl & "/offshop/point/confirmuser.asp?errcode=1"
		        response.end    
		    end if
		    
		    ''업체인경우 수정 불가
		    if (userdiv="02") or (userdiv="03") then
		        response.write "<script>alert('업체 및 기타권한은 이곳에서 수정하실 수 없습니다.');</script>"
		        response.end  
		    end if
		
			'// 세션처리후 회원정보 수정 페이지로 GoGo!
		    Session("InfoConfirmFlag") = userid
		    response.write "<script>location.replace('" & wwwUrl & "/offshop/point/user_info.asp?membergubun="&vMemberGubun&"');</script>"
			
		'''end if
		
ElseIf vMemberGubun = "2" Then
	vTmp_CardNo = requestCheckVar(Request("cardno"),16)
	jumin1 = requestCheckVar(Request("jumin1"),6)
	jumin2 = requestCheckVar(Request("jumin2"),7)
	
		''개인정보보호를 위해 패스워드로 한번더 Check

		checkedPass = false
		
	    ''패스워드없이 쿠키로만 들어온경우
	    if jumin1="" OR jumin2="" then
	        response.redirect wwwUrl & "/offshop/point/confirmuser.asp"
	        response.end    
	    end if
	    
	    Enc_jumin2 = MD5(CStr(jumin2))
	    
	    ''암호화 사용
		sqlStr = " SELECT Count(*) FROM [db_shop].[dbo].tbl_total_shop_card AS A " & _
				 "		INNER JOIN [db_shop].[dbo].tbl_total_shop_user AS B ON A.UserSeq = B.UserSeq " & _
				 "	WHERE A.CardNo = '" & vTmp_CardNo & "' AND B.Jumin1 = '" & jumin1 & "' AND B.Jumin2_Enc = '" & Enc_jumin2 & "' "
	    rsget.Open sqlStr, dbget, 1
	    if rsget(0) > 0 then
	        checkedPass = true
	    end if
	    rsget.close
	    
	    ''패스워드올바르지 않음
	    if (Not checkedPass) then
	        response.write "<script>location.replace('" & wwwUrl & "/offshop/point/confirmuser.asp?errcode=2');</script>"
	        'response.redirect wwwUrl & "/offshop/point/confirmuser.asp?errcode=2"
	        response.end    
	    end if

		'// 세션처리후 회원정보 수정 페이지로 GoGo!
	    Session("InfoConfirmFlag1") = vTmp_CardNo
	    response.write "<script>location.replace('" & wwwUrl & "/offshop/point/user_info.asp?membergubun="&vMemberGubun&"');</script>"
			
End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->