<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'#######################################################
'	History	:  2009.10.08 한용민 생성
'	Description : 비회원 메일링 서비스 신청 팝업
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->

<%
dim username , usermail1 , usermail2 , usermail, chk10x10, chkFingers
	username = requestCheckVar(request("username"),32)		
	usermail1 = requestCheckVar(request("usermail1"),64)
	usermail2 = requestCheckVar(request("usermail2"),64)
	chk10x10 = requestCheckVar(request("chk_10x10"),1)
	chkFingers = requestCheckVar(request("chk_fingers"),1)
	usermail = usermail1&"@"&usermail2

	chk10x10 = ChkIIF(chk10x10<>"","Y","N")
	chkFingers = ChkIIF(chkFingers<>"","Y","N")

	if chk10x10="N" and chkFingers="N" then
		response.write "<script>"
		response.write "alert('메일링을 원하시는 서비스를 적어도 한가지는 선택해주셔야 합니다.');"	
		response.write "</script>"	
		dbget.close() : response.end
	end if

dim sql, chkidx, chkModi, chk1, chk2

	'신청여부 체크
		sql = "select idx, email_10x10 as chk1, email_fingers as chk2 from db_user.dbo.tbl_mailzine_notmember where isusing='Y' and usermail='"&html2db(usermail)&"'"
	
		rsget.open sql,dbget,1

		if not rsget.EOF  then
			'참여내용 있음
			chkidx = rsget("idx")	'신청번호
			chk1 = rsget("chk1")	'텐바이텐 신청여부
			chk2 = rsget("chk2")	'더핑거스 신청여부
			chkModi = true

			'//텐바이텐 추가 신청
			if (chk1="N" and chk10x10="Y") then
				sql = "update db_user.dbo.tbl_mailzine_notmember "
				sql = sql & " set email_10x10='" & chk10x10 & "'"
				sql = sql & " where idx=" & chkidx
				dbget.execute sql
				chkModi = false
			end if
			'//핑거스 아카데미 추가 신청
			if (chk2="N" and chkFingers="Y") then
				sql = "update db_user.dbo.tbl_mailzine_notmember "
				sql = sql & " set email_fingers='" & chkFingers & "'"
				sql = sql & " where idx=" & chkidx
				dbget.execute sql
				chkModi = false
			end if

			'//중복 안내
			if chkModi then
				response.write "<script>"
				response.write "alert('이미 비회원 메일링으로 등록되어 있는 이메일 주소 입니다.');"	
				response.write "</script>"	
				rsget.close(): dbget.close() : response.end
			end if
		else
			'// 참여내용 없음(신규)
			'// 저장처리
			sql = "insert into db_user.dbo.tbl_mailzine_notmember (username,usermail,isusing,email_10x10,email_fingers) values"
			sql = sql & "("
			sql = sql & " '"& html2db(username) &"' , '"& html2db(usermail) & "','Y','" & chk10x10 & "','" & chkFingers & "'"
			sql = sql & ")"
			dbget.execute sql
		end if
	
		rsget.close()

%>
		<script>
			parent.location.href='/member/mailzine/notmember_popok.asp?username=<%=username%>&usermail=<%=usermail%>';
		</script>
	
<!-- #include virtual="/lib/db/dbclose.asp" -->

