<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	strPageTitle = "텐바이텐 10X10 : BEST AWARD : 베스트 컬러"
	'// 변수 선언 //
	Dim catecode, lp, atype, vTotalCount, vFListDiv, vC, cp, icoCp, rCp
	dim classStr, adultChkFlag, adultPopupLink, linkUrl
	cp=  requestCheckVar(request("cp"),4)
	'if cp="" then cp=0
	if cp="" then
		'// 랜덤으로 컬러 선정
		Randomize
		cp = Int(30* Rnd+1)
	end if
	icoCp = split("28,01,02,10,26,03,04,29,24,05,21,06,07,25,08,23,22,09,11,12,27,13,14,15,16,17,18,19,20,30,31",",")(cp)
	rCp = split("23,01,02,10,21,03,04,24,19,05,16,06,07,20,08,18,17,09,11,12,22,13,14,15,25,26,27,28,29,30,31",",")(cp)

	'// 파라메터 접수
	catecode = requestCheckVar(Request("disp"),3)
	''if catecode="" then catecode="118"			''??

	dim colorCD 	: colorCD = NullFillWith(requestCheckVar(request("iccd"),9),rCp)
	dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)
	dim imgSz	: imgSz = chkIIF(icoSize="M",180,150)

	if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)
	vFListDiv = "bestlist"

	'// 상품검색
	dim oDoc,iLp
	set oDoc = new SearchItemCls
	oDoc.FRectSortMethod	= "be"
	oDoc.FRectSearchCateDep = "T"

	oDoc.FRectMakerid	= ""
	oDoc.FCurrPage = 1
	oDoc.FPageSize = 100
	oDoc.FScrollCount = 10
	oDoc.FListDiv = vFListDiv
	oDoc.FLogsAccept = false
	oDoc.FAddLogRemove = true			'추가로그 기록안함
	oDoc.FRectColsSize = 6
	if colorCD>0 then
		oDoc.FcolorCode = Num2Str(colorCD,3,"0","R")
	end if
	oDoc.FRectcatecode	= catecode
	oDoc.FSellScope="Y"
	oDoc.getSearchList
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script>
$(function() {
	//colorchip control
	$('.colorchipV15 li p input').click(function(){
		$(this).parent().parent().toggleClass('selected');
	});

	$(".colorNavV15 ul li").hide();
	$(".colorNavV15 ul li:first").show();

	$(".colorNavV15 .prevBtn").click(function(){
		$(".colorNavV15 ul li:last").prependTo(".colorNavV15 ul");
		$(".colorNavV15 ul li").hide().eq(0).show();
	});

	$(".colorNavV15 .nextBtn").click(function(){
		$(".colorNavV15 ul li:first").appendTo(".colorNavV15 ul");
		$(".colorNavV15 ul li").hide().eq(0).show();
	});

	//급상승 상품 mark control
	$(".bestUpV15 .ranking").append("<span>급상승한 상품입니다</span>");
	$(".pdtList p").click(function(e){
		e.stopPropagation();				
	});			
});

$(function() {
	// Item Image Control
	$(".pdtList li .pdtPhoto").mouseenter(function(e){
		$(this).find("dfn").fadeIn(150);
	}).mouseleave(function(e){
		$(this).find("dfn").fadeOut(150);
	});
});
var arr = new Array(23,01,02,10,21,03,04,24,19,05,16,06,07,20,08,18,17,09,11,12,22,13,14,15,25,26,27,28,29,30,31);

function visible(qwe){
	var frm = document.frm;
	var sarry        = document.images["mainimg"].src.split("\\");      // 선택된 이미지 화일의 풀 경로
	var maxlength    = sarry.length-1;       // 이미지 화일 풀 경로에서 이미지만 뽑아내기
	var ext = sarry[maxlength].split(".");
	var str = ext[3];
	var cnt = 2;
	var lng = str.length;
	//var xx = str.substring(lng-cnt,lng)
	var xx =document.sFrm.cp.value;
	var zz;

	if(qwe == "ll"){
		if(xx == 0){
			xx = 30;
		}else{
			xx= Number(xx)-1;
			document.sFrm.cp.value = xx;
		}
	}else if(qwe == "rr"){

		if(xx == 30){
			xx = 0;
		}else{
			xx= Number(xx)+1;
			document.sFrm.cp.value = xx;
		}
	}
		location.href ="/award/bestaward_colorpalette.asp?iccd="+ arr[xx] + "&cp=" + xx + "&disp=<%=catecode%>"
	//document.images["mainimg"].src = "http://fiximage.10x10.co.kr/web2015/shopping/ico_color_"+arr[xx]+".gif";
}

// 컬러칩 선택
function fnSelColorChip(iccd) {
	document.sFrm.iccd.value=iccd;

		for(var i=0; i< 31; i++){
			if(arr[i] == iccd)
			document.sFrm.cp.value= i;
		}
	document.sFrm.submit();
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap" class="bestAwdV17">
			<div class="hotHgroupV19">
				<div class="tab-area">
					<ul>
						<li class="on"><a href="#">베스트 셀러</a></li>
						<li><a href="/bestreview/bestreview_main.asp?disp=<%=catecode%>">베스트 리뷰</a></li>
					</ul>
				</div>
				<h2>BEST SELLER</h2>
				<div class="grpSubWrapV19">
					<ul>
						<li><a href="/award/awardlist.asp?atype=b&disp=<%=catecode%>">베스트셀러</a></li>
						<li><a href="/award/awardlist.asp?atype=g&disp=<%=catecode%>">고객만족 베스트</a></li>
						<li><a href="/award/awardlist.asp?atype=f&disp=<%=catecode%>">베스트 위시</a></li>
						<li><a href="/award/bestaward_new.asp?disp=<%=catecode%>">신상품 베스트</a></li>
						<li><a href="/award/bestaward_price.asp?disp=<%=catecode%>">가격대별 베스트</a></li>
						<li class="on"><a href="/award/bestaward_colorpalette.asp?disp=<%=catecode%>">베스트 컬러</a></li>
						<li><a href="/award/awardbrandlist.asp?disp=<%=catecode%>">베스트 브랜드</a></li>
					</ul>
				</div>
			</div>
			<div class="snb-bar">
				<div class="snbbar-inner">
					<div class="btn-ctgr"><span><%=fnSelectCategoryName(catecode)%></span></div>
				</div>
				<div class="lnbHotV19">
					<div class="inner">
						<ul>
							<li class="<%= chkIIF(catecode="","on","") %>"><a href="?atype=<%=atype%>">전체 카테고리</a></li>
							<%=fnAwardBestCategoryLI(catecode,"/award/bestaward_colorpalette.asp?atype="&atype&"&cp="&cp&"&iccd="&colorCD&"&")%>
						</ul>
					</div>
				</div>
			</div>
			<div class="hotSectionV15">
				<form name="sFrm" method="get" action="?" style="margin:0px;">
				<input type="hidden" name="iccd" value="<%=colorCD%>">
				<input type="hidden" name="reset" value="">
				<input type="hidden" name="cp" value="<%=cp%>">
				<input type="hidden" name="disp" value="<%=catecode%>">
				<div class="hotArticleV15">
					<ul class="colorchipV15">
						<li class="wine <%=CHKIIF(colorCD=23,"selected","")%>"><p><input type="radio" id="wine" onClick="fnSelColorChip(23)" /></p><label for="wine">Wine</label></li>
						<li class="red <%=CHKIIF(colorCD=1,"selected","")%>"><p><input type="radio" id="red" onClick="fnSelColorChip(1)" /></p><label for="red">Red</label></li>
						<li class="orange <%=CHKIIF(colorCD=2,"selected","")%>"><p><input type="radio" id="orange" onClick="fnSelColorChip(2)" /></p><label for="orange">Orange</label></li>
						<li class="brown <%=CHKIIF(colorCD=10,"selected","")%>"><p><input type="radio" id="brown" onClick="fnSelColorChip(10)" /></p><label for="brown">Brown</label></li>
						<li class="camel <%=CHKIIF(colorCD=21,"selected","")%>"><p><input type="radio" id="camel" onClick="fnSelColorChip(21)" /></p><label for="camel">Camel</label></li>
						<li class="yellow <%=CHKIIF(colorCD=3,"selected","")%>"><p><input type="radio" id="yellow" onClick="fnSelColorChip(3)" /></p><label for="yellow">Yellow</label></li>
						<li class="beige <%=CHKIIF(colorCD=4,"selected","")%>"><p><input type="radio" id="beige" onClick="fnSelColorChip(4)" /></p><label for="beige">Beige</label></li>
						<li class="ivory <%=CHKIIF(colorCD=24,"selected","")%>"><p><input type="radio" id="ivory" onClick="fnSelColorChip(24)" /></p><label for="ivory">Ivory</label></li>
						<li class="khaki <%=CHKIIF(colorCD=19,"selected","")%>"><p><input type="radio" id="khaki" onClick="fnSelColorChip(19)" /></p><label for="khaki">Khaki</label></li>
						<li class="green <%=CHKIIF(colorCD=5,"selected","")%>"><p><input type="radio" id="green" onClick="fnSelColorChip(5)" /></p><label for="green">Green</label></li>
						<li class="mint <%=CHKIIF(colorCD=16,"selected","")%>"><p><input type="radio" id="mint" onClick="fnSelColorChip(16)" /></p><label for="mint">Mint</label></li>
						<li class="skyblue <%=CHKIIF(colorCD=6,"selected","")%>"><p><input type="radio" id="skyblue" onClick="fnSelColorChip(6)" /></p><label for="skyblue">Skyblue</label></li>
						<li class="blue <%=CHKIIF(colorCD=7,"selected","")%>"><p><input type="radio" id="blue" onClick="fnSelColorChip(7)" /></p><label for="blue">Blue</label></li>
						<li class="navy <%=CHKIIF(colorCD=20,"selected","")%>"><p><input type="radio" id="navy" onClick="fnSelColorChip(20)" /></p><label for="navy">Navy</label></li>
						<li class="violet <%=CHKIIF(colorCD=8,"selected","")%>"><p><input type="radio" id="violet" onClick="fnSelColorChip(8)" /></p><label for="violet">Violet</label></li>
						<li class="lilac <%=CHKIIF(colorCD=18,"selected","")%>"><p><input type="radio" id="lilac" onClick="fnSelColorChip(18)" /></p><label for="lilac">Lilac</label></li>
						<li class="babypink <%=CHKIIF(colorCD=17,"selected","")%>"><p><input type="radio" id="babypink" onClick="fnSelColorChip(17)" /></p><label for="babypink">Babypink</label></li>
						<li class="pink <%=CHKIIF(colorCD=9,"selected","")%>"><p><input type="radio" id="pink" onClick="fnSelColorChip(9)" /></p><label for="pink">Pink</label></li>
						<li class="white <%=CHKIIF(colorCD=11,"selected","")%>"><p><input type="radio" id="white" onClick="fnSelColorChip(11)" /></p><label for="white">White</label></li>
						<li class="grey <%=CHKIIF(colorCD=12,"selected","")%>"><p><input type="radio" id="grey" onClick="fnSelColorChip(12)" /></p><label for="grey">Grey</label></li>
						<li class="charcoal <%=CHKIIF(colorCD=22,"selected","")%>"><p><input type="radio" id="charcoal" onClick="fnSelColorChip(22)" /></p><label for="charcoal">Charcoal</label></li>
						<li class="black <%=CHKIIF(colorCD=13,"selected","")%>"><p><input type="radio" id="black" onClick="fnSelColorChip(13)" /></p><label for="black">Black</label></li>
						<li class="silver <%=CHKIIF(colorCD=14,"selected","")%>"><p><input type="radio" id="silver" onClick="fnSelColorChip(14)" /></p><label for="silver">Silver</label></li>
						<li class="gold <%=CHKIIF(colorCD=15,"selected","")%>"><p><input type="radio" id="gold" onClick="fnSelColorChip(15)" /></p><label for="gold">Gold</label></li>
						<li class="check <%=CHKIIF(colorCD=25,"selected","")%>"><p><input type="radio" id="check" onClick="fnSelColorChip(25)" /></p><label for="check">Check</label></li>
						<li class="stripe <%=CHKIIF(colorCD=26,"selected","")%>"><p><input type="radio" id="stripe" onClick="fnSelColorChip(26)" /></p><label for="stripe">Stripe</label></li>
						<li class="dot <%=CHKIIF(colorCD=27,"selected","")%>"><p><input type="radio" id="dot" onClick="fnSelColorChip(27)" /></p><label for="dot">Dot</label></li>
						<li class="flower <%=CHKIIF(colorCD=28,"selected","")%>"><p><input type="radio" id="flower" onClick="fnSelColorChip(28)" /></p><label for="flower">Flower</label></li>
						<li class="drawing <%=CHKIIF(colorCD=29,"selected","")%>"><p><input type="radio" id="drawing" onClick="fnSelColorChip(29)" /></p><label for="drawing">Drawing</label></li>
						<li class="animal <%=CHKIIF(colorCD=30,"selected","")%>"><p><input type="radio" id="animal" onClick="fnSelColorChip(30)" /></p><label for="animal">Animal</label></li>
						<li class="geometric <%=CHKIIF(colorCD=31,"selected","")%>"><p><input type="radio" id="geometric" onClick="fnSelColorChip(31)" /></p><label for="geometric">Geometric</label></li>
					</ul>

					<!--<div class="colorNavV15">
						<ul>
							<li><img id="mainimg" src="http://fiximage.10x10.co.kr/web2015/shopping/ico_color_<%=Format00(2,icoCp)%>.png" alt="ALL" /></li>
						</ul>
						<button type="button" onclick="visible('ll');" class="prevBtn">Prev</button>
						<button type="button" onclick="visible('rr');" class="nextBtn">Next</button>
					</div>-->

					<div class="ctgyBestV15">
						<div class="pdtWrap pdt240V15">
							<ul class="pdtList">
						<%
							vTotalCount = oDoc.FResultCount
							For vC = 0 To vTotalCount-1
							If vTotalCount>0 AND vTotalCount > vC Then
								classStr = ""
								linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(vC).FItemID 
								adultChkFlag = false
								adultChkFlag = session("isAdult") <> true and oDoc.FItemList(vC).FadultType = 1

								If oDoc.FItemList(vC).GetLevelUpCount > "29" then
									classStr = addClassStr(classStr,"bestUpV15")							
								end if
								If oDoc.FItemList(vC).isSoldOut=true then
									classStr = addClassStr(classStr,"soldOut")							
								end if				
								if adultChkFlag then
									classStr = addClassStr(classStr,"adult-item")								
								end if						
																														
								If vC < 3 then
						%>
								<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
									<p class="ranking">BEST <%= vC+1 %></p>
									<div class="pdtBox">
										<% '// 해외직구배송작업추가(원승현) %>
										<% If oDoc.FItemList(vC).IsDirectPurchase Then %>
											<i class="abroad-badge">해외직구</i>
										<% End If %>
										<div class="pdtPhoto">
											<% if adultChkFlag then %>									
											<div class="adult-hide">
												<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
											</div>
											<% end if %>										
											<a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(vC).FItemID %>">
												<span class="soldOutMask"></span>
												<img src="<%=oDoc.FItemList(vC).FImageBasic%>" alt="<%=oDoc.FItemList(vC).FItemName%>" />
												<% if oDoc.FItemList(vC).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(vC).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(vC).FItemName,"""","")%>" /></dfn><% end if %>
											</a>
										</div>
										<div class="pdtInfo">
											<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oDoc.FItemList(vC).FMakerid %>"><%= oDoc.FItemList(vC).FBrandName %></a></p>
											<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(vC).FItemId%>"><%= oDoc.FItemList(vC).FItemName %></a></p>
											<%
												If oDoc.FItemList(vC).IsSaleItem or oDoc.FItemList(vC).isCouponItem Then
													'If oDoc.FItemList(vC).Fitemcoupontype <> "3" Then
													'	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(vC).FOrgPrice,0) & "원 </span></p>"
													'End If
													IF oDoc.FItemList(vC).IsSaleItem Then
														Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(vC).FOrgPrice,0) & "원 </span></p>"
														Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(vC).getRealPrice,0) & "원 </span>"
														Response.Write "<strong class='cRd0V15'>[" & oDoc.FItemList(vC).getSalePro & "]</strong></p>"
											 		End IF
											 		IF oDoc.FItemList(vC).IsCouponItem Then
											 			if Not(oDoc.FItemList(vC).IsFreeBeasongCoupon() or oDoc.FItemList(vC).IsSaleItem) Then
											 				Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(vC).FOrgPrice,0) & "원 </span></p>"
											 			end if
														Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(vC).GetCouponAssignPrice,0) & "원 </span>"
														Response.Write "<strong class='cGr0V15'>[" & oDoc.FItemList(vC).GetCouponDiscountStr & "]</strong></p>"
											 		End IF
												Else
													Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(vC).getRealPrice,0) & "원 </span>"
												End If
											%>
											<p class="pdtStTag tPad10">
											<%
												IF oDoc.FItemList(vC).isSoldOut Then
													Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
												Else
											 		IF oDoc.FItemList(vC).isTenOnlyItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif' alt='ONLY' /> "
											 		IF oDoc.FItemList(vC).isSaleItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' /> "
											 		IF oDoc.FItemList(vC).isCouponItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' /> "
											 		IF oDoc.FItemList(vC).isLimitItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' /> "
											 		IF oDoc.FItemList(vC).isNewItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' /> "
											 		IF oDoc.FItemList(vC).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
												End If
											%>
											</p>
										</div>
										<ul class="pdtActionV15">
											<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oDoc.FItemList(vC).FItemid%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
											<li class="postView"><a href="" onclick="popEvaluate('<%=oDoc.FItemList(vC).FItemid%>'); return false;"><span><%=oDoc.FItemList(vC).FEvalCnt%></span></a></li>
											<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oDoc.FItemList(vC).FItemid %>'); return false;"><span><%= oDoc.FItemList(vC).FfavCount %></span></a></li>
										</ul>
									</div>
								</li>
							<%
								end if
							End If
							Next
							%>
							</ul>
						</div>
					</div>

					<div class="pdtWrap pdt200V15">
						<ul class="pdtList">
					<%
						vTotalCount = oDoc.FResultCount
						For vC = 0 To vTotalCount-1
						If vTotalCount>0 AND vTotalCount > vC Then
							classStr = ""
							linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(vC).FItemID 
							adultChkFlag = false
							adultChkFlag = session("isAdult") <> true and oDoc.FItemList(vC).FadultType = 1

							If oDoc.FItemList(vC).GetLevelUpCount > "29" then
								classStr = addClassStr(classStr,"bestUpV15")							
							end if
							If oDoc.FItemList(vC).isSoldOut=true then
								classStr = addClassStr(classStr,"soldOut")							
							end if				
							if adultChkFlag then
								classStr = addClassStr(classStr,"adult-item")								
							end if						
									
							If vC > 2 then
					%>
							<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
								<p class="ranking"><%= vC+1 %>.</p>
								<div class="pdtBox">
									<% '// 해외직구배송작업추가(원승현) %>
									<% If oDoc.FItemList(vC).IsDirectPurchase Then %>
										<i class="abroad-badge">해외직구</i>
									<% End If %>
									<div class="pdtPhoto">
										<% if adultChkFlag then %>									
										<div class="adult-hide">
											<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
										</div>
										<% end if %>									
										<a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(vC).FItemID %>">
											<span class="soldOutMask"></span>
											<img src="<%=oDoc.FItemList(vC).FImageIcon1%>" alt="<%=oDoc.FItemList(vC).FItemName%>" />
											<% if oDoc.FItemList(vC).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(vC).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(vC).FItemName,"""","")%>" /></dfn><% end if %>
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oDoc.FItemList(vC).FMakerid %>"><%= oDoc.FItemList(vC).FBrandName %></a></p>
										<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(vC).FItemId%>"><%= oDoc.FItemList(vC).FItemName %></a></p>
										<%
											If oDoc.FItemList(vC).IsSaleItem or oDoc.FItemList(vC).isCouponItem Then
												'If oDoc.FItemList(vC).Fitemcoupontype <> "3" Then
												'	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(vC).FOrgPrice,0) & "원 </span></p>"
												'End If
												IF oDoc.FItemList(vC).IsSaleItem Then
													Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(vC).FOrgPrice,0) & "원 </span></p>"
													Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(vC).getRealPrice,0) & "원 </span>"
													Response.Write "<strong class='cRd0V15'>[" & oDoc.FItemList(vC).getSalePro & "]</strong></p>"
										 		End IF
										 		IF oDoc.FItemList(vC).IsCouponItem Then
										 			if Not(oDoc.FItemList(vC).IsFreeBeasongCoupon() or oDoc.FItemList(vC).IsSaleItem) Then
										 				Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(vC).FOrgPrice,0) & "원 </span></p>"
										 			end if
													Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(vC).GetCouponAssignPrice,0) & "원 </span>"
													Response.Write "<strong class='cGr0V15'>[" & oDoc.FItemList(vC).GetCouponDiscountStr & "]</strong></p>"
										 		End IF
											Else
												Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(vC).getRealPrice,0) & "원 </span>"
											End If
										%>
										<p class="pdtStTag tPad10">
										<%
											IF oDoc.FItemList(vC).isSoldOut Then
												Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
											Else
										 		IF oDoc.FItemList(vC).isTenOnlyItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif' alt='ONLY' /> "
										 		IF oDoc.FItemList(vC).isSaleItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' /> "
										 		IF oDoc.FItemList(vC).isCouponItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' /> "
										 		IF oDoc.FItemList(vC).isLimitItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' /> "
										 		IF oDoc.FItemList(vC).isNewItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' /> "
										 		IF oDoc.FItemList(vC).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
											End If
										%>
										</p>
									</div>
									<ul class="pdtActionV15">
											<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oDoc.FItemList(vC).FItemid%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
											<li class="postView"><a href="" onclick="popEvaluate('<%=oDoc.FItemList(vC).FItemid%>'); return false;"><span><%=oDoc.FItemList(vC).FEvalCnt%></span></a></li>
											<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oDoc.FItemList(vC).FItemid %>'); return false;"><span><%= oDoc.FItemList(vC).FfavCount %></span></a></li>
									</ul>
								</div>
							</li>
						<%
							end if
						End If
						Next
						%>
						</ul>
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