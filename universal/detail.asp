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
.tMar15 {margin-top:0;}
.w1060 {width:1060px; margin:0 auto;}
.w1140 {width:1140px; margin:0 auto;}
.w1300 {width:1300px; margin:0 auto;}
.relative {position:relative;}	
.uni-footer {width:100%; max-width:1920px; height:100px; margin:0 auto; display:flex; align-items:center; justify-content:center; margin-top:90px; background:#111; text-align:center;}
.univarsal {background:#fff;}
.menu-swiper {display:flex; align-items:center; justify-content:space-between; height:39px; padding:15px 0 6px;}
.menu-swiper .swiper-slide {width:auto; margin-left:32px;}
.menu-swiper .swiper-slide a {position:relative;display:inline-block; font-size:14px; color:rgba(0,0,0,0.5); font-weight:400; text-decoration:none;}
.menu-swiper .swiper-slide.active a {padding-bottom:16.5px; font-weight:700; color:#000;}
.menu-swiper .swiper-slide.active a::before {content:""; position:absolute; left:0; bottom:0; width:100%; height:3px; background:#000;}
.menu-swiper .swiper-container {width:auto; margin-top:12px; background:#fff;}
.menu-swiper .logo {padding-left:21px; margin-top:-10px;}
.sub-bnr .menu-swiper.fixed {position:fixed; left:50%; top:0; z-index:20; width:1140px; margin-left:-570px; background:#fff;}
.visual-area .visual-bnr {width:100%; height:0; overflow-y:hidden;}
.visual-area .visual-bnr.on {height:440px;}
.sub-contents .prd-menu-swiper {width:100%; padding:24px 0; margin-left:22px;}
.sub-contents .prd-menu-swiper .swiper-slide {width:auto; margin-right:8px;}
.sub-contents .prd-menu-swiper .swiper-slide button {display:inline-block; width:auto; height:32px; padding:0 12px; line-height:32px; font-size:14px; font-weight:400; color:#999; background:#fff; border:1px solid #eee; border-radius:32px;}
.sub-contents .prd-menu-swiper .swiper-slide.active button {font-weight:700; color:#FF214F; border-color:#FF214F;}
.sub-menu-area {display:flex; align-items:center; justify-content:flex-end; height:80px; border-top:1px solid #F5F6F7;}
.view-select {position:relative; width:200px; margin-right:22px; text-align:right;}
.view-select .btn-view {position:relative; font-size:14px; font-weight:500; color:#000; background:transparent;}
.view-select .btn-view .icon {display:inline-block; width:16px; height:19px; background-size:100%; background:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/icon_arrow_down.png) no-repeat 0 0; vertical-align:middle; transition:all .3s;}
.view-select .btn-view.on .icon {transform:rotate(180deg); vertical-align:top;}
.view-select .select-list {display:none; width:auto; position:absolute; right:-10px; top:50px; padding:20px; z-index:20; background:#fff; border:1px solid #eee;}
.view-select .select-list.on {display:block;}
.view-select .select-list li {margin-bottom:10px; font-size:14px; font-weight:500; color:rgba(0,0,0,0.5); cursor:pointer; text-align:left;}
.view-select .select-list li:last-child {margin-bottom:0;}
.uni-prd-list .pdtWrap {margin-top:0; background:none}
.uni-prd-list .pdtWrap .pdtList {margin:0 0 -1px;}
.uni-prd-list .pdtWrap .pdtList li:nth-child(1),
.uni-prd-list .pdtWrap .pdtList li:nth-child(2),
.uni-prd-list .pdtWrap .pdtList li:nth-child(3),
.uni-prd-list .pdtWrap .pdtList li:nth-child(4) {padding-top:0;}
/* 상품 리스트 */
.pdtWrap {overflow:hidden; padding:0; margin-top:30px; padding-bottom:1px; background:url(http://fiximage.10x10.co.kr/web2015/common/line_pdtlist.gif) 0 100% repeat-x;}
.pdtWrap img {vertical-align:top; display:inline;}
.pdtWrap .pdtList {margin-top:-30px; margin-bottom:-1px;}
.pdtWrap .pdtList li {background:url(http://fiximage.10x10.co.kr/web2015/common/line_pdtlist.gif) 0 100% repeat-x;}
.pdtWrap .pdtActionV15 li {background:none;}
.pdtList {overflow:hidden;}
.pdtList li {float:left; text-align:center;}
.pdtList li.soldOut .soldOutMask {display:block; z-index:10;}
.pdtBox {position:relative; margin:0 auto;}
.pdtInfo {text-align:center;}
.pdtLabel {position:absolute; right:-9px; z-index:12;}
.pdtPhoto {position:relative;}
.pdtPhoto a {display:block; width:100%; height:100%;}
.pdtPhoto a dfn {display:none; position:absolute; left:0; top:0; width:100%; height:100%; z-index:5;}
.pdtPhoto .offline {background:#d3e4ea url(http://fiximage.10x10.co.kr/web2017/my10x10/ico_store.png) 50% 32px no-repeat;}
.pdtPhoto .offline span {position:absolute; left:0; bottom:0; width:100%; height:29px; font-size:11px; font-weight:bold; line-height:29px; color:#fff; background-color:#555;}
.soldOutMask {display:none; position:absolute; left:0; top:0; right:0; bottom:0; width:100%; height:100%; background:url(http://fiximage.10x10.co.kr/web2015/common/mask_soldout.png) 50% 50% no-repeat;}
.pdtBrand {color:#b2b2b2; font-size:13px; line-height:14px; font-weight:bold; text-decoration:underline; word-wrap:break-word; word-break:break-all;}
.pdtBrand a {color:#b2b2b2; text-decoration:underline; word-wrap:break-word; word-break:break-all;}
.pdtName {color:#555; font-size:13px; min-height:32px; padding-bottom:5px; vertical-align:top; line-height:18px; word-wrap:break-word; word-break:break-all;}
.pdtPrice {color:#777; font-size:13px; letter-spacing:-.5px; font-weight:normal;}
.finalP {color:#777; font-weight:bold;}
.ctgyWrapV15 .pdt240V15 .pdtList {background:url(http://fiximage.10x10.co.kr/web2015/shopping/line_pdtlist240.gif) 0 0 repeat-y;}
.ctgyWrapV15 .pdt240V15 .pdtList > li {width:25%;}
.pdt240V15 .pdtList > li {padding:40px 22.5px;}
.pdt240V15 .pdtBox {width:240px; height:445px;}
.pdt240V15.pdtBiz .pdtBox {height:400px;}
.pdt240V15 .pdtPhoto, .pdt240V15 .pdtPhoto img {width:240px; height:240px;}
.pdt240V15 .pdtPhoto a, .pdt150V15 .pdtPhoto a {position:relative;}
.pdt240V15 .pdtPhoto a::before, .pdt150V15 .pdtPhoto a::before {content:""; position:absolute; left:0; top:0; display:inline-block; width:100%; height:100%; background:#000; opacity:0.01;}
.class-badge,
.dealBadge {display:none; position:absolute; width:46px; height:50px; padding-top:9px; color:#fff; font-weight:normal; z-index:10; font-size:12px; line-height:14px; background-image:url(http://fiximage.10x10.co.kr/web2017/common/ico_dealBadge_itemlist.png); background-position:50% 0; background-repeat:no-repeat; text-align:center; font-style:normal;}
.deal-item .dealBadge {display:block;}
.pdtList .dealBadge {left:10px; top:0;}
.enjoyEvent .dealBadge {left:18px; top:8px;}
.pdtInfoWrapV15 .dealBadge {left:50px; top:5px; width:70px; height:67px; padding-top:11px; font-size:16px; line-height:18px; background-image:url(http://fiximage.10x10.co.kr/web2017/common/ico_dealBadge_itemdetail.png);}
.pdtInfoWrapV15 .badge-diarygift {position:absolute; bottom:50px; right:30px; z-index:999; width:136px; height:102px;}
.pdtInfoWrapV15 .badge-diarygift a, .pdtInfoWrapV15 .badge-diarygift img {display:inline-block; width:100%; height:100%;}
.class-badge {display:block; left:16px; height:42px; background-image:url(http://fiximage.10x10.co.kr/web2017/common/ico_badge_org1.png);}
.photoReviewWrap .class-badge {left:10px; width:30px; height:21px; padding-top:10px; background-image:url(http://fiximage.10x10.co.kr/web2017/common/ico_badge_org2.png); font-size:9px; line-height:1;}
.free-shipping-badge {display:inline-block; position:absolute; top:192px; right:8px; width:40px; height:35px; padding-top:5px; color:#fff; background-color:#000; font-weight:bold; z-index:10; font-size:11px; line-height:15px;  text-align:center; font-style:normal;}
.pdtBizWrap .free-shipping-badge {top:273px;}
.bigBadge {display:inline-block; position:absolute; top:205px; right:0; width:72px; height:54px; z-index:20;}
.bigBadge img {width:100%;}
.abroad-badge {position:absolute; left:10px; top:0; z-index:10; width:46px; height:23px; padding-top:27px; color:#fff; font-weight:normal; font-size:11px; line-height:12px; background:url(http://fiximage.10x10.co.kr/web2017/common/ico_dealBadge_itemlist.png) 0 0 no-repeat; text-align:center; font-style:normal; letter-spacing:-1px;}
.abroad-badge:after {content:''; position:absolute; left:50%; top:7px; width:20px; height:14px; margin-left:-10px; background:url(http://fiximage.10x10.co.kr/web2018/common/ico_abroad_white.png) 0 0 no-repeat;}
.photoReviewWrap .abroad-badge,
.pdt180V15 .abroad-badge,
.pdt150V15 .abroad-badge {width:28px; height:30px; padding-top:0; background-image:url(http://fiximage.10x10.co.kr/web2018/common/bg_badge_blue.png); text-indent:-999em;}
.pdtActionV15 {overflow:hidden; position:absolute; left:0; bottom:0; width:100%; height:15px; text-align:center;}
.pdtActionV15 li {display:inline-block; float:none; *float:left; height:15px; vertical-align:top; background:none; font-size:11px; line-height:13px; color:#999; font-weight:normal; letter-spacing:-0.085em;}
.pdtActionV15 li a, .pdtActionV15 li p {display:block; height:15px; padding:0 3px 0 24px; cursor:pointer; text-decoration:none; color:#999; font-weight:bold; letter-spacing:.2px;}
.pdtActionV15 li.largeView a, .pdtActionV15 li.largeView p {padding:0 3px 0 0;}
.pdtActionV15 li.postView {background:url(http://fiximage.10x10.co.kr/web2015/common/ico_review.png) 0 50% no-repeat;}
.pdtActionV15 li.wishView {background:url(http://fiximage.10x10.co.kr/web2015/common/ico_wish.png) 0 50% no-repeat;}
.pdtActionV15 li.wishView a, .pdtActionV15 li.wishView p {padding:0 0 0 24px;}
/* swiper */
.slick-track {display:flex; align-items:center;}
</style>
</head>
<body>
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <div class="eventContV15 tMar15">
        <div class="contF contW">
            <div id="app"></div>
        </div>
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

    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
    <link rel="stylesheet"href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
    <script type="text/javascript" src="/lib/js/slick.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>

    <script src="/vue/common/common.js?v=1.00"></script>

    <script src="/vue/universal/detail/store.js?v=1.00"></script>
    <script src="/vue/universal/detail/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->