<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual ="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual ="/lib/classes/shopping/specialshopitemcls.asp" -->
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


Dim i,j,userlevel, userLevelUnder
Dim scType, sCategory, sCateMid
Dim cShopchance
Dim iTotCnt, arrList,intLoop
Dim iPageSize, iCurrpage ,iDelCnt
Dim iStartPage, iEndPage, iTotalPage, ix,iPerCnt, k
Dim atype,cdl,cdm , selOp, vLink, vImg, vIcon, vName
dim userid: userid = getEncLoginUserID ''GetLoginUserID


	userlevel = GetLoginUserLevel
	'### 레벨이 없거나, 오렌지(5)거나, 옐로우(0), 그린(1) 일때 0으로 지정. 블루(2),VIP(3),Staff(7),Mania(4),Friends(8)
	If userlevel = "" OR userlevel = 5 OR userlevel = 0 OR userlevel = 1 Then
		userlevel = 0
	End If

	atype = RequestCheckVar(request("atype"),1)
	if atype="" then atype="b"

	selOp		=  requestCheckVar(Request("selOP"),1) '정렬

	'파라미터값 받기 & 기본 변수 값 세팅
	scType 		= requestCheckVar(Request("scT"),15) '쇼핑찬스 분류
	sCategory 	= requestCheckVar(Request("disp"),3) '카테고리 대분류
	iCurrpage 	= requestCheckVar(Request("iC"),10)	'현재 페이지 번호

	If scType ="end" then
		selOp = "1"
	ElseIf selOp = "" Then
		selOp = "0"
	End if

	IF iCurrpage = "" THEN	iCurrpage = 1

	iPageSize = 6		'한 페이지의 보여지는 열의 수
	iPerCnt = 10		'보여지는 페이지 간격

'	If userlevel > 0 Then
		'데이터 가져오기
		set cShopchance = new ClsShoppingChance
		cShopchance.FCPage 		= iCurrpage		'현재페이지
		cShopchance.FPSize 		= iPageSize		'페이지 사이즈
		cShopchance.FSCType 	= ""    	'이벤트구분(전체,세일,사은품,상품후기, 신규,마감임박)
		cShopchance.FSCategory 	= sCategory 	'제품 카테고리 대분류
		cShopchance.FSCateMid 	= sCateMid		'제품 카테고리 중분류
		cShopchance.FEScope 	= 2				'view범위: 10x10
		cShopchance.FselOp	 	= selOp			'이벤트정렬
		arrList = cShopchance.fnGetBannerListSpecialCorner	'배너리스트 가져오기
		iTotCnt = cShopchance.FTotCnt 			'배너리스트 총 갯수
		set cShopchance = nothing

		iTotalPage =   int((iTotCnt-1)/iPageSize) +1  '전체 페이지 수
'	End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
<!--

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
					<%' If userlevel > 0 Then %>
						<div class="mySection">
							<!-- 우수회원 전용코너 -->
							<form name="frmSC" method="get" action="special_corner.asp" style="margin:0px;">
							<input type="hidden" name="iC" >
							<input type="hidden" name="scT" value="<%=scType%>">
							<input type="hidden" name="disp" value="<%=sCategory%>">
							<input type="hidden" name="cdm" value="">
							<input type="hidden" name="selOP" value="<%=selOP%>">
							<div class="spcEvtWrap">
								<ul>
									<%
										'### 배열번호
										' 0 ~ 7  : A.evt_code, B.evt_bannerimg, A.evt_startdate, A.evt_enddate, A.evt_kind, B.brand,B.evt_LinkType ,B.evt_bannerlink '
										' 8		 : ,(Case When A.evt_kind=13 Then (Select top 1 itemid from [db_event].[dbo].[tbl_eventitem] where evt_code=A.evt_code order by itemid desc) else 0 end) as itemid '
										' 9 ~ 10 : , B.etc_itemid, isNull(B.etc_itemimg,'''') as etc_itemimg '
										'11		 : , case when isNull(B.etc_itemimg,'''') = '''' then (select isNull(basicimage600,'''') from db_item.dbo.tbl_item where itemid = B.etc_itemid) end as basicimage600 '
										'12		 : , case when isNull(B.etc_itemimg,'''') = '''' then (select basicimage from db_item.dbo.tbl_item where itemid = B.etc_itemid) end as basicimage '
										'13 ~ 22 : , A.evt_name, A.evt_subcopyK, B.issale, B.isgift, B.iscoupon, B.isOnlyTen, B.isoneplusone, B.isfreedelivery, B.isbookingsell, B.iscomment '
										'23		 : , A.evt_startdate '

										IF isArray(arrList) THEN
											For intLoop =0 To UBound(arrList,2)

												IF arrList(4,intLoop) = "16" Then
													IF arrList(6,intLoop) = "I" and arrList(7,intLoop) <> "" THEN '링크타입 체크
														vLink = "location.href='" & arrList(7,intLoop) & "';"
													ELSE
														vLink = "GoToBrandShopevent_direct('" & arrList(5,intLoop) & "','" & arrList(0,intLoop) & "');"
													END IF
													vName = split(arrList(13,intLoop),"|")(0)
												Elseif arrList(4,intLoop) = "13" Then
													vLink = "TnGotoProduct('" & arrList(8,intLoop) & "');"
													vName = arrList(13,intLoop)
												Else
													IF arrList(6,intLoop) = "I" and arrList(7,intLoop) <> "" THEN '링크타입 체크
														vLink = "location.href='" & arrList(7,intLoop) & "';"
													ELSE
														vLink = "TnGotoEventMain('" & arrList(0,intLoop) & "');"
													END IF
													vName = arrList(13,intLoop)
												End IF

												If arrList(10,intLoop) = "" Then
													If arrList(11,intLoop) = "" Then
														vImg = "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(arrList(9,intLoop)) & "/" & arrList(12,intLoop)
													Else
														vImg = "http://webimage.10x10.co.kr/image/basic600/" & GetImageSubFolderByItemid(arrList(9,intLoop)) & "/" & arrList(11,intLoop)
													End IF
												Else
													vImg = arrList(10,intLoop)
												End If

												vIcon = ""
												If arrList(18,intLoop) Then
													vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif"" alt=""ONLY"" /> "
												End IF
												If arrList(15,intLoop) Then
													vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif"" alt=""SALE"" /> "
												End IF
												If arrList(17,intLoop) Then
													vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif"" alt=""쿠폰"" /> "
												End IF
												If arrList(19,intLoop) Then
													vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_oneplus.gif"" alt=""1+1"" /> "
												End IF
												If arrList(16,intLoop) Then
													vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_gift.gif"" alt=""GIFT"" /> "
												End IF
												If datediff("d",arrList(2,intLoop),date)<=3 Then
													vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif"" alt=""NEW"" /> "
												End IF
												If arrList(22,intLoop) Then
													vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_involve.gif"" alt=""참여"" /> "
												End IF
									%>
									<li>
										<a href="" onclick="<%=vLink%>;return false;">
											<p><img src="<%=vImg%>" alt="<%=replace(vName,"""","")%>" width="390px" height="189px" /></p>
											<p class="evtTitV15"><strong><%=chrbyte(db2html(vName),46,"Y")%></strong></p>
											<p>~<%=FormatDate(arrList(3,intLoop),"0000.00.00")%></p>
										</a>
									</li>
									<%
										Next
									End If
									%>
								</ul>
							</div>
							<div class="pageWrapV15 tMar20">
								<%= fnDisplayPaging_New_nottextboxdirect(iCurrpage, iTotCnt, iPageSize, iPerCnt,"jsGoPage") %>
							</div>
							</form>
							<!--// 우수회원 전용코너 -->
						</div>
					<%' Else %>
						<!--div class="noData specialShopBenefit">
							<p><strong>우수회원샵의 혜택은 <strong class="memBLUE">블루회원</strong>부터 적용됩니다.</strong></p>
							<a href="/my10x10/special_info.asp" class="btnView"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/btn_view_member_benefit.gif" alt="회원혜택 보기" /></a>
						</div-->
					<%' End If %>
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
set cShopchance = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->