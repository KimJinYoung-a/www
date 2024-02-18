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
	strPageTitle = "텐바이텐 10X10 : 주문배송 조회"		'페이지 타이틀 (필수)
	strPageImage = "http://fiximage.10x10.co.kr/page/title/pageImage_orderList_v1.jpg"
	strPageDesc = "주문내역 조회가 가능합니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 주문 내역 조회"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/order/myorderlist.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
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
dim iniRentalInfoData, tmpRentalInfoData, iniRentalMonthLength, iniRentalMonthPrice '// 이니렌탈 관련 변수

pflag = requestCheckvar(request("pflag"),10)
aflag = requestCheckvar(request("aflag"),2)
cflag = requestCheckvar(request("cflag"),2)

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
		end if

		myorder.GetMyOrderListProc
	end if

elseif IsGuestLoginOK() then
    myorder.FRectOrderserial = GetGuestLoginOrderserial()
    if (pflag="C") then
        myorder.GetMyCancelOrderList
    elseif (pflag="P") then
        myorder.GetMyOrderListProc
    else
        myorder.GetMyOrderListProc
    end if

    IsBSearch = true
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

function popMyOrderNo(){
	var f = document.frmSearch;
	var url = "/my10x10/orderPopup/popMyOrderNo.asp?frmname=" + f.name + "&targetname=" + f.orderserial.name;
	var popwin = window.open(url,'popMyOrderNo','width=670,height=500,scrollbars=yes,resizable=yes');
	popwin.focus();
}
function OrderSearch(g){
	document.frmODSearch.pflag.value=g;
	frmODSearch.submit();
}
function canceljumun(){
	<% if (pflag <> "C") then %>
	document.frmODSearch.pflag.value="C";
	<% else %>
	document.frmODSearch.pflag.value="";
	<% end if %>
	frmODSearch.submit();
}

function setCalNSearch(cmd, comp){
    var currdate=new Date();
    var predate =new Date();
	var DayAdd  = 0;

	if(cmd == "1D"){
		DayAdd = 0;
	}else if(cmd == "15D"){
		DayAdd = -15;
	}else if(cmd == "1M"){
		DayAdd = -30;
	}else if(cmd == "2M"){
		DayAdd = -60;
	}else if(cmd == "3M"){
		DayAdd = -90;
	}

	var newtimes=predate.getTime()+(DayAdd*24*60*60*1000);
	predate.setTime(newtimes);

    var stDt = "";
    var edDt = "";
    stDt = predate.getFullYear();
	edDt = currdate.getFullYear();
	if(predate.getMonth() <9){
		stDt += "-" + "0" + (predate.getMonth()+1).toString();
	}else{
		stDt += "-" + (predate.getMonth()+1).toString();
	}
	if(predate.getDate() <10 ){
		stDt += "-" + "0" +  predate.getDate().toString();
	}else{
		stDt += "-" + predate.getDate().toString();
	}

    if(currdate.getMonth() <9){
		edDt += "-" + "0" + (currdate.getMonth()+1).toString();
	}else{
		edDt += "-" + (currdate.getMonth()+1).toString();
	}
	if(currdate.getDate() <10 ){
		edDt += "-" + "0" +  currdate.getDate().toString();
	}else{
		edDt += "-" + currdate.getDate().toString();
	}



	frmODSearch.stDt.value = stDt;
	frmODSearch.edDt.value = edDt;

	frmODSearch.submit();
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
					<!-- 다스배너 -->
					<!-- <a href="/diarystory2021/" target="_balnk" class="bnr_myorder_dr"><img src="http://fiximage.10x10.co.kr/web2021/diary2022/bnr_diary2022_order.png" alt="다이어리스토리 메인으로 이동"></a> -->

					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_delivery_check.gif" alt="주문배송조회" /></h3>
						<ul class="list">
							<li>[주문번호] 및 [주문상품]을 클릭하시면 주문상세 내역 및 상품별 배송상황을 조회하실 수 있으며, 취소/교환/반품 신청도 가능합니다.</li>
							<li>텐바이텐 Gift 카드 주문 내역은 MY 텐바이텐 &gt; MY 쇼핑혜택: Gift카드 &gt; 카드 주문내역 에서 확인 가능합니다. <a href="/my10x10/giftcard/?tab=ord" class="linkBtn">Gift 카드 주문확인 하러가기</a></li>
						</ul>
					</div>

					<div class="mySection">
						<ul class="tabMenu addArrow bMar25">
							<li><a href="#" class="on"><span>온라인</span></a></li>
							<li><a href="/my10x10/order/myshoporderlist.asp"><span>매장</span></a></li>
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
									<span><input type="radio"  value="H" onClick="OrderSearch('H');" id="day15" /> <label class="<%= CHKIIF(pflag="H","current","") %>" for="day15">15일</label></span>
									<span><input type="radio" value="M" onClick="OrderSearch('M');" id="onMonth" /> <label class="<%= CHKIIF(pflag="M","current","") %>" for="onMonth">1개월</label></span>
									<span><input type="radio" value="T" onClick="OrderSearch('T');" id="threeMonth" /> <label class="<%= CHKIIF(pflag="T","current","") %>" for="threeMonth">3개월</label></span>
									<span><input type="radio" value="" onClick="OrderSearch('');" id="sixMonth" /> <label class="<%= CHKIIF(pflag="","current","") %>" for="sixMonth">6개월</label></span>
									<span><input type="radio" value="P" onClick="OrderSearch('P');" id="beforeSix" /> <label class="<%= CHKIIF(pflag="P","current","") %>" for="beforeSix">6개월 이전</label></span>
								</div>
								<div class="option">
									<select name="aflag" title="주문배송조회 옵션 선택" class="optSelect" onChange="frmODSearch.submit();">
										<option value="" <%= CHKIIF(aflag="","selected","") %>>배송전체</option>
										<option value="KR" <%= CHKIIF(aflag="KR","selected","") %>>국내배송</option>
										<option value="AB" <%= CHKIIF(aflag="AB","selected","") %>>해외배송</option>
									</select>
									<a href="#" onClick="canceljumun();" class="btn btnS2 btnGry2"><span class="fn"><% if (pflag = "C") then %>정상<% else %>취소<% end if %>주문 조회</span></a>
								</div>
							</div>
							<% End If%>
							</form>
							<table class="baseTable">
							<caption>주문배송조회 목록</caption>
							<colgroup>
								<col width="98" /> <col width="88" /> <col width="*" /> <col width="81" /> <col width="81" /> <col width="130" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">주문번호</th>
								<th scope="col">주문일자</th>
								<th scope="col">주문상품</th>
								<th scope="col">총 구매금액</th>
								<th scope="col">주문상태</th>
								<th scope="col">변경/취소/교환/반품</th>
							</tr>
							</thead>
							<tbody>
							<% for i = 0 to (myorder.FResultCount - 1) %>
							<tr>
								<td><a href="myorderdetail.asp?idx=<%= myorder.FItemList(i).FOrderSerial %>&pflag=<%= pflag %>&cflag=<%= cflag %>" onfocus='this.blur()'><%= myorder.FItemList(i).FOrderSerial %></a></td>
								<td><%= Left(CStr(myorder.FItemList(i).Fregdate),10) %></td>
								<td class="lt"><a href="myorderdetail.asp?idx=<%=myorder.FItemList(i).FOrderSerial%>&pflag=<%=pflag%>&cflag=<%= cflag %>" onfocus='this.blur()'><%=myorder.FItemList(i).GetItemNames%></a></td>
								<% If myorder.FItemList(i).Faccountdiv="150" Then %>
									<%
										iniRentalInfoData = fnGetIniRentalOrderInfo(myorder.FItemList(i).FOrderSerial)
										If instr(lcase(iniRentalInfoData),"|") > 0 Then
											tmpRentalInfoData = split(iniRentalInfoData,"|")
											iniRentalMonthLength = tmpRentalInfoData(0)
											iniRentalMonthPrice = tmpRentalInfoData(1)
										Else
											iniRentalMonthLength = ""
											iniRentalMonthPrice = ""
										End If			
									%>
									<td><%=iniRentalMonthLength%>개월간 월 <%=FormatNumber(iniRentalMonthPrice,0)%>원</td>
								<% Else %>								
									<td><%=FormatNumber(myorder.FItemList(i).FSubTotalPrice,0)%>원</td>
								<% End If %>
								<td>
	                                <% if (myorder.FItemList(i).FCancelyn<>"N") then %>
                                        취소주문
                                    <% else %>
                                    	<em class="<%=myorder.FItemList(i).GetIpkumDivColor%>"><%=myorder.FItemList(i).GetIpkumDivNameNew%></em>
                                    <% end if %>
								</td>
								<td>
                                <% if (myorder.FItemList(i).FCancelyn="N") then %>
				                    	<% if (myorder.FItemList(i).IsWebOrderCancelEnable) or (myorder.FItemList(i).IsWebOrderPartialCancelEnable) then %>
				                    		<a href="/my10x10/order/order_cancel_detail.asp?idx=<%= myorder.FItemList(i).FOrderSerial %>" class="btn btnS2 btnGrylight" onfocus='this.blur()'><span class="fn">주문취소</span></a>
										<% end if %>
	                                	<% if (myorder.FItemList(i).IsWebOrderInfoEditEnable) then %>
				                    		<a href="/my10x10/order/order_info_edit_detail.asp?idx=<%= myorder.FItemList(i).FOrderSerial %>" class="btn btnS2 btnGrylight" onfocus='this.blur()'><span class="fn">주문정보 변경</span></a>
				                    	<% end if %>
										<% if (myorder.FItemList(i).IsWebOrderReturnEnable) then %>
				                    		<a href="/my10x10/order/order_return_detail.asp?idx=<%= myorder.FItemList(i).FOrderSerial %>" class="btn btnS2 btnGrylight" onfocus='this.blur()'><span class="fn">반품접수</span></a>
				                    	<% end if %>
		                         <% end if %>
								</td>
							</tr>
							<% next %>

							<% if myorder.FResultCount < 1 then %>
	                        <tr>
								<td align="center" colspan="6">검색된 주문내역이 없습니다.</td>
            				</tr>
							<% end if %>
							</tbody>
							</table>

							<div class="pageWrapV15 tMar20">
							<%= fnDisplayPaging_New_nottextboxdirect(myorder.FcurrPage, myorder.FtotalCount, myorder.FPageSize, 5, "goPage") %>
							</div>
						</fieldset>
					</div>

					<div class="helpSection">
						<h4><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_help.gif" alt="도움말 HELP" /></h4>
						<ul class="list">
							<li>주문건별 배송상태에 대한 설명입니다. 각 단계에 따라 주문하신 분께 확인메일 및 SMS를 발송해드립니다.</li>
							<li>주문이 정상완료 되지 않으면 내역조회가 되지 않습니다.</li>
							<li>배송조회는 상품이 출고된 날의 익일 오전부터 가능합니다.</li>
							<li>배송 시작일로부터 2일 경과후에도 택배추적이 되지 않을 경우, 고객센터로 연락 부탁드립니다.</li>
						</ul>

						<ol class="orderProcess step5">
							<li class="receipt">
								<strong>결제 대기 중</strong>
								<p>입금을 기다리고 있습니다.<br /> 3일 내 미입금시 자동으로<br /> 주문이 취소됩니다.</p>
							</li>
							<li class="payment">
								<strong>결제 완료</strong>
								<p>주문하신 상품의<br /> 결제가 완료되었습니다.</p>
							</li>
							<li class="inform">
								<strong>상품 확인 중</strong>
								<p>주문이 접수 되었으며<br /> 상품의 재고 및 상태를<br /> 꼼꼼하게 확인합니다.</p>
							</li>
							<li class="preparation">
								<strong>상품 포장 중</strong>
								<p>재고 및 상태 확인 후<br /> 안전한 배송을 위해<br /> 상품을 포장합니다.</p>
							</li>
							<li class="release last">
								<strong>배송 시작</strong>
								<p>포장 완료 후 배송을 위해<br /> 상품이 배송사로<br /> 전달되었습니다.</p>
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
<!-- #include virtual="/lib/db/dbclose.asp" -->
