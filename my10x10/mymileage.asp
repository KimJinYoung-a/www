<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 마일리지 현황"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_money_v1.jpg"
	strPageDesc = "내 마일리지는 얼마나 적립되어 있을까요?"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 마일리지 조회"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/mymileage.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_mileage_logcls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim userid, page, dType, gaparam, rdsite, returnplg
userid  = getEncLoginUserID
page    = requestCheckvar(request("page"),9)
dType   = requestCheckvar(request("dType"),1)
	gaparam    = requestCheckvar(request("gaparam"),32)
	rdsite    = requestCheckvar(request("rdsite"),32)

returnplg="0"
if page="" then page=1
if (dType<>"S") and (dType<>"B") and (dType<>"X") then dType="O"

' 행운의편지 당첨처리	' 2019.10.04 한용민 생성
if userid<>"" then
	' 메일러 타고 들어옴
	if gaparam="tmailer_luckyletter" then	' rdsite="tmailer"
		 returnplg = fnevent_luckyletter_mileage_insert(userid)
		 if returnplg="1" then
		 	response.write "<script type='text/javascript'>"
			response.write "	alert('행운의편지 10,000 마일리지가 발급되었습니다.');"
			response.write "</script>"
		 end if
	end if
end if

dim myMileage
set myMileage = new TenPoint
myMileage.FRectUserID = userid
if (userid<>"") then
    myMileage.getTotalMileage

    Call SetLoginCurrentMileage(myMileage.FTotalmileage)
end if


dim myOffMileage
set myOffMileage = new TenPoint
myOffMileage.FGubun = "my10x10"
myOffMileage.FRectUserID = userid
if (userid<>"") then
    myOffMileage.getOffShopMileagePop
end if

dim myMileageLog
set myMileageLog = New CMileageLog
myMileageLog.FPageSize=10
myMileageLog.FCurrPage= page
myMileageLog.FRectUserid = userid
myMileageLog.FRectMileageLogType = dType

if (userid<>"") and (dType<>"") and (GetLoginUserLevel<>"9") then
	myMileageLog.getMileageLog
end if


''만료예정 기준일
dim baseExpireDate
baseExpireDate = CStr(Year(Now)) + "-12-31"				'// "2013-12-31"

''만료예정  마일리지
dim oExpireMile
set oExpireMile = new CMileageLog
oExpireMile.FRectUserid = userid
oExpireMile.FRectExpireDate = baseExpireDate
if (userid<>"") then
    oExpireMile.getNextExpireMileageSum
end if

dim i,lp

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script>
$(document).ready(function() {
	getEvalMileageUserInfoMyMileage();
});

function Off2On(){
    <% if (myOffMileage.FOffShopMileage<1) then %>
    alert('전환할 마일리지가 없습니다.');
    <% else %>
	var popwin = window.open('/my10x10/Pop_offmile2online.asp','offmile2online','width=560,height=450,scrollbars=no,resizable=no');
	popwin.focus();
	<% end if %>
}

function popExpireMileSummary(yyyymmdd){
    var popwin = window.open('popExpireMileSummary.asp?yyyymmdd=' + yyyymmdd,'popExpireMileSummary','width=520,height=400,scrollbars=yes,resizable=yes');
    popwin.focus();
}

function goPage(pg){
    var frm = document.researchForm;
    frm.page.value = pg;
    frm.submit();
}

<%'적립예상마일리지 호출%>
function getEvalMileageUserInfoMyMileage(){
	$.ajax({
		url: "/my10x10/act_MyUncompletedEvalData.asp",
		cache: false,
		success: function(message) {
			var str;
			str = message.split("||");
			if (str[0]!="Err"){
				$("#mileageCreditAvailableMyMileage").empty().html("<a href='/my10x10/goodsusing.asp'><p>후기 작성시 <em>+"+str[1]+"p</em> 적립</p></a>");
			}
		}
		,error: function(err) {
			//alert(err.responseText);
		}
	});
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_mileage.gif" alt="마일리지 현황" /></h3>
						<ul class="list">
							<li>마일리지는 구매시 적립되는 마일리지와 상품후기작성 등을 통해 적립되는 보너스 마일리지가 있습니다.</li>
							<li>마일리지는 부여된 해로부터 5년 이내에 사용하셔야 합니다.</li>
							<li><em class="crRed">3만원 이상 구매시 현금처럼 사용</em>하실 수 있으며 마일리지샵의 상품을 구매하실 수 있습니다.</li>
							<li>구매마일리지는 <em class="crRed">상품출고 후</em> 적립됩니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<h4>나의 마일리지 현황</h4>
						<div class="myTopic">
							<div class="box">
								<div class="half online">
									<h5>온라인</h5>
									<div class="price">
										<strong><%=FormatNumber(myMileage.FTotalMileage,0) %></strong><span>P</span>
										<span id="mileageCreditAvailableMyMileage"></span>
									</div>
									<ul class="bulletDot">
										<li>구매 마일리지 : <strong><%=FormatNumber(myMileage.FTotJumunmileage + myMileage.FAcademymileage,0) %>P</strong></li>
										<li>사용 마일리지 : <strong><%=FormatNumber(myMileage.FSpendMileage*-1,0) %>P</strong></li>
										<li>보너스 마일리지 : <strong><%=FormatNumber(myMileage.FBonusMileage,0) %>P</strong></li>
										<li>소멸된 마일리지 :<strong><%=FormatNumber(myMileage.FrealExpiredMileage*-1,0) %>P</strong></li>

										<% if (True) then %>
										<li style="width:100%">적립예정 마일리지 : <strong><%=FormatNumber(myMileage.Fmichulmile + myMileage.FmichulmileACA,0) %>P</strong> (상품 출고 후 적립됩니다)</li>
										<% end if %>
									</ul>
								</div>

								<div class="half">
									<h5>오프라인</h5>
									<div class="price"><strong><%=FormatNumber(myOffMileage.FOffShopMileage,0) %></strong><span>P</span></div>
									<div class="btnArea">
										<a href="javascript:Off2On();" class="btn btnS2 btnWhite" title="온라인 마일리지로 전환하기"><span class="fn redArr03">온라인 마일리지로 전환하기</span></a>
									</div>
								</div>
							</div>
						</div>

						<p class="checkpoint"><span class="word"><%= oExpireMile.FOneItem.getKorExpireDateStr %> 소멸 대상 마일리지: <%= FormatNumber(oExpireMile.FOneItem.getMayExpireTotal,0) %> point / 마일리지는 부여된 해로부터 5년 이내에 사용하셔야 합니다.</span> <a href="/my10x10/popExpireMileSummary.asp" onclick="window.open(this.href, 'popExpireMileSummary', 'width=750, height=540, scrollbars=yes'); return false;" title="소멸 대상 마일리지 자세히 보기" class="btn btnS2 btnGry2"><span class="fn">소멸대상 마일리지 보기</span></a></p>

						<div class="etcInfo">
							<h4>마일리지 적립 및 사용내역</h4>
							<ul class="tabMenu addArrow">
								<li><a href="?dType=O" <% if (dType = "O") then %>class="on"<% end if %> title="구매 마일리지 내역보기"><span>구매 마일리지</span></a></li>
								<li><a href="?dType=B" <% if (dType = "B") then %>class="on"<% end if %> title="보너스 마일리지 내역보기">보너스 마일리지</a></li>
								<li><a href="?dType=S" <% if (dType = "S") then %>class="on"<% end if %> title="사용 마일리지 내역보기">사용 마일리지</a></li>
								<% if (now()>"2014-12-22") then %>
								<li><a href="?dType=X" <% if (dType = "X") then %>class="on"<% end if %> title="소멸 마일리지 내역보기">소멸 마일리지</a></li>
							    <% end if %>
							</ul>
							<table class="baseTable tMar15">
							<caption>마일리지 적립 및 사용내역 현황</caption>
							<colgroup>
								<col width="160" /> <col width="160" /> <col width="*" /> <col width="160" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">주문번호</th>
								<% if dType="S" then %>
								    <th scope="col">사용일자</th>
								<% elseif dType="X" then %>
								    <th scope="col">소멸일자</th>
								<% else %>
								    <th scope="col">적립일자</th>
							    <% end if %>
								<th scope="col">적용내용</th>
								<th scope="col">마일리지</th>
							</tr>
							</thead>
							<tbody>
<%
if (myMileageLog.FresultCount > 0) then
	for i = 0 to myMileageLog.FResultCount - 1
%>
							<tr>
								<td><%= myMileageLog.FItemList(i).Forderserial %></td>
								<td><%= Replace(Left(myMileageLog.FItemList(i).FRegdate,10), "-", "/") %></td>
								<td><%= myMileageLog.FItemList(i).Fjukyo %></td>
								<td><%= FormatNumber(myMileageLog.FItemList(i).Fmileage,0) %>P</td>
							</tr>
<%
	next

	if dType="O" then
		if (CStr(myMileageLog.FTotalPage)=CStr(page)) then
			if (myMileage.FOldJumunmileage>0) then
%>
							<tr>
								<td>6개월이전적립합계</td>
								<td></td>
								<td>주문적립</td>
								<td><%= FormatNumber(myMileage.FOldJumunmileage,0) %>P</td>
							</tr>
<%
			end if

			if (myMileage.FAcademyMileage>0) then
%>
							<tr>
								<td>아카데미주문적립</td>
								<td></td>
								<td>주문적립</td>
								<td><%= FormatNumber(myMileage.FAcademyMileage,0) %>P</td>
							</tr>
<%
			end if
		end if
	end if
elseif (myMileage.FOldJumunmileage>0) or (myMileage.FAcademyMileage>0) then
    if dType="O" then  ''2014/12/22 추가
			if (myMileage.FOldJumunmileage>0) then
%>
							<tr>
								<td>6개월이전적립합계</td>
								<td></td>
								<td>주문적립</td>
								<td><%= FormatNumber(myMileage.FOldJumunmileage,0) %>P</td>
							</tr>
<%
			end if

			if (myMileage.FAcademyMileage>0) then
%>
							<tr>
								<td>아카데미주문적립</td>
								<td></td>
								<td>주문적립</td>
								<td><%= FormatNumber(myMileage.FAcademyMileage,0) %>P</td>
							</tr>
<%
			end if
	end if
else
%>
							<tr>
								<td colspan="4">해당 내역이 없습니다.</td>
							</tr>
<%
end if
%>
							</tbody>
							</table>

							<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(myMileageLog.FcurrPage, myMileageLog.FtotalCount, myMileageLog.FPageSize, 10, "goPage") %></div>
						</div>
					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

<form name="researchForm" method="get" action="">
<input type="hidden" name="page" value="">
<input type="hidden" name="dType" value="<%= dType %>">
</form>

</body>
</html>
<%  

set myMileageLog = Nothing
set myMileage = Nothing
set myOffMileage = Nothing
set oExpireMile = Nothing
 
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
