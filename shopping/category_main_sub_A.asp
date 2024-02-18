<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<!-- #include virtual="/shopping/category_code_check.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
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
		$('.multiSlideV15').slidesjs({
			width:635,
			height:380,
			navigation:{active:false},
			pagination:{active:true, effect:"fade"},
			play:{active:true, interval:3300, effect:"fade", auto:true, pauseOnHover:true},
			roundLengths:0,
			effect:{
				fade:{speed:700, crossfade:true}
			}
		});
		$('.multiSlideV15 .slidesjs-pagination > li').eq(0).addClass("multi00");
		$('.multiSlideV15 .slidesjs-pagination > li').eq(1).addClass("multi01");
		$('.multiSlideV15 .slidesjs-pagination > li').eq(2).addClass("multi02");
		$('.multiSlideV15 .slidesjs-pagination > li').eq(3).addClass("multi03");
		$('.multiSlideV15 .slidesjs-pagination > li').eq(4).addClass("multi04");
		$('.multiSlideV15 .slidesjs-pagination > li').eq(5).addClass("multi05");
	
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
	
		//md's pick control
		$('.mdPickSlideV15').slidesjs({
			start: iMDPRan,
			width:683,
			height:401,
			navigation:{active:false, effect:"fade"},
			pagination:{active:true, effect:"fade"},
			play:{active:false, effect:"fade", auto:false},
			effect:{
				fade:{speed:350, crossfade:true}
			}
		});
	
		//brand pick control
		$('.brdPickSlideV15').slidesjs({
			width:570,
			height:550,
			navigation:{active:false, effect:"fade"},
			pagination:{active:true, effect:"fade"},
			play:{active:false, effect:"fade", auto:false},
			effect:{
				fade:{speed:350, crossfade:true}
			}
		});
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
						<div class="multiWrapV15">
							<div class="multiSlideV15">
							<%
								On Error Resume Next
								server.Execute "/chtml/dispcate/loader/catemain_xml_367.asp"
								On Error Goto 0
							%>
							</div>
						</div>
						<div class="todayHotV15 typeA">
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

					<div class="section ctgyMdPickV15">
						<p class="bnrV15">
						<%
							On Error Resume Next
							server.Execute "/chtml/dispcate/loader/catemain_xml_368.asp"
							'' server.Execute "/chtml/dispcate/main/ban/catemain_linkbanner_368_"&vDisp&".html"		'배너 > XML일자별로 변경 (2015.05.04; 허진원)
							On Error Goto 0
						%>
						</p>
						<div class="mdPickWrapV15">
							<h3><img src="http://fiximage.10x10.co.kr/web2015/shopping/contit_mdpick.gif" alt="MD'S PICK" /></h3>
							<div class="mdPickSlideV15">
							<%
								On Error Resume Next
								server.Execute "/chtml/dispcate/main/catemain_mdpick_"&vDisp&".html"
								On Error Goto 0
							%>
							</div>
						</div>
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

					<div class="section ctgyBrandV15">
						<div class="bnrV15">
						<%
							On Error Resume Next
							server.Execute "/chtml/dispcate/loader/catemain_xml_369.asp"
							On Error Goto 0
						%>
						</div>
						<div class="brandWrapV15">
							<h3><img src="http://fiximage.10x10.co.kr/web2015/shopping/contit_brandpick.gif" alt="BRAND PICK" /></h3>
							<div class="brdPickSlideV15">
							<%
								'On Error Resume Next
								server.Execute "/chtml/dispcate/loader/catemain_xml_370.asp"
								'On Error Goto 0
							%>
							</div>
						</div>
					</div>

					<div class="section ctgyBestAwdV15">
						<iframe class="autoheight" src="/shopping/inc_10x10_Award.asp?disp=<%=vDisp%>" name="ifrm_award" width="100%" height="540px" frameborder="0" scrolling="no"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->