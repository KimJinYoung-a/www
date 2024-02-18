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
' Description : NCT X 산리오 이벤트
' History : 2022-09-23 유율선
'####################################################

dim eCode : eCode   = requestCheckVar(Request("eventid"),10) '이벤트 코드번호

IF application("Svr_Info") = "Dev" THEN
    eCode = "118200"
End If

%>

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>

<style type="text/css">
.evt119859 section{position:relative;width:100%;}

.evt119859 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119859/main.jpg) no-repeat 50% 0;height:1800px;}

.evt119859 .section02 .open01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119859/open01.jpg) no-repeat 50% 0;height:779px;position:relative;}
.evt119859 .section02 .open01 .btn_open{width:312px;height:67px;display:block;position:absolute;bottom:162px;left:50%;margin-left:27px;}
.evt119859 .section02 .open02{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119859/open02.jpg) no-repeat 50% 0;height:588px;position:relative;}
.evt119859 .section02 .open02 .btn_open{width:312px;height:67px;display:block;position:absolute;bottom:185px;left:50%;margin-left:-363px;}
.evt119859 .section02 .open03{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119859/open03.jpg) no-repeat 50% 0;height:581px;position:relative;}
.evt119859 .section02 .open03 .btn_open{width:312px;height:67px;display:block;position:absolute;bottom:180px;left:50%;margin-left:27px;}

.evt119859 .section03{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119859/event.jpg) no-repeat 50% 0;height:1389px;}
.evt119859 .section03 .btn_alert{width:321px;height:69px;display:block;position:absolute;bottom:195px;left:50%;transform:translateX(-50%);}
</style>
<script>
	let isUserLoginOK = false;
    <% IF IsUserLoginOK THEN %>
        isUserLoginOK = true;
    <% END IF %>
</script>

<div id="app"></div>

<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js" ></script>

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
<script src="/vue/components/common/functions/event_common.js?v=1.00"></script>
<script type="text/babel" src="/vue/common/mixins/common_mixins.js?v=1.00"></script>


<script src="/vue/event/etc/119859/index.js?v=1.00"></script>