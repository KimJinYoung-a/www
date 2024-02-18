<%
Dim cCa43down, fc43, vCa43DownArr
SET cCa43down = New CPlay
cCa43down.FRectDIdx = vDIdx
cCa43down.FRectDevice = "pc"
vCa43DownArr = cCa43down.fnPlayDownloadList
SET cCa43down = Nothing
%>
<div class="article playDetailV16 wallpaper">
	<div class="cont">
		<div class="detail">
			<div class="hgroup">
				<div>
					<!--<a href="list.asp?cate=4" class="corner">THING.</a>//-->
					THING.
					<h2><%=vTitleStyle%></h2>
					<div class="download">
						<p>해상도를 선택하여 다운로드 받으세요!</p>
						<ul>
							<%
							IF isArray(vCa43DownArr) THEN
								For fc43=0 To UBound(vCa43DownArr,2)
							%>
								<li><a href="<%=vCa43DownArr(1,fc43)%>"><span><%=vCa43DownArr(0,fc43)%></span><i></i></a></li>
							<%
								Next
							End IF
							%>
						</ul>
					</div>
				</div>
			</div>
			<div class="figure"><img src="<%=fnPlayImageSelect(vImageList,vCate,"20","i")%>" alt="" /></div>
			<div class="qrcode">
				<p>
					<span><img src="<%=fnPlayImageSelect(vImageList,vCate,"10","i")%>" width="50" height="50" alt="바로가기 QR코드" /></span>
					모바일용 배경화면은 텐바이텐 모바일 사이트에서 만나보세요! QR코드를 스캔하시면, 해당 페이지로 이동됩니다.
				</p>
			</div>
		</div>
	</div>
	<!-- #include file="./inc_sns.asp" -->
	<div class="listMore">
		<div class="more">
			<h2>다른 THING. 보기</h2>
			<a href="list.asp?cate=thing">more</a>
		</div>
		<!-- #include file="./inc_listmore.asp" -->
	</div>
</div>