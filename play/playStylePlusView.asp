<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
'#############################################
' 스타일플러스 상세 - 이종화
' 2013-09-09
'#############################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Dim idx , oStylePlus , viewno , i , ii , oStylePlusItem
	Dim playcode : playcode = 2 '메뉴상단 번호를 지정 해주세요
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg

	idx = getNumeric(requestCheckVar(request("idx"),8))
	viewno = getNumeric(requestCheckVar(request("viewno"),8))

	If idx = "" Then
		Response.Redirect "/play/"
		dbget.close
		Response.End
	End If

	set oStylePlus = new CPlayContents
		oStylePlus.FRectviewno = viewno
		oStylePlus.FRectIdx = idx
		oStylePlus.Fplaycode = playcode
		oStylePlus.Fuserid = GetLoginUserID
		oStylePlus.GetOneRowStyleContent() '1row
		oStylePlus.GetRowTagContent() ' taglist

	Set oStylePlusItem = new CPlayContents
		oStylePlusItem.FRectIdx = idx
		oStylePlusItem.GetRowStyleItemList() ' itemlist

		snpTitle = Server.URLEncode("No."&oStylePlus.FOneItem.Fviewno&" "&oStylePlus.FOneItem.Fviewtitle)
		snpLink = Server.URLEncode("http://10x10.co.kr/play/playStylePlusView.asp?idx=" & idx&"&viewno="& viewno &"")
		snpPre = Server.URLEncode("텐바이텐 스타일플러스")
		snpTag = Server.URLEncode("텐바이텐 " & Replace("#"&oStylePlus.FOneItem.Fviewno&" "&oStylePlus.FOneItem.Fviewtitle," ",""))
		snpTag2 = Server.URLEncode("#10x10")
		snpImg = Server.URLEncode(oStylePlus.FOneItem.Flistimg)

		strPageTitle = "텐바이텐 10X10 : 스타일플러스"
		strPageDesc = "텐바이텐 PLAY - 스타일플러스 상세페이지"
		strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
		strPageUrl = "http://10x10.co.kr/play/playStylePlusView.asp?idx=" & idx&"&viewno="& viewno 	'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">
	$(function() {

		var mySwiper01 = new Swiper('#swiper01',{
			pagination:'#pagination01',
			loop:true,
			speed:700,
			//autoplay:3000,
			grabCursor: true,
			paginationClickable: true,
			onTouchEnd : function(){
				chgimg();
			}
		});

		$('#swiperBtnLt01').on('click', function(e){
			e.preventDefault();
			mySwiper01.swipePrev();
			chgimg();
		});
		$('#swiperBtnRt01').on('click', function(e){
			e.preventDefault();
			mySwiper01.swipeNext();
			chgimg();
		});
		$('#pagination01').on('click', function(e){
			e.preventDefault();
			chgimg();
		});

		chgimg();

		function chgimg(){
			var temphtml = mySwiper01.activeSlide().html();
			var tempid = $(temphtml).attr("rel");

			$(".thumbList li img").each(function( index ) {
			  var rel = $(this).attr("rel");
				  if (tempid == rel )
				  {
					$(this).attr("src",$(this).attr("src").replace("gray","normal"));
				  }else{
					$(this).attr("src",$(this).attr("src").replace("normal","gray"));
				  }
			});
		}
	});
</script>
</head>
<body>
<div class="wrap playWrapV15" id="playSub">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- #include virtual="/lib/inc/incPlayHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="playTit">
				<h2 class="ftLt" style="margin-bottom:-8px;"><a href="/play/playStylePlus.asp"><img src="http://fiximage.10x10.co.kr/web2013/play/tit_style.gif" alt="STYLE+" /></a></h2>
				<a href="/play/playStylePlusList.asp" class="btnListView">리스트 보기</a>
			</div>

			<div class="articleWrap">
				<div class="snsArea">
					<strong class="ftLt tPad05 cr000">No. <%=oStylePlus.FOneItem.Fviewno%></strong>
					<div class="sns">
						<ul>
							<!-- <li><a href="" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li> -->
							<li><a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
							<li><a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
							<li><a href="" onClick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
						</ul>
						<div id="mywish<%=idx%>" class="favoriteAct <%=chkiif(oStylePlus.FOneItem.Fchkfav > 0 ,"myFavor","")%>" <% If GetLoginUserID <> "" Then %>onclick="TnAddPlaymywish('<%=playcode%>','<%= oStylePlus.FOneItem.Fidx %>','');"<% Else %>onclick="jsChklogin();"<% End If %>><strong><%= FormatNumber(oStylePlus.FOneItem.Ffavcnt,0) %></strong></div>
					</div>
				</div>
				<div class="styleBnrWrap tMar10">
					<a href="" class="arrow-left" id="swiperBtnLt01"></a>
					<a href="" class="arrow-right" id="swiperBtnRt01"></a>
					<div class="swiper-container" id="swiper01">
						<div class="swiper-wrapper">
							<% If oStylePlus.FOneItem.Fviewimg1 <> "" Then %>
							<p class="swiper-slide"><img src="<%=oStylePlus.FOneItem.Fviewimg1%>" alt="<%=oStylePlus.FOneItem.Fviewtitle%> 1번이미지" rel="1"/></p>
							<% End If  %>
							<% If oStylePlus.FOneItem.Fviewimg2 <> "" Then %>
							<p class="swiper-slide"><img src="<%=oStylePlus.FOneItem.Fviewimg2%>" alt="<%=oStylePlus.FOneItem.Fviewtitle%> 2번이미지" rel="2"/></p>
							<% End If  %>
							<% If oStylePlus.FOneItem.Fviewimg3 <> "" Then %>
							<p class="swiper-slide"><img src="<%=oStylePlus.FOneItem.Fviewimg3%>" alt="<%=oStylePlus.FOneItem.Fviewtitle%> 3번이미지" rel="3"/></p>
							<% End If  %>
							<% If oStylePlus.FOneItem.Fviewimg4 <> "" Then %>
							<p class="swiper-slide"><img src="<%=oStylePlus.FOneItem.Fviewimg4%>" alt="<%=oStylePlus.FOneItem.Fviewtitle%> 4번이미지" rel="4"/></p>
							<% End If  %>
							<% If oStylePlus.FOneItem.Fviewimg5 <> "" Then %>
							<p class="swiper-slide"><img src="<%=oStylePlus.FOneItem.Fviewimg5%>" alt="<%=oStylePlus.FOneItem.Fviewtitle%> 5번이미지" rel="5"/></p>
							<% End If  %>
						</div>
					</div>
					<div class="pagination" id="pagination01"></div>
				</div>
				<div class="overHidden">
					<p class="styleCopy"><img src="<%=oStylePlus.FOneItem.Ftextimg%>" alt="<%=oStylePlus.FOneItem.Fviewtitle%>" /></p>
					<ul class="thumbList">
						<% if oStylePlusItem.FTotalCount > 0 then %>
						<% For ii = 0 To oStylePlusItem.FTotalCount -1 %>
							<li><a href="/shopping/category_prd.asp?itemid=<%=oStylePlusItem.FItemList(ii).Fitemid%>"><img src="http://thumbnail.10x10.co.kr/webimage/image/List/<%= GetImageSubFolderByItemid(oStylePlusItem.FItemList(ii).Fitemid) %>/<%=oStylePlusItem.FItemList(ii).Flistimg%>?cmd=gray" alt="<%=oStylePlusItem.FItemList(ii).Fitemname%>" width="80px" height="80px" title="<%=oStylePlusItem.FItemList(ii).Fitemname%>" rel="<%=oStylePlusItem.FItemList(ii).Fviewno%>"/></a></li>
								<%
									Dim iii
									Dim tempi
									if ii = oStylePlusItem.FTotalCount -1 And ii < 4 Then
										tempi = 4-ii
										For iii = 1 To tempi
								%>
										<li></li>
								<%
										Next
									elseif ii = oStylePlusItem.FTotalCount -1 And ii > 4 And  ii < 9 Then
										tempi = 9-ii
										For iii = 1 To tempi
								%>
										<li></li>
								<%
										Next
									end If
								%>
						<% Next %>
						<% End If %>
					</ul>
				</div>
				<dl class="tagView tPad30">
					<% If oStylePlus.FTotalCount > 0 Then %>
					<dt class="ftLt">Tag</dt>
					<dd class="ftLt">
						<ul>
							<% For i = 0 To oStylePlus.FTotalCount -1 %>
							<li><span><a href="<%=chkiif(oStylePlus.FItemList(i).Ftagurl="","/search/search_result.asp?rect="&oStylePlus.FItemList(i).Ftagname&"",oStylePlus.FItemList(i).Ftagurl)%>"><%=oStylePlus.FItemList(i).Ftagname%></a></span></li>
							<% Next %>
						</ul>
					</dd>
					<% End If %>
				</dl>
			</div>
			<div id="tempdiv" style="display:none" ></div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
	Set oStylePlus = Nothing
	Set oStylePlusItem = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->