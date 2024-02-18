<%
'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg

dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode("[텐바이텐] 터져라 포텐!")
snpLink = Server.URLEncode("http://www.10x10.co.kr/event/4ten/")
snpPre = Server.URLEncode("10x10 이벤트")

'기본 태그
snpTag = Server.URLEncode("텐바이텐")
snpTag2 = Server.URLEncode("#10x10")
%>
<!-- sns -->
<div class="fourtenSns">
	<div class="ftContent">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/bnr_fourten_sns.png" alt="친구와 함께 4월의 텐바이텐을 즐기면 기쁜 두배!" /></p>
		<button type="button" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>'); return false;" class="ktShare"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/btn_white.png" alt="트위터 공유" /></button>
		<button type="button" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;" class="fbShare"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/btn_white.png" alt="페이스북 공유" /></button>
	</div>
</div>
