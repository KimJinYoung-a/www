<script>var IE8Under=false;var IE7Under=false;</script>
<!--[if lt IE 9]>
<script>var IE8Under=true;</script>
<![endif]-->
<!--[if lt IE 8]>
<script>var IE7Under=true;</script>
<![endif]-->
<script>
$(function() {
	$('.head-util ul li').mouseover(function() {
		$(this).children('.util-layer').show();
	});
	$('.head-util ul li').mouseleave(function() {
		$(this).children('.util-layer').hide();
	});
	//GNB Control
	$('.gnbV18 li').mouseover(function() {
		if (IE7Under) return;
		
		$('.gnbV18 li').removeClass('on');
		$(this).addClass('on');
		$('.gnb-sub-wrap').show().unbind('mouseover').unbind('mouseleave')
			.mouseover(function() {$(this).show();})
			.mouseleave(function() {$(this).hide();});
		$('.gnb-sub').hide();
		var subGnbId = $(this).attr('name');
		
		try{
			var ictVar = eval("vCtHtml"+subGnbId.substring(3,6));
		}catch(e){
			return;
		}

		//추가
		if (ictVar!=""){
		   $(".gnb-sub-wrap").append(ictVar);
		   eval("vCtHtml"+subGnbId.substring(3,6)+"=''");
			// HOT
			jsHotCateShow(subGnbId.substring(3,6));
			
			if (IE8Under){
				$('.dept-unit-top li').unbind('mouseover').unbind('mouseleave')
				.mouseover(function() {
					$(this).addClass('current');
				})
				.mouseleave(function() {
					$(this).removeClass('current');
				});
		   }else{
				$('.dept-unit-top li').unbind('mouseover').unbind('mouseleave')
				.mouseover(function() {
					$(this).addClass('current');
					$('.gnbV18').children('span').show();
					//if ($(this).children('.subGroupWrapV15').length > 0){
					//	$(this).children('.subGroupWrapV15').show();
					//	$('.gnbBnrV15').children('span').show();
					//} else {
					//	$(this).children('.subGroupWrapV15').hide();
					//	$('.gnbBnrV15').children('span').hide();
					//}
				})
				.mouseleave(function() {
					$(this).removeClass('current');
					//$(this).children('.subGroupWrapV15').hide();
					$('.gnbV18').children('span').hide();
				});
		   }
		}
		
		$("div[class|='gnb-sub'][id|='"+ subGnbId +"']").show().unbind('mouseover').unbind('mouseleave')
			.mouseover(function() {
				$(this).show();
				$('.gnbV18 li[name="'+subGnbId+'"]').addClass('on');
			})
			.mouseleave(function() {
				$(this).hide();
				$('.gnbV18 li').removeClass('on');
			});
	});

	$('.gnbV18 li').mouseleave(function() {
		if (IE7Under) return;
		
		$(this).removeClass('on');
		$('.gnb-sub-wrap').hide();
	});
});
</script>
<!-- #include virtual="/chtml/dispcate/html/cate_menu_js_loader.html" -->
<!-- #include virtual="/chtml/dispcate/html/cate_menu_hot_js_loader.html" -->
<div class="gnbV18">
	<ul>
		<%' 인기 카테고리에 클래스 gnb-hot 붙여주세요 %>
		<li name="gnb101" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=101';"><p>디자인문구</p></li>
		<li name="gnb102" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=102';"><p>디지털/핸드폰</p></li>
		<li name="gnb124" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=124';"><p>디자인가전</p></li>
		<li class="line" name="gnb121" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=121';"><p>가구/수납</p></li>
		<li name="gnb120" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=120';"><p>패브릭/생활</p></li>
		<li name="gnb122" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=122';"><p>데코/조명</p></li>
		<li name="gnb112" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=112';"><p>키친</p></li>
		<li class="gnb-hot" name="gnb119" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=119';"><p>푸드</p></li>
		<li class="line gnb-hot" name="gnb117" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=117';"><p>패션의류</p></li>
		<li name="gnb116" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=116';"><p>패션잡화</p></li>
		<li name="gnb118" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=118';"><p>뷰티</p></li>
		<li name="gnb125" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=125';"><p>주얼리/시계</p></li>
		<li class="line" name="gnb110" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=110';"><p>Cat&amp;Dog</p></li>
		<li name="gnb104" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=104';"><p>토이/취미</p></li>
		<li name="gnb103" onClick="top.location.href='<%=SSLUrl%>/shopping/category_list.asp?disp=103';"><p>캠핑</p></li>
	</ul>
	<%' 2depth %>
	<div class="gnb-sub-wrap">
	</div>
	<%' //2depth %>
</div>