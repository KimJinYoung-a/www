<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
'#############################################
' play-main - 이종화
' 2013-10-01 
'#############################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Response.Redirect "/playing/"
	dbget.close
	Response.End
	
	'### 2016.07.15 PLAY 리뉴얼 계획으로 업데이트 잠시 중단 > 기존에 작성되었던 컨텐츠로 강제 이동
	Dim vRdrURL
	if date>="2016-07-18" and date<"2016-07-25" then
		vRdrURL = "/play/playGround.asp?gidx=22&gcidx=90"
	ElseIf date>="2016-07-25" and date<"2016-08-01" then
		vRdrURL = "/play/playStylePlusView.asp?idx=133&viewno=133"
	ElseIf date>="2016-08-01" and date<"2016-08-08" then
		vRdrURL = "/play/playGround.asp?gidx=22&gcidx=91"
	ElseIf date>="2016-08-08" and date<"2016-08-15" then
		vRdrURL = "/play/playStylePlusView.asp?idx=146&viewno=146"
	ElseIf date>="2016-08-15" and date<"2016-08-22" then
		vRdrURL = "/play/playGround.asp?gidx=21&gcidx=86"
	ElseIf date>="2016-08-22" and date<"2016-08-29" then
		vRdrURL = "/play/playStylePlusView.asp?idx=106&viewno=104"
	ElseIf date>="2016-08-29" and date<"2016-09-05" then
		vRdrURL = "/play/playGround.asp?gidx=19&gcidx=78"
	ElseIf date>="2016-09-05" and date<"2016-09-12" then
		vRdrURL = "/play/playStylePlusView.asp?idx=136&viewno=136"
	ElseIf date>="2016-09-12" and date<"2016-09-19" then
		vRdrURL = "/play/playGround.asp?gidx=18&gcidx=75"
	ElseIf date>="2016-09-19" and date<"2016-09-26" then
		vRdrURL = "/play/playStylePlusView.asp?idx=154&viewno=154"
	ElseIf date>="2016-09-26" and date<"2016-10-03" then
		vRdrURL = "/play/playGround.asp?gidx=17&gcidx=71"
	ElseIf date>="2016-10-03" and date<"2016-10-10" then
		vRdrURL = "/play/playStylePlusView.asp?idx=107&viewno=105"
	Elseif date>="2016-10-10" and date<"2016-10-17" then
		vRdrURL = "/play/playGround.asp?gidx=16&gcidx=68"
	ElseIf date>="2016-10-17" and date<"2016-10-24" then
		vRdrURL = "/play/playStylePlusView.asp?idx=101&viewno=99"
	ElseIf date>="2016-10-24" and date<"2016-10-31" then
		vRdrURL = "/play/playGround.asp?gidx=14&gcidx=53"
	ElseIf date>="2016-10-31" and date<"2016-11-07" then
		vRdrURL = "/play/playStylePlusView.asp?idx=97&viewno=96"
	ElseIf date>="2016-11-07" and date<"2016-11-14" then
		vRdrURL = "/play/playGround.asp?gidx=14&gcidx=61"
	ElseIf date>="2016-11-14" and date<"2016-11-21" then
		vRdrURL = "/play/playStylePlusView.asp?idx=105&viewno=103"
	ElseIf date>="2016-11-21" and date<"2016-11-28" then
		vRdrURL = "/play/playGround.asp?gidx=13&gcidx=50"
	ElseIf date>="2016-11-28" and date<"2016-12-05" then
		vRdrURL = "/play/playStylePlusView.asp?idx=95&viewno=94"
	ElseIf date>="2016-12-05" and date<"2016-12-12" then
		vRdrURL = "/play/playGround.asp?gidx=12&gcidx=45"
	ElseIf date>="2016-12-12" and date<"2016-12-19" then
		vRdrURL = "/play/playStylePlusView.asp?idx=116&viewno=116"
	ElseIf date>="2016-12-19" then
		vRdrURL = "/play/playGround.asp?gidx=12&gcidx=47"
	Else
		vRdrURL = "/play/playGround.asp"
	end if

	dbget.close()
	response.redirect vRdrURL
	response.end
	'### END #####
	
	Dim oPlayMain , oStyleMain , oPictureDiaryMain
	Dim oDfMain , oColorTrend , oViedeClip

	'//플레이 메인
	set oPlayMain = new CPlayContents
		 oPlayMain.GetOneRowGroundPlayMain()
	set oStyleMain = new CPlayContents
		 oStyleMain.fnStylePlayMain()
	set oPictureDiaryMain = new CPlayContents
		 oPictureDiaryMain.fnPictureDiaryPlayMain()
	set oDfMain = new CPlayContents
		 oDfMain.fnDeignfingersPlayMain()
	Set oColorTrend = new CPlayContents
		oColorTrend.fncolortrendPlayMain()
	Set oViedeClip = new CPlayContents
		oViedeClip.fnVideoClipPlayMain()
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('img').load(function(){
			$(".playContList").masonry({
				itemSelector: '.box'
			});
		});
		$(".playContList").masonry({
			itemSelector: '.box'
		});
	});
</script>
</head>
<body>
<div class="wrap playWrapV15" id="playMainV15">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- #include virtual="/lib/inc/incPlayHeader.asp" -->
	<div class="container">
		<div class="groundWrap autoForm" style="background-color:<%=oPlayMain.FOneItem.FmainBGColor%>; background-image:url(<%=oPlayMain.FOneItem.Fplaymainimg%>);"><a href="playGround.asp?gidx=<%=oPlayMain.FOneItem.Fidxsub	%>&gcidx=<%=oPlayMain.FOneItem.Fidx%>"><%=oPlayMain.FOneItem.Fviewtitle%></a></div>
		<div id="contentWrap">
			<div class="playContList">
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title02.gif" alt="Style+" /></dt>
						<dd>
							<a href="playStylePlusView.asp?idx=<%=oStyleMain.FItemList(0).Fidx%>"><img src="<%=oStyleMain.FItemList(0).Fplaymainimg%>" alt="<%=oStyleMain.FItemList(0).Fviewtitle%>" /></a>
						</dd>
					</dl>
				</div>
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title05.gif" alt="그림일기" /></dt>
						<dd>
							<a href="playPicDiary.asp?idx=<%=oPictureDiaryMain.FItemList(0).Fidx%>&viewno=<%=oPictureDiaryMain.FItemList(0).Fviewno%>"><img src="<%=oPictureDiaryMain.FItemList(0).Flistimg%>" alt="<%=oPictureDiaryMain.FItemList(0).Fviewtitle%>" /></a>
						</dd>
					</dl>
				</div>
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title04.gif" alt="Design fingers" /></dt>
						<dd>
							<a href="playdesignfingers.asp?fingerid=<%=oDfMain.FItemList(0).Fidx%>"><img src="<%=oDfMain.FItemList(0).Flistimg%>" alt="<%=oDfMain.FItemList(0).Fviewtitle%>" /></a>
						</dd>
					</dl>
				</div>
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title03.gif" alt="Color trend" /></dt>
						<dd>
							<a href="playColorTrendView.asp?ctcode=<%=oColorTrend.FItemList(0).Fidx%>"><img src="<%=oColorTrend.FItemList(0).Flistimg%>" alt="<%=oColorTrend.FItemList(0).Fviewtitle%>" /></a>
						</dd>
					</dl>
				</div>
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title05.gif" alt="그림일기" /></dt>
						<dd>
							<a href="playPicDiary.asp?idx=<%=oPictureDiaryMain.FItemList(1).Fidx%>&viewno=<%=oPictureDiaryMain.FItemList(1).Fviewno%>"><img src="<%=oPictureDiaryMain.FItemList(1).Flistimg%>" alt="<%=oPictureDiaryMain.FItemList(1).Fviewtitle%>" /></a>
						</dd>
					</dl>
				</div>
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title06.gif" alt="VIDEO CLIP" /></dt>
						<dd>
							<a href="playVideoClip.asp?idx=<%=oViedeClip.FItemList(0).Fidx%>"><img src="<%=oViedeClip.FItemList(0).Flistimg%>" alt="<%=oViedeClip.FItemList(0).Fviewtitle%>" /></a>
						</dd>
					</dl>
				</div>

				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title07.gif" alt="T-EPISODE" /></dt>
						<dd>
							<a href="/play/playtEpisodePhotopick.asp"><img src="http://fiximage.10x10.co.kr/web2013/play/20131002_play_Photopick_ban.jpg" alt="T-EPISODE" /></a>
						</dd>
					</dl>
				</div>
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title03.gif" alt="Color trend" /></dt>
						<dd>
							<a href="playColorTrendView.asp?ctcode=<%=oColorTrend.FItemList(1).Fidx%>"><img src="<%=oColorTrend.FItemList(1).Flistimg%>" alt="<%=oColorTrend.FItemList(1).Fviewtitle%>" /></a>
						</dd>
					</dl>
				</div>
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title07.gif" alt="T-EPISODE" /></dt>
						<dd>
							<a href="/play/playtepisodeWallpaperPc.asp"><img src="http://fiximage.10x10.co.kr/web2013/play/20131031_play_wallpaper_ban.jpg" alt="T-EPISODE" /></a>
						</dd>
					</dl>
				</div>
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title02.gif" alt="Style+" /></dt>
						<dd>
							<a href="playStylePlusView.asp?idx=<%=oStyleMain.FItemList(1).Fidx%>"><img src="<%=oStyleMain.FItemList(1).Fplaymainimg%>" alt="<%=oStyleMain.FItemList(1).Fviewtitle%>" /></a>
						</dd>
					</dl>
				</div>
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title05.gif" alt="그림일기" /></dt>
						<dd>
							<a href="playPicDiary.asp?idx=<%=oPictureDiaryMain.FItemList(2).Fidx%>&viewno=<%=oPictureDiaryMain.FItemList(2).Fviewno%>"><img src="<%=oPictureDiaryMain.FItemList(2).Flistimg%>" alt="<%=oPictureDiaryMain.FItemList(2).Fviewtitle%>" /></a>
						</dd>
					</dl>
				</div>
				<div class="box">
					<dl>
						<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title04.gif" alt="DESIGN FINGERS" /></dt>
						<dd>
							<a href="playdesignfingers.asp?fingerid=<%=oDfMain.FItemList(1).Fidx%>"><img src="<%=oDfMain.FItemList(1).Flistimg%>" alt="<%=oDfMain.FItemList(1).Fviewtitle%>" /></a>
						</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
	Set oViedeClip = Nothing 
	Set oColorTrend = Nothing 
	Set oDfMain = Nothing 
	Set oPictureDiaryMain = Nothing 
	Set oStyleMain = Nothing 
	Set oPlayMain = Nothing 
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->