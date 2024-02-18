<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/point_search.asp
' Description : 오프라인샾 point1010 포인트 조회
' History : 2009.07.17 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->
<!-- #include virtual="/offshop/lib/leftmenu/point_loginchk.asp" -->

<%
	If GetLoginUserID() = "" Then
		Response.Write "<script>location.href='point_login.asp?reurl=/offshop/point/point_search.asp';</script>"
		Response.End
	End If
	
	Dim ClsOSPoint, arrPoint, intN
	set ClsOSPoint = new COffshopPoint1010
		ClsOSPoint.FCardNo = vCardNo
		arrPoint = ClsOSPoint.fnGetMyCardPointInfo
		
	Dim iTotCnt,iCurrentPage,iPageSize, iPerCnt
	Dim iStartPage, iEndPage, iTotalPage, ix	
	iCurrentPage= requestCheckVar(Request("iCP"),10)
	
	IF iCurrentPage = "" THEN
		iCurrentPage = 1	
	END IF
	
	iPageSize = 10
	iPerCnt	= 10
%>

<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
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
					<td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub06_tit.gif" style="margin-left:10px;"></td>
				</tr>
				<tr>
					<td style="padding:30px 0;" align="center">
						<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub06_tit01.gif" width="66" height="16"></td>
						</tr>
						<tr>
							<td style="padding-top:10px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
										<tr>
											<td style="border-bottom:1px solid #eaeaea;" height="25" class="space3px" bgcolor="#f2f2f2">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr align="center">
													<td width="90"><strong>구분</strong></td>
													<td align="center"><strong>카드번호</strong></td>
													<td width="90" ><strong>현재포인트</strong></td>
													<td width="90"><strong>적립포인트</strong></td>
													<td width="90"><strong>사용포인트</strong></td>
													<!--
													<td width="90"><strong>소멸된포인트</strong></td>
													<td width="90"><strong>소멸예정포인트</strong></td>
													//-->
												</tr>
												</table>
											</td>
										</tr>
										<%
											IF isArray(arrPoint) THEN
												For intN =0 To UBound(arrPoint,2)
										%>
										<tr>
											<td style="border-bottom:1px solid #eaeaea;" height="25" class="space3px">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr align="center">
													<td width="90">
													<%
														If Left(arrPoint(0,intN),4) = "1010" Then
															Response.Write "POINT1010"
														ElseIf Left(arrPoint(0,intN),5) = "32531" Then
															Response.Write "아이띵소(구)"
														Else
															Response.Write "오프라인(구)"
														End If
													%>
													</td>
													<td align="center"><%=arrPoint(0,intN)%></td>
													<td width="90" ><%=FormatNumber(arrPoint(1,intN),0)%></td>
													<td width="90">
													<%
														ClsOSPoint.FCardNo = arrPoint(0,intN)
														ClsOSPoint.FGubun = "plus"
														ClsOSPoint.fnGetMyCardPoint
														Response.Write FormatNumber(ClsOSPoint.FPoint,0)
													%>
													</td>
													<td width="90">
													<%
														ClsOSPoint.FCardNo = arrPoint(0,intN)
														ClsOSPoint.FGubun = "minus"
														ClsOSPoint.fnGetMyCardPoint
														Response.Write FormatNumber(ClsOSPoint.FPoint,0)
													%>
													</td>
													<!--
													<td width="90">10,000</td>
													<td width="90">10,000</td>
													//-->
												</tr>
												</table>
											</td>
										</tr>
										<%
												Next
											End If
										%>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td style="padding-top:10px;"><span class="red"></span></td>
						</tr>
						<tr>
							<td style="padding-top:30px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<%
									Dim vGoPoint, arrPointList
									vGoPoint = Request("cardgubun")
									If vGoPoint = "" Then
										vGoPoint = "1010"
									End If
																
									ClsOSPoint.FCPage	= iCurrentPage
									ClsOSPoint.FPSize	= iPageSize
									ClsOSPoint.FCardNo 	= vCardNo
									ClsOSPoint.FGubun 	= vGoPoint
									arrPointList = ClsOSPoint.fnGetMyCardPointList
									iTotCnt = ClsOSPoint.FTotCnt
								%>
								<script language="javascript">
								function goPoint()
								{
									frmN.submit();
								}
								function jsGoPage(iP){
									document.frmN.iCP.value = iP;
									document.frmN.submit();	
								}
								</script>
								<form name="frmN" action="<%=CurrURL()%>" method="post">
								<input type="hidden" name="iCP" value="">
								<tr>
									<td width="50%"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub06_tit02.gif" width="136" height="16"></td>
									<td width="50%" align="right">
									<!--
									<select name="cardgubun" onChange="goPoint(this.value)" class="input_default" style="width:100px; height:19px;">
										<option value='1010' >POINT1010</option>
										<option value='3253' >아이띵소</option>
										<option value='othe' >오프라인</option>
									</select>
									//-->
									</td>
								</tr>
								</form>
								</table>
							</td>
						</tr>
						<tr>
							<td style="padding-top:10px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
										<tr>
											<td style="border-bottom:1px solid #eaeaea;" height="25" class="space3px" bgcolor="#f2f2f2">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr align="center">
													<!--td width="140"><strong>지점명</strong></td -->
													<td width="180" align="center"><strong>회원카드번호</strong></td>
													<td width="110" ><strong>사용일자</strong></td>
													<td width="130"><strong>거래구분</strong></td>
													<!--<td width="70"><strong>거래금액</strong></td>//-->
													<td width="90"><strong>포인트</strong></td>
													<td ><strong>관련주문번호</strong></td>
												</tr>
												</table>
											</td>
										</tr>
										<%
											IF isArray(arrPointList) THEN
												iTotalPage 	=  Int(iTotCnt/iPageSize)
											    IF (iTotCnt MOD iPageSize) > 0 THEN	iTotalPage = iTotalPage + 1
											    	
												For intN =0 To UBound(arrPointList,2)
										%>
												<tr>
													<td style="border-bottom:1px solid #eaeaea;" height="25" class="space3px">
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr align="center">
															<!-- td width="140">
															<%
																If arrPointList(0,intN) = "" Then
																	Response.Write "온라인가입"
																Else
																	Response.Write fnGetShopName(arrPointList(0,intN))
																End IF
															%>
															</td -->
															<td width="180" align="center"><%=arrPointList(1,intN)%></td>
															<td width="110" ><%=arrPointList(2,intN)%></td>
															<td width="130">
															<%
																'### 포인트 0이고 code가 3(포인트이관)일때 카드등록으로 나타냄.
																If arrPointList(5,intN) = "0" AND arrPointList(7,intN) = "3" Then
																	Response.Write arrPointList(8,intN)
																Else
																	Response.Write arrPointList(3,intN)
																End IF
															%>
															</td>
															<!--<td width="70"><%=FormatNumber(arrPointList(4,intN),0)%></td>//-->
															<td width="90"><%=FormatNumber(arrPointList(5,intN),0)%></td>
															<td ><%=arrPointList(6,intN)%>&nbsp;</td>
														</tr>
														</table>
													</td>
												</tr>
										<%
												Next
											Else
										%>
												<tr>
													<td style="border-bottom:1px solid #eaeaea;" height="25" class="space3px">
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr align="center">
															<td align="center">포인트 적립 및 사용내역이 없습니다.</td>
														</tr>
														</table>
													</td>
												</tr>
										<%
											End If
										%>
										</table>
									</td>
								</tr>
								<tr>
									<td align="center" style="padding-top:15px;">
									<%	
									IF isArray(arrPointList) THEN
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
									<% End If %>
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
<% set ClsOSPoint = nothing %>
<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->