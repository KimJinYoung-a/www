<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<!-- #include virtual="/shopping/category_code_check.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim vChkCpg, ab, vsortMet
	vChkCpg = request("cpg")
	ab = request("ab")
	vsortMet = request("srm")
%>
	<script type="text/javascript">
	$(function() {
		var iTodayCnt = $('.todayPhoto').length
		var iTodayRan = (Math.floor(Math.random() * iTodayCnt))+1;
		var iMDPCnt = $('.mdPickSlideV15 > ul').length
		var iMDPRan = (Math.floor(Math.random() * iMDPCnt))+1;
		
		//LNB Control
		$('.lnbV15 li').mouseover(function() {
			$(this).children('.lnbLyrWrapV15').show();
		});

		$('.lnbV15 li').mouseleave(function() {
			$(this).children('.lnbLyrWrapV15').hide();
		});

		//multi banner control
		$('.multiSlideV15a').slidesjs({
			width:420,
			height:420,
			navigation:false,
			pagination:{active:true, effect:"fade"},
			play:{interval:3000, effect:"fade", auto:true, pauseOnHover:true},
			effect:{
				fade:{speed:700, crossfade:true}
			}
		});
		$('.multiSlideV15a .slidesjs-pagination > li').eq(0).addClass("multi00");
		$('.multiSlideV15a .slidesjs-pagination > li').eq(1).addClass("multi01");
		$('.multiSlideV15a .slidesjs-pagination > li').eq(2).addClass("multi02");
		$('.multiSlideV15a .slidesjs-pagination > li').eq(3).addClass("multi03");
		$('.multiSlideV15a .slidesjs-pagination > li').eq(4).addClass("multi04");
		$('.multiSlideV15a .bnr00 .bnrTit').clone().appendTo('.multiWrapV15a .slidesjs-pagination li.multi00 a');
		$('.multiSlideV15a .bnr01 .bnrTit').clone().appendTo('.multiWrapV15a .slidesjs-pagination li.multi01 a');
		$('.multiSlideV15a .bnr02 .bnrTit').clone().appendTo('.multiWrapV15a .slidesjs-pagination li.multi02 a');
		$('.multiSlideV15a .bnr03 .bnrTit').clone().appendTo('.multiWrapV15a .slidesjs-pagination li.multi03 a');
		$('.multiSlideV15a .bnr04 .bnrTit').clone().appendTo('.multiWrapV15a .slidesjs-pagination li.multi04 a');

		//today's hot control
		$('.todaySlideV15').slidesjs({
			start: iTodayRan,
			width:170,
			height:300,
			navigation:{active:true, effect:"fade"},
			pagination:{active:true, effect:"fade"},
			play:{active:false, effect:"fade", auto:false},
			effect:{
				fade:{speed:300, crossfade:true}
			}
		});



		<% if vChkCpg <> "" or vsortMet <> "" then %>
			window.$('html,body').animate({scrollTop:1600}, 0)
		<% end if %>
	});
	</script>
</head>
<body>
<div class="wrap" id="ctgyMainV15">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->

	<div class="container">
		<div id="contentWrap">
			<div class="ctgyWrapV15">
				<div class="lnbWrapV15">
					<h2><a href="/shopping/category_main.asp?disp=<%=vDisp%>"><%=CategoryNameUseLeftMenu(vDisp)%></a></h2>
					<!-- #include virtual="/shopping/include_category_banner.asp" -->
					<!-- #include virtual="/chtml/dispcate/menu/loader/leftcate.asp" -->
					<ul class="addLnbV15">
						<li><a href="/shoppingtoday/shoppingchance_saleitem.asp?disp=<%=Left(vDisp,3)%>">SALE</a></li>
						<li><a href="/shoppingtoday/shoppingchance_allevent.asp?disp=<%=Left(vDisp,3)%>">EVENT</a></li>
					</ul>
				</div>

				<div class="content">
					<div class="section ctgySlideV15">
						<div class="multiWrapV15a">
							<div class="multiSlideV15a">
							<%
								On Error Resume Next
								server.Execute "/chtml/dispcate/loader/catemain_xml_367.asp"
								On Error Goto 0
							%>
							</div>
						</div>
						<div class="todayHotV15">
							<h3><img src="http://fiximage.10x10.co.kr/web2015/shopping/contit_todayhot.gif" alt="TODAY'S HOT" /></h3>
							<div class="todaySlideV15">
							<%
								On Error Resume Next
								server.Execute "/chtml/dispcate/main/catemain_todayhot_"&vDisp&".html"
								On Error Goto 0
							%>
							</div>
						</div>
					</div>

					<%' HOT KEYWORD(11/30 추가) %>
					<div class="section ctgyHotKwdV15a">
						<h3><img src="http://fiximage.10x10.co.kr/web2015/shopping/contit_hot_keyword.png" alt="HOT KEYWORD 지금 핫한 키워드" /></h3>
						<ul>
							<%
								On Error Resume Next
								server.Execute "/chtml/dispcate/main/catemain_hotkeyword_"&vDisp&".html"
								On Error Goto 0
							%>
						</ul>
					</div>

					<div class="section ctgySpcEvtV15">
						<div class="titWrapV15">
							<h3><img src="http://fiximage.10x10.co.kr/web2015/shopping/contit_spc_event.gif" alt="SPECIAL EVENT" /></h3>
							<a href="/shoppingtoday/shoppingchance_allevent.asp?disp=<%=vDisp%>" class="moreV15">more &gt;</a>
						</div>
						<div class="spcEvtWrap">
							<ul>
							<%
								On Error Resume Next
								server.Execute "/chtml/dispcate/main/catemain_eventbanner_"&vDisp&".html"
								On Error Goto 0
							%>
							</ul>
						</div>
					</div>
				</div>
				<%'// 상품 리스트 %>
				<div id="cateSubLst">
					<% server.execute("/shopping/category_sub_list.asp") %>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->