<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.Expires = -1
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cahce"
Response.AddHeader "cache-Control", "no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/designfingers/designfingersCls.asp" -->
<!-- #include virtual="/lib/classes/designfingers/dfCommentCls.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%

'#######################################################
'	History	:  2009.03.23 강준구 생성
'			   2009.09.21 한용민 / 이미지 맵 처리
'              2010.06.01 허진원 / 미오픈 Alert처리
'              2012.04.04 허진원 / 2012리뉴얼
'	Description : 디자인핑거스
'#######################################################


'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : DESIGN FINGERS"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

Dim playcode : playcode = 4 '메뉴상단 번호를 지정 해주세요
Dim clsDF, clsDFComm, oFingers, isMyComm, WinnerBody
Dim iDFSeq,sTitle,txtContents,dPrizeDate, sCommentTxt, sDFType, sTopImgURL, sRegdate, sOpenDate
Dim arrImg3dv, arrImgAdd, arrWinner, intLoop, iWishListCurrentPage, iLC
Dim i, k, iComCurrentPage, iTotCnt, arrMainList, arrCateList, arrRecentComm, arrMain, arrMainWishList, iTotWishCnt
Dim iRecentDFS, sRecentImgURL, sRecentTitle, iCate, sSort, sSearchTxt, bImg
Dim arrProdName, arrProdSize, arrProdColor, arrProdJe, arrProdGu, arrProdSpe, sEventLeftImg, sEventRightImg, arrSourceImgAdd

	iDFSeq 	  			= NullFillWith(Trim(requestCheckVar(request("fingerid"),4)),0)
	iComCurrentPage		= requestCheckVar(request("iCC"),10)
	iLC					= requestCheckVar(request("iLC"),10)
	iCate				= NullFillWith(requestCheckVar(request("category"),10),0)
	sSort				= NullFillWith(requestCheckVar(request("sort"),10),"1")
	sSearchTxt			= NullFillWith(requestCheckVar(request("searchtxt"),50),"")


	If IsNumeric(iDFSeq) = False Then
		response.write "<script>alert('올바른 접근이 아닙니다.');location.href='playdesignfingers.asp';</script>"
		dbget.close()	:	response.End
	End If


	IF iComCurrentPage = "" THEN iComCurrentPage = 1
	set clsDF = new CDesignFingers
		clsDF.FDFSeq = iDFSeq
		clsDF.fnGetDFContents

		iDFSeq			= clsDF.FDFSeq
		sDFType 		= clsDF.FDFType
		sTitle 			= clsDF.FTitle
		txtContents 	= clsDF.FContents
		dPrizeDate 		= clsDF.FPrizeDate
		sCommentTxt		= clsDF.FCommentTxt
		arrProdName		= clsDF.FProdName
		arrProdSize		= clsDF.FProdSize
		arrProdColor	= clsDF.FProdColor
		arrProdJe		= clsDF.FProdJe
		arrProdGu		= clsDF.FProdGu
		arrProdSpe		= clsDF.FProdSpe
		sRegdate		= clsDF.FRegdate
		sOpenDate		= clsDF.FOpenDate

		sTopImgURL		= clsDF.FTopImgURL
		sEventLeftImg	= clsDF.FEventLeftImg
		sEventRightImg	= clsDF.FEventRightImg
		arrImg3dv		= clsDF.FArrImg3dv
		arrImgAdd		= clsDF.FArrImgAdd
		arrSourceImgAdd	= clsDF.FArrSourceImgAdd
		arrWinner		= clsDF.FArrWinner
		bImg			= clsDF.FListImg

	set oFingers = new CPlayContents
		oFingers.FRectIdx = iDFSeq
		oFingers.Fplaycode = playcode
		oFingers.Fuserid = GetLoginUserID
		oFingers.GetFingersContent() '1row
If oFingers.FOneItem.Ffavcnt = "" Then
	oFingers.FOneItem.Ffavcnt = 0
End If


	'// 오픈되지 않은 핑거스 검사 (STAFF등급은 보임)
	IF GetLoginUserLevel<>"7" and sOpenDate>date() then
		response.write "<script>alert('준비중인 핑거스입니다.');location.href='playdesignfingers.asp';</script>"
		dbget.close()	:	response.End
	end if

	IF sRegdate="" or isNull(sRegdate) THEN
		response.write "<script>alert('해당 핑거스가 존재하지 않습니다.');location.href='playdesignfingers.asp';</script>"
		dbget.close()	:	response.End
	END IF

	'####### 핑거스 컨텐츠
	Dim vFImage, vFUseMap, vDesignFingersContents
	For intLoop = 1 To ubound(arrImgAdd)
		If arrImgAdd(intLoop,3) = "5" Then
			IF arrImgAdd(intLoop,1) <> "" THEN
				vFImage = vFImage & "<img src=""" & arrImgAdd(intLoop,1) & """ usemap=""#add" & arrImgAdd(intLoop,0) & "Map""><br>"
				If arrImgAdd(intLoop,2) <> "" Then
					vFUseMap = vFUseMap & "" & arrImgAdd(intLoop,2)
				End If
			Else
				vFImage = vFImage & "" & arrImgAdd(intLoop,2)
			END IF

		END IF
	Next

	vDesignFingersContents = vFImage & vFUseMap

	vFImage = ""
	For intLoop = 1 To ubound(arrSourceImgAdd)
		If arrSourceImgAdd(intLoop,3) = "25" Then
			IF arrSourceImgAdd(intLoop,1) <> "" THEN
				vFImage = vFImage & "<img src=""" & arrSourceImgAdd(intLoop,1) & """><br>"
			END IF
		END IF
	Next
	vFImage	 = Replace(vFImage,vbCrLf,"")

	'// Facebook 오픈그래프 메타태그 작성
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 디자인핑거스> " & replace(sTitle,"""","") & """ />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""http://www.10x10.co.kr/play/playdesignfingers.asp?fingerid=" & iDFSeq & """ />" & vbCrLf
	if Not(bImg="" or isNull(bImg)) then
		strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""" & bImg & """ />" & vbCrLf &_
													"<link rel=""image_src"" href=""" & bImg & """ />" & vbCrLf
	end if
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript" src="/lib/js/jquery.zclip.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript">

<!--
	// 3dview 클릭에 따라 원본이미지 및 bgcolor 변경
	function jsSet3dVImg(sImgURL, iNo){
		if (sImgURL !="")	{	document.all.img3dV.src = sImgURL;}
		for(i=0;i<10;i++){
			if(iNo == i){
				//alert(iNo);
				document.getElementById(i).className = "current";
				//document.all.tb3dv[i].className = "current";
				//$(this).parent().addClass('current');

			}else{
				document.getElementById(i).className = "";
				//$(this).parent().addClass('');
				//document.all.tb3dv[i].style.backgroundColor = "#dddddd";
			}
		}

	}

	function insertWish() {
	<% If IsUserLoginOK Then %>
		alert("1");
		document.fingerList.wishgubun.value = "I";
  		document.fingerList.target = "wishProc1";
  		document.fingerList.action ="/play/lib/iframe_designfinger_wishproc.asp";
  		document.fingerList.submit();
	<% Else %>
		if(confirm("로그인을 하셔야 합니다.\n로그인을 하시겠습니까?") == true) {
			top.location.href = "/login/loginpage.asp?backpath=<%=server.URLEncode(request.ServerVariables("URL"))%>&strGD=<%=server.URLEncode(request.ServerVariables("QUERY_STRING"))%>&strPD=<%=server.URLEncode(fnMakePostData)%>";
			return true;
		} else {
			return false;
		}
	<% End If %>
	}

	// 클립보드로 소스복사
	$(document).ready(function(){
	    $('#d_clip_button').zclip({
	        path:'/lib/js/ZeroClipboard.swf',
	        copy:'<%=wwwUrl%><%=CurrURLQ()%>',
	        afterCopy:function(){alert("URL이 복사되었습니다.\n보내실 곳에 Ctrl+V 하시면됩니다.");}
	    });
	});
//-->
</script>
</head>
<body>
<div class="wrap playWrapV15" id="playSub">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- #include virtual="/lib/inc/incPlayHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<!-- #include file="./lib/designfingers_top.asp" -->
			<form name="fingerList">
			<input type="hidden" name="fingerid" value="<%=iDFSeq%>">
			<input type="hidden" name="wishgubun" value="">
			<input type="hidden" name="iLC" value="">
			<input type="hidden" name="ismain" value="o">
			</form>


			<div class="fingersTitle">
				<p class="fingersName"><span>No. <% For i = 0 To Len(iDFSeq)-1 %> <% Response.Write Mid(iDFSeq,i+1,1) %> <% Next %> </span> <strong><%=sTitle%></strong></p>
				<ul class="fingersType">
					<li class="typeUnique <%=CHKIIF(sDFType="13","selected","")%>"><span>UNIQUE DESIGN</span></li>
					<li class="typeHigh <%=CHKIIF(sDFType="11","selected","")%>"><span>HIGH FUNCTION</span></li>
					<li class="typeCreative <%=CHKIIF(sDFType="12","selected","")%>"><span>CREATIVE IDEA</span></li>
					<li class="typeSpecial <%=CHKIIF(sDFType="26","selected","")%>"><span>FOR SPECIAL DAY</span></li>
				</ul>
			</div>

			<div class="fingersCont">
				<p><center><%= vDesignFingersContents %></center></p>
			</div>

			<div class="snsArea tMar80">
				<div class="sns">
					<%
						'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
						dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
						snpTitle = Server.URLEncode(sTitle)
						snpLink = Server.URLEncode("http://10x10.co.kr/df/" & iDFSeq)
						snpPre = Server.URLEncode("텐바이텐 디자인핑거스!")
						snpTag = Server.URLEncode("텐바이텐 " & Replace(sTitle," ",""))
						snpTag2 = Server.URLEncode("#10x10")
						snpImg = Server.URLEncode(arrImg3dv(1,1))
					%>
					<ul>
						<!-- <li><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>')" style="cursor:pointer;" alt="미투데이" /></li> -->
						<li><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>')" style="cursor:pointer;" alt="트위터" /></li>
						<li><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','')" style="cursor:pointer;" alt="페이스북" /></li>
						<li><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" onClick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>'); return false;" style="cursor:pointer;" alt="핀터레스트" /></li>
					</ul>
					<div id="mywish<%=iDFSeq%>" class="favoriteAct <%=chkiif(oFingers.FOneItem.Fchkfav > 0 ,"myFavor","")%>" <% If GetLoginUserID <> "" Then %>onclick="TnAddPlaymywish('<%=playcode%>','<%= iDFSeq %>','');" <% Else %>onclick="jsChklogin();"<% End If%>><strong><%=oFingers.FOneItem.Ffavcnt%></strong></div>
				</div>
			</div>
			<div id="tempdiv" style="display:none" ></div>

			<h3 class="tMar40 bPad10 bBdr2"><img src="http://fiximage.10x10.co.kr/web2013/play/fingers_conttit_detail.gif" alt="DETAIL VIEW" /></h3>
			<div class="detailViewWrap">
				<p class="detailBigPic"><img src="<%=arrImg3dv(1,1)%>" id="img3dV" alt="<%=sTitle%>" /></p>
				<div class="detailInfo">
					<dl>
						<dt><%=sTitle%></dt>
						<dd>
							<ul>
								<% If arrProdName <> "" Then %>
								<li><strong>상품</strong><%=arrProdName%></li>
								<%
								End If
								If arrProdSize <> "" Then
								%>
								<li><strong>크기</strong><%=arrProdSize%></li>
								<%
								End If
								If arrProdColor <> "" Then
								%>
								<li><strong>색상</strong><%=arrProdColor%></li>
								<%
								End If
								If arrProdJe <> "" Then
								%>
								<li><strong>재료</strong><%=arrProdJe%></li>
								<%
								End If
								If arrProdGu <> "" Then
								%>
								<li><strong>구성</strong><%=arrProdGu%></li>
								<%
								End If
								If arrProdSpe <> "" Then
								%>
								<li><strong>특징</strong><%=arrProdSpe%></li>
								<% End IF %>
							</ul>
						</dd>
					</dl>
					<ul class="fingersPdtImgList">
						<% For intLoop = 1 To 10 %>
							<% IF arrImg3dv(intLoop,1) <> "" THEN %>
						<li class="" id="<%=intLoop-1%>"><a href="javascript:jsSet3dVImg('<%=arrImg3dv(intLoop,1)%>',<%=intLoop-1%>)"><img src="<%=arrImg3dv(intLoop,2)%>" width="60px" height="60px" alt="DETAIL VIEW" /><span></span></a></li>
							<% Else %>
							<li id="<%=intLoop-1%>"></li>
							<% END IF %>
						<% Next %>
					<ul>
				</div>
			</div>

			<h3 class="tMar60 bPad10 bBdr2"><img src="http://fiximage.10x10.co.kr/web2013/play/fingers_conttit_product.gif" alt="PRODUCT" /></h3>
			<div class="dFPdtWrap pdt150 bBdr2">
				<ul class="pdtList">
				<%
				IF clsDF.FResultCount > 0 THEN
					For i = 0 To (clsDF.FResultCount-1)
				%>
					<li>
						<div class="pdtBox">
							<div class="pdtPhoto">
								<p><a href="javascript:TnGotoProduct('<%=clsDF.FCategoryPrdList(i).Fitemid%>');" onFocus="blur()"><img src="<%=clsDF.FCategoryPrdList(i).FImageIcon1%>" width="160px" height="160px" alt="처칠머그컵" /></a></p>
							</div>
							<div class="pdtInfo">
								<p class="pdtBrand"><a href="javascript:GoToBrandShop('<%=clsDF.FCategoryPrdList(i).FMakerID%>');"><%=clsDF.FCategoryPrdList(i).FBrandName%></a></p>
								<p class="pdtName tPad07"><a href="javascript:TnGotoProduct('<%=clsDF.FCategoryPrdList(i).Fitemid%>');"><%=clsDF.FCategoryPrdList(i).FItemName%></a></p>
								<%
									If clsDF.FCategoryPrdList(i).IsSaleItem or clsDF.FCategoryPrdList(i).isCouponItem Then
										Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(clsDF.FCategoryPrdList(i).FOrgPrice,0) & "원 </span></p>"
										If clsDF.FCategoryPrdList(i).IsSaleItem Then
											Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(clsDF.FCategoryPrdList(i).getRealPrice,0) & "원 </span>"
											Response.Write "<strong class='cRd0V15'>[" & clsDF.FCategoryPrdList(i).getSalePro & "]</strong></p>"
										End If
										If clsDF.FCategoryPrdList(i).isCouponItem Then
												Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(clsDF.FCategoryPrdList(i).GetCouponAssignPrice,0) & "원 </span>"
												Response.Write "<strong class='cGr0V15'>[" & clsDF.FCategoryPrdList(i).GetCouponDiscountStr & "]</strong></p>"
										End If
									Else
										Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(clsDF.FCategoryPrdList(i).getRealPrice,0) & "원 </span>"
									End If
								%>
								<p class="pdtStTag tPad10">
									<%
										If clsDF.FCategoryPrdList(i).IsSoldOut Then
											Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
										Else
											IF clsDF.FCategoryPrdList(i).isSaleItem Then
												Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' />"
											End If
											IF clsDF.FCategoryPrdList(i).isCouponItem Then
												Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' />"
											End If
											IF clsDF.FCategoryPrdList(i).isLimitItem Then
												Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' />"
											End If
											IF clsDF.FCategoryPrdList(i).isNewItem Then
												Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' />"
											End If
										End If
									%>
								</p>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=clsDF.FCategoryPrdList(i).Fitemid%>');return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" onclick="popEvaluate('<%=clsDF.FCategoryPrdList(i).FItemid%>');return false;"><span><%= FormatNumber(clsDF.FCategoryPrdList(i).FEvalCnt,0) %></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%= clsDF.FCategoryPrdList(i).FItemID %>');return false;"><span><%= FormatNumber(clsDF.FCategoryPrdList(i).FFavCount,0) %></span></a></li>
								</ul>
							</div>
						</div>
					</li>
				<% Next

				End IF
				 %>
				</ul>
			</div>
			<% If sEventRightImg <> "" AND iDFSeq > 723 Then %>
			<div class="dfEvtWrap tMar60">
				<% If dPrizeDate <> "" AND dateadd("d",1,dPrizeDate) > now() Then %>
				<p class="dfEvtBnr"><span class="ct">D-<%= DateDiff("d",now(),dateadd("d",1,dPrizeDate)) %></span>
				<% End If %>

				<% If  dPrizeDate <> "" AND dateadd("d",1,dPrizeDate) <= now() Then %>
				<p class="dfEvtBnr"><span class="fs11 lt">당첨자 발표</span>
				<% End If %>
					<img src="<%=sEventRightImg%>" alt="<%=sTitle%>" /></p>

		<% If IsArray(arrWinner) Then %>
				<%
					WinnerBody = ""
					For intLoop = 0 To UBound(arrWinner,2)

						If intLoop <> 0 Then
							WinnerBody = WinnerBody & "&nbsp;/&nbsp;"
						End If
						WinnerBody = WinnerBody & "" & printUserId(arrWinner(0,intLoop),2,"*") & ""
							If intLoop = 9 then
								WinnerBody = WinnerBody & "" & "<br>" & ""
							End If

					Next
				%>

				<div class="evtResultWrap">
					<dl>
						<dt><span><em><%=iDFSeq%>회 디자인핑거스 당첨을 축하드립니다!</em></span></dt>
						<dd><%=WinnerBody%></dd>
					</dl>
				</div>
		<% End If %>

			</div>
			<% End If %>

			<div class="basicCmtWrap tMar40">
				<!-- #include file="./lib/inc_designfingers_comment.asp" -->
			</div>
<!-- 	// 코멘트 끝								-->
<table width="960" border="0" align="center" cellpadding="0" cellspacing="0">
<tr><!--핑거스 리스트-->
	<td style="padding-top:50px;"><iframe src="/play/lib/iframe_designfinger_sub_list.asp?fingerid=<%=iDFSeq%>" class="autoheight" name="iframeDB1" width="100%" height="100%" frameborder="0" marginheight="0" marginwidth="0" scrolling="no"></iframe></td>
</tr>
</table>
<script type="text/javascript" src="/lib/js/jquery.iframe-auto-height.js"></script>
<iframe src="about:blank" name="iframeDB" frameborder="0" width="0" height="0"></iframe>
<iframe id="wishProc1" name="wishProc1" src="about:blank" frameborder="0" width="0" height="0"></iframe>

<% set clsDF = nothing %>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->