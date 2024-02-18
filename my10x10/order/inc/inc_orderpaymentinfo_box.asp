
							<script type="text/javascript">

							// 올앳카드 매출전표 팝업
							function receiptallat(tid){
								var receiptUrl = "http://www.allatpay.com/servlet/AllatBizPop/member/pop_card_receipt.jsp?" +
									"shop_id=10x10_2&order_no=" + tid;
								var popwin = window.open(receiptUrl,"app","width=410,height=650,scrollbars=0");
								popwin.focus();
							}

							// 신용카드 매출전표 팝업_이니시스
							function receiptinicis(tid){
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

							// 신용카드 매출전표 팝업_KCP
							function receiptkcp(tid){
								var receiptUrl = "https://admin.kcp.co.kr/Modules/Sale/CARD/ADSA_CARD_BILL_Receipt.jsp?" +
									"c_trade_no=" + tid + "&mnu_no=AA000001";
								var popwin = window.open(receiptUrl,"KCPreceipt","width=415,height=600");
								popwin.focus();
							}

							// 세금계산서 요청 팝업
							function taxreceipt(orderserial, mflag){
								var receiptUrl = "/my10x10/taxSheet/pop_taxOrder.asp?orderserial=" + orderserial;
								var popwin = window.open(receiptUrl,"Taxreceipt","width=518,height=400,scrollbars=yes");
								popwin.focus();
							}

							// 전자보증서 팝업
							function insurePrint(orderserial, mallid){
								var receiptUrl = "https://gateway.usafe.co.kr/esafe/ResultCheck.asp?oinfo=" + orderserial + "|" + mallid
								var popwin = window.open(receiptUrl,"insurePop","width=518,height=400,scrollbars=yes,resizable=yes");
								popwin.focus();
							}

							//뱅크페이 현금영수증
							function receiptbankpay(tid){
								var receiptUrl = "http://www.bankpay.or.kr/pgmember/customcashreceipt.jsp?bill_key1=" + tid;
								var popwin = window.open(receiptUrl,"BankPayreceipt","width=400,height=560");
								popwin.focus();
							}

							//현금영수증 신청 or PopUp - 이니시스 실시간이체 or 무통장
							function cashreceipt(iorderserial){
								var receiptUrl = "/inipay/receipt/checkreceipt.asp?orderserial=" + iorderserial;
								var popwin = window.open(receiptUrl,"Cashreceipt","width=670,height=260,scrollbars=yes,resizable=yes");
								popwin.focus();
							}

							</script>

								<div class="title">
									<h4>결제정보</h4>
									<%
									if (MyOrdActType="E") and (IsWebEditEnabled) then
										if (myorder.FOneItem.IsEditEnable_AccountName) then
									%>
									<a href="javascript:popEditOrderInfo('<%= orderserial %>','payn');" title="결제방법 변경" class="btn btnS2 btnGrylight btnW100"><span class="fn">결제방법 변경</span></a>
									<%
										end if
									end if
									%>
								</div>
								<table class="baseTable rowTable">
								<caption>결제정보</caption>
								<colgroup>
									<col width="130" /> <col width="210" /> <col width="130" /> <col width="*" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">결제방법</th>
									<td>
										<%= myorder.FOneItem.GetAccountdivName %>
										<% IF (MyOrdActType = "N") Then %>

											<!-- All@ 결제일 경우 -->
											<% if (trim(myorder.FOneItem.Faccountdiv)="80") and (myorder.FOneItem.FIpkumDiv >= 4) then %>
												<a href="javascript:receiptallat('<%= myorder.FOneItem.Fpaygatetid %>')" title="신용카드 매출전표 확인하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용카드 매출전표"></a>
											<% end if %>

											<!-- 신용카드 결제일 경우 -->
											<% if ((myorder.FOneItem.FAccountDiv="100") or (myorder.FOneItem.FAccountDiv="110")) and (myorder.FOneItem.FIpkumDiv >= 4) then %>
												<% if myorder.FOneItem.Fpaygatetid<>"" then %>
													<% if (myorder.FOneItem.Fpggubun = "KA") then %>
													<a href="javascript:receiptCardRedirect('<%= myorder.FOneItem.ForderSerial %>','<%= myorder.FOneItem.Fpaygatetid %>')" title="신용카드 매출전표 확인하기" class="vMiddle"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt=""></a>
													<% elseif (myorder.FOneItem.Fpggubun = "NP") then %>
													<a href="javascript:receiptNaverpay('<%= myorder.FOneItem.ForderSerial %>','<%= myorder.FOneItem.Fpaygatetid %>')" title="신용카드 매출전표 확인하기" class="vMiddle"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt=""></a>
    													<% if (myorder.FOneItem.IsPaperRequestExist) and (myorder.FOneItem.IsPaperFinished) then %>
    													        <% if (myorder.FOneItem.GetPaperType="R") then %>
    													            <a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>');" title="새창에서 열림" class="btn btnS2 btnMint"><span class="fn">현금영수증</span></a>
                    											<% end if %>
                    											<% if (myorder.FOneItem.FcashreceiptReq="J") then %>(자진발급)<% end if %>
    													<% else %>
        													<% if (myorder.FOneItem.IsSpendNpayPointExists) then %>
        													<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>')" title="현금영수증 발급신청하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue.gif" alt="현금영수증 발급신청"></a>
        												    <% end if %>
        												<% end if %>
													<% elseif (myorder.FOneItem.Fpggubun = "PY") then %>
													<a href="javascript:receiptPayco('<%= myorder.FOneItem.ForderSerial %>','<%= myorder.FOneItem.Fpaygatetid %>')" title="신용카드 매출전표 확인하기" class="vMiddle"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt=""></a>
													<% elseif (myorder.FOneItem.Fpggubun = "KK") then %>
													<a href="javascript:receiptKakaoPay('<%= myorder.FOneItem.ForderSerial %>','<%= myorder.FOneItem.Fpaygatetid %>','<%=SHA256(CStr(kakaoPayCid&myorder.FOneItem.Fpaygatetid&"temp"&orderTempIdx&userid))%>')" title="신용카드 매출전표 확인하기" class="vMiddle"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt=""></a>
													<% elseif (myorder.FOneItem.Fpggubun = "TS") then %>
													<a href="javascript:receiptTossPay('<%= myorder.FOneItem.Fpaygatetid %>')" title="신용카드 매출전표 확인하기" class="vMiddle"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt=""></a>														
													<% elseif (Left(myorder.FOneItem.Fpaygatetid,9)="IniTechPG") or (Left(myorder.FOneItem.Fpaygatetid,5)="INIMX") or (Left(myorder.FOneItem.Fpaygatetid,10)="INIpayRPAY") or (Left(myorder.FOneItem.Fpaygatetid,6)="Stdpay") or (Left(myorder.FOneItem.Fpaygatetid,3)="cns") or (Left(myorder.FOneItem.Fpaygatetid,5)="KCTEN") then %>
													<a href="javascript:receiptCardRedirect('<%= myorder.FOneItem.ForderSerial %>','<%= myorder.FOneItem.Fpaygatetid %>')" title="신용카드 매출전표 확인하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용카드 매출전표"></a>
													<% else %>
													<a href="javascript:receiptkcp('<%= myorder.FOneItem.Fpaygatetid %>')" title="신용카드 매출전표 확인하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용카드 매출전표"></a>
													<% end if %>
												<% end if %>
											<% end if %>

											<!-- 전자보증보험 -->
											<% if (myorder.FOneItem.IsInsureDocExists) then %>
											<a href="javascript:insurePrint('<%= myorder.FOneItem.ForderSerial %>','ZZcube1010')" title="전자보증보험 발급신청하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_assurance.gif" title="전자보증보험"></a>
											<% end if %>

											<% if ((myorder.FOneItem.FAccountDiv="7") or (myorder.FOneItem.FAccountDiv="20")) then %>
												<% If (myorder.FOneItem.Fpggubun = "KK") Then %>
													<a href="" onclick="alert('카카오페이는 카카오톡내 페이에서 확인하실 수 있습니다.');return false;" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금영수증 조회"></a>
												<% ElseIf (myorder.FOneItem.Fpggubun = "TS") Then %>
													<a href="" onclick="alert('토스 앱에서 확인하실 수 있습니다.');return false;" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금영수증 조회"></a>
												<% ElseIf (myorder.FOneItem.Fpggubun = "CH") Then %>
													<a href="" onclick="alert('차이 앱에서 확인하실 수 있습니다.');return false;" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금영수증 조회"></a>													
												<% Else %>
													<% if (myorder.FOneItem.IsPaperRequestExist) then %>
														<% if (myorder.FOneItem.IsPaperFinished) then %>
															<% if (myorder.FOneItem.GetPaperType="R") then %>
																<% IF (myorder.FOneItem.IsDirectBankCashreceiptExists) then %>
																	<a href="javascript:receiptinicis('<%= myorder.FOneItem.Fpaygatetid %>');" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금영수증 조회"></a>
																<% else %>
																	<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>');" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif"></a>
																<% end if %>
															<% elseif (myorder.FOneItem.GetPaperType="T") then %>
																<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>');" title="세금계산서 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_tax.gif" alt="세금계산서 조회"></a>
															<% end if %>
														<% else %>
															<% if (myorder.FOneItem.IsCashDocReqValid) then %>
																<% if (myorder.FOneItem.GetPaperType="R") then %>
																	<a href="javascript:cashreceipt ('<%= myorder.FOneItem.ForderSerial %>');" title="현금영수증 발급중"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue_ing.gif" alt="현금영수증 발급중"></a>
																<% elseif (myorder.FOneItem.GetPaperType="T") then %>
																	<a href="javascript:cashreceipt ('<%= myorder.FOneItem.ForderSerial %>');" title="세금계산서 발급중"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue_ing.gif" alt="세금계산서 발급중"></a>
																<% end if %>
															<% end if %>
														<% end if %>
														<% if (myorder.FOneItem.FcashreceiptReq="J") then %>(자진발급)<% end if %>
													<% else %>
														<% if (myorder.FOneItem.IsCashDocReqValid) and (myorder.FOneItem.IsValidOrder) then %>
															<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>')" title="증빙서류 발급신청하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue.gif" alt="증빙서류 발급신청"></a>
														<% end if %>
													<% end if %>
												<% End If %>
											<% end if %>

										<% end if %>
									</td>
									<th scope="row">결제확인 일시</th>
									<td><%= myorder.FOneItem.FIpkumDate %></td>
								</tr>
<% if (myorder.FOneItem.FAccountDiv="110") then %>
								<tr>
									<th scope="row">OK캐쉬백 사용금액</th>
									<td><%= FormatNumber(myorder.FOneItem.FokcashbagSpend,0) %>원</td>
									<th scope="row">신용카드결제 금액</th>
									<td><%= FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice-myorder.FOneItem.FokcashbagSpend,0) %>원</td>
								</tr>
<% elseif (myorder.FOneItem.FAccountDiv="150") then %>
	<tr>
		<th scope="row">결제하실 금액</th>
		<td colspan="3"><strong class="crRed"><%=iniRentalMonthLength%></strong>개월 간 월 <strong class="crRed"><%=formatnumber(iniRentalMonthPrice,0)%></strong>원</td>
	</tr>
<% else %>
	<% if myorder.FOneItem.FAccountdiv = 7 then %>
								<tr>
									<th scope="row"><%= CHKIIF(myorder.FOneItem.FIpkumdiv>3,"결제 금액","결제하실 금액") %></th>
									<td><%= FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice,0) %>원</td>
									<th scope="row">입금하실 계좌</th>
									<td><%= myorder.FOneItem.Faccountno %>&nbsp;&nbsp;(주)텐바이텐</td>
								</tr>
	<% else %>
								<tr>
									<th scope="row"><%= CHKIIF(myorder.FOneItem.FIpkumdiv>3,"결제 금액","결제하실 금액") %></th>
									<td colspan="3"><%= FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice,0) %>원</td>
								</tr>
	<% end if %>
<% end if %>
<% if (myorder.FOneItem.Fspendtencash<>0)  then %>
								<tr>
									<th scope="row">예치금 사용금액</th>
									<td colspan="3">
										<%= FormatNumber(myorder.FOneItem.Fspendtencash,0) %>원
										<% IF (MyOrdActType="N") Then %>

											<% if ((myorder.FOneItem.FAccountDiv="7") or (myorder.FOneItem.FAccountDiv="20")) then %>
												<% if (myorder.FOneItem.IsPaperRequestExist) then %>
													<% if (myorder.FOneItem.IsPaperFinished) then %>
														<% if (myorder.FOneItem.GetPaperType="R") then %>
															<% IF (myorder.FOneItem.IsDirectBankCashreceiptExists) then %>
																<a href="javascript:receiptinicis('<%= myorder.FOneItem.Fpaygatetid %>');" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금영수증 조회"></a>
															<% else %>
																<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>');" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif"></a>
															<% end if %>
														<% elseif (myorder.FOneItem.GetPaperType="T") then %>
															<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>');" title="세금계산서 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_tax.gif" alt="세금계산서 조회"></a>
														<% end if %>
													<% else %>
														<% if (myorder.FOneItem.IsCashDocReqValid) then %>
															<% if (myorder.FOneItem.GetPaperType="R") then %>
																<a href="javascript:cashreceipt ('<%= myorder.FOneItem.ForderSerial %>');" title="현금영수증 발급중"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue_ing.gif" alt="현금영수증 발급중"></a>
															<% elseif (myorder.FOneItem.GetPaperType="T") then %>
																<a href="javascript:cashreceipt ('<%= myorder.FOneItem.ForderSerial %>');" title="세금계산서 발급중"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue_ing.gif" alt="세금계산서 발급중"></a>
															<% end if %>
														<% end if %>
													<% end if %>
												<% else %>
													<% if (myorder.FOneItem.IsCashDocReqValid) and (myorder.FOneItem.IsValidOrder) then %>
														<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>')" title="증빙서류 발급신청하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue.gif" alt="증빙서류 발급신청"></a>
													<% end if %>
												<% end if %>
											<% end if %>

										<% end if %>
									</td>
								</tr>
<% end if %>
<% if (myorder.FOneItem.Fspendgiftmoney<>0)  then %>
								<tr>
									<th scope="row">GIFT카드 사용금액</th>
									<td colspan="3">
										<%= FormatNumber(myorder.FOneItem.Fspendgiftmoney,0) %>원
										<% IF (MyOrdActType="N") Then %>

											<% if ((myorder.FOneItem.FAccountDiv="7") or (myorder.FOneItem.FAccountDiv="20")) then %>
												<% if (myorder.FOneItem.IsPaperRequestExist) then %>
													<% if (myorder.FOneItem.IsPaperFinished) then %>
														<% if (myorder.FOneItem.GetPaperType="R") then %>
															<% IF (myorder.FOneItem.IsDirectBankCashreceiptExists) then %>
																<a href="javascript:receiptinicis('<%= myorder.FOneItem.Fpaygatetid %>');" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금영수증 조회"></a>
															<% else %>
																<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>');" title="현금영수증 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif"></a>
															<% end if %>
														<% elseif (myorder.FOneItem.GetPaperType="T") then %>
															<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>');" title="세금계산서 조회하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_tax.gif" alt="세금계산서 조회"></a>
														<% end if %>
													<% else %>
														<% if (myorder.FOneItem.IsCashDocReqValid) then %>
															<% if (myorder.FOneItem.GetPaperType="R") then %>
																<a href="javascript:cashreceipt ('<%= myorder.FOneItem.ForderSerial %>');" title="현금영수증 발급중"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue_ing.gif" alt="현금영수증 발급중"></a>
															<% elseif (myorder.FOneItem.GetPaperType="T") then %>
																<a href="javascript:cashreceipt ('<%= myorder.FOneItem.ForderSerial %>');" title="세금계산서 발급중"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue_ing.gif" alt="세금계산서 발급중"></a>
															<% end if %>
														<% end if %>
													<% end if %>
												<% else %>
													<% if (myorder.FOneItem.IsCashDocReqValid) and (myorder.FOneItem.IsValidOrder) then %>
														<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>')" title="증빙서류 발급신청하기"><img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_issue.gif" alt="증빙서류 발급신청"></a>
													<% end if %>
												<% end if %>
											<% end if %>

										<% end if %>
									</td>
								</tr>
<% end if %>
<% if myorder.FOneItem.FAccountdiv = 7 then %>
								<tr>
									<th scope="row">입금 예정자명</th>
									<td><%= myorder.FOneItem.Faccountname %></td>
									<th scope="row">입금기한</th>
									<td><%=Left(fnGetCyberAccountEndDate(myorder.FOneItem.ForderSerial),10) %> 까지</td>
								</tr>
<% end if %>
<% IF (MyOrdActType="C") and (Request.ServerVariables("URL") = "/my10x10/orderPopup/popCancelOrder.asp") Then %>
								<!--
								<tr>
									<th scope="row">주문취소사유</th>
									<td colspan="3">
										<select id="ordercancel" class="optSelect" style="width:115px;">
											<option>주문취소사유</option>
										</select>
									</td>
								</tr>
								-->
<% end if %>
								</tbody>
								</table>
