<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/cscenter/lib/csfrontfunction.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 내가 신청한 서비스 상세내역"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

dim i, lp, refunding, editrebankaccount

dim userid
userid = getEncLoginUserID

dim CsAsID
CsAsID = request("CsAsID")

'==============================================================================
dim mycslist
set mycslist = new CCSASList
mycslist.FRectCsAsID = CsAsID

if IsUserLoginOK() then
    mycslist.FRectUserID = getEncLoginUserID()
    mycslist.GetOneCSASMaster
elseif IsGuestLoginOK() then
    mycslist.FRectOrderserial = GetGuestLoginOrderserial()
    mycslist.GetOneCSASMaster
end if

If mycslist.FResultCount = 0 Then
	Response.Write "<script>alert('처리된 서비스번호 입니다.');</script>"
	dbget.close()
	Response.End
End If

if (mycslist.FOneItem.Fencmethod = "PH1") or (mycslist.FOneItem.Fencmethod = "AE2") then
	mycslist.FOneItem.Frebankaccount = (mycslist.FOneItem.FdecAccount)
end if

IF IsNULL(mycslist.FOneItem.Frebankaccount) then mycslist.FOneItem.Frebankaccount=""
editrebankaccount = mycslist.FOneItem.Frebankaccount
IF (Len(mycslist.FOneItem.Frebankaccount)>7) then mycslist.FOneItem.Frebankaccount=Left(mycslist.FOneItem.Frebankaccount,Len(Trim(mycslist.FOneItem.Frebankaccount))-3) + "***"

'==============================================================================
dim mycsdetail, iscanceled

set mycsdetail = new CCSASList
mycsdetail.FRectUserID = userid
mycsdetail.FRectCsAsID = CsAsID

if (CsAsID<>"") then
    ''mycsdetail.GetOneCSASMaster
    ''2015/07/15 수정.. 두번 쿼리?..
    if IsUserLoginOK() then
        mycsdetail.FRectUserID = getEncLoginUserID()
        mycsdetail.GetOneCSASMaster
    elseif IsGuestLoginOK() then
        mycsdetail.FRectOrderserial = GetGuestLoginOrderserial()
        mycsdetail.GetOneCSASMaster
    end if

    iscanceled = "N"
    if (mycsdetail.FResultCount < 1) then
    	iscanceled = "Y"
    end if
end if



'==============================================================================
dim mycsdetailitem
set mycsdetailitem = new CCSASList
mycsdetailitem.FRectUserID = userid
mycsdetailitem.FRectCsAsID = CsAsID
mycsdetailitem.FRectOrderserial = mycsdetail.FoneItem.ForderSerial
if (CsAsID<>"") then
	mycsdetailitem.GetCsDetailList
end if



'==============================================================================
Dim detailDeliveryName, detailSongjangNo, detailDeliveryTel
if (mycsdetailitem.FResultCount > 0) then
    for i=0 to mycsdetailitem.FResultCount-1
        if mycsdetailitem.FItemList(i).Fitemid <> 0 and Not IsNull(mycsdetailitem.FitemList(i).FsongjangNo) then
			detailDeliveryName	= mycsdetailitem.FitemList(i).FDeliveryName
			detailSongjangNo	= mycsdetailitem.FitemList(i).FsongjangNo
			detailDeliveryTel	= mycsdetailitem.FitemList(i).FDeliveryTel
		end if
	next
end if

dim beasongpaysum, itemcostsum, itemcount, itemtotalcount, packpaysum

dim returnmakerididx
returnmakerididx = 0

if (iscanceled = "Y") then
	response.write "<script>alert('삭제된 CS 내역입니다.');opener.focus(); window.close();</script>"
	response.end
end if

dim OReturnAddr, vIsPacked
vIsPacked = fnExistPojang(mycsdetail.FoneItem.ForderSerial,"")

dim isNaverPay
isNaverPay = (fnGetPgGubun(mycslist.FoneItem.Forderserial)="NP")
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="javascript" src="/lib/js/confirm.js"></script>
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

function popSongjang()
{
	var url = "/my10x10/orderPopup/popSongjang.asp?asid=<%=CsAsID%>&songjangDiv=<%=mycslist.FoneItem.FsongjangDiv%>&songjangNo=<%=mycslist.FoneItem.FsongjangNo%>&sendSongjangNo=<%= detailSongjangNo %>";
	var popwin = window.open(url,'popSongjang','width=440,height=360,scrollbars=no,resizable=no');
	popwin.focus();
}

function goCSASdelete()
{
	if(confirm("반품 신청하신 것을 철회하시겠습니까?") == true) {
		document.csfrm.mode.value = "delete";
		document.csfrm.submit();
	}
}

function CheckNSubmit(frm){
	if (frm.rebankname.value==""){
		alert("[환불 계좌 은행]을(를) 선택해주세요");
		frm.rebankname.focus();
	}
	else{
		if (validate(frm)){
			if (confirm('수정 하시겠습니까?')){
				frm.submit();
			}
		}
	}
}
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_service_detail.gif" alt="내가 신청한 서비스 상세내역" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<div class="guidanceMsg">
						<ul class="list">
							<li>고객님이 신청하신 서비스 상세내역입니다.</li>
							<li>상품반품/회수 또는 맞교환상품 발송 시 출력하여 동봉하여 주시면, 빠른 처리가 가능합니다.</li>
						</ul>
					</div>

					<div class="productInfo">
						<h2>기본정보 - <%= mycsdetail.FoneItem.FopenTitle %></h2>
						<table class="baseTable rowTable">
						<caption>기본정보</caption>
						<colgroup>
							<col width="120" /> <col width="300" /> <col width="120" /> <col width="*" />
						</colgroup>
						<tbody class="fs12">
						<tr>
							<th scope="row">서비스 코드</th>
							<td class="lt"><strong><%= mycsdetail.FoneItem.Fid%> <span>[<%= mycsdetail.FoneItem.GetCurrstateName %>]</span></strong></td>
							<th scope="row">주문번호</th>
							<td class="lt"><%=mycsdetail.FoneItem.ForderSerial%></td>
						</tr>
						<tr>
							<th scope="row">접수일시</th>
							<td class="lt"><%= Replace(mycsdetail.FoneItem.FregDate, "-", "/") %></td>
							<th scope="row">접수사유</th>
							<td class="lt"><%=mycsdetail.FoneItem.Fgubun02name%></td>
						</tr>
						<tr>
							<th scope="row">접수내용</th>
							<td colspan="3" class="lt"><%=mycsdetail.FoneItem.FopenTitle%></td>
						</tr>
						<%
						if (mycsdetail.FOneItem.Fdivcd = "A111") then
							'// 상품변경 맞교환회수(텐바이텐배송)
						%>
						<tr>
							<th scope="row">고객추가배송비</th>
							<td class="lt">
								<% if (Not IsNull(mycsdetail.FoneItem.Faddbeasongpay)) then %>
									<%= FormatNumber(mycsdetail.FoneItem.Faddbeasongpay, 0)%> 원
								<% end if %>
							</td>
							<th scope="row">부담방법</th>
							<td class="lt"><%= mycsdetail.FoneItem.GetCustomerBeasongPayAddMethod %></td>
						</tr>
						<% end if %>
						<% if (InStr("A000,A001,A002,A004,A010,A011,A012,A111,A112", mycsdetail.FOneItem.Fdivcd) > 0) then %>
						<tr>
							<th scope="row">관련 운송장 번호</th>
							<td colspan="3" class="lt">
								<% if (InStr("A004,A012,A112", mycsdetail.FOneItem.Fdivcd) > 0) then %>
									<%= mycsdetail.FoneItem.FsongjangDivName%>&nbsp;<%= mycsdetail.FoneItem.FsongjangNo%>
									<% If mycsdetail.FoneItem.Fcurrstate < "B007" Then %>
									<a href="javascript:popSongjang();" class="btn btnS2 btnGry lMar10" title="반품 운송장번호 등록하기"><span class="whiteArr01 fn">반품 운송장번호 등록하기</span></a>
									<% end if %>
								<% else %>
									<% if (Not IsNULL(mycsdetail.FoneItem.FsongjangNo)) and (mycsdetail.FoneItem.FsongjangNo<>"") then %>
										<%= CsDeliverDivCd2Nm(mycsdetail.FoneItem.FsongjangDiv) %>
										<%= mycsdetail.FoneItem.FsongjangNo %>
										<% if (CsDeliverDivCd2Nm(mycsdetail.FoneItem.FsongjangDiv) <> "") and (CsDeliverDivTrace(mycsdetail.FoneItem.FsongjangDiv) <> "") then %>
											&nbsp;&nbsp;
											<a href="<%= CsDeliverDivTrace(mycsdetail.FoneItem.FsongjangDiv) %><%= mycsdetail.FoneItem.FsongjangNo %>" target="_blank" class="btn btnS2 btnGry lMar10" title="배송 조회하기"><span class="whiteArr01 fn">조회하기</span></a>
										<% end if %>
									<% else %>
										등록된 운송장 정보가 없습니다.
									<% end if %>
								<% end if %>
							</td>
						</tr>
						<% end if %>
						<%
						if (mycsdetail.FoneItem.Fcurrstate = "B007") then
							if mycsdetail.FOneItem.Ffinishdate<>"" then
						%>
						<tr>
							<th scope="row"><strong>처리일시</strong></th>
							<td colspan="3" class="lt"><strong><%= mycsdetail.FOneItem.Ffinishdate %></strong></td>
						</tr>
						<%
							end if
							if mycsdetail.FOneItem.Fopencontents<>"" then
						%>
						<tr>
							<th scope="row"><strong>처리내용</strong></th>
							<td colspan="3" class="lt">
								<div><strong><%= Replace(mycsdetail.FOneItem.Fopencontents, vbCrLf, "</strong></div> <div><strong>") %></strong></div>
							</td>
						</tr>
						<%
							end if
						%>
						<% end if %>
						</tbody>
						</table>

						<% if (InStr("A004,A010", mycsdetail.FOneItem.Fdivcd) > 0) and (mycsdetail.FoneItem.Fcurrstate < "B007") then %>
						<div class="btnArea ct tPad25">
							<a href="javascript:goCSASdelete()" class="btn btnS1 btnRed btnW160" title="반품철회">반품철회</a>
						</div>
						<% end if %>
					</div>

					<div class="etcInfo">

					<% if mycsdetailitem.FResultCount > 0 then %>
						<!----- 등록상품정보 시작 ----->
						<h2>접수상품 정보</h2>
						<table class="baseTable">
						<caption>접수상품정보 목록</caption>
						<colgroup>
							<col width="100" /><col width="70" /><col width="*" /><col width="90" /><col width="50" /><col width="100" /><% If vIsPacked = "Y" Then %><col width="75" /><% End If %>
						</colgroup>
						<thead>
						<tr>
							<th scope="col">상품코드/배송</th>
							<th scope="col" colspan="2">상품정보</th>
							<th scope="col">판매가</th>
							<th scope="col">수량</th>
							<th scope="col">소계금액</th>
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
						beasongpaysum = 0
						itemcostsum = 0
						itemcount = 0
						itemtotalcount = 0
						packpaysum = 0

                		for i=0 to mycsdetailitem.FResultCount-1
                			if mycsdetailitem.FItemList(i).Fitemid = 0 then
                				beasongpaysum = beasongpaysum + mycsdetailitem.FItemList(i).FItemCost * mycsdetailitem.FItemList(i).Fconfirmitemno
                			elseif mycsdetailitem.FItemList(i).Fitemid = 100 then
                				packpaysum = packpaysum + mycsdetailitem.FItemList(i).FItemCost * mycsdetailitem.FItemList(i).Fconfirmitemno
                			else
                				itemcostsum = itemcostsum + mycsdetailitem.FItemList(i).FItemCost * mycsdetailitem.FItemList(i).Fconfirmitemno
								itemcount = itemcount + 1
								itemtotalcount = itemtotalcount + mycsdetailitem.FItemList(i).Fconfirmitemno
                				returnmakerididx = i
                			end if

							if mycsdetailitem.FItemList(i).Fitemid <> 0 and mycsdetailitem.FItemList(i).Fitemid <> 100 Then
                		%>
						<tr>
							<td>
								<div><%=mycsdetailitem.Fitemlist(i).FitemId%></div>
								<div><% if mycsdetailitem.FItemList(i).Fisupchebeasong = "Y" then %>업체배송<% else %>텐바이텐배송<% end if %></div>
							</td>
							<td><img src="<%= mycsdetailitem.FItemList(i).FSmallImage %>" width="50" height="50" alt="<%= mycsdetailitem.FItemList(i).FItemName %>" /></td>
							<td class="lt">
								<div><%= mycsdetailitem.FItemList(i).FItemName %></div>
								<% if mycsdetailitem.FItemList(i).FItemoptionName<>"" then %>
								<div><strong>옵션 : <%= mycsdetailitem.FItemList(i).FItemoptionName %></strong></div>
								<% end if %>
							</td>
							<td><%= FormatNumber(mycsdetailitem.FItemList(i).FItemCost,0) %> 원
							<% if (mycsdetailitem.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
                            <p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(mycsdetailitem.FItemList(i).getReducedPrice,0) %><%= CHKIIF(mycsdetailitem.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
                            <% end if %>
							</td>
							<td>
								<%= mycsdetailitem.FItemList(i).Fregitemno %>
								<% if (mycsdetailitem.FItemList(i).Fregitemno <> mycsdetailitem.FItemList(i).Fconfirmitemno) then %>
								<br>-><%= mycsdetailitem.FItemList(i).Fconfirmitemno %>
								<% end if %>
							</td>
							<td><%= FormatNumber((mycsdetailitem.FItemList(i).FItemCost * mycsdetailitem.FItemList(i).Fconfirmitemno),0) %> 원
							<% if (mycsdetailitem.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
							<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(mycsdetailitem.FItemList(i).getReducedPrice*mycsdetailitem.FItemList(i).Fconfirmitemno,0) %><%= CHKIIF(mycsdetailitem.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
							<% end if %>
							</td>
							<% If vIsPacked = "Y" Then %>
							<td>
								<%
								If mycsdetailitem.FItemList(i).FIsPacked = "Y" Then	'### 내가포장했는지
									Response.Write "<img src=""http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png"" alt=""상품요청상품"" />"
								End If
								%>
							</td>
							<% End If %>
						</tr>
						<%
							end if
						next
						%>
						</tbody>
						<tfoot>
						<tr>
							<td colspan="7">총 금액 : 상품구매총액 <strong><%= FormatNumber((itemcostsum),0) %></strong>원(상품수 <%= FormatNumber(itemcount, 0) %>종 <%= FormatNumber(itemtotalcount, 0) %>개)<%=CHKIIF(vIsPacked="Y"," + 선물포장비 " & FormatNumber(packpaysum,0) & "원","")%> + 배송비 <%= FormatNumber((beasongpaysum),0) %> 원</td>
						</tr>
						</tfoot>
						</table>
						<!----- 등록상품정보 끝 ----->
		          	<% end if %>


					<%
					if (mycsdetail.FOneItem.Fdivcd = "A003") or (mycsdetail.FOneItem.Fdivcd = "A004") or (mycsdetail.FOneItem.Fdivcd = "A007") or (mycsdetail.FOneItem.Fdivcd = "A008") or (mycsdetail.FOneItem.Fdivcd = "A010") then
						if mycsdetail.FOneItem.Frefundrequire > 0 then
					%>
						<!----- 환불정보 시작 ----->
						<h2>환불정보</h2>
						<form name="frmRefund" method="post" action="popCsDetail_proc.asp">
						<input type="hidden" name="mode" value="editRefund">
						<input type="hidden" name="CsAsID" value="<%= CsAsID %>">
						<table class="baseTable rowTable">
						<caption>환불정보</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody class="fs12">
						<tr>
							<th scope="row">환불 예정액</th>
							<td class="lt">
								<strong class="crRed"><%=FormatNumber(mycslist.FoneItem.Frefundrequire,0)%></strong> 원
								<% If mycslist.FoneItem.Frefunddeliverypay <> 0 Or mycslist.FoneItem.Frefundcouponsum <> 0 Or mycslist.FoneItem.Frefundmileagesum <> 0 Then %>
								<br>(
									<% If mycsdetail.FoneItem.Frefunddeliverypay <> 0 and mycsdetail.FOneItem.Fdivcd  = "A008" Then %>
										추가배송비 차감 : <strong class="crRed"><%=FormatNumber(-1*(mycslist.FoneItem.Frefunddeliverypay),0)%></strong>원 &nbsp;
									<% elseif mycsdetail.FoneItem.Frefunddeliverypay <> 0 and (mycsdetail.FOneItem.Fdivcd  = "A004" or mycsdetail.FOneItem.Fdivcd  = "A010") then %>
										반품배송비 차감 : <strong class="crRed"><%=FormatNumber(-1*(mycslist.FoneItem.Frefunddeliverypay),0)%></strong>원 &nbsp;
									<% elseif mycsdetail.FoneItem.Frefunddeliverypay <> 0 then %>
										배송비 차감 : <strong class="crRed"><%=FormatNumber(-1*(mycslist.FoneItem.Frefunddeliverypay),0)%></strong>원 &nbsp;
									<% End If %>
									<% If mycslist.FoneItem.Frefundcouponsum <> 0 Then %>
										사용쿠폰환급액 : <strong class="crRed"><%=FormatNumber(-1*(mycslist.FoneItem.Frefundcouponsum),0)%></strong>원 &nbsp;
									<% End If %>
									<% If mycslist.FoneItem.Frefundmileagesum <> 0 Then %>
										사용마일리지환급액 : <strong class="crRed"><%=FormatNumber(-1*(mycslist.FoneItem.Frefundmileagesum),0)%></strong> Point
									<% End If %>
									)
								<% End If %>

								<% if (mycslist.FoneItem.Frefunddepositsum <> 0) or (mycslist.FoneItem.Frefundgiftcardsum <> 0) then %>
								(
								<% If mycslist.FoneItem.Frefunddepositsum <> 0 Then %>
									사용예치금환급액 : <strong class="crRed"><%=FormatNumber(-1*(mycslist.FoneItem.Frefunddepositsum),0)%></strong>원 &nbsp;
								<% End If %>
								<% If mycslist.FoneItem.Frefundgiftcardsum <> 0 Then %>
									사용기프트카드환급액 : <strong class="crRed"><%=FormatNumber(-1*(mycslist.FoneItem.Frefundgiftcardsum),0)%></strong>원 &nbsp;
								<% End If %>
								)
								<% End If %>

							</td>
						</tr>
						<tr>
							<th scope="row">환불방법</th>
							<% if (isNaverPay) and ((mycslist.FoneItem.Freturnmethod="R100") or (mycslist.FoneItem.Freturnmethod="R120") or (mycslist.FoneItem.Freturnmethod="R020") or (mycslist.FoneItem.Freturnmethod="R022")) then %>
							<td class="lt">네이버페이취소</td>
						    <% else %>
							<td class="lt"><%= mycslist.FoneItem.FreturnMethodName%></td>
						    <% end if %>
						</tr>
						<%
						If mycslist.FoneItem.FreturnMethod = "R007" and DateDiff("m", mycslist.FoneItem.Fregdate, Now) <= 3 Then
							'// 3개월 지나면 표시안함(skyer9)
						%>
						<%
							If mycsdetail.FoneItem.Fcurrstate < "B007" Then
								refunding=true
							else
								refunding=false
							end if
						%>
						<% if mycsdetail.FoneItem.Fcurrstate = "B001" Then %>
						<tr>
							<th scope="row">환불 계좌 은행</th>
							<td class="lt">
								<select name='rebankname' class="select" title="입금 은행 선택"<% if Not(refunding) then response.write " disabled"%>>
									<option value="">입금하실 은행을 선택하세요.</option>
									<option value="농협"<% if mycslist.FoneItem.Frebankname="농협" then response.write " selected" %>>농    협</option>
									<option value="국민"<% if mycslist.FoneItem.Frebankname="국민" then response.write " selected" %>>국민은행</option>
									<option value="우리"<% if mycslist.FoneItem.Frebankname="우리" then response.write " selected" %>>우리은행</option>
									<option value="신한"<% if mycslist.FoneItem.Frebankname="신한" then response.write " selected" %>>신한은행</option>
									<option value="하나"<% if mycslist.FoneItem.Frebankname="하나" then response.write " selected" %>>하나은행</option>
									<option value="기업"<% if mycslist.FoneItem.Frebankname="기업" then response.write " selected" %>>기업은행</option>
									<option value="경남"<% if mycslist.FoneItem.Frebankname="경남" then response.write " selected" %>>경남은행</option>
									<option value="부산"<% if mycslist.FoneItem.Frebankname="부산" then response.write " selected" %>>부산은행</option>
									<option value="우체국"<% if mycslist.FoneItem.Frebankname="우체국" then response.write " selected" %>>우체국</option>
									<option value="수협"<% if mycslist.FoneItem.Frebankname="수협" then response.write " selected" %>>수협</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">환불 계좌 번호</th>
							<td class="lt">
								<input type="text" id="[on,off,2,32][환불 계좌 번호]" name="rebankaccount" value="<%= editrebankaccount %>" class="txtInp focusOn" style="width:140px;"<% if Not(refunding) then response.write " disabled"%> />
							</td>
						</tr>
						<tr>
							<th scope="row">환불 계좌 예금주</th>
							<td class="lt">
								<input type="text" id="[on,off,2,32][환불 계좌 예금주]" name="rebankownername" value="<%= mycslist.FoneItem.Frebankownername %>" class="txtInp focusOn" style="width:140px;"<% if Not(refunding) then response.write " disabled"%> />
							</td>
						</tr>
						<% else %>
						<tr>
							<th scope="row">환불 계좌 은행</th>
							<td class="lt">
								<% if mycslist.FoneItem.Frebankname <> "" then %>
								<%= mycslist.FoneItem.Frebankname %>
								<% else %>
								&nbsp;
								<% end if %>
							</td>
						</tr>
						<tr>
							<th scope="row">환불 계좌 번호</th>
							<td class="lt">
							    <% if mycslist.FoneItem.Frebankaccount <> "" then %>
								<%= mycslist.FoneItem.Frebankaccount %>
								<% else %>
								&nbsp;
								<% end if %>
							</td>
						</tr>
						<tr>
							<th scope="row">환불 계좌 예금주</th>
							<td class="lt">
							    <% if mycslist.FoneItem.Frebankownername <> "" then %>
								<%= mycslist.FoneItem.Frebankownername %>
								<% end if %>
							</td>
						</tr>
						<% end if %>
						<% end if %>
						</tbody>
						</table>
						</form>
						<ul class="list bulletDot tMar10">
							<li>할인 보너스쿠폰을 사용한 주문건일 경우, 각 상품별로 할인된 금액이 차감되어 환불됩니다.</li>
						</ul>
						<% if refunding and mycsdetail.FoneItem.Fcurrstate="B001" then %>
						<div class="btnArea ct tPad20">
							<input type="button" class="btn btnS1 btnRed btnW100" onClick="CheckNSubmit(document.frmRefund);" value="수정" />
							<input type="button" class="btn btnS1 btnGry btnW100" onClick="window.close();" value="취소" />
						</div>
						<% end if %>
					<%
						end if
					end if
					%>
					<% if (InStr("A012,A112", mycsdetail.FOneItem.Fdivcd) > 0) then %>
					<!---- 맞교환회수(업체) 안내 ---->

						<h2>회수안내</h2>
						<ul class="list">
							<li class="bPad05">
								신청하신 상품은 <em class="crRed">업체배송 상품</em>으로 교환접수 후, 해당 업체에 <em class="fb crRed">직접 반품</em>해주셔야 교환상품을 받으실 수 있습니다.<br>
								배송박스에 상품이 파손되지 않도록 재포장하신 후, 아래 주소로 발송 부탁드립니다.<br>
								해당 택배사의 대표번호로 전화하신 후,<br>
								처음 받으신 택배상자에 붙어있던 운송장번호를 알려주시면 빠른 택배반품접수가 가능합니다.<br>
								택배접수시 <em class="crRed">착불반송</em>으로 접수하시면 되며,<br>
								접수사유에 따라 추가 배송비를 박스에 넣어서 보내셔야 합니다.<br>
							</li>
							<li><strong>추가택배비 안내 (착불반송시)</strong><br />
								고객변심 교환 : 왕복배송비 / 상품불량 교환 : 추가 배송비 없음
							</li>
						</ul>
						<%

						set OReturnAddr = new CCSReturnAddress

						if mycsdetailitem.FItemList(returnmakerididx).Fisupchebeasong = "Y" then
							if mycsdetailitem.FItemList(returnmakerididx).FMakerid <> "" then
								OReturnAddr.FRectMakerid = mycsdetailitem.FItemList(returnmakerididx).FMakerid
								OReturnAddr.GetReturnAddress
							end if
						end if

						if (OReturnAddr.FResultCount>0) then

						%>
						<table class="baseTable rowTable fs12 tMar15">
						<caption>반품관련 택배, 판매자 및 반품주소 정보</caption>
						<colgroup>
							<col width="120" /> <col width="*" /> <col width="120" /> <col width="300" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">배송상품 택배정보</th>
							<td class="lt"><%=detailDeliveryName%>&nbsp;<%=detailSongjangNo%></td>
							<th scope="row">택배사 대표번호</th>
							<td class="lt"><%=detailDeliveryTel%></td>
						</tr>
						<tr>
							<th scope="row">판매업체명</th>
							<td class="lt"><%=OReturnAddr.Freturnname%></td>
							<th scope="row">판매업체 연락처</th>
							<td class="lt"><%= OReturnAddr.Freturnphone %></td>
						</tr>
						<tr>
							<th scope="row">반품 주소지</th>
							<td colspan="3" class="lt">[<%= OReturnAddr.Freturnzipcode %>] <%= OReturnAddr.Freturnzipaddr %> &nbsp;<%= OReturnAddr.Freturnetcaddr %></td>
						</tr>
						</tbody>
						</table>
						<% end if %>

					<% elseif (InStr("A011,A111", mycsdetail.FOneItem.Fdivcd) > 0) then %>
					<!---- 맞교환회수 안내 ---->

						<h2>회수안내</h2>
						<ul class="list">
							<li class="bPad05">
								신청하신 상품은 <em class="crRed">텐바이텐배송 상품</em>으로 신청 후 2-3일 내에 택배기사님이 방문하시어, 반품상품을 회수할 예정입니다.<br />
								배송박스에 상품이 파손되지 않도록 재포장 하신 후, 택배기사님께 전달 부탁드립니다.<br />
								<em class="crRed">고객변심</em>에 의한 상품 교환인 경우 반품입고가 확인된 이후에, 불량상품 교환의 경우 즉시 출고상품이 배송됩니다.<br />
								접수사유에 따라 추가 배송비를 박스에 넣어서 보내셔야 합니다.
							</li>
							<li><strong>추가택배비 안내</strong><br />
								고객변심 교환 : 왕복배송비 / 상품불량 교환 : 추가 배송비 없음
							</li>
						</ul>

					<% elseif mycsdetail.FOneItem.Fdivcd = "A004" then %>
					<!---- 반품 안내 ---->

						<h2>반품안내</h2>
						<ul class="list">
							<li class="bPad05">
								신청하신 상품은 <em class="crRed">업체배송 상품</em>으로 반품접수 후, 해당 업체에 <em class="fb crRed">직접 반품</em>해주셔야 합니다.<br>
								배송박스에 상품이 파손되지 않도록 재포장하신 후, 아래 주소로 발송 부탁드립니다.<br>
								해당 택배사의 대표번호로 전화하신 후,<br>
								처음 받으신 택배상자에 붙어있던 운송장번호를 알려주시면 빠른 택배반품접수가 가능합니다.<br>
								택배접수시 <em class="crRed">착불반송</em>으로 접수하시면 되며,<br>
								접수사유에 따라 환불시 배송비가 차감되고 환불됩니다.<br>
							</li>
							<li><strong>배송비차감 안내 (착불반송시)</strong><br />
								고객변심 반품 : 왕복배송비 / 상품불량 교환 : 배송비차감 없음
							</li>
						</ul>
						<%

						set OReturnAddr = new CCSReturnAddress

						if mycsdetailitem.FItemList(returnmakerididx).Fisupchebeasong = "Y" then
							if mycsdetailitem.FItemList(returnmakerididx).FMakerid <> "" then
								OReturnAddr.FRectMakerid = mycsdetailitem.FItemList(returnmakerididx).FMakerid
								OReturnAddr.GetReturnAddress
							end if
						end if

						if (OReturnAddr.FResultCount>0) then

						%>
						<table class="baseTable rowTable fs12 tMar15">
						<caption>반품관련 택배, 판매자 및 반품주소 정보</caption>
						<colgroup>
							<col width="120" /> <col width="*" /> <col width="120" /> <col width="210" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">배송상품 택배정보</th>
							<td class="lt"><%=detailDeliveryName%>&nbsp;<%=detailSongjangNo%></td>
							<th scope="row">택배사 대표번호</th>
							<td class="lt"><%=detailDeliveryTel%></td>
						</tr>
						<tr>
							<th scope="row">판매업체명</th>
							<td class="lt"><%=OReturnAddr.Freturnname%></td>
							<th scope="row">판매업체 연락처</th>
							<td class="lt"><%= OReturnAddr.Freturnphone %></td>
						</tr>
						<tr>
							<th scope="row">반품 주소지</th>
							<td colspan="3" class="lt">[<%= OReturnAddr.Freturnzipcode %>] <%= OReturnAddr.Freturnzipaddr %> &nbsp;<%= OReturnAddr.Freturnetcaddr %></td>
						</tr>
						</tbody>
						</table>
						<% end if %>

					<% elseif mycsdetail.FOneItem.Fdivcd = "A010" then %>
					<!---- 회수(텐바이텐배송) 안내 ---->

						<h2>회수안내</h2>
						<ul class="list">
							<li class="bPad05">
								신청하신 상품은 <em class="crRed">텐바이텐배송 상품</em>으로 신청 후 2-3일 내에 택배기사님이 방문하시어, 반품상품을 회수할 예정입니다.<br>
								배송박스에 상품이 파손되지 안도록 재포장하신 후, 택배기사님께 전달 부탁드립니다.<br>
								반품 입고 확인 후, 영업일 기준으로 1~2일내에 환불처리되며,<br>
								접수사유에 따라 환불시 배송비가 차감되고 환불됩니다.<br>
							</li>
							<li><strong>배송비차감 안내</strong><br />
								고객변심 반품 : 왕복배송비 / 상품불량 교환 : 배송비차감 없음
							</li>
						</ul>

					<% end if %>

					</div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>

<form name="csfrm" action="popCsDetail_proc.asp" method="post">
<input type="hidden" name="mode" value="">
<input type="hidden" name="csasid" value="<%=CsAsID%>">
</form>

<%

set mycslist = Nothing
set mycsdetail = Nothing
set mycsdetailitem = Nothing

%>

</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
