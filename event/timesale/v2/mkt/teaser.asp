<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<!--
TEST 할때 : https://m.10x10.co.kr/event/eventmain.asp?eventid=114433&setting_time=2021-09-26%2009:00:00
setting_time은 DEV, STG에서만 적용 운영에서는 불가능
설정시간 기준으로 해당 타임세일이벤트가 진행중이면 자동으로 리다이렉션

-->

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>

<style type="text/css">
    .evt116051 .topic {position:relative; width:100%; height:1305px;}
    .evt116051 .topic .float {position:absolute; left:50%; top:44%; transform: translate(90%,0); z-index:1;}
    .evt116051 .section-01 {position: relative; width:100%;}
    .evt116051 .slide-area {width:1140px; position:absolute; left:50%; top:669px; transform:translate(-50%,0);}
    .evt116051 .slide-area .swiper-wrapper {display:flex; transition-timing-function:linear;}
    .evt116051 .slide-area .swiper-wrapper .swiper-slide {padding:0 12px;}
</style>
</head>
<body>
    <div id="app"></div>

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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.7/js/swiper.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.7/css/swiper.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/vue-awesome-swiper@4.1.1/dist/vue-awesome-swiper.min.js"></script>

    <script src="/vue/event/timesale/teaser/mkt/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->