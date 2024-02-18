<%
Dim cCa31comma, vCa31Directer, vCate31Img(5), vCate31Copy(5), fc31
SET cCa31comma = New CPlay
cCa31comma.FRectDIdx = vDIdx
cCa31comma.sbPlayCommaDetail
vCa31Directer = cCa31comma.FOneItem.Fdirecter
SET cCa31comma = Nothing

For fc31=1 To 5
	vCate31Img(fc31)	= fnPlayImageSelectSortNo(vImageList,vCate,"25","i","0",fc31)
	vCate31Copy(fc31)	= fnPlayImageSelectSortNo(vImageList,vCate,"25","c","0",fc31)
Next
%>
<div class="article playDetailV16 comma">
	<div class="cont">
		<div id="cover" class="hgroup cover" style="background-image:url(<%=fnPlayImageSelect(vImageList,vCate,"23","i")%>);">
			<div>
				<!--<a href="list.asp?cate=5" class="corner">COMMA,</a>//-->
				TALK
				<h2><%=vTitleStyle%></h2>
			</div>
		</div>
		<div id="detail" class="detail">
			<h3><%=vSubCopy%></h3>
			<div class="textarea">
				<div class="desc">
					<div class="figure"><img src="<%=vCate31Img(1)%>" alt="" /></div>
					<p><%=vCate31Copy(1)%></p>
				</div>
				<div id="masonry" class="masonry">
					<%
					For fc31=2 To 5
						If vCate31Img(fc31) <> "" Then
					%>
						<div class="desc">
							<div class="figure"><img src="<%=vCate31Img(fc31)%>" alt="" /></div>
							<p><%=vCate31Copy(fc31)%></p>
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
	<% If fnPlayImageSelect(vImageList,vCate,"26","i") <> "" Then %>
	<div class="bnr">
		<a href="<%=fnPlayImageSelect(vImageList,vCate,"26","l")%>"><img src="<%=fnPlayImageSelect(vImageList,vCate,"26","i")%>" alt="" /></a>
	</div>
	<% End If %>
	<!-- #include file="./inc_sns.asp" -->
	<div class="listMore">
		<div class="more">
			<h2>다른 TALK 보기</h2>
			<a href="list.asp?cate=talk">more</a>
		</div>
		<!-- #include file="./inc_listmore.asp" -->
	</div>

</div>