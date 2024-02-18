<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<!-- #include virtual="/shopping/category_code_check.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim vChkCpg, ab, vsortMet, vChkTestDate
	vChkCpg = request("cpg")
	vsortMet = request("srm")
	vChkTestDate = request("chkTestDate")

	If Trim(vDisp)="" Then
		vDisp="101"
	End If

	Dim conIp, arrIp, tmpIp
	conIp = Request.ServerVariables("REMOTE_ADDR")
	arrIp = split(conIp,".")
	tmpIp = Num2Str(arrIp(0),3,"0","R") & Num2Str(arrIp(1),3,"0","R") & Num2Str(arrIp(2),3,"0","R") & Num2Str(arrIp(3),3,"0","R")

	if Not(tmpIp=>"115094163042" and tmpIp<="115094163045") and Not(tmpIp=>"061252133001" and tmpIp<="061252133127") and Not(tmpIp=>"061252143070" and tmpIp<="061252143072") and Not(tmpIp=>"192168001001" and tmpIp<="192168001256") and tmpIp<>"211206236117" then
		If Response.Buffer Then
			Response.Clear
			Response.Expires = 0
		End If
		Response.write "<script>alert('관리자만 볼 수 있는 페이지 입니다.');location.href='/shopping/category_main.asp?disp="&vDisp&"';</script>"
		Response.End
	end if


	'// 전시 카테고리중 사용 안하는 카테고리는 메인 페이지로 넘긴다.
	Select Case Trim(vDisp)
		Case "101","102","103","104","121","122", "120", "112", "119", "117", "116", "118", "115", "110", "124", "125"

		Case Else
			Response.write "<script>alert('사용하지 않거나 존재하지 않는 카테고리 입니다.\n메인으로 이동합니다.');location.replace('/');</script>"
			Response.End
	End Select

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
					<h2><a href="/shopping/category_main.asp?disp=<%=vDisp%>"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ctgy_tit<%=vDisp%>.gif" alt="<%=CategoryNameUseLeftMenu(vDisp)%>" /></a></h2>
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
								server.Execute "/chtml_test/dispcate/loader/catemain_xml_367.asp"
								On Error Goto 0
							%>
							</div>
						</div>
						<div class="todayHotV15">
							<h3><img src="http://fiximage.10x10.co.kr/web2015/shopping/contit_todayhot.gif" alt="TODAY'S HOT" /></h3>
							<div class="todaySlideV15">
							<%
								On Error Resume Next
								server.Execute "/chtml_test/dispcate/main/catemain_todayhot_"&vDisp&".html"
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
								server.Execute "/chtml_test/dispcate/main/catemain_hotkeyword_"&vDisp&".html"
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
								server.Execute "/chtml_test/dispcate/main/catemain_eventbanner_"&vDisp&".html"
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