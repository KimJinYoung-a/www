<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_orderCls2016.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/util/rndSerial.asp" -->
<%
'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 기프트카드 주문결과"		'페이지 타이틀 (필수)

dim userid, userlevel
dim giftOrderserial, IsSuccess, myorder
Dim IsValidOrder : IsValidOrder = False   '''정상 주문 여부
Dim vSendCnt

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

vSendCnt = getGiftCardSMSsendcnt(giftorderserial)

If myorder.FResultcount > 0 Then
	IsValidOrder = true
Else
	Response.Write "<script type='text/javascript'>alert('잘못된 접속입니다.');self.location='/';</script>"
	dbget.close()
	Response.End
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
$(function(){
	$("#lyGiftcardUrl").hide();
	$("#lyGiftcardUrlWrap a").click(function(){
		$("#lyGiftcardUrl").slideDown();
		$("#shareUrl").select();
		return false;
	});
	$("#lyGiftcardUrl .btnclose").click(function(){
		$("#lyGiftcardUrl").hide();
	});
});

// 주문확인서 인쇄
function jumunreceipt(){
	var openwin = window.open('','orderreceipt','width=740,height=700,scrollbars=yes,resizable=yes');
	openwin.focus();
	document.frmprt.action = "/my10x10/giftcard/popCardOrderReciept.asp";
	document.frmprt.target = "orderreceipt";
	document.frmprt.submit();
}

//인증코드 MMS재전송
function CardCodeResend(){
<% If vSendCnt >= 2 Then %>
	alert("메시지 재전송은 2회까지 가능합니다.\nURL복사하기로 공유하실 수 있습니다.");
	return false;
<% Else %>
	if(confirm("메시지 재전송은 2회까지 가능합니다.\n메시지를 전송하시겠습니까?\n( <%=(2-vSendCnt)%>회 남았습니다 )") == true) {
		document.frmprt.action = "/my10x10/giftcard/do_GiftCodeResend.asp";
		document.frmprt.target = "iframeProc";
		document.frmprt.submit();
	} else {
		return false;
	}
<% End If %>
}
</script>
</head>
<body>
<div id="giftcardWrapV15a" class="wrap skinBlueV15a">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="giftcardDoneV15a">
				<!-- breadcrumb -->
				<div class="breadcrumbV15a">
					<a href="" class="underlineLink">HOME</a> &gt; <b>텐바이텐 기프트카드</b>
				</div>

			<% if Not (IsSuccess) then %>
			<!-- // 주문 실패 -->
				<div class="orderFailure">
					<p><img src="http://fiximage.10x10.co.kr/web2015/giftcard/txt_order_failure_v2.png" alt="기프트카드 주문이 실패하였습니다" /></p>
					<p class="errorMsg"><b>오류내용</b> : <%= myorder.FOneItem.FResultmsg %></p>
					<p class="contact">텐바이텐 고객행복센터 <b class="cRd0V15">1644-6030</b> <span>l</span> <a href="mailto:customer@10x10.co.kr">customer@10x10.co.kr</a></p>
				</div>

				<div class="btnGroupV15a">
					<a href="<%=SSLUrl%>/giftcard/present.asp" class="btn btnB1 btnRed" style="width:216px;">다시 주문하기</a>
				</div>
			<% else %>
			<!-- // 주문 성공 -->
				<div class="orderSumV15a">
					<p><img src="http://fiximage.10x10.co.kr/web2015/giftcard/txt_order_done_v2.png" alt="주문이 정상적으로 완료되었습니다." /></p>
					<div class="orderNo">
						<b>[주문번호] <%=myorder.FOneItem.FgiftOrderSerial%></b>
					</div>
					<p class="fs11"><b class="cRd0V15">마이텐바이텐 &gt; 기프트카드</b>에서 주문내역을 확인 하실 수 있습니다.</p>
				</div>

				<div class="tableV15a">
					<table>
						<caption>결제 정보 확인</caption>
						<thead>
						<tr>
						<% if myorder.FOneItem.Faccountdiv="7" then %>
							<th scope="col">결제방법</th>
							<th scope="col">결제금액</th>
							<th scope="col">입금자명</th>
							<th scope="col">입금계좌</th>
						<% else %>
							<th scope="col">결제일시</th>
							<th scope="col">결제방법</th>
							<th scope="col">결제금액</th>
							<th scope="col">결제상태</th>
						<% end if %>
						</tr>
						</thead>
						<tbody>
						<tr>
						<% if myorder.FOneItem.Faccountdiv="7" then %>
							<td><%=myorder.FOneItem.GetAccountdivName%></td>
							<td><strong><%=formatNumber(myorder.FOneItem.FsubtotalPrice,0)%>원</strong></td>
							<td><%=myorder.FOneItem.FaccountName%></td>
							<td><strong><%=myorder.FOneItem.Faccountno%></strong></td>
						<% else %>
							<td>
								<% if IsNULL(myorder.FOneItem.Fipkumdate) or (myorder.FOneItem.FIpkumDiv<4) Then %>
								결제이전
								<% else %>
								<%=myorder.FOneItem.Fipkumdate%>
								<% end if %>
							</td>
							<td><%=myorder.FOneItem.GetAccountdivName%></td>
							<td><strong><%=formatNumber(myorder.FOneItem.FsubtotalPrice,0)%>원</strong></td>
							<td>
							<%
								if myorder.FOneItem.Fipkumdiv="5" or myorder.FOneItem.Fipkumdiv="8" then
									Response.Write "결제완료"
								else
									Response.Write myorder.FOneItem.GetIpkumDivName
								end if
							%>
							</td>
						<% end if %>
						</tr>
						</tbody>
					</table>
				</div>

				<div class="tableV15a">
					<table>
						<caption>기프트카드 주문 정보 확인</caption>
						<thead>
						<tr>
							<th scope="col">주문일</th>
							<th scope="col">상품명</th>
							<th scope="col">구매금액</th>
							<th scope="col">전송방법</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%=myorder.FOneItem.Fregdate%></td>
							<td><%=myorder.FOneItem.FCarditemname & " " & myorder.FOneItem.FcardOptionName%></td>
							<td><%=formatNumber(myorder.FOneItem.Ftotalsum,0)%>원</td>
							<td><%=myorder.FOneItem.getSendDivName%></td>
						</tr>
						</tbody>
					</table>
				</div>

				<div class="tableV15a">
					<table>
						<caption>전송 정보 확인</caption>
						<thead>
						<tr>
							<th scope="col">보내시는 분</th>
							<th scope="col">보내는 사람 휴대전화</th>
							<th scope="col">받는 사람 휴대전화</th>
							<th scope="col"><% if myorder.FOneItem.Faccountdiv<>"7" then %>기프트카드 재전송<% end if %></th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%=myorder.FOneItem.FbuyName%></td>
							<td><%=myorder.FOneItem.Fsendhp%></td>
							<td><b><u class="cRd0V15"><%=myorder.FOneItem.Freqhp%></u></b></td>
							<td>
								<% if myorder.FOneItem.Faccountdiv<>"7" then %>
								<button type="button" onclick="CardCodeResend(); return false;" class="btn btnS2 btnWhite btnW90">SMS 재전송</button>
								<div id="lyGiftcardUrlWrap" class="lyGiftcardUrlWrap">
									<a href="" class="btn btnS2 btnWhite2 btnW90">URL 복사</a>
									<div id="lyGiftcardUrl" class="lyGiftcardUrlV15a">
										<fieldset>
											<label for="shareUrl">URL 복사하기</label>
											<input type="text" id="shareUrl" value="http://m.10x10.co.kr/giftcard/view.asp?gc=<%=rdmSerialEnc(myorder.FOneItem.FmasterCardCode)%>" readonly />
											<button type="button" class="btnclose">닫기</button>
										</fieldset>
									</div>
								</div>
								<% end if %>
							</td>
						</tr>
						</tbody>
					</table>
				</div>

				<div class="btnGroupV15a">
					<a href="/my10x10/giftcard/giftcardOrderlist.asp" class="btn btnB1 btnWhite">주문 확인하기</a>
					<a href="" onclick="jumunreceipt(); return false;" class="btn btnB1 btnWhite">인쇄하기</a>
					<a href="<%=SSLUrl%>/giftcard/present.asp" class="btn btnB1 btnRed">추가 선물하기</a>
				</div>
				<form name="frmprt" method="post" action="/my10x10/giftcard/popCardOrderReciept.asp" style="margin:0px;">
				<input type="hidden" name="idx" value="<%= giftOrderserial %>">
				</form>
				<iframe src="about:blank" id="iframeProc" name="iframeProc" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0"></iframe>
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