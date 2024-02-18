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
' History : 2022-08-01 유율선
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
.evt119092 section{position:relative;width:100%;}

.evt119092 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119092/main.jpg) no-repeat 50% 0;height:1827px;}

.evt119092 .section02 .open01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119092/open01.jpg?v=1.02) no-repeat 50% 0;height:825px;position:relative;}
.evt119092 .section02 .open01 a{width:312px;height:67px;display:block;position:absolute;bottom:103px;left:50%;margin-left:-156px;}
.evt119092 .section02 .open02{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119092/open02.jpg?v=1.02) no-repeat 50% 0;height:810px;position:relative;}
.evt119092 .section02 .open02 a{width:312px;height:67px;display:block;position:absolute;bottom:91px;left:50%;margin-left:-156px;}
.evt119092 .section02 .open03{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119092/open03.jpg?v=1.02) no-repeat 50% 0;height:819px;position:relative;}
.evt119092 .section02 .open03 a{width:312px;height:67px;display:block;position:absolute;bottom:79px;left:50%;margin-left:-156px;}
.evt119092 .section02 .open04{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119092/open04.jpg?v=1.02) no-repeat 50% 0;height:826px;position:relative;}
.evt119092 .section02 .open04 a{width:312px;height:67px;display:block;position:absolute;bottom:94px;left:50%;margin-left:-156px;}
.evt119092 .section02 .open05{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119092/open05.jpg?v=1.02) no-repeat 50% 0;height:794px;position:relative;}
.evt119092 .section02 .open05 a{width:312px;height:67px;display:block;position:absolute;bottom:83px;left:50%;margin-left:-156px;}
.evt119092 .section02 .open06{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119092/open06.jpg?v=1.02) no-repeat 50% 0;height:807px;position:relative;}
.evt119092 .section02 .open06 a{width:312px;height:67px;display:block;position:absolute;bottom:80px;left:50%;margin-left:-156px;}
.evt119092 .section02 .open07{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119092/open07.jpg) no-repeat 50% 0;height:962px;position:relative;}
.evt119092 .section02 .open07 a{width:312px;height:67px;display:block;position:absolute;bottom:74px;left:50%;margin-left:-156px;}

.evt119092 .section03{background:url(//webimage.10x10.co.kr/fixevent/event/2022/119092/event.jpg?v=1.08) no-repeat 50% 0;height:1175px;}
.evt119092 .section03 .btn_alert{width:255px;height:48px;display:block;position:absolute;bottom:214px;left:50%;transform:translateX(-50%);}
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


<script src="/vue/event/etc/119092/index.js?v=1.00"></script>