<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCommonCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/dayAndCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'#######################################################
'	History	:  2010.04.09 허진원 생성
'	Description : DAY& Ajax 페이지
'#######################################################
 Dim clsEvtDayand
 Dim eCode, page, lp
 
 	eCode		= getNumeric(requestCheckVar(request("eventid"),10))
 	page 	  	= getNumeric(requestCheckVar(request("page"),8))
	if eCode 	= "" then eCode = 0
	if page		= "" then page 	= 1

 	Dim idaTotCnt, idaTotPg, arrDA, intDA
		set clsEvtDayand = new ClsDayAnd
		clsEvtDayand.FCurrPage = page
		clsEvtDayand.FPageSize = 10
		clsEvtDayand.FScrollCount = 10 
		arrDA = clsEvtDayand.fnGetDayAndList
		idaTotCnt = clsEvtDayand.FTotCnt
		idaTotPg = clsEvtDayand.FTotalPage
		set clsEvtDayand = nothing
 
	if isArray(arrDA) then
%>
<ul class="pastDayandList">
<% for intDA=0 to ubound(arrDA,2) %>
	<li <%=chkIIF(cStr(eCode)=cStr(arrDa(0,intDa)),"class=""current""","")%> onclick="viewCont(<%=arrDa(0,intDa)%>,<%=page%>)">
		<p class="thumb"><img src="<%=arrDa(3,intDa)%>" alt="<%=replace(arrDa(1,intDa),"""","")%>" /><span></span></p>
		<p class="tPad05" style="cursor:pointer;"><%=arrDa(1,intDa)%></p>
	</li>
<% next %>
</ul>
<span class="listMove goListPrev" <% if Int(page)>1 then %>onclick="goPage(<%=page-1%>)"<% end if %>>이전페이지로 이동</span>
<span class="listMove goListNext" <% if Int(page)<Int(idaTotPg) then %>onclick="goPage(<%=page+1%>)"<% end if %>>다음페이지로 이동</span>
<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(page,idaTotCnt,10,10,"goPage") %></div>
<%	end if %> 
<!-- #include virtual="/lib/db/dbclose.asp" -->