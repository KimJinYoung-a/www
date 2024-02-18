<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>

<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/offshop/lib/leftmenu/point_loginchk.asp" -->

<%
dim userid
dim mode
dim oldpass,newpass1
dim username,zipcode
dim addr1,addr2,userphone
dim usercell ,useremail
dim emailok,userbirthday
dim email_way2way, email_10x10
dim userpw_q, userpw_a
dim issolar, vMemberGubun, vUserSeq, point1010EmailYN, point1010SMSYN

'' 2007-12-27 추가
dim smsok, smsok_fingers, allow_other
Const COtherSiteFlag = "academy"

userid      = requestCheckVar(GetLoginUserID,32)

vUserSeq	 = requestCheckVar(Request("userseq"),10)
vMemberGubun = requestCheckVar(Request("membergubun"),1)

oldpass     = requestCheckVar(request.Form("oldpass"),32)
newpass1    = requestCheckVar(request.Form("newpass1"),32)

mode        = requestCheckVar(request.Form("mode"),16)
username    = requestCheckVar(html2db(request.Form("username")),32)
zipcode     = requestCheckVar(request.Form("txZip1"),3) + "-" + requestCheckVar(request.Form("txZip2"),3)
addr1       = requestCheckVar(html2db(request.Form("txAddr1")),128)
addr2       = requestCheckVar(html2db(request.Form("txAddr2")),128)

userphone   = requestCheckVar(request.Form("userphone1"),4) + "-" + requestCheckVar(request.Form("userphone2"),4) + "-" + requestCheckVar(request.Form("userphone3"),4)
usercell    = requestCheckVar(request.Form("usercell1"),4)+ "-" + requestCheckVar(request.Form("usercell2"),4) + "-" + requestCheckVar(request.Form("usercell3"),4)
useremail   = requestCheckVar(html2db(request.Form("usermail")),128)

issolar         = requestCheckVar(request.Form("issolar"),9)

if (mode="infomodi") then
    userbirthday    = requestCheckVar(CStr(DateSerial(request.form("userbirthday1"),request.form("userbirthday2"),request.form("userbirthday3"))),10)
end if

email_10x10     = requestCheckVar(request.Form("email_10x10"),9)
email_way2way   = requestCheckVar(request.Form("email_way2way"),9)

smsok           = requestCheckVar(request.Form("smsok"),9)
smsok_fingers   = requestCheckVar(request.Form("smsok_fingers"),9)
allow_other     = requestCheckVar(request.Form("allow_other"),9)

point1010EmailYN	= requestCheckVar(request.Form("emailyn"),1)
point1010SMSYN		= requestCheckVar(request.Form("psmsyn"),1)

if (email_10x10="Y") or (email_way2way="Y") then
    emailok = "Y"
else
    emailok = "N"
end if

if (smsok<>"Y") then smsok="N"
if (smsok_fingers<>"Y") then smsok_fingers="N"


if (allow_other="N") then
    if (COtherSiteFlag="10x10") then
        email_10x10 = "N"
        smsok       = "N"
    elseif (COtherSiteFlag="academy") then
        email_way2way = "N"
        smsok_fingers = "N"
    end if
end if


''if email_way2way="" then email_way2way="N"
''if email_10x10="" then email_10x10="N"
''
'' ** emailok N 일경우 email_10x10, email_way2way 둘다 N (전체 사이트 N로)
''    Y일 경우 email_way2way 특정 사이트만 Y
''    emailok Flag는 차후 통합 E-mail 발송시 사용 .. 

''비밀번호 질문답변 사용안함
''userpw_q = request.Form("userpw_q")
''userpw_a = html2db(request.Form("userpw_a"))



dim sqlStr, opass, passspecial
dim Enc_userpass, Enc_userpass64, Enc_Old_userpass, Enc_Old_userpass64, Enc_New_userpass, Enc_New_userpass64
Enc_Old_userpass =  MD5(CStr(oldpass))
Enc_Old_userpass64 =  SHA256(MD5(CStr(oldpass)))

if (mode="passmodi") then
	sqlStr = "select top 1 userpass, Enc_userpass, Enc_userpass64 from [db_user].[dbo].tbl_logindata" + VbCrlf
	sqlStr = sqlStr + " where userid='" + userid + "'" + VbCrlf
	rsget.Open sqlStr, dbget, 1

	if Not rsget.Eof then
		opass = rsget("userpass")
		Enc_userpass = rsget("Enc_userpass")
		Enc_userpass64 = rsget("Enc_userpass64")
	end if
	rsget.Close
    
    ''if (opass<>oldpass)  then                  '' 비암호화
	if (Enc_userpass<>Enc_Old_userpass)  then    '' 암호화 사용(MD5)
	''if (Enc_userpass64<>Enc_Old_userpass64)  then    '' 암호화 사용(SHA256)
		response.write "<script>alert('기존 비밀번호가 일치하지 않습니다.');</script>"
		response.write "<script>history.back();</script>"
		response.end
	end if
    
    '' 비밀번호 특수 문자 체크
'	if (IsSpecialCharExist(newpass1)) then
'		response.write "<script>alert('비밀번호에는 특수문자를 사용할수 없습니다.(알파벳과 숫자 사용가능)')</script>"
'		response.write "<script>history.back()</script>"
'		response.end
'	end if

    '' 차후 비밀번호 Encript시 사용 하기 위함
	Enc_New_userpass =  MD5(CStr(newpass1))
	Enc_New_userpass64 =  SHA256(MD5(CStr(newpass1)))

	sqlStr = "update [db_user].[dbo].tbl_logindata" + VbCrlf
	sqlStr = sqlStr + " set userpass=''" + VbCrlf
	sqlStr = sqlStr + " , Enc_userpass='" + Enc_New_userpass + "'" + VbCrlf
	sqlStr = sqlStr + " , Enc_userpass64='" + Enc_New_userpass64 + "'" + VbCrlf
	sqlStr = sqlStr + " where userid='" + userid + "'" + VbCrlf
	
	dbget.Execute sqlStr

elseif (mode="infomodi") then
	If vMemberGubun = "1" Then
			sqlStr = "select top 1 userpass, Enc_userpass, Enc_userpass64 from [db_user].[dbo].tbl_logindata" + VbCrlf
			sqlStr = sqlStr + " where userid='" + userid + "'" + VbCrlf
			rsget.Open sqlStr, dbget, 1
		
			if Not rsget.Eof then
				opass = rsget("userpass")
				Enc_userpass = rsget("Enc_userpass")
				Enc_userpass64 = rsget("Enc_userpass64")
			end if
			rsget.Close
		    
		    ''if (opass<>oldpass) then                  '' 비암호화
			if (Enc_userpass<>Enc_Old_userpass)  then   '' 암호화 사용(MD5)
			''if (Enc_userpass64<>Enc_Old_userpass64)  then   '' 암호화 사용(SHA256)
				response.write "<script>alert('기존 비밀번호가 일치하지 않습니다.');</script>"
				response.write "<script>history.back();</script>"
				response.end
			end if
		    
		    
		    ''다른 사이트 이용중지설정시 -모두 사용안함으로 설정할 수 없음.
		    dim IsAllSiteNotUsing
		    IsAllSiteNotUsing = false
		    if (allow_other="N") then
		        sqlStr = "select count(userid) as cnt from db_user.dbo.tbl_user_allow_site" & VbCrlf
		    	sqlStr = sqlStr & " where userid='" & userid & "'" & VbCrlf
		    	sqlStr = sqlStr & " and sitegubun<>'" & COtherSiteFlag & "'"
		    	sqlStr = sqlStr & " and siteusing='N'"
		    	
		    	rsget.Open sqlStr, dbget, 1
		    	    IsAllSiteNotUsing = rsget("cnt")>=1
		    	rsget.close
		    	
		    	if (IsAllSiteNotUsing) then
		    	    response.write "<script>alert('모든 서비스를 사용 안함으로 설정 하실 수 없습니다.');</script>"
		    	    response.write "<script>history.back();</script>"
		    	    response.end
		    	end if
		    end if
		    
		    
			sqlStr = "update [db_user].[dbo].tbl_user_n" + VbCrlf
			sqlStr = sqlStr + " set " + VbCrlf
			sqlStr = sqlStr + " zipcode='" + zipcode + "'"  + VbCrlf
			sqlStr = sqlStr + " ,useraddr='" + addr2 + "'"  + VbCrlf
			sqlStr = sqlStr + " ,userphone='" + userphone + "'"  + VbCrlf
			sqlStr = sqlStr + " ,usercell='" + usercell + "'"  + VbCrlf
			sqlStr = sqlStr + " ,usermail='" + useremail + "'"  + VbCrlf
			sqlStr = sqlStr + " ,emailok='" + emailok + "'"  + VbCrlf
			sqlStr = sqlStr + " ,email_10x10='" + email_10x10 + "'"  + VbCrlf
			sqlStr = sqlStr + " ,email_way2way='" + email_way2way + "'"  + VbCrlf
			sqlStr = sqlStr + " ,smsok='" + smsok + "'"  + VbCrlf
			sqlStr = sqlStr + " ,smsok_fingers='" + smsok_fingers + "'"  + VbCrlf
			sqlStr = sqlStr + " where userid='" + userid + "'" + VbCrlf
		
			dbget.Execute sqlStr
			
			
			'' 사이트 이용 관리 (2007-12-27): 10x10
			dim SiteConfirmExistes
			
			sqlStr = "select userid, sitegubun, siteusing from db_user.dbo.tbl_user_allow_site" & VbCrlf
			sqlStr = sqlStr & " where userid='" & userid & "'" & VbCrlf
			sqlStr = sqlStr & " and sitegubun='" & COtherSiteFlag & "'"
			rsget.Open sqlStr, dbget, 1
		
			if Not rsget.Eof then
				SiteConfirmExistes = true
			end if
			rsget.Close
			
			if (SiteConfirmExistes) then
			    sqlStr = "update db_user.dbo.tbl_user_allow_site" & VbCrlf
			    sqlStr = sqlStr & " set siteusing='" & allow_other & "'" & VbCrlf
			    if (allow_other="Y") then
			        sqlStr = sqlStr & " ,allowdate=IsNULL(allowdate,getdate())"
			    else
			        sqlStr = sqlStr & " ,disallowdate=IsNULL(disallowdate,getdate())"
			    end if
			    sqlStr = sqlStr & " where userid='" & userid & "'" & VbCrlf
			    sqlStr = sqlStr & " and sitegubun='" & COtherSiteFlag & "'"
			    
			    dbget.Execute sqlStr
			else
			    if (allow_other="Y") then
		    	    sqlStr = "insert into db_user.dbo.tbl_user_allow_site" & VbCrlf
		    	    sqlStr = sqlStr + " (userid, sitegubun, siteusing, allowdate)"
		            sqlStr = sqlStr + " values("
		            sqlStr = sqlStr + " '" & userid & "'"
		            sqlStr = sqlStr + " ,'" & COtherSiteFlag & "'"
		            sqlStr = sqlStr + " ,'Y'"
		            sqlStr = sqlStr + " ,getdate()"
		            sqlStr = sqlStr + " )"
		            
		            dbget.Execute sqlStr
		        else
		            sqlStr = "insert into db_user.dbo.tbl_user_allow_site" & VbCrlf
		    	    sqlStr = sqlStr + " (userid, sitegubun, siteusing, disallowdate)"
		            sqlStr = sqlStr + " values("
		            sqlStr = sqlStr + " '" & userid & "'"
		            sqlStr = sqlStr + " ,'" & COtherSiteFlag & "'"
		            sqlStr = sqlStr + " ,'N'"
		            sqlStr = sqlStr + " ,getdate()"
		            sqlStr = sqlStr + " )"
		            
		            dbget.Execute sqlStr
		        end if
			end if
	End If
	
	sqlStr = " UPDATE [db_shop].[dbo].tbl_total_shop_user SET " & _
			 "			Email = '" & useremail & "', " & _
			 "			EmailYN = '" & point1010EmailYN & "', " & _
			 "			SMSYN = '" & point1010SMSYN & "', " & _
			 "			TelNo = '" & userphone & "', " & _
			 "			HpNo = '" & usercell & "', " & _
			 "			ZipCode = '" & Replace(zipcode,"-","") & "', " & _
			 "			Address = '" & addr1 & "', " & _
			 "			AddressDetail = '" & addr2 & "' " & _
			 "	WHERE UserSeq = '" & vUserSeq & "' "
	dbget.Execute sqlStr

end if


function IsSpecialCharExist(s)
        dim buf, result, index

        index = 1
        do until index > len(s)
                buf = mid(s, index, cint(1))
                if (lcase(buf) >= "a" and lcase(buf) <= "z") then
                        result = false
                elseif (buf >= "0" and buf <= "9") then
                        result = false
                else
                        IsSpecialCharExist = true
                        exit function
                end if
                index = index + 1
        loop

        IsSpecialCharExist = false
end function

%>
<script language='javascript'>
    alert('수정 되었습니다.');
    location.replace('<%= wwwUrl %>/offshop/point/user_info.asp?membergubun=<%=vMemberGubun%>');
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->