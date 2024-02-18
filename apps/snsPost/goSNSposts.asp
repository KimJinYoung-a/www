<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<%

'#######################################################
'	History	:  2010.07.21 허진원 생성
'	Description : 쇼셜 네트워크 서비스로 글보내기
'               - 내용은 반드시 UTF8로 전송해야 됨.
'#######################################################
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>SNS Post Trans</title>
</head>
<body>
<%
	'변수선언
	Dim StDiv, strLink, strTitle, strPre, strTags, strImg
	StDiv = Request("svc")
	strLink = Server.URLEncode(Request("link"))
	strTitle = Server.URLEncode(Request("tit"))
	strPre = Server.URLEncode(Request("pre"))
	strTags = Server.URLEncode(Request("tag"))
	strImg = Server.URLEncode(Request("img"))
	if strTitle="" then
		Response.Write "<script language='javascript'>" & vbCrLf &_
			"alert('보낼 내용이 없습니다.');" & vbCrLf &_
			"self.close();" & vbCrLf &_
			"</script>"
		Response.End
	end if

	Select Case StDiv
		Case "m2"
			'# 미투데이
			Response.Redirect("http://me2day.net/plugins/post/new?new_post[body]=%5B" & Replace(strPre,"%ED%85%90%EB%B0%94%EC%9D%B4%ED%85%90","%5C%ED%85%90%EB%B0%94%EC%9D%B4%ED%85%90%5C") & "%5D+%22" & strTitle & "%22:" & strLink & "&new_post[tags]=" & strTags)
		Case "m2e"
			'# 미투데이 2012-04-30 김진영 추가 따옴표처리
			Response.Redirect("http://me2day.net/posts/new?new_post[body]=%5B" & Replace(strPre,"%ED%85%90%EB%B0%94%EC%9D%B4%ED%85%90","%5C%ED%85%90%EB%B0%94%EC%9D%B4%ED%85%90%5C") & "%5D" & strTitle & "%22:" & strLink & "&new_post[tags]=" & strTags)
		Case "tw"
			'# 트위터
			'신버전의 버그로 URL문자 전각문자로 치환
			strPre = convFulChar(strPre)
			strTitle = convFulChar(strTitle)
			Response.Redirect("http://twitter.com/intent/tweet?text=%5B" & strPre & "%5D+" & strTitle & "+" & strTags & "&url=" & strLink & "&lang=ko")

		Case "fb"
			'# 페이스북
			Response.Redirect("https://www.facebook.com/sharer.php?u=" & strLink & "&t=" & strPre & "+" & strTitle)
		Case "yz"
			'# 다음 요즘
			Response.Redirect("http://yozm.daum.net/api/popup/prePost?link=" & strLink & "&prefix=" & strPre & "+" & strTitle)
		Case "pt"
			'# 핀터레스트
			Response.Redirect("http://pinterest.com/pin/create/button/?url=" & strLink & "&media=" & strImg)
		Case Else
			Response.Write "<script language='javascript'>" & vbCrLf &_
				"alert('잘못된 접근입니다.');" & vbCrLf &_
				"self.close();" & vbCrLf &_
				"</script>"
	end Select

	'// 전각문자 변환
	function convFulChar(xcon)
		xcon = Replace(xcon,"%26","%EF%BC%86")	'&
		xcon = Replace(xcon,"%23","%EF%BC%83")	'#
		xcon = Replace(xcon,"%3F","%EF%BC%9F")	'?
		convFulChar = xcon
	end function
%>
</body>
</html>
