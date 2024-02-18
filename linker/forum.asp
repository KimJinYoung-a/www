<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
    Dim forumIndex , onlyMyPosting
    forumIndex = Request("idx")
    If forumIndex = "" Then
        Call Alert_Return("잘못된 접근입니다.")
        response.End
    End If

    onlyMyPosting = Request("me")
    If onlyMyPosting = "" Then
        onlyMyPosting = "0"
    End If

    If InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 Then
        If Not(Request("mfg")="pc" or session("mfg")="pc") Then
            If Not(flgDevice="W" or flgDevice="D" or flgDevice="T") Then
                Response.Redirect "https://m.10x10.co.kr/linker/forum.asp?idx=" & forumIndex
                REsponse.End
            End If
        End If
    End If

%>
<!-- #include virtual="/lib/inc/head.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>
<script type="text/javascript" src="/lib/js/swiper6.0.4-bundle.min.js"></script>

<style>
    
</style>
</head>
<body>
    <div class="wrap anniv20">
        <!-- #include virtual="/lib/inc/incHeader.asp" -->
        <div id="app"></div>
        <!-- #include virtual="/lib/inc/incFooter.asp" -->
    </div>
    <script type="text/javascript">
        const forumIndex = Number('<%=forumIndex%>');
        const staticImgUpUrl = "<%= staticImgUpUrl %>";
        const getUserId = "<%= GetLoginUserID %>";
        var userAgent = navigator.userAgent.toLowerCase();
        const onlyMyPosting = <%=ChkIif(onlyMyPosting="1", "true", "false")%>;
        const place = '<%=Request("gaparam")%>'.startsWith('main_mainroll') ? 'mainrolling' : '';

        let isUserLoginOK = false;
        <% IF IsUserLoginOK THEN %>
            isUserLoginOK = true;
        <% END IF %>
        
    </script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.10.4/polyfill.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    <% IF application("Svr_Info") = "Dev" THEN %>
        <script src="/vue/vue_dev.js"></script>
    <% Else %>
        <script src="/vue/2.5/vue.min.js"></script>
    <% End If %>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>

    <script type="text/babel" src="/vue/common/common.js?v=1.00"></script>
    <script type="text/babel" src="/vue/common/mixins/common_mixins.js?v=1.00"></script>
    <script type="text/javascript" src="/lib/js/infinitegrid.gridlayout.min.js"></script>

    <script type="text/babel" src="/vue/components/linker/linker_mixins.js"></script>
    <script type="text/babel" src="/vue/components/common/functions/modal_mixins.js"></script>
    <script type="text/babel" src="/vue/components/common/modal.js"></script>
    <script type="text/babel" src="/vue/components/linker/forum_info.js"></script>
    <script type="text/babel" src="/vue/components/linker/forum_list.js"></script>
    <script type="text/babel" src="/vue/components/linker/forum_description.js"></script>
    <script type="text/babel" src="/vue/components/linker/modal_forum_detail.js"></script>
    <script type="text/babel" src="/vue/components/linker/modal_posting_link_item.js"></script>
    <script type="text/babel" src="/vue/components/linker/modal_posting_write.js"></script>
    <script type="text/babel" src="/vue/components/linker/modal_posting_comment.js"></script>
    <script type="text/babel" src="/vue/components/linker/modal_posting_detail.js"></script>
    <script type="text/babel" src="/vue/components/linker/modal_profile_write.js"></script>
    <script type="text/babel" src="/vue/linker/store.js?v=1.00"></script>
    <script type="text/babel" src="/vue/linker/index.js?v=1.01"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->