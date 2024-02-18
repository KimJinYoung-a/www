<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  드라마존 Index
' History : 2018-05-09
'###########################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	Dim sqlStr , arrList , jcnt , dramaidx , listidx , idx , dramatitle
	Dim sqlStr2 , arrList2

	dramaidx = requestCheckVar(Request("dramaidx"),10)
	listidx = requestCheckVar(Request("listidx"),10)

	'// sbs 드라마존 서비스 종료
	If date() > "2019-03-31" and GetLoginUserLevel <> "7"  Then
		response.write "<script>alert('종료된 서비스 입니다.'); location.href='/'</script>"
		dbget.close()	:	response.End
	End If

	If dramaidx = "" Or listidx = "" Then
		Call Alert_Return("올바른 접근이 아닙니다.")
		dbget.close()	:	response.End
	End If

	'// query
	sqlStr = "[db_sitemaster].[dbo].[usp_WWW_SBSvShop_Drama_Get]"
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr,dbget,1
	IF Not (rsget.EOF OR rsget.BOF) THEN
		arrList = rsget.GetRows
	END If
	rsget.close

	'// og tag용
	sqlStr2 = "[db_sitemaster].[dbo].[usp_WWW_SBSvShop_DramaList_Get] @idx=" & dramaidx & ", @listidx=" & listidx
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr2,dbget,1
	IF Not (rsget.EOF OR rsget.BOF) THEN
		arrList2 = rsget.GetRows
	END If
	rsget.close

	Dim contentsText : contentsText = db2html(arrList2(3,0))
	Dim dTitle : dTitle = db2html(arrList2(2,0))
	Dim thumbImage	: thumbImage = "http://imgstatic.10x10.co.kr/mobile/drama" & arrList2(4,0)
	Dim contentsRegdate : contentsRegdate = formatDate(arrList2(12,0),"0000.00.00")


	'// Facebook 오픈그래프 메타태그 작성
	strHeaderAddMetaTag =	"<meta property=""og:title"" content=""[텐바이텐 - SBS 드라마존] " & dTitle & """ />" & vbCrLf &_
							"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
							"<meta property=""og:url"" content=""http://www.10x10.co.kr/dramazone/detail.asp?dramaidx="&dramaidx&"&listidx="&listidx&""" />" & vbCrLf &_
							"<meta property=""og:image"" content=""" & thumbImage & """ />" & vbCrLf &_
							"<link rel=""image_src"" href=""" & thumbImage & """ />" & vbCrLf &_
							"<meta property=""og:description"" content="""& contentsText &""">" & vbCrLf

	strPageTitle = "텐바이텐 10X10 : SBS 드라마존"
	strPageKeyword = "SBS 드라마존 - " & dTitle
	strPageImage = thumbImage
	strPageDesc = "[텐바이텐 SBS 드라마존] " & contentsText
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.7.1/clipboard.min.js"></script>
<script type="text/javascript">
$(function(){
	// sorting bar
	$('.sortingbar').click(function(e){
		e.preventDefault();
		if ($('.sbs-top').hasClass("on")) {
			$('.sbs-top').removeClass("on");
			unfold();
		} else {
			$('.sbs-top').addClass("on");
			fold();
		}
	});

	// replace text
	function fold(){
		var el = $('.option-right');
		el.html(el.html().replace('드라마 목록 펼쳐보기', '드라마 목록 접기'));
	}
	function unfold(){
		var el = $('.option-right');
		el.html(el.html().replace('드라마 목록 접기', '드라마 목록 펼쳐보기'));
	}

	fnAmplitudeEventMultiPropertiesAction("view_dramazonedetail","idx|dramaidx","<%=listidx%>|<%=dramaidx%>");
});
</script>
</head>
<body>
<div class="wrap fullEvt">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container sbsDrama detail">
		<div id="contentWrap">
			<%'!-- sbs탑--%>
			<div class="sbs-top">
				<div class="inner">
					<h2><a href="/dramazone/"><img src="http://fiximage.10x10.co.kr/web2018/sbs/img_logo.png" alt="SBS Drama zone 드라마속 상품들을 텐바이텐에서 만나보세요!" /></a></h2>
					<div class="sortingbar">
						<div class="option-right ellipsis">드라마 목록 펼쳐보기<span class="arrow-bottom bottom1" id="basketDropIcon"></span></div>
					</div>
					<ul>
						<li class="<%=chkiif(dramaidx = 0 ,"on","")%>"><a href="/dramazone/" onclick="fnAmplitudeEventAction('click_dramazonetop','idx','0');">ALL</a></li>
					<%
					if isarray(arrList) Then
						For jcnt = 0 To ubound(arrList,2)
							If CInt(dramaidx) = CInt(arrList(0,jcnt)) Then dramatitle = arrList(2,jcnt) End If
							Response.write  "<li class='"& chkiif(CInt(dramaidx) = CInt(arrList(0,jcnt)),"on","") &"'><a href='/dramazone/?idx="& arrList(0,jcnt) &"' onclick=fnAmplitudeEventAction('click_dramazonetop','idx','"&arrList(0,jcnt)&"');>"& arrList(2,jcnt) &"</a></li>"
						Next
					End If
					%>
					</ul>
				</div>
			</div>
			<%'!-- sbs탑--%>

			<div id="dramazone"></div>

			<div class="recent-vod">
				<div class="inner">
				<h4>최근 등록된 컨텐츠</h4>
				<a href="/dramazone/" class="more btn-linkV18 link2">더보기 <span></span></a>
					<ul id="morecontents"></ul>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
(function($){
	var $drama = $("#dramazone");
	var $more = $("#morecontents");
	var dataurl = "/dramazone/";
	var json_data2 = dataurl+"json_data2.asp?dramaidx=<%=dramaidx%>&listidx=<%=listidx%>";
	var json_data3 = dataurl+"json_data3.asp?listidx=<%=listidx%>";

	// detail
	$.getJSON(json_data2, function (data, status, xhr) {
			function getRandomColor(){
				var color = '#';
				var letters = ['FBEEF1', 'E9F5F9', 'F9F3E5']; 
				color += letters[Math.floor(Math.random() * letters.length)]; 

				return color;	
			}
			function getNowDate(){
				var d = new Date()
				, month = '' + (d.getMonth() + 1)
				, day = '' + d.getDate()
				, year = d.getFullYear(); 

				if (month.length < 2) month = '0' + month; 
				if (day.length < 2) day = '0' + day; 

				return [year, month, day].join('-');			
			}
			function isDateValid(startdate, enddate){
				return (getNowDate() >= startdate && getNowDate() <= enddate)
			}		
		if (status == "success") {
			if (data != ''){
				console.log("Data OK");

				$.each(data,function(){
					var html;
					var _list = this;
					html = '<div class="section"><div class="inner">';
					html = html + '<div class="sbs-location btn-linkV18 link2"><a href="/dramazone/">ALL</a><span></span><a href="/dramazone/index.asp?idx=<%=dramaidx%>"><%=dramatitle%></a></div>';

					if (_list.videoYN == 1){
						html = html + '<div class="thumb-wrap vod ftLt">';
					}else{
						html = html + '<div class="thumb-wrap slide ftLt">';
					}
						if (_list.videoYN == 1){
							html = html + '<iframe src="'+ _list.videourl +'" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen class="vod-player"></iframe>';
						}else{
							html = html + '<div class="drama-rolling">';
							html = html + '	<div class="swiper-container">';
							html = html + '		<div class="swiper-wrapper">';
							html = html + '			<div class="swiper-slide"><img src="'+ _list.mainimage +'" alt=""></div>';
							$.each(_list.dramaimages,function(){
								var _imgs = this;
								html = html + '			<div class="swiper-slide"><img src="'+ _imgs.images +'" alt=""></div>';
							});
							html = html + '		</div>';
							html = html + '	</div>';
							html = html + '</div>';
						}
						html = html + '	<div class="info">';
						html = html + '		<span class="thumb-chn"><img src="'+ _list.posterimage +'" alt="'+ _list.title +'" /></span>';
						html = html + '		<div class="tit">'+ _list.title +'<p class="date">'+ _list.regdate  +'</p></div>';
						html = html + '		<ul class="sns-list">';
						html = html + '			<li id="fbsns"><a href="" onclick=fnAmplitudeEventAction("click_dramazoneshare","action","facebook");return false;>페이스북<i class="icon icon-fb"></i></a></li>';
						html = html + '			<li id="clipboards" data-clipboard-text="http://www.10x10.co.kr/dramazone/detail.asp?dramaidx=<%=dramaidx%>&listidx=<%=listidx%>"><a href="" onclick=fnAmplitudeEventAction("click_dramazoneshare","action","urlcopy");return false;>주소복사<i class="icon icon-url"></i></a></li>';
						html = html + '		</ul>';
						html = html + '	</div>';
						html = html + '	<div class="desc">'+ _list.contents +'</div>';
						html = html + '</div>';
						html = html + '<div class="vod-items ftRt">';
						html = html + '<h3>이 영상에 노출된 상품은?</h3>';
						html = html + '<ul class="item-list">';
						<%'// <!--// 드라마존 이벤트 배너 -->%>
						if(_list.bannerisusing==="Y" && isDateValid(_list.evtsdt, _list.evtedt)){
							html = html + '<a href=/event/eventmain.asp?eventid='+_list.evtcode+'>';
							html = html + '<li class="bnr-drama-evt" style="background-color:'+getRandomColor()+'">';
							html = html + '	<span class="drama-label"><img src="'+ _list.bannerimage +'" alt="" /></span>';
							html = html + '	<div class="evt-tit">'+ _list.bannermaincopy 
							html = _list.bannersaleper != 0 ? html + ' <span class="color-red">'+ _list.bannersaleper +'%</span>' : html + "";
							html = html + '	</div>';							
							html = html + '	<p>'+ _list.bannersubcopy +'</p>';
							html = html + '</li>';
							html = html + '</a>';
						}
						<%'// <!--// 드라마존 이벤트 배너 -->%>	
						$.each(_list.dramaitem,function(){
							var _item = this;
							html = html + '<li>'
							html = html + '		<a href="'+ _item.link +'" onclick=fnAmplitudeEventMultiPropertiesAction("click_dramazoneitem","itemid|contentidx","'+_item.itemid+'|'+_list.listidx+'");>';
							html = html + '			<div class="txt">';
							html = html + '				<p class="name">'+ _item.itemname +'</p>';
							html = html + '				<s>보러가기</s>';
							html = html + '			</div>';
							html = html + '			<div class="thumb"><img src="'+ _item.itemimage +'" alt="" /></div>';
							html = html + '		</a>';
							html = html + '	</li>';
						});
						html = html + '</ul>';
						html = html + '</div>';

					html = html + '</div></div>';

					$drama.append(html);

					// fb share
					$('#fbsns').click(function(){
						popSNSPost('fb',_list.title,'<%=Server.URLEncode("http://www.10x10.co.kr/dramazone/detail.asp?dramaidx="&dramaidx&"&listidx="&listidx&"")%>','','');return false;
					});
				});

				// clipboard
				var btn = document.getElementById('clipboards');
				var clipboard = new Clipboard(btn);//로드 시 한번 선언

				clipboard.on('success', function(e) {
					alert('URL 주소가 복사되었습니다');
				});
				clipboard.on('error', function(e) {
					alert('fail');
				});

				// clipboard
			}else{
				console.log("JSON data not Loaded.");
			}
		} else {
			console.log("JSON data not Loaded." + status);
		}
	});

	// contentsplay
	var contentsplay = function(){
		var sbsVod = $('.vod-player');
		var sbsSlide = $('.drama-rolling');
		if (sbsVod.length > 0)
		{
			var url = sbsVod.attr('src').split('?')[0];
			var data = {
				method: 'play'
			};
			sbsVod[0].contentWindow.postMessage(JSON.stringify(data), url);
		}else{
			$('.drama-rolling .swiper-wrapper').slidesjs({
				width:1920,
				height:800,
				pagination:{effect:'fade'},
				navigation:{effect:'fade'},
				play:{interval:3000, effect:'fade', auto:false},
				effect:{fade: {speed:1200, crossfade:true}
				},
				callback: {
					complete: function(number) {
						var pluginInstance = $('.drama-rolling .swiper-wrapper').data('plugin_slidesjs');
						setTimeout(function() {
							pluginInstance.play(true);
						}, pluginInstance.options.play.interval);
					}
				}
			});
		}
	}

	setTimeout(function(){
		contentsplay();
	},1500);
	// contentsplay

	// more
	$.getJSON(json_data3, function (data, status, xhr) {
		if (status == "success") {
			if (data != ''){
				console.log("Data OK");

				$.each(data,function(){
					var html;
					var _morelist = this;

					console.log(_morelist.videoYN);

					html =			'		<li>';
					html = html + '				<a href="/dramazone/detail.asp?listidx='+ _morelist.listidx +'&dramaidx='+ _morelist.dramaidx +'" onclick=fnAmplitudeEventMultiPropertiesAction("click_dramazonerecent","idx|dramaidx","'+_morelist.listidx+'|'+_morelist.dramaidx+'");>';
					html = html + '				<div class="prev-thumb" id="prev-thumb">';
					html = html + '					<img src="'+ _morelist.image +'" alt="">';
		if (_morelist.videoYN == 1) html = html + '	<span class="icon icon-play"></span>';
					html = html + '				</div>';
					html = html + '				<p class="tit">'+ _morelist.dramatitle +'</p>';
					html = html + '				<div class="desc">'+ _morelist.contents +'</div>';
					html = html + '				</a>';
					html = html + '			</li>';

					$more.append(html);
				});
			}else{
				console.log("JSON data not Loaded.");
			}
		} else {
			console.log("JSON data not Loaded." + status);
		}
	});
}(jQuery));
</script>
<!-- #include virtual="/lib/inc/incFooter.asp" -->
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->