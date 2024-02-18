<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 18주년 리다이렉트 페이지
' History : 2019-09-30 원승현 
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<script type="text/javascript">
    $(function(){
        document.location.href='/event/18th/'
        return false;
    });
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->