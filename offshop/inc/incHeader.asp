<%
'매장 리스트 가져오기
Dim offshoplist, ix, menuid, arrMainGallery, offshopMainGallery
menuid = requestCheckVar(request("menuid"),1)
If menuid="" Then menuid=1
Set  offshoplist = New COffShop
offshoplist.GetOffShopList

Set  offshopMainGallery = New COffShopGallery
offshopMainGallery.FShopId=shopid
arrMainGallery = offshopMainGallery.fnGetShopMainGallery
%>
<style>
@font-face {
 font-family:'Noto Sans KR';
 font-style:normal;
 font-weight:300;
 src:url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff2) format('woff2'),
 url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff) format('woff'),
 url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.otf) format('opentype');
}
</style>
<script type="text/javascript">
$(function(){
	$('.gnb-wrap').hide();

	// open ly-offshop-list
	$('.offshop-name').click(function(){
		$('.ly-offshop-list').fadeIn(400)

		$(window).resize(function(){
			var bodyH = $('body').height();
			var browserH = $(window).height();
			var listH = $('.ly-offshop-list ul').height();
			$('.ly-offshop-list ul').css('margin-top',-listH/2);
			if (listH < browserH){
				$('.ly-offshop-list').css('height','100%');
				stoppedScroll();
			} else {
				$('.ly-offshop-list').css('height',bodyH);
				freeScroll();
			}
		}).resize();
	});

	// close ly-offshop-list
	$('.ly-offshop-list').click(function(){
		$('.ly-offshop-list').fadeOut(400);
		freeScroll();
	});
	$('.ly-offshop-list li a').click(function(){
		event.preventDefault();
		$('.ly-offshop-list').fadeOut(400);
		freeScroll();
	});
});

// free Scroll
function freeScroll(){
	$('html, body').css({'overflow':'auto', 'height':'auto'});
	$('.offshopV18').off('scroll mousewheel');
}

// stoped scroll
function stoppedScroll(){
	$('html, body').css({'overflow':'hidden', 'height':'100%'});
	$('.offshopV18').on('scroll touchmove mousewheel', function(event) {
		event.preventDefault();
		return false;
	});
}

// close layer
function closeLy(){
	$('.ly-offshop').hide();
	freeScroll();
}

function fnMoveShop(shopid){
location.href="/offshop/index.asp?shopid="+shopid;
}
</script>
<!-- header -->
<div class="offshop-header">
	<div class="offshop-name"><%=offshopinfo.FOneItem.FShopName%><i class="arrow"></i></div>
	<div class="offshop-gnb">
		<ul>
			<li class="offshop-info<% If menuid="1" Then %> current<% End If %>"><a href="/offshop/?shopid=<%=shopid%>&menuid=1">매장정보</a></li> <!-- for dev msg 현재 탭에 current -->
			<li class="offshop-noti<% If menuid="2" Then %> current<% End If %>"><a href="/offshop/shopnotice.asp?shopid=<%=shopid%>&menuid=2">공지&#47;이벤트</a></li>
			<li class="offshop-qna<% If menuid="3" Then %> current<% End If %>"><a href="/offshop/shopqna.asp?shopid=<%=shopid%>&menuid=3">질문과답변</a></li>
			<li class="offshop-qna<% If menuid="4" Then %> current<% End If %>"><a href="/offshop/shopsketch.asp?shopid=<%=shopid%>&menuid=4">매장스케치</a></li>
		</ul>
	</div>
</div>
<!--// header -->

<!-- ly-offshop list -->
<div class="ly-offshop-list">
	<% If offshoplist.FResultCount >0 Then %>
	<ul>
		<% For ix=0 To offshoplist.FResultCount-1 %>
		<% If shopid=offshoplist.FItemList(ix).FShopID Then %><li class="current" onclick="fnMoveShop('<%=offshoplist.FItemList(ix).FShopID%>');"><% Else %><li onclick="fnMoveShop('<%=offshoplist.FItemList(ix).FShopID%>');"><% End If %><a href="javascript:void(0);"><span class="icoV18"></span><%=offshoplist.FItemList(ix).FShopName%></a></li>
		<% Next %>
	</ul>
	<% End If %>
	<div class="ly-bg-offshop" onClick="closeLy()"></div>
</div>
<!--// ly-offshop list -->
<%
Set  offshoplist = Nothing
Set  offshopMainGallery = Nothing
%>