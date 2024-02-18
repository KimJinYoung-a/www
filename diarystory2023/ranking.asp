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
                Response.Redirect "//m.10x10.co.kr/diarystory2023/index.asp"
                REsponse.End
            end if
        end if
    end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">

<style>
	/* 다꾸2023 페이지에서만! .gnb-wrap{border-bottom:0;} */
	.gnb-wrap{border-bottom:0;}
	.diary2023 img{width:100%;}
	.diary2023 a:hover{text-decoration:none;}
	.diary2023 a{color:inherit;}
	.diary2023 .btn_cart .btnRed{color:#fff;}
	.diary2023 #contentWrap{width:100%; padding:0; position:relative; overflow:hidden; background:url(//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/back_new_02.jpg/10x10/optimize); background-position:top; background-size:1920px auto; background-repeat:repeat-y;}
	.diary2023_ranking .top{width:100%; min-height:171px;}
	.diary2023_ranking .bottom{width:100%; min-height:170px;}
	.diary2023_ranking .content{width:100%;}
	.diary2023_ranking .section{width:1140px; margin:0 auto; display:flex; position:relative;}
	.diary2023_ranking .blur01{position:absolute; width:815px; height:815px; left:50%; top:441px; margin-left:-65px; border-radius:100%; background:radial-gradient(50% 50% at 50% 50%, #465785 0%, #05999E 55.21%, #cbe7e366 100%); filter:blur(25px);}
	.diary2023_ranking .blur02{position:absolute; width:182.2px; height:273.3px; left:50%; top:-138px; margin-left:-635px; background:radial-gradient(50% 50% at 50% 50%, rgba(255, 0, 0, 0.2) 0%, rgba(255, 111, 31, 0.2) 100%); mix-blend-mode:multiply; filter:blur(15px); border-radius:100px; transform:rotate(-62.45deg);}
	.diary2023_ranking .blur02::before{position:absolute; width:182.2px; height:273.3px; border-radius:100px; content:''; left:0; top:0; background:#FFF; opacity:0.5;}
	.diary2023_ranking .blur03{position:absolute; width:400px; height:400px; left:50%; top:994px; margin-left:-440px; border-radius:100%; background:radial-gradient(50% 50% at 50% 50%, #7751C8 0%, #91A8D0 48.96%, #f7cac9cc 100%); filter:blur(25px);}
	.diary2023_ranking .line01{position:absolute; width:656.61px; height:547.5px; left:50%; top:379px; margin-left:339px;}
	.diary2023_ranking .line02{position:absolute; width:736.5px; height:491px; left:50%; top:771px; margin-left:-960px;}
	.diary2023_ranking .section01{position:relative; width:292px; left:0; top:-100px;}
	.diary2023_ranking .sect01_link .date{width:fit-content;}
	.diary2023_ranking .sect01_link .date p{font-size:28px; font-weight:600; line-height:27px; margin-bottom:30px;}
	.diary2023_ranking .sect01_link .date p a{color:#666;}
	.diary2023_ranking .sect01_link .ranking p{font-size:20px; font-weight:500; line-height:24px; margin-bottom:20px;}
	.diary2023_ranking .sect01_link .ranking.on p{font-size:20px; font-weight:700; line-height:24px; margin-bottom:20px; text-decoration:underline; text-underline-position:from-font;}
	.diary2023_ranking .sect01_link .ranking.on p a{color:#111;}
	.diary2023_ranking .sect01_link .eventlink p{letter-spacing:-0.4px; max-width:269px; font-size:20px; font-weight:500; line-height:24px; margin-bottom:20px; overflow:hidden; text-overflow:ellipsis; display:-webkit-box; -webkit-line-clamp:1; -webkit-box-orient:vertical;}
	.diary2023_ranking .sect01_link .category p{font-size:20px; font-weight:500; line-height:24px;}
	.diary2023_ranking .search{margin-top:32px;}
	.diary2023_ranking .input_box{width:268px; height:40px; border-radius:20px; border:1px solid #999; background:transparent; display:flex; position:relative;}
	.diary2023_ranking .input_box .ico_search{width:24.07px; position:absolute; left:232px; top:7px;}
	.diary2023_ranking .input_box input{caret-color:#FF214F; background:transparent; margin-top:2px; font-size:14px; font-weight:500; line-height:16.8px; padding-left:16px;}
	.diary2023_ranking .input_box input::placeholder{color:#999;}
	.diary2023_ranking .reco_search{display:flex; margin:8px 0 0 14px; flex-wrap:wrap;}
	.diary2023_ranking .reco_search p{font-weight:400; letter-spacing:-0.4px; font-size:13px; line-height:16.8px; margin-right:8px;}
	.diary2023_ranking .sect01_link .reco_search p a{color:#111;}
	.diary2023_ranking .sect01_inform{color:#fff; position:absolute; width:200px; height:200px; border-radius:50%; left:119px; top:754px; background:#2F3167; font-size:16px; font-weight:500; line-height:24px; text-align:center; display:none;}
	.diary2023_ranking .sect01_inform p{letter-spacing:-1px; position:absolute; left:48%; transform:translateX(-50%); top:49px;}
	.diary2023_ranking .sect01_inform span{color:#00C4BD; font-size:20px; line-height:28px; font-weight:600; white-space:nowrap;}
	.diary2023_ranking .sect01_inform li{padding-top:10px; border-top:2px solid rgba(255, 255, 255, 0.6); letter-spacing:-1px; position:absolute; left:48%; transform:translateX(-50%); top:107px; font-size:14px; line-height:20px; list-style:none; font-weight:500;}
	.diary2023_ranking .sect01_inform li span{font-size:11px; line-height:16px; color:#fff; background:#00C4BD; text-align:center; display:inline-block; width:38px; border-radius:10px; margin-left:2px;} 
	.diary2023_ranking .section02{position:relative; width:848px; right:0; top:-100px; background:#fff; padding:40px 24px 24px 24px; box-sizing:border-box; box-shadow:2px 2px 12px rgba(0, 0, 0, 0.08);}
	.diary2023_ranking .section02 .section02_top{position:absolute; width:784.88px; height:22px; left:50%; margin-left:-392.44px; top:-11px;}
	.diary2023_ranking .sect02_list{display:flex;flex-wrap:wrap;}
	.diary2023_ranking .sect02_list .prd_wrap{position:relative; width:256px; height:349px; margin:0 16px 32px 0;}
	.diary2023_ranking .sect02_list .prd_wrap:nth-of-type(3n){margin:0 0 0 0;}
	.diary2023_ranking .sect02_list .prd_img{width:256px; height:256px; overflow:hidden; margin-bottom:12px; position:relative;}
	.diary2023_ranking .sect02_list .prd_img::after{position:absolute; content:''; width:100%; height:100%; background:black; opacity:0.05; left:0;}
	.diary2023_ranking .sect02_list .prd_img .ranking{z-index:2; width:40px; height:40px; position:absolute; left:0; top:0; background:#00000099;
; text-align:center; color:#fff; font-size:16px; line-height:15.71px; font-weight:600; padding-top:13px; box-sizing:border-box;} 
	.diary2023_ranking .sect02_list .prd_info .price{color:#111; font-size:18px; font-weight:600; line-height:17.68px; margin-right:4px; display:inline-block; margin-bottom:4px;}
	.diary2023_ranking .sect02_list .prd_info .price s{color:#999; font-size:14px; font-weight:400; line-height:13.75px; margin-right:11px;}
	.diary2023_ranking .sect02_list .prd_info .price span{color:#FF214F; font-size:14px; font-weight:600; line-height:13.75px;}
	.diary2023_ranking .sect02_list .prd_info .name{overflow:hidden; text-overflow:ellipsis; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; color:#111; font-size:14px; font-weight:400; line-height:20px; margin-bottom:4px; width:178px;}
	.diary2023_ranking .sect02_list .prd_info .brand{color:#999; font-size:13px; font-weight:400; line-height:12.77px; width:178px;}
	.diary2023_ranking .sect02_list .btn_cart{background:#fff; background:#F5F6F7; width:63px; height:32px; border-radius:4px; box-sizing:border-box; font-size:14px; line-height:16.8px; font-weight:500; color:#999; position:absolute; right:0; bottom:0; display:flex; align-items:center; padding-left:27px; padding-top:1px;}
	.diary2023_ranking .sect02_list .btn_cart::before{background:url(//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/cart.png?v=1.2) no-repeat; position:absolute; content:''; left:10px; width:15px; height:16px; background-size:contain; top:7px;}
	.diary2023_ranking .rangking_slide{width:100%; overflow:hidden; margin-bottom:32px; position:relative;}
	.diary2023_ranking .rangking_slide .swiper-slide{cursor:pointer; width:fit-content; height:29px; box-sizing:border-box; padding:7px 8px; text-align:center; font-size:14px; line-height:16.8px; font-weight:500; border:1px solid #ccc; border-radius:4px; margin-right:4px; color:#ccc;}
	.diary2023_ranking .rangking_slide .swiper-slide.on{border-color:#111; color:#111;}
	.diary2023_ranking .rangking_slide .swiper-button-prev::after{z-index:5; position:absolute; width:24px; height:24px; top:4px; right:0; background:url(//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/arrow_right02.png) no-repeat; background-size:100% 100%;}
	.diary2023_ranking .rangking_slide .swiper-button-disabled{display:none;}
	.diary2023_ranking .rangking_slide .swiper-button-next::after{z-index:5; position:absolute; width:24px; height:24px; top:3px; right:0; background:url(//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/arrow_right02.png) no-repeat; background-size:100% 100%;}
	.diary2023_ranking .rangking_slide .swiper-button-prev::after, .diary2023_ranking .rangking_slide .swiper-button-next::after{content:'';}
	.diary2023_ranking .rangking_slide .swiper-button-prev{position:absolute; left:-1px; top:22px; width:112px; height:30px; background:linear-gradient(270deg, #FFFFFF 41.11%, rgba(255, 255, 255, 0) 93.33%);z-index:2; transform:rotate(180deg);}
	.diary2023_ranking .rangking_slide .swiper-button-next{position:absolute; right:-1px; top:22px; width:112px; height:30px; background:linear-gradient(270deg, #FFFFFF 41.11%, rgba(255, 255, 255, 0) 93.33%);z-index:2;}
<style>[v-cloak] { display: none; }</style>
</head>
<body>
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <div class="eventContV15 tMar15">
        <div id="app" v-cloak></div>
    </div>
    <!-- #include virtual="/diarystory2023/cursor_drawing.asp" -->

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

    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue-awesome-swiper@4.1.1/dist/vue-awesome-swiper.min.js"></script>

    <script src="/vue/common/common.js?v=1.00"></script>

    <script src="/vue/diarystory2023/menu_component.js?v=1.00"></script>
    <script src="/vue/diarystory2023/store.js?v=1.00"></script>
    <script src="/vue/diarystory2023/ranking.js?v=1.00"></script>

    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->