<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<%
    if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
        if Not(Request("mfg")="pc" or session("mfg")="pc") then
            if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
                Response.Redirect "//m.10x10.co.kr/event/21th/index.asp"
                REsponse.End
            end if
        end if
    end if
	dim tabType : tabType = RequestCheckVar(request("tabType"),7)

	If tabType = "" Then '//초기 진입시 혜택 탭
		tabType = "benefit"
	End if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<style>
@font-face {
font-family: 'GmarketSansMedium';
src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
font-weight: normal;
font-style: normal;
}

.anniversary section{position:relative; width:100%;}
.anniversary a{text-decoration: none;}
.anniversary section .prd_wrap ul{display:flex;flex-wrap:wrap;overflow:hidden; width:1042px; margin:0 auto;}
.anniversary section .prd_wrap ul li{margin-right:29px;}
.anniversary section .prd_wrap ul li:nth-of-type(4n){margin-right:0;}
.anniversary section .prd_wrap ul li .desc{margin-top:20px;}
.anniversary section .prd_wrap ul li .desc .name{text-overflow: ellipsis;width:238px;overflow: hidden;font-size:18px; color:#fff;text-align:left;}
.anniversary section .prd_wrap ul li .desc .price{margin-top:0;display:flex;font-size:25px;font-weight:bold;align-items:center; color:#fff;}
.anniversary section .prd_wrap ul li .desc .price s{font-size:18px;font-weight:lighter;color:#63ae91; margin-right:8px;}
.anniversary section .prd_wrap ul li .desc .price span{color:#ffea3a;font-size:18px;font-weight:normal; margin-left:8px;}
.anniversary section .prd_wrap ul li .thumbnail{width:238px; height:238px; overflow:hidden;}
.anniversary section .prd_wrap ul li .thumbnail img{width:100%;}

.anniversary .main{background:url(//webimage.10x10.co.kr/fixevent/event/2022/anniversary/main.jpg?v=1.03)no-repeat 50% 0;height:598px;}
.anniversary .main02{width:1920px;margkn:0 auto;position:relative;left:50%;margin-left:-960px;}
.anniversary .main03{background:url(//webimage.10x10.co.kr/fixevent/event/2022/anniversary/main_new03_01.jpg)no-repeat 50% 0;height:598px;}

.anniversary .tab-area{background:#161616;z-index:999;top:0;}
.anniversary .tab-area.fixed{position:fixed;top:0;z-index:999;}
.anniversary .tab-area .tab_wrap{width:660px;margin:0 auto;display:flex;justify-content:space-around;align-items:center;}
.anniversary .tab-area .tab_wrap p a{font-family:'GmarketSansMedium';font-size:18px;color:#8a8a8a;padding:20px 0;display:block;line-height:1em;}
.anniversary .tab-area .tab_wrap p.active a{color:#fff;font-weight:bold;}
.anniversary .tab-area .tab_wrap p.active a span{position:relative;}
.anniversary .tab-area .tab_wrap p.active a span::after{content:'';position:absolute;top:-5px;right:-8px;width:6px;height:6px;background:#ffea3c;border-radius:25px;}


.anniversary .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/anniversary/section01.jpg)no-repeat 50% 0;height:592px;margin-bottom:15px;}
.anniversary .section01 .scroll{width:420px;position:absolute;top:95px;left:50%;margin-left:20px;}
.anniversary .section01 .scroll p a{width:100%;height:55px;display:block;margin-bottom:14.5px;}

.anniversary .section02{background:url(//webimage.10x10.co.kr/fixevent/event/2022/anniversary/section02.jpg?v=1.02)no-repeat 50% 0;height:417px;margin-bottom:15px;}
.anniversary .section02 .coupon{position:absolute;top:105px;left:50%;margin-left:47px;animation: updown .8s ease-in-out infinite alternate;}
.anniversary .section02 .coupon_wrap{position:absolute;top:204px;left:50%;margin-left:34px;}

.anniversary .section03{background:url(//webimage.10x10.co.kr/fixevent/event/2022/anniversary/section03.jpg)no-repeat 50% 0;height:582px;margin-bottom:60px;}
.anniversary .section03 .mileage{position:absolute;top:139px;left:50%;margin-left:47px;animation: updown .6s .3s ease-in-out infinite alternate;}
.anniversary .section03 .mileage_wrap{position:absolute;top:237px;left:50%;margin-left:34px;}
.anniversary .section03 button{width:352px;height:75px;background:transparent;position:absolute;top:430px;left:50%;transform:translateX(-50%);}

.anniversary .section04{background:url(//webimage.10x10.co.kr/fixevent/event/2022/anniversary/section04.jpg)no-repeat 50% 0;height:666px;margin-bottom:60px;}
.anniversary .section04 button{width:360px;height:75px;background:transparent;position:absolute;top:512px;left:50%;transform:translateX(-50%);}
.anniversary .section04 .swiper01{width:930px;margin:0 auto;padding-top:250px;}
.anniversary .section04 .swiper-button-prev, .anniversary .section04 .swiper-button-next{background:url(//webimage.10x10.co.kr/fixevent/event/2022/anniversary/arrow.png) no-repeat 0 0;width:35px;height:60px;color:unset;margin-top:unset;}
.anniversary .section04 .swiper-button-prev{left:50%;margin-left:-502px;}
.anniversary .section04 .swiper-button-next{transform:rotate(180deg);left:50%;margin-left:460px;}
.anniversary .section04 .swiper-button-prev:after, .anniversary .section04 .swiper-button-next:after{content:unset;}
.anniversary .section04 .swiper-button-next.swiper-button-disabled, .anniversary .section04 .swiper-button-prev.swiper-button-disabled{opacity:1;}

.anniversary .section05{overflow:hidden;width:850px;height:240px;left:50%;transform:translateX(-50%);margin-bottom:28px;}
.anniversary .section05 a{position:relative;overflow:hidden;}
.anniversary .section05 a .thumbnail{width:268px;border-radius:50%;position:absolute;top:15px;left:50%;transform:translateX(-50%);}
.anniversary .section05 a .thumbnail img{border-radius: 50%;width:100%;left:100%;}
.anniversary .section05 a .desc{position:absolute;font-family:'GmarketSansMedium';font-size:16px;text-align:right;top:120px;right:40px;color:#fff;}
.anniversary .section05 a .desc .discount{font-size:20px;font-weight:bold;background:#000;padding:5px 10px;border-radius:25px}
.anniversary .section05 a .desc .sum{font-size:30px;font-weight:bold;}

.anniversary .section06{overflow:hidden;width:850px;height:240px;left:50%;transform:translateX(-50%);margin-bottom:60px;}

.anniversary .section07{background:url(//webimage.10x10.co.kr/fixevent/event/2022/anniversary/section07.jpg)no-repeat 50% 0;height:425px;margin-bottom:15px;}
.anniversary .section07 .swiper02{width:676px;position:absolute;top:95px;left:50%;margin-left:-50px;}
.anniversary .section07 .prdSwiper .swiper-wrapper{align-items: flex-end;}
.anniversary .section07 .prdSwiper .swiper-wrapper .swiper-slide{width:169px;}
.anniversary .section07 button{width:317px;height:75px;background:transparent;position:absolute;top:278px;left:50%;margin-left:-466px;}

.anniversary .section08{background:url(//webimage.10x10.co.kr/fixevent/event/2022/anniversary/section08.jpg)no-repeat 50% 0;height:568px;margin-bottom:43px;}
.anniversary .section08 .youtube{position:absolute;width:147px;height:166px;top:190px;left:50%;margin-left:150px;}
.anniversary .section08 .youtube p{position:absolute;}
.anniversary .section08 .youtube p.you01{left:unset;}
.anniversary .section08 .youtube p.you02{left:unset;margin-left:unset;}
.anniversary .section08 .youtube p.you04{bottom:unset;left:unset;}
.anniversary .section08 .youtube p.you05{bottom:unset;right:unset;}
.anniversary .section08 .youtube.on{position:absolute;top:94px;width:466px;height:360px;left:50%;margin-left:50px;transition:all 1s;}
.anniversary .section08 .youtube.on p{position:absolute;}
.anniversary .section08 .youtube.on p.you01{left:0;}
.anniversary .section08 .youtube.on p.you02{left:50%;margin-left:-73.5px;}
.anniversary .section08 .youtube.on p.you04{bottom:0;left:80px;}
.anniversary .section08 .youtube.on p.you05{bottom:0;right:80px;}
.anniversary .section08 button{width:352px;height:75px;background:transparent;position:absolute;top:368px;left:50%;margin-left:-466px;}

.anniversary .section10{overflow:hidden;width:850px;height:256px;left:50%;transform:translateX(-50%);margin-bottom:30px;}

.anniversary .section11{width:850px;left:50%;transform:translateX(-50%);margin-bottom:60px;}
.anniversary .section11 .banner_wrap{display:flex;justify-content:space-between;}

.anniversary .section12{background:url(//webimage.10x10.co.kr/fixevent/event/2022/anniversary/section13.jpg)no-repeat 50% 0;height:535px;}
.anniversary .section12 button{width:316px;height:75px;background:transparent;position:absolute;top:362px;left:50%;margin-left:-466px;}
.anniversary .section12 .hbd p{position:absolute;}
.anniversary .section12 .hbd p.icon01{top:270px;left:50%;margin-left:225px;animation: updown2 .6s 0s ease-in-out infinite alternate;}
.anniversary .section12 .hbd p.icon02{top:240px;left:50%;margin-left:75px;animation: on 1.7s ease-in-out infinite ;}
.anniversary .section12 .hbd p.icon03{top:265px;left:50%;margin-left:345px;animation: on 1.8s 0.3s ease-in-out infinite ;}
.anniversary .section12 .hbd p.icon04{top:345px;left:50%;margin-left:110px;animation: on 2s ease-in-out infinite ;}

.anniversary .section13{width:336px;margin:0 auto;margin-bottom:70px;}

.anniversary .section14 h2{text-align:center;margin-bottom:60px;}
.anniversary .cont_wrap{width:1042px; margin:0 auto;}
.anniversary .section14  .prd_wrap{padding-bottom:35px;}
.anniversary .section14 .prd_wrap ul{overflow:hidden; max-height:1930px;}
.anniversary .section14  .prd_wrap ul li{margin-bottom:55px;}
.anniversary .section14  .prd_wrap ul li .desc {font-family:'GmarketSansMedium';}
.anniversary .section14  .prd_wrap ul li .desc .name{color:#111;text-overflow: ellipsis;font-size:18px;font-family:'GmarketSansMedium';line-height:22px;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;overflow: hidden;}
.anniversary .section14  .prd_wrap ul li .desc .price{color:#111;}
.anniversary .section14  .prd_wrap ul li .desc .price s{color:#999;}
.anniversary .section14  .prd_wrap ul li .desc .price span{color:#ff4848;}

.anniversary .section14 .cont_wrap > div{position:relative;}
.anniversary .section14 .cont_wrap > div .ten_mask{width:100%; height:210px;display:block;bottom:34px;z-index:11; position:absolute; background:linear-gradient(360deg, rgba(255,255,255,1) 0%, rgba(255,255,255,1) 60%, rgba(255,255,255,0.7259278711484594) 85%, rgba(255,255,255,0) 100%);}
.anniversary .section14 .cont_wrap > div .ten_mask .btn_more{bottom:70px; position:absolute; left:50%;transform:translateX(-50%);background:#ff4848;font-family:'GmarketSansMedium';font-size:20px;color:#fff;padding:10px 30px;border-radius: 25px;border-radius: 25vw;-webkit-box-shadow: 0px 10px 14px 0px rgb(210 210 210); 
box-shadow: 0px 10px 14px 0px rgb(210 210 210);}
.anniversary .section14 .cont_wrap > div .ten_mask .btn_more span{transform:rotate(223deg);display:inline-block;width: 10px;height: 10px;border-top: 3px solid #fff; border-left: 3px solid #fff;margin-left:8px;margin-bottom:2px;}
.anniversary .section14 .prd_wrap ul.more{max-height:none; padding-bottom:125px;}
.anniversary .section14 .cont_wrap > div .ten_mask.more{bottom:0;}


@keyframes updown {
    0% {transform: translateY(-15px);}
    100% {transform: translateY(0);}    
}

@keyframes updown2 {
    0% {transform: translateY(-10px);}
    100% {transform: translateY(10px);}    
}

@keyframes on {
    0% {transform: translateY(15px);opacity:0;}
    100% {transform: translateY(0);opacity:1;}    
}
</style>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
</head>
<body>
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <div class="eventContV15 tMar15">
		<div class="contF contW" style="background:#fff;"><div>
        <div id="app"></div>
    </div>

    <script type="text/javascript">
        const loginUserID = "<%= GetLoginUserID %>";
        const server_info = "<%= application("Svr_Info") %>";

        let isUserLoginOK = false;
        <% IF IsUserLoginOK THEN %>
            isUserLoginOK = true;
        <% END IF %>
		let tabType = "<%=tabType%>";

    </script>

    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
	<script type="text/javascript" src="/event/etc/json/js_applyItemInfo_monthlyten.js?v=1.01"></script>

    <script src="/vue/vue_dev.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>
    
    <script src="/vue/common/common.js?v=1.00"></script>

    <script src="/vue/event/21th/components/benefit.js?v=1.00"></script>
    <script src="/vue/event/21th/components/special_price.js?v=1.00"></script>
    <script src="/vue/event/21th/components/youtube.js?v=1.00"></script>
    <script src="/vue/event/21th/components/event.js?v=1.00"></script>
    
	<script src="/vue/event/21th/store.js?v=1.00"></script>
	<script src="/vue/event/21th/index.js?v=1.00"></script>

    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->