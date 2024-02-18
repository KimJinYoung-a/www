<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2019-04-04"
	'response.write currentdate
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<%
	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/event/salelife/index.asp"
			REsponse.End
		end if
	end If
    

    dim couponIdx

    IF application("Svr_Info") = "Dev" THEN
	    couponIdx = "22171,22172,22173,22174"     
    Else
        couponIdx = "40091,40090,40089,40088"     
    End If
    

	Dim cPopular, vDisp, vSort, vCurrPage, i, j, vArrEval, myWishArr,sqlStr
	vDisp = RequestCheckVar(Request("disp"),18)
	vSort = NullFillWith(RequestCheckVar(Request("sort"),1),"3")
	vCurrPage = RequestCheckVar(Request("cpg"),5)

	If vCurrPage = "" Then vCurrPage = 1
	
	Dim vTitle, vLink, vPre, vImg, vIsEnd, vQuery, vState, vNowTime, vCouponMaxCount
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle	= Server.URLEncode("[텐바이텐] 세.라.밸 페스티벌")
	snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/salelife/")
	snpPre		= Server.URLEncode("10x10 이벤트")
	snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/salabal/index/bnr_salabal_share.jpg")


	'// Facebook 오픈그래프 메타태그 작성
	strPageTitle = "[텐바이텐] 세.라.밸 페스티벌"
	strPageKeyword = "[텐바이텐] 세.라.밸 페스티벌"
	strPageDesc = "최대 20% 쿠폰으로 당신의 삶의 질을 높여드릴 상품들이 당신을 기다립니다!"
	strPageUrl = "http://www.10x10.co.kr/event/salelife/"
	strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/salabal/index/bnr_salabal_share.jpg"

Dim userid : userid = GetEncLoginUserID()

Dim iscouponeDown
iscouponeDown = false
vQuery = "select count(1) from [db_item].[dbo].[tbl_user_item_coupon] where userid = '" & getencLoginUserid() & "'"
vQuery = vQuery + " and itemcouponidx in ("&couponIdx&") "
vQuery = vQuery + " and usedyn = 'N' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
If rsget(0) = 4 Then
	iscouponeDown = true
End IF
rsget.close

dim vRs , objCmd

if userid <> "" then
	Set objCmd = Server.CreateObject("ADODB.COMMAND")
	With objCmd
		.ActiveConnection = dbget
		.CommandType = adCmdText
		.CommandText = "SELECT itemid from db_my10x10.dbo.tbl_myfavorite where userid = ? "
		.Prepared = true
		.Parameters.Append .CreateParameter("userid", adVarChar, adParamInput, Len(userid), userid)
		SET vRs = objCmd.Execute
			if not vRs.EOF then
				myWishArr = vRs.getRows()
			end if
		SET vRs = nothing
	End With
	Set objCmd = Nothing
end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.salabal-main {background-color:#fde5ce; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/bg_orange_2.png); background-position:50% 0;}
.salabal-main figure {margin:0;}
.salabal-main button {background-color:transparent;}
.salabal-main button:focus {outline:0;}

.topic {height:492px;}
.topic h2 {width:330px; height:330px; margin:0 auto; padding-top:110px;}
.topic h2 span {opacity:0; transition:all .8s .2s;}
.topic .t1 {margin-left:-100px;}
.topic .t2 {display:inline-block; margin:19px 0 22px 100px; transition-delay:.5s;}
.topic .t3 {margin-left:-100px; transition-delay:.7s;}
.topic.animation .t1 {margin-left:0; opacity:1;}
.topic.animation .t2 {margin-left:0; opacity:1;}
.topic.animation .t3 {margin-left:0; opacity:1;}

.topic .date {position:absolute; top:138px; left:50%; margin-left:-316px;}
.topic .subcopy {margin-top:36px;}

.section {position:relative; z-index:10; height:3245px;}
.section > div {position:absolute; left:50%;}
.section > div h3 {position:absolute; top:0; left:0;}
.section .coupon {top:48px; margin-left:156px;}
.section .coupon p {text-align:left; margin-top:11px; margin-left:5px;}
.section .relay {top:113px; margin-left:-487px;}
.section .relay .inner {position:relative; width:497px; height:516px;}
.section .relay h3 {display:none;}
.section .relay span {position:absolute; top:-20px; left:0; z-index:150; animation:bounce .7s 1000 ease-in-out;}

.section .relay .open {display:inline-block; position:absolute; top:0; left:0; z-index:1; width:497px; height:516px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/tit_relay_open_v3.png);}
.section .relay .open b {overflow:hidden; display:inline-block; position:absolute; left:13px; bottom:21px; width:464px;}
.section .relay .open b:after {display:inline-block; position:relative; z-index:3; width:10000px; height:110px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_stuff_v3.png) 50% 0 repeat-x; animation:slideLeft 80s infinite linear; content:' ';}
.section .relay .open b:before {display:inline-block; position:absolute; bottom:6px; left:116px; z-index:5; width:95px; height:93px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_calc.png) 50% 50% no-repeat; content:' '; }
.section .hundred {top:646px; margin-left:-90px;}
.section .hundred h3 {left:-304px; top:210px;}
.section .hundred h3 span {position:absolute; top:222px; right:-598px;}
.section .salabal-prj {top:1232px; width:1190px; height:930px; margin-left:-595px;}
.section .salabal-prj .prj {position:absolute; opacity:0;}
.section .salabal-prj.prj-slide {top:1232px; width:1190px; height:930px; margin-left:-595px;}
.section .salabal-prj.prj-slide .slick-slide {position:relative; width:1190px; height:930px;}
.section .salabal-prj.prj-slide .slick-arrow {display:inline-block; position:absolute; top:11px; z-index:10; width:46px; height:859px; background-color:transparent; color:transparent;}
.section .salabal-prj.prj-slide .slick-arrow.slick-prev {left:-45px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/bnt_prev_v3.png); background-repeat:no-repeat; background-position:0 0; outline:none;}
.section .salabal-prj.prj-slide .slick-arrow.slick-next {right:-45px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/bnt_next_v3.png);  outline:none;}
.section .salabal-prj.prj-slide .slick-slide.slide2 .prj2 span {top:315px;}
.section .salabal-prj .prj span {display:inline-block; width:86px; height:86px; position:absolute; top:259px; left:53px; color:#222; font:24px/86px 'Roboto'; font-weight:bold;}
.section .salabal-prj .prj span b {display:inline-block; position:relative; z-index:10; width:100%; height:100%; border-radius:50%; background-color:#fff947;}
.section .salabal-prj .prj span:after {display:inline-block; position:absolute; top:0; left:0; z-index:5; width:100%; height:100%; border-radius:50%; background-color:#fff947; content:'';}
.section .salabal-prj .prj:hover span:after {animation:bomb .7s 1000 ease-in;}
.section .salabal-prj div.prj1 {top:0; left:13px;}
.section .salabal-prj div.prj1 span {top:256px; left:585px;}
.section .salabal-prj div.prj2 {bottom:0; left:13px; animation-delay:.3s;}
.section .salabal-prj div.prj3 {bottom:0; right:0; animation-delay:.5s;}
.section .scratch {top:2240px; margin-left:-317px;}
.section .scratch h3 {display:none;}
.section .scratch span {position:absolute; top:-20px; left:198px; animation:swing 1s 1000 ease-in-out;}
.section .prosale {top:2662px; margin-left:-482px; outline:none;}
.section .prosale h3 {top:197px;}
.section .prosale p i {position:absolute; top:0; left:0; z-index:10;}
/*.section .couple-life {top:2590px; margin-left:-486px;}
.section .couple-life h3 {top:261px; left:0; z-index:10;}
.section .couple-life .couple-slide {width:355px; height:311px;}*/
.section .quater-winner {top:2656px; margin-left:-478px;}
.section .quater-winner h3 {top:-52px; left:-60px; animation:swing2 1s 1000 ease-in-out; transform-origin:44% 100%;}
.section .quater-winner span {position:absolute; top:-51px; left:37px; animation:bounce 1.1s 1000 ease-in-out;}
.section .quater-winner span.item2 {top:23px; left:220px; animation-delay:.3s;}
.section .quater-winner span.item3 {top:92px; left:-18px; animation-delay:.5s;}
.section .best {top:2662px; margin-left:115px;}
.section .best h3 {top:378px;}
.section .best span {position:absolute; top:0; left:-10px; z-index:10;}
.section .best i {display:inline-block; position:absolute; top:100px; left:103px; width:156px; height:156px; background-color:#ffe5d4; border-radius:50%; transform:scale(1); transition:all .5s;}
.section .best:hover i {transform:scale(0); transition:all .5s;}

.bnr-sns {position:fixed; top:250px; left:50%; z-index:100; margin-left:490px;}
.bnr-sns ul {position:absolute; top:88px; left:0; width:100%; height:97px;}
.bnr-sns ul li {width:100%; height:40px; margin-bottom:10px;}
.bnr-sns ul li a {display:inline-block; width:100%; height:100%; text-indent:-999em;}

.wish-item {position:relative; z-index:5; padding-bottom:100px; background-color:#f7f7f7;}
.wish-item .inner {width:1140px; margin:0 auto;}
.wish-item h3{padding:100px 0 60px;}
.wish-item .items {padding-bottom:29px;}
.wish-item .items ul {overflow:initial;}
.wish-item .items ul:after {clear:both; display:block; content:'';}
.wish-item .items li {width:320px; height:360px; margin:0 10px 40px; padding:20px; background-color:#fff;box-shadow:5px 5px 15px 0 rgba(0, 0, 0, 0.1);}
.wish-item .items li a div {position:relative;}
.wish-item .items li .thumbnail {width:100%; height:320px;}
.wish-item .items li .thumbnail img {position:relative; z-index:2; height:100%;}
.wish-item .items li .thumbnail:after {z-index:3; background-color:rgba(0,0,0,.04)}
.wish-item .items li .thumbnail:before {display:inline-block; position:absolute; top:0; left:0; z-index:5; width:100%; height:100%; background-color:rgba(0,0,0,.6); opacity:0; content:''; transition:all .6s;}
.wish-item .items li:hover .thumbnail:before {opacity:1;}
.wish-item .items li .desc {position:absolute; bottom:0; left:0; z-index:10; width:calc(100% - 95px); min-height:45px; padding:0 70px 55px 25px; color:#fff; opacity:0; text-align:left; transition:all .6s;}
.wish-item .items li:hover .desc {opacity:1;}
.wish-item .items .name {width:100%; height:auto; font-size:14px; line-height:1.43; font-weight:bold; word-break:keep-all; text-overflow:unset; white-space:normal;}
.wish-item .items .price {position:absolute; bottom:30px; left:25px; color:#fff; font-size:13px;}
.wish-item .items .price .discount.red {margin-right:3px; color:#ffa9a9;}
.wish-item .items .etc {font-size:0; line-height:1;}
.wish-item .items .etc .review {border-right:1px solid rgba(0,0,0,.1); color:#666; font-family:"roboto","AvenirNext-Medium", "AppleSDGothicNeo-Medium", "malgun Gothic","맑은고딕";}
.wish-item .items .etc .review .icon-rating span {display:inline-block; position:relative; top:2px; width:65px; height:13px; margin-right:10px; background:url(//fiximage.10x10.co.kr/web2019/common/ico_star_grey.png) 0 50% no-repeat;}
.wish-item .items .etc .review .icon-rating span i {display:inline-block; position:absolute; top:0; left:0; z-index:10; width:65px; height:13px; background:url(//fiximage.10x10.co.kr/web2019/common/ico_star_yellow.png) 0 50% no-repeat; text-indent:-999em;}
.wish-item .items .etc .review,
.wish-item .items .etc .btn-wish{display:inline-block; width:49%; margin:21px 0; background-color:transparent; font-size:13px; line-height:18px; text-align:center;}
.wish-item .items .etc .btn-wish {margin:0; padding:21px 0;}
.wish-item .items .etc .btn-wish span {padding-left:25px; background-image:url(//fiximage.10x10.co.kr/web2019/common/ico_heart.png?v=1.02); background-repeat:no-repeat; background-position:0 2px; color:#666; font-weight:500;}
.wish-item .items .etc .btn-wish.on span {background-position:0 -15px;}

.wish-item .items li.bnr-sns {position:relative; width:360px; height:400px; padding:0; background-color:transparent; box-shadow:none;}
.wish-item .items li.bnr-sns a {display:inline-block; position:absolute; top:202px; left:90px; width:110px; height:30px; text-indent:-999em;}
.wish-item .items li.bnr-sns a:before {display:inline-block; position:absolute; bottom:6px; right:0; width:70px; height:1px; background-color:#fff; content:''; opacity:0;}
.wish-item .items li.bnr-sns a:hover:before{opacity:1;}
.wish-item .items li.bnr-sns a.insta {top:243px; width:115px;}
.wish-item .items li.bnr-sns a.insta:before {right:0; width:74px;}

#lyrCoupon {display:none; position:fixed; left:50%; top:50%; z-index:999; width:734px; height:632px; margin:-316px 0 0 -367px;}
#lyrCoupon .btn-close {position:absolute; left:50%; top:30px; margin-left:281px;}
#lyrCoupon a {position:absolute; top:460px; left:50%; margin-left:-177px;}
#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background-color:#000; opacity:0.6; cursor:pointer;}

.dc-group {overflow:hidden; position:absolute; top:0; left:50%; z-index:1; width:100%; height:100%; margin-left:-50%;}
.dc-group span {display:inline-block; position:absolute; top:5000px; left:50%;}
.dc-group .dc1 {top:-38px; margin-left:-515px;}
.dc-group .dc2 {top:96px; margin-left:-264px;}
.dc-group .dc3 {top:105px; margin-left:-316px;}
.dc-group .dc4 {top:450px; margin-left:-648px;}
.dc-group .dc5 {top:110px; margin-left:274px;}
.dc-group .dc6 {top:1200px; margin-left:-804px;}
.dc-group .dc7 {top:993px; margin-left:646px;}
.dc-group .dc8 {top:1848px; margin-left:796px;}
.dc-group .dc9 {top:1669px; margin-left:-830px;}
.dc-group .dc10 {top:2099px; margin-left:504px;}
.dc-group .dc11 {top:2666px; margin-left:-1043px;}
.dc-group .dc12 {top:2926px; margin-left:-993px;}
.dc-group .dc13 {top:3142px; margin-left:-712px;}
.dc-group .dc14 {top:3562px; margin-left:-640px;}
.dc-group .dc15 {top:2980px; margin-left:490px;}
.dc-group .dc16 {top:3076px; z-index:5; margin-left:478px;}
.dc-group .dc17 {top:3133px; margin-left:440px;}
.dc-group .dc18 {top:3420px; margin-left:652px;}
.dc-group .dc19 {top:1049px; margin-left:-715px;}
.dc-group .dc20 {top:1080px; margin-left:-860px;}
.dc-group .dc21 {top:1954px; margin-left:820px;}

.zoom {animation:zoom .8s 1 forwards;}
@keyframes zoom {
	from {transform:scale(1);}
	to {transform:scale(.5);}
}
.slideInUp {animation:slideInUp 1s 1 forwards;}
@keyframes slideInUp {
	from {transform:translate3d(0, 70%, 0); opacity:0;}
	to {-webkit-transform:translate3d(0, 0, 0); transform:translate3d(0, 0, 0); opacity:1;}
}
@keyframes bounce{
	from,to {transform:translateY(-7px);}
	50% {transform:translateY(7px);}
}
@keyframes swing{
	from,to {transform:rotate(-1deg);}
	50% {transform:rotate(1deg);}
}
@keyframes swing2{
	from,to {transform:rotate(-15deg);}
	50% {transform:rotate(0deg);}
}
@keyframes slideLeft {
	from {transform:translateX(0);}
	to {transform:translateX(-50%);}
}
@keyframes bomb{
	from {transform:scale(1); opacity:1}
	to {transform:scale(1.5); opacity:0; background-color:#4c6dcb;}
}
</style>
<script style="text/javascript">
var isloading=true;
var myWish = ''

<%
if isArray(myWishArr) then
	for i=0 to uBound(myWishArr,2)
	%>
	myWish = myWish + '<%=myWishArr(0,i)%>,'
	<%
	next
end if
%>
function closeLy() {
	$('#lyrCoupon').fadeOut(200);
	$("#dimmed").hide();
}
$(function(){
	fnAmplitudeEventMultiPropertiesAction('view_2019salelife_main','','');
    $('.btn-wish').click(function(e){
        e.stoppropagation()            
    });
});    
$(function(){
	$(".topic").addClass('animation');
 	// 프로세일러이미지버저닝
	/*var i = 0;
    $(".prosale").mouseover(function(){
		num = ++ i;
		$('.prosale i img').attr('src','//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_prosale_v3.gif'+'?v='+ num);
    }).mouseout(function(){
      $(".prosale i img").removeAttr('src');
    });*/

	// 쿠폰 레이어
	$("#dimmed").hide();

	//세라밸프로젝트
	$(window.parent).scroll(function(){
		var scrl = $(this).scrollTop();
		//console.log(scrl);
		if (scrl > 1000 ) {
			$(".prj").addClass('slideInUp');
		} else {
			$(".prj").removeClass('slideInUp');
		}
	});
	$('.prj-slide').slick({
        autoplay:true,
        autoplaySpeed:5000,
		speed:2400
    });

	// 부부라이프
	/*$('.couple-slide').slick({
		autoplay:true,
		autoplaySpeed:1600,
		speed:1800,
		fade:true,
	});*/
    getList();
    getSaleInfo()
});
</script>
<script style="text/javascript">
function getSaleInfo(){
    var evtcodes = ""
    var $evtEl = $(".evt-sale-info");
    var numOfEvt = $evtEl.length;
    console.log(numOfEvt)
    $evtEl.each(function(){
        var tmpCode = $(this).attr("evtcode");
        evtcodes += tmpCode != "" ? tmpCode + "," : ""                 
    })    
    evtcodes = numOfEvt > 0 ? evtcodes.substr(0, evtcodes.length - 1) : "";
    console.log(evtcodes)

    $.ajax({			
        type: "get",
        url: "evtSaleAjax.asp",
        data: "evtArr="+evtcodes,
        cache: false,
        success: function(message) {
            var items = message.items
            console.log(items)
            $evtEl.each(function(idx, item){                
                for(var i = 0 ; i < items.length ; i ++){
                    if($(this).attr("evtcode") == items[i].evtCode){
                        $(this).html("~" + items[i].salePer + "%")
                    }                                                        
                }                
            })
        },
        error: function(err) {
            console.log(err.responseText);
        }
    });    
    
}
function getList() {        
	var str = $.ajax({
			type: "GET",
	        url: "act_salelife.asp",
	        data: $("#popularfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;	
	if(str!="") {               
    	if($("#popularfrm input[name='cpg']").val()=="1") {
        	//내용 넣기                                  
        	$('#lySearchResult').html(str);			
        } else {            
       		$str = $(str)
       		$('#lySearchResult').append($str)               
        }
        isloading=false;
		chkMyWish()  
    } else {
    	//더이상 자료가 없다면 스크롤 이벤트 종료
    	$(window).unbind("scroll");
    }
}

function fnWishListMore(){    
	var pg = $("#popularfrm input[name='cpg']").val();    
	pg++;
	$("#popularfrm input[name='cpg']").val(pg);    
	setTimeout(getList(),500);
}

function fnWishItemMore(){
	window.open("/my10x10/popularwish.asp","_blank");
}

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
	fnAmplitudeEventMultiPropertiesAction('click_2019salelife_coupon','','');	
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
                    var wrapHeight = $(document).height();
                    $('#lyrCoupon').fadeIn(300);
                    $("#dimmed").show();
                    $("#dimmed").css("height",wrapHeight);
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
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/salelife/")%>';
		return;
	}
}
function chkMyWish(){	
    $('.item-list').each(function(index, item){
        if(myWish.indexOf($(this).attr("itemid")) > -1){
            $(this).find(".btn-wish").addClass("on")
        }        
    })
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt"><!-- for dev msg : 왼쪽메뉴(카테고리명) 사용시 클래스 : partEvt / 왼쪽메뉴(카테고리명) 사용 안할때 클래스 : fullEvt -->
		<div id="contentWrap" style="padding-top:0;">
			<div class="eventWrapV15">


				<div class="eventContV15">
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contF contW">

						<!-- 세라밸 : 메인 -->
						<div class="salabal-main">

							<div class="topic">
								<h2>
									<span class="t1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/tit_salabal_1_v3.png" alt="세일 페스티벌"></span>
									<span class="t2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/tit_salabal_2_v3.png" alt="라이프"></span>
									<span class="t3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/tit_salabal_3_v3.png" alt="밸런스"></span>
								</h2>
								<p class="subcopy"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_subcopy_v2.png" alt="삶의 질이 달라지는 다양한 이야기가 시작됩니다"></p>
								<p class="date"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_date_v2.png" alt="2019. 04.01 - 22"></p>
							</div>

							<div class="section">
								<!-- 쿠폰 발급 레이어 -->
								<div id="dimmed" onclick="closeLy();"></div>
								<div id="lyrCoupon">
									<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_coupon_cont_v2.png" alt="쿠폰이 발급 되었습니다 " />
									<a href="/my10x10/couponbook.asp" target="_blank"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/btn_go_coupon.png" alt="쿠폰함으로 가기" /></a>
									<button class="btn-close" onclick="closeLy();"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/btn_close.png" alt="닫기" /></button>
								</div>
								<!--// 쿠폰 발급 레이어 -->

								<!-- 쿠폰 -->                                    
								<div class="coupon">
                                    <% if Not(IsUserLoginOK) then %>    
                                        <button class="btn-coupon" onclick="jsEventLogin();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_coupon_v3.png" alt="세라밸 쿠폰 받기"></button>
                                    <% Else %>
                                        <% If iscouponeDown Then %>
                                            <button class="btn-coupon"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_coupon_done_v3.png" alt="발급완료"></button>
                                        <% else %>
                                            <button class="btn-coupon" onclick="jsDownCoupon('prd,prd,prd,prd','<%=couponIdx%>');return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_coupon_v2.png" alt="세라밸 쿠폰 받기"></button>
                                        <% end if %>
                                    <% End If %>                                        
									<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_coupon_v2.png" alt="당신의 라이프를 업그레이드 시켜줄  쿠폰을 받아 가세요!"></p>
								</div>

								<!-- 백원의 기적 -->
								<div class="hundred">
									<a href="/event/eventmain.asp?eventid=93354" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_100won','','');">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_hundred_1_v2.png" alt="100원의 기적 "><span><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_hundred_2_v2.png" alt="price 100won"></span></h3>
										<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_hundred_v4.gif" alt=""></p>
									</a>
								</div>

								<!-- 앗싸 에어팟 (릴레이) -->
								<div class="relay">
									<a href="/event/eventmain.asp?eventid=93475" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_airpod2','','');">
										<h3>앗싸~ 에어팟2 득템!</h3>
										<p class="inner">
											<!--<i class="closed cls1" data-0="width:246px;" data-700="width:0;"></i>
											<i class="closed cls2" data-0="width:251px; margin-left:-251px;" data-700="width:0; margin-left:0;"></i>-->
											<i class="open"><b></b></i>
											<span><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_relay_v3.png" alt="지금, sns에 포스팅하고 에어팟2 득템에 도전하세요!"></span>
										</p>
									</a>
								</div>

								<!-- 세라밸 프로젝트 -->
								<div class="prj-slide salabal-prj">
									
									<div class="slide2">
										<div class="prj1 prj">
											<a href="/event/eventmain.asp?eventid=93412" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_project','idx','4');">
												<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_prj_sale_4_v3.png" alt="깔끔함의 끝,  정리정돈!">
												<span><b class="evt-sale-info" evtcode="93412">~%</b></span>
											</a>
										</div>
										<div class="prj2 prj">
											<a href="/event/eventmain.asp?eventid=93413" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_project','idx','5');">
												<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_prj_sale_5_v3.png" alt="집에서 즐기는  심야식당의 모든 것">
												<span><b class="evt-sale-info" evtcode="93413">~%</b></span>
											</a>
										</div>
										<div class="prj3 prj">
											<a href="/event/eventmain.asp?eventid=93414" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_project','idx','6');">
												<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_prj_sale_6_v3.png" alt="손 쉽게  부기빼는 방법">
												<span><b class="evt-sale-info" evtcode="93414">~%</b></span>
											</a>
										</div>
									</div>

                                    <div class="slide3">
										<div class="prj1 prj">
											<a href="/event/eventmain.asp?eventid=93415" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_project','idx','7');">
												<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_prj_sale_7_v2.png" alt="하나를 샀는데,  두개를 얻은 기분">
												<span><b class="evt-sale-info" evtcode="93415">~%</b></span>
											</a>
										</div>
										<div class="prj2 prj">
											<a href="/event/eventmain.asp?eventid=93416" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_project','idx','8');">
												<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_prj_sale_8_v2.png" alt="우리 집 여백  활용백서">
												<span><b class="evt-sale-info" evtcode="93416">~%</b></span>
											</a>
										</div>
										<div class="prj3 prj">
											<a href="/event/eventmain.asp?eventid=93417" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_project','idx','9');">
												<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_prj_sale_9_v2.png" alt="우리 집 여백  활용백서">
												<span><b class="evt-sale-info" evtcode="93417">~%</b></span>
											</a>
										</div>
									</div>

									<div class="slide1">
										<div class="prj1 prj">
											<a href="/event/eventmain.asp?eventid=93409" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_project','idx','1');">
												<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_prj_sale_1_v3.png" alt="프로자취러를 위한 모든 것">
												<span><b class="evt-sale-info" evtcode="93409">~%</b></span>
											</a>
										</div>
										<div class="prj2 prj">
											<a href="/event/eventmain.asp?eventid=93410" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_project','idx','2');">
												<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_prj_sale_2_v3.png" alt="직장생활의 완성은 데스크테리어!">
												<span><b class="evt-sale-info" evtcode="93410">~%</b></span>
											</a>
										</div>
										<div class="prj3 prj">
											<a href="/event/eventmain.asp?eventid=93411" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_project','idx','3');">
												<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_prj_sale_3_v3.png" alt="좋은 냄새 활용법!">
												<span><b class="evt-sale-info" evtcode="93411">~%</b></span>
											</a>
										</div>
									</div>
								</div>

								<!-- 스크래치 -->
								<div class="scratch">
									<a href="/event/eventmain.asp?eventid=87066" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_event','evtname','스크래치기획전');">
										<h3>스크래치가구전</h3>
										<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/tit_scratch_v3.png" alt="스크래치 가구展"></p>
										<span><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_scratch_v2.png" alt="어차피 생길 스크래치 할인 받아 구매하자!"></span>
									</a>
								</div>

								<!-- 프로세일러 -->
								<!--<div class="prosale">
									<a href="/event/eventmain.asp?eventid=93345" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_event','evtname','프로세일러');">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/tit_prosale.png" alt="프로 세일러"></h3>
										<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_prosale_v3.png" alt="세일의 프로가 쇼핑을 제안합니다! UP TO 90%"><i><img src="" alt=""></i></p>
									</a>
								</div>-->

                                <!-- 부부라이프 -->
								<!--<div class="couple-life">
									<a href="/event/eventmain.asp?eventid=93256" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_event','evtname','쀼라이프');">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/tit_couple_life.png" alt="쀼라이프"></h3>
										<div class="couple-slide">
											<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_couple_slide_1.png" alt="엠디부부"></div>
											<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_couple_slide_2.png" alt="디자이너부부"></div>
											<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_couple_slide_3.png" alt="프로쇼핑러부부"></div>
											<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_couple_slide_4.png" alt="ceo부부"></div>
										</div>
									</a>
								</div>-->

								<!-- 1분기 결산템 -->
								<div class="quater-winner">
									<!--<a href="/event/eventmain.asp?eventid=93497" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_event','evtname','1분기 결산템');">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_home_interior.png" alt="1분기 결산템 2019년 1분기 리빙템 인기쟁이를 만나보세요!"></h3>
										<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_home_interior.gif" alt="home interior"></p>
									</a>
									<a href="/event/eventmain.asp?eventid=93563">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_fashion.png" alt="1분기 결산템 2019년 1분기 패션 뷰티 인기쟁이를 만나보세요!"></h3>
										<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_fashion.gif" alt="fashion beauty"></p>
									</a>
									<a href="/event/eventmain.asp?eventid=93564" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_event','evtname','1분기 결산템');">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_mania.png" alt="1분기 결산템 텐텐러들이 사랑한 매니아 아이템"></h3>
										<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_mania.gif" alt="텐텐러들이 사랑한 매니아 아이템"></p>
										<span class="item1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_mania1.png" alt=""></span>
										<span class="item2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_mania2.png" alt=""></span>
										<span class="item3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_mania3.png" alt=""></span>
									</a>
									<a href="/event/eventmain.asp?eventid=93497" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_event','evtname','1분기 결산템');">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_home_interior.png" alt="1분기 결산템 2019년 1분기 리빙템 인기쟁이를 만나보세요!"></h3>
										<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_home_interior_v2.gif" alt="home interior"></p>
									</a>-->
									<!--<a href="/event/eventmain.asp?eventid=93565"onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_event','evtname','1분기 결산템');">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_lifestyle.png" alt="1분기 결산템 텐텐러들이 사랑한 라이프스타일 아이템"></h3>
										<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_lifestyle.gif" alt="텐텐러들이 사랑한 매니아 아이템"></p>
										<span class="item1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_lifesyle1.png" alt=""></span>
										<span class="item2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_lifesyle2.png" alt=""></span>
										<span class="item3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_lifesyle3.png" alt=""></span>
									</a>-->
									<a href="/event/eventmain.asp?eventid=91839" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_event','evtname','어서와 텐바이텐');">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/txt_welcome.png" alt="어서와~"></h3>
										<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/tit_welcome.png" alt="텐텐은 처음이지?"></p>
									</a>
								</div>

								<!-- 베스트 -->
								<div class="best">
									<a href="/award/awardlist.asp?atype=b" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_event','evtname','베스트셀러');">
										<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/tit_best_v2.png" alt="베스트셀러 "></h3>
										<p>
											<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_best_2_v3.png" alt="삶의 질을 올려주는 텐바이텐 베스트셀러를 소개합니다">
											<span><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_best_v2.png" alt="BEST SELLER"></span>
											<i></i>
										</p>
									</a>
								</div>
							</div>

							<!-- 배경 데코 -->
							<div class="dc-group parallax-wrapper">
								<span class="dc1"><figure class="parallax-1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_1_v3.png" alt=""></figure></span>
								<span class="dc2"><figure class="parallax-2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_2_v3.png" alt=""></figure></span>
								<span class="dc3"><figure class="parallax-3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_3_v3.png" alt=""></figure></span>
								<span class="dc4"><figure class="parallax-4"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_4_v3.png" alt=""></figure></span>
								<span class="dc5"><figure class="parallax-5"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_5_v3.png" alt=""></figure></span>
								<span class="dc6"><figure class="parallax-6"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_6_v3.png" alt=""></figure></span>
								<span class="dc7"><figure><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_7_v3.png" alt=""></figure></span>
								<span class="dc8"><figure class="parallax-7"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_8_v2.png" alt=""></figure></span>
								<span class="dc9"><figure><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_9_v3.png" alt=""></figure></span>
								<span class="dc10"><figure><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_10_v3.png" alt=""></figure></span>
								<span class="dc11"><figure class="parallax-8"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_11_v3.png" alt=""></figure></span>
								<span class="dc12"><figure><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_12_v3.png" alt=""></figure></span>
								<span class="dc13"><figure class="parallax-1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_13_v2.png" alt=""></figure></span>
								<span class="dc14"><figure class="parallax-2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_14_v3.png" alt=""></figure></span>
								<span class="dc15"><figure class="parallax-5"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_15_v3.png" alt=""></figure></span>
								<span class="dc16"><figure class="parallax-5"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_16_v3.png" alt=""></figure></span>
								<span class="dc17"><figure><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_17_v3.png" alt=""></figure></span>
								<span class="dc18"><figure><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_18_v3.png" alt=""></figure></span>
								<span class="dc19"><figure><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_19.png" alt=""></figure></span>
								<span class="dc20"><figure><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_20_v2.png" alt=""></figure></span>
								<span class="dc21"><figure class="parallax-5"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/img_figure_21_v2.png" alt=""></figure></span>
							</div>

							<!-- 위시 -->
							<div class="wish-item">
                                <form id="popularfrm" name="popularfrm" method="get" style="margin:0px;">
                                    <input type="hidden" name="cpg" id="cpg" value="1" />
                                    <input type="hidden" name="disp" value="<%=vDisp%>" />
                                    <input type="hidden" name="sort" value="<%=vSort%>" />
                                </form>                            
								<div class="inner">
									<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/tit_wish_v3.png" alt="지금, 다른 사람들이 위시하는 상품을 실시간으로 만나보세요!"></h3>
									<div class="items type-thumb">            
										<ul id="lySearchResult" class="wishList">                                            
										</ul>
									</div>
									<button onclick="fnWishListMore()"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/btn_more_v2.png" alt=""></button>
								</div>
							</div>
							<!-- 공유 -->
							<div class="bnr-sns">
								<img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/index/bnr_share_v3.png" alt="sns 공유하기">
								<ul>
									<li><a href="javascript:snschk('fb');" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_share','type','fb');">페이스북 공유</a></li>
									<li><a href="javascript:snschk('tw');" onclick="fnAmplitudeEventMultiPropertiesAction('click_2019salelife_share','type','tw');">트위터 공유</a></li>                         
								</ul>
							</div>
						</div>
						<!--// 세라밸 : 메인 -->
					</div>
					<!-- //event area(이미지만 등록될때 / 수작업일때) -->
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<!--<script type="text/javascript" src="/lib/js/skrollr.min.js"></script>
<script type="text/javascript">
skrollr.init({

});
</script>-->
<script type="text/javascript">
// 도형animation
	(function ($) {
		$.fn.parallax = function (options) {
			var parallax_element = this;
			var settings = {
				speed: '100',
				ascending: true,
				delay: '1000'
			};

			if (options) {
				$.extend(settings, options);
			}

			var ad = "+";
			if (!settings['ascending'] == true) {
				var ad = "-";
			}

			$(window).scroll(function () {
				var wScroll = $(this).scrollTop();
				parallax_element.css({
					"transform": "translate(0px, " + ad + wScroll / settings['speed'] + "%)",
					"transition-duration": settings['delay'] + "ms"
				});
			});
		}
	}(jQuery));

	$(function(){
		$(".dc-group span").addClass('dc');
		$(".parallax-1").parallax({speed:10,ascending:true,delay:800});
		$(".parallax-2").parallax({speed:100,ascending:true,delay:800});
		$(".parallax-3").parallax({speed:10,ascending:false,delay:800});
		$(".parallax-4").parallax({speed:10,ascending:true,delay:800});
		$(".parallax-5").parallax({speed:50,ascending:false,delay:800});
		$(".parallax-6").parallax({speed:10,ascending:true,delay:800});
		$(".parallax-7").parallax({speed:50,ascending:true,delay:800});
		$(".parallax-8").parallax({speed:50,ascending:false,delay:800});
	})
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->