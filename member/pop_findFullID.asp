<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #INCLUDE Virtual="/lib/util/base64.asp" -->
<!-- #INCLUDE Virtual="/lib/util/tenEncUtil.asp" -->
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 아이디 뒷자리 확인"		'페이지 타이틀 (필수)

	Dim sName, sCell, sEmail, chkMtd

	sName = session("findIDName")
	sCell = session("findIDCell")
	sEmail = session("findIDMail")

	if sName="" or (sCell="" and sEmail="") then
		Response.Write "<script type=""text/javascript"">" &_
					"	alert(""유효기간이 만료되었습니다.\n다시 시도해주세요."");" &_
					"	opener.location.replace(""/member/forget.asp"");" &_
					"	self.close();" &_
					"</script>"
		dbget.Close: Response.End
	end if

	'유효값 확인
	if sCell<>"" then
		if ubound(split(sCell,"-"))<2 then
			Response.Write "<script type=""text/javascript"">" &_
						"	alert(""잘못된 휴대폰 번호입니다.\n다시 시도해주세요."");" &_
						"	opener.location.replace(""/member/forget.asp"");" &_
						"	self.close();" &_
						"</script>"
			dbget.Close: Response.End
		end if
		chkMtd = "HP"
	end if

	if sEmail<>"" then
		if ubound(split(sEmail,"@"))<1 then
			Response.Write "<script type=""text/javascript"">" &_
						"	alert(""잘못된 이메일 주소입니다.\n다시 시도해주세요."");" &_
						"	opener.location.replace(""/member/forget.asp"");" &_
						"	self.close();" &_
						"</script>"
			dbget.Close: Response.End
		end if
		chkMtd = "EM"
	end if

	'// 아이디 암호화 함수
	function encTenUID(uid)
		encTenUID = Base64encode(tenEnc(uid))
	end function
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
$(function(){
	//아이디 기본 선택
	$(".idList input[name='selID']").first().prop("checked",true);
});

function fnSendFullId(mtd) {
	if($(".idList input[name='selID']:checked").length<=0) {
		alert("아이디를 선택해주세요.");
		return;
	}

	var sId = $(".idList input[name='selID']:checked").val();

	var rstStr = $.ajax({
		type: "POST",
		url: "pop_findFullId_proc.asp",
		data: "sid="+encodeURIComponent(sId)+"&mtd="+mtd,
		dataType: "text",
		async: false
	}).responseText;

	switch(rstStr) {
		case "E1":
			alert("유효기간이 만료되었습니다.(E01)\n다시 시도해주세요.");
			opener.location.replace("/member/forget.asp");
			self.close();
			break;
		case "E2":
			alert("처리중 오류가 발생했습니다.(E02)\n다시 시도해주세요.");
			break;
		case "E3":
			alert("처리중 오류가 발생했습니다.(E03)\n다시 시도해주세요.");
			break;
		case "10":
			alert("회원정보에 등록된 휴대폰 번호로 아이디가 전송되었습니다.");
			opener.location.replace("/member/forget.asp");
			self.close();
			break;
		case "20":
			alert("회원정보에 등록된 이메일 주소로 아이디가 전송되었습니다.");
			self.close();
			break;
		default:
			alert("처리중 오류가 발생했습니다.(E99)"+rstStr);
	}
}
</script>
</head>
<body>
<!-- for dev msg : 팝업 창 사이즈 width=620, height=800 -->
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2015/popup/tit_confirm_id.gif" alt="아이디 뒷자리 확인" /></h1>
		</div>
		<div class="popContent">
			<div class="viewWholeId">
				<div class="box5 findResult">
					<ul class="idList">
					<%
						'// 대상 아이디 찾기
						dim sqlStr, lp

						sqlStr = "EXEC [db_user_Hold].[dbo].[usp_WWW_FindUserid_Get] '" & sName & "','" & sEmail & "','" & sCell & "'"
						rsget.CursorLocation = adUseClient
						rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

						if Not rsget.Eof then
							lp = 1
							Do Until rsget.EOF
					%>
						<li><input type="radio" name="selID" id="selID<%=lp%>" value="<%=encTenUID(rsget("userid"))%>" /> <label for="selID<%=lp%>"><strong><%=printUserId(rsget("userid"),2,"*")%></strong></label> (가입일자 : <%=left(FormatDateTime(rsget("regdate"),1),len(FormatDateTime(rsget("regdate"),1))-4)%>)</li>
					<%
							rsget.MoveNext
							lp = lp+1
							Loop
						else
							Call Alert_Close("검색 대상이 없습니다.\n확인 후 다시 시도해주세요.")
							rsget.Close: dbget.Close: Response.End
						end if

						rsget.Close
					%>
					</ul>
				</div>
				<!--<p class="ct tPad30 bPad15 fs12"><strong>뒷자리가 모두 표기된 아이디 확인 방법을 선택해주세요.</strong></p>-->
				<div class="sendId">
					<!--
					<ul class="tabNav">
						<li class="phone <%=chkIIF(sCell<>"","current","")%>"><a href="#sendPhone" onclick="<%=chkIIF(sCell="","alert('휴대폰 번호로 아이디 찾기 후 보내실 수 있습니다.');","")%>return false;"><p><strong>등록 휴대폰</strong>회원정보에 등록된<br />휴대폰 번호로 아이디 받기</p></a></li>
						<li class="mail <%=chkIIF(sEmail<>"","current","")%>"><a href="#sendMail" onclick="<%=chkIIF(sEmail="","alert('이메일로 아이디 찾기 후 보내실 수 있습니다.');","")%>return false;"><p><strong>등록 이메일</strong>회원정보에 등록된<br />이메일 주소로 아이디 받기</p></a></li>
					</ul>
					-->
					<div class="tabContainer">
					<%
						if sCell<>"" then
					%>
						<div id="sendPhone">
							<div>
								<p class="bPad15">회원정보에 등록된 휴대폰 번호로 아이디를 보내드립니다.</p>
								<strong class="fs20"><%=split(sCell,"-")(0) & "-" & split(sCell,"-")(1) %>-****</strong>
							</div>
						</div>
					<%
						ElseIf sEmail<>"" then
					%>
						<div id="sendMail">
							<div>
								<p class="bPad15">회원정보에 등록된 이메일 주소로 아이디를 보내드립니다.</p>
								<strong class="fs20"><%=printUserId(split(sEmail,"@")(0),2,"*") & "@" & split(sEmail,"@")(1) %></strong>
							</div>
						</div>
					<%
						end if
					%>
					</div>
				</div>
				<div class="btnArea ct tPad30">
					<a href="#" onclick="fnSendFullId('<%=chkMtd%>');return false;" class="btn btnM2 btnRed btnW160">확인</a>
				</div>
			</div>
		</div>
	</div>
	<div class="popFooter">
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->