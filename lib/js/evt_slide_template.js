$(function(){
	// wide swipe
	$('.wideSwipe').each(function(idx, el){
		var slider = $(el).find('.swiper-container')[0];
		var wideSwipe = new Swiper(slider, {
			loop:true,
			slidesPerView:'auto',
			centeredSlides:true,
			speed:1400,
			autoplay:1500,
			simulateTouch:false,
			pagination: $(slider).find('.pagination')[0],
			paginationClickable:true,
			autoplayDisableOnInteraction:false
		});
		$(slider).find('.btnPrev').on('click', function(){
			wideSwipe.swipePrev();
		})
		$(slider).find('.btnNext').on('click', function(){
			wideSwipe.swipeNext();
		});
	});

	// wide slide
	$('.wideSlide .swiper-wrapper').slidesjs({
		width:1920,
		height:800,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.wideSlide .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	// full slide
	$('.fullSlide .swiper-wrapper').slidesjs({
		width:930,
		height:575,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.fullSlide .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
});