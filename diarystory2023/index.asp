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
	.diary2023 a{color:#111;}
	.diary2023 #contentWrap{width:100%; padding:0;}
	.diary2023_main .section01{width:100%; height:623px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/main_top_new02.jpg/10x10/optimize) no-repeat; background-size:auto; background-position:center top; overflow:hidden;position:relative;}
	.diary2023_main .section01 .blur02{position:absolute; width:182.2px; height:273.3px; left:50%; top:-138px; margin-left:-741px; background:radial-gradient(50% 50% at 50% 50%, rgba(57, 255, 219, 0.3) 0%, rgba(143, 255, 0, 0.15) 100%); mix-blend-mode:multiply; filter:blur(15px); border-radius:100px; transform:rotate(-62.45deg);}
	.diary2023_main .section01 .blur02::before{position:absolute; width:182.2px; height:273.3px; border-radius:100px; content:''; left:0; top:0; background:#FFF; opacity:0.5;}
	.diary2023_main .section01 .line01{display:none; position:absolute; width:1005.43px; height:444.95px; left:50%; top:-151px; margin-left:-1073px;}
	.diary2023_main .section01 .line02{display:none; position:absolute; width:736.5px; height:491px; left:50%; top:141.65px; margin-left:248px;}
	.diary2023_main .sect01_wrap{position:relative; width:1140px; margin:0 auto; padding:65px 0 54px 0; display:flex;}
	.diary2023_main .sect01_link .date.on{width:fit-content;}
	.diary2023_main .sect01_link .date.on p{font-size:28px; font-weight:600; line-height:27px; margin-bottom:30px;}
	.diary2023_main .sect01_link .date.on p a{color:#666;}
	.diary2023_main .sect01_link .ranking p{font-size:20px; font-weight:500; line-height:24px; margin-bottom:20px;}
	.diary2023_main .sect01_link .eventlink p{letter-spacing:-0.4px; max-width:240px; font-size:20px; font-weight:500; line-height:24px; margin-bottom:20px; overflow:hidden; text-overflow:ellipsis; display:-webkit-box; -webkit-line-clamp:1; -webkit-box-orient:vertical;}
	.diary2023_main .sect01_link .category p{font-size:20px; font-weight:500; line-height:24px;}
	.diary2023_main .sect01_link div p a{color:#242542;}
	.diary2023_main .search{margin-top:32px;}
	.diary2023_main .input_box{width:268px; height:40px; border-radius:20px; border:1px solid #999; background:transparent; display:flex; position:relative;}
	.diary2023_main .input_box .ico_search{width:24.07px; position:absolute; left:232px; top:7px;}
	.diary2023_main .input_box input{caret-color:#FF214F; background:transparent; margin-top:2px; font-size:14px; font-weight:500; line-height:16.8px; padding-left:16px;}
	.diary2023_main .input_box input::placeholder{color:#999;}
	.diary2023_main .reco_search{display:flex; margin:8px 0 0 14px; flex-wrap:wrap;}
	.diary2023_main .reco_search p{font-weight:400; letter-spacing:-0.4px; font-size:13px; line-height:16.8px; margin-right:8px;}
	.diary2023_main .sect01_link .reco_search p a{color:#111;}
	.diary2023_main .sect01_rolling{position:absolute; left:270px; margin-left:76px; z-index:1; width:920px;}
	.diary2023_main .sect01_rolling .main_slider{width:100%; display:flex;}
	.diary2023_main .sect01_rolling .slide{width:460px; height:504px; position:relative;}
	.diary2023_main .sect01_rolling .slide .slide_img{position:relative; width:100%; height:100%; overflow:hidden;}
	.diary2023_main .sect01_rolling .slide .slide_img img{position:absolute; left:20px; top:68px;}
	.diary2023_main .sect01_wrap .swiper-button-next:after, .diary2023_main .sect01_wrap .swiper-button-prev:after{display:none;}
	.diary2023_main .sect01_wrap .prev{cursor:pointer; position:absolute; width:40px; height:40px; top:304px; left:277px; transform:rotate(180deg);}
	.diary2023_main .sect01_wrap .next{cursor:pointer; position:absolute; width:40px; height:40px; top:304px; left:1216px;}
	.diary2023_main .sect01_wrap .swiper-pagination{position:absolute; bottom:8px; left:50%; margin:0; padding:0; transform:translateX(-50%); width:fit-content; margin-left:-38px;}
	.diary2023_main .sect01_wrap .swiper-pagination .swiper-pagination-bullet{float:left; margin:0 4px 0 0;}
	.diary2023_main .sect01_wrap .swiper-pagination .swiper-pagination-bullet:last-child{margin:0;}
	.diary2023_main .sect01_wrap .swiper-pagination .swiper-pagination-bullet{background:#00000033; opacity:unset; width:6px; height:6px; border-radius:50%; border:none; text-indent:-9999px;}
	.diary2023_main .sect01_wrap .swiper-pagination .swiper-pagination-bullet-active{background:#FF214F;}
	.diary2023_main .sect01_rolling .slide_info{position:absolute; top:0; left:0;}
	.diary2023_main .sect01_rolling .slide_info p{width:353px; overflow:hidden; text-overflow:ellipsis; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; margin-bottom:4px; font-weight:700; font-size:16px; line-height:24px;}
	.diary2023_main .sect01_rolling .slide_info .blue{font-weight:700; font-size:14px; line-height:20px; color:#FF214F;}
	.diary2023_main .sect01_rolling .slide_info .blue span{font-weight:600; font-size:14px; line-height:20px;}
	.diary2023_main .sect01_rolling .slide_info .number{-webkit-text-stroke:1.2px #000; text-stroke:1.2px #000; font-size:32px; line-height:31px; font-weight:600; color:transparent; margin-bottom:4px; height:30.99px;}
	.diary2023_main .sect01_rolling .slide_info .badge p{font-size:12px; font-weight:700; line-height:14.4px; text-align:center; color:#FF214F; background:transparent; width:52px; height:24px; box-sizing:border-box; margin-top:19px; display:flex; justify-content:center; align-items:center; border:0.5px solid #FF214F; white-space:nowrap;}
	.diary2023_main .sect01_inform{font-size:13px; line-height:18px; font-weight:500; position:absolute; color:#999; right:-104px; top:534px;}
	.diary2023_main .sect02_event{ width:1140px; margin:0 auto; padding:40px 0 80px 0; display:flex;flex-wrap:wrap;}
	.diary2023_main .sect02_event .event_wrap{position:relative;width:364px; margin:0 24px 60px 0;}
	.diary2023_main .sect02_event .event_wrap:nth-of-type(3n){margin:0 0 60px 0;}
	.diary2023_main .sect02_event .event_img{width:364px; height:250px; overflow:hidden; position:relative;}
	.diary2023_main .sect02_event .event_img img{border-radius:20px 0;}
	.diary2023_main .sect02_event .event_img::after{position:absolute; content:''; width:100%; height:100%; background:black; opacity:0.05; left:0; border-radius:20px 0;}
	.diary2023_main .sect02_event .event_info{display:flex; margin-top:16px; justify-content:space-between;}
	.diary2023_main .sect02_event .event_info p{width:267px; font-size:16px; font-weight:600; line-height:24px; overflow:hidden; text-overflow:ellipsis; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical;}
	.diary2023_main .sect02_event .event_info .blue{text-align:right; width:calc(100% - 267px); font-size:14px; font-weight:700; line-height:20px; color:#FF214F; margin:1px 1px 0 0;}
	.diary2023_main .sect02_event .event_info .blue span{font-weight:600;}
	.diary2023_main .sect02_event .badge{z-index:2; position:absolute; font-size:12px; font-weight:700; padding-top:2px; line-height:14.4px; text-align:center; color:#FF214F; background:#FFFFFFCC; width:52px; height:24px; box-sizing:border-box; top:12px; right:12px; display:flex; justify-content:center; align-items:center; border:0.5px solid #FF214F; white-space:nowrap;}

</style>
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
			fnAmplitudeEventAction('click_diarystory_best', 'item_id', itemid);
            parent.location.href='/shopping/category_prd.asp?itemid='+itemid;
            return false;
        }

        function goEventLink(evt) {
			fnAmplitudeEventAction('click_diarystory_event', 'event_code', evt);
        	parent.location.href='/event/eventmain.asp?eventid='+evt;
        }
    </script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>

    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
    <link rel="stylesheet"href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/vue-awesome-swiper@4.1.1/dist/vue-awesome-swiper.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>


    <script src="/vue/common/common.js?v=1.00"></script>

    <script src="/vue/diarystory2023/menu_component.js?v=1.00"></script>
    <script src="/vue/diarystory2023/store.js?v=1.00"></script>
    <script src="/vue/diarystory2023/index.js?v=1.00"></script>

    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->