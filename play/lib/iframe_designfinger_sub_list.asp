<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/designfingers/designfingersCls.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<%
'#######################################################
'	History	:  2011.03.22 강준구 생성
'              2012.04.04 허진원 / 2012리뉴얼
'	Description : 디자인핑거스
'#######################################################

Dim playcode : playcode = 4 '메뉴상단 번호를 지정 해주세요
Dim clsDF, clsDFComm
Dim iDFSeq,sTitle,txtContents,dPrizeDate, sCommentTxt, sDFType, sTopImgURL
Dim arrImg3dv, arrImgAdd, arrWinner, intLoop, intLoop1
Dim i, k, iListCurrentPage,iComCurrentPage, iTotCnt, arrMainList, arrTop3CommList, arrRecentComm, arrMain
Dim iRecentDFS, sRecentImgURL, sRecentTitle, iCate, sSort, sSearchTxt, arrMainWishList, iTotWishCnt, sPSize,	mywishlist

	iDFSeq 	  			= NullFillWith(getNumeric(requestCheckVar(request("fingerid"),10)),0)
	iListCurrentPage	= getNumeric(requestCheckVar(request("iLC"),8))
	iCate				= NullFillWith(getNumeric(requestCheckVar(request("category"),10)),0)
	sSort				= NullFillWith(requestCheckVar(request("sort"),1),"1")
	sSearchTxt			= NullFillWith(requestCheckVar(request("searchtxt"),50),"")
	sPSize				= NullFillWith(getNumeric(requestCheckVar(request("psize"),8)),12)
	IF iListCurrentPage = "" THEN iListCurrentPage = 1
	set clsDF = new CDesignFingers

	'메인리스트
	clsDF.FRDFS 		= iDFSeq
	clsDF.FDFCodeSeq 	= 4		'list용 이미지
	clsDF.FCategory		= iCate
	clsDF.FSort			= sSort
	clsDF.FSearchTxt	= sSearchTxt
	clsDF.FCPage 		= iListCurrentPage
	clsDF.FPSize 		= sPSize
	arrMainList = clsDF.fnGetList
	iTotCnt = clsDF.FTotCnt

	If GetLoginUserID() <> "" Then
		clsDF.FUserId	 	= GetLoginUserID
	End If

	'위시리스트
	set mywishlist= new CPlayContents
	mywishlist.FRectidx = iDFSeq
	mywishlist.Fplaycode = playcode
	mywishlist.Fuserid = GetLoginUserID
	mywishlist.FPageSize 		= sPSize
	mywishlist.FCurrPage = iListCurrentPage
	mywishlist.fnGetFingersList


%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language="javascript">
<!--
	// 리스트 페이지이동
	function jsGoListPage(iP){
		location.href = "<%=CurrURL()%>?iDFS=<%=iDFSeq%>&iLC="+iP+"&psize=<%=sPSize%>&category=<%=iCate%>&sort=<%=sSort%>&searchtxt=<%=sSearchTxt%>";
	}

	function jsGoPage(iP){
		document.pageFrm.iLC.value = iP;
		document.pageFrm.submit();
	}

	//검색 및 정렬
	function goCategory() {
		searchFrm.submit();
	}

	function viewDiv(gb) {
		if(gb == "t") {
			$("#div_psize").show();
			$("#div_sort").hide();
		} else if(gb == "s") {
			$("#div_psize").hide();
			$("#div_sort").show();
		} else {
			$("#div_psize").hide();
			$("#div_sort").hide();
		}
	}

	function goPSizeSort(gb,code) {
		if(gb == "t") {
			location.href = "<%=CurrURL()%>?iDFS=<%=iDFSeq%>&iLC=1&psize="+code+"&category=<%=iCate%>&sort=<%=sSort%>&searchtxt=<%=sSearchTxt%>";
		} else if(gb == "s") {
			location.href = "<%=CurrURL()%>?iDFS=<%=iDFSeq%>&iLC=1&psize=<%=sPSize%>&category=<%=iCate%>&sort="+code+"&searchtxt=<%=sSearchTxt%>";
		}
	}

	function goFrmSearch(txt) {
		document.searchFrm.searchtxt.value = "" + txt + "";
		document.searchFrm.submit();
	}
//-->
</script>
</head>
<body>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
			<div class="dfEvtListFilter ">
				<ul class="fingersType">
					<li class="typeAll <%=ChkIIF(iCate=0,"current","")%>"><a href="<%=CurrURL()%>?category=&psize=<%=sPSize%>&sort=<%=sSort%>&searchtxt=<%=sSearchTxt%>" onFocus="blur()"><span>All</span></a></li>
					<li class="typeUnique <%=ChkIIF(iCate=13,"current","")%>"><a href="<%=CurrURL()%>?category=13&psize=<%=sPSize%>&sort=<%=sSort%>&searchtxt=<%=sSearchTxt%>" onFocus="blur()"><span>UNIQUE DESIGN</span></a></li>
					<li class="typeHigh <%=ChkIIF(iCate=11,"current","")%>" ><a href="<%=CurrURL()%>?category=11&psize=<%=sPSize%>&sort=<%=sSort%>&searchtxt=<%=sSearchTxt%>" onFocus="blur()"><span>HIGH FUNCTION</span></a></li>
					<li class="typeCreative <%=ChkIIF(iCate=12,"current","")%>" ><a href="<%=CurrURL()%>?category=12&psize=<%=sPSize%>&sort=<%=sSort%>&searchtxt=<%=sSearchTxt%>" onFocus="blur()"><span>CREATIVE IDEA</span></a></li>
					<li class="typeSpecial <%=ChkIIF(iCate=26,"current","")%>" ><a href="<%=CurrURL()%>?category=26&psize=<%=sPSize%>&sort=<%=sSort%>&searchtxt=<%=sSearchTxt%>" onFocus="blur()"><span>FOR SPECIAL DAY</span></a></li>
				</ul>
				<div class="dfSearch">
					<dl class="recommendWord">
						<dt>추천검색어</dt>
						<dd>					<%	'### 추천검색어 txt 파일
						Dim fso, oFile, vTag, vTmp, j
						Set fso = CreateObject("Scripting.FileSystemObject")
						If (fso.FileExists(server.mappath("/chtml/designfingers/")&"\taglist.txt")) Then
							Set oFile = fso.OpenTextFile(server.mappath("/chtml/designfingers/")&"\taglist.txt", 1)
								Do Until oFile.AtEndOfStream
									vTag = oFile.Readline
								Loop
							set oFile = nothing
						End If
						Set fso = nothing

						On Error Resume Next
						For j = 0 To UBound(Split(vTag,"/"))
							vTmp = vTmp & "<a href=""javascript:goFrmSearch('"&Trim(Split(vTag,"/")(j))&"');"" class=""link_gray_11px_blue_line"">" & Trim(Split(vTag,"/")(j)) & "</a>" & " / "
						Next
						vTmp = Trim(vTmp)
						vTmp = Left(vTmp,Len(vTmp)-1)
						Response.Write vTmp
						On Error Goto 0
					%></dd>
					</dl>
					<form name="searchFrm" action="<%=CurrURL()%>" method="post">
					<input type="hidden" name="category" value="<%=iCate%>">
					<input type="hidden" name="sort" value="<%=sSort%>">
					<input type="hidden" name="psize" value="<%=sPSize%>">
					<div class="schBox">
						<input type="text" name="searchtxt" value="<%=sSearchTxt%>" class="txtInp" value="" title="검색하고자 하는 단어를 입력해주세요." style="width:120px" />
						<input type="button" value="검색" onClick="searchFrm.submit();" class="btn btnW70 btnS1 btnBlue fn" />
					</div>
					</form>
				</div>
			</div>
			<div class="overHidden pad15">
				<p class="dfEvtSort"><a href="javascript:goPSizeSort('s','1');" onFocus="blur()" class="<%=ChkIIF(sSort=1,"current","")%>">최근등록순</a> <span>|</span> <a href="javascript:goPSizeSort('s','2');" onFocus="blur()" class="<%=ChkIIF(sSort=2,"current","")%>">코멘트순</a> <span>|</span> <a href="javascript:goPSizeSort('s','3');" onFocus="blur()" class="<%=ChkIIF(sSort=3,"current","")%>">관심순</a></p>
			</div>

			<div class="dfEvtListWrap">
				<ul class="evtList">
	            <%
	            	If iTotCnt > 0 Then

	            			For intLoop = 0 To UBound(arrMainList,2)
	            %>
					<li class="<%=ChkIIF(db2html(iDFSeq)=db2html(arrMainList(0,intLoop)),"current","")%>">
						<div class="evtBox">
							<p class="evtPhoto"><a href="/play/playdesignfingers.asp?fingerid=<%=arrMainList(0,intLoop)%>" target="_top" ><img src="<%=arrMainList(2,intLoop)%>" width="150px" height="150px" alt="<%=arrMainList(1,intLoop)%>" /><span></span></a></p>
							<div class="evtInfo">
								<p class="evtCondition">
								<% If arrMainList(4,intLoop) <> "" AND dateadd("d",1,arrMainList(4,intLoop)) =< now() Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/play/fingers_evt_tag_result.gif" alt="당첨자 발표" />
								<%
									Else
										If arrMainList(4,intLoop) <> "" Then
								%>
									<img src="http://fiximage.10x10.co.kr/web2013/play/fingers_evt_tag_ing.gif" alt="이벤트 진행중" />
									 <span class="lPad05">D-<%= DateDiff("d",now(),dateadd("d",1,arrMainList(4,intLoop))) %></span>
								<%
										End If
									End If
								%>
								</p>
								<p class="evtName"><a href="/play/playdesignfingers.asp?fingerid=<%=arrMainList(0,intLoop)%>" target="_top"><%=chrbyte(arrMainList(1,intLoop),45,"Y")%></a>
								<% If arrMainList(6,intLoop) = "Y" Then %>
								 <img src="http://fiximage.10x10.co.kr/web2013/play/fingers_ico_vod.png" alt="동영상 있음" class="tMar01" />
								 <% End If %>
								 </p>
								<p class="evtCmtFavor"><span class="evtCmt"><%=arrMainList(3,intLoop)%></span><span class="evtFavor <%=chkiif(mywishlist.FItemList(intLoop).Fchkfav > 0 ,"myFavor","")%>"><%=mywishlist.FItemList(intLoop).Ffavcnt%></span></p>
							</div>
						</div>
					</li>
				<%
							Next
					End If
				%>
				</ul>
			</div>

			<div class="pageWrapV15 tMar30">
				<%= fnDisplayPaging_New(iListCurrentPage,iTotCnt,sPSize,10,"jsGoPage") %>
			</div>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
<input type="hidden" name="iDFS" value="<%=iDFSeq%>">
<input type="hidden" name="iLC" value="<%=iListCurrentPage%>">
<input type="hidden" name="psize" value="<%=sPSize%>">
<input type="hidden" name="category" value="<%=iCate%>">
<input type="hidden" name="sort" value="<%=sSort%>">
<input type="hidden" name="searchtxt" value="<%=sSearchTxt%>">
</form>
</body>
</html>
<%
	set clsDF = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->