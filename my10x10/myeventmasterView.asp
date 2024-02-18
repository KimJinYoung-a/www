<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2013.09.16 허진원 2013리뉴얼
'	Description : 이벤트 당첨 배송지 확인 팝업
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 당첨 배송지 확인"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/login/checkpoplogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/cscenter/eventsbeasongcls.asp" -->
<%
dim id, userid
id = requestCheckVar(request("id"),10)
userid = getEncLoginUserID


dim ibeasong
set ibeasong = new CEventsBeasong
ibeasong.FRectUserID = userid
ibeasong.FRectId = id
ibeasong.GetOneWinnerItem

if ibeasong.FResultCount<1 then
	response.write "<script>alert('검색된 내역이 없습니다.');</script>"
	response.write "<script>window.close();</script>"
	response.end
end if

dim i

if IsNULL(ibeasong.FOneItem.Freqphone) then ibeasong.FOneItem.Freqphone=""
if IsNULL(ibeasong.FOneItem.Freqhp) then ibeasong.FOneItem.Freqhp=""
if IsNULL(ibeasong.FOneItem.Freqzipcode) then ibeasong.FOneItem.Freqzipcode=""

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_event_delivery.gif" alt="이벤트 당첨 배송지 입력내역" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<fieldset>
						<legend>이벤트 당첨 배송지 정보 확인 폼</legend>
						<div class="delivery">
							<h2>배송지 정보</h2>
						</div>
						<table class="baseTable rowTable docForm">
						<caption>이벤트 당첨 배송지</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">이벤트명</th>
							<td><strong><%= ibeasong.FOneItem.Fgubunname %></strong></td>
						</tr>
						<tr>
							<th scope="row">당첨상품</th>
							<td><%= ibeasong.FOneItem.FPrizeTitle %></td>
						</tr>
						<tr>
							<th scope="row">당첨자 성함</th>
							<td><%= ibeasong.FOneItem.Fusername %></td>
						</tr>
						<tr>
							<th scope="row"><label for="receiveName">수령인 성함</label></th>
							<td><%= ibeasong.FOneItem.Freqname %></td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td><%=ibeasong.FOneItem.Freqphone%></td>
						</tr>
						<tr>
							<th scope="row">휴대전화번호</th>
							<td><%=ibeasong.FOneItem.Freqhp%></td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td>
								<div><%= ibeasong.FOneItem.Freqzipcode %></div>
								<div class="tPad07"><%= ibeasong.FOneItem.Freqaddress1 & " " & ibeasong.FOneItem.Freqaddress2 %></div>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="etcmsg">기타사항</label></th>
							<td><%= ibeasong.FOneItem.Freqetc %></td>
						</tr>
						</tbody>
						</table>
					</fieldset>
				</div>
				<!-- //content -->
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
<% set ibeasong = Nothing %>

<!-- #include virtual="/lib/db/dbclose.asp" -->