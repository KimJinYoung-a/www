<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>

<style>
.evt113635 .topic {position:relative; height:2029px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113634/bg_main.jpg) no-repeat 50% 0;}
.evt113635 .topic h2 {position:absolute; left:50%; top:220px; margin-left:-213px; opacity:0; transition:1.5s; transform: translateY(-1rem);}
.evt113635 .topic .txt {position:absolute; left:50%; top:680px; margin-left:-290px; opacity:0; transition:1.5s 1s; transform: translateY(-1rem);}
.evt113635 .topic h2.check,
.evt113635 .topic .txt.check {transform: translateY(0); opacity:1;}
.evt113635 .event-area {position:relative; width:1140px; margin:0 auto; background:#20362a; z-index:10; overflow: hidden;}
.evt113635 .event-wrap {background:#20362a;}
.evt113635 .event-area .ph01 {position:absolute; left:37%; bottom:-10%; z-index:5;}
.evt113635 .event-area .ph02 {position:absolute; left:46%; bottom:-10%;}
.evt113635 .event-area .ph03 {position:absolute; left:47%; bottom:-10%; z-index:4;}
.evt113635 .event-area .ph04 {position:absolute; left:37%; bottom:-2%; z-index:3;}
.evt113635 .event-area .ph05 {position:absolute; left:31%; bottom:38%; z-index:3;}
.evt113635 .event-area .ph06 {position:absolute; left:56%; bottom:-10%;}
.evt113635 .event-area .ph07 {position:absolute; left:62%; bottom:-10%; z-index:4;}
.evt113635 .event-area .ph08 {position:absolute; left:28%; bottom:-10%;}
.evt113635 .event-area .ph09 {position:absolute; left:51%; bottom:19%; z-index:5;}
.evt113635 .event-area .ph01-01 {position:absolute; left:37%; bottom:-10%; z-index:5; animation:show 1.5s alternate infinite;}
.evt113635 .event-area .ph02-02 {position:absolute; left:46%; bottom:-10%; animation:show 1.5s alternate infinite;}
.evt113635 .event-area .ph03-03 {position:absolute; left:47%; bottom:-10%; z-index:4; animation:show 1.5s 1s alternate infinite;}
.evt113635 .event-area .ph04-04 {position:absolute; left:37%; bottom:-2%; z-index:3; animation:show 1.5s 1s alternate infinite;}
.evt113635 .event-area .ph05-05 {position:absolute; left:31%; bottom:38%; z-index:3; animation:show 2s 1s alternate infinite;}
.evt113635 .event-area .ph06-06 {position:absolute; left:56%; bottom:-10%; animation:show 2s 1s alternate infinite;}
.evt113635 .event-area .ph07-07 {position:absolute; left:62%; bottom:-10%; z-index:4; animation:show 3s 1s alternate infinite;}
.evt113635 .event-area .ph08-08 {position:absolute; left:28%; bottom:-10%; animation:show 3s 1s alternate infinite;}
.evt113635 .event-area .ph09-09 {position:absolute; left:51%; bottom:19%; z-index:5; animation:show 3s 1s alternate infinite;}
.evt113635 .event-area .bar {width:500px; height:33px; position:absolute; left:50%; bottom:9px; margin-left:-250px; background:#a37f4b; z-index:10;}
.evt113635 .event-area .bar02 {width:660px; height:33px; position:absolute; left:50%; bottom:-24px; margin-left:-330px; background:#20362a; z-index:10;}

.evt113635 .qr-area {height:683px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113634/bg_qr.jpg) no-repeat 50% 0;}
.evt113635 .point-area {position:relative; height:1048px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113634/bg_event.jpg) no-repeat 50% 0;}
.evt113635 .point-area .id {position:absolute; left:50%; top:150px; transform: translate(-50%,0); text-align:center;}
.evt113635 .point-area .id span {text-decoration-color:#20362a; text-decoration:underline;}
.evt113635 .point-area .id p {color:#20362a; font-weight:bold; text-indent:-25px; letter-spacing:-2.5px;}
.evt113635 .point-area .id p:nth-child(1) {font-size:45px;}
.evt113635 .point-area .id p:nth-child(2) {font-size:55px;}
.evt113635 .point-area .btn-point {width:75px; height:85px; position:absolute; left:50%; top:887px; transform: translate(180%,0);}
.evt113635 .noti-area .btn-detail {position:relative; width:100%; height:87px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113634/btn_detail.jpg) no-repeat 50% 0;}
.evt113635 .noti-area .noti {display:none; height:250px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113634/info_detail.jpg) no-repeat 50% 0;}
.evt113635 .noti-area .noti.on {display:block;}
.evt113635 .noti-area .icon {position:absolute; left:50%; top:56px; margin-left:120px; width:18px; height:11px; transform: rotate(0);}
.evt113635 .noti-area .icon.on {transform: rotate(180deg);}
.evt113635 .bnr-area {position:relative; height:3291px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113634/bg_bnr.jpg) no-repeat 50% 0;}
.evt113635 .bnr-area .pd01 {position:absolute; left:50%; top:700px; margin-left:-640px; width:500px; height:400px;}
.evt113635 .bnr-area .pd02 {position:absolute; left:50%; top:700px; margin-left:180px; width:500px; height:450px;}
.evt113635 .bnr-area .pd03 {position:absolute; left:50%; top:1200px; margin-left:-250px; width:500px; height:400px;}
.evt113635 .bnr-area .pd04 {position:absolute; left:50%; top:1860px; margin-left:-610px; width:500px; height:730px;}
.evt113635 .bnr-area .pd05 {position:absolute; left:50%; top:1800px; margin-left:260px; width:500px; height:400px;}
.evt113635 .bnr-area .pd06 {position:absolute; left:50%; top:2390px; margin-left:210px; width:500px; height:400px;}
.evt113635 .bnr-area .btn-go {position:absolute; left:0; bottom:130px; width:100%; height:200px;}
.evt113635 .bnr-area a {display:inline-block; width:100%; height:100%;}
@keyframes show {
    0% {opacity:0;}
    100% {opacity:1;}
}
</style>
</head>
<body>
    <script>
        const userid = "<%= GetLoginUserID %>";
        let isUserLoginOK = false;
        <% IF IsUserLoginOK THEN %>
            isUserLoginOK = true;
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

    <script src="/vue/event/mileage_attendance/index.js"></script>
    <script>
        $(function(){
            $('.topic h2,.topic .txt').addClass('check');
        });
    </script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->