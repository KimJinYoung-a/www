<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.Buffer = True
'#######################################################
'	History	:  2013.10.01 허진원 생성
'	Description : PLAY 검색 결과 Ajax
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<%
	dim oGrPly, lp
	dim DocSearchText : DocSearchText = requestCheckVar(request("rect"),100) '현재 입력된 검색어
	dim ExceptText	: ExceptText=requestCheckVar(request("extxt"),100) '결과내 제외어
	dim currpage	:	currpage=getNumeric(requestCheckVar(request("cpg"),8)) '페이지

	if currpage="" then currpage=1

	DocSearchText = RepWord(DocSearchText,"[^가-힣a-zA-Z0-9.&%\-\s]","")
	ExceptText = RepWord(ExceptText,"[^가-힣a-zA-Z0-9.&%\-\s]","")

	'// PLAY 검색결과
	set oGrPly = new SearchPlayCls
	oGrPly.FRectSearchTxt = DocSearchText
	oGrPly.FRectExceptText = ExceptText
	oGrPly.FCurrPage = currpage
	oGrPly.FPageSize = 8
	oGrPly.FScrollCount =10
	oGrPly.getPlayList

	'// PLAY 검색 결과
	if oGrPly.FResultCount>0 then
%>
	<!-- PLAY 검색 결과 -->
	<div class="schPlayV15">
		<div class="playContListV15">
		<%	FOR lp = 0 to oGrPly.FResultCount-1 %>
			<div class="box">
				<dl>
					<dt><img src="http://fiximage.10x10.co.kr/web2013/play/thumb_title<%=Num2Str(oGrPly.FItemList(lp).Fplaycate,2,"0","R")%>.gif" alt="<%=oGrPly.FItemList(lp).getPlayCateNm%>" /></dt>
					<dd>
						<a href="<%=oGrPly.FItemList(lp).getPlayCateLink & oGrPly.FItemList(lp).Fidx%><%=chkiif(oGrPly.FItemList(lp).Fplaycate="5","&viewno="&oGrPly.FItemList(lp).FsortNo,"")%>"><img src="<%=oGrPly.FItemList(lp).FlistImage%>" alt="<%=Replace(oGrPly.FItemList(lp).Fplayname,"""","")%>" /></a>
					</dd>
				</dl>
			</div>
		<% Next %>
		</div>

		<!-- //Paging -->
		<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(currpage,oGrPly.FTotalCount,oGrPly.FPageSize,10,"jsGoPlayPage") %></div>
	</div>
<%
	end if

	Set oGrPly = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->