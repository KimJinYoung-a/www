<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<!-- #include virtual="/shopping/category_code_check.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim vChkCpg, ab, vsortMet
	vChkCpg = request("cpg")
	vsortMet = request("srm")

	If Trim(vDisp)="" Then
		vDisp="101"
	End If

	dim parentsPage : parentsPage = "categoryMain"

	'// 전시 카테고리중 사용 안하는 카테고리는 메인 페이지로 넘긴다.
	Select Case Trim(vDisp)
		Case "101","102","103","104","121","122", "120", "112", "119", "117", "116", "118", "110", "124", "125"

		Case Else
			Response.write "<script>alert('사용하지 않거나 존재하지 않는 카테고리 입니다.\n메인으로 이동합니다.');location.replace('/');</script>"
			Response.End
	End Select

	'// B2B모드이면 category_list.asp로 redirect
	If isBizMode="Y" Then
		Response.Redirect wwwUrl & "/shopping/category_list.asp?" & request.QueryString
	End If

	'// 구글 ADS 스크립트 관련(2018.09.21 신규버전 추가)
	googleADSCRIPT = " <script> "
	googleADSCRIPT = googleADSCRIPT & "   gtag('event', 'page_view', { "
	googleADSCRIPT = googleADSCRIPT & "     'send_to': 'AW-851282978', "
	googleADSCRIPT = googleADSCRIPT & "     'ecomm_pagetype': 'category', "
	googleADSCRIPT = googleADSCRIPT & "     'ecomm_prodid': '', "
	googleADSCRIPT = googleADSCRIPT & "     'ecomm_totalvalue': '' "
	googleADSCRIPT = googleADSCRIPT & "   }); "
	googleADSCRIPT = googleADSCRIPT & " </script> "	
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
			window.$('html,body').animate({scrollTop:1060}, 0)
		<% end if %>
	});

	function amplitudeDiaryStory() {
		fnAmplitudeEventAction('view_diarystory_main', 'place', 'category');
	}
	</script>
</head>
<body>
<div class="wrap" id="ctgyMainV15">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->

	<div class="container">
		<% If now() >= #2022-09-01 00:00:00# and now() < #2022-11-09 00:00:00# Then %>
		<style>
			#ctgyMainV15 .container {position:relative;}
		</style>
		<div style="width:1140px; margin:0 auto;"><a href="/diarystory2023/index.asp" onclick="amplitudeDiaryStory()"><img style="width:100%;" src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/categorybanner.png?v=1.3" alt="DIARY STORY 2023"></a></div>
		<% elseif application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
		<style>
			#ctgyMainV15 .container {position:relative;}
		</style>
		<% End If %>
		<div id="contentWrap">
			<div class="ctgyWrapV15">
				<div class="lnbWrapV15">
					<h2><a href="/shopping/category_main.asp?disp=<%=vDisp%>"><%=CategoryNameUseLeftMenu(vDisp)%></a></h2>
					<%'<!-- for dev msg : 20181116 크리스마스2018 페이지로 이동(br) --> %>

					<% if vDisp = "122" and now() <= #12/25/2018 00:00:00# then %>
					<p style="margin-top:12px;"><a href="/christmas/"><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/bnr_xmas.jpg" alt="Christmas Record - 당신의 크리스마스 한 컷"></a></p>					
					<% end if %>
					<%'// 좌측 카테고리 배너 %>
					<% server.Execute("/shopping/include_category_banner.asp") %>
					
					<!-- #include virtual="/chtml/dispcate/menu/loader/leftcate.asp" -->
					<ul class="addLnbV15">
						<li><a href="/shoppingtoday/shoppingchance_saleitem.asp?disp=<%=Left(vDisp,3)%><%=CateMain_GaParam(vDisp,"SALE","1")%>">SALE</a></li>
						<li><a href="/shoppingtoday/shoppingchance_allevent.asp?disp=<%=Left(vDisp,3)%><%=CateMain_GaParam(vDisp,"EVENT","1")%>">EVENT</a></li>
					</ul>
				</div>

				<div class="content">
					<!-- 텐텐다꾸 ver2 -->
					<div style="width:100%; margin-bottom:20px;"><a href="/diarystory2023/index.asp"><img style="width:100%;" src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/categorybanner_new.png" alt="DIARY STORY 2023"></a></div>
					<!-- //텐텐다꾸 ver2 -->
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
							<h3>TODAY'S HOT</h3>
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
<!-- 					<div class="section ctgyHotKwdV15a"> -->
<!-- 						<h3><img src="http://fiximage.10x10.co.kr/web2015/shopping/contit_hot_keyword.png" alt="HOT KEYWORD 지금 핫한 키워드" /></h3> -->
<!-- 						<ul> -->
							<%
								On Error Resume Next
								'server.Execute "/chtml/dispcate/main/catemain_hotkeyword_"&vDisp&".html"
								On Error Goto 0
							%>
<!-- 						</ul> -->
<!-- 					</div> -->

					<div class="section ctgySpcEvtV16">
						<div class="titWrapV15">
							<h3>SPECIAL EVENT</h3>
							<a href="/shoppingtoday/shoppingchance_allevent.asp?disp=<%=vDisp%>" class="moreV15" onclick="fnAmplitudeEventMultiPropertiesAction('click_category_main_specialevent_more','','');">more &gt;</a>
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