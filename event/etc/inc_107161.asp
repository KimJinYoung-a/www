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
	eCode   =  107161
End If

userid = GetEncLoginUserID()
%>
<style type="text/css">
.evt107161 {height:1355px; background:url(//webimage.10x10.co.kr/eventIMG/2020/103730/bg_cont.jpg) no-repeat 50% 0;}
.evt107161 .inner {width:1140px; margin:0 auto;}
.evt107161 .inner:after {content:' '; display:block; clear:both;}
.evt107161 .section {position:relative; float:left; width:50%; height:1029px; padding-top:196px;}
.evt107161 .section:after {content:''; display:inline-block; position:absolute; background-position:0 0; background-repeat:no-repeat;}
.evt107161 .section .go-more {position:absolute; left:50%; bottom:0; margin-left:-190px;}
.evt107161 .section .total {position:absolute; left:50%; bottom:253px; width:203px; margin-left:-72px; color:#000; font-size:30px; line-height:28px; font-weight:500; text-align:right;}
.evt107161 .section .total b {font-size:32px; font-weight:700;}
.evt107161 .section ul {width:419px; margin:0 auto; text-align:left;}
.evt107161 .section li a {display:block; position:relative;}
.evt107161 .section li .price {position:absolute; left:140px; top:85px; padding-left:48px; font-size:16px; line-height:20px; color:#000; background:url(//webimage.10x10.co.kr/fixevent/event/2020/107161/txt_price.png) no-repeat 0 50%; font-weight:700;}
.evt107161 .section li .price s {display:none;}
.evt107161 .section li .price span {display:inline-block; height:20px; margin-left:8px; padding:0 5px; color:#fff; font-size:14px; line-height:20px; font-weight:400; background:#15032b;}
.evt107161 .furniture {background:url(//webimage.10x10.co.kr/eventIMG/2018/84318/v2/bg_furniture.png) no-repeat 0 0;}
.evt107161 .furniture:after {left:-178px; top:-20px; width:310px; height:554px; background-image:url(//webimage.10x10.co.kr/eventIMG/2018/84318/img_pen.png);}
.evt107161 .props {background:url(//webimage.10x10.co.kr/eventIMG/2020/103730/bg_props.png) no-repeat 50% 0;}
.evt107161 .props ul {padding-bottom:24px;}
.scrollbarwrap {width:484px; margin:0 auto; padding:17px 0 0;}
.scrollbarwrap .overview {margin-top:-14px;}
.scrollbarwrap .viewport {width:419px; height:691px; margin-left:35px;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:12px; background-color:transparent;}
.scrollbarwrap .track {position: relative; width:12px; height:100%; background-color:transparent;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:12px; background-color:#5a58bf; cursor:pointer; border-radius:15px;}
.scrollbarwrap .disable {display:none;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script src="/event/etc/json/js_applyItemInfo.js"></script>
<script>
$(function() {
	fnApplyToTalPriceItem({
		items:"1943407,1752332,3059421,1835660,2602528,1858724,1729117,1510751,672273,1490116,3127447,3279723,3155557,1660717",
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
						if(this.itemid==2602528)
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
<div class="evt107161">
  <div class="inner">
    <!-- 가구점 -->
    <div class="section furniture">
      <ul id="list1">
        <li class="item1943407">
          <a href="/shopping/category_prd.asp?itemid=1943407&pEtr=107161">
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_furniture_1.jpg" alt="두닷모노 하이엔 무소음 메모리폼 침대" /></div>
            <p class="price"></p>
          </a>
        </li>
        <li class="item1752332">
          <a href="/shopping/category_prd.asp?itemid=1752332&pEtr=107161">
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_furniture_2.jpg" alt="마켓비 OLLSON 책상" /></div>
            <p class="price"></p>
          </a>
        </li>
        <li class="item3059421">
          <a href="/shopping/category_prd.asp?itemid=3059421&pEtr=107161">
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_furniture_3.jpg" alt="BC체어 사무용 메쉬의자" /></div>
            <p class="price"></p>
          </a>
        </li>
        <li class="item1835660">
          <a href="/shopping/category_prd.asp?itemid=1835660&pEtr=107161">
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_furniture_4.jpg" alt="왕자행거 GOTHEM (순수원목) 수납공간박스" /></div>
            <p class="price"></p>
          </a>
        </li>
        <li class="item2602528">
          <a href="/shopping/category_prd.asp?itemid=2602528&pEtr=107161">
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_furniture_5.jpg" alt="어썸프레임 바인 루밍 행거 랙" /></div>
            <p class="price"></p>
          </a>
        </li>
      </ul>
      <p class="total"><b id="totalprice1"></b>원</p>
      <a href="#mapGroup346522" class="go-more"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/btn_more_1.png" alt="더 많은 가구 보러 가기" /></a>
    </div>
    <!-- 소품점 -->
    <div class="section props">
      <div class="scrollbarwrap">
        <div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
        <div class="viewport">
          <div class="overview">
            <ul id="list2">
              <li class="item1858724">
                <a href="/shopping/category_prd.asp?itemid=1858724&pEtr=107161">
                  <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_props_1.jpg" alt="아이르 큐브 차렵이불" /></div>
                  <p class="price"></p>
                </a>
              </li>
              <li class="item1729117">
                <a href="/shopping/category_prd.asp?itemid=1729117&pEtr=107161">
                  <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_props_2.jpg" alt="프리즘 RUSTA 장스탠드" /></div>
                  <p class="price"></p>
                </a>
              </li>
              <li class="item1510751">
                <a href="/shopping/category_prd.asp?itemid=1510751&pEtr=107161">
                  <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_props_3.jpg" alt="까르데코 알로카시아 블랙 pot (50cm)" /></div>
                  <p class="price"></p>
                </a>
              </li>
              <li class="item672273">
                <a href="/shopping/category_prd.asp?itemid=672273&pEtr=107161">
                  <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_props_4.jpg" alt="매일리 호텔식 화이트 쉬폰 커튼" /></div>
                  <p class="price"></p>
                </a>
              </li>
              <li class="item1490116">
                <a href="/shopping/category_prd.asp?itemid=1490116&pEtr=107161">
                  <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_props_5.jpg" alt="스마일리지 숲속의 향기 디퓨저 6종" /></div>
                  <p class="price"></p>
                </a>
              </li>
              <li class="item3127447">
                <a href="/shopping/category_prd.asp?itemid=3127447&pEtr=107161">
                  <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_props_6.jpg" alt="어반던스 LED 조명 탁상거울" /></div>
                  <p class="price"></p>
                </a>
              </li>
              <li class="item3279723">
                <a href="/shopping/category_prd.asp?itemid=3279723&pEtr=107161">
                  <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_props_7.jpg" alt="더프리그 명화 빈티지 전시회 포스터" /></div>
                  <p class="price"></p>
                </a>
              </li>
              <li class="item3155557">
                <a href="/shopping/category_prd.asp?itemid=3155557&pEtr=107161">
                  <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_props_8.jpg" alt="피너츠 스누피 원형러그 1200" /></div>
                  <p class="price"></p>
                </a>
              </li>
              <li class="item1660717">
                <a href="/shopping/category_prd.asp?itemid=1660717&pEtr=107161">
                  <div><img src="//webimage.10x10.co.kr/fixevent/event/2020/107161/img_props_9.jpg" alt="데일리라이크 와이어 레터링 6종" /></div>
                  <p class="price"></p>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <p class="total"><b id="totalprice2"></b>원</p>
      <a href="#mapGroup346523" class="go-more"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84318/v2/btn_more_2.png" alt="더 많은 소품 보러 가기" /></a>
    </div>
  </div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->