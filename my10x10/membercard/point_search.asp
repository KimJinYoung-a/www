<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/point_search.asp
' Description : 텐바이텐 멤버쉽 카드 조회/등록/전환
' History : 2017-06-26 유태욱
'##################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/offshop/lib/leftmenu/point_loginchk.asp" -->

<%
	'접속 경로 확인
	dim referer, userid
	userid = getEncLoginUserID

	If userid = "" Then
		Response.Write	"<script type='text/javascript'>" &_
						"alert('잘못된 접속입니다.');" &_
						"</script>"
		dbget.close()	:	response.end
	End If

	Dim iTotCnt,iCurrentPage,iPageSize, iPerCnt
	Dim iStartPage, iEndPage, iTotalPage, ix	
	iCurrentPage= requestCheckVar(Request("iCP"),10)
	
	IF iCurrentPage = "" THEN
		iCurrentPage = 1	
	END IF
	
	iPageSize = 10
	iPerCnt	= 10

	Dim ClsOSPoint, arrPoint, intN
	set ClsOSPoint = new COffshopPoint1010
		ClsOSPoint.FCardNo = vCardNo
		arrPoint = ClsOSPoint.fnGetMyCardPointInfo

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
<!-- #include virtual="/lib/inc/head.asp" -->
<script language="javascript">
function jsGoComPage(iP){
	document.frmN.iCP.value = iP;
	document.frmN.iCTot.value = "<%=iTotCnt%>";
	document.frmN.submit();
}

function fnPopOffCardreg(wd,hi) {
	var popWidth  = wd;
	var popHeight = hi;
	var winWidth  = document.body.clientWidth;
	var winHeight = document.body.clientHeight;
	var winX      = window.screenX || window.screenLeft || 0;
	var winY      = window.screenY || window.screenTop || 0;
	var popupX = (winX + (winWidth - popWidth) / 2)- (wd / 4);
	var popupY = (winY + (winHeight - popHeight) / 2)- (hi / 1.2);
	var popup = window.open("/my10x10/membercard/popRegistMemcard.asp?mode=cardpop&itemid=cardreg","","width="+wd+", height="+hi+", left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);
}

function Off2On(mm){
	if(mm < 1){
    	alert('전환할 마일리지가 없습니다.');
	}else{
		var popwin = window.open('/my10x10/Pop_offmile2online.asp','offmile2online','width=560,height=450,scrollbars=no,resizable=no');
		popwin.focus();
	}
}

function tencardreg(){
	//'카드 발급
	if (confirm('포인트카드를 발급 받으시겠습니까?')){
		var rstStr = $.ajax({
			type: "POST",
			url: "/my10x10/dotentencard.asp",
			dataType: "text",
			async: false
		}).responseText;
		if (rstStr == "0000"){
			alert('포인트카드 발급이 완료 되었습니다');
			document.location.reload();
		}else if(rstStr == "3435"){
			if(confirm("로그인 후 발급 받을 수 있습니다.\n로그인 하시겠습니까?")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
			return false;
		}else if (rstStr == "2101"){
			alert('이미 온라인 카드가 발급되어 있습니다.');
			document.location.reload();
		}else{
			alert('오류가 발생했습니다.');
			document.location.reload();
		}
	}
}

</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap"><!-- for dev msg: 이전 모든 마이텐바이텐 페이지에 id="my10x10WrapV15" 추가해주세요 -->
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap skinBlue">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- for dev msg : my10x10 menu -->
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->

				<!-- content -->
				<div class="myContent">
					<div class="registMembercardV17 ">
						<div class="titleSection">
							<h3><img src="http://fiximage.10x10.co.kr/web2017/memberCard/tit_memeber_card.gif" alt="텐바이텐 멤버십카드" /></h3>
							<ul class="list">
								<li>온/오프라인 어디에서든 사용 가능한 멤버십카드의 발급/등록/조회/마일리지 전환을 하실 수 있습니다.</li>
								<li>멤버십카드에 대한 자세한 내용을 알고싶다면? <a href="/offshop/point/card_service.asp"><strong>텐바이텐 멤버십카드 안내 &gt;</strong></a></li>
							</ul>
						</div>

						<div class="mySection">
						<%
							dim cardgubun
							IF isArray(arrPoint) THEN
								If Left(arrPoint(0,intN),4) = "1010" Then
									cardgubun = "POINT1010"
								ElseIf Left(arrPoint(0,intN),5) = "32531" Then
									cardgubun = "아이띵소(구)"
								Else
									cardgubun = "오프라인(구)"
								End If
						%>
								<div class="after">
									<div class="memberCardList">
										<div class="title">
											<h4>나의 멤버십카드</h4>
										</div>
										<a href="" onclick="fnPopOffCardreg('530','770'); return false;" class="btnregiCard btn btnS2 btnRed fn">카드 등록</a>
										<table class="baseTable tMar10">
										<caption>나의 텐바이텐 멤버십카드</caption>
										<colgroup>
											<col style="width:228px;" /> <col style="width:160px;" /> <col style="width:140px;" /> <col  style="width:157px;" /> <col  style="width:*;" />
										</colgroup>
										<thead>
										<tr>
											<th scope="col">카드정보</th>
											<th scope="col">적립포인트</th>
											<th scope="col">사용포인트</th>
											<th scope="col">잔여포인트</th>
											<th scope="col">온라인 마일리지 전환</th>
										</tr>
										</thead>
										<tbody>
										<% For intN =0 To UBound(arrPoint,2) %>
											<tr>
												<td class="cardInfo">
													<span class="cardImg"><img src="http://fiximage.10x10.co.kr/web2018/memberCard/img_bnr_memcard.png" alt="<%= cardgubun %>" /></span>
													<span><%=arrPoint(0,intN)%> </span>
													<br /><span class="date">등록일 : <%= FormatDate(arrPoint(4,intN),"0000/00/00") %></span>
												</td>
												<td>
													<%
														ClsOSPoint.FCardNo = arrPoint(0,intN)
														ClsOSPoint.FGubun = "plus"
														ClsOSPoint.fnGetMyCardPoint
														Response.Write FormatNumber(ClsOSPoint.FPoint,0)
													%>
												</td>
												<td>
													<%
														ClsOSPoint.FCardNo = arrPoint(0,intN)
														ClsOSPoint.FGubun = "minus"
														ClsOSPoint.fnGetMyCardPoint
														Response.Write FormatNumber(ClsOSPoint.FPoint,0)
													%>
												</td>
												<td class="cRd0V15"><%=FormatNumber(arrPoint(1,intN),0)%></td>
												<td class="transMile"><a href="" onclick="Off2On('<%= arrPoint(1,intN) %>'); return false;" class="btn btnS2 btnGrylight"><span class="fn">마일리지 전환</span></a></td>
											</tr>
										<% next %>
										<!--
										<tr>
											<td colspan="6"><p class="noData fs12"><strong>등록된 10X10 멤버십카드가 없습니다.</strong></p></td>
										</tr>
										-->
										</tbody>
										</table>

										<!-- pagenation
										<div class="pageWrapV15 tMar20">
											<div class="paging">
												<a href="" class="first arrow"><span>맨 처음 페이지로 이동</span></a>
												<a href="" class="prev arrow"><span>이전페이지로 이동</span></a>
												<a href=""><span>1</span></a>
												<a href=""><span>2</span></a>
												<a href=""><span>3</span></a>
												<a href="" class="current"><span>4</span></a>
												<a href=""><span>5</span></a>
												<a href=""><span>6</span></a>
												<a href=""><span>7</span></a>
												<a href=""><span>8</span></a>
												<a href=""><span>9</span></a>
												<a href=""><span>10</span></a>
												<a href="" class="next arrow"><span>다음 페이지로 이동</span></a>
												<a href="" class="end arrow"><span>맨 마지막 페이지로 이동</span></a>
											</div>
										</div>
										 pagenation -->
									</div>


									<!-- 포인트 적립/사용내역 -->
									<div class="pointHistory">
										<div class="title">
											<h4>포인트 적립/사용내역</h4>
										</div>
										<form name="frmN" action="<%=CurrURL()%>" method="post">
										<input type="hidden" name="iCP" value="">
										<input type="hidden" name="iCTot" value="">
										<table class="baseTable tMar10">
											<caption>포인트 적립/사용내역</caption>
											<colgroup>
												<col style="width:145px;" /> <col style="width:210px;" /> <col style="width:150;" /> <col style="width:*;" /> <col style="width:126px;" />
											</colgroup>
											<thead>
											<tr>
												<th scope="col">사용일자</th>
												<th scope="col">카드정보</th>
												<th scope="col">거래구분</th>
												<th scope="col">관련주문번호</th>
												<th scope="col">포인트</th>
											</tr>
											</thead>
											<tbody>
											<%
											IF isArray(arrPointList) THEN
												iTotalPage 	=  Int(iTotCnt/iPageSize)
												IF (iTotCnt MOD iPageSize) > 0 THEN	iTotalPage = iTotalPage + 1
												For intN =0 To UBound(arrPointList,2)
											%>
													<tr>
														<td><%=arrPointList(2,intN)%></td>
														<td><%=arrPointList(1,intN)%></td>
														<td>
														<%
															'### 포인트 0이고 code가 3(포인트이관)일때 카드등록으로 나타냄.
															If arrPointList(5,intN) = "0" AND arrPointList(7,intN) = "3" Then
																Response.Write arrPointList(8,intN)
															Else
																Response.Write arrPointList(3,intN)
															End IF
														%>
														</td>
														<td><%=arrPointList(6,intN)%></td>
														<td class="cRd0V15"><%=FormatNumber(arrPointList(5,intN),0)%></td>
													</tr>
											<%
												next
											else
											%>
												<tr>
													<td colspan="6"><p class="noData fs12"><strong>포인트 적립/사용내역이 없습니다.</strong></p></td>
												</tr>
											<% end if %>
											</tbody>
										</table>
										</form>

										<!-- pagenation -->
										<div class="pageWrapV15 tMar20">
											<%= fnDisplayPaging_New(iCurrentPage,iTotCnt,iPageSize,iPerCnt,"jsGoComPage") %>
										</div>
										<!--// pagenation -->
									</div>
									<!--// 포인트 적립/사용내역 -->
								</div>
							<% else %>
								<div class="before">
									<div class="col regisOnline ftLt">
										<h4>온라인 카드발급</h4>
										<div class="cardImg"><img src="http://fiximage.10x10.co.kr/web2017/memberCard/img_regi_online.jpg" alt="" /></div>
										<p>쇼핑할 때마다 쏟아지는<br />마일리지 포인트를 놓치고 싶지 않다면?<br />바로바로 적립해 현금처럼 사용 가능한<br />10X10 멤버십카드를 만나보세요!</p>
										<div>
											<a href=""  onclick="tencardreg();return false;" class="btnCard1 btn btnCard1 btnRed">카드 발급</a>
											<a href="/offshop/point/card_service.asp" class="btnCard2 btn btnWhite">멤버십카드 안내</a>
										</div>
									</div>
									<div class="col regisOffline ftRt">
										<h4>오프라인 카드발급</h4>
										<div class="cardImg"><a href="" onclick="fnPopOffCardreg('530','770'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/memberCard/img_regi_offline.jpg" alt="" /></a></div>
										<p>이미 가맹점에서 카드를 발급받으셨나요?<br />적립된 포인트 사용 및 본인확인을 위해<br />카드를 등록해주세요</p>
										<div><a href="" onclick="fnPopOffCardreg('530','770'); return false;" class="btnCard1 btn btnCard1 btnRed">카드 등록</a></div>
									</div>
								</div>
							<% end if %>
						</div>
					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% set ClsOSPoint = nothing %>
<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->