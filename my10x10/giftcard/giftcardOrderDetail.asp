<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2013.09.06 - 허진원 생성
'	Description : e기프트카드 주문내역 상세
'#######################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_ordercls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/util/rndSerial.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "10X10 : 텐바이텐 기프트카드 주문 상세"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim IsValidOrder : IsValidOrder = False   '''정상 주문인가.
	Dim myorder, userid, i, giftorderserial, masterCardCd, resendCnt, oIdx, vSendCnt
	userid = getEncLoginUserID()
	giftorderserial = requestCheckvar(request("idx"),15)

	set myorder = new cGiftcardOrder
	myorder.FUserID = userid
	myorder.Fgiftorderserial = giftorderserial
	myorder.getGiftcardOrderDetail
	
	
	If myorder.FResultcount > 0 Then
		IsValidOrder = true
	Else
		Response.Write "<script language='javascript'>alert('잘못된 주문번호 입니다.');</script>"
		dbget.close()
		Response.End
	End If
	
	if Not (myorder.FOneItem.IsValidOrder) then
	    Response.Write "<script language='javascript'>alert('취소된 주문이거나 정상 주문건이 아닙니다.');</script>"
	end if
	
	vSendCnt = getGiftCardSMSsendcnt(giftorderserial)
%>

<script language='javascript'>
document.ondblclick = function(event) { };  // kill dblclick

$(function(){
	$("#lyGiftcardUrl").hide();
	$("#lyGiftcardUrlWrap a").click(function(){
		$("#lyGiftcardUrl").slideDown();
		jsURLcopy();
		return false;
	});
	$("#lyGiftcardUrl .btnclose").click(function(){
		$("#lyGiftcardUrl").hide();
	});
});

// 신용카드 매출전표 팝업_이니시스
function receiptinicis(tid){
	var receiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?" +
		"noTid=" + tid + "&noMethod=1";
	var popwin = window.open(receiptUrl,"INIreceipt","width=415,height=600");
	popwin.focus();
}

// 신용카드 매출전표 팝업_KCP
function receiptkcp(tid){
	var receiptUrl = "https://admin.kcp.co.kr/Modules/Sale/CARD/ADSA_CARD_BILL_Receipt.jsp?" +
		"c_trade_no=" + tid + "&mnu_no=AA000001";
	var popwin = window.open(receiptUrl,"KCPreceipt","width=415,height=600");
	popwin.focus();
}

// 전자보증서 팝업
function insurePrint(orderserial, mallid){
	var receiptUrl = "https://gateway.usafe.co.kr/esafe/ResultCheck.asp?oinfo=" + orderserial + "|" + mallid
	var popwin = window.open(receiptUrl,"insurePop","width=518,height=400,scrollbars=yes,resizable=yes");
	popwin.focus();
}

//인증코드 MMS재전송
function CardCodeResend(){
<% If vSendCnt >= 2 Then %>
	alert("메시지 재전송은 2회까지 가능합니다.\n모두 사용하셨습니다.");
	return false;
<% Else %>
	if(confirm("메시지 재전송은 2회까지 가능합니다.\n메시지를 전송하시겠습니까?\n( <%=(2-vSendCnt)%>회 남았습니다 )") == true) {
		frmprt.action = "/my10x10/giftcard/do_GiftCodeResend.asp";
		frmprt.target = "iframeProc";
		frmprt.submit();
	} else {
		return false;
	}
<% End If %>
}

//주문확인서 인쇄
function jumunreceipt(){
	var openwin = window.open('','orderreceipt','width=925,height=800,scrollbars=yes,resizable=yes');
	openwin.focus();
	frmprt.action = "/my10x10/giftcard/popCardOrderReciept.asp";
	frmprt.target = "orderreceipt";
	frmprt.submit();
}

//보낸메일보기
function popReviewEmailCard() {
	var openwin = window.open('','cardPreview','width=880,height=900,scrollbars=yes');
	openwin.focus();
	frmprt.target = "cardPreview";
	frmprt.action = "/inipay/giftcard/popPreviewEmailCard.asp";
	frmprt.submit();
}


function PopGiftCardCancel(giftorderserial){
    if (giftorderserial == "") {
        alert("먼저 주문을 선택하세요.");
        return;
    }
	var popwin = window.open("popGiftCardCancel.asp?giftorderserial=" + giftorderserial,"PopGiftCardCancel","width=925, height=800,scrollbars=yes,resizable=no,status=no");
	popwin.focus();
}

function jsURLcopy(){
	$("#shareUrl").focus();
	$("#shareUrl").select();
}
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<div class="myHeader">
				<h2><a href="/my10x10/"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_my10x10.png" alt="MY 10X10" /></a></h2>
				<div class="breadcrumb">
					<a href="/">HOME</a> &gt;
					<a href="/my10x10/">MY TENBYTEN</a> &gt;
					<a href="" onclick="return false;">MY 쇼핑활동</a> &gt;
					<strong>GIFT 카드</strong>
				</div>
			</div>
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<div class="myContent">
					<div class="giftcard giftcardV15a">
						<div class="subHeader">
							<h3><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_giftcard.png" alt="텐바이텐 기프트카드" /></h3>
							<p>무슨 선물을 할까 늘 고민인 당신, 간편한 기프트 카드로 마음을 전해보세요.</p>
							<div class="btnGroupV15a">
								<a href="<%=SSLUrl%>/giftcard/present.asp" class="btn btnS1 btnRed">선물하기</a>
								<a href="/giftcard/" class="btn btnS1 btnWhite">안내 및 유의사항</a>
							</div>
							<div class="ico"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/img_gift_card_visual.png" alt=""></div>
						</div>
						<ul class="tabMenu addArrow tabReview">
							<li><a href="/my10x10/giftcard/giftcardOrderlist.asp" class="on"><span>주문내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardUselist.asp"><span>사용내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardRegistlist.asp"><span>등록내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardRegist.asp"><span>카드등록</span></a></li>
						</ul>
						<div class="mySection">
							<div class="orderDetail">
								<div class="title">
									<h4>주문정보</h4>
								</div>
								<table class="baseTable tMar10">
								<caption>기프트카드 주문정보</caption>
								<colgroup>
									<col style="width:120px;" /> <col style="width:*;" /> <col style="width:110px;" /> <col  style="width:90px;" /> <col  style="width:110px;" /> <col style="width:120px;" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col">주문번호</th>
									<th scope="col">상품명</th>
									<th scope="col">구매금액</th>
									<th scope="col">주문날짜</th>
									<th scope="col">상태</th>
									<th scope="col">취소요청</th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<td><%=myorder.FOneItem.Fgiftorderserial%></td>
									<td><%=myorder.FOneItem.FCarditemname & " [<span>" & myorder.FOneItem.FcardOptionName & "</span>]"%></td>
									<td><%=FormatNumber(myorder.FOneItem.FcardSellCash,0)%>원</td>
									<td><%=formatDate(myorder.FOneItem.Fregdate,"0000/00/00")%></td>
									<td>
						            <%
						            	If (myorder.FOneItem.FCancelyn<>"N") Then
						                	Response.Write "취소주문"
						            	Else
						                	Response.Write myorder.FOneItem.GetJumunDivName
						            	End If
						            %>
									</td>
									<td>
						            <%
						            	If (myorder.FOneItem.FCancelyn="N") Then
											If (myorder.FOneItem.IsWebOrderCancelEnable) Then
						            			Response.Write "<a href="""" class=""btn btnS2 btnGrylight btnW90"" onclick=""PopGiftCardCancel('" & myorder.FOneItem.Fgiftorderserial & "'); return false;""><span class=""fn"">주문취소</span></a>"
						            		End If
						            	End If
						            %>
									</td>
								</tr>
								</tbody>
								</table>

								<div class="title">
									<h4>기프트카드 전송정보</h4>
								</div>
								<table class="baseTable rowTable">
								<caption>기프트카드 전송 내역</caption>
								<colgroup>
									<col style="width:130px;" /> <col style="width:295px;" /> <col style="width:130px;" /> <col style="width:*;" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">보내는 분</th>
									<td><%=myorder.FOneItem.Fsendhp%></td>
									<th scope="row">전송 일시</th>
									<td>
									<%
										if myorder.FOneItem.Fipkumdiv<=3 then
											Response.Write "결제 완료 시 인증번호 전송이 됩니다."
										else
											Response.Write replace(replace(myorder.FOneItem.FsendDate,"-","/")," 오","<span class=""lPad05 rPad05"">|</span>오")
										end if
									%>
									</td>
								</tr>
								<tr>
									<th scope="row">받는 분</th>
									<td><%=myorder.FOneItem.Freqhp%></td>
									<th scope="row">작성 내용</th>
									<td><a href="/my10x10/giftcard/popGiftcardView.asp?idx=<%=giftorderserial%>" onclick="window.open(this.href, 'popGiftcardView', 'width=500, height=700, scrollbars=yes'); return false;" target="_blank" title="팝업 새창" class="btn btnS2 btnRed fn">기프트카드 보기</a></td>
								</tr>
								<% If myorder.FOneItem.Fjumundiv>=3 and myorder.FOneItem.Fjumundiv<7 and myorder.FOneItem.FCancelyn="N" Then %>
								<tr>
									<th scope="row">기프트카드<br /> 재전송</th>
									<td colspan="3">
										<button type="button" class="btn btnS2 btnWhite fn" onclick="CardCodeResend(); return false;">SMS 재전송</button>
										<div id="lyGiftcardUrlWrap" class="lyGiftcardUrlWrap">
											<a href="#lyGiftcardUrl" class="btn btnS2 btnWhite fn">URL 복사</a>
											<div id="lyGiftcardUrl" class="lyGiftcardUrlV15a">
												<fieldset>
													<label for="shareUrl">URL 공유하기</label>
													<input type="text" id="shareUrl" value="http://m.10x10.co.kr/giftcard/view.asp?gc=<%=rdmSerialEnc(myorder.FOneItem.FmasterCardCode)%>" />
													<button type="button" class="btnclose">닫기</button>
												</fieldset>
											</div>
										</div>
									</td>
								</tr>
								<% end if %>
								</tbody>
								</table>

								<div class="title">
									<h4>구매자정보</h4>
								</div>
								<table class="baseTable rowTable">
								<caption>기프트카드 구매자정보 내역</caption>
								<colgroup>
									<col style="width:130px;" /> <col style="width:295px;" /> <col style="width:130px;" /> <col style="width:*;" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">주문하시는 분</th>
									<td><%=myorder.FOneItem.Fbuyname%></td>
									<th scope="row">이메일 주소</th>
									<td><%=myorder.FOneItem.Fbuyemail%></td>
								</tr>
								<tr>
									<th scope="row"> 전화번호</th>
									<td><%=myorder.FOneItem.FbuyPhone%></td>
									<th scope="row">휴대전화 번호</th>
									<td><%=myorder.FOneItem.Fbuyhp%></td>
								</tr>
								</tbody>
								</table>

								<div class="title">
									<h4 class="last">결제정보</h4>
								</div>
								<table class="baseTable rowTable">
								<caption>기프트카드 결제정보 내역</caption>
								<colgroup>
									<col style="width:130px;" /> <col style="width:295px;" /> <col style="width:130px;" /> <col style="width:*;" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">결제방법</th>
									<td><%=myorder.FOneItem.GetAccountdivName%></td>
									<th scope="row">결제확인 일시</th>
									<td><%=chkIIF(myorder.FOneItem.FIpkumDiv>=4,myorder.FOneItem.Fipkumdate,"-")%></td>
								</tr>
								<%
									if (myorder.FOneItem.FAccountDiv="7") then
									'// 무통장입금일 경우
								%>
									<tr>
										<th scope="row"><%=chkIIF(myorder.FOneItem.FIpkumDiv>=4,"결제금액","결제하실 금액")%></th>
										<td><%=FormatNumber(myorder.FOneItem.Fsubtotalprice,0)%>원</td>
										<th scope="row">입금하실 계좌</th>
										<td><%=myorder.FOneItem.FaccountNo%></td>
									</tr>
								<%
									else
									'// 신용카드일경우
								%>
									<tr>
										<th scope="row">결제금액</th>
										<td colspan="3"><%=FormatNumber(myorder.FOneItem.Fsubtotalprice,0)%>원</td>
									</tr>
								<%	end if %>
								</tbody>
								</table>
							</div>
							<% If IsValidOrder THEN %>
							<div class="btnArea overHidden tPad20">
								<div class="ftLt">
									<% '### 신용카드 결제일 경우
										if ((myorder.FOneItem.FAccountDiv="100") or (myorder.FOneItem.FAccountDiv="110")) and (myorder.FOneItem.FIpkumDiv >= 4) then
											if myorder.FOneItem.Fpaydateid<>"" then
									%>
										<a href="" title="새창에서 열림" class="btn btnS2 btnBlue" onclick="receiptinicis('<%= myorder.FOneItem.Fpaydateid %>'); return false;"><span class="fn">신용카드매출전표</span></a>
									<%
											end if
										end if
									%>
									<% if (myorder.FOneItem.IsInsureDocExists) then	'### 전자보증보험 %>
										<a href="" title="새창에서 열림" class="btn btnS2 btnOlive" onclick="insurePrint('<%= myorder.FOneItem.Fgiftorderserial %>','ZZcube1010'); return false;"><span class="fn">전자보증보험</span></a>
									<% end if %>
									<!--<a href="" onclick="jumunreceipt(); return false;" title="새창에서 열림" class="btn btnS2 btnGry"><span class="fn whiteArr01">주문확인서</span></a>//-->
								</div>
							</div>
							<% end if %>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form name="frmprt" method="post" action="" style="margin:0px;">
	<input type="hidden" name="idx" value="<%= giftOrderserial %>">
	</form>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<iframe src="about:blank" id="iframeProc" name="iframeProc" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0"></iframe>
</body>
</html>
<% Set myorder = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->