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
' History : 2020-06-29 조경애
'####################################################
Dim eCode, userid

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67507
Else
	eCode   =  103730
End If

userid = GetEncLoginUserID()
%>
<style type="text/css">
.evt103730 {height:1355px; background:url(//webimage.10x10.co.kr/eventIMG/2020/103730/bg_cont.jpg) no-repeat 50% 0;}
.evt103730 .inner {width:1140px; margin:0 auto;}
.evt103730 .inner:after {content:' '; display:block; clear:both;}
.evt103730 .section {position:relative; float:left; width:50%; height:1029px; padding-top:196px;}
.evt103730 .section:after {content:''; display:inline-block; position:absolute; background-position:0 0; background-repeat:no-repeat;}
.evt103730 .section .go-more {position:absolute; left:50%; bottom:0; margin-left:-190px;}
.evt103730 .section .total {position:absolute; left:50%; bottom:253px; width:203px; margin-left:-72px; color:#000; font-size:30px; line-height:28px; font-weight:500; text-align:right;}
.evt103730 .section .total b {font-size:32px; font-weight:700;}
.evt103730 .section ul {width:419px; margin:0 auto; text-align:left;}
.evt103730 .section li a {display:block; position:relative;}
.evt103730 .section li .price {position:absolute; left:140px; top:85px; padding-left:48px; font-size:16px; line-height:20px; color:#000; background:url(//webimage.10x10.co.kr/fixevent/event/2020/103730/txt_price.png) no-repeat 0 50%; font-weight:700;}
.evt103730 .section li .price s {display:none;}
.evt103730 .section li .price span {display:inline-block; height:20px; margin-left:8px; padding:0 5px; color:#fff; font-size:14px; line-height:20px; font-weight:400; background:#15032b;}
.evt103730 .furniture {background:url(//webimage.10x10.co.kr/eventIMG/2018/84318/v2/bg_furniture.png) no-repeat 0 0;}
.evt103730 .furniture:after {left:-178px; top:-20px; width:310px; height:554px; background-image:url(//webimage.10x10.co.kr/eventIMG/2018/84318/img_pen.png);}
.evt103730 .props {background:url(//webimage.10x10.co.kr/eventIMG/2020/103730/bg_props.png) no-repeat 50% 0;}
.evt103730 .props ul {padding-bottom:24px;}
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
	fnApplyToTalPriceItem({
		items:"1654161,2956066,2865205,1231688,2232979,2841681,1654118,1370223,1891212,2655010,1996706,2595057",
		target:"item",
		fields:["price","sale"],
		unit:"ew",
		saleBracket:false
	});
	$('.scrollbarwrap').tinyscrollbar();
});
// 개별 상품 정보 업데이트
function fnApplyToTalPriceItem(opts) {
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
						if(this.itemid==2232979)
						{
							$("#totalprice1").empty().html(numberFormat(isTotalPrice));
							isTotalPrice=0;
						}
						else if(this.itemid==2595057)
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
                        <div class="evt103730">
							<div class="inner">
								<!-- 가구점 -->
								<div class="section furniture">
									<ul>
										<li class="item1654161">
											<a href="/shopping/category_prd.asp?itemid=1654161&pEtr=103730">
												<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_furniture_1.jpg" alt="로디 일체형 침대" /></div>
												<p class="price"></p>
											</a>
										</li>
										<li class="item2956066">
											<a href="/shopping/category_prd.asp?itemid=2956066&pEtr=103730">
												<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_furniture_2.jpg" alt="OLLSON 책상 + FIHA 서랍장 6단 세트" /></div>
												<p class="price"></p>
											</a>
										</li>
										<li class="item2865205">
											<a href="/shopping/category_prd.asp?itemid=2865205&pEtr=103730">
												<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_furniture_3.jpg" alt="컴퓨터 책상 학생 의자 709 BLACK FRAME" /></div>
												<p class="price"></p>
											</a>
										</li>
										<li class="item1231688">
											<a href="/shopping/category_prd.asp?itemid=1231688&pEtr=103730">
												<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_furniture_4.jpg" alt="화이트 2단행거" /></div>
												<p class="price"></p>
											</a>
										</li>
										<li class="item2232979">
											<a href="/shopping/category_prd.asp?itemid=2232979&pEtr=103730">
												<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_furniture_5.jpg" alt="팔각 골드 대형전신거울" /></div>
												<p class="price"></p>
											</a>
										</li>
									</ul>
									<p class="total"><b id="totalprice1">0</b>원</p>
									<a href="#mapGroup330878" class="go-more"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/btn_more_1.png" alt="더 많은 가구 보러 가기" /></a>
								</div>
								<!-- 소품점 -->
								<div class="section props">
									<div class="scrollbarwrap">
										<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
										<div class="viewport">
											<div class="overview">
												<ul>
													<li class="item2841681">
														<a href="/shopping/category_prd.asp?itemid=2841681&pEtr=103730">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_props_1.jpg" alt="시어서커 여름 차렵침구" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item1654118">
														<a href="/shopping/category_prd.asp?itemid=1654118&pEtr=103730">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_props_2.jpg" alt="프리즘 충전식 무선 LED 스탠드" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item1370223">
														<a href="/shopping/category_prd.asp?itemid=1370223&pEtr=103730">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_props_3.jpg" alt="노르딕솔리드 작은창 암막커튼" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item1891212">
														<a href="/shopping/category_prd.asp?itemid=1891212&pEtr=103730">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_props_4.jpg" alt="매일리 디퓨져" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item2655010">
														<a href="/shopping/category_prd.asp?itemid=2655010&pEtr=103730">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_props_5.jpg?v=1" alt="라이프썸 LED 거울" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item1996706">
														<a href="/shopping/category_prd.asp?itemid=1996706&pEtr=103730">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_props_6.jpg" alt="메모리얼 드로잉 패브릭 포스터 / 가리개커튼" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item2595057">
														<a href="/shopping/category_prd.asp?itemid=2595057&pEtr=103730">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/103730/img_props_7.jpg" alt="사계절 심플 단모 거실 침실 원형 러그" /></div>
															<p class="price"></p>
														</a>
													</li>
												</ul>
											</div>
										</div>
									</div>
									<p class="total"><b id="totalprice2">0</b>원</p>
									<a href="#mapGroup330879" class="go-more"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/btn_more_2.png" alt="더 많은 소품 보러 가기" /></a>
								</div>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->