<%
snpTitle	= Server.URLEncode(vTitle)
snpLink		= Server.URLEncode("http://www.10x10.co.kr/playing/view.asp?didx="&vDIdx&"")	'### PC주소
snpPre		= Server.URLEncode("10x10 PLAYing")
snpTag 		= Server.URLEncode("텐바이텐 " & Replace(vTitle," ",""))
snpTag2 	= Server.URLEncode("#10x10")
%>
<script>
function snschk(snsnum) {
	if(snsnum=="tw"){
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
		return false;
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
		return false;
	}else if(snsnum=="pt"){
		popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=vSquareImg%>');
		return false;
	}
}
</script>
<div id="snsPlaying" class="sns">
	<ul>
		<li class="twitter"><a href="" onclick="snschk('tw'); return false;"><span></span>트위터에 공유하기</a></li>
		<li class="facebook"><a href="" onclick="snschk('fb'); return false;"><span></span>페이스북에 공유하기</a></li>
		<li class="pinterest"><a href="" onclick="snschk('pt'); return false;"><span></span>핀터레스트에 공유하기</a></li>
	</ul>
</div>