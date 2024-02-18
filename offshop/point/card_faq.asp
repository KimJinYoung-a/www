<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/card_faq.asp
' Description : 오프라인샾 point1010 FAQ
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
	Dim idx, sflag	
	Dim ClsOSPoint
	Dim arrPoint, arrNotice, intN, vSearch
	Dim iTotCnt,iCurrentPage,iPageSize, iPerCnt
	Dim iStartPage, iEndPage, iTotalPage, ix	
	
	idx 		= requestCheckVar(Request("iN"),10)
	sflag 		= "1"
	iCurrentPage= requestCheckVar(Request("iCP"),10)
	vSearch		= requestCheckVar(Request("searchtxt"),100)

	'//html 팅
	if (checkNotValidHTML(vSearch) = True) then
		Alert_return("검색어는 HTML을 사용하실 수 없습니다.")
	End if
	
	IF iCurrentPage = "" THEN
		iCurrentPage = 1	
	END IF
	
	iPageSize = 10
	iPerCnt	= 10

	set ClsOSPoint = new COffshopPoint1010
		ClsOSPoint.FCPage	= iCurrentPage
		ClsOSPoint.FPSize	= iPageSize
		ClsOSPoint.FSearch	= vSearch
		arrPoint = ClsOSPoint.fnGetPointFAQ
		iTotCnt = ClsOSPoint.FTotCnt
	set ClsOSPoint = nothing
	
	iTotalPage 	=  Int(iTotCnt/iPageSize)
    IF (iTotCnt MOD iPageSize) > 0 THEN	iTotalPage = iTotalPage + 1

%>

<script language="JavaScript">
var HitArr = new Array();

function CheckHit(faqId,idx){
    for (var i=0;i<HitArr.length;i++){
        if (HitArr[i]==faqId) return;
    }
    
    HitArr.length = HitArr.length +1;
    HitArr[HitArr.length] = faqId;
//    document.all["FaqCnt"].src="/cscenter/faq/process_faqhit.asp?faqid=" + faqId;

	if (faqId)
	{
		var url = "/cscenter/faq/process_faqhit.asp?faqid=" + faqId;
		var xmlHttp = createXMLHttpRequest();
		xmlHttp.open("GET", url, true);	
		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
		xmlHttp.setRequestHeader("Pragma", "no-cache");
		xmlHttp.send(null);
		
		location.href = "card_faq_view.asp?faqid="+faqId+"&idx="+idx+"&searchtxt=<%=vSearch%>";
	}
}

function jsGoPage(iP){
	document.frmN.iCP.value = iP;
	document.frmN.submit();	
}

function faq_search()
{
	if(frmN.searchtxt.value == "" || frmN.searchtxt.value == "ex) 카드발급,포인트,적립 등")
	{
		alert('검색어를 입력하세요.');
		valuedelete();
		frmN.searchtxt.focus();
		return;
	}
	frmN.submit();
}

function valuedelete()
{
	if(frmN.searchtxt.value == "ex) 카드발급,포인트,적립 등")
	{
		frmN.searchtxt.value = "";
	}
	frmN.searchtxt.focus();
}

function faq_write()
{
	<% If GetLoginUserID() = "" Then %>
		location.href='point_login.asp?reurl=/offshop/point/card_qna_write.asp';
		return;
	<% Else %>
		location.href = "card_qna_write.asp";
	<% End If %>
}
</script>

<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
<form name="frmN" method="post" action="card_faq.asp">
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
					<td align="center" valign="top">
						<table width="730" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub04_tit.gif" width="42" height="20" style="margin-left:10px;"></td>
						</tr>
						<tr>
							<td align="center">
								<table width="700" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td height="192"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub04_top01_link.gif" width="700" height="192" border="0" usemap="#Map"></td>
                                </tr>
								<tr>
									<td valign="bottom">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="35" bgcolor="#f0f0f0" style="border: 1px solid #e2e2e2;" align="center">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub04_tit02.gif" width="56" height="15"></td>
													<td style="padding-left:10px;"><input type="text" name="searchtxt" onClick="valuedelete()" class="input_default" style="width:330px;" value="<% If vSearch = "" Then %>ex) 카드발급,포인트,적립 등<% Else Response.Write vSearch End If %>"></td>
													<td style="padding-left:5px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_search.gif" width="60" height="19" onClick="faq_search();" style="cursor:pointer"></td>
												</tr>
												</table>
											</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td height="330" valign="top" style="padding-top:30px;">
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
																	<td width="80" align="center"><span class="date"><%=(iTotCnt - iPageSize * (iCurrentPage-1) - intN)%></span></td>
																	<td class="space3px"><a href="javascript:CheckHit('<%= arrPoint(0,intN) %>','<%=(iTotCnt - iPageSize * (iCurrentPage-1) - intN)%>');"><%=arrPoint(1,intN)%></a></td>
																	<td width="100" align="center"><span class="date"><%=arrPoint(3,intN)%></span></td>
																</tr>
																</table>
															</td>
														</tr>
												<%
														Next
													END IF
												%>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center" style="padding-top:10px;">
												<table border="0" cellspacing="0" cellpadding="0" width="100%">
												<tr>
													<td width="77"></td>
													<td align="center">
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
													<!-- 페이지넘버 테이블 END -->
													</td>
													<td width="77"><a href="javascript:faq_write()" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_question.gif" width="77" height="20"></a></td>
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
<map name="Map">
  <area shape="rect" coords="376,130,457,148" href="/offshop/point/card_qna_write.asp" onFocus="blur()">
</map>
<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->