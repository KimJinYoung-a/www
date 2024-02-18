$(function(){
	CallHappyTogether();
});


function CallHappyTogether() {
	$.ajax({
		url: "act_happyTogether.asp",
		cache: false,
		async: false,
		success: function(vRst) {
			if(vRst!="") {
				$("#lyrHPTgr").empty().html(vRst);
		    }
			else {
				$('.happyTogether').hide();
			}
		}
		,error: function(err) {
			//alert(err.responseText);
			$('.happyTogether').hide();
		}
	});
}