<%
dim arrSwiperList
dim eventCode, imgURL, headLine, subCopy, salePer, saleCPer, isSale, isCoupon, leftBGColor, rightBGColor, isgift, isoneplusone, leftCnt, brand, evtSellCash
dim isOnly, isNew, isFreeDel, isReserveSell

arrSwiperList = oExhibition.getSwiperListProc2( masterCode, "P" , "exhibition" ) '마스터코드 , 채널 , 기획전종류
%>
<script type="text/javascript">
$(function(){
	//상단롤링
	var $slider = $('.slide-area').find('.slide1');
	var $progressBar = $('.slide-area').find('.progressbar-fill');
	$slider.on('init', function () {
		var amt =  $(this).find('.slide-item').length;
		var init = 100 / amt
		$progressBar.css('width', init + '%');
	});
	$slider.on('beforeChange', function(event, slick, currentSlide, nextSlide) {
		var calc = ( (nextSlide+1) / (slick.slideCount) ) * 100;
		$progressBar.css('width', calc + '%');
		var bgImg = $(this).find('.slide-item').eq(currentSlide).find('img').attr('src')
		var bgColor = $(this).find('.slide-item').eq(currentSlide).find('.copy-bg').css("background-color");
		if ((currentSlide > nextSlide && (nextSlide !== 0 || currentSlide === 1)) || (currentSlide === 0 && nextSlide === slick.slideCount - 1)) {
			$(this).find('.slide-item').eq(currentSlide-1).find('.img-area').css({'background-image':'url('+bgImg+')'})
			$(this).find('.slide-item').eq(currentSlide-1).find('.copy-area').css({'background-color': bgColor })
		}
		else {
			$(this).find('.slide-item').eq(nextSlide).find('.img-area').css({'background-image':'url('+bgImg+')'})
			$(this).find('.slide-item').eq(nextSlide).find('.copy-area').css({'background-color': bgColor })
		}
	});
	$('.slide1').slick({
		autoplay:true,
		autoplaySpeed:4000,
		arrows:true,
		speed:1,
		fade:true,
		pauseOnHover:false,
		dots: true,
		customPaging: function(slick,index) {
			pagI=index+1
			// console.log(pagI)
			return '<b>' + pagI + '</b> / ' + slick.slideCount ;
		}

	});
	$('.slide1').on('swipe', function(event, slick, direction){
		if (direction=="right"){
			$('.slick-slide').removeClass('direction-right direction-left').addClass('direction-right');
		}
		else {
			$('.slick-slide').removeClass('direction-right direction-left').addClass('direction-left');
		}
	});
	$('.slick-prev').click(function(){
		$('.slick-slide').removeClass('direction-right direction-left').addClass('direction-right');
	});
	$('.slick-next').click(function(){
		$('.slick-slide').removeClass('direction-right direction-left').addClass('direction-left');
	});
	//---------여기까지가 상단롤링 

	//추천다이어리 tab-menu
	$('.recommend .tab-menu').find('li').click(function() {
		$(this).addClass('on').siblings().removeClass('on')
		var i = $(this).index();
		$('.recommend .item-list').eq(i).addClass('on').siblings().removeClass('on')
		return false;
	})

	//더 많은 상품보기- 버튼
	$('.btn-down').click(function(e){
		$(this).css({'display':'none'})
		return false;
	})
	// $("#mainSwiper .evt-slide").each(function(idx){
	// 	$(".badge-area em:gt(2)", this).css('display','none');
	// })
});
</script>
<% if isArray(arrSwiperList) then %>
				<div class="topic">
					<div class="slide-area">
						<div class="slide1" id="mainSwiper">
<%
    for i = 0 to ubound(arrSwiperList,2)

        eventCode = arrSwiperList(9,i)
        imgURL = arrSwiperList(5,i)
        headLine = nl2br(arrSwiperList(2,i))
        subCopy = nl2br(arrSwiperList(10,i))
        salePer = arrSwiperList(12,i)
        saleCPer = arrSwiperList(13,i)
        isSale = arrSwiperList(14,i)
        isCoupon = arrSwiperList(15,i)
        leftBGColor = arrSwiperList(3,i)
        rightBGColor = arrSwiperList(4,i)
        isgift = arrSwiperList(16,i)
        isoneplusone = arrSwiperList(17,i)
        leftCnt = arrSwiperList(18,i)
        brand = arrSwiperList(19,i)
		evtSellCash = arrSwiperList(20,i)
		isOnly = arrSwiperList(21,i)
		isNew = arrSwiperList(22,i)
		isFreeDel = arrSwiperList(23,i)
		isReserveSell = arrSwiperList(24,i)
%>
							<div class="slide-item evt-slide">
								<a href="/event/eventmain.asp?eventid=<%=eventCode%>">
									<div class="img-area">
										<span class="slide-img"><img src="<%=imgURL%>" /></span>
										<%'<!-- 0905수정 위치변경 원래 copy-area 안에 있었는데 img-area 안으로 -->%>
										<div class="desc">
											<ul>
												<li class="brand"><%=brand%></li>
												<li class="tit"><%=headLine%></li>
												<li class="price-area">
													<% if evtSellCash <> "" and evtSellCash <> "0" then %><span class="price"><%=FormatNumber(evtSellCash, 0)%></span><% end if %>
													<%'<!-- 0905수정 여기 할인율있던거 밑에 뱃지로 갔음 -->%>
												</li>
												<%'<!-- 0905수정 원래3개까지만 보여지기로했던거 다~ 보여지기 -->%>
												<li class="badge-area">
													<% if isSale then %><em class="badge-sale"><%=salePer%>%</em><% end if %>
													<% if isCoupon then %><em class="badge-cpn"><%=couponDisp(saleCPer)%> 쿠폰</em><% end if %>
													<% if isOnly then %><em class="badge-only">ONLY</em><% end if %>
													<% if isgift then %><em class="badge-gift">GIFT</em><% end if %>
													<% if isoneplusone then %><em class="badge-plus">1+1</em><% end if %>
													<% if isNew then %><em class="badge-launch">런칭</em><% end if %>
													<% if isFreeDel then %><em class="badge-free">무료배송</em><% end if %>
													<% if isReserveSell then %><em class="badge-book">예약판매</em><% end if %>
													<% if leftCnt <> "" and leftCnt <> 0 then %><em class="badge-count"><%=FormatNumber(leftCnt, 0)%>개 남음</em><% end if %> 
												</li>
											</ul>
										</div>
									</div>
									<div class="copy-area">
										<div class="copy-bg" style="background-color: #<%=leftBGColor%>"></div>
									</div>
								</a>
							</div>
<%
    next
%>
						</div>
						<div class="progressbar"><span class="progressbar-fill"></span></div>
					</div>
				</div>
<% end if %>