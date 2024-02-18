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
' Description : 월간텐텐(2월) 브랜드 상품목록
' History : 2023-01-27 김성진 생성
'####################################################
%>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<link rel="stylesheet" type="text/css" href="/monthlyten/2023/february/product/list/styles.css" scoped />
<body class="page-february-monthly-detail default-font">
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <main id="page"></main> 
    <!-- #include virtual="/lib/inc/incfooter.asp" -->
</body>
<script src="/vue/2.5/vue.min.js"></script>
<script src="/vue/vue.lazyimg.min.js"></script>
<script src="/vue/vuex.min.js"></script>

<script type="text/javascript">
  let isUserLoginOK = false;
  <% if IsUserLoginOK then %>
      isUserLoginOK = true;
  <% End If %>
</script>


<script src="/vue/common/common.js?v=1.00"></script>
<script type="text/javascript" src="/lib/js/swiper6.0.4-bundle.min.js"></script>
<script src="/monthlyten/2023/february/product/list/stores/store_data.js?v=1.0.0"></script>
<script src="/monthlyten/2023/february/product/list/index.js?v=1.0.0"></script>
