<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 스페티벌
' History : 2021-07-23 이전도
'####################################################
%>
<style>
.evt112850 {position:relative; overflow:hidden;}
.evt112850 .topic { width:100%; height:750px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_title.jpg?v=2) no-repeat 50% 0; position:relative;}
.evt112850 .topic .icon { width:66px; height:26px; position:absolute; bottom:60px; left:50%; margin-left:-13px; animation: bounce 1s ease-in-out alternate infinite;}
.evt112850 .section-01  { width:100%; height:1524px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_event02.jpg) no-repeat 50% 0; position:relative;}
.evt112850 .section-01 .img-01 { position:absolute; top:550px; left:50%; margin-left:-500px; z-index:3;}
.evt112850 .section-01 .img-02 { position:absolute; top:375px; left:50%; margin-left:-500px; z-index:2; opacity:0; }
.evt112850 .section-01 .event-btn { position:absolute; top:1004px; left:50%; margin-left:-500px; animation: shake-horizontal 4s cubic-bezier(0.455, 0.030, 0.515, 0.955) infinite both; background:transparent;}
.evt112850 .animate.img-02 {transform:translateY(40%);}
@keyframes blinker {
    0% {opacity:1;}
    25% {opacity:1;}
    50% {opacity:1;}
    75% {opacity:0;}
    100% {opacity:1;}
}
@keyframes shake-horizontal {
    0%,
    100% { transform:translateX(0);}
    10%,
    30%,
    50%,
    70% { transform:translateX(-10px);}
    20%,
    40%,
    60% { transform:translateX(10px);}
    80% { transform:translateX(8px);}
    90% { transform:translateX(-8px);}
}
.evt112850 .pop-container { position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(0, 0, 0,0.6); z-index:150; overflow-y:auto;}
.evt112850 .pop-contents {position:relative; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%);}
.evt112850 .pop-contents .btn-close {width:100%; height:83px; position:absolute; left:0; bottom:0; text-indent:-9999px; background:transparent;}
.evt112850 .pop-contents .img-03 {width:100vw; position:absolute; left:50%; top:183px; margin-left:-50vw; z-index:152;}
.evt112850 .pop-contents .img-04 {width:100vw; position:absolute; left:50%; top:133px; margin-left:-50vw; z-index:151; animation: bounce 1s ease-in-out alternate infinite;}
.evt112850 .pop-point {width:100%; position:absolute; left:0; top:454px; text-align:center;}
.evt112850 .pop-point p {font-size:35px; color:#111; font-weight:bold; letter-spacing:-1px;}
.evt112850 .pop-contents.last-day .pop-point {top:454px;}
.evt112850 .animate {opacity:0; transform:translateY(20%); transition:all 1s;}
.evt112850 .animate.on {opacity:1; transform:translateY(0); animation:blinker 4s ease-in-out infinite;}

.evt112850 .section-02 {width:100%; height:926px; position:relative;}
.evt112850 .section-02 div {width:422px; height:242px; position:absolute; top:274px; margin-left:50.5px; left:50%; display:block;}
.evt112850 .section-02 div.left {height:505px; width:504px; left:50%; margin-left:-475px;}
.evt112850 .section-02 div:last-child {top:535px;}
.evt112850 .section-02 div a {display:inline-block; width:100%; height:100%; }
.evt112850 .list-price.section-03 {width:100%; height:1393px; position:relative;}
.evt112850 .list-price.section-04 {width:100%; height:1108px; position:relative;}
.evt112850 .list-price .list-conts { width:1045px; display:flex; align-items:flex-start; justify-content:space-between; flex-wrap:wrap; padding-top:480px; margin:0 auto; }
.evt112850 .list-price .list-conts > div { width:240px; height:375px; display:block;}
.evt112850 .list-price .list-conts div a { display:inline-block; position:relative; width:100%; height:375px;}
.evt112850 .list-price .list-conts div a .thumbnail {width:100%; height:240px; overflow:hidden;}
.evt112850 .list-price .list-conts div a .thumbnail img {width:100%;height:100%;}
.evt112850 .list-price .list-conts a div.desc { width:100%; position:absolute; left:0; top:68%; text-align:left; }
.evt112850 .list-price .list-conts a div.desc .price { font-size:17px; color:#000000; position:relative; padding:30px 0 0 40px; font-weight:800; letter-spacing:-0.01em;}
.evt112850 .list-price .list-conts a div.desc .price.not-sale {padding: 3px 0 0 0;}
.evt112850 .list-price .list-conts a div.desc .price s { text-decoration:none; color:#a0a79b; font-size:17px; position:absolute; top:3px; left:0; font-weight:300; letter-spacing:-0.01em;}
.evt112850 .list-price .list-conts a div.desc .price span { color:#ff1461; font-size:17px; position:absolute; left:0; bottom:0;}
.evt112850 .list-price .list-conts a div.desc .brand {font-size:10px; color:#000; font-weight:500;}
.evt112850 .list-price .list-conts a div.desc .name {font-size:14px; color:#000; padding-bottom:8px; font-weight:500; height:44px;}
.evt112850 .list-price .list-conts.type2 {padding-top:60px; width:780px; }
.evt112850 .list-price.section-04 .list-conts {padding-top:170px;}
.evt112850 .list-price.section-04 .list-conts.type2 {padding-top:60px; width:780px; }

.evt112850 .section-05 {width:100%; height:2180px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_sticker01.jpg) no-repeat 50% 0; position:relative;}
.evt112850 .prd-wrap {position:relative;}
.evt112850 .prd-wrap div { position:absolute; left:50%;}
.evt112850 .section-05 div:nth-child(1) {top:422px; margin-left:-560px;}
.evt112850 .section-05 div:nth-child(2) {top:712px; margin-left:100px;}
.evt112850 .section-05 div:nth-child(3) {top:1200px; margin-left:-580px;}
.evt112850 .section-05 div:nth-child(4) {top:1370px; margin-left:14px;}
.evt112850 .section-06 {width:100%; height:1135px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_sticker02.jpg) no-repeat 50% 0; position:relative;}
.evt112850 .section-06 div:nth-child(1) {top:130px; margin-left:-593px;}
.evt112850 .section-06 div:nth-child(2) {top:450px; margin-left:83px;}
.evt112850 .section-07 {width:100%; height:1133px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_sticker03.jpg) no-repeat 50% 0; position:relative;}
.evt112850 .section-07 div:nth-child(1) {top:130px; margin-left:19px;}
.evt112850 .section-07 div:nth-child(2) {top:450px; margin-left:-583px;}
.evt112850 .section-08 {width:100%; height:1135px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_sticker04.jpg) no-repeat 50% 0; position:relative;}
.evt112850 .section-08 div:nth-child(1) {top:129px; margin-left:-577px;}
.evt112850 .section-08 div:nth-child(2) {top:440px; margin-left:70px;}
.evt112850 .section-09 {width:100%; height:957px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_list.jpg) no-repeat 50% 0; position:relative;}
.evt112850 .section-09 .link-conts {display: flex; flex-wrap: wrap; width:967px;position: absolute; left:50%; top:322px; margin-left:-483px; }
.evt112850 .section-09 .link-conts div {width:25%; }
.evt112850 .section-09 .link-conts div a {height:230px; position:relative; display:inline-block; width:100%;}
.evt112850 .section-09 .link-conts.list-wrap {top:565px; width:1217px; margin-left:-611px;}
.evt112850 .section-09 .link-conts.list-wrap div {width:20%;}
@keyframes bounce {
    0% {transform: translateY(-10px)}
    100% {transform: translateY(10px)}
}
.fade-enter-active, .fade-leave-active {transition: opacity .5s;}
.fade-enter, .fade-leave-to {opacity: 0;}
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
<script src="/vue/event/etc/112850/data.js?v=1.05"></script>
<script src="/vue/event/etc/112850/spetivalItem.js?v=1.01"></script>
<script src="/vue/event/etc/112850/vue_112850.js?v=1.02"></script>