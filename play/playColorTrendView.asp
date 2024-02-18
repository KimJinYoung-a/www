<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual ="/lib/classes/color/colortrend_cls.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
Dim playcode : playcode = 3 '메뉴상단 번호를 지정 해주세요
dim i, lp, iLp, icol, oDoc, ocolor, colorcode, vColorCode, cColorT, SortMet, vCurrPage, vDisp, vCTcode, snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg, vViewNo, vNMainImg, vTitle, vTotRegCnt, vExist, vPre, vNext, vMap
	vCTcode = getNumeric(requestcheckvar(request("ctcode"),10))
	If vCTcode = "" Then
		Response.Write "<script>alert('잘못된 경로입니다.');top.location.href='/play/playColorTrend.asp';</script>"
		dbget.close
		Response.End
	End If
	vDisp = getNumeric(requestcheckvar(request("disp"),18))
	SortMet = requestCheckVar(request("srm"),2)
	If SortMet = "" Then
		SortMet = "rd"
	End If
	vCurrPage = getNumeric(requestcheckvar(request("cpg"),10))
	If vCurrPage = "" Then
		vCurrPage = "1"
	End IF

Dim categorysudong
categorysudong = true		'/카테고리 all 일경우 수동 카테고리사용	'/수정시 슬라이더쪽도 바꿔주세요.
	SET cColorT = New ccolortrend_list
	cColorT.frectctcode = vCTcode
	cColorT.frectuserid = GetLoginUserID()
	cColorT.GetColorTrendDetail
	If cColorT.FTotalCount > 0 Then
		vColorCode = cColorT.FOneItem.fcolorcode
		vViewNo = cColorT.FOneItem.Fviewno
		vNMainImg = cColorT.FOneItem.FNmainimg
		vMap = cColorT.FOneItem.FImageMap
		vTitle = cColorT.FOneItem.Fcolortitle
		vTotRegCnt = cColorT.FOneItem.Ftotregcnt
		vExist = cColorT.FOneItem.FExist
		vPre = cColorT.FOneItem.FPreCTcode
		vNext = cColorT.FOneItem.FNextCTcode
	End IF
	SET cColorT = Nothing
	
	If vTitle = "" Then
		Response.Write "<script>alert('잘못된 경로입니다.');top.location.href='/play/playColorTrend.asp';</script>"
		dbget.close
		Response.End
	End If

	
	colorcode = vColorCode
	snpTitle = Server.URLEncode(vTitle)
	snpLink = Server.URLEncode("http://10x10.co.kr/play/playColorTrendView.asp?ctcode=" & vCTcode)
	snpPre = Server.URLEncode("텐바이텐 컬러트랜드")
	snpTag = Server.URLEncode("텐바이텐 " & Replace(vTitle," ",""))
	snpTag2 = Server.URLEncode("#10x10")
	snpImg = Server.URLEncode(vNMainImg)


	'/컬러칩 리스트
	set ocolor = new ccolortrend_list
		ocolor.frectcolorcode = colorcode
		ocolor.GetColorchips

	strPageTitle = "텐바이텐 10X10 : 컬러트랜드"
	strPageDesc = "텐바이텐 PLAY - 컬러트랜드 상세페이지"
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/play/playColorTrendView.asp?ctcode="&vCTcode 	'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">
$(function() {
	$('.colorchips li input').click(function(){
		$('.colorchips li').removeClass('selected');
		$(this).parent().addClass('selected');
	});

	$('.colorStory .btnOpen').hide();
	$('.colorStory .btnClose').click(function(){
		$('.colorStory .story').hide();
		$('.colorStory .btnOpen').show();
		$('.colorStory .btnClose').hide();
	});

	$('.colorStory .btnOpen').click(function(){
		$('.colorStory .story, .colorStory .btnClose').show();
		$('.colorStory .btnOpen').hide();
	});

	var mySwiper01 = new Swiper('#swiperColor',{
		noSwiping:true,
		simulateTouch:false,
		pagination:false,
		loop:false,
		speed:700,
		paginationClickable: false
	});
	$('#swiperColorLt').on('click', function(e){
		e.preventDefault();
		location.href = "/play/playColorTrendView.asp?ctcode=<%=vPre%>";
	});
	$('#swiperColorRt').on('click', function(e){
		e.preventDefault();
		location.href = "/play/playColorTrendView.asp?ctcode=<%=vNext%>";
	});
});
	
function jsREgColorCode(cd){
	$(".favoriteAct").addClass("myFavor");
	TnAddFavoritecolor(cd);
}

function jsGoColorTrendItem(c,s,p){
	$('input[name="disp"]').val(c);
	$('input[name="srm"]').val(s);
	$('input[name="cpg"]').val(p);
	frm1.submit();
}

function jsGoPage(p){
	jsGoColorTrendItem('<%=vDisp%>','<%=SortMet%>',p);
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
				<h2 class="ftLt"><a href="/play/playColorTrend.asp"><img src="http://fiximage.10x10.co.kr/web2013/play/tit_color.gif" alt="COLOR TREND" /></a></h2>
				<a href="/play/playColorTrend.asp?colorcode=<%=vColorCode%>" class="btnListView">리스트 보기</a>
			</div>

			<div class="colorTrend">
			<!-- #include virtual="/play/playColorTrand_colortab.asp" -->
			</div>

			<div class="articleWrap">
				<div class="styleBnrWrap colorTrBnr">
					<div class="colorStory">
						<p class="story"><img src="http://fiximage.10x10.co.kr/web2013/play/txt_color_story_<%=vColorCode%>.gif" alt="<%=UCase(fnColorTrendColorName(vColorCode))%>" /></p>
						<button type="button" class="btnClose">닫기</button>
						<button type="button" class="btnOpen">열기</button>
					</div>
					<% If vPre > "0" Then %><a href="/play/playColorTrendView.asp?ctcode=<%=vPre%>" class="arrow-left" id="swiperColorLt"></a><% End If %>
					<% If vNext > "0" Then %><a href="/play/playColorTrendView.asp?ctcode=<%=vNext%>" class="arrow-right" id="swiperColorRt"></a><% End If %>
					<div class="swiper-container" id="swiperColor">
						<div class="swiper-wrapper">
							<div class="swiper-slide"><img src="<%=vNMainImg%>" alt="<%=UCase(fnColorTrendColorName(vColorCode))%> Image" usemap="#Mapmainimagenew" /></div>
							<%=vMap%>
						</div>
					</div>
					<div class="pagination" id="paginationColor"></div>
				</div>
				<div class="snsArea tPad13">
					<p class="colorTrTitle">No. <%=vViewNo%> <span class="lPad10"><%=vTitle%></a></span>
					<div class="sns">
						<ul>
							<!-- <li><a href="" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li> -->
							<li><a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
							<li><a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
							<li><a href="" onClick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
						</ul>
						<div id="mywish<%=vCTcode%>" class="favoriteAct <%=CHKIIF(vExist="Y","myFavor","")%>" <% If GetLoginUserID <> "" Then %>onclick="TnAddPlaymywish('<%=playcode%>','<%=vCTcode%>','');"<% Else %>onclick="jsChklogin();"<% End If %>><strong><%=FormatNumber(vTotRegCnt,0)%></strong></div>
					</div>
				</div>
				<form name="frm1" method="get" action="">
				<input type="hidden" name="ctcode" value="<%=vCTcode%>">
				<input type="hidden" name="disp" value="<%=vDisp%>">
				<input type="hidden" name="cpg" value="<%=vCurrPage%>">
				<div class="categorySorting">
					<ul>
						<li><a href="javascript:jsGoColorTrendItem('','<%=SortMet%>','1');" <%=CHKIIF(vDisp="","class='on'","")%>>ALL</a></li>
						<%=fnAwardBestCategoryLI(vDisp,"/play/playColorTrendView.asp?ctcode="&vCTcode&"&srm="&SortMet&"&cpg=1&")%>					
					</ul>
					<select title="정렬 옵션을 선택하세요." name="srm" class="optSelect" onChange="jsGoColorTrendItem('<%=vDisp%>',this.value,'1');">
						<% if vDisp = "" then %>
							<option value="rd" <%=CHKIIF(SortMet="rd","selected","")%>>추천상품순</option>
						<% end if %>
						<option value="be" <%=CHKIIF(SortMet="be","selected","")%>>인기상품순</option>
						<option value="ne" <%=CHKIIF(SortMet="ne","selected","")%>>신상품순</option>
						<option value="lp" <%=CHKIIF(SortMet="lp","selected","")%>>낮은가격순</option>
						<option value="hp" <%=CHKIIF(SortMet="hp","selected","")%>>높은가격순</option>
						<option value="hs" <%=CHKIIF(SortMet="hs","selected","")%>>높은할인률순</option>
					</select>
				</div>
				</form>
				<%
				'//상품목록리스트
				'/대카테고리가 없고, 추천상품순일경우  수기로 등록한 내역
				if vDisp = "" and categorysudong and SortMet = "rd" then
					set oDoc = new ccolortrend_list
						oDoc.FRectSortMethod = SortMet
						oDoc.frectcolorcode	= vColorCode
						oDoc.FCurrPage = vCurrPage
						oDoc.FPageSize = 28
						oDoc.GetColoritemlist
				
				'/검색엔진
				else
				
				set oDoc = new SearchItemCls
					oDoc.FRectSortMethod = SortMet
					oDoc.FRectSearchFlag = "n"
					oDoc.FRectSearchItemDiv = "y"
					oDoc.FRectSearchCateDep = "T"
					oDoc.FRectCateCode	= vDisp
					oDoc.FcolorCode	= Num2Str(vColorCode,3,"0","R")
					oDoc.FCurrPage = vCurrPage
					oDoc.FPageSize = 28
					oDoc.FScrollCount = 10
					oDoc.FListDiv = "colorlist"
					oDoc.FSellScope = "y"
					oDoc.FRectSearchTxt = ""
					oDoc.getSearchList
				end if
					
					IF oDoc.FResultCount > 0 then
				%>
				<div class="nonePdtInfoV15 playCrTrList">
					<div class="pdtWrap pdt120V15">
						<ul class="pdtList">
						<% For i = 0 to oDoc.FResultCount - 1 %>
							<li>
								<div class="pdtBox">
									<div class="pdtPhoto">
										<a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(i).FItemID %>">
											<span class="soldOutMask"></span>
											<img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FImageIcon2,"120","120","true","false")%>" alt="<%=oDoc.FItemList(i).Fitemname%>" />
										</a>
									</div>
								</div>
							</li>
						<% next %>
						</ul>
					</div>
				</div>
				<%
					End If
				%>
			</div>

			<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(vCurrPage,oDoc.FTotalCount,28,10,"jsGoPage") %></div>
			<div id="tempdiv" style="display:none" ></div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% Set oDoc = Nothing %>