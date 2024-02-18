<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 증빙서류발급"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_service_v1.jpg"
	strPageDesc = "현금영수증, 결제영수증 등을 확인 할수 있습니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 증빙서류발급"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/order/document_issue.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/taxsheet_cls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/cashreceiptcls.asp" -->
<!-- #include virtual="/inipay/iniWeb/aspJSON1.17.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
Dim IsBiSearch   : IsBiSearch   = False   '''비회원 주문인가.
Dim kakaoPayCid, strSql, orderTempIdx
Dim iniRentalAesEncodeTid, oJSON, strData, iniRentalMid
if (application("Svr_Info")="Dev") then
	kakaoPayCid = "TC0ONETIME"'//테스트용
ElseIf (application("Svr_Info")="Staging") Then
	'kakaoPayCid = "TC0ONETIME"'//테스트용
	kakaoPayCid = "C371930065"'//실결제용
Else
	kakaoPayCid = "C371930065"'//실결제용
End If

dim i, j, lp
dim page
dim pflag
pflag = requestCheckVar(request("pflag"),10)
page = requestCheckVar(request("page"),9)
if (page="") then page = 1

dim userid, orderserial
userid       = getEncLoginUserID()
orderserial  = requestCheckVar(request("idx"),11)


dim myorder
set myorder = new CMyOrder

myorder.FPageSize = 10
myorder.FCurrpage = page
myorder.FRectUserID = userid
myorder.FRectSiteName = "10x10"

if (pflag = "P") then
	myorder.FRectOldjumun = pflag
end if

myorder.FrectSearchGubun = "issue"

if IsUserLoginOK() then
    myorder.GetMyOrderListProc
elseif IsGuestLoginOK() then
    myorder.FRectOrderserial = GetGuestLoginOrderserial()
    myorder.GetMyOrderListProc

    IsBiSearch = True
    orderserial = myorder.FRectOrderserial
else
    dbget.close()	:	response.End
end if


dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectOrderserial = orderserial

if myorder.FResultCount>0 then
''    myorderdetail.GetOrderDetail  ''주석처리. 필요없음. 2016/08/09
end if

dim bufNpoint
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language='javascript'>

$(document).unbind("dblclick");

function goPage(page){
    location.href="?pflag=<%=pflag%>&page=" + page ;
}

var PrvPflag = '<%= pflag %>';
function chkClickChange(comp){
    if (PrvPflag!=comp.value){
        comp.form.submit();
	}
}

// 올앳카드 매출전표 팝업
function receiptallat(tid){
	var receiptUrl = "http://www.allatpay.com/servlet/AllatBizPop/member/pop_card_receipt.jsp?" +
		"shop_id=10x10_2&order_no=" + tid;
	window.open(receiptUrl,"app","width=410,height=650,scrollbars=0");
}

// 신용카드 매출전표 팝업_이니시스
function receiptinicis111(tid){
	var receiptUrl = "https://iniweb.inicis.com/app/publication/apReceipt.jsp?" +
		"noTid=" + tid + "&noMethod=1";
	var popwin = window.open(receiptUrl,"INIreceipt","width=415,height=600");
	popwin.focus();
}

// 신용카드 전표 분기.
function receiptCardRedirect(iorderserial, tid){
	var receiptUrl = "/my10x10/receipt/pop_CardReceipt.asp?orderserial=" + iorderserial +"&tid=" + tid;
	var popwin = window.open(receiptUrl,"pop_CardReceipt","width=415,height=600,scrollbars=yes,resizable=yes");
	popwin.focus();
}

// 네이버페이 전표 팝업
function receiptNaverpay(iorderserial, tid){
	alert("[네이버페이 > 결제내역]에서 확인 하실 수 있습니다.");
	window.open("https://order.pay.naver.com/home");
	//window.open("https://m.pay.naver.com/o/home");
	return;
	var receiptUrl = "/inipay/naverpay/pop_CardReceipt.asp?orderserial=" + iorderserial +"&tid=" + tid;
	var popwin = window.open(receiptUrl,"pop_CardReceipt","width=780,height=830,scrollbars=yes,resizable=yes");
	popwin.focus();
}

// 페이코 전표 팝업
function receiptPayco(iorderserial, tid){
	<% if (application("Svr_Info")="Dev") then %>
	var receiptUrl = "https://alpha-bill.payco.com/outseller/receipt/"+tid;
	<% else %>
	var receiptUrl = "https://bill.payco.com/outseller/receipt/"+tid;
	<% end if %>
	var popwin = window.open(receiptUrl,"Paycoreceipt","width=415,height=600");
	popwin.focus();
}

// 토스 전표 팝업
function receiptTossPay(tid){
	<% if (application("Svr_Info")="Dev") then %>
	var receiptUrl = "https://pay.toss.im/payfront/web/external/sales-check?payToken="+tid;
	<% else %>
	var receiptUrl = "https://pay.toss.im/payfront/web/external/sales-check?payToken="+tid;
	<% end if %>
	var popwin = window.open(receiptUrl,"Tossreceipt","width=415,height=600");
	popwin.focus();
}

// 카카오페이 신규 전표 팝업
function receiptKakaoPay(iorderserial, tid, hashValue){
	<% if (application("Svr_Info")="Dev") then %>
	var receiptUrl = "https://mockup-pg-web.kakao.com/v1/confirmation/p/"+tid+"/"+hashValue;
	<% else %>
	var receiptUrl = "https://pg-web.kakao.com/v1/confirmation/p/"+tid+"/"+hashValue;
	<% end if %>
	var popwin = window.open(receiptUrl,"KakaoPayreceipt","width=415,height=600");
	popwin.focus();
}

// 신용카드 매출전표 팝업_KCP
function receiptkcp(tid){
	var receiptUrl = "https://admin.kcp.co.kr/Modules/Sale/CARD/ADSA_CARD_BILL_Receipt.jsp?" +
		"c_trade_no=" + tid + "&mnu_no=AA000001";
	var popwin = window.open(receiptUrl,"KCPreceipt","width=415,height=600");
	popwin.focus();
}

//현금영수증 신청 or PopUp - 이니시스 실시간이체 or 무통장
function cashreceipt(iorderserial){
	var receiptUrl = "/inipay/receipt/checkreceipt.asp?orderserial=" + iorderserial;
	var popwin = window.open(receiptUrl,"Cashreceipt","width=640,height=280,scrollbars=yes,resizable=yes");
	popwin.focus();
}

//이니렌탈 매출전표 PopUp
function receiptinirental(tid, mid){
	var receiptUrl = "https://inirt.inicis.com/statement/v1/statement?mid=" + mid +"&encdata=" + tid;
	var popwin = window.open(receiptUrl,"receiptinirental","width=670,height=670,scrollbars=yes,resizable=yes");
	popwin.focus();
}

$(function(){
	$('.searchField .word span label').click(function() {
		$('.searchField .word span label').removeClass('current');
		$(this).addClass('current');
	});
});

$(document).ready(function() {
	<% if (pflag = "P") then %>
	$('.searchField .word span #labelBeforeSix').addClass("current");
	<% else %>
	$('.searchField .word span #labelSixMonth').addClass("current");
	<% end if %>
});

</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_document_issue.gif" alt="증빙서류발급" /></h3>
						<ul class="list">
							<li>해당 주문건의 증빙서류 아이콘을 클릭하시면, 증빙서류의 출력이 가능합니다.</li>
							<li>현금영수증 신청을 원하실 경우, [발급신청] 버튼을 통해 신청 가능합니다.</li>
						</ul>
					</div>

					<form name="frmODSearch" method="get" >

					<div class="mySection">
						<fieldset>
						<legend>주문배송조회 조회기간</legend>
							<div class="searchField">
								<div class="word">
									<strong>조회기간</strong>
									<!--
									<span><input type="checkbox" id="day15" /> <label for="day15">15일</label></span>
									<span><input type="checkbox" id="onMonth" checked="checked" /> <label for="onMonth">1개월</label></span>
									<span><input type="checkbox" id="threeMonth" /> <label for="threeMonth">3개월</label></span>
									-->
									<span><input type="radio" id="sixMonth" name="pflag" onClick="chkClickChange(this);" /> <label for="sixMonth" id="labelSixMonth">최근 6개월</label></span>
									<span><input type="radio" id="beforeSix" name="pflag" value="P" <%= CHKIIF(pflag="P","checked","") %> onClick="chkClickChange(this);" /> <label for="beforeSix" id="labelBeforeSix">6개월 이전</label></span>
								</div>
							</div>

							<table class="baseTable">
							<caption>주문배송조회 목록</caption>
							<colgroup>
								<col width="98" /> <col width="88" /> <col width="*" /> <col width="81" /> <col width="81" /> <col width="81" /> <col width="81" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">주문번호</th>
								<th scope="col">주문일자</th>
								<th scope="col">주문상품</th>
								<th scope="col">총 구매금액</th>
								<th scope="col">주문상태</th>
								<th scope="col">신용카드/<br />보증보험</th>
								<th scope="col">현금영수증</th>
							</tr>
							</thead>
							<tbody>
							<% for i = 0 to (myorder.FResultCount - 1) %>
							<%
							    ''네이버 현금영수증 관련 추가 // 네이버 포인트 (현금성) 사용시 2016/08/09
							    ''NaverPay 신용카드인데 현금영수증 발행 필요가 있는지 체크.
							    bufNpoint = 0
							    if (myorder.FItemList(i).Fpggubun = "NP") and (myorder.FItemList(i).FAccountDiv="100") then
							        if (dateDiff("d",myorder.FItemList(i).Fipkumdate,date())<=61) then
    							        bufNpoint = fnGetNpaySpendPointSUM(myorder.FItemList(i).FOrderSerial)
    							        if (bufNpoint<>0) then
    							            myorder.FItemList(i).FspendNpayPoint = bufNpoint
    							        end if
    							    end if
							    end if
							%>
							<tr>
								<td><a href="myorderdetail.asp?idx=<%= myorder.FItemList(i).FOrderSerial %>&pflag=<%= pflag %>"><%= myorder.FItemList(i).FOrderSerial %></a></td>
								<td><%= Replace(Left(CStr(myorder.FItemList(i).Fregdate),10), "-", "/") %></td>
								<td class="lt">
									<a href="myorderdetail.asp?idx=<%= myorder.FItemList(i).FOrderSerial %>&pflag=<%= pflag %>"><%=myorder.FItemList(i).GetItemNames%></a>
								</td>
								<td><%= FormatNumber(myorder.FItemList(i).FSubTotalPrice,0) %>원</td>
								<td><span class="<%= myorder.FItemList(i).GetIpkumDivCSS %>"><%= myorder.FItemList(i).GetIpkumDivNameNew %></span></td>
								<td>
									<% if (trim(myorder.FItemList(i).Faccountdiv)="80") and (myorder.FItemList(i).FIpkumDiv >= 4) then %>
									<a href="javascript:receiptallat('<%= myorder.FItemList(i).Fpaygatetid %>')"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /></a><!-- All@ 결제일 경우 -->
									<% end if %>

									<% if (trim(myorder.FItemList(i).Faccountdiv)="150") and (myorder.FItemList(i).FIpkumDiv >= 4) then %>
										<%
											strData = ""
											iniRentalMid = ""
											Call fnGetIniRentalAesEncodeTid(myorder.FItemList(i).Fpaygatetid,strData,iniRentalMid)
											Set oJSON = New aspJSON
											oJSON.loadJSON(strData)
											iniRentalAesEncodeTid = oJSON.data("output")
											Set oJSON = Nothing
										%>
										<a href="" onclick="receiptinirental('<%=Server.URLEncode(iniRentalAesEncodeTid)%>', '<%=iniRentalMid%>');return false;"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /></a><!-- 이니렌탈 결제일 경우 -->								
									<% End If %>

									<%
									if ((myorder.FItemList(i).FAccountDiv="100") or (myorder.FItemList(i).FAccountDiv="110")) and (myorder.FItemList(i).FIpkumDiv >= 4) then
										if myorder.FItemList(i).Fpaygatetid<>"" then
											if (myorder.FItemList(i).Fpggubun = "KA") then
									%>
									<a href="javascript:receiptCardRedirect('<%= myorder.FItemList(i).FOrderSerial %>','<%= myorder.FItemList(i).Fpaygatetid %>')"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /></a><!-- 신용카드 결제일 경우(이니시스) -->
									<%		elseif (myorder.FItemList(i).Fpggubun = "NP") then %>
									<a href="javascript:receiptNaverpay('<%= myorder.FItemList(i).FOrderSerial %>','<%= myorder.FItemList(i).Fpaygatetid %>')"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /></a>
									<%		elseif (myorder.FItemList(i).Fpggubun = "PY") then %>
									<a href="javascript:receiptPayco('<%= myorder.FItemList(i).FOrderSerial %>','<%= myorder.FItemList(i).Fpaygatetid %>')"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /></a>
									<%		elseif (myorder.FItemList(i).Fpggubun = "TS") then %>
									<a href="javascript:receiptTossPay('<%= myorder.FItemList(i).Fpaygatetid %>')"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /></a>									
									<%
											elseif (Left(myorder.FItemList(i).Fpaygatetid,9)="IniTechPG") or (Left(myorder.FItemList(i).Fpaygatetid,5)="INIMX") or (Left(myorder.FItemList(i).Fpaygatetid,6)="Stdpay") then
									%>
									<a href="javascript:receiptCardRedirect('<%= myorder.FItemList(i).FOrderSerial %>','<%= myorder.FItemList(i).Fpaygatetid %>')"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /></a><!-- 신용카드 결제일 경우(이니시스) -->
									<%
											'// 신규 카카오 페이 추가
											elseif (myorder.FItemList(i).Fpggubun = "KK") then
											'// 카카오페이는 temp_idx값이 있어야 영수증 발급이 가능하여 해당 부분 가져옴
											strSql = "SELECT TOP 1 temp_idx from db_order.dbo.tbl_order_temp WITH (NOLOCK) WHERE orderserial='"&myorder.FItemList(i).FOrderSerial&"' "
											rsget.Open strSql,dbget,1
											if Not(rsget.EOF or rsget.BOF) then
												orderTempIdx = rsget(0)
											end if
											rsget.Close
									%>
									<a href="javascript:receiptKakaoPay('<%= myorder.FItemList(i).FOrderSerial %>','<%=myorder.FItemList(i).Fpaygatetid%>','<%=SHA256(CStr(kakaoPayCid&myorder.FItemList(i).Fpaygatetid&"temp"&orderTempIdx&userid))%>')"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /></a><!-- 신용카드 결제일 경우(카카오페이) -->
									<%
											else
									%>
									<a href="javascript:receiptkcp('<%= myorder.FItemList(i).Fpaygatetid %>')"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /></a><!-- 신용카드 결제일 경우(KCP) -->
									<%
											end if
										end if
									end if
									%>

									<% if (myorder.FItemList(i).IsInsureDocExists) then %>
									<a href="javascript:insurePrint('<%= myorder.FItemList(i).ForderSerial %>','ZZcube1010')"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_assurance.gif" alt="전자" /></a><!-- 전자보증보험 -->
									<% end if %>
								</td>
								<td>
									<%
									if (myorder.FItemList(i).IsPaperRequestExist) then
										if (myorder.FItemList(i).IsPaperFinished) then
											if (myorder.FItemList(i).GetPaperType="R") then
												'// 현금 영수증
												if (myorder.FItemList(i).IsDirectBankCashreceiptExists) then
									%>
									<a href="javascript:receiptCardRedirect('<%= myorder.FItemList(i).FOrderSerial %>','<%= myorder.FItemList(i).Fpaygatetid %>');"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금" /></a>
									<% if (myorder.FItemList(i).FcashreceiptReq="J") then %><br>(자진발급)<% end if %>
									<%
												else
									%>
									<a href="javascript:cashreceipt('<%= myorder.FItemList(i).ForderSerial %>');"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금" /></a>
									<% if (myorder.FItemList(i).FcashreceiptReq="J") then %><br>(자진발급)<% end if %>
									<%
												end if
											elseif (myorder.FItemList(i).GetPaperType="T") then
												'// 세금계산서
									%>
									<a href="javascript:cashreceipt('<%= myorder.FItemList(i).ForderSerial %>');"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_tax.gif" alt="세금" /></a>
									<%
											end if
										else
											if (myorder.FItemList(i).IsCashDocReqValid) then
												if (myorder.FItemList(i).GetPaperType="R") or (myorder.FItemList(i).GetPaperType="T") then
									%>
									<a href="javascript:cashreceipt('<%= myorder.FItemList(i).ForderSerial %>');"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue_ing.gif" alt="발급 중" /></a>
									<%
												end if
											end if
										end if
									else
										if (myorder.FItemList(i).IsCashDocReqValid) and (pflag <> "P") and (pflag <> "C") and (myorder.FItemList(i).FSubTotalPrice>0) and (myorder.FItemList(i).Fpggubun <> "KK") and (myorder.FItemList(i).Fpggubun <> "TS") and (myorder.FItemList(i).Fpggubun <> "CH") then  ''myorder.FItemList(i).FSubTotalPrice 추가 2013/12/31
									%>
									<a href="javascript:cashreceipt('<%= myorder.FItemList(i).ForderSerial %>');"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue.gif" alt="청" /></a>
									<%
										elseif (myorder.FItemList(i).Fpggubun = "TS") then
									%>
									<a href="" onclick="alert('토스 앱에서 확인하실 수 있습니다.');return false;" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금영수증 조회"></a>

									<%
										elseif (myorder.FItemList(i).Fpggubun = "CH") then
									%>
									<a href="" onclick="alert('차이 앱에서 확인하실 수 있습니다.');return false;" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금영수증 조회"></a>														
									<%
										elseif (myorder.FItemList(i).Fpggubun = "KK") then
									%>
									<a href="" onclick="alert('카카오페이는 카카오톡내 페이에서 확인하실 수 있습니다.');return false;" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금영수증 조회"></a>
									<%
										end if
									end if
									%>
								</td>
							</tr>
							<% next %>
							</tbody>
							</table>

							<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(myorder.FcurrPage, myorder.FtotalCount, myorder.FPageSize, 10, "goPage") %></div>

						</fieldset>
					</div>

					</form>

					<div class="helpSection">
						<h4><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_help.gif" alt="도움말 HELP" /></h4>
						<ul class="define">
							<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /> 신용카드 매출전표는 신용카드결제와 동시에 발급됩니다.</li>
							<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금" /> 무통장결제 및 실시간계좌이체시 발급가능하며, 31일(결제일 기준) 이내에 발급 가능합니다.</li>
							<% if (FALSE) then %>
							<!-- li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_tax.gif" alt="세금" /> 결제일 기준으로 익월 5일까지 결제월의 세금계산서 발급이 가능합니다.(예]5월 12일 구매시 6월 5일까지 발급요청가능)</li -->
						    <% end if %>
							<li><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_assurance.gif" alt="전자" /> 현금구매 시 발급가능한 전자보증보험서비스입니다.</li>
						</ul>

						<ul class="list">
							<li><em class="cr000">신용카드매출전표, 현금영수증은 동시에 발급되지 않습니다.</em>
								<ul>
									<li>- 무통장 및 실시간계좌이체 시 현금영수증 발행이 가능합니다. (세금계산서는 발행되지 않습니다.)</li>
									<li>- 실시간이체로 현금영수증 발급 시 결제에 이용된 예금주의 정보로 자동 발급되며, 발급 후 수정은 불가합니다.</li>
								</ul>
							</li>
							<li><em class="cr000">예치금 사용시 증빙서류 발급 안내</em>
								<ul>
									<li>- 신용카드 및 핸드폰 결제시 같이 사용한 예치금 금액에 대해서 별도로 현금영수증 발급이 가능합니다.</li>
									<li>- 무통장 및 실시간이체로 결제 시에는 사용한 예치금을 합산하여 총 구매금액에 대해 증빙서류가 발급됩니다.</li>
								</ul>
							</li>
							<% if (now()>"2016-07-01") then %>
							<li><em class="cr000">현금 영수증 자진 발급 안내</em>
								<ul>
									<li>- 2016년 7월부터 10만원 이상 무통장 거래건에 대해, 출고후 2일내에 발급하지 않으시면 출고 3일후 자진 발급 합니다. </li>
									<li>- 국세청 홈텍스 사이트에서 현금영수증 자진발급분 소비자 등록 메뉴로 수정 가능합니다. </li>
								</ul>
							</li>
						    <% end if %>
						</ul>

						<table class="baseTable columnTable tMar05">
						<caption>결제방식에 따른 증빙서류 발급 안내</caption>
						<colgroup>
							<col width="*" /> <col width="180" /> <col width="180" /> <col width="180" /> <col width="180" />
						</colgroup>
						<thead>
						<tr class="ico">
							<th scope="col"></th>
							<th scope="col"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용" /><br /> 신용카드매출전표</th>
							<th scope="col"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금" /><br /> 현금영수증</th>
							<th scope="col"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_assurance.gif" alt="전자" /><br /> 전자보증보험</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td>카드결제</td>
							<td><em class="crRed">발급가능</em></td>
							<td>발급불가</td>
							<td>발급불가</td>
						</tr>
						<tr>
							<td>실시간이체</td>
							<td>발급불가</td>
							<td ><em class="crRed">발급가능</em></td>
							<td>발급불가</td>
						</tr>
						<tr>
							<td>무통장입금</td>
							<td>발급불가</td>
							<td ><em class="crRed">발급가능</em></td>
							<td><em class="crRed">발급가능</em></td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%

set myorder = Nothing
set myorderdetail = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
