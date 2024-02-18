<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">

<style>
    [v-cloak] { display: none; }
</style>
<style>
.evt118419 .section{position:relative;}
li{list-style:none;}
.evt118419 a{display:block; width:100%; height:100%;}

/* section01 */
.evt118419 .section01{height:1258px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/section01.jpg?v=1.2) no-repeat 50% 0;}
.evt118419 .section01 .txt{position:absolute; width:502px; height:240px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/txt01.png?v=1.1); background-repeat:no-repeat; background-position:center; background-size:contain; left:50%; margin-left:-251px; top:523px;}

/* section02 */
.evt118419 .section02_01{height:347px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/section02_01.jpg) no-repeat 50% 0;}
.evt118419 .section02_02{height:365px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/section02_02.jpg?v=1.3) no-repeat 50% 0; margin-top:291px;}
.evt118419 .coupon_slide{width:1140px; height:291px; background:#64c9f7; position:absolute; left:50%; margin-left:-570px; text-align:center;}
.evt118419 .coupon_slide .slide_wrap{width:500px; position:absolute; left:50%; transform:translateX(-50%);}
.evt118419 .coupon_slide .slide_wrap img{width:373px; margin:auto; padding-left:56px;}
.evt118419 .coupon_slide .slick-prev{width:20px; height:63px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/arrow_left.png) no-repeat; top:105px; left:-48px;}
.evt118419 .coupon_slide .slick-next{width:20px; height:63px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/arrow_right.png) no-repeat; top:105px; right:-48px;}
.evt118419 .coupon_slide .slick-dots{width:99px; height:13px; left:50%; margin-left:-49.5px; display:flex; justify-content:space-between; position:absolute; bottom:-61px;}
.evt118419 .coupon_slide .slick-dots li{width:13px; height:13px; border-radius:50%; background:#b2e7ff; cursor:pointer;}
.evt118419 .coupon_slide .slick-dots li.slick-active{background:#fff;}
.evt118419 .section02_02 .sect02_btn{position:absolute; width:413px; height:97px; left:50%; margin-left:-206.5px; bottom:200px;}
.evt118419 .section02 .btn_alert{position:absolute; width:128px; height:128px; left:50%; top:30px; margin-left:410px;}
.evt118419 .section02 .btn_alert.fixed{position:fixed; z-index:2;}

/* section03 */
.evt118419 .section03_01{height:615px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/section03.jpg) no-repeat 50% 0;}
.evt118419 .section03_02{height:1030px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/section03_02.jpg?v=1.1) no-repeat 50% 0;}
.evt118419 .section03_02 .sect03_btn{position:absolute; width:413px; height:97px; left:50%; margin-left:-206.5px; bottom:120px;}

/* section04 */
.evt118419 .section04_01{height:613px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/section04.jpg?v=1.1) no-repeat 50% 0;}
.evt118419 .section04_02{height:2488px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/section04_02.jpg?v=1.2) no-repeat 50% 0;}
.evt118419 .section04_02 .sect04_btn{position:absolute; width:413px; height:97px; left:50%; margin-left:-206.5px; top:949px;}
.evt118419 .section04_02 .sect04_btn02{position:absolute; width:413px; height:97px; left:50%; margin-left:-206.5px; bottom:129px;}

/* section05 */
.evt118419 .section05{height:1011px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118419/section05.jpg) no-repeat 50% 0;}
.evt118419 .section05 .sect05_btn{position:absolute; width:413px; height:97px; left:50%; margin-left:-206.5px; bottom:120px;}

/* popup */
.evt118419 .popup{display:none;}
.evt118419 .popup .bg_dim{position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,0.6); z-index:51;}
.evt118419 .popup .pop{position:fixed; top:50%; left:50%; margin-left:-435.5px; z-index:52; transform:translateY(-50%); width:871px;}
.evt118419 .popup .pop .btn_close{width:70px; height:70px; display:block; position:absolute; top:0; right:0;}
.evt118419 .popup .pop .btn_alert{width:430px; height:97px; display:block; position:absolute; top:409px; left:50%; margin-left:-215px;}

</style>
</head>

<body>
    <div v-cloak id="app"></div>
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
        let _jquery_this = $(this);
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
    <script src="/vue/components/common/functions/event_common.js?v=1.0"></script>

    <script type="text/babel" src="/vue/event/etc/118419/store.js?v=1.00"></script>
    <script type="text/babel" src="/vue/event/etc/118419/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->