<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/card_qna.asp
' Description : 오프라인샾 point1010 QNA
' History : 2009.07.21 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/offshop/lib/leftmenu/point_loginchk.asp" -->

<%
	If GetLoginUserID() = "" Then
		Response.Write "<script>location.href='point_login.asp?reurl=/offshop/point/card_qna.asp';</script>"
		Response.End
	End If
	
	Dim faqid, idx, sflag	
	Dim ClsOSPoint
	Dim arrPoint, arrNotice, intN
	Dim iTotCnt,iCurrentPage,iPageSize, iPerCnt
	Dim iStartPage, iEndPage, iTotalPage, ix, vSearch
	

	iCurrentPage= requestCheckVar(Request("iCP"),10)
	
	IF iCurrentPage = "" THEN
		iCurrentPage = 1	
	END IF
	
	iPageSize = 10
	iPerCnt	= 10

	set ClsOSPoint = new COffshopPoint1010
		ClsOSPoint.FCPage	= iCurrentPage
		ClsOSPoint.FPSize	= iPageSize
		arrPoint = ClsOSPoint.fnPoint1010QnaList
		iTotCnt = ClsOSPoint.FTotCnt
	set ClsOSPoint = nothing
	
	iTotalPage 	=  Int(iTotCnt/iPageSize)
    IF (iTotCnt MOD iPageSize) > 0 THEN	iTotalPage = iTotalPage + 1

%>

<script language="JavaScript">
function jsGoPage(iP){
	document.frmN.iCP.value = iP;
	document.frmN.submit();	
}

function faq_write()
{
	<% If GetLoginUserID() = "" Then %>
		alert("온라인 로그인을 하세요.");
		return;
	<% Else %>
		location.href = "card_qna_write.asp";
	<% End If %>
}
</script>

<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
<form name="frmN" method="post" action="card_qna.asp">
<input type="hidden" name="iCP" value="">
<tr>
	<td width="170" style="padding-top:41px;" align="center" valign="top">
	<!-- // 왼쪽 메뉴 // -->
	<!-- #include virtual="/offshop/lib/leftmenu/point1010Left.asp" -->
	</td>
	<td width="790" style="padding-top: 30px;" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" width="760" valign="top">
				<table width="730" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub08_tit.gif" height="20" style="margin-left:10px;"></td>
				</tr>
				<tr>
					<td align="center" valign="top">

						<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="230" style="background:url(http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub04_top02.gif) no-repeat;" valign="bottom"></td>
						</tr>
						<tr>
							<td height="330" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
										<%
											IF isArray(arrPoint) THEN
												For intN =0 To UBound(arrPoint,2)
										%>
												<tr>
													<td style="border-bottom:1px solid #eaeaea;" height="27">
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="110" align="center"><span class="date"><%=arrPoint(3,intN)%></span></td>
															<td class="space3px"><a href="card_qna_view.asp?idx=<%=arrPoint(0,intN)%>"><%=db2html(arrPoint(1,intN))%></a></td>
															<td width="70" align="center">
															<% If arrPoint(4,intN) = "N" Then %>
															<img src="http://fiximage.10x10.co.kr/tenbytenshop/ico_no.gif" width="16" height="10"></td>
															<% Else %>
															<img src="http://fiximage.10x10.co.kr/tenbytenshop/ico_yes.gif" width="22" height="10"></td>
															<% End If %>
														</tr>
														</table>
													</td>
												</tr>
										<%
												Next
											Else
										%>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
												<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
												<tr>
													<td style="border-bottom:1px solid #eaeaea;" height="25">
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td align="center">등록하신 글이 없습니다.</td>
														</tr>
														</table>
													</td>
												</tr>
											</td>
										</tr>
										</table>
										<%
											END IF
										%>
										</table>
									</td>
								</tr>
								<tr>
									<td align="center" style="padding-top:15px;">
										<table border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td style="padding-left:80">&nbsp;</td>
											<td width="100%" align="center">
												<%	
												IF isArray(arrPoint) THEN
													Dim vBar
													iStartPage = (Int((iCurrentPage-1)/iPerCnt)*iPerCnt) + 1								
													If (iCurrentPage mod iPerCnt) = 0 Then																
													iEndPage = iCurrentPage
													Else								
													iEndPage = iStartPage + (iPerCnt-1)
													End If	
																	
												%>
													<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td style="padding-right:10px;">
															<%
																if (iStartPage-1 )> 0 then
																	Response.Write "<a href='javascript:jsGoPage(" & iStartPage-1 & ")' class='link_page' onFocus='this.blur();'>&lt;&lt;</a>"
																else
																	Response.Write "<span class='page_off'>&lt;&lt;</span>"
																end if
															%>
														</td>
														<td>
												<%
														for ix = iStartPage  to iEndPage
														if (ix > iTotalPage) then Exit for
														vBar = vBar + 1
			
															If vBar = 1 Then
																Response.Write "<img src='http://fiximage.10x10.co.kr/tenbytenshop/ico_bar.gif' width='1' height='10' hspace='5' align='absmiddle'>"
															End IF
															if Cint(ix) = Cint(iCurrentPage) then
																Response.Write "<a href='javascript:jsGoPage(" & ix & ")' class='link_page_on' onFocus='this.blur();'>" & ix & "</a><img src='http://fiximage.10x10.co.kr/tenbytenshop/ico_bar.gif' width='1' height='10' hspace='5' align='absmiddle'>"
															else	
																Response.Write "<a href='javascript:jsGoPage(" & ix & ")' class='link_page' onFocus='this.blur();'>" & ix & "</a><img src='http://fiximage.10x10.co.kr/tenbytenshop/ico_bar.gif' width='1' height='10' hspace='5' align='absmiddle'>"
															end if
														next
												%>
														</td>
														<td style="padding-left:10px;">
															<%
																if Cint(iTotalPage) > Cint(iEndPage)  then
																	Response.Write "<a href='javascript:jsGoPage(" & ix & ")' class='link_page' onFocus='this.blur();'>&gt;&gt;</a>"
																else	
																	Response.Write "<span class='page_off'>&gt;&gt;</span>"
																end if
															%>
														</td>
													</tr>
													</table>
												<% Else %>
												<table border="0" cellspacing="0" cellpadding="0"><tr><td style="padding-right:10px;"></td><td></td><td style="padding-left:10px;"></td></tr></table>
												<% End If %>
											</td>
											<td align="right"><a href="javascript:faq_write()" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_question2.gif" width="77" height="20"></a></td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						</table>

					</td>
				</tr>
				</table>
			</td>
			<td width="30" valign="top">
				<div style="position:absolute; width:55px; height:95px; top:115px; margin-left:10px;">
				<img src="http://fiximage.10x10.co.kr/tenbytenshop/object_sticker.gif" width="55" height="95">
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>
</form>
</table>
<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->