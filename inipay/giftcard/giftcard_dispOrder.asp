<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_orderCls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 기프트카드 주문결과"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim userid, userlevel
dim giftOrderserial, IsSuccess, myorder
Dim IsValidOrder : IsValidOrder = False   '''정상 주문 여부

userid          = GetLoginUserID
userlevel       = GetLoginUserLevel

giftOrderserial = request.cookies("shoppingbag")("before_GiftOrdSerial")
IsSuccess   = request.cookies("shoppingbag")("before_GiftisSuccess")

'' cookie is String
if LCase(CStr(IsSuccess))="true" then
    IsSuccess=true
else
    IsSuccess = false
end if

'''테섭용==============================
IF (application("Svr_Info")="Dev") then
    IF (request("osi")<>"") then
        giftOrderserial = request("osi")
        IsSuccess = true
    end if
End IF
''''===================================

set myorder = new cGiftcardOrder
myorder.FUserID = userid
myorder.Fgiftorderserial = giftorderserial
myorder.getGiftcardOrderDetail


If myorder.FResultcount > 0 Then
	IsValidOrder = true
Else
	Response.Write "<script language='javascript'>alert('잘못된 접속입니다.');self.location='/';</script>"
	dbget.close()
	Response.End
End If

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language="javascript">

function jumunreceipt(){
	var openwin = window.open('','orderreceipt','width=740,height=700,scrollbars=yes,resizable=yes');
	openwin.focus();
	frmprt.target = "orderreceipt";
	frmprt.submit();
}

</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="cartWrap orderWrap">
				<div class="cartHeader">
					<div class="orderGiftStep">
						<span class="step01">Gift 카드 주문결제</span>
						<h2><span class="step02">Gift 카드 주문완료</span></h2>
					</div>
					<dl class="myBenefitBox">
						<dt class="tPad10"><strong><%=GetLoginUserName%></strong>님 <span class="<%= GetUserLevelCSSClass() %>"><strong>[<%=GetUserLevelStr(userlevel)%>]</strong></span></dt>
						<dd class="bPad10">간편하고 실속 있는 <br /><strong class="crRed">텐바이텐 GIFT카드</strong>로 마음을 전하세요.</dd>
					</dl>
				</div>
<% if Not (IsSuccess) then %>
				<div class="cartBox tMar15">
					<div class="orderComplete">
						<p><strong><img src="http://fiximage.10x10.co.kr/web2013/inipay/txt_order_fail.gif" alt="고객님의 주문이 실패하였습니다." /></strong></p>
						<div class="failCont" style="width:600px;">
							<strong>오류내용</strong> : <%= myorder.FOneItem.FResultmsg %>
						</div>
						<p class="ftDotum"><strong class="cr888">텐바이텐 고객행복센터 <span class="crRed">1644-6030</span> <span class="fn lPad05 rPad05">|</span> <a href="mailto:customer@10x10.co.kr" class="cr888">customer@10x10.co.kr</a></strong></p>
					</div>

					<div class="ct tMar60 bPad20">
						<a href="javascript:history.back();" class="lMar10 btn btnB2 btnRed btnW220"><em class="whiteArr02">다시 주문하기</em></a>
					</div>
				</div>
<% else %>
				<div class="cartBox tMar15">
					<div class="orderComplete">
						<p><strong><img src="http://fiximage.10x10.co.kr/web2013/inipay/txt_order_complete.gif" alt="주문이 정상적으로 완료되었습니다." /></strong></p>
						<div class="orderNumber">
							<strong>[주문번호] <%=myorder.FOneItem.FgiftOrderSerial%></strong>
		<%
			'# 입금대기중 무통장입금이면 입금은행 계좌번호 표시
			if myorder.FOneItem.Faccountdiv="7" and myorder.FOneItem.Fipkumdiv<4 then
		%>
							<strong>[입금은행 가상계좌] <%=myorder.FOneItem.Faccountno%></strong>
		<% end if %>
						</div>
						<p>주문내역 및 인증번호 전송에 관한 내용은 <em class="crRed">마이텐바이텐 &gt; Gift 카드 &gt; 카드주문내역</em>에서 확인 가능 합니다.</p>
					</div>

					<div class="overHidden">
						<h3>결제 정보 확인</h3>
					</div>
					<table class="baseTable orderForm payForm tMar10">
						<caption>결제 정보 확인</caption>
						<colgroup>
							<col width="14%" /><col width="36%" /><col width="14%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>결제 방법</th>
							<td><%=myorder.FOneItem.GetAccountdivName%></td>
							<th>주문일시</th>
							<td><%=myorder.FOneItem.Fregdate%></td>
						</tr>
						<tr>
							<th>결제 금액</th>
							<td><strong class="crRed"><%=formatNumber(myorder.FOneItem.FsubtotalPrice,0)%>원</strong></td>
							<th>결제일시</th>
							<td>
								<% if IsNULL(myorder.FOneItem.Fipkumdate) or (myorder.FOneItem.FIpkumDiv<4) Then %>
								결제이전
								<% else %>
								<%=myorder.FOneItem.Fipkumdate%>
								<% end if %>
							</td>
						</tr>
		<% if myorder.FOneItem.Faccountdiv="7" then %>
						<tr>
							<th>입금 예정자명</th>
							<td colspan="3"><%=myorder.FOneItem.FaccountName%></td>
						</tr>
						<tr>
							<th>입금은행 가상계좌</th>
							<td colspan="3"><strong class="crRed"><%=myorder.FOneItem.Faccountno%></strong></td>
						</tr>
		<% end if %>
						</tbody>
					</table>

					<div class="overHidden tMar55">
						<h3>GIFT 카드 주문 정보 확인</h3>
					</div>
					<table class="baseTable bBdrNone tMar10">
						<caption>GIFT 카드 주문리스트</caption>
						<colgroup>
							<col width="120px" /><col width="220px" /><col width="" /><col width="120px" /><col width="190px" />
						</colgroup>
						<thead>
						<tr>
							<th>상품코드</th>
							<th colspan="2">상품정보</th>
							<th>판매가격</th>
							<th>전송방법</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%=myorder.FOneItem.FcardItemId%></td>
							<td class="rt">
								<a href="/shopping/giftcard/giftcard.asp?cardid=<%=myorder.FOneItem.FcardItemId%>" target="_blank"><img src="<%= myorder.FOneItem.GetSmallImage %>" alt="<%=myorder.FOneItem.FCarditemname & " [" & myorder.FOneItem.FcardOptionName & "]"%>" /></a>
							</td>
							<td class="lt"><%=myorder.FOneItem.FCarditemname & " [" & myorder.FOneItem.FcardOptionName & "]"%></td>
							<td><%=formatNumber(myorder.FOneItem.Ftotalsum,0)%>원</td>
							<td><%=myorder.FOneItem.getSendDivName%></td>
						</tr>
						</tbody>
						<tfoot>
						<tr>
							<td colspan="5"><strong class="cr555">총 결제액</strong> <span class="crRed lPad10"><strong class="fs20"><%=formatNumber(myorder.FOneItem.FsubtotalPrice,0)%></strong>원</span></td>
						</tr>
						</tfoot>
					</table>

					<div class="overHidden tMar55">
						<h3>주문고객 정보 확인</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>주문고객 정보 확인</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>주문자명</th>
							<td><%=myorder.FOneItem.FbuyName%></td>
							<th>이메일</th>
							<td><%=myorder.FOneItem.Fbuyemail%></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td><%=myorder.FOneItem.Fbuyhp%></td>
							<th>전화번호</th>
							<td><%=myorder.FOneItem.FbuyPhone%></td>
						</tr>
						</tbody>
					</table>

					<div class="overHidden tMar55">
						<h3>전송 정보 확인</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>전송 정보 확인</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>받으시는 분<br /> 휴대전화</th>
							<td><%=myorder.FOneItem.Freqhp%></td>
							<th>받으시는 분<br /> 이메일</th>
							<td>
								<% if Not(myorder.FOneItem.Freqemail="" or isNull(myorder.FOneItem.Freqemail)) then %>
								<%=myorder.FOneItem.Freqemail%>
								<% end if %>
							</td>
						</tr>
						<% if myorder.FOneItem.FbookingYn="Y" then %>
						<tr>
							<th>예약 전송 선택</th>
							<td colspan="3"><%=formatDateTime(myorder.FOneItem.FbookingDate,1) & " " & hour(myorder.FOneItem.FbookingDate) & "시"%></td>
						</tr>
						<% elseif Not(myorder.FOneItem.FsendDate="" or isNull(myorder.FOneItem.FsendDate)) then %>
						<tr>
							<th>전송일시</th>
							<td colspan="3">
								<%
									if myorder.FOneItem.Fipkumdiv<=3 then
										Response.Write "무통장 입금 결제 완료 시 인증번호 전송이 됩니다."
									else
										Response.Write myorder.FOneItem.FsendDate
									end if
								%>
							</td>
						</tr>
						<% end if %>
						</tbody>
					</table>

					<div class="ct tMar60 bPad20">
						<a href="/my10x10/giftcard/giftcardOrderlist.asp" class="btn btnB2 btnWhite2 btnW220">주문확인 하기</a>
						<a href="javascript:jumunreceipt()" class="lMar10 btn btnB2 btnWhite2 btnW220">인쇄하기</a>
						<a href="/" class="lMar10 btn btnB2 btnRed btnW220"><em class="whiteArr02">쇼핑 계속하기</em></a>
					</div>
				</div>

				<form name="frmprt" method="post" action="/my10x10/giftcard/popCardOrderReciept.asp" style="margin:0px;">
				<input type="hidden" name="idx" value="<%= giftOrderserial %>">
				</form>

				<% end if %>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
set myorder = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
