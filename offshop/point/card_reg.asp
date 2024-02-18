<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/card_reg.asp
' Description : 오프라인샾 point1010 카드등록
' History : 2009.07.17 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
	If GetLoginUserID() = "" Then
		Response.Write "<script>location.href='point_login.asp?reurl=/offshop/point/card_reg.asp';</script>"
		Response.End
	End If

	Dim arrPoint, intN, ClsOSPoint, vUserID, vRegdate, vRealNameChk, vUseYN, vGubun, vUserSeq, vHaveCardYN, vHaveTotalCardYN
	Dim vHaveOLDCardYN
	vHaveCardYN = "N"
    vHaveOLDCardYN = "N"

	set ClsOSPoint = new COffshopPoint1010
		arrPoint = ClsOSPoint.fnGetUserSilMyung
		vHaveTotalCardYN = ClsOSPoint.FHaveTotalCardYN
	set ClsOSPoint = nothing
    
	IF isArray(arrPoint) THEN
	    if (UBound(arrPoint,2)>0) then vHaveCardYN = "Y"
	    
	    For intN =0 To UBound(arrPoint,2)
			If Left(arrPoint(1,intN),4) <> "1010" Then
			    vHaveOLDCardYN = "Y"
			    Exit For
			end if
	    Next
	End IF
%>


<script language="javascript">

function TnJoin10x10(){
	var frm = document.myinfoForm;

	<% If vHaveTotalCardYN = "N" Then %>
	if (frm.yak1.checked == false){
		alert("POINT1010 이용 약관에 동의를 하셔야 합니다.");
		return ;
	}
	<% End If %>
	
	if (frm.txCard1.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard1.focus();
		return ;
	}
	
	if (frm.txCard2.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard2.focus();
		return ;
	}
	
	if (frm.txCard3.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard3.focus();
		return ;
	}
	
	if (frm.txCard4.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard4.focus();
		return ;
	}
	
	if (frm.cardnochk.value == "x"){
		alert("카드번호 확인을 하세요.");
		return ;
	}
	
	<% If vGubun = "1" Then %>
	if(!chkID){		
		alert("아이디를 확인해주세요");				
	   	DuplicateIDCheck(frm.txuserid);	   	
	   	return;
	}
	<% End If %>
    
	var ret = confirm('카드등록을 하시겠습니까?\n\n*POINT1010카드 재발급시 잔여포인트는 자동으로 이관됩니다.');
	if(ret){
		frm.submit();
	}
}

function jsCardnocheck(){

	var frm = document.myinfoForm;
	
	if (frm.txCard1.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard1.focus();
		return ;
	}
	
	if (frm.txCard2.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard2.focus();
		return ;
	}
	
	if (frm.txCard3.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard3.focus();
		return ;
	}
	
	if (frm.txCard4.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard4.focus();
		return ;
	}
	
	var cardno = frm.txCard1.value + frm.txCard2.value + frm.txCard3.value + frm.txCard4.value;
	iframeDB1.location.href = "iframe_card_check.asp?cardno="+cardno;
}

function TnTabNumber(thisform,target,num) {
   if (eval("document.myinfoForm." + thisform + ".value.length") == num) {
	  eval("document.myinfoForm." + target + ".focus()");
   }
}


</script>

<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td width="170" style="padding-top:41px;" align="center" valign="top"><!-- // 왼쪽 메뉴 // -->
	<!-- #include virtual="/offshop/lib/leftmenu/point1010Left.asp" -->
	</td>
	<td width="790" style="padding-top: 30px;" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<form name="myinfoForm" method="post" action="<%=SSLUrl%>/offshop/point/dojoin.asp" >
		<input type="hidden" name="cardnochk" value="x">
		<tr>
			<td align="right" width="760" valign="top">
				<table width="730" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="20%"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub01_tit.gif" style="margin-left:10px;"></td>
							<td width="80%" align="right">
								<!--
								<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/process01.gif" height="13" hspace="5"></td>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/process_arrow.gif" width="6" height="10" hspace="5"></td>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/process03_on.gif" height="13" hspace="5"></td>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/process_arrow.gif" width="6" height="10" hspace="5"></td>
									<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/process04.gif" height="13" hspace="5"></td>
								</tr>
								</table>
								//-->
							</td>
						</tr>
						</table>
					</td>
				</tr>
				
				
				
				<tr>
					<td style="padding:30 0 15 0;" align="center">
					
						<table width="700" border="0" cellspacing="0" cellpadding="0">
						<% If (vHaveOLDCardYN="Y") Then ''(vHaveTotalCardYN = "N") Then %>
							<% IF isArray(arrPoint) THEN %>
							<tr>
								<td style="padding:0px 0 3px 0;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub01_tit03.gif"></td>
							</tr>
							<tr>
								<td><!--(구)포인트카드가 있는 경우-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
											<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
											<tr>
												<td style="border-bottom:1px solid #eaeaea;" height="25" class="space3px" bgcolor="#f2f2f2">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr align="center">
														<td width="200"><strong>카드구분</strong></td>
														<td align="center"><strong>카드번호</strong></td>
														<td width="150"><strong>등록일</strong></td>
														<td width="150" ><strong>잔여포인트</strong></td>
													</tr>
													</table>
												</td>
											</tr>
											<%
													For intN =0 To UBound(arrPoint,2)
														If Left(arrPoint(1,intN),4) <> "1010" Then
											%>
															<tr>
																<td style="border-bottom:1px solid #eaeaea;" height="25" class="space3px">
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr align="center">
																		<td width="200">
																		<%
																			If Left(arrPoint(1,intN),4) = "1010" Then
																				Response.Write "POINT1010"
																			ElseIf Left(arrPoint(1,intN),5) = "32531" Then
																				Response.Write "아이띵소"
																			Else
																				Response.Write "오프라인"
																			End If
																		%>
																		</td>
																		<td align="center"><%=arrPoint(1,intN)%></td>
																		<td width="150"><%=arrPoint(2,intN)%></td>
																		<td width="150" ><%=FormatNumber(arrPoint(3,intN),0)%></td>
																	</tr>
																	</table>
																</td>
															</tr>
											<%			Else	%>
											<!--
															<tr>
																<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
																	<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
																	<tr>
																		<td style="border-bottom:1px solid #eaeaea;" height="60" class="space3px">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr align="center">
																				<td>발급받으신 (구) 포인트 카드는 통합이 되었습니다.</td>
																			</tr>
																			</table>
																		</td>
																	</tr>
																	</table>
																</td>
															</tr>
											-->
											<%
														End If
														vUserSeq = arrPoint(4,0)
														vHaveCardYN = "Y"
													Next
											%>
											</table>
										</td>
									</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="padding:10 0 50 0">
									<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td>* 구 포인트카드(텐바이텐SHOP카드/아이띵소 카드)는 신규 POINT1010카드 등록시 사용중지되며,</td>
									</tr>
									<tr>
										<td>&nbsp;&nbsp;&nbsp;구 포인트카드의 잔여포인트는 신규 POINT카드로 자동이관됩니다.</td>
									</tr>
									</table>	
								</td>
							</tr>
							<% END IF %>
						<% End If %>
						<% If vHaveTotalCardYN = "Y" Then %>
						<tr>
							<td style="padding:0px 0 3px 0;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub01_tit03_1.gif"></td>
						</tr>
						<tr>
							<td><!--포인트카드가 있는 경우-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
										<tr>
											<td style="border-bottom:1px solid #eaeaea;" height="25" class="space3px" bgcolor="#f2f2f2">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr align="center">
													<td width="200"><strong>카드구분</strong></td>
													<td align="center"><strong>카드번호</strong></td>
													<td width="150"><strong>등록일</strong></td>
													<td width="150" ><strong>잔여포인트</strong></td>
												</tr>
												</table>
											</td>
										</tr>
										<%
											IF isArray(arrPoint) THEN
												For intN =0 To UBound(arrPoint,2)
													If Left(arrPoint(1,intN),4) = "1010" Then
										%>
													<tr>
														<td style="border-bottom:1px solid #eaeaea;" height="25" class="space3px">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr align="center">
																<td width="200">POINT1010</td>
																<td align="center"><%=arrPoint(1,intN)%></td>
																<td width="150"><%=arrPoint(2,intN)%></td>
																<td width="150" ><%=FormatNumber(arrPoint(3,intN),0)%></td>
															</tr>
															</table>
														</td>
													</tr>
										<%
													End If
												Next
												vUserSeq = arrPoint(4,0)
												vHaveCardYN = "Y"
											Else
										%>
													<tr>
														<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
															<table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-top:1px solid #eaeaea;">
															<tr>
																<td style="border-bottom:1px solid #eaeaea;" height="60" class="space3px">
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr align="center">
																		<td>발급받으신 POINT1010 카드가 없습니다.</td>
																	</tr>
																	</table>
																</td>
															</tr>
															</table>
														</td>
													</tr>
										<%	END IF	%>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td style="padding:10 0 50 0">
								<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>* 분실 및 훼손으로 인하여, 신규 POINT1010카드 등록시, 구 포인트카드의 잔여포인트는 신규 POINT1010카드로 자동이관됩니다.</td>
								</tr>
								</table>	
							</td>
						</tr>
						<% End If %>
						<% If vHaveTotalCardYN = "N" Then %>
						<tr>
							<td style="padding:0px 0 3px 0;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub01_tit04.gif" width="177" height="16"></td>
						</tr>
						<tr>
							<td><textarea name="textarea" cols="80" rows="17" style="width:700px;height:80px" class="input_default">
텐바이텐 Point1010 서비스 약관

제1조 (목적)
본 약관은 ㈜텐바이텐 회원이 당사가 제공하는 텐바이텐 포인트1010 서비스를 이용함에 있어 텐바이텐 포인트1010 회원과 당사의 제반 권리의무 및 관련 절차 등을 규정하는데 그 목적이 있습니다.

제2조 (용어의 정의)
1. 텐바이텐 포인트1010 회원(이하 “회원”이라 함)이란 이 약관을 승인하고 당사에 텐바이텐 포인트1010카드의 발급을 신청하여 당사로부터 카드를 발급받아 텐바이텐 포인트1010 홈페이지에 카드를 등록한 회원을 말합니다.
2. 텐바이텐 포인트1010 카드(이하 “카드”라 함)란 회원이 텐바이텐 포인트1010 서비스를 정상적으로 이용할 수 있도록 당사가 승인한 카드로써 텐바이텐 또는 텐바이텐 제휴가맹점에서 발급합니다.
3. 텐바이텐 포인트1010카드 서비스(이하 “서비스”라 함)라 함은 포인트1010카드 회원을 위해 당사가 제공하는 서비스로서 그 개요는 본 약관 3조에 기술한 바와 같습니다.
4. 텐바이텐 포인트1010 가맹점(이하 “가맹점”라 함)이라 함은 당사의 정식 승인을 받은 텐바이텐샵, 아이띵소, 취화선, 카페1010, 핑거스,등 포인트1010 서비스를 제공하기로 업체 또는 점포를 말합니다. 가맹점은 가맹점의 사정에 따라 해지 또는 추가될 수 있으며, 변경 내용 발생시 홈페이지,e-mail을 통해 안내해 드립니다.
5. 텐바이텐 포인트1010 고객센터(이하 “고객센터”라 함)이라 함은 회원의 카드 관련 제반적인 사항에 대한 서비스를 제공하고자 운영하는 콜센터를 말합니다.

제3조 (서비스)
당사가 본 약관에 정해진 바에 따라 회원에게 제공하는 서비스는 아래와 같으며 서비스를 이용하고자 하는 고객은 본 약관에 정해진 제반 절차를 거쳐 회원으로 가입하여야 합니다.
1. 포인트 적립 : 회원은 가맹점에서 상품/서비스를 구입하고 카드를 제시하면 포인트를 적립 받을 수 있습니다. 카드 운영정책에 따라 카드 회원정보에 등록된 정보와 회원이 제시한 정보가 일치할 경우에 한하여 휴대폰 번호 등 회원의 개인정보가 카드를 대신할 수 있습니다.
2. 포인트 사용 : 회원은 적립받은 포인트를 당사 및 각 가맹점에서 정한 기준에 따라 상품/서비스를 구입 시 사용할 수 있습니다. 단, 포인트 사용시에는 반드시 카드를 소지하여야 하며, 카드 운영정책에 따라 비밀번호 등 추가정보를 요청할 수 있습니다.
3. 기타 서비스 : 회원이 가맹점에서 상품/서비스를 구입하고 카드를 제시하였음에도 불구하고 카드 마그네틱 손상 및 단말기, POS, 통신장애 등 인프라 문제로 적립 서비스를 제공 할 수 없는 경우, 매출일로부터 2주 이내에 해당 점포에 재방문하여 적립 받으실 수 있습니다.
당사는 상기 각 호의 서비스 이외에도 추가적인 서비스를 개발하여 회원에게 제공할 수 있습니다.
4. 당사는 서비스의 원활한 제공을 위하여 포인트1010카드 홈페이지(point.10x10.co.kr)(이하 “홈페이지”)를 운영하고 있으며 회원은 홈페이지에서 제공하는 각종 서비스를 이용할 수 있습니다. 단, 홈페이지를 이용하고자 하는 회원은 당사가 정하는 이용자 등록절차를 거쳐야 합니다.

제4조 (약관개정)
1. 본 약관은 수시로 개정될 수 있으며 약관을 개정하고자 할 경우 당사는 개정된 약관을 적용하고자 하는 날(이하 "효력 발생일"이라고 합니다)로부터 30일 이전에 약관이 개정된다는 사실과 개정된 내용 등을 아래에 규정된 방법 중 1가지 이상의 방법으로 회원에게 고지하여 드립니다.
① e-mail통보
② 홈페이지(point.10x10.co.kr) 내 게시
③ 가맹정 내 게시
2. 당사가 e-mail통보의 방법으로 본 약관이 개정된 사실 및 개정된 내용을 회원에게 고지하는 경우에는 회원이 당사에 기제공한 e-mail 주소 중 가장 최근에 제공된 e-mail로 통보합니다.
3. 본 조의 규정에 의하여 개정된 약관(이하 "개정약관")은 원칙적으로 그 효력 발생일로부터 장래를 향하여 유효합니다.
4. 본 약관의 개정과 관련하여 이의가 있는 회원은 회원탈퇴를 할 수 있습니다. 단, 이의가 있음에도 불구하고 본 조 제1항 내지 제2항에 정해진 바에 따른 당사의 고지가 있은 후 30일 이내에 회원탈퇴를 하지 않은 회원은 개정 약관에 동의한 것으로 봅니다.
5. 본 조의 통지방법 및 통지의 효력은 본 약관의 각 조항에서 규정하는 개별적인 또는 전체적인 통지의 경우에 이를 준용합니다.

제5조 (회원가입 및 포인트1010카드 발급)
1. 포인트1010카드는 당사 및 가맹점에서 고객이 요청할 경우 1인당 1매를 발급해 드립니다.
2. 회원으로 가입하고자 하는 고객은 텐바이텐 홈페이지를 통해 텐바이텐 온라인 통합 회원으로 가입 후 본 약관에 동의하고 당사가 발급한 포인트1010카드를 홈페이지에 등록함으로써 회원 가입을 신청합니다. 단, 14세 미만은 회원 가입이 불가합니다.
3. 회원은 회원 자격을 타인에게 양도하거나 대여하거나 담보의 목적물로 이용할 수 없습니다.

제6조 (포인트1010카드의 이용 및 운용)
1. 회원은 가맹점에서 1,000원 이상의 상품/서비스를 구매하고 카드를 제시할 경우, 구매금액(포인트 사용시포인트 결제금을 제외한 결제금액)의 3%를 적립 받을 수 있으며, 적립 포인트가 일정 포인트 이상[현행 3,000포인트 이상이며, 이벤트 및 가맹점의 별도 기준에 따라 달라질 수 있슴] 되었을 경우, 상품/서비스 구매시 현금 대신 사용아실 수 있습니다. (1포인트는 1원에 해당하며, 포인트는 현금으로 환급될 수 없습니다.)
2. 회원은 카드를 타인에게 양도 또는 담보의 목적물로 이용할 수 없습니다.
3. 회원은 카드를 분실하였을 경우 당사에 분실신고를 하실 수 있으며, 그렇지 않아 발생되는 손실에 대한 책임은 모두 회원에게 있습니다.
4. 적립된 포인트의 사용기간은 적립일로부터 5년까지이며, 이 기간 내에 사용하지 않은 포인트는 매년 12월 31일 회사 영업 종료시간에 자동 소멸됩니다.
5. 일부 할인상품 구매 및 증정이벤트/할인이벤트 참여시 포인트는 적립되지 않습니다. 회원은 할인/증정이벤트 참여 또는 포인트 적립 중 하나의 제도를 선택하실 수 있습니다.

제7조 (적립포인트의 관리 및 권리)
1. 가맹점에서 발급받으신 카드이용에 따른 적립포인트는 최초 적립하는 시점부터 누적되어 적용됩니다.
2. 회원의 적립포인트는 회원에게 귀속된 금전적 권리이므로 당사는 이를 제3자에게 담보로 제공하거나 채무에 대한 변제로 충당할 수 없습니다.
3. 포인트 적립에 오류가 있을 경우 회원은 오류 발생 시점부터 30일 이내에 당사에 정정신청을 하여야 하며 당사는 회원의 정정요청일로부터 30일 이내에 조정을 할 수 있습니다. 단, 회원은 이를 증명할 수 있는 구매 영수증이나 기타 자료를 제시하거나 또는 해당 가맹점로부터 명시적인 확인을 받아야 합니다.
4. 적립포인트의 조회는 당사의 홈페이지(point.10x10.co.kr) 또는 각 가맹점에 설치된 POS ,고객센터(1644-6030) 문의를 통해 확인 가능합니다.

제8조 (카드의 분실 및 재발급)
1. 회원이 카드를 분실,하였을 경우 당사 홈페이지 또는 고객센터(1644-6030)를 통해 분실신고를 하여야 하며, 그렇지 않아 발생되는 손실에 대한 책임은 모두 회원에게 있습니다.
2. 카드를 분실,파,훼손하였을 경우 당사 및 가맹점에서 신규 카드를 수령하시고, 당사 홈페이지에서 회원 로그인 후, 신규카드를 등록할 수 있습니다. 이때, 기존카드는 정지되며, 기존카드의 잔여포인트는 신규카드등록시 신규카드로 이관됩니다.

제9조 (회원 탈퇴와 자격상실)
1. 회원은 언제든지 서면, e-mail, 전화, 홈페이지 고객 게시판 등 기타 당사가 정하는 방법으로 회원탈퇴를 요청할 수 있으며, 당사는 회원의 요청에 따라 조속히 회원탈퇴에 필요한 제반 절차를 수행합니다.
2. 회원이 다음 각 호의 사유에 해당하는 경우, 당사는 당해 회원에 대한 통보로써 회원의 자격을 상실시킬 수 있습니다.
① 회원 가입 신청 시에 허위의 내용을 등록한 경우
② 포인트를 부정 적립 또는 부정 사용하는 등 서비스를 부정한 방법 또는 목적으로 이용한 경우
③ 다른 회원의 서비스 이용을 방해하거나 그 정보를 도용하는 경우
④ 서비스 홈페이지를 이용하여 법령, 본 약관 또는 공서양속에 반하는 행위를 하는 경우
⑤ 당사 또는 다른 회원의 명예를 훼손하거나 모욕하는 경우
⑥ 기타 본 약관에 규정된 회원의 의무를 위반한 경우
3. 본 조 제2항의 사유로 자격이 상실된 회원은 제2항의 각 호의 사유가 자신의 고의 또는 과실에 기한 것이 아님을 소명할 수 있습니다. 이 경우 당사는 회원의 소명 내용을 심사하여 회원의 주장이 타당하다고 판단하는 경우 회원으로 하여금 정상적인 서비스를 이용할 수 있도록 합니다.
4. 본 조 제1항에 의한 회원탈퇴 또는 제2항에 의한 회원자격상실이 확정되는 시점은 회원 탈퇴 요청일 또는 회원 자격 상실 통보일에 회원 탈퇴 또는 자격 상실이 확정됩니다.
5. 본 조 제1항에 의해 회원 탈퇴 시 회원 탈퇴 요청일 현재까지 적립된 포인트는 자동으로 소멸되며, 재가입 시 소멸된 포인트는 복원되지 않습니다.
6. 본 조 제2항에 의해 회원 자격이 상실된 경우, 자격 상실일 현재까지 적립된 포인트는 자동으로 소멸됩니다.

제10조 (개인정보 수집)
1. 당사와 가맹점은 회원이 가입 신청을 할 때 제공한 정보와 이후 포인트1010카드를 이용하여 발생시키는 정보를 통하여 개인정보를 수집합니다. 당사 및 가맹점은 이를 분석하여 보다 향상된 서비스를 제공하기 위한 마케팅 활동에 사용합니다.
2. 당사와 가맹점이 회원으로부터 수집하는 개인정보는 회원의 성명, 주민등록번호, 주소, e-mail 주소, 전화번호 등 텐바이텐 온라인 통합 회원 가입 신청시 기재한 개인식별정보와 회원의 서비스 이용 실적을 통해 파악하는 거래정보 입니다.

제11조 (개인정보 이용과 제공)
1. 당사와 가맹점은 서비스를 회원에게 최적화하기 위한 목적과 서비스의 활성화를 통한 고객지향적인 마케팅 수행 및 ‘개인정보취급방침’에 기재된 목적 범위 내에서만 수집된 개인정보를 활용하며, ‘개인정보취급방침’에 기재된 자에게만 개인정보를 제공합니다.
2. 당사와 가맹점는 수집한 개인정보를 당해 회원의 동의 없이 전항에 기재된 목적 범위를 넘어선 용도로 이용하거나 ‘개인정보취급방침’에 기재된 자 이외의 제3자에게 제공할 수 없습니다. 다만, 다음의 경우에는 예외로 합니다.
① 배송업무상 배송업체에게 배송에 필요한 최소한의 회원의 정보(성명, 주소, 전화번호)를 알려주는 경우
② 통계작성 연구 또는 마케팅 활동 등을 위하여 필요한 경우로서 특정 개인을 알아볼 수 없는 형태로 가공하여 제공하는 경우
③ 회원으로부터 사전 공개 동의를 받은 경우
3. 당사는 포인트 결제 및 정산 등을 위하여 회원의 개인정보, 포인트1010카드 발급, 이용 및 포인트 관련 정보 등을 가맹점에 제공하거나 가맹점로부터 제공받을 수 있습니다.

제12조 (개인정보 보유 및 이용 기간)
1. 당사와 가맹점은 수집된 회원의 개인정보를 회원이 회원 자격을 유지하고 있을 때까지만 보유하고 이용할 수 있습니다. 만약, 회원이 탈퇴하거나 자격을 상실할 경우 당사와 가맹점은 회원의 별도 요청이 없을 경우라도 수집된 회원정보를 삭제 및 파기하기로 합니다.
2. 전항에도 불구하고 상법, 전자금융거래법 등 관련 법령에 의하여 회원의 거래 내용 확인 등을 이유로 일정 기간 동안 보유할 필요가 있는 경우 당사와 가맹점은 관련 법령이 정한 회원의 정보를 보유할 수 있습니다.

제13조 (개인정보보호를 위한 회원의 권리)
1. 회원은 회원 탈퇴를 함으로써 언제든지 본 약관 제10조 및 제11조에 의한 동의를 철회할 수 있습니다.
2. 회원은 당사가 고지한 개인정보관리책임자를 통하여 당사에 대하여 자신의 개인정보에 대한 열람을 요구할 수 있으며, 자신의 개인정보에 오류가 있는 경우에는 그 정정을 요구할 수 있습니다.
3. 당사는 회원으로부터 본조 제1항의 규정에 의한 동의 철회 및 본조 제2항의 규정에 의한 열람 및 정정 요구를 받은 경우에는 지체 없이 필요한 조치를 취하도록 합니다.

제14조 (서비스의 변경)
1. 회원에게 제공되는 포인트 및 기타 카드 관련 서비스는 당사의 영업 정책이나 가맹점의 사정에 따라 변경될 수 있으며, 그 내용은 변경하고자 하는 날로부터 30일 이전에 본 약관 제4조 제1항에 규정된 통지 방법을 준용하여 회원에게 알려드립니다.
2. 전항의 통지한 서비스 변경일 이후 당사 및 가맹점이 포인트 적립율을 변경할 경우 회원은 변경된 포인트 적립율에 의하여 포인트 적립 혜택을 받으며, 포인트 사용 기준이 변경될 경우 변경된 사용 기준에 의해 포인트를 사용할 수 있습니다.

제15조 (서비스의 종료)
1. 포인트1010카드 서비스를 중단하고자 할 때, 당사는 중단시점 최소 3개월 이전에 본 약관 제4조에 의거하여 회원에게 통보하며, 당사는 적극적인 포인트 사용을 촉진하는 활동을 합니다.
2. 포인트1010카드 서비스의 종료기준일은 회원에게 송부된 게시물에 명시된 일자로 합니다. 포인트1010카드 서비스 종료일까지 사용되지 않은 포인트는 소멸됩니다.

제16조 (변경사항의 통지)
회원은 당사에 제공한 개인정보와 관련하여 변경사항이 있는 경우에는 지체 없이 당사에 그 변경사실을 통하여야 하며, 이를 태만히 함으로써 발생한 일체의 손해에 대하여 당사는 어떠한 책임도 지지 않습니다.

제17조 (본 약관에서 정하지 않은 사항)
본 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 관계 법령 및 상관례에 따릅니다.

제18조 (약관 위반 시 책임)
본 약관을 위반함으로써 발생하는 모든 책임은 위반한 자가 부담하며, 이로 인하여 상대방에게 손해를 입힌 경우에는 배상하여야 합니다.

제19조 (분쟁조정 및 관할법원)
본 약관에 따른 분쟁의 조정은 일반 상관례에 따라 회원과 당사가 상호 협의하여 결정하되 합의가 안될 경우에는 본 약관에 관련되어 회사가 고객에게 소송을 제기하는 경우에는 고객의 주소지를 관할하는 법원을, 고객이 회사에게 소송을 제기하는 경우에는 회사의 주된 사업장 소재지를 제1심의 전속적 관할법원으로 합니다.

(부칙)
2009년 8월 1일부터 시행합니다. 

								</textarea></td>
						</tr>
						<tr>
							<td align="right" style="padding-bottom:50">
								<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="padding:4px 5px 0 0;"><strong>이용 약관에 동의 합니다.</strong></td>
									<td><input type="checkbox" name="yak1"></td>
								</tr>
								</table>
							</td>
						</tr>
						<% End IF %>
						<tr>
							<td style="padding-bottom:3px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub01_tit07.gif" width="150" height="16"></td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border-bottom:1px solid #e0e0e0; border-top: 1px solid #e0e0e0;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px solid #eaeaea; border-top: 1px solid #eaeaea;">
										<tr>
											<td width="150" height="24" style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px"><font class="red_bold">카드번호</font></span></td>
											<td width="550" style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input type="text" name="txCard1" class="input_default" style="width:60px;" maxlength="4" onKeyUp="TnTabNumber('txCard1','txCard2','4')">
													-
													<input type="text" name="txCard2" id="[on,off,1,4][카드번호2]" class="input_default" style="width:60px;" maxlength="4" onKeyUp="TnTabNumber('txCard2','txCard3','4')">
													-
													<input type="text" name="txCard3" id="[on,off,1,4][카드번호3]" class="input_default" style="width:60px;" maxlength="4" onKeyUp="TnTabNumber('txCard3','txCard4','4')">
													-
													<input type="text" name="txCard4" id="[on,off,1,4][카드번호4]" class="input_default" style="width:60px;" maxlength="4"></td>
													<td style="padding-left:5px;"><a href="javascript:jsCardnocheck();" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_card.gif" width="64" height="19"></a></td>
												</tr>
												</table>
											</td>
										</tr>
										<input type="hidden" name="txuserid" value="<%=vUserID%>">
										<input type="hidden" name="havetotalcardyn" value="<%=vHaveTotalCardYN%>">
										<input type="hidden" name="havecardyn" value="<%=vHaveCardYN%>">
										<input type="hidden" name="userseq" value="<%=vUserSeq%>">
										<input type="hidden" name="RealCardNo" value="">
										<tr>
											<td style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">이메일 수신여부</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td style="padding-top:10px;">
														<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="350">POINT1010(텐바이텐가맹점)의 이메일 서비스를 받아보시겠습니까?</td>
																	<td style="padding-left:10px;">
																		<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="padding-bottom:2px;"><input type="radio" name="email_point1010" value="Y" checked></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="email_point1010" value="N"></td>
																			<td style="padding-left:2px;">아니오</td>
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
										<tr>
											<td style="border-bottom:solid 1px #eaeaea;" bgcolor="#f5f5f5" class="space3px"><span class="margin20px">문자메세지 수신여부</span></td>
											<td style="border-bottom:solid 1px #eaeaea; padding-left:20px;">
												<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td style="padding-top:10px;">
														<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="350">POINT1010(텐바이텐가맹점)의 SMS 문자서비스를 받아보시겠습니까?</td>
																	<td style="padding-left:10px;">
																		<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="padding-bottom:2px;"><input type="radio" name="smsok_point1010" value="Y" checked></td>
																			<td style="padding-left:2px;">예</td>
																			<td style="padding:0 0 2px 15px;"><input type="radio" name="smsok_point1010" value="N"></td>
																			<td style="padding-left:2px;">아니오</td>
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
						</tr>
						</table>

					</td>
				</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center">
						<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="padding-top:10px;"><a href="javascript:TnJoin10x10()" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/btn_regicard.gif"></a></td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</td>
			<td width="30" valign="top"><div style="position:absolute; width:55px; height:95px; top:115px; margin-left:10px;"> <img src="http://fiximage.10x10.co.kr/tenbytenshop/object_sticker.gif" width="55" height="95"> </div></td>
		</tr>
		</form>
		</table>
	</td>
</tr>
</table>

<iframe name="iframeDB1" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" onload="resizeIfr(this, 10)"></iframe>
<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
