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
.evt111787 {max-width:1920px; margin:0 auto; background:#fff;}
.evt111787 button {background-color:transparent;}
.evt111787 .topic {position:relative; width:100%; height:649px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/120264/img_main.jpg?v=2) no-repeat 50% 0;}/* 09-22 수정 */
.evt111787 .topic .main-top {position:relative; width:1140px; height:649px; margin:0 auto;}
.evt111787 .topic .main-top .show-time-current {position:absolute; right:28px; top:240px;}/* 09-22 수정 */
.evt111787 .topic .main-top .show-time-current .time-current-wrap {display:flex;}
.evt111787 .topic .main-top .show-time-current .time-current-wrap div {position:relative; margin:0 20px;}/* 09-22 수정 */
.evt111787 .topic .main-top .show-time-current .time-current-wrap div.end:before {content:""; position:absolute; left:50%; top:64%; transform:translate(-50%,-50%); display:inline-block; width:126px; height:3px; background:#c25513;}/* 09-22 추가 */
.evt111787 .topic .main-top .sale-timer {position:absolute; bottom:125px; left:30px; color:#fff; font-size:99px; font-weight:700;}
.evt111787 .topic .main-top .tit-ready {position:absolute; left:30px; bottom:251px;}
.evt111787 .topic .main-top .tit-ready h2 {color:#fff; font-size:30px; font-weight:500;}
.evt111787 .topic .main-top .img-beg {position:absolute; right:5px; top:30px; width:150px; height:130px;} /* 10-04 수정 */
.evt111787 .topic .main-top .img-beg img {width:100%;} /* 10-04 추가 */

.evt111787 .special-list-wrap {width:100%; height:580px;}
.evt111787 .special-list-wrap .special-item {position:relative; width:1140px; height:580px; margin:0 auto;}
.evt111787 .special-list-wrap .special-item .list {position:absolute; left:105px; top:-40px;}
.evt111787 .special-list-wrap .special-item a {display:inline-block; text-decoration:none;}

.evt111787 .special-list-wrap .special-item li.sold-out .product-inner .thum {position:relative;}
.evt111787 .special-list-wrap .special-item li.sold-out .product-inner .thum:before {content:""; position:absolute; left:0; top:0; display:inline-block; width:100%; height:100%; background-color:rgb(243, 243, 243); opacity:0.6; z-index:10;}
.evt111787 .special-list-wrap .special-item li.sold-out .product-inner .thum:after {content:""; position:absolute; left:50%; top:160px; display:inline-block; width:149px; height:149px; transform:translate(-50%,0); z-index:20; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110064/txt_sold_out.png)no-repeat; background-size:100%;}
.evt111787 .special-list-wrap .special-item li.sold-out .go-link a {cursor:not-allowed; pointer-events:none;}

.evt111787 .special-list-wrap .special-item li.not-open .product-inner .thum {position:relative;}
.evt111787 .special-list-wrap .special-item li.not-open .product-inner .thum:before {content:""; position:absolute; left:0; top:0; display:inline-block; width:100%; height:100%; background-color:rgb(243, 243, 243); opacity:0.6; z-index:10;}
.evt111787 .special-list-wrap .special-item li.not-open .product-inner .thum:after {content:""; position:absolute; left:50%; top:160px; display:inline-block; width:149px; height:149px; transform:translate(-50%,0); z-index:20; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110064/m/txt_not_open.png)no-repeat; background-size:100%;}
.evt111787 .special-list-wrap .special-item li.not-open .go-link a {cursor:not-allowed; pointer-events:none;}

.evt111787 .special-list-wrap .special-item li .product-inner .thum img{width:600px;}/* 2021.06.14 손지수 추가 */

.evt111787 .special-list-wrap .special-item .desc {position:relative; width:calc(100% - 750px); margin-left:30px; margin-top:170px;}
/* 2021-04-01 수정 */
.evt111787 .special-list-wrap .special-item .desc .name {width:100%; height:62px; overflow:hidden; font-size:27px; line-height:1.2; color:#111; font-weight:500; text-overflow:ellipsis; text-align:left;}
.evt111787 .special-list-wrap .special-item .desc .price {display:flex; align-items:baseline; position:absolute; left:0; top:95px; font-size:40px; font-weight:700; color:#111;}
/* // */
.evt111787 .special-list-wrap .special-item .desc .price s {position:absolute; left:0; top:-15px; font-size:25px; font-weight:400; color:#888;}
.evt111787 .special-list-wrap .special-item .desc .price span {display:inline-block; margin-left:20px; color:#ff0943; font-size:50px;}
.evt111787 .special-list-wrap .special-item .desc .price .p-won {margin-left:10px; font-size:25px; font-weight:500; color:#111;}
.evt111787 .special-list-wrap .special-item .product-inner {position:relative; display:flex; align-items:flex-start; width:1050px;}
.evt111787 .special-list-wrap .special-item .product-inner .num-limite {display:inline-block; position:absolute; top:-11px; left:-28px; z-index:11; width:166px; height:51px; line-height:51px; font-size:21px; font-weight:700; color:#fff; text-align:center; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/img_limit_sold.png?v=2.1) no-repeat 50% 50%/100%; }
.evt111787 .special-list-wrap .special-item .product-inner .num-limite em {font-size:25px;}
.evt111787 .special-list-wrap .special-item .go-link {position:absolute; right:215px; bottom:30px;}
.evt111787 .special-list-wrap .special-item .txt-noti {position:absolute; left:220px; bottom:90px; font-size:15px; color:#9c9c9c; font-weight:500;}

.evt111787 .md-list{background:#fafafa;padding:132px 0;}
.evt111787 .md-list-wrap {width:1140px; margin:0 auto;}
.evt111787 .md-list-wrap #itemList {display:flex; flex-wrap:wrap; justify-content:space-between;margin: 0 100px;width:calc(100% - 200px);}
.evt111787 .md-list-wrap #itemList li {width:calc(50% - 20px); }
.evt111787 .md-list-wrap #itemList li:nth-child(even){padding-left:20px;}
.evt111787 .md-list-wrap #itemList li a {text-decoration:none;}
.evt111787 .md-list-wrap .desc {position:relative; height:190px; margin-top:30px;margin-left:10px;} /* 06-04 수정 */
.evt111787 .md-list-wrap .thumbnail {position:relative; width:450px; height:450px; background-color:#f4f4f4;}
.evt111787 .md-list-wrap .thumbnail:before {content:''; position: absolute; top: 50%; left: 50%; width: 4.27rem; height: 4.27rem; margin: -2.22rem 0 0 -2.22rem; background: url(http://fiximage.10x10.co.kr/m/2017/common/bg_img_loading.png) 50% 0 no-repeat; background-size: 100% auto;}
.evt111787 .md-list-wrap .thumbnail img {position:relative; width:100%; z-index:2;}
.evt111787 .md-list-wrap .thumbnail .num-limite{display:inline-block; position:absolute; bottom:-15px; left:0; z-index:11; width:115px; height:38px; line-height:38px; font-size:20px; color:#fff; text-align:center; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/img_limit_num.png?v=5) no-repeat 50% 50%/100%;}
.evt111787 .md-list-wrap .thumbnail .num-limite em {font-size:20px;}
/* md상품 영역 수정 */
/* 1줄일 때 */
.evt111787 .md-list-wrap .desc.line_01 .name {height:40px; overflow:hidden; font-size:24px; line-height:1.3; color:#111; font-weight:500; text-align:left;} /* 03-26 수정 */
.evt111787 .md-list-wrap .desc.line_01 .price {position:absolute; left:0; top:65px; font-size:28px; font-weight:700; color:#111;} /* 03-26 수정 */
.evt111787 .md-list-wrap .desc.line_01 .price s {position:absolute; left:0; top:-20px; font-size:21px; color:#888; font-weight:400;}
.evt111787 .md-list-wrap .desc.line_01 .price span {display:inline-block; margin-left:1.1rem; font-size:33px; color:#ff0943; font-weight:700;}
/* 2줄일 때 */
.evt111787 .md-list-wrap .desc.line_02 .name {height:60px; overflow:hidden; font-size:24px; line-height:1.3; color:#111; font-weight:500; text-align:left;} /* 03-26 수정 */
.evt111787 .md-list-wrap .desc.line_02 .price {position:absolute; left:0; top:95px; font-size:28px; font-weight:700; color:#111;} /* 03-26 수정 */
.evt111787 .md-list-wrap .desc.line_02 .price s {position:absolute; left:0; top:-20px; font-size:21px; color:#888; font-weight:400;}
.evt111787 .md-list-wrap .desc.line_02 .price span {display:inline-block; margin-left:1.1rem; font-size:33px; color:#ff0943; font-weight:700;}
/* // md상품 영역 수정 */

.evt111787 .teaser-timer {width:100%; height:440px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/120264/img_left_time02.jpg?v=2) no-repeat 50% 0;}/* 09-22 수정 */
.evt111787 .teaser-timer .timer-inner {position:relative; width:1140px; height:440px; margin:0 auto;}
.evt111787 .teaser-timer .sale-timer {position:absolute; bottom:16%; left:5.5%; color:#fff; font-size:75px; font-weight:700;}
.evt111787 .teaser-timer .btn-push {width:21.74rem; height:6.08rem; position:absolute; right:0; bottom:18%; background:transparent;}

.evt111787 .product-list-wrap {padding-bottom:100px; background:#effffb;} /* 10-07 수정 */
.evt111787 .product-list {width:1020px; margin:0 auto; background:#effffb;}
/* 10-07 수정 */
.evt111787 .product-list .list {display:flex; justify-content:center; flex-wrap:nowrap;}
.evt111787 .product-list .list li {width:349px;}
.evt111787 .product-list .list li:nth-child(2) {margin:0 45px;}
.evt111787 .product-list .product-inner {position:relative;width: 349px;height: 373px;}
.evt111787 .product-list .product-inner img {width: 349px;height: 373px;}
/* // */
/* 잠시 후 오픈 이미지->텍스트 수정 2021.06.09 손지수 */
.evt111787 .product-list .open-time{position:relative;width:466px;height:52px;text-align:left;font-size:34px;color:#000;letter-spacing:-0.15rem;padding-left:15px;padding-top:18px;line-height:38px;z-index:0;}
.evt111787 .product-list .open-time::after{position:absolute;top:0;left:0;content:'';width:45px;height:45px;border-radius:50%;background-color:#a8ff00;z-index:-1;}
.evt111787 .product-list .open-time span{font-weight:bold;font-size:38px}
/* // 잠시 후 오픈 이미지->텍스트 수정 2021.06.09 손지수 */
.evt111787 .product-list .product-inner .num-limite {position:absolute; top:-14px; right:0; z-index:10; width:140px; height:37px; font-size:21px; font-weight:700; color:#fff; text-align:center; line-height:42px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/img_limit_sold.png) no-repeat 0 0; background-size:100%; content:'';}
.evt111787 .product-list .product-inner .num-limite em {padding-left:10px; font-size:25px;}

.evt111787 .product-list .desc .name {position:absolute; left:1.73rem; top:19.5rem; width:90%; overflow:hidden; font-size:23px; line-height:1.2; color:#111; font-weight:500; white-space:nowrap; text-overflow:ellipsis; text-align:left;}
.evt111787 .product-list .desc .price {display:flex; align-items:baseline; position:absolute; left:1.73rem; top:24rem; font-size:33px; font-weight:700; color:#111;}
.evt111787 .product-list .desc .price s {position:absolute; left:0; top:-1.5rem; font-size:23px; font-weight:400; color:#888;}
.evt111787 .product-list .desc .price span {display:inline-block; margin-left:1.1rem; color:#ff0943; font-size:40px;}
.evt111787 .product-list .desc .price .p-won {font-size:21px; color:#111; margin:0 0 7px 1px;}

/* 쿠폰영역 생성 */
.evt111787 .coupon-area{width:100%;height:795px;background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/coupon.jpg?v=2) no-repeat 50% 0; position: relative;}
.evt111787 .coupon-area a.go-coupon{width:327px;height:83px;display:block;position:absolute;top:627px;left:50%;margin-left:-163.5px;}
/* // 쿠폰영역 생성 */

.sold-out-wrap {position:relative; height:763px; background:#f4f4f4;}
.sold-out-wrap .sold-out-list {width:1140px; position:absolute; left:50%; top:258px; transform:translate(-37.5%, 0);} /* 10-07 수정 */
.sold-out-wrap .sold-out-list .slide-area .list {display:flex;}
.sold-out-wrap .swiper-button-prev {position:absolute; left:-2px; top:0;width:62px; height:440px; background:#f4f4f4; cursor:pointer;}
.sold-out-wrap .swiper-button-prev:before {content:""; position:absolute; left:2px; top:117px; display:inline-block; width:22px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/icon_arrow.png) no-repeat 0 0; background-size:100%;}
.sold-out-wrap .sold-out-list .sold-prd {position:relative; display:flex; width:270px!important; height:440px; margin-right:45px;} /* 10-07 수정 */
.sold-out-wrap .sold-out-list .sold-prd:last-child {margin-right:0;} /* 10-07 추가 */
.sold-out-wrap .sold-out-list .sold-prd .thum {position:relative; width:270px;}
.sold-out-wrap .sold-out-list .sold-prd .tit-prd {width:inherit;}
.sold-out-wrap .sold-out-list .desc {position:relative; width:270px; padding-bottom:75px; margin:0.5rem 0 0 0.5rem;}
.sold-out-wrap .sold-out-list .desc .name {overflow:hidden; font-size:23px; line-height:1.2; color:#636363; font-weight:400; white-space:nowrap; text-overflow:ellipsis; text-align:left;}
.sold-out-wrap .sold-out-list .desc .price {display:flex; align-items:flex-end; position:absolute; left:0; top:45px; display:flex; margin-top:12px; font-size:28px; color:#6a6a6a; font-weight:700; opacity:0;}
.sold-out-wrap .sold-out-list .desc .price s {position:absolute; left:0; top:-1.3rem; font-size:20px; color:#888; font-weight:400;}
.sold-out-wrap .sold-out-list .desc .price span {display:inline-block; margin-left:10px; color:#000; font-size:28px;}
.sold-out-wrap .sold-out-list .desc .price .p-won {font-size:20px; font-weight:500; color:#6a6a6a; margin:0 0 4px 1px;}
.sold-out-wrap .sold-out-list .sold-prd.sold-out .price {opacity:1;}
.sold-out-wrap .sold-out-list .sold-prd.sold-out .thum:before {content:""; position:absolute; left:0; top:0; display:inline-block; width:270px; height:284px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110064/img_dim_sold.png?v=3) no-repeat 0 0; background-size:100%;}
/* 2021.06.15 손지수 수정 */
.sold-out-wrap .sold-out-list li .sold-time{display:none;}
.sold-out-wrap .sold-out-list li.sold-out .sold-time{display:block;position:absolute; left:19px; top:245px; display:inline-block; font-size:23px; color:#fff; font-weight:500;} /* 2021.6.15 손지수 추가 */
/* // 2021.06.15 손지수 수정 */
/* .sold-out-wrap .sold-out-list li.sold-out .thum:after {position:absolute; left:19px; top:245px; display:inline-block; font-size:23px; color:#fff; font-weight:500;} */
/*.sold-out-wrap .sold-out-list li:nth-child(1).sold-out .thum:after {content:"오전 9시";}
.sold-out-wrap .sold-out-list li:nth-child(2).sold-out .thum:after {content:"오전 12시"; left:15px;}
.sold-out-wrap .sold-out-list li:nth-child(3).sold-out .thum:after {content:"오후 3시"; left:15px;}
.sold-out-wrap .sold-out-list li:nth-child(4).sold-out .thum:after {content:"오후 6시"; left:15px;}*/

.evt111787 .pop-container .input-box {position:absolute; left:105px; top:70%; display:flex; justify-content:space-between; align-items:center; width:54%;}
.evt111787 .pop-container .input-box input {width:100%; height:51px; padding:0; background-color:transparent; border:0; border-bottom:solid 3px #acfe25; border-radius:0; color:#fff; font-size:27px; text-align:left;}
.evt111787 .pop-container .input-box .btn-submit {width:65px; height:54px; margin-left:-1px; color:#acfe25; border-bottom:solid 3px #acfe25; font-size:21px; background:transparent;}
.evt111787 .pop-container .input-box input::placeholder {font-size:21px; color:#b7b7b7; text-align:left;}
.evt111787 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
.evt111787 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
.evt111787 .pop-container .pop-inner a {display:inline-block;}
.evt111787 .pop-container .pop-inner .btn-close {position:absolute; right:66px; top:55px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111786/icon_close.png?v=2) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
.evt111787 .pop-container.push .contents-inner {position:relative; width:663px; height:765px; margin:0 auto;}

.noti-area {max-width:1920px; margin:0 auto; background:#262626;}
.noti-area .noti-header .btn-noti {position:relative; width:1140px; margin:0 auto;}
.noti-area .noti-header .btn-noti span {display:inline-block; position:absolute; left:50%; top:80px; transform:translate(610%,0);}
.noti-area .noti-header .btn-noti.on span img {transform:rotate(180deg);}
.noti-area .noti-info {display:none; width:1140px; margin:0 auto;}
.noti-area .noti-info.on {display:block;}
</style>
</head>
<body>
    <div id="app"></div>

    <script type="text/javascript">
        const isUserLoginOK = "<%= IsUserLoginOK %>";
        const loginUserLevel = "<%= GetLoginUserLevel %>";
        const loginUserID = "<%= GetLoginUserID %>";

        $(document).ready(function (){
            setTimeout(setSwiper, 2000);
        });

        function setSwiper(){
            let swiper = new Swiper('.sold-out-list .swiper-container', {
                speed: 500,
                slidesPerView:5,
                spaceBetween:20,
                loop:false
            });

            $('.swiper-button-prev').on('click', function(e){ //왼쪽 네비게이션 버튼 클릭
                e.preventDefault()
                swiper.swipeNext()
            });
        }
        function goProduct(itemid) {
            parent.location.href='/shopping/category_prd.asp?itemid='+itemid;
            return false;
        }
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
    <script src="/vue/common/mixins/common_mixins.js?v=1.00"></script>
    <script type="text/javascript" src="/event/etc/json/js_applyItemInfo_110063.js?v=1.00"></script>
    <script type="text/javascript" src="/event/lib/countdown.js"></script>

    <script src="/vue/event/timesale/store.js?v=1.01"></script>
    <script src="/vue/event/timesale/index.js?v=1.03"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->