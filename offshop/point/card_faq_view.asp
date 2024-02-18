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

<%
	Dim faqid, idx, sflag	
	Dim ClsOSPoint
	Dim arrPoint, arrNotice, intN
	Dim iTotCnt,iCurrentPage,iPageSize, iPerCnt
	Dim iStartPage, iEndPage, iTotalPage, ix, vSearch
	
	faqid		= requestCheckVar(Request("faqid"),10)
	idx 		= requestCheckVar(Request("idx"),10)
	sflag 		= "1"
	iCurrentPage= requestCheckVar(Request("iCP"),10)
	vSearch		= requestCheckVar(Request("searchtxt"),100)
	
	IF iCurrentPage = "" THEN
		iCurrentPage = 1	
	END IF
	
	iPageSize = 10
	iPerCnt	= 10

	set ClsOSPoint = new COffshopPoint1010
		ClsOSPoint.FCPage	= iCurrentPage
		ClsOSPoint.FPSize	= iPageSize
		ClsOSPoint.FFAQIDX	= faqid
		ClsOSPoint.FSearch	= vSearch
		arrPoint = ClsOSPoint.fnGetPointFAQ
		iTotCnt = ClsOSPoint.FTotCnt
	set ClsOSPoint = nothing
	
	iTotalPage 	=  Int(iTotCnt/iPageSize)
    IF (iTotCnt MOD iPageSize) > 0 THEN	iTotalPage = iTotalPage + 1

%>

<script language="JavaScript">
var HitArr = new Array();

function CheckHit(faqId){
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
	}
}

function showhideFAQ(num, p_totcount, faqId)	{

  for (i=0; i<p_totcount; i++)   {
	  menu=eval("document.all.FAQblock"+i+".style");
	  
	  if (num==i ){
		if (menu.display=="block"){
			menu.display="none";
		}else{
		  menu.display="block";
		  CheckHit(faqId);
		}
	  }else{
		 menu.display="none";
	  }
	}
}

function jsGoPage(iP){
	document.frmN.iCP.value = iP;
	document.frmN.submit();	
}

function faq_write()
{
	<% If GetLoginUserID() = "" Then %>
		location.href='point_login.asp?reurl=/offshop/point/card_qna_write.asp';
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
													<td style="padding-left:10px;"><input type="text" name="textfield" id="textfield" class="input_default" style="width:330px;" value="ex) 카드발급,포인트,적립 등"></td>
													<td style="padding-left:5px;"><a href="#" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_search.gif" width="60" height="19"></a></td>
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
												<%
													IF isArray(arrPoint) THEN
														For intN =0 To UBound(arrPoint,2)
												%>
												<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
												<tr>
													<td style="border-bottom:1px solid #eaeaea;" height="25">
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="80" align="center"><span class="date"><%=idx%></span></td>
															<td class="space3px"><strong><%=arrPoint(1,intN)%></strong></td>
															<td width="100" align="center"><span class="date"><%=arrPoint(3,intN)%></span></td>
														</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td style="border-bottom:1px solid #eaeaea;" height="240" valign="top">
														<div style="position:absolute; height:240px;width:700px; overflow-y: auto; padding:25px 0; border-bottom:1px solid #eaeaea;">
														<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
														<tr>
															<td><%=Replace(db2html(arrPoint(2,intN)),vbCrLf,"<br>")%></td>
														</tr>
														</table>
														</div>
													</td>
												</tr>
												</table>
												<%
														Next
													END IF
												%>
											</td>
										</tr>
										<tr>
											<td align="center" style="padding-top:10px;">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="50%"><a href="card_faq.asp?searchtxt=<%=vSearch%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_list.gif" width="40" height="18"></a></td>
													<td width="50%" align="right">
														<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td class="space3px"><span class="red_bold">답변이 충분하지 않으신가요?</span></td>
															<td style="padding-left:5px;"><a href="javascript:faq_write()" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_question.gif" width="77" height="20"></a></td>
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