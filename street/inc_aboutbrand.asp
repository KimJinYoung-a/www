<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<script type="text/javascript">
	$(function() {
		// ABOUT BRAND
		$('.aboutBrandV15 h4').click(function(){
			$('.brandInfoV15').toggle();
			$(this).toggleClass('open');
		});
		$('.brandInfoV15 .closeLayer').click(function(){
			$('.brandInfoV15').hide();
		});

		<%
		'//상단 백그라운드 이미지
		If bgImageURL <> "" Then
		%>
			<% IF application("Svr_Info")="Dev" THEN %>
				$('.customBgUse .brandNavV15').css('background', 'url(<%=bgImageURL%>) center no-repeat');
			<% ELSE %>
				$('.customBgUse .brandNavV15').css('background', 'url(<%=bgImageURL%>) center no-repeat');
			<% End IF %>
		<% End If %>
		$('.customBgUse .brandNavV15').css('background-size', 'cover');

		<%
		'//브랜드 메인에서 타고 들어온 경우 헬로우 브랜드 펼쳐짐
		if InStr(refer,"10x10.co.kr/street/index.asp")>0 then
		%>
			$('.brandInfoV15').toggle();
			$('.aboutBrandV15 h4').toggleClass('open');
		<% end if %>
	});
</script>
<%
'//해당 브랜드가 헬로우 노출 권한이 있을때만 뿌림
If hello_yn="Y" Then
	if Designis<>"" or StoryContent<>"" or philosophyContent<>"" or brandTag<>"" or samebrand<>"" then
%>
		<div class="wFixV15">
			<h4>ABOUT BRAND</h4>
			<div class="brandInfoV15">
				<span class="arrow"></span>
	
				<% If Designis <> "" Then %>
					<dl class="aboutContV15 tPad0">
						<dt><img src="http://fiximage.10x10.co.kr/web2015/brand/tit_design_is.png" alt="DESIGN IS" /></dt>
						<dd>
							<p><dfn><strong><%= Designis %></strong></dfn></p>
						</dd>
					</dl>
				<% end if %>
				
				<% If StoryContent <> "" Then %>
					<dl class="aboutContV15">
						<dt><img src="http://fiximage.10x10.co.kr/web2015/brand/tit_brand_story.png" alt="BRAND STORY" /></dt>
						<dd>
							<% If StoryTitle <> "" Then %>
								<p><dfn><strong><%= StoryTitle %></strong></dfn></p>
							<% end if %>
	
							<p class="tPad03"><%= StoryContent %></p>
						</dd>
					</dl>
				<% end if %>
				
				<% If philosophyContent <> "" Then %>
					<dl class="aboutContV15">
						<dt><img src="http://fiximage.10x10.co.kr/web2015/brand/tit_philosophy.png" alt="PHILOSOPHY" /></dt>
						<dd>
							<% If philosophyTitle <> "" Then %>
								<p><dfn><strong><%= philosophyTitle %></strong></dfn></p>
							<% end if %>
	
							<p class="tPad03"><%= philosophyContent %></p>
						</dd>
					</dl>
				<% end if %>
	
				<div class="aboutContV15 brandGuideV15">
					<% If brandTag <> "" Then %>
						<%
						If right(brandTag,1) = "," Then
							brandTag = left(brandTag,len(brandTag)-1)				
						End If
						
						Dim splitBrandTag, bt
						splitBrandTag = Split(brandTag, ",")
						%>
						<dl class="tagView">
							<dt>BRAND TAG</dt>
							<dd>
								<ul>
									<% For bt = 0 to Ubound(splitBrandTag) %>
									<li><span><a href="/street/index.asp?paraTxt=<%=Server.urlEncode(trim(splitBrandTag(bt)))%>"><%= splitBrandTag(bt) %></a></span></li>
									<% Next %>
								</ul>
							</dd>
						</dl>
					<% end if %>
					
					<% If samebrand <> "" Then %>
						<%
						Dim samebrandlist, arrRows, sb
						SET samebrandlist = new cHello
							samebrandlist.FRectMakerid = makerid
							arrRows = samebrandlist.fnHelloSameBrandlist
						%>
						<dl>
							<dt>SIMILAR BRAND</dt>
							<dd class="similarV15">
								<% For sb = 0 to Ubound(arrRows,2) %>
								<a href="/street/street_brand.asp?makerid=<%= arrRows(1,sb) %>"><%= arrRows(2,sb) %>&nbsp;<%= arrRows(3,sb) %></a>&nbsp;<%= chkiif( sb <> Ubound(arrRows,2), "/","")%>
								<% Next %>
							</dd>
						</dl>
						<% Set samebrandlist = nothing %>
					<% end if %>
				</div>
				<button class="closeLayer"><img src="http://fiximage.10x10.co.kr/web2015/brand/btn_close_layer.gif" alt="닫기" /></button>
			</div>
		</div>
	<% end if %>
<% end if %>