<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  이벤트코드 59972 캐릭터열전
' History : 2015.03.10 진연미 생성
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
	<dt><span>캐릭터열전</span></dt>
	<dd>
		<ul>
			<li><a href="/event/eventmain.asp?eventid=59972" target="_top">#01 스티치</a></li>
			<% If Now() > #03/10/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=60290" target="_top">#02 헬로키티</a></li>
			<% End If %>
			<% If Now() > #03/16/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=60314" target="_top">#03 겨울왕국</a></li>
			<% End If %>
			<% If Now() > #03/30/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=60406" target="_top">#04 스누피</a></li>
			<% End If %>
			<% If Now() > #04/03/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=60896" target="_top">#05 토이스토리</a></li>
			<% End If %>
			<% If Now() > #04/09/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=61431" target="_top">#06 빅히어로6</a></li>
			<% End If %>
			<% If Now() > #04/15/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=61575" target="_top">#07 요괴워치</a></li>
			<% End If %>
			<% If Now() > #04/24/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=61598" target="_top">#08 마이크&amp;설리</a></li>
			<% End If %>
			<% If Now() > #05/12/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=62048" target="_top">#09 후치코</a></li>
			<% End If %>
			<% If Now() > #05/22/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=62293" target="_top">#10 미피</a></li>
			<% End If %>
			<% If Now() > #05/29/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=63170" target="_top">#11 포켓몬스터</a></li>
			<% End If %>
			<% If Now() > #06/03/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=63306" target="_top">#12 리락쿠마</a></li>
			<% End If %>
			<% If Now() > #06/19/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=63955" target="_top">#13 스타워즈</a></li>
			<% End If %>
			<% If Now() > #07/03/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=63962" target="_top">#14 원피스</a></li>
			<% End If %>
			<% If Now() > #07/06/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=63963" target="_top">#15 도라에몽</a></li>
			<% End If %>
			<% If Now() > #07/13/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=64855" target="_top">#16 어드벤처타임</a></li>
			<% End If %>
			<% If Now() > #07/21/2015 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=65053" target="_top">#17 토토로</a></li>
			<% End If %>
		</ul>
	</dd>
</dl>
</body>
</html>