<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>

<%
'#######################################################
'	History	:  2013.09.04 허진원 : 생성
'	History	:  2016.04.18 유태욱 : listisusing 추가
'	Description : culturestation 메인 추가 페이지 Ajax
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestationCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	dim oCulture , i, tmpTit, listisusing
	dim page, idx
	page = getNumeric(requestCheckVar(request("page"),5))
	idx = getNumeric(requestCheckVar(request("idx"),5))
	if page="" then page=1

	listisusing = ""
	if GetLoginUserLevel <> "7" then
		listisusing = "Y"
	end if
	
	'// 컬쳐에디터 배너 접수
	set oCulture = new ceditor_list
	oCulture.FCurrPage = page
	oCulture.FPageSize = 5
	oCulture.FScrollCount = 3
	oCulture.frectChkImg="N"	'이미지 없어도 됨
	oCulture.frectisusing = listisusing
	oCulture.feditor_list()

	if oCulture.FResultCount>0 then
%>
	<ul>
	<%
		for i=0 to oCulture.FResultCount-1
			tmpTit = oCulture.FItemList(i).feditor_name
			tmpTit = Replace(tmpTit,"NO." & oCulture.FItemList(i).feditor_no & ".","")
			tmpTit = Replace(tmpTit,"NO." & oCulture.FItemList(i).feditor_no,"")
			tmpTit = trim(tmpTit)
	%>
		<li>
			<a href="culturestation_editor.asp?editor_no=<%=oCulture.FItemList(i).feditor_no%>&page=<%=page%>" <%=chkIIF(cInt(oCulture.FItemList(i).feditor_no)=cInt(idx),"class=""current""","")%>>
				<span class="numbering"><span>NO.<%=oCulture.FItemList(i).feditor_no%></span> | <span><%=formatDate(oCulture.FItemList(i).fregdate,"0000/00/00")%></span></span>
				<em><%=tmpTit%></em>
			</a>
		</li>
	<%
		next
	%>
	</ul>

	<%= replace(fnDisplayPaging_New_nottextboxdirect(oCulture.FcurrPage, oCulture.FtotalCount, oCulture.FPageSize, 3, "FnMovePage"),"paging tMar20","paging") %>
<%
	end if

	set oCulture = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->