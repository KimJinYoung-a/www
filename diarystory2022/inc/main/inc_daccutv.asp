<script>
$(function() {
    // video-list
	getList();
})

function getList() {
	var str = $.ajax({
			type: "GET",
			url: "/diarystory2022/lib/act_daccutv.asp",
			data: $("#listfrm").serialize(),
			dataType: "text",
			async: false
	}).responseText;

	if(str!="") {
		($("#listfrm input[name='cpg']").val()=="1") ? $('#vodLists').empty().html(str) : $('#vodLists').append(str);
		isloading=false;
	}
}
</script>
<section class="sect-tv">
    <h2><a href="/diarystory2020/daccutv.asp"><span class="sub">그래서 다꾸 그거 어떻게 하는거라고요?</span>도와줘요! 다꾸TV</a></h2>
    <div class="tv_list" id="vodLists"></div>
	<a href="/diarystory2020/daccutv.asp" class="btn-gp">다꾸TV 전체보기</a>
	<div class="ly-clap">
		<div class="ly-clap-inner">
			<div class="dots dots1"></div>
			<div class="dots dots2"></div>
			<div class="dots dots3"></div>
			<div class="dots dots4"></div>
			<div class="dots dots5"></div>
			<div class="dots dots6"></div>
			<div class="dots dots7"></div>
			<div class="dots dots8"></div>
			<div class="hand"></div>
			<div class="heart"><i></i></div>
		</div>
		<div class="mask"></div>
	</div>
</section>
<form id="listfrm" name="listfrm" method="get" style="margin:0px;">
	<input type="hidden" name="cpg" value="1" />				
	<input type="hidden" name="sortMet" value="1" />
</form>