<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2009.10.08 한용민 생성
'	Description : 비회원 메일링 서비스 수신거부
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->

<%
dim usermail, chkSiteDiv
	usermail = requestCheckVar(request("usermail"),128)
	chkSiteDiv = requestCheckVar(request("site"),7)

if usermail = "" then
	response.write "<script>"
	response.write "alert('[오류]메일주소가 지정되지 않았습니다.');"	
	response.write "self.close();"
	response.write "</script>"
	dbget.close() : response.end	
end if

dim sql, chkIdx, chk10x10, chkFingers

	'처음 참여하는지 체크
		sql = "select idx, email_10x10, email_fingers from db_user.dbo.tbl_mailzine_notmember where isusing='Y' and usermail='"&html2db(usermail)&"'"
		rsget.open sql,dbget,1
		
		if not rsget.EOF  then
		  chkIdx		= rsget("idx")
		  chk10x10		= rsget("email_10x10")
		  chkFingers	= rsget("email_fingers")
		end if

		rsget.close
		
		'//해당되는 메일이 있는지 확인
		if chkIdx="" or (chk10x10="N" and chkSiteDiv="10x10") or (chkFingers="N" and chkSiteDiv="fingers") then
			response.write "<script>"
			response.write "alert('해당 이메일 내역이 없습니다.');"	
			response.write "self.close();"
			response.write "</script>"
			dbget.close() : response.end
		end if

		'// 사이트 구분에 따른 처리
		if chkFingers="Y" and chkSiteDiv="10x10" then
			'#텐바이텐 메일 수신거부
			sql = "update db_user.dbo.tbl_mailzine_notmember set email_10x10='N' where idx="& chkIdx
		elseif chk10x10="Y" and chkSiteDiv="fingers" then
			'#핑거스 아카데미 메일 수신거부
			sql = "update db_user.dbo.tbl_mailzine_notmember set email_fingers='N' where idx="& chkIdx
		else
			'#삭제처리
			sql = "update db_user.dbo.tbl_mailzine_notmember set isusing='N' where idx="& chkIdx
		end if

		dbget.execute sql	
			 
%>
		<script>
			location.href='/member/mailzine/notmember_delok.asp';
		</script>
	
<!-- #include virtual="/lib/db/dbclose.asp" -->

