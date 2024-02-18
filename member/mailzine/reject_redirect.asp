<%@ codepage="65001" language="VBScript" %>
<%
'#######################################################
'	History	:  2014.11.17 허진원 생성
'	Description : 메일링 서비스 수신거부 (for RecoPick / Direct 접속용)
'
'http://www.10x10.co.kr/member/mailzine/reject_redirect.asp?파라메터
'- 파라메터 : base64("M_ID=이메일주소")
'- 예제 : http://www.10x10.co.kr/member/mailzine/reject_redirect.asp?TV9JRD1rb2J1bGFAMTB4MTAuY28ua3I=
'#######################################################
%>
<script>
location.href="reject_mailzine.asp";
</script>
