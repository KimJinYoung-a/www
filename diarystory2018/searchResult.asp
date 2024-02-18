<!-- #include virtual="/html/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/diary2017.css" />
<script type="text/javascript">
$(function(){
	// preview layer
	function diaryPreviewSlide(){
		$('.diaryPreview .slide').slidesjs({
			width:"670",
			height:"470",
			pagination:false,
			navigation:{effect:"fade"},
			play:{interval:2800, effect:"fade", auto:true},
			effect:{fade: {speed:800, crossfade:true}
			},
			callback: {
				complete: function(number) {
					var pluginInstance = $('.diaryPreview .slide').data('plugin_slidesjs');
					setTimeout(function() {
						pluginInstance.play(true);
					}, pluginInstance.options.play.interval);
				}
			}
		});
	}
	$('.btnPreview').click(function(){
		diaryPreviewSlide();
	});

	// 마우스 오버시 활용컷보기
	$(function() {
		$('.diaryList li .pPhoto').mouseenter(function(e){
			$(this).find('dfn').fadeIn(150);
		}).mouseleave(function(e){
			$(this).find('dfn').fadeOut(150);
		});
	});
});
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/html/lib/inc/incHeader.asp" -->
	<div class="container diarystory2017">
		<div id="contentWrap">
			<!-- #include virtual="/html/diarystory2017/inc/head.asp" -->
			<div class="diaryContent diarySearchResult">
				<!-- 검색영역 -->
				<div class="diarySearch">
					<div class="diarySearchWrap">
						<h3><strong>원하는 항목에 체크해 주세요. <em class="cRd0V15">중복체크도 가능</em>합니다.</strong></h3>
						<!--<p class="goPlanner"><a href="">혹시 플래너를 찾으시나요?</a></p>-->
						<div class="searchOption">
							<dl class="optionType01">
								<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tit_design.png" alt="DESIGN" /></dt>
								<dd>
									<ul class="optionList">
										<li><input type="checkbox" class="check" id="sOptS01" /> <label for="sOptS01">Simple</label></li>
										<li><input type="checkbox" class="check" id="sOptS02" /> <label for="sOptS02">Illust</label></li>
										<li><input type="checkbox" class="check" id="sOptS03" /> <label for="sOptS03">Pattern</label></li>
										<li><input type="checkbox" class="check" id="sOptS04" /> <label for="sOptS04">Photo</label></li>
									</ul>
								</dd>
							</dl>
							<dl class="optionType02">
								<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tIt_contents.png" alt="CONTENTS" /></dt>
								<dd>
									<dl class="dateType">
										<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_date.png" alt="DATE TYPE" /></dt>
										<dd>
											<ul class="optionList">
												<li><input type="checkbox" class="check" id="sOptCt01" /> <label for="sOptCt01">Only 2016</label></li>
												<li><input type="checkbox" class="check" id="sOptCt02" /> <label for="sOptCt02">만년 다이어리</label></li>
											</ul>
										</dd>
									</dl>
									<dl class="layout">
										<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_layout.png" alt="PAGE LAYOUT" /></dt>
										<dd>
											<ul class="optionList">
												<li><input type="checkbox" class="check" id="sOptCt03" /> <label for="sOptCt03">Half diary</label></li>
												<li><input type="checkbox" class="check" id="sOptCt04" /> <label for="sOptCt04">Yearly</label></li>
												<li><input type="checkbox" class="check" id="sOptCt05" /> <label for="sOptCt05">Monthly</label></li>
												<li><input type="checkbox" class="check" id="sOptCt06" /> <label for="sOptCt06">Weekly</label></li>
												<li><input type="checkbox" class="check" id="sOptCt07" /> <label for="sOptCt07">Daily</label></li>
											</ul>
										</dd>
									</dl>
									<dl class="option">
										<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_option.png" alt="OPTION" /></dt>
										<dd>
											<ul class="optionList">
												<li><input type="checkbox" class="check" id="sOptCt08" /> <label for="sOptCt08">Cash</label></li>
												<li><input type="checkbox" class="check" id="sOptCt09" /> <label for="sOptCt09">Pocket</label></li>
												<li><input type="checkbox" class="check" id="sOptCt10" /> <label for="sOptCt10">Band</label></li>
												<li><input type="checkbox" class="check" id="sOptCt11" /> <label for="sOptCt11">Pen holder</label></li>
											</ul>
										</dd>
									</dl>
								</dd>
							</dl>
							<dl class="optionType03">
								<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tit_cover.png" alt="COVER" /></dt>
								<dd>
									<dl class="material">
										<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_material.png" alt="MATERIAL" /></dt>
										<dd>
											<ul class="optionList">
												<li><input type="checkbox" class="check" id="sOptCv01" /> <label for="sOptCv01">Paper soft</label></li>
												<li><input type="checkbox" class="check" id="sOptCv02" /> <label for="sOptCv02">Paper hard</label></li>
												<li><input type="checkbox" class="check" id="sOptCv03" /> <label for="sOptCv03">Leather</label></li>
												<li><input type="checkbox" class="check" id="sOptCv04" /> <label for="sOptCv04">PVC</label></li>
												<li><input type="checkbox" class="check" id="sOptCv05" /> <label for="sOptCv05">Fabric</label></li>
											</ul>
										</dd>
									</dl>
									<dl class="color">
										<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_color.png" alt="COLOR" /></dt>
										<dd>
											<ul class="optionList colorchips">
												<li class="all selected"><input type="radio" id="allC" /><label for="allC">ALL</label></li>
												<li class="wine"><input type="radio" id="wineC" /><label for="wineC">WINE</label></li>
												<li class="red"><input type="radio" id="redC" /><label for="redC">RED</label></li>
												<li class="orange"><input type="radio" id="orangeC" /><label for="orangeC">ORANGE</label></li>
												<li class="brown"><input type="radio" id="brownC" /><label for="brownC">BROWN</label></li>
												<li class="camel"><input type="radio" id="camelC" /><label for="camelC">CAMEL</label></li>
												<li class="yellow"><input type="radio" id="yellowC" /><label for="yellowC">YELLOW</label></li>
												<li class="beige"><input type="radio" id="beigeC" /><label for="beigeC">BEIGE</label></li>
												<li class="ivory"><input type="radio" id="ivoryC" /><label for="ivoryC">IVORY</label></li>
												<li class="khaki"><input type="radio" id="khakiC" /><label for="khakiC">KHAKI</label></li>
												<li class="green"><input type="radio" id="greenC" /><label for="greenC">GREEN</label></li>
												<li class="mint"><input type="radio" id="mintC" /><label for="mintC">MINT</label></li>
												<li class="skyblue"><input type="radio" id="skyblueC" /><label for="skyblueC">SKYBLUE</label></li>
												<li class="blue"><input type="radio" id="blue" /><label for="blueC">BLUE</label></li>
												<li class="navy"><input type="radio" id="navyC" /><label for="navyC">NAVY</label></li>
												<li class="violet"><input type="radio" id="violetC" /><label for="violetC">VIOLET</label></li>
												<li class="lilac"><input type="radio" id="lilacC" /><label for="lilacC">LILAC</label></li>
												<li class="babypink"><input type="radio" id="babypinkC" /><label for="babypinkC">BABYPINK</label></li>
												<li class="pink"><input type="radio" id="pinkC" /><label for="pinkC">PINK</label></li>
												<li class="white"><input type="radio" id="whiteC" /><label for="whiteC">WHITE</label></li>
												<li class="grey"><input type="radio" id="greyC" /><label for="greyC">GREY</label></li>
												<li class="charcoal"><input type="radio" id="charcoalC" /><label for="charcoalC">CHARCOAL</label></li>
												<li class="black"><input type="radio" id="blackC" /><label for="blackC">BLACK</label></li>
												<li class="silver"><input type="radio" id="silverC" /><label for="silverC">SILVER</label></li>
												<li class="gold"><input type="radio" id="goldC" /><label for="goldC">GOLD</label></li>
												<li class="check"><input type="radio" id="checkC" /><label for="checkC">CHECK</label></li>
												<li class="stripe"><input type="radio" id="stripeC" /><label for="stripeC">STRIPE</label></li>
												<li class="dot"><input type="radio" id="dotC" /><label for="dotC">DOT</label></li>
												<li class="flower"><input type="radio" id="flowerC" /><label for="flowerC">FLOWER</label></li>
												<li class="drawing"><input type="radio" id="drawingC" /><label for="drawingC">DRAWING</label></li>
												<li class="animal"><input type="radio" id="animalC" /><label for="animalC">ANIMAL</label></li>
												<li class="geometric"><input type="radio" id="geometricC" /><label for="geometricC">GEOMETRIC</label></li>
											</ul>
										</dd>
									</dl>
								</dd>
							</dl>
						</div>
						<div class="clearAll"><input type="checkbox" id="checkAll2" class="check" /> <label for="checkAll2">전체선택 해제</label></div>
						<div class="searchBtn"><input type="submit" value="검색" class="btn btnB1 btnRed" /></div>
					</div>
				</div>
				<!--// 검색영역 -->
				<div class="diaryCtgy">
					<div class="array">
						<p><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_total.png" alt="Total" /> (9998)</p>
						<div class="option">
							<select class="optSelect" title="다이어리 정렬 방식 선택">
								<option>인기상품순</option>
								<option>신상품순</option>
								<option>낮은가격순</option>
								<option>높은가격순</option>
								<option>높은할인율순</option>
							</select>
						</div>
					</div>
					<div class="diaryList">
						<ul>
							<!-- for dev msg : 상품은 16개씩 노출됩니다 / 품절일경우 클래스 soldOut 붙여주세요-->
							<li class="soldOut">
								<div class="pPhoto">
									<span class="soldOutMask"></span>
									<!-- 미리보기 --><a href="#lyrPreview" onclick="viewPoupLayer('modal',$('#lyrPreview').html());return false;" target="_top" class="btnPreview">미리보기</a>
									<a href="">
										<img src="http://fiximage.10x10.co.kr/web2013/diarystory2015/@temp_img_270x270_01.jpg" width="240" height="240" alt="상품명" />
										<dfn><img src="http://fiximage.10x10.co.kr/web2013/@temp/pdt01_400x400.jpg" width="240" height="240" alt="상품명" /></dfn>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="brand"><a href="">7321 Design</a></p>
									<a href="">
										<p class="name">앨리스 다이어리 vol.17</p>
										<p class="price">12,039,600원 <strong class="cRd0V15">[10%]</strong><strong class="cGr0V15">[10%]</strong></p>
									</a>
								</div>
							</li>
							<li>
								<div class="pPhoto">
									<span class="soldOutMask"></span>
									<a href="#lyrPreview" onclick="viewPoupLayer('modal',$('#lyrPreview').html());return false;" target="_top" class="btnPreview">미리보기</a>
									<a href="">
										<img src="http://thumbnail.10x10.co.kr/webimage/image/basic600/135/B001359962.jpg" width="240" height="240" alt="상품명" />
										<dfn><img src="http://thumbnail.10x10.co.kr/webimage/image/add5_600/135/A001359962_05.jpg" width="240" height="240" alt="상품명" /></dfn>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="brand"><a href="">MELLOW</a></p>
									<a href="">
										<p class="name">[3년일기장] 책가도_A Three-year Story Book</p>
										<p class="price">12,039,600원 <strong class="cRd0V15">[10%]</strong><strong class="cGr0V15">[10%]</strong></p>
									</a>
								</div>
							</li>
							<li>
								<div class="pPhoto">
									<span class="soldOutMask"></span>
									<a href="#lyrPreview" onclick="viewPoupLayer('modal',$('#lyrPreview').html());return false;" target="_top" class="btnPreview">미리보기</a>
									<a href="">
										<img src="http://thumbnail.10x10.co.kr/webimage/image/add2_600/156/A001560582_02.jpg" width="240" height="240" alt="상품명" />
										<dfn><img src="http://thumbnail.10x10.co.kr/webimage/image/add3_600/156/A001560582_03.jpg" width="240" height="240" alt="상품명" /></dfn>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="brand"><a href="">ICONIC</a></p>
									<a href="">
										<p class="name">아이코닉 더 플래너 2017</p>
										<p class="price">12,039,600원 <strong class="cRd0V15">[10%]</strong><strong class="cGr0V15">[10%]</strong></p>
									</a>
								</div>
							</li>
							<li>
								<div class="pPhoto">
									<span class="soldOutMask"></span>
									<a href="#lyrPreview" onclick="viewPoupLayer('modal',$('#lyrPreview').html());return false;" target="_top" class="btnPreview">미리보기</a>
									<a href="">
										<img src="http://thumbnail.10x10.co.kr/webimage/image/basic600/156/B001560582.jpg" width="240" height="240" alt="상품명" />
										<dfn><img src="http://thumbnail.10x10.co.kr/webimage/image/add1_600/156/A001560582_01.jpg" width="240" height="240" alt="상품명" /></dfn>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="brand"><a href="">INVITE.L</a></p>
									<a href="">
										<p class="name">Spring Note PVC Cover</p>
										<p class="price">12,039,600원 <strong class="cGr0V15">[10%]</strong></p>
									</a>
								</div>
							</li>
						</ul>
						<div class="pageWrapV15">
							<div class="paging">
								<a href="" class="first arrow"><span>맨 처음 페이지로 이동</span></a>
								<a href="" class="prev arrow"><span>이전페이지로 이동</span></a>
								<a href=""><span>1</span></a>
								<a href=""><span>2</span></a>
								<a href=""><span>3</span></a>
								<a href="" class="current"><span>4</span></a>
								<a href=""><span>5</span></a>
								<a href=""><span>6</span></a>
								<a href=""><span>7</span></a>
								<a href=""><span>8</span></a>
								<a href=""><span>9</span></a>
								<a href=""><span>10</span></a>
								<a href="" class="next arrow"><span>다음 페이지로 이동</span></a>
								<a href="" class="end arrow"><span>맨 마지막 페이지로 이동</span></a>
							</div>
							<div class="pageMove">
								<input type="text" style="width:24px;" /> /23페이지 <a href="" class="btn btnS2 btnGry2"><em class="whiteArr01 fn">이동</em></a>
							</div>
						</div>
					</div>
					<!-- 검색결과 없을 경우 -->
					<div class="nodata">
						<p><img src="http://fiximage.10x10.co.kr/web2013/common/txt_search_no.png" alt="흠… 검색 결과가 없습니다."></p>
						<p class="tMar10">해당상품이 품절 되었을 경우 검색이 되지 않습니다.</p>
					</div>
					<!--// 검색결과 없을 경우 -->
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/html/lib/inc/incFooter.asp" -->
</div>
</body>
</html>