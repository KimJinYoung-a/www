<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  이벤트코드 49124 책시리즈
' History : 2014.03.10 이종화 생성
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
			<li><a href="/event/eventmain.asp?eventid=49124" target="_top">2월의 책 : 사표</a></li>
			<% If Now() > #03/12/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=49920" target="_top">3월의 책 : 삼십 살</a></li>
			<% End If %>
			<% If Now() > #04/02/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=50577" target="_top">4월의 책 : 비밀기지 만들기</a></li>
			<% End If %>
			<% If Now() > #05/01/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=51359" target="_top">5월의 책 : On a journey...</a></li>
			<% End If %>
			<% If Now() > #06/06/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=52308" target="_top">6월의 책 : 세상을 여행하는 당신에게</a></li>
			<% End If %>
			<% If Now() > #07/02/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=52976" target="_top">7월의 책 : 123명의 집</a></li>
			<% End If %>
			<% If Now() > #07/30/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=53763" target="_top">8월의 책 : 빵과 강아지</a></li>
			<% End If %>
			<% If Now() > #09/03/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=54685" target="_top">9월의 책 : 제주로 훈저옵서예</a></li>
			<% End If %>
			<% If Now() > #10/06/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=55351" target="_top">10월의 책 : 천국은 어쩌면 가까이</a></li>
			<% End If %>
			<% If Now() > #11/14/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=56271" target="_top">11월의 책 : 인생독학</a></li>
			<% End If %>
			<% If Now() > #12/03/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=57121" target="_top">12월의 책 : Santa Spectacular</a></li>
			<% End If %>
		</ul>
	</dd>
</dl>
</body>
</html>