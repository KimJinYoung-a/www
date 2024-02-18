<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.Buffer = True
'#######################################################
'	History	:  2013.10.03 허진원 생성
'              2014.07.29 허진원 : 쿠키 > 세션으로 변경
'	Description : 나의 검색어 처리 및 출력
'#######################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim mode, keyword, arrMyKwd, arrCKwd, rstKwd, i

mode = requestCheckVar(request("mode"),3)
keyword = requestCheckVar(request("kwd"),100)

Select Case mode
	Case "del"
		'선택삭제
		''arrCKwd = request.Cookies("search")("keyword")
		arrCKwd = session("myKeyword")
		arrCKwd = split(arrCKwd,",")
	
		rstKwd = ""
		if ubound(arrCKwd)>-1 then
			for i=0 to ubound(arrCKwd)
				if trim(arrCKwd(i))<>trim(keyword) then
					rstKwd = rstKwd & chkIIF(rstKwd="","",",") & arrCKwd(i)
				end if
				if i>9 then Exit For
			next
		end if

		'쿠키 재저장
		''response.Cookies("search").domain = "10x10.co.kr"
		''response.cookies("search").Expires = Date + 3	'3일간 쿠키 저장
		''response.Cookies("search")("keyword") = rstKwd
		session("myKeyword") = rstKwd

		if rstKwd<>"" then 
			arrMyKwd = split(rstKwd,",")

			for i=0 to ubound(arrMyKwd)
				Response.Write "<span><a href=""/search/search_result.asp?rect=" & server.URLEncode(arrMyKwd(i)) & "&exkw=1"">" & arrMyKwd(i) & "</a>"
				Response.Write " <a href="""" onclick=""delMyKeyword('" & server.URLEncode(arrMyKwd(i)) & "');return false;""><img src=""http://fiximage.10x10.co.kr/web2013/common/btn_delete.gif"" alt=""Delete"" class=""deleteBtn"" /></a>"
				Response.Write "</span>"
				if i>=4 then Exit For
			next
		end if

	Case "da"
		'전체 삭제
		session("myKeyword") = ""

End Select
%>