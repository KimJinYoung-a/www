<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2020 팬스티벌 
' History : 2020-06-05 이종화
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<%
dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode = "102178"
Else
	eCode = "103142"
End If
%>
<style>
div.fullEvt #contentWrap {padding-top:0 !important;}
div.fullEvt .evtHead {display:none !important;}
div.fullEvt .eventContV15 {margin-top:0 !important;}
.finish-event {display:none;}

.fan2020 {background-color:#fff; color:#111;}
.fan2020 a {color:#111;}
.fan2020 a:hover {text-decoration:none;}

.fan2020 .top-vod {height:810px;}
.fan2020 .top-vod h2 {display:none;}
.today {height:270px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/103142/bg_today.jpg) no-repeat 50% 0;}
.today a {display:flex; align-items:center; width:1140px; height:100%; padding:0 100px 0 68px; margin:0 auto; box-sizing:border-box;}
.today h3 {margin-right:130px;}
.today .desc {width:250px; margin-right:105px;}
.today .name {font-size:23px; line-height:1.2; text-align:right; word-break:keep-all;}
.today .price {position:relative; padding-top:40px; margin-top:25px; font-size:26px; line-height:1; font-weight:800; text-align:right;}
.today .price s {margin-right:16px; font-size:18px; color:#8c8c8c; font-style:italic; font-weight:300;}
.today .price span {position:absolute; top:0; right:0; padding:6px 9px; border-radius:4px; background-color:#ff5a12; color:#fff; font-size:15px; font-weight:500;}
.today .thumbnail {overflow:hidden; width:216px; height:216px; border-radius:50%; border:solid 6px #e4e4e4;}
.today .thumbnail img {width:100%; height:100%;}

.nav-fan {position:relative; width:100vw; background-color:#fff;}
.nav-fan:after {display:block; position:absolute; bottom:0; left:0; width:100vw; height:2px; background-color:#dadada; content:'';}
.nav-fan ul {display:flex; width:1140px; margin:0 auto;}
.nav-fan ul li {position:relative; width:25%; border-bottom:solid 2px #dadada;}
.nav-fan ul li a {display:block; color:#a6a6a6; font-size:24px; font-weight:500;}
.nav-fan ul li.on:after {display:block; position:absolute; bottom:-2px; left:0; z-index:20; width:100%; height:6px; background-color:#18a6ff; content:'';}
.nav-fan ul li.on a {color:#18a6ff;}
.nav-fan ul li .ico {display:flex; height:95px; align-items:flex-end; justify-content:center; box-sizing:border-box;}
.nav-fan ul .nav-youtube .ico {padding-bottom:8px;}
.nav-fan ul li span {display:flex; align-items:center; justify-content:center; height:70px;}

.fixed.nav-fan {position:fixed; top:0; left:50%; z-index:30; transform:translateX(-50%);}
.fixed.nav-fan .ico {display:none;}
.fixed.nav-fan ~ .section {margin-top:176px;}

.section {width:1140px; margin:0 auto;}
.section-top {padding:70px 0; background-color:#e4f7ff;}
.section-top h3 {margin-bottom:23px; font-size:34px; line-height:1; font-weight:800; color:#111;}
.section-top > p {font-size:24px; font-weight:500;}
.section-top .nav-sub {margin-top:30px; font-size:0;}
.section-top .nav-sub ul li {display:inline-block; margin:0 5px;}
.section-top .nav-sub ul li a {display:inline-block; padding:5px 9px 4px; color:#a5a5a5; border-radius:16px; border:solid 2px #a5a5a5; background-color:#fff; font-size:20px; line-height:1; font-weight:500;}
.section-top .nav-sub ul li.on a {border-color:#18a6ff; color:#18a6ff;}

.fan2020 .item-wrap {padding-top:60px;}
.fan2020 .item-wrap .tit {padding-left:20px; margin-bottom:40px; font-size:30px; color:#18a6ff; font-weight:600; line-height:1; text-align:left;}
.fan2020 .item-list {position:relative; display:flex; flex-wrap:wrap; justify-content:space-between; width:1100px; min-height:430px; margin:0 auto; padding:0 20px;}
.fan2020 .item-list.on {display:block;}
.fan2020 .item-list li {position:relative; width:252px; margin-bottom:55px;}
.fan2020 .item-list li a {position:relative; display:block; text-decoration:none;}
.fan2020 .item-list .thumbnail {overflow:hidden; position:relative; width:100%; height:252px; border-radius:10px;}
.fan2020 .item-list .thumbnail:after {display:block; position:absolute; top:0; left:0; z-index:10; width:100%; height:100%; background-color:rgba(0,0,0,.03); content:'';}
.fan2020 .item-list .thumbnail img {width:100%;}
.fan2020 .item-list .desc {padding:15px 8px 0; font-size:14px; text-decoration:none; text-align:left;}
.fan2020 .item-list .desc .name {overflow:hidden; height:44px; margin-bottom:10px;}
.fan2020 .item-list .desc .price-area {display:flex; align-items:center; margin-bottom:8px; font-weight :bold; font-size:16px;}
.fan2020 .item-list .desc .price-area .won {display:none;}
.fan2020 .item-list .desc .price-area .discount {display:inline-block; margin-left:5px; font-weight:normal; font-size:14px;}
.fan2020 .item-list .desc .price-area .color-red {color:#ff357b !important;}
.fan2020 .item-list .desc .price-area .color-green {color:#00cfcb !important;}
.fan2020 .item-list .desc .brand {font-size:12px; color:#999;}
.fan2020 .item-list .tag {display:flex; align-items:center; float:left; padding-left:8px; margin-right:10px;}
.fan2020 .item-list .icon {position:relative; display:inline-block; vertical-align:middle;}
.fan2020 .item-list .icon:before {content:' '; position:absolute; top:0; left:0;}
.fan2020 .item-list .icon-rating {width:82px; height:13px;}
.fan2020 .item-list .icon-rating:before, .fan2020 .item-list .icon-rating i {width:100%; height:100%; background:url(//fiximage.10x10.co.kr/web2019/common/ico_star.png) 0 0 no-repeat;}
.fan2020 .item-list .icon-rating i {position:absolute; left:0; top:0; text-indent:-999px; background-position:0 100%;}
.fan2020 .item-list .counting {padding-left:5px; font-size:12px;}

.fan2020 .section-func .item-list .desc .price {margin-bottom:8px; font-weight:bold; font-size:16px;}
.fan2020 .section-func .item-list .desc .price s {display:none;}
.fan2020 .section-func .item-list .desc .price span {margin-left:0; font-weight:normal; font-size:14px;}
.fan2020 .section-func .item-list .desc .price span:nth-of-type(1) {margin-left:5px;}
.fan2020 .section-func .item-list .desc .sale {color:#ff357b;}
.fan2020 .section-func .item-list .desc .coupon {color:#00cfcb;}

.fan2020 .section-yt .yt {display:flex; justify-content:space-between; align-items:center; padding:75px 0; border-bottom:2px solid #e0e0e0;}
.fan2020 .section-yt .yt p {width:259px; text-align:center;}
.fan2020 .section-yt .yt .vod {padding:0 53px;}
.fan2020 .section-yt .yt .vod iframe {width:720px; height:405px; border-width:22px 27.5px; border-style:solid; border-color:#cff4ff; border-radius:20px;}
.fan2020 .section-yt .yt2 .vod iframe {border-color:#d2ddff;}
.fan2020 .section-yt .yt3 {border:0; padding-bottom:0;}
.fan2020 .section-yt .yt3 .vod iframe {border-color:#badcff;}

.fan2020 .badge {display:inline-block; position:absolute; top:6px; left:6px; z-index:4; width:30px; height:30px; border:solid 2px #3db8ec; border-radius:50%; background-color:#b9eaff; color:#111; font-size:14px; line-height:30px; font-weight:600; text-align:center;}
.fan2020 .badge-time {width:unset; padding:0 10px; border-radius:30px;}

.fan2020 .btn-more {display:inline-block; width:173px; height:36px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/103142/btn_more.png) no-repeat 50% 0; text-indent:-999em;}
.fan-brand {margin-top:90px; background-color:#76d0f6;}
</style>
<%
	Dim today_code, currentDate
	currentDate = date()
	'currentDate = "2020-06-10"
	today_code = "2955051"

	if currentdate = "2020-06-09" Then
		today_code = "2922292"
	ElseIf currentdate = "2020-06-10" Then
		today_code = "2928972"
	ElseIf currentdate = "2020-06-11" Then
		today_code = "2930481"
	ElseIf currentdate >= "2020-06-12" AND currentdate <= "2020-06-14" Then
		today_code = "2930529"
	ElseIf currentdate >= "2020-06-15" AND currentdate <= "2020-06-16" Then
		today_code = "2936675"
	ElseIf currentdate = "2020-06-17" Then
		today_code = "2941119"
	ElseIf currentdate = "2020-06-18" Then
		today_code = "2941101"
	ElseIf currentdate >= "2020-06-19" AND currentdate <= "2020-06-21" Then
		today_code = "2930529"
	ElseIf currentdate = "2020-06-22" Then
		today_code = "2954995"
	ElseIf currentdate = "2020-06-23" Then
		today_code = "2955047"
	ElseIf currentdate = "2020-06-24" Then
		today_code = "2955048"
	ElseIf currentdate = "2020-06-25" Then
		today_code = "2955051"
	ElseIf currentdate = "2020-06-26" AND currentdate <= "2020-06-28" Then
		today_code = "2955062"
	ElseIf currentdate = "2020-06-29" Then
		today_code = "2954995"
	ElseIf currentdate = "2020-06-30" Then
		today_code = "2955047"
	ElseIf currentdate = "2020-07-01" Then
		today_code = "2955048"
	ElseIf currentdate = "2020-07-02" Then
		today_code = "2955051"
	ElseIf currentdate = "2020-07-03" AND currentdate <= "2020-07-05" Then
		today_code = "2955062"
	ElseIf currentdate = "2020-07-06" Then
		today_code = "2954995"
	ElseIf currentdate = "2020-07-07" Then
		today_code = "2955047"
	ElseIf currentdate = "2020-07-08" Then
		today_code = "2955048"
	ElseIf currentdate = "2020-07-09" Then
		today_code = "2955051"
	ElseIf currentdate = "2020-07-10" AND currentdate <= "2020-07-12" Then
		today_code = "2955062"
	ElseIf currentdate = "2020-07-13" Then
		today_code = "2954995"
	ElseIf currentdate = "2020-07-14" Then
		today_code = "2955047"
	ElseIf currentdate = "2020-07-15" Then
		today_code = "2955048"
	ElseIf currentdate = "2020-07-16" Then
		today_code = "2955051"
	ElseIf currentdate = "2020-07-17" AND currentdate <= "2020-07-19" Then
		today_code = "2955062"
	ElseIf currentdate = "2020-07-20" Then
		today_code = "2954995"
	ElseIf currentdate = "2020-07-21" Then
		today_code = "2955047"
	ElseIf currentdate = "2020-07-22" Then
		today_code = "2955048"
	ElseIf currentdate = "2020-07-23" Then
		today_code = "2955051"
	ElseIf currentdate = "2020-07-24" AND currentdate <= "2020-07-26" Then
		today_code = "2955062"
	ElseIf currentdate = "2020-07-27" Then
		today_code = "2954995"
	ElseIf currentdate = "2020-07-28" Then
		today_code = "2955047"
	ElseIf currentdate = "2020-07-29" Then
		today_code = "2955048"
	ElseIf currentdate = "2020-07-30" Then
		today_code = "2955051"
	ElseIf currentdate = "2020-07-31" AND currentdate <= "2020-08-02" Then
		today_code = "2955062"
	End If
%>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script>
$(function(){
	fnApplyToTalPriceItem({
		items:<%=today_code%>,
		target:"item",
		fields:["image","name","price","sale"],
		unit:"hw"
	});

	// section-func items
	funcFans = [
		{codeList: [2933363,2878525,2878662,2932416,2943925,2944212,2967365,2366122,1954882,2878664,2895696,2886311]},
		{codeList: [2975756,2904884,2928938,2353564,1702345,2913317,2901678,2360383,2359618,2372348,2791616,2916033]},
		{codeList: [2923535,2920325,2896990,2865619,2901865,2901657,2981631,1934911,2956806,2380063,2400866,2890418]}
	]
	$.each(funcFans, function (i, item) {
		var codeGrp = funcFans[i].codeList
		var itemList = "itemList" + (i+1)
		var $rootEl = $("#" + itemList)
		var itemEle = tmpEl = ""
		$rootEl.empty();

		codeGrp.forEach(function(item){
			tmpEl = '<li>\
						<a href="/shopping/category_prd.asp?itemid='+item+'&pEtr=103142">\
							<div class="thumbnail"><img src="" alt="" /></div>\
							<div class="desc">\
								<div class="price"><s>정가</s> 할인가<span class="sale">상품할인%</span> <span class="coupon">쿠폰할인%</span></div>\
								<p class="name">상품명</p>\
							</div>\
							<div class="etc">\
								<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>\
							</div>\
						</a>\
					</li>\
					'
			itemEle += tmpEl
		});
		$rootEl.append(itemEle)
	
		fnApplyItemInfoToTalPriceList({
			items:codeGrp,
			target:itemList,
			fields:["image","name","price","salecoupon","evaluate"],
			unit:"none",
			saleBracket:false
		});
	});

	// scroll
	$('html,body').animate({ scrollTop : $('.fan2020').offset().top }, 100);

	// nav fan
	$(".fan2020 .section").hide();
	$('.section-yt').show();
	$(".nav-fan li a").click(function(){
		$(this).parents('li').addClass('on').siblings("li").removeClass("on");
		var thisCont = $(this).attr("href");
		$(".fan2020 .section").hide();
		$(thisCont).show();
		$('html, body').animate({'scrollTop': $('.today').offset().top + 360},0);
		return false;
	});
	
	// sub nav scroll
	$(".nav-sub li a").click(function(){
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top - 70}, 0);	
		return false;
	});

	// fixed 
	window.onload=function(){
		var menuTab = $(".nav-fan").offset().top;
		$(window).scroll(function(){
			if( $(window).scrollTop() >= menuTab ) {
				$(".nav-fan").addClass("fixed");
			} else {
				$(".nav-fan").removeClass("fixed");
			}
		});
    }
    
    fnSearchPriceItems(1);
    fnSearchPriceItems(2);
    fnSearchPriceItems(3);
    fnSearchPriceItems(4);
    fnJustSoldItems();
});

function fnSearchPriceItems(v) {
    var dataUrl = "";
    var targetElement = "";
	switch (v) {
		case 1:
            dataUrl = "/event/lib/act_searchitem.asp?search_on=on&rect=%ED%9C%B4%EB%8C%80%EC%9A%A9%EC%84%A0%ED%92%8D%EA%B8%B0&sflag=n&cpg=1&chkr=False&chke=False&sscp=N&psz=12&srm=bs&minPrc=690&maxPrc=9990&lstDiv=search&listoption=all&prevmode=L";
            targetElement = "fanPrice1";
			break;
		case 2 :
            dataUrl = "/event/lib/act_searchitem.asp?search_on=on&rect=%ED%9C%B4%EB%8C%80%EC%9A%A9%EC%84%A0%ED%92%8D%EA%B8%B0&sflag=n&cpg=1&chkr=False&chke=False&sscp=N&psz=12&srm=bs&minPrc=10000&maxPrc=19990&lstDiv=search&listoption=all&prevmode=L"
            targetElement = "fanPrice2";
			break;
		case 3 :
            dataUrl = "/event/lib/act_searchitem.asp?search_on=on&rect=%ED%9C%B4%EB%8C%80%EC%9A%A9%EC%84%A0%ED%92%8D%EA%B8%B0&sflag=n&cpg=1&chkr=False&chke=False&sscp=N&psz=12&srm=bs&minPrc=20000&maxPrc=29990&lstDiv=search&listoption=all&prevmode=L"
            targetElement = "fanPrice3";
			break;
		case 4 :
            dataUrl = "/event/lib/act_searchitem.asp?search_on=on&rect=%ED%9C%B4%EB%8C%80%EC%9A%A9%EC%84%A0%ED%92%8D%EA%B8%B0&sflag=n&cpg=1&chkr=False&chke=False&sscp=N&psz=12&srm=bs&minPrc=30000&maxPrc=99990&lstDiv=search&listoption=all&prevmode=L"
            targetElement = "fanPrice4";
			break;
		default :
			dataUrl = ""
			break;
    }
    
	$.ajax({
		url: dataUrl,
		cache: false,
		success: function(message) {
			if(message!="") {
				$("#"+targetElement).empty().append(message);
			} 
		}
		,error: function(err) {
			alert(err.responseText);
		}
	});
}

var cpg = 0;
function fnJustSoldItems() {
    cpg++;   

    $.ajax({
		url: '/event/lib/act_justsoldcategory.asp?cpg='+cpg,
		cache: false,
		success: function(message) {
			if(message!="") {
				$("#justsold").append(message);
			} 
		}
		,error: function(err) {
			alert(err.responseText);
		}
	});
}
</script>
<div class="evt103142 fan2020">
    <div class="top-vod">
        <h2>2020팬스티벌</h2>
        <video id="video-cnt" preload="auto" autoplay="true" muted="muted" volume="0" style="width:1920px; height:810px;">
            <source src="//webimage.10x10.co.kr/video/vid983.mp4" type="video/mp4">
        </video>
    </div>
    
    <%'!-- 오늘의 특가 --%>
    <div class="today">
        <a href="/shopping/category_prd.asp?itemid=<%=today_code%>&pEtr=103142" class="item<%=today_code%>">
            <h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/103142/tit_today.png" alt="오늘만 이 가격"></h3>
            <div class="desc">
                <p class="name">일이삼사오육칠팔구십 일이삼사오육칠파구십일이</p>
                <div class="price"><s>정가</s> 할인가<span>할인율%</span></div>
            </div>
            <div class="thumbnail"><img src="" alt=""></div>
        </a>
    </div>

    <%'!-- 탭 --%>
	<div class="nav-fan">
		<ul>
			<li class="nav-youtube on">
				<a href="#sectionYt">
					<i class="ico"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103142/ico_yt.png" alt=""></i>
					<span>유투버 Pick</span>
				</a>
			</li>
			<li class="nav-func">
				<a href="#sectionFunc">
					<i class="ico"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103142/ico_func.png" alt=""></i>
					<span>기능</span>
				</a>
			</li>
			<li class="nav-price">
				<a href="#sectionPrice">
					<i class="ico"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103142/ico_price.png" alt=""></i>
					<span>가격</span>
				</a>
			</li>
			<li class="nav-sold">
				<a href="#sectionSold">
					<i class="ico"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103142/ico_sold.png" alt=""></i>
					<span>방금 판매된</span>
				</a>
			</li>
		</ul>
	</div>

	<%'!-- 유튜브 --%>
	<div class="section section-yt" id="sectionYt">
		<div class="section-top">
			<h3>유튜버 pick</h3>
			<p>유튜버가 추천하는 다양한 휴대용선풍기! 지금 바로 구경하자! </p>
		</div>								
		<div class="yt yt1">
			<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/103142/img_yt1.png" alt=""></p>
			<div class="vod">
				<iframe width="720" height="405" src="https://www.youtube.com/embed/jYxGy6XeGI8" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe>
			</div>
		</div>
		<div class="yt yt2">
			<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/103142/img_yt2.png" alt=""></p>
			<div class="vod">
				<iframe width="720" height="405" src="https://www.youtube.com/embed/HN9tD0Jwwdw" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe>
			</div>
		</div>
		<div class="yt yt3">
			<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/103142/img_yt3.png" alt=""></p>
			<div class="vod">
				<iframe width="720" height="405" src="https://www.youtube.com/embed/Q7ZR4oqmDVE" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe>
			</div>
		</div>
	</div>

    <%'!-- 기능 (퍼블) --%>
    <div class="section section-func" id="sectionFunc">
        <div class="section-top">
            <h3>기 능</h3>
            <p>내게 꼭 필요한 기능이 있는 휴대용 선풍기 찾아보기!</p>
            <div class="nav-sub">
                <ul>
                    <li class="on"><a href="#smallFan">#초소형</a></li>
                    <li><a href="#silencFan">#저소음</a></li>
                    <li><a href="#multiFan">#다기능</a></li>
                </ul>
            </div>
        </div>
        <div class="item-wrap" id="smallFan">
            <p class="tit">#초소형</p>
            <ul class="item-list" id ="itemList1"></ul>
        </div>
        <div class="item-wrap" id="silencFan">
            <p class="tit">#저소음</p>
            <ul class="item-list" id ="itemList2"></ul>
        </div>
        <div class="item-wrap" id="multiFan">
            <p class="tit">#다기능</p>
            <ul class="item-list" id ="itemList3"></ul>
        </div>
    </div>

    <%'!-- 가격 --%>
    <div class="section section-price" id="sectionPrice">
        <div class="section-top">
            <h3>가 격</h3>
            <p>금액대별 휴대용 선풍기 똑~소리나게 확인하자!</p>
            <div class="nav-sub">
                <ul>
                    <li class="on"><a href="#fanPrice1">#1만원이하</a></li>
                    <li><a href="#fanPrice2">#1만원대</a></li>
                    <li><a href="#fanPrice3">#2만원대</a></li>
                    <li><a href="#fanPrice4">#3만원이상</a></li>
                </ul>
            </div>
        </div>
        <div class="item-wrap" id="fanPrice1"></div>
        <div class="item-wrap" id="fanPrice2"></div>
        <div class="item-wrap" id="fanPrice3"></div>
        <div class="item-wrap" id="fanPrice4"></div>
    </div>

    <%'!-- 방금판매된 --%>
    <div class="section section-sold" id="sectionSold">
        <div class="section-top">
            <h3>방금 판매된</h3>
            <p>방금 판매된 방금 판매된 휴대용 선풍기를 확인해보세요!</p>
        </div>
        <div class="item-wrap" id="soldFan">
            <ul class="item-list" id="justsold"></ul>
            <a href="" onclick="fnJustSoldItems();return false;" class="btn-more">더 보러가기</a>
        </div>
    </div>

    <%'!-- 브랜드 --%>
    <div class="fan-brand">
        <img src="//webimage.10x10.co.kr/fixevent/event/2020/103142/img_brand.jpg" alt="" usemap="#image-map">
        <map name="image-map">
            <area target="_blank" alt="루메나" onfocus="this.blur()" href="/street/street_brand_sub06.asp?makerid=n9" coords="216,124,436,331" shape="rect">
            <area target="_blank" alt="단순생활" onfocus="this.blur()" href="/street/street_brand_sub06.asp?rect=&prvtxt=&rstxt=&extxt=&sflag=n&dispCate=&cpg=1&chkr=False&chke=False&makerid=printec&sscp=N&psz=40&srm=be&iccd=0&styleCd=&attribCd=&icoSize=M&arrCate=124&deliType=&minPrc=&maxPrc=&lstDiv=brand&slidecode=5&shopview=1" coords="453,124,672,333" shape="rect">
            <area target="_blank" alt="스미다" onfocus="this.blur()" href="/street/street_brand_sub06.asp?makerid=simida170417" coords="694,117,913,336" shape="rect">
            <area target="_blank" alt="카카오프렌즈" onfocus="this.blur()" href="/street/street_brand_sub06.asp?rect=&prvtxt=&rstxt=&extxt=&sflag=n&dispCate=&cpg=1&chkr=False&chke=False&makerid=widmobile&sscp=N&psz=40&srm=be&iccd=0&styleCd=&attribCd=&icoSize=M&arrCate=124&deliType=&minPrc=&maxPrc=&lstDiv=brand&slidecode=5&shopview=1" coords="216,355,444,569" shape="rect">
            <area target="_blank" alt="쿨린" onfocus="this.blur()" href="/street/street_brand_sub06.asp?makerid=coolean24" coords="465,358,679,568" shape="rect">
            <area target="_blank" alt="아이리버" onfocus="this.blur()" href="/search/search_result.asp?rect=아이리버&prvtxt=아이리버&rstxt=아이리버&extxt=&sflag=n&dispCate=&cpg=1&chkr=False&chke=False&mkr=&sscp=N&psz=60&srm=bs&iccd=0&styleCd=&attribCd=&icoSize=M&arrCate=124101&deliType=&minPrc=&maxPrc=&lstDiv=search&subshopcd=&giftdiv=&prectcnt=28" coords="697,355,909,565,872,267" shape="rect">
        </map>
    </div>
</div>