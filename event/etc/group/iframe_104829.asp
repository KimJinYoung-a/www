<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2020-08-06"
	'response.write currentdate
%>
<style type="text/css">
.evt104829 {position:relative; height:182px; padding-top:310px; background:url(//webimage.10x10.co.kr/eventIMG/2020/104829/bg.png) 50% 0 no-repeat;}
</style>
</head>
<body>
<!-- 104829 -->
<div class="evt104829">
    <% if currentdate < "2020-08-07" then %>
    <div><img src="//webimage.10x10.co.kr/eventIMG/2020/104829/w_txt2.png" alt="D-2"></div>
    
    <% elseif currentdate < "2020-08-08" then %>
    <div><img src="//webimage.10x10.co.kr/eventIMG/2020/104829/w_txt1.png" alt="D-1"></div>
    
    <% else %>
    <div><img src="//webimage.10x10.co.kr/eventIMG/2020/104829/w_txt0.png" alt="D-day"></div>
    <% end if %>
</div>
<!--// 104829 -->

</body>
</html>