$(function(){
	CallHappyTogether();
});

/*
function CallHappyTogether() {
	$.ajax({
		url: "act_happyTogether.asp?itemid="+vIId+"&disp="+vDisp,
		cache: false,
		async: false,
		success: function(vRst) {
			if(vRst!="") {
				$("#rcmdPrd02").empty().html(vRst);
				$(".itemNaviV15 .item01 a").addClass("on");
				$(".itemNaviV15 .item02 a").removeClass("on");
				$("#rcmdPrd01").show();
				$("#rcmdPrd02").hide();
				$("#rcmdPrd03").hide();
		    }
		}
		,error: function(err) {
			//alert(err.responseText);
			$('.recommendItemV15').show().find('.itemNaviV15 .item02').hide();
		}
	});
}
*/

function CallHappyTogether() {
	$.ajax({
		url: "act_happyTogether_skyer9.asp?itemid="+vIId+"&disp="+vDisp,
		cache: false,
		async: false,
		success: function(vRst) {
			if(vRst!="") {
				$("#rcmdPrd").empty().html(vRst);
		    }
		}
		,error: function(err) {
			//alert(err.responseText);
			$('#rcmdPrd').hide();
		}
	});
}
