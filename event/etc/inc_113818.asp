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
.evt113818 {width:1140px; margin:0 auto;}
.evt113818 .topic {position:relative; height:623px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113819/bg_top.jpg) no-repeat 50% 0;}
.evt113818 .topic .txt {position:absolute; left:50%; top:110px; margin-left:-87px; animation:bouns 1s linear alternate infinite;}
.evt113818 .section-01 {position:relative; height:1389px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113819/bg_sub01.jpg?v=2) no-repeat 50% 0;}/* 2021-09-01 수정 */
.evt113818 .section-01 .item01 {position:absolute; left:21%; top:19%;}
.evt113818 .section-01 .item02 {position:absolute; left:46%; top:30%; z-index:2;}
.evt113818 .section-01 .item03 {position:absolute; left:50%; top:19%;}
.evt113818 .section-01 .item04 {position:absolute; left:62%; top:33%;}
.evt113818 .section-01 .icon_arr {position:absolute; left:50%; top:53%; margin-left:-183px; animation: swing 1s linear alternate infinite;}
.evt113818 .noti-area .btn-detail {position:relative; width:100%; height:116px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113819/btn_noti.jpg) no-repeat 50% 0;}
.evt113818 .noti-area .noti {display:none; height:357px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113819/info_noti.jpg) no-repeat 50% 0;}
.evt113818 .noti-area .noti.on {display:block;}
.evt113818 .noti-area .icon {position:absolute; left:50%; top:67px; margin-left:107px; width:16px; height:9px; transform: rotate(0);}
.evt113818 .noti-area .icon.on {transform: rotate(180deg);}
.evt113818 .section-02 {height:418px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113819/bg_sub02.jpg) no-repeat 50% 0;}
.evt113818 .section-03 {position:relative; height:3876px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113819/bg_prd.jpg) no-repeat 50% 0;}
.evt113818 .section-03 .txt {position:absolute; left:50%; top:125px; margin-left:-87px; animation:bouns 1s linear alternate infinite;}
.evt113818 .section-03 .prd01 {width:522px; height:522px; position:absolute; left:8%; top:14%;}
.evt113818 .section-03 .prd02 {width:270px; height:350px; position:absolute; left:66%; top:22%;}
.evt113818 .section-03 .prd03 {width:560px; height:400px; position:absolute; left:17%; top:33%;}
.evt113818 .section-03 .prd04 {width:570px; height:580px; position:absolute; left:43%; top:45%;}
.evt113818 .section-03 .prd05 {width:666px; height:477px; position:absolute; left:7%; top:61%;}
.evt113818 .section-03 .prd06 {width:408px; height:211px; position:absolute; left:56%; top:76%;}
.evt113818 .section-03 .prd07 {width:490px; height:368px; position:absolute; left:10%; top:81%;}
.evt113818 .section-03 .btn-item {width:520px; height:200px; position:absolute; left:50%; bottom:84px; margin-left:-260px;}
@keyframes bouns {
    0% {transform: translateY(-1rem);}
    100% {transform: translateY(0);}
}
@keyframes swing {
    0% {transform: translateX(-.5rem);}
    100% {transform: translateX(0);}
}
</style>

<script>
    const userid = '<%= userid %>';
    let isLoginOk = false;
    <% IF isLoginOk THEN %>
        isLoginOk = true;
    <% END IF %>

    /* 이미지 순차 노출 */
    changingImg();
    function changingImg(){
        var i=1;
        var repeat = setInterval(function(){
            i++;
            if(i>2){i=1;}
            $('.evt113818 .item01').attr('src','//webimage.10x10.co.kr/fixevent/event/2021/113819/img_item01_prd0'+ i +'.png');
            $('.evt113818 .item02').attr('src','//webimage.10x10.co.kr/fixevent/event/2021/113819/img_item02_prd0'+ i +'.png');
            $('.evt113818 .item03').attr('src','//webimage.10x10.co.kr/fixevent/event/2021/113819/img_item03_prd0'+ i +'.png');
            $('.evt113818 .item04').attr('src','//webimage.10x10.co.kr/fixevent/event/2021/113819/img_item04_prd0'+ i +'.png');
            /* if(i == 5) {
                clearInterval(repeat);
            } */
        },1300);
    }
    // btn more
    $('.evt113818 .btn-detail').click(function (e) {
        $(this).next().toggleClass('on');
        $(this).find('.icon').toggleClass('on');
    });
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

<script src="/vue/event/etc/113818/index.js?v=1.00"></script>