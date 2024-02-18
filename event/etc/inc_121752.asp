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
    eCode = "119242"
End If

%>

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>

<style>
div.fullEvt #contentWrap .eventWrapV15 {width: unset;left: unset;transform: unset;}
a:hover{text-decoration: none;}
.evt121752{background:#fff;}
.evt121752 section{position:relative;}
.evt121752 .prd_area{width:520px;height:400px;position:absolute;left:50%;}
.evt121752 .prdlist01{top:503px;margin-left:-549px;}
.evt121752 .prdlist02{top:503px;margin-left:35px;}
.evt121752 .prdlist03{top:1114px;margin-left:-549px;}
.evt121752 .prdlist04{top:1114px;margin-left:35px;}
.evt121752 .prd_area ul{position:relative;width:100%;height:400px; display:flex; flex-wrap:nowrap;}
.evt121752 .prd_area ul li{float:left;width:250px;overflow:hidden;margin:0 5px;}
.evt121752 .prd_area .desc{text-align:left;width:233px;margin-left:5px;}
.evt121752 .prd_area .desc .name{font-size:14px;font-weight: bold;margin:-1px 0 13px;overflow: hidden;text-overflow:ellipsis;white-space:nowrap;color:#040404;letter-spacing: -0.5px;}
.evt121752 .prd_area .desc .price{font-size:17px;font-weight:bold;line-height:1.48;width:fit-content;position: relative;color:#000000;}
.evt121752 .prd_area .desc .price::after{content:'원';position:absolute;right:-16px;bottom:0px;}
.evt121752 .prd_area .desc .price span{margin-right:4px;color:#ff1461;float: left;}
.evt121752 .prd_area .desc .price s{display:block;text-decoration:none;font-size:17px;color:#a0a79b;font-weight: normal;}
.evt121752 .prd_area .thumbnail{width:240px;height:240px; overflow: hidden;}
.evt121752 .prd_area .brand{font-size:10px;margin-top:20px;color:#000;}
.evt121752 .prd_area .thumbnail img {width:100%; height:100%;}
.evt121752 .top{background:url(//webimage.10x10.co.kr/fixevent/event/2022/121752/top.jpg) no-repeat 50% 0;height:997px;}
.evt121752 .top .float img{position:absolute; left:50%;}
.evt121752 .top .float .float_d{width:191px;top:146px;margin-left:-332px;animation: updown 1.5s 0s ease-in-out infinite alternate;}
.evt121752 .top .float .float_i{width:79px;top:89px;margin-left:-151px;animation: updown 1.5s 0.3s ease-in-out infinite alternate;}
.evt121752 .top .float .float_a{width:178px;top:174px;margin-left:-101px;animation: updown 1.2s 0s ease-in-out infinite alternate;}
.evt121752 .top .float .float_r{width:171px;top:102px;margin-left:46px;animation: updown 1.2s 0.3s ease-in-out infinite alternate;}
.evt121752 .top .float .float_y{width:161px;top:174px;margin-left:206px;animation: updown 1.3s 0s ease-in-out infinite alternate;}
.evt121752 .top_sub{background:url(//webimage.10x10.co.kr/fixevent/event/2022/121752/top_sub.jpg) no-repeat 50% 0;height:929px;}
.evt121752 .item_list{background:url(//webimage.10x10.co.kr/fixevent/event/2022/121752/item_list.jpg) no-repeat 50% 0;height:1093px;}
.evt121752 .item_list .item_link{width:1228px; height:532px; display:flex; position:absolute; top:295px; left:50%; margin-left:-614px;}
.evt121752 .item_list .item_link p{width:33.33%; height:100%;}
.evt121752 .item_list .item_link p a{width:100%; height:100%; display:inline-block;}
.evt121752 .item_list .item_more{width:506px; height:97px; position:absolute; bottom:111px; left:50%; margin-left:-253px; display:inline-block;}
.evt121752 .awards_list{background:url(//webimage.10x10.co.kr/fixevent/event/2022/121752/awards_list.jpg) no-repeat 50% 0;height:1626px;}
.evt121752 .event_list{background:url(//webimage.10x10.co.kr/fixevent/event/2022/121752/event_list.jpg) no-repeat 50% 0;height:848px;}
.evt121752 .event_list .event_link{display:flex; position:absolute; left:50%; width:1152px; margin-left:-576px; top:399px; height:144px;}
.evt121752 .event_list .event_link a{width:33.33%; height:100%;}
.evt121752 .timesale{background:url(//webimage.10x10.co.kr/fixevent/event/2022/121752/timesale_v2.jpg) no-repeat 50% 0;height:2101px;}
.evt121752 .timesale .main_time{width:960px;position:absolute; background:#fff; height:650px; border-bottom:5px solid #f8f3eb; left:50%; margin-left:-570px; top:645px; padding:70px 110px 0 70px;} 
.evt121752 .timesale .main_time .prd_item{overflow: hidden;}
.evt121752 .timesale .main_time .prd_img{width:440px;height:440px;float:left;margin:0;}
.evt121752 .timesale .main_time .prd_img img{width:100%;}
.evt121752 .timesale .main_time .prd_info{text-align:left;margin-left:84px;width:calc(50% - 84px);float:left;}
.evt121752 .timesale .main_time .prd_date{width:422px;margin-bottom:29px;padding-bottom:21px;border-bottom:1px solid #000;}
.evt121752 .timesale .main_time .prd_date .date{font-size:54px;font-weight:800;color:#222;line-height:54px;letter-spacing:-0.03em;margin-left: 41px;}
.evt121752 .timesale .main_time .prd_date .date span{display:block;font-size:22px;font-weight:400;color:#686868;line-height:22px;margin-bottom:15px;letter-spacing:-0.01em;}
.evt121752 .timesale .main_time .prd_date .date span b{font-size:25px;font-weight:700;line-height:25px;letter-spacing:-0.11em;}
.evt121752 .timesale .main_time .prd_date .time{font-size:49px;line-height: 49px;font-weight: 700;color:#000;margin-top:81px;position:relative;width:fit-content;letter-spacing:-0.01em;margin-left: 41px;}
.evt121752 .timesale .main_time .prd_date .time::after{content:'';display:block;background: #FF0D38;width:12px;height:12px;border-radius:50%;position:absolute;top:-5px;right:-15px;animation: twinkle ease-in-out alternate;-webkit-animation: twinkle alternate .6s infinite;}
.evt121752 .timesale .main_time .prd_name{font-size:25px;letter-spacing:-0.03em;width:290px;font-weight:700;margin-left: 41px;}
.evt121752 .timesale .main_time .prd_price{margin-left:41px;margin-top:26px;font-size:28px;line-height:28px;letter-spacing:-0.01em;font-weight:700;color:#222;margin-top:10px;}
.evt121752 .timesale .main_time s{display:block;font-size:23px;line-height:23px;letter-spacing:-0.01em;font-weight:400;color:#8C8C8C;}
.evt121752 .timesale .main_time span{font-size:33px;line-height: 33px;letter-spacing:-0.01em;font-weight:700;color:#FF0D38;margin-left:10px;}
.evt121752 .timesale .main_time .o_price{display:block;font-size:23px;line-height:23px;letter-spacing:-0.01em;font-weight:400;color:#8C8C8C;}
.evt121752 .timesale .main_time .set_price{font-size:28px;line-height:28px;letter-spacing:-0.01em;font-weight:700;color:#222;margin-top:10px;}
.evt121752 .timesale .main_time .discount{font-size:33px;line-height: 33px;letter-spacing:-0.01em;font-weight:700;color:#FF0D38;margin-left:10px;}
.evt121752 .timesale .main_time .prd_link{width:483px;height:77px;display:flex;align-items:center;justify-content:center;background-color:#090909;color:#fff;border-radius:50px;position:absolute;bottom:75px;left:50%;margin-left:-241.5px;font-size:24px;}
.evt121752 .timesale .sub_time{background:#fffbdf;overflow: hidden; width:1140px; position:absolute;left:50%; margin-left:-570px; top:1370px;}
.evt121752 .timesale .sub_time .time_list{width:970px;margin:80px auto;overflow: hidden; }
.evt121752 .timesale .sub_time .time_list li{width:220px;height:220px;float:left;margin-right:30px;position:relative;}
.time_list li:nth-child(1),.time_list li:nth-child(2),.time_list li:nth-child(3),.time_list li:nth-child(4){margin-bottom:30px;}
.time_list li:nth-child(4),.time_list li:nth-child(8){margin-right:0 !important;}
.evt121752 .timesale .sub_time .time_list li figure{margin:0;}
.evt121752 .timesale .sub_time .time_list li figure .mask{width:100%;height:100%;position:absolute;top:0;left:0;background-color:#686868;opacity: 0.15;}
.evt121752 .timesale .sub_time .time_list li img{width:100%;}
.evt121752 .timesale .sub_time .time_list li .time_date{font-size:20px;line-height:20px;font-weight:600;position:absolute;top:15px;left:8px;text-align:left;color:#fff;}
.evt121752 .timesale .sub_time .time_list li .time_date span{display:block;font-size: 30px;line-height:36px;letter-spacing:-0.05em;font-weight:500;}
.evt121752 .timesale .sub_time .time_list li.close a.more{display:none;}
.evt121752 .timesale .sub_time .time_list li.close figure .mask{background-color:#222;opacity: 0.2;}
.evt121752 .timesale .sub_time .time_list li.close figure img{filter: grayscale(100%);}
.evt121752 .timesale .sub_time .time_list li.close .time_date{text-align: center;font-size:26px;line-height:26px;position:absolute;top:80px;left:0;width:100%;}
.evt121752 .timesale .sub_time .time_list li a.more{width:31px;height:31px;position:absolute;right:8.4px;bottom:8.4px;}
.evt121752 .timesale .sub_time .time_list li a.more img{width:100%;}
.evt121752 .layerDeal .deal_list{padding:0 90px;padding-bottom:200px;margin-top:90px;}
.evt121752 .layerDeal .deal_list .itemDeal li > a:after{border:0;}
.evt121752 .layerDeal .deal_list .itemDeal .half{width:320px;height:437px;margin:0;margin-right:40px;margin-bottom:80px;}
.evt121752 .layerDeal .deal_list .itemDeal .half:nth-child(even){margin-right:0;}
.evt121752 .layerDeal .deal_list .itemDeal .half > a{width:320px;height:437px;padding:0;border:0;}
.evt121752 .layerDeal .deal_list .itemDeal .half .pdtPhoto, .evt121752 .layerDeal .deal_list .itemDeal .half .pdtPhoto img{width:320px;height:320px;margin-bottom:20px;}
.evt121752 .layerDeal .itemDeal .pdtInfo{width:320px;}

@keyframes updown{
    0% {transform: translateY(10px);}
    100% {transform: translateY(-10px);}
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

<script src="/vue/event/etc/121752/index.js?v=1.00"></script>