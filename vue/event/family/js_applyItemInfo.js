/*
	## 상품 정보 업데이트 플러그인
	## 2017.09.26; 허진원 생성
	-----------------------------
	* 사용법
		<script type="text/javascript">
		fnApplyItemInfoList({
			items:"1,2,3",
			target:"lyrItemList",
			fields:["soldout","price","limit"],
			unit:"hw",
			saleBracket:true
		});

	* 변수
		- items : 쉼표로 구분된 상품코드
		- target : 치환대상 ID / 접두어
		- fields : 치환항목
		- unit : 가격표시 단위 (hw,ew,hp,ep,none)
		- saleBracket : 할인율 표시시 괄효 표시 여부
*/

// 비전시 그룹 이벤트 상품 정보 업데이트
function fnDisplayNoneEventItems(opts) {
	// 필터 정의
	var isImg=false, 
		isNm=false, 
		isPrc=false, 
		isSale=false, 
		isSld=false, 
		isLmt=false ,
		isBrand=false,
		isWish=false,
		isEvaluate=false,
		isSaleCoupon=false
	$(opts.fields).each(function(){
		switch(this.toString()){
			case "image" : isImg=true; break;
			case "name" : isNm=true; break;
			case "price" : isPrc=true; break;
			case "sale" : isSale=true; break;
			case "soldout" : isSld=true; break;
			case "limit" : isLmt=true; break;
			case "brand" : isBrand=true; break;
			case "wish" : isWish = true; break;
			case "evaluate" : isEvaluate = true; break;
			case "salecoupon" : isSaleCoupon = true; break;
		}
	});

	var additionalHtml = function(saleString , couponString , saleBracket) {
		saleString = (typeof saleString == "undefined") ? "" : saleString;
		couponString = (typeof couponString == "undefined") ? "" : couponString;
		
		var saleStringHtml = saleString !="" ? saleBracket !="" ? "<span class=\'sale\'>["+ saleString +"]</span>" : "<span class=\'sale\'>"+saleString+"</span>": "";
		var couponStringHtml = couponString !="" ? saleBracket !="" ? "<span class=\'coupon\'>["+ couponString +"]</span>" : "<span class=\'coupon\'>"+couponString+"</span>": "";
		var returnHtml = saleStringHtml.concat(couponStringHtml);

		return returnHtml;
	}

	$.ajax({
		type: "post",
		url: "/event/etc/json/act_getItemInfo6.asp",
		data: "arriid="+opts.items+"&unit="+opts.unit,
		cache: false,
		success: function(message) {
			if(typeof(message)=="object" && typeof(message.items)=="object") {
				let i = (opts.page - 1) * opts.page_size;
				$(message.items).each(function(){
					// 상품 이미지 출력
					if(isImg){
						$("#"+opts.target+" li .thumbnail img").eq(i).attr("src",this.imgurl);
					}

					// 브랜드명 출력
					if(isBrand){
						$("#"+opts.target+" li .brand").eq(i).html(this.brandname);
					}

					// 상품명 출력
					if(isNm){
						$("#"+opts.target+" li .name").eq(i).html(this.itemname);
						if(this.itemname.length >= 23){
							$("#"+opts.target+" li .desc").eq(i).addClass("line_02");
						}
						else{
							$("#"+opts.target+" li .desc").eq(i).addClass("line_01");
						}
					}

					// 판매가 출력
					if(isPrc){
						if(isSale){
							//할인율 표시
							if(this.saleper!="") {
								if(opts.saleBracket) {
									$("#"+opts.target+" li .price").eq(i).html("<s>"+this.orgprice+"</s> <span>" + this.sellprice + "</span><span class='sale'>["+this.saleper+"]</span>");
								} else {
									$("#"+opts.target+" li .price").eq(i).html("<s>"+this.orgprice+"</s> <span>" + this.sellprice + "</span><span class='sale'>"+this.saleper+"</span>");
								}
							} else {
								$("#"+opts.target+" li .price").eq(i).html(this.sellprice);
							}
							// 할인율 / 쿠폰 분리 표기
						}else if(isSaleCoupon) {
							if (this.itemType == "deal") {
								$("#"+opts.target+" li .price").eq(i).html("<s>"+this.orgprice+"</s> " + this.sellprice + additionalHtml(this.saleper , '' , opts.saleBracket));
							} else {
								$("#"+opts.target+" li .price").eq(i).html("<s>"+this.orgprice+"</s> " + this.sellprice + additionalHtml(this.saleString , this.couponString , opts.saleBracket));
							}
						}else{
							// 판매가 표시
							$("#"+opts.target+" li .price").eq(i).html(this.sellprice);
						}
					}

					// 품절상품 표시
					if(isSld){
						if(this.soldout=="true") {
							$("#"+opts.target+" li").eq(i).addClass("soldout");
						}
					}

					// 한정 남은갯수 표시
					if(isLmt){
						if(this.limityn=="Y") {
							$("#"+opts.target+" li .limit span").eq(i).html(this.limitRemain);
						} else {
							$("#"+opts.target+" li .limit").eq(i).hide();
						}
					}

					//위시 참여 여부 확인
					if(this.favItemID){
						$("#"+opts.target+" li .wish").eq(i).addClass("on");
					}

					// 후기평점 및 , 위시 카운트표기
					if(isWish || isEvaluate){
						if(isEvaluate && this.evalCount > 0) {
							$("#"+opts.target+" li .review").eq(i).find('i').css("width",this.totalPoint+"%");
							$("#"+opts.target+" li .review").eq(i).find('.counting').text(this.evalCount > 999 ? "999+" : this.evalCount);
						} else {
							$("#"+opts.target+" li .review").eq(i).hide();
						}
						if(isWish) {
							if(this.favCount > 0) {
								$("#"+opts.target+" li .wish").eq(i).find('i').addClass("hidden");
								$("#"+opts.target+" li .wish").eq(i).find('.counting').text(this.favCount > 999 ? "999+" : this.favCount);
							}
						}
					}

					i++;
				});
			}
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
}

// 목록형 상품 정보 업데이트
function fnApplyItemInfoList(opts) {
	// 필터 정의
	var isImg=false,
		isNm=false,
		isPrc=false,
		isSale=false,
		isSld=false,
		isLmt=false ,
		isBrand=false,
		isWish=false,
		isEvaluate=false,
		isSaleCoupon=false
	$(opts.fields).each(function(){
		switch(this.toString()){
			case "image" : isImg=true; break;
			case "name" : isNm=true; break;
			case "price" : isPrc=true; break;
			case "sale" : isSale=true; break;
			case "soldout" : isSld=true; break;
			case "limit" : isLmt=true; break;
			case "brand" : isBrand=true; break;
			case "wish" : isWish = true; break;
			case "evaluate" : isEvaluate = true; break;
			case "salecoupon" : isSaleCoupon = true; break;
		}
	});

	var additionalHtml = function(saleString , couponString , saleBracket) {
		saleString = (typeof saleString == "undefined") ? "" : saleString;
		couponString = (typeof couponString == "undefined") ? "" : couponString;

		var saleStringHtml = saleString !="" ? saleBracket !="" ? "<span class=\'sale\'>["+ saleString +"]</span>" : "<span class=\'sale\'>"+saleString+"</span>": "";
		var couponStringHtml = couponString !="" ? saleBracket !="" ? "<span class=\'coupon\'>["+ couponString +"]</span>" : "<span class=\'coupon\'>"+couponString+"</span>": "";
		var returnHtml = saleStringHtml.concat(couponStringHtml);

		return returnHtml;
	}

	$.ajax({
		type: "post",
		url: "/event/etc/json/act_getItemInfo6.asp",
		data: "arriid="+opts.items+"&unit="+opts.unit,
		cache: false,
		success: function(message) {
			if(typeof(message)=="object") {
				if(typeof(message.items)=="object") {
					var i=0;
					$(message.items).each(function(){
						// 상품 이미지 출력
						if(isImg){
							$("#"+opts.target+" li .thumbnail img").eq(i).attr("src",this.imgurl);
						}

						// 브랜드명 출력
						if(isBrand){
							$("#"+opts.target+" li .brand").eq(i).html(this.brandname);
						}

						// 상품명 출력
						if(isNm){
							$("#"+opts.target+" li .name").eq(i).html(this.itemname);
							if(this.itemname.length >= 23){
								$("#"+opts.target+" li .desc").eq(i).addClass("line_02");
							}
							else{
								$("#"+opts.target+" li .desc").eq(i).addClass("line_01");
							}
						}

						// 판매가 출력
						if(isPrc){
							if(isSale){
								//할인율 표시
								if(this.saleper!="") {
									if(opts.saleBracket) {
										$("#"+opts.target+" li .price").eq(i).html("<s>"+this.orgprice+"</s> <span>" + this.sellprice + "</span><span class='sale'>["+this.saleper+"]</span>");
									} else {
										$("#"+opts.target+" li .price").eq(i).html("<s>"+this.orgprice+"</s> <span>" + this.sellprice + "</span><span class='sale'>"+this.saleper+"</span>");
									}
								} else {
									$("#"+opts.target+" li .price").eq(i).html(this.sellprice);
								}
								// 할인율 / 쿠폰 분리 표기
							}else if(isSaleCoupon) {
								if (this.itemType == "deal") {
									$("#"+opts.target+" li .price").eq(i).html("<s>"+this.orgprice+"</s> " + this.sellprice + additionalHtml(this.saleper , '' , opts.saleBracket));
								} else {
									$("#"+opts.target+" li .price").eq(i).html("<s>"+this.orgprice+"</s> " + this.sellprice + additionalHtml(this.saleString , this.couponString , opts.saleBracket));
								}
							}else{
								// 판매가 표시
								$("#"+opts.target+" li .price").eq(i).html(this.sellprice);
							}
						}

						// 품절상품 표시
						if(isSld){
							if(this.soldout=="true") {
								$("#"+opts.target+" li").eq(i).addClass("soldout");
							}
						}

						// 한정 남은갯수 표시
						if(isLmt){
							if(this.limityn=="Y") {
								$("#"+opts.target+" li .limit span").eq(i).html(this.limitRemain);
							} else {
								$("#"+opts.target+" li .limit").eq(i).hide();
							}
						}

						//위시 참여 여부 확인
						if(this.favItemID){
							$("#"+opts.target+" li .wish").eq(i).addClass("on");
						}

						// 후기평점 및 , 위시 카운트표기
						if(isWish || isEvaluate){
							if(isEvaluate && this.evalCount > 0) {
								$("#"+opts.target+" li .review").eq(i).find('i').css("width",this.totalPoint+"%");
								$("#"+opts.target+" li .review").eq(i).find('.counting').text(this.evalCount > 999 ? "999+" : this.evalCount);
							} else {
								$("#"+opts.target+" li .review").eq(i).hide();
							}
							if(isWish) {
								if(this.favCount > 0) {
									$("#"+opts.target+" li .wish").eq(i).find('i').addClass("hidden");
									$("#"+opts.target+" li .wish").eq(i).find('.counting').text(this.favCount > 999 ? "999+" : this.favCount);
								}
							}
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