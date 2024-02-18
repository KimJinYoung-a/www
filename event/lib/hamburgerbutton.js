
$(function(){
    $("#navFashion").css({"margin-left":"300px", "opacity":"0"});
    $("#navFashion *").css({"opacity":"0"});
    $("#hamburger").click(function(){
        if ($(this).hasClass("open")){
            $("#navFashion").hide();
            $("#navFashion").delay(100).animate({"margin-left":"300px", "opacity":"0"},300);
            $("#navFashion *").animate({"opacity":"0"},300);
            $(this).removeClass("open");
        } else {
            $("#navFashion").show();
            $("#navFashion").delay(100).animate({"margin-left":"103px", "opacity":"1"},300);
            $("#navFashion *").animate({"opacity":"1"},300);
            $(this).addClass("open");
        }
        return false;
    });
});

function fnGetListHeader(pg , ecode , evtkind) {
	var str = $.ajax({
		type: "GET",
		url: "/event/lib/hamburgerbutton.asp",
		data: "eventid="+ ecode +"&page="+pg+"&evt_kind="+evtkind,
		dataType: "text",
		async: false
	}).responseText;
	if(str!="") {
        $("#FMHeaderNew").empty().html(str);
        $("#navFashion").hide();
	}
}

function goLayerPage(pg , ecode , evtkind) {
	var str = $.ajax({
		type: "GET",
		url: "/event/lib/hamburgerbutton.asp",
		data: "eventid="+ ecode +"&page="+pg+"&evt_kind="+evtkind,
		dataType: "text",
		async: false
	}).responseText;
	if(str!="") {
		$("#FMHeaderNew").empty().html(str);
		$("#navFashion").show();
		$("#dimmed").show();
		$(this).addClass("open");
	}
}