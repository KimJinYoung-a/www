<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
    DIM userid, isLoginOk

    userid = GetencLoginUserID
    isLoginOk = IsUserLoginOK
%>

<style>
.contF{width:100%;}
@font-face {font-family:'10x10'; src:url('//fiximage.10x10.co.kr/webfont/10x10.woff') format('woff'), url('//fiximage.10x10.co.kr/webfont/10x10.woff2') format('woff2'); font-style:normal; font-weight:normal;}
.evt113992 .section{position:relative;}

/* section01 */
.evt113992 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113992/top.jpg)no-repeat 50% 0;height:795px;}
.evt113992 .section01 .slide01{position:absolute;top:144px;left:50%;margin-left:-252px;opacity:0; transform:translateY(20px); transition:all 1s .3s;}
.evt113992 .section01 .slide02{position:absolute;top:275px;left:50%;margin-left:-257.5px;opacity:0; transform:translateY(20px); transition:all 1s .5s;}
.evt113992 .section01 .slide03{position:absolute;top:358px;left:50%;margin-left:-256.5px;opacity:0; transform:translateY(20px); transition:all 1s .7s;}
.evt113992 .section01 .slide.on{opacity:1; transform:translateY(0);}

/* section02 */
.evt113992 .section02{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113992/info.jpg)no-repeat 50% 0;height:856px;}
.evt113992 .section02 .slide04{position:absolute;top:183px;left:50%;margin-left:-433px;opacity:0; transform:translateY(20px); transition:all 1s .3s;}
.evt113992 .section02 .slide05{position:absolute;top:487px;left:50%;margin-left:-438px;opacity:0; transform:translateY(20px); transition:all 1s .5s;}
.evt113992 .section02 .slide06{position:absolute;top:593px;left:50%;margin-left:-330.5px;opacity:0; transform:translateY(20px); transition:all 1s .7s;}
.evt113992 .section02 .slides.on{opacity:1; transform:translateY(0);}

/* section03 */
.evt113992 .section03{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113992/copy.jpg)no-repeat 50% 0;height:1634px;}
.evt113992 .section03 .copy{width:1402px;margin:0 auto;padding-top:335px;}
.evt113992 .section03 .copy p{float:left;}
.evt113992 .section03 button{width:470px;height:105px;text-indent: -99999px;position:absolute;top:1392px;left:50%;margin-left:-235px;background:transparent;}

/* section01 */
.evt113992 .section04{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113992/notice.jpg)no-repeat 50% 0;height:509px;}

/* section01 */
.evt113992 .section05{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113992/box_copy.jpg)no-repeat 50% 0;height:1069px;}


</style>

<script>
    const userid = '<%= userid %>';
    let isLoginOk = false;
    <% IF IsUserLoginOK THEN %>
        isLoginOk = true;
    <% END IF %>
</script>


<div id="app"></div>

<% IF application("Svr_Info") = "Dev" THEN %>
    <script src="/vue/vue_dev.js"></script>
<% Else %>
    <script src="/vue/2.5/vue.min.js"></script>
<% End If %>
<script src="/vue/vue.lazyimg.min.js"></script>
<script src="/vue/vuex.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.7.1/clipboard.min.js"></script>

<script src="/vue/event/etc/113992/index.js?v=1.00"></script>