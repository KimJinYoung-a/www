<%@ codepage="65001" language="VBScript" %>
<%
option Explicit
Response.CharSet = "utf-8"
%>
<%
'#######################################################
'	History	:  2015.03.20 허진원 생성
'	Description : My10x10 Main > 내 후기 내용
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
	if ((Not IsUserLoginOK) and (Not IsGuestLoginOK)) then
		dbget.Close:  response.end
	end if

	dim userid	: userid	= getEncLoginUserID
	dim page	: page		= requestCheckVar(request("page"),9)
	if page="" then
		page=1
	else
		page = cInt(page) 
	end if

	dim EvList
	set EvList = new CEvaluateSearcher
	EvList.FRectUserID = Userid
	EvList.FPageSize = 1
	EvList.FCurrPage	= page
	EvList.FRectEvaluatedYN="N"
	EvList.NotEvalutedItemListNew ''후기 안쓰인 상품 가져오기

	if EvList.FResultCount > 0 then
%>
<div class="pdtList">
	<a href="/shopping/category_prd.asp?itemid=<%= EvList.FItemList(0).FItemId %>" title="상품 페이지로 이동" class="figure"><img src="<%= getThumbImgFromURL(EvList.FItemList(0).FIcon2,106,106,"true","false") %>" width="106" height="106" alt="<%= Replace(EvList.FItemList(0).FItemName,"""","") %>" /></a>
	<span class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%= EvList.FItemList(0).FMakerid %>" title="브랜드로 이동"><%= EvList.FItemList(0).FMakerName %></a></span>
	<span class="pdtName"><a href="/shopping/category_prd.asp?itemid=<%= EvList.FItemList(0).FItemId %>"><%= EvList.FItemList(0).FItemName %></a></span>
	<% if EvList.FItemList(0).FEvalCnt=0 then %><strong class="saving cRd0V15">+200p적립</strong><% end if %>
	<a href="" class="btn btnS3 btnRed btnW80 fn" onclick="AddEval('<%= EvList.FItemList(0).FOrderSerial %>','<%= EvList.FItemList(0).FItemID %>','<%= EvList.FItemList(0).FItemOption %>');return false;" title="상품후기 쓰기">상품후기 쓰기</a>
</div>
<div class="pagination">
	<button type="button" onclick="<%=chkIIF(page>1,"fnGetMyEvalCont(" & page-1 & ");","")%>return false;" class="prev">이전</button>
	<button type="button" onclick="<%=chkIIF(page<EvList.FtotalCount,"fnGetMyEvalCont(" & page+1 & ");","")%>return false;" class="next">다음</button>
	<span><em><%=page%></em>/<%=EvList.FtotalCount%></span>
</div>
<%	
	end if
	set EvList = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->