<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new101.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=101';""><strong>디자인문구</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new102.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=102';""><strong>디지털/핸드폰</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new103.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=103';""><strong>캠핑/트래블</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new104.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=104';""><strong>토이</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new121.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=121';""><strong>가구/조명</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new122.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=122';""><strong>데코/플라워</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new120.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=120';""><strong>패브릭/수납</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new112.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=112';""><strong>키친</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new119.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=119';""><strong>푸드</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new117.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=117';""><strong>패션의류</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new116.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=116';""><strong>가방/슈즈/주얼리</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new118.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=118';""><strong>뷰티</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new115.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=115';""><strong>베이비/키즈</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new110.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=110';""><strong>Cat &amp; Dog</strong></p></li>" END IF
On Error Goto 0
%>