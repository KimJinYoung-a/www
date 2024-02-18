<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 50만원으로 내 방 꾸미기
' History : 2020-06-29 조경애
'####################################################
Dim eCode, userid

IF application("Svr_Info") = "Dev" THEN
	eCode = 67507
Else
	eCode = 111333
End If

userid = GetEncLoginUserID()
%>
<style type="text/css">
.evt-myroom {position:relative;}
.evt-myroom .topic {background:url(//webimage.10x10.co.kr/eventIMG/2020/107161/BGImage20201104122011.JPEG) no-repeat 50% 0;}
.evt-myroom .items-wrap {height:1355px; background:url(//webimage.10x10.co.kr/eventIMG/2020/103730/bg_cont.jpg) no-repeat 50% 0;}
.evt-myroom .inner {width:1140px; margin:0 auto;}
.evt-myroom .inner:after {content:' '; display:block; clear:both;}
.evt-myroom .section {position:relative; float:left; width:50%; height:1029px; padding-top:196px;}
.evt-myroom .section:after {content:''; display:inline-block; position:absolute; background-position:0 0; background-repeat:no-repeat;}
.evt-myroom .section .go-more {position:absolute; left:50%; bottom:0; margin-left:-190px;}
.evt-myroom .section .total {position:absolute; left:50%; bottom:253px; width:203px; margin-left:-72px; color:#000; font-size:30px; line-height:28px; font-weight:500; text-align:right;}
.evt-myroom .section .total b {font-size:32px; font-weight:700;}
.evt-myroom .section ul {width:419px; margin:0 auto; text-align:left;}
.evt-myroom .section li a {display:block; position:relative;}
.evt-myroom .section li .price {position:absolute; left:140px; top:85px; padding-left:48px; font-size:16px; line-height:20px; color:#000; background:url(//webimage.10x10.co.kr/fixevent/event/2020/103730/txt_price.png) no-repeat 0 50%; font-weight:700;}
.evt-myroom .section li .price s {display:none;}
.evt-myroom .section li .price span {display:inline-block; height:20px; margin-left:8px; padding:0 5px; color:#fff; font-size:14px; line-height:20px; font-weight:400; background:#15032b;}
.evt-myroom .furniture {background:url(//webimage.10x10.co.kr/fixevent/event/2021/111333/bg_furniture.png?v=2.4) no-repeat 0 0;}
.evt-myroom .furniture:after {left:-178px; top:-20px; width:310px; height:554px; background-image:url(//webimage.10x10.co.kr/eventIMG/2018/84318/img_pen.png);}
.evt-myroom .props {background:url(//webimage.10x10.co.kr/fixevent/event/2021/111333/bg_props.png?v=2.2) no-repeat 50% 0;}
.scrollbarwrap {width:484px; margin:0 auto; padding:17px 0 0;}
.scrollbarwrap .overview {margin-top:-14px;}
.scrollbarwrap .viewport {width:419px; height:691px; margin-left:35px;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:12px; background-color:transparent;}
.scrollbarwrap .track {position: relative; width:12px; height:100%; background-color:transparent;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:12px; background-color:#5a58bf; cursor:pointer; border-radius:15px;}
.furniture .scrollbarwrap .thumb {background:#e7415f;}
.scrollbarwrap .disable {display:none;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(function() {
	fnApplyToTalPriceItem({
		items:"3593365,1635089,3468614,3825585,2640251,2489750,1791011,3812529,3783876,3823852,2774903,3762087,3754825,3715687",
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
						if(this.itemid==1791011)
						{
							$("#totalprice1").empty().html(numberFormat(isTotalPrice));
							isTotalPrice=0;
						}
						else if(this.itemid==3715687)
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
<div class="evt-myroom">
	<div class="topic"><img src="//webimage.10x10.co.kr/eventIMG/2020/107161/main_mo20201104121748.JPEG" alt="50만원으로 내 방 꾸미기"></div>
	<div class="items-wrap">
		<div class="inner">
			<!-- 가구점 -->
			<div class="section furniture">
                <div class="scrollbarwrap">
                    <div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
                    <div class="viewport">
                        <div class="overview">
                            <ul>
                                <li class="item3593365">
                                    <a href="/shopping/category_prd.asp?itemid=3593365&pEtr=111333">
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_furniture_1.jpg" alt="" /></div>
                                        <p class="price"></p>
                                    </a>
                                </li>
                                <li class="item1635089">
                                    <a href="/shopping/category_prd.asp?itemid=1635089&pEtr=111333">
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_furniture_2.jpg" alt="" /></div>
                                        <p class="price"></p>
                                    </a>
                                </li>
                                <li class="item3468614">
                                    <a href="/shopping/category_prd.asp?itemid=3468614&pEtr=111333">
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_furniture_3.jpg" alt="" /></div>
                                        <p class="price"></p>
                                    </a>
                                </li>
                                <li class="item3825585">
                                    <a href="/shopping/category_prd.asp?itemid=3825585&pEtr=111333">
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_furniture_4.jpg" alt="" /></div>
                                        <p class="price"></p>
                                    </a>
                                </li>
                                <li class="item2640251">
                                    <a href="/shopping/category_prd.asp?itemid=2640251&pEtr=111333">
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_furniture_5.jpg" alt="" /></div>
                                        <p class="price"></p>
                                    </a>
                                </li>
                                <li class="item2489750">
                                    <a href="/shopping/category_prd.asp?itemid=2489750&pEtr=111333">
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_furniture_6.jpg" alt="" /></div>
                                        <p class="price"></p>
                                    </a>
                                </li>
                                <li class="item1791011">
                                    <a href="/shopping/category_prd.asp?itemid=1791011&pEtr=111333">
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_furniture_7.jpg" alt="" /></div>
                                        <p class="price"></p>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
				<p class="total"><b id="totalprice1">0</b>원</p>
				<a href="#mapGroup366515" class="go-more"><img src="//webimage.10x10.co.kr/eventIMG/2018/84318/v2/btn_more_1.png" alt="더 많은 가구 보러 가기" /></a>
			</div>
			<!-- 소품점 -->
			<div class="section props">
				<div class="scrollbarwrap">
					<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
					<div class="viewport">
						<div class="overview">
							<ul>
								<li class="item3812529">
									<a href="/shopping/category_prd.asp?itemid=3812529&pEtr=111333">
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_props_1.jpg" alt="" /></div>
										<p class="price"></p>
									</a>
								</li>
								<li class="item3783876">
									<a href="/shopping/category_prd.asp?itemid=3783876&pEtr=111333">
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_props_2.jpg" alt="" /></div>
										<p class="price"></p>
									</a>
								</li>
								<li class="item3823852">
									<a href="/shopping/category_prd.asp?itemid=3823852&pEtr=111333">
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_props_3.jpg" alt="" /></div>
										<p class="price"></p>
									</a>
								</li>
								<li class="item2774903">
									<a href="/shopping/category_prd.asp?itemid=2774903&pEtr=111333">
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_props_4.jpg" alt="" /></div>
										<p class="price"></p>
									</a>
								</li>
								<li class="item3762087">
									<a href="/shopping/category_prd.asp?itemid=3762087&pEtr=111333">
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_props_5.jpg" alt="" /></div>
										<p class="price"></p>
									</a>
								</li>
								<li class="item3754825">
									<a href="/shopping/category_prd.asp?itemid=3754825&pEtr=111333">
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_props_6.jpg" alt="" /></div>
										<p class="price"></p>
									</a>
								</li>
								<li class="item3715687">
									<a href="/shopping/category_prd.asp?itemid=3715687&pEtr=111333">
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111333/img_props_7.jpg" alt="" /></div>
										<p class="price"></p>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<p class="total"><b id="totalprice2">0</b>원</p>
				<a href="#mapGroup366516" class="go-more"><img src="//webimage.10x10.co.kr/eventIMG/2018/84318/v2/btn_more_2.png" alt="더 많은 소품 보러 가기" /></a>
			</div>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->