<link rel="stylesheet" type="text/css" href="/lib/css/diary2020.css?v=1.27">
<script>
$(function() {
	//공통 tab-menu
	$('.tab-menu').find('li').click(function() {
		$(this).addClass('on').siblings().removeClass('on')
		return false;
	})

	//랭킹 디자인 효과
	$('.num-rolling').append('<svg><circle cx="21.5" cy="21.5" stroke="#ffe400" r="21" fill="none" stroke-width="2" stroke-miterlimit="10"></circle></svg>')

	var conT = $(".container").offset().top;
	$(window).scroll(function(){
		var y = $(window).scrollTop();
		if ( conT < y ) {
			$(".container").addClass("is-fixed");
		} else {
			$(".container").removeClass("is-fixed");
		}
	});
})
</script>
<div class="diary-header">
	<div class="inner">
		<a href="/diarystory2020/"><h2>DIARY STORY 2020</h2></a>
		<ul class="diary-menu">
			<li class="<%=chkiif(instr(request.ServerVariables("SCRIPT_NAME"),"index.asp") > 0,"on","")%>"><a href="/diarystory2020/" onclick="fnAmplitudeEventAction('click_diary_gnbmenu','gnb_name','home');">홈</a></li>
			<li class="<%=chkiif(instr(request.ServerVariables("SCRIPT_NAME"),"exhibition.asp") > 0,"on","")%>"><a href="/diarystory2020/exhibition.asp" onclick="fnAmplitudeEventAction('click_diary_gnbmenu','gnb_name','diaryevent');">기획전</a></li>
			<li class="<%=chkiif(instr(request.ServerVariables("SCRIPT_NAME"),"daccu_ranking.asp") > 0,"on","")%>"><a href="/diarystory2020/daccu_ranking.asp" onclick="fnAmplitudeEventAction('click_diary_gnbmenu','gnb_name','daccu_ranking');">다꾸랭킹</a></li>
			<li class="<%=chkiif(instr(request.ServerVariables("SCRIPT_NAME"),"daccutv.asp") > 0,"on","")%>"><a href="/diarystory2020/daccutv.asp" onclick="fnAmplitudeEventAction('click_diary_gnbmenu','gnb_name','daccutv');">다꾸티비</a></li>
			<li class="<%=chkiif(instr(request.ServerVariables("SCRIPT_NAME"),"daccu_toktok.asp") > 0,"on","")%>"><a href="/diarystory2020/daccu_toktok.asp" onclick="fnAmplitudeEventAction('click_diary_gnbmenu','gnb_name','daccutalktalk');">다꾸톡톡</a></li>
			<li class="diary-sch"><a href="/diarystory2020/search.asp" onclick="fnAmplitudeEventAction('click_diary_gnbmenu','gnb_name','search');">다이어리 찾기</a></li>
		</ul>
	</div>
</div>
