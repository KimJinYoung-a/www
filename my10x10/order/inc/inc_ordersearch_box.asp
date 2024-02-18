<script language='javascript'>

$(document).unbind("dblclick");

function popMyOrderNo(){
	var f = document.frmOrdSearch;
	var url = "/my10x10/orderPopup/popMyOrderNo.asp?frmname=" + f.name + "&targetname=" + f.orderserial.name;
	var popwin = window.open(url,'popMyOrderNo','width=750,height=565,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function getRecentOrder(){
    var frm = document.frmDumi;
    frm.target="FrameRctOrd";
    frm.action="/my10x10/order/inc/ifraRecentOrd.asp";
	frm.submit();
}

function goOrdSearch(iordno){
    if (iordno!=''){
    	var f = document.frmOrdSearch;
    	f.orderserial.value=iordno;
    	f.submit();
	}
}

function popSoldOutCancel(iorderserial){
    var popwin = window.open('/my10x10/orderPopup/popCancelOrder.asp?mode=so&orderserial=' + iorderserial+'','popSoldOutCancel','width=800,height=600,scrollbars=yes,resizable=yes');
    popwin.focus();
}

function popPartialCancel(iorderserial){
    var popwin = window.open('/my10x10/orderPopup/popPartialCancelOrder.asp?orderserial=' + iorderserial+'','popPartialCancel','width=1000,height=600,scrollbars=yes,resizable=yes');
    popwin.focus();
}

</script>

	<div class="searchField orderNo">
		<iframe name="FrameRctOrd" src="about:blank;" frameborder="0" width="0" height="0" ></iframe>
		<form name="frmOrdSearch" style="margin:0;">
	    <input type="hidden" name="itemid">
		<div class="word">
			<strong>주문번호</strong>
			<input type="text" name="orderserial" value="<%= orderserial %>" class="iText" />
		</div>
		<div class="option">
			<% if (Not IsBiSearch) then %>
			<a href="#" title="주문내역 검색하기" onClick="popMyOrderNo(); return false;" class="btn btnS2 btnRed" title="주문검색"><span class="fn">주문검색</span></a>
				<% if MyOrdActType <> "R" then %>
			<a href="javascript:getRecentOrder();" class="btn btnS2 btnWhite" title="최근 주문건 바로보기"><span class="fn">최근 주문건 바로보기</span></a>
          	   <% else %>
          		  &nbsp;
          	   <% end if %>
          	<% else %>
          	  &nbsp;
            <% end if %>
		</div>
		</form>
		<iframe name="FrameRctOrd" src="about:blank;" frameborder="0" width="0" height="0" ></iframe>
	</div>

	<form name="frmDumi" method="post" style="margin:0;"></form>

<% if (orderserial<>"") then %>

	<div class="serviceItem">
		<ul>
	<% IF (MyOrdActType="N") Then %>
		<% if (myorder.FOneItem.IsWebOrderInfoEditEnable) or (myorder.FOneItem.IsWebOrderCancelEnable) or (myorder.FOneItem.IsWebOrderReturnEnable) or (iRegedCsCNT>0) or ((myorder.FOneItem.Fjumundiv="9") and (myorder.FOneItem.Flinkorderserial<>"")) or ((cflag="C") and (myorder.FOneItem.Fcancelyn<>"N")) then %>
			<li>
				<span class="subtitle">신청가능한 서비스 :</span>
			<% if (myorder.FOneItem.IsWebOrderInfoEditEnable) then %>
				<a href="/my10x10/order/order_info_edit_detail.asp?idx=<%=orderserial%>" class="btn btnS2 btnGrylight btnW90" title="주문정보변경"><span class="fn">주문정보변경</span></a>
			<% end if %>
			<% if (myorder.FOneItem.IsWebOrderCancelEnable) then %>
				<a href="/my10x10/order/order_cancel_detail.asp?idx=<%=orderserial%>" class="btn btnS2 btnGrylight" title="주문취소"><span class="fn">주문취소</span></a>
			<% end if %>
			<% if myorder.FOneItem.IsWebOrderPartialCancelEnable and myorder.FOneItem.IsRequestPartialCancelEnable(myorderdetail) then %>
				<a href="/my10x10/order/order_cancel_detail.asp?idx=<%=orderserial%>" class="btn btnS2 btnGrylight" title="주문취소"><span class="fn">일부취소</span></a>
			<% end if %>
			<% if (myorder.FOneItem.IsValidOrder) and (myorder.FOneItem.IsWebStockOutItemCancelEnable) and (myorder.FOneItem.IsDirectStockOutPartialCancelEnable(myorderdetail)) then %>
				<a href="/my10x10/order/order_cancel_detail.asp?idx=<%=orderserial%>&mode=so" class="btn btnS2 btnGrylight" title="품절상품 취소"><span class="fn">품절상품 취소</span></a>
			<% end if %>
			<% if (myorder.FOneItem.IsWebOrderReturnEnable) then %>
				<a href="/my10x10/order/order_return_detail.asp?idx=<%=orderserial%>" class="btn btnS2 btnGrylight" title="반품접수"><span class="fn">반품접수</span></a>
			<% end if %>
				<a href="javascript:myqnawriteWithParam('<%=orderserial%>','','');" class="btn btnS2 btnRed" title="1:1 상담 신청하기"><span class="fn">1:1 상담 신청하기</span></a>
			</li>
		<% end if %>
		<% if (iRegedCsCNT>0) then %>
			<li>
				<span class="subtitle">등록된 서비스 조회 :</span>
				<a href="/my10x10/order/order_cslist.asp?orderSerial=<%= orderserial %>" class="btn btnS2 btnGrylight" title="등록된 서비스 조회 페이지로 이동"><span class="fn gryArr01">바로가기</span></a>
			</li>
		<% end if %>
		<% if (myorder.FOneItem.Fjumundiv="9") and (myorder.FOneItem.Flinkorderserial<>"") Then %>
			<li>
				<span class="subtitle originalNo">관련 원 주문번호 :</span>
				<a href="Javascript:goOrdSearch('<%= myorder.FOneItem.FLinkorderserial %>');" class="btn btnS2 btnGrylight" title="관련 원 주문번호 조회 페이지로 이동"><span class="fn gryArr01">바로가기</span></a>
				(원주문번호 : <%= myorder.FOneItem.Flinkorderserial %>)
			</li>
		<% end if %>
		<% if (cflag="C") and (myorder.FOneItem.Fcancelyn<>"N") then %>
			<li>
				<span class="subtitle">취소 된 주문건입니다.</span>
			</li>
		<% end if %>
	<% elseIF (MyOrdActType="E") Then %>
			<li>
				<span class="subtitle">변경가능여부 :</span>
		<% if (myorder.FOneItem.IsWebOrderInfoEditEnable) then %>
				<strong class="cr777">고객님이 직접 주문자정보 / 결제정보 / 배송지정보 수정이 가능합니다.</strong>
		<% elseif (myorder.FOneItem.IsWebOrderInfoEditRequirable) then %>
				<strong class="cr777">1:1상담요청을 통해 변경요청을 해주시면, 변경가능여부를 확인 후, 고객님께 안내해드리겠습니다.</strong>
				<a href="javascript:myqnawriteWithParam('<%= myorder.FOneItem.FOrderSerial %>','01','');" class="btn btnS2 btnRed" title="1:1 상담 신청하기"><span class="fn">1:1 상담 신청하기</span></a>
        <% else %>
				<strong class="cr777">상품이 출고되어, 주문정보 변경이 불가능합니다.</strong>
		<% end if %>
			</li>
		<% if (myorder.FOneItem.IsRequireDetailItemExists(myorderdetail)) or (myorder.FOneItem.IsPhotoBookItemExists(myorderdetail)) then %>
			<li>
				<strong class="cr777">
					* 주문제작상품의 문구 및 정보 변경은 하단 주문제작상품리스트에서 상품별로 확인하시기 바랍니다.
				</strong>
			</li>
		<% end if %>
			<li>
				<span class="subtitle">변경가능정보 :</span>
		<% if (IsWebEditEnabled) then %>
				<a href="javascript:popEditOrderInfo('<%= orderserial %>','ordr');" title="구매자 정보변경" class="btn btnS2 btnGrylight btnW90"><span class="fn">구매자 정보변경</span></a>
			<% if (myorder.FOneItem.IsReceiveSiteOrder) then %>
				<a href="javascript:popEditOrderInfo('<%= orderserial %>','recv');" title="수령인 정보변경" class="btn btnS2 btnGrylight btnW90"><span class="fn">수령인 정보변경</span></a>
			<% else %>
				<a href="javascript:popEditOrderInfo('<%= orderserial %>','recv');" title="배송지 정보변경" class="btn btnS2 btnGrylight btnW90"><span class="fn">배송지 정보변경</span></a>
			<% end if %>
			<% if Not IsNull(myorder.FOneItem.Freqdate) and Not(myorder.FOneItem.IsReceiveSiteOrder) then %>
				<a href="javascript:popEditOrderInfo('<%= orderserial %>','flow');" title="플라워 주문정보 변경" class="btn btnS2 btnGrylight"><span class="fn">플라워 주문정보 변경</span></a>
			<% end if %>
		<% end if %>
		<% if (myorder.FOneItem.IsEditEnable_AccountName) then %>
				<a href="javascript:popEditOrderInfo('<%= orderserial %>','payn');" title="결제방법 변경" class="btn btnS2 btnGrylight"><span class="fn">결제방법 변경</span></a>
		<% end if %>
			</li>
	<% elseIF (MyOrdActType="C") Then %>
	<!-- 주문취소 start -->
			<li>
				<span class="subtitle">취소가능여부 :</span>
				<% if (myorder.FOneItem.IsWebOrderCancelEnable) then %>
				<strong class="cr000">고객님이 직접 주문취소가 가능합니다. 일부취소를 원하시는 경우, 고객센터로 문의 부탁드립니다.</strong>
				<% elseif (myorder.FOneItem.IsWebOrderCancelRequirable) then %>
				<strong class="cr000">1:1상담요청을 통해 취소요청을 해주시면, 취소가능여부를 확인 후 고객님께 안내해드리겠습니다.</strong>
				<% else %>
				<strong class="cr000">주문취소가 불가능합니다.</strong>
				<% end if %>
				<div class="cancelInfo">
					<p>- <strong class="crRed">상품 일부만 취소</strong>하고자 하시는 경우, [1:1 상담] 또는 [고객센터]로 문의주시기 바랍니다</p>
					<p>- <strong class="crRed">상품준비중</strong>인 상품의 경우, [1:1 상담] 또는 [고객센터]를 통해 취소가 가능하며,<br /> 고객센터에서 출고여부를 확인 후에 취소여부를 안내해드립니다.</p>
					<p>- 이미 <strong class="crRed">출고된 상품</strong>이 있는 경우 주문을 취소할 수 없습니다. 반품 메뉴를 이용하시기 바랍니다.</p>
					<% if (myorder.FOneItem.IsGiftiConCaseOrder) then %>
					<p>- <strong class="crRed">기프티콘/기프팅 주문은</strong> 취소가 불가능합니다. [1:1 상담] 또는 [고객센터]로 문의주시기 바랍니다</p>
					<% end if %>
				</div>
			</li>
			<li>
				<span class="subtitle">빠른 서비스 :</span>
				<% if (myorder.FOneItem.IsWebOrderCancelEnable) then %>
				<a href="javascript:popCancel('<%= myorder.FOneItem.FOrderSerial %>');" class="btn btnS2 btnGrylight" title="전체취소"><span class="fn">전체취소</span></a>
				<% end if %>
				<% if myorder.FOneItem.IsWebOrderPartialCancelEnable and myorder.FOneItem.IsRequestPartialCancelEnable(myorderdetail) then %>
				<a href="javascript:popPartialCancel('<%= myorder.FOneItem.FOrderSerial %>');" class="btn btnS2 btnGrylight" title="일부취소"><span class="fn">일부취소</span></a>
				<% end if %>
				<% if (myorder.FOneItem.IsValidOrder) and (myorder.FOneItem.IsWebStockOutItemCancelEnable) and (myorder.FOneItem.IsDirectStockOutPartialCancelEnable(myorderdetail)) then %>
				<a href="javascript:popSoldOutCancel('<%= myorder.FOneItem.FOrderSerial %>');" class="btn btnS2 btnGrylight" title="품절상품 취소"><span class="fn">품절상품 취소</span></a>
				<% end if %>
				<a href="javascript:myqnawriteWithParam('<%= myorder.FOneItem.FOrderSerial %>','04','');" class="btn btnS2 btnRed" title="1:1 상담 신청하기"><span class="fn">1:1 상담 신청하기</span></a>
			</li>
	<!-- 주문취소 end -->
	<% elseif (MyOrdActType = "R") Then %>
	<!-- 내용없음 -->
	<% end if %>
		</ul>
	</div>

<% end if %>
