<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
response.write getencLoginUserid() & "<Br>"
response.write request.ServerVariables("SCRIPT_NAME") & "?" & request.ServerVariables("QUERY_STRING")
%>
<script type="text/javascript">

</script>
</head>
<body>
<div>
    <!--
    eventType : EVENT(이벤트) , EXHIBITION(기획전)
    alarmType : KAKAO(카카오알림톡) , PUSH(푸시) / 지정이 없는경우 자동 www/m : 알림톡 , a : 푸시
    linkIdx : 이벤트나 기획전의 실제 idx 번호값
    isapp : 앱여부
    referUrl : 로그인후 돌아올 경로
    -->
    <input type="button" value="통합자동알림" onclick="doAutoAlarm('EVENT','','5555','0','<%= Server.URLencode(request.ServerVariables("SCRIPT_NAME") & "?" & request.ServerVariables("QUERY_STRING")) %>');">
    <br>
    <input type="button" value="통합자동알림(수신여부Y로같이변경)" onclick="doAutoAlarmWithReqYN('EVENT','','5555','0','<%= Server.URLencode(request.ServerVariables("SCRIPT_NAME") & "?" & request.ServerVariables("QUERY_STRING")) %>');">
    <br>
    <input type="button" value="통합자동알림삭제" onclick="doAutoAlarmDel('EVENT','','5555','0','<%= Server.URLencode(request.ServerVariables("SCRIPT_NAME") & "?" & request.ServerVariables("QUERY_STRING")) %>');">
</div>
</body>
</html>


<!-- #include virtual="/lib/db/dbclose.asp" -->