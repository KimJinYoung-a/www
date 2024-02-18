<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 입고 알림 신청 내역"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_interest_v1.jpg"
	strPageDesc = "맘에드는 상품의 재입고 알림을 신청하세요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 입고알림신청내역"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/MyAlarmHistory.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim userid, vPage, vPagesize, sqlStr, vTotalCount, vTotalPage, vResultCount, vLengthSetting
userid      = GetLoginUserID
vPage        = requestCheckVar(request("page"),9)
vPagesize    = requestCheckVar(request("pagesize"),9)
vLengthSetting = requestCheckVar(request("lengthSetting"),10)

If Trim(vLengthSetting)="" Then
	vLengthSetting="m1"
End If
vPageSize = 10
If vPage="" Then vPage=1


sqlStr = ""
sqlStr = sqlStr & " SELECT count(idx) as TotalCnt "
sqlStr = sqlStr & " FROM db_my10x10.[dbo].[tbl_SoldOutProductAlarm] SA WITH (NOLOCK) "
sqlStr = sqlStr & " INNER JOIN db_item.dbo.tbl_item i WITH (NOLOCK) ON SA.itemid = i.itemid "
sqlStr = sqlStr & " LEFT JOIN db_item.dbo.tbl_item_option o WITH (NOLOCK) ON SA.itemid = o.itemid And SA.ItemOptionCode = o.itemoption "
sqlStr = sqlStr & " LEFT JOIN db_user.dbo.tbl_user_c c WITH (NOLOCK) ON i.makerid = c.userid "
sqlStr = sqlStr & " WHERE SA.userid='"&userid&"'  "
Select Case Trim(vLengthSetting)
	Case "d15"
		sqlStr = sqlStr & " 	And SA.LastUpDate >= dateadd(d, -15, getdate()) "
	Case "m1"
		sqlStr = sqlStr & " 	And SA.LastUpDate >= dateadd(m, -1, getdate()) "
	Case "m3"
		sqlStr = sqlStr & " 	And SA.LastUpDate >= dateadd(m, -3, getdate()) "
	Case "prevm3"
		sqlStr = sqlStr & " 	And SA.LastUpDate <= dateadd(m, -3, getdate()) "
End Select
rsget.CursorLocation = adUseClient
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
	vTotalCount = rsget("TotalCnt")
rsget.close
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
$(function(){

});

// 상품목록 페이지 이동
function goPage(pg){
	var frm = document.frmAlarmHistory;
	frm.action="MyAlarmHistory.asp";
	frm.page.value=pg;
	frm.submit();
}

function ChangeLengthAlarm(ls)
{
	location.href='/my10x10/MyAlarmHistory.asp?lengthSetting='+ls
}

function btnCancelCk(idx)
{
	
	if (confirm("신청하신 입고 알림을 취소하시겠습니까?")) {
		$.ajax({
			type:"GET",
			url:"act_MyAlarmHistory.asp?UserId=<%=tenEnc(userid)%>&idx="+idx,
			dataType: "text",
			async:false,
			cache:true,
			success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data=="OK") {
								document.location.reload();
							}
						}
					}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("잘못된 접근 입니다.");
				//var str;
				//for(var i in jqXHR)
				//{
				//	 if(jqXHR.hasOwnProperty(i))
				//	{
				//		str += jqXHR[i];
				//	}
				//}
				//alert(str);
				//document.location.reload();
				return false;
			}
		});
	}
	else {
		return false;
	}
}
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap"><!-- for dev msg: 이전 모든 마이텐바이텐 페이지에 id="my10x10WrapV15" 추가해주세요 -->
	<form name="frmAlarmHistory" method="get">
		<input type="hidden" name="page" value="">
		<input type="hidden" name="lengthSetting" value="<%=vLengthSetting%>">
	</form>

	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<%' for dev msg : my10x10 menu %>
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<%' content %>
				<div class="myContent myStock">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2018/my10x10/tit_stock_list.png" alt="입고 알림 신청 내역" /></h3>
						<ul class="list">
							<li>고객님께서 입고 알림 신청하신 목록으로 선택하신 기간 내에 구매 가능할 경우 알림 메시지를 보내드립니다.<br/ >(PC/모바일 웹은 문자 발송되며, 모바일 앱에서는 신청하신 건은 Push 발송 됩니다. </li>
							<li>알림을 받으신 뒤 구매 시점에 따라 품절이 발생할 수 있으며, 판매가는 신청 지점과 차이가 날 수 있습니다.</li>
						</ul>
					</div>

					<%' 입고 알림신청 내역이 있을경우 %>
					<%
						sqlStr = ""
						sqlStr = sqlStr & " SELECT top " & CStr(vPageSize*vPage) & "SA.idx, SA.itemid, SA.ItemOptionCode, SA.AlarmType,  "
						sqlStr = sqlStr & " 	SA.PlatForm, SA.AlarmTerm, SA.AlarmValue, convert(varchar(10), SA.LastUpDate, 111) as LastUpDate, LimitPushDate, SA.SendPushDate, SA.SendStatus, SA.UserCheckStatus, "
						sqlStr = sqlStr & " 	i.itemname, "
						sqlStr = sqlStr & " 	'http://thumbnail.10x10.co.kr/webimage/image/list/'+  "
						sqlStr = sqlStr & " 	CASE WHEN LEN(CONVERT(VARCHAR(20),(SA.itemid / 10000)))=1 THEN '0'+convert(VARCHAR(20),(SA.itemid / 10000)) ELSE CONVERT(VARCHAR(20),(SA.itemid / 10000)) END+  "
						sqlStr = sqlStr & " 	'/'+i.listimage AS listimage, "
						sqlStr = sqlStr & " 	CASE WHEN o.optionname IS NULL THEN CONVERT(BIT,0) ELSE CONVERT(BIT,1) END AS OptionNameCheck, "
						sqlStr = sqlStr & " 	o.optionname, "
						sqlStr = sqlStr & " 	c.socname, "
						sqlStr = sqlStr & " 	i.makerid "
						sqlStr = sqlStr & " FROM db_my10x10.[dbo].[tbl_SoldOutProductAlarm] SA WITH (NOLOCK) "
						sqlStr = sqlStr & " INNER JOIN db_item.dbo.tbl_item i WITH (NOLOCK) ON SA.itemid = i.itemid "
						sqlStr = sqlStr & " LEFT JOIN db_item.dbo.tbl_item_option o WITH (NOLOCK) ON SA.itemid = o.itemid And SA.ItemOptionCode = o.itemoption "
						sqlStr = sqlStr & " LEFT JOIN db_user.dbo.tbl_user_c c WITH (NOLOCK) ON i.makerid = c.userid "
						sqlStr = sqlStr & " WHERE SA.userid='"&userid&"'  "
						Select Case Trim(vLengthSetting)
							Case "d15"
								sqlStr = sqlStr & " 	And SA.LastUpDate >= dateadd(d, -15, getdate()) "
							Case "m1"
								sqlStr = sqlStr & " 	And SA.LastUpDate >= dateadd(m, -1, getdate()) "
							Case "m3"
								sqlStr = sqlStr & " 	And SA.LastUpDate >= dateadd(m, -3, getdate()) "
							Case "prevm3"
								sqlStr = sqlStr & " 	And SA.LastUpDate <= dateadd(m, -3, getdate()) "
						End Select
						sqlStr = sqlStr & " ORDER BY SA.idx DESC "
						rsget.CursorLocation = adUseClient
						rsget.pagesize = vPageSize
						rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

						vTotalPage =  CInt(vTotalCount\vPageSize)
						if  (vTotalCount\vPageSize)<>(vTotalCount/vPageSize) then
							vTotalPage = vTotalPage +1
						end if

						if Not rsget.Eof then
					%>
					<div class="stock-list">
						<div class="mySection">
							<fieldset>
							<legend>입고알림신청 목록 조회기간</legend>
								<div class="searchField">
									<div class="word">
										<strong>조회기간</strong>
										<span><input type="checkbox" id="day15" onclick="ChangeLengthAlarm('d15');" <% If Trim(vLengthSetting)="d15" Then %> checked="checked" <% End If %> /> <label for="day15" <% If Trim(vLengthSetting)="d15" Then %>class="current"<% End If %>>15일</label></span>
										<span><input type="checkbox" id="onMonth" onclick="ChangeLengthAlarm('m1');" <% If Trim(vLengthSetting)="m1" Then %> checked="checked" <% End If %> /> <label for="onMonth" <% If Trim(vLengthSetting)="m1" Then %>class="current"<% End If %>>1개월</label></span>
										<span><input type="checkbox" id="threeMonth" onclick="ChangeLengthAlarm('m3');" <% If Trim(vLengthSetting)="m3" Then %> checked="checked" <% End If %> /> <label for="threeMonth" <% If Trim(vLengthSetting)="m3" Then %>class="current"<% End If %>>3개월</label></span>
										<span><input type="checkbox" id="beforeThree" onclick="ChangeLengthAlarm('prevm3');" <% If Trim(vLengthSetting)="prevm3" Then %> checked="checked" <% End If %> /> <label for="beforeThree" <% If Trim(vLengthSetting)="prevm3" Then %>class="current"<% End If %>>3개월 이전</label></span>
									</div>
								</div>

								<table class="baseTable">
								<caption>입고알림신청 목록</caption>
								<colgroup>
									<col width="120" /> <col width="50" /> <col width="*;" /> <col width="120" /> <col width="70" /> <col width="90" /> <col width="115" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col">상품코드</th>
									<th scope="col" colspan="2">상품정보</th>
									<th scope="col">신청일</th>
									<th scope="col">신청기간</th>
									<th scope="col">알림방법</th>
									<th scope="col">진행상태</th>
								</tr>
								</thead>
								<tbody>
								<%
									rsget.absolutepage = vPage
									do until rsget.eof
								%>
								<tr>
									<td><a href="/shopping/category_prd.asp?itemid=<%=rsget("itemid")%>" target="_blank"><%=rsget("itemid")%></a></td>
									<td><a href="/shopping/category_prd.asp?itemid=<%=rsget("itemid")%>" target="_blank"><img src="<%=rsget("listimage")%>" alt=""></a></td>
									<td class="lt"><a href="/shopping/category_prd.asp?itemid=<%=rsget("itemid")%>" target="_blank"><%=rsget("itemname")%><% If rsget("OptionNameCheck") Then%><br>옵션 : <%=rsget("OptionName")%><% End If %></a></td>
									<td><%=Left(rsget("LastUpDate"), 10)%></td>
									<td>
										<% If LCase(Trim(rsget("AlarmTerm")))="month" Then %>
											<%=rsget("AlarmValue")%>개월
										<% End If %>
										<% If LCase(Trim(rsget("AlarmTerm")))="day" Then %>
											<%=rsget("AlarmValue")%>일
										<% End If %>
									</td>
									<td>
										<% If LCase(Trim(rsget("AlarmType")))="lms" Then %>
											문자메시지
										<% End If %>
										<% If LCase(Trim(rsget("AlarmType")))="apppush" Then %>
											App Push
										<% End If %>
									</td>
									<td>
										<div id="status<%=rsget("idx")%>">
											<% If LCase(Trim(rsget("SendStatus")))="y" Then %>
												<span class="fn">완료</span>
											<% Else %>
												<% If LCase(Trim(rsget("UserCheckStatus")))="y" Then %>
													<% If Now() >= CDate(rsget("LimitPushDate")) Then %>
														<span class="fn">기간 종료</span>
													<% Else %>
														<span class="fn">신청</span>
														<a href="" onclick="btnCancelCk('<%=rsget("idx")%>');return false;" class="btn btnS1 btnW60 btnWhite3"><span class="fn">알림취소</span></a>
													<% End If %>
												<% Else %>
													<span class="fn">취소</span>
												<% End If %>
											<% End If %>
										</div>
									</td>
								</tr>
								<%
									rsget.movenext
									loop
								%>
								</tbody>
								</table>

								<div class="paging tMar20">
									<%= fnDisplayPaging_New_nottextboxdirect(vPage, vTotalCount, vPageSize, 10, "goPage") %>
								</div>
							</fieldset>
						</div>

						<div class="helpSection">
							<h4><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_help.gif" alt="도움말 HELP" /></h4>
							<ul class="list">
								<li>신청 정보의 [진행상태]는 알림 신청하신 상품의 진행 정보입니다.
									<ul>
										<li>- 신청: 상품 입고 알림 신청하신 상태로 알림을 취소하실 수 있습니다.</li>
										<li>- 완료: 상품이 입고되어 신청하신 알림 방법으로 알림이 완료된 상태입니다. (App Push 알림을 위해 스마트폰의 알림 설정을 확인해주세요.)</li>
										<li>- 취소: 상품 입고 알림 신청 기간 중에 알림을 직접 취소하신 상태입니다.</li>
										<li>- 기간 종료: 상품 입고 알림 신청 기간 내에 상품이 입고되지 않아 알림이 종료된 상태입니다.</li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
					<%
						rsget.close
						Else
					%>
					<%'// 입고 알림신청 내역이 있을경우 %>
						
					<%' 입고 알림신청 내역이 없을경우 %>
					<div class="none-list">
						<div><img src="http://fiximage.10x10.co.kr/web2018/my10x10/ico_none.png" alt="입고 알림 신청 내역" /></div>
						<p><img src="http://fiximage.10x10.co.kr/web2018/my10x10/txt_none_stock_list.png" alt="입고 알림 신청 내역이 없습니다." /></p>
					</div>
					<%'// 입고 알림신청 내역이 없을경우 %>
					<%
						End If
					%>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<iframe name="iframerecookies" src="" width="0" height="0"></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->

