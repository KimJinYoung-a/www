<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 19주년 댓글 이벤트
' History : 2020-10-05
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->

<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
		if Not(Request("mfg")="pc" or session("mfg")="pc") then
			if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
				dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
				Response.Redirect "http://m.10x10.co.kr/event/19th/" & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"")
				REsponse.End
			end if
		end if
	end if

	Dim currentDate, evtStartDate, evtEndDate, eCode, userid
	Dim eventCoupons, isCouponShow, vQuery

	currentDate =  date()
	evtStartDate = Cdate("2020-10-05")
	evtEndDate = Cdate("2020-10-29")

	'test
	'currentDate = Cdate("2020-10-11")

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  "103232"
		eventCoupons = "22264,22263,22262,22261,22260,22259,22258"	
	Else
		eCode   =  "106375"
		eventCoupons = "112772,112771,112770,112769,112768,112767,112766"
	End If

	userid = GetEncLoginUserID()

	isCouponShow = True

	If IsUserLoginOK Then
		vQuery = "select count(1) from [db_item].[dbo].[tbl_user_item_coupon] where userid = '" & getencLoginUserid() & "'"
		vQuery = vQuery + " and itemcouponidx in ("&eventCoupons&") "
		vQuery = vQuery + " and usedyn = 'N' "
		rsget.CursorLocation = adUseClient
		rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
		If rsget(0) = 7 Then	' 
			isCouponShow = False
		Else
			isCouponShow = True
		End IF
		rsget.close
	End If

%>
<style>
.anniv19th .comment-wrap {background:#9435ff;}
.anniv19th .comment-wrap .bg-wrap {background:#ffd5d5 url(//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/bg_v2_contents_yellow.jpg) repeat-y top center; background-position-y: -273px;}/* 2020-10-05 추가 */
.anniv19th .comment-wrap .bg-wrap.bg-position {background:#ffd5d5 url(//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/bg_v2_contents_yellow.jpg) repeat-y top center; background-position-y:0;}/* 2020-10-05 추가 */
.anniv19th .comment-container {width:1041px; margin:0 auto;}
.anniv19th .comment-container .txt-info {padding-bottom:56px;}
.anniv19th .message-area {display:flex; align-items:flex-start; justify-content:flex-start; height:127px; padding-bottom:56px; border-radius:30px;}
.anniv19th .message-area .txt {width:calc(100% - 110px); height:127px;}
.anniv19th .message-area .txt textarea {overflow:hidden; width:calc(100% - 46px); height:50px; padding:38.5px 23px; resize:none; border:0; background:#fff; font-size:20px; color:#444; border-radius:30px 0 0 30px;}
.anniv19th .message-area .txt textarea::placeholder {font-size:20px; color:#888;}
.anniv19th .message-area .btn {width:110px; height:100%; background:#242424; border-radius:0 30px 30px 0;}
.anniv19th .message-area .btn button {width:100%; height:100%; font-size:24px; color:#fff; background:transparent;}
.anniv19th .message-view {padding-bottom:80px;}
.anniv19th .message-view .comment-list {display:flex; flex-wrap:wrap; justify-content:space-between; padding-bottom:64px;}
.anniv19th .message-view .comment-list li {display:flex; align-items:flex-start; justify-content:flex-start;}
.anniv19th .message-view .comment-list li:first-child {padding-top:0;}
.anniv19th .message-view .comment-list li:nth-child(2n) {padding-top:56px;}
.anniv19th .message-view .comment-list .img-character {width:69px; height:69px; padding-right:14px;}
.anniv19th .message-view .comment-list .img-character img {width:69px; height:69px;}
.anniv19th .message-view .comment-list .contents-area {padding-top:8px;}
.anniv19th .message-view .comment-list .id {padding:0 0 12px 4px; font-size:20px; color:#fff; line-height:1;}
.anniv19th .message-view .comment-list .num {font-size:18px; color:#666; line-height:1;}
.anniv19th .message-view .comment-list .message {height:154px; padding-top:15px; font-size:20px; color:#444; line-height:28px; word-break:break-all;}
.anniv19th .message-view .comment-list .date {font-size:18px; color:#ababab; text-align:right; line-height:1;}
.anniv19th .message-view .comment-list .btn-close {position:absolute; right:20px; top:20px; width:18px; height:18px; text-indent:-9999px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/icon_close.png) no-repeat 0 0; background-size:100%;}

.anniv19th .message-view .comment-list li:nth-child(odd) .message-container {position: relative; width:356px; height:203px; padding:32px 28px; background:#79faff; border-radius:27px;}
.anniv19th .message-view .comment-list li:nth-child(odd) .message-container:before {content:""; display:block; width:32px; height:25px; position:absolute; left:-11px; top:0; background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/icon_corner_01.png) no-repeat 0 0; background-size:100%;}
.anniv19th .message-view .comment-list li:nth-child(2n) .message-container {position: relative; width:356px; height:203px; padding:32px 28px; border-radius:27px; background:#fff179;}
.anniv19th .message-view .comment-list li:nth-child(2n) .message-container:before {content:""; display:block; width:32px; height:25px; position:absolute; right:-11px; top:0; background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/icon_corner_02.png) no-repeat 0 0; background-size:100%;}
.anniv19th .message-view .comment-list li:nth-child(2n) .id {text-align:right;}
.anniv19th .message-view .comment-list li:nth-child(2n) .img-character {padding-right:0; padding-left:14px;}
.anniv19th .message-view .comment-list li.type-yellow .message-container {background:#fff179;}
.anniv19th .message-view .comment-list li.type-yellow .message-container:before {content:""; background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/icon_corner_03.png) no-repeat 0 0; background-size:100%;}
.anniv19th .message-view .comment-list li:nth-child(2n).type-blue .message-container {background:#79faff;}
.anniv19th .message-view .comment-list li:nth-child(2n).type-blue .message-container:before {content:""; background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/icon_corner_04.png) no-repeat 0 0; background-size:100%;}

.anniv19th .message-view .pageMove {display:none;}
.anniv19th .message-view .paging a {border:0; background:none;}
.anniv19th .message-view .paging a span {padding:0 16px; font-size:20px; font-weight:500; color:#ed9e9e;}
.anniv19th .message-view .paging .first.arrow,
.anniv19th .message-view .paging .end.arrow {display:none;}
.anniv19th .message-view .paging a.current span {color:#fff;}
.anniv19th .message-view .paging .prev.arrow span,
.anniv19th .message-view .paging .next.arrow span {padding:0;}
.anniv19th .message-view .paging .prev.arrow span {display:inline-block; width:10px; height:15px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/icon_prev.png) no-repeat 0 0; background-size:100%;}
.anniv19th .message-view .paging .next.arrow span {display:inline-block; width:10px; height:15px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/icon_next.png) no-repeat 0 0; background-size:100%;}
.anniv19th .message-view .paging .prev.arrow {padding-right:16px;}
.anniv19th .message-view .paging .next.arrow {padding-left:16px;}
.anniv19th .topic {background:#ff4d83;}
.anniv19th .topic,
.anniv19th .topic img {width:100%;}
.anniv19th .inner {max-width:1920px; margin:0 auto;}
.anniv19th .contents-section > img {width:100%;}
.anniv19th .contents-section {height:661px;}/* 2020-10-05 수정 */
.anniv19th .contents-section .sction-area01 {position:relative; width:1040px; height:661px; margin:0 auto; text-align:center;}
.anniv19th .contents-section .sction-area01 .img-txt {padding-top:80px;}
.anniv19th .contents-section .sction-area01 button {position:absolute; left:50%; bottom:0; transform:translateX(-50%); background:transparent; animation: shake .6s ease-in-out alternate infinite;}
@keyframes shake {
	0% {left:48%;}
	100% {left:52%}
}
.anniv19th .contents-section02 {height:auto;}/* 2020-10-05 수정 */
.anniv19th .contents-section02 .sction-area01 {position:relative; width:1060px; height:auto; margin:0 auto; padding-bottom:141px; text-align:center;}/* 2020-10-05 수정 */
.anniv19th .contents-section02 .sction-area01 .img-txt {padding-top:110px;}
.anniv19th .contents-section02 .link-list {display:flex; flex-wrap:wrap; justify-content:space-between; align-items:flex-start; padding-top:29px;}/* 2020-10-05 수정 */
/* 2020-10-05 삭제 */
/* .anniv19th .contents-section02 .link-list li:nth-child(1) {padding-top:19px;}
.anniv19th .contents-section02 .link-list li:nth-child(3) {padding-top:23px;}
.anniv19th .contents-section02 .link-list li:nth-child(4) {padding-top:40px;} */

.anniv19th .contents-section03 {height:995px;} /* 2020-10-05 수정 */
.anniv19th .contents-section03 .sction-area01 {position:relative; width:1040px; height:995px; margin:0 auto; text-align:center;}
.anniv19th .contents-section03 .btn-view {position:absolute; left:50%; bottom:129px; transform:translateX(-50%);}

.anniv19th .contents-section04 {height:860px;} /* 2020-10-05 수정 */
.anniv19th .contents-section04 .sction-area01 {position:relative; width:1040px; height:860px; margin:0 auto; text-align:center;}
.anniv19th .contents-section04 .btn-view {position:absolute; left:46%; bottom:120px; transform:translateX(-46%);}
.anniv19th .contents-section04 .memberCountCon {position:absolute; left:46%; bottom:415px; transform:translateX(-46%); font-size:90px; font-weight:700; color:#fff; word-break:keep-all;}

.contents-section03 .list-wrap {position:absolute; left:50%; top:183px; transform:translateX(-50%);}
.contents-section03 .list-wrap .list-product {position:relative; width:870px;}
.contents-section03 .list-wrap .list-product li {opacity:0; transform-origin:center center;}

.contents-section03 .list-wrap.show .list-product li:nth-child(1) {animation: product 0.4s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.show .list-product li:nth-child(2) {animation: product 1.4s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.show .list-product li:nth-child(3) {animation: product 0.8s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.show .list-product li:nth-child(4) {animation: product 2.4s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.show .list-product li:nth-child(5) {animation: product 0.9s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.show .list-product li:nth-child(6) {animation: product 1.4s cubic-bezier(.97,.18,.15,.52); opacity:1;}

.contents-section03 .list-wrap.second.show .list-product li:nth-child(1) {animation: product 1.2s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.second.show .list-product li:nth-child(2) {animation: product 0.6s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.second.show .list-product li:nth-child(3) {animation: product 2s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.second.show .list-product li:nth-child(4) {animation: product 2.1s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.second.show .list-product li:nth-child(5) {animation: product 0.3s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.second.show .list-product li:nth-child(6) {animation: product 1.1s cubic-bezier(.97,.18,.15,.52); opacity:1;}

.contents-section03 .list-wrap.third.show .list-product li:nth-child(1) {animation: product 1.6s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.third.show .list-product li:nth-child(2) {animation: product 2.2s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.third.show .list-product li:nth-child(3) {animation: product 1s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.third.show .list-product li:nth-child(4) {animation: product 0.4s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.third.show .list-product li:nth-child(5) {animation: product 2.1s cubic-bezier(.97,.18,.15,.52); opacity:1;}
.contents-section03 .list-wrap.third.show .list-product li:nth-child(6) {animation: product 1.7s cubic-bezier(.97,.18,.15,.52); opacity:1;}

.contents-section03 .list-wrap .list-product li:nth-child(1) {position:absolute; left:0; top:15px;}
.contents-section03 .list-wrap .list-product li:nth-child(2) {position:absolute; left:152px; top:18px;}
.contents-section03 .list-wrap .list-product li:nth-child(3) {position:absolute; left:316px; top:15px;}
.contents-section03 .list-wrap .list-product li:nth-child(4) {position:absolute; left:497px; top:12px;}
.contents-section03 .list-wrap .list-product li:nth-child(5) {position:absolute; left:599px; top:8px;}
.contents-section03 .list-wrap .list-product li:nth-child(6) {position:absolute; left:783px; top:0;}

.contents-section03 .list-wrap.second .list-product li:nth-child(1) {position:absolute; left:0; top:165px;}
.contents-section03 .list-wrap.second .list-product li:nth-child(2) {position:absolute; left:172px; top:178px;}
.contents-section03 .list-wrap.second .list-product li:nth-child(3) {position:absolute; left:300px; top:180px;}
.contents-section03 .list-wrap.second .list-product li:nth-child(4) {position:absolute; left:435px; top:196px;}
.contents-section03 .list-wrap.second .list-product li:nth-child(5) {position:absolute; left:619px; top:186px;}
.contents-section03 .list-wrap.second .list-product li:nth-child(6) {position:absolute; left:711px; top:194px;}

.contents-section03 .list-wrap.third .list-product li:nth-child(1) {position:absolute; left:0; top:360px;}
.contents-section03 .list-wrap.third .list-product li:nth-child(2) {position:absolute; left:135px; top:378px;}
.contents-section03 .list-wrap.third .list-product li:nth-child(3) {position:absolute; left:311px; top:371px;}
.contents-section03 .list-wrap.third .list-product li:nth-child(4) {position:absolute; left:458px; top:364px;}
.contents-section03 .list-wrap.third .list-product li:nth-child(5) {position:absolute; left:561px; top:373px;}
.contents-section03 .list-wrap.third .list-product li:nth-child(6) {position:absolute; left:758px; top:363px;}
@keyframes product {
	0% {opacity:0;}
	89% {transform:scale(1);}
	90% {transform:scale(1.2);}
	100% {opacity:1; transform:scale(1);}
}
.pop-container.show {display:block;}
.pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgb(255, 255, 255); opacity:0.949; z-index:150;}
.pop-container .pop-inner {position:relative; width:670px; height:589px; margin:105px auto;}
.pop-container .pop-inner .btn-coupon {position:absolute; left:50%; top:365px; width:325px; height:74px; transform:translateX(-50%);}
.pop-container .pop-inner .btn-close {position:absolute; right:24px; top:24px; width:30px; height:30px; background:url(http://webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/icon_close02.png?v=1.01) no-repeat 0 0; background-size:100%; text-indent:-9999px;}
</style>
<script>
	$(document).ready(function() {
		// 숫자 롤링 event
		var fired = false;
		var memberCountConTxt= 7643;
		
		window.addEventListener("scroll", function(){
			var sc_top = $(this).scrollTop() +500;
			var top_roll = $(".contents-section04").offset().top;
			var wrap = $(".list-wrap");
			var wrap02 = $(".list-wrap.second");
			var wrap03 = $(".list-wrap.third");

			if (sc_top > top_roll && fired === false) {
				$({ val : 0 }).animate({ val : memberCountConTxt }, {
						duration: 2000,
						step: function() {
							var num = numberWithCommas(Math.floor(this.val));
							$(".memberCountCon").text(num+'개');
						},
						complete: function() {
							var num = numberWithCommas(Math.floor(this.val));
							$(".memberCountCon").text(num+'개');
						}
					});
					function numberWithCommas(x) {
							return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					}
					wrap.addClass("show");
					wrap02.addClass("show");
					wrap03.addClass("show");
				fired = true;
			}
		}, true)
		// 상품리스트 노출
		var product = false;
		window.addEventListener("scroll", function(){
			var sc_top = $(this).scrollTop() +500;
			var top_roll = $(".contents-section03").offset().top;
			var wrap = $(".list-wrap");
			var wrap02 = $(".list-wrap.second");
			var wrap03 = $(".list-wrap.third");

			if (sc_top > top_roll && product === false) {
					wrap.addClass("show");
					wrap02.addClass("show");
					wrap03.addClass("show");
					product = true;
			}
		}, true)

		$(".pop-container .btn-close").on("click",function(){
			$(".pop-container").removeClass("show");
		});
		//배너 체크
		var length = $(".link-list > li").length;
		
		if(length > 5 || length === 5) {
			$(".bg-wrap").addClass("bg-position");
		} else {
			$(".bg-wrap").removeClass("bg-position");
		}
	});

	function jsDownCoupon(stype,idx){
		<% if Not(IsUserLoginOK) then %>
			jsEventLogin();
		<% else %>
		var imageUrl = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_coupon_comp.png"
		$.ajax({
			type: "post",
			url: "/shoppingtoday/act_couponshop_process.asp",
			data: "idx="+idx+"&stype="+stype,
			cache: false,
			success: function(message) {
				if(typeof(message)=="object") {
					if(message.response=="Ok") {
						setTimeout(function(){$('.contents-section').fadeOut();}, 100);
						$(".pop-container").addClass("show");					
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/19th/")%>';
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
					<%'<!-- event area(이미지만 등록될때 / 수작업일때) -->%>
						<div class="contW">
							<%'<!-- MKT 19주년 메인 (W) -->%>
							<div class="anniv19th">
								<div class="topic">
									<div class="inner">
										<% if currentdate < "2020-10-19" then %>
										<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_tit_pc_02.gif" alt="19주년 생일파티 올해 마지막 Big Sale">
										<% Else %>
										<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_v2_tit_pc.gif" alt="19주년 생일파티 올해 마지막 Big Sale">
										<% End If %>
									</div>
								</div>
								<div class="comment-wrap">
									<div class="bg-wrap"><!-- for dev msg : 쿠폰팩5개 이상일때 class bg-position 추가 -->
										<% If isCouponShow Then %>
											<div class="contents-section">
												<div class="sction-area01">
													<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_v2_contents_01.png" class="img-txt" alt="앗 잠깐 쿠폰은 받았나? 19주년 쿠폰팩 최대50%">
													<button type="button" class="btn-coupon-down" onclick="jsDownCoupon('prd,prd,prd,prd,prd,prd,prd','<%=eventCoupons%>');return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_v2_btn_coupon01.png" alt="쿠폰 받기"></button>
												</div>
											</div>
										<% End If %>
										<div class="contents-section02">
											<div class="sction-area01">
												<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_contents_02.png" class="img-txt" alt="혜택 보고 가면 안 잡아 먹지!">
												<%'<!-- for dev msg : 혜택 배너 -->%>
												<ul class="link-list">
													<!-- #include virtual="/event/19th/inc_19thbanner.asp" -->
												</ul>
											</div>
										</div>
										<div class="contents-section03">
											<div class="sction-area01">
												<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_contents_03.png?v=1.01" class="img-txt" alt="지금 769,762개 상품 할인 중">
												<div class="list-wrap">
													<ul class="list-product">
														<li><a href="/shopping/category_prd.asp?itemid=3171639"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_01.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=2964071"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_02.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=2785591"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_03.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=3069797"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_04.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=2591489"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_05.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=3181488"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_06.png" alt="상품 icon"></a></li>
													</ul>
												</div>
												<div class="list-wrap second">
													<ul class="list-product">
														<li><a href="/shopping/category_prd.asp?itemid=1887286"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_07.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=2722020"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_08.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=3217278"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_09.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=3019218"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_10.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=2501734"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_11.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=774875"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_12.png" alt="상품 icon"></a></li>
													</ul>
												</div>
												<div class="list-wrap third">
													<ul class="list-product">
														<li><a href="/shopping/category_prd.asp?itemid=2953002"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_13.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=3136367"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_14.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=3095413"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_15.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=3144060"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_16.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=2238185"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_17.png" alt="상품 icon"></a></li>
														<li><a href="/shopping/category_prd.asp?itemid=3220588"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_product_18.png" alt="상품 icon"></a></li>
													</ul>
												</div>
												<a href="http://www.10x10.co.kr/shoppingtoday/shoppingchance_saleitem.asp?" class="btn-view"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_btn_coupon06.png" alt="자세히 보러가기"></a>
											</div>
										</div>
										<div class="contents-section04">
											<div class="sction-area01">
												<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_v2_contents_04.png" class="img-txt" alt="지금 할인 중인 브랜드 7,643개 최대 할인 50%">
												<div class="memberCountCon"></div>
												<a href="/event/eventmain.asp?eventid=106390" class="btn-view"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_btn_coupon06.png" alt="자세히 보러가기"></a>
											</div>
										</div>
									</div>
									<%'<!-- 코멘트 영역 --> %>
									<!-- #include virtual="/event/19th/inc_comment.asp" -->
									<%'<!-- //코멘트 영역 -->%>
									<%'<!-- for dev msg : 쿠폰팩 팝업 -->%>
									<div class="pop-container">
										<div class="pop-inner">
											<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_pop_coupon.png" alt="쿠폰팩이 발급되었습니다. 최대 50% 쿠폰은 10월 29일까지 사용 할 수 있으며 사용 후 다시 발급받을 수 있습니다.">
											<a href="/my10x10/couponbook.asp" class="btn-coupon"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_btn_coupon07.png?v=1.01" alt="쿠폰함으로 가기"></a>
											<button type="button" class="btn-close">닫기</button>
										</div>
									</div>
								</div>
							</div>
							<!-- //MKT 19주년 메인 (W) -->
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