<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 쿠폰/보너스 쿠폰"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_money_v1.jpg"
	strPageDesc = "보유한 쿠폰을 확인하세요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 쿠폰 조회"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/couponbook.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_couponcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_itemcouponcls.asp" -->
<%
dim vtempbounscouponyn : vtempbounscouponyn="N"

dim userid
userid = getEncLoginUserID

dim osailcoupon
set osailcoupon = new CCoupon
osailcoupon.FRectUserID = userid
osailcoupon.FPageSize=100

if userid<>"" then
    osailcoupon.getValidCouponList
end if

dim oitemcoupon
set oitemcoupon = new CUserItemCoupon
oitemcoupon.FRectUserID = userid

if userid<>"" then
    oitemcoupon.getValidCouponList

    '' 쿠키(쿠폰 갯수) 재 세팅.
    Call SetLoginCouponCount(osailcoupon.FTotalCount + oitemcoupon.FTotalCount)
end if




''## 진행중인 보너스쿠폰 이벤트 #######################
'' -> 쿠폰샵 오픈으로 필요없음 : 사용안함..
dim osailcouponmaster, IsAvailThisCoupon, IsAlreadyReceiveCoupon
set osailcouponmaster = new CCouponMaster
osailcouponmaster.FRectUserID = userid

''if userid<>"" then
''    ''전체 지급하는 발급할수 있는쿠폰을 먼저 찾고
''    osailcouponmaster.GetOneAvailCouponMaster
''    if (osailcouponmaster.FResultCount<1) then
''        ''자신에게 지급될 수 있는 쿠폰을 다음으로 찾는다.
''        osailcouponmaster.GetOneAppointmentCouponMaster
''    end if
''end if
''
''
''''FRectIdx의 쿠폰행사가 진행중일때
''if (osailcouponmaster.FResultCount>0) then
''	IsAlreadyReceiveCoupon = osailcouponmaster.CheckAlreadyReceiveCoupon(osailcouponmaster.FOneItem.Fidx, userid)
''end if
''''####################################################

dim i
dim cpnNo, strDiv, tmpNo, lp

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language='javascript'>

function PopItemCouponAssginList(iidx){
	var popwin = window.open('/my10x10/Pop_CouponItemList.asp?itemcouponidx=' + iidx,'PopItemCouponAssginList','width=700,height=800,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function ReCeiveCoupon(frm){
	var ret= confirm('상품쿠폰을 받으시겠습니까?');

	if (ret){
		frm.submit();
	}
}

//오프라인 쿠폰 교환
function coupon2coupon(){
	var popwin = window.open('/my10x10/coupon/changecoupon.asp','changecoupon','width=640 height=480');
	popwin.focus();
}

</script>
<style type="text/css">

.invisibleLink {
    display: block;
	position: absolute;
	left: 920px; top: 350px;
    height:80px;
    padding-left:100px;
    padding-top:50px;
    width:70px;
	text-indent:-9999px;
}

</style>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_coupon.gif" alt="쿠폰/보너스 쿠폰" /></h3>
						<ul class="list">
							<li>해당 상품쿠폰 및 보너스쿠폰의 사용기준과 기간을 반드시 확인하여 주세요.</li>
							<li>오프라인 및 텐바이텐 제휴사에서 증정받으신 쿠폰은 번호입력을 통해 보너스쿠폰으로 우선 발급을 받으셔야 이용하실 수 있습니다.</li>
							<li>유효기간이 만기된 상품쿠폰 및 보너스쿠폰은 자동 소멸되며 사용된 쿠폰은 주문취소 후 재발급 되지 않습니다.</li>
						</ul>
					</div>

					<% ' 18주년 세일 기간 동안 쿠폰 배너 노출
					'If date() > "2019-09-25" AND date() < "2019-10-01" Then
					If date() > "2019-09-30" AND date() < "2019-10-14" Then
					%>
					<div class="bnr18th" style="position:fixed; top:630px; left:50%; margin-left:587px;">
						<a href="/event/eventmain.asp?eventid=97449" onclick="fnAmplitudeEventMultiPropertiesAction('click_couponbook_coupon_banner','','',);" target="_balnk"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/bnr_18th_mycp.png" alt="뽑기에 성공하면 아이패드가 100원?!"></a>
					</div>
					<% End if %>
					<%If date() > "2019-10-13" AND date() < "2019-11-01" Then %>
					<div class="bnr18th" style="position:fixed; top:630px; left:50%; margin-left:587px;">
						<a href="/event/eventmain.asp?eventid=97805" onclick="fnAmplitudeEventMultiPropertiesAction('click_couponbook_coupon_banner','','',);" target="_balnk"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/bnr_18th_mycp2.png" alt="비밀번호 풀면 마샬 스피커를 드려요!"></a>
					</div>
					<% End if %>

					<div class="mySection">
						<h4>현재 사용 가능한 쿠폰</h4>
						<div class="myTopic coupon">
							<div class="box">
								<ul class="count price">
									<li>보너스 쿠폰 : <span class="crRed"><strong><%= osailcoupon.FTotalCount %></strong>장</span></li>
									<li>상품 쿠폰 : <span class="crRed"><strong><%= oitemcoupon.FTotalCount %></strong>장</span></li>									
								</ul>
								<div class="couponbook">
									<a href="/shoppingtoday/couponshop.asp" class="invisibleLink" title="쿠폰북으로 이동">쿠폰북 바로가기</a>
									<h5><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_coupon_book.gif" alt="쿠폰북" /></h5>
									<p>내가 받을 수 있는<br /> 모든 쿠폰을 안내해 드립니다.</p>
									<a href="/shoppingtoday/couponshop.asp" class="linkBtn" title="쿠폰북으로 이동">쿠폰북 바로가기</a>
								</div>
							</div>
						</div>

						<p class="checkpoint"><span class="word">오프라인 및 텐바이텐 제휴사에서 받은 상품권 및 쿠폰번호를 입력하시면 사용쿠폰을 알려드립니다.</span> <a href="javascript:coupon2coupon();" title="상품권 및 보너스 쿠폰 발급받기" class="btn btnS2 btnRed"><span class="fn">상품권 및 보너스 쿠폰 발급받기</span></a></p>
					</div>

					<div class="couponSection">
						<h4>나의 쿠폰</h4>
						
						<!-- 보너스 쿠폰 -->
						<div class="couponList bonusCoupon">
							<h5>보너스 쿠폰 <span>(<strong><%= osailcoupon.FTotalCount %></strong>장)</span></h5>
<% If (osailcoupon.FResultCount > 0) Then %>
	<% 
		
		dim evtCouponStr, isEvtCoupon

		For i=0 To osailcoupon.FResultCount-1 
			evtCouponStr = ""
			isEvtCoupon = false
			if osailcoupon.FItemList(i).fmasteridx = 1147 or osailcoupon.FItemList(i).fmasteridx = 1148 or osailcoupon.FItemList(i).fmasteridx = 1149 or osailcoupon.FItemList(i).fmasteridx = 1150 then
				isEvtCoupon = true
			end if
			if isEvtCoupon then
				evtCouponStr = "<em class=""tag"">[이벤트]</em>"
			end if					
	%>
							<div class="couponBox <%=CHKIIF(isEvtCoupon,"surprise-cp","")%>">
								<div class="box">
									<div class="title">
										<span class="tag red">
										<%
											cpnNo = osailcoupon.FItemList(i).getCouponTypeStr

											if instr(cpnNo,"원")>0 then
												'원할인 쿠폰
												cpnNo = replace(cpnNo,"원","")
												strDiv = "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_red_num_won.png' alt='원' />"
											elseif instr(cpnNo,"배송비")>0 then
												cpnNo = ""
												strDiv = ""
												Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_red_freeship.png' alt='무료배송' />"
											else
												'%할인 쿠폰
												cpnNo = replace(cpnNo,"%","")
												strDiv = "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_red_num_per.png' alt='%' />"
											end if

											For lp=1 to len(cpnNo)
												tmpNo = mid(cpnNo, lp, 1)
												if tmpNo="," then
													%>
													<img src="http://fiximage.10x10.co.kr/web2013/common/cp_red_num_comma.png" alt="," />
													<%
												else
													%>
													<img src="http://fiximage.10x10.co.kr/web2013/common/cp_red_num0<%= tmpNo %>.png" alt="<%= tmpNo %>" />
													<%
												end if
											Next
											Response.Write strDiv
										%>
										</span>
									</div>
									<%
									'//특정 쿠폰 쿠폰설명 고정		'/2014.10.07 한용민 생성
									vtempbounscouponyn="N"
									IF application("Svr_Info")="Dev" THEN
										if osailcoupon.FItemList(i).fmasteridx=357 or osailcoupon.FItemList(i).fmasteridx=358 or osailcoupon.FItemList(i).fmasteridx=359 or osailcoupon.FItemList(i).fmasteridx=360 or osailcoupon.FItemList(i).fmasteridx=361 or osailcoupon.FItemList(i).fmasteridx=362 or osailcoupon.FItemList(i).fmasteridx=363 or osailcoupon.FItemList(i).fmasteridx=364 or osailcoupon.FItemList(i).fmasteridx=365 or osailcoupon.FItemList(i).fmasteridx=366 or osailcoupon.FItemList(i).fmasteridx=367 then
											vtempbounscouponyn="Y"
										end if
									ELSE
										if osailcoupon.FItemList(i).fmasteridx=644 or osailcoupon.FItemList(i).fmasteridx=645 or osailcoupon.FItemList(i).fmasteridx=646 or osailcoupon.FItemList(i).fmasteridx=647 or osailcoupon.FItemList(i).fmasteridx=648 or osailcoupon.FItemList(i).fmasteridx=649 or osailcoupon.FItemList(i).fmasteridx=650 or osailcoupon.FItemList(i).fmasteridx=651 or osailcoupon.FItemList(i).fmasteridx=652 or osailcoupon.FItemList(i).fmasteridx=653 or osailcoupon.FItemList(i).fmasteridx=654 then
											vtempbounscouponyn="Y"
										end if
									END IF
									%>
									<div class="account">
										<ul>
											<li class="name"><%= evtCouponStr %><%= osailcoupon.FItemList(i).Fcouponname %></li>
											<li class="date"><%= osailcoupon.FItemList(i).getAvailDateStr %></li>
											<li class="condition">
												<em class="crRed">
													<%= osailcoupon.FItemList(i).getMiniumBuyPriceStr %><%=CHKIIF(osailcoupon.FItemList(i).getValidTargetStr<>"",",","")%>  
													
													<% if vtempbounscouponyn="Y" then %>
														앱쇼상품전용
													<% else %>
														<%= osailcoupon.FItemList(i).getValidTargetStr %>
													<% end if %>
												</em>
											</li>
										</ul>
									</div>
								</div>
							</div>
	<% next %>
<% else %>
							<p class="noData"><strong>보유한 쿠폰이 없습니다.</strong></p>
<% end if %>
						</div>
						<!-- //보너스 쿠폰 -->

						<!-- 상품 쿠폰 -->
						<div class="couponList">
							<h5>상품 쿠폰 <span>(<strong><%= oitemcoupon.FTotalCount %></strong>장)</span></h5>
<% If (oitemcoupon.FResultCount > 0) Then %>
	<% For i=0 to oitemcoupon.FResultCount-1 %>
							<div class="couponBox">
								<div class="box">
									<div class="title">
										<span class="tag green">
										<%
											cpnNo = oitemcoupon.FItemList(i).GetDiscountStr

											if instr(cpnNo,"원")>0 then
												'원할인 쿠폰
												cpnNo = replace(cpnNo,"원 할인","")
												strDiv = "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_green_num_won.png' alt='원' />"
											elseif instr(cpnNo,"무료배송")>0 then
												cpnNo = ""
												strDiv = ""
												Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_green_freeship.png' alt='무료배송' />"
											else
												'%할인 쿠폰
												cpnNo = replace(cpnNo,"% 할인","")
												strDiv = "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_green_num_per.png' alt='%' />"
											end if

											For lp=1 to len(cpnNo)
												tmpNo = mid(cpnNo, lp, 1)
												if tmpNo="," then
													%>
													<img src="http://fiximage.10x10.co.kr/web2013/common/cp_green_num_comma.png" alt="," />
													<%
												else
													%>
													<img src="http://fiximage.10x10.co.kr/web2013/common/cp_green_num0<%= tmpNo %>.png" alt="<%= tmpNo %>" />
													<%
												end if
											Next
											Response.Write strDiv
										%>
										</span>
									</div>
									<div class="account">
										<ul>
											<li class="name"><%= oitemcoupon.FItemList(i).Fitemcouponname %></li>
											<li class="date"><%= oitemcoupon.FItemList(i).getAvailDateStr %></li>
										</ul>
									</div>
								</div>
								<div class="btn"><a href="javascript:PopItemCouponAssginList('<%= oitemcoupon.FItemList(i).FitemcouponIdx %>');" title="쿠폰적용 상품 보기"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_view.png" alt="쿠폰적용상품보기" /></a></div>
								<!-- /html/my10x10/popCouponList.asp width=700, height=800 -->
							</div>
	<% next %>
<% else %>
							<p class="noData"><strong>보유한 쿠폰이 없습니다.</strong></p>
<% end if %>
						</div>
						<!-- //상품 쿠폰 -->
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
<%

set osailcoupon = Nothing
set oitemcoupon = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
