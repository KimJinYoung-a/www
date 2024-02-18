<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 월간텐텐(2월) 외부 링킹 페이지
' History : 2023-01-27 김성진 생성

response.redirect "/monthlyten/2023/february/index.asp"
'####################################################
%>
<script type="text/javascript">
    let currentDate = <%=Date()%>
    let februaryLoginCheck = "<%=IsUserLoginOK%>";
    document.addEventListener("DOMContentLoaded", function() {
        location.href = `/monthlyten/2023/february/index.asp`
    });
</script>
<link rel="stylesheet" type="text/css" href="/monthlyten/2023/february/external/styles.css" scope />
<!-- 비회원/비로그인 -->
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/intro/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/common/content-guide/styles.css" scoped />
<body class="external-page-february-monthly default-font">
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <main id="page"></main>
    <!-- #include virtual="/lib/inc/incfooter.asp" -->
</body>
<script src="/vue/2.5/vue.min.js"></script>
<script src="/vue/vue.lazyimg.min.js"></script>
<script src="/vue/vuex.min.js"></script>
<script src="/vue/common/common.js?v=1.00"></script>
<script src="/monthlyten/2023/february/external/stores/store_data.js?v=1.0.0"></script>
<!-- 비회원/비로그인 -->
<script src="/monthlyten/components/signin_after/intro/index.js"></script>
<script src="/monthlyten/components/common/content-guide/index.js?v=1.0.0"></script>
<script src="/monthlyten/2023/february/external/index.js?v=1.0.0"></script>
