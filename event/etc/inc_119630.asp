<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">

<style type="text/css">
    html {scroll-behavior:smooth}
    .evt119630 {background:#fff;}
    .evt119630 .sec-wrap {max-width:1920px; margin:0 auto;}
    .evt119630 .txt-hidden {font-size:0; text-indent:-9999px;}
    .evt119630 a {display:inline-block; width:100%; height:100%; text-decoration:none;}
    .evt119630 .w1140 {width:1140px; height:100%; margin:0 auto;}
    .evt119630 .section01 {position:relative; width:100%; height:2157px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/main.jpg) no-repeat 50% 0;}
    .evt119630 .section01 .btn-alram {position:absolute; left:50%; bottom:150px; transform:translateX(-50%); width:730px; height:230px; background:transparent;}
    .evt119630 .section02 {position:relative; width:100%; height:613px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/sub01.jpg) no-repeat 50% 0;}
    .evt119630 .section02 .link-area {display:flex; justify-content:center; padding-top:220px;}
    .evt119630 .section02 .link-area li {width:245px; height:283px;}
    .evt119630 .section03 {position:relative; width:100%; height:2362px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/sub02.jpg) no-repeat 50% 0;}
    .evt119630 .section03 .link-brand {display:flex; flex-wrap:wrap; justify-content:space-between; width:1140px; margin:0 auto; padding-top:396px;}
    .evt119630 .section03 .link-brand li {width:524px; height:556px; margin-bottom:80px;}
    .evt119630 .section04 {position:relative;}
    .evt119630 .section04 .tit {width:100%; height:431px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/tit_time.jpg) no-repeat 50% 0;}
    .evt119630 .section04 .time-prd {width:100%; height:574px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/img_prd_item01.jpg) no-repeat 50% 0;}
    .evt119630 .section04 .time-prd.time02 {background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/img_prd_item02.jpg) no-repeat 50% 0;}
    .evt119630 .section04 .time-prd.time03 {background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/img_prd_item03.jpg) no-repeat 50% 0;}
    .evt119630 .section04 .time-prd.time04 {background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/img_prd_item03.jpg) no-repeat 50% 0;}
    .evt119630 .section04 .time-counting {position:absolute; left:50%; top:445px; transform:translateX(9%); font-size:115px; font-weight:700; color:#fff;}
    .evt119630 .section05 {position:relative; width:100%; height:2304px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/img_brand.jpg) no-repeat 50% 0;}
    .evt119630 .section05.update {background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/img_brand02.jpg) no-repeat 50% 0;}
    .evt119630 .section05 ul {display:flex; flex-wrap:wrap; width:100%; padding-top:395px;}
    .evt119630 .section05 ul li {width:285px; height:600px;}
    .evt119630 .section06 {background:#fff;}
    .evt119630 .section06 .tit {width:100%; height:379px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/119630/tit_recommend.jpg) no-repeat 50% 0;}
    .evt119630 .recommend-swiper .swiper-slide {width:50%;}
    .evt119630 .recommend-swiper .swiper-wrapper {display:flex; height:65px!important;}
    .evt119630 .recommend-swiper button {width:100%; height:65px; background:#ff5a00; font-size:18px; font-weight:700; color:#fff;}
    .evt119630 .recommend-swiper button span {position:relative;}
    .evt119630 .recommend-swiper button.active span::before {content:""; position:absolute; right:0; top:-11px; width:4px; height:4px; background:#fff; border-radius:100%;}
    .evt119630 .item-recommend ul {display:flex; flex-wrap:wrap; margin-top:70px;}
    .evt119630 .item-recommend ul li {margin:0 19.5px 40px; flex:1;}
    .evt119630 .item-recommend .thumbnail {width:246px; height:246px; overflow:hidden; background:#ddd;}
    .evt119630 .item-recommend .thumbnail img {width:100%;}
    .evt119630 .item-recommend .name {margin-top: 8px;font-size: 14px;color: #111;font-weight: 400;text-align: left;overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;}
    .evt119630 .item-recommend .price {font-weight: 600;font-size: 18px;color: #111;letter-spacing: -0.05em; text-align:left;}
    .evt119630 .item-recommend .price s {padding-right:8px; font-weight:400; font-size:16px; color:#999;}
    .evt119630 .item-recommend .price span {padding-left:8px; color:#ff4c4c;}
    .evt119630 .recommend-swiper.fixed {position:fixed; left:0; top:0; z-index:100;}
    .evt119630 .prdtitswiper {padding:1.77rem 0 1.77rem 0; background:#FC335E;}
    .evt119630 .prdtitswiper .swiper-slide {width:auto;}
    .evt119630 .prdtitswiper .swiper-slide span {color:#FFCBD6; font-size:1.37rem; font-family:'CoreSansCRegular', 'AppleSDGothicNeo-Medium', 'NotoSansKRMedium';}
    .evt119630 .prdtitswiper .swiper-slide.active span {position:relative; color:#fff; font-size:1.37rem; font-family:'CoreSansCBold', 'AppleSDGothicNeo-Bold', 'NotoSansKRBold';}
    .evt119630 .prdtitswiper .swiper-slide.active span::before {content:''; position:absolute; right:-0.5rem; top:0; display:inline-block; width:0.34rem; height:0.34rem; background:#fff; border-radius:100%;}
    .evt119630 .prdlistswiper {padding:0.68rem 0.81rem 0.68rem 1.45rem; background:#fff;}
    .evt119630 .prdlistswiper .swiper-slide {width:auto; margin-right:0.64rem;}
    .evt119630 .prdlistswiper .swiper-slide span {display:inline-block; height:2.69rem; padding:0 1.07rem; cursor: pointer; line-height:2.89rem; border:0.09rem solid #EBEBEB; border-radius:50px; color:#7A7A7A; font-size:1.28rem; font-family:'CoreSansCBold', 'AppleSDGothicNeo-Bold', 'NotoSansKRBold';}
    .evt119630 .prdlistswiper .swiper-slide.active span {color:#fff; background:#FC335E; border-color:#FC335E;}
    .evt119630 .category-list {display:none;}
    .evt119630 .category-list.active {display:block;}
    .evt119630 .tab-category {width:1140px; height:65px; margin:0 auto; overflow:hidden;}
</style>
<style>
    [v-cloak] { display: none; }
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

    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>

    <script src="/vue/common/common.js?v=1.00"></script>
    <script src="/vue/components/common/functions/common.js?v=1.00"></script>
    <script src="/vue/components/common/functions/event_common.js?v=1.0"></script>

    <script src="/vue/event/family/js_applyItemInfo.js?v=1.00"></script>
    <script type="text/javascript" src="/event/lib/countdown24.js"></script>
    <script src="/vue/event/etc/119630/store.js?v=1.00"></script>
    <script src="/vue/event/etc/119630/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->