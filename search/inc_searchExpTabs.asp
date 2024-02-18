<%
	dim oGrCat, oGrBrn, oGrPly, oGrCd3, lp2
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
	oGrCat.FGroupScope = "2"	'카테고리 그룹 범위(depth)
	oGrCat.FLogsAccept = False '그룹형은 절대 !!! False 
	oGrCat.FSellScope=SellScope                                 ''2015/11/05 추가
	oGrCat.getGroupbyCategoryList		'//카테고리 접수

	'// 브랜드별 검색결과
	set oGrBrn = new SearchItemCls
	oGrBrn.FRectSearchTxt = DocSearchText
	oGrBrn.FRectExceptText = ExceptText
	oGrBrn.FRectSortMethod = SortMet
	oGrBrn.FRectSearchItemDiv = SearchItemDiv
	oGrBrn.FCurrPage = 1
	oGrBrn.FPageSize = 100
	oGrBrn.FScrollCount =10
	oGrBrn.FListDiv = ListDiv
	oGrBrn.FLogsAccept = False
	oGrBrn.FSellScope=SellScope                                 ''2015/11/05 추가
	oGrBrn.getGroupbyBrandList

	'// 각 탭 결과 수 취합
	if oGrCat.FResultCount>0 then
		for lp=0 to oGrCat.FResultCount-1
			catTTCnt = catTTCnt + oGrCat.FItemList(lp).FSubTotal
		next
	end if

	if oGrBrn.FResultCount>0 then
		'브랜드 전체 카운트
		brnTTCnt = oGrBrn.FResultCount
		'베스트 브랜드 카운트
		tmpRank = 9999
		for lp=0 to oGrBrn.FResultCount-1
			if oGrBrn.FItemList(lp).FisBestBrand="Y" then
				brnBtCnt = brnBtCnt+1
				
				if brnBtCnt<=5 then
					'브랜드 랭크를 비교하여 순서가 높으면 앞에 위치
					if tmpRank>oGrBrn.FItemList(lp).FCurrRank then
						strBrnBest = strBrnBest & "<span><a href=""/street/street_brand.asp?makerid=" & oGrBrn.FItemList(lp).FMakerID & """ target=""_blank""><strong>" & oGrBrn.FItemList(lp).FBrandName & "</strong> (" & formatNumber(oGrBrn.FItemList(lp).FItemScore,0) & ")</a></span>"
					else
						strBrnBest = "<span><a href=""/street/street_brand.asp?makerid=" & oGrBrn.FItemList(lp).FMakerID & """ target=""_blank""><strong>" & oGrBrn.FItemList(lp).FBrandName & "</strong> (" & formatNumber(oGrBrn.FItemList(lp).FItemScore,0) & ")</a></span>" & strBrnBest
					end if
					tmpRank = oGrBrn.FItemList(lp).FCurrRank
				end if
			end if
		next
	end if

'// 결과가 있어야 출력
if catTTCnt>0 or brnTTCnt>0 or plyTTcnt>0 then
%>
<ul id="lyrSchExpTab" class="schTabV15">
	<% if catTTCnt>0 then %>
	<li class="tabCtgy <%=chkIIF(makerid="","current","")%>" id="tabCtgy" name="Cate">
		<p>
			<strong>아이템</strong>
			<span>(<%=formatNumber(catTTCnt,0)%>)</span>
		</p>
	</li>
	<% end if %>
	<% if brnTTCnt>0 then %>
	<li class="tabBrand <%=chkIIF(makerid<>"","current","")%>" id="tabBrand" name="Brand">
		<p>
			<strong>브랜드</strong>
			<span>(<%=formatNumber(brnTTCnt,0)%>)</span>
		</p>
	</li>
	<% end if %>
	<% if plyTTcnt>0 then %>
	<li class="tabPlay" id="tabPlay" name="Play">
		<p>
			<strong>PLAY</strong>
			<span>(<%=formatNumber(plyTTcnt,0)%>)</span>
		</p>
	</li>
	<% end if %>
</ul>

<div class="schDetailBoxV15">
<%
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
							oGrCd3.FGroupScope = "3"	'카테고리 그룹 범위(depth)
							oGrCd3.FLogsAccept = False '그룹형은 절대 !!! False 
							oGrCd3.getGroupbyCategoryList		'//카테고리 접수
		
							if oGrCd3.FResultCount>0 then
								tempCD3 = "<div class=""depthWrapV15"">"
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

		'카테고리 펼침메뉴 속성 지정 (1줄이 넘으면 표시, 펼침밖의 분류를 선택했으면->js에서 처리)
		moreYn = chkIIF(rowCnt>1,"Y","N")

		'// 본분 시작
		rowCnt = 1
		tempCD1 = CStr(oGrCat.FItemList(0).FCateCd1)
%>
	<div class="lyrTabV15" id="lyrCate" <%=chkIIF(makerid<>"","style=""display:none;""","")%>>
		<!-- 카테고리 검색 결과 -->
		<div class="schCateV15">
			<table>
				<colgroup>
					<col width="225" /><col width="" />
				</colgroup>
				<tbody>
			<%
				For lp=Ubound(rowScore) to 1 step -1
					if rowText(lp,2)<>"" then
			%>
				<tr <%=chkIIF((Ubound(rowScore)-lp)>=1 and moreYn="Y","class='trCateMore' style='display:none;'","") %>>
					<th><input type="checkbox" class="check" name="ctCd1<%=rowText(lp,2)%>" id="cate<%=rowText(lp,2)%>" value="<%=rowText(lp,2)%>" <%=chkIIF(chkArrValue(arrCate,rowText(lp,2)),"checked","")%> /> <a href=""""><%=rowText(lp,3)%></a> <span class="fn">(<%=formatNumber(rowText(lp,1),0)%>)</span></th>
					<td><%=rowText(lp,4)%></td>
				</tr>
			<%
					end if
				Next
			%>
				</tbody>
			</table>
		</div>
		<!-- //카테고리 검색 결과 -->
		<% if moreYn="Y" then %><p class="schMoreViewV15 btnMoreCate">더보기</p><% end if %>
	</div>
<%
	end if
	moreYn = "N"

'// 브랜드 확장검색 //
	if oGrBrn.FResultCount>0 then
%>
	<div class="lyrTabV15" id="lyrBrand" <%=chkIIF(makerid="","style=""display:none;""","")%>>
		<!-- 브랜드 검색 결과 -->
		<% if brnBtCnt>=5 then %>
		<dl class="schBestBrV15">
			<dt><img src="http://fiximage.10x10.co.kr/web2015/common/tit_best_brand.gif" alt="BEST BRAND" /></dt>
			<dd><%=strBrnBest%></dd>
		</dl>
		<% end if %>
		<div class="schBrListV15">
			<ul>
			<%
				for Lp=0 to oGrBrn.FResultCount-1
			%>
				<li <%=chkIIF(Lp>=10,"class='trBrandMore' style='display:none;'","")%>><input type="checkbox" class="check" name="mkrid" id="br<%=lp%>" value="<%=oGrBrn.FItemList(lp).FMakerID%>" <%=chkIIF(chkArrValue(makerid,oGrBrn.FItemList(lp).FMakerID),"checked","")%> />
					<a href=""><%=oGrBrn.FItemList(lp).FBrandName%> (<%=formatNumber(oGrBrn.FItemList(lp).FItemScore,0)%>)</a>
					<% if oGrBrn.FItemList(lp).FisBestBrand="Y" then %><img src="http://fiximage.10x10.co.kr/web2013/common/tag_best.gif" alt="BEST" /><% end if %>
				</li>
			<%
				next
	
				if oGrBrn.FResultCount>10 then  moreYn="Y"
			%>
			</ul>
		</div>
		<!-- //브랜드 검색 결과 -->
		<% if moreYn="Y" then %><p class="schMoreViewV15 btnMoreBrand">더보기</p><% end if %>
	</div>
<%
	end if
	 moreYn="N"
%>
</div>

<div id="lyrJoinSearch" class="tPad05 rt">
	<a href="" class="btn btnS2 btnGry" id="btnDelTerm" <%=chkIIF(arrCate<>"" or makerid<>"","","style=""display:none;""")%>>선택 초기화</a>
	<a href="" class="btn btnS2 btnRed" id="btnActTerm">선택 조건 검색</a>
</div>
<%

	end if

	Set oGrCat = nothing
	Set oGrBrn = nothing
%>
<script>
	var cnt = $("#lyrCate input[name^='ctCd1']").length;
	if(cnt==0) {
		$("#tabCtgy, #lyrCate").hide();
		$("#tabBrand").addClass("current");
		$("#lyrBrand").show();
	}
</script>