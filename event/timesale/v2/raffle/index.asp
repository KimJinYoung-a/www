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
.timesales {max-width:1920px; overflow:hidden; background:#f8f8f8;}
.timesales .txt-hidden {font-size:0; text-indent:-9999px;}
.timesales .relative {position:relative;}
.timesales .conts {width:1140px; height:100%; margin:0 auto;}
.timesales .topic {position:relative; width:100%; height:584px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/117461/main.gif?v=3) no-repeat 50% 0;}
.timesales .btn-check {position:absolute; right:0; top:0; background:transparent;}
.timesales .top-sec {padding-top:130px;}
.timesales .top-sec .btn-tenten {width:30px; height:30px; position:absolute; right:370px; top:25px; background:transparent;}
.timesales .top-sec .time-border {position:relative; width:529px; margin:21px auto 0;}
.timesales .top-sec .time-border .open-noti {margin-top:18px; font-size:26px; color:#0054FF; text-align:center; font-weight:600;}
.timesales .top-sec .time {position:absolute; left:0; top:0; width:529px; height:114px;}
.timesales .top-sec .time span {position:absolute; font-size:60px; color:#0054FF;}
.timesales .top-sec .time .hour {left:5%; top:50%; transform:translateY(-50%);}
.timesales .top-sec .time .min {left:28%; top:50%; transform:translateY(-50%); letter-spacing:4rem;}
.timesales .top-sec .time .second {left:69%; top:50%; transform:translateY(-50%); letter-spacing:4rem;}
.timesales .top-sec .time .bar {left:18%; top:6%;}
.timesales .top-sec .time .bar02 {left:60%; top:6%;}
.timesales .item-sec {padding-top:16px; margin-top:35px;} /* 2022-03-29 */
.timesales .product-inner .info {width:561px; padding-top:74px;}
.timesales .product-inner .info .line {width:100%; height:1px; margin-top:38px; background:#B7B7B7;}
.timesales .product-inner .info .event-day {margin:34px 0 0 42px; text-align:left;}
.timesales .product-inner .info .event-day li {font-size:18px; color:#A6A6A6; line-height:28.75px; font-weight:500;}
.timesales .product-inner {display:flex; align-items:flex-start; justify-content:center;}
.timesales .product-inner .thum {position:relative; margin-right:26px;}
.timesales .product-inner .thum .item-img {position:absolute; right:16px; top:61px; width:450px; height:470px; overflow:hidden;}
.timesales .product-inner.next-item .thum .item-img {position:absolute; right:80px; top:61px; width:360px; height:360px; overflow:hidden;}
.timesales .product-inner .thum .item-img img {width:100%;}
.timesales .product-inner .thum .round {position:absolute; right:-17px; top:31px;}
.timesales .desc {position:relative; margin-left:42px; text-align:left;}
.timesales .desc .brand {font-size:18px; color:#848484;}
.timesales .desc .name {margin:10px 0 25px; font-size:29px; color:#222; line-height:41px; font-weight:700; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; text-overflow: ellipsis; overflow:hidden; word-break:break-all;}
.timesales .desc .num-limite {display:inline-block; height:34px; padding:0 16px; line-height:34px; border-radius:30px; background:#FF214F; font-size:20px; font-weight:600; color:#fff;}
.timesales .desc .price {padding-top:50px; font-size:42px; color:#000; font-weight:600;}
.timesales .desc .price s {position:absolute; left:0; top:15px; font-size:24px; color:#B5B5B5; font-weight:300; text-decoration:none;}
.timesales .desc .price .sale {margin-left:10px; color:#FF214F;}
.timesales .desc .btn-alram {position:absolute; right:0; bottom:60px; background:transparent;}
.timesales .desc .btn-share {position:absolute; right:0; bottom:15px; background:transparent;}
.timesales .item-sec .btn-apply {width:554px; height:85px; margin-top:69px; font-size:32px; border-radius:5.55rem; background:linear-gradient(181.32deg, #4AEBD7 -15.24%, rgba(5, 162, 143, 0.81) 131.38%); color:#fff; font-weight:700;}
.timesales .item-sec .btn-apply.disabled {color:#D8D8D8; background:#4B4B4B; pointer-events:none;}
.timesales .item-sec .tit-noti {padding-top:15px; font-size:18px; color:#848484; font-weight:500;}
.timesales .noti-area {margin:28px 0 100px; text-align:center;}
.timesales .btn-noti {position:relative; background:transparent;}
.timesales .btn-noti .icon {position:absolute; right:12px; top:10px; display:inline-block; width:14px; height:9px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/117461/icon_arrow.png) no-repeat 0 0; background-size:100%;}
.timesales .btn-noti .icon.on {transform:rotate(180deg);}
.timesales .noti-txt {display:none; width:937px; margin:60px auto 0; text-align:left;}
.timesales .noti-txt.on {display:block;}
.timesales .noti-txt h3 {padding-bottom:0.1rem; font-size:18px; color:#4A4A4A; font-weight:600;}
.timesales .noti-txt li {font-size:18px; color:#4A4A4A; line-height:30.73px; letter-spacing:-1.2px;}

.timesales .item-sec02 {padding:100px 0 60px; background:#fff;}
.timesales .item-sec02 h3 {width:1000px; margin:0 auto; padding-left:40px; text-align:left;}
.timesales .product-inner.next-item {padding:20px 0 120px;}
.timesales .product-inner.next-item .bg {position:relative; display:flex; align-items:flex-start; justify-content:space-between; width:1000px; min-height:424px; padding:30px 63px; background: linear-gradient(100.24deg, rgba(204, 255, 89, 0.091) 16.94%, rgba(171, 235, 255, 0.266) 75.57%); border-radius: 30px;}
.timesales .product-inner.next-item .thum {width:500px; min-height:424px; margin:0;}
.timesales .product-inner.next-item .info {width:410px; position:absolute; right:60px; top:50%; transform:translateY(-50%); padding-top:0;}
.timesales .product-inner.next-item .thum .item-img {top:50%; transform:translateY(-50%);}
.timesales .product-inner.next-item .thum .item-img img {width:100%;}
.timesales .product-inner.next-item .desc {margin-left:0;}
.timesales .product-inner.next-item .desc .name {font-size:26px;}
.timesales .product-inner.next-item .desc .num-limite {background:#222;}
.timesales .product-inner.next-item .desc .price {font-size:31px;}

.timesales .product-inner.end-time .bg {background:rgba(0, 0, 0, 0.08);}
.timesales .product-inner.end-time .desc .brand,
.timesales .product-inner.end-time .desc .name,
.timesales .product-inner.end-time .desc .price,
.timesales .product-inner.end-time .desc .price s,
.timesales .product-inner.end-time .desc .price .p-won,
.timesales .product-inner.end-time .desc .price .sale {color:#A6A6A6;}
.timesales .product-inner.end-time .badge {position:absolute; right:0; top:0;}
.timesales .product-inner.end-time .item-img img {filter: grayscale(100%);}

.timesales .more-product .grd-bar {width:100%; height:16px; background: linear-gradient(90.16deg, #35CFFF -1.55%, rgba(217, 255, 131, 0.71) 82.98%);}
.timesales .more-product .top-tit {position:relative; padding-top:115px;}
.timesales .more-product.before .top-tit {padding-bottom:83px;} /* 2022-03-29 */
.timesales .more-product.before .top-tit .link01 {display:inline-block; width:250px; height:250px; position:absolute; right:310px; bottom:130px;}
.timesales .more-product.before .top-tit .link02 {display:inline-block; width:250px; height:250px; position:absolute; right:20px; bottom:130px;}
.timesales .more-product .top-tit .open-noti {padding:12px 0 64px; font-size:26px; color:#0054FF; line-height:42.12px; letter-spacing:-0.015em; font-weight:600;}
.timesales .more-product .top-tit .tit {width:402px; margin:0 auto;}
.timesales .more-product .top-tit .time {display:flex; align-items:center; justify-content:center; padding:0 0 57px; margin-right:30px;}
.timesales .more-product .top-tit .time span {font-size:60px; color:#222;}
.timesales .more-product .top-tit .btn-sale {position:absolute; right:360px; top:135px; width:50px; height:50px; background:transparent;}

/* 2022-03-25 수정 */
.timesales #itemList {display:flex; flex-wrap:wrap; justify-content:flex-start; margin:0 auto;}
/* // */
.timesales #itemList li {width:250px; margin-right:35px; list-style:none;}
.timesales #itemList li a {text-decoration:none;}
.timesales #itemList .desc {position:relative; width:250px; height:10rem; margin:25px 0 130px;}
.timesales #itemList .thumbnail {position:relative; width:250px; height:250px; overflow:hidden; background:#fff;}
.timesales #itemList .thumbnail img{width:100%;}
.timesales #itemList .desc .name {height:60px; padding:0 0 0 10px; overflow: hidden; font-size:21px; line-height:1.5; color: #000; font-weight:600; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;}
.timesales #itemList .desc .brand {padding-left:10px; font-size:15px; color:#848484;}
.timesales #itemList .desc .price {position:absolute; left:10px; top:125px; padding-top:0; margin-top:13px; font-size:23px; font-weight:600;}
.timesales #itemList .desc .price s {position:absolute; left:0; top:-1.5rem; font-size:19px; color:#888;}
.timesales #itemList .desc .price .sale {display:inline-block; margin-left:0.5rem; font-size:1.45rem; color:#FF214F;}

.timesales .winner-info {padding:0 29px;}
.timesales .winner-detail {display:flex; align-items:flex-start; justify-content:center; margin:45px 0;}
.timesales .winner-detail .desc {width:48%; padding:0; margin:30px 0 0 30px; flex:1;}
.timesales .winner-detail .desc .round {display:inline-block; height:32px; line-height:32px; padding:0 17px; font-size:22px; color:#fff; background:#222; border-radius:56px; font-weight:700;}
.timesales .winner-detail .desc .name {padding:0; font-size:22px; line-height:30px; color:#4B4B4B; font-weight:600; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow:hidden;}
.timesales .winner-detail .desc .winner-id {padding-top:10px;}
.timesales .winner-detail .desc .winner-id p {font-size:22px; color:#222; font-weight:500;}
.timesales .winner-detail .desc .winner-id .id {display:flex; align-items:center; font-weight:700;}
.timesales .winner-detail .desc .winner-id .id .ten-id {margin-right:0.3rem; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;}
.timesales .winner-detail .thumbnail {position:relative; width:250px; height:250px; background:transparent;}
.timesales .winner-detail .thumbnail .bg-noti {position:absolute; left:0; top:0; display:flex; align-items:center; justify-content:center; width:100%; height:100%; font-size:30px; z-index:5; color:#fff; font-weight:800; background:rgba(0, 0, 0, 0.43);}
.timesales .winner-detail .thumbnail img {width:100%;}

.timesales .popup {position:absolute; right:0; top:0; z-index:107;}
.timesales .dim {position:fixed; left:0; top:0; width:100%; height:100%; background: rgba(0, 0, 0, 0.8); box-shadow: 0px -3px 27px rgba(0, 0, 0, 0.06); z-index:106;}
.timesales .popup .btn-close {position:absolute; right:30px; top:50px; width:30px; height:30px; background:transparent;}
.timesales .popup.pop-alram .btn-close,
.timesales .popup.pop-apply .btn-close {right:50px; top:53px; width:40px; height:40px;}
.timesales .pop-win01 .btn-close,
.timesales .pop-win02 .btn-close,
.timesales .pop-win03 .btn-close {right:25px; top:25px; width:40px; height:40px;}
.timesales .pop-win03 .btn-close {right:30px; width:60px; height:60px;}
.timesales .popup.ten-raffle {right:337px; top:60px;}
.timesales .popup.ten-sale {right:339px; top:180px;}
.timesales .pop-alram,
.timesales .pop-apply,
.timesales .pop-win01,
.timesales .pop-win02,
.timesales .pop-win03 {position:fixed; top:50%; left:50%; transform:translate(-50%,-50%);}
.timesales .pop-win01,
.timesales .pop-win02 {width:500px; height:500px;}
.timesales .pop-win02 .txt {position:absolute; left:50%; top:230px; width:100%; transform:translateX(-50%); text-align:center; font-size:31px; color:#222; font-weight:700; line-height:47px;}
.timesales .pop-alram,
.timesales .pop-apply {width:579px; height:554px;}
.timesales .pop-alram input,
.timesales .pop-apply input {position:absolute; left: 50%; top:287px; width:340px; height:51px; padding:0 50px 0 20px; transform:translateX(-50%); border:0; background:transparent; font-size:22px; color:#B7B7B7;}
.timesales .pop-alram input::placeholder,
.timesales .pop-apply input::placeholder {font-size:22px; color:#B7B7B7;}
.timesales .pop-alram .btn-delete,
.timesales .pop-apply .btn-delete {width:50px; height:50px; position:absolute; right:86px; top:289px; background:transparent;}
.timesales .pop-alram .btn-applys,
.timesales .pop-apply .btn-applys {width:100%; height:75px; position:absolute; left:0; bottom:98px; background:transparent;}
.timesales .btn-ch-win {width:100%; height:75px; position:absolute; left:0; top:253px; background:transparent;}
.timesales .btn-all-win {width:100%; height:75px; position:absolute; left:0; top:349px; background:transparent;}
.timesales .popup.pop-win03 {width:800px; max-height:720px; overflow:auto; background:#fff; border-radius:30px;}
.timesales .popup.pop-win03 .tit {width:535px; margin:0 0 55px 139px;}
.timesales .popup.pop-win03 .prev-day {width:100%; height:50px; line-height:50px; font-size:27px; color:#222; text-align:center; background:linear-gradient(91.82deg, rgba(0, 194, 255, 0.39) 5.9%, rgba(204, 255, 89, 0.7) 93.65%); font-weight:700;}
.timesales .popup.pop-win03 .prev-day.next-day {margin-top:80px; background:#D9D9D9;}
.timesales .popup.pop-win03 .txt-noti {padding-top:45px; font-size:24px; font-weight:600; color:#222; text-align:center;}
.timesales .popup.pop-win03 .pop-inner {padding:34px 60px;}

/* 2022-03-25 추가 */
.timesales .bnr-zone {position:absolute; right:16px; bottom:270px;}
.timesales .bnr-zone a {display:inline-block; width:250px; height:250px;}
.timesales .bnr-zone .link-wrap {position:relative;}
.timesales .bnr-zone .link-wrap .link01 {position:absolute; left:0; top:32px;}
.timesales .bnr-zone .link-wrap .link02 {position:absolute; right:0; top:32px;}
</style>
<style>
    [v-cloak] { display: none; }
</style>
</head>

<body>
    <div v-cloak id="app"></div>

    <script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js" ></script>
    <script type="text/javascript">
        const isUserLoginOK = "<%= IsUserLoginOK %>";
        const loginUserLevel = "<%= GetLoginUserLevel %>";
        const loginUserID = "<%= GetLoginUserID %>";
        const server_info = "<%= application("Svr_Info") %>";

        function goProduct(itemid) {
            parent.location.href='/shopping/category_prd.asp?itemid='+itemid;
            return false;
        }
    </script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.10.4/polyfill.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>

    <script src="/vue/common/common.js?v=1.00"></script>
    <script src="/vue/components/common/functions/common.js?v=1.00"></script>
    <script type="text/babel" src="/vue/common/mixins/common_mixins.js?v=1.00"></script>
    <script type="text/javascript" src="/event/etc/json/js_applyItemInfo_timesale_raffle.js?v=1.00"></script>
    <script type="text/javascript" src="/vue/event/timesale/raffle/countdown.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.7.1/clipboard.min.js"></script>

    <script type="text/babel" src="/vue/event/timesale/raffle/store.js?v=1.00"></script>
    <script type="text/babel" src="/vue/event/timesale/raffle/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->