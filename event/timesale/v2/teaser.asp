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

<style>
    .evt111786 {max-width:1920px; margin:0 auto; background:#fff;}
    .evt111786 button {background-color:transparent;}
.evt111786 .topic {position:relative; width:100%; height:649px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/120264/img_teaser_main.jpg) no-repeat 50% 0;}/* 09-22 수정 */
    .evt111786 .topic .teaser-main {position:relative; width:1140px; height:649px; margin:0 auto;}
    .evt111786 .topic .teaser-main .btn-more {display:block; width:100%; background-color:rgba(0,0,10,0.5);}
    .evt111786 .topic .teaser-main .list-wrap a {position:relative; display:inline-block; width:100%; height:100%;}
.evt111786 .topic .teaser-main .item-area {position:absolute; right:11%; top:48%; opacity:0.8;}/* 09-22 수정 */
    .evt111786 .topic .teaser-main .item-area .thumb .item1,
    .evt111786 .topic .teaser-main .item-area .thumb .item2,
    .evt111786 .topic .teaser-main .item-area .thumb .item3,
    .evt111786 .topic .teaser-main .item-area .thumb .item4 {transition: .5s ease-in;}
.evt111786 .topic .teaser-main .img-beg {position:absolute; right:5px; top:30px; width:150px; height:130px;} /* 10-04 수정 */
.evt111786 .topic .teaser-main .img-beg img {width:100%;}

.evt111786 .teaser-timer {width:100%; height:440px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/120264/img_left_time.jpg) no-repeat 50% 0;}/* 09-22 수정 */
    .evt111786 .teaser-timer .timer-inner {position:relative; width:1140px; height:440px; margin:0 auto;}
    .evt111786 .teaser-timer .sale-timer {position:absolute; bottom:16%; left:5.5%; color:#fff; font-size:75px; font-weight:700;}
    .evt111786 .teaser-timer .btn-push {width:21.74rem; height:6.08rem; position:absolute; right:0; bottom:18%; background:transparent;}

    .evt111786 .product-list {width:1020px; margin:0 auto 176px; padding-top:107px; background:#fff;}
    /* 10-07 수정 */
    .evt111786 .product-list .list {display:flex; justify-content:center; flex-wrap:nowrap;}
    .evt111786 .product-list .list li {width:349px;}
    .evt111786 .product-list .list li:nth-child(2) {margin:0 45px;}
    .evt111786 .product-list .product-inner {position:relative;width: 349px;height: 373px;}
    .evt111786 .product-list .product-inner img {width: 349px;height: 373px;}
    .evt111786 .product-list .product-inner .num-limite {position:absolute; top:-14px; right:0; z-index:10; width:140px; height:37px; font-size:21px; font-weight:700; color:#fff; text-align:center; line-height:42px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111786/img_limit_sold.png) no-repeat 0 0; background-size:100%; content:'';}
    /* // */
    .evt111786 .product-list .product-inner .num-limite em {padding-left:10px; font-size:25px;}

    .evt111786 .product-list .desc .name {position:absolute; left:1.73rem; top:19.5rem; width:90%; overflow:hidden; font-size:23px; line-height:1.2; color:#111; font-weight:500; white-space:nowrap; text-overflow:ellipsis; text-align:left;}
    .evt111786 .product-list .desc .price {display:flex; align-items:baseline; position:absolute; left:1.73rem; top:24rem; font-size:33px; font-weight:700; color:#111;}
    .evt111786 .product-list .desc .price s {position:absolute; left:0; top:-1.5rem; font-size:23px; font-weight:400; color:#888;}
    .evt111786 .product-list .desc .price span {display:inline-block; margin-left:1.1rem; color:#ff0943; font-size:40px;}
    .evt111786 .product-list .desc .price .p-won {font-size:21px; color:#111; margin:0 0 7px 1px;}

    .evt111786 .pop-container .input-box {position:absolute; left:105px; top:70%; display:flex; justify-content:space-between; align-items:center; width:54%;}
    .evt111786 .pop-container .input-box input {width:100%; height:51px; padding:0; background-color:transparent; border:0; border-bottom:solid 3px #acfe25; border-radius:0; color:#fff; font-size:27px; text-align:left;}
    .evt111786 .pop-container .input-box .btn-submit {width:65px; height:54px; margin-left:-1px; color:#acfe25; border-bottom:solid 3px #acfe25; font-size:21px; background:transparent;}
    .evt111786 .pop-container .input-box input::placeholder {font-size:21px; color:#b7b7b7; text-align:left;}
    .evt111786 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
    .evt111786 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
    .evt111786 .pop-container .pop-inner a {display:inline-block;}
    .evt111786 .pop-container .pop-inner .btn-close {position:absolute; right:66px; top:55px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111786/icon_close.png?v=4) no-repeat 0 0; background-size:100%; text-indent:-9999px;}
    .evt111786 .pop-container.push .contents-inner {position:relative; width:663px; height:765px; margin:0 auto;}

    .evt111786 .wish-list .thumbnail {width:230px;}
    .evt111786 .wish-list .thumbnail img {width:100%;}
    .evt111786 .wish-list .desc {padding-left:5px;}
    .evt111786 .wish-list .name {height:40px; margin-top:10px; font-size:14px; line-height:1.46;}
    .evt111786 .wish-list .price {margin-top:13px; color:#222; font-size:16px; font-weight:bold;}
    .evt111786 .wish-list .sale {color:#fe3f3f; font-size:12px;}

    .noti-area {max-width:1920px; margin:0 auto; background:#262626;}
    .noti-area .noti-header .btn-noti {position:relative; width:1140px; margin:0 auto;}
    .noti-area .noti-header .btn-noti span {display:inline-block; position:absolute; left:50%; top:80px; transform:translate(610%,0);}
    .noti-area .noti-header .btn-noti.on span img {transform:rotate(180deg);}
    .noti-area .noti-info {display:none; width:1140px; margin:0 auto;}
    .noti-area .noti-info.on {display:block;}

    /* 잠시 후 오픈 이미지->텍스트 수정 2021.06.09 손지수 */
    .product-list .open-time{position:relative;width:466px;height:52px;text-align:left;font-size:34px;color:#000;letter-spacing:-0.15rem;padding-left:15px;padding-top:18px;line-height:38px;z-index:0;}
    .product-list .open-time::after{position:absolute;top:0;left:0;content:'';width:45px;height:45px;border-radius:50%;background-color:#a8ff00;z-index:-1;}
    .product-list .open-time span{font-weight:bold;font-size:38px}
    /* // 잠시 후 오픈 이미지->텍스트 수정 2021.06.09 손지수 */
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
    <script src="/vue/common/mixins/common_mixins.js?v=1.00"></script>

    <script type="text/javascript" src="/event/lib/countdown24.js"></script>

    <script src="/vue/event/timesale/teaser/store.js?v=1.00"></script>
    <script src="/vue/event/timesale/teaser/index.js?v=1.01"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->