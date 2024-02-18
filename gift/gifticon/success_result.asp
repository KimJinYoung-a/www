<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 기프티콘 교환"
	
	Dim vQuery, vIdx, vResult, vOrderserial
	Dim vRegdate, vCouponNo, vListImage, vItemID, vItemName, vOptionName, vDelivery, vBuyName, vBuyEmail, vBuyHP, vBuyPhone, vReqName, vReqHP, vReqPhone
	Dim vReqzipcode, vAddr, vComment
	vOrderserial = requestCheckVar(request("orderserial"),20)
	If vOrderserial = "" Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	IF IsNumeric(vOrderserial) = false Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	
	vQuery = "SELECT TOP 1 "
	vQuery = vQuery & "m.regdate, g.couponno, g.listimage, g.itemid, g.itemname, g.optionname, d.odlvType, m.buyname, m.buyemail, m.buyhp, m.buyphone, m.reqname, m.reqhp, m.reqphone, "
	vQuery = vQuery & "m.reqzipcode, m.reqzipaddr + ' ' + m.reqaddress AS addr, m.comment "
	vQuery = vQuery & "FROM [db_order].[dbo].[tbl_order_master] AS m "
	vQuery = vQuery & "INNER JOIN [db_order].[dbo].[tbl_order_detail] AS d ON m.orderserial = d.orderserial "
	vQuery = vQuery & "INNER JOIN [db_order].[dbo].[tbl_mobile_gift] AS g ON m.orderserial = g.orderserial "
	vQuery = vQuery & "WHERE m.orderserial = '" & vOrderserial & " ' AND d.itemid <> '0'"
	rsget.Open vQuery,dbget,1
	IF Not rsget.EOF THEN
		vRegdate	= rsget("regdate")
		vCouponNo	= rsget("couponno")
		vListImage	= rsget("listimage")
		vItemID		= rsget("itemid")
		vItemName	= rsget("itemname")
		vOptionName	= rsget("optionname")
		vDelivery	= rsget("odlvType")
		vBuyName	= rsget("buyname")
		vBuyEmail	= rsget("buyemail")
		vBuyHP		= rsget("buyhp")
		vBuyPhone	= rsget("buyphone")
		vReqName	= rsget("reqname")
		vReqHP		= rsget("reqhp")
		vReqPhone	= rsget("reqphone")
		vReqzipcode	= rsget("reqzipcode")
		vAddr		= rsget("addr")
		vComment 	= nl2Br(db2html(rsget("comment")))
		Select Case vDelivery
			Case "1" 
				vDelivery = "텐바이텐배송"
			Case "2"
				vDelivery = "업체무료배송"
			Case "4"
				vDelivery = "텐바이텐배송"
			Case "5"
				vDelivery = "업체무료배송" 
			Case "7"
				vDelivery = "업체착불배송"
			Case "9"
				vDelivery = "업체배송"
			Case Else
				vDelivery = "텐바이텐배송"
		End Select
		rsget.close
	Else
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		rsget.close
		dbget.close()
		Response.End
	END IF
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="cartWrap orderWrap">
				<div class="cartHeader">
					<div class="orderGifticonStep">
						<span class="step01">배송지 입력</span>
						<h2><span class="step02">배송요청 완료</span></h2>
					</div>
					<dl class="myBenefitBox">
						<dt class="tPad15">
						<% If IsUserLoginOK() Then %>
						<strong><%=GetLoginUserName()%></strong>님 <span class="mem<%=GetUserLevelStr(GetLoginUserLevel)%>"><strong>[<%=GetUserLevelStr(GetLoginUserLevel)%>]</strong></span></dt>
						<% End If %>
						<dd class="bPad20">
							<p class="tPad03">텐바이텐을 이용해 주셔서 감사합니다.</p>
						</dd>
					</dl>
				</div>

				<div class="cartBox tMar15">
					<div class="orderComplete">
						<p><strong><img src="http://fiximage.10x10.co.kr/web2013/cart/txt_delivery_ok.gif" alt="배송요청이 정상적으로 완료되었습니다." /></strong></p>
						<div class="orderNumber">
							<strong>[주문번호] <%=vOrderserial%></strong>
						</div>
						<p>비회원 주문시에는 주문번호를 알아야 홈페이지에서 주문배송조회가 가능합니다.<br />주문내역 및 배송에 관한 안내는 <span class="crRed">마이텐바이텐 &gt; 주문배송조회</span>에서 확인 가능 합니다.</p>
					</div>

					<div class="overHidden">
						<h3>결제 정보 확인</h3>
					</div>
					<table class="baseTable orderForm payForm tMar10">
						<caption>결제 정보 확인</caption>
						<colgroup>
							<col width="14%" /><col width="36%" /><col width="14%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>결제 방법</th>
							<td>기프티콘</td>
							<th>주문일시</th>
							<td><%=vRegdate%></td>
						</tr>
						<tr>
							<th>기프티콘 인증번호</th>
							<td colspan="3"><strong class="crRed"><%=vCouponNo%></strong></td>
						</tr>
						</tbody>
					</table>

					<div class="overHidden tMar55">
						<h3>주문리스트 확인</h3>
					</div>
					<table class="baseTable tMar10">
						<caption>주문리스트 확인</caption>
						<colgroup>
							<col width="110px" /><col width="110px" /><col width="220px" /><col width="" /><col width="200px" />
						</colgroup>
						<thead>
						<tr>
							<th>상품코드</th>
							<th>배송</th>
							<th colspan="2">상품정보</th>
							<th>옵션</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%=vItemID%></td>
							<td><%=vDelivery%></td>
							<td class="rt"><img src="<%=vListImage%>" width="50px" height="50px" alt="<%=vItemName%>" /></td>
							<td class="lt"><%=vItemName%></td>
							<td><%=CHKIIF(vOptionName="","-",vOptionName)%></td>
						</tr>
						</tbody>
					</table>

					<div class="overHidden tMar55">
						<h3>주문고객 정보 확인</h3>
					</div> 
					<table class="baseTable orderForm tMar10">
						<caption>주문고객 정보 확인</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>보내시는 분</th>
							<td><%=vBuyName%></td>
							<th>이메일</th>
							<td><%=vBuyEmail%></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td><%=vBuyHP%></td>
							<th>전화번호</th>
							<td><%=vBuyPhone%></td>
						</tr>
						</tbody>
					</table>

					<div class="overHidden tMar55">
						<h3>배송지 정보 확인</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>배송지 정보 확인</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>받으시는 분</th>
							<td colspan="3"><%=vReqName%></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td><%=vReqHP%></td>
							<th>전화번호</th>
							<td><%=vReqPhone%></td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">[<%=vReqzipcode%>] <%=vAddr%></td>
						</tr>
						<tr>
							<th>배송 유의사항</th>
							<td colspan="3"><%=vComment%></td>
						</tr>
						</tbody>
					</table>

					<div class="ct tMar60 bPad20">
						<a href="/my10x10/order/myorderlist.asp" class="btn btnB2 btnWhite2 btnW220">주문/배송 조회</a>
						<a href="javascript:window.print();" class="lMar10 btn btnB2 btnWhite2 btnW220">인쇄하기</a>
						<a href="/" class="lMar10 btn btnB2 btnRed btnW220"><em class="whiteArr02">쇼핑 계속하기</em></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>