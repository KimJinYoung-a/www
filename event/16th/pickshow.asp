<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : [텐쑈]뽑아주쑈!
' History : 2017.09.26 정태훈
'###########################################################

	'// Facebook 오픈그래프 메타태그 작성
	strPageTitle = "[텐바이텐] 16주년 텐쑈 - 뽑아주쑈"
	strPageKeyword = "[텐바이텐] 16주년 텐쑈"
	strPageDesc = "[텐바이텐] 이벤트 - 매일매일 마음에 드는 아이템을 최대 3개까지 골라주세요!"
	strPageUrl = "http://www.10x10.co.kr/event/16th/pickshow.asp"
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2017/80412/banMoList20170929160648.JPEG"
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/event/16th/pickshowCls.asp" -->
<%
dim eCode, eItemCode, vUserID, nowdate, itemid, ItemGroupCate
Dim sqlstr, evtsubscriptcnt, ItemGroup, ItemGroupNum, gid
IF application("Svr_Info") = "Dev" THEN
	eCode = "67435"
	eItemCode="67436"
Else
	eCode = "80412"
	eItemCode="80741"
End If

gid = requestCheckVar(Request("gid"),10)

If gid<>"" Then
	nowdate=GetItemGroupDate(gid)
Else
	nowdate = date()
End If
vUserID = getEncLoginUserID

If nowdate="2017-10-10" Then
	ItemGroup="220325"
	ItemGroupNum="0"
	ItemGroupCate="101"
ElseIf nowdate="2017-10-11" Then
	ItemGroup="220326"
	ItemGroupNum="1"
	ItemGroupCate="102"
ElseIf nowdate="2017-10-12" Then
	ItemGroup="220327"
	ItemGroupNum="2"
	ItemGroupCate="103"
ElseIf nowdate="2017-10-13" Then
	ItemGroup="220328"
	ItemGroupNum="3"
	ItemGroupCate="104"
ElseIf nowdate="2017-10-14" Then
	ItemGroup="220329"
	ItemGroupNum="4"
	ItemGroupCate="124"
ElseIf nowdate="2017-10-15" Then
	ItemGroup="220437"
	ItemGroupNum="5"
	ItemGroupCate="121"
ElseIf nowdate="2017-10-16" Then
	ItemGroup="220438"
	ItemGroupNum="6"
	ItemGroupCate="122"
ElseIf nowdate="2017-10-17" Then
	ItemGroup="220439"
	ItemGroupNum="7"
	ItemGroupCate="120"
ElseIf nowdate="2017-10-18" Then
	ItemGroup="220440"
	ItemGroupNum="8"
	ItemGroupCate="112"
ElseIf nowdate="2017-10-19" Then
	ItemGroup="220441"
	ItemGroupNum="9"
	ItemGroupCate="119"
ElseIf nowdate="2017-10-20" Then
	ItemGroup="220442"
	ItemGroupNum="10"
	ItemGroupCate="117"
ElseIf nowdate="2017-10-21" Then
	ItemGroup="220443"
	ItemGroupNum="11"
	ItemGroupCate="116"
ElseIf nowdate="2017-10-22" Then
	ItemGroup="220444"
	ItemGroupNum="12"
	ItemGroupCate="125"
ElseIf nowdate="2017-10-23" Then
	ItemGroup="220445"
	ItemGroupNum="13"
	ItemGroupCate="118"
ElseIf nowdate="2017-10-24" Then
	ItemGroup="220446"
	ItemGroupNum="14"
	ItemGroupCate="115"
ElseIf nowdate="2017-10-25" Then
	ItemGroup="220447"
	ItemGroupNum="15"
	ItemGroupCate="110"
Else
	ItemGroup="220325"
	ItemGroupNum="0"
	ItemGroupCate="101"
End If

Function GetItemGroupDate(groupcode)
	If groupcode="220325" Then
		GetItemGroupDate="2017-10-10"
	ElseIf groupcode="220326" Then
		GetItemGroupDate="2017-10-11"
	ElseIf groupcode="220327" Then
		GetItemGroupDate="2017-10-12"
	ElseIf groupcode="220328" Then
		GetItemGroupDate="2017-10-13"
	ElseIf groupcode="220329" Then
		GetItemGroupDate="2017-10-14"
	ElseIf groupcode="220437" Then
		GetItemGroupDate="2017-10-15"
	ElseIf groupcode="220438" Then
		GetItemGroupDate="2017-10-16"
	ElseIf groupcode="220439" Then
		GetItemGroupDate="2017-10-17"
	ElseIf groupcode="220440" Then
		GetItemGroupDate="2017-10-18"
	ElseIf groupcode="220441" Then
		GetItemGroupDate="2017-10-19"
	ElseIf groupcode="220442" Then
		GetItemGroupDate="2017-10-20"
	ElseIf groupcode="220443" Then
		GetItemGroupDate="2017-10-21"
	ElseIf groupcode="220444" Then
		GetItemGroupDate="2017-10-22"
	ElseIf groupcode="220445" Then
		GetItemGroupDate="2017-10-23"
	ElseIf groupcode="220446" Then
		GetItemGroupDate="2017-10-24"
	ElseIf groupcode="220447" Then
		GetItemGroupDate="2017-10-25"
	Else
		GetItemGroupDate="2017-10-10"
	End If
End Function

Dim pickitem1, pickitem2, pickitem3
if vUserID <> "" Then
	sqlstr = ""
	sqlstr = "select pickitem1, pickitem2, pickitem3"
	sqlstr = sqlstr & " from [db_temp].[dbo].[tbl_event_16th_pickshow]"
	sqlstr = sqlstr & " where evt_code="& eCode &""
	sqlstr = sqlstr & " and evt_sub_code="& ItemGroup &" and userid='"& vUserID &"'"

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		pickitem1 = rsget("pickitem1")
		pickitem2 = rsget("pickitem2")
		pickitem3 = rsget("pickitem3")
	END IF
	rsget.close
End If

Dim cEventItem, iTotCnt, ix
Set cEventItem = New ClsEvtItem
cEventItem.FECode 	= eItemCode
cEventItem.FEGCode 	= ItemGroup
cEventItem.FEItemCnt=36
cEventItem.FItemsort=9
cEventItem.fnGetEventItem
iTotCnt = cEventItem.FTotCnt

Dim cEventItemTop, iTotCnt2
Set cEventItemTop = New ClsEvtItem
cEventItemTop.FECode 	= eItemCode
cEventItemTop.FEGCode 	= ItemGroup
cEventItemTop.FEItemCnt=3
cEventItemTop.FItemsort=8
cEventItemTop.fnGetEventItem
iTotCnt2 = cEventItemTop.FTotCnt
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* common */
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}
.ten-show .inner {position:relative; width:1140px; margin:0 auto;}
.ten-show .noti {padding:24px 0; background-color:#373737;}
.ten-show .noti h3 {position:absolute; left:222px; top:50%; margin-top:-24px;}
.ten-show .noti ul {margin-left:438px; padding:15px 0 15px 100px; border-left:1px solid #555; text-align:left;}
.ten-show .noti li {padding:3px 0 3px 9px; text-indent:-9px; line-height:18px; color:#cecece;}
.ten-show .share {height:126px; text-align:left; background-color:#03154e;}
.ten-show .share p {padding-top:52px;}
.ten-show .share .btn-group {position:absolute; right:0; top:35px;}
.ten-show .share .btn-group a {position:relative; margin-left:12px;}
.ten-show .share .btn-group a:active {top:3px;}

/* pick-show */
.w1140 {width:1140px; margin:0 auto;}
.pick-show {position:relative; background-color:#fff;}
.pick-show button {outline:none; background:transparent;}
.pick-show .pick-head {height:477px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/bg_dark_blue.jpg) no-repeat 50% 0;}
.pick-show .pick-head h2 {position:absolute;  top:93px; left:50%; width:538px; height:220px; margin-left:-281px;}
.pick-show .pick-head span {position:absolute; top:0;}
.pick-show .pick-head h2 span.t1 {left:0; z-index:10; animation:bounce1 .8s forwards; opacity:0;}
.pick-show .pick-head h2 span.t2 {top:30px; right:0; animation:bounce1 1s .3s forwards; opacity:0;}
.pick-show .pick-head .dc1 {top:215px; left:50%; margin-left:44px; animation:cursor .8s .5s forwards; opacity:0;}
.pick-show .pick-head .dc2 {top:120px; left:50%; margin-left:-312px; animation:bounce1 1.2s 1.3s forwards; opacity:0;}
.pick-show .pick-head .dc3 {top:126px; left:50%; margin-left:-209px; z-index:10; animation:twinkle1 1s 1.3s 100; opacity:0;}
.pick-show .pick-head .dc4 {top:136px; left:50%; margin-left:165px; animation:twinkle1 1s 1.5s 100; opacity:0;}
.pick-show .subcopy{padding-top:322px;}
.pick-show .go-main {position:absolute; top:20px; left:50%; margin-left:427px; animation:bounce2 1s 100;}

.pick-nav {position:relative; width:1084px; height:95px; margin:-47.5px auto 0; z-index:1; -webkit-box-shadow: 0px 10px 30px 0px rgba(231,231,231,1); -moz-box-shadow: 0px 10px 30px 0px rgba(231,231,231,1); box-shadow: 0px 30px 40px 0px rgba(231,231,231,1);}
.pick-nav .swiper-container {width:100%; height:95px;}
.pick-nav .swiper-slide {height:95px !important;}
.pick-nav li {position:relative; float:left; width:271px; }
.pick-nav li a {overflow:hidden; width:271px; height:100%;}
.pick-nav li img {display:block; margin-top:-99px;}
.pick-nav li.current img {margin-top:0;}
.pick-nav li.open img{margin-top:-199px}
.pick-nav button {position:absolute; top:0;}
.pick-nav .btnPrev {left:-50px;}
.pick-nav .btnNext {right:-50px;}

.picked-item.before .real-rank {display:none;}
.picked-item.after .real-rank {display:block;}
.picked-item.after .my-pick {display:none;}
.picked-item {overflow:hidden; height:340px; padding-top:50px; margin-top:-50px; background-color:#f0f0f0;}
.picked-item .my-pick h3 {margin:35px 0 34px;}
.picked-item .my-pick .submit {margin-top:20px;}
.picked-item .my-pick .submit.bounce2 {animation:bounce2 .2s forwards;}
.picked-item .my-pick .submit,
.picked-item .my-pick ul {float:left;}
.picked-item .my-pick ul {overflow:visible; width:450px; margin:0 15px 0 223px;}
.picked-item .my-pick ul li {float:left; position:relative; width:120px; height:120px; margin:0 15px;}
.picked-item ul li .thumbnail {display:block; width:110px; height:110px; border:solid 5px #fff;}
.picked-item ul li .thumbnail img{display:block; width:110px; height:110px;}
.picked-item .my-pick ul li .thumbnail {background:#d6d6d6 url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/bg_blank.png) no-repeat 50% 50%; color:transparent;}
.picked-item .my-pick ul li .delete {display:block; position:absolute; top:-10px; right:-10px; cursor:pointer}

.picked-item .real-rank {position:relative;}
.picked-item .real-rank h3 {margin:46px 0;}
.picked-item .real-rank .go-category {position:absolute; top:0; left:50%; margin-left:328px;}
.picked-item .real-rank ul{overflow:visible; width:900px; height:120px; margin:0 auto;}
.picked-item .real-rank ul li{position:relative; float:left; width:236px; height:100%; padding-left:44px; margin: 0 10px;}
.picked-item .real-rank ul li:after {content:' '; display:block; position:absolute; top:0; left:0px; width:30px; height:20px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/txt_rank1.png) no-repeat 50% 50%;}
.picked-item .real-rank ul li:first-child + li:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/txt_rank2.png);}
.picked-item .real-rank ul li:first-child + li + li:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/txt_rank3.png);}
.picked-item .real-rank ul li a:hover {text-decoration:none;}
.picked-item .real-rank ul li .rank-inner {display:table;}
.picked-item .real-rank ul li .thumbnail,
.picked-item .real-rank ul li .item-detail {display:table-cell;}
.picked-item .real-rank ul li .item-detail {overflow:hidden; position:relative; padding-left:16px; vertical-align:middle; text-align: left; color:#000; font-weight:bold;}
.picked-item .real-rank ul li .item-detail .brand {width:90px;}
.picked-item .real-rank ul li .item-detail .name {width:90px; max-height:63px;}
.ellipsis-multi {overflow:hidden; text-overflow:ellipsis; display:-webkit-box; -webkit-line-clamp:3; -webkit-box-orient:vertical; word-wrap:break-word; line-height: 21px; white-space: normal;}
.ellipsis {display: inline-block; white-space: nowrap;overflow: hidden; text-overflow: ellipsis;}

.item-list {padding-bottom:105px;}
.items-rolling {position:relative; width:1016px; height:825px; margin:-55px auto 0; z-index:1;}
.items-rolling .swiper-container {overflow:hidden; width:100%; height:825px;}
.items-rolling .swiper-slide {overflow:hidden; float:left; height:825px !important;}
.items-rolling li {position:relative; float:left; width:224px; height:224px; padding:5px 15px 25px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/bg_white2.png); cursor:pointer;}
.items-rolling li img{display:block; border:solid 12px #fff;}
.items-rolling li.on img{border-color:#ff4e4e;}
.items-rolling li.yet img {margin-top:0;}
.items-rolling button {position:absolute; top:298px;}
.items-rolling .btnPrev {left:-60px;}
.items-rolling .btnNext {right:-60px;}
.items-rolling .pagination {position:absolute; bottom:0; left:50%; margin-left:-75px; height:50px;}
.items-rolling .pagination span{display:inline-block; width:50px; height:50px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/btn_pagination.png) no-repeat 0 0; cursor:pointer;}
.items-rolling .pagination .swiper-active-switch {background-position:0 100%;}
.items-rolling .pagination span:first-child + span {background-position:-50px 0;}
.items-rolling .pagination span:first-child + span.swiper-active-switch {background-position:-50px 100%;}
.items-rolling .pagination span:first-child + span + span {background-position:100% 0;}
.items-rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:100% 100%;}

.ly-item {position:absolute; top:0; left:0; z-index:30; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/bg_black.png) repeat 0 0;}
.ly-item .chosen-item {position:relative; width:700px; height:439px; margin:970px auto; padding:2px 22px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/bg_white.png) no-repeat 0 0; }
.ly-item .item-wrap {display:table;width:700px; height:395px;}
.ly-item .chosen-item .thumbnail {width:371px; height:371px; padding:12px;}
.ly-item .chosen-item .thumbnail img {width:371px; height:371px;}
.ly-item .chosen-item .thumbnail,
.ly-item .chosen-item .item-detail {display:table-cell;}
.ly-item .chosen-item .item-detail {padding:0 24px; vertical-align:middle; text-align:left; font-weight:bold; color:#333;}
.ly-item .chosen-item .item-detail .brand,
.ly-item .chosen-item .item-detail .name {width:245px;}
.ly-item .chosen-item .item-detail .price {width:245px; padding:17px 0 22px; border-bottom:1px solid #d4d4d4;}
.ly-item .chosen-item .item-detail .orgin {color:#4c4c4c;}
.ly-item .chosen-item .item-detail .sale {display:inline-block; width:33px; height:15px; background-color:#d11d1d; font-size:9px; line-height:15px; color:#fff; text-align:center;}
.ly-item .chosen-item .item-detail .btn {display:block; width:245px; height:40px; font-size:17px; line-height:40px; color:#fff;}
.ly-item .chosen-item .item-detail .btn-pick {margin-top:45px; background-color:#d11d1d;}
.ly-item .chosen-item .item-detail .btn-more {margin-top:15px; background-color:#9e9e9e;}
.ly-item .chosen-item .close {position:absolute; top:-10px; right:15px;}

@keyframes cursor {
	from {transform:translate(70px, 50px); opacity:0;}
	80% {transform:translate(0);}
	85% {transform:translateY(10px);}
	to {transform:translate(0); opacity:1;}
}
@keyframes bounce1 {
	from {transform:translateY(-50px);}
	50%{transform:translateY(10px)}
	to {transform:translateY(0); opacity:1;}
}
@keyframes bounce2 {
	from to{transform:translateY(0);}
	50%{transform:translateY(5px)}
}
@keyframes twinkle1 {
	from,to {opacity:0;}
	50% {opacity:1;}
}
</style>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/css/numSpinner.css" />
<script type="text/javascript">
$(function(){
	pickNavSwiper = new Swiper('.pick-nav .swiper-container',{
		initialSlide:<% If ItemGroupNum>0 Then Response.write ItemGroupNum-1 Else Response.write ItemGroupNum End If %>,
		loop:false,
		autoplay:false,
		speed:500,
		slidesPerView:'4',
		pagination:false,
		nextButton:'.pick-nav .btnNext',
		prevButton:'.pick-nav .btnPrev'
	});

	$('.pick-nav .btnPrev').on('click', function(e){
		e.preventDefault()
		pickNavSwiper.swipePrev()
	});

	$('.pick-nav .btnNext').on('click', function(e){
		e.preventDefault()
		pickNavSwiper.swipeNext()
	});

	itemSwiper = new Swiper('.items-rolling .swiper-container',{
		initialSlide:0,
		loop:true,
		autoplay:false,
		speed:800,
		slidesPerView:'1',
		pagination:'.items-rolling .pagination',
		nextButton:'.items-rolling .btnNext',
		prevButton:'.items-rolling .btnPrev',
		paginationClickable: true
	});

	$('.items-rolling .btnPrev').on('click', function(e){
		e.preventDefault()
		itemSwiper.swipePrev()
	});

	$('.items-rolling .btnNext').on('click', function(e){
		e.preventDefault()
		itemSwiper.swipeNext()
	});

	$(".ly-item").hide();
	$(".ly-item .thumbnail").hide();

	var position = $('.pick-nav').offset();
	$(".items-rolling ul li").click(function(){
		$('html,body').animate({scrollTop : position.top + 300},300);
	});

//	$(".items-rolling ul li").click(function(){
//		$(".ly-item").show();
//		$(".ly-item .thumbnail").fadeIn(800);
//		event.preventDefault();
//	});

//	$(".my-pick .submit").click(function(e){
//		$(".submit").addClass("bounce2");
//		event.preventDefault();
//		return false;
//	});
});

function fnClosePop(){
	$(".ly-item").hide();
	$(".ly-item .thumbnail").hide();
	event.preventDefault();
	return false;
}
function fnItemInfoView(itemid,sid){
//alert(itemid);
	$.ajax({
		url: "/event/16th/act_itemprd_pop.asp?itemid="+itemid+"&eCode=<%=eCode%>&sid="+sid,
		cache: false,
		async: false,
		success: function(message) {
			if(message!="") {
				$str = $(message);
				$(".ly-item").empty(); 
				$(".ly-item").show();
				$(".ly-item .thumbnail").fadeIn(800);
				$(".ly-item").append($str);
				//event.preventDefault();
				return false;
			} else {
				alert("제공 할 정보가 없습니다.");
				return false;
			}
		}
	});
}

function fnSelectPickItem(itemid,img,sid){
<% If IsUserLoginOK() Then %>
	if($("#itemid1").val()&&$("#itemid2").val()&&$("#itemid3").val()) {
		alert("아이템은 최대 3개까지 고를 수 있습니다.");
		return;
	}

	if($("#itemid1").val()==itemid||$("#itemid2").val()==itemid||$("#itemid3").val()==itemid) {
		alert("이미 선택하신 상품입니다.");
		return;
	}

	var str='<span class="thumbnail"><img src="' + img + '" /></span>';

	if($("#itemid1").val()=="")
	{
		str=str+'<a href="" onclick="fnDeletePickItem(1,'+sid+');return false;" class="delete"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/img_delete.png" alt="선택 취소하기" /></a>';
		$("#spick1").empty();
		$("#itemid1").val(itemid);
		$("#spick1").append(str);
	}
	else if($("#itemid2").val()=="")
	{
		str=str+'<a href="" onclick="fnDeletePickItem(2,'+sid+');return false;" class="delete"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/img_delete.png" alt="선택 취소하기" /></a>';
		$("#spick2").empty();
		$("#itemid2").val(itemid);
		$("#spick2").append(str);
	}
	else
	{
		str=str+'<a href="" onclick="fnDeletePickItem(3,'+sid+');return false;" class="delete"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/img_delete.png" alt="선택 취소하기" /></a>';
		$("#spick3").empty();
		$("#itemid3").val(itemid);
		$("#spick3").append(str);
	}
	$(".ly-item").hide();
	$(".ly-item .thumbnail").hide();
	$("#lyrItemRolling [data='sid"+sid+"']").addClass("on");
	//event.preventDefault();
	return false;
<% else %>
	if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/16th/pickshow.asp")%>';
	}
	return false;
<% End IF %>
}
function fnDeletePickItem(delnum,sid){
	$("#itemid"+delnum).val("");
	$("#spick"+delnum).empty();
	$("#spick"+delnum).append('<span class="thumbnail"></span>');
	$("#lyrItemRolling [data='sid"+sid+"']").removeClass("on");
	return false;
}
function fnSubmitPick(){
<% If IsUserLoginOK() Then %>
	if($("#itemid1").val()=="" && $("#itemid2").val()=="" && $("#itemid3").val()=="")
	{
		alert("아이템을 한가지 이상 선택해 주세요.");
		return false;
	}
	else
	{
		document.pickfrm.action="/event/16th/dopickshow.asp";
		document.pickfrm.submit();
	}
<% else %>
	if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/16th/pickshow.asp")%>';
	}
	return false;
<% End IF %>
}

// 쇼셜네트워크로 글보내기
function popSNSPost(svc,tit,link,pre,tag,img) {
    // tit, img 및 link는 반드시 UTF8로 변환하여 호출요망! (2013.10.02; 허진원 UTF8 처리 문제로 APPS서버 경유)
    var popwin = window.open("http://apps.10x10.co.kr/snsPost/goSNSposts.asp?svc=" + svc + "&link="+link + "&tit="+tit + "&pre="+pre + "&tag="+tag + "&img="+img,'popSNSpost');
    popwin.focus();
}
</script>

</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt"><!-- for dev msg : 왼쪽메뉴(카테고리명) 사용시 클래스 : partEvt / 왼쪽메뉴(카테고리명) 사용 안할때 클래스 : fullEvt -->
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contF contW">
						<div class="ten-show pick-show">

							<!-- 뽑아주쑈! 상단 -->
							<!-- for dev msg 
								- (go-main) 주년이벤트 메인으로 이동 시켜 주세요.
							-->
							<div class="pick-head">
								<h2>
									<span class="t1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tit_pick1.png" alt="뽑아주" /></span>
									<span class="t2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tit_pick2.png" alt="쑈!" /></span>
								</h2>
								<span class="dc1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/img_cursor.png" alt="커서" /></span>
								<span class="dc2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/img_coin.png" alt="동전" /></span>
								<span class="dc3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/img_star.png" alt="반짝이" /></span>
								<span class="dc4"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/img_star2.png" alt="반짝이" /></span>
								<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/txt_subcopy.png" alt="매일매일 마음에 드는 아이템을 최대 3개까지 골라주세요!" /></p>
								
								<a href="/event/16th/" class="go-main"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/txt_16th_v2.png" alt="16주년 텐쇼!" /></a>
							</div>

							<!-- 날짜별 tab -->
							<!-- for dev msg 현재탭에 current 붙여주세요-->
							<div class="pick-nav">
								<div class="swiper-container">
									<ul class="swiper-wrapper">
										<li class="swiper-slide<% If ItemGroup="220325" Then %> current<% Else %><% If date() < "2017-10-11" Then %><% Else %> open<% End If %><% End If %>">
											<a href="/event/16th/pickshow.asp?gid=220325" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_1.png" alt="디자인문구" />
											</a>
										</li>
										<li class="swiper-slide<% If ItemGroup="220326" Then %> current<% Else %><% If date() < "2017-10-11" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-11" Then %>
												<% If date() < "2017-10-11" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_2.png" alt="디지털  핸드폰" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220326" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_2.png" alt="디지털  핸드폰" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220326" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_2.png" alt="디지털  핸드폰" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220327" Then %> current<% Else %><% If date() < "2017-10-12" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-12" Then %>
												<% If date() < "2017-10-12" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_3.png" alt="캠핑 트래블" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220327" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_3.png" alt="캠핑 트래블" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220327" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_3.png" alt="캠핑 트래블" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220328" Then %> current<% Else %><% If date() < "2017-10-13" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-13" Then %>
												<% If date() < "2017-10-13" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_4.png" alt="토이" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220328" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_4.png" alt="토이" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220328" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_4.png" alt="토이" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220329" Then %> current<% Else %><% If date() < "2017-10-14" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-14" Then %>
												<% If date() < "2017-10-14" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_5.png" alt="디자인가전" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220329" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_5.png" alt="디자인가전" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220329" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_5.png" alt="디자인가전" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220437" Then %> current<% Else %><% If date() < "2017-10-15" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-15" Then %>
												<% If date() < "2017-10-15" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_6.png" alt="가구 수납" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220437" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_6.png" alt="가구 수납" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220437" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_6.png" alt="가구 수납" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220438" Then %> current<% Else %><% If date() < "2017-10-16" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-16" Then %>
												<% If date() < "2017-10-16" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_7.png" alt="데코 조명" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220438" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_7.png" alt="데코 조명" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220438" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_7.png" alt="데코 조명" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220439" Then %> current<% Else %><% If date() < "2017-10-17" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-17" Then %>
												<% If date() < "2017-10-17" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_8.png" alt="패브릭 생활" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220439" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_8.png" alt="패브릭 생활" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220439" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_8.png" alt="패브릭 생활" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220440" Then %> current<% Else %><% If date() < "2017-10-18" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-18" Then %>
												<% If date() < "2017-10-18" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_9.png" alt="키친" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220440" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_9.png" alt="키친" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220440" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_9.png" alt="키친" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220441" Then %> current<% Else %><% If date() < "2017-10-19" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-19" Then %>
												<% If date() < "2017-10-19" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_10.png" alt="푸드" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220441" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_10.png" alt="푸드" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220441" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_10.png" alt="푸드" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220442" Then %> current<% Else %><% If date() < "2017-10-20" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-20" Then %>
												<% If date() < "2017-10-20" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_11.png" alt="패션의류" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220442" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_11.png" alt="패션의류" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220442" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_11.png" alt="패션의류" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220443" Then %> current<% Else %><% If date() < "2017-10-21" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-21" Then %>
												<% If date() < "2017-10-21" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_12.png" alt="패션잡화" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220443" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_12.png" alt="패션잡화" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220443" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_12.png" alt="패션잡화" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220444" Then %> current<% Else %><% If date() < "2017-10-22" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-22" Then %>
												<% If date() < "2017-10-22" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_13.png" alt="쥬얼리 시계" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220444" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_13.png" alt="쥬얼리 시계" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220444" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_13.png" alt="쥬얼리 시계" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220445" Then %> current<% Else %><% If date() < "2017-10-23" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-23" Then %>
												<% If date() < "2017-10-23" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_14.png" alt="뷰티" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220445" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_14.png" alt="뷰티" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220445" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_14.png" alt="뷰티" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220446" Then %> current<% Else %><% If date() < "2017-10-24" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-24" Then %>
												<% If date() < "2017-10-24" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_15.png" alt="베이비 키즈" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220446" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_15.png" alt="베이비 키즈" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220446" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_15.png" alt="베이비 키즈" />
											</a>
											<% End If %>
										</li>
										<li class="swiper-slide<% If ItemGroup="220447" Then %> current<% Else %><% If date() < "2017-10-25" Then %><% Else %> open<% End If %><% End If %>">
											<% If nowdate < "2017-10-25" Then %>
												<% If date() < "2017-10-25" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_16.png" alt="CAT&DOG" />
												<% Else %>
												<a href="/event/16th/pickshow.asp?gid=220447" target="_top">
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_16.png" alt="CAT&DOG" />
												</a>
												<% End If %>
											<% Else %>
											<a href="/event/16th/pickshow.asp?gid=220447" target="_top">
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tab_16.png" alt="CAT&DOG" />
											</a>
											<% End If %>
										</li>
									</ul>
								</div>
								<button type="button" class="btnPrev"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/btn_nav_prev.png" alt="이전" /></button>
								<button type="button" class="btnNext"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/btn_nav_next.png" alt="다음" /></button>
							</div>

							<div class="picked-item<% If pickitem1<>"" Or pickitem2<>"" Or pickitem3<>"" Then %> after<% Else %> before<% End If %>">

								<form method="post" name="pickfrm">
								<input type="hidden" name="itemid1" id="itemid1">
								<input type="hidden" name="itemid2" id="itemid2">
								<input type="hidden" name="itemid3" id="itemid3">
								<input type="hidden" name="eCode" value="<%=eCode%>">
								<input type="hidden" name="evt_sub_code" value="<%=ItemGroup%>">
								<div class="my-pick w1140">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tit_mypick<%=ItemGroupNum+1%>.png" alt="내가 뽑은 000 아이템" /></h3>
									<ul class="items">
										<li id="spick1">
											<span class="thumbnail"></span>
										</li>
										<li id="spick2">
											<span class="thumbnail"></span>
										</li>
										<li id="spick3">
											<span class="thumbnail"></span>
										</li>
									</ul>
									<button class="submit" onClick="fnSubmitPick();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/btn_submit.png" alt="제출하기" /></button>
								</div>
								</form>

								<div class="real-rank w1140">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/tit_real_rank.png" alt="실시간 순위" /></h3>
									<a href="/shopping/category_main.asp?disp=<%=ItemGroupCate%>" class="go-category"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/txt_more_item.png" alt="더 많은 상품 보러가기" /></a>
									<% IF (iTotCnt2 >= 0) Then %>
									<ul>
										<% For ix=0 To 2 %>
										<li>
											<a href="/shopping/category_prd.asp?itemid=<%=cEventItemTop.FCategoryPrdList(ix).FItemID%>">
												<div class="rank-inner">
													<span class="thumbnail"><img src="<% if Not(cEventItemTop.FCategoryPrdList(ix).Ftentenimage400="" Or isnull(cEventItemTop.FCategoryPrdList(ix).Ftentenimage400)) Then %><%=getThumbImgFromURL(cEventItemTop.FCategoryPrdList(ix).Ftentenimage400,"110","110","true","false")%><% Else %><%=getThumbImgFromURL(cEventItemTop.FCategoryPrdList(ix).FImageIcon1,"110","110","true","false")%><% End If %>" alt="<%=cEventItemTop.FCategoryPrdList(ix).FItemName%>" /></span>
													<span class="item-detail">
														<span class="brand ellipsis"><%=cEventItemTop.FCategoryPrdList(ix).FBrandName%></span>
														<span class="name ellipsis-multi"><%=chrbyte(cEventItemTop.FCategoryPrdList(ix).FItemName,25,"Y")%></span>
													</span>
												</div>
											</a>
										</li>
										<% Next %>
									</ul>
									<% End If %>
								</div>
							</div>
							<!-- 상품 리스트 -->

							<div class="item-list w1140">
								<div class="items-rolling">
									<div class="swiper-container"  id="lyrItemRolling">
										<div class="swiper-wrapper">
											<% IF (iTotCnt >= 0) Then %>
											<ul class="swiper-slide">
												<% For ix=0 To iTotCnt %>
												<li id="sid<%=ix%>" data="sid<%=ix%>" <% If pickitem1=cEventItem.FCategoryPrdList(ix).FItemID Then Response.write " class=""on""" %><% If pickitem2=cEventItem.FCategoryPrdList(ix).FItemID Then Response.write " class=""on""" %><% If pickitem3=cEventItem.FCategoryPrdList(ix).FItemID Then Response.write " class=""on""" %> onClick="fnItemInfoView(<%=cEventItem.FCategoryPrdList(ix).FItemID%>,'<%=ix%>');"><img src="<% if Not(cEventItem.FCategoryPrdList(ix).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(ix).Ftentenimage400)) Then %><%=getThumbImgFromURL(cEventItem.FCategoryPrdList(ix).Ftentenimage400,"200","200","true","false")%><% Else %><%=getThumbImgFromURL(cEventItem.FCategoryPrdList(ix).FImageIcon1,"200","200","true","false")%><% End If %>" alt="" /></li>
											<% If (ix=11 Or ix=23) And ix<>0 Then %>
											</ul>
											<ul class="swiper-slide">
											<% End If %>
												<% Next %>
											</ul>
											<% End If %>
										</div>
									</div>
									<button type="button" class="btnPrev"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/btn_prev.png" alt="이전" /></button>
									<button type="button" class="btnNext"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80412/btn_next.png" alt="다음" /></button>
									<div class="pagination"></div>
								</div>

								<!-- 상품 상세 팝업 레이어 -->
								<!--- for dev msg
									- (btn-pick) 선택시 '내가 뽑은 000 아이템' 목록에 담기게 해주세요!
									- (btn-more) 해당 상품 상세 페이지로 연결 해주세요
								-->
								<div class="ly-item"></div>
							</div>

							<!-- 유의사항 -->
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/tit_noti.png" alt="이벤트 유의사항" /></h3>
									<ul>
										<li>- 본 이벤트는 텐바이텐 회원님을 위한 혜택입니다.(비회원 증정 불가)</li>
										<li>- ID당 하루에 한 번씩만 참여 가능합니다.</li>
										<li>- 참여 마일리지는 10월 27일(금)에 일괄지급될 예정입니다.</li>
									</ul>
								</div>
							</div>
							<%
								'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
								dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
								snpTitle = Server.URLEncode("[텐바이텐] 16주년 텐쇼 - 매일매일 마음에 드는 아이템을 골라주세요.")
								snpLink = Server.URLEncode("http://www.10x10.co.kr/event/16th/pickshow.asp")
								snpPre = Server.URLEncode("텐바이텐 16주년 텐쑈")
								snpTag = Server.URLEncode("텐바이텐 뽑아주쑈!")
								snpTag2 = Server.URLEncode("#10x10")
								snpImg = Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2017/16th/m/kakao_tenshow_sub2.jpg")	
							%>
							<!-- 공유하기 -->
							<div class="share">
								<div class="inner">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/txt_share.png" alt="1년에 한번 있는 텐바이텐 쑈! 친구와 함께하쑈~!" /></p>
									<div class="btn-group">
										<a href="#" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');tagScriptSend('', 'pcsnsfb', '', 'amplitude');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/btn_facebook_v2.png" alt="페이스북으로 텐쑈 공유하기" /></a>
										<a href="#" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');tagScriptSend('', 'pcsnstw', '', 'amplitude');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/btn_twitter.png" alt="트위터로 텐쑈 공유하기" /></a>
										<a href="#" onclick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>');tagScriptSend('', 'pcsnspt', '', 'amplitude');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/btn_pinterest.png" alt="핀터레스트로 텐쑈 공유하기" /></a>
									</div>
								</div>
							</div>
						</div>
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