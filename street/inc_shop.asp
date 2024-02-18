<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>

<%
dim oGrCat, oGrBrn, oGrEvt, oGrPly, oGrCd3, lp2, iconcount
dim rowCnt, colCnt, catTTCnt, brnTTCnt, evtTTCnt, plyTTcnt, strBrnBest, brnBtCnt, tmpRank
dim moreYn : moreYn = "N"
catTTCnt=0: brnTTCnt=0: evtTTCnt=0: plyTTcnt=0: brnBtCnt=0

'// 카테고리별 검색결과(2Depth)
set oGrCat = new SearchItemCls
	oGrCat.FRectSearchTxt = DocSearchText
	oGrCat.FRectExceptText = ExceptText
	oGrCat.FRectSortMethod = SortMet
	oGrCat.FRectSearchItemDiv = SearchItemDiv
	oGrCat.FRectSearchCateDep = SearchCateDep
	oGrCat.FCurrPage = 1
	oGrCat.FPageSize = 200
	oGrCat.FScrollCount =10
	oGrCat.FListDiv = ListDiv
	oGrCat.FRectMakerid = makerid
	oGrCat.FGroupScope = "2"	'카테고리 그룹 범위(depth)
	oGrCat.FLogsAccept = False '그룹형은 절대 !!! False
	oGrCat.getGroupbyCategoryList		'//카테고리 접수

'// 카테고리 확장검색 //
dim tempCD1, tempCD2, tempCD3, rowScore(), rowText(), rowTemp()
if oGrCat.FResultCount>0 then
	'카테고리별 총합 산출 및 중분류 결과 배열 생성
	rowCnt = 1 :	colCnt = 1
	reDim rowScore(rowCnt), rowTemp(4,rowCnt)
	tempCD1 = CStr(oGrCat.FItemList(0).FCateCd1)
	tempCD2 = "": chkCd3=false
	rowScore(rowCnt) = 0

	for Lp=0 to oGrCat.FResultCount-1
		if oGrCat.FItemList(lp).FCateCd1<>"999" then
			if tempCD1<>CStr(oGrCat.FItemList(lp).FCateCd1) then
				tempCD1 = CStr(oGrCat.FItemList(lp).FCateCd1)
				rowCnt = rowCnt + 1
				reDim Preserve rowScore(rowCnt), rowTemp(4,rowCnt)

				'리셋
				rowScore(rowCnt) = 0
				tempCD2 = ""
				colCnt = 1
			end if

			'행구분 시작
			if (colCnt mod 4)=1 then
				tempCD2 = tempCD2 & "<div class=""category"">"
			end if

			'2dep 내용 삽입
			if oGrCat.FItemList(lp).FCateCd2<>"" and ubound(split(oGrCat.FItemList(lp).FCateName,"^^"))>1 then
				tempCD2 = tempCD2 & "<span><input type=""checkbox"" class=""check"" name=""ctCd2" & left(oGrCat.FItemList(lp).FCateCode,3) & """ id=""cate" & left(oGrCat.FItemList(lp).FCateCode,6) & """ value=""" & left(oGrCat.FItemList(lp).FCateCode,6) & """ " & chkIIF(chkArrValueLen(arrCate,oGrCat.FItemList(lp).FCateCode,6),"checked","") & " /> <a href="""">" & split(oGrCat.FItemList(lp).FCateName,"^^")(1) & " (" & formatNumber(oGrCat.FItemList(lp).FSubTotal,0) & ")</a></span>"
			end if
			rowScore(rowCnt) = rowScore(rowCnt) + oGrCat.FItemList(lp).FSubTotal
			'행구분 종료
			dim chkEnd, chkCd3
			if Lp<(oGrCat.FResultCount-1) then
				if tempCD1<>CStr(oGrCat.FItemList(lp+1).FCateCd1) then
					chkEnd = true
				else
					chkEnd = false
				end if
			else
				chkEnd = true
			end if
			''//선택이 2depth 1개인 경우에 3depth 표시
			if ubound(split(arrCate,","))=0 then
				if chkArrValueLen(arrCate,oGrCat.FItemList(lp).FCateCode,6) then
					if chkCd3=false then
						'// 카테고리별 검색결과(3Depth)
						set oGrCd3 = new SearchItemCls
						oGrCd3.FRectSearchTxt = DocSearchText
						oGrCd3.FRectExceptText = ExceptText
						oGrCd3.FRectSortMethod = SortMet
						oGrCd3.FRectSearchItemDiv = SearchItemDiv
						oGrCd3.FRectSearchCateDep = SearchCateDep
						oGrCd3.FRectCateCode	= left(oGrCat.FItemList(lp).FCateCode,6)
						oGrCd3.FCurrPage = 1
						oGrCd3.FPageSize = 200
						oGrCd3.FScrollCount =10
						oGrCd3.FListDiv = ListDiv
						oGrCd3.FRectMakerid = makerid
						oGrCd3.FGroupScope = "3"	'카테고리 그룹 범위(depth)
						oGrCd3.FLogsAccept = False '그룹형은 절대 !!! False
						oGrCd3.getGroupbyCategoryList		'//카테고리 접수

						if oGrCd3.FResultCount>0 then
							tempCD3 = "<div class=""depthWrap"">"
							tempCD3 = tempCD3 & "	<div class=""depth active0" & ((colCnt-1) mod 4) & """>"

							for Lp2=0 to oGrCd3.FResultCount-1
								if oGrCd3.FItemList(lp2).FCateCd3<>"" then
									tempCD3 = tempCD3 & "		<a href="""" selcd3=""" & left(oGrCd3.FItemList(lp2).FCateCode,9) & """ " & chkIIF(chkArrValueLen(arrCate,oGrCd3.FItemList(lp2).FCateCode,9),"class=""crRed""","") & ">" & split(oGrCd3.FItemList(lp2).FCateName,"^^")(2) & " (" & formatNumber(oGrCd3.FItemList(lp2).FSubTotal,0) & ")</a>"
								end if
							next

							tempCD3 = tempCD3 & "	</div>"
							tempCD3 = tempCD3 & "</div>"

						end if

						set oGrCd3 = nothing

						chkCd3 = true
					end if
				end if

			end if

			if (colCnt mod 4)=0 or chkEnd then
				tempCD2 = tempCD2 & tempCD3 & "</div>"
				chkCd3 = false: tempCD3=""
			end if

			'2dep갯수 증가
			colCnt = colCnt + 1

			'// 중분류 결과 배열값 저장
			rowTemp(1,rowCnt) = rowScore(rowCnt)
			rowTemp(2,rowCnt) = oGrCat.FItemList(lp).FCateCd1
			rowTemp(3,rowCnt) = split(oGrCat.FItemList(lp).FCateName,"^^")(0)
			rowTemp(4,rowCnt) = tempCD2
		end if
	next

	'// 결과 배열 정렬
	reDim rowText(rowCnt,4)
	for lp=1 to rowCnt
		rowText(lp,1) = rowTemp(1,lp)
		rowText(lp,2) = rowTemp(2,lp)
		rowText(lp,3) = rowTemp(3,lp)
		rowText(lp,4) = rowTemp(4,lp)
	next

	if rowCnt>1 then
		Call ArrayQuickSort(rowText,1,rowCnt,1)
	end if

	'카테고리 펼침메뉴 속성 지정 (3줄이 넘으면 표시, 펼침밖의 분류를 선택했으면->js에서 처리)
	moreYn = chkIIF(rowCnt>3,"Y","N")

	'// 본분 시작
	rowCnt = 1
	tempCD1 = CStr(oGrCat.FItemList(0).FCateCd1)
%>
<script>
$(function(){
	//시작 위치 설정
	<% if CurrPage>1 or DocSearchText<>"" or arrCate<>"" then %>
	$(window).scrollTop($("#lyrCate").offset().top-10);
	<% end if %>
});
</script>
	<div id="lyrCate" class="schDetailBox tMar20">
		<!-- 카테고리 검색 결과 -->
		<table>
			<colgroup>
				<col width="212" /><col width="" />
			</colgroup>
			<tbody>
				<%
					For lp=Ubound(rowScore) to 1 step -1
						if rowText(lp,2)<>"" then
				%>
					<tr <%=chkIIF((Ubound(rowScore)-lp)>=3 and moreYn="Y","class='trCateMore' style='display:none;'","") %>>
						<th><input type="checkbox" class="check" name="ctCd1<%=rowText(lp,2)%>" id="cate<%=rowText(lp,2)%>" value="<%=rowText(lp,2)%>" <%=chkIIF(chkArrValue(arrCate,rowText(lp,2)),"checked","")%> /> <a href=""""><%=rowText(lp,3)%></a> <span class="fn">(<%=formatNumber(rowText(lp,1),0)%>)</span></th>
						<td><%=rowText(lp,4)%></td>
					</tr>
				<%
						end if
					Next
				%>
			</tbody>
		</table>
		<!-- //카테고리 검색 결과 -->
		<% if moreYn="Y" then %><p class="schMoreView btnMoreCate">더보기</p><% end if %>
	</div>
	<div id="lyrJoinSearch" class="tPad10 rPad10 rt">
		<button type="button" id="btnDelTerm" <%=chkIIF(arrCate<>"" ,"","style=""display:none;""")%> class="btn btnW130 btnS1 btnGry">선택 조건 해제</button>
		<input type="button" id="btnActTerm" class="btn btnW130 btnS1 btnRed" value="선택 조건 검색" />
	</div>
	<% Set oGrCat = nothing %>
<% end if %>

<div class="ctgyWrapV15">
	<!-- #Include virtual="/search/inc_searchFilter.asp" -->
	<!-- #include virtual="/diarystory2023/inc/diary2023_filter.asp" -->
	<% if Not(searchFlag="ea" or searchFlag="ep") then %>
		<%
		Dim icol
		IF oDoc.FResultCount >0 then
		%>
			<% '<!-- for dev msg : 이미지 사이즈별 클래스 적용(pdt240V15/pdt200V15/pdt150V15)--> %>
			<div class="pdtWrap <%=chkIIF(icoSize="M","pdt240V15","pdt150V15")%>">
				<ul class="pdtList">
					<%
					For icol=0 To oDoc.FResultCount -1
						classStr = ""
						linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(icol).FItemID &"&disp="& oDoc.FItemList(icol).FcateCode & logparam
						adultChkFlag = false
						adultChkFlag = session("isAdult") <> true and oDoc.FItemList(icol).FadultType = 1

						If oDoc.FItemList(icol).FItemDiv="21" then
							classStr = addClassStr(classStr,"deal-item")
						end if
						If oDoc.FItemList(icol).isSoldOut=true then
							classStr = addClassStr(classStr,"soldOut")
						end if
						if adultChkFlag then
							classStr = addClassStr(classStr,"adult-item")
						end if
					%>
					<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
						<div class="pdtBox">
							<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
							<% if oDoc.FItemList(icol).Fiskimtentenrecom="Y" or oDoc.FItemList(icol).IsSaleItem or oDoc.FItemList(icol).isCouponItem then %>
								<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
									<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
										<span class="badge_anniv21<% If oDoc.FItemList(icol).FDeliverFixDay <> "L" Then %><% If oDoc.FItemList(icol).FFreeDeliveryYN="Y" Then %> free<% End If %><% End If %>">
											<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
										</span>
									<% end if %>
								<% else %>
									<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
										<span class="badge_anniv21<% If oDoc.FItemList(icol).FDeliverFixDay <> "L" Then %><% If oDoc.FItemList(icol).FFreeDeliveryYN="Y" Then %> free<% End If %><% End If %>">
											<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
										</span>
									<% end if %>
								<% end if %>
							<% end if %>
							<% if oDoc.FItemList(icol).FGiftDiv>0 then %>
								<% If now() >= #2022-09-01 00:00:00# and now() < #2022-11-09 00:00:00# Then %>
									<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
										<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
										<% else %>
											<i class="diary2023Badge"></i>
										<% end if%>
									<% else %>
										<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
										<% else %>
											<i class="diary2023Badge"></i>
										<% end if%>
									<% end if%>
								<% end if %>
							<% end if %>
							<% '// 무료배송 작업 %>
							<% If icoSize="M" Then %>
								<% If oDoc.FItemList(icol).FDeliverFixDay <> "L" Then %>
									<% If oDoc.FItemList(icol).FFreeDeliveryYN="Y" Then %>
										<i class="free-shipping-badge">무료<br>배송</i>
									<% End If %>
								<% ElseIf oDoc.FItemList(icol).FDeliverFixDay = "L" Then %>
									<i class="class-badge">텐텐<br><strong>클래스</strong></i>
								<% End If %>
							<% End If %>
							<% '// 해외직구배송작업추가(원승현) %>
							<% If oDoc.FItemList(icol).IsDirectPurchase Then %>
								<i class="abroad-badge">해외직구</i>
							<% End If %>
							<div class="pdtPhoto">
							<% if adultChkFlag then %>
							<div class="adult-hide">
								<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
							</div>
							<% end if %>
								<a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%= oDoc.FItemList(icol).FcateCode %><%=logparam%>">
									<span class="soldOutMask"></span>
									<img src="<%=chkIIF(icoSize="M",getThumbImgFromURL(oDoc.FItemList(icol).FImageBasic,imgSz,imgSz,"true","false"),getThumbImgFromURL(oDoc.FItemList(icol).FImageIcon2,imgSz,imgSz,"true","false"))%>" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" />
									<% if oDoc.FItemList(icol).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(icol).FAddimage,imgSz,imgSz,"true","false")%>" onerror="$(this).parent().empty();" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" /></dfn><% end if %>
								</a>
							</div>
							<div class="pdtInfo">
								<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oDoc.FItemList(icol).FMakerid %>"><% = oDoc.FItemList(icol).FBrandName %></a></p>
								<p class="pdtName tPad07">
									<a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%= oDoc.FItemList(icol).FcateCode %><%=logparam%>"><% = oDoc.FItemList(icol).FItemName %></a>
								</p>
								<% If oDoc.FItemList(icol).FItemDiv="30" Then %>
									<%'' 이니렌탈 가격 표시 %>
									<p class="pdtPrice"><span class="finalP">월 <%=FormatNumber(fnRentalPriceCalculationDataInEventList(oDoc.FItemList(icol).getRealPrice),0)%>원~</span></p>
								<% Else %>
									<% if oDoc.FItemList(icol).IsSaleItem or oDoc.FItemList(icol).isCouponItem Then %>
										<% IF oDoc.FItemList(icol).IsSaleItem then %>
											<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oDoc.FItemList(icol).getOrgPrice,0)%>원</span></p>
											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(icol).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=oDoc.FItemList(icol).getSalePro%>]</strong></p>
										<% end if %>
										<% IF oDoc.FItemList(icol).IsCouponItem Then %>
											<% if Not(oDoc.FItemList(icol).IsFreeBeasongCoupon() or oDoc.FItemList(icol).IsSaleItem) Then %>
												<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oDoc.FItemList(icol).getOrgPrice,0)%>원</span></p>
											<% end If %>

											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(icol).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=oDoc.FItemList(icol).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(icol).getRealPrice,0) & chkIIF(oDoc.FItemList(icol).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
								<% End If %>
								<p class="pdtStTag tPad10">
									<% IF oDoc.FItemList(icol).isSoldOut Then %>
										<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
									<% else %>
										<% IF oDoc.FItemList(icol).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
										<% IF oDoc.FItemList(icol).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
										<% IF oDoc.FItemList(icol).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
										<% IF oDoc.FItemList(icol).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
										<% IF oDoc.FItemList(icol).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
										<% IF oDoc.FItemList(icol).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
									<% end if %>
								</p>
							</div>

							<ul class="pdtActionV15">
								<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oDoc.FItemList(icol).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
								<li class="postView"><a href="" onclick="<%=chkIIF(oDoc.FItemList(icol).FEvalCnt>0,"popEvaluate('" & oDoc.FItemList(icol).FItemid & "');","")%>return false;"><span><%=oDoc.FItemList(icol).FEvalCnt%></span></a></li>
								<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oDoc.FItemList(icol).FItemid %>'); return false;"><span><%=oDoc.FItemList(icol).FfavCount%></span></a></li>
							</ul>

						</div>
					</li>
					<% Next %>
				</ul>
			</div>
		<% else %>
		    <script type="text/javascript" src="/common/addlog.js?tp=noresult&ror=<%=server.UrlEncode(Request.serverVariables("HTTP_REFERER"))%>"></script>
			<div class="ct" style="padding:150px 0;">
				<p style="font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif; font-size:21px; color:#000;"><strong>흠... <span class="cRd0V15">조건에 맞는 상품</span>이 없습니다.</strong></p>
				<p class="tPad10">Filter 조건 선택해제 후, 다시 원하시는 조건을 선택해 주세요.<p>
				<p>일시적으로 상품이 품절일 경우 검색되지 않습니다.</p>
			</div>
		<% End If %>

		<!-- paging -->
		<div class="pageWrapV15 tMar20">
			<%= fnDisplayPaging_New(CurrPage,oDoc.FTotalCount,PageSize,10,"jsGoPagebrand") %>
		</div>
	<%
	else
		'//상품 리뷰 목록
		Dim oEval, arrEvalTargetItemList
		dim arrUserid, bdgUid, bdgBno
	%>
		<% IF oDoc.FResultCount >0 then %>
			<%
			arrEvalTargetItemList = ""
			for lp=0 to oDoc.FResultCount-1
				arrEvalTargetItemList = arrEvalTargetItemList & oDoc.FItemList(lp).FItemid
				if lp<(oDoc.FResultCount-1) then
					arrEvalTargetItemList = arrEvalTargetItemList & ","
				end if
			next

			set oEval = new SearchItemEvaluate
				oEval.FRectSort = SortMet
				oEval.FRectArrItemid = arrEvalTargetItemList
				if searchFlag="ep" then oEval.FRectMode = "photo"
				oEval.GetBestReviewArrayList
			%>
			<!-- review list -->
			<div class="pdtWrap reviewListV15 <%=chkIIF(searchFlag="ea","txtReviewWrap","photoReviewWrap")%>">
				<% If oEval.FResultCount > 0 Then %>
					<ul class="pdtList">
						<%
						'사용자 아이디 모음 생성(for Badge)
						for lp = 0 to oEval.FResultCount - 1
							arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oEval.FItemList(lp).FUserID) & "''"
						next

						'뱃지 목록 접수(순서 랜덤)
						Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")

						For lp=0 To (oEval.FResultCount-1)

							classStr = ""
							linkUrl = "/shopping/category_prd.asp?itemid="& oEval.FItemList(lp).FItemID &"&disp="& oEval.FItemList(lp).FcateCode & logparam
							adultChkFlag = false
							adultChkFlag = session("isAdult") <> true and oEval.FItemList(lp).FadultType = 1

							If oEval.FItemList(lp).FItemDiv="21" then
								classStr = addClassStr(classStr,"deal-item")
							end if
							If oEval.FItemList(lp).isSoldOut=true then
								classStr = addClassStr(classStr,"soldOut")
							end if
							if adultChkFlag then
								classStr = addClassStr(classStr,"adult-item")
							end if
						if searchFlag="ea" then		'/// 일반상품 후기
						%>
							<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
								<div class="pdtBox">
									<% '// 해외직구배송작업추가(원승현) %>
									<% If oEval.FItemList(lp).IsDirectPurchase Then %>
										<i class="abroad-badge">해외직구</i>
									<% End If %>
									<div class="pdtPhoto">
									<% if adultChkFlag then %>
									<div class="adult-hide">
										<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
									</div>
									<% end if %>
										<a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>"><span class="soldOutMask"></span><img src="<%=getThumbImgFromURL(oEval.FItemList(lp).FIcon1Image,200,200,"true","false")%>" width="200px" height="200px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
									</div>
									<div class="pdtInfo ftRt">
										<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oEval.FItemList(lp).FMakerId%>"><%=oEval.FItemList(lp).Fbrandname%></a></p>
										<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>"><%=oEval.FItemList(lp).Fitemname%></a></p>
										<p class="pdtPrice">
											<%
											if oEval.FItemList(lp).IsSaleItem or oEval.FItemList(lp).isCouponItem Then
												Response.Write "<span class=""txtML"">" & FormatNumber(oEval.FItemList(lp).getOrgPrice,0) & "원</span>"

												IF oEval.FItemList(lp).IsSaleItem then
													Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
													Response.Write " <strong class=""cRd0V15""> [" & oEval.FItemList(lp).getSalePro & "]</strong>"
												end if
												IF oEval.FItemList(lp).IsCouponItem then
													Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).GetCouponAssignPrice,0) & "원</span>"
													Response.Write " <strong class=""cGr0V15""> [" & oEval.FItemList(lp).GetCouponDiscountStr & "]</strong>"
												End IF
											Else
												Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
											End if
											%>
										</p>
										<p class="pdtStTag tPad10">
										<% IF oEval.FItemList(lp).isSoldOut Then %>
											<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
										<% else %>
											<% iconcount=0 %>
											<% IF oEval.FItemList(lp).isTempSoldOut and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% iconcount=iconcount+1 %><% end if %>
											<% IF oEval.FItemList(lp).isSaleItem and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% iconcount=iconcount+1 %><% end if %>
											<% IF oEval.FItemList(lp).isCouponItem and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% iconcount=iconcount+1 %><% end if %>
											<% IF oEval.FItemList(lp).isLimitItem and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% iconcount=iconcount+1 %><% end if %>
											<% IF oEval.FItemList(lp).IsTenOnlyitem and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% iconcount=iconcount+1 %><% end if %>
											<% IF oEval.FItemList(lp).isNewItem and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% iconcount=iconcount+1 %><% end if %>
										<% end if %>
										</p>
									</div>
									<ul class="pdtActionV15">
										<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oEval.FItemList(lp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
										<li class="postView"><a href="" <%=chkIIF(oEval.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oEval.FItemList(lp).FItemid & "'); return false;""","")%>><span><%=oEval.FItemList(lp).FEvalcnt%></span></a></li>
										<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oEval.FItemList(lp).FItemid %>'); return false;"><span><%=oEval.FItemList(lp).FfavCount%></span></a></li>
									</ul>
								</div>
								<div class="reviewBoxV15" <%=chkIIF(adultChkFlag, "style=""display:none""", "")%>>
									<p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoints%>.png" alt="별<%=oEval.FItemList(lp).FPoints%>개" /></p>
								<%
									'//상품고시관련 상품후기 제외 상품이 아닐경우
									if oEval.FItemList(lp).fEval_excludeyn="N" then
								%>
									<div class="reviewTxt"><a href="" onclick="popEvaluateDetail(<%=oEval.FItemList(lp).Fitemid%>,<%=oEval.FItemList(lp).Fidx%>);return false;" title="상세 리뷰 보기"><% = chrbyte(oEval.FItemList(lp).Fcontents,150,"Y") %></a></div>
								<%
									'//상품고시관련 상품후기 제외 상품일경우
									else
								%>
									<ul class="reviewFoodV15">
										<li><span>기능</span> <em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_fun%>.png" alt="별<%=oEval.FItemList(lp).FPoint_fun%>개" /></em></li>
										<li><span>디자인</span> <em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_dgn%>.png" alt="별<%=oEval.FItemList(lp).FPoint_dgn%>개" /></em></li>
										<li><span>가격</span> <em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_prc%>.png" alt="별<%=oEval.FItemList(lp).FPoint_prc%>개" /></em></li>
										<li><span>만족도</span> <em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_stf%>.png" alt="별<%=oEval.FItemList(lp).FPoint_stf%>개" /></em></li>
									</ul>
								<% end if %>

									<a href="" onclick="popEvaluate(<%=oEval.FItemList(lp).Fitemid%>,'');return false;" class="more1V15">상품 전체 리뷰보기</a>
									<div class="reviewWriteV15">
										<p>
											<span><% = printUserId(oEval.FItemList(lp).Fuserid,2,"*") %></span>
											<%=getUserBadgeIcon(oEval.FItemList(lp).FUserID,bdgUid,bdgBno,3)%>
										</p>
										<em>ㅣ</em>
										<span><% = FormatDate(oEval.FItemList(lp).Fregdate,"0000.00.00") %></span>
									</div>
								</div>
							</li>
						<%
						'/// 포토 상품 후기
						else
						%>
							<%
							'//상품고시관련 상품후기 제외 상품이 아닐경우
							if oEval.FItemList(lp).fEval_excludeyn="N" then
							%>
								<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
									<div class="reviewBoxV15" <%=chkIIF(adultChkFlag, "style=""display:none""", "")%>>
										<p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoints%>.png" alt="별<%=oEval.FItemList(lp).FPoints%>개" /></p>
										<div class="reviewTxt"><a href="" onclick="popEvaluateDetail(<%=oEval.FItemList(lp).Fitemid%>,<%=oEval.FItemList(lp).Fidx%>);return false;" title="상세 리뷰 보기"><% = chrbyte(oEval.FItemList(lp).Fcontents,120,"Y") %></a></div>
										<div class="reviewWriteV15">
											<p>
												<span><% = printUserId(oEval.FItemList(lp).Fuserid,2,"*") %></span>
												<%=getUserBadgeIcon(oEval.FItemList(lp).FUserID,bdgUid,bdgBno,3)%>
											</p>
											<em>ㅣ</em>
											<span><% = FormatDate(oEval.FItemList(lp).Fregdate,"0000.00.00") %></span>
										</div>
										<a href="" onclick="popEvaluate(<%=oEval.FItemList(lp).Fitemid%>,'');return false;" class="more1V15">상품 전체 리뷰보기</a>
									<div class="pdtPhoto">
										<a href="" onclick="popEvaluateDetail(<%=oEval.FItemList(lp).Fitemid%>,<%=oEval.FItemList(lp).Fidx%>);return false;"><img src="<%=getThumbImgFromURL(chkIIF(oEval.FItemList(lp).FImageIcon1<>"",oEval.FItemList(lp).FImageIcon1,oEval.FItemList(lp).FImageIcon2),400,400,"true","false")%>" width="400px" height="400px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
									</div>
									</div>
									<div class="pdtBox">
										<% '// 해외직구배송작업추가(원승현) %>
										<% If oEval.FItemList(lp).IsDirectPurchase Then %>
											<i class="abroad-badge">해외직구</i>
										<% End If %>
										<div class="pdtPhoto">
										<% if adultChkFlag then %>
										<div class="adult-hide">
											<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
										</div>
										<% end if %>
											<a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>"><span class="soldOutMask"></span><img src="<%=getThumbImgFromURL(oEval.FItemList(lp).FIcon1Image,400,400,"true","false")%>" width="400px" height="400px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
										</div>
										<div class="pdtInfo">
											<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oEval.FItemList(lp).FMakerId%>"><%=oEval.FItemList(lp).Fbrandname%></a></p>
											<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>"><%=oEval.FItemList(lp).Fitemname%></a></p>
											<p class="pdtPrice">
												<%
												if oEval.FItemList(lp).IsSaleItem or oEval.FItemList(lp).isCouponItem Then
													Response.Write "<span class=""txtML"">" & FormatNumber(oEval.FItemList(lp).getOrgPrice,0) & "원</span>"

													IF oEval.FItemList(lp).IsSaleItem then
														Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
														Response.Write " <strong class=""cRd0V15""> [" & oEval.FItemList(lp).getSalePro & "]</strong>"
													elseIF oEval.FItemList(lp).IsCouponItem then
														Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).GetCouponAssignPrice,0) & "원</span>"
														Response.Write " <strong class=""cGr0V15""> [" & oEval.FItemList(lp).GetCouponDiscountStr & "]</strong>"
													End IF
												Else
													Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
												End if
												%>
												<span class="pdtStTag">
													<% IF oEval.FItemList(lp).isSoldOut Then %>
														<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
													<% else %>
														<% iconcount=0 %>
														<% IF oEval.FItemList(lp).isTempSoldOut and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% iconcount=iconcount+1 %><% end if %>
														<% IF oEval.FItemList(lp).isSaleItem and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% iconcount=iconcount+1 %><% end if %>
														<% IF oEval.FItemList(lp).isCouponItem and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% iconcount=iconcount+1 %><% end if %>
														<% IF oEval.FItemList(lp).isLimitItem and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% iconcount=iconcount+1 %><% end if %>
														<% IF oEval.FItemList(lp).IsTenOnlyitem and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% iconcount=iconcount+1 %><% end if %>
														<% IF oEval.FItemList(lp).isNewItem and iconcount < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% iconcount=iconcount+1 %><% end if %>
													<% end if %>
												</span>
											</p>
										</div>
										<ul class="pdtActionV15">
											<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oEval.FItemList(lp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
											<li class="postView"><a href="" <%=chkIIF(oEval.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oEval.FItemList(lp).FItemid & "'); return false;""","")%>><span><%=oEval.FItemList(lp).FEvalcnt%></span></a></li>
											<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oEval.FItemList(lp).FItemid %>'); return false;"><span><%=oEval.FItemList(lp).FfavCount%></span></a></li>
										</ul>
									</div>
								</li>
							<% end if %>
						<%
						end if

						next
						%>
					</ul>
				<% else %>
					<div class="ct" style="padding:150px 0;">
						<p style="font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif; font-size:21px; color:#000;"><strong>흠... <span class="cRd0V15">조건에 맞는 상품</span>이 없습니다.</strong></p>
						<p class="tPad10">Filter 조건 선택해제 후, 다시 원하시는 조건을 선택해 주세요.<p>
						<p>일시적으로 상품이 품절일 경우 검색되지 않습니다.</p>
					</div>
				<% end if %>
			</div>
			<!-- //review list -->

			<% If oEval.FResultCount > 0 Then %>
				<!-- paging -->
				<div class="pageWrapV15 tMar20">
					<%= fnDisplayPaging_New(CurrPage,oDoc.FTotalCount,PageSize,10,"jsGoPagebrand") %>
				</div>
			<% end if %>
		<% else %>
			<div class="ct" style="padding:150px 0;">
				<p style="font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif; font-size:21px; color:#000;"><strong>흠... <span class="cRd0V15">조건에 맞는 상품</span>이 없습니다.</strong></p>
				<p class="tPad10">Filter 조건 선택해제 후, 다시 원하시는 조건을 선택해 주세요.<p>
				<p>일시적으로 상품이 품절일 경우 검색되지 않습니다.</p>
			</div>
		<% end if %>
	<%
	end if
	%>
</div>
