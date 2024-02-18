<%'본 파일은 자동생성 되는 파일입니다. 절대 수작업을 통해 수정하지 마세요!%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim evt_code
evt_code = getNumeric(requestCheckVar(request("evt_code"),5))
%>
<li class="reading"><a href="" class="ico"><span>읽어봐 (1)</span></a>
	<ul class="submenu">
		<li><a href="culturestation_event.asp?evt_code=97578" <%=chkIIF(evt_code="97578","class='current'","")%> onclick="TnGotocultureEvenMain(97578);">당신의 사전</a></li>
	</ul>
</li>
