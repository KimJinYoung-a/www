<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 추석 응모 이벤트 - 브릿지 페이지
' History : 2021-09-14 이전도
'####################################################
%>
<style>
.evt114117 section{position:relative;}

.evt114117 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2021/114117/top.jpg)no-repeat 50% 0;height:1218px;}
.evt114117 .section01 .txt{position:absolute;top:268px;left:50%;margin-left:-253px;transform: translateY(-50px); opacity:0; transition:all 1s;}
.evt114117 .section01 .txt.on{opacity:1;transform: translateY(0);}
.evt114117 .section01 .app_float{position:absolute;top:384px;left:50%;margin-left:357px;animation:updown 1s ease-in-out alternate infinite;}

.evt114117 .section02 div.submit{background:url(//webimage.10x10.co.kr/fixevent/event/2021/114117/submit.jpg)no-repeat 50% 0;height:1614px;position:relative;}
.evt114117 .section02 div.submit .float01{position:absolute;top:136px;left:50%;margin-left:-57.5px;animation:updown 1s ease-in-out alternate infinite;}
.evt114117 .section02 div.submit .info{width:1140px;height:126px;position:absolute;bottom:0;left:50%;margin-left:-570px;}
.evt114117 .section02 div.submit .info span{position:absolute;left:50%;margin-left:120px;transform: rotate(0);transition:all 1s;top:64px;}
.evt114117 .section02 div.submit .info span.on{transform: rotate(180deg);transition:all 1s;top:54px;}
.evt114117 .section02 div.notice{background:url(//webimage.10x10.co.kr/fixevent/event/2021/114117/notice.jpg)no-repeat 50% 0;height:451px;}

.evt114117 .section03{background:url(//webimage.10x10.co.kr/fixevent/event/2021/114117/product.jpg)no-repeat 50% 0;height:662px;}

.evt114117 .section04{background:url(//webimage.10x10.co.kr/fixevent/event/2021/114117/item.jpg)no-repeat 50% 0;height:3079px;}
.evt114117 .section04 .float02{position:absolute;top:139px;left:50%;margin-left:-82px;animation:updown 1s ease-in-out alternate infinite;}

.evt114117 .section04 .item01{width:1920px;height:645px;position:absolute;top:614px;left:50%;margin-left:-960px;}
.evt114117 .section04 .item01 .prd01{width:645px;height:645px;display:block;position:absolute;top:0;right:50%;margin-right:104px;}
.evt114117 .section04 .item01 .url01{width:168px;height:66px;display:block;position:absolute;top:56px;right:50%;margin-right:57px;}
.evt114117 .section04 .item01 .prd02{width:255px;height:280px;display:block;position:absolute;top:56px;left:50%;margin-left:125px;}
.evt114117 .section04 .item01 .prd03{width:459px;height:330px;display:block;position:absolute;top:222px;left:50%;margin-left:269px;}
.evt114117 .section04 .item01 .url02{width:168px;height:66px;display:block;position:absolute;top:401px;left:50%;margin-left:137px;}

.evt114117 .section04 .item02{width:1920px;height:682px;position:absolute;top:1395px;left:50%;margin-left:-960px;}
.evt114117 .section04 .item02 .prd01{width:196px;height:285px;display:block;position:absolute;top:0;right:50%;margin-right:374px;}
.evt114117 .section04 .item02 .url01{width:168px;height:66px;display:block;position:absolute;top:116px;right:50%;margin-right:181px;}
.evt114117 .section04 .item02 .prd02{width:373px;height:373px;display:block;position:absolute;bottom:0;right:50%;margin-right:-140px;}
.evt114117 .section04 .item02 .url02{width:168px;height:66px;display:block;position:absolute;bottom:59px;right:50%;margin-right:193px;}
.evt114117 .section04 .item02 .prd03{width:557px;height:682px;display:block;position:absolute;bottom:0;left:50%;margin-left:171px}
.evt114117 .section04 .item02 .url03{width:168px;height:66px;display:block;position:absolute;top:212px;left:50%;margin-left:423px;}

.evt114117 .section04 .item03{width:1920px;height:710px;position:absolute;top:2220px;left:50%;margin-left:-960px;}
.evt114117 .section04 .item03 .prd01{width:710px;height:710px;display:block;position:absolute;top:0;right:50%;margin-right:13px;}
.evt114117 .section04 .item03 .url01{width:168px;height:66px;display:block;position:absolute;bottom:60px;right:50%;margin-right:132px;}
.evt114117 .section04 .item03 .prd02{width:710px;height:710px;display:block;position:absolute;bottom:0;left:50%;margin-left:15px;}
.evt114117 .section04 .item03 .url02{width:168px;height:66px;display:block;position:absolute;top:78px;left:50%;margin-left:302px;}

@keyframes updown {
    0% {transform: translateY(-20px);}
    100% {transform: translateY(20px);}
}
</style>
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


<div id="app"></div>
<script src="/vue/event/etc/114116/vue_114116.js?v=1.00"></script>