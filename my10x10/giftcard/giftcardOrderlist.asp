<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2013.09.05 - 허진원 생성
'	Description : e기프트카드 주문내역 정보
'#######################################################
%>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 텐바이텐 기프트카드 주문 내역"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_money_v1.jpg"
	strPageDesc = "기프트카드의 조회가 가능합니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 기프트카드 조회"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/giftcard/giftcardOrderlist.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_ordercls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim myorder, page, userid, i
	userid = getEncLoginUserID()
	page = requestCheckvar(request("page"),9)
	if (page="") then page = 1

	set myorder = new cGiftcardOrder
	myorder.FPageSize = 15
	myorder.FCurrpage = page
	myorder.FUserID = userid
	myorder.getGiftcardOrderList

	'// 현재 잔액 계산 (로그인 쿠키정보 업데이트)
	Dim cMyGiftCard, currGiftcard
	set cMyGiftCard = new myGiftCard
	cMyGiftCard.FRectUserid = userid
	currGiftcard = cMyGiftCard.myGiftCardCurrentCash

	if cStr(currGiftcard)<>cStr(request.cookies("etc")("currtengiftcard")) then
		response.Cookies("etc").domain = "10x10.co.kr"
		response.cookies("etc")("currtengiftcard") = currGiftcard
		response.WRite "1"
	end if

	set cMyGiftCard = Nothing
%>
<script language="javascript">
function goPage(page){
    location.href="?page=" + page + "" ;
}

function PopGiftCardCancel(giftorderserial){
    if (giftorderserial == "") {
        alert("먼저 주문을 선택하세요.");
        return;
    }

	var popwin = window.open("popGiftCardCancel.asp?giftorderserial=" + giftorderserial,"PopGiftCardCancel","width=925, height=800,scrollbars=yes,resizable=no,status=no");
	popwin.focus();
}
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<div class="myHeader">
				<h2><a href="/my10x10/"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_my10x10.png" alt="MY 10X10" /></a></h2>
				<div class="breadcrumb">
					<a href="/">HOME</a> &gt;
					<a href="/my10x10/">MY TENBYTEN</a> &gt;
					<a href="" onclick="return false;">MY 쇼핑활동</a> &gt;
					<strong>GIFT 카드</strong>
				</div>
			</div>
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="giftcard giftcardV15a">
						<div class="subHeader">
							<h3><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_giftcard.png" alt="텐바이텐 기프트카드" /></h3>
							<p>무슨 선물을 할까 늘 고민인 당신, 간편한 기프트 카드로 마음을 전해보세요.</p>
							<div class="btnGroupV15a">
								<a href="<%=SSLUrl%>/giftcard/present.asp" class="btn btnS1 btnRed">선물하기</a>
								<a href="/giftcard/" class="btn btnS1 btnWhite">안내 및 유의사항</a>
							</div>
							<div class="ico"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/img_gift_card_visual.png" alt=""></div>
						</div>

						<!-- tab -->
						<ul class="tabMenu addArrow tabReview">
							<li><a href="/my10x10/giftcard/giftcardOrderlist.asp" class="on"><span>주문내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardUselist.asp"><span>사용내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardRegistlist.asp"><span>등록내역</span></a></li>
							<li><a href="/my10x10/giftcard/giftcardRegist.asp"><span>카드등록</span></a></li>
						</ul>

						<ul class="list tMar35">
							<li><em class="cr000">[주문번호] 또는 [주문상품]을 클릭하시면 주문 상세 내역을 조회하실 수 있습니다</em></li>
						</ul>

						<!-- list -->
						<table class="baseTable tMar10">
						<caption>GIFT카드 주문내역</caption>
						<colgroup>
							<col style="width:120px;" /> <col style="width:90px;" /> <col style="width:*;" /> <col style="width:110px;" /> <col style="width:90px;" /> <col style="width:120px;" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">주문번호</th>
							<th scope="col">주문일자</th>
							<th scope="col">상품명</th>
							<th scope="col">구매금액</th>
							<th scope="col">주문상태</th>
							<th scope="col">취소요청</th>
						</tr>
						</thead>
						<tbody>
						<%
							If myorder.FResultCount>0 Then
								For i = 0 To (myorder.FResultCount - 1)
						%>
						<tr>
							<td><%=myorder.FItemList(i).Fgiftorderserial%></td>
							<td><%=formatDate(myorder.FItemList(i).Fregdate,"0000/00/00")%></td>
							<td><a href="/my10x10/giftcard/giftcardOrderDetail.asp?idx=<%=myorder.FItemList(i).Fgiftorderserial%>"><%=myorder.FItemList(i).FCarditemname%>&nbsp;<%=myorder.FItemList(i).FcardOptionName%></a></td>
							<td><%=FormatNumber(myorder.FItemList(i).Fsubtotalprice,0)%>원</td>
							<td>
						    <%
						    	If (myorder.FItemList(i).FCancelyn<>"N") Then
						        	Response.Write "<em class=""cr555"">취소주문</em>"
						    	Else
						        	Response.Write "<em class="""&myorder.FItemList(i).GetJumunDivColor&""">"&myorder.FItemList(i).GetJumunDivName&"</em>"
						    	End If
						    %>
							</td>
							<td>
						    <%
						    	If (myorder.FItemList(i).FCancelyn="N") Then
						    		If (myorder.FItemList(i).IsWebOrderCancelEnable) Then
						    			Response.Write "<a href="""" class=""btn btnS2 btnGrylight btnW90"" onclick=""PopGiftCardCancel('" & myorder.FItemList(i).Fgiftorderserial & "');return false;""><span class=""fn"">주문취소</span></a>"
						    		End If
						    	End If
						    %>
						</tr>
						<%
								Next
							else
						%>
						<tr>
							<td colspan="6"><p class="noData fs12"><strong>등록된 카드가 없습니다.</strong></p></td>
						</tr>
						<%	end if %>
						</tbody>
						</table>

						<%
							If myorder.FResultCount>0 Then
								Response.Write "<div class=""pageWrapV15 tMar20"">" & fnDisplayPaging_New(myorder.FcurrPage, myorder.FtotalCount, myorder.FPageSize, 15, "goPage") & "</div>"
							end if
						%>

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
<% set myorder = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
