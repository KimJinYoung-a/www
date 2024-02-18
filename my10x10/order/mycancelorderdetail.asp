<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% const MenuSelect = "01" %>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/header.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<%

dim i, j
dim userid, orderserial, etype
dim pflag
dim tensongjangdiv

userid       = getEncLoginUserID()
orderserial  = request("idx")
etype        = request("etype")
pflag        = request("pflag")


dim myorder
set myorder = new CMyOrder
myorder.FRectOldjumun = pflag

if IsUserLoginOK() then
    myorder.FRectUserID = getEncLoginUserID()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
elseif IsGuestLoginOK() then
    myorder.FRectOrderserial = GetGuestLoginOrderserial()
    myorder.GetOneOrder
end if


dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectOrderserial = orderserial
myorderdetail.FRectOldjumun = pflag

if myorder.FResultCount>0 then
    myorderdetail.GetOrderDetail
end if

if Not myorder.FOneItem.IsValidOrder then
    response.write "<script language='javascript'>alert('취소된 주문건 또는 올바른 주문이 아닙니다.');</script>"
end if

'네비바 내용 작성
strMidNav = "MY 쇼핑리스트 > <b>취소주문조회</b>"
%>

<script language='javascript'>

// 올앳카드 매출전표 팝업
function receiptallat(tid){
	var receiptUrl = "http://www.allatpay.com/servlet/AllatBizPop/member/pop_card_receipt.jsp?" +
		"shop_id=10x10_2&order_no=" + tid;
	window.open(receiptUrl,"app","width=410,height=650,scrollbars=0");
}

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

// 세금계산서 요청 팝업
function taxreceipt(orderserial, mflag){
    var receiptUrl = "/my10x10/taxSheet/pop_taxOrder.asp?orderserial=" + orderserial;
	var popwin = window.open(receiptUrl,"Taxreceipt","width=518,height=400,scrollbars=yes");
	popwin.focus();
    
    /* 팝업창에서 체크
	//분기
	switch(mflag)
	{
		case "new":
			var receiptUrl = "/my10x10/taxSheet/pop_taxOrder.asp?orderserial=" + orderserial;
			var popwin = window.open(receiptUrl,"Taxreceipt","width=518,height=400,scrollbars=yes");
			popwin.focus();
			break;
		case "print":
			var receiptUrl = "/my10x10/taxSheet/pop_taxPrint.asp?orderserial=" + orderserial;
			var popwin = window.open(receiptUrl,"view","width=800,height=620,status=no, scrollbars=auto, menubar=no");
			popwin.focus();
			break;
	}
    */
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
	var popwin = window.open(receiptUrl,"Cashreceipt","width=640,height=400");
	popwin.focus();
}

function jumunreceipt(orderserial,pflag){
	var receiptUrl = "myorder_receipt.asp?idx=" + orderserial + "&pflag=" + pflag;
	window.open(receiptUrl,"orderreceipt","width=750,height=700, scrollbars=yes, resizabled=yes");
}

function fnGoEditOrder(comp, idx){
    if (comp.value.length>0){
        if (comp.value=="cncl"){
            location.href="/my10x10/order/order_cancel.asp?idx=" + idx;
        }else{
            location.href="/my10x10/order/order_info_edit.asp?idx=" + idx + "&etype=" + comp.value;
        }
    }
}
</script>

<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="960">
	<!----- 마이텐바이텐 타이틀 시작 ----->
	<!-- #include virtual ="/lib/topMenu/top_my10x10.asp" -->
	<!----- 마이텐바이텐 타이틀 끝 ----->
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="mar_top_20px">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="180" valign="top" style="padding-right:20px">
            <!----- 레프트 시작 ----->
            <!-- #include virtual ="/lib/leftmenu/left_my10x10.asp" -->
            <!----- 레프트 끝 ----->
            </td><!----- 주문 배송조회 시작 ----->
            <td width="780" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<!-- My10x10 메뉴 -->
					<!-- #include virtual ="/lib/topmenu/Menu_my10x10.asp" -->
					</td>
				</tr>
              <tr>
                <td class="pdd_top_30px" style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2010/mytenbyten/title_main01_sub03.gif" alt="취소 주문 내역"></td>
              </tr>
              <tr>
                <td class="link_gray_11px_line" style="line-height:16px;padding-bottom:20px"></td>
              </tr>
              <tr>
                <td style="padding-bottom:7px">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td align="right" style="padding:0 10px 4px 0">
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="62" style="padding-right:10px"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/ordercancelnum_title.gif" width="62" height="17"></td>
                        <td class="eng12pxredb"><%= orderserial %></td>
                        <td style="padding-left:10px;" align="right"><a href="/my10x10/order/myorderlist.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/btn_ordersearch03.gif"  border="0"></a></td>
                        <td width="110" style="padding-left:10px;" align="right"><a href="/my10x10/order/mycancelorderlist.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/btn_ordersearch02.gif"  border="0"></a></td>
                      </tr>
                      </table></td>
                  </tr>
                  </table>
                 </td>
              </tr>
              <tr>
                <!----- 주문리스트 시작 ----->
                <td style="padding-bottom:25px"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr bgcolor="#fcf6f6">
                      <td height="30" style="border-top:3px solid #be0808;border-bottom:1px solid #eaeaea;padding-top:3px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="70" align="center" style="padding-left:5px;">상품</td>
                            <td width="95" align="center">상품코드/배송</td>
                            <td align="center">상품명 [옵션]</td>
                            <td width="75" align="center">판매가</td>
                            <td width="30" align="center">수량</td>
                            <td width="75" align="center">소계금액</td>
                            <td width="60" align="center">주문상태</td>
                            <td width="95" align="center">택배정보</td>
                          </tr>
                      </table></td>
                    </tr>
				<% for i=0 to myorderdetail.FResultCount-1 %>
                    <tr>
                      <td height="78" style="border-bottom:1px solid #eaeaea;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="70" align="center" style="padding-left:5px;"><a href="javascript:ZoomItemPop(<%= myorderdetail.FItemList(i).FItemid %>,'new');" onFocus="blur()"><img src="<%= myorderdetail.FItemList(i).FImageSmall %>" width="50" height="50"></a></td>
                            <td width="95" align="center" style="padding-top:3px;line-height:17px;">
								<%=myorderdetail.FItemList(i).FItemid%><br>
								<%=myorderdetail.FItemList(i).getDeliveryTypeName %>
							</td>
                            <td style="padding:3px 0 0 5px;line-height:17px;">
								<a href="javascript:ZoomItemPop(<%= myorderdetail.FItemList(i).FItemid %>,'new');"  class="link_ctleft"><%= myorderdetail.FItemList(i).FItemName %></a>
								<br>
								<font color="blue"><%= myorderdetail.FItemList(i).FItemoptionName %></font>
							</td>
                            <td width="75" align="center" style="padding-top:3px;"><%= FormatNumber(myorderdetail.FItemList(i).FItemCost,0) %>원</td>
                            <td width="30" align="center" style="padding-top:3px;"><%= myorderdetail.FItemList(i).FItemNo %></td>
                            <td width="75" align="center" style="padding-top:3px;"><%= FormatNumber((myorderdetail.FItemList(i).FItemCost * myorderdetail.FItemList(i).FItemNo),0) %>원</td>
                            <td width="60" align="center" style="padding-top:3px;"><%= myorderdetail.FItemList(i).GetItemDeliverStateName(myorder.FOneItem.FIpkumDiv, myorder.FOneItem.FCancelyn) %></td>
                            <td width="95" align="center" style="padding-top:3px;line-height:17px;">
								<%= myorderdetail.FItemList(i).GetDeliveryName %><br>
								<%= myorderdetail.FItemList(i).GetSongjangURL %>
							</td>
                          </tr>
                      </table></td>
                    </tr>
				<% next %>
                    <tr>
                      <td height="30" align="right" bgcolor="#fcf6f6" style="padding-right:26px;border-bottom:1px solid #eaeaea;">					  
						총 결제 금액 : 상품주문금액 <%= FormatNumber((myorder.FOneItem.Ftotalsum - myorder.FOneItem.FDeliverprice),0) %>원 + 배송비 <%= FormatNumber(myorder.FOneItem.FDeliverprice,0) %>원 - 마일리지 <%= FormatNumber(myorder.FOneItem.Fmiletotalprice,0) %>원 - 할인 <%= FormatNumber((myorder.FOneItem.Ftencardspend + myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership),0) %>원 = 
						<span class="red_11px_bold"><%= FormatNumber(myorder.FOneItem.FsubtotalPrice,0) %></span>원
					  </td>
                    </tr>
                </table></td>
                <!----- 주문리스트 끝 ----->
              </tr>
              <tr>
                <!----- 구매자정보 시작 ----->
                <td style="padding-bottom:25px"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main01_02.gif" width="77" height="17"></td>
                    </tr>
                    <tr>
                      <td><table width="760px" border="0" cellpadding="0" cellspacing="0" style="border-top:3px solid #be0808;border-bottom:1px solid #eaeaea;">
                          <tr>
                            <td width="110" height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea;">주문하신 분</td>
                            <td width="270" height="31" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.FBuyName %></td>
                            <td width="110" height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea;">이메일 주소</td>
                            <td width="270" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.FBuyEmail %></td>
                          </tr>
                          <tr>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01">전화번호</td>
                            <td height="31" style="padding:0 0 0 20px;"><%= myorder.FOneItem.FBuyPhone %></td>
                            <td width="110" height="31" bgcolor="#fcf6f6" class="bbstxt01">휴대폰 번호</td>
                            <td style="padding:0 0 0 20px;"><%= myorder.FOneItem.FBuyhp %></td>
                          </tr>
                      </table></td>
                    </tr>
                </table></td>
                <!----- 구매자정보 끝 ----->
              </tr>
              <tr>
                <!----- 결제정보 시작 ----->
                <td style="padding-bottom:25px"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main01_03.gif" width="61" height="17"></td>
                    </tr>
                    <tr>
                      <td><table width="760px" border="0" cellpadding="0" cellspacing="0" style="border-top:3px solid #be0808;border-bottom:1px solid #eaeaea;">
                          <tr>
                            <td width="120" height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea">결제방법</td>
                            <td width="260" height="31" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.GetAccountdivName %></td>
                            <td width="120" height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea;">결제확인일시</td>
                            <td width="260" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.FIpkumDate %>&nbsp;</td>
                          </tr>
						  <tr>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea">마일리지 사용금액</td>
                            <td height="31" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= FormatNumber(myorder.FOneItem.Fmiletotalprice,0) %> Point</td>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea;">할인권 사용 금액</td>
                            <td style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= FormatNumber(myorder.FOneItem.Ftencardspend,0) %>원</td>
                          </tr>
                          <tr>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea">기타 할인 금액</td>
                            <td height="31" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= FormatNumber(myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership,0) %>원</td>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea;">총 결제 금액</td>
                            <td style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= FormatNumber(myorder.FOneItem.FsubtotalPrice,0) %>원</td>
                          </tr>
                          <tr>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01">마일리지 적립금액</td>
                            <td height="31" colspan="3" style="padding:0 0 0 20px;">
								<% if (myorder.FOneItem.FIpkumdiv>3) then %>
								<%= FormatNumber(myorder.FOneItem.FTotalMileage,0) %> Point
								<% else %>
								결제 후 적립&nbsp;
								<% end if %>
							</td>
                          </tr>
						<% if myorder.FOneItem.FAccountdiv = 7 then %>
                          <tr>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea">입금 예정자명</td>
                            <td height="31" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.Faccountname %></td>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea;">입금은행 정보</td>
                            <td style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.Faccountno %>&nbsp;&nbsp;(주)텐바이텐</td>
                          </tr>
						<% end if %>

					  </table></td>
                    </tr>
                </table></td>
              </tr>
              <!----- 배송지정보 시작 ----->
              <tr>
                <td style="padding-bottom:25px"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main01_04.gif" width="76" height="17"></td>
                    </tr>
                    <tr>
                      <td><table width="760px" border="0" cellpadding="0" cellspacing="0" style="border-top:3px solid #be0808;border-bottom:1px solid #eaeaea;">
                          <tr>
                            <td width="110" height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea;">받으시는 분</td>
                            <td height="31" colspan="3" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.FReqName %></td>
                          </tr>
                          <tr>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea">전화번호</td>
                            <td width="270" height="31" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.FReqPhone %></td>
                            <td width="110" height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea">휴대폰 번호</td>
                            <td width="270" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.FReqHp %></td>
                          </tr>
                          <tr>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea">주소</td>
                            <td height="31" colspan="3" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.Freqzipaddr %>&nbsp;<%= myorder.FOneItem.Freqaddress %></td>
                          </tr>
                          <tr>
                            <td height="31" bgcolor="#fcf6f6" class="bbstxt01">유의사항</td>
                            <td height="31" colspan="3" style="padding:0 0 0 20px;"><%= nl2Br(myorder.FOneItem.Fcomment) %>&nbsp;</td>
                          </tr>
                      </table></td>
                    </tr>

                </table></td>
              </tr>
			<% if Not IsNull(myorder.FOneItem.Freqdate) then %>
              <tr>
                <td style="padding-bottom:25px"><!---- 플라워배송 추가정보 시작 ---->
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="padding-bottom:7px;"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/title_main01_05.gif" width="113" height="17"></td>
                      </tr>
                      <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td><table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-top:3px solid #be0808;border-bottom:1px solid #eaeaea;">
                                  <tr>
                                    <td width="110" height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea;">보내시는 분</td>
                                    <td height="31" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.Ffromname %></td>
                                  </tr>
                                  <tr>
                                    <td height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea;">희망배송일</td>
                                    <td height="31" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.Freqdate %>일 <%= myorder.FOneItem.GetReqTimeText %></td>
                                  </tr>
                                  <tr>
                                    <td width="110" height="31" bgcolor="#fcf6f6" class="bbstxt01" style="border-bottom:1px solid #eaeaea;">메세지 선택</td>
                                    <td height="31" style="border-bottom:1px solid #eaeaea;padding:0 0 0 20px;"><%= myorder.FOneItem.GetCardLibonText %></td>
                                  </tr>
                                  <tr>
                                    <td height="31" bgcolor="#fcf6f6" class="bbstxt01">메세지 내용</td>
                                    <td height="31" style="padding:0 0 0 20px;"><%= myorder.FOneItem.Fmessage %>&nbsp;</td>
                                  </tr>
                              </table></td>
                            </tr>
                        </table></td>
                      </tr>
                    </table>
                  <!---- 플라워배송 추가정보 끝 ----></td>
              </tr>
			<%End If %>
			
				
            </table></td><!----- 주문 배송조회 끝 ----->
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>


<%
set myorder = Nothing
set myorderdetail = Nothing
%>

<!-- #include virtual="/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
