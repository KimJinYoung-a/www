<%'본 파일은 자동생성 되는 파일입니다. 절대 수작업을 통해 수정하지 마세요!%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim evt_code
evt_code = getNumeric(requestCheckVar(request("evt_code"),5))
%>
<li class="feeling"><a href="" class="ico"><span>느껴봐 (3)</span></a>
	<ul class="submenu">
		<li><a href="culturestation_event.asp?evt_code=97531" <%=chkIIF(evt_code="97531","class='current'","")%> onclick="TnGotocultureEvenMain(97531);">버티고</a></li>
		<li><a href="culturestation_event.asp?evt_code=97459" <%=chkIIF(evt_code="97459","class='current'","")%> onclick="TnGotocultureEvenMain(97459);">디어 마이 프렌드</a></li>
		<li><a href="culturestation_event.asp?evt_code=97577" <%=chkIIF(evt_code="97577","class='current'","")%> onclick="TnGotocultureEvenMain(97577);">두번할까요</a></li>
	</ul>
</li>
