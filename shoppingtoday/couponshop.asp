<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/enjoy/couponshopcls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : ENJOY EVENT : COUPON BOOK"

	'// 모달창이 필요한경우 아래 변수에 내용을 넣어주세요.
	strModalCont = ""

	'// 팝업창(레이어)이 필요한 경우 아래 변수에 내용을 넣어주세요.
	strPopupCont = ""

dim userid, cCouponMaster, arrBonusList, intLoop, arrItem, intItem,ix, stype , arrItemList , arrFreeDeliveryList
dim stab
dim strGubun
	userid = getEncLoginUserID

	stab = requestCheckVar(Request("stab"),4) '// 상품 텝

	If stab = "" Then stab = "all" End If
	If stype = "" Then stype = "1" End If

	set cCouponMaster = new ClsCouponShop
		'// 보너스 쿠폰
		arrBonusList = cCouponMaster.fnGetCouponList
		
		'// 상품 쿠폰
		cCouponMaster.Ftype = "2"
		arrItemList = cCouponMaster.fnGetCouponTabList

		'// 무료배송 쿠폰
		cCouponMaster.Ftype = "3"
		arrFreeDeliveryList = cCouponMaster.fnGetCouponTabList
%>
<script>
function PopItemCouponAssginList(iidx) {
	var popwin = window.open('/my10x10/Pop_CouponItemList.asp?itemcouponidx=' + iidx,'PopItemCouponAssginList','width=775,height=800,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function jsDownCoupon(stype,idx) {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
		return;
	}

	var frm = document.frmC;
		frm.stype.value = stype;
		frm.idx.value = idx;
		frm.submit();
}

function jsDownSelCoupon(sgubun,gubun) {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
		return;
	}

	fnAmplitudeEventMultiPropertiesAction('click_couponshop_coupondown_btn', '', '')

	var chkCnt = 0;
	var stype = "";
	var idx = "";
	var frm = document.frmC;

	if(frm.allidx){
		if (!frm.allidx.length) {

				stype = frm.allidx.stype;
				idx = frm.allidx.value;
				chkCnt = 1;

		} else {
			for(i=0;i<frm.allidx.length;i++) {
					if (chkCnt == 0 ) {
						stype = frm.allidx[i].getAttribute("stype");
						idx = frm.allidx[i].value;
					} else {
						stype =stype+"," +frm.allidx[i].getAttribute("stype");
						idx = idx+"," +frm.allidx[i].value;
					}
					chkCnt += 1;
			}
		}
	}else{
		alert("등록된 쿠폰이 없습니다.");
		return;
	}

	frm.stype.value = stype;
	frm.idx.value =idx;
	frm.submit();
}

function fnNoDataCheck() {
	<% if isarray(arrItemList) then %>
	$("#itemsale").show();
	<% else %>
	$("#itemsale").hide();
	<% end if %>

	<% if isarray(arrFreeDeliveryList) then %>
	$("#freedelivery").show();
	<% else %>
	$("#freedelivery").hide();
	<% end if %>
}

$(function() {
	$(".grpSubWrapV19 li").click(function() {
		$(".grpSubWrapV19 li").removeClass("on");
		$(this).addClass("on");
	});
});
</script>
</head>
<body>
<div id="couponBookV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap">
			<div class="hotHgroupV19 bg-orange">
				<div class="tab-area">
					<ul>
						<li><a href="/shoppingtoday/shoppingchance_allevent.asp">기획전</a></li>
						<li class="on"><a href="/shoppingtoday/couponshop.asp">쿠폰북</a></li>
						<li><a href="/shoppingtoday/shoppingchance_mailzine.asp">메일진</a></li>
					</ul>
				</div>
				<h2>COUPON BOOK</h2>
				<div class="grpSubWrapV19">
					<ul>
						<li class="nav1 on"><a href="" onclick="{$('.couponList').show();fnNoDataCheck(); return false;}">전체 쿠폰</a></li>
						<li class="nav2"><a href="" onclick="{$('.couponList').hide();$('#bonus').show(); return false;}">보너스 쿠폰</a></li>
						<li class="nav3"><a href="" onclick="{$('.couponList').hide();$('#itemsale').show(); return false;}">할인 쿠폰</a></li>
						<li class="nav4"><a href="" onclick="{$('.couponList').hide();$('#freedelivery').show(); return false;}">배송비 절약 쿠폰</a></li>
					</ul>
				</div>
			</div>
			<div class="cpnbook_guide">
				<div class="inner">
					<div class="desc">
						<i><img src="//fiximage.10x10.co.kr/web2019/common/ico_couponbook.png" alt=""></i>
						<div class="txt"><p>텐텐 회원에게만 제공되는 특별한 혜택, 쿠폰북</p>지금 바로 로그인하고 다운 받으세요!</div>
					</div>
					<div class="btn-area">
						<a href="javascript:jsDownSelCoupon('A','event');" class="btn-cpnbook btn-cpndown">전체 쿠폰<br>다운받기<i><img src="//fiximage.10x10.co.kr/web2019/common/ico_dwld.png" alt=""></i></a>
						<a href="/event/benefit/" class="btn-cpnbook btn-cpnview">텐텐 회원만의<br>플러스 혜택<i><img src="//fiximage.10x10.co.kr/web2019/common/ico_bkplus.png" alt=""></i></a>
					</div>
				</div>
			</div>

			<div class="hotSectionV15 enjoyCouponV15">
				<div class="hotArticleV15">
					<form name="frmC" method="post" action="couponshop_process.asp" style="margin:0px;">
					<input type="hidden" name="stype" value="">
					<input type="hidden" name="idx" value="">
					<%'// 보너스 쿠폰 %>
					<%	if isarray(arrBonusList) then %>
						<%
							Dim vCSS, vCouponName, vEventCouponCnt, vProdCouponCnt, k, vTempCount
							vEventCouponCnt = 0
							vProdCouponCnt	= 0
							vTempCount		= 0
							For intLoop = 0 To UBound(arrBonusList,2)
								If arrBonusList(0,intLoop) ="event" Then
									vEventCouponCnt = vEventCouponCnt + 1
								Else
									vProdCouponCnt = vProdCouponCnt + 1
								End IF
							Next
							
							If vEventCouponCnt > 0 or  vProdCouponCnt >0 Then
								IF vEventCouponCnt > 0 then 
						%>
									<div class="couponList" id="bonus">
										<div class="tit-area">보너스 쿠폰<span>기회는 바로 지금! 보너스 할인 혜택을 받아보세요</span></div>
										<div>
											<%
												For intLoop = 0 To UBound(arrBonusList,2)
													If arrBonusList(0,intLoop) = "event" Then
											%>
											<div class="couponBox">
												<input name="allidx" type="hidden" value="<%=arrBonusList(1,intLoop)%>" stype="<%=arrBonusList(0,intLoop)%>">
												<div class="box">
													<div class="title">
														<span class="tag red">
															<% IF arrBonusList(2,intLoop) = 3 THEN	'쿠폰타입(무료배송) %>
																<img src="http://fiximage.10x10.co.kr/web2013/common/cp_red_freeship.png" alt="무료배송" />
															<% Else %>
																<%=FnCouponValueView_2011(arrBonusList(0,intLoop),CLng(arrBonusList(3,intLoop)),arrBonusList(2,intLoop))%>
															<% End If %>
														</span>
													</div>
													<div class="account">
														<ul>
															<li class="name"><%= arrBonusList(4,intLoop) %></li>
															<li class="date"><%=FormatDate(arrBonusList(7,intLoop),"0000.00.00")%>~<%=FormatDate(arrBonusList(8,intLoop),"0000.00.00")%></li>
															<li class="condition"><em class="crRed">
															<%= CHKIIF(arrBonusList(15,intLoop)="C","해당카테고리 ",CHKIIF(arrBonusList(15,intLoop)="B","해당브랜드 ","")) %>
															상품금액 <%= FormatNumber(arrBonusList(9,intLoop),0) %>원 이상 구매시</em>
															</li>
														</ul>
													</div>
												</div>
												<div class="btn">
													<input name="chkidx" type="hidden" value="<%=arrBonusList(1,intLoop)%>" stype="<%=arrBonusList(0,intLoop)%>">
													<a href="javascript:jsDownCoupon('<%=arrBonusList(0,IntLoop)%>','<%=arrBonusList(1,IntLoop)%>');" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_download_red.gif" alt="다운로드" /></a>
												</div>
											</div>
											<%
													End If
												Next
											%>
										</div>
									</div>
						<% 	
								End if
							End If 
						End if 
						%>
						
							<div class="couponList" id="itemsale" style="display:<%=chkiif(isarray(arrItemList),"block","none")%>">
						<%'// 상품 쿠폰 %>
						<%
							vTempCount = 0
							If isarray(arrItemList) Then
						%>
								<div class="tit-area">할인 쿠폰<span>원하는 카테고리, 원하는 상품만을 쏙쏙 골라 받는 혜택!</span></div>
								<div>
									<%
									
										For intLoop = 0 To UBound(arrItemList,2)
											If arrItemList(0,intLoop) <> "event" Then
									%>
									<div class="couponBox">
										<input name="allidx" type="hidden" value="<%=arrItemList(1,intLoop)%>" stype="<%=arrItemList(0,intLoop)%>">
										<div class="box">
											<div class="title">
												<span class="tag green">
													<%=FnCouponValueView_2011(arrItemList(0,intLoop),CLng(arrItemList(3,intLoop)),arrItemList(2,intLoop))%>
												</span>
											</div>
											<div class="account">
												<ul>
													<li class="name"><%=chrbyte(db2html(arrItemList(4,intLoop)),30,"Y")%></li>
													<li class="date"><%=FormatDate(arrItemList(7,intLoop),"0000.00.00")%>~<%=FormatDate(arrItemList(8,intLoop),"0000.00.00")%></li>
												</ul>
												<div class="photo">
												<%
													cCouponMaster.Fitemcouponidx = arrItemList(1,intLoop)

													arrItem = cCouponMaster.fnGetCouponItemList

													IF isArray(arrItem)	THEN
												%>
													<img src="<%=getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(arrItem(0,intItem)) & "/" & arrItem(12,intItem),230,230,"true","false")%>" width="230" height="230" alt="<%=arrItem(4,intItem)%>" />

												<%
													End If
												%>
												</div>
											</div>
										</div>
										<div class="btn">
											<a href="javascript:PopItemCouponAssginList('<%=arrItemList(1,intLoop)%>');" title="새창에서 열림"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_view.png" alt="적용상품보기" /></a>
											<a href="javascript:jsDownCoupon('<%=arrItemList(0,IntLoop)%>','<%=arrItemList(1,IntLoop)%>');" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_download_green.gif" alt="다운로드" /></a>
										</div>
									</div>
									<%
											End If
										Next
							ELSE
						%>
									<p class="noData"><strong>진행되고 있는 할인 쿠폰이 없습니다.</strong></p>
						<%
							end if 
						%>
								</div>
							</div>
							<div class="couponList" id="freedelivery" style="display:<%=chkiif(isarray(arrFreeDeliveryList),"block","none")%>">
						<%'// 무료배송 쿠폰 %>
						<%
							vTempCount = 0
							If isarray(arrFreeDeliveryList) Then
						%>
								<div class="tit-area">배송비 절약 쿠폰<span>배송비 아까워 차마 장바구니에 담지 못한 상품이 있다면?</span></div>
								<div>
									<%
										For intLoop = 0 To UBound(arrFreeDeliveryList,2)
											If arrFreeDeliveryList(0,intLoop) <> "event" Then
									%>
									<div class="couponBox">
										<input name="allidx" type="hidden" value="<%=arrFreeDeliveryList(1,intLoop)%>" stype="<%=arrFreeDeliveryList(0,intLoop)%>">
										<div class="box">
											<div class="title">
												<span class="tag green">
													<img src="http://fiximage.10x10.co.kr/web2013/common/cp_green_freeship.png">
												</span>
											</div>
											<div class="account">
												<ul>
													<li class="name"><%=chrbyte(db2html(arrFreeDeliveryList(4,intLoop)),30,"Y")%></li>
													<li class="date"><%=FormatDate(arrFreeDeliveryList(7,intLoop),"0000.00.00")%>~<%=FormatDate(arrFreeDeliveryList(8,intLoop),"0000.00.00")%></li>
												</ul>
												<div class="photo">
												<%
													cCouponMaster.Fitemcouponidx = arrFreeDeliveryList(1,intLoop)

													arrItem = cCouponMaster.fnGetCouponItemList

													IF isArray(arrItem)	THEN
												%>
													<img src="<%=getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(arrItem(0,intItem)) & "/" & arrItem(12,intItem),230,230,"true","false")%>" width="230" height="230" alt="<%=arrItem(4,intItem)%>" />

												<%
													End If
												%>
												</div>
											</div>
										</div>
										<div class="btn">
											<a href="javascript:PopItemCouponAssginList('<%=arrFreeDeliveryList(1,intLoop)%>');" title="새창에서 열림"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_view.png" alt="적용상품보기" /></a>
											<a href="javascript:jsDownCoupon('<%=arrFreeDeliveryList(0,IntLoop)%>','<%=arrFreeDeliveryList(1,IntLoop)%>');" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/web2013/shoppingtoday/btn_download_green.gif" alt="다운로드" /></a>
										</div>
									</div>
									<%
											End If
										Next
							ELSE
									%>
									<p class="noData"><strong>진행되고 있는 무료배송 쿠폰이 없습니다.</strong></p>
						<%
							end if 
						%>
								</div>
							</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
	set cCouponMaster = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->