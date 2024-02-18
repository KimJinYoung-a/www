<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
	const MenuSelect = "01"
	strPageTitle = "텐바이텐 10X10 : 주문배송조회"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim IsBSearch : IsBSearch = False ''비회원조회

dim i, j, lp
dim page
dim pflag, aflag, cflag

pflag = requestCheckvar(request("pflag"),10)
aflag = requestCheckvar(request("aflag"),2)
cflag = requestCheckvar(request("cflag"),2)
If pflag="" Then pflag="S"
page = requestCheckvar(request("page"),9)
if (page="") then page = 1

dim userid
userid = getEncLoginUserID()

dim myorder
set myorder = new CMyOrder

myorder.FPageSize = 10
myorder.FCurrpage = page
myorder.FRectUserID = userid
myorder.FRectSiteName = "10x10"
myorder.FRectArea = aflag

IF pflag="P" Then
    myorder.FRectOldjumun = pflag
ENd IF

if IsUserLoginOK() then
	if (pflag="C") then
		myorder.GetMyCancelOrderList
	else
		if (pflag="H") then		'15일
    		myorder.FRectStartDate = FormatDateTime(DateAdd("d",-15,now()),2)
    		myorder.FRectEndDate = FormatDateTime(now(),2)
		elseif (pflag="M") then		'1개월
    		myorder.FRectStartDate = FormatDateTime(DateAdd("m",-1,now()),2)
    		myorder.FRectEndDate = FormatDateTime(now(),2)
		elseif (pflag="T") then		'3개월
    		myorder.FRectStartDate = FormatDateTime(DateAdd("m",-3,now()),2)
    		myorder.FRectEndDate = FormatDateTime(now(),2)
		elseif (pflag="S") then		'6개월
    		myorder.FRectStartDate = FormatDateTime(DateAdd("m",-6,now()),2)
    		myorder.FRectEndDate = FormatDateTime(now(),2)
		end if
		myorder.GetMyShopOrderListProc
	end if
end if

%>


<script type="text/javascript">
	$(function(){
		$('.searchField .word span label').click(function() {
			$('.searchField .word span label').removeClass('current');
			$(this).addClass('current');
		});
	});
</script>
<script type="text/javascript">
$(document).unbind("dblclick");
var PrvPflag = '<%= pflag %>';
function chkClickChange(comp){
    // nothing
    //if (PrvPflag!=comp.value){
    //    comp.form.submit();
   // }
}

function goPage(page){
    location.href="?page=" + page + "&pflag=<%= pflag %>" + "&aflag=<%=aflag %>"+ "&cflag=<%=cflag %>" ;
}

function OrderSearch(g){
	document.frmODSearch.pflag.value=g;
	frmODSearch.submit();
}

</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap"><!-- for dev msg: 이전 모든 마이텐바이텐 페이지에 id="my10x10WrapV15" 추가해주세요 -->
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_delivery_check.gif" alt="주문배송조회" /></h3>
						<ul class="list">
							<li>[주문번호] 및 [주문상품]을 클릭하시면 주문상세 내역 및 상품별 배송상황을 조회하실 수 있으며, 취소/교환/반품 신청도 가능합니다.</li>
							<li>텐바이텐 Gift 카드 주문 내역은 MY 텐바이텐 &gt; MY 쇼핑혜택: Gift카드 &gt; 카드 주문내역 에서 확인 가능합니다. <a href="/my10x10/giftcard/?tab=ord" class="linkBtn">Gift 카드 주문확인 하러가기</a></li>
						</ul>
					</div>

					<div class="mySection">
						<ul class="tabMenu addArrow bMar25">
							<li><a href="/my10x10/order/myorderlist.asp"><span>온라인</span></a></li>
							<li><a href="#" class="on"><span>매장</span></a></li>
						</ul>
						<fieldset>
						<legend>주문배송조회 조회기간</legend>
							<form name="frmODSearch" method="get" >
							<input type="hidden" name="cflag" value="">
							<input type="hidden" name="pflag" value="<%=pflag%>">
							<% if IsUserLoginOK() or IsGuestLoginOK() then %>
							<div class="searchField">
								<div class="word">
									<strong>조회기간</strong>
									<span><input type="checkbox" value="H" onClick="OrderSearch('H');" id="day15" /> <label class="<%= CHKIIF(pflag="H","current","") %>" for="day15">15일</label></span>
									<span><input type="checkbox" value="M" onClick="OrderSearch('M');" id="onMonth" /> <label class="<%= CHKIIF(pflag="M","current","") %>" for="onMonth">1개월</label></span>
									<span><input type="checkbox" value="T" onClick="OrderSearch('T');" id="threeMonth" /> <label class="<%= CHKIIF(pflag="T","current","") %>" for="threeMonth">3개월</label></span>
									<span><input type="checkbox" value="S" onClick="OrderSearch('S');" id="sixMonth" /> <label class="<%= CHKIIF(pflag="S","current","") %>" for="sixMonth">6개월</label></span>
									<span><input type="checkbox" value="P" onClick="OrderSearch('P');" id="beforeSix" /> <label class="<%= CHKIIF(pflag="P","current","") %>" for="beforeSix">6개월 이전</label></span>
								</div>
							</div>
							<% End If%>
							</form>
							<table class="baseTable">
							<caption>주문배송조회 목록</caption>
							<colgroup>
								<col style="width:98px;" /> <col style="width:88px;" /> <col style="width:*;" /> <col style="width:87px;" /> <col style="width:85px;" /> <col style="width:125px;" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">주문번호</th>
								<th scope="col">주문일자</th>
								<th scope="col">주문상품</th>
								<th scope="col">총 구매금액</th>
								<th scope="col">주문상태</th>
								<th scope="col">구매 매장</th>
							</tr>
							</thead>
							<tbody>
							<% For i = 0 To (myorder.FResultCount - 1) %>
							<tr>
								<td><a href="myshoporderdetail.asp?idx=<%= myorder.FItemList(i).FOrderSerial %>&pflag=<%= pflag %>&cflag=<%= cflag %>" onfocus='this.blur()'><%= myorder.FItemList(i).FOrderSerial %></a></td>
								<td><%= Left(CStr(myorder.FItemList(i).Fregdate),10) %></td>
								<td class="lt"><a href="myshoporderdetail.asp?idx=<%=myorder.FItemList(i).FOrderSerial%>&pflag=<%=pflag%>&cflag=<%= cflag %>" onfocus='this.blur()'><%=myorder.FItemList(i).GetItemNames%></a></td>
								<td><%=FormatNumber(myorder.FItemList(i).FSubTotalPrice,0)%>원</td>
								<td><% If myorder.FItemList(i).FSubTotalPrice>0 Then %><em class="cRd0V15">구매완료</em><% Else %>반품<% End If %></td>
								<td><%=myorder.FItemList(i).FShopName%></td>
							</tr>
							<% Next %>
							<% if myorder.FResultCount < 1 then %>
	                        <tr>
								<td align="center" colspan="6">검색된 주문내역이 없습니다.</td>
            				</tr>
							<% end if %>
							</tbody>
							</table>

							<div class="paging tMar20">
								<%= fnDisplayPaging_New_nottextboxdirect(myorder.FcurrPage, myorder.FtotalCount, myorder.FPageSize, 5, "goPage") %>
							</div>
						</fieldset>
					</div>

					<div class="offNoti">
						<ul>
							<li>매장에서 주문시 텐바이텐 멤버십카드를 제시하시면 구매 <em>금액의 3%를 매장 마일리지로 적립</em>해드립니다.</li>
							<li>※ 멤버십카드는 마이텐바이텐 > <a href="/my10x10/membercard/point_search.asp">텐바이텐 멤버십카드</a> 메뉴에서 확인할 수 있습니다.</li>
						</ul>
					</div>

					<div class="helpSection">
						<h4><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_help.gif" alt="도움말 HELP" /></h4>
						<ul class="list">
							<li>오프라인 주문건별 구매 내역 정보입니다.</li>
							<li>오프라인 주문 정보는 일별로 매장 마감한 상품 기준으로 갱신됩니다.</li>
							<li>오프라인 상품의 할인, 가격 정보는 매장별 정책에 따라 온라인 상품 정보와 상이할 수 있습니다.</li>
							<li>오프라인 구매 상품의 교환 및 환불 신청은 구매 매장에 문의 부탁드립니다. <a href="http://www.10x10.co.kr/offshop/shopinfo.asp?shopid=streetshop011&tabidx=1" class="cGy0V15" target="_blank"><strong>[매장정보 보기]</strong></a></li>
						</ul>
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
<!-- #include virtual="/lib/db/dbclose.asp" -->