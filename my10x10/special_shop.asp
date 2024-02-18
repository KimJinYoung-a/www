<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual ="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual ="/lib/classes/shopping/specialshopitemcls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
'####### 회원등급 재조정 #######
Call getDBUserLevel2Cookie()
'####### 회원등급 재조정 #######

	'//for Developers
	'//commlib.asp, tenEncUtil.asp는 head.asp에 포함되어있으므로 페이지내에 넣지 않도록 합시다.

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 우수회원 샵"		'페이지 타이틀 (필수)
	strPageDesc = "마이텐바이텐 - 우수회원 샵"		'페이지 설명
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

Dim iTotCnt
Dim iPageSize, iCurrpage ,iDelCnt
Dim iStartPage, iEndPage, iTotalPage, iPerCnt
Dim i,j,userlevel, userLevelUnder, ospecialshop, iCols, iRows, vTitle, vSDate, vEDate
dim userid: userid = getEncLoginUserID ''GetLoginUserID

	iCurrpage = NullFillWith(requestCheckVar(Request("iC"),10),1)	'현재 페이지 번호
	iPageSize = 24		'한 페이지의 보여지는 열의 수
	iPerCnt   = 10		'보여지는 페이지 간격

	userlevel = GetLoginUserLevel
	'### 레벨이 없거나, 오렌지(5)거나, 옐로우(0), 그린(1) 일때 0으로 지정. 블루(2),VIP(3),Staff(7),Mania(4),Friends(8)
	If userlevel = "" OR userlevel = 5 OR userlevel = 0 OR userlevel = 1 Then
		userlevel = 0
	End If

	set ospecialshop = new CSpecialShop
	If userlevel > 0 Then
		ospecialshop.FNowDate = date()
		ospecialshop.GetSpecialShopInfo
		vTitle = ospecialshop.Ftitle
		vSDate = ospecialshop.Fsdate
		vEDate = ospecialshop.Fedate
		
		ospecialshop.FCurrPage = iCurrpage
		ospecialshop.FPageSize = iPageSize
		ospecialshop.FRectUserLevelUnder = userlevel
		
		If vTitle <> "" Then
			ospecialshop.GetSpecialItemList
		End If

		iTotCnt = ospecialshop.FTotalCount
		iTotalPage =   int((iTotCnt-1)/iPageSize) +1
	End If

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
<!--
	$(document).unbind("dblclick");
	function jsGoPage(iP){
			document.frmPrize.iC.value = iP;
			document.frmPrize.submit();
	}
	
function AddMileItem2(iitemid){
    var mfrm = document.frmPrize;
	var frm = document.reloadFrm;
	var iitemoption="0000";
    //옵션 선택 추가..
    if (eval("document.frmPrize.item_option_"+iitemid)){
        var comp = eval("frmPrize.item_option_"+iitemid);
        if (comp[comp.selectedIndex].id == "S") { alert("품절된 옵션은 구매하실 수 없습니다."); return; }

        iitemoption=comp[comp.selectedIndex].value;

        if (iitemoption==""){
            alert('옵션을 선택 하세요.');
            comp.focus();
            return;
        }
    }
	frm.mode.value      = "add";
	frm.itemid.value    =iitemid;
	frm.itemoption.value=iitemoption;
	frm.itemea.value    ="1";
	frm.submit();
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
				<form name="frmPrize" method="post" action="<%=CurrURL()%>">
				<input type="hidden" name="iC" value="<%=iCurrpage%>">
				<div class="myContent">
					<% If IsSpecialShopUser() AND vTitle <> "" Then %>
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_special_shop.gif" alt="우수회원샵" /></h3>
						<ul class="list">
							<li>우수회원샵은 BLUE 등급 이상의 회원님들께 특별할인가에 상품을 소개하는 <em class="crRed">회원 등급별 차등 가격제 서비스</em>입니다.</li>
							<li>우수 회원샵 상품의 할인은 해당 기간에 한합니다. 명시된 기간을 꼭 확인하시어 할인찬스 놓치지 마세요!</li>
							<li>상품은 한시적으로 오픈되며, 상품 운영상황에 따라 조기 종료될 수 있습니다.</li>
						</ul>
					</div>
					<div class="thisWeekShop">
						<div class="theme">
							<h4>이번주 테마<span class="bar">|</span><em class="crRed"><%=vTitle%></em></h4>
							<p>할인기간<span class="bar">|</span><%=Replace(vSDate,"-",".")%>~<%=Right(Replace(vEDate,"-","."),5)%></p>
						</div>
						<p class="myGrade"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_grade_<%=userlevel%>.gif" alt="<%=userlevel%>" /></p>
					</div>
					<% End If %>
					<div class="mySection">
						<% If userlevel > 0 Then %>
						<% if iTotCnt = 0 then
								Dim vReservDate
								vReservDate = fnReservDate()
						%>
						<div class="ct">
							<p style="padding-top:60px;"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_coming_soon.gif" alt="COMING SOON" /></p>
							<p class="tPad25"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_next_shop.gif" alt="다음 우수회원샵이 곧 오픈될 예정입니다. 곧 오픈될 상품들도 기대해 주세요!" /></p>
							<% If vReservDate <> "" Then %><p class="nextShop"><span>오픈예정일 : <%=Replace(vReservDate,"-",".")%></span></p><% End If %>
						</div>
						<% else %>
						<div class="pdtWrap pdt150">
							<ul class="pdtList specialShop">
								<% for i=0 to ospecialshop.FResultCount-1 %>
								<li>
									<div class="pdtBox">
										<div class="pdtPhoto">
											<p><a href="" onclick="TnGotoProduct('<%= ospecialshop.FItemList(i).FItemID %>'); return false;"><img src="<%= ospecialshop.FItemList(i).FImageIcon2 %>" width="150px" height="150px" alt="<%= ospecialshop.FItemList(i).FItemName %>" /></a></p>
											<div class="pdtAction">
												<ul>
													<li class="largeView"><p onclick="ZoomItemInfo('<%= ospecialshop.FItemList(i).FItemid %>');"><span>크게보기</span></p></li>
													<li class="postView"><p onclick="popEvaluate('<%=ospecialshop.FItemList(i).FItemid%>');"><span><%=FormatNumber(ospecialshop.FItemList(i).FEvalCnt,0)%></span></p></li>
													<li class="wishView"><p onclick="TnAddFavorite('<%=ospecialshop.FItemList(i).FItemID%>');"><span><%= FormatNumber(ospecialshop.FItemList(i).FFavCount,0) %></span></p></li>
												</ul>
											</div>
										</div>
										<div class="pdtInfo">
											<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%= ospecialshop.FItemList(i).FMakerid %>"><%= ospecialshop.FItemList(i).FBrandName %></a></p>
											<p class="pdtName tPad10"><a href="/shopping/category_prd.asp?itemid=<%= ospecialshop.FItemList(i).FItemId %>"><%= ospecialshop.FItemList(i).FItemName %></a></p>
											<%
												If ospecialshop.FItemList(i).IsSaleItem or ospecialshop.FItemList(i).isCouponItem Then
													Response.Write "<p class=""pdtPrice tPad10""><span class=""txtML"">" & FormatNumber(ospecialshop.FItemList(i).FOrgPrice,0) & "원</span></p>"
													IF ospecialshop.FItemList(i).IsSaleItem Then
														Response.Write "<p class=""pdtPrice""><span class=""finalP"">" & FormatNumber(ospecialshop.FItemList(i).getRealPrice,0) & "원</span>"
														Response.Write "&nbsp;<strong class=""crRed"">[" & ospecialshop.FItemList(i).getSalePro & "]</strong></p>"
													End IF
													IF ospecialshop.FItemList(i).IsCouponItem Then
														Response.Write "<p class=""pdtPrice""><span class=""finalP"">" & FormatNumber(ospecialshop.FItemList(i).GetCouponAssignPrice,0) & "원</span>"
														Response.Write "&nbsp;<strong class=""crGrn"">[" & ospecialshop.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
													End IF
												Else
													Response.Write "<p class=""pdtPrice tPad10""><span class=""finalP"">" & FormatNumber(ospecialshop.FItemList(i).getRealPrice,0) & "원 </span></p>"
												End If
											%>
											<p class="tPad05">
											<%
												dim optionBoxHtml
												optionBoxHtml = ""
												''품절시 제외.
												If (ospecialshop.FItemList(i).IsItemOptionExists) and (Not ospecialshop.FItemList(i).IsSoldOut) then
													optionBoxHtml = getOneTypeOptionBoxHtmlSpecialShop(ospecialshop.FItemList(i).FItemID,ospecialshop.FItemList(i).IsSoldOut,"class=""optSelect2"" title=""옵션을 선택해주세요"" style=""width:100%;""")
												End If

												response.write optionBoxHtml
											%>
											</p>
										</div>
										<p class="cartBtn">
											<a href="" class="btn btnM2 btnWhite btnW150" onclick="AddMileItem2('<%= ospecialshop.FItemList(i).FItemId %>');return false;">장바구니</a>
										</p>
									</div>
								</li>
								<% Next %>
							</ul>
						</div>
						<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(ospecialshop.FcurrPage, ospecialshop.FtotalCount, ospecialshop.FPageSize, 5, "jsGoPage") %></div>
						<% End If %>
						<% Else %>
						<div class="noData specialShopBenefit">
							<p><strong>우수회원샵의 혜택은 <strong class="memBLUE">블루회원</strong>부터 적용됩니다.</strong></p>
							<a href="/my10x10/special_info.asp" class="btnView"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/btn_view_member_benefit.gif" alt="회원혜택 보기" /></a>
						</div>
						<% End If %>
					</div>
				</div>
				</form>
				<form name="reloadFrm" method="post" action="/inipay/shoppingbag_process.asp" onsubmit="return false;" style="margin:0px;">
				<input type="hidden" name="mode" value="">
				<input type="hidden" name="sitename" value="10x10">
				<input type="hidden" name="itemid" value="">
				<input type="hidden" name="itemoption" value="">
				<input type="hidden" name="itemea" value="">
				</form>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
set ospecialshop = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->