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
	eCode = 67507
Else
	eCode = 108174
End If

userid = GetEncLoginUserID()
%>
<style type="text/css">
.evt108174 {height:1355px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108174/bg_cont.jpg) no-repeat 50% 0;}
.evt108174 .inner {width:1140px; margin:0 auto;}
.evt108174 .inner:after {content:' '; display:block; clear:both;}
.evt108174 .section {position:relative; float:left; width:50%; height:1029px; padding-top:196px;}
.evt108174 .section:after {content:''; display:inline-block; position:absolute; background-position:0 0; background-repeat:no-repeat;}
.evt108174 .section .go-more {position:absolute; left:50%; bottom:0; margin-left:-190px;}
.evt108174 .section .total {position:absolute; left:50%; bottom:253px; width:203px; margin-left:-72px; color:#000; font-size:30px; line-height:28px; font-weight:500; text-align:right;}
.evt108174 .section .total b {font-size:32px; font-weight:700;}
.evt108174 .section ul {width:419px; margin:0 auto; text-align:left;}
.evt108174 .section li a {display:block; position:relative;}
.evt108174 .section li .price {position:absolute; left:140px; top:85px; padding-left:63px; font-size:16px; line-height:20px; color:#000; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108174/txt_price.png) no-repeat 0 50%; font-weight:700;}
.evt108174 .section li .price s {display:none;}
.evt108174 .section li .price span {display:inline-block; height:20px; margin-left:8px; padding:0 5px; color:#fff; font-size:14px; line-height:20px; font-weight:400; background:#15032b;}
.evt108174 .furniture {background:url(//webimage.10x10.co.kr/fixevent/event/2020/108174/bg_furniture.jpg) no-repeat center top;}
.evt108174 .props {background:url(//webimage.10x10.co.kr/fixevent/event/2020/108174/bg_props.jpg) no-repeat center top;}
.evt108174 .props ul {padding-bottom:24px;}
.scrollbarwrap {width:483px; margin:0 auto; padding:17px 0 0;}
.scrollbarwrap .overview {margin-top:-14px;}
.scrollbarwrap .viewport {width:419px; height:691px; margin-left:35px;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:12px; background-color:transparent;}
.scrollbarwrap .track {position: relative; width:12px; height:100%; background-color:transparent;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:12px; background-color:#e32b13; cursor:pointer; border-radius:15px;}
.scrollbarwrap .disable {display:none;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script>
$(function() {
	fnApplyToTalPriceItem({
		items:"774875,1819313,1440122,2228458,2289960,2584292,3358084,3477037,3371157,3180003,2686885,1791011",
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
						if(this.itemid==2289960)
						{
							$("#totalprice1").empty().html(numberFormat(isTotalPrice));
							isTotalPrice=0;
						}
						else if(this.itemid==1791011)
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
						<div class="evt108174">
							<div class="inner">
								<!-- 가구점 -->
								<div class="section furniture">
									<ul>
										<li class="item774875">
											<a href="/shopping/category_prd.asp?itemid=774875&pEtr=108174">
												<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_furniture_1.jpg?v=1" alt="" /></div>
												<p class="price"></p>
											</a>
										</li>
										<li class="item1819313">
											<a href="/shopping/category_prd.asp?itemid=1819313&pEtr=108174">
												<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_furniture_2.jpg" alt="" /></div>
												<p class="price"></p>
											</a>
										</li>
										<li class="item1440122">
											<a href="/shopping/category_prd.asp?itemid=1440122&pEtr=108174">
												<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_furniture_3.jpg" alt="" /></div>
												<p class="price"></p>
											</a>
										</li>
										<li class="item2228458">
											<a href="/shopping/category_prd.asp?itemid=2228458&pEtr=108174">
												<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_furniture_4.jpg" alt="" /></div>
												<p class="price"></p>
											</a>
										</li>
										<li class="item2289960">
											<a href="/shopping/category_prd.asp?itemid=2289960&pEtr=108174">
												<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_furniture_5.jpg" alt="" /></div>
												<p class="price"></p>
											</a>
										</li>
									</ul>
									<p class="total"><b id="totalprice1">0</b>원</p>
									<a href="#mapGroup350983" class="go-more"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/btn_more_1.png" alt="더 많은 가구 보러 가기" /></a>
								</div>
								<!-- 소품점 -->
								<div class="section props">
									<div class="scrollbarwrap">
										<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
										<div class="viewport">
											<div class="overview">
												<ul>
													<li class="item2584292">
														<a href="/shopping/category_prd.asp?itemid=2584292&pEtr=108174">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_props_1.jpg" alt="" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item3358084">
														<a href="/shopping/category_prd.asp?itemid=3358084&pEtr=108174">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_props_2.jpg" alt="" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item3477037">
														<a href="/shopping/category_prd.asp?itemid=3477037&pEtr=108174">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_props_3.jpg" alt="" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item3371157">
														<a href="/shopping/category_prd.asp?itemid=3371157&pEtr=108174">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_props_4.jpg" alt="" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item3180003">
														<a href="/shopping/category_prd.asp?itemid=3180003&pEtr=108174">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_props_5.jpg" alt="" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item2686885">
														<a href="/shopping/category_prd.asp?itemid=2686885&pEtr=108174">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_props_6.jpg" alt="" /></div>
															<p class="price"></p>
														</a>
													</li>
													<li class="item1791011">
														<a href="/shopping/category_prd.asp?itemid=1791011&pEtr=108174">
															<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/img_props_7.jpg" alt="" /></div>
															<p class="price"></p>
														</a>
													</li>
												</ul>
											</div>
										</div>
									</div>
									<p class="total"><b id="totalprice2">0</b>원</p>
									<a href="#mapGroup350984" class="go-more"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108174/btn_more_2.png" alt="더 많은 소품 보러 가기" /></a>
								</div>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->