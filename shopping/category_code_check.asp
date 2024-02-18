<%
	Dim vDisp, vDepth, vIsBookCate
	vDisp = getNumeric(RequestCheckVar(Request("disp"),18))
	vDepth = getNumeric(RequestCheckVar(Request("depth"),1))
	
	If Request("cdl") <> "" Then	'### 예전주소로 들어올 경우.
		Response.Redirect "/shopping/category_main.asp"
	End If

	If vDisp <> "" Then
		If isNumeric(vDisp) = False Then	'### 코드값이 숫자가 아닐때.
			Response.Redirect "/shopping/category_main.asp"
		End If
	
		If (Len(vDisp) mod 3) <> 0 Then		'### 코드값이 3자리씩이 아닐때(잘못입력된경우).
			Response.Redirect "/shopping/category_main.asp"
		End IF
	Else
		vDisp = "101"
	End If
	
	vDepth = (Len(vDisp)/3)
	If vDepth = 1 AND CurrURL() = "/shopping/category_list.asp" Then		'### 1뎁스의 코드를 달고 리스트 페이지로 갈 경우는 메인으로 돌림.
		if vDisp="123" then
			'클리어런스 카테고리면 > Sale클리어런스로 이동(2016.07.26)
			Response.Redirect "/clearancesale/"
		else
			Response.Redirect "/shopping/category_main.asp?disp=" & vDisp & ""
		end if
	End If
	
	If vDepth > 1 Then
		vIsBookCate = fnIsBookCate(vDisp)
	End If
	
	If vDepth > 1 AND CurrURL() = "/shopping/category_main.asp" Then		'### 2뎁스 이상의 코드를 달고 메인 페이지로 갈 경우는 리스트로 돌림.
		Response.Redirect "/shopping/category_list.asp?disp=" & vDisp & ""
	End If
	
	If InStr(",106,114,113,111,109,107,",Left(vDisp,3)) > 0 Then
		Response.Redirect "/shopping/category_main.asp?disp=101"
	End If
	
	
	Function fnIsBookCate(disp)
		If Len(disp) > 5 Then
			If InStr(",101113,102112,103112,104114,121114,122112,120113,112113,119109,117112,116111,118111,115113,110115,",Left(disp,6)) > 0 Then
				fnIsBookCate = True
			Else
				fnIsBookCate = False
			End If
		Else
			fnIsBookCate = False
		End IF
	End Function
%>