<link rel="stylesheet" type="text/css" href="/lib/css/diary2021.css">
<script>
$(window).load(function(){
	var menuTab = $(".diary-header").offset().top;
	$(window).scroll(function(){
		if ( $(window).scrollTop() >= menuTab ) {
			$(".container").addClass("is-fixed");
		} else {
			$(".container").removeClass("is-fixed");
		}
	});
});
</script>
<div class="diary-header">
	<div class="inner">
		<h2><a href="/diarystory2022/">텐텐문구점</a></h2>
		<ul class="diary-menu">
			<li class="<%=chkiif(instr(request.ServerVariables("SCRIPT_NAME"),"index.asp") > 0,"on","")%>"><a href="/diarystory2022/" onclick="fnAmplitudeEventAction('click_diary_gnbmenu','gnb_name','home');">홈</a></li>
			<li class="<%=chkiif(instr(request.ServerVariables("SCRIPT_NAME"),"exhibition.asp") > 0,"on","")%>"><a href="/diarystory2022/exhibition.asp" onclick="fnAmplitudeEventAction('click_diary_gnbmenu','gnb_name','diaryevent');">기획전</a></li>
			<li class="<%=chkiif(instr(request.ServerVariables("SCRIPT_NAME"),"daccu_toktok.asp") > 0,"on","")%>"><a href="/diarystory2022/daccu_toktok.asp" onclick="fnAmplitudeEventAction('click_diary_gnbmenu','gnb_name','daccutalktalk');">다꾸톡톡</a></li>
			<!--<li class="<%=chkiif(instr(request.ServerVariables("SCRIPT_NAME"),"daccutv.asp") > 0,"on","")%>"><a href="/diarystory2020/daccutv.asp" onclick="fnAmplitudeEventAction('click_diary_gnbmenu','gnb_name','daccutv');">다꾸티비</a></li>-->
		</ul>
	</div>
</div>