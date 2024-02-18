			<script>var IE8Under=false;var IE7Under=false;</script>
			<!--[if lt IE 9]>
            <script>var IE8Under=true;</script>
            <![endif]-->
            <!--[if lt IE 8]>
            <script>var IE7Under=true;</script>
            <![endif]-->
			<script>
			$(function() {
				//GNB Control
				$('.gnbV15 li').mouseover(function() {
				    if (IE7Under) return;
				    
					$('.gnbV15 li').removeClass('on');
					$(this).addClass('on');
					$('.gnbSubWrapV15').show().unbind('mouseover').unbind('mouseleave')
						.mouseover(function() {$(this).show();})
						.mouseleave(function() {$(this).hide();});
					$('.gnbSubV15').hide();
					var subGnbId = $(this).attr('name');
					
					try{
					    var ictVar = eval("vCtHtml"+subGnbId.substring(3,6));
					}catch(e){
					    return;
					}

					//추가
					if (ictVar!=""){
                       $(".gnbSubWrapV15").append(ictVar);
                       eval("vCtHtml"+subGnbId.substring(3,6)+"=''");
					    // HOT
                        jsHotCateShow(subGnbId.substring(3,6));
						
						if (IE8Under){
						    $('.deptUnitTopV15 li').unbind('mouseover').unbind('mouseleave')
    						.mouseover(function() {
    							$(this).addClass('current');
    						})
    						.mouseleave(function() {
    							$(this).removeClass('current');
    						});
					   }else{
					        $('.deptUnitTopV15 li').unbind('mouseover').unbind('mouseleave')
    						.mouseover(function() {
    							$(this).addClass('current');
    							if ($(this).children('.subGroupWrapV15').length > 0){
    								$(this).children('.subGroupWrapV15').show();
    								$('.gnbBnrV15').children('span').show();
    							} else {
    								$(this).children('.subGroupWrapV15').hide();
    								$('.gnbBnrV15').children('span').hide();
    							}
    						})
    						.mouseleave(function() {
    							$(this).removeClass('current');
    							$(this).children('.subGroupWrapV15').hide();
    							$('.gnbBnrV15').children('span').hide();
    						});
					   }
					}
					
					$("div[class|='gnbSubV15'][id|='"+ subGnbId +"']").show().unbind('mouseover').unbind('mouseleave')
						.mouseover(function() {
							$(this).show();
							$('.gnbV15 li[name="'+subGnbId+'"]').addClass('on');
						})
						.mouseleave(function() {
							$(this).hide();
							$('.gnbV15 li').removeClass('on');
						});
				});
			
				$('.gnbV15 li').mouseleave(function() {
				    if (IE7Under) return;
				    
					$(this).removeClass('on');
					$('.gnbSubWrapV15').hide();
				});
			});
			</script>
			<!-- #include virtual="/chtml/dispcate/html/cate_menu_js_loader.html" -->
			<!-- #include virtual="/chtml/dispcate/html/cate_menu_hot_js_loader.html" -->
			<div class="gnbV15">
				<ul>
					<li name="gnb101" onClick="top.location.href='/shopping/category_list.asp?disp=101';"><p>디자인문구 <span class="icoHot"><img src="http://fiximage.10x10.co.kr/web2017/common/ico_hot.png" alt="Hot" /></span></p></li>
					<li name="gnb102" onClick="top.location.href='/shopping/category_list.asp?disp=102';"><p>디지털/핸드폰</p></li>
					<li name="gnb104" onClick="top.location.href='/shopping/category_list.asp?disp=104';"><p>토이/취미</p></li>
					<li name="gnb124" onClick="top.location.href='/shopping/category_list.asp?disp=124';"><p>디자인가전</p></li>
					<li name="gnb121" onClick="top.location.href='/shopping/category_list.asp?disp=121';"><p>가구/수납</p></li>
					<li name="gnb122" onClick="top.location.href='/shopping/category_list.asp?disp=122';"><p>데코/조명</p></li>
					<li name="gnb120" onClick="top.location.href='/shopping/category_list.asp?disp=120';"><p>패브릭/생활 <span class="icoHot"><img src="http://fiximage.10x10.co.kr/web2017/common/ico_hot.png" alt="Hot" /></span></p></li>
					<li name="gnb112" onClick="top.location.href='/shopping/category_list.asp?disp=112';"><p>키친</p></li>
					<li name="gnb119" onClick="top.location.href='/shopping/category_list.asp?disp=119';"><p>푸드</p></li>
					<li name="gnb117" onClick="top.location.href='/shopping/category_list.asp?disp=117';"><p>패션의류</p></li>
					<li name="gnb116" onClick="top.location.href='/shopping/category_list.asp?disp=116';"><p>패션잡화</p></li>
					<li name="gnb125" onClick="top.location.href='/shopping/category_list.asp?disp=125';"><p>주얼리/시계</p></li>
					<li name="gnb118" onClick="top.location.href='/shopping/category_list.asp?disp=118';"><p>뷰티</p></li>
					<li name="gnb115" onClick="top.location.href='/shopping/category_list.asp?disp=115';"><p>베이비/키즈</p></li>
					<li name="gnb110" onClick="top.location.href='/shopping/category_list.asp?disp=110';"><p>Cat&amp;Dog</p></li>
				</ul>
				<div class="gnbSubWrapV15" >
				</div>
			</div>