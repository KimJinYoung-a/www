<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCommonCls.asp" -->
<!-- #include virtual="/lib/classes/HSProject/HSPCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'#######################################################
'	History	:  2015.10.23 원승현 생성
'	Description : 헤이썸띵 Ajax 페이지
'#######################################################

 Dim clsEvtHSP
 Dim eCode, page, lp
 
 	eCode		= getNumeric(requestCheckVar(request("eventid"),10))
 	page 	  	= getNumeric(requestCheckVar(request("page"),8))
	if eCode 	= "" then eCode = 0
	if page		= "" then page 	= 1

 	Dim idaTotCnt, idaTotPg, arrDA, intDA
		set clsEvtHSP = new ClsHSP
		clsEvtHSP.FCurrPage = page
		clsEvtHSP.FPageSize = 4
		clsEvtHSP.FScrollCount = 10
		arrDA = clsEvtHSP.fnGetHSPList
		idaTotCnt = clsEvtHSP.FTotCnt
		idaTotPg = clsEvtHSP.FTotalPage
		set clsEvtHSP = nothing
 
	if isArray(arrDA) then

%>
<div class="listHey">
	<div class="inner">
		<p class="total">TOTAL <b><%=idaTotCnt%></b></p>

		<ul>
			<% for intDA=0 to ubound(arrDA,2) %>
			<li>
				<a href="/HSProject/?eventid=<%=arrDa(0,intDa)%>&page=<%=page%>">
					<div class="thumb"><img src="<%=arrDa(3,intDa)%>" alt="<%=replace(arrDa(1,intDa),"""","")%>" width="200" height="200" /></div>
					<strong><%=replace(arrDa(1,intDa),"""","")%></strong>
					<span><%=replace(arrDa(4,intDa),"""","")%></span>
				</a>
			</li>
			<% next %>
		</ul>

		<%' paging %>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(page,idaTotCnt,4,10,"goHSPPage") %>
		</div>
	</div>
</div>
<%	end if %> 
<!-- #include virtual="/lib/db/dbclose.asp" -->