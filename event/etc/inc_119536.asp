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
.evt119536 .section{position:relative;}
.evt119536 .section .content{width:100%;height:703px;position:absolute;top:380px;}
.evt119536 .section .content ul{position: relative;top: 160px;left: 50%;margin-left:-568px;width:1224px;height:350px;}
.evt119536 .section .content ul li{float:left;width:240px;overflow:hidden;margin:0 15px;margin-bottom: 35px;}
.evt119536 .section .content ul li:nth-child(2){margin-right:140px;}
.evt119536 .desc{text-align:left;width:200px;margin-left:5px;}
.evt119536 .desc .name{font-size:14px;font-weight: bold;margin:-1px 0 13px;overflow: hidden;text-overflow:ellipsis;white-space:nowrap;color:#000;letter-spacing: -0.5px;}
.evt119536 .desc .price{font-size:17px;font-weight:bold;line-height:1.48;width:fit-content;position: relative;color:#111111;}
.evt119536 .desc .price::after{content:'원';position:absolute;right:-16px;bottom:0px;}
.evt119536 .desc .price span{margin-right:11px;color:#ff2241;float: left;}
.evt119536 .desc .price s{display:block;text-decoration:none;font-size:17px;color:#a0a79b;font-weight: normal;}
.evt119536 .content .thumbnail{width:200px;height:200px; overflow: hidden;}
.evt119536 .brand{font-size:10px;margin-top:15px;color:#000;}
.evt119536 .thumbnail img {width:100%;}
.evt119536 .section .prd_main a{width:1010px;height:562px;position:absolute;left:50%;margin-left:-505px;top:328px;}
.evt119536 .section .btn{position:absolute;left:50%;margin-left:-180.5px;bottom:121px;width:361px;}

/* section01 */
.evt119536 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119536/section01.jpg) no-repeat 50% 0;height:1082px;}
.evt119536 .section01 .float01{position:absolute;top:247px;left:50%;margin-left:251px;animation: updown 1.5s 0s ease-in-out infinite alternate;}
.evt119536 .section01 .progress-bar {border-radius: 10px; width: 220px;background:transparent;height:12px;position:absolute;top:506px;right:50%;margin-right:527px;}
.evt119536 .section01 .progress-bar span{display:block;}
.evt119536 .section01 .progress-bar span.bar{background:transparent;}
.evt119536 .section01 .progress-bar span.progress{border-radius:10px;animation: loader 8s ease infinite;background:#ff97da;width:0;height:12px;position:relative;}
.evt119536 .section01 .progress-bar span.progress::after{content:'';display:block;position:absolute;right:-2px;top:-7px;background:url(//webimage.10x10.co.kr/fixevent/event/2022/119536/heart.png)no-repeat 0 0;width:31px;height:27px;background-size:100%;}
/* section02 */
.evt119536 .section02_01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119536/section02.jpg) no-repeat 50% 0;height:1110px;}

/* section03 */
.evt119536 .section03_01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119536/section03.jpg) no-repeat 50% 0;height:1110px;}

/* section04 */
.evt119536 .section04_01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119536/section04.jpg) no-repeat 50% 0;height:1110px;}
 
/* section05 */
.evt119536 .section05{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119536/section05.jpg) no-repeat 50% 0;height:310px;}
.evt119536 .link01{width:183px;height:49px;position:absolute;bottom:87px;left:50%;margin-left:-396px;}
.evt119536 .link02{width:275px;height:227px;position:absolute;left:50%;margin-left:169px;bottom:52px;}

/* timesale */
.evt119536 .timesale .main_time{width:960px;margin:108px auto 207px;position:relative;}
.evt119536 .timesale .main_time .prd_item{overflow: hidden;}
.evt119536 .timesale .main_time .prd_img{width:440px;height:440px;float:left;margin:0;}
.evt119536 .timesale .main_time .prd_img img{width:100%;}
.evt119536 .timesale .main_time .prd_info{text-align:left;margin-left:84px;width:calc(50% - 84px);float:left;}
.evt119536 .timesale .main_time .prd_date{width:422px;margin-bottom:29px;padding-bottom:21px;border-bottom:1px solid #000;}
.evt119536 .timesale .main_time .prd_date .date{font-size:54px;font-weight:800;color:#222;line-height:54px;letter-spacing:-0.03em;margin-left: 41px;}
.evt119536 .timesale .main_time .prd_date .date span{display:block;font-size:22px;font-weight:400;color:#686868;line-height:22px;margin-bottom:15px;letter-spacing:-0.01em;}
.evt119536 .timesale .main_time .prd_date .date span b{font-size:25px;font-weight:700;line-height:25px;letter-spacing:-0.11em;}
.evt119536 .timesale .main_time .prd_date .time{font-size:49px;line-height: 49px;font-weight: 700;color:#000;margin-top:81px;position:relative;width:fit-content;letter-spacing:-0.01em;margin-left: 41px;}
.evt119536 .timesale .main_time .prd_date .time::after{content:'';display:block;background: #FF0D38;width:12px;height:12px;border-radius:50%;position:absolute;top:-5px;right:-15px;animation: twinkle ease-in-out alternate;-webkit-animation: twinkle alternate .6s infinite;}
.evt119536 .timesale .main_time .prd_name{font-size:25px;letter-spacing:-0.03em;width:290px;font-weight:700;margin-left: 41px;}
.evt119536 .timesale .main_time .prd_price{margin-left:41px;margin-top:26px;}
.evt119536 .timesale .main_time .o_price{display:block;font-size:23px;line-height:23px;letter-spacing:-0.01em;font-weight:400;color:#8C8C8C;}
.evt119536 .timesale .main_time .set_price{font-size:28px;line-height:28px;letter-spacing:-0.01em;font-weight:700;color:#222;margin-top:10px;}
.evt119536 .timesale .main_time .discount{font-size:33px;line-height: 33px;letter-spacing:-0.01em;font-weight:700;color:#FF0D38;margin-left:10px;}
.evt119536 .timesale .main_time .prd_link{width:483px;height:77px;display:flex;align-items:center;justify-content:center;background-color:#090909;color:#fff;border-radius:50px;position:absolute;bottom:-130px;left:50%;margin-left:-241.5px;font-size:24px;}
.evt119536 .timesale .sub_time{background:#efe1ff;overflow: hidden;}
.evt119536 .timesale .sub_time .time_list{width:970px;margin:80px auto;overflow: hidden;}
.evt119536 .timesale .sub_time .time_list li{width:220px;height:220px;float:left;margin-right:30px;position:relative;}
.time_list li:nth-child(1),.time_list li:nth-child(2),.time_list li:nth-child(3),.time_list li:nth-child(4){margin-bottom:30px;}
.time_list li:nth-child(4),.time_list li:nth-child(8){margin-right:0 !important;}
.evt119536 .timesale .sub_time .time_list li figure{margin:0;}
.evt119536 .timesale .sub_time .time_list li figure .mask{width:100%;height:100%;position:absolute;top:0;left:0;background-color:#686868;opacity: 0.15;}
.evt119536 .timesale .sub_time .time_list li img{width:100%;}
.evt119536 .timesale .sub_time .time_list li .time_date{font-size:20px;line-height:20px;font-weight:600;position:absolute;top:15px;left:8px;text-align:left;color:#fff;}
.evt119536 .timesale .sub_time .time_list li .time_date span{display:block;font-size: 30px;line-height:36px;letter-spacing:-0.05em;font-weight:500;}
.evt119536 .timesale .sub_time .time_list li.close a.more{display:none;}
.evt119536 .timesale .sub_time .time_list li.close figure .mask{background-color:#222;opacity: 0.2;}
.evt119536 .timesale .sub_time .time_list li.close figure img{filter: grayscale(100%);}
.evt119536 .timesale .sub_time .time_list li.close .time_date{text-align: center;font-size:26px;line-height:26px;position:absolute;top:80px;left:0;width:100%;}
.evt119536 .timesale .sub_time .time_list li a.more{width:31px;height:31px;position:absolute;right:8.4px;bottom:8.4px;}
.evt119536 .timesale .sub_time .time_list li a.more img{width:100%;}

@keyframes updown{
    0% {transform: translateY(20px);}
    100% {transform: translateY(-20px);}
}

@keyframes twinkle {
	0%{opacity: 0;}
	100%{opacity: 1;}
}

@keyframes loader {
	0% {
		width: 0;
	}
	25% {
		width: 25%;
    }
	75% {
		width: 75%;
    
	}

	100% {
		width: 100%;
	}

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

<script src="/vue/event/etc/119536/index.js?v=1.02"></script>