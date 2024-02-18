<%
Dim cCa5comma, vCa5Directer, vCate5Img(5), vCate5Copy(5), fc5
SET cCa5comma = New CPlay
cCa5comma.FRectDIdx = vDIdx
cCa5comma.sbPlayCommaDetail
vCa5Directer = cCa5comma.FOneItem.Fdirecter
SET cCa5comma = Nothing

For fc5=1 To 5
	vCate5Img(fc5)	= fnPlayImageSelectSortNo(vImageList,vCate,"14","i","0",fc5)
	vCate5Copy(fc5)	= fnPlayImageSelectSortNo(vImageList,vCate,"14","c","0",fc5)
Next
%>
<div class="article playDetailV16 comma">
	<div class="cont">
		<div id="cover" class="hgroup cover" style="background-image:url(<%=fnPlayImageSelect(vImageList,vCate,"12","i")%>);">
			<div>
				<!--<a href="list.asp?cate=5" class="corner">COMMA,</a>//-->
				!NSPIRATION
				<h2><%=vTitleStyle%></h2>
			</div>
		</div>
		<div id="detail" class="detail">
			<h3><%=vSubCopy%></h3>
			<div class="textarea">
				<div class="desc">
					<div class="figure"><img src="<%=vCate5Img(1)%>" alt="" /></div>
					<p><%=vCate5Copy(1)%></p>
				</div>
				<div id="masonry" class="masonry">
					<%
					For fc5=2 To 5
						If vCate5Img(fc5) <> "" Then
					%>
						<div class="desc">
							<div class="figure"><img src="<%=vCate5Img(fc5)%>" alt="" /></div>
							<p><%=vCate5Copy(fc5)%></p>
						</div>
					<%
						End If
					Next
					%>
				</div>
				<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
				<script type="text/javascript">
				$(function(){
					/* masonry */
					$("#masonry img").load(function(){
						$("#masonry").masonry({
							itemSelector: '.desc'
						});
					});
					$("#masonry").masonry({
						itemSelector: ".desc",
						isRTL: false
					});
				});
				</script>
			</div>
		</div>
	</div>
	<% If fnPlayImageSelect(vImageList,vCate,"15","i") <> "" Then %>
	<div class="bnr">
		<a href="<%=fnPlayImageSelect(vImageList,vCate,"15","l")%>"><img src="<%=fnPlayImageSelect(vImageList,vCate,"15","i")%>" alt="" /></a>
	</div>
	<% End If %>
	<!-- #include file="./inc_sns.asp" -->
	<div class="listMore">
		<div class="more">
			<h2>다른 !NSPIRATION 보기</h2>
			<a href="list.asp?cate=inspi">more</a>
		</div>
		<!-- #include file="./inc_listmore.asp" -->
	</div>

</div>