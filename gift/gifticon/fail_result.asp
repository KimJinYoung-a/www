<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
<%
	Dim vQuery, vIdx, vResult, vCouponNo, vCouponIdx, vStatus, vOrderserial, vItemID, vItemName, vItemOption, vOptionName, vMakerID, vBrandName, vListImage, vGiftCardCode
	vIdx = requestCheckVar(request("idx"),10)
	If vIdx = "" Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	IF IsNumeric(vIdx) = false Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	
	vQuery = "SELECT * From [db_order].[dbo].[tbl_mobile_gift] Where idx = '" & vIdx & "' AND gubun = 'gifticon'"
	rsget.Open vQuery,dbget,1
	IF Not rsget.EOF THEN
		vCouponNo 		= rsget("couponno")
		vStatus			= rsget("status")
		vOrderserial	= rsget("orderserial")
		vGiftCardCode	= rsget("masterCardCode")
		vCouponIdx		= rsget("couponidx")
		vItemID			= rsget("itemid")
		vItemName		= rsget("itemname")
		vItemOption 	= rsget("itemoption")
		vOptionName		= rsget("optionname")
		vMakerID		= rsget("makerid")
		vBrandName		= rsget("brandname")
		vListImage		= rsget("listimage")
		vResult 		= rsget("resultmessage")
		
		If rsget("IsPay") = "Y" Then
			vStatus = "3115"
		End IF
	End IF
	rsget.close
%>


		<% If vStatus = "3115" OR vStatus = "3121" Then %>

			<% If vGiftCardCode <> "" Then %>
				<p class="message">이미 등록이 완료된<br>Gift카드 입니다.</p><p>마이텐바이텐에서<br>Gift 카드 잔액 확인이 가능합니다. </p>
				<div class="btns">
					<!--<a href="#" ><img src="http://fiximage.10x10.co.kr/m/kakaotalk/btn_balance.png" width="110" height="40" alt="쿠폰확인하기"></a>//-->
					<a href="/" ><img src="http://fiximage.10x10.co.kr/m/kakaotalk/btn_gohome.png" width="110" height="40" alt="홈으로가기"></a>
				</div>
			<%
				Else
					If vCouponIdx <> "0" Then
			%>
						<p class="message">이미 텐바이텐 쿠폰교환이 완료된<br>인증번호 입니다.</p><p>쿠폰 현황은 마이텐바이텐에서 확인 가능합니다.</p>
						<div class="btns">
							<a href="/my10x10/couponbook.asp" ><img src="http://fiximage.10x10.co.kr/m/kakaotalk/btn_gocoupon.png" width="110" height="40" alt="쿠폰확인하기"></a>
							<a href="/" ><img src="http://fiximage.10x10.co.kr/m/kakaotalk/btn_gohome.png" width="110" height="40" alt="홈으로가기"></a>
						</div>
			<%
					Else
						Dim vIpkumDiv, vDivName, vSongjangNo, vFindURL
						vQuery = "SELECT Top 1 m.ipkumdiv, s.divname, replace(d.songjangno,'-','') as songjangno, s.findurl From [db_order].[dbo].[tbl_order_master] AS m "
						vQuery = vQuery & "INNER JOIN [db_order].[dbo].tbl_order_detail AS d ON m.orderserial = d.orderserial "
						vQuery = vQuery & "LEFT JOIN db_order.[dbo].tbl_songjang_div AS s ON d.songjangdiv = s.divcd "
						vQuery = vQuery & "WHERE m.orderserial = '" & vOrderserial & "' and d.itemid <> 0 and d.cancelyn <> 'Y' "
						rsget.Open vQuery,dbget,1
						IF Not rsget.EOF THEN
							vIpkumDiv = rsget("ipkumdiv")
							vDivName = rsget("divname")
							vSongjangNo = rsget("songjangno")
							vFindURL = db2html(rsget("findurl")) & vSongjangNo
						End IF
						rsget.close
			%>
						<div class="message">이미 배송지 정보입력을 완료하셨습니다.<br>
						주문번호를 선택하시면<br>
						주문상세정보를 확인하실 수 있습니다.</div>
						<div class="detail">
							<p class="order_status">주문상태 : 
							<%
						        select case vIpkumDiv
						            case "0"
						                Response.Write "주문실패"
						            case "1"
						                Response.Write "주문실패"
						            case "2"
						                Response.Write "주문접수"
						            case "3"
						                Response.Write "입금대기"
						            case "4"
						                Response.Write "결제완료"
						            case "5"
						                Response.Write "주문통보"
						            case "6"
						                Response.Write "상품준비"
						            case "7"
						                Response.Write "일부출고"
						            case "8"
						                Response.Write "출고완료"
						            case "9"
						                Response.Write "반품"
						            case else
						                Response.Write ""
						        end select
							%>
							</p>
							<% If isNull(vSongjangNo) = false Then %>
							택배정보 : <a href="<%=vFindURL%>" target="_blank"><%=vDivName%> <%=vSongjangNo%></a>
							<% End If %>
							<a href="/my10x10/order/myorderdetail.asp?idx=<%=vOrderserial%>">주문번호 : <%=vOrderserial%></a>
						</div>
			<%
					End If
				End If
			%>

		<% Else %>
<input name="coupon_num" id="coupon_num" type="text" class="coupon_num" value="<%=vCouponNo%>" />죄송합니다.<br/><%=vResult%>
		<% End IF %>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->