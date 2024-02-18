<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : gift카드 주문확인서"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_orderCls.asp" -->
<%
''주문 완료 페이지에서 Print와 같이 사용
dim refer
refer = lcase(request.serverVariables("HTTP_REFERER"))

if Not(InStr(refer,"10x10.co.kr")>0) then
	Call Alert_close("잘못된 접속입니다.")
	dbget.Close: response.End
end if

'==============================================================================
'나의주문
dim userid
dim giftOrderSerial
dim myorder
Dim IsValidOrder : IsValidOrder = False   '''정상 주문 여부

userid = GetLoginUserID()
giftOrderSerial = requestCheckVar(request("idx"),11)

set myorder = new cGiftcardOrder
myorder.FUserID = userid
myorder.Fgiftorderserial = giftorderserial
myorder.getGiftcardOrderDetail

If myorder.FResultcount > 0 Then
	IsValidOrder = true
Else
	Call Alert_close("주문내역이 존재하지 않습니다.")
	dbget.Close: response.End
End If

if Not (myorder.FOneItem.IsValidOrder) then
    Response.Write "<script language='javascript'>alert('취소된 주문이거나 정상 주문건이 아닙니다.');window.close();</script>"
    dbget.Close: response.End
end if
%>
	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_receipt.gif" alt="주문확인서" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<div class="orderDetail">
						<div class="title">
							<h2 class="tMar0">주문정보</h2>
						</div>
						<table class="baseTable rowTable">
						<caption>주문정보 내역</caption>
						<colgroup>
							<col width="130" /> <col width="285" /> <col width="130" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">결제방법</th>
							<td><%=myorder.FOneItem.GetAccountdivName%></td>
							<th scope="row">주문일자</th>
							<td><%=formatDate(myorder.FOneItem.Fregdate,"0000/00/00")%></td>
						</tr>
						<tr>
							<th scope="row"><%=chkIIF(IsNULL(myorder.FOneItem.Fipkumdate) or (myorder.FOneItem.FIpkumDiv<4),"결제하실 금액","총 결제금액")%></th>
							<td><em class="crRed"><strong>10,000</strong>원</em></td>
							<th scope="row">결제일시</th>
							<td>
							<%
								if IsNULL(myorder.FOneItem.Fipkumdate) or (myorder.FOneItem.FIpkumDiv<4) Then
									Response.Write "<strong class=""crRed"">결제이전</strong>"
								else
									Response.Write replace(replace(myorder.FOneItem.Fipkumdate,"-","/")," 오","<span class=""lPad05 rPad05"">|</span>오")
								end if
							%>
							</td>
						</tr>
						<% if myorder.FOneItem.Faccountdiv="7" then %>
						<tr>
							<th scope="row">입금 예정자명</th>
							<td><%=myorder.FOneItem.FaccountName%></td>
							<th scope="row">입금하실 계좌</th>
							<td><%=myorder.FOneItem.Faccountno%> 텐바이텐</td>
						</tr>
						<% end if %>
						<% if myorder.FOneItem.FcancelYn="Y" then %>
						<tr>
							<th scope="row">주문 취소일시</th>
							<td colspan="3"><%=replace(replace(myorder.FOneItem.FcancelDate,"-","/")," 오","<span class=""lPad05 rPad05"">|</span>오")%></td>
						</tr>
						<% end if %>
						<tr>
							<th scope="row">주문자 정보</th>
							<td colspan="3"><%=myorder.FOneItem.FbuyName%> (휴대전화번호 : <%=myorder.FOneItem.Fbuyhp%> / 전화번호 : <%=myorder.FOneItem.FbuyPhone%> / 이메일 : <%=myorder.FOneItem.Fbuyemail%>)</td>
						</tr>
						</tbody>
						</table>

						<div class="title">
							<h2>주문 내용 확인</h2>
						</div>
						<table class="baseTable">
						<caption>주문 내용</caption>
						<colgroup>
							<col width="130" /> <col width="130" /> <col width="*" /> <col width="130" /> <col width="130" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">주문번호</th>
							<th scope="col">상품</th>
							<th scope="col">상품명 [옵션]</th>
							<th scope="col">판매가</th>
							<th scope="col">전송방법</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%=myorder.FOneItem.FgiftOrderSerial%></td>
							<td><img src="<%=myorder.FOneItem.FsmallImage%>" alt="Gift Card Basic" /></td>
							<td><%=myorder.FOneItem.FCarditemname & " [<span>" & myorder.FOneItem.FcardOptionName & "</span>]"%></td>
							<td><%=formatNumber(myorder.FOneItem.Ftotalsum,0)%>원</td>
							<td><%=myorder.FOneItem.getSendDivName%></td>
						</tr>
						</tbody>
						</table>

						<div class="title">
							<h2>전송 정보 확인</h2>
						</div>
						<table class="baseTable rowTable">
						<caption>전송 정보 내역</caption>
						<colgroup>
							<col width="190" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">받으시는 분 휴대폰 번호</th>
							<td><%=myorder.FOneItem.Freqhp%></td>
						</tr>
						<% if Not(myorder.FOneItem.Freqemail="" or isNull(myorder.FOneItem.Freqemail)) then %>
						<tr>
							<th scope="row">받으시는 분 이메일 주소</th>
							<td><%=myorder.FOneItem.Freqemail%></td>
						</tr>
						<% end if %>
						<% if myorder.FOneItem.FbookingYn="Y" then %>
						<tr>
							<th scope="row">예약 발송 선택</th>
							<td><%=formatDate(myorder.FOneItem.FbookingDate,"0000/00/00") & " " & hour(myorder.FOneItem.FbookingDate) & "시"%></td>
						</tr>
						<% elseif Not(myorder.FOneItem.FsendDate="" or isNull(myorder.FOneItem.FsendDate)) then %>
						<tr>
							<th scope="row">발송시간</th>
							<td><%=replace(replace(myorder.FOneItem.FsendDate,"-","/")," 오","<span class=""lPad05 rPad05"">|</span>오")%></td>
						</tr>
						<% end if %>
						</tbody>
						</table>
					</div>

					<div class="companyInfo">
						<div class="logo"><img src="http://fiximage.10x10.co.kr/web2013/common/logo.gif" alt="텐바이텐 10X10" /></div>
						<div class="selling">
							<p class="title"><strong><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_selling_agency.gif" alt="판매처 안내 : (주)텐바이텐" /></strong></p>
							<!-- 13.09.06 -->
							<p><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_selling_agency_info.gif" alt="사업자등록번호 : 211-87-00620 / 대표이사 : 최은희 / 소재지 : 우)110-510 서울시 종로구 동숭도 1-45 자유빌딩 5층" /></p>
							<!-- //13.09.06 -->
						</div>
						<div class="cs">
							<p class="title"><strong><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_cscenter.gif" alt="텐바이텐 고객센터안내" /></strong></p>
							<p><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_cscenter_info.gif" alt="TEL : 1644-6030 / AM 09 :00~PM 06:00 점심시간 PM 12:00~01:00 주말,공휴일 휴무 / E-mail : customer@10x10.co.kr" /></p>
						</div>
					</div>

					<div class="btnArea tMar30 ct">
						<button type="button" class="btn btnB1 btnWhite btnW185 lMar10" onclick="window.print();return false;">인쇄하기</button>
					</div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();return false;">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>
<%
set myorder = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->