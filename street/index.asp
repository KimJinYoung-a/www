<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description :  브랜드스트리트메인
' History : 2013.09.13 김진영 생성
'###########################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/street/BrandStreetCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 브랜드 스트리트"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_shopping_v1.jpg"
	strPageDesc = "텐바이텐 모든 브랜드를 한자리에!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 브랜드 리스트"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/street/"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf

	'// 모달창이 필요한경우 아래 변수에 내용을 넣어주세요.
	strModalCont = "<div id='itemLyr' class='window loginLyr'>" &_
					"<div style='background:#fff; width:500px; height:400px'>모달 내용</div>" &_
					"	<p class='lyrClose'>close</p>" &_
					"</div>"

	'// 팝업창(레이어)이 필요한 경우 아래 변수에 내용을 넣어주세요.
	strPopupCont = "<div id='popLyr' class='window certLyr'>" &_
					"<div style='background:#fef; width:500px; height:400px'>팝업 내용</div>" &_
					"	<p class='lyrClose'>close</p>" &_
					"</div>"

'모달 및 팝업 레이어 호출 스크립트 함수 입니다.(tenbytencommon.js)		'※ 참고 : http://2013www.10x10.co.kr/pageSample.asp
'viewPoupLayer(div,sCont)
'- div : 오픈형식
'	* modal:모달창
'	* popup:단순팝업레이어)
'- sCont : 팝업에 들어가는 내용
'	* 내용은 반드시 div로 쌓여 있어야됨.
Dim paraTxt , cdl , charcd , page , ctab
	paraTxt = requestcheckvar(request("paraTxt"),50)
	page = request("page")
	ctab = request("ctab")
	cdl = requestcheckvar(Request("cdl"),4)

If page = "" Then page = 1
If ctab = "" Then ctab = "ctab3" ''ctab1=>ctab3 2017/05/15

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">

$(function() {
	$('.brandBnr .slide').slidesjs({
		width:"1140",
		height:"500",
		navigation: false,
		pagination: {
			effect: "fade"
		},
		effect: {
			fade: {
				speed:1000,
				crossfade:true
			}
		},
		play: {
			interval:3000,
			effect: "fade",
			auto: true
		}
	});

	//Interview
	var mySwiper2 = new Swiper('.swiper2',{
		pagination:false,
		loop:true,
		grabCursor:false,
		paginationClickable:true
	});
	$('.articleList .arrow-left').on('click', function(e){
		e.preventDefault()
		mySwiper2.swipePrev()
	});
	$('.articleList .arrow-right').on('click', function(e){
		e.preventDefault()
		mySwiper2.swipeNext()
	});

	// Look Book
	var mySwiper3 = new Swiper('.swiper3',{
		pagination:'.lookNum',
		loop:true,
		speed:700,
		autoplay:3000,
		grabCursor:true,
		paginationClickable:true
	});

	// Brand search
	$('.findWord li').click(function(){
		$('.findWord li').removeClass('current');
		$(this).addClass('current');
	});

	$('.brandschList .brdGroup:nth-child(odd)').css('background','#fafafa');

	if("<%=paraTxt%>" != "" ){
		document.getElementById('brdlist').scrollIntoView();
		SearchModm('','','','','<%=paraTxt%>')
	}
});

function trim(str) {
	return str.replace(/^\s\s*/,"").replace(/\s\s*$/,"");
}

function SearchModm(charcd, langs, cdl, txtYN, paraTxt) {
	var scTxt = "";
	if(txtYN == "Y"){
		if(trim(document.brsearchfrm.brname.value) == ""){
			alert('검색하고자 하는 단어를 입력해주세요');
			document.brsearchfrm.brname.value = "";
			document.brsearchfrm.brname.focus();
			return;
		}else{
			scTxt = document.brsearchfrm.brname.value;
		}
	}

	if(paraTxt != ""){
		scTxt = paraTxt
	}

	$("#brdlist").empty();
	var str = $.ajax({
		type: "POST",
		url: "/street/act_streetSearch.asp",
		data: "charcd="+escape(charcd)+"&lang="+langs+"&cdl="+cdl+"&scTxt="+escape(scTxt),
		dataType: "text",
		async: false
	}).responseText;
	if(str!="") {
		$("#brdlist").html(str);
	}
}

function SearchModrecmd(ctab, langs, cdl, txtYN, paraTxt, page) {
	var scTxt = "";
	if(txtYN == "Y"){
		if(trim(document.brsearchfrm.brname.value) == ""){
			alert('검색하고자 하는 단어를 입력해주세요');
			document.brsearchfrm.brname.value = "";
			document.brsearchfrm.brname.focus();
			return;
		}else{
			scTxt = document.brsearchfrm.brname.value;
		}
	}

	if(paraTxt != ""){
		scTxt = paraTxt
	}

	$("#brdlist").empty();
	var str = $.ajax({
		type: "POST",
		url: "/street/act_recommendSearch.asp",
		data: "ctab="+ctab+"&lang="+langs+"&cdl="+cdl+"&scTxt="+escape(scTxt)+"&page="+page,
		dataType: "text",
		async: false
	}).responseText;
	if(str!="") {
		$("#brdlist").html(str);
	}
}

function gosubmit(page){
	SearchModrecmd('<%=ctab%>', '', '<%=cdl%>', '', '',page);
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container brandMain skinV19">
		<div id="contentWrap">
			<div class="hotHgroupV19 va-md">
				<h2>BRAND STREET<p class="tit-sub">텐바이텐 브랜드를 한 자리에</p></h2>
			</div>
			<div class="snb-bar">
				<div class="snbbar-inner">
					<span></span>
					<div class="sortingV19">
						<div class="select-boxV19">
							<dl>
								<dt class=""><span>나의 찜브랜드</span></dt>
								<dd style="display: none;">
									<%=getMyzzimBrand %>
								</dd>
							</dl>
						</div>
					</div>
				</div>
			</div>
			<div class="brandContWrap">
				<!-- <script type="text/javascript" src="/chtml/street/js/main/brand_MainTop3Banner.js"></script> -->
				<!-- brand pick -->
				<div class="brandPick tMar60">
					<h3>BRAND PICK</h3>
					<ul>
						<script language="javascript" src="/chtml/street/js/main/brand_MainBranPick.js"></script>
					</ul>
				</div>
				<!--// brand pick -->

				<!-- interview / lookbook -->
				<!-- <div class="overHidden tMar60">
					<div class="mInterview">
						<h3>INTERVIEW</h3>
						<div class="articleList">
							<a class="arrow-left" href="#"></a>
							<a class="arrow-right" href="#"></a>
							<div class="swiper-container swiper2">
								<div class="swiper-wrapper">
									<script language="javascript" src="/chtml/street/js/main/brand_MainInterView.js"></script>
								</div>
							</div>
						</div>
					</div>
					<div class="mLookbook">
						<h3>LOOKBOOK</h3>
						<div class="lookbookWrap">
							<div class="swiper-container swiper3">
								<div class="swiper-wrapper">
									<script language="javascript" src="/chtml/street/js/main/brand_MainLookBook.js"></script>
								</div>
							</div>
							<div class="lookNum"></div>
						</div>
					</div>
				</div> -->
				<!--// interview / lookbook -->
				<!-- brand search -->
				<div class="brandSch tMar60" id="brdlist">
					<div class="schHeader">
						<h3>BRAND SEARCH</h3>
						<dl class="brandTag">
						<%
							Dim fso, oFile, vTag, vTmp, j
							Set fso = CreateObject("Scripting.FileSystemObject")
							If (fso.FileExists(server.mappath("/chtml/street/")&"\taglist.txt")) Then
								Set oFile = Server.CreateObject("ADODB.Stream")
									oFile.CharSet = "UTF-8"
									oFile.Open
									oFile.LoadFromFile(server.mappath("/chtml/street/")&"\taglist.txt")
									vTag = oFile.ReadText()
								Set oFile = nothing
							End If
							Set fso = nothing

							If UBound(Split(vTag,"|")) > 0 Then
						%>
							<dt># BRAND TAG</dt>
						<%
							End If
						%>
							<dd>
								<ul>
						<%
							On Error Resume Next
							For j = 0 To UBound(Split(vTag,"|"))
								vTmp = vTmp & "<li style='cursor:pointer;' onclick=javascript:SearchModm('','','','','"&Trim(Split(vTag,"|")(j))&"');>" & Trim(Split(vTag,"|")(j)) & "</li>"
							Next
							vTmp = Trim(vTmp)
							vTmp = Left(vTmp,Len(vTmp)-1)
							Response.Write vTmp
							On Error Goto 0
						%>
								</ul>
							</dd>
						</dl>
						<div class="schWrap">
							<form name="brsearchfrm" action="javascript:SearchModm('','','','Y','');" method="post">
							<div class="schBox">
								<input type="text" name="brname" class="hdschInput" value="<%= paraTxt %>" title="검색하고자 하는 단어를 입력해주세요." style="width:182px" maxlength="40">
								<input type="submit" value="" class="hdSchBtn">
							</div>
							</form>
						</div>
					</div>
					<div>
						<ul class="brandCate">
							<li class='current' onclick="SearchModrecmd('<%=ctab%>', '', '', '',  '' ,'');">전체</li>
							<%=fnBrandStreetCategoryHeaderAct("","SearchModrecmd",ctab,"","")%>
						</ul>
						<ul>
							<li style="border-bottom:1px solid #ddd;"></li>
						</ul>
						<div class="findWord">
							<dl>
								<dt><span class="crRed">가나다순</span> 찾기</dt>
								<dd>
									<ol>
										<li onclick="SearchModm('가', 'K', '', '', '');">가</li>
										<li onclick="SearchModm('나', 'K', '', '', '');">나</li>
										<li onclick="SearchModm('다', 'K', '', '', '');">다</li>
										<li onclick="SearchModm('라', 'K', '', '', '');">라</li>
										<li onclick="SearchModm('마', 'K', '', '', '');">마</li>
										<li onclick="SearchModm('바', 'K', '', '', '');">바</li>
										<li onclick="SearchModm('사', 'K', '', '', '');">사</li>
										<li onclick="SearchModm('아', 'K', '', '', '');">아</li>
										<li onclick="SearchModm('자', 'K', '', '', '');">자</li>
										<li onclick="SearchModm('차', 'K', '', '', '');">차</li>
										<li onclick="SearchModm('카', 'K', '', '', '');">카</li>
										<li onclick="SearchModm('타', 'K', '', '', '');">타</li>
										<li onclick="SearchModm('파', 'K', '', '', '');">파</li>
										<li onclick="SearchModm('하', 'K', '', '', '');">하</li>
									</ol>
								</dd>
							</dl>
							<dl>
								<dt><span class="crRed">알파벳순</span> 찾기</dt>
								<dd>
									<ol>
										<li onclick="SearchModm('A', 'E', '', '', '');">A</li>
										<li onclick="SearchModm('B', 'E', '', '', '');">B</li>
										<li onclick="SearchModm('C', 'E', '', '', '');">C</li>
										<li onclick="SearchModm('D', 'E', '', '', '');">D</li>
										<li onclick="SearchModm('E', 'E', '', '', '');">E</li>
										<li onclick="SearchModm('F', 'E', '', '', '');">F</li>
										<li onclick="SearchModm('G', 'E', '', '', '');">G</li>
										<li onclick="SearchModm('H', 'E', '', '', '');">H</li>
										<li onclick="SearchModm('I', 'E', '', '', '');">I</li>
										<li onclick="SearchModm('J', 'E', '', '', '');">J</li>
										<li onclick="SearchModm('K', 'E', '', '', '');">K</li>
										<li onclick="SearchModm('L', 'E', '', '', '');">L</li>
										<li onclick="SearchModm('M', 'E', '', '', '');">M</li>
										<li onclick="SearchModm('N', 'E', '', '', '');">N</li>
										<li onclick="SearchModm('O', 'E', '', '', '');">O</li>
										<li onclick="SearchModm('P', 'E', '', '', '');">P</li>
										<li onclick="SearchModm('Q', 'E', '', '', '');">Q</li>
										<li onclick="SearchModm('R', 'E', '', '', '');">R</li>
										<li onclick="SearchModm('S', 'E', '', '', '');">S</li>
										<li onclick="SearchModm('T', 'E', '', '', '');">T</li>
										<li onclick="SearchModm('U', 'E', '', '', '');">U</li>
										<li onclick="SearchModm('V', 'E', '', '', '');">V</li>
										<li onclick="SearchModm('W', 'E', '', '', '');">W</li>
										<li onclick="SearchModm('X', 'E', '', '', '');">X</li>
										<li onclick="SearchModm('Y', 'E', '', '', '');">Y</li>
										<li onclick="SearchModm('Z', 'E', '', '', '');">Z</li>
										<li onclick="SearchModm('Σ', 'E', '', '', '');">etc</li>
									</ol>
								</dd>
							</dl>

							<dl class="recommend">
								<dt><span class="crRed">추천순</span> 찾기</dt>
								<dd>
									<ul>
										<li class="new" onclick="SearchModrecmd('ctab1', '', '', '', '','');"><span <%=chkiif(ctab="ctab1","class='current'","")%>>NEW</span></li>
										<li class="best" onclick="SearchModrecmd('ctab3', '', '', '', '','');"><span <%=chkiif(ctab="ctab3","class='current'","")%>>BEST</span></li>
										<li class="zzim" onclick="SearchModrecmd('ctab2', '', '', '', '','');"><span <%=chkiif(ctab="ctab2","class='current'","")%>>ZZIM</span></li>
										<li class="artist" onclick="SearchModrecmd('ctab5', '', '', '', '','');"><span <%=chkiif(ctab="ctab5","class='current'","")%>>ARTIST</span></li>
										<li class="lookbook" onclick="SearchModrecmd('ctab7', '', '', '', '','');"><span <%=chkiif(ctab="ctab7","class='current'","")%>>LOOKBOOK</span></li>
										<li class="interview" onclick="SearchModrecmd('ctab8', '', '', '', '','');"><span <%=chkiif(ctab="ctab8","class='current'","")%>>INTERVIEW</span></li>
									</ul>
								</dd>
							</dl>

						</div>
					<%
					'	Dim oaward, b
					'	set oaward = new CAWard
					'		oaward.FPageSize = 5
					'		oaward.FDisp1 = ""
					'		oaward.FRectAwardgubun = "b"
					'		oaward.GetBrandAwardList
					'	If oaward.FResultCount > 0 Then
					%>
						<!-- <dl class="schBestBrand">
							<dt>BEST BRAND</dt>
							<dd>
								<ul>
								<%' For b = 0 to oaward.FResultCount-1 %>
									<li><em></em><a href="/street/street_brand_sub01.asp?makerid=<%'= oaward.FItemList(b).FMakerid %>"><strong><%'= oaward.FItemList(b).FSocname %></strong><br /><%'= oaward.FItemList(b).FSocname_kor %></a></li>
								<%' Next %>
								</ul>
							</dd>
						</dl> -->
					<%
						'Else
					%>
						<!-- <dl><dd><ul><li style="border-bottom:1px solid #ddd;"></li></ul></dd></dl> -->
					<%
						'End If
						'Set oaward = nothing
					%>
					<%
						Dim oawardn , i
						Set oawardn = new CAWard
						oawardn.FPageSize = 20
						oawardn.FCurrPage = page
						oawardn.FCdl = cdl
						oawardn.FRectAwardgubun = ctab
						If ctab = "ctab7" Or ctab = "ctab8" Then '//lookbook , interview
							oawardn.GetBrandChoiceList_add2013
						else
							oawardn.GetBrandChoiceList_new2013
						End If 

					%>
						<% If oawardn.FTotalCount > 0 Then %>
						<div class="brandschRecommend">
							<ul>
								<%
									For i = 0 To oawardn.FResultCount-1
								%>
								<li>
									<div class="brandPhoto"><a href="/street/street_brand_sub06.asp?makerid=<%=oawardn.FItemList(i).FMakerID%>&gaparam=street_list_<%=i+1%>" target="_blank">
										<img src="<%=oawardn.FItemList(i).FBrandImage%>" width="200" height="200" alt="7321 Design" onerror="this.src = 'https://fiximage.10x10.co.kr/m/2020/common/no_img.svg'" /></a>
									</div>
									<div class="description">
										<strong><%=oawardn.FItemList(i).FSocname%></strong>
										<span><%=oawardn.FItemList(i).FSocname_Kor%></span>
									</div>
								</li>
								<% Next %>
							</ul>
						</div>
						<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(oawardn.FCurrPage,oawardn.FTotalCount,oawardn.FPageSize,10,"gosubmit") %></div>
						<% Else %>
						<div align="center" class="brdGroup">
							<div class="fs11 tPad30">해당되는 브랜드가 없습니다.</div>
						</div>
						<%End If%>
					<%
						Set oawardn = nothing
					%>
					</div>
				</div>
				<!--// brand search -->
				<div id="movego"></div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->