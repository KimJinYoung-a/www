<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/HSProject/HSPCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	Dim eCode : eCode   = getNumeric(requestCheckVar(Request("eventid"),8)) '이벤트 코드번호
	Dim clsEvtHSP, idx, page, ename, sTemplate, sMimg, sMhtml, sBrand, dEnddate, dPrizeDate, iLinkEcode
	Dim isComment, isBBs, evt_firstCd, evt_lastCd, evt_preCd, evt_Nextcd, iEvtKind, evt_exefile, evt_exefile_mo, evtFileyn, evtFileyn_mo

	idx 	  	= getNumeric(requestCheckVar(request("idx"),10))
	page 	  	= getNumeric(requestCheckVar(request("page"),8))

	if idx 		= "" then idx 	= 0
	if page		= "" then page 	= 1

'	If eCode = "69755" Then		'2016-03-28 09:18 김진영...이메일 땜빵으로 이벤트 이동시키게 함
'		response.redirect("/event/eventmain.asp?eventid="&eCode)
'	End If

	'메일에 링크를 다음주껄로 잘못 걸어서 다음주꺼 죽이고 73551로 보냄
	If eCode = "73609" Then
		response.redirect("/HSProject/?eventid=73551")
	End If

	IF eCode = "" Then
		response.redirect("/HSProject/?eventid="&fngetNewHeySomeThingEvtCode)
		dbget.close()	:	response.End
	elseif Not(isNumeric(eCode)) then
		Call Alert_Return("잘못된 이벤트번호입니다.")
		dbget.close()	:	response.End
	END If


 	iEvtKind	= 29		'헤이썸띵 이벤트 분류 코드


	'// 메인내용 접수
	set clsEvtHSP = new ClsHSP
		clsEvtHSP.FECode = eCode		
		clsEvtHSP.FIdx 	= idx
		
		clsEvtHSP.fnGetEventCont
		
		eCode 		= clsEvtHSP.FECode 
		ename		= clsEvtHSP.FEName
		sTemplate 	= clsEvtHSP.Fevt_template
		sMimg 		= clsEvtHSP.Fevt_mainimg
		sMhtml 		= clsEvtHSP.Fevt_html
		sBrand		= clsEvtHSP.Fbrand
		dEndDate	= clsEvtHSP.Fevt_enddate
		dPrizeDate 	= clsEvtHSP.Fevt_prizedate
		iLinkECode	= clsEvtHSP.Fevt_linkcode 
		IF iLinkECode = 0 THEN iLinkECode = ""
		isComment	= clsEvtHSP.Fiscomment
		isBBS		= clsEvtHSP.Fisbbs
		evt_firstCd	= clsEvtHSP.Fevt_firstCd
		evt_lastCd	= clsEvtHSP.Fevt_lastCd
		evt_preCd	= clsEvtHSP.Fevt_preCd
		evt_NextCd	= clsEvtHSP.Fevt_NextCd
		evt_exefile	= clsEvtHSP.FevtExeFile
		evt_exefile_mo	= clsEvtHSP.FevtExeFileMobile
		evtFileyn	 	= clsEvtHSP.FevtFileyn
		evtFileyn_mo 	= clsEvtHSP.FevtFileyn_mo
		if isNull(evt_lastCd) then evt_lastCd=""

	set clsEvtHSP = nothing

	strPageTitle	= "텐바이텐 10X10 : " & ename
	strPageUrl		= "http://www.10x10.co.kr/HSProject/?eventid=" & eCode
	strPageImage	= sMimg
	strPageDesc = "[텐바이텐] Hey, something project "&ename


%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type='text/javascript'>

	$(function(){
		fnGetList('<%=page%>');
		fnGetListHeader('<%=page%>');

		$("#navHey").hide();
		$("#navHey").css({"margin-left":"300px", "opacity":"0"});
		$("#navHey *").css({"opacity":"0"});
		$("#hamburger").click(function(){
			if ($(this).hasClass("open")){
				$("#navHey").hide();
				$("#navHey").delay(100).animate({"margin-left":"300px", "opacity":"0"},300);
				$("#navHey *").animate({"opacity":"0"},300);
				$(this).removeClass("open");
			} else {
				$("#navHey").show();
				$("#navHey").delay(100).animate({"margin-left":"103px", "opacity":"1"},300);
				$("#navHey *").animate({"opacity":"1"},300);
				$(this).addClass("open");
			}
			return false;
		});
	});

	// Ajax 페이지 이동(jQuery)
	function goHSPPage(pg) {
		var str = $.ajax({
			type: "GET",
			url: "/HSProject/list.asp",
			data: "eventid=<%=eCode%>&page="+pg,
			dataType: "text",
			async: false
		}).responseText;
		if(str!="") {
			$("#HSPList").empty().html(str);
			//document.getElementById("HSPList").innerHTML=str;
		}
	}

	function goHSPPageH(pg) {
		var str = $.ajax({
			type: "GET",
			url: "/HSProject/HSPheader.asp",
			data: "eventid=<%=eCode%>&page="+pg,
			dataType: "text",
			async: false
		}).responseText;
		if(str!="") {
			$("#HSPHeader").empty().html(str);
			//document.getElementById("HSPList").innerHTML=str;
		}
	}

	function fnGetList(pg) {
		var str = $.ajax({
			type: "GET",
			url: "/HSProject/list.asp",
			data: "eventid=<%=eCode%>&page="+pg,
			dataType: "text",
			async: false
		}).responseText;
		if(str!="") {
			$("#HSPList").empty().html(str);
			//document.getElementById("HSPList").innerHTML=str;
		}
	}

	function fnGetListHeader(pg) {
		var str = $.ajax({
			type: "GET",
			url: "/HSProject/HSPheader.asp",
			data: "eventid=<%=eCode%>&page="+pg,
			dataType: "text",
			async: false
		}).responseText;
		if(str!="") {
			$("#HSPHeader").empty().html(str);
			//document.getElementById("HSPList").innerHTML=str;
		}
	}
</script>

</head>
<body>
<div id="heySomethingV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="heySomething">
				<%' 탭 navigator 영역 %>
				<a href="#navHey" title="Hey something project 메뉴" id="hamburger" class="hamburger">
					<span>
						<i></i>
						<i></i>
						<i></i>
					</span>
				</a>
				<div id="HSPHeader"></div>

				<%' execute 영역 %>
					<% If Trim(evtFileyn)="" Or evtFileyn = 0 Or isnull(evtFileyn) Then %>
						<%=sMhtml%>
					<% Else %>
						<% If checkFilePath(server.mappath(evt_exefile)) Then %>
							<% server.execute(evt_exefile)%>
						<% Else %>
							<%=sMhtml%>
						<% End If %>
					<% End If %>
				<%'//execute영역 끝 %>

				<%' 리스트 영역 %>
				<%
					Dim vTitle, vLink, vPre, vImg
					Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
					snpTitle	= Server.URLEncode(ename)
					snpLink		= Server.URLEncode("http://www.10x10.co.kr/HSProject/?eventid=" & ecode)
					snpPre		= Server.URLEncode("텐바이텐 Hey, something project")
				%>
				<div class="sns">
					<ul>
						<li class="twitter"><a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');return false;"><span></span>트위터에 공유하기</a></li>
						<li class="facebook"><a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><span></span>페이스북에 공유하기</a></li>
					</ul>
				</div>
				<div id="HSPList"></div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>