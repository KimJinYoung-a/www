<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2019-12-02"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "100859" Then '// 01
		vStartNo = "0"
	ElseIf vEventID = "101557" Then '// 02
		vStartNo = "0"
	ElseIf vEventID = "102311" Then '// 03
		vStartNo = "0"
	ElseIf vEventID = "103794" Then '// 04
		vStartNo = "0"
	ElseIf vEventID = "104599" Then '// 05
		vStartNo = "1"
	ElseIf vEventID = "106897" Then '// 06
		vStartNo = "2"
	ElseIf vEventID = "111652" Then '// 07
		vStartNo = "3"
	ElseIf vEventID = "111975" Then '// 08
		vStartNo = "4"
	ElseIf vEventID = "112554" Then '// 09
		vStartNo = "5"
	ElseIf vEventID = "113118" Then '// 10
		vStartNo = "6"
	Else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigator {position:relative; width:1140px; height:92px; padding:0 95px;}
.navigator .menu {width:190px;}
.navigator .menu {height:48px; margin-top:44px;}
.navigator .menu a {display:flex; align-items:center; justify-content:center; height:100%; text-align:center; font-weight:500; font-size:18px; color:#fff; background:#c4c4c4; text-decoration:none; border-radius:15px 15px 0 0;}
.navigator .menu.current {height:60px; margin-top:32px;}
.navigator .menu.current a {font-weight:700; font-size:23px; background:#222;}
.navigator .slick-arrow {width:70px; height:92px; top:0; background:url(//webimage.10x10.co.kr/fixevent/event/2020/100859/nav_arrow.png) 50% no-repeat;}
.navigator .slick-prev {left:0; transform:scaleX(-1);}
.navigator .slick-next {right:0;}
</style>
<script type="text/javascript">
$(function(){
	$("#navigator").slick({
		slidesToShow: 5,
		variableWidth: true,
		infinite: false,
		initialSlide: <%=vStartNo%>
	});
	 $(".navigator .coming").on('click', function(e){
		e.preventDefault();
		alert("오픈 예정 기획전 입니다 :)");
	});
});
</script>
</head>
<body>
<div id="navigator" class="navigator">
	<% if currentdate < "2020-02-25" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="100859"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=100859" target="_top">01. Plande</a>
	</div>

	<% if currentdate < "2020-03-25" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="101557"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=101557" target="_top">02. OURS</a>
	</div>

	<% if currentdate < "2020-04-27" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="102311"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=102311" target="_top">03. 푸르름</a>
	</div>

	<% if currentdate < "2020-06-24" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="103794"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=103794" target="_top">04. 퍼디</a>
	</div>

	<% if currentdate < "2020-07-28" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="104599"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=104599" target="_top">05. 영이의 숲</a>
	</div>

	<% if currentdate < "2020-10-26" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="106897"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=106897" target="_top">06. 프롬하오팅</a>
	</div>

	<% if currentdate < "2021-06-02" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="111652"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=111652" target="_top">07. 어리틀페퍼</a>
	</div>

	<% if currentdate < "2021-06-18" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="111975"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=111975" target="_top">08. 레터에잇</a>
	</div>

	<% if currentdate < "2021-07-07" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="112554"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=112554" target="_top">09. 에구구</a>
	</div>

	<% if currentdate < "2021-08-10" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="113118"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=113118" target="_top">10. 눈고</a>
	</div>

	<% if currentdate < "2022-10-26" then %>
	<div class="menu coming">
	<% Else %>
	<div class="menu open<%=CHKIIF(vEventID="000"," current","")%>">
	<% End If %>
		<a href="/event/eventmain.asp?eventid=000" target="_top">Coming soon</a>
	</div>

</div>
</body>
</html>