<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>

<style>
    .evt113056 .topic {position:relative; height:1504px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113056/bg_main.jpg) no-repeat 50% 0;}
    .evt113056 .topic .cut01 {position:absolute; left:50%; top:490px; margin-left:-512px; opacity:0; transform: translateY(-1rem); transition:1s;}
    .evt113056 .topic .cut02 {position:absolute; left:50%; top:820px; margin-left:-488px; opacity:0; transform: translateY(-1rem); transition:1s .5s;}
    .evt113056 .topic .cut03 {position:absolute; left:50%; top:428px; margin-left:-54px; opacity:0; transform: translateY(-1rem); transition:1s 1s;}
    .evt113056 .topic .cut01.check {position:absolute; left:50%; top:490px; margin-left:-512px; transform: translateY(0); opacity:1;}
    .evt113056 .topic .cut02.check {position:absolute; left:50%; top:820px; margin-left:-488px; transform: translateY(0); opacity:1;}
    .evt113056 .topic .cut03.check {position:absolute; left:50%; top:428px; margin-left:-54px; transform: translateY(0); opacity:1;}
    .evt113056 .topic .txt {position:absolute; left:50%; top:1170px; margin-left:-200px;}
    .evt113056 .animate {opacity:0; transform:translateY(-3rem); transition:all 1s;}
    .evt113056 .animate.on {opacity:1; transform:translateY(0);}
    .evt113056 .section-01 {height:987px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113056/img_sub01.jpg) no-repeat 50% 0;}
    .evt113056 .section-02 {position:relative; height:736px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113056/img_check.jpg) no-repeat 50% 0;}
    .evt113056 .section-02 .check-area {position:relative; width:1140px; margin:0 auto;}
    .evt113056 .section-02 .check-area button {position:relative; background:transparent;}
    .evt113056 .section-02 .check-area button.on::before {content:""; display:block; width:31px; height:31px; position:absolute; left:50%; top:2%; transform:translate(-50%,0); background:url(//webimage.10x10.co.kr/fixevent/event/2021/113056/icon_check.png) no-repeat 0 0; background-size:31px;}
    .evt113056 .section-02 .check-area .btn-ch01 {width:220px; height:285px; position:absolute; left:111px; top:0;}
    .evt113056 .section-02 .check-area .btn-ch02 {width:220px; height:285px; position:absolute; left:345px; top:0;}
    .evt113056 .section-02 .check-area .btn-ch03 {width:220px; height:285px; position:absolute; left:580px; top:0;}
    .evt113056 .section-02 .check-area .btn-ch04 {width:220px; height:285px; position:absolute; left:814px; top:0;}
    .evt113056 .section-02 .check-area .btn-ch05 {width:220px; height:285px; position:absolute; left:228px; top:340px;}
    .evt113056 .section-02 .check-area .btn-ch05.on::before,
    .evt113056 .section-02 .check-area .btn-ch06.on::before,
    .evt113056 .section-02 .check-area .btn-ch07.on::before {top:-2%;}
    .evt113056 .section-02 .check-area .btn-ch06 {width:220px; height:285px; position:absolute; left:462px; top:340px;}
    .evt113056 .section-02 .check-area .btn-ch07 {width:220px; height:285px; position:absolute; left:697px; top:340px;}
    .evt113056 .section-03 .top {position:relative; height:120px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113056/img_comment_top.jpg) no-repeat 50% 0;}
    .evt113056 .section-03 .top textarea {position:absolute; left:50%; top:40px; transform:translate(-50%,0); width:796px; height:74px; padding:0; border:0; font-size:20px; color:#878787; font-weight:500;}
    .evt113056 .section-03 .top textarea::placeholder {font-size:20px; color:#878787;}
    .evt113056 .section-03 .md {position:relative; height:113px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113056/img_comment_md.jpg) no-repeat 50% 0;}
    .evt113056 .section-03 .md .img-view {position:absolute; left:50%; top:9px; transform:translate(-380%,0); width:100px; height:100px; border:2px solid #ebebeb;}
    .evt113056 .section-03 .md .img-view .wraps {position:relative; width:100%; height:100%;}
    .evt113056 .section-03 .md .img-view .wraps .img {width:100%; height:100%; overflow:hidden;}
    .evt113056 .section-03 .md .img-view .wraps .img img {width:100%;}
    .evt113056 .section-03 .md .img-view .wraps .btn-close {position:absolute; right:-10%; top:-11%; width:30px; z-index:10; background:transparent;}
    .evt113056 .section-03 .bottom {position:relative; height:460px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113056/img_comment_bottom.jpg) no-repeat 50% 0;}
    .evt113056 .section-03 .bottom .count-num {position:absolute; left:50%; top:38px; transform: translate(210%,0); font-size:18px; color:#979797; font-weight:500;}
    .evt113056 .section-03 .bottom .btn-photo {position:absolute; left:50%; top:23px; transform: translate(-270%,0); width:150px; height:68px; background:transparent;}
    .evt113056 .section-03 .btn-apply {position:absolute; left:50%; top:124px; transform:translate(-50%,0); width:308px; height:70px; background:transparent;}
    .evt113056 .section-04 {background:#fff4e3;}
    .evt113056 .section-04 .comment-list {display:flex; flex-wrap:wrap; width:1086px; padding:198px 27px 0; margin:0 auto;}
    .evt113056 .section-04 .comment-list .list-area:nth-child(1),
    .evt113056 .section-04 .comment-list .list-area:nth-child(2),
    .evt113056 .section-04 .comment-list .list-area:nth-child(3) {margin-top:0;}
    .evt113056 .section-04 .comment-list .list-area {position:relative; width:300px; height:435px; padding:15px 15px 30px; margin:112px 16px 0; background:#fff;}
    .evt113056 .section-04 .comment-list .list-area .img {width:100%; height:300px; overflow:hidden; background:#ddd;}
    .evt113056 .section-04 .comment-list .list-area .img img {width:100%;}
    .evt113056 .section-04 .comment-list .list-area .info {display:flex; align-items:center; justify-content:space-between; padding:28px 0 20px;}
    .evt113056 .section-04 .comment-list .list-area .info .num {color:#404040; font-size:17px; font-weight:700;}
    .evt113056 .section-04 .comment-list .list-area .info .id {color:#9d9d9d; font-size:15px; font-weight:500;}
    .evt113056 .section-04 .comment-list .list-area .comment {color:#404040; font-size:16px; line-height:1.4; font-weight:500; text-align:left;}
    .evt113056 .section-04 .comment-list .list-area .ch-view {position:absolute; left:50%; top:-60px; transform:translate(-50%,0);}
    .evt113056 .pageWrapV15 {padding:78px 0 126px;}
    .evt113056 .pagingV15a {position:relative; height:100%; margin:0; display:flex; align-items:center; justify-content:center;}
    .evt113056 .pagingV15a span {display:inline-block; width:28px; height:28px; margin:0 3px; color:#686765; font-weight:600; font-size:16px;}
    .evt113056 .pagingV15a span.current {color:#fff; border:0; background-color:#e32285; border-radius:50%;}
    .evt113056 .pagingV15a span a {display:inline-block; width:100%; height:auto; line-height:1.8; border:0; background:transparent; cursor:pointer;}
    .evt113056 .pagingV15a span.arrow {display:inline-block; min-width:33px; height:28px; padding:0; background-color:transparent;}
    .evt113056 .pagingV15a span.arrow a {width:100%; height:100%; background-size:100% 100%; border:0; font-size:0;}
    .evt113056 .pagingV15a span.arrow a:after {display:none;}
    .evt113056 .pagingV15a span.arrow.prevBtn a{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113056/icon_left.png) no-repeat 0 50%; background-size:0.76rem 1.32rem;}
    .evt113056 .pagingV15a span.arrow.nextBtn a{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113056/icon_right.png) no-repeat right 50%; background-size:0.76rem 1.32rem;}

    .evt113056 .noti {height:434px; margin-top:-1px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113056/img_noti.jpg) no-repeat 50% 0;}
    @keyframes show {
        0% {opacity:0;}
        100% {opacity:1;}
    }
</style>
</head>
<body>
    <div id="app"></div>
    <script type="text/javascript">
        const loginUserLevel = "<%= GetLoginUserLevel %>";
        const loginUserID = "<%= GetLoginUserID %>";
        const server_info = "<%= application("Svr_Info") %>";

        let isUserLoginOK = false;
        <% IF IsUserLoginOK THEN %>
            isUserLoginOK = true;
        <% END IF %>
    </script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.10.4/polyfill.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
    <% IF application("Svr_Info") = "Dev" THEN %>
        <script src="/vue/vue_dev.js"></script>
    <% Else %>
        <script src="/vue/2.5/vue.min.js"></script>
    <% End If %>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>

    <script src="/vue/common/common.js?v=1.00"></script>
    <script type="text/babel" src="/vue/common/mixins/common_mixins.js?v=1.00"></script>
    <script type="text/javascript" src="/event/etc/json/js_applyItemInfo_110063.js?v=1.00"></script>
    <script type="text/javascript" src="/event/lib/countdown.js"></script>

    <script type="text/babel" src="/vue/event/sanrio/store.js?v=1.00"></script>
    <script type="text/babel" src="/vue/event/sanrio/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->