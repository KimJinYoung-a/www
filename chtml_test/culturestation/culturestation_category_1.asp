<%'본 파일은 자동생성 되는 파일입니다. 절대 수작업을 통해 수정하지 마세요!%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim evt_code
evt_code = getNumeric(requestCheckVar(request("evt_code"),5))
%>
<li class="feeling"><a href="" class="ico"><span>느껴봐 (12)</span></a>
	<ul class="submenu">
		<li><a href="culturestation_event.asp?evt_code=3325" <%=chkIIF(evt_code="3325","class='current'","")%> onclick="TnGotocultureEvenMain(3325);">영화 마음이 외치고 싶어해</a></li>
		<li><a href="culturestation_event.asp?evt_code=3324" <%=chkIIF(evt_code="3324","class='current'","")%> onclick="TnGotocultureEvenMain(3324);">영화 33</a></li>
		<li><a href="culturestation_event.asp?evt_code=3319" <%=chkIIF(evt_code="3319","class='current'","")%> onclick="TnGotocultureEvenMain(3319);">뮤지컬 데드 독</a></li>
		<li><a href="culturestation_event.asp?evt_code=3317" <%=chkIIF(evt_code="3317","class='current'","")%> onclick="TnGotocultureEvenMain(3317);">강연 TEDxSNU 제 10회</a></li>
		<li><a href="culturestation_event.asp?evt_code=3312" <%=chkIIF(evt_code="3312","class='current'","")%> onclick="TnGotocultureEvenMain(3312);">공연 그랜드 일루션</a></li>
		<li><a href="culturestation_event.asp?evt_code=3311" <%=chkIIF(evt_code="3311","class='current'","")%> onclick="TnGotocultureEvenMain(3311);">전시 모네 빛을 그리다 전</a></li>
		<li><a href="culturestation_event.asp?evt_code=3310" <%=chkIIF(evt_code="3310","class='current'","")%> onclick="TnGotocultureEvenMain(3310);">연극 술과 눈물과 지킬앤하이드</a></li>
		<li><a href="culturestation_event.asp?evt_code=3308" <%=chkIIF(evt_code="3308","class='current'","")%> onclick="TnGotocultureEvenMain(3308);">뮤지컬 로기수</a></li>
		<li><a href="culturestation_event.asp?evt_code=3306" <%=chkIIF(evt_code="3306","class='current'","")%> onclick="TnGotocultureEvenMain(3306);">연극 싸이코패스는 고양이를 죽이다</a></li>
		<li><a href="culturestation_event.asp?evt_code=3303" <%=chkIIF(evt_code="3303","class='current'","")%> onclick="TnGotocultureEvenMain(3303);">연극 꽃의 비밀</a></li>
		<li><a href="culturestation_event.asp?evt_code=3299" <%=chkIIF(evt_code="3299","class='current'","")%> onclick="TnGotocultureEvenMain(3299);">뮤지컬 마타하리</a></li>
		<li><a href="culturestation_event.asp?evt_code=3294" <%=chkIIF(evt_code="3294","class='current'","")%> onclick="TnGotocultureEvenMain(3294);">전시 반 고흐 인사이드</a></li>
	</ul>
</li>
