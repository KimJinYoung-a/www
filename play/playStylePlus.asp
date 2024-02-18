<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
'#############################################
' 스타일 플러스 - 이종화
' 2013-09-09 
'#############################################
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 스타일플러스"		'페이지 타이틀 (필수)
	strPageDesc = "텐바이텐 PLAY - 스타일플러스"
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/play/playStylePlus.asp"			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Dim CurrPage , oStylePlus , i , oStylePlusTag , oStylePlusItem , ii , iii , tempi
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	Dim playcode : playcode = 2 '메뉴상단 번호를 지정 해주세요
	Dim pagesize : pagesize = 3
	CurrPage = getNumeric(requestCheckVar(request("cpg"),8))

	if CurrPage = "" then CurrPage = 1

	'//스타일 플러스 블로그형 리스트
	set oStylePlus = new CPlayContents
		oStylePlus.FPageSize = pagesize
		oStylePlus.FCurrPage = CurrPage
		oStylePlus.Fplaycode = playcode
		oStylePlus.Fuserid = GetLoginUserID
		oStylePlus.fnGetStylePlusList()
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">
	$(function() {

		var mySwiper01 = new Swiper('#swiper01',{
			pagination:'#pagination01',
			loop:true,
			speed:500,
			//autoplay:3000,
			grabCursor: true,
			paginationClickable: true,
			onTouchEnd : function(){
				chgimg("1");
			}
		});
		$('#swiperBtnLt01').on('click', function(e){
			e.preventDefault();
			mySwiper01.swipePrev();
			chgimg("1");
		});
		$('#swiperBtnRt01').on('click', function(e){
			e.preventDefault();
			mySwiper01.swipeNext();
			chgimg("1");
		});
		$('#pagination01').on('click', function(e){
			e.preventDefault();
			chgimg("1");
		});

		var mySwiper02 = new Swiper('#swiper02',{
			pagination:'#pagination02',
			loop:true,
			speed:500,
			//autoplay:3000,
			grabCursor: true,
			paginationClickable: true,
			onTouchEnd : function(){
				chgimg("2");
			}
		});
		$('#swiperBtnLt02').on('click', function(e){
			e.preventDefault();
			mySwiper02.swipePrev();
			chgimg("2");
		});
		$('#swiperBtnRt02').on('click', function(e){
			e.preventDefault();
			mySwiper02.swipeNext();
			chgimg("2");
		});
		$('#pagination02').on('click', function(e){
			e.preventDefault();
			chgimg("2");
		});

		var mySwiper03 = new Swiper('#swiper03',{
			pagination:'#pagination03',
			loop:true,
			speed:500,
			//autoplay:3000,
			grabCursor: true,
			paginationClickable: true,
			onTouchEnd : function(){
				chgimg("3");
			}
		});
		$('#swiperBtnLt03').on('click', function(e){
			e.preventDefault();
			mySwiper03.swipePrev();
			chgimg("3");
		});
		$('#swiperBtnRt03').on('click', function(e){
			e.preventDefault();
			mySwiper03.swipeNext();
			chgimg("3");
		});
		$('#pagination03').on('click', function(e){
			e.preventDefault();
			chgimg("3");
		});

		chgimg('1');
		chgimg('2');
		chgimg('3');

		function chgimg(v){
			if (v == "1"){
				var temphtml = mySwiper01.activeSlide().html();
			}else if (v == "2"){
				var temphtml = mySwiper02.activeSlide().html();
			}else{
				var temphtml = mySwiper03.activeSlide().html();
			}
			var tempid = $(temphtml).attr("rel");
			$("#thumbitem"+v+" li img").each(function( index ) {
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
	function jsGoPage(p){
			location.href = "/play/playStylePlus.asp?cpg="+p+"";
	}
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

			<% if oStylePlus.FresultCount > 0 then %>
			<% for i=0 to oStylePlus.FresultCount-1 %>
			<%
				set oStylePlusTag	= new CPlayContents
					oStylePlusTag.FRectIdx = oStylePlus.FItemList(i).Fidx
					oStylePlusTag.Fplaycode = playcode
					oStylePlusTag.GetRowTagContent() ' taglist
				set oStylePlusItem	= new CPlayContents
					oStylePlusItem.FRectIdx = oStylePlus.FItemList(i).Fidx
					oStylePlusItem.GetRowStyleItemList() ' itemlist

					snpTitle = Server.URLEncode("No."&oStylePlus.FItemList(i).Fviewno&" "&oStylePlus.FItemList(i).Fviewtitle)
					snpLink = Server.URLEncode("http://10x10.co.kr/play/playStylePlusView.asp?idx=" & oStylePlus.FItemList(i).Fidx&"&viewno="& oStylePlus.FItemList(i).Fviewno &"")
					snpPre = Server.URLEncode("텐바이텐 스타일플러스")
					snpTag = Server.URLEncode("텐바이텐 " & Replace("#"&oStylePlus.FItemList(i).Fviewno&" "&oStylePlus.FItemList(i).Fviewtitle," ",""))
					snpTag2 = Server.URLEncode("#10x10")
					snpImg = Server.URLEncode(oStylePlus.FItemList(i).Flistimg)
			%>
			<div class="articleWrap">
				<div class="snsArea">
					<strong class="ftLt tPad05 cr000">No. <%=oStylePlus.FItemList(i).Fviewno%></strong>
					<div class="sns">
						<ul>
							<!-- <li><a href="" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li> -->
							<li><a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
							<li><a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
							<li><a href="" onClick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
						</ul>
						<div id="mywish<%=oStylePlus.FItemList(i).Fidx%>" class="favoriteAct <%=chkiif(oStylePlus.FItemList(i).Fchkfav > 0 ,"myFavor","")%>" <% If GetLoginUserID <> "" Then %>onclick="TnAddPlaymywish('<%=playcode%>','<%= oStylePlus.FItemList(i).Fidx %>','');"<% Else %>onclick="jsChklogin();"<% End If %>><strong><%= FormatNumber(oStylePlus.FItemList(i).Ffavcnt,0) %></strong></div>
					</div>
				</div>
				<div class="styleBnrWrap tMar10">
					<a href="" class="arrow-left" id="swiperBtnLt0<%=i+1%>"></a>
					<a href="" class="arrow-right" id="swiperBtnRt0<%=i+1%>"></a>
					<div class="swiper-container" id="swiper0<%=i+1%>">
						<div class="swiper-wrapper">
							<% If oStylePlus.FItemList(i).Fviewimg1 <> "" Then %>
							<p class="swiper-slide"><img src="<%=oStylePlus.FItemList(i).Fviewimg1%>" alt="<%=oStylePlus.FItemList(i).Fviewtitle%> 1번이미지" rel="1"/></p>
							<% End If  %>
							<% If oStylePlus.FItemList(i).Fviewimg2 <> "" Then %>
							<p class="swiper-slide"><img src="<%=oStylePlus.FItemList(i).Fviewimg2%>" alt="<%=oStylePlus.FItemList(i).Fviewtitle%> 2번이미지" rel="2"/></p>
							<% End If  %>
							<% If oStylePlus.FItemList(i).Fviewimg3 <> "" Then %>
							<p class="swiper-slide"><img src="<%=oStylePlus.FItemList(i).Fviewimg3%>" alt="<%=oStylePlus.FItemList(i).Fviewtitle%> 3번이미지" rel="3"/></p>
							<% End If  %>
							<% If oStylePlus.FItemList(i).Fviewimg4 <> "" Then %>
							<p class="swiper-slide"><img src="<%=oStylePlus.FItemList(i).Fviewimg4%>" alt="<%=oStylePlus.FItemList(i).Fviewtitle%> 4번이미지" rel="4"/></p>
							<% End If  %>
							<% If oStylePlus.FItemList(i).Fviewimg5 <> "" Then %>
							<p class="swiper-slide"><img src="<%=oStylePlus.FItemList(i).Fviewimg5%>" alt="<%=oStylePlus.FItemList(i).Fviewtitle%> 5번이미지" rel="5"/></p>
							<% End If  %>
						</div>
					</div>
					<div class="pagination" id="pagination0<%=i+1%>"></div>
				</div>
				<div class="overHidden">
					<p class="styleCopy"><img src="<%=oStylePlus.FItemList(i).Ftextimg%>" alt="<%=oStylePlus.FItemList(i).Fviewtitle%>" /></p>
					<ul class="thumbList" id="thumbitem<%=i+1%>">
						<% if oStylePlusItem.FTotalCount > 0 then %>
						<% If oStylePlusItem.FTotalCount > 15 Then oStylePlusItem.FTotalCount = 15 ' 15개 이상등록 할경우 안보임%>
						<% For ii = 0 To oStylePlusItem.FTotalCount -1 %>
						<li><a href="/shopping/category_prd.asp?itemid=<%=oStylePlusItem.FItemList(ii).Fitemid%>"><img src="http://thumbnail.10x10.co.kr/webimage/image/List/<%= GetImageSubFolderByItemid(oStylePlusItem.FItemList(ii).Fitemid) %>/<%=oStylePlusItem.FItemList(ii).Flistimg%>?cmd=gray" alt="<%=oStylePlusItem.FItemList(ii).Fitemname%>" width="80px" height="80px" title="<%=oStylePlusItem.FItemList(ii).Fitemname%>" rel="<%=oStylePlusItem.FItemList(ii).Fviewno%>"/></a></li>
							<%
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
									elseif ii = oStylePlusItem.FTotalCount -1 And ii > 9 And  ii < 14 Then 
											tempi = 14-ii
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
					<% If oStylePlusTag.FTotalCount > 0 Then %>
					<dt class="ftLt">Tag</dt>
					<dd class="ftLt">
						<ul>
							<% For iii = 0 To oStylePlusTag.FTotalCount -1 %>
								<li><span><a href="<%=chkiif(oStylePlusTag.FItemList(iii).Ftagurl="","/search/search_result.asp?rect="&oStylePlusTag.FItemList(iii).Ftagname&"",oStylePlusTag.FItemList(iii).Ftagurl)%>"><%=oStylePlusTag.FItemList(iii).Ftagname%></a></span></li>
							<% Next %>
						</ul>
					</dd>
					<% End If %>
				</dl>
			</div>
			<% Set oStylePlusItem = Nothing %>
			<% Set oStylePlusTag = Nothing %>
			<% Next %>
			<% End If %>

			<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(CurrPage,oStylePlus.FTotalCount,PageSize,10,"jsGoPage") %></div>
			<div id="tempdiv" style="display:none" ></div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
	Set oStylePlus = Nothing 
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->