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
		clsEvtHSP.FScrollCount = 5
		arrDA = clsEvtHSP.fnGetHSPList
		idaTotCnt = clsEvtHSP.FTotCnt
		idaTotPg = clsEvtHSP.FTotalPage
		set clsEvtHSP = nothing
 

	if isArray(arrDA) then


%>
<div id="navHey" class="navHey">
	<div class="navName" lang="en"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_contetents_list.png" alt="CONTENTS LIST" /></div>
	<ul>
		<%' for dev msg : 한 페이지당 5개씩 보여주세요 현재 페이지에는 클래스 on 붙여주세요 <a href="" class="on"> %>
		<% for intDA=0 to ubound(arrDA,2) %>
		<li>
			<a href="/HSProject/?eventid=<%=arrDa(0,intDa)%>&page=<%=page%>" <% If Trim(eCode)=Trim(arrDa(0,intDa)) Then %>class="on"<% End If %>>
				<div class="thumb"><img src="<%=arrDa(3,intDa)%>" alt="<%=replace(arrDa(1,intDa),"""","")%>" width="70" height="70" /></div>
				<strong>
					<%
						If Len((idaTotCnt-CInt(arrDa(6,intDa))+1))="1" Then
							Response.write "0"&(idaTotCnt-CInt(arrDa(6,intDa))+1)&". "
						Else
							Response.write (idaTotCnt-CInt(arrDa(6,intDa))+1)&". "					
						End If
					%>
					<%=replace(arrDa(1,intDa),"""","")%>
				</strong>
				<span><%=replace(arrDa(4,intDa),"""","")%></span>
			</a>
		</li>
		<% Next %>
	</ul>

	<div class="pageWrapV15">
		<%= fnDisplayPaging_New(page,idaTotCnt,4,5,"goHSPPageH") %>
	</div>
</div>
<%	end if %> 
<!-- #include virtual="/lib/db/dbclose.asp" -->