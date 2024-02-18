<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2015-03-09"
	
	'response.write currentdate
%>
<%
'#######################################################################
'	작업자 전달 사항
'
'	* 어드민에 소스 넣을때 뭐뭐뭐.asp 뒤에 ?eventid=코드 꼭 넣으세요!!
'	* 이 페이지에 소스 수정시 몇 탄이벤트코드 에 해당 코드 넣어주면 됩니다.
'
'연미님 코맨트
'1. 24Line부터 시작하는 vEventID를 각 날짜에 맞게 넣어주세요. ex) 11/14일에 이벤트코드가 정해지면 29Line에 74068이 아닌 그 이벤트코드로 수정
'2. swiper-slide에 이벤트코드 수정해주세요. ex) 11/14일에 이벤트코드가 정해지면 121Line에 74068이 아닌 그 이벤트코드 수정과 내용 수정
'#######################################################################
	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.hidden {visibility:hidden; width:0; height:0; overflow:hidden; position:absolute; top:-1000%; line-height:0;}

/* toyTab */
.toyTab {position:relative;}
.toyTab ul {overflow:visible; width:1140px; height:120px; margin:0 auto; background:#f0fdff;}
.toyTab ul li{float:left; position:relative; width:284px; height:100%; padding:0 0.5px; }
.toyTab ul li span {display:block; width:100%; height:100%; position:absolute; top:0; left:0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77295/txt_tab_v4.jpg) no-repeat 0 0; text-indent:-999em;}

.toyTab ul li.nav1 span{background-position:0 -120px;}
.toyTab ul li.nav1 .on span{background-position:0 100%;}

.toyTab ul li.nav2 span{background-position:-285px -120px;}
.toyTab ul li.nav2 .on span{background-position:-285px 100%;}
.toyTab ul li.nav2 .coming span{background-position:-285px 0;}

.toyTab ul li.nav3 span{background-position:-570px -120px;}
.toyTab ul li.nav3 .on span{background-position:-570px 100%}
.toyTab ul li.nav3 .coming span{background-position:-570px 0;}

.toyTab ul li.nav4 span{background-position:100% -120px;}
.toyTab ul li.nav4 .on span{background-position:100% 100%}
.toyTab ul li.nav4 .coming span{background-position:100% 0;}

</style>
</head>
<body>
	<div id="navigator" class="toyTab">
		<h1 class="hidden">아트토이 컬쳐</h1>
		<ul class="">
			<li class="nav1">
				<a href="/event/eventmain.asp?eventid=77029" target="_top" <%=CHKIIF(vEventID="77029"," class='on'","")%>><span>4월 3일</span></a>
			</li>

			<% if currentdate < "2017-04-10" then %>
			<li class="nav2">
				<span class="coming"><span></span>4월 10일</span>
			</li>
			<% Else %>
			<li class="nav2">
				<a href="/event/eventmain.asp?eventid=77270" target="_top" <%=CHKIIF(vEventID="77270"," class='on'","")%>><span></span>4월 10일</a>
			</li>
			<% End If %>

			<% If currentdate < "2017-04-17" Then %>
			<li class="nav3">
				<span class="coming"><span></span>4월 17일</span>
			</li>
			<% Else %>
			<li class="nav3">
				<a href="/event/eventmain.asp?eventid=77294" target="_top" <%=CHKIIF(vEventID="77294"," class='on'","")%>><span></span>4월 17일</a>
			</li>
			<% End If %>

			<% If currentdate < "2017-04-24" Then %>
			<li class="nav4">
				<span class="coming"><span></span>4월 24일</span>
			</li>
			<% Else %>
			<li class="nav4">
				<a href="/event/eventmain.asp?eventid=77295" target="_top" <%=CHKIIF(vEventID="77295"," class='on'","")%>><span></span>4월 24일</a>
			</li>
			<% End If %>
		</ul>
	</div>
</body>
</html>