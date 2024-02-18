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
.itemweek section{position:relative;}
.itemweek section a:hover{text-decoration:none;}
.itemweek dfn{display:none;}

.itemweek .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2021/115376/bg_main.jpg)no-repeat 50% 0;height:1860px;}

/* timesale */
.itemweek .timesale .main_time{width:960px;margin:108px auto 207px;position:relative;}
.itemweek .timesale .main_time .prd_item{overflow: hidden;}
.itemweek .timesale .main_time .prd_img{width:440px;height:440px;float:left;margin:0;}
.itemweek .timesale .main_time .prd_img img{width:100%;}
.itemweek .timesale .main_time .prd_info{text-align:left;margin-left:84px;width:calc(50% - 84px);float:left;}
.itemweek .timesale .main_time .prd_date{width:422px;margin-bottom:29px;padding-bottom:21px;border-bottom:1px solid #000;}
.itemweek .timesale .main_time .prd_date .date{font-size:54px;font-weight:800;color:#222;line-height:54px;letter-spacing:-0.03em;margin-left: 41px;}
.itemweek .timesale .main_time .prd_date .date span{display:block;font-size:22px;font-weight:400;color:#686868;line-height:22px;margin-bottom:15px;letter-spacing:-0.01em;}
.itemweek .timesale .main_time .prd_date .date span b{font-size:25px;font-weight:700;line-height:25px;letter-spacing:-0.11em;}
.itemweek .timesale .main_time .prd_date .time{font-size:49px;line-height: 49px;font-weight: 700;color:#000;margin-top:81px;position:relative;width:fit-content;letter-spacing:-0.01em;margin-left: 41px;}
.itemweek .timesale .main_time .prd_date .time::after{content:'';display:block;background: #FF0D38;width:12px;height:12px;border-radius:50%;position:absolute;top:-5px;right:-15px;animation: twinkle ease-in-out alternate;-webkit-animation: twinkle alternate .6s infinite;}
.itemweek .timesale .main_time .prd_name{font-size:25px;letter-spacing:-0.03em;width:290px;font-weight:700;margin-left: 41px;}
.itemweek .timesale .main_time .prd_price{margin-left:41px;margin-top:26px;font-size:28px;line-height:28px;letter-spacing:-0.01em;font-weight:700;color:#222;margin-top:10px;}
.itemweek .timesale .main_time s{display:block;font-size:23px;line-height:23px;letter-spacing:-0.01em;font-weight:400;color:#8C8C8C;}
.itemweek .timesale .main_time span{font-size:33px;line-height: 33px;letter-spacing:-0.01em;font-weight:700;color:#FF0D38;margin-left:10px;}
.itemweek .timesale .main_time .prd_link{width:483px;height:77px;display:flex;align-items:center;justify-content:center;background-color:#090909;color:#fff;border-radius:50px;position:absolute;bottom:-130px;left:50%;margin-left:-241.5px;font-size:24px;}
.itemweek .timesale .sub_time{background:#F8F3EB;overflow: hidden;}
.itemweek .timesale .sub_time .time_list{width:970px;margin:80px auto;overflow: hidden;}
.itemweek .timesale .sub_time .time_list li{width:220px;height:220px;float:left;margin-right:30px;position:relative;}
.time_list li:nth-child(1),.time_list li:nth-child(2),.time_list li:nth-child(3),.time_list li:nth-child(4){margin-bottom:30px;}
.time_list li:nth-child(4),.time_list li:nth-child(8){margin-right:0 !important;}
.itemweek .timesale .sub_time .time_list li figure{margin:0;}
.itemweek .timesale .sub_time .time_list li figure .mask{width:100%;height:100%;position:absolute;top:0;left:0;background-color:#686868;opacity: 0.15;}
.itemweek .timesale .sub_time .time_list li img{width:100%;}
.itemweek .timesale .sub_time .time_list li .time_date{font-size:20px;line-height:20px;font-weight:600;position:absolute;top:15px;left:8px;text-align:left;color:#fff;}
.itemweek .timesale .sub_time .time_list li .time_date span{display:block;font-size: 30px;line-height:36px;letter-spacing:-0.05em;font-weight:500;}
.itemweek .timesale .sub_time .time_list li.close a.more{display:none;}
.itemweek .timesale .sub_time .time_list li.close figure .mask{background-color:#222;opacity: 0.2;}
.itemweek .timesale .sub_time .time_list li.close figure img{filter: grayscale(100%);}
.itemweek .timesale .sub_time .time_list li.close .time_date{text-align: center;font-size:26px;line-height:26px;position:absolute;top:80px;left:0;width:100%;}
.itemweek .timesale .sub_time .time_list li a.more{width:31px;height:31px;position:absolute;right:8.4px;bottom:8.4px;}
.itemweek .timesale .sub_time .time_list li a.more img{width:100%;}

/* hashtag */
.itemweek section .item{position:relative;}
.itemweek section .hashtag{position:absolute;}
.itemweek section .hashtag .hash{float:left;margin-right:8px;}
.itemweek section .item .sub_pro{width:832px;height:530px;}
.itemweek section .item .sub_pro a{width:220px;height:230px;position:absolute;}
.itemweek section .left .hashtag{top:175px;left:50%;margin-left:110px;}
.itemweek section .left .main_pro{width:480px;height:74px;display:block;position:absolute;top:398px;left:50%;margin-left:85px;}
.itemweek section .left .sub_pro{position:absolute;top:541px;left:50%;margin-left:-541px;}
.itemweek section .left .sub_pro a.sub01{top:280px;left:0;}
.itemweek section .left .sub_pro a.sub02{top:300px;left:248px;}
.itemweek section .left .sub_pro a.sub03{top:200px;left:470px;}
.itemweek section .left .sub_pro a.sub04{top:0;right:0;}
.itemweek section .right .hashtag{top:175px;right:50%;margin-right:110px;}
.itemweek section .right .main_pro{width:480px;height:74px;display:block;position:absolute;top:398px;right:50%;margin-right:86px;}
.itemweek section .right .sub_pro{position:absolute;top:546px;left:50%;margin-left:-263px;}
.itemweek section .right .sub_pro a.sub01{top:0;left:0;}
.itemweek section .right .sub_pro a.sub02{top:200px;left:143px;}
.itemweek section .right .sub_pro a.sub03{top:300px;left:370px;}
.itemweek section .right .sub_pro a.sub04{top:280px;right:0;}
.itemweek section .hashtag .hash a{font-size:12pt;padding:10px 15px;background:#ffff00;border-radius: 50px;color:#000;font-weight:500;}


.itemweek .section03 .item01{background:url(//webimage.10x10.co.kr/fixevent/event/2021/115376/item01.jpg)no-repeat 50% 0;height:1412px;}
.itemweek section .item01 .hashtag{top:310px;left:50%;margin-left:110px;}
.itemweek section .item04 .hashtag{margin-right:110px;}
.itemweek section .item01 .main_pro{width:480px;height:74px;display:block;position:absolute;top:540px;left:50%;margin-left:85px;}
.itemweek section .item01 .sub_pro{position:absolute;top:680px;left:50%;margin-left:-542px;}
.itemweek .section03 .item02{background:url(//webimage.10x10.co.kr/fixevent/event/2021/115376/item02.jpg)no-repeat 50% 0;height:1281px;}
.itemweek .section03 .item03{background:url(//webimage.10x10.co.kr/fixevent/event/2021/115376/item03.jpg)no-repeat 50% 0;height:1279px;}
.itemweek .section03 .item04{background:url(//webimage.10x10.co.kr/fixevent/event/2021/115376/item04.jpg)no-repeat 50% 0;height:1280px;}
.itemweek .section03 .item05{background:url(//webimage.10x10.co.kr/fixevent/event/2021/115376/item05.jpg)no-repeat 50% 0;height:1350px;}

.itemweek .section04{background:url(//webimage.10x10.co.kr/fixevent/event/2021/115376/bg_coupon.jpg)no-repeat 50% 0;height:1214px;}

.itemweek .layerDeal{overflow:hidden;}
.itemweek .layerDeal .title{height:118px;line-height:118px;font-size:20px;font-weight: 400;letter-spacing: -0.01em;}
.itemweek .layerDeal .title span b{font-size:20px;font-weight: 500;letter-spacing: -0.01em;}
.itemweek .layerDeal .itemArea .pdtBrand{font-size:19px;line-height:19px;letter-spacing: -0.02em;color:#818181;margin-top:61px;text-decoration: none;margin-bottom:35px;}
.itemweek .layerDeal .itemArea .pdtBrand a{text-decoration: none;}
.itemweek .layerDeal .itemArea .tit_pdtName{min-height:90px;font-size:26px;line-height:45px;letter-spacing:-0.01em;margin:0 auto;padding:0;}

.itemweek .layerDeal .contents{height:730px;}
.itemweek .layerDeal .deal_detail{margin-top:120px;}
.itemweek .layerDeal .deal_list{padding:0 90px;padding-bottom:200px;margin-top:90px;}
.itemweek .layerDeal .deal_list .itemDeal li > a:after{border:0;}
.itemweek .layerDeal .deal_list .itemDeal .half{width:320px;height:437px;margin:0;margin-right:40px;margin-bottom:80px;}
.itemweek .layerDeal .deal_list .itemDeal .half:nth-child(even){margin-right:0;}
.itemweek .layerDeal .deal_list .itemDeal .half > a{width:320px;height:437px;padding:0;border:0;}
.itemweek .layerDeal .deal_list .itemDeal .half .pdtPhoto, .itemweek .layerDeal .deal_list .itemDeal .half .pdtPhoto img{width:320px;height:320px;margin-bottom:20px;}
.itemweek .layerDeal .itemDeal .pdtInfo{width:320px;}
.itemweek .layerDeal .itemDeal .pdtName{margin-top:20px;font-size:20px;letter-spacing:-0.01em;font-weight: 400;height:none;line-height:28px;width:300px;height:54px;display:-webkit-box; -webkit-line-clamp:2;overflow:hidden; -webkit-box-orient: vertical;}
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

<script src="/vue/event/itemweek/jsonData.js?v=1.00"></script>
<script>
    const event_data = event_<%= eCode %>;
</script>
<script src="/vue/event/itemweek/index.js?v=1.02"></script>