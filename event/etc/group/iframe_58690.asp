<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  이벤트코드 58690 책시리즈
' History : 2015.01.23 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
	$(function(){
	// Design Selectbox
	$(".evtSelect dt").click(function(){
		if($(".evtSelect dd").is(":hidden")){
			$(this).parent().children('dd').show("slide", { direction: "up" }, 300);
			$(this).addClass("over");
		}else{
			$(this).parent().children('dd').hide("slide", { direction: "up" }, 200);
		};
	});
	$(".evtSelect dd li").click(function(){
		var evtName = $(this).text();
		$(".evtSelect dt").removeClass("over");
		$(".evtSelect dd li").removeClass("on");
		$(this).addClass("on");
		$(this).parent().parent().parent().children('dt').children('span').text(evtName);
		$(this).parent().parent().hide("slide", { direction: "up" }, 200);
	});
	$(".evtSelect dd").mouseleave(function(){
		$(this).hide();
		$(".evtSelect dt").removeClass("over");
	});
});
</script>
</head>
<body style="background-color:transparent;">
<dl class="evtSelect">
	<dt><span>이번엔 어떤 책을 볼까?</span></dt>
	<dd>
		<ul>
			<li><a href="/event/eventmain.asp?eventid=58690" target="_top">1월의 책 : GRE, 그래!</a></li>
			<% If Now() > #02/16/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=59424" target="_top">2월의 책 : Before after</a></li>
			<% End If %>
			<% If Now() > #03/18/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=60362" target="_top">3월의 책 : 우주 우표책</a></li>
			<% End If %>
			<% If Now() > #04/27/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=61617" target="_top">4월의 책 : 우리가족 평균연령 60세!</a></li>
			<% End If %>
			<% If Now() > #05/20/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=62652" target="_top">5월의 책 : COLOR THIS BOOK</a></li>
			<% End If %>
			<% If Now() > #06/17/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=63718" target="_top">6월의 책 : HOW OLD ARE YOU</a></li>
			<% End If %>
			<% If Now() > #07/31/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=65128" target="_top">7월의 책 : 이환천의 문학살롱</a></li>
			<% End If %>
			<% If Now() > #08/12/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=65362" target="_top">8월의 책 : 반 고흐</a></li>
			<% End If %>
			<% If Now() > #09/23/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=66270" target="_top">9월의 책 : 케이트와 고양이의 ABC</a></li>
			<% End If %>
			<% If Now() > #10/27/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=67604" target="_top">10월의 책 : 주말클렌즈</a></li>
			<% End If %>
			<% If Now() > #11/25/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=67355" target="_top">11월의 책 : 상상고양이</a></li>
			<% End If %>
			<% If Now() > #12/30/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=68253" target="_top">12월의 책 : 갱상도 사투리 배우러 들온나</a></li>
			<% End If %>
		</ul>
	</dd>
</dl>
</body>
</html>