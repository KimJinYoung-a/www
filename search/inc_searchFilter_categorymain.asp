<%
	'// amplitude Script category_main
	'// amplitude 카테고리 리스트용
	Dim isCateMainUrl : isCateMainUrl = InStr(Request.ServerVariables("SCRIPT_NAME"),"/category_main.asp") > 0

	Function amplitudeScript(v,f)
		If isCateMainUrl Then
			amplitudeScript = "onclick=fnAmplitudeEventMultiPropertiesAction('click_category_main_item_type','categoryname|type','"& fnFindToCateName(vDisp) &"|"& f &"');chgSFragTab('"& v &"');"
		End If 
	End Function 

	Function amplitudeListStyle(s)
		If isCateMainUrl Then
			amplitudeListStyle = "onclick=fnAmplitudeEventMultiPropertiesAction('click_category_main_list_style','categoryname|list_style','"& fnFindToCateName(vDisp) &"|"& s &"');"
		end if 
	End Function

	Function amplitudeMovesubCategory(nextCateCode)
		If isCateMainUrl Then
			amplitudeMovesubCategory = "onclick=fnAmplitudeEventMultiPropertiesAction('view_category_main_leftcategory','category_code|category_depth|move_category_code|move_category_depth','"& vDisp &"|"& CInt(Len(vDisp)/3) &"|"& nextCateCode &"|"& CInt(Len(nextCateCode)/3) &"');"
		end if 
	End Function 
%>
<div class="pdtFilterWrap tMar50">
	<div class="tabWrapV15">
		<div class="sortingTabV15">
			<ul>
				<li class="<%=chkIIF(searchFlag="n","selected","")%>" <%=amplitudeScript("n","all")%>>
					<strong>ALL</strong>
					<span>
						<% if (searchFlag="n") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("n",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<li class="<%=chkIIF(searchFlag="sc","selected","")%>" <%=amplitudeScript("sc","sale")%>>
					<strong>SALE</strong>
					<span>
						<% if (searchFlag="sc") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("sc",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<li class="<%=chkIIF(searchFlag="ea","selected","")%>" <%=amplitudeScript("ea","review")%>>
					<strong>REVIEW</strong>
					<span>
						<% if (searchFlag="ea") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("ea",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<li class="<%=chkIIF(searchFlag="ep","selected","")%>" <%=amplitudeScript("ep","photo")%>>
					<strong>PHOTO</strong>
					<span>
						<% if (searchFlag="ep") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("ep",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<li class="<%=chkIIF(searchFlag="fv","selected","")%>" <%=amplitudeScript("fv","wish")%>>
					<strong>WISH</strong>
					<span>
						<% if (searchFlag="fv") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("fv",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<% If G_IsPojangok Then %>
				<li class="wrappingV15a<%=chkIIF(searchFlag="pk"," selected","")%>" <%=amplitudeScript("pk","wrapping")%>>
					<i></i><strong>WRAPPING</strong>
					<span>
						<% if (searchFlag="pk") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("pk",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<% End If %>
			</ul>
		</div>

		<div class="evtSelectV15a ftRt tMar15">
			<p>
				<span>
					<%
						strsql = " Select catecode, catename From [db_item].[dbo].[tbl_display_cate] "
						strsql = strsql & " Where depth=1 And left(catecode, 3)='"&Trim(Left(vDisp, 3))&"' And useyn='y' "
						strsql = strsql & " order by sortNo, catecode Asc "
						rsget.open strsql, dbget,1
					%>
						<%=rsget("catename")%> 전체
					<% 
						rsget.close
					%>
				</span>
			</p>
			<div>
				<ul>
					<%
						strsql = " Select catecode, catename From [db_item].[dbo].[tbl_display_cate] "
						strsql = strsql & " Where depth=2 And left(catecode, 3)='"&Trim(Left(vDisp, 3))&"' And useyn='y' "
						strsql = strsql & " order by sortNo, catecode Asc "
						rsget.open strsql, dbget,1

						Do Until rsget.eof
					%>
						<li><a href="/shopping/category_list.asp?disp=<%=rsget("catecode")%>" <%=amplitudeMovesubCategory(rsget("catecode"))%>><%=rsget("catename")%></a></li>
					<% 
						rsget.movenext
						Loop

						rsget.close
					%>
				</ul>
			</div>
		</div>
	</div>
</div>
<div class="overHidden tPad15">
	<% if left(dispCate,3)="119" then %>
	<!--<div class="ftLt lPad25">
		<p class="cmt02 cr888 fs11 tMar04">본 상품은 건강식품 및 의료기기에 해당되는 상품으로 고객 상품평 이용이 제한됩니다.</p>
	</div>-->
	<% end if %>
	<div class="ftRt" style="width:<%=chkIIF(searchFlag="ea" or searchFlag="ep" or ListDiv="search","220x","220px")%>;">
		<select id="selSrtMet" class="ftLt optSelect" title="배송구분 옵션을 선택하세요" style="height:18px;" onchange=amplitudeChangeSortSend(this.value);>
			<option value="ne" <%=chkIIF(SortMet="ne","selected","")%>>신상품순</option>
			<option value="bs" <%=chkIIF(SortMet="bs","selected","")%>>판매량순</option>
			<option value="be" <%=chkIIF(SortMet="be","selected","")%>><%=chkIIF(searchFlag="fv","인기위시순","인기상품순")%></option>
			<option value="lp" <%=chkIIF(SortMet="lp","selected","")%>>낮은가격순</option>
			<option value="hp" <%=chkIIF(SortMet="hp","selected","")%>>높은가격순</option>
			<option value="hs" <%=chkIIF(SortMet="hs","selected","")%>>높은할인율순</option>
		</select>
		<a href="" id="soldoutExc" value="<%=SellScope%>" class="lMar20 ftLt btn btnS3 btnGry fn"><%=chkIIF(SellScope="Y", " + 품절상품 포함 "," - 품절상품 제외 ")%></a>
	</div>
</div>