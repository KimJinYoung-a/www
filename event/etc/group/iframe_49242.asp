<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  이벤트코드 49242 상점의 재발견 시리즈
' History : 2014.02.14 이종화 생성
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
	<dt><span>다른 상점 더보기</span></dt>
	<dd>
		<ul>
			<li><a href="/event/eventmain.asp?eventid=49242" target="_top">상점의 재발견 #1 O-CHECK [공책]</a></li>
			<% If Now() > #03/17/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=49879" target="_top">상점의 재발견 #2 REDCLOUDY </a></li>
			<% End If %>
			<% If Now() > #05/13/2014 00:00:00# Then %>
			<li><a href="/event/eventmain.asp?eventid=51657" target="_top">상점의 재발견 #3 STALOGY </a></li>
			<% End If %>
		</ul>
	</dd>
</dl>
</body>
</html>