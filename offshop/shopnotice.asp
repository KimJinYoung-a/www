<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/shopping/offshopcls.asp" -->
<!-- #include virtual="/offshop/inc/offshopCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/offshop/inc/commonFunction.asp" -->
<%
'##################################################
' PageName : /offshop/ shopnotice.asp
' Description : 오프라인숍 메인
' History : 2018.06.12 정태훈 리뉴얼
'##################################################
%>
<%
'매장 정보 가져오기
Dim offshopinfo, shopid
shopid = requestCheckVar(request("shopid"),16)
'Response.write shopid
'Response.end
Set  offshopinfo = New COffShop
offshopinfo.FRectShopID=shopid
offshopinfo.GetOneOffShopContents

Dim idx, sflag
Dim ClsOSBoard
Dim arrNoticeCont, arrNotice, intN
Dim iTotCnt,iCurrentPage,iPageSize, iPerCnt
Dim iStartPage, iEndPage, iTotalPage, vCSS

idx 		= requestCheckVar(Request("iN"),10)
sflag 		= "1"
iCurrentPage= requestCheckVar(Request("iCP"),10)
iTotCnt		= requestCheckVar(Request("iTC"),10)

IF iCurrentPage = "" THEN
	iCurrentPage = 1
END IF

iPageSize = 10
iPerCnt	= 10

If isNumeric(iCurrentPage) = False Then
	Response.Write "<script>alert('잘못된 경로입니다.');history.back();</script>"
	dbget.close()
	Response.End
End If

set ClsOSBoard = new COffshopBoard
	ClsOSBoard.FCPage	= iCurrentPage
	ClsOSBoard.FPSize	= iPageSize
	ClsOSBoard.FShopId = shopid
	arrNotice = ClsOSBoard.fnGetNotice
	iTotCnt = ClsOSBoard.FTotCnt
set ClsOSBoard = nothing

iTotalPage 	=  Int(iTotCnt/iPageSize)
IF (iTotCnt MOD iPageSize) > 0 THEN	iTotalPage = iTotalPage + 1
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
$(function() {
	// control board list
	$(".board-list .specific-conts").hide();
	<% If iCurrentPage < 2 Then %>
	$(".board-list tr:nth-child(2)").show();
	<% End If %>


});

function showhideNotice(num, p_totcount)	{
	for (i=0; i<=p_totcount; i++)   {
		menu=eval("document.all.Noticeblock"+i+".style");
		if (num==i ){
			if (menu.display=="table-row"){
				menu.display="none";
			}else{
				menu.display="table-row";
			}
		}
		else{
			menu.display="none";
		}
	}
}

function jsGoPage(iP){
	document.frmN.iCP.value = iP;
	document.frmN.submit();
}

function jsViewImg(v){
	  var w;
	  w = window.open("/common/showimage.asp?img=" + v, "imageView", "status=no,resizable=yes,scrollbars=yes");
	  w.focus();
}
</script>
</head>
<body>
<div class="wrap fullEvt">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container offshopV18">
		<div id="contentWrap">
			<!-- #include virtual="/offshop/inc/incHeader.asp" -->
			<div class="offshop-conts offshop-noti">

				<!-- 공지 및 이벤트 리스트 -->
				<div class="board-list">
					<h3>오프라인매장 공지 및 이벤트</h3>
					<table>
					<form name="frmN" method="post" action="shopnotice.asp">
					<input type="hidden" name="iCP" value="">
					<input type="hidden" name="shopid" value="<%=shopid%>">
					<input type="hidden" name="menuid" value="<%=menuid%>">
						<colgroup>
							<col width="160" /> <col width="*" /> <col width="140" />
						</colgroup>
						<tbody>
							<%
								If isArray(arrNotice) Then
									For intN =0 To UBound(arrNotice,2)

									If DateDiff("d",arrNotice(6,intN),Now()) < 7 Then '최근등록 1일이내 - new 이미지
										vCSS = "class='link_black11pxb'"
									End If
							%>
							<tr onclick="javascript:showhideNotice('<%= intN %>','<%= UBound(arrNotice,2) %>')">
								<td><%=fnGetNoticeGubun(arrNotice(2,intN),"2")%></td>
								<td class="tit lt"><%=db2html(arrNotice(3,intN))%></td>
								<td class="fs13"><%=FormatDate(arrNotice(6,intN),"0000.00.00")%></td>
							</tr>
							<tr class="specific-conts lt" id="Noticeblock<%= intN %>">
								<td colspan="3">
									<p>
										<% If IsNull(arrNotice(8,intN)) = "True" Then '진영 추가 2012-09-21 %>
										<%=nl2br(db2html(arrNotice(7,intN)))%>
										<% Else %>
										<%=nl2br(db2html(arrNotice(7,intN)))%>
										<% End If %>
									</p>
									<% If arrNotice(8,intN) <> "" Then %>
									<div class="thumb"><img src="http://webimage.10x10.co.kr/contimage/offshopevent/<%=arrNotice(8,intN)%>" alt="<%=db2html(arrNotice(7,intN))%>"></div>
									<% End If %>
								</td>
							</tr>
							<%
									Next
								End If
							%>
						</tbody>
					</form>
					</table>
					<div class="pagingV18 tMar30">
						<%
							iStartPage = (Int((iCurrentPage-1)/iPerCnt)*iPerCnt) + 1
							If (iCurrentPage mod iPerCnt) = 0 Then
							iEndPage = iCurrentPage
							Else
							iEndPage = iStartPage + (iPerCnt-1)
							End If

							if (iStartPage-1 )> 0 then
								Response.Write "<a href='javascript:jsGoPage(" & iStartPage-1 & ")' class='first arrow'></a>"
							else
								Response.Write "<a class='first arrow'></a>"
							end if

							If iTotalPage = 0 Then
								Response.Write "<a href='' class='current'><span>1</span></a>"
							End If
							For ix = iStartPage To iEndPage
								If (ix > iTotalPage) Then Exit For
								If Cint(ix) = Cint(iCurrentPage) Then
									Response.Write "<a href='javascript:jsGoPage(" & ix & ")' class='current' onFocus='this.blur();'><span>" & ix & "</span></a>"
								Else
									Response.Write "<a href='javascript:jsGoPage(" & ix & ")' onFocus='this.blur();'><span>" & ix & "</span></a>"
								End If
							Next

							If Cint(iTotalPage) > Cint(iEndPage)  Then
								Response.Write "<a href='javascript:jsGoPage(" & ix & ")' class='end arrow' onFocus='this.blur();'></a>"
							Else
								Response.Write "<a class='end arrow'></a>"
							End If
						%>

					</div>
				</div>
				<!--// 공지 및 이벤트 리스트 -->

				<!-- for dev msg 매장별 썸네일 최신 3장-->
				<svg width="100%" height="280" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 1140 540" preserveAspectRatio="xMidYMid slice" class="svgBlur">
					<filter id="svgBlurFilter">
						<feGaussianBlur in="SourceGraphic" stdDeviation="1.6" />
					</filter>
					<% If isArray(arrMainGallery) Then %>
					<image xlink:href="<%=arrMainGallery(0,0)%>" x="0" y="0"  filter="url(#svgBlurFilter)" />
					<% End If %>
				</svg>
				<!--// for dev msg 매장별 썸네일 최신 3장-->

			</div>
		</div>
	</div>
</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

</body>
</html>
<% Set  offshopinfo = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->