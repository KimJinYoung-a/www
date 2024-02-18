<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% const MenuSelect = "02" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 주문 정보 변경"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_orderList_v1.jpg"
	strPageDesc = "구매자정보 / 배송지정보 /주문제작상품문구 등을 변경하실 수 있습니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 주문 정보 변경"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/order/order_info_edit_detail.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/inc/incForceSSL.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'' 주문 내역 변경
'' etype          [recv         , ordr          , payn        , flow          ]
''                [배송정보수정 , 주문자정보수정, 입금자명변경, 플라워정보수정]
Dim IsValidOrder : IsValidOrder = False   '''정상 주문인가.
Dim IsBiSearch   : IsBiSearch   = False   '''비회원 주문인가.
Dim IsTicketOrder : IsTicketOrder = FALSE ''티켓주문인가

dim i, pflag
dim userid, orderserial
dim etype, vIsDeliveItemExist

userid       = getEncLoginUserID()
orderserial  = requestCheckVar(request("idx"),11)
etype        = requestCheckVar(request("etype"),10)

if (orderserial = "") then
	orderserial = requestCheckVar(request("orderserial"), 11)
end if

dim myorder
set myorder = new CMyOrder

if IsUserLoginOK() then
        myorder.FRectUserID = getEncLoginUserID()
        myorder.FRectOrderserial = orderserial
        myorder.GetOneOrder
elseif IsGuestLoginOK() then
        myorder.FRectOrderserial = GetGuestLoginOrderserial()
        myorder.GetOneOrder

        IsBiSearch = True
        orderserial = myorder.FRectOrderserial
end if

dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectUserID = userid
myorderdetail.FRectOrderserial = orderserial

if myorder.FResultCount>0 then
    myorderdetail.GetOrderDetail
    IsValidOrder = True

    IsTicketOrder = myorder.FOneItem.IsTicketOrder
end if

'2020-10-20 상단 UI추가 정태훈
dim orderState
dim CurrStateCnt1 : CurrStateCnt1 = 0
dim CurrStateCnt2 : CurrStateCnt2 = 0
dim CurrStateCnt3 : CurrStateCnt3 = 0
dim CurrStateCnt4 : CurrStateCnt4 = 0
dim CurrStateCnt5 : CurrStateCnt5 = 0

if ((myorder.FOneItem.FCancelyn="Y") or (myorder.FOneItem.FCancelyn="D")) then'취소
	orderState = "E"
elseif ((myorder.FOneItem.Fjumundiv="6") or (myorder.FOneItem.Fjumundiv="9")) then'교환/반품
	orderState = "E"
else
	if (myorder.FOneItem.FIpkumDiv="0") then'결제오류
		orderState = "E"
	elseif (myorder.FOneItem.FIpkumDiv="1") then'주문실패
		orderState = "E"
	elseif (myorder.FOneItem.FIpkumDiv="2") or (myorder.FOneItem.FIpkumDiv="3") then'결제 대기 중
		orderState = "S"
	else
		orderState = "S"
		for i=0 to myorderdetail.FResultCount-1
			if (IsNull(myorderdetail.FItemList(i).Fcurrstate) or (myorderdetail.FItemList(i).Fcurrstate="0")) and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") then'결제완료
				if myorderdetail.FItemList(i).Fisupchebeasong="Y" then
					CurrStateCnt1=CurrStateCnt1+1
				else
					if (datediff("n",myorder.FOneItem.FIpkumDate,now()) >= 30) then
						CurrStateCnt2=CurrStateCnt2+1
					else
						CurrStateCnt1=CurrStateCnt1+1
					end if
				end if
			elseif myorderdetail.FItemList(i).Fcurrstate="2" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") then'상품 확인 중
				if myorderdetail.FItemList(i).Fisupchebeasong="Y" then
					CurrStateCnt2=CurrStateCnt2+1
				else
					if (datediff("n",myorder.FOneItem.Fbaljudate,now()) >= 30) then
						CurrStateCnt3=CurrStateCnt3+1
					else
						CurrStateCnt2=CurrStateCnt2+1
					end if
				end if
			elseif myorderdetail.FItemList(i).Fcurrstate="3" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") then'상품 포장 중
				CurrStateCnt3=CurrStateCnt3+1
			elseif myorderdetail.FItemList(i).Fcurrstate="7" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") and IsNull(myorderdetail.FItemList(i).Fdlvfinishdt) then'배송 시작
				CurrStateCnt4=CurrStateCnt4+1
			elseif myorderdetail.FItemList(i).Fcurrstate="7" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") and not IsNull(myorderdetail.FItemList(i).Fdlvfinishdt) then'배송 완료
				CurrStateCnt5=CurrStateCnt5+1
			end if
		next
	end if
end if

if (Not myorder.FOneItem.IsValidOrder) then
    IsValidOrder = False
    '''response.write "<script language='javascript'>alert('취소된 주문건 또는 올바른 주문이 아닙니다.');</script>"
end if

dim IsWebEditEnabled
IsWebEditEnabled = myorder.FOneItem.IsWebOrderInfoEditEnable
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
<script>
	document.ondblclick = function(event) { };  // kill dblclick

	function searchOrder(frm){
		if (frm.idx.value.length<11){
			alert('주문번호를 정확히 입력하세요.');
			frm.idx.focus();
			return;
		}

		frm.submit();
	}

	function popEditOrderInfo(orderserial,etype){
		var popwin = window.open('/my10x10/orderPopup/popEditOrderInfo.asp?orderserial=' + orderserial + '&etype=' + etype,'popEditOrderInfo','width=800,height=800,scrollbars=yes,resizable=yes');
		popwin.focus();
	}

	function popReqOrderInfo(){
		var popwin = window.open('/my10x10/orderPopup/popReqOrderInfo.asp?orderserial=' + orderserial,'popReqOrderInfo','width=800,height=800,scrollbars=yes,resizable=yes');
		popwin.focus();
	}

	function popEditOrderDetailInfo(orderserial){
		var popwin = window.open('/my10x10/orderPopup/popEditOrderDetailInfo.asp?orderserial=' + orderserial,'popEditOrderDetailInfo','width=800,height=800,scrollbars=yes,resizable=yes');
		popwin.focus();
	}

	function popCancelOrder(orderserial,flag){
		var popwin = window.open('/my10x10/orderPopup/popCancelOrder.asp?orderserial=' + orderserial + '&flag=' + flag,'popCancelOrder','width=800,height=800,scrollbars=yes,resizable=yes');
		popwin.focus();
	}

	function popEditHandMadeReq(orderserial,idx){
		var popwin = window.open('/my10x10/orderPopup/popEditHandMadeReq.asp?orderserial=' + orderserial + '&idx=' + idx,'popEditHandMadeReq','width=352,height=650,scrollbars=yes,resizable=yes');
		popwin.focus();
	}

	function editPhotolooks(orderserial, didx, itemid, itemoption, orgfile){
		var ws = screen.width * 0.8;
		var hs = screen.height * 0.8;
		var winspec = "width="+ ws + ",height="+ hs +",top=10,left=10, menubar=no,toolbar=no,scroolbars=no,resizable=yes";
		var popwin = window.open("/shopping/fuji/photolooks.asp?orderserial=" + orderserial + "&didx=" + didx + "&itemid="+ itemid +"&itemoption="+ itemoption +"&orgfile="+orgfile, "photolooks", winspec)
		popwin.focus();
	}

	function popTicketPlace(iplaceIdx){
		var popwin = window.open('/my10x10/popTicketPLace.asp?placeIdx='+iplaceIdx,'popTicketPlace','width=750,height=700,scrollbars=yes,resizable=yes');
		popwin.focus();
	}
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_info_edit.gif" alt="주문정보변경" /></h3>
						<ul class="list">
							<li>구매자정보 / 배송지정보 / 플라워주문정보 / 주문제작상품문구를 변경하실 수 있습니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<fieldset>
						<legend>주문번호 검색</legend>

							<!-- #include virtual ="/my10x10/order/inc/inc_ordersearch_box.asp" -->

<% IF IsValidOrder Then %>
							<div class="orderDetail">

								<!-- #include virtual ="/my10x10/order/inc/inc_orderbuyerinfo_box.asp" -->

								<!-- #include virtual ="/my10x10/order/inc/inc_orderpaymentinfo_box.asp" -->

								<%	'### 선물포장관련 추가
								Dim vPackTemp, vIsPacked, packpaysum, packcnt
								vPackTemp = myorder.FOneItem.IsPackItemExists(myorderdetail)
								If vPackTemp <> "" Then
									vIsPacked = "Y"
									packpaysum = Split(vPackTemp,",")(1)
									packcnt = Split(vPackTemp,",")(0)
								End IF
								%>
								<!-- #include virtual ="/my10x10/order/inc/inc_orderreceiverinfo_box.asp" -->

								<% if (myorder.FOneItem.IsRequireDetailItemExists(myorderdetail)) or (myorder.FOneItem.IsPhotoBookItemExists(myorderdetail)) then %>
								<!-- #include virtual ="/my10x10/order/inc/inc_orderhandmadeinfo_box.asp" -->
								<% End If %>

								<%'// 해외 직구 %>
								<!-- #include virtual ="/my10x10/order/inc/inc_DirectPurchase_box.asp" -->

							</div>
<% end if %>
						</fieldset>
					</div>
					<!----- 도움말 시작 ----->
					<!-- #include virtual ="/cscenter/help/help_order_info_edit_detail.asp" -->
					<!----- 도움말 끝 ----->
				</div>
				<!--// content -->
				<% if (IsValidOrder) and (Not (IsWebEditEnabled)) then %>
				<script>
					alert('주문정보 바로변경 가능 상태가 아닙니다.');
				</script>
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
set myorderdetail = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
