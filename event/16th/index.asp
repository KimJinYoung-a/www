<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/16th/" & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

	'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
	Dim vTitle, vLink, vPre, vImg, vIsEnd, vQuery, vState, vNowTime, vCouponMaxCount
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle	= Server.URLEncode("[텐바이텐] 16주년 텐쇼")
	snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/16th/")
	snpPre		= Server.URLEncode("10x10 이벤트")
	snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2017/16th/m/kakao_tenshow_main.jpg")
	
	
	'// Facebook 오픈그래프 메타태그 작성
	strPageTitle = "[텐바이텐] 16주년 텐쑈"
	strPageKeyword = "[텐바이텐] 16주년 텐쑈"
	strPageDesc = "[텐바이텐] 이벤트 - 10월에는 텐바이텐 하십쑈!"
	strPageUrl = "http://www.10x10.co.kr/event/16th/"
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2017/16th/bnr_main.jpg"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<style>
/* common */
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}
.ten-show .inner {position:relative; width:1140px; height:100%; margin:0 auto;}
.ten-show .share {height:126px; text-align:left; background-color:#03154e;}
.ten-show .share p {padding-top:52px;}
.ten-show .share .btn-group {position:absolute; right:0; top:35px;}
.ten-show .share .btn-group a {position:relative; margin-left:12px;}
.ten-show .share .btn-group a:active {top:3px;}

/* main */
.show-main {background-color:#fff;}

.section {position:relative; background-position:50% 0; background-repeat:no-repeat}
.section h3 {position:absolute; left:0; z-index:50;}
.section .desc {position:absolute; left:250px; z-index:50; text-align:left;}
.section .desc a {display:inline-block; margin-top:15px;}
.section .deco {position:absolute; background-position:0 0; background-repeat:no-repeat;}

.show-event1 {position:relative; height:888px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_cont_1.jpg);}
.show-event1:after {content:''; display:inline-block; position:absolute; left:0; top:0; width:100%; height:400px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_head.gif) 50% 0 no-repeat;}
.show-event1 .date {position:absolute; right:16px; top:23px; z-index:40;}
.show-event1 .october {position:absolute; left:486px; top:0; z-index:40;}
.show-event1 h2 span {position:absolute; z-index:30;}
.show-event1 h2 span.ten {left:26px; top:56px;}
.show-event1 h2 span.show {left:618px; top:117px;}
.show-event1 .btn-coupon {position:absolute; left:363px; top:608px; z-index:30; outline:none;}
.show-event1 .d1 {left:-34px; top:548px; z-index:50; width:359px; height:254px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco1_1.png);}
.show-event1 .d1:before {content:''; display:inline-block; position:absolute; left:45px; top:69px; width:102px; height:180px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco1_6.gif) 0 0 no-repeat;}
.show-event1 .d1:after {content:''; display:inline-block; position:absolute; left:269px; top:-15px; width:102px; height:180px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco1_7.gif) 0 0 no-repeat;}
.show-event1 .d2 {left:-66px; top:413px; z-index:20; width:112px; height:111px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco1_2.gif);}
.show-event1 .d3 {right:-97px; top:418px; z-index:36; width:202px; height:215px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco1_3.gif);}
.show-event1 .d4 {right:25px; top:256px; z-index:20; width:188px; height:184px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco1_4.gif);}
.show-event1 .d5 {left:782px; top:704px; z-index:20; width:120px; height:165px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco1_5.gif);}
.show-event1 .d6 {right:105px; top:473px; z-index:35; width:67px; height:100px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco1_8.gif);}

.show-event2 {height:512px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_cont_2.png);}
.show-event2 h3 {top:66px;}
.show-event2 .desc {top:78px;}
.show-event2 .item-rolling {position:absolute; top:230px; width:183px; height:183px;}
.show-event2 .item-rolling:hover:after {content:''; display:inline-block; position:absolute; left:0; top:0; width:100%; height:100%; background-position:0 100%; background-repeat:no-repeat;}
.show-event2 .slide .slidesjs-container,.show-event2 .slide .slidesjs-control {width:183px !important; height:183px !important;}
.show-event2 .item1 {left:-20px; z-index:10;}
.show-event2 .item2 {left:140px; z-index:20;}
.show-event2 .item3 {left:300px; z-index:30;}
.show-event2 .item4 {right:300px; z-index:30;}
.show-event2 .item5 {right:140px; z-index:20;}
.show-event2 .item6 {right:-20px; z-index:10;}
.show-event2 .item1:hover:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_1.png);}
.show-event2 .item2:hover:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_2.png);}
.show-event2 .item3:hover:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_3.png);}
.show-event2 .item4:hover:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_4_v2.png);}
.show-event2 .item5:hover:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_5.png);}
.show-event2 .item6:hover:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_6.png);}
.show-event2 .btn-select {position:absolute; left:50%; top:322px; z-index:50; margin-left:-90px; outline:none; background:transparent;}
.show-event2 .btn-select:active {margin-top:3px;}
.show-event2 .d1 {left:419px; top:175px; z-index:20; width:329px; height:68px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco2_1.gif);}
.show-event2 .d2 {left:483px; top:93px; z-index:25; width:172px; height:352px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco2_2.gif);}
.show-event2 .d3 {left:460px; top:310px; z-index:35; width:218px; height:88px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco2_3.png);}

.show-event3 {height:339px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_cont_3.jpg);}
.show-event3 h3 {top:106px;}
.show-event3 .desc {top:113px;}
.show-event3 .d1 {left:736px; top:132px; z-index:20; width:38px; height:36px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco3_1.gif);}

.show-event4 {height:594px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_cont_4.png);}
.show-event4 h3 {top:100px;}
.show-event4 .desc {top:109px;}
.show-event4 .d1 {left:-47px; top:41px; z-index:20; width:264px; height:92px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco4_1.png); animation:twinkle1 1s 100;}
.show-event4 .d2 {left:-170px; top:338px; z-index:20; width:212px; height:265px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco4_2.gif);}
.show-event4 .gift {position:relative; padding-top:135px; text-align:right;}
/*.show-event4 .gift:after {content:''; display:inline-block; position:absolute; right:279px; bottom:181px; width:75px; height:75px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/txt_early.gif) 0 0 no-repeat;}*/
.show-event4 .gift span {display:block; position:absolute; left:56px; bottom:0; width:284px; height:287px;}
.show-event4 .gift span:hover {background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_cup.jpg) 0 0 no-repeat;}
.show-event4 .soldout1,.show-event4 .soldout2,.show-event4 .soldout3 {display:block; position:absolute; left:397px; bottom:114px; width:143px; height:35px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/txt_soldout.png) 0 0 no-repeat; text-indent:-999em; text-align:left;}
.show-event4 .soldout2 {left:800px;}
.show-event4 .soldout3 {left:40px; bottom:90px;}

.show-event5 {overflow:hidden; height:464px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_cont_5.png);}
.show-event5 .inner:after {content:''; display:block; position:absolute; left:0; top:0; z-index:30; width:1140px; height:62px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco5_4.png);}
.show-event5 h3 {top:209px;}
.show-event5 .desc {top:213px;}
.show-event5 .rank {overflow:hidden; position:absolute; left:628px; top:137px; z-index:30; width:515px;}
.show-event5 .rank li {float:left; width:125px; height:125px; margin-right:35px; padding:5px; background:#fff;}
.show-event5 .rank li + li {margin-top:53px;}
.show-event5 .rank li + li + li {margin-top:105px;}
.show-event5 .rank li a {display:block; position:relative;}
.show-event5 .rank li a:hover:after {content:''; display:inline-block; position:absolute; left:0; top:0; width:125px; height:125px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/btn_view.png) 0 0 no-repeat;}
.show-event5 .rank li img {width:125px; height:125px;}
.show-event5 .d1 {right:0; top:81px; z-index:20; width:649px; height:569px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco5_1.png);}
.show-event5 .d2 {right:322px; top:288px; z-index:40; width:48px; height:46px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco5_2.png);}
.show-event5 .d3 {right:-330px; top:30px; z-index:10; width:1244px; height:921px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_deco5_3.png); animation:rotate1 47s 10 linear;}

.show-main .comment-write {padding:60px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_dot.png) repeat 0 0;}
.show-main .comment-write .inner {width:1020px;}
.show-main .comment-write .select-icon {position:relative; z-index:100; overflow:hidden; width:450px; margin:0 auto; padding:52px 0 24px;}
.show-main .comment-write .select-icon  > div {overflow:hidden; float:left; width:110px; height:110px; margin:0 20px}
.show-main .comment-write .select-icon input[type=radio] {visibility:hidden; position:absolute; left:0; top:0;}
.show-main .comment-write .select-icon label {display:block; position:relative; cursor:pointer;}
.show-main .comment-write .select-icon input[type=radio]:checked + label:after {content:''; display:block; position:absolute; left:50%; top:50%; width:50px; height:36px; margin:-18px 0 0 -25px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/ico_check.png) no-repeat 0 0; animation:bounce1 .3s;}
.show-main .comment-write .select-icon input[type=radio]:checked + label img {margin-top:-110px;}
.show-main .comment-write .write-cont {position:relative; height:104px; text-align:left; border:3px solid #ffe243; background-color:#fff;}
.show-main .comment-write .write-cont:after {content:''; display:inline-block; position:absolute; left:0; top:-65px; z-index:10; width:100%; height:70px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_character.png) no-repeat 0 0;}
.show-main .comment-write .write-cont textarea {width:890px; height:74px; padding:15px 105px 15px 15px; font-size:12px; line-height:1.3; border:0; vertical-align:top;}
.show-main .comment-write .write-cont .btn-submit {position:absolute; right:0; top:0; outline:none;}
.show-main .comment-write .caution {padding-top:12px; text-align:left; color:#9b9b9b; font-size:11px; line-height:1;}
.show-main .comment-list {padding-bottom:50px;}
.show-main .comment-list ul {overflow:hidden; margin:0 -11px; padding:50px 0 20px; border-bottom:1px solid #ccc;}
.show-main .comment-list li {float:left; width:215px; height:260px; margin:0 15px 30px; padding:20px 20px 0 25px; word-break:break-all; font-size:11px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_cmt_1.png) no-repeat 0 0;}
.show-main .comment-list li.cmt2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_cmt_2.png);}
.show-main .comment-list li.cmt3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_cmt_3.png);}
.show-main .comment-list li .info {position:relative; height:85px; line-height:1; color:#a7a7a7; text-align:right;}
.show-main .comment-list li .num {height:36px; color:#ff8a8a; font-weight:bold;}
.show-main .comment-list li .writer {height:18px; font-weight:bold;}
.show-main .comment-list li .writer img {margin:-2px 3px 0 0;}
.show-main .comment-list li .delete {display:inline-block; position:absolute; right:0; top:16px;  height:15px; padding:0 3px; line-height:15px; color:#fff; background-color:#a7a7a7;}
.show-main .pageMove {display:none;}
.scrollbarwrap {width:100%;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:205px; height:130px;}
.scrollbarwrap .overview {color:#666; line-height:18px;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:6px;}
.scrollbarwrap.track {position: relative; width:6px; height:100%; background-color:#ececec;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:6px; height:24px; background-color:#ff8a8a; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}

.layer {position:fixed; left:50% !important; top:50% !important; z-index:99999; width:584px; margin-left:-292px;}
.layer .btn-close {display:block; position:absolute; left:50%; top:5px; width:39px; height:39px; margin-left:197px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/btn_layer_close.png) no-repeat 0 0; text-indent:-999em; outline:none;}

.layer-coupon {margin-top:-230px;}
.layer-coupon .btn-close {top:105px; margin-left:227px;}
.layer-gollabo {margin-top:-360px;}
.layer-gollabo .btn-close {margin-left:217px;}
.layer-gollabo .onemore {position:relative;}
.layer-gollabo .onemore .btn-download {display:block; position:absolute; left:70px; top:50px; width:435px; height:300px; text-indent:-999em;}
.layer-gollabo .onemore ul {overflow:hidden; position:absolute; left:190px; top:452px; width:200px; height:60px;}
.layer-gollabo .onemore li {float:left; width:33.33333%; height:100%;}
.layer-gollabo .onemore li a {display:block; height:100%;  text-indent:-999em;}
.layer-gollabo .win .item {margin-left:-10px;}
.layer-gollabo .win .btn-mypage {position:absolute; left:50%; bottom:94px; margin-left:-105px;}
.layer-gollabo .win .code {position:absolute; right:70px; bottom:63px; color:#d6d6d6; font-size:10px;}
.layer-noti {width:698px; margin:-200px 0 0 -349px;}
.layer-noti .btn-ten {position:absolute; left:50%; top:342px; margin-left:-106px;}
.layer-noti .btn-close {margin-left:284px;}
.layer-result {width:638px; height:461px; margin:-230px 0 0 -319px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_layer.png) no-repeat 0 0;}
.layer-result .user {padding:70px 0 32px; text-align}
.layer-result .user strong {display:inline-block; width:185px; color:#000; font-size:15px; line-height:21px; border-bottom:2px solid #404040;}
.layer-result .btn-close {margin-left:255px;}
.layer-result table {width:444px; font:bold 14px/1 'malgun gothic', '맑은고딕', dotum, sans-serif; color:#313131; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/bg_table.png) repeat-y 0 0; table-layout:fixed;}
.layer-result table td {height:45px; text-align:center;}
.layer-result table td a {text-decoration:none;}
.layer-result table td .cRd0V15 i {font-size:12px; font-style:normal; vertical-align:top;}
.layer-result .scrollbarwrap {width:470px; margin-left:84px;}
.layer-result .scrollbarwrap .viewport {width:444px; height:225px; margin:0 auto;}
.layer-result .scrollbarwrap.track {background-color:#d5d5d5;}
.layer-result .scrollbarwrap .thumb {background-color:#343434;}
@keyframes bounce1 {
	from,to {transform:translateY(0);}
	50% {transform:translateY(5px);}
}
@keyframes rotate1 {
	from {transform:rotate(0);}
	to {transform:rotate(360deg);}
}
@keyframes twinkle1 {
	from,to {opacity:0;}
	50% {opacity:1;}
}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(function(){
	// event2
	$("#slide1").slidesjs({
		pagination:false,navigation:false,
		play:{interval:300,effect:"fade",auto:true},
		effect:{fade:{speed:5, crossfade:true}},
	});
	$("#slide2").slidesjs({
		pagination:false,navigation:false,
		play:{interval:300,effect:"fade",auto:true},
		effect:{fade:{speed:5, crossfade:true}},
	});
	$("#slide3").slidesjs({
		pagination:false,navigation:false,
		play:{interval:300,effect:"fade",auto:true},
		effect:{fade:{speed:5, crossfade:true}},
	});
	$("#slide4").slidesjs({
		pagination:false,navigation:false,
		play:{interval:300,effect:"fade",auto:true},
		effect:{fade:{speed:5, crossfade:true}},
	});
	$("#slide5").slidesjs({
		pagination:false,navigation:false,
		play:{interval:300,effect:"fade",auto:true},
		effect:{fade:{speed:5, crossfade:true}},
	});
	$("#slide6").slidesjs({
		pagination:false,navigation:false,
		play:{interval:300,effect:"fade",auto:true},
		effect:{fade:{speed:5, crossfade:true}},
	});

	$(".show-event2 .desc a").click(function(){
		$('.layer-result .scrollbarwrap').tinyscrollbar();
	});
});

function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}

function jsDownCoupon(stype,idx){
	<% if Not(IsUserLoginOK) then %>
		jsEventLogin();
	<% else %>
	$.ajax({
		type: "post",
		url: "/shoppingtoday/act_couponshop_process.asp",
		data: "idx="+idx+"&stype="+stype,
		cache: false,
		success: function(message) {
			if(typeof(message)=="object") {
				if(message.response=="Ok") {
					viewPoupLayer('modal',$('#lyrCoupon').html());
				} else {
					alert(message.message);
				}
			} else {
				alert("처리중 오류가 발생했습니다.");
			}
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
	<% end if %>
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/16th/")%>';
		return;
	}
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contF contW">

						<!-- 16주년 이벤트 -->
						<div class="ten-show show-main">

							<!-- 1.쿠폰왔쇼 -->
							<div class="section show-event1">
								<div class="inner">
									<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/txt_date.png" alt="2017.10.10~10.25 (16일간)" /></p>
									<p class="october"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/txt_october_show.png" alt="10월에는 텐바이텐 하십쑈!" /></p>
									<h2>
										<span class="ten"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/tit_ten_v2.png" alt="텐" /></span>
										<span class="show"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/tit_show.png" alt="쑈" /></span>
									</h2>
									<% if Not(IsUserLoginOK) then %>
										<button type="button" class="btn-coupon" onclick="jsEventLogin();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/btn_coupon_v2.gif" alt="16주년 쿠폰쑈! 최대 30%할인쿠폰 다운받기" /></button>
									<% Else %>
										<button type="button" class="btn-coupon" onclick="jsDownCoupon('prd,prd,prd','12823,12824,12825');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/btn_coupon_v2.gif" alt="16주년 쿠폰쑈! 최대 30%할인쿠폰 다운받기" /></button>
									<% End IF %>

									<div class="deco d1"></div>
									<div class="deco d2"></div>
									<div class="deco d3"></div>
									<div class="deco d4"></div>
									<div class="deco d5"></div>
									<div class="deco d6"></div>
								</div>
								<!-- 쿠폰 다운로드 레이어 -->
								<div id="lyrCoupon" style="display:none;">
									<div class="layer layer-coupon">
										<div class="layerCont">
											<div><a href="/my10x10/couponbook.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/layer_coupon_v3.png" alt="쿠폰이 발급되었습니다 즐거운 쑈핑 되세요!" /></a></div>
										</div>
										<button type="button" class="btn-close" onclick="ClosePopLayer()">닫기</button>
									</div>
								</div>
								<!--// 쿠폰 다운로드 레이어 -->
							</div>

							<%'!-- 2.골라보쑈 --%>
							<% server.Execute("/event/16th/exc_dailypick.asp") %>

							<!-- 3.함께하쑈 -->
							<div class="section show-event3">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/tit_together.png" alt="서포터즈 이벤트 함께하쑈" /></h3>
									<div class="desc">
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/txt_together.png" alt="50만원의 쇼핑지원금으로 신나게 쇼핑을 즐겨 줄 서포터즈를 찾습니다!" /></p>
										<a href="/event/16th/together.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/btn_together.png" alt="지원하러 가기" /></a>
									</div>
									<div class="deco d1"></div>
								</div>
							</div>

							<!-- 4.선물왔쑈 -->
							<div class="section show-event4">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/tit_gift.png" alt="선물왔쑈" /></h3>
									<div class="desc">
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/txt_gift.png" alt="금액대별로 주어지는 선착순 득템기회를 놓치지 마세요" /></p>
										<a href="#lyrNoti" onclick="viewPoupLayer('modal',$('#lyrNoti').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/btn_gift.png" alt="구매 사은 이벤트 유의사항" /></a>
									</div>
									<div class="gift">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_gift_v3.jpg" alt="4만원 이상 구매 시 텐바이텐 16주년 머그컵/7만원이상 구매 시 플레잉 랩핑페이퍼 또는 2000마일리지 중 택1/30만원 이상 구매 시 레꼴뜨 프레스샌드메이커 또는 10000마일리지 중 택1" usemap="#giftMap" />
										<map name="giftMap" id="giftMap">
											<area shape="rect" coords="348,156,479,314" onfocus="this.blur();" href="/playing/view.asp?didx=153" alt="플레잉 랩핑페이퍼 보러가기" />
											<area shape="rect" coords="748,96,885,316" onfocus="this.blur();" href="/shopping/category_prd.asp?itemid=1419077&pEtr=80410" alt="레꼴뜨 프레스샌드메이커 보러가기" />
										</map>
										<!--<span></span>-->
										<p class="soldout1">PLAYing 랩핑 페이퍼 SOLDOUT</p>
										<p class="soldout2">레꼴뜨 프레스샌드메이커 SOLDOUT</p>
										<p class="soldout3">텐바이텐 16주년 머그컵 SOLDOUT</p>
									</div>
									<div class="deco d1"></div>
									<div class="deco d2"></div>
								</div>
								<!-- 유의사항 레이어 -->
								<div id="lyrNoti" style="display:none;">
									<div class="layer layer-noti">
										<div class="layerCont">
											<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/layer_noti.png" alt="구매사은이벤트 유의사항" /></div>
											<a href="/event/eventmain.asp?eventid=80481" class="btn-ten"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/btn_ten_delivery.png" alt="텐바이텐 배송상품 보러가기" /></a>
										</div>
										<button type="button" class="btn-close" onclick="ClosePopLayer()">닫기</button>
									</div>
								</div>
								<!--// 유의사항 레이어 -->
							</div>

							<!-- 5.뽑아주쑈 -->
							<% server.Execute("/event/16th/exc_pickshow.asp") %>

							<!-- 공유하기 -->
							<div class="share">
								<div class="inner">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/txt_share_v2.png" alt="1년에 한번 있는 텐바이텐 쑈! 친구와 함께하쑈~!" /></p>
									<div class="btn-group">
										<a href="#" onclick="snschk('fb');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/btn_facebook_v2.png" alt="페이스북으로 텐쑈 공유하기" /></a>
										<a href="#" onclick="snschk('tw');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/btn_twitter.png" alt="트위터로 텐쑈 공유하기" /></a>
										<a href="#" onclick="snschk('pt');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/btn_pinterest.png" alt="핀터레스트로 텐쑈 공유하기" /></a>
									</div>
								</div>
							</div>
							<!-- #include virtual="/event/16th/inc_comment.asp" -->
						</div>
						<!-- // 16주년 이벤트 -->

					</div>
					<!-- //event area(이미지만 등록될때 / 수작업일때) -->
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->