<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
'####################################################
' Description : pen themselves
' History : 2016-09-06 유태욱 생성
'####################################################
%>
<%
Dim Ecode

Ecode = requestCheckVar(Request("eventid"),8)
%>
<style>
.storyNav {overflow:hidden;}
.storyNav li {position:relative; float:left; width:380px;}
.storyNav li span {display:block; width:100%; height:153px; background-position:0 0; background-repeat:no-repeat;}
.storyNav li span a {display:none; height:100%; text-indent:-999em;}
.storyNav li.open span {background-position:0 -153px;}
.storyNav li.current span {background-position:0 100%;}
.storyNav li.open span a,
.storyNav li.current span a {display:block;}
.storyNav li.nav1 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72654/nav_1.png);}
.storyNav li.nav2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72654/nav_2.png);}
.storyNav li.nav3 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72654/nav_3_v1.png);}
</style>
</head>
<body>
	<div class="storyNav">
		<ul>
			<!-- for dev msg : 오픈된 페이지 open / 현재 보고있는 페이지 current 클래스 붙여주세요-->
			<% If Date() >="2016-08-29" then %>
				<li class="nav1 <% If Date() >="2016-08-29" then %>open<% end if %> <% if Ecode="72654" then %> current<% end if %>"><span><a href="<% If Date() >="2016-08-29" then %>/event/eventmain.asp?eventid=72654<% end if %>" target="_top">1.석금호 대표 : 디자이너의 펜 이야기</a></span></li>
				<li class="nav2 <% If Date() >="2016-09-12" then %>open<% end if %> <% if Ecode="72992" then %> current<% end if %>"><span><a href="<% If Date() >="2016-09-12" then %>/event/eventmain.asp?eventid=72992<% end if %>" target="_top">2. 황성제 작곡가 : 작곡가의 펜 이야기</a></span></li>
				<li class="nav3 <% If Date() >="2016-09-26" then %>open<% end if %> <% if Ecode="72993" then %> current<% end if %>"><span><a href="<% If Date() >="2016-09-26" then %>/event/eventmain.asp?eventid=72993<% end if %>" target="_top">3. 김선현 건축가 : 건축가의 펜 이야기</a></span></li>
			<% end if %>
		</ul>
	</div>
</body>
</html>