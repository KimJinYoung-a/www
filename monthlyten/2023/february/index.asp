<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 월간텐텐(2월)
' History : 2023-01-27 김성진 생성
'####################################################
%>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" scoped />
<script type="text/javascript">
  let userid = "<%= getEncLoginUserID %>";
  let monthlyTenSmsUserCheck = "<%=request.Cookies("appboy")("emailCheck")%>";
  let monthlyTenEmailUserCheck = "<%=request.Cookies("appboy")("smsCheck")%>";
  let februaryLoginCheck = "<%=IsUserLoginOK%>";
  let username = "<%=GetLoginUserName%>";
  let couponCodeFebruaryMonthlyten = "";
  let isDevelopment = false;
  <% IF application("Svr_Info") = "Dev" THEN %>
      couponCodeFebruaryMonthlyten = "4043,4044";
      isDevelopment = true;
  <% Else %>
      couponCodeFebruaryMonthlyten = "2429,2430";
  <% End If %>
</script>
<link rel="stylesheet" type="text/css" href="/monthlyten/2023/february/styles.css" scope />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/floating/styles.css" />
<!-- 비회원/비로그인 -->
<link rel="stylesheet" type="text/css" href="/monthlyten/components/common/content-guide/styles.css" scoped />
<!-- 회원/로그인 -->
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/profile/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/coupon-publish-guide/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/intro/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/take-part-brand-list/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/today-brand-item-list/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/brand-item-list-group/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/discount-item-list-group/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/exhibit-and-event/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/to-gift/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/alarm-or-download/styles.css" scoped />
<link rel="stylesheet" type="text/css" href="/monthlyten/components/signin_after/modal/coupon-modal/styles.css" scoped />

<body class="page-february-monthly default-font">
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <main id="page"></main>
    <!-- #include virtual="/lib/inc/incfooter.asp" -->
</body>
<% IF application("Svr_Info") = "Dev" THEN %>
  <script src="/vue/vue_dev.js"></script>
<% Else %>
  <script src="/vue/2.5/vue.min.js"></script>
<% End If %>
<script src="/vue/vue.lazyimg.min.js"></script>
<script src="/vue/vuex.min.js"></script>
<script type="text/javascript" src="/lib/js/swiper6.0.4-bundle.min.js"></script>
<script src="/monthlyten/2023/february/stores/store_data.js?v=1.0.0"></script>
<script src="/vue/components/common/functions/common.js?v=1.0"></script>
<!-- 비회원/비로그인 -->
<script src="/monthlyten/components/common/content-guide/index.js?v=1.0.0"></script>
<!-- 회원/로그인 -->
<script src="/monthlyten/components/signin_after/profile/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/coupon-publish-guide/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/intro/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/take-part-brand-list/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/today-brand-item-list/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/brand-item-list-group/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/discount-item-list-group/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/exhibit-and-event/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/floating/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/modal/coupon-modal/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/to-gift/index.js?v=1.0.0"></script>
<script src="/monthlyten/components/signin_after/alarm-or-download/index.js?v=1.0.0"></script>
<script src="/monthlyten/2023/february/index.js?v=1.0.0"></script>
