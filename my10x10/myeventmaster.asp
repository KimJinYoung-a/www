<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	Description : 이벤트 당첨 안내
'	History	:  2013.09.16; 허진원 2013리뉴얼
'#######################################################

	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 이벤트 당첨안내"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_service_v1.jpg"
	strPageDesc = "참여한 이벤트를 확인 할 수 있습니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 내가 참여한 이벤트"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/myeventmaster.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/cscenter/eventprizeCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
Dim clsEvtPrize, arrList, intLoop, vGubun, vWinnerOX, strGoUrl
Dim iTotCnt
Dim iPageSize, iCpW, iCpJ ,iDelCnt
Dim iStartPage, iEndPage, iTotalPage, ix,iPerCnt
Dim arreventkind, arrevtprizetype
dim userid: userid = getEncLoginUserID ''GetLoginUserID

arreventkind = fnSetCommonCodeArr("eventkind", False)
arrevtprizetype = fnSetCommonCodeArr("evtprizetype", False)

iCpW	 	= NullFillWith(requestCheckVar(Request("icw"),10),1)	'당첨 페이지 번호
iCpJ	 	= NullFillWith(requestCheckVar(Request("icj"),10),1)	'참여 페이지 번호
vGubun		= NullFillWith(RequestCheckVar(request("gubun"),1),"e")
vWinnerOX	= NullFillWith(RequestCheckVar(request("winnerox"),1),"")

iPageSize = 10		'한 페이지의 보여지는 열의 수
iPerCnt = 10		'보여지는 페이지 간격
%>
<script type="text/javascript">
function jsPrizePage(iP){
	document.frmPrize.iCw.value = iP;
	document.frmPrize.submit();
}
function jsJoinPage(iP){
	document.frmPrize.iCj.value = iP;
	document.frmPrize.submit();
}

//배송지 입력
function PopOpenEventSongjangEdit(id){
	if(id==""){return;}
	var popwin = window.open('/my10x10/myeventmasteredit.asp?id=' + id, 'PopOpenEventSongjangEdit', 'width=640,height=700,location=no,menubar=no,resizable=no,status=no,toolbar=no');
	popwin.focus();
}

//배송지 입력
function PopOpenEventSongjangView(id){
	if(id==""){return}
	var popwin = window.open('/my10x10/myeventmasterView.asp?id=' + id, 'PopOpenEventSongjangEdit', 'width=640,height=580,location=no,menubar=no,resizable=no,status=no,toolbar=no');
	popwin.focus();
}

//참여이벤트 필터링
function jsChgOpt(gb,ox){
	document.frmPrize.gubun.value=gb;
	document.frmPrize.winnerox.value=ox;
	document.frmPrize.iCj.value='';
	document.frmPrize.submit();
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
				<%
					'//////////////////////
					'// 당첨 이벤트 목록 //
					'//////////////////////
					set clsEvtPrize  = new CEventPrize
						clsEvtPrize.FUserid = getLoginuserid
						clsEvtPrize.FCPage 	= iCpW		'현재페이지
						clsEvtPrize.FPSize 	= iPageSize		'페이지 사이즈
						arrList = clsEvtPrize.fnGetEventPrizeList
						iTotCnt = clsEvtPrize.FTotCnt

						iTotalPage =   int((iTotCnt-1)/iPageSize) +1  '전체 페이지 수
				%>
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_event.gif" alt="당첨안내" /></h3>
						<ul class="list">
							<li>당첨공지 후 해당 이벤트 확인 기간 내에 [확인]을 꼭 해주세요.</li>
							<li>[배송지 입력하기] 버튼이 있는 이벤트의 경우, 클릭하셔서 배 송지를 지정 해 주세요.</li>
							<li>최근 6개월간 참여하신 이벤트는 리스트로 확인 가능합니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<h4>당첨 이벤트 리스트</h4>
						<table class="baseTable myQna" style="height:80px;">
						<caption>당첨 이벤트 목록</caption>
						<colgroup>
							<col width="120" /> <col width="*" /> <col width="90" /> <col width="110" /> <col width="90" /> <col width="120" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">이벤트명</th>
							<th scope="col">당첨일</th>
							<th scope="col">확인하기</th>
							<th scope="col">상태</th>
							<th scope="col">비고</th>
						</tr>
						</thead>
						<tbody>
					<%
						IF isArray(arrList) THEN
							For intLoop =0 To UBound(arrList,2)
								clsEvtPrize.FPrizeType	= arrList(2,intLoop)
								clsEvtPrize.FStatus     = arrList(4,intLoop)
								clsEvtPrize.FSongjangid = arrList(5,intLoop)
								clsEvtPrize.FSongjangno = arrList(6,intLoop)
								clsEvtPrize.FPCode		= arrList(0,intLoop)
								clsEvtPrize.FreqDeliverDate = arrList(10,intLoop)
								clsEvtPrize.fnSetStatus

								strGoUrl = GetEventURLLink(arrList(1,intLoop),arrList(9,intLoop),arrList(8,intLoop),arrList(11,intLoop),arrList(12,intLoop),arrList(7,intLoop))
					%>
						<tr>
							<td><%=fnGetCommCodeArrDesc(arreventkind,arrList(1,intLoop))%></td>
							<td class="lt"><%=strGoUrl%></td>
							<td><%=Replace(formatdate(arrList(3,intLoop),"0000/00/00"),"1900/01/01","&nbsp;")%></td>
							<td><%=clsEvtPrize.FConfirm%></td>
							<td><em class="crRed"><%=clsEvtPrize.FStatusDesc%></em></td>
							<td><%IF arrList(6,intLoop)<>"" THEN%><%= GetEventSongjangURL(arrList(14,intLoop), arrList(6,intLoop)) %><%END IF%></td>
						</tr>
					<%
							Next
						Else
					%>
						<tr>
							<td colspan="6"><p class="noData"><strong>당첨된 내역이 없습니다.</strong></p></td>
						</tr>
					<%	End IF %>
						</tbody>
						</table>
						<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(iCpW, iTotCnt, iPageSize, 10, "jsPrizePage") %></div>
				<%
					set clsEvtPrize  = Nothing

					'//////////////////////
					'// 참여 이벤트 목록 //
					'//////////////////////
					set clsEvtPrize  = new CEventPrize
						clsEvtPrize.FGubun		= vGubun
						clsEvtPrize.FCPage 		= iCpj	'현재페이지
						clsEvtPrize.FPSize 		= iPageSize		'페이지 사이즈
						clsEvtPrize.FUserid 	= getLoginuserid
						clsEvtPrize.FWinnerOX	= vWinnerOX
						arrList = clsEvtPrize.fnGetEventJoinList
						iTotCnt = clsEvtPrize.FTotCnt

						iTotalPage =   int((iTotCnt-1)/iPageSize) +1  '전체 페이지 수
				%>
						<h4>참여 이벤트 리스트</h4>
						<div class="sorting bPad15">
							<ul class="tabMenu addArrow">
								<li><a href="" onclick="jsChgOpt('e','<%=vWinnerOX%>');return false;" <%=chkIIF(vGubun="e","class=""on""","")%>><span>인조이 이벤트</span></a></li>
								<!--<li><a href="" onclick="jsChgOpt('f','<%=vWinnerOX%>');return false;" <%=chkIIF(vGubun="f","class=""on""","")%>><span>디자인핑거스</span></a></li>-->
								<li><a href="" onclick="jsChgOpt('c','<%=vWinnerOX%>');return false;" <%=chkIIF(vGubun="c","class=""on""","")%>><span>Culture Station</span></a></li>
							</ul>
							<div class="option">
								<select name="winnerox" title="참여 이벤트 진행상태 선택 옵션" class="optSelect" style="width:98px;" onChange="jsChgOpt('<%=vGubun%>',this.value)">
									<option value="">당첨발표</option>
									<option value="Y" <%=chkIIF(vWinnerOX="Y","selected","")%>>발표완료</option>
									<option value="N" <%=chkIIF(vWinnerOX="N","selected","")%>>발표이전</option>
								</select>
							</div>
						</div>

						<table class="baseTable">
						<caption>참여 이벤트 목록</caption>
						<colgroup>
							<col width="120" /> <col width="*" /> <col width="90" /> <col width="110" /> <col width="110" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">이벤트명</th>
							<th scope="col">상태</th>
							<th scope="col">당첨일</th>
							<th scope="col">당첨발표</th>
						</tr>
						</thead>
						<tbody>
					<%
						IF isArray(arrList) THEN
							For intLoop =0 To UBound(arrList,2)

							'GetEventURLLink(eType,gCd,eCd,lnkTp,lnkUrl,przNm)
							If vGubun="e" Then
								strGoUrl = GetEventURLLink(arrList(1,intLoop),arrList(0,intLoop),arrList(0,intLoop),arrList(6,intLoop),arrList(7,intLoop),arrList(2,intLoop))
							ElseIf vGubun="f" Then
								strGoUrl = GetEventURLLink(11,arrList(0,intLoop),arrList(0,intLoop),"","",arrList(2,intLoop))
							Else
								strGoUrl = GetEventURLLink(5,arrList(0,intLoop),arrList(0,intLoop),"","",arrList(2,intLoop))
							end if
					%>
						<tr>
							<td>
							<%
								If vGubun="e" Then
									Response.Write fnGetCommCodeArrDesc(arreventkind,arrList(1,intLoop))
								ElseIf vGubun="f" Then
									Response.Write "디자인핑거스"
								else
									Response.Write "컬쳐스테이션"
								end if
							%>
							</td>
							<td class="lt"><%=strGoUrl%></td>
							<td><%=arrList(3,intLoop)%></td>
							<td><%=Replace(formatdate(arrList(4,intLoop),"0000/00/00"),"1900/01/01","&nbsp;")%></td>
							<td><%=chkIIF(arrList(5,intLoop)="Y","<em class=""crRed"">발표완료</em>","<em class=""crMint"">발표이전</em>")%></td>
						</tr>
					<%
							Next
						Else
					%>
						<tr>
							<td colspan="5"><p class="noData"><strong>참여하신 이벤트가 없습니다.</strong></p></td>
						</tr>
					<%	End if %>
						</tbody>
						</table>

						<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(iCpj, iTotCnt, iPageSize, 10, "jsJoinPage") %></div>
				<%
					set clsEvtPrize  = Nothing
				%>
					</div>

				</div>
				<!--// content -->
			</div>
		</div>
		<form name="frmPrize" method="post" action="<%=CurrURL()%>">
		<input type="hidden" name="iCw" value="<%=iCpW%>">
		<input type="hidden" name="iCj" value="<%=iCpJ%>">
		<input type="hidden" name="gubun" value="<%=vGubun%>">
		<input type="hidden" name="winnerox" value="<%=vWinnerOX%>">
		</form>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
