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
.evt117931 section{position:relative;}
.evt117931 a:hover{text-decoration: none;}

.evt117931 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/117931/section01.jpg)no-repeat 50% 0;width:100%;height:1633px;}
.evt117931 .section01 .title01{position:absolute;top:114px;left:50%;margin-left:-218px;}
.evt117931 .section01 .present{position:absolute;top:358px;left:50%;margin-left:-184px;}
.evt117931 .section01 .deco01{position:absolute;top:425px;left:50%;margin-left:-315px;}
.evt117931 .section01 .deco02{position:absolute;top:380px;left:50%;margin-left:150px;}
.evt117931 .section01 .deco03{position:absolute;top:330px;left:50%;margin-left:-250px;}
.evt117931 .section01 .deco04{position:absolute;top:400px;left:50%;margin-left:-210px;}
.evt117931 .section01 .overwrap{position:absolute;top:495px;left:50%;margin-left:-520px;}
.evt117931 .section01 .overwrap p{font-size:40px;font-weight:700;color:#fff;}
.evt117931 .section01 .overwrap .sale{position:absolute;bottom:25px;left:50%;margin-left:270px;}
.evt117931 .section01 .overwrap .coupon{position:absolute;bottom:80px;left:50%;margin-left:380px;}

.evt117931 section .mySwiper{width:1140px;position:absolute;bottom:135px;left:50%;margin-left:-570px;border-radius:50px;}
.evt117931 section .mySwiper .swiper-pagination{width:100%;height:15px;position:absolute;bottom:-30px;}
.evt117931 section .mySwiper .swiper-pagination .swiper-pagination-bullet{background:rgba(255,255,255,0.8);width:10px;height:10px;border-radius:50%;}
.evt117931 section .mySwiper .swiper-pagination .swiper-pagination-bullet-active{background:#fff;}

.evt117931 section .prd_wrap{width:1140px;margin:0 auto;padding:110px 0;}
.evt117931 section .prd_wrap ul{display:flex;justify-content:space-evenly;flex-wrap:wrap;}
.evt117931 section .prd_wrap ul li{width:230px;text-align: left;margin-bottom:50px;}
.evt117931 section .prd_wrap ul li .thumbnail{width:230px;height:230px;background:#ddd;border-radius: 25px;margin-bottom:20px;}
.evt117931 section .prd_wrap ul li .thumbnail img{width:100%;border-radius: 25px;}
.evt117931 section .prd_wrap ul li .desc .brand{font-size:10px;margin-bottom:5px;}
.evt117931 section .prd_wrap ul li .desc .name{font-size:14px;font-weight:500;margin-bottom:15px;}
.evt117931 section .prd_wrap ul li .desc .price{font-size:16px;font-weight:600;line-height:26px;}
.evt117931 section .prd_wrap ul li .desc .price s{display:block;text-decoration:none;color:#a0a79b;}
.evt117931 section .prd_wrap ul li .desc .price .sale{float:left;margin-right:5px;color:#ff1461;}

.evt117931 .section02{background:url(//webimage.10x10.co.kr/fixevent/event/2022/117931/section02.jpg)no-repeat 50% 0;width:100%;height:1200px;}

.evt117931 .section03{background:url(//webimage.10x10.co.kr/fixevent/event/2022/117931/section03.jpg)no-repeat 50% 0;width:100%;height:773px;}
.evt117931 .section03 .prd_wrap{padding-top:305px;}
.evt117931 .section03 .prd_wrap ul li .desc{color:#fff;}
.evt117931 .section03 .prd_wrap ul li .desc .price s{color:#79009b;font-weight:500;}
.evt117931 .section03 .prd_wrap ul li .desc .price .sale{color:#ffe400;}

.evt117931 .section04{background:url(//webimage.10x10.co.kr/fixevent/event/2022/117931/section04.jpg)no-repeat 50% 0;width:100%;height:1285px;}
.evt117931 .section05{background:#fdf1de;}
.evt117931 .section06{background:url(//webimage.10x10.co.kr/fixevent/event/2022/117931/section05.jpg)no-repeat 50% 0;width:100%;height:1346px;}
.evt117931 .section07{background:#edf3ff;}
.evt117931 .section08{background:url(//webimage.10x10.co.kr/fixevent/event/2022/117931/section06.jpg)no-repeat 50% 0;width:100%;height:1246px;}
.evt117931 .section09{background:#eaf5df;}
.evt117931 .section10{background:url(//webimage.10x10.co.kr/fixevent/event/2022/117931/section07.jpg)no-repeat 50% 0;width:100%;height:1267px;}
.evt117931 .section11{background:#ffe6f0;}
.evt117931 .section12{background:url(//webimage.10x10.co.kr/fixevent/event/2022/117931/section08.jpg)no-repeat 50% 0;width:100%;height:1270px;}
.evt117931 .section13{background:#ffe2da;}

.evt117931 .section14{background:url(//webimage.10x10.co.kr/fixevent/event/2022/117931/section09.jpg)no-repeat 50% 0;width:100%;height:877px;}
.evt117931 .section14 .evt_wrap{display:flex;width:1140px;margin:0 auto;flex-wrap:wrap;padding-top:221px;}
.evt117931 .section14 .evt_wrap a{width:50%;height:300px;display:block;}

.category-wrap {position:relative; padding:0px 0 80px; background:#ff64a1;}
.category-wrap h3 {padding:86px 0 45px; text-align:center;}
.category-wrap .type {position:relative; margin-bottom:66px;}
.category-wrap .type ul {display:flex; justify-content:center;}
.category-wrap .type li {position:relative;}
.category-wrap .type li + li {margin-left:15px;}
.category-wrap .type li input {visibility:hidden; position:absolute; left:0; top:0; width:0; height:0;}
.category-wrap .type li label {position:relative; display:flex; flex-direction:column; justify-content:center; align-items:center; width:133px; height:133px; font-weight:300; text-align:center; cursor:pointer; background:#ff3372; border-radius:67px;}
.category-wrap .type li label span {display:block; padding-top:3px; font-size:14px; color:rgba(255,255,255,.5); text-transform:uppercase; letter-spacing:1px;}
.category-wrap .type li label strong {display:block; font-weight:300; font-size:19px; letter-spacing:-.5px; color:#fff;}
.category-wrap .type li input:checked + label {box-shadow:0 7px 10px 0 rgba(0,0,0,.15);}
.category-wrap .type li input:checked + label:after {content:' '; position:absolute; top:0px; left:0px; width:133px; height:133px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/family2020/ico_chk.png) no-repeat 50%; animation:typeRotate 5s infinite;}
@keyframes typeRotate {
	100% {transform:rotate(360deg);}
}
.category-wrap .item-box {position:relative; left:50%; width:1120px; margin-left:-755px; padding:50px 195px; background-color:#fff2e0; border-radius:40px; box-shadow:0 10px 20px 0 rgba(0,0,0,.2);}
.evt117931 .category-wrap .prd_wrap{padding:0;}
.evt117931 .category-wrap .prd_wrap ul li .thumbnail{width:230px;height:230px;background:#ddd;border-radius: 25px;margin-bottom:20px;}
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

        function goEventLink(evt) {
            parent.location.href='/event/eventmain.asp?eventid='+evt;
        }
    </script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.10.4/polyfill.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>

    <link
      rel="stylesheet"
      href="https://unpkg.com/swiper@8/swiper-bundle.min.css"
    />
    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

    <script src="/vue/common/common.js?v=1.00"></script>
    <script src="/vue/components/common/functions/common.js?v=1.00"></script>

    <script src="/vue/event/family/js_applyItemInfo.js?v=1.00"></script>
    <script type="text/babel" src="/vue/event/family/store.js?v=1.00"></script>
    <script type="text/babel" src="/vue/event/family/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->