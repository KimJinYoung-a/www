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
' Description :
' History :
'####################################################

dim eCode : eCode   = requestCheckVar(Request("eventid"),10) '이벤트 코드번호

IF application("Svr_Info") = "Dev" THEN
    eCode = "109407"
End If

%>

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>

<style>
/* common */
a:hover{text-decoration: none;}
.evt116455 .section{position:relative;}
.evt116455 .section .content{width:100%;height:703px;}
.evt116455 .section .content ul{position: relative;top: 97px;left: 50%;margin-left:-540px;width:1080px;height:350px;}
.evt116455 .section .content ul li{float:left;width:240px;overflow:hidden;margin:0 15px;margin-bottom: 35px;}
.evt116455 .desc{text-align:left;width:200px;margin-left:5px;}
.evt116455 .desc .name{font-size:14px;font-weight: bold;margin:-1px 0 13px;overflow: hidden;text-overflow:ellipsis;white-space:nowrap;color:#000;letter-spacing: -0.5px;}
.evt116455 .desc .price{font-size:17px;font-weight:bold;line-height:1.48;width:fit-content;position: relative;color:#111111;}
.evt116455 .desc .price::after{content:'원';position:absolute;right:-16px;bottom:0px;}
.evt116455 .desc .price span{margin-right:11px;color:#ff2241;float: left;}
.evt116455 .desc .price s{display:block;text-decoration:none;font-size:17px;color:#a0a79b;font-weight: normal;}
/*.evt116455 .thumbnail{width:240px;height:240px; overflow: hidden;}*/
.evt116455 .content .thumbnail{width:240px;height:240px; overflow: hidden;}
.evt116455 .brand{font-size:10px;margin-top:15px;color:#000;}
.evt116455 .thumbnail img {width:100%;}
.evt116455 .section .prd_main a{width:1010px;height:562px;position:absolute;left:50%;margin-left:-505px;top:328px;}
.evt116455 .section .btn{position:absolute;left:50%;margin-left:-180.5px;bottom:121px;width:361px;}

/* section01 */
.evt116455 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/116455/section01.jpg) no-repeat 50% 0;height:1147px;}
.evt116455 .section01 .float01{position:absolute;top:247px;left:50%;margin-left:251px;animation: updown 1.5s 0s ease-in-out infinite alternate;}
.evt116455 .section01 .float02{position:absolute;top:431px;left:50%;margin-left:-539px;animation: updown 1.8s 0s ease-in-out infinite alternate;}
/* section02 */
.evt116455 .section02{height:1693px;}
.evt116455 .section02_01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/116455/section02.jpg) no-repeat 50% 0;height:990px;}

/* section03 */
.evt116455 .section03_01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/116455/section03.jpg) no-repeat 50% 0;height:990px;}

/* section04 */
.evt116455 .section04_01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/116455/section04.jpg) no-repeat 50% 0;height:990px;}

/* section05 */
.evt116455 .section05{background:url(//webimage.10x10.co.kr/fixevent/event/2022/116455/section05.jpg) no-repeat 50% 0;height:440px;}
.evt116455 .link01{width:437px;height:97px;position:absolute;bottom:95px;left:50%;margin-left:-580px;}
.evt116455 .link02{width:437px;height:330px;position:absolute;left:50%;margin-left:94px;bottom:52px;}

/* timesale */
.evt116455 .timesale .main_time{width:960px;margin:108px auto 207px;position:relative;}
.evt116455 .timesale .main_time .prd_item{overflow: hidden;}
.evt116455 .timesale .main_time .prd_img{width:440px;height:440px;float:left;margin:0;}
.evt116455 .timesale .main_time .prd_img img{width:100%;}
.evt116455 .timesale .main_time .prd_info{text-align:left;margin-left:84px;width:calc(50% - 84px);float:left;}
.evt116455 .timesale .main_time .prd_date{width:422px;margin-bottom:29px;padding-bottom:21px;border-bottom:1px solid #000;}
.evt116455 .timesale .main_time .prd_date .date{font-size:54px;font-weight:800;color:#222;line-height:54px;letter-spacing:-0.03em;margin-left: 41px;}
.evt116455 .timesale .main_time .prd_date .date span{display:block;font-size:22px;font-weight:400;color:#686868;line-height:22px;margin-bottom:15px;letter-spacing:-0.01em;}
.evt116455 .timesale .main_time .prd_date .date span b{font-size:25px;font-weight:700;line-height:25px;letter-spacing:-0.11em;}
.evt116455 .timesale .main_time .prd_date .time{font-size:49px;line-height: 49px;font-weight: 700;color:#000;margin-top:81px;position:relative;width:fit-content;letter-spacing:-0.01em;margin-left: 41px;}
.evt116455 .timesale .main_time .prd_date .time::after{content:'';display:block;background: #FF0D38;width:12px;height:12px;border-radius:50%;position:absolute;top:-5px;right:-15px;animation: twinkle ease-in-out alternate;-webkit-animation: twinkle alternate .6s infinite;}
.evt116455 .timesale .main_time .prd_name{font-size:25px;letter-spacing:-0.03em;width:290px;font-weight:700;margin-left: 41px;}
.evt116455 .timesale .main_time .prd_price{margin-left:41px;margin-top:26px;font-size:28px;line-height:28px;letter-spacing:-0.01em;font-weight:700;color:#222;margin-top:10px;}
.evt116455 .timesale .main_time s{display:block;font-size:23px;line-height:23px;letter-spacing:-0.01em;font-weight:400;color:#8C8C8C;}
.evt116455 .timesale .main_time span{font-size:33px;line-height: 33px;letter-spacing:-0.01em;font-weight:700;color:#FF0D38;margin-left:10px;}
.evt116455 .timesale .main_time .prd_link{width:483px;height:77px;display:flex;align-items:center;justify-content:center;background-color:#090909;color:#fff;border-radius:50px;position:absolute;bottom:-130px;left:50%;margin-left:-241.5px;font-size:24px;}
.evt116455 .timesale .sub_time{background:#F8F3EB;overflow: hidden;}
.evt116455 .timesale .sub_time .time_list{width:970px;margin:80px auto;overflow: hidden;}
.evt116455 .timesale .sub_time .time_list li{width:220px;height:220px;float:left;margin-right:30px;position:relative;}
.time_list li:nth-child(1),.time_list li:nth-child(2),.time_list li:nth-child(3),.time_list li:nth-child(4){margin-bottom:30px;}
.time_list li:nth-child(4),.time_list li:nth-child(8){margin-right:0 !important;}
.evt116455 .timesale .sub_time .time_list li figure{margin:0;}
.evt116455 .timesale .sub_time .time_list li figure .mask{width:100%;height:100%;position:absolute;top:0;left:0;background-color:#686868;opacity: 0.15;}
.evt116455 .timesale .sub_time .time_list li img{width:100%;}
.evt116455 .timesale .sub_time .time_list li .time_date{font-size:20px;line-height:20px;font-weight:600;position:absolute;top:15px;left:8px;text-align:left;color:#fff;}
.evt116455 .timesale .sub_time .time_list li .time_date span{display:block;font-size: 30px;line-height:36px;letter-spacing:-0.05em;font-weight:500;}
.evt116455 .timesale .sub_time .time_list li.close a.more{display:none;}
.evt116455 .timesale .sub_time .time_list li.close figure .mask{background-color:#222;opacity: 0.2;}
.evt116455 .timesale .sub_time .time_list li.close figure img{filter: grayscale(100%);}
.evt116455 .timesale .sub_time .time_list li.close .time_date{text-align: center;font-size:26px;line-height:26px;position:absolute;top:80px;left:0;width:100%;}
.evt116455 .timesale .sub_time .time_list li a.more{width:31px;height:31px;position:absolute;right:8.4px;bottom:8.4px;}
.evt116455 .timesale .sub_time .time_list li a.more img{width:100%;}

.evt116455 .layerDeal{overflow:hidden;}
.evt116455 .layerDeal .title{height:118px;line-height:118px;font-size:20px;font-weight: 400;letter-spacing: -0.01em;}
.evt116455 .layerDeal .title span b{font-size:20px;font-weight: 500;letter-spacing: -0.01em;}
.evt116455 .layerDeal .itemArea .pdtBrand{font-size:19px;line-height:19px;letter-spacing: -0.02em;color:#818181;margin-top:61px;text-decoration: none;margin-bottom:35px;}
.evt116455 .layerDeal .itemArea .pdtBrand a{text-decoration: none;}
.evt116455 .layerDeal .itemArea .tit_pdtName{min-height:90px;font-size:26px;line-height:45px;letter-spacing:-0.01em;margin:0 auto;padding:0;}

.evt116455 .layerDeal .contents{height:730px;}
.evt116455 .layerDeal .deal_detail{margin-top:120px;}
.evt116455 .layerDeal .deal_list{padding:0 90px;padding-bottom:200px;margin-top:90px;}
.evt116455 .layerDeal .deal_list .itemDeal li > a:after{border:0;}
.evt116455 .layerDeal .deal_list .itemDeal .half{width:320px;height:437px;margin:0;margin-right:40px;margin-bottom:80px;}
.evt116455 .layerDeal .deal_list .itemDeal .half:nth-child(even){margin-right:0;}
.evt116455 .layerDeal .deal_list .itemDeal .half > a{width:320px;height:437px;padding:0;border:0;}
.evt116455 .layerDeal .deal_list .itemDeal .half .pdtPhoto, .itemweek .layerDeal .deal_list .itemDeal .half .pdtPhoto img{width:320px;height:320px;margin-bottom:20px;}
.evt116455 .layerDeal .itemDeal .pdtInfo{width:320px;}
.evt116455 .layerDeal .itemDeal .pdtName{margin-top:20px;font-size:20px;letter-spacing:-0.01em;font-weight: 400;height:none;line-height:28px;width:300px;height:54px;display:-webkit-box; -webkit-line-clamp:2;overflow:hidden; -webkit-box-orient: vertical;}
.evt116455.itemDeal .pdtList{display:flex;margin-top:-20px;flex-wrap:wrap;justify-content:space-around;}
.evt116455.itemDeal .half .pdtPhoto, .itemDeal .half .pdtPhoto img{width:320px;height:320px;}


@keyframes updown{
    0% {transform: translateY(20px);}
    100% {transform: translateY(-20px);}
}

@keyframes twinkle {
	0%{opacity: 0;}
	100%{opacity: 1;}
}
</style>

<div id="app"></div>

<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js" ></script>
<script>
    const eCode = '<%= eCode %>';
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
<script src="/vue/components/common/functions/common.js?v=1.00"></script>
<script type="text/babel" src="/vue/common/mixins/common_mixins.js?v=1.00"></script>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js?v=1.01"></script>
<script type="text/javascript" src="/event/lib/countdown.js"></script>

<script src="/vue/event/etc/116455/index.js?v=1.02"></script>