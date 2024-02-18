<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<%
    if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
        if Not(Request("mfg")="pc" or session("mfg")="pc") then
            if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
                Response.Redirect "//m.10x10.co.kr/event/heart_gift/index.asp"
                REsponse.End
            end if
        end if
    end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<link href="/vue/heart_gift/heart-gift.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <div class="eventContV15 tMar15">
        <div id="app"></div>
    </div>
    <script type="text/javascript">
        const loginUserLevel = "<%= GetLoginUserLevel %>";
        const loginUserID = "<%= GetLoginUserID %>";
        const server_info = "<%= application("Svr_Info") %>";

        let isUserLoginOK = false;
        <% IF IsUserLoginOK THEN %>
            isUserLoginOK = true;
        <% END IF %>

        function goProduct(itemid) {
            parent.location.href='/shopping/category_prd.asp?itemid='+itemid;
            return false;
        }

        function goEventLink(evt) {
        	parent.location.href='/event/eventmain.asp?eventid='+evt;
        }
    </script>
</body>
</html>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>

<script src="/vue/common/common.js?v=1.01"></script>
<script src="/vue/components/common/functions/event_common.js?v=1.0"></script>
<% If application("Svr_Info") = "Dev" Then %>
    <script src="/vue/vue_dev.js"></script>
<% Else %>
    <script src="/vue/2.5/vue.min.js"></script>
<% End If %>
<script src="/vue/vuex.min.js"></script>
<script type="text/javascript" src="/lib/js/swiper6.0.4-bundle.min.js"></script>
<!--script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script-->
<!--script src="https://cdn.jsdelivr.net/npm/vue-awesome-swiper@4.1.1/dist/vue-awesome-swiper.min.js"></script-->
<script src="/vue/components/linker/linker_mixins.js"></script>
<script src="/vue/event/family/js_applyItemInfo.js?v=1.00"></script>
<script src="/vue/heart_gift/linker.js"></script>
<script src="/vue/heart_gift/store.js?v=1.01"></script>
<script src="/vue/heart_gift/index.js?v=1.00"></script>
<!-- #include virtual="/lib/db/dbclose.asp" -->