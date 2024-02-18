<script type="text/javascript">
$(function() {
	//UNB - Shopping Bag Control
	if(typeof(Storage) !== "undefined") {
		//Btn Action
		$('.util-cart').mouseover(function() {
			fnChkHeadCart();
			$(this).children('.util-layer').show();
		}).mouseleave(function() {
			$('.util-cart > .util-layer').hide();
		});
	} else {
		//Remove drop Icon
		$("#basketDropIcon").hide();
	}
});

// Check Cart Status
function fnChkHeadCart() {
	if(typeof(Storage) !== "undefined") {
		var chkCartSr = false, oCart;

		if(sessionStorage.getItem("cart")) {
			oCart = JSON.parse(sessionStorage.getItem("cart"));
			var vNowDt = new Date();
			if(TnCheckCompDate(oCart.expire,">=",vNowDt.isoDate())) {
				chkCartSr = true;
			}
			if (oCart.usrkey=='<%=chkIIF(IsUserLoginOK,request.Cookies("tinfo")("shix"),session.sessionid)%>') {
				chkCartSr = true;
			} else {
				chkCartSr = false;
			}
		}

		if(!chkCartSr) {
			fnGetHeadCartList();
		}
		if($("#lyrHdCartList").html()=="") {
			fnPrintHeadCart();
		}
	}
}

// Get Cart List
function fnGetHeadCartList() {
	if(typeof(Storage) !== "undefined") {
		$.ajax({
			url: "/common/act_shoppingbagList.asp",
			cache: false,
			async: false,
			success: function(message) {
				sessionStorage.setItem("cart", message);
				fnPrintHeadCart();
			}
			,error: function(err) {
				alert(err.responseText);
			}
		});
	}
}

// Print Cart List
function fnPrintHeadCart() {
	if(typeof(Storage) !== "undefined") {
		var vCont='<p class="tip">* 최근 담은 순으로 5개까지 보여집니다.</p>';
		var vCartCnt = 0;

		var oCart = JSON.parse(sessionStorage.getItem("cart"));
		if(oCart.list.length>0) {
			vCont += '<div class="items type-list"><ul>';

			$(oCart.list).each(function(i){
				vCont += '<li>';
				vCont += '	<a href="/shopping/category_prd.asp?itemid='+this.itemid+'">';
				vCont += '		<div class="thumbnail"><img src="'+this.image+'" alt="" /></div>';
				vCont += '		<div class="desc">';
				vCont += '			<p class="brand">'+this.brand+'</p>';
				vCont += '			<p class="name">'+this.itemname+'</p>';
				vCont += '		</div>';
				vCont += '	</a>';
				vCont += '	<button type="button" class="btn-delete" onclick="fnDelCartItem(\''+this.itemid+'\',\''+this.itemoption+'\')"><span class="icoV18">상품 삭제</span></button>';
				vCont += '</li>';
				if(i>=4) return false;
			});
			vCont += '</ul></div>';

			if(oCart.list.length>5) {
				vCont += '	<a href="" class="btn-all btn-linkV18 link4" onclick="TnGotoShoppingBag(); return false;">';
				vCont += '		장바구니 전체보기<span></span></a>';
			}

			vCartCnt = oCart.cartcnt;
		} else {
			vCont += '<div class="items type-list"><ul><li class="nodata"><p>장바구니에 담긴 상품이 없습니다.</li></ul></div>';
		}
		$("#lyrHdCartList").html(vCont);
		$("#ibgaCNT").html(vCartCnt);
	}
}

// Reset Cart List
function fnDelCartAll() {
	if(typeof(Storage) !== "undefined") {
		sessionStorage.removeItem("cart");
	}
}

// Delete Cart Item
function fnDelCartItem(iid,iop){
	if(confirm("상품을 장바구니에서 삭제하시겠습니까?")) {
		$.ajax({
			type:"POST",
			url: "/common/act_shoppingbag_Proc.asp",
			data: "mode=del&itemid="+iid+"&itemoption="+iop,
			cache: false,
			success: function(message) {
				if(message=="1") {
					fnGetHeadCartList();
				} else {
					alert("처리중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
				}
			}
			,error: function(err) {
				alert(err.responseText);
			}
		});
	}
}
</script>

<div class="util-layer" id="lyrHdCartList"></div>