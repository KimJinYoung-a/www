<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
	response.Charset="UTF-8"
	Session.CodePage = 65001
%>
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<%
	'//for Developers
	'// commlib.asp, tenEncUtil.asp는 head.asp에 포함되어있으므로 페이지내에 넣지 않도록 합시다.

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 우편번호찾기"		'페이지 타이틀 (필수)
	strPageDesc = "우편번호 찾기 이미지"		'페이지 설명
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

%>
<!-- #include virtual="/lib/inc/head_ssl.asp" -->
<%
	dim fiximgPath
	'이미지 경로 지정(SSL 처리)
	if request.ServerVariables("SERVER_PORT_SECURE")<>1 then
		fiximgPath = "http://fiximage.10x10.co.kr"
	else
		fiximgPath = "/fiximage"
	end if

	' -------------------------------------
	' 회원의 주소를 찾는 Popup Window 화면
	' -------------------------------------
	Dim strTarget
	Dim strQuery
	Dim strMode, stype

	strTarget	= requestCheckVar(Request("target"),32)
	strQuery	= requestCheckVar(Request("query"),16)
	strMode     = requestCheckVar(Request("strMode"),32)
	stype		= requestCheckVar(Request("stype"),4)
	if stype="" then stype="road"

	Dim strSql
	Dim nRowCount

	Dim strAddress
	dim useraddr01, useraddr02
	dim FRecultCount

		''strSql = " [db_zipcode].[dbo].[usp_Ten_GetZipcodeList] '" + CStr(strQuery) + "', '" + CStr(stype) + "' "
		strSql = " [db_zipcode].[dbo].[usp_Ten_GetZipcodeList_FullText] '" + CStr(strQuery) + "', '" + CStr(stype) + "' "

		if (strQuery<>"") then
			FRecultCount = 0
			rsCTget.Open strSQL,dbCTget,1
			if Not rsCTget.Eof then
				FRecultCount = 1
			end if
		end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup_ssl.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15_ssl.css" />
<script>
	document.title="텐바이텐 우편번호 검색";

	// 해당폼에 선택정보 전송 > 끝
	function CopyZip() {
		var frm = eval("opener.document.<%=strTarget%>");
		var post1 = document.tranFrm.zip1.value;
		var post2 = document.tranFrm.zip2.value;
		var add = document.tranFrm.addr1.value;
		var dong = document.tranFrm.addr2.value;
		var detail = $("input[name='detail']").val();

		if (detail=="") {
			alert("상세주소를 입력해주세요.");
			$("input[name='detail']").focus();
			return;
		}
		dong = dong +' '+ detail;

	<% if strMode="MyAddress" then %>
		// copy
		if(typeof(frm.zip) != 'undefined'){ 
			frm.zip.value		= post1+'-'+post2;
		}
		else
		{
			frm.zip1.value		= post1;
			frm.zip2.value		= post2;
		}

		frm.reqZipaddr.value		= add;
		frm.reqAddress.value		= dong;

		// focus
		frm.reqAddress.focus();
	<% elseif (strMode="buyer") then %>
		// copy
		if(typeof(frm.buyZip) != 'undefined'){ 
			frm.buyZip.value		= post1+'-'+post2;
		}
		else
		{
			frm.buyZip1.value		= post1;
			frm.buyZip2.value		= post2;
		}
		frm.buyAddr1.value		= add;
		frm.buyAddr2.value		= dong;

		// focus
		frm.buyAddr2.focus();
	<% else %>
		// copy
		if(typeof(frm.txZip) != 'undefined'){ 
			frm.txZip.value			= post1+'-'+post2;
		}
		else
		{
			frm.txZip1.value			= post1;
			frm.txZip2.value			= post2;
		}
		frm.txAddr1.value		= add;
		frm.txAddr2.value		= dong;

		// focus
		frm.txAddr2.focus();
	<% end if %>
		// close this window
		window.close();
	}

	// 2nd 상세정보 입력폼 표시
	function DetailPost(elm,post1,post2,add,dong) {
		document.tranFrm.zip1.value=post1;
		document.tranFrm.zip2.value=post2;
		document.tranFrm.addr1.value=add;
		document.tranFrm.addr2.value=dong;
		$(".addDetail").remove();
		$(elm).after('<tr class="addDetail"><td>상세주소</td><td align="left"><b>'+ add+' '+dong +'</b><br /><input type="text" name="detail" class="txtInp" style="height:14px; width:180px;" /> <button class="btn btnS2 btnGry2" style="height:26px;" onclick="CopyZip(); return false;">완료</button></td></tr>');
	}

	function SubmitForm(frm) {
		if (frm.query.value.length < 2) { alert("검색어를 두 글자 이상 입력하세요."); return; }
		frm.submit();
	}

	function chgTab(dv) {
		if(dv=="a") {
			$("#fdstt").html("찾고자 하는 주소의 동/읍/면 이름을 입력하세요.");
			$("#dRowEx").html("(예: 대치동,곡성읍,오곡면)");
			$("#stype").val("addr");
			$("#addr").addClass("on");
			$("#road").removeClass("on");
		} else {
			$("#fdstt").html("찾고자 하는 주소의 도로명을 입력하세요.");
			$("#dRowEx").html("(예: 동숭1길, 세종대로)");
			$("#stype").val("road");
			$("#road").addClass("on");
			$("#addr").removeClass("on");
		}
	}
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
		<!-- // 본문 시작 //-->
			<div class="popHeader">
				<h1><img src="<%=fiximgPath%>/web2013/common/tit_zipcode_find.gif" alt="우편번호찾기" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<ul class="tabMenu" style="">
					<li><a href="" class="<%=chkIIF(stype="addr","on","")%>" id="addr" onclick="chgTab('a'); return false;">지번검색</a></li>
					<li><a href="" class="<%=chkIIF(stype="road","on","")%>" id="road" onclick="chgTab('r'); return false;">도로명검색</a></li>
				</ul>

				<form action="searchzip.asp" method="get" name="gil" onsubmit="SubmitForm(document.gil); return false;" style="margin:0px;">
				<input type="hidden" name="target"	value="<%=strTarget%>" />
				<input type="hidden" name="strMode"	value="<%=strMode%>" />
				<input type="hidden" name="stype"	id="stype" value="<%=stype%>" >
				<fieldset>
				<legend>지번/도로명검색</legend>
					<div class="box5 finder">
						<p class="fs12" id="fdstt"><%=chkIIF(stype="addr","찾고자 하는 주소의 동/읍/면 이름을 입력하세요.","찾고자 하는 주소의 도로명을 입력하세요.")%></p>
						<div class="field">
							<input type="text" title="검색어 입력" class="inputSearh" name="query" style="ime-mode:active" />
							<input type="submit" value="" class="btnSearch"/>
						</div>
						<p class="cr888" id="dRowEx"><%=chkIIF(stype="addr","(예: 대치동,곡성읍,오곡면)","(예: 동숭1길, 세종대로)")%></p>
					</div>
				</fieldset>
				</form>

				<p class="bPad10">검색 결과 중 해당 주소를 클릭하시면 자동 입력됩니다.</p>
				<div class="boardList zipcode">
					<table>
					<caption>우편번호 및 주소 검색결과 목록</caption>
					<colgroup>
						<col width="90" /> <col width="*" />
					</colgroup>
					<thead>
					<tr>
						<th scope="row">우편번호</th>
						<th scope="row">주소</th>
					</tr>
					</thead>
					<tbody>
					<% if (FRecultCount>0) then %>
						<% if (not rsCTget.eof) then
							do while (not rsCTget.EOF and nRowCount < rsCTget.PageSize)

								if stype="road" then
									'도로명주소
									strAddress = trim(rsCTget("ADDR_Fulltext")) & " " & trim( rsCTget("ADDR_BLDNO1"))
									if Not(rsCTget("ADDR_BLDNO2")="" or isNull(rsCTget("ADDR_BLDNO2"))) then
										strAddress = strAddress & " ~ " & trim(rsCTget("ADDR_BLDNO2"))
									end if

									useraddr01 = trim(rsCTget("ADDR_SI")) & " " & trim( rsCTget("ADDR_GU"))
									'' 동추가 (택배사 주소정제 프로그램에서 동/면이 있어야 인식이됨) 2016/07/07
									'' useraddr02 = trim( rsCTget("ADDR_ROAD"))
									useraddr02 = trim( rsCTget("ADDR_DONG")) & " " & trim( rsCTget("ADDR_ROAD"))
									if Not(rsCTget("ADDR_ETC")="" or isNull(rsCTget("ADDR_ETC"))) then
										'다량 배송처가 있는 곳은 단일 건물
										useraddr02 = useraddr02 & " " & trim(rsCTget("ADDR_BLDNO1")) & " " & trim(rsCTget("ADDR_ETC"))
									end if
									useraddr02 = trim(Replace(useraddr02,"'","\'"))
								else
									'지번주소
									strAddress = trim(rsCTget("ADDR_Fulltext"))

									useraddr01 = trim(rsCTget("ADDR_SI")) & " " & trim( rsCTget("ADDR_GU"))
									useraddr02 = trim( rsCTget("ADDR_DONG")) & " " & trim( rsCTget("ADDR_ETC"))
									useraddr02 = trim(Replace(useraddr02,"'","\'"))
								end if
						%>
						<tr onclick="DetailPost(this,'<%=rsCTget("ADDR_ZIP1")%>','<%=rsCTget("ADDR_ZIP2")%>','<% = useraddr01 %>', '<% = useraddr02 %>')" style="cursor:pointer;">
							<td><%=rsCTget("ADDR_zip1")%>-<%=rsCTget("ADDR_zip2")%></td>
							<td class="lt"><a href="" onclick="return false;"><%=strAddress%></a></td>
						</tr>
						<%
								rsCTget.MoveNext
							loop
							end if
							rsCTget.close
						%>
					<% else %>
						<% if (strQuery="") then %>
						<tr>
							<td colspan="2">지역명을 입력해주세요.</td>
						</tr>
						<% else %>
						<tr>
							<td colspan="2">검색 결과가 없습니다.</td>
						</tr>
						<% end if %>
					<% End if%>
					</tbody>
					</table>
				</div>
				<!-- //content -->
			</div>
			<form name="tranFrm" style="margin:0px;">
			<input type="hidden" name="zip1" value="">
			<input type="hidden" name="zip2" value="">
			<input type="hidden" name="addr1" value="">
			<input type="hidden" name="addr2" value="">
			</form>
		<!-- // 본문 끝 //-->
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbCTclose.asp" -->
