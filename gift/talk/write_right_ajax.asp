<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
%>
<%
'###########################################################
' Description :  기프트
' History : 2015.02.10 유태욱 생성
'###########################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/gift/giftCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/classes/shopping/todayshoppingcls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<%
	'Dim vStoryItem, vIsMine, vCount, vIsSearch, vKeyword
	Dim vTab, vFolderID, vListName, vItemID, vTalkIdx, vSort
	Dim vSearchText, vDisp
	Dim vPage, vOrderType, ix, vPrice, vSale
	vTab 		= requestCheckVar(Request("tab"),1)	'1=My Wish , 2=상품검색
	vFolderID 	= requestCheckvar(request("fidx"),9)
	vPage		= requestCheckVar(request("page"),3)
	vOrderType	= requestCheckVar(request("OrderType"),10)
	vSearchText	= requestCheckVar(request("searchtxt"),100) '현재 입력된 검색어
	vDisp		= getNumeric(requestCheckVar(request("dispCate"),18))

	If vFolderID = "" Then vFolderID = "0" End If
	If vTab = "" Then vTab = "2" End IF
	If vPage = "" Then vPage = "1" End IF

	vSearchText = RepWord(vSearchText,"[^가-힣a-zA-Z0-9.&%\-\s]","")

	Dim arrList, intLoop, cTalkItem
	If vTab = "1" Then	'My Wish
		set cTalkItem = new CMyFavorite
		cTalkItem.FRectUserID = getEncLoginUserID
		arrList = cTalkItem.fnGetFolderList

		cTalkItem.FPageSize        = 5
		cTalkItem.FCurrpage        = vPage
		cTalkItem.FScrollCount     = 5
		cTalkItem.FRectOrderType   = vOrderType
		cTalkItem.FRectSortMethod  = ""
		cTalkItem.FRectDisp		= ""
		cTalkItem.FRectSellScope	= ""
		cTalkItem.FFolderIdx		= vFolderID
		cTalkItem.FExB2BItemYn	   = "Y"
		cTalkItem.getMyWishList
	ElseIf vTab = "2" Then	'상품검색
		set cTalkItem = new SearchItemCls
		cTalkItem.FRectSearchTxt = vSearchText
		cTalkItem.FRectSortMethod	= fnSortMatching(vOrderType)
		cTalkItem.FRectSearchItemDiv = "y"	'### 카테고리 값있을때 y 없을때 n
		cTalkItem.FRectSearchCateDep = "T"
		cTalkItem.FRectCateCode	= vDisp
		cTalkItem.FCurrPage = vPage
		cTalkItem.FPageSize = 5
		cTalkItem.FScrollCount = 5
		cTalkItem.FListDiv = "search"
		cTalkItem.FLogsAccept = false
		cTalkItem.FSellScope = "Y"		'품절제외 여부 (Y:판매상품만, N:일시품절 이상)
		cTalkItem.getSearchList
	ElseIf vTab = "3" Then	'최근 본 상품
		dim myTodayShopping
		set myTodayShopping = new CTodayShopping
		myTodayShopping.FPageSize        = 5
		myTodayShopping.FCurrpage        = vPage 'page
		myTodayShopping.FScrollCount     = 4
		myTodayShopping.FRectOrderType   = vOrderType
		'myTodayShopping.FRectCDL         = cdl
		myTodayShopping.FRectUserID      = getEncLoginUserID
		
		if getEncLoginUserID<>"" then
		    myTodayShopping.getMyTodayViewList
		end if
	End If
'----------------카테고리---------------------------------
	Dim oGrCat, oGrCat1, oGrCat2, vTmpCode, Lp
	Dim vCateDepth
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">
$(function(){
	/* drop down */
	var select_root = $('div.selectwrap');
	var select_value = $('.myValue');
	var select_a = $('div.selectwrap>ul>li>a');
	var select_input = $('div.selectwrap>ul>li>input[type=radio]');
	var select_label = $('div.selectwrap>ul>li>label');

	$('div.myValue').each(function(){
		var default_value = $(this).next('.iList').find('input[checked]').next('label').text();
		$(this).append(default_value);
	});

	select_value.bind('focusin',function(){$(this).addClass('outLine');});
	select_value.bind('focusout',function(){$(this).removeClass('outLine');});
	select_input.bind('focusin',function(){$(this).parents('div.selectwrap').children('div.myValue').addClass('outLine');});
	select_input.bind('focusout',function(){$(this).parents('div.selectwrap').children('div.myValue').removeClass('outLine');});

	function show_option(){
		$(this).parents('div.selectwrap:first').toggleClass('open');
	}

	function i_hover(){
		$(this).parents('ul:first').children('li').removeClass('hover');
		$(this).parents('li:first').toggleClass('hover');
	}

	function hide_option(){
		var t = $(this);
		setTimeout(function(){
			t.parents('div.selectwrap:first').removeClass('open');
		}, 1);
	}

	function set_label(){
		var v = $(this).next('label').text();
		$(this).parents('ul:first').prev('.myValue').text('').append('<span>'+v+'</span>');
		$(this).parents('ul:first').prev('.myValue').addClass('selected');
		$(this).parents('ul:first').prev('.myValue').append("<em></em>");
	}

	function set_anchor(){
		var v = $(this).text();
		$(this).parents('ul:first').prev('.myValue').text('').append('<span>'+v+'</span>');
		$(this).parents('ul:first').prev('.myValue').addClass('selected');
		$(this).parents('ul:first').prev('.myValue').append("<em></em>");
		return false;
	}

	$('*:not("div.selectwrap a")').focus(function(){
		$('.aList').parent('.select').removeClass('open');
	});

	select_value.click(show_option);
	select_root.find('ul').css('position','absolute');
	select_root.removeClass('open');
	select_root.mouseleave(function(){$(this).removeClass('open');});
	select_a.click(set_anchor).click(hide_option).focus(i_hover).hover(i_hover);
	select_input.change(set_label).focus(set_label);
	select_label.hover(i_hover).click(hide_option);

	$('input[type="reset"], button[type="reset"]').click(function(){
		$(this).parents('form:first').find('.myValue').each(function(){
			var origin = $(this).next('ul:first').find('li:first label').text();
			$(this).text(origin).removeClass('selected');
		});
	});

	$('.myValue').click(function(){
		$(this).addClass('selected');
	});

	/* select */
	if (!$.browser.opera) {
		// select element styling
		$('select.select').each(function(){
			var title = $(this).attr('title');
			if( $('option:selected', this).val() != ''  ) title = $('option:selected',this).text();
			$(this)
			.css({'z-index':10,'opacity':0,'-khtml-appearance':'none'})
			.after('<span class="select">' + title + '</span>')
			.change(function(){
				val = $('option:selected',this).text();
				$(this).next().text(val);
			})
		});
	};
});

//페이징
function jsTalkRightListPaging(a){
	$.ajax({
			<% If vTab = "1" Then %>
			url: "/gift/talk/write_right_ajax.asp?tab=1&fidx=<%=vFolderID%>&OrderType=<%=vOrderType%>&page="+a+"",
			<% ElseIf vTab = "2" Then %>
			url: "/gift/talk/write_right_ajax.asp?tab=2&OrderType=<%=vOrderType%>&searchtxt="+encodeURIComponent($("#searchtxt").val())+"&page="+a+"&dispCate=<%=vDisp%>",
			<% ElseIf vTab = "3" Then %>
			url: "/gift/talk/write_right_ajax.asp?tab=3&OrderType=<%=vOrderType%>&searchtxt="+encodeURIComponent($("#searchtxt").val())+"&page="+a+"&dispCate=<%=vDisp%>",
			<% End If %>
			cache: false,
			success: function(message)
			{
				$("#write_right").empty().append(message);
			}
	});
}

//마이위시 폴더 선택
function jsTalkRightListWish(a){
	$.ajax({
			url: "/gift/talk/write_right_ajax.asp?tab=<%=vTab%>&fidx="+a+"&OrderType=<%=vOrderType%>",
			cache: false,
			success: function(message)
			{
				$("#write_right").empty().append(message);
			}
	});
}

//상품정렬
function jsTalkRightListSorting(a){
	$.ajax({
			<% If vTab = "1" Then %>
			url: "/gift/talk/write_right_ajax.asp?tab=1&fidx=<%=vFolderID%>&OrderType="+a+"",
			<% ElseIf vTab = "2" Then %>
			url: "/gift/talk/write_right_ajax.asp?tab=2&OrderType="+a+"&searchtxt="+encodeURIComponent($("#searchtxt").val())+"&dispCate=<%=vDisp%>",
			<% ElseIf vTab = "3" Then %>
			url: "/gift/talk/write_right_ajax.asp?tab=3&OrderType="+a+"&searchtxt="+encodeURIComponent($("#searchtxt").val())+"&dispCate=<%=vDisp%>",
			<% End If %>
			cache: false,
			success: function(message)
			{
				$("#write_right").empty().append(message);
			}
	});
}

//상품검색
function jsTalkRightSearch(){
	var sTxt = $("#searchtxt");
	if(sTxt.val() == "상품코드 또는 키워드 입력" || sTxt.val() == ""){
		sTxt.val("");
		alert("상품코드 또는 키워드를 입력해주세요.");
		sTxt.focus();
		return;
	}else{
		$.ajax({
				url: "/gift/talk/write_right_ajax.asp?tab=2&OrderType=<%=vOrderType%>&searchtxt="+encodeURIComponent(sTxt.val())+"",
				cache: false,
				success: function(message)
				{
					$("#write_right").empty().append(message);
				}
		});
	}
}

//카테고리 선택
function jsTalkRightCateSearch(c){
	var sTxt = $("#searchtxt");
	if(sTxt.val() == "상품코드 또는 키워드 입력" || sTxt.val() == ""){
		sTxt.val("");
		alert("상품코드 또는 키워드를 입력해주세요.");
		sTxt.focus();
		return;
	}else{
		$.ajax({
				url: "/gift/talk/write_right_ajax.asp?tab=2&OrderType=<%=vOrderType%>&searchtxt="+encodeURIComponent(sTxt.val())+"&dispCate="+c+"",
				cache: false,
				success: function(message)
				{
					$("#write_right").empty().append(message);
				}
		});
	}
}

<!-- #include file="./inc_Javascript.asp" -->
</script>
<!-- 빠른 상품 찾기 -->
	<form name="itemSearch" method="get" style="margin:0px;" onSubmit="return false;">
	<input type="hidden" name="tab" value="<%=vTab%>">
	<input type="hidden" name="fidx" value="<%=vFolderID%>">
	<input type="hidden" name="dispCate" value="<%=vDisp%>">
	<input type="hidden" name="page" value="">
	<div class="inner" >
		<h4>빠른 상품 찾기</h4>
		<ul class="tabnav">
			<li><a href="" onClick="jsTalkRightListTabChange('2'); return false;" <%=CHKIIF(vTab="2"," class='on'","")%>>상품검색</a></li>
			<li><a href="" onClick="jsTalkRightListTabChange('1'); return false;" <%=CHKIIF(vTab="1"," class='on'","")%>>MY WISH</a></li>
			<li><a href="" onClick="jsTalkRightListTabChange('3'); return false;" <%=CHKIIF(vTab="3"," class='on'","")%>>최근 본 상품</a></li>
		</ul>

		<div class="tabcontainer">
			<% If vTab = "2" Then %>
			<!-- 상품 검색 -->
			<div id="findItem" class="findItem tabcont" style="display:<%=CHKIIF(vTab="2","block","none")%>;">
				<h5 class="hidden">상품 검색</h5>
				<div class="finder">
					<fieldset>
					<legend>상품 검색</legend>
						<div class="itext">
							<input type="text" name="searchtxt" id="searchtxt" onFocus="jsTalkRightSearchInput();" onkeyup="fnKeyInput(keyCode(event))" onkeypress="if(keyCode(event)==13) {jsTalkRightSearch();}" value="<% If vSearchText = "" Then %>상품코드 또는 검색어를 입력하세요<% Else Response.Write vSearchText End If %>" title="상품코드 또는 검색어를 입력하세요" />
						</div>
						<input type="submit" value="검색" class="btnsearch" onClick="jsTalkRightSearch();" />
					</fieldset>
				</div>

				<% If vSearchText <> "" Then %>
					<% If (cTalkItem.FResultCount < 1) Then %>
						<p class="result"><em>흠.. 검색결과가 없습니다.</em> <span>해당상품이 품절 되었을 경우 검색이 되지 않습니다.</span></p>
					<% else %>
						<p class="result"><strong>'<%=vSearchText%>'</strong> 검색결과 <strong><%= FormatNumber(cTalkItem.FTotalCount,0) %></strong>개</p>
						<div class="findList">
							<div class="breadcrumb">
								<%
								if vDisp<>"" then
									vCateDepth = cStr(len(vDisp)\3)+1			'하위 뎁스
								else
									vCateDepth = "1"
								end if
								if vCateDepth>3 then vCateDepth=3
								'// 카테고리별 검색결과
								set oGrCat = new SearchItemCls
								oGrCat.FRectSearchTxt = vSearchText
								oGrCat.FRectSortMethod = "ne"
								oGrCat.FRectSearchItemDiv = "y"		'//Y 기본카테고리만
								oGrCat.FRectSearchCateDep = "T"		'//T 하위카테고리 모두 검색
								oGrCat.FCurrPage = 1
								oGrCat.FPageSize = 20
								oGrCat.FScrollCount =10
								oGrCat.FListDiv = "search"
								oGrCat.FRectCateCode = "" 		'left(vDisp,3*vCateDepth-1)	'추가
								oGrCat.FSellScope="Y"		'// 품절상품 제외여부
								oGrCat.FGroupScope = "1"
								oGrCat.FLogsAccept = False '그룹형은 절대 !!! False
								'oGrCat.FRectSearchFlag = searchFlag
								'oGrCat.FminPrice	= minPrice
								'oGrCat.FmaxPrice	= maxPrice
								'oGrCat.FdeliType	= deliType
								'oGrCat.FcolorCode	= colorCD
								oGrCat.getGroupbyCategoryList
								%>
								<% if oGrCat.FResultCount > 0 then %>
									<div class="styled-selectbox">
										<select class="select" onchange="jsTalkRightCateSearch(this.value);" title="카테고리 선택">
											<option value=''>카테고리 선택</option>
											<%
												for Lp=0 to oGrCat.FResultCount-1
												response.write oGrCat.FItemList(Lp).FCateCd1
													If oGrCat.FItemList(Lp).FCateCd1 <> vTmpCode Then
														Response.Write "<option " & CHKIIF(oGrCat.FItemList(Lp).FCateCd1=left(vDisp,3),"selected","") & " value=" & oGrCat.FItemList(lp).FCateCd1 & ">" & Split(oGrCat.FItemList(Lp).FCateName,"^^")(0) &"</option>" & vbCrLf
														if oGrCat.FItemList(Lp).FCateCd1=left(vDisp,3) then
															vListName = Split(oGrCat.FItemList(Lp).FCateName,"^^")(0)
														end if
													End IF
													vTmpCode = oGrCat.FItemList(Lp).FCateCd1
												next
											%>
										</select>
									</div>
								<% end if %>
								<% set oGrCat = nothing %>
								<%
								if vCateDepth > 1 then
									response.write " &gt; "
									'// 카테고리별 검색결과
									set oGrCat = new SearchItemCls
									oGrCat.FRectSearchTxt = vSearchText
									oGrCat.FRectSortMethod = "ne"
									oGrCat.FRectSearchItemDiv = "y"		'//Y 기본카테고리만
									oGrCat.FRectSearchCateDep = "T"		'//T 하위카테고리 모두 검색
									oGrCat.FCurrPage = 1
									oGrCat.FPageSize = 20
									oGrCat.FScrollCount =10
									oGrCat.FListDiv = "search"
									oGrCat.FRectCateCode = left(vDisp,3)	'추가
									oGrCat.FSellScope="Y"		'// 품절상품 제외여부
									oGrCat.FGroupScope = "2"
									oGrCat.FLogsAccept = False '그룹형은 절대 !!! False
									'oGrCat.FRectSearchFlag = searchFlag
									'oGrCat.FminPrice	= minPrice
									'oGrCat.FmaxPrice	= maxPrice
									'oGrCat.FdeliType	= deliType
									'oGrCat.FcolorCode	= colorCD
									oGrCat.getGroupbyCategoryList
								%>
									<% if oGrCat.FResultCount > 0 then %>
										<div class="styled-selectbox">
											<select class="select" onchange="jsTalkRightCateSearch(this.value);" title="카테고리 선택">
												<option value='<%= left(vDisp,3) %>'>카테고리 선택</option>
												<%
													for Lp=0 to oGrCat.FResultCount-1
														If oGrCat.FItemList(Lp).FCateCd2 <> vTmpCode Then
															Response.Write "<option " & CHKIIF(oGrCat.FItemList(Lp).FCateCd2=mid(vDisp,4,3),"selected","") & " value=" & left(oGrCat.FItemList(lp).FCateCode,6) & ">" & Split(oGrCat.FItemList(Lp).FCateName,"^^")(1) &"</option>" & vbCrLf
															if oGrCat.FItemList(Lp).FCateCd2=mid(vDisp,4,3) then
																vListName = Split(oGrCat.FItemList(Lp).FCateName,"^^")(1)
															end if
														End IF
														vTmpCode = oGrCat.FItemList(Lp).FCateCd2
													next
												%>
											</select>
										</div>
									<% end if %>
								<% set oGrCat = nothing %>
								<% end if %>
								<%
								if vCateDepth > 2 then
									response.write " &gt; "
									'// 카테고리별 검색결과
									set oGrCat = new SearchItemCls
									oGrCat.FRectSearchTxt = vSearchText
									oGrCat.FRectSortMethod = "ne"
									oGrCat.FRectSearchItemDiv = "y"		'//Y 기본카테고리만
									oGrCat.FRectSearchCateDep = "T"		'//T 하위카테고리 모두 검색
									oGrCat.FCurrPage = 1
									oGrCat.FPageSize = 20
									oGrCat.FScrollCount =10
									oGrCat.FListDiv = "search"
									oGrCat.FRectCateCode = left(vDisp,6)	'추가
									oGrCat.FSellScope="Y"		'// 품절상품 제외여부
									oGrCat.FGroupScope = "3"
									oGrCat.FLogsAccept = False '그룹형은 절대 !!! False 
									'oGrCat.FRectSearchFlag = searchFlag
									'oGrCat.FminPrice	= minPrice
									'oGrCat.FmaxPrice	= maxPrice
									'oGrCat.FdeliType	= deliType
									'oGrCat.FcolorCode	= colorCD
									oGrCat.getGroupbyCategoryList
								%>
									<% if oGrCat.FResultCount > 0 then %>
										<div class="styled-selectbox">
											<select class="select" onchange="jsTalkRightCateSearch(this.value);" title="카테고리 선택">
												<option value='<%= left(vDisp,6) %>'>카테고리 선택</option>
												<%
													for Lp=0 to oGrCat.FResultCount-1
														If oGrCat.FItemList(Lp).FCateCd3 <> vTmpCode Then
															Response.Write "<option " & CHKIIF(oGrCat.FItemList(Lp).FCateCd3=mid(vDisp,7,9),"selected","") & " value=" & left(oGrCat.FItemList(lp).FCateCode,9) & ">" & Split(oGrCat.FItemList(Lp).FCateName,"^^")(2) &"</option>" & vbCrLf
															if oGrCat.FItemList(Lp).FCateCd3=mid(vDisp,7,9) then
																vListName = Split(oGrCat.FItemList(Lp).FCateName,"^^")(2)
															end if
														End IF
														vTmpCode = oGrCat.FItemList(Lp).FCateCd3
													next
												%>
											</select>
										</div>
									<% end if %>
									<% set oGrCat = nothing %>
								<% end if %>
							</div>
							<%
							If vTab = "2" AND vListName = "" Then
								vListName = "All"
							End If
							%>
							<div class="option">
								<span><strong><%=vListName%></strong> (<%= FormatNumber(cTalkItem.FTotalCount,0) %>)</span>
								<div class="styled-selectbox" name="OrderType" >
									<select class="select" title="정렬 방식 선택" onChange="jsTalkRightListSorting(this.value);">
										<% If vTab = "1" Then %><option value="recent" <% if vOrderType="" or vOrderType="recent" then response.write "selected" %>>최근담은순</option><% End If %>
										<option value="fav" <% if vOrderType="fav" then response.write "selected" %>>인기상품순</option>
										<option value="highprice" <% if vOrderType="highprice" then response.write "selected" %>>높은가격순</option>
										<option value="lowprice" <% if vOrderType="lowprice" then response.write "selected" %>>낮은가격순</option>
									</select>
								</div>
							</div>
							<div class="pdtWrap">
								<ul class="pdtList">
									<%
									If (cTalkItem.FResultCount > 0) Then
										for ix = 0 to cTalkItem.FResultCount-1
										
											vPrice = cTalkItem.FItemList(ix).fnRealAllPrice
											if vPrice<>"" and vPrice<>0 and cTalkItem.FItemList(ix).FOrgPrice<>"" and cTalkItem.FItemList(ix).FOrgPrice<>0 then
												vSale = Round(100-(100*(vPrice/cTalkItem.FItemList(ix).FOrgPrice)))
											else
												vSale=0
											end if
									%>
										<!-- for dev msg : 페이지당 5개 보여주세요. -->
										<li onClick="jsTalkSelectItem('<%= cTalkItem.FItemList(ix).FItemID %>');">
											<div class="pdtPhoto"><img src="<% = cTalkItem.FItemList(ix).FImageIcon2 %>" width="100" height="100" alt="<%= Replace(cTalkItem.FItemList(ix).FItemName,"""","") %>" /></div>
											<div class="pdtInfo">
												<p class="pdtBrand"><%= cTalkItem.FItemList(ix).FBrandName %></p>
												<p class="pdtName tPad07"><%= cTalkItem.FItemList(ix).FItemName %></p>
												<p class="pdtPrice"><span class="finalP"><%=FormatNumber(vPrice,0)%>원</span><% If vSale > 0 Then %> <strong class="crRed">[<%=vSale%>%]</strong><% End If %></p>
											</div>
										</li>
									<% 	
										next
									end if
									%>
								</ul>
							</div>
							<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(cTalkItem.FcurrPage, cTalkItem.FtotalCount, cTalkItem.FPageSize, 5, "jsTalkRightListPaging") %></div>
						</div>
					<% end if %>
				<% end if %>
			</div>
			<% end if %>

			<% If vTab = "1" Then %>
			<!-- 나의 위시 -->
			<div id="findWish" class="findWish tabcont" style="display:<%=CHKIIF(vTab="1","block","none")%>;">
				<h5 class="hidden">MY WISH</h5>
				<div class="finder">
					<div class="selectwrap open">
					<%
					IF isArray(arrList) THEN
						For intLoop = 0 To UBound(arrList,2)
							If CStr(arrList(0,intLoop))=CStr(vFolderID) Then
								vListName = chkIIF(arrList(0,intLoop)="0","기본폴더",arrList(1,intLoop))
							End If
						next
					end if
					%>
						<button type="button" class="myValue"><span><%= vListName %></span><em></em></button>
						<ul class="aList">
						<%
						IF isArray(arrList) THEN
							For intLoop = 0 To UBound(arrList,2)
								If CStr(arrList(0,intLoop))=CStr(vFolderID) Then
									vListName = chkIIF(arrList(0,intLoop)="0","기본폴더",arrList(1,intLoop))
								End If
								Response.Write "<li" & CHKIIF(CStr(arrList(0,intLoop))=CStr(vFolderID)," class='hover'","") & "><a href='' onClick=""jsTalkRightListWish('"&arrList(0,intLoop)&"'); return false;"">" & chkIIF(arrList(0,intLoop)="0","기본폴더",arrList(1,intLoop)) & "</a></li>"
							Next
						Else
							Response.Write "<li><span>기본폴더</span></li>"
						End If
						%>
						</ul>
					</div>
				</div>
				<% If (cTalkItem.FResultCount < 1) Then %>
					<p class="result"><em>등록된 상품이 없습니다.</em></p>
				<% else %>
					<div class="findList">
						<div class="option">
						<span><strong><%=vListName%></strong> (<%= FormatNumber(cTalkItem.FTotalCount,0) %>)</span>
						<div class="styled-selectbox" name="OrderType" >
							<select class="select" title="정렬 방식 선택" onChange="jsTalkRightListSorting(this.value);">
								<% If vTab = "1" Then %><option value="recent" <% if vOrderType="" or vOrderType="recent" then response.write "selected" %>>최근담은순</option><% End If %>
								<option value="fav" <% if vOrderType="fav" then response.write "selected" %>>인기상품순</option>
								<option value="highprice" <% if vOrderType="highprice" then response.write "selected" %>>높은가격순</option>
								<option value="lowprice" <% if vOrderType="lowprice" then response.write "selected" %>>낮은가격순</option>
							</select>
						</div>
						</div>
	
						<div class="pdtWrap">
							<ul class="pdtList">
							<%
							If (cTalkItem.FResultCount > 0) Then
								for ix = 0 to cTalkItem.FResultCount-1
								
									vPrice = cTalkItem.FItemList(ix).fnRealAllPrice
									if vPrice<>"" and vPrice<>0 and cTalkItem.FItemList(ix).FOrgPrice<>"" and cTalkItem.FItemList(ix).FOrgPrice<>0 then
										vSale = Round(100-(100*(vPrice/cTalkItem.FItemList(ix).FOrgPrice)))
									else
										vSale=0
									end if
							%>
								<li onClick="jsTalkSelectItem('<%= cTalkItem.FItemList(ix).FItemID %>');">
									<div class="pdtPhoto"><img src="<% = cTalkItem.FItemList(ix).FImageIcon2 %>" width="100" height="100" alt="<%= Replace(cTalkItem.FItemList(ix).FItemName,"""","") %>" /></div>
									<div class="pdtInfo">
										<p class="pdtBrand"><%= cTalkItem.FItemList(ix).FBrandName %></p>
										<p class="pdtName tPad07"><%= cTalkItem.FItemList(ix).FItemName %></p>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(vPrice,0)%>원</span><% If vSale > 0 Then %> <strong class="crRed">[<%=vSale%>%]</strong><% End If %></p>
									</div>
								</li>
							<% 	
								next
							end if
							%>
							</ul>
						</div>
						<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(cTalkItem.FcurrPage, cTalkItem.FtotalCount, cTalkItem.FPageSize, 5, "jsTalkRightListPaging") %></div>
					</div>
				<% end if %>
			</div>
			<% end if %>

			<% If vTab = "3" Then %>
			<!-- 최근 본 상품 -->
			<div id="findLately" class="findLately tabcont" style="display:<%=CHKIIF(vTab="3","block","none")%>;">
				<h5 class="hidden">최근 본 상품</h5>
				<% If myTodayShopping.FResultCount < 1 Then %>
					<p class="result">최근 본 상품이 없습니다.</p>
				<% else %>
					<div class="findList">
						<p class="noti">현재 오픈되어 있는 윈도우창을 닫으시면 자동 소멸되며 <strong>최근기준으로 40개까지 담을 수 있습니다.</strong></p>
						<div class="option">
							<span><strong>All</strong> (<%= FormatNumber(myTodayShopping.FTotalCount,0) %>)</span>
							<div class="styled-selectbox" name="OrderType" >
								<select class="select" title="정렬 방식 선택" onChange="jsTalkRightListSorting(this.value);">
									<% If vTab = "1" Then %><option value="recent" <% if vOrderType="" or vOrderType="recent" then response.write "selected" %>>최근담은순</option><% End If %>
									<option value="fav" <% if vOrderType="fav" then response.write "selected" %>>인기상품순</option>
									<option value="highprice" <% if vOrderType="highprice" then response.write "selected" %>>높은가격순</option>
									<option value="lowprice" <% if vOrderType="lowprice" then response.write "selected" %>>낮은가격순</option>
								</select>
							</div>
						</div>
						<div class="pdtWrap">
							<ul class="pdtList">
							<% For lp=0 To myTodayShopping.FResultCount-1 %>
								<li onClick="jsTalkSelectItem('<%= myTodayShopping.FItemList(lp).FItemID %>');">
									<div class="pdtPhoto"><img src="<%= myTodayShopping.FItemList(lp).FImageicon2 %>" width="100" height="100" alt="<% = myTodayShopping.FItemList(lp).FItemName %>" /></div>
									<div class="pdtInfo">
										<p class="pdtBrand"><%= myTodayShopping.FItemList(lp).FBrandName %></p>
										<p class="pdtName tPad07"><%= myTodayShopping.FItemList(lp).FItemName %></p>
										<% IF myTodayShopping.FItemList(lp).IsSaleItem or myTodayShopping.FItemList(lp).isCouponItem Then %>
											<% IF myTodayShopping.FItemList(lp).IsSaleItem then %>
												<p class="ftSmall2 c999"><del><%= FormatNumber(myTodayShopping.FItemList(lp).getOrgPrice,0) %>원</del></p>
												<p class="pdtPrice"><%= FormatNumber(myTodayShopping.FItemList(lp).getRealPrice,0) %>원 <strong class="crRed">[<%= myTodayShopping.FItemList(lp).getSalePro %>]</strong></p>
											<% End IF %>
											<% IF myTodayShopping.FItemList(lp).IsCouponItem Then %>
												<% IF Not(myTodayShopping.FItemList(lp).IsFreeBeasongCoupon() or myTodayShopping.FItemList(lp).IsSaleItem) then %>
													<p class="ftSmall2 c999"><del><% = FormatNumber(myTodayShopping.FItemList(lp).getRealPrice,0) %>원</del></p>
												<% End IF %>
												<p class="pdtPrice"><% = FormatNumber(myTodayShopping.FItemList(lp).GetCouponAssignPrice,0) %>원 <strong class="crGrn">[<% = myTodayShopping.FItemList(lp).GetCouponDiscountStr %>]</strong><% IF myTodayShopping.FItemList(lp).IsFreeBeasong Then Response.Write "[무료배송]" %></p>
											<% end if %>
										<% Else %>
											<p class="pdtPrice"><%= FormatNumber(myTodayShopping.FItemList(lp).getRealPrice,0) %><% if myTodayShopping.FItemList(lp).IsMileShopitem then %> Point<% else %> 원<% end if %></p>
										<% End if %>
									</div>
								</li>
							<% next %>
							</ul>
						</div>
						<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(myTodayShopping.FcurrPage, myTodayShopping.FtotalCount, myTodayShopping.FPageSize, 5, "jsTalkRightListPaging") %></div>
					</div>
				<% end if %>
			</div>
			<% end if %>
		</div>
	</div>
	</form>
<% If Request("gb") = "first" Then	'### 처음 들어올때 & back버튼 클릭하면 초기값으로 셋팅. %>
<script>$('input[name="itemid"]').val(',');$('input[name="itemcount"]').val('0');</script>
<% End If %>
<% set cTalkItem = nothing %>
<% set myTodayShopping = nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->