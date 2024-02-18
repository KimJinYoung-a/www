<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  드라마존 Index
' History : 2018-05-09 이종화 생성 - PC
'			2018.06.01 한용민 수정
'###########################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	Dim sqlStr , arrList , jcnt , idx , dramatitle	

	idx = getNumeric(requestCheckVar(Request("idx"),10))
	If idx = "" Then idx = 0

	'// sbs 드라마존 서비스 종료
	If date() > "2019-03-31" and GetLoginUserLevel <> "7"  Then
		response.write "<script>alert('종료된 서비스 입니다.'); location.href='/'</script>"
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
%>
<!-- #include virtual="/lib/inc/head.asp" -->
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

	fnAmplitudeEventAction("view_dramazone","","");

	// main banner	
	if ($('.bnr-sbs > div').length > 1) {
		$('.bnr-sbs').slidesjs({
			width:1060,
			height:400,
			pagination:{effect:'fade'},
			navigation:{effect:'fade'},
			play:{interval:3000, effect:'fade', auto:1800},
			effect:{fade: {speed:1200, crossfade:true}
			}
		});
	}
		
	$(window).on('load resize',function(){
		$('.sbs-top').addClass("on");
		fold();
	})
});
</script>
</head>
<body>
<div class="wrap fullEvt">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container sbsDrama">
		<div id="contentWrap">
			<%'!-- sbs탑--%>
			<div class="sbs-top">
				<div class="inner">
					<h2><a href="/dramazone/"><img src="http://fiximage.10x10.co.kr/web2018/sbs/img_logo.png" alt="SBS Drama zone 드라마속 상품들을 텐바이텐에서 만나보세요!" /></a></h2>
					<div class="sortingbar">
						<div class="option-right ellipsis">드라마 목록 펼쳐보기<span class="arrow-bottom bottom1" id="basketDropIcon"></span></div>
					</div>
					<ul>
						<li class="<%=chkiif(idx = 0 ,"on","")%>"><a href="/dramazone/" onclick="fnAmplitudeEventAction('click_dramazonetop','idx','0');">ALL</a></li>
					<%
					if isarray(arrList) Then
						For jcnt = 0 To ubound(arrList,2)
							If clng(idx) = clng(arrList(0,jcnt)) Then dramatitle = arrList(2,jcnt) End If
							Response.write  "<li class='"& chkiif(clng(idx) = clng(arrList(0,jcnt)),"on","") &"'><a href='/dramazone/?idx="& arrList(0,jcnt) &"' onclick=fnAmplitudeEventAction('click_dramazonetop','idx','"&arrList(0,jcnt)&"');>"& arrList(2,jcnt) &"</a></li>"
						Next
					End If
					%>
					</ul>
				</div>
			</div>
			<%'!-- sbs탑--%>
<% if idx = 0 then %>
			<!--  롤링배너  -->
			<div class="bnr-sbs" >
				<div>
					<a href="/event/eventmain.asp?eventid=91346">
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2018/91346/etcitemban20181219120226.JPEG" alt="" style="margin-top: -60px"/></span>
						<div>
							<span>
								<h3>텐바이텐 x 황후의품격</h3>
								<p>색다른 황실 로맨스 속, 색다른 인테리어</p>
								<em>~66% SALE</em>
							</span>
						</div>
					</a>
				</div>
				<div>
					<a href="/event/eventmain.asp?eventid=90398">
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2018/90398/etcitemban20181112144946.JPEG" alt="" style="margin-top: -60px"/></span>
						<div>
							<span>
								<h3>한겨울에도 따스한 집</h3>
								<p>여우각시별 속 따스한 한여름의 방 인테리어</p>
								<em>~58% SALE</em>
							</span>
						</div>
					</a>
				</div>
			</div>
			<!-- // 롤링배너  -->
<% end if %>
			<div id="dramazone"></div>
		</div>
	</div>
</div>
<script>
(function($){
	var $drama = $("#dramazone");
	var dataurl = "/dramazone/";
	var json_data2 = dataurl+"json_data2.asp?dramaidx=<%=idx%>";

	$.getJSON(json_data2, function (data, status, xhr) {
			function getRandomColor(){
				var color = '#';
				var letters = ['FBEEF1', 'F9F0DC', 'E1F2F7'];
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
					if (_list.videoYN == 1){
						html = html + '<div class="thumb-wrap vod ftLt">';
					}else{
						html = html + '<div class="thumb-wrap slide ftLt">';
					}
						html = html + '<a href="'+ _list.dramaurl +'" onclick=fnAmplitudeEventAction("click_dramazonecontent","idx","'+_list.listidx+'");>';
						html = html + '<div class="prev-thumb" id="prev-thumb">';
						html = html + '	<img src="'+ _list.mainimage +'" alt=""/>';
if (_list.videoYN == 1) html = html + '	<span class="icon icon-play"></span>';
						html = html + '	<div class="info">';
						html = html + '		<span class="thumb-chn"><img src="'+ _list.posterimage +'" alt="'+ _list.title +'" /></span>';
						html = html + '		<p class="tit">'+ _list.title +'</p>';
						html = html + '	</div>';
						html = html + '</div>';
						html = html + '</a>';
						html = html + '	<div class="desc">'+ _list.contents +'</div>';
						html = html + '	<p class="date">'+ _list.regdate  +'</p>';
						html = html + '</div>';
						html = html + '<ul class="item-list ftRt">';

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
							html = html + '<li>';
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

					html = html + '</div></div>';

					$drama.append(html);
				});
			}else{
				console.log("JSON data not Loaded.");
			}
		} else {
			console.log("JSON data not Loaded." + status);
		}

		// bg-color
		$('.section:nth-child(2n)').addClass('bg-grey');

	});
}(jQuery));
</script>
<!-- #include virtual="/lib/inc/incFooter.asp" -->
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->