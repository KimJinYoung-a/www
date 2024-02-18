<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 내가 신청한 서비스"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_service_v1.jpg"
	strPageDesc = "교환, 반품, 주문변경 등을 조회할수 있습니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 내가 신청한 서비스"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/order/order_cslist.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
Dim IsBiSearch   : IsBiSearch   = False   '''비회원 주문인가.

dim i,lp
dim page

page = requestCheckvar(request("page"), 32)
if (page="") then page = 1


dim userid
userid = getEncLoginUserID

dim mycslist
set mycslist = new CCSASList

mycslist.FPageSize = 10
mycslist.FCurrpage = page
mycslist.FRectUserID = userid

dim orderSerial	: orderSerial = requestCheckvar(req("orderSerial",""), 11)
dim divCd		: divCd = requestCheckvar(req("divCd",""), 32)

if IsUserLoginOK() then
    mycslist.FRectOrderserial	= orderSerial
    mycslist.FRectDivCd			= divCd

    mycslist.GetCSASMasterList
elseif IsGuestLoginOK() then
	orderserial = GetGuestLoginOrderserial()
    mycslist.FRectOrderserial = orderserial
    mycslist.FRectDivCd			= divCd

	mycslist.GetCSASMasterList
	IsBiSearch = True
end if


dim currstatecolor
dim popJsName

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script>

function goPage(page){
    location.href="?page=" + page;
}

function popMyOrderNo() {
	var f = document.frmOrdSearch;
	var url = "/my10x10/orderPopup/popMyOrderNo.asp?frmname=" + f.name + "&targetname=" + f.orderserial.name;
	window.open(url,'popMyOrderNo','width=750,height=565,scrollbars=yes,resizable=yes');
}

function popCsDetail(idx) {
	var url = "/my10x10/orderPopup/popCsDetail.asp?CsAsID="+idx;
	var popwin = window.open(url,'popCsDetail','width=735,height=600,scrollbars=yes,resizable=yes');
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_service.gif" alt="내가 신청한 서비스" /></h3>
						<ul class="list">
							<li>고객님이 신청하신 CS 처리 리스트입니다.</li>
							<li>주문번호를 선택하시거나 신청하신 서비스 목록을 선택하시면 좀더 편리하게 신청한 서비스 내용을 찾으실 수 있습니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<fieldset>
							<legend>주문번호 검색</legend>
							<div class="searchField orderNo">
								<div class="word">
									<form name="frmOrdSearch" style="margin:0;">
									<input type="hidden" name="itemid">
									<strong>주문번호</strong>
									<input type="text" name="orderserial" value="<%= orderserial %>" readOnly maxlength="11" class="iText" />
								</div>
								<div class="option">
									<% if (Not IsBiSearch) then %>
									<a href="javascript:popMyOrderNo()" title="주문 검색" class="btn btnS2 btnRed">주문검색</a>
									<% end if %>
								</div>
							</div>

							<div class="productInfo">
								<div class="myservice">
									<p><strong><%=mycslist.FtotalCount%>건의 서비스가 검색되었습니다.</strong></p>
									<select name="divCd" title="서비스 선택 옵션" class="optSelect" onchange="this.form.submit();">
										<option value="">전체서비스</option>
										<option value="">----------------</option>
										<option value="A008" <% if (divCd = "A008") then %>selected<% end if %>>주문취소</option>
										<option value="A900" <% if (divCd = "A900") then %>selected<% end if %>>주문내역변경</option>
										<option value="">----------------</option>
										<option value="CHGO" <% if (divCd = "CHGO") then %>selected<% end if %>>교환출고</option>
										<option value="RCVU" <% if (divCd = "RCVU") then %>selected<% end if %>>교환회수(업체배송)</option>
										<option value="RCVT" <% if (divCd = "RCVT") then %>selected<% end if %>>교환회수</option>
										<option value="">----------------</option>
										<option value="A004" <% if (divCd = "A004") then %>selected<% end if %>>반품접수(업체배송)</option>
										<option value="A010" <% if (divCd = "A010") then %>selected<% end if %>>회수신청</option>
										<option value="">----------------</option>
										<option value="A001" <% if (divCd = "A001") then %>selected<% end if %>>누락재발송</option>
										<option value="A002" <% if (divCd = "A002") then %>selected<% end if %>>서비스발송</option>
										<option value="A003" <% if (divCd = "A003") then %>selected<% end if %>>환불요청</option>
										<option value="A007" <% if (divCd = "A007") then %>selected<% end if %>>카드/이체취소요청</option>
									</select>
								</div>
								</form>
								<table class="baseTable">
								<caption>내가 신청한 서비스 목록</caption>
								<colgroup>
									<col width="100" /> <col width="200" /> <col width="*" /> <col width="100" /> <col width="90" /> <col width="125" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col">주문번호</th>
									<th scope="col">서비스 구분</th>
									<th scope="col">접수 제목</th>
									<th scope="col">접수일자</th>
									<th scope="col">상태</th>
									<th scope="col">상세보기</th>
								</tr>
								</thead>
								<tbody>
								<%
								if mycslist.FResultCount > 0 then
									for i = 0 to (mycslist.FResultCount - 1)
								%>
								<tr>
									<td><a href="javascript:popCsDetail('<%=mycslist.FItemList(i).Fid%>');" title="서비스 상세보기"><%= mycslist.FItemList(i).Forderserial %></a></td>
									<td><%= mycslist.FItemList(i).FdivcdName %></td>
									<td class="lt"><a href="javascript:popCsDetail('<%=mycslist.FItemList(i).Fid%>');" title="서비스 상세보기"><%= mycslist.FItemList(i).Fopentitle %></a></td>
									<td><%= Replace(Left(mycslist.FItemList(i).Fregdate, 10), "-", "/") %></td>
									<td>
										<% if (mycslist.FItemList(i).Fcurrstate = "B007") and Not IsNull(mycslist.FItemList(i).Ffinishdate) then %>
										<div><em class="crRed">완료</em></div>
										<div><em class="crRed"><%= Replace(Left(mycslist.FItemList(i).Ffinishdate, 10), "-", "/") %></em></div>
										<% else %>
										진행중
										<% end if %>
									</td>
									<td>
										<a href="javascript:popCsDetail('<%=mycslist.FItemList(i).Fid%>');" title="서비스 상세보기" class="btn btnS2 btnGrylight"><span class="fn">상세내역 보기</span></a>
									</td>
								</tr>
								<%
									next
								else
								%>
								<tr>
									<td colspan="6">신청하신 서비스 내역이 없습니다.</td>
								</tr>
								<%
								end if
								%>
								</tbody>
								</table>

								<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(mycslist.FcurrPage, mycslist.FtotalCount, mycslist.FPageSize, 10, "goPage") %></div>
							</div>
						</fieldset>
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

set mycslist = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
