<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% const MenuSelect = "04" %>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/header.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->

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

Dim IsWebEditEnabled
IsWebEditEnabled = (MyOrdActType = "E")

'네비바 내용 작성
strMidNav = "MY 쇼핑리스트 > <b>반품 / 교환</b>"
%>

<script language='javascript'>
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

    var popwin=window.open('','popReturnOrder','width=775,height=600,scrollbars=yes,resizable=yes');
    frm.target = "popReturnOrder";
    frm.action = "/my10x10/orderPopup/popReturnOrder.asp";
    frm.submit();
    popwin.focus();
}

function ChangeOrder(frm){
    if (!IsCheckedItem(frm)){
        alert('선택 상품이 없습니다. 먼저 반품하실 상품을 선택하세요.');
        return;
    }

    //브랜드별로(반송처) 따로 접수하도록 체크
    if (!IsAvailReturnValid(frm)){
        return;
    }

    var popwin=window.open('','popReturnOrder','width=775,height=600,scrollbars=yes,resizable=yes');
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
			        alert('업체배송 상품을 반품 또는 교환하실 경우 브랜드별(입점업체별)로 - 따로 신청해 주시기 바랍니다.');
	                return false;
			    }
			    pBrand = e.id.substring(1,32);
			}
		}
	}

	if ((tenBExists==true)&&(upBExists==true)){
	    alert('텐바이텐배송상품과 업체배송상품을 같이 반품 또는 교환신청 하실 수 없습니다. - 따로 신청해 주시기 바랍니다.');
	    return false;
	}

	return true;
}

function IsAvailChangeValid(frm){
	var arrcheckidx = document.getElementsByName("checkidx");
	var arritemoption = document.getElementsByName("itemoption");
	var arrlimityn = document.getElementsByName("limityn");

	for (var i = 0;i < arrcheckidx.length; i++) {
		if (arrcheckidx[i].checked == true) {
			if (arrlimityn[i].value == "Y") {
				alert("한정상품은 고객센터에서 재고를 확인후 ");
			}
		}
	}





    for (var i=0;i<frm.elements.length;i++){
		var e = frm.elements[i];

		if ((e.type=="checkbox")&&(e.checked==true)) {
			if (e.id.substring(0,1)=="N"){
			    tenBExists = true;
			}else{
			    upBExists = true;

			    if ((pBrand!="")&&(pBrand!=e.id.substring(1,32))){
			        alert('업체배송 상품을 반품 또는 교환하실 경우 브랜드별(입점업체별)로 - 따로 신청해 주시기 바랍니다.');
	                return false;
			    }
			    pBrand = e.id.substring(1,32);
			}
		}
	}

	if ((tenBExists==true)&&(upBExists==true)){
	    alert('텐바이텐배송상품과 업체배송상품을 같이 반품 또는 교환신청 하실 수 없습니다. - 따로 신청해 주시기 바랍니다.');
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


<table border="0" align="center" cellpadding="0" cellspacing="0">
  	<tr>
	    <td width="960">
			<!----- 마이텐바이텐 타이틀 시작 ----->
			<!-- #include virtual ="/lib/topMenu/top_my10x10.asp" -->
			<!----- 마이텐바이텐 타이틀 끝 ----->
		    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="mar_top_20px">
		      	<tr>
		        	<td>
		        		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		          			<tr>
		            			<td width="180" valign="top" style="padding-right:20px">
		            			<!----- 레프트 시작 ----->
					            <!-- #include virtual ="/lib/leftmenu/left_my10x10.asp" -->
					            <!----- 레프트 끝 ----->
	            				</td>

	            				<!----- 반품신청 시작 ----->
	            				<td width="780" valign="top">
						            <table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
											<!-- My10x10 메뉴 -->
											<!-- #include virtual ="/lib/topmenu/Menu_my10x10.asp" -->
											</td>
										</tr>
										<tr>
	                						<td class="pdd_top_20px" style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2010/mytenbyten/title_main04.gif"></td>
	              						</tr>
	              						<tr>
	                						<td class="gray_11px_line" style="line-height:16px;padding-bottom:10px">
	                							<span class="red_11px">상품출고일 기준으로 15일 이내에 반품 / 교환 가능합니다.</span><br>
												반품을 원하시는 상품이 포함된 주문의 주문번호나 [반품접수] 버튼을 클릭해주시면, 상세정보에서 반품등록이 가능합니다.<br />
											  	이미 접수하신 반품(교환) 신청은 [내가 신청한 서비스]에서도 확인하실 수 있습니다.
	                  						</td>
	              						</tr>
										<tr>
	                						<td>
                                        <!-- #include virtual ="/my10x10/order/inc/inc_ordersearch_box.asp" -->
											</td>
	              						</tr>
<% if (IsValidOrder) then %>
	                					<!----- 주문리스트 시작 ----->

	             	 					<tr >
							                <td style="padding-top:25px;padding-bottom:25px">
												<form name="frmDetail" method="post" action="">
												<input type="hidden" name="orderserial" value="<%=orderserial%>">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
								                      	<td style="padding-bottom:7px"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/ordercancelinfo_title.gif" width="105" height="17"></td>
								                    </tr>
								                    <tr bgcolor="#fcf6f6">
								                      	<td height="30" style="border-top:3px solid #be0808;border-bottom:1px solid #eaeaea;padding-top:3px;">
								                      		<table width="100%" border="0" cellspacing="0" cellpadding="0">
									                          	<tr>
										                            <td width="20" align="center">&nbsp;</td>
										                            <td width="70" align="center" style="padding-left:5px;">상품</td>
										                            <td width="95" align="center">상품코드/배송</td>
										                            <td align="center">상품명 [옵션]</td>
										                            <td width="75" align="center">판매가</td>
										                            <td width="30" align="center">수량</td>
										                            <td width="75" align="center">소계금액</td>
										                            <td width="60" align="center">주문상태</td>
										                            <td width="95" align="center">비고</td>
									                          	</tr>
								                      		</table>
								                      	</td>
								                    </tr>

												<% for i=0 to myorderdetail.FResultCount-1 %>
													<%
													' 기존 반품 내역 조회
													Dim arr, k, strAsList, totalNo
													totalNo		= 0
													strAsList	= ""
													if (myorderdetail.FItemList(i).IsDirectReturnEnable) And returnOrderCount > 0 then
														arr = myorder.GetOrderDetailReturnASList(myorderdetail.FItemList(i).Fidx)
														If IsArray(arr) Then
															For k = 0 To UBound(arr,2)
																strAsList = strAsList & "<a href=""javascript:popCsDetail(" & arr(0,k) & ");"" ><img src=""http://fiximage.10x10.co.kr/web2009/mytenbyten/btn_returnlist.gif""  border=""0""></a><br>"
																totalNo = totalNo + arr(3,k)	' 총반품 신청개수
															Next
														End If
													End If
													%>
								                    <tr>
								                      	<td height="78" style="border-bottom:1px solid #eaeaea;">
								                      		<table width="100%" border="0" cellspacing="0" cellpadding="0">
								                          		<tr>
																	<td width="20" align="center" valign="middle" style="padding:0 5 0 5">
																		<% if (myorderdetail.FItemList(i).IsDirectReturnEnable and myorder.FOneItem.Fsitename = "10x10") And CLNG(totalNo) < CLNG(myorderdetail.FItemList(i).Fitemno) and (CLNG(myorderdetail.FItemList(i).Fitemno)>0) and (Not myorder.FOneItem.IsGiftiConCaseOrder) and (Not IsChangeOrder) then %>
																			<input type="checkbox" name="checkidx" id="<%= myorderdetail.FItemList(i).FisUpchebeasong %>|<%= myorderdetail.FItemList(i).FMakerid %>" value="<%= myorderdetail.FItemList(i).Fidx %>">
																		<% else %>
																			<input type="checkbox" name="checkidx" id="<%= myorderdetail.FItemList(i).FisUpchebeasong %>|<%= myorderdetail.FItemList(i).FMakerid %>" value="<%= myorderdetail.FItemList(i).Fidx %>" disabled >
																		<% end if %>
																	</td>
																	<input type="hidden" name="itemoption" value="<%= myorderdetail.FItemList(i).Fitemoption %>">
																	<input type="hidden" name="limityn" value="<%= myorderdetail.FItemList(i).Flimityn %>">
																	<td width="70" align="center" style="padding-left:5px;"><a href="javascript:ZoomItemPop(<%= myorderdetail.FItemList(i).FItemid %>,'new');" onFocus="blur()"><img src="<%= myorderdetail.FItemList(i).FImageSmall %>" width="50" height="50"></a></td>
										                            <td width="95" align="center" style="padding-top:3px;line-height:17px;">
																		<%= myorderdetail.FItemList(i).FItemid %>
																		<br>
																		<% if myorderdetail.FItemList(i).Fisupchebeasong="N" then %>
																			텐바이텐
																		<% elseif myorderdetail.FItemList(i).Fisupchebeasong="Y" then %>
																			<font color="red"><%= myorderdetail.FItemList(i).getDeliveryTypeName %></font>
																		<% end if %>
																	</td>
								                            		<td style="padding:3px 0 0 5px;line-height:17px;">

																		<% if (myorderdetail.FItemList(i).Flimityn = "Y") then %>
																			<font color=purple>[한정]</font>
																		<% end if %>
																		<span class="brandname">[<%= myorderdetail.FItemList(i).Fbrandname %>]</span><br>
																		<a href="javascript:ZoomItemPop(<%= myorderdetail.FItemList(i).FItemid %>,'new');" class="link_ctleft">
																		<%= myorderdetail.FItemList(i).FItemName %>
																		</a>
																		<br>
																		<% if myorderdetail.FItemList(i).FItemoptionName<>"" then %>
																		<font color="blue">[<%= myorderdetail.FItemList(i).FItemoptionName %>]</font>
																		<% end if %>
																	</td>
										                            <td width="75" align="center" style="padding-top:3px;"><%= FormatNumber(myorderdetail.FItemList(i).FItemCost,0) %>원</td>
										                            <td width="30" align="center" style="padding-top:3px;"><%= myorderdetail.FItemList(i).FItemNo %></td>
										                            <td width="75" align="center" style="padding-top:3px;"><%= FormatNumber((myorderdetail.FItemList(i).FItemCost * myorderdetail.FItemList(i).FItemNo),0) %>원</td>
										                            <td width="60" align="center" style="padding-top:3px;"><%= myorderdetail.FItemList(i).GetItemDeliverStateName(myorder.FOneItem.FIpkumDiv, myorder.FOneItem.FCancelyn) %></td>
										                            <td width="100" align="center" style="padding-top:3px;line-height:17px;">
																		<% if (myorderdetail.FItemList(i).IsDirectReturnEnable and myorder.FOneItem.Fsitename = "10x10") and (Not myorder.FOneItem.IsGiftiConCaseOrder) and (Not IsChangeOrder) then %>
																			<% if CDbl(totalNo) >= CDbl(myorderdetail.FItemList(i).Fitemno) then %>
																				<span class="link_gray_11px_line">반품(교환) 접수완료</span>
																			<% Else %>
																			    <% if (CLNG(myorderdetail.FItemList(i).Fitemno)>0) then %>
																			    	<font color="#004000">반품접수 가능</font><br>
																			    	<% if (myorderdetail.FItemList(i).Flimityn = "Y") then %>
																			    		교환접수 불가
																			    	<% else %>
																			    		<font color="#004000">교환접수 가능</font>
																			    	<% end if %>
																				<% else %>
																				<font color="red">접수불가</font>
																				<% end if %>
																			<% end if %>
																		<% Else %>
																			<font color="red">접수불가</font>
																		<% end if %>
																		<br>
																		<%=strAsList%>
																	</td>
																</tr>
								                      		</table>
								                      	</td>
								                    </tr>
												<% next %>
												</form>

								                   <tr>
                                                  	<td height="50" colspan="6" style="border-bottom:1px solid #eaeaea;" align="right">
                                            		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eaeaea">
                                                      <tr>
                                                        <td bgcolor="#FFFFFF" style="border:3px solid #f3f3f3;">
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                          <tr>
                                                            <td style="padding-right:10px;padding-left:10px;">
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                              <tr>
                                                                <td align="right" style="padding:10px 5px 10px 5px;">
                                                                <table border="0" cellspacing="0" cellpadding="0">
                                                                  <tr>
                                                                    <td style="padding-left:30px;" class="gray888_12px">주문상품수 <strong><%= i %>종 (<%= FormatNumber(myorder.FOneItem.GetTotalOrderItemCount(myorderdetail),0) %>개)</strong></td>
                                                                    <td style="padding-left:30px;" class="gray888_12px">적립 마일리지 <strong><%= FormatNumber(myorder.FOneItem.Ftotalmileage,0) %></strong> Point</td>
                                                                    <td style="padding-left:30px;" class="gray888_12px">상품구매총액 <strong><%= FormatNumber(myorder.FOneItem.FTotalSum-myorder.FOneItem.FDeliverPrice,0) %></strong> 원</td>
                                                                  </tr>
                                                                </table></td>
                                                              </tr>
                                                              <tr height="1">
                                                                <td height="1" bgcolor="#eaeaea"></td>
                                                              </tr>
                                                              <tr>
                                                                <td align="right" style="padding:10px 5px 10px 5px;" class="black_12px">
                                                                총결제금액 :
                                                				상품구매총액 <%= FormatNumber((myorder.FOneItem.FTotalSum-myorder.FOneItem.FDeliverPrice),0) %>원
                                                				+ 배송비 <%= FormatNumber(myorder.FOneItem.FDeliverpriceCouponNotApplied,0) %>원 <!-- 쿠폰 적용전 배송비 -->
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
                                                				=
                                                				<span class="red_12px_bold"><%= FormatNumber(myorder.FOneItem.FsubtotalPrice,0) %></span> 원
                                                                </td>
                                                              </tr>
                                                            </table></td>
                                                          </tr>
                                                        </table></td>
                                                      </tr>
                                                    </table>
                                            		</td>
                                                </tr>
	                							</table>
											</td>
	              						</tr>
	                					<!----- 주문리스트 끝 ----->
										<tr>
						                	<td height="" class="red_11px">
						                		* <b>주문제작</b> 상품 및 <b>마일리지 상품</b>등 일부 상품은 반품이 불가합니다.<br>
						                		* <b>입점몰결제</b> 주문은 1:1 상담 또는 고객센터에서 반품접수하실수 있습니다.<br>
						                		<!--
						                		* <b>새상품 맞교환</b>은 반드시 1:1 고객센터로 문의해주시기 바랍니다<br>
						                		-->
						                		<a href="javascript:myqnawriteWithParam('<%=orderserial%>','06','');" onFocus="this.blur();" ><img src="http://fiximage.10x10.co.kr/web2011/mytenbyten/btn_1to1.gif" width="88" height="27" border="0" align="absmiddle"></a>


						                		<% if (myorder.FOneItem.IsGiftiConCaseOrder) then %>
                                   	    		<br>* <span class="red_11px">기프티콘/기프팅 주문은</span> 반품이 불가능합니다 . 1:1 상담 또는 고객센터로 문의해주세요.
                                   	    		<% end if %>
						                	</td>
										</tr>
										<tr>
											<td height="80" align="center">
                                                <table width="70%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td>
														<a href="javascript:ReturnOrder(document.frmDetail);" onFocus="this.blur();">
															<img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/btn_return02.gif" width="127" height="36" border="0">
														</a>
                                                	</td>
                                                    <td>
														<a href="javascript:ChangeOrder(document.frmDetail);" onFocus="this.blur();">
															<img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/btn_return02.gif" width="127" height="36" border="0">
															교환신청(동일상품)
														</a>
                                                	</td>
                                                    <td>
														<a href="javascript:ChangeOptionOrder(document.frmDetail);" onFocus="this.blur();">
															<img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/btn_return02.gif" width="127" height="36" border="0">
															교환신청(옵션변경)
														</a>
                                                	</td>
                                                  </tr>
                                                </table>
											</td>
										</tr>
<% end if %>


                                        <% if IsTicketOrder then %>

											    <!-- #include virtual ="/cscenter/help/help_order_refundTicket.asp" -->

                                        <% else %>

												<!----- 도움말 시작 ----->
												<!-- #include virtual ="/cscenter/help/help_return_detail.asp" -->
												<!----- 도움말 끝 ----->

										<% end if %>
	            					</table>
	            				</td>
	            				<!----- 반품신청 끝 ----->
	          				</tr>
	        			</table>
	        		</td>
	      		</tr>
	    	</table>
	    </td>
	</tr>
</table>


<%
set myorder = Nothing
set myorderdetail = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/tailer.asp" -->
