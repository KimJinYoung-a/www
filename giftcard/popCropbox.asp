<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	dim tmpUpFile
	tmpUpFile = staticImgUrl & "/giftcard/temp/" & Request("fnm")
	
%>
<link rel="stylesheet" type="text/css" href="/lib/css/jquery.cropbox.css" />
<script type="text/javascript" src="/lib/js/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.cropbox.min.js"></script>
<script type="text/javascript" defer>
$(function() {
	$('.cropimage').each(function() {
		var image = $(this),
		cropwidth = image.attr('cropwidth'),
		cropheight = image.attr('cropheight'),
		results = image.next('.results' ),
		x = $('.cropX', results),
		y = $('.cropY', results),
		w = $('.cropW', results),
		h = $('.cropH', results),
		download = results.next('.download').find('a');

		image.cropbox( {width: cropwidth, height: cropheight, showControls: 'auto' } )
		.on('cropbox', function( event, results, img ) {
			$("#fileCrpX").val(results.cropX);
			$("#fileCrpY").val(results.cropY);
			$("#fileCrpW").val(results.cropW);
			$("#fileCrpH").val(results.cropH);
		});
	});
});
</script>
<div class='window'>
	<div class="lyCropimage">
		<p class="instruction">드래그를 이용해 사진 영역을 지정해주세요</p>
		<div class="cropWrap">
			<img class="cropimage" src="<%=tmpUpFile%>?rv=<%=FormatDate(now,"00000000000000")%>" cropwidth="454" cropheight="275" alt="" />
		</div>
		<div class="btnGroupV15a">
			<button type="button" onclick="fnCheckCropProc();" class="btn btnB3 btnRed btnW185">등록</button>
			<button type="button" onclick="ClosePopLayer();" class="btn btnB3 btnGry btnW185">취소</button>
		</div>
	</div>
</div>