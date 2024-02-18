
			<script>
			var vGNBTimer;
			$(function() {
				//GNB Control
				$('.gnbV15 li').mouseover(function() {
					var oCurr = this;
					clearTimeout(vGNBTimer);
					if(!$('.gnbV15 li').hasClass('on')) {
						vGNBTimer = setTimeout(function(){
							fnGetGNBExtCate();
							fnGNBShow(oCurr);
						},100);
					} else {
						fnGNBShow(oCurr);
					}
				});

				$('.gnbV15 li').mouseleave(function() {
					var oCurr = this;
					setTimeout(function(){$(oCurr).removeClass('on');},50);
					clearTimeout(vGNBTimer);
					$('.gnbSubWrapV15').hide();
				});
			
			});

			// GNB Master Action
			function fnGNBShow(obj) {
				$('.gnbV15 li').removeClass('on');
				$(obj).addClass('on');
				$('.gnbSubWrapV15').show().unbind('mouseover').unbind('mouseleave')
					.mouseover(function() {$(this).show();})
					.mouseleave(function() {$(this).hide();});
				$('.gnbSubV15').hide();
				var subGnbId = $(obj).attr('name');
				$("div[class|='gnbSubV15'][id|='"+ subGnbId +"']").show().unbind('mouseover').unbind('mouseleave')
					.mouseover(function() {
						$(this).show();
						$('.gnbV15 li[name="'+subGnbId+'"]').addClass('on');
					})
					.mouseleave(function() {
						$(this).hide();
						$('.gnbV15 li').removeClass('on');
					});			
			}

			// GNB Expand Print
			function fnGetGNBExtCate() {
				if($(".gnbSubWrapV15").html()=="") {
					var vExpCateCont;
					if(typeof(Storage) !== "undefined") {
						vExpCateCont = sessionStorage.getItem("gnbExtMenu");
					}

					if(vExpCateCont=="" || vExpCateCont==null) {
						$.ajax({
							url: "/lib/inc/act_topCateExtMenu.asp",
							cache: true,
							async: false,
							success: function(message) {
								vExpCateCont = message;
								if(typeof(Storage) !== "undefined") {
									sessionStorage.setItem("gnbExtMenu", message);
								}
								$(".gnbSubWrapV15").empty().html(vExpCateCont);
								fnExtCateOverAction();
							}
							,error: function(err) {
								alert(err.responseText);
							}
						});
					} else {
						$(".gnbSubWrapV15").empty().html(vExpCateCont);
						fnExtCateOverAction();
					}
				}
			}

			// GNB Expand Area Action
			function fnExtCateOverAction() {
				$('.deptUnitTopV15 li').mouseover(function() {
					$(this).addClass('current');
					if ($(this).children('.subGroupWrapV15').length > 0){
						$(this).children('.subGroupWrapV15').show();
						$('.gnbBnrV15').children('span').show();
					} else {
						$(this).children('.subGroupWrapV15').hide();
						$('.gnbBnrV15').children('span').hide();
					}
				});

				$('.deptUnitTopV15 li').mouseleave(function() {
					$(this).removeClass('current');
					$(this).children('.subGroupWrapV15').hide();
					$('.gnbBnrV15').children('span').hide();
				});
			}

			</script>
			<div class="gnbV15">
				<ul>
					<li name="gnb101" onClick="top.location.href='/shopping/category_list.asp?disp=101';"><p>디자인문구</p></li>
					<li name="gnb102" onClick="top.location.href='/shopping/category_list.asp?disp=102';"><p>디지털/핸드폰</p></li>
					<li name="gnb103" onClick="top.location.href='/shopping/category_list.asp?disp=103';"><p>캠핑/트래블</p></li>
					<li name="gnb104" onClick="top.location.href='/shopping/category_list.asp?disp=104';"><p>토이</p></li>
					<li name="gnb114" onClick="top.location.href='/shopping/category_list.asp?disp=114';"><p>가구</p></li>
					<li name="gnb106" onClick="top.location.href='/shopping/category_list.asp?disp=106';"><p>홈인테리어</p></li>
					<li name="gnb112" onClick="top.location.href='/shopping/category_list.asp?disp=112';"><p>키친</p></li>
					<li name="gnb119" onClick="top.location.href='/shopping/category_list.asp?disp=119';"><p>푸드 <span class="icoNew"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif" alt="New" /></span></p></li>
					<li name="gnb117" onClick="top.location.href='/shopping/category_list.asp?disp=117';"><p>패션의류</p></li>
					<li name="gnb116" onClick="top.location.href='/shopping/category_list.asp?disp=116';"><p>가방/슈즈/주얼리</p></li>
					<li name="gnb118" onClick="top.location.href='/shopping/category_list.asp?disp=118';"><p>뷰티/다이어트</p></li>
					<li name="gnb115" onClick="top.location.href='/shopping/category_list.asp?disp=115';"><p>베이비/키즈</p></li>
					<li name="gnb110" onClick="top.location.href='/shopping/category_list.asp?disp=110';"><p>Cat&amp;Dog</p></li>
				</ul>
				<div class="gnbSubWrapV15"></div>
			</div>