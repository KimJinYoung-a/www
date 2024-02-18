function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}
}

// 확인 후 로그인 페이지로 이동
function jsChkConfirmLogin(msg) {
	if(msg=="") msg = "로그인이 필요합니다.";
	if(confirm(msg + "\n로그인 하시겠습니까?")){
		var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
		winLogin.focus();
	}
}

$(function() {
	//동영상 이미지 추가시(추후개발)
	//$(".photoSlideV15 .slidesjs-pagination > li:last-child").addClass('thumbVod');
	//$(".photoSlideV15 .slidesjs-pagination > li.thumbVod a").append('<em></em>');

	$('.infoMoreViewV15').mouseover(function(){
		$(this).children('.infoViewLyrV15').show();
	});
	$('.infoMoreViewV15').mouseleave(function(){
		$(this).children('.infoViewLyrV15').hide();
	});

	$('.infoMoreViewV15a').mouseover(function(){
		$(this).children('.infoViewLyrV15a').show();
	});
	$('.infoMoreViewV15a').mouseleave(function(){
		$(this).children('.infoViewLyrV15a').hide();
	});

	// recommend item tap view Control
	$(".itemNaviV15 li a").removeClass("on");
	$(".itemContV15").hide();

	if(!$("#rcmdPrd01").has("ul").length) {$(".itemNaviV15 .item01").hide();}
	if(!$("#rcmdPrd02").has("ul").length) {$(".itemNaviV15 .item02").hide();}
	if(!$("#rcmdPrd03").has("ul").length) {$(".itemNaviV15 .item03").hide();}

	if($("#rcmdPrd01").has("ul").length) {
		$(".itemNaviV15 .item01 a").addClass("on");
		$("#rcmdPrd01").show();
	} else if($("#rcmdPrd02").has("ul").length) {
		$(".itemNaviV15 .item02 a").addClass("on");
		$("#rcmdPrd02").show();
	} else if($("#rcmdPrd03").has("ul").length) {
		$(".itemNaviV15 .item03 a").addClass("on");
		$("#rcmdPrd03").show();
	} else {
		$(".recommendItemV15").hide();
	}

	$(".itemNaviV15 li").mouseenter(function() {
		$(this).siblings("li").find("a").removeClass("on");
		$(this).find("a").addClass("on");
		$(this).closest(".itemNaviV15").nextAll(".itemContainerV15:first").find(".itemContV15").hide();
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).show();
		return false;
	});

	// 상품후기, 상품문의
	$(".talkList .talkMore").hide();
	$(".talkList .talkShort").click(function(){
		if($(this).parent().parent().next('.talkMore').is(":hidden")){
			$(".talkList .talkMore").hide();
			$(this).parent().parent().next('.talkMore').show();
		} else {
			$(this).parent().parent().next('.talkMore').hide();
		}

		// 클릭 위치가 가려질경우 스크롤 이동
		if($(window).scrollTop()>$(this).parent().parent().offset().top-47) {
			$('html, body').animate({scrollTop:$(this).parent().parent().offset().top-47}, 'fast');
		}
	});

	// 상품문의
	$("#inquiryForm").hide();
	$("#inquiryBtn").click(function(){
		$("#inquiryForm").toggle();
	});

	/* for dev msg : PLUSE SALE 개선 작업 (2017.02.06) */
	/* dropdown */
	// common
	var select_root = $(".dropdown");
	var select_value = $(".btnDrop");
	var select_a = $(".dropdown>ul>li>a>div");
	
	// show
	function show_option(){
		$(this).toggleClass("on");
		$(this).parents(".dropdown:first").toggleClass("open");
		$(this).parents(".dropdown").css("z-index", "35");
	}
	
	// hide
	function hide_option(){
		var t = $(this);
		setTimeout(function(){
			t.parents(".dropdown:first").removeClass("open");
		}, 1);
	}
	
	// set anchor
	function set_anchor(){

		var v = $(this).text();
		$(this).parents("ul:first").prev(".btnDrop").text("").append(v);
		$(this).parents("ul:first").prev(".btnDrop").removeClass("on");
	}

	// anchor focus out
	$("*:not('.dropdown a')").focus(function(){
		$(".dropdownList").parent(".dropdown").removeClass("open");
		$(".dropdownList").parent(".dropdown").css("z-index", "0");
	});
	
	select_value.click(show_option);
	select_root.find("ul").css("position","absolute");
	select_root.removeClass("open");
	select_root.mouseleave(function(){$(this).removeClass("open");});
	select_a.click(set_anchor).click(hide_option);
	
	/* plus slae item list check */
	// for dev msg : PlUS SALE관련 상품일 경우에만 해당 스크립트 호출해주세요!
	plusSaleVItemCheck();
	function plusSaleVItemCheck() {
		$(".plusSaleVItem17").each(function(){
			var checkItem = $(this).children(".item").children("ul").children("li").length;
			if (checkItem == 1) {
				$(this).children(".item").addClass("one");
			}
		});
	}

	// 기획전 이미지 마우스오버
	$('.imgOverV15 span').append('<em></em>');
	$('.imgOverV15').mouseover(function(){
		$(this).find('em').show();
	});
	$('.imgOverV15').mouseleave(function(){
		$(this).find('em').hide();
	});

});

//앵커이동
function goToByScroll(id){
	// 해당메뉴 위치로 스크롤 변경 (스크롤 = 해당매뉴 위치 - 탑메뉴 높이)
	$('html,body').animate({scrollTop: $("#detail0"+id).offset().top-$(".pdtTabLinkV15").outerHeight()-20},'slow');
}

// 해외 직구 배송정보 안내 (Overseas Direct Purchase)
function ODPorderinfo(){
	var popwin=window.open('/shopping/popDirectGuide.asp','orderinfo','width=1000,height=640,scrollbars=yes,resizable=no');
	popwin.focus();
}