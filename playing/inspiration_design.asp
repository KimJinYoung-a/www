<%
Dim fc2, vCate2Img(5), vInspiImgCd, vInspiImgBody
If vCate = "21" Then
	vInspiImgCd = "4"
ElseIf vCate = "22" Then
	vInspiImgCd = "5"
End If

For fc2=1 To 5
	vCate2Img(fc2) = fnPlayImageSelectSortNo(vImageList,vCate,vInspiImgCd,"i","0",fc2)
Next

For fc2=1 To 5
	If vCate2Img(fc2) <> "" Then
		vInspiImgBody = vInspiImgBody & "<div><img src=""" & vCate2Img(fc2) & """ width=""640"" height=""810"" alt="""" /></div>" & vbCrLf
	End If
Next
%>
<div class="article playDetailV16 inspiration">
	<div class="cont" style="background-color:#<%=vBGColor%>;">
		<div class="detail">
			<div id="hgroup" class="hgroup">
				<div>
					<!--<a href="list.asp?cate=2" class="corner"></a>//-->
					!NSPIRATION
					<h2><%=vTitleStyle%></h2>
					<div class="textarea">
						<p><%=Replace(vSubCopy,vbCrLf,"<br>")%></p>
						<p class="pageview"><b><%=FormatNumber(vViewCntW+vViewCntM+vViewCntA,0)%>명</b>이 이 페이지를 보았습니다.</p>
					</div>
				</div>
			</div>
			<script type="text/javascript">
				$(function(){
					$(".inspiration #hgroup").css({top:"50%", margin:"-"+($(".inspiration #hgroup").height() / 2)+"px 0 0 0"+"px"});
				});
			</script>
			<div class="rolling">
				<div id="slide" class="slide">
					<%=vInspiImgBody%>
				</div>
			</div>
			<script type="text/javascript">
				$(function(){
					/* slide js */
					if ($("#slide > div").length > 1) {
						$("#slide").slidesjs({
							width:"640",
							height:"810",
							pagination:{effect:"fade"},
							navigation:false,
							play:{interval:4000, effect:"fade", auto:true},
							effect:{fade: {speed:1200, crossfade:true}}
						});
					}

					$("#slide .slidesjs-pagination li a").text("01");
					$("#slide .slidesjs-pagination li:nth-child(2) a").text("02");
					$("#slide .slidesjs-pagination li:nth-child(3) a").text("03");
					$("#slide .slidesjs-pagination li:nth-child(4) a").text("04");
					$("#slide .slidesjs-pagination li:nth-child(5) a").text("05");
				});
			</script>
		</div>
	</div>
	<%
	Dim cCa2item
	SET cCa2item = New CPlay
	cCa2item.FRectDIdx = vDIdx
	cCa2item.fnPlayItemList
	
	If cCa2item.FResultCount > 0 Then
	%>
	<div class="listItemV16">
		<h3>관련 상품 보기</h3>
		<ul>
			<% For fc2 = 0 To cCa2item.FResultCount - 1 %>
			<li>
				<a href="/shopping/category_prd.asp?itemid=<%=cCa2item.FItemList(fc2).FItemID%>&gaparam=playing_<%=vCate%>_<%=vDIdx%>">
					<div class="pPhoto"><img src="<%=cCa2item.FItemList(fc2).FImageList120 %>" alt="" /></div>
					<div class="pdtCont">
						<p class="pBrand"><%=cCa2item.FItemList(fc2).FBrandName%></p>
						<p class="pName"><%=cCa2item.FItemList(fc2).FItemName%></p>
						<div class="pPrice"><% = FormatNumber(cCa2item.FItemList(fc2).getRealPrice,0) %>원 <%=CHKIIF(cCa2item.FItemList(fc2).IsSaleItem,"["&cCa2item.FItemList(fc2).getSalePro&"]","")%></div>
					</div>
				</a>
			</li>
			<% Next %>
		</ul>
	</div>
	<%
	End If
	SET cCa2item = Nothing %>
	<!-- #include file="./inc_sns.asp" -->
	<div class="listMore">
		<div class="more">
			<h2>다른 !NSPIRATION 보기</h2>
			<a href="list.asp?cate=inspi">more</a>
		</div>
		<!-- #include file="./inc_listmore.asp" -->
	</div>
</div>