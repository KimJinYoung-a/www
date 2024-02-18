<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim currentdate
	currentdate = date()
%>
<style type="text/css">
body {background-color:transparent;}
</style>
<script type="text/javascript">
$(function(){
	function swing () {
		$("#swing img").animate({"margin-top":"0"},800).animate({"margin-top":"-5px"},1600, swing);
	}
	swing();
});
</script>
</head>
<body>
	<div class="bnr">
		<!-- 12/14 -->
		<% If currentdate = "2016-12-14" Then %>
		<a href="/event/eventmain.asp?eventid=74971" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 가방/잡화 #3 기획전으로 이동" /></a>

		<!-- 12/15 -->
		<% ElseIf currentdate = "2016-12-15" Then %>
		<a href="/event/eventmain.asp?eventid=74972" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 푸드 #4 기획전으로 이동" /></a>

		<!-- 12/16 -->
		<% ElseIf currentdate = "2016-12-16" Then %>
		<a href="/event/eventmain.asp?eventid=74973" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 토이 #5 기획전으로 이동" /></a>

		<!-- 12/19 -->
		<% ElseIf currentdate = "2016-12-19" Then %>
		<a href="/event/eventmain.asp?eventid=74974" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 여행 #6 기획전으로 이동" /></a>

		<!-- 12/20 -->
		<% ElseIf currentdate = "2016-12-20" Then %>
		<a href="/event/eventmain.asp?eventid=74975" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 패션의류 #7 기획전으로 이동" /></a>
		
		<!-- 12/21 -->
		<% ElseIf currentdate = "2016-12-21" Then %>
		<a href="/event/eventmain.asp?eventid=75114" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 키친 #8 기획전으로 이동" /></a>
		
		<!-- 12/22 -->
		<% ElseIf currentdate = "2016-12-22" Then %>
		<a href="/event/eventmain.asp?eventid=75115" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 문구 #9 기획전으로 이동" /></a>
		
		<!-- 12/23 -->
		<% ElseIf currentdate = "2016-12-23" Then %>
		<a href="/event/eventmain.asp?eventid=75116" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 CAT&amp;DOG #10 기획전으로 이동" /></a>
		
		<!-- 12/26 -->
		<% ElseIf currentdate = "2016-12-26" Then %>
		<a href="/event/eventmain.asp?eventid=75117" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 뷰티 #11 기획전으로 이동" /></a>
		
		<!-- 12/27 -->
		<% ElseIf currentdate = "2016-12-27" Then %>
		<a href="/event/eventmain.asp?eventid=75245" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 베이비 #12 기획전으로 이동" /></a>

		<!-- 12/28 -->
		<% ElseIf currentdate => "2016-12-28" Then %>
		<a href="/event/eventmain.asp?eventid=75252" target="_top" id="swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74863/img_bnr.png" alt="텐바이텐 어워드 캐릭터 #13 기획전으로 이동" /></a>
		<% End If %>
	</div>
</body>
</html>