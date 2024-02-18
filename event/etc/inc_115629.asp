<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : WAKE UP 이벤트
' History : 2021-12-30 김형태
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp"-->

<style>
.evt115629 {max-width:1920px; margin:0 auto;}
.evt115629 .txt-hidden {font-size:0; text-indent:-9999px;}
.evt115629 .w1140 {width:1140px; height:100%; margin:0 auto; position:relative;}
.evt115629 .w1140 a {display:inline-block;}
.evt115629 .w1140 a .wish {display:flex; align-items:flex-start; font-size:25px; color:#ff5373; font-weight:500;}
.evt115629 .desc .wish .icon {display:inline-block; width:21px; height:21px; margin:0.3rem 0.3rem 0 0; background:url(//webimage.10x10.co.kr/fixevent/event/2021/115629/icon_wish.png) no-repeat 0 0; background-size:100%;}
.evt115629 .w1140 .desc {width:100%; height:100%; position:relative;}
.evt115629 .topic {height:1208px; background:url(http://webimage.10x10.co.kr/fixevent/event/2021/115629/top.jpg?v=2) no-repeat 50% 0;}
.evt115629 .prd01 {height:1010px; background:url(http://webimage.10x10.co.kr/fixevent/event/2021/115629/prd01.jpg?v=3) no-repeat 50% 0;}
.evt115629 .prd02 {height:1125px; background:url(http://webimage.10x10.co.kr/fixevent/event/2021/115629/prd02.jpg?v=2) no-repeat 50% 0;}
.evt115629 .prd03 {height:1177px; background:url(http://webimage.10x10.co.kr/fixevent/event/2021/115629/prd03.jpg?v=2) no-repeat 50% 0;}
.evt115629 .prd04 {height:925px; background:url(http://webimage.10x10.co.kr/fixevent/event/2021/115629/prd04.jpg?v=2) no-repeat 50% 0;}
.evt115629 .prd05 {height:2701px; background:url(http://webimage.10x10.co.kr/fixevent/event/2021/115629/prd05.jpg?v=2) no-repeat 50% 0;}
.evt115629 .prd01 .item01 {width:400px; height:250px; position:absolute; left:50%; top:236px; margin-left:-200px;}
.evt115629 .prd01 .item01 .wish {position:absolute; right:24px; top:212px; line-height:normal;}
.evt115629 .prd01 .item02 {width:573px; height:130px; position:absolute; left:50%; top:587px; margin-left:-525px;}
.evt115629 .prd01 .item02 .wish {position:absolute; right:-18px; top:49px; line-height:normal;}
.evt115629 .prd01 .item03 {width:600px; height:130px; position:absolute; left:50%; top:708px; margin-left:-90px;}
.evt115629 .prd01 .item03 .wish {position:absolute; left:-31px; top:49px; line-height:normal;}

.evt115629 .prd02 .item01 {width:530px; height:130px; position:absolute; left:50%; top:274px; margin-left:-95px;}
.evt115629 .prd02 .item01 .wish {position:absolute; left:10px; top:52px; line-height:normal;}
.evt115629 .prd02 .item02 {width:530px; height:130px; position:absolute; left:50%; top:396px; margin-left:-418px;}
.evt115629 .prd02 .item02 .wish {position:absolute; right:10px; top:52px; line-height:normal;}
.evt115629 .prd02 .item03 {width:530px; height:130px; position:absolute; left:50%; top:591px; margin-left:-1px;}
.evt115629 .prd02 .item03 .wish {position:absolute; right:10px; top:52px; line-height:normal;}
.evt115629 .prd02 .item04 {width:530px; height:130px; position:absolute; left:50%; top:777px; margin-left:-104px;}
.evt115629 .prd02 .item04 .wish {position:absolute; left:45px; top:52px; line-height:normal;}
.evt115629 .prd02 .item05 {width:530px; height:130px; position:absolute; left:50%; top:921px; margin-left:-304px;}
.evt115629 .prd02 .item05 .wish {position:absolute; right:25px; top:55px; line-height:normal;}

.evt115629 .prd03 .item01 {width:530px; height:130px; position:absolute; left:50%; top:238px; margin-left:-95px;}
.evt115629 .prd03 .item01 .wish {position:absolute; left:60px; top:84px; line-height:normal;}
.evt115629 .prd03 .item02 {width:530px; height:130px; position:absolute; left:50%; top:375px; margin-left:-418px;}
.evt115629 .prd03 .item02 .wish {position:absolute; right:86px; top:21px; line-height:normal;}
.evt115629 .prd03 .item03 {width:530px; height:130px; position:absolute; left:50%; top:514px; margin-left:-331px;}
.evt115629 .prd03 .item03 .wish {position:absolute; left:-5px; top:52px; line-height:normal;}
.evt115629 .prd03 .item04 {width:530px; height:130px; position:absolute; left:50%; top:859px; margin-left:-354px;}
.evt115629 .prd03 .item04 .wish {position:absolute; right:21px; top:52px; line-height:normal;}
.evt115629 .prd03 .item05 {width:530px; height:130px; position:absolute; left:50%; top:992px; margin-left:-60px;}
.evt115629 .prd03 .item05 .wish {position:absolute; left:15px; top:36px; line-height:normal;}

.evt115629 .prd04 .item01 {width:530px; height:130px; position:absolute; left:50%; top:238px; margin-left:-255px;}
.evt115629 .prd04 .item01 .wish {position:absolute; left:58px; top:84px; line-height:normal;}
.evt115629 .prd04 .item02 {width:530px; height:130px; position:absolute; left:50%; top:426px; margin-left:-359px;}
.evt115629 .prd04 .item02 .wish {position:absolute; right:70px; top:84px; line-height:normal;}
.evt115629 .prd04 .item03 {width:530px; height:130px; position:absolute; left:50%; top:673px; margin-left:-256px;}
.evt115629 .prd04 .item03 .wish {position:absolute; left:0px; top:52px; line-height:normal;}

.evt115629 .prd05 .item01 {width:230px; height:220px; position:absolute; left:22px; top:360px;}
.evt115629 .prd05 .item02 {width:260px; height:280px; position:absolute; left:452px; top:439px;}
.evt115629 .prd05 .item03 {width:410px; height:470px; position:absolute; left:731px; top:376px;}
.evt115629 .prd05 .item04 {width:280px; height:320px; position:absolute; left:102px; top:680px;}
.evt115629 .prd05 .item05 {width:400px; height:140px; position:absolute; left:452px; top:860px;}
.evt115629 .prd05 .item06 {width:380px; height:270px; position:absolute; left:-8px; top:1017px;}
.evt115629 .prd05 .item07 {width:300px; height:180px; position:absolute; left:414px; top:1057px;}
.evt115629 .prd05 .item08 {width:370px; height:360px; position:absolute; left:774px; top:1057px;}
.evt115629 .prd05 .item09 {width:310px; height:390px; position:absolute; left:62px; top:1484px;}
.evt115629 .prd05 .item10 {width:300px; height:320px; position:absolute; left:442px; top:1344px;}
.evt115629 .prd05 .item11 {width:325px; height:195px; position:absolute; left:442px; top:1694px;}
.evt115629 .prd05 .item12 {width:400px; height:300px; position:absolute; left:752px; top:1634px;}
.evt115629 .prd05 .item13 {width:350px; height:360px; position:absolute; left:-27px; top:1954px;}
.evt115629 .prd05 .item14 {width:340px; height:370px; position:absolute; left:543px; top:2027px;}
.evt115629 .prd05 .item15 {width:230px; height:370px; position:absolute; left:893px; top:2027px;}
.evt115629 .prd05 a {font-size:0; text-indent:-9999px;}
.evt115629 .co-area {height:800px; background:#ffe385;}
.evt115629 .co-area .co-input {display:flex; align-items:center; width:790px; height:140px; padding:20px; margin:0 auto; background:#fff; border-radius:40px;}
.evt115629 .co-area .co-input textarea {width:100%; height:auto; max-height:140px; padding:0; border:0; line-height:23px; overflow:hidden; font-size:23px; color:#111; text-align:center; resize:none;}
.evt115629 .co-area .co-input textarea::placeholder {color:#c5c5c5;}
.evt115629 .co-area button {margin-top:40px;}
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

<script>
    let isUserLoginOK = false;
    <% IF IsUserLoginOK THEN %>
        isUserLoginOK = true;
    <% END IF %>
</script>

<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script src="/vue/common/common.js?v=1.00"></script>

<script src="/vue/event/etc/115629/index.js?v=1.00"></script>

