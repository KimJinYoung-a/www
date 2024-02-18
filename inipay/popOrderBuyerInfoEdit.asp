<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->

<%
strPageTitle = "텐바이텐 10X10 : 정보 수정"		'페이지 타이틀 (필수)

dim buyphone
dim buyhp
dim buyemail
dim buyZip, buyAddr1, buyAddr2
dim userid, sqlStr
dim errcode, alerMsg
dim confirmPwd

buyphone = html2db(requestCheckVar(request.Form("buyphone1") + "-" + request.Form("buyphone2") + "-" + request.Form("buyphone3"),16))
buyhp    = html2db(requestCheckVar(request.Form("buyhp1") + "-" + request.Form("buyhp2") + "-" + request.Form("buyhp3"),16))
buyemail = html2db(requestCheckVar(request.Form("buyemail"),100))
'buyZip   = html2db(requestCheckVar(request.Form("buyZip1") + "-" + request.Form("buyZip2"),7))
buyZip   = html2db(requestCheckVar(request.Form("buyZip"),10))
buyAddr1 = html2db(requestCheckVar(request.Form("buyAddr1"),128))
buyAddr2 = html2db(requestCheckVar(request.Form("buyAddr2"),128))
confirmPwd = requestCheckVar(request.Form("confirmPwd"),32)

userid          = getEncLoginUserID

if (userid="") then response.end

dim Enc_userpass, userdiv
dim checkedPass
checkedPass = False

private function userInfoUpdate()
    On Error Resume Next
        dbget.beginTrans

        errcode = "910"

        sqlStr = " update [db_user].[dbo].tbl_user_n" + VbCrlf
        sqlStr = sqlStr + " set userphone='" & buyphone & "'" + VbCrlf
        sqlStr = sqlStr + " ,usercell='" & buyhp & "'" + VbCrlf
        sqlStr = sqlStr + " ,usermail='" & buyemail & "'" + VbCrlf
        sqlStr = sqlStr + " ,zipcode='" & buyZip & "'" + VbCrlf
        sqlStr = sqlStr + " ,zipaddr='" & buyAddr1 & "'" + VbCrlf
        sqlStr = sqlStr + " ,useraddr='" & buyAddr2 & "'" + VbCrlf
        sqlStr = sqlStr + " where userid='" & userid & "'"

        dbget.Execute sqlStr

        Call saveUpdateLog(userid, "I")

        If Err.Number = 0 Then
            dbget.CommitTrans
            alerMsg = "수정되었습니다."
            response.write "<script>alert('"&alerMsg&"');window.close();</script>"
            dbget.close() : response.end
        Else
            dbget.RollBackTrans
            alerMsg = "데이타를 저장하는 도중에 에러가 발생하였습니다.\r\n지속적으로 문제가 발생시에는 고객센타에 연락주시기 바랍니다.(에러코드 : " + CStr(errcode) + ")"
            response.write "<script>alert('"&alerMsg&"');</script>"
        End If
    on error Goto 0
end function

IF GetLoginUserDiv="05" THEN
    if LCase(Session("InfoConfirmFlag")) = LCase(userid) and (confirmPwd="success") then 
        userInfoUpdate()
    END IF 
ELSE
    if (userid<>"") and (confirmPwd<>"") then
        ''비밀 번호 확인.

        Enc_userpass = MD5(CStr(confirmPwd))

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
            response.write "<script>alert('비밀 번호가 올바르지 않습니다.');</script>"
            checkedPass = false
        end if

        ''업체인경우 수정 불가
        if (userdiv="02") or (userdiv="03") then
            response.write "<script>alert('업체 및 기타권한은 이곳에서 수정하실 수 없습니다.');</script>"
            checkedPass = false
        end if

        If (checkedPass) then
            userInfoUpdate()
        end if
    end if
END IF
'// 정보수정 로그 기록(2010.06.25; 허진원)
Sub saveUpdateLog(uid,udiv)
	dim strSql
	strSql = "insert into db_log.dbo.tbl_user_updateLog (userid,updateDiv,siteDiv,refIP) values " &_
			" ('" & uid & "'" &_
			", '" & udiv & "', 'M'" &_
			", '" & Left(request.ServerVariables("REMOTE_ADDR"),32) & "')"
	dbget.Execute strSql
end Sub
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup_ssl.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>
function ChangeMyInfo(frm){
    <% if GetLoginUserDiv <> "05" then %>
    if (frm.confirmPwd.value.length<1){
        alert('비밀 번호를 입력해 주세요.');
        frm.confirmPwd.focus();
        return ;
    }
    <% end if %>

    if (confirm('수정 하시겠습니까?')){
        frm.submit();
    }
}
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="/fiximage/web2013/inipay/tit_personal_info_edit.gif" alt="개인정보 수정" /></h1>
			</div>
			<div class="popContent">
			<form name="frminfo" method="post" onSubmit="ChangeMyInfo(frminfo); return false;">
            <input type="hidden" name="buyphone1" value="<%= request.Form("buyphone1") %>">
            <input type="hidden" name="buyphone2" value="<%= request.Form("buyphone2") %>">
            <input type="hidden" name="buyphone3" value="<%= request.Form("buyphone3") %>">
            <input type="hidden" name="buyhp1" value="<%= request.Form("buyhp1") %>">
            <input type="hidden" name="buyhp2" value="<%= request.Form("buyhp2") %>">
            <input type="hidden" name="buyhp3" value="<%= request.Form("buyhp3") %>">
            <input type="hidden" name="buyemail" value="<%= request.Form("buyemail") %>">
            <input type="hidden" name="buyZip" value="<%= request.Form("buyZip") %>">
            <input type="hidden" name="buyAddr1" value="<%= request.Form("buyAddr1") %>">
            <input type="hidden" name="buyAddr2" value="<%= request.Form("buyAddr2") %>">
				<div class="orderWrap">
					<p class="ct fs15"><strong>아래와 같이 개인정보를 수정합니다.</strong></p>

					<form action="">
					<fieldset>
					<legend>개인정보 수정</legend>
						<table class="baseTable orderForm tMar30">
						<caption>개인정보 수정</caption>
						<colgroup>
							<col width="130" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><strong>휴대전화</strong></th>
							<td><%= buyhp %></td>
						</tr>
						<tr>
							<th scope="row"><strong>전화번호</strong></th>
							<td><%= buyphone %></td>
						</tr>
						<tr>
							<th scope="row"><strong>이메일</strong></th>
							<td><%= buyemail %></td>
						</tr>
						<tr>
							<th scope="row"><strong>주소</strong></th>
							<td>[<%= buyZip %>] <%= buyAddr1 %> <br> <%= buyAddr2 %></td>
						</tr>
                        <% if GetLoginUserDiv <> "05" then %>
						<tr>
							<th scope="row"><strong><label for="pwConfirm">비밀번호 확인</label></strong></th>
							<td><input type="password" name="confirmPwd" class="txtInp" style="width:198px;" /></td>
						</tr>
                        <% else %>
                        <input type="hidden" name="confirmPwd" value="success">
                        <% end if %>
						</tbody>
						</table>

						<div class="btnArea ct tMar35">
							<input type="submit" class="btn btnS1 btnRed btnW100" value="수정" />
							<button type="button" class="btn btnS1 btnGry btnW100" onclick="window.close();">취소</button>
						</div>
					</fieldset>
					</form>
				</div>
				<!-- //content -->
			</form>
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->
