<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%

''주문 완료 페이지에서 Print와 같이 사용
dim refer
refer = request.serverVariables("HTTP_REFERER")

if InStr(refer,"/inipay/displayorder.asp")<1 then
	'' 비회원로그인 / 회원 로그인 체크
	if ((Not IsUserLoginOK) and (Not IsGuestLoginOK)) then
		'// 2009.04.15  정윤정 수정. post data 값 추가
		dim checklogin_backpath
	  	dim strBackPath, strGetData, strPostData
	   		strBackPath 	= request.ServerVariables("URL")
	   		strGetData  	= request.ServerVariables("QUERY_STRING")
	   		strPostData 	= fnMakePostData 'post data를 get string 형태로 변경

	 	checklogin_backpath = "backpath="+ server.URLEncode(strBackPath) + "&strGD=" +  server.URLEncode(strGetData) + "&strPD="+  server.URLEncode(strPostData)
	        response.redirect "/login/loginpage.asp?vType=G&" + checklogin_backpath
	        dbget.Close: response.end
	end if
end if
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim i, j

'==============================================================================
'나의주문
dim userid
dim orderserial
dim pflag

userid = getEncLoginUserID()
orderserial = requestCheckVar(request("idx"),11)
pflag       = requestCheckVar(request("pflag"),10)

dim myorder
set myorder = new CMyOrder
myorder.FRectOldjumun = pflag

if IsUserLoginOK() then
    myorder.FRectUserID = getEncLoginUserID()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
elseif IsGuestLoginOK() then
    orderserial = GetGuestLoginOrderserial()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
elseif (request.Cookies("shoppingbag")("before_orderserial")=orderserial) then ''비회원 주문완료후 내역서 출력
    ''쿠키 체크 2015/07/15============
    if (TenOrderSerialHash(orderserial)<>request("dumi")) then
        Dim iRaizeERR : SET iRaizeERR= new iRaizeERR  ''초기 에러 발생시킴(관리자확인)
        response.end
    end if
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
end if

dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectUserID = userid
myorderdetail.FRectOrderserial = orderserial
myorderdetail.FRectOldjumun = pflag

if myorder.FResultCount>0 then
    myorderdetail.GetOrderDetail
end if


dim tname
if (myorder.FOneItem.IsTicketOrder) then
	tname = "주문확인서"
Else
	tname = "예매확인서"
End If
'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : " + tname		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)
%>

<%
if myorderdetail.FResultCount <1 then
	response.write "<script>alert('주문내역이 존재하지 않습니다.')</script>"
	response.write "<script>window.close()</script>"
	dbget.close()	:	response.End
end if

'''티켓상품관련 체크(결제 완료 후 출력 가능)
if (myorder.FOneItem.IsTicketOrder) and (myorder.FOneItem.FIpkumdiv<4) or (myorder.FOneItem.Fcancelyn<>"N") or (myorder.FOneItem.FjumunDiv="9") then
    response.write "<script>alert('입금 이전 내역이거나 정상주문건이 아닙니다.\n\n티켓 주문은 결제 후 예매확인서 출력이 가능합니다.')</script>"
	response.write "<script>window.close()</script>"
	dbget.close()	:	response.End
end if

Dim vIsPacked, packpaysum, packcnt
vIsPacked = CHKIIF(myorder.FOneItem.FOrderSheetYN="P","Y","N")

'// 이니렌탈 월 납입금액, 렌탈 개월 수 가져오기
dim iniRentalInfoData, tmpRentalInfoData, iniRentalMonthLength, iniRentalMonthPrice
iniRentalInfoData = fnGetIniRentalOrderInfo(orderserial)
If instr(lcase(iniRentalInfoData),"|") > 0 Then
	tmpRentalInfoData = split(iniRentalInfoData,"|")
	iniRentalMonthLength = tmpRentalInfoData(0)
	iniRentalMonthPrice = tmpRentalInfoData(1)
Else
	iniRentalMonthLength = ""
	iniRentalMonthPrice = ""
End If
%>

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>
<% If vIsPacked = "Y" Then %>
$(function() {
	$('.infoMoreViewV15').mouseover(function(){
		$(this).children('.infoViewLyrV15').show();
	});
	$('.infoMoreViewV15').mouseleave(function(){
		$(this).children('.infoViewLyrV15').hide();
	});
});
<% End If %>

	function popTicketPlace(iplaceIdx){
	    var popwin = window.open('/my10x10/popTicketPLace.asp?placeIdx='+iplaceIdx,'popTicketPlace','width=720,height=700,scrollbars=yes,resizable=yes');
	    popwin.focus();
	}
</script>
</head>
<body>
<% if (myorder.FOneItem.IsTicketOrder) then %>
<%
Dim oticketItem, oticketSchedule, oitem

    Set oticketItem = new CTicketItem
    oticketItem.FRectItemID = myorderdetail.FItemList(0).FItemID
    oticketItem.GetOneTicketItem

    Set oticketSchedule = new CTicketSchedule
    oticketSchedule.FRectItemID = myorderdetail.FItemList(0).FItemID
    oticketSchedule.FRectItemOption = myorderdetail.FItemList(0).FItemOption
    oticketSchedule.getOneTicketSchdule

    Set oitem = new CatePrdCls
    oitem.GetItemData myorderdetail.FItemList(0).FItemID
%>

	<div class="heightgird" id="orderPrint">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_reservation_receipt.gif" alt="예매확인서" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<div class="orderDetail">
						<div class="reservationInfo">
							<div class="title">
								<h2 class="tMar0">예매정보</h2>
							</div>
							<div class="photo">
								<img src="<%= oitem.Prd.FImageBasic %>" width="200px" height="200px" alt="<%= myorderdetail.FItemList(0).FItemName %>" />
							</div>
							<table class="baseTable rowTable">
							<caption>예매정보</caption>
							<colgroup>
								<col width="130" /> <col width="*" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">예매번호</th>
								<td><%= myorder.FOneItem.FOrderSerial %></td>
							</tr>
							<tr>
								<th scope="row">공연명</th>
								<td>
									<div><%= myorderdetail.FItemList(0).FItemName %></div>
									<% if Not(myorderdetail.FItemList(0).FItemoptionName="" or isNull(myorderdetail.FItemList(0).FItemoptionName)) then %>
									<div><strong>선택옵션</strong> : <%= myorderdetail.FItemList(0).FItemoptionName %></div>
									<% End If %>
								</td>
							</tr>
							<tr>
								<th scope="row">예매자명</th>
								<td><%= myorder.FOneItem.FBuyName %></td>
							</tr>
							<tr>
								<th scope="row">공연일시</th>
								<td><%= oticketSchedule.FOneItem.getScheduleDateStr %>&nbsp;
								<% if oticketSchedule.FOneItem.getScheduleDateTime<>"-" then %>
									<%= oticketSchedule.FOneItem.getScheduleDateTime %>
								 <% end if %>
								</td>
							</tr>
							<tr>
								<th scope="row">공연장소</th>
								<td><%= oticketItem.FOneItem.FticketPlaceName %> <a href="#" onClick="popTicketPlace('<%= oticketItem.FOneItem.FticketPlaceIDx %>');" title="새창에서 열림" class="btn btnS2 btnGry2 lMar05"><span class="fn whiteArr01">약도보기</span></a></td>
							</tr>
							<tr>
								<th scope="row">티켓매수</th>
								<td><%= myorderdetail.FItemList(0).FItemNo %>장</td>
							</tr>
							<tr>
								<th scope="row">티켓수령방법</th>
								<td><%= oticketItem.FOneItem.getTicketDlvName %></td>
							</tr>
							</tbody>
							</table>
						</div>

						<div class="title">
						 <% if (oticketItem.FOneItem.FticketDlvType=9) then %>
							<h4>배송지정보</h4>
						<% else %>
							<h2>수령인정보</h2>
						<% End If %>
		                <% if (oticketItem.FOneItem.FticketDlvType=9) then %>
								(사은품 상품 배송을 위한 주소지 정보)
		                <% end if %>
						</div>
						<table class="baseTable rowTable">
						<caption>
							 <% if (oticketItem.FOneItem.FticketDlvType=9) then %>
								배송지정보
							<% else %>
								수령인정보
							<% End If %>
						</caption>
						<colgroup>
							<col width="130" /> <col width="295" /> <col width="130" /> <col width="*" />
						</colgroup>
						<tbody>

						<tr>
							<th scope="row">수령인명</th>
							<td colspan="3"><%= myorder.FOneItem.FReqName %></td>
						</tr>

						<tr>
							<th scope="row">휴대전화 번호</th>
							<td><%= myorder.FOneItem.FReqHp %></td>
							<th scope="row">전화번호</th>
							<td><%= myorder.FOneItem.FReqPhone %></td>
						</tr>
					<% if Not (IsNULL(myorder.FOneItem.Freqzipaddr) or (myorder.FOneItem.Freqzipaddr="")) then %>
						<tr>
							<th scope="row">주소</th>
							<td colspan="3">  <%= myorder.FOneItem.Freqzipaddr %>&nbsp;<%= myorder.FOneItem.Freqaddress %></td>
						</tr>
					<% End If %>
						</tbody>
						</table>

						<div class="title">
							<h2>결제정보</h2>
						</div>
						<table class="baseTable rowTable">
						<caption>결제정보</caption>
						<colgroup>
							<col width="130" /> <col width="295" /> <col width="130" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">결제일자</th>
							<td colspan="3">
							<% if not IsNULL(myorder.FOneItem.FIpkumDate) then %>
                         	   <%= myorder.FOneItem.FIpkumDate %>
                            <% end if %>
                           	</td>
						</tr>
						<tr>
							<th scope="row">결제수단</th>
							<td colspan="3">
								<%= myorder.FOneItem.GetAccountdivName %>
                          		<%= CHKIIF(IsNULL(myorder.FOneItem.FIpkumDate),"(입금 전)","입금완료") %>
                            </td>
						</tr>
						<tr>
							<th scope="row">총 결제금액</th>
							<td colspan="3"><%= FormatNumber(myorder.FOneItem.FsubTotalPrice,0) %>원</td>
						</tr>
						</tbody>
						</table>
					</div>

					<div class="companyInfo">
						<p><img src="http://fiximage.10x10.co.kr/web2020/my10x10/img_company_info.png" alt="텐바이텐 10X10 / 판매처 안내 : (주)텐바이텐 사업자등록번호 : 211-87-00620 / 대표이사 : 최은희 / 소재지 : 우)03082 서울시 종로구 대학로57, 교육동14층 / 텐바이텐 고객센터안내 TEL : 1644-6030 / AM 09 :00~PM 06:00 점심시간 PM 12:00~01:00 주말,공휴일 휴무 / E-mail : customer@10x10.co.kr " /></p>
					</div>

					<div class="btnArea tMar30 ct">
						<button type="button" onclick="window.print()" onFocus="blur()"class="btn btnB1 btnWhite btnW185 lMar10">인쇄하기</button>
					</div>
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

<%
Set oticketItem = Nothing
Set oticketSchedule = Nothing
Set oitem = Nothing
%>
<% else %>
	<div class="heightgird popV18" id="orderPrint">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1>거래 내역서</h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<div class="orderDetail">
						<div class="title">
							<% if (myorder.FOneItem.IsReceiveSiteOrder) then %>
							<h2 class="ftLt">거래 정보</h2>
							<p class="ftRt"><img src="http://company.10x10.co.kr/barcode/barcode.asp?image=3&type=23&data=<%=orderserial%>&height=50&barwidth=1" alt="바코드이미지" /></p>
							<% else %>
							<h2 class="ftLt">거래 정보</h2>
							<% End If %>
						</div>
						<table class="baseTable rowTable">
						<caption>주문정보 내역</caption>
						<colgroup>
							<col width="15%" /> <col width="35%" /> <col width="15%" /> <col width="35%" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">주문번호</th>
							<td>
								<%= myorder.FOneItem.FOrderSerial %>
								  <% If myorder.FOneItem.IsForeignDeliver Then %>
									  (<strong>해외배송</strong>)
								  <% End If %>
							</td>
							<th scope="row">주문일자</th>
							<td><%= FormatDate(myorder.FOneItem.FRegDate,"0000-00-00") %></td>
						</tr>
						<tr>
							<th scope="row">결제방법</th>
							<td><%= myorder.FOneItem.GetAccountdivName %></td>
							<th scope="row">결제일자</th>
							<td>
								<% if IsNULL(myorder.FOneItem.FIpkumDate) then %>
									<strong class="crRed">입금 전</strong>
								<% else %>
									<%= FormatDate(myorder.FOneItem.FIpkumDate,"0000-00-00") %>
								<% end if %>
							</td>
						</tr>
						<tr>
						<% if myorder.FOneItem.FAccountdiv = 7 then %>
							<th scope="row"><%= CHKIIF(IsNULL(myorder.FOneItem.FIpkumDate),"결제하실금액","결제금액") %></th>
							<td><em class="crRed"><strong><%= FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice,0) %></strong>원</em></td>
							<th scope="row">입금하실 계좌</th>
							<td><%= myorder.FOneItem.Faccountno %></td>
						 <% else %>
							<th scope="row"><%= CHKIIF(IsNULL(myorder.FOneItem.FIpkumDate),"결제하실금액","결제금액") %></th>
							<% if (myorder.FOneItem.FAccountDiv="150") then %>
								<td colspan="3" class="crRed"><span><%=iniRentalMonthLength%></span>개월 간 월 <em class="crRed"><strong><%=formatnumber(iniRentalMonthPrice,0)%></strong>원</em>
							<% Else %>
								<td colspan="3"><em class="crRed"><strong><%= FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice,0) %></strong>원</em>
							<% End If %>
							 <% if (myorder.FOneItem.FAccountDiv="100") or (myorder.FOneItem.FAccountDiv="110") then %>
		                        <% if (myorder.FOneItem.FokcashbagSpend<>0) then %>
			                        : <span class="red_11px">신용카드 <%= FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice-myorder.FOneItem.FokcashbagSpend,0) %> 원
			                        , OK캐쉬백 사용 : <%= FormatNumber(myorder.FOneItem.FokcashbagSpend,0) %> 원
			                	   <% end if %>
		                         </span>
		                    <% end if %>
                    		</td>
                    	<% end if %>
						</tr>

		                <% if myorder.FOneItem.FspendTenCash<>0 then %>
		                <tr>
		                  <th scope="row">예치금사용</th>
		                  <td colspan="3"><em class="crRed"><strong><%= FormatNumber(myorder.FOneItem.FspendTenCash,0) %></strong> 원</em></td>
		                </tr>
		                 <% end if %>
		                 <% if myorder.FOneItem.Fspendgiftmoney<>0 then %>
		                <tr>
		                  <th scope="row">Gift카드사용</th>
		                     <td colspan="3"><em class="crRed"><strong><%= FormatNumber(myorder.FOneItem.Fspendgiftmoney,0) %></strong> 원</em></td>
		                </tr>
		                 <% end if %>

						<tr>
							<th scope="row">주문자 정보</th>
							<td colspan="3"><%= myorder.FOneItem.FBuyName %> (휴대전화번호 : <%= myorder.FOneItem.FBuyHp %> / 전화번호 : <%= myorder.FOneItem.FBuyPhone %>)</td>
						</tr>
						<tr>
							<th scope="row">수령자 정보</th>
							<td colspan="3">
							 <% If myorder.FOneItem.IsForeignDeliver Then %>
								<div><%= myorder.FOneItem.FReqName %>(전화번호 : <%= myorder.FOneItem.FReqPhone %>	/ 이메일주소 : <%= myorder.FOneItem.FReqEmail %>)</div>
								<div><%= myorder.FOneItem.Freqzipaddr %></div>
								<div><%= myorder.FOneItem.Freqaddress %></div>
							 <% Else %>
								<div><%= myorder.FOneItem.FReqName %>	(휴대전화번호 : <%= myorder.FOneItem.FReqHp %>	/ 전화번호 : <%= myorder.FOneItem.FReqPhone %>)</div>
							 <% End If %>
							</td>
						</tr>
					<% if (myorder.FOneItem.IsReceiveSiteOrder) then %>
						<tr>
							<th scope="row">수령 방법</th>
							<td colspan="3">현장 수령</td>
						</tr>
					<% End If %>
						</tbody>
						</table>

						<div class="title">
							<h2>거래 상품 정보</h2>
						</div>
						<table class="baseTable btmLine">
						<caption>거래 상품 정보 목록</caption>
						<colgroup>
							<col width="98" /><col width="70" /><col width="*" /><col width="90" /><col width="68" /><col width="90" /><col width="80" /><% If vIsPacked = "Y" Then %><col width="70" /><% End If %>
						</colgroup>
						<thead>
						<tr>
							<th scope="col">상품코드/배송</th>
							<% If myorder.FOneItem.FAccountDiv="150" Then %>
								<th scope="col" colspan="3">상품정보</th>
							<% Else %>
								<th scope="col" colspan="2">상품정보</th>
								<th scope="col">판매가</th>
							<% End If %>
							<th scope="col">수량</th>
							<th scope="col">소계금액</th>
							<th scope="col">주문상태</th>
							<% If vIsPacked = "Y" Then %>
							<th scope="col" class="pkgInfoLyrV15a">
								<div class="infoMoreViewV15">
									<span>선물포장</span>
									<div class="infoViewLyrV15" style="display:none;">
										<div class="infoViewBoxV15">
											<dfn></dfn>
											<div class="infoViewV15">
												<div class="pad15">
													<p class="pkgOnV15a">선물포장이 <strong>가능</strong>한 상품</p>
													<p class="pkgActV15a">선물포장을 <strong>설정</strong>한 상품</p>
													<p class="pkgNoV15a">아이콘이 미표기된 상품은 선물포장을 <br />지원하지 않는 상품입니다.</p>
												</div>
											</div>
										</div>
									</div>
								</div>
							</th>
							<% End If %>
						</tr>
						</thead>
						<tbody>
						 <%
							packpaysum = 0
							packcnt = 0
						 for i=0 to myorderdetail.FResultCount-1
						 	If myorderdetail.FItemList(i).FItemid <> 100 Then
						 %>
							<tr>
								<td>
									<div><%= myorderdetail.FItemList(i).FItemid %></div>
									<div>
										<% '// 해외 직구 %>
										<% If myorderdetail.FItemList(i).Fodlvfixday="G" Then %>
											해외직구배송
										<% Else %>
											<% if myorderdetail.FItemList(i).Fisupchebeasong="N" then %>
											    <% if (myorderdetail.FItemList(i).Fodlvfixday="Q") Then %>
											    바로배송
											    <% else %>
												텐바이텐
											    <% end if %>
											<% elseif myorderdetail.FItemList(i).Fisupchebeasong="Y" then %>
												업체개별
											<% end if %>
										<% End If %>
									</div>
								</td>
								<td><img src="<%=myorderdetail.FItemList(i).FImageSmall %>" width="50" height="50" alt="<%= myorderdetail.FItemList(i).FItemName %>" /></td>
								<td class="lt">
									<div><%= myorderdetail.FItemList(i).FItemName %></div>
									<div><strong><%= myorderdetail.FItemList(i).FItemoptionName %></strong></div>
								</td>
								<% If myorder.FOneItem.FAccountDiv="150" Then %>
									<td></td>
								<% Else %>
									<td>
										<% if (myorderdetail.FItemList(i).IsSaleItem) then %>
											<strike><%= FormatNumber(myorderdetail.FItemList(i).Forgitemcost,0) %></strike><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %><br>
											<strong class="crRed"><%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %></strong><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
										<% else %>
											<% if (myorderdetail.FItemList(i).IsItemCouponAssignedItem) then %>
											<strike><%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %></strike><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
											<% else %>
											<%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
											<% end if %>
										<% end if %>

										<% if (myorderdetail.FItemList(i).IsItemCouponAssignedItem) then %>
											<br><strong class="crGrn"><%= FormatNumber(myorderdetail.FItemList(i).FItemCost,0) %>원</strong>
										<% else %>

										<% end if %>

										<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
										<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
										<% end if %>
									</td>
								<% End If %>
								<td><%= myorderdetail.FItemList(i).FItemNo %>
									<%
										If myorderdetail.FItemList(i).FIsPacked = "Y" Then
											Response.Write "<br /><span class=""cRd0V15"">(포장상품 " & fnGetPojangItemCount(myorderdetail.FItemList(i).FOrderSerial, myorderdetail.FItemList(i).FItemid, myorderdetail.FItemList(i).FItemoption) & ")</span>"
										End If
									%>
								</td>
								<% if (myorder.FOneItem.FAccountDiv="150") then %>
									<td>
										<p><span><%=iniRentalMonthLength%></span>개월 간</p>
										<strong class="crRed">월 <em><%=formatnumber(iniRentalMonthPrice, 0)%>원</em></strong>									
								<% Else %>
									<td><%= FormatNumber(myorderdetail.FItemList(i).FItemCost*myorderdetail.FItemList(i).FItemNo,0) %> <%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
								<% End If %>
								<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
								<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice*myorderdetail.FItemList(i).FItemNo,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
								<% end if %>
								</td>
								<td><%= myorderdetail.FItemList(i).GetItemDeliverStateNameNew(myorder.FOneItem.FIpkumDiv, myorder.FOneItem.FCancelyn, myorder.FOneItem.Fbaljudate, myorder.FOneItem.FTenbeasongCnt) %></td>
								<% If vIsPacked = "Y" Then %>
								<td>
									<%
									If myorderdetail.FItemList(i).FIsPacked = "Y" Then	'### 내가포장했는지
										Response.Write "<img src=""http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png"" alt=""상품요청상품"" />"
									End If
									%>
								</td>
								<% End If %>
							</tr>

						<%
							Else
								packcnt = packcnt + myorderdetail.FItemList(i).Fitemno	'### 총결제금액에 사용. 상품종수, 갯수 -1 해줌.
								packpaysum = packpaysum + myorderdetail.FItemList(i).FItemCost * myorderdetail.FItemList(i).Fitemno
							End If
						next %>
						</tbody>
						<tfoot>
						<tr>
							<td colspan="8">
								<div class="orderSummary">
									<span>주문상품수 <strong><%=CHKIIF(packcnt>0,myorderdetail.FResultCount-1,myorderdetail.FResultCount)%>종 (<%= FormatNumber(myorder.FOneItem.GetTotalOrderItemCount(myorderdetail)-packcnt,0) %>개)</strong></span>
									<% If myorder.FOneItem.FAccountDiv<>"150" Then %>
										<span>적립 마일리지 <strong><% if IsUserLoginOK() then %><%= FormatNumber(myorder.FOneItem.Ftotalmileage,0) %><% else %>0<% end if %>P</strong></span>
										<span>상품구매 총액 <strong><%= FormatNumber(myorder.FOneItem.FTotalSum-myorder.FOneItem.FDeliverPrice-packpaysum,0) %>원</strong></span>
									<% End If %>
								</div>
								<% if (myorder.FOneItem.FAccountDiv="150") then %>
									<div class="orderTotal">
										총 결제금액 : <strong class="crRed"><%=iniRentalMonthLength%></strong>개월 간 월 <strong class="crRed"><%=formatnumber(iniRentalMonthPrice,0)%></strong>원
									</div>
								<% Else %>
									<div class="orderTotal">
										총 결제금액 : 상품구매총액 <strong><%= FormatNumber((myorder.FOneItem.FTotalSum-myorder.FOneItem.FDeliverPrice-packpaysum),0) %></strong>원
										<%=CHKIIF(vIsPacked="Y"," + 선물포장비 " & FormatNumber(packpaysum,0) & "원","")%>
										+ 배송비 <%= FormatNumber(myorder.FOneItem.FDeliverpriceCouponNotApplied,0) %>원
									<% if (myorder.FOneItem.FDeliverpriceCouponNotApplied>myorder.FOneItem.FDeliverprice) then %>
										- 배송비쿠폰할인 <%= FormatNumber(myorder.FOneItem.FDeliverpriceCouponNotApplied-myorder.FOneItem.FDeliverprice,0) %>원
									<% end if %>
									<% IF (myorder.FOneItem.Fmiletotalprice<>0) then %>
									- 마일리지 <%= FormatNumber(myorder.FOneItem.Fmiletotalprice,0) %>P
									<% end if %>
									<% IF (myorder.FOneItem.Ftencardspend<>0) then %>
									- 보너스쿠폰할인 <%= FormatNumber(myorder.FOneItem.Ftencardspend,0) %>원
									<% end if %>

									<% if (myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership<>0) then %>
									- 기타할인 <%= FormatNumber((myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership),0) %>원
									<% end if %>
									= <strong class="crRed"><%= FormatNumber(myorder.FOneItem.FsubtotalPrice,0) %></strong>원
									</div>
								<% End If %>
							</td>
						</tr>
						</tfoot>
						</table>
					</div>

					<div class="companyInfo">
						<!-- 2013.09.24 -->
						<p><img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_company_info3.gif?v=1" alt="텐바이텐 10X10 / 판매처 안내 : (주)텐바이텐 사업자등록번호 : 211-87-00620 / 대표이사 : 최은희 / 소재지 : 우)03082 서울시 종로구 대학로 57 홍익대학교 대학로캠퍼스 교육동 14층 / 텐바이텐 고객센터안내 TEL : 1644-6030 / AM 10 :00~PM 05:00 점심시간 PM 12:00~01:00 주말,공휴일 휴무 / E-mail : customer@10x10.co.kr " /></p>
						<!-- //2013.09.24 -->
					</div>

					<div class="btnArea tMar30 ct">
						<button type="button" onclick="window.print()" onFocus="blur()" class="btn btnB1 btnWhite btnW185 lMar10">인쇄하기</button>
					</div>
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
<% end if %>
</body>
</html>

<%
set myorderdetail = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
