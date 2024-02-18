<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<%
'####################################################
' Description : 2020 랜선 송년회 : 쓸데없는 선물하기 이벤트
' History : 2020-12-23 이전도
'####################################################
Dim eCode

IF application("Svr_Info") = "Dev" THEN
	eCode = 104280
Else
	eCode = 108614
End If
%>
<style type="text/css">
.evt108614 .topic {width:100%; height:1373px; background: url(//webimage.10x10.co.kr/fixevent/event/2020/108614/img_bg01.jpg) no-repeat 50% 0;}
.evt108614 .item-area {position:absolute; left:50%; top:190px; transform:translate(-50%,0);}
.evt108614 .item-area .thumb .item1,
.evt108614 .item-area .thumb .item2,
.evt108614 .item-area .thumb .item3,
.evt108614 .item-area .thumb .item4,
.evt108614 .item-area .thumb .item5 {width:343px; height:345px; transition: .5s ease-in;}
.evt108614 .banner {position:absolute; left:50%; top:111px; transform: translate(124%,0);}
.evt108614 .number {position:absolute; left:50%; top:981px; transform: translate(130%,0); animation: updown .5s ease-in-out alternate infinite;}
.evt108614 .section-01 {position:relative; width:100%; height:1177px; background: url(//webimage.10x10.co.kr/fixevent/event/2020/108614/img_bg02.jpg) no-repeat 50% 0;}
.evt108614 .section-01 .btn-join {width:500px; height:110px; position:absolute; left:50%; bottom:65px; transform:translate(-50%,0); background:transparent;}
.evt108614 .section-02 {width:100%; height:433px; background: url(//webimage.10x10.co.kr/fixevent/event/2020/108614/img_bg03.jpg) no-repeat 50% 0;}
.evt108614 .section-03 {position:relative; background:#fd4e19;}
.evt108614 .section-03 .count {width:100%; position:absolute; left:50%; top:105px; transform: translate(-50%,0); text-align:center;}
.evt108614 .section-03 .count p {font-size:55px; color:#fff; line-height:normal;}
.evt108614 .section-03 .count .num {font-weight:700; line-height:1;}
.evt108614 .view-wish {width:800px; margin:0 auto; background:#fd4e19;}
.evt108614 .view-wish ul {overflow: hidden;}
.evt108614 .view-wish ul li {width:calc(100% / 4 - 26px); margin:0 13px 40px; float:left;}
.evt108614 .view-wish ul li a {display:inline-block; width:100%; text-decoration:none;}
.evt108614 .view-wish ul li .thum {width:100%; height:100%; background:#fff;}
.evt108614 .view-wish ul li .thum img {width:100%;}
.evt108614 .view-wish ul li .id {padding:10px 0 14px; font-size:13px; color:#fff; text-align:right; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;}
.evt108614 .view-wish ul li .name {height:2.8rem; font-size:18px; color:#fff; line-height:1.5rem; overflow:hidden; text-align:left; word-break: break-word;}
.evt108614 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; padding-top:94px; background-color:rgba(45, 37, 108,0.902); z-index:150;}
.evt108614 .pop-container .pop-content {position:relative; display:inline-block;}
.evt108614 .pop-container .pop-inner {position:relative; width:100%; height:85%; overflow-y:scroll;}
.evt108614 .pop-container .pop-inner a {display:inline-block;}
.evt108614 .pop-container .pop-inner .btn-close {position:absolute; right:30px; top:30px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/107094/m/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
@keyframes updown {
    0% {top:975px;}
    100% {top:985px;}
}
</style>
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
<script src="/event/etc/vue/vue_108614.js"></script>
<!-- #include virtual="/lib/db/dbclose.asp" -->