<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<%
    if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
        if Not(Request("mfg")="pc" or session("mfg")="pc") then
            if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
                Response.Redirect "//m.10x10.co.kr/monthlyten/index2020.asp"
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
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Abril+Fatface" />

<style>
	@font-face {
	font-family: 'GmarketSansMedium';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
	font-weight: normal;
	font-style: normal;
	}
	.monthly_ten section{width:1440px; margin:0 auto; position:relative; left:50%; margin-left:-720px;}
	.monthly_ten li{list-style:none;}
	.monthly_ten a{width:100%; height:100%; display:block;}
	.monthly_ten a:hover{text-decoration:none;}
	.monthly_ten section .prd_wrap ul{display:flex;flex-wrap:wrap;overflow:hidden; width:1042px; margin:0 auto;}
	.monthly_ten section .prd_wrap ul li{margin-right:29px;}
	.monthly_ten section .prd_wrap ul li:nth-of-type(4n){margin-right:0;}
	.monthly_ten section .prd_wrap ul li .desc{margin-top:20px;}
	.monthly_ten section .prd_wrap ul li .desc .name{text-overflow: ellipsis;white-space: nowrap;width:238px;overflow: hidden;font-size:18px; color:#111;}
	.monthly_ten section .prd_wrap ul li .desc .price{margin-top:0;display:flex;font-size:25px;font-weight:bold;align-items:baseline; color:#111;}
	.monthly_ten section .prd_wrap ul li .desc .price s{font-size:18px;font-weight:lighter;margin-right:8px;}
	.monthly_ten section .prd_wrap ul li .desc .price span{font-size:18px;font-weight:normal; margin-left:8px;}
	.monthly_ten section .prd_wrap ul li .thumbnail{width:238px; height:238px; overflow:hidden;}
	.monthly_ten section .prd_wrap ul li .thumbnail img{width:100%;}


	/* monthtop */
	.monthly_ten .monthtop{position:absolute; top:60px; left:50%; transform:translateX(-50%);}

	/* tab-area */
	.monthly_ten .tab-area{background:#373737;z-index:999;top:0; height:70px;}
	.monthly_ten .tab-area.fixed{position:fixed;top:0;z-index:999;}
	.monthly_ten .tab-area .tab_wrap{display:flex; justify-content:space-between; align-items:center; width:775px; margin:0 auto; height:100%;}
	.monthly_ten .tab-area .tab a{color:#a2a2a2;font-size:22px;display:block;text-align:center;}
	.monthly_ten .tab-area .tab.active a{color:#fff446;font-family: var(--bd);}
	.monthly_ten .tab-area .tab.active a span{width:fit-content;position:relative;}
	.monthly_ten .tab-area .tab.active a span::after{content:'';display:block;position:absolute;top:-5.5px;right:-14.5px;background:#fff446;width:10px;height:10px;border-radius:50%;}

	/* tab01 */
	.monthly_ten .tab01 .section01_1_benefit .top_text{font-family:'GmarketSansMedium'; white-space:nowrap; position:absolute; top:83px; left:50%; transform:translateX(-50%); font-size:31px; color:#fff446; text-align:center;}
	.monthly_ten .tab01 .section01_1_benefit .top_text .name{position:relative;}
	.monthly_ten .tab01 .section01_1_benefit .top_text .name::before{position:absolute; content:''; width:100%; height:1px; background:#fff446; bottom:3px; left:0;}
	.monthly_ten .tab01 .section01_1_benefit .benefit_list{width:1072px; display:flex; height:177px; flex-wrap:nowrap; bottom:54px; left:50%; margin-left:-536px; position:absolute;}
	.monthly_ten .tab01 .section01_1_benefit .benefit_list a{width:25%; height:100%;}
	.monthly_ten .tab01 .section01_2 .btn_download{position:absolute; width:400px; left:50%; transform:translateX(-50%); bottom:156px; height:84px;}
	.monthly_ten .tab01 .section01_4{background:#fff; padding:78px 0 76px;}
	.monthly_ten .tab01 .section01_4 .prd_evt p img{margin-left:20px;}
	.monthly_ten .tab01 .section01_5 .btn_mileage{position:absolute; width:377px; height:103px; bottom:82px; left:50%; margin-left:-537px;}
	.monthly_ten .tab01 .section01_5 .date01{position:absolute; bottom:87px; left:50%; margin-left:156px;}
	.monthly_ten .tab01 .section01_5 .date01_2{position:absolute; top:265px; left:50%; margin-left:-533px;}
	/* 수정ver8 */
	.monthly_ten .tab01 .section01_5 .date02{position:absolute; bottom:87px; left:50%; margin-left:109px;}
	.monthly_ten .tab01 .section01_5 .date02_2{position:absolute; top:265px; left:50%; margin-left:-533px;}
	.monthly_ten .tab01 .section01_5 .date02_3{position:absolute; top:265px; left:50%; margin-left:-533px;}
	/* //수정ver8 */
	.monthly_ten .tab01 .section01_6 button{width:384px;height:81px;background:transparent;position:absolute;top:383px;left:50%;margin-left:-541px;}
	.monthly_ten .tab01 .section01_6 .date01{position:absolute; bottom:90px; left:50%; margin-left:212px;}
	.monthly_ten .tab01 .section01_6 .date01_2{position:absolute; top:90px; left:50%; margin-left:-535px;}
	.monthly_ten .tab01 .section01_6 .date02{position:absolute; bottom:90px; left:50%; margin-left:230px;}
	.monthly_ten .tab01 .section01_6 .date02_2{position:absolute; top:90px; left:50%; margin-left:-535px;}
	.monthly_ten .tab01 .section01_6 .free_wrap{width:603px; position:absolute; top:143px; left:50%; margin-left:-25px;}
	.monthly_ten .tab01 .section01_6 .free_wrap .swiper-slide{width:192px; height:256px;}
	.monthly_ten .tab01 .section01_6 .free_wrap .swiper-slide img{margin:14px 0 1.3px 0; width:190px; height:243px;}
	.monthly_ten .tab01 .section01_6 .free_wrap .swiper-slide::before{position:absolute; width:55px; height:56px; left:0; top:0; content:''; background:url(//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/free_badge01.png) no-repeat; background-size:100%;}
	.monthly_ten .tab01 .section01_6 .free_wrap .swiper-slide::after{position:absolute; width:91px; height:48px; left:31px; top:24px; content:''; background:url(//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/free_badge02.png) no-repeat; background-size:100%;}
	.monthly_ten .tab01 .section01_6 .swiper-button-prev, .monthly_ten .tab01 .section01_6 .swiper-button-next{background:url(//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/arrow_left.png) no-repeat 0 0;width:22px;height:51px;color:unset;margin-top:unset; top:108px;}
	.monthly_ten .tab01 .section01_6 .swiper-button-prev{left:-47px;}
	.monthly_ten .tab01 .section01_6 .swiper-button-next{transform:rotate(180deg);right:-47px;}
	.monthly_ten .tab01 .section01_6 .swiper-button-prev:after, .monthly_ten .tab01 .section01_6 .swiper-button-next:after{content:unset;}
	.monthly_ten .tab01 .section01_6 .swiper-button-next.swiper-button-disabled, .monthly_ten .tab01 .section01_6 .swiper-button-prev.swiper-button-disabled{opacity:1;}
	.monthly_ten .tab01 .section01_1_brand{background:#111; padding:84px 0 72px 0;}
	.monthly_ten .tab01 .section01_1_brand h2{margin:0 auto; padding-bottom:64px;}
	.monthly_ten .tab01 .section01_1_brand .brand_wrap{position:relative;}
	.monthly_ten .tab01 .section01_1_brand .brand_wrap .swiper-slide{width:177px; margin-right:18px;}
	.monthly_ten .tab01 .section01_1_brand .brand_wrap .swiper-slide img{width:176px; height:191px;}
	.monthly_ten .tab01 .section01_1_brand .brand_wrap .swiper-wrapper{display:flex; transition-timing-function:linear;}
	.monthly_ten .tab01 .section01_1_brand .brand_wrap .swiper-container{margin-bottom:18px;}
	.monthly_ten .tab01 .section01_1_brand .brand_wrap::before{position:absolute; content:''; width:107px; height:100%; left:0; top:0; background:linear-gradient(270deg, rgba(255,255,255,0) 0%, rgba(0,0,0,1) 100%); z-index:2;}
	.monthly_ten .tab01 .section01_1_brand .brand_wrap::after{position:absolute; content:''; width:107px; height:100%; right:0; top:0; background:linear-gradient(90deg, rgba(255,255,255,0) 0%, rgba(0,0,0,1) 100%); z-index:2;}
	.monthly_ten .tab01 .section01_2_today{padding:134px 0 85px; overflow:hidden; position:relative; background:#fff446;}
	.monthly_ten .tab01 .section01_2_today .top_text{font-family:'GmarketSansMedium'; white-space:nowrap; position:absolute; top:77px; left:50%; transform:translateX(-50%); font-size:31px; color:#111; text-align:center; font-weight:700;}
	.monthly_ten .tab01 .section01_2_today h2{margin:0 auto; padding-bottom:70px;}
	.monthly_ten .tab01 .section01_2_today .prd_wrap ul li .desc .price s{color:#aea624;}
	.monthly_ten .tab01 .section01_2_today .prd_wrap ul li .desc .price span{color:#a853ff;}

	/* tab02 */
	.monthly_ten .tab02 .section01_4{background:#fff;}
	.monthly_ten .tab02 .section01_4 h2{padding-top:89px; padding-bottom:91px;}
	.monthly_ten .tab02 .section01_4 h2 p{padding-top:10px;}
	.monthly_ten .tab02 .section01_4 .cont_wrap{width:1042px; margin:0 auto;}
	.monthly_ten .tab02 .section01_4 h3{font-size:20px; color:#808080;margin-bottom:30px;width:fit-content; font-weight:normal;}
	.monthly_ten .tab02 .section01_4 h3 span{font-size:28px; color:#111; font-weight:bold;border-bottom:4px solid #111; margin-right:10px;}
	.monthly_ten .tab02 .section01_4 .prd_wrap{padding-bottom:35px;}
	.monthly_ten .tab02 .section01_4 .prd_wrap ul{overflow:hidden; max-height:620px;}
	.monthly_ten .tab02 .section01_4 .prd_wrap ul li{margin-bottom:55px;}
	.monthly_ten .tab02 .section01_4 .prd_wrap ul li .desc .name{color:#111;}
	.monthly_ten .tab02 .section01_4 .prd_wrap ul li .desc .price{color:#111;}
	.monthly_ten .tab02 .section01_4 .prd_wrap ul li .desc .price s{color:#999999;}
	.monthly_ten .tab02 .section01_4 .prd_wrap ul li .desc .price span{color:#ff72d4;}
	.monthly_ten .tab02 .section01_4 .prd_wrap ul li:nth-of-type(n+9){display:none;}
	.monthly_ten .tab02 .section01_4 .cont_wrap > div{position:relative;}
	.monthly_ten .tab02 .section01_4 .cont_wrap > div .ten_mask{width:100%; height:210px;display:block;bottom:34px;z-index:11; position:absolute; background:linear-gradient(360deg, rgba(255,255,255,1) 0%, rgba(255,255,255,1) 60%, rgba(255,255,255,0.7259278711484594) 85%, rgba(255,255,255,0) 100%);}
	.monthly_ten .tab02 .section01_4 .cont_wrap > div .ten_mask .btn_more{bottom:70px; position:absolute; left:50%; margin-left:-117.5px; width:235px; height:87px;}
	.monthly_ten .tab02 .section01_4 .prd_wrap ul.more{max-height:none; padding-bottom:125px;}
	.monthly_ten .tab02 .section01_4 .cont_wrap > div .ten_mask.more{bottom:0;}

	/* tab03 */
	.monthly_ten .tab03 .section01_1{background:#eaeaea; padding-bottom:74px;}
	.monthly_ten .tab03 .section01_1 h2{padding-top:86px; padding-bottom:72px;}
	.monthly_ten .tab03 .section01_1 .bnr_wrap{width:1061px; margin:0 auto; display:flex; flex-wrap:wrap; justify-content:center;}
	.monthly_ten .tab03 .section01_1 .bnr_wrap li{width:348px; height:318px;}
	.monthly_ten .tab03 .section01_1 .bnr_wrap li img{width:348px; height:318px;}

	/* 텐텐다꾸 플로팅 배너 */
	.monthly_ten .daccu_banner{width:143px; height:159px; position:fixed; top:145px; right:50%; margin-right:-608px; display:none; z-index:20;}
	.monthly_ten .daccu_banner.active{display:block;}
	.monthly_ten .daccu_banner .btn_daccu{display:block; position:absolute; left:0; bottom:0; width:145px; height:144px;}
	.monthly_ten .daccu_banner .btn_close{display:block; position:absolute; right:0; top:0; z-index:2; width:26px; height:25px;}
	.monthly_ten .daccu_banner .btn_close img{height:100%;}

	/* popup */
	.monthly_ten .popup .bg_dim{display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(0, 0, 0,0.741); z-index:999;}
	.monthly_ten .popup .pop01{position:relative; width:588px; margin:0 auto; top:50%; transform:translateY(-55%); z-index:999;}
	.monthly_ten .popup .pop01 .btn_close{position:absolute; width:50px; height:50px; position:absolute; right:20px; top:20px;}
	.monthly_ten .popup .pop01 .btn_coupon{position:absolute; width:400px; height:80px; position:absolute; left:50%; transform:translateX(-50%); bottom:84px;}
	.monthly_ten .popup .check .check01{position:absolute; width:25px; left:120px; top:225px; display:block; cursor:pointer;}
	.monthly_ten .popup .check .check02{position:absolute; width:25px; left:120px; top:225px; display:none; cursor:pointer;}
	.monthly_ten .popup .check.on .check01{display:none;}
	.monthly_ten .popup .check.on .check02{display:block;}
</style>
<!-- 11월 추가 -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
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
		let userName = "고객"
        let isUserLoginOK = false;
        <% IF IsUserLoginOK THEN %>
            isUserLoginOK = true;
			userName = "<%=GetLoginUserName%>";
        <% END IF %>
		let tabType = "<%=tabType%>";

    </script>

    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
	<script type="text/javascript" src="/event/etc/json/js_applyItemInfo_monthlyten.js"></script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>
    
    <script src="/vue/common/common.js?v=1.00"></script>

	<script src="/vue/components/monthlyten/benefit/index.js?v=1.02"></script>

	<script src="/vue/components/monthlyten/sale/index.js?v=1.02"></script>
	<script src="/vue/components/monthlyten/sale/content.js?v=1.00"></script>

	<script src="/vue/components/monthlyten/event/index.js?v=1.02"></script>

	<script src="/vue/monthlyten/store.js?v=1.00"></script>
	<script src="/vue/monthlyten/index.js?v=1.00"></script>

    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->