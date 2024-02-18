<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/card_faq_view.asp
' Description : 오프라인샾 point1010 FAQ 보기
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
		Response.Write "<script>alert('로그인을 하세요.');location.href='point_login.asp?reurl=/offshop/point/card_qna.asp';</script>"
		Response.End
	End If
	
	Dim vAction
	vAction = requestCheckVar(Request("action"),6)
	If vAction = "insert" Then
		Call Proc()
	End If
	
	Dim faqid, idx, sflag	
	Dim ClsOSPoint
	Dim arrPoint, arrNotice, intN
	Dim iTotCnt,iCurrentPage,iPageSize, iPerCnt
	Dim iStartPage, iEndPage, iTotalPage, ix, vSearch
	
	idx 		= requestCheckVar(Request("idx"),10)
	IF iCurrentPage = "" THEN
		iCurrentPage = 1	
	END IF
	
	iPageSize = 10
	iPerCnt	= 10

	set ClsOSPoint = new COffshopPoint1010
		ClsOSPoint.FCPage	= iCurrentPage
		ClsOSPoint.FPSize	= iPageSize
		ClsOSPoint.FIDX		= idx
		arrPoint = ClsOSPoint.fnPoint1010QnaList
		iTotCnt = ClsOSPoint.FTotCnt
	set ClsOSPoint = nothing
	
	iTotalPage 	=  Int(iTotCnt/iPageSize)
    IF (iTotCnt MOD iPageSize) > 0 THEN	iTotalPage = iTotalPage + 1

%>

<script language="JavaScript">
function faq_write()
{
	<% If GetLoginUserID() = "" AND vCardNo = "" Then %>
		alert("온라인 로그인을 하세요.");
		return;
	<% Else %>
		location.href = "card_qna_write.asp";
	<% End If %>
}

function qna_delete()
{
	if(confirm("선택하신 글을 삭제하시겠습니까?") == true) {
		frm1.submit();
		return true;
     } else {
     	return false;
     }
}
</script>

<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
<form name="frm1" method="post" action="<%=CurrURL()%>">
<input type="hidden" name="action" value="insert">
<input type="hidden" name="idx" value="<%=idx%>">
</form>
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
							<%
								IF isArray(arrPoint) THEN
									For intN =0 To UBound(arrPoint,2)
							%>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
										<tr>
											<td style="border-bottom:1px solid #eaeaea;" height="25">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="110" align="center" class="date" style="padding-top:3px;"><%=arrPoint(3,intN)%></td>
													<td style="padding-top:3px;"><%=db2html(arrPoint(1,intN))%></td>
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
										<tr>
											<td style="border-bottom:1px solid #eaeaea;" height="270" valign="top">
												<div style="position:absolute; height:270px;width:700px; overflow-y: auto; padding:25px 0;border-bottom:1px solid #eaeaea;">
												<table width="650" border="0" cellspacing="0" cellpadding="0" align="center">
												<tr>
													<td style="padding-top:15px;"><%=Replace(db2html(arrPoint(2,intN)),vbCrLf,"<br>")%></td>
												</tr>
												<% If arrPoint(4,intN) <> "N" Then %>
												<tr>
													<td style="padding-top:20px;">
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr bgcolor="#f2f2f2">
															<td width="35" align="right" valign="top" style="padding:10px 5px 0 0;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/ico_reply.gif" width="18" height="16"></td>
															<td valign="top" style="padding:15px 0;" class="222"><%=Replace(db2html(arrPoint(5,intN)),vbCrLf,"<br>")%></td>
														</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td style="padding-top:15px"><img src="http://fiximage.10x10.co.kr/tenbytenshop/ico_del.gif" onClick="qna_delete()" style="cursor:pointer"></td>
												</tr>
												<% End If %>
												</table>
												</div>
											</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td style="padding-top:10px">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="50%"><a href="card_qna.asp" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_list.gif" width="40" height="18"></a></td>
											<td width="50%" align="right">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td style="padding-left:5px;"><a href="javascript:faq_write()" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_question2.gif" width="77" height="20"></a></td>
												</tr>
												</table>
											</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							<%
									Next
								END IF
							%>
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
</table>

<%
Function Proc()
	Dim ClsOSPoint, vIDX
	vIDX = requestCheckVar(Request("idx"),10)

	set ClsOSPoint = new COffshopPoint1010
		ClsOSPoint.FIDX	= vIDX
		ClsOSPoint.fnPoint1010QnaDelete
	set ClsOSPoint = nothing
	
	Response.Write "<script>alert('삭제되었습니다.');location.href='card_qna.asp';</script>"
	dbget.close
	Response.End
End Function
%>

<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->