<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% const MenuSelect = "04" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 반품 신청"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_orderList_v1.jpg"
	strPageDesc = "반품 접수 및 신청내역 조회가 가능합니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 반품 신청"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/order/order_return_detail.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim IsValidOrder : IsValidOrder = False   '''정상 주문인가.
Dim IsBiSearch   : IsBiSearch   = False   '''비회원 주문인가.
Dim IsTicketOrder : IsTicketOrder = FALSE ''티켓주문인가
Dim IsChangeOrder : IsChangeOrder = FALSE ''교환주문인가

dim i, j
dim userid, orderserial, etype
dim pflag
dim tensongjangdiv

userid       = getEncLoginUserID()
orderserial  = requestCheckVar(request("idx"),11)
etype        = requestCheckVar(request("etype"),10)
pflag        = requestCheckVar(request("pflag"),10)

if (orderserial = "") then
	orderserial = requestCheckVar(request("orderserial"), 32)
end if


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

    IsBiSearch = True
    orderserial = myorder.FRectOrderserial
else
    dbget.close()	:	response.End
end if


dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectOrderserial = orderserial

Dim returnOrderCount	'' 반품신청 주문수
returnOrderCount = 0
if myorder.FResultCount>0 then
	myorderdetail.FRectUserID = userid
    myorderdetail.GetOrderDetail

	returnOrderCount = myorder.getReturnOrderCount
	IsValidOrder = True

	IsTicketOrder = myorder.FOneItem.IsTicketOrder

	IsChangeOrder = myorder.FOneItem.IsChangeOrder
end if

if (Not myorder.FOneItem.IsValidOrder) then
    IsValidOrder = False

    if (orderserial<>"") then
        response.write "<script language='javascript'>alert('취소된 주문건 또는 올바른 주문이 아닙니다.');</script>"
    end if
end if

Dim IsWebEditEnabled, vIsPacked, packpaysum, packcnt
'// MyOrdActType : /lib/inc/incMytentenHeader.asp 에서 생성
IsWebEditEnabled = (MyOrdActType = "E")
vIsPacked = CHKIIF(myorder.FOneItem.FOrderSheetYN="P","Y","N")
%>
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

function popReturnPrint(asid)
{
	var url = "/my10x10/orderPopup/popReturnPrint.asp?asid="+asid;
	var popwin = window.open(url,'popReturnPrint','width=775,height=600,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function popCsDetail(idx)
{
	var url = "/my10x10/orderPopup/popCsDetail.asp?CsAsID="+idx;
	var popwin = window.open(url,'popCsDetail','width=735,height=600,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function ReturnOrder(frm){
    if (!IsCheckedItem(frm)){
        alert('선택 상품이 없습니다. 먼저 반품하실 상품을 선택하세요.');
        return;
	}

//브랜드별로(반송처) 따로 접수하도록 체크
    if (!IsAvailReturnValid(frm)){
        return;
    }

    var popwin=window.open('','popReturnOrder','width=977,height=800,scrollbars=yes,resizable=yes');
    frm.target = "popReturnOrder";
    frm.action = "/my10x10/orderPopup/popReturnOrder.asp";
    frm.submit();
    popwin.focus();
}

function IsCheckedItem(frm){
    for (var i=0;i<frm.elements.length;i++){
		var e = frm.elements[i];

		if ((e.type=="checkbox")&&(e.checked==true)) {
			return true;
		}
	}
	return false;
}

function IsAvailReturnValid(frm){
    var tenBExists = false;
    var upBExists = false;
    var pBrand = "";

    for (var i=0;i<frm.elements.length;i++){
		var e = frm.elements[i];

		if ((e.type=="checkbox")&&(e.checked==true)) {
			if (e.id.substring(0,1)=="N"){
			    tenBExists = true;
			}else{
			    upBExists = true;

			    if ((pBrand!="")&&(pBrand!=e.id.substring(1,32))){
			        alert('업체배송 상품을 반품하실 경우 브랜드별(입점업체별)로 - 따로 신청해 주시기 바랍니다.');
	                return false;
			    }
			    pBrand = e.id.substring(1,32);
			}
		}
	}

	if ((tenBExists==true)&&(upBExists==true)){
	    alert('텐바이텐배송상품과 업체배송상품을 같이 반품신청 하실 수 없습니다. - 따로 신청해 주시기 바랍니다.');
	    return false;
	}

	return true;
}

function popMyOrderNo()
{
	var f = document.frmSearch;
	var url = "/my10x10/orderPopup/popMyOrderNo.asp?frmname=" + f.name + "&targetname=" + f.orderserial.name;
	window.open(url,'popMyOrderNo','width=670,height=500,scrollbars=yes,resizable=yes');
}

</script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_return.gif" alt="반품/환불" /></h3>
						<ul class="list">
							<li><em class="crRed">상품출고일 기준으로 7일 이내(평일기준)에 반품/환불 가능합니다.</em></li>
							<li>반품을 원하시는 상품이 포함된 주문의 주문번호나 [반품접수] 버튼을 클릭해주시면, 상세정보에서 반품등록이 가능합니다.</li>
							<li>이미 접수한신 반품/환불 서비스는 [내가 신청한 서비스]에서도 확인하실 수 있습니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<fieldset>
						<legend>주문번호 검색</legend>

							<!-- #include virtual ="/my10x10/order/inc/inc_ordersearch_box.asp" -->

<% if (isValidOrder) then %>

							<form name="frmDetail" method="post" action="">
							<input type="hidden" name="orderserial" value="<%=orderserial%>">
							<div class="productInfo">
								<h4>주문상품정보</h4>
								<table class="baseTable">
								<caption>주문상품정보 목록</caption>
								<colgroup>
									<col width="35" /><col width="78" /><col width="70" /><col width="*" /><col width="90" /><col width="68" /><col width="90" /><col width="80" /><% If vIsPacked = "Y" Then %><col width="70" /><% End If %><col width="110" />
								</colgroup>
								<thead>
								<tr>
									<th></th>
									<th scope="col">상품코드/배송</th>
									<th scope="col" colspan="2">상품정보</th>
									<th scope="col">판매가</th>
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
									<th scope="col">반품접수</th>
								</tr>
								</thead>
								<tbody>
								<%
								packpaysum = 0
								packcnt = 0
								for i=0 to myorderdetail.FResultCount-1
									If myorderdetail.FItemList(i).FItemid <> 100 Then
										' 기존 반품 내역 조회
										Dim arr, k, strAsList, totalNo
										totalNo		= 0
										strAsList	= ""
										if (myorderdetail.FItemList(i).IsDirectReturnEnable) And returnOrderCount > 0 then
											arr = myorder.GetOrderDetailReturnASList(myorderdetail.FItemList(i).Fidx)
											If IsArray(arr) Then
												For k = 0 To UBound(arr,2)
													strAsList = strAsList & "<a href=""javascript:popCsDetail(" & arr(0,k) & ");"" class=""btn btnS2 btnGrylight""><span class=""fn"">반품 상세내역</span></a><br>"
													totalNo = totalNo + arr(3,k)	' 총반품 신청개수
												Next
											End If
										End If
									%>

									<tr>
										<td>
											<% if ((myorderdetail.FItemList(i).IsDirectReturnEnable or orderserial = "15121587559") and (myorder.FOneItem.Fsitename = "10x10" or myorder.FOneItem.Fsitename = "10x10_cs")) And CLNG(totalNo) < CLNG(myorderdetail.FItemList(i).Fitemno) and (CLNG(myorderdetail.FItemList(i).Fitemno)>0) and (Not myorder.FOneItem.IsGiftiConCaseOrder) and (Not IsChangeOrder) then %>
												<input type="checkbox" name="checkidx" id="<%= myorderdetail.FItemList(i).FisUpchebeasong %>|<%= myorderdetail.FItemList(i).FMakerid %>" value="<%= myorderdetail.FItemList(i).Fidx %>" title="반품할 상품 선택" />
											<% else %>
												<input type="checkbox" name="checkidx" id="<%= myorderdetail.FItemList(i).FisUpchebeasong %>|<%= myorderdetail.FItemList(i).FMakerid %>" value="-1" disabled title="반품할 상품 선택" />
											<% end if %>
										</td>
										<td>
											<div><%=myorderdetail.FItemList(i).FItemid%></div>
											<div><%=myorderdetail.FItemList(i).getDeliveryTypeName %></div>
										</td>
										<td><a href="javascript:ZoomItemInfo('<%= myorderdetail.FItemList(i).FItemid %>');" title="상품 자세히 보기"><img src="<%= myorderdetail.FItemList(i).FImageSmall %>" width="50" height="50" alt="<%= myorderdetail.FItemList(i).FItemName %>" /></a></td>
										<td class="lt">
											<div><a href="javascript:ZoomItemInfo('<%= myorderdetail.FItemList(i).FItemid %>');" title="상품 자세히 보기"><%= myorderdetail.FItemList(i).FItemName %></a></div>
											<% if myorderdetail.FItemList(i).FItemoptionName <> "" then %>
											<div><strong>옵션 : <%= myorderdetail.FItemList(i).FItemoptionName %></strong></div>
											<% end if %>
										</td>
										<td>
											<% if (myorderdetail.FItemList(i).IsSaleItem) then %>
												<strike><%= FormatNumber(myorderdetail.FItemList(i).Forgitemcost,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></strike><br>
												<strong class="crRed"><%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %></strong><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
											<% else %>
												<% if (myorderdetail.FItemList(i).IsItemCouponAssignedItem) then %>
												<strike><%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %></strike><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
												<% else %>
												<%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
												<% end if %>
											<% end if %>


											<% if (myorderdetail.FItemList(i).IsItemCouponAssignedItem) then %>
												<br><strong class="crGrn"><%= FormatNumber(myorderdetail.FItemList(i).FItemCost,0) %> 원</strong>
											<% else %>

											<% end if %>

											<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
	                                        <p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
	                                        <% end if %>
										</td>
										<td><%= myorderdetail.FItemList(i).FItemNo %>
											<%
												If myorderdetail.FItemList(i).FIsPacked = "Y" Then
													Response.Write "<br /><span class=""cRd0V15"">(포장상품 " & fnGetPojangItemCount(myorderdetail.FItemList(i).FOrderSerial, myorderdetail.FItemList(i).FItemid, myorderdetail.FItemList(i).FItemoption) & ")</span>"
												End If
											%>
										</td>
										<td>
											<%= FormatNumber(myorderdetail.FItemList(i).FItemCost*myorderdetail.FItemList(i).FItemNo,0) %> <%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>

											<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
	            							<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice*myorderdetail.FItemList(i).FItemNo,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
	            							<% end if %>
										</td>
										<td><%= myorderdetail.FItemList(i).GetItemDeliverStateName(myorder.FOneItem.FIpkumDiv, myorder.FOneItem.FCancelyn) %></td>
										<% If vIsPacked = "Y" Then %>
										<td>
											<%
											If myorderdetail.FItemList(i).FIsPacked = "Y" Then	'### 내가포장했는지
												Response.Write "<img src=""http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png"" alt=""상품요청상품"" />"
											End If
											%>
										</td>
										<% End If %>
										<td>
											<% if (myorderdetail.FItemList(i).IsDirectReturnEnable and (myorder.FOneItem.Fsitename = "10x10" or myorder.FOneItem.Fsitename = "10x10_cs")) and (Not myorder.FOneItem.IsGiftiConCaseOrder) and (Not IsChangeOrder) then %>
												<% if CDbl(totalNo) >= CDbl(myorderdetail.FItemList(i).Fitemno) then %>
													<em class="crRed">반품 접수 완료</em>
												<% Else %>
													<% If myorder.FOneItem.FAccountDiv="150" Then %>
														<em class="crRed">접수불가</em>
													<% Else %>
														<% if (CLNG(myorderdetail.FItemList(i).Fitemno)>0) then %>
														<em class="crMint">반품가능</em>
														<% else %>
														<em class="crRed">접수불가</em>
														<% end if %>
													<% End If %>
												<% end if %>
											<% Else %>
												<em class="crRed">접수불가</em>
											<% end if %>
											<br>
											<%=strAsList%>
										</td>
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
									<td colspan="10">
										총 결제금액 :<%=myorder.FOneItem.GetTotalOrderItemCount(myorderdetail)%>
										상품구매총액 <strong><%= FormatNumber(myorder.FOneItem.FTotalSum-myorder.FOneItem.FDeliverPrice-packpaysum,0) %></strong>원
										(상품수 <%=CHKIIF(packcnt>0,i-1,i)%>종 <%= myorder.FOneItem.GetTotalOrderItemCount(myorderdetail)-packcnt %>개)
										<%=CHKIIF(vIsPacked="Y"," + 선물포장비 " & FormatNumber(packpaysum,0) & "원","")%>
										+ 배송비 <%= FormatNumber(myorder.FOneItem.FDeliverpriceCouponNotApplied,0) %>원 <!-- 배송비 쿠폰 적용전 -->
										<% if (myorder.FOneItem.FDeliverpriceCouponNotApplied>myorder.FOneItem.FDeliverprice) then %>
										- 배송비쿠폰할인 <%= FormatNumber(myorder.FOneItem.FDeliverpriceCouponNotApplied-myorder.FOneItem.FDeliverprice,0) %>원
										<% end if %>
										<% IF (myorder.FOneItem.Fmiletotalprice<>0) then %>
										- 마일리지 <%= FormatNumber(myorder.FOneItem.Fmiletotalprice,0) %>원
										<% end if %>
										<% IF (myorder.FOneItem.Ftencardspend<>0) then %>
										- 보너스쿠폰할인 <%= FormatNumber(myorder.FOneItem.Ftencardspend,0) %>원
										<% end if %>
										<% if (myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership<>0) then %>
										- 기타할인 <%= FormatNumber((myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership),0) %>원
										<% end if %>
										= <strong class="crRed"><%= FormatNumber(myorder.FOneItem.FsubtotalPrice,0) %></strong> 원
									</td>
								</tr>
								</tfoot>
								</table>

								<div class="msg">
									<ul class="list bulletDot">
										<li><strong>반품배송비</strong>는 브랜드별로 다를 수 있습니다.</li>
										<li><strong>주문제작 상품 및 마일리지 상품</strong> 등 일부 상품은 반품이 불가합니다.</li>
										<li><strong>입점몰결제</strong> 주문은 1:1상담 또는 고객센터에서 반품접수 하실 수 있습니다.</li>
										<li><em class="fn crRed">새상품 교환은 반드시 1:1 고객센터로 문의해주시기 바랍니다.</em></li>
										<li>보너스쿠폰 중 금액할인쿠폰을 사용하여 복수의 상품을 구매 하시는 경우, 상품별 판매가에 따라 쿠폰할인금액이 각각 분할되어 적용됩니다.</li>
						                <% if (myorder.FOneItem.IsGiftiConCaseOrder) then %>
										<li><strong>기프티콘/기프팅 주문은</strong> 반품이 불가능합니다 . 1:1 상담 또는 고객센터로 문의해주세요.</li>
                           	    		<% end if %>
						                <% if IsTicketOrder then %>
										<li><strong>티켓 주문은</strong> 반품이 불가능합니다 . 1:1 상담 또는 고객센터로 문의해주세요.</li>
                           	    		<% end if %>
						                <% if myorder.FOneItem.FAccountDiv="150" then %>
										<li><strong>이니렌탈 주문은</strong> 반품을 원하실 경우 1:1 상담 또는 고객센터로 문의해주세요.</li>
                           	    		<% end if %>										   
									</ul>
								</div>
							</div>
							</form>

							<div class="btnArea ct tPad25">
								<% if myorder.FOneItem.FAccountDiv="150" then %>
									<input type="button" class="btn btnS1 btnRed btnW175" value="선택상품 반품신청" onClick="alert('이니렌탈 상품은 반품을 원하실 경우\n1:1 상담 또는 고객센터로 문의해주세요.');return;" />
								<% Else %>
									<input type="button" class="btn btnS1 btnRed btnW175" value="선택상품 반품신청" onClick="ReturnOrder(document.frmDetail);" />
								<% End If %>
								<input type="button" class="btn btnS1 btnRed btnW175" value="[새상품] 교환문의" onClick="myqnawriteWithParam('<%=orderserial%>','06','');" />
							</div>
<% end if %>
						</fieldset>
					</div>

					<div class="helpSection">
						<h4><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_help.gif" alt="도움말 HELP" /></h4>
						<ul class="list">
							<li>불량 및 파손에 의한 반품을 제외한, 고객변심에 의한 반품은 출고일로부터 7일 이후(평일기준)에는 불가합니다.</li>
							<li>상품의 배송구분에 따라 반품방식이 다르니, 이점 유의하시기 바랍니다.</li>
						</ul>

						<h5>텐바이텐 배송상품 반품절차</h5>
						<p>회수서비스를 제공하고 있습니다. 웹사이트 및 고객센터로 접수하시면, 택배기사님이 2-3일 후 방문 드립니다.</p>

						<ol class="orderProcess step3">
							<li class="receipt">
								<strong>반품접수</strong>
								<p>반품신청을 하신 후, 반품하실 상품을<br /> 받으신 상태로 재포장해주세요.</p>
							</li>
							<li class="visit">
								<strong>택배기사 방문</strong>
								<p>반품접수 후 2-3일 내에 택배기사님이<br /> 방문하여 상품을 회수합니다</p>
							</li>
							<li class="returnFinish last">
								<strong>반품완료</strong>
								<p>회수된 상품 확인 후 결제취소<br /> 또는 환불을 해드립니다.</p>
							</li>
						</ol>

						<h5>업체 배송상품 반품절차</h5>
						<p>번거로우시겠지만, <span class="crRed">개별업체로 직접 반품</span>을 해주셔야 합니다. 가능하시면 상품을 수령한 택배회사를 이용해주세요.<br /> 업체별 개별기준이 있는 경우, 해당 기준이 우선 적용 됩니다. (해당 상품의 상품페이지 참고)</p>

						<ol class="orderProcess step4">
							<li class="receipt">
								<strong>반품접수</strong>
								<p>반품신청을 하신 후,<br /> 반품하실 상품을<br /> 받으신 상태로 재포장해주세요.</p>
							</li>
							<li class="release">
								<strong>택배발송</strong>
								<p>해당 택배사로 연락 후<br /> 업체로 직접 상품을 보내주세요.</p>
							</li>
							<li class="returnIng">
								<strong>반품진행</strong>
								<p>택배 발송 후<br /> [내가 신청한 서비스]에<br /> 보내신 송장번호를 입력해주세요.</p>
							</li>
							<li class="returnFinish last">
								<strong>반품완료</strong>
								<p>반품된 상품 확인 후 결제취소<br /> 또는 환불을 해드립니다.</p>
							</li>
						</ol>
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
