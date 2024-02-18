<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2020 다꾸티비 - 상세
' History : 2019-08-21 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/diarystory2020/lib/worker_only_view.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/media/mediaCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
	dim oMedia
    dim vContentsidx : vContentsidx = requestCheckvar(request("cidx"),10)

	if Not(isNumeric(vContentsidx)) then
        Call Alert_Return("잘못된 컨텐츠 번호입니다.")
        response.End
    end if	

	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
    if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr") < 1 then
        if Not(Request("mfg")="pc" or session("mfg")="pc") then
            if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
                Response.Redirect "http://m.10x10.co.kr/diarystory2020/daccutv_detail.asp?cidx=" & vContentsidx
                REsponse.End
            end if
        end if
    end if

    

    SET oMedia = new MediaCls
        oMedia.FrectCidx = vContentsidx
		oMedia.getOneContents

		'#############################################################################################################################################################
		'// Facebook 오픈그래프 메타태그 작성
		strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐/다꾸TV] "& replace(oMedia.FOneItem.Fctitle,"""","") &""" />" & vbCrLf &_
							"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
							"<meta property=""og:url"" content=""http://www.10x10.co.kr/diarystory2020/daccutv_detail.asp?cidx=" & vContentsidx & """ />" & vbCrLf
							
		if Not(oMedia.FOneItem.Fmainimage = "" or isNull(oMedia.FOneItem.Fmainimage)) then
		strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""" & oMedia.FOneItem.Fmainimage & """ />" & vbCrLf &_
													"<link rel=""image_src"" href=""" & oMedia.FOneItem.Fmainimage & """ />" & vbCrLf &_
													"<meta property=""og:description"" content=""[텐바이텐/다꾸TV] "& oMedia.FOneItem.Fctext &""">" & vbCrLf
		strPageImage = oMedia.FOneItem.Fmainimage
		strPageDesc = "[텐바이텐/다꾸TV] "& oMedia.FOneItem.Fctext &""
		end If

		strPageTitle = "텐바이텐 10X10 : " & oMedia.FOneItem.Fctitle
		strPageKeyword = "다꾸TV, " & replace(oMedia.FOneItem.Fctitle,"""","")
		'#############################################################################################################################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/platform.css?v=1.25">
<script type="text/javascript">
$(function(){
	// video play
	$('.player .thumbnail').click(function(){
		$(this).fadeOut(400);
		$(this).next('.vod').find('iframe')[0].contentWindow.postMessage('{"event":"command","func":"' + 'playVideo' + '","args":""}', '*');
	});

	// go video
	$(window).scroll(function(){
		var player = $(".player").offset().top + $(".player").height();
		if ( player < $(window).scrollTop() + 51 ) {
			$(".go-video").addClass("on");
		} else {
			$(".go-video").removeClass("on");
		}
	});
	$(".btn-go-video").click(function(){
		var vodT = $(".view-left").offset().top;
		$('html, body').animate({scrollTop:vodT});
	});

	// reply
	$(".reply-evt .write textarea").on({
		focus: function(){
			$(this).attr( 'placeholder', '300자 이내로 작성해주세요' );
		}, blur: function(){
			$(this).attr( 'placeholder', '댓글을 입력해주세요' );
		}
	});
});

$(window).load(function(){
	// float
	var conT = $(".container").offset().top;
	var viewH = $(".view-left").outerHeight();
	var floatH = $(".floating-wrap").outerHeight();
	var gap = viewH - floatH;

	$(window).scroll(function(){
		var y = $(window).scrollTop();
		var newT = gap - y + 51;

		// floating
		if ( conT < y ) {
			$(".floating-wrap").css("position","fixed");
			if ( gap < y ) {
				$(".floating-wrap").css("top",newT);
			} else {
				$(".floating-wrap").css("top",51);
			}
		} else {
			$(".floating-wrap").css({"position":"absolute", "top":0});
		}
	});
});
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<% if InStr(request.ServerVariables("HTTP_REFERER"),"/diarystory2021/") > 0 or date() >= "2020-09-07" then %>
	<div class="container diary2021">
	<% else %>
	<div class="container diary2020">
	<% end if %>
		<div id="contentWrap" class="diary-tv diary-tv-detail">
            <% if InStr(request.ServerVariables("HTTP_REFERER"),"/diarystory2021/") > 0 or date() >= "2020-09-07" then %>
            <!-- #include virtual="/diarystory2021/inc/header.asp" -->
			<% else %>
			<!-- #include virtual="/diarystory2020/inc/head.asp" -->
			<% end if %>
			<div class="diary-content">
				<div class="inner">
					<div class="view-left">
						<div class="owner">
							<div class="thumbnail"><a href=""><img src="<%=oMedia.FOneItem.Fprofileimage%>" alt=""></a></div>
							<div class="desc">
								<p class="name"><a href="javascript:void(0);"><%=oMedia.FOneItem.Ftitlename%></a></p>
								<p><%=oMedia.FOneItem.Fprofile%></p>
							</div>
						</div>
						<div class="player">
							<div class="thumbnail" style="background-image:url(<%=oMedia.FOneItem.Fmainimage%>)"><% if datediff("d", oMedia.FOneItem.Fstartdate, date()) < 3 then %><span class="badge">NEW</span><% end if %></div>
							<div class="vod">
								<iframe width="817" height="460" src="<%=oMedia.FOneItem.Fvideourl%>" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
							</div>
						</div>
						<div class="vod-info">
							<h3 class="info-tit"><%=db2html(oMedia.FOneItem.Fctitle)%></h3>
							<%' 박수-짝짝짝 %>
							<!-- #include virtual="/diarystory2020/inc/claps.asp" -->
							<%' 박수-짝짝짝 %>
							<div class="info-view">view <%=formatnumber(oMedia.FOneItem.Fviewcount,0)%></div>
							<div class="info-txt"><%=db2html(oMedia.FOneItem.Fctext)%></div>
							<%' 태그 %>
							<!-- #include virtual="/diarystory2020/inc/infotags.asp" -->
							<%' 태그 %>
							<ul class="share">
								<%
									'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
									dim snpTitle, snpLink, snpPre, snpTag, snpTag2 , snpImg
									snpTitle = Server.URLEncode(oMedia.FOneItem.Fctitle)
									snpLink = Server.URLEncode("http://www.10x10.co.kr"&Request.ServerVariables("URL")&"?"&Request.ServerVariables("QUERY_STRING"))
									snpPre = Server.URLEncode("텐바이텐_텐플루언서")
									snpTag = Server.URLEncode("텐바이텐 " & Replace(oMedia.FOneItem.Fctitle," ",""))
									snpTag2 = Server.URLEncode("#10x10")
									snpImg = oMedia.FOneItem.Fmainimage	'상단에서 생성
								%>
								<li><a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');return false;" class="twitter">트위터로 공유</a></li>
								<li><a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;" class="facebook">페이스북으로 공유</a></li>
								<li><a href="" onclick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>');return false;" class="pinterest">핀터레스트로 공유</a></li>
							</ul>
						</div>
						<%' 이벤트 코멘트 %>
						<!-- #include virtual="/diarystory2020/inc/eventcomment.asp" -->
						<%' 이벤트 코멘트 %>
					</div>
					<div class="floating-wrap">
						<%' 연관상품 %>
						<!-- #include virtual="/diarystory2020/inc/infoitems.asp" -->
						<%' 연관상품 %>
						<div class="bnr-list">
							<ul>
								<% if oMedia.FOneItem.Fevtlinkimage1pc <> "" then %>
								<li>
									<a href="/event/eventmain.asp?eventid=<%=oMedia.FOneItem.Fevtlinkcode1%>"><img src="<%=oMedia.FOneItem.Fevtlinkimage1pc%>" alt=""></a>
								</li>
								<% end if %>
								<% if oMedia.FOneItem.Fevtlinkimage2pc <> "" then %>
								<li>
									<a href="/event/eventmain.asp?eventid=<%=oMedia.FOneItem.Fevtlinkcode2%>"><img src="<%=oMedia.FOneItem.Fevtlinkimage2pc%>" alt=""></a>
								</li>
								<% end if %>
								<% if oMedia.FOneItem.Fevtlinkimage3pc <> "" then %>
								<li>
									<a href="/event/eventmain.asp?eventid=<%=oMedia.FOneItem.Fevtlinkcode3%>"><img src="<%=oMedia.FOneItem.Fevtlinkimage3pc%>" alt=""></a>
								</li>
								<% end if %>
								<% if oMedia.FOneItem.Fevtlinkimage4pc <> "" then %>
								<li>
									<a href="/event/eventmain.asp?eventid=<%=oMedia.FOneItem.Fevtlinkcode4%>"><img src="<%=oMedia.FOneItem.Fevtlinkimage4pc%>" alt=""></a>
								</li>
								<% end if %>
								<% if oMedia.FOneItem.Fevtlinkimage5pc <> "" then %>
								<li>
									<a href="/event/eventmain.asp?eventid=<%=oMedia.FOneItem.Fevtlinkcode5%>"><img src="<%=oMedia.FOneItem.Fevtlinkimage5pc%>" alt=""></a>
								</li>
								<% end if %>
							</ul>
						</div>
						<div class="go-video">
							<div class="thumbnail" style="background-image:url(<%=oMedia.FOneItem.Fmainimage%>)"><% if datediff("d", oMedia.FOneItem.Fstartdate, date()) < 3 then %><span class="badge">NEW</span><% end if %></div>
							<button type="button" class="btn-go-video"><span>영상으로 돌아가기</span></button>
						</div>
					</div>
					<%' !-- 박수 30번 축하 레이어 -- %>
					<div class="ly-clap">
						<div class="ly-clap-inner">
							<div class="dots dots1"></div>
							<div class="dots dots2"></div>
							<div class="dots dots3"></div>
							<div class="dots dots4"></div>
							<div class="dots dots5"></div>
							<div class="dots dots6"></div>
							<div class="dots dots7"></div>
							<div class="dots dots8"></div>
							<div class="hand"></div>
							<div class="heart"><i></i></div>
						</div>
						<div class="mask"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
    SET oMedia = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->