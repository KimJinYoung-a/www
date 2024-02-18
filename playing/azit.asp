<%
Dim cCa3azit, vCate3EntryCont, vCate3EntrySDate, vCate3EntryEDate, vCate3AnnounDate, vCate3Notice, vPlayAzitList, vCate3EntryMethod
Dim vCate3Ptitle(4), vCate3Pjuso(4), vCate3Plink(4), vCate3PImg(20), vCate3PCopy(20), fc3, p3, l3, tmp3, vCate3PlaceImg, vCate3PlaceCSS
SET cCa3azit = New CPlay
cCa3azit.FRectDIdx = vDIdx
cCa3azit.sbPlayAzitDetail

tmp3 = 0
vCate3EntryCont		= cCa3azit.FOneItem.FCate3EntryCont
If cCa3azit.FOneItem.FCate3EntrySDate <> "" Then
	vCate3EntrySDate		= Right(FormatDate(cCa3azit.FOneItem.FCate3EntrySDate,"0000.00.00"),5)
End If
If cCa3azit.FOneItem.FCate3EntryEDate <> "" Then
	vCate3EntryEDate		= Right(FormatDate(cCa3azit.FOneItem.FCate3EntryEDate,"0000.00.00"),5)
End If
If cCa3azit.FOneItem.FCate3AnnounDate <> "" Then
	vCate3AnnounDate		= Right(FormatDate(cCa3azit.FOneItem.FCate3AnnounDate,"0000.00.00"),5)
End If
vCate3Notice			= cCa3azit.FOneItem.FCate3Notice
vCate3EntryMethod		= cCa3azit.FOneItem.FCate3EntryMethod
vPlayAzitList			= cCa3azit.FPlayAzipList

For p3=1 To 4
	vCate3Ptitle(p3)	= fnPlayAzitSelect(vPlayAzitList,p3,"1")
	vCate3Pjuso(p3)	= fnPlayAzitSelect(vPlayAzitList,p3,"2")
	vCate3Plink(p3)	= fnPlayAzitSelect(vPlayAzitList,p3,"3")
	
	For l3=1 To 5
		tmp3 = tmp3 + 1
		vCate3PImg(tmp3)		= fnPlayImageSelectSortNo(vImageList,vCate,"7","i",p3,l3)
		vCate3PCopy(tmp3)	= fnPlayImageSelectSortNo(vImageList,vCate,"7","c",p3,l3)
	Next
Next
SET cCa3azit = Nothing
%>
<div class="article playDetailV16 azit">
	<div class="cont">
		<div id="cover" class="hgroup cover" style="background-image:url(<%=fnPlayImageSelect(vImageList,vCate,"19","i")%>);">
			<div>
				<!--<a href="list.asp?cate=3" class="corner">AZIT&amp;</a>//-->
				TALK
				<h2><%=vTitleStyle%></h2>
				<p><%=vSubCopy%></p>
			</div>
		</div>
		<div class="detail">
			<!-- for dev msg : 장소는 최대 4개까지 입력할 수 있습니다. slide js는 id값 placeRolling1, placeRolling2, placeRolling3, placeRolling4 -->
			
			
			<%
			tmp3 = 0
			For p3=1 To 4
				vCate3PlaceImg = ""
				If vCate3Ptitle(p3) <> "" Then
			%>
				<div class="place type<%=CHKIIF((p3 mod 2)=1,"A","B")%>">
					<div class="textarea">
						<h3><span>0<%=p3%></span><%=vCate3Ptitle(p3)%></h3>
						<%
						For l3=1 To 5
							tmp3 = tmp3 + 1
						%>
							<% If l3 < 5 Then %>
								<p><%=vCate3PCopy(tmp3)%></p>
							<% End If %>
							<% If l3 = 5 Then %>
								<p class="last"><a href="<%=vCate3Plink(p3)%>" target="_blank" title="새창" class="address"><span><%=vCate3Pjuso(p3)%></span></a></p>
							<% End If %>
						<%
							vCate3PlaceImg = vCate3PlaceImg & "<div><img src="""&vCate3PImg(tmp3)&""" alt="""" /></div>"
							vCate3PlaceCSS = vCate3PlaceCSS & "$(""#placeRolling"&p3&" .slidesjs-pagination li"").eq("&l3-1&").children(""a"").css(""background-image"", ""url("&getThumbImgFromURL(vCate3PImg(tmp3),"105","83","true","false")&")"");" & vbCrLf
						Next %>
					</div>

					<div class="rolling">
						<div id="placeRolling<%=p3%>" class="slide">
						<%=vCate3PlaceImg%>
						</div>
					</div>
				</div>
			<%
				End If
			Next
			%>
			<script type="text/javascript">
			$(function(){
				/* slide js */
				$("#placeRolling1").slidesjs({
					width:"560",
					height:"463",
					pagination:{effect:"fade"},
					navigation:false,
					play:false,
					effect:{fade: {speed:300, crossfade:true}}
				});

				$("#placeRolling2").slidesjs({
					width:"560",
					height:"463",
					pagination:{effect:"fade"},
					navigation:false,
					play:false,
					effect:{fade: {speed:300, crossfade:true}}
				});

				$("#placeRolling3").slidesjs({
					width:"560",
					height:"463",
					pagination:{effect:"fade"},
					navigation:false,
					play:false,
					effect:{fade: {speed:300, crossfade:true}}
				});

				$("#placeRolling4").slidesjs({
					width:"560",
					height:"463",
					pagination:{effect:"fade"},
					navigation:false,
					play:false,
					effect:{fade: {speed:300, crossfade:true}}
				});

				$(".place .slide .slidesjs-pagination li a").append('<span></span>');

				<%=vCate3PlaceCSS%>

				/* mouse control */
				$("#placeRolling1 .slidesjs-pagination li a").mouseenter(function(){
					$('#placeRolling1 .slidesjs-pagination li a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
				});
				$("#placeRolling2 .slidesjs-pagination li a").mouseenter(function(){
					$('#placeRolling2 .slidesjs-pagination li a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
				});
				$("#placeRolling3 .slidesjs-pagination li a").mouseenter(function(){
					$('#placeRolling3 .slidesjs-pagination li a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
				});
				$("#placeRolling4 .slidesjs-pagination li a").mouseenter(function(){
					$('#placeRolling4 .slidesjs-pagination li a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
				});
			});
			</script>
		</div>

		<% If vCate3EntryMethod = "c" Then %>
			<!-- #include file="./azit_comment.asp" -->
		<% Else %>
		<div class="summary">
			<div class="desc" style="background-color:#cac7bb;">
				<p class="msg"><%=vCate3EntryCont%></p>
				<p class="date">응모기간 : <%=vCate3EntrySDate%> ~ <%=vCate3EntryEDate%> <span>|</span> 발표 : <%=vCate3AnnounDate%></p>
				<div class="btnLink">
					<a href="https://www.instagram.com/explore/tags/%ED%85%90%EB%B0%94%EC%9D%B4%ED%85%90%EC%95%84%EC%A7%80%ED%8A%B8%EC%97%94/" target="_blank"><span>AZIT&amp; 올리러 가기</span></a>
				</div>
			</div>
			<div class="noti">
				<ul>
					<%=Replace(vCate3Notice,vbCrLf,"<br />")%>
				</ul>
			</div>
		</div>
		<% End If %>
	</div>
	<!-- #include file="./inc_sns.asp" -->
	<div class="listMore">
		<div class="more">
			<h2>다른 TALK 보기</h2>
			<a href="list.asp?cate=talk">more</a>
		</div>
		<!-- #include file="./inc_listmore.asp" -->
	</div>
</div>