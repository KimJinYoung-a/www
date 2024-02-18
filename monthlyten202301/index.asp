<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 월간텐텐
' History : 2022.12.03 정태훈 생성
'####################################################

if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
    if Not(Request("mfg")="pc" or session("mfg")="pc") then
        if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
            Response.Redirect "//m.10x10.co.kr/universal/"
            REsponse.End
        end if
    end if
end if

dim tabType : tabType = RequestCheckVar(request("tabType"),7)

'If tabType = "" Then '//초기 진입시 혜택 탭
'    tabType = "benefit"
'End if

dim eCode
IF application("Svr_Info") = "Dev" THEN
    eCode = "119233"
ElseIf application("Svr_Info")="staging" Then
    eCode = "121346"
Else
    eCode = "121346"
End If
%>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<style>
.monthlyten{position:relative;}
.monthlyten li{list-style:none;}
.monthlyten section{position:relative;width:1920px;left:50%;transform:translateX(-50%);}
.monthlyten .sec_title{font-size:41px;line-height: 52px;text-align:center;font-weight:700; color:#111; padding-left:106px;}
.monthlyten .sec_title span{display:block;font-size:21px;line-height:33px;margin-bottom:5px;font-weight:400; color:#B18F9A;}
.monthlyten a:hover{text-decoration:none;}
.monthlyten .top .top01{position:relative; height:500px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/top_back_01.jpg) no-repeat; background-size:contain;}
.monthlyten .top .top02{position:relative; height:500px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/top_back_02.jpg) no-repeat; background-size:contain;}
.monthlyten .top .top03{position:relative; height:500px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/top_back_03.jpg) no-repeat; background-size:contain;}
.monthlyten .top .rabbit{position:absolute; width:412px; left:50%; margin-left:-167px; top:31px; transform:rotate(-5deg); animation:swing 1.3s ease-in-out alternate infinite;}
.monthlyten .top .top02 .rabbit{top:19px;}
.monthlyten .top .top03 .rabbit{top:27px;}
.monthlyten .top .rabbit img{width:100%;}
.monthlyten .sec_brand{background:#FDCADB; padding:65px 0 55px; position:relative;}
.monthlyten .sec_brand .sec_title{padding-bottom:39px;}
.monthlyten .sec_brand::before{width:327px; height:100%; position:absolute; content:''; transform:matrix(-1, 0, 0, 1, 0, 0); background:linear-gradient(270deg, #FDCADB 15.29%, rgba(253, 202, 219, 0) 100%); left:0; top:0; z-index:2;}
.monthlyten .sec_brand::after{width:327px; height:100%; position:absolute; content:''; background:linear-gradient(270deg, #FDCADB 15.29%, rgba(253, 202, 219, 0) 100%); right:0; top:0; z-index:2;}
.monthlyten .sec_brand .swiper-wrapper{margin-bottom:15px; transition-timing-function:linear;}
.monthlyten .sec_brand .swiper-slide{width:134px; margin-right:15px;}
.monthlyten .sec_brand .swiper-slide img{width:132px; height:180px;}
.monthlyten .sec_curation{padding:65px 0 71px 0; background:#FFE5EE;}
.monthlyten .sec_curation .sec_title{margin-bottom:42px;}
.monthlyten .sec_curation .sec_title span{margin-bottom:8px;}
.monthlyten .sec_curation .bnr_rabbit{margin:0 auto; padding-left:105px;}
.monthlyten .sec_curation .bnr_rabbit img{width:989px;}
.monthlyten .sec_curation .prd_list{padding-top:32px; position:relative; padding-bottom:51px; padding-left:100px;}
.monthlyten .prd_list{width:895px; display:flex; flex-wrap:wrap; margin:0 auto; justify-content:space-between;}
.monthlyten .prd_list .prd_item{width:285px; padding-bottom:51px; position:relative;}
.monthlyten .prd_list .prd_item .thumbnail{width:285px; height:285px; overflow:hidden;}
.monthlyten .prd_list .prd_item .thumbnail img{width:100%;}
.monthlyten .prd_list .prd_item .desc{padding:20px 10px 0;}
.monthlyten .prd_list .prd_item .desc .name{padding-top:4px; font-size:14px; color:#111; font-weight:400; line-height:16.69px; text-align:left;  overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;}
.monthlyten .prd_list .prd_item .desc .price s{display:block; font-size:16px; line-height:15.71px; font-weight:300; color:#666;}
.monthlyten .prd_list .prd_item .desc .price {font-weight:600; font-size:18px; color:#111; letter-spacing:-0.05em; text-align:left;}
.monthlyten .prd_list .prd_item .desc .price .sale {margin-left:4px; font-weight:600; font-size:14px; color:#FF214F; letter-spacing:-0.05em;}
.monthlyten .prd_list .prd_item .desc .brand{font-size:13px; line-height:12.77px; font-weight:400; color:#666; text-align: left; padding-top:7px;}
.monthlyten .prd_list .user_comment {font-size:1rem; color:var(--c_666);}
.monthlyten .prd_list .prd_link {position:absolute; top:0; right:0; bottom:0; left:0; z-index:10;}
.monthlyten .prd_list .blind {font-size:0; text-indent: -9999px;}
.monthlyten .prd_list .user_side {padding-top:10px; text-align:left; padding-left:10px;}
.monthlyten .prd_list .user_side .user_eval {display: inline-block;position: relative;width: 50px;height: 10px;}
.monthlyten .prd_list .user_side .user_eval::before {width:100%; content:' '; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3e%3cpath fill='none' stroke='%23FF214F' stroke-width='2' d='M24.006 5c.026 0 .052.008.074.024h0l6.442 12.24 13.856 1.943c.221.042.4.109.52.22.062.06.097.133.101.212.009.152-.056.308-.153.457-.154.235-.398.446-.712.613h0l-9.46 8.752 1.965 11.632c.133.594.187 1.082.14 1.466-.02.155-.035.3-.134.377-.11.087-.272.072-.449.058-.396-.03-.87-.175-1.422-.41h0L23.97 37.007l-10.71 5.58c-.551.233-1.025.377-1.42.408-.177.014-.34.03-.45-.058-.098-.077-.113-.222-.132-.377-.048-.384.005-.872.139-1.466h0L13.36 29.46l-9.459-8.75a2.02 2.02 0 01-.74-.635c-.1-.15-.169-.305-.16-.457a.266.266 0 01.093-.185c.128-.114.32-.181.558-.224h0l13.865-1.945 6.209-12.045a.533.533 0 01.162-.179.227.227 0 01.118-.039z'/%3e%3c/svg%3e");}
.monthlyten .prd_list .user_side .user_eval i {font-size:0; color:transparent; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3e%3cpath fill='%23FF214F' fill-rule='evenodd' d='M25.093 4.737l6.077 11.608 13.369 1.875c1.963.357 1.87 2.322.187 3.304l-8.975 8.304 1.87 11.073c.654 2.946-.561 3.75-3.273 2.59l-10.377-5.359-10.284 5.358c-2.712 1.16-3.927.357-3.273-2.59l1.87-11.072-8.975-8.304c-1.683-.982-1.87-2.947.187-3.304l13.37-1.875 5.983-11.608c.56-.983 1.776-.983 2.244 0z'/%3e%3c/svg%3e");}
.monthlyten .prd_list .user_side .user_comment {font-size:12px; font-weight:300; color:#666;}
.monthlyten .prd_list .user_side .user_eval i {position:absolute; top:0; left:0; height:100%; background-position:left center; background-repeat:repeat-x; background-size:auto 100%;}
.monthlyten .prd_list dfn {display:none;}
.monthlyten .prd_list .btn_more{font-size:19px; line-height:22.8px; padding:18px 0 16px 0; box-sizing:border-box; font-weight:500; display:flex; align-items:center; justify-content:center; width:261px; position:absolute; border:1px solid #333; bottom:0; left:50%; transform:translateX(-50%); color:#000; margin-left:48px;}
.monthlyten .sec_benefit{padding:74px 0 47px 0; background:#252525;}
.monthlyten .sec_benefit .sec_title{margin-bottom:49px; color:#fff; font-size:41px; line-height:34.5px; display:flex; justify-content:center;}
.monthlyten .sec_benefit .sec_title .user_name{position:relative;}
.monthlyten .sec_benefit .sec_title .user_name::before{position:absolute; content:''; width:100%; height:2px; background:#fff; left:0; bottom:-4px;}
.monthlyten .sec_benefit .bene_list{padding-left:106px; display:flex; flex-wrap:wrap; justify-content:space-between; width:720px; margin:0 auto;}
.monthlyten .sec_benefit .bene_list .benefit{width:350px; padding:15px 0 11px; border-radius:51px; background:#fff; margin-bottom:21px; display:flex; align-items:center; justify-content:center; color:#111; font-size:20px; line-height:47.8px; font-weight:500;}
.monthlyten .sec_benefit .bene_list .benefit span{color:#ea4076;}
.monthlyten .sec_benefit .bene_list .benefit.on{color:#fff; background:#ea4076;}
.monthlyten .sec_benefit .bene_list .benefit.on span{color:#fff;}
.monthlyten .sec_coupon{background:#fff; padding:73px 0 68px 0;}
.monthlyten .sec_coupon .sec_title{padding-bottom:48px;}
.monthlyten .sec_coupon .coupon_list .coupon_img{display:flex; justify-content:space-between; width:664px; margin:0 auto; padding-bottom:22px;}
.monthlyten .sec_coupon .coupon_list .coupon_img img{width:322px; height:174px;}
.monthlyten .sec_coupon .coupon_list .coupon_info{color: #8a8a8a; padding-bottom:36px; font-size:18px; line-height:21.6px; font-weight:300;}
.monthlyten .sec_coupon .coupon_list .coupon_info02{color: #8a8a8a; padding:15px 0 58px 0; font-size:16px; line-height:19.2px; font-weight:300;}
.monthlyten .sec_coupon .coupon_list .btn_coupon{background:#161616; color:#fff; font-size:19px; line-height:15.5px; font-weight:500; width:261px; padding:23px 0 19px 0; display:flex; align-items:center; justify-content:center; margin:0 auto;}
.monthlyten .sec_coupon .coupon_list{padding-left:106px;}
.monthlyten .sec_coupon .coupon_list02{margin:0 auto; width:895px; height:275px; padding-left:106px;}
.monthlyten .sec_coupon .coupon_list02 img{width:100%;}
.monthlyten .sec_today{background:#FFE76A; padding:74px 0 66px 0;}
.monthlyten .sec_today .sec_title span{padding:12px 0 45px 0; color:#7D6D15;}
.monthlyten .sec_today .prd_list.t02{display:flex; flex-wrap:nowrap; width:986px; padding-left:106px;}
.monthlyten .sec_today .prd_list.t02 li{width:230px; position:relative;}
.monthlyten .sec_today .prd_list.t02 li .thumbnail{width:230px; height:285px; overflow:hidden;}
.monthlyten .sec_today .prd_list.t02 li .thumbnail img{width:285px; height:100%; margin-left:-27.5px;}
.monthlyten .sec_sale{padding:66px 0 3px 105px; background:#fff;}
.monthlyten .sec_sale .sec_title{margin-bottom:40px; padding-left:0;}
.monthlyten .sec_sale .prd_list{padding:80px 47px 127px 47px; box-sizing:border-box; position:relative; width:989px; margin:0 auto;}
.monthlyten .sec_sale .prd_list .category{width:100%; position:absolute; left:0; padding:29px 0 26px 0; top:0; text-align:center; color:#000; font-size:21px; line-height:25.2px; font-weight:700; background:#FCF6EE;}
.monthlyten .sec_sale .prd_list .category a{display:flex; align-items:center; justify-content:center; width:100%; height:100%;}
.monthlyten .sec_sale .prd_list .category span{position:absolute; width:22px; height:22px; right:31px; top:27px;}
.monthlyten .sec_sale .prd_list .category span img{width:100%;}
.monthlyten .sec_sale .prd_list .btn_more{bottom:70px; margin-left:8px;}
.monthlyten .sec_sale .prd_list .prd_item{padding:32px 0 51px 0;}
.monthlyten .sec_event{padding:67px 0 72px 0; background:#252525;}
.monthlyten .sec_event .sec_title{color:#fff; margin-bottom:43px;}
.monthlyten .sec_event .sec_title span{padding-top:11px; color:#afafaf;}
.monthlyten .sec_event .event_list{display:flex; flex-wrap:wrap; justify-content:center; width:916px; margin:0 auto; padding-left:106px;}
.monthlyten .sec_event .event_list p{width:438px; height:180px; margin:0 10px 20px 10px;}
.monthlyten .sec_event .event_list p img{width:100%;}
.monthlyten .sec_event .qr_app{padding-top:30px; margin:auto; width:801px; height:233px; padding-left:106px;}
.monthlyten .sec_event .qr_app img{width:100%;}

.monthlyten .tab-area{position:absolute;top:1145px;left:50%;margin-left:-570px;}
.monthlyten .tab-area.fixed{position:fixed;top:90px;left:50%;margin-left:-570px;}
.monthlyten .tab-area div{padding-bottom:2px;}
.monthlyten .tab-area .tab05 a{background:transparent; padding:0; margin-top:8px;}
.monthlyten .tab-area .tab06 a{background:transparent; padding:0; margin-top:10px;}
.monthlyten .tab-area .tab05 img{width:79px;}
.monthlyten .tab-area .tab06 img{width:79px;}
.monthlyten .tab-area div.on a{background:#000;color:#fff; font-weight:500; line-height:20px;}
.monthlyten .tab-area a{width:80px;padding:24px 0 20px 0; display:flex;justify-content:center;align-items:center;flex-direction:column;background:#FDF2F6;color:#7B7B7B;font-weight:400;font-size:14px;line-height:18px;letter-spacing:-0.05em;}
.monthlyten .tab-area a span{color:#FF214F;margin-top:5px;}
@keyframes swing {
    0% {transform:rotate(-5deg);}
    100% {transform:rotate(5deg);}
}
/* 팝업 */
.monthlyten .popup{position:fixed; left:50%; top:44%; transform:translate(-50%,-50%); padding-right:2px; z-index:107; width:430px; background:#fff; border-radius:16px;}
.monthlyten .dim{position:fixed; left:0; top:0; width:100%; height:100%; background: rgba(0, 0, 0, 0.7); z-index:106;}
.monthlyten .popup .btn_close{width:28px;height:28px;position:absolute;top:18px;left:18px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/btn_close.png) no-repeat 50%; background-size:100%;}
.monthlyten .pop01{padding:56px 0 52px 0;}
.monthlyten .popup h2{font-size:21px; line-height:21px; font-weight:700; color:#000;}
.monthlyten h2 li:nth-of-type(1){padding-bottom:11px;}
.monthlyten .pop01 .txt01{padding:29px 0 14px 0; font-size:16px; line-height:24px; font-weight:400; color:#606060;}
.monthlyten .pop01 .btn_agree{background:#161616; width:261px; height:57px; display:flex; align-items:center; justify-content:center; color:#fff; font-size:19px; line-height:15.5px; font-weight:500; margin:auto;}
.monthlyten .pop02{padding:78px 0 72px 0;}
.monthlyten .pop02 .txt01{color:#333; padding-top:15px; font-size:16px; line-height:24px; font-weight:400;}
</style>
<style>[v-cloak] { display: none; }</style>
</head>
<body>
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <div class="eventContV15 tMar15">
        <div class="contF contW" style="background:#fff;">
            <div id="app" v-cloak></div>
        </div>
    </div>
    <script type="text/javascript">
        const loginUserLevel = "<%= GetLoginUserLevel %>";
        const userid = "<%= GetLoginUserID %>";
        const server_info = "<%= application("Svr_Info") %>";
        let eventid = "";
        let tabType="";
        let isUserLoginOK = "";
        let sysdt = new Date(<%=year(now)%>,<%=month(now)-1%>,<%=day(now)%>,<%=hour(now)%>,<%=minute(now)%>,<%=second(now)%>).getTime();
        <%''let sysdt = new Date(2022, 11, 12, 18, 0, 0).getTime();%>
        isUserLoginOK = false;
        <% IF IsUserLoginOK THEN %>
            isUserLoginOK = true;
        <% END IF %>
        eventid = "<%=eCode%>";
        tabType = "<%=tabType%>";

        function goProduct(itemid) {
            parent.location.href='/shopping/category_prd.asp?itemid='+itemid;
            return false;
        }

        function goEventLink(evt) {
        	parent.location.href='/event/eventmain.asp?eventid='+evt;
        }
    </script>

    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
	<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>
    
    <script src="/vue/common/common.js?v=1.00"></script>
    <script src="/vue/components/common/functions/item_mixins.js?v=1.0"></script>
    <script src="/vue/components/common/functions/modal_mixins.js?v=1.0"></script>
    <script src="/vue/components/common/functions/common_mixins.js?v=1.0"></script>

	<script src="/vue/monthlyten202301/index.js?v=1.00"></script>

    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->