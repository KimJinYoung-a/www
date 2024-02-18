<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual ="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual ="/lib/classes/membercls/specialcornerCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'####### 회원등급 재조정 #######
Call getDBUserLevel2Cookie()
'####### 회원등급 재조정 #######

	'//for Developers
	'//commlib.asp, tenEncUtil.asp는 head.asp에 포함되어있으므로 페이지내에 넣지 않도록 합시다.

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 우수회원 전용코너"		'페이지 타이틀 (필수)
	strPageDesc = "마이텐바이텐 - 우수회원 전용코너"		'페이지 설명
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim userid: userid = getEncLoginUserID ''GetLoginUserID
Dim userlevel, iCurrpage, iPageSize, iPerCnt, cSpchance, arrList, iTotCnt, iTotalPage, intLoop


	userlevel = GetLoginUserLevel
	'### 레벨이 없거나, 오렌지(5)거나, 옐로우(0), 그린(1) 일때 0으로 지정. 블루(2),VIP(3),Staff(7),Mania(4),Friends(8)
	If userlevel = "" OR userlevel = 5 OR userlevel = 0 OR userlevel = 1 Then
		userlevel = 0
	End If


	'파라미터값 받기 & 기본 변수 값 세팅
	iCurrpage 	= requestCheckVar(Request("iC"),10)	'현재 페이지 번호


	IF iCurrpage = "" THEN	iCurrpage = 1

	iPageSize = 6		'한 페이지의 보여지는 열의 수
	iPerCnt = 10		'보여지는 페이지 간격

	If userlevel > 0 Then
		'데이터 가져오기
		set cSpchance = new CVip
		cSpchance.FCurrPage 		= iCurrpage		'현재페이지
		cSpchance.FPageSize 		= iPageSize		'페이지 사이즈
		cSpchance.GetVipCornerList	'리스트 가져오기
		iTotCnt = cSpchance.FTotalCount 			'배너리스트 총 갯수
		iTotalPage =   int((iTotCnt-1)/iPageSize) +1  '전체 페이지 수
	End If



%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
<!--

	$(function(){
		$('.spcEvtWrap li:nth-child(odd)').addClass('oddEvt');
		$('.spcEvtWrap li:nth-child(even)').addClass('evenEvt');
	});

	function jsGoUrl(scT, disp){
		self.location.href = "/my10x10/special_corner.asp?scT=" +scT + "&disp="+disp;
	}

	function jsGoPage(iP){
		document.frmSC.iC.value = iP;
		document.frmSC.submit();
	}



//-->
</script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap skinBlue">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent specialShopV15">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_special_shop.png" alt="우수회원 전용코너" /></h3>
						<ul class="list">
							<li>텐바이텐 우수회원 전용 코너 입니다.</li>
							<li>각종 시크릿 이벤트 진행 시 공지 해 드립니다.</li>
						</ul>
					</div>
					<% If userlevel > 0 Then %>
						<% IF iTotalPage > 0 THEN %>
							<div class="mySection">
								<!-- 우수회원 전용코너 -->
								<div class="spcEvtWrap">
									<ul>
										<% For intLoop=0 To (cSpchance.FTotalCount-1) %>
											<li>
												<a href="/event/eventmain.asp?eventid=<%=cSpchance.FItemList(intLoop).FevtCode%>">
													<p><img src="<%=webImgUrl&"/vipcorner/"&cSpchance.FItemList(intLoop).Fpcimg%>" alt="<%=cSpchance.FItemList(intLoop).FevtName%>" /></p>
													<p class="evtTitV15"><strong><%=cSpchance.FItemList(intLoop).FevtSubCopy%></strong></p>
													<p><%=Replace(cSpchance.FItemList(intLoop).FevtStartDate, "-",".")%> ~ <%=Right(Replace(cSpchance.FItemList(intLoop).FevtEndDate,"-","."), 5)%></p>
												</a>
											</li>
										<% Next %>
									</ul>
								</div>
								<!--div class="pageWrapV15 tMar20">
									<%'fnDisplayPaging_New_nottextboxdirect(iCurrpage, iTotCnt, iPageSize, iPerCnt,"jsGoPage") %>
								</div-->
								<!--// 우수회원 전용코너 -->
							</div>
						<% End If %>
					<% Else %>
						<div class="noData specialShopBenefit">
							<p><strong>우수회원 전용코너의 혜택은 <strong class="memBLUE">블루회원</strong>부터 적용됩니다.</strong></p>
							<a href="/my10x10/special_info.asp" class="btnView"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/btn_view_member_benefit.gif" alt="회원혜택 보기" /></a>
						</div>
					<% End If %>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
	set cSpchance = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->