<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'####################################################
' Description : 50만원으로 내 방 꾸미기
' History : 2018-02-13 정태훈
'####################################################
Dim eCode, userid

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67507
Else
	eCode   =  84318
End If

userid = GetEncLoginUserID()
%>
<style type="text/css">
.evt84318 {height:2334px; background:#ffa0b5 url(http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/bg_cont.jpg) no-repeat 50% 0;}
.evt84318 .topic {position:relative;}
.evt84318 .topic .date {position:absolute; left:50%; top:33px; margin-left:413px;}
.evt84318 .topic h2 {padding:55px 0 80px;}
.evt84318 .inner {width:1140px; margin:0 auto;}
.evt84318 .inner:after {content:' '; display:block; clear:both;}
.evt84318 .inner .section {position:relative; float:left; width:50%; height:1029px; padding-top:196px;}
.evt84318 .inner .section:after {content:''; display:inline-block; position:absolute; background-position:0 0; background-repeat:no-repeat;}
.evt84318 .inner .section .go-more {position:absolute; left:50%; bottom:0; margin-left:-190px;}
.evt84318 .inner .section .total {position:absolute; left:50%; bottom:256px; width:203px; margin-left:-72px; color:#000; font-size:30px; line-height:28px; font-weight:bold; text-align:right;}
.evt84318 .inner .section ul {width:419px; margin:0 auto; }
.evt84318 .inner .section li {position:relative;}
.evt84318 .inner .section li > a {display:block;}
.evt84318 .inner .section li .price {position:absolute; left:50%; top:85px; margin-left:-5px; font-size:16px; line-height:1; color:#000;}
.evt84318 .inner .section li .price s {display:none;}
.evt84318 .inner .section li .price span {display:inline-block; position:relative; top:-1px; height:20px; margin-left:5px; padding:0 5px; color:#fff; font-size:14px; line-height:19px; background:#000;}
.evt84318 .inner .furniture {background:url(http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/bg_furniture.png) no-repeat 0 0;}
.evt84318 .inner .furniture:after {left:-178px; top:-20px; width:310px; height:554px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84318/img_pen.png?v=1);}
.evt84318 .inner .props {background:url(http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/bg_props.png) no-repeat 50% 0;}
.evt84318 .inner .props ul {padding-bottom:24px;}
.evt84318 .video {position:relative; width:750px; height:422px; margin:0 auto 110px; padding:8px; background-color:#fff;}
.evt84318 .video iframe {width:750px; height:422px;}
.evt84318 .video:before,
.evt84318 .video:after {content:''; display:inline-block; position:absolute; width:101px; height:102px; background-position:0 0; background-repeat:no-repeat;}
.evt84318 .video:before {left:-35px; top:-28px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/img_deco_1.png);}
.evt84318 .video:after {right:-30px; bottom:-30px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/img_deco_2.png);}
.scrollbarwrap {width:484px; margin:0 auto; padding:17px 0 0;}
.scrollbarwrap .overview {margin-top:-14px;}
.scrollbarwrap .viewport {width:419px; height:691px; margin-left:35px;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:12px; background-color:transparent;}
.scrollbarwrap .track {position: relative; width:12px; height:100%; background-color:transparent;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:12px; background-color:#5a58bf; cursor:pointer; border-radius:15px;}
.scrollbarwrap .disable {display:none;}
</style>

<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script>
$(function() {
	fnApplyItemInfoEach({
		items:"1702350,1752332,1764193,1835660,1899244,1858724,1729117,1510751,672273,1490116,1883108,1782547,281012,1660717",
		target:"item",
		fields:["price","sale"],
		unit:"hw",
		saleBracket:false
	});
	$('.scrollbarwrap').tinyscrollbar();
});
// 개별 상품 정보 업데이트
function fnApplyItemInfoEach(opts) {
	// 필터 정의
	var isImg=false, isNm=false, isPrc=false, isSale=false, isSld=false, isLmt=false, isTotalPrice=0;
	$(opts.fields).each(function(){
		switch(this.toString()){
			case "image" : isImg=true; break;
			case "name" : isNm=true; break;
			case "price" : isPrc=true; break;
			case "sale" : isSale=true; break;
			case "soldout" : isSld=true; break;
			case "limit" : isLmt=true; break;
		}
	});

	$.ajax({
		type: "get",
		url: "/event/etc/json/act_getItemInfo2.asp",
		data: "arriid="+opts.items+"&unit="+opts.unit,
		cache: false,
		success: function(message) {
			if(typeof(message)=="object") {
				if(typeof(message.items)=="object") {
					var i=0;
					$(message.items).each(function(){
						// 상품 이미지 출력
						if(isImg){
							$("."+opts.target+this.itemid+" .thumbnail img").attr("src",this.imgurl);
						}
						// 상품명 출력
						if(isNm){
							$("."+opts.target+this.itemid+" .name").html(this.itemname);
						}
						
						// 판매가 출력
						if(isPrc){
							if(isSale){
								//할인율 표시
								if(this.saleper!="") {
									if(opts.saleBracket) {
										$("."+opts.target+this.itemid+" .price").html("<s>"+this.orgprice+"</s> "+this.sellprice+"<span>["+this.saleper+"]</span>");
									} else {
										$("."+opts.target+this.itemid+" .price").html("<s>"+this.orgprice+"</s> "+this.sellprice+"<span>"+this.saleper+"</span>");
									}
								
								} else {
									$("."+opts.target+this.itemid+" .price").html(this.sellprice);
								}
							}else{
								// 판매가 표시
								$("."+opts.target+this.itemid+" .price").html(this.sellprice);
							}
						}

						// 품절상품 표시
						if(isSld){
							if(this.soldout=="true") {
								$("."+opts.target+this.itemid).addClass("soldout");
							}
						}

						// 한정 남은갯수 표시
						if(isLmt){
							if(this.limityn=="Y") {
								$("#"+opts.target+" li .limit span").html(this.limitRemain);
							} else {
								$("#"+opts.target+" li .limit").hide();
							}
						}

						isTotalPrice += this.sellprice2;
						//alert(this.itemid + " / " + this.sellprice2 + " / " + isTotalPrice);
						if(this.itemid==1899244)
						{
							$("#totalprice1").empty().html(numberFormat(isTotalPrice));
							isTotalPrice=0;
						}
						else if(this.itemid==1660717)
						{
							$("#totalprice2").empty().html(numberFormat(isTotalPrice));
							isTotalPrice=0;
						}
						i++;
					});
				}
			}
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
}


function numberFormat(num){
	num = num.toString();
	return num.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1,');
}
</script>
						<div class="evt84318">
							<div class="topic">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/tit_room.png" alt="50만원으로 내 방 꾸미기!" /></h2>
								<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/txt_date.png" alt="2018.02.19~04.19" /></p>
							</div>
							<div class="video">
								<iframe src="https://www.youtube.com/embed/bk7WAurAHIw" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
							</div>
							<div class="inner">
								<!-- 가구점 -->
								<div class="section furniture">
									<ul style="padding-top:3px;">
										<li class="item1702350">
											<a href="/shopping/category_prd.asp?itemid=1702350&pEtr=84318">
												<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_furniture_1.jpg?v=1" alt="로디 일체형 침대 S (높은다릿발)" /></div>
												<p class="price">가격 <span>할인율</span></p>
											</a>
										</li>
										<li class="item1752332">
											<a href="/shopping/category_prd.asp?itemid=1752332&pEtr=84318">
												<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_furniture_2.jpg?v=1" alt="OLLSON 책상" /></div>
												<p class="price">가격</p>
											</a>
										</li>
										<li class="item1764193">
											<a href="/shopping/category_prd.asp?itemid=1764193&pEtr=84318">
												<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_furniture_3.jpg?v=1" alt="RAMIRA 의자" /></div>
												<p class="price">가격</p>
											</a>
										</li>
										<li class="item1835660">
											<a href="/shopping/category_prd.asp?itemid=1835660&pEtr=84318">
												<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_furniture_4.jpg?v=1" alt="GOTHEM (순수원목) 수납공간박스" /></div>
												<p class="price">가격</p>
											</a>
										</li>
										<li class="item1899244">
											<a href="/shopping/category_prd.asp?itemid=1899244&pEtr=84318">
												<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_furniture_5.jpg?v=1" alt="아크 코트 랙 내추럴" /></div>
												<p class="price">가격</p>
											</a>
										</li>
									</ul>
									<p class="total"><b id="totalprice1">0</b>원</p>
									<a href="#groupBar1" class="go-more"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/btn_more_1.png" alt="더 많은 가구 보러 가기" /></a>
								</div>
								<!-- 소품점 -->
								<div class="section props">
									<div class="scrollbarwrap">
										<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
										<div class="viewport">
											<div class="overview">
												<ul>
													<li class="item1858724">
														<a href="/shopping/category_prd.asp?itemid=1858724&pEtr=84318">
															<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_props_1.jpg?v=1.1" alt="큐브 차렵이불 (SQ)" /></div>
															<p class="price">가격</p>
														</a>
													</li>
													<li class="item1729117">
														<a href="/shopping/category_prd.asp?itemid=1729117&pEtr=84318">
															<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_props_2.jpg?v=1" alt="RUSTA 장스탠드" /></div>
															<p class="price">가격</p>
														</a>
													</li>
													<li class="item1510751">
														<a href="/shopping/category_prd.asp?itemid=1510751&pEtr=84318">
															<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_props_3.jpg?v=1" alt="알로카시아 블랙 pot (50cm)" /></div>
															<p class="price">가격</p>
														</a>
													</li>
													<li class="item672273">
														<a href="/shopping/category_prd.asp?itemid=672273&pEtr=84318">
															<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_props_4.jpg?v=1" alt="호텔식 화이트 시폰 커튼" /></div>
															<p class="price">가격</p>
														</a>
													</li>
													<li class="item1490116">
														<a href="/shopping/category_prd.asp?itemid=1490116&pEtr=84318">
															<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_props_5.jpg?v=1.1" alt="숲속의 향기 디퓨저 6종" /></div>
															<p class="price">가격</p>
														</a>
													</li>
													<li class="item1883108">
														<a href="/shopping/category_prd.asp?itemid=1883108&pEtr=84318">
															<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_props_6.jpg?v=1" alt="프리미엄 LED 조명 탁상거울" /></div>
															<p class="price">가격</p>
														</a>
													</li>
													<li class="item1782547">
														<a href="/shopping/category_prd.asp?itemid=1782547&pEtr=84318">
															<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_props_7.jpg?v=1" alt="패브릭 포스터 열대 나뭇잎" /></div>
															<p class="price">가격</p>
														</a>
													</li>
													<li class="item281012">
														<a href="/shopping/category_prd.asp?itemid=281012&pEtr=84318">
															<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_props_8.jpg?v=1" alt="한일카페트 터치미 러그" /></div>
															<p class="price">가격</p>
														</a>
													</li>
													<li class="item1660717">
														<a href="/shopping/category_prd.asp?itemid=1660717&pEtr=84318">
															<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/img_props_9.jpg?v=1" alt="와이어 레터링 6종" /></div>
															<p class="price">가격</p>
														</a>
													</li>
												</ul>
											</div>
										</div>
									</div>
									<p class="total"><b id="totalprice2">0</b>원</p>
									<a href="#groupBar2" class="go-more"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/btn_more_2.png" alt="더 많은 소품 보러 가기" /></a>
								</div>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->