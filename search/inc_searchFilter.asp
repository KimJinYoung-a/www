<%
	'// amplitude 카테고리 리스트용
	Dim isCatelistUrl : isCatelistUrl = InStr(Request.ServerVariables("SCRIPT_NAME"),"/category_list.asp") > 0

	Function amplitudeScript(f)
		If isCatelistUrl Then
			amplitudeScript = "fnAmplitudeEventMultiPropertiesAction('click_category_list_item_type','categoryname|type','"& fnFindToCateName(vDisp) &"|"& f &"');"
		End If 
	End Function 

	Function amplitudeListStyle(s)
		If isCatelistUrl Then
			amplitudeListStyle = "onclick=fnAmplitudeEventMultiPropertiesAction('click_category_list_list_style','categoryname|list_style','"& fnFindToCateName(vDisp) &"|"& s &"');"
		end if 
	End function
%>
<div class="pdtFilterWrap tMar50">
	<div class="tabWrapV15">
		<div class="sortingTabV15">
			<ul>
				<li class="<%=chkIIF(searchFlag="n","selected","")%>" onclick="<%=amplitudeScript("all")%>chgSFragTab('n');">
					<strong>ALL</strong>
					<span>
						<% if (searchFlag="n") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("n",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<li class="<%=chkIIF(searchFlag="sc","selected","")%>" onclick="<%=amplitudeScript("sale")%>chgSFragTab('sc');">
					<strong>SALE</strong>
					<span>
						<% if (searchFlag="sc") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("sc",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<li class="<%=chkIIF(searchFlag="ea","selected","")%>" onclick="<%=amplitudeScript("review")%>chgSFragTab('ea');">
					<strong>REVIEW</strong>
					<span>
						<% if (searchFlag="ea") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("ea",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<li class="<%=chkIIF(searchFlag="ep","selected","")%>" onclick="<%=amplitudeScript("photo")%>chgSFragTab('ep');">
					<strong>PHOTO</strong>
					<span>
						<% if (searchFlag="ep") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("ep",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<li class="<%=chkIIF(searchFlag="fv","selected","")%>" onclick="<%=amplitudeScript("wish")%>chgSFragTab('fv');">
					<strong>WISH</strong>
					<span>
						<% if (searchFlag="fv") then %>
						(<%= FormatNumber(oDoc.FTotalCount,0) %>)</td>
						<% elseif (isShowSumamry) then %>(<%= FormatNumber(getCateListCount("fv",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText),0) %>)<% end if %>
					</span>
				</li>
				<% If G_IsPojangok Then %>
				<li class="wrappingV15a<%=chkIIF(searchFlag="pk"," selected","")%>" onclick="<%=amplitudeScript("wrapping")%>chgSFragTab('pk');">
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
		<ul class="dFilterTabV15">
			<li class="tabColor" id="tabColor"><p>컬러</p></li>
			<li class="tabStyle" id="tabStyle"><p>스타일</p></li>
			<li class="tabAttribute" id="tabAttribute"><p>속성</p></li>
			<li class="tabPrice" id="tabPrice"><p>가격</p></li>
			<li class="tabDelivery" id="tabDelivery"><p>배송</p></li>
			<% if ListDiv<>"search" then %><li class="tabSearch" id="tabSearch"><p>검색</p></li><% end if %>
		</ul>
	</div>
	<div class="dFilterWrap">
		<div class="filterSelect">
			<div class="ftColor" id="fttabColor">
			<!-- #Include file="inc_searchColorBox.asp" -->
			</div>
			<div class="ftStyle" id="fttabStyle">
			<!-- #Include file="inc_searchStyleBox.asp" -->
			</div>
			<div class="ftAttribute" id="fttabAttribute">
			<!-- #Include file="inc_searchItemAttrBox.asp" -->
			</div>
			<div class="ftPrice" id="fttabPrice">
			<!-- #Include file="inc_searchItemPriceBox.asp" -->
			</div>
			<div class="ftDelivery" id="fttabDelivery">
				<ul>
					<li><input type="radio" name="dlvTp" id="delivery01" class="radio" value="" <%=chkIIF(deliType="","checked","")%> /> <label for="delivery01">ALL</label></li>
					<li><input type="radio" name="dlvTp" id="delivery02" class="radio" value="FD" <%=chkIIF(deliType="FD","checked","")%> /> <label for="delivery02" title="무료배송 상품입니다.">무료 배송</label></li>
					<li><input type="radio" name="dlvTp" id="delivery03" class="radio" value="TN" <%=chkIIF(deliType="TN","checked","")%> /> <label for="delivery03" title="텐바이텐 물류센터에서 직접 발송이 되는 상품입니다.">텐바이텐 배송</label></li>
					<li><input type="radio" name="dlvTp" id="delivery04" class="radio" value="FT" <%=chkIIF(deliType="FT","checked","")%> /> <label for="delivery04" title="텐바이텐 물류센터에서 직접 발송이 되는 무료배송 상품입니다.">무료+텐바이텐 배송</label></li>
					<%'// 해외직구배송작업추가(원승현)%>
					<% if now() < #07/31/2019 12:00:00# then %>
					<li><input type="radio" name="dlvTp" id="delivery06" class="radio" value="QT" <%=chkIIF(deliType="QT","checked","")%> /> <label for="delivery06" title="퀵으로 배송되는 상품입니다.">바로 배송</label></li>
					<% end if %>
					<li><input type="radio" name="dlvTp" id="delivery07" class="radio" value="DT" <%=chkIIF(deliType="DT","checked","")%> /> <label for="delivery07" title="해외에서 배송되는 상품입니다.">해외 직구</label></li>
					<li class="abroad"><input type="radio" name="dlvTp" id="delivery05" class="radio" value="WD" <%=chkIIF(deliType="WD","checked","")%> /> <label for="delivery05" title="해외 배송이 가능한 상품입니다.">해외 배송</label></li>
				</ul>
			</div>
			<div class="ftSearch" id="fttabSearch">
				<input type="text" name="skwd" value="<%=chkIIF(SearchText<>"",SearchText,"키워드를 입력해주세요.")%>" style="width:400px" class="ftSearchInput" />
				<input type="image" src="http://fiximage.10x10.co.kr/web2015/common/btn_add.png" alt="Search" />
			</div>
		</div>

		<span class="filterLyrClose"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_close.gif" alt="Layer Close" /></span>
	</div>
	<div class="dFilterResult" style="display:none;">
		<dl>
			<dt class="resultTit">필터</dt>
			<dd class="resultCont" id="lyrSearchFilter"></dd>
		</dl>
		<p class="btnSltSearch">
			<a href="" id="btnRstFilter" class="btn btnS1 btnWhite btnW80">초기화</a>
			<a href="" id="btnActFilter" class="btn btnS1 btnRed btnW80">검색</a>
		</p>
	</div>
</div>
<div class="overHidden tPad15">
	<% if left(dispCate,3)="119" then %>
	<!--<div class="ftLt lPad25">
		<p class="cmt02 cr888 fs11 tMar04">본 상품은 건강식품 및 의료기기에 해당되는 상품으로 고객 상품평 이용이 제한됩니다.</p>
	</div>-->
	<% end if %>
	<div class="ftRt" style="width:<%=chkIIF(searchFlag="ea" or searchFlag="ep" or ListDiv="search","220x","220px")%>;">
		<select id="selSrtMet" class="ftLt optSelect" title="배송구분 옵션을 선택하세요" style="height:18px;">
			<option value="ne" <%=chkIIF(SortMet="ne","selected","")%>>신상품순</option>
			<option value="bs" <%=chkIIF(SortMet="bs","selected","")%>>판매량순</option>
			<option value="be" <%=chkIIF(SortMet="be","selected","")%>><%=chkIIF(searchFlag="fv","인기위시순","인기상품순")%></option>
			<% if (getLoginUserLevel="7") then%><option value="vv" <%=chkIIF(SortMet="vv","selected","")%>>추천 상품순</option><% end if %>
			<option value="lp" <%=chkIIF(SortMet="lp","selected","")%>>낮은가격순</option>
			<option value="hp" <%=chkIIF(SortMet="hp","selected","")%>>높은가격순</option>
			<option value="hs" <%=chkIIF(SortMet="hs","selected","")%>>높은할인율순</option>			
		</select>
		<a href="" id="soldoutExc" value="<%=SellScope%>" class="lMar20 ftLt btn btnS3 btnGry fn"><%=chkIIF(SellScope="Y", " + 품절상품 포함 "," - 품절상품 제외 ")%></a>
	</div>
</div>