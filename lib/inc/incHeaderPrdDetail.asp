<%
	'// 상품 상세용 incHeader (Http이기 때문에 Https로 링크 수정해줌)
	
	'///// 모바일에서 pc버전 보기 할때 /////
	if Request("mfg") = "pc" or session("mfg") = "pc" then
		session("mfg") = "pc"
	end if

	Dim strModalCont, strPopupCont

	'//561(기본검색어링크-인덱스), 562(기본검색어링크-일반)
    dim AppTopKey : AppTopKey = Array(561,562, 700, 701, 702, 703)
	ReDim AppTopVar(UBound(AppTopKey))

    on Error Resume Next
    Call fnGetHeaderContents(AppTopVar,AppTopKey)

    if (Err) then Application("chk_header_Contents")=-1
    on Error Goto 0
%>
<script type="text/javascript" src="/lib/js/SearchAutoComplete.js"></script>
<script type="text/javascript">
var V_CURRENTYYYYMM = "<%= CC_currentyyyymmdd %>";
</script>
<%' modal layer control area %>
<div id="boxes">
	<div id="mask" class="pngFix"></div>
	<div id="freeForm"></div>
	<%=strModalCont%>
</div>
<%' //modal layer control area %>
<%' 2015 추가 %>
<%
	Dim current_url  : current_url = Request.ServerVariables("url")
%>
<%' layer popup control area %>
<div id="lyrPop">
	<%' 2015 추가 %>
	<% If inStr(current_url,"Diary") > 0 Then %>
		<!-- #include virtual="/lib/inc/incPlayDiary.asp" -->
	<% ElseIf inStr(lcase(current_url),"episode") > 0 Then %>
		<!-- #include virtual="/lib/inc/incPlayPhotoPick.asp" -->
	<% else %>
		<%=strPopupCont%>
	<% End If %>
</div>
<!-- #include virtual="/lib/inc/incPopup.asp" -->
<div id="hBoxes"></div>
<%' //layer popup control area %>

<%' ie8 버전 이하 알림 %>
<div class="version-noti" id="version-noti" style="display:none;">
	<div class="inner">
		<p>
			구버전의 Internet Explorer로 접속하셨습니다. <strong>텐바이텐은 IE 11에서 최적화</strong>되어 보여집니다.<br/><em>편리한 사이트 이용 및 보안성 향상을 위해 최신 브라우저로의 업그레이드를 권장합니다.</em>
		</p>
		<span><img src="http://fiximage.10x10.co.kr/web2017/main/img_noti.png" alt="" /></span>
		<button type="button" class="btn-close" onclick="closeWin('ieversion', 1); return false;"><img src="http://fiximage.10x10.co.kr/web2017/main/btn_close.png" alt="닫기" /></button>
	</div>
</div>

<% If isBizMode = "Y" Then %>
	<div class="biz-menu-bar headerTopNew">
		<div class="inner">
			<div class="linkSide">
				<a href="/biz/change_biz_mode.asp?mode=N">감성채널 감성에너지 <span class="ten"><img src="//fiximage.10x10.co.kr/web2021/biz/icon_ten_group.png" alt="biz"></span> <span class="arrow"></span></a>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incBizHeader.asp" -->
	
<% Else %>
	<%'//header_top_banner%>
	<% server.Execute("/chtml/main/loader/banner/exc_header_upper.asp") %>

	<div class="headerTopNew">
		<div class="inner">
			<div class="linkSide">
				<a href="/biz/change_biz_mode.asp?mode=Y">사업자전용몰, 텐바이텐 <span><img src="//fiximage.10x10.co.kr/web2021/biz/icon_biz_group.png" alt="biz"></span> <span class="arrow"></span></a>
			</div>
			<div class="head-util">
				<ul>
					<% '## 로그인X %>
					<% If (Not IsUserLoginOK) Then %>
						<% '## 비회원 로그인X %>
						<% If Not(IsGuestLoginOK) Then %>
							<li class="util-join"><a href="/login/loginpage.asp?vType=G" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','login|<%=Request.ServerVariables("PATH_INFO")%>');">로그인</a> 
							/ <a href="/member/join.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','signup|<%=Request.ServerVariables("PATH_INFO")%>');">회원가입</a></li>

						<% '## 비회원 로그인 %>
						<% Else %>
							<li class="util-user">
								<a href="location.href='/my10x10/" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','guestorder|<%=Request.ServerVariables("PATH_INFO")%>');">주문번호 <b><%= GetGuestLoginOrderserial %></b></a>
								<div class="util-layer">
									<ul class="my-munu">
										<li><a href="/my10x10/" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','guestmy10x10|<%=Request.ServerVariables("PATH_INFO")%>');"><b>마이텐바이텐</b></a></li>
										<li><a href="/my10x10/order/order_cancel_detail.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','guestordercancel|<%=Request.ServerVariables("PATH_INFO")%>');">주문취소</a></li>
										<li><a href="/my10x10/qna/myqnalist.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','guest1:1board|<%=Request.ServerVariables("PATH_INFO")%>');">1:1 상담</a></li>
										<li><a href="" onclick="TnLogOut();fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','guestlogout|<%=Request.ServerVariables("PATH_INFO")%>'); return false;">로그아웃</a></li>
									</ul>
								</div>
							</li>
						<% End If %>
					<% '## 회원 %>
					<% Else %>
						<li class="util-user">
							<a href="/my10x10/"><em><%= GetLoginUserID %></em>님<span class="arrow-bottom bottom1"></span></a>
							<div class="util-layer">
								<div class="mem-info">
									<p><a href="/my10x10/" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','username|<%=Request.ServerVariables("PATH_INFO")%>');"><b><%=GetLoginUserName()%></b>님</a> <a href="/my10x10/special_info.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','userlevel|<%=Request.ServerVariables("PATH_INFO")%>');" class="<%=GetUserLevelCSSClass()%>"><b><%=GetUserLevelStr(GetLoginUserLevel)%></b></a></p>
									<ul class="list-dot">
										<li><a href="/my10x10/couponbook.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','coupon|<%=Request.ServerVariables("PATH_INFO")%>');">쿠폰 <b><%=GetLoginCouponCount%>장</b></a></li>
										<li><a href="/my10x10/mymileage.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','mileage|<%=Request.ServerVariables("PATH_INFO")%>');">마일리지 <b><%=FormatNumber(getLoginCurrentMileage,0)%>P</b></a></li>
									</ul>
								</div>
								<ul class="my-munu">
									<li><a href="/my10x10/" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','my10x10|<%=Request.ServerVariables("PATH_INFO")%>');"><b>마이텐바이텐</b></a></li>
									<li><a href="/my10x10/mytodayshopping.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','todayshopping|<%=Request.ServerVariables("PATH_INFO")%>');">최근 본 상품</a></li>
									<li><a href="/my10x10/mywishlist.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','wish|<%=Request.ServerVariables("PATH_INFO")%>');">위시</a></li>
									<li><a href="/my10x10/goodsusing.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','goodusing|<%=Request.ServerVariables("PATH_INFO")%>');">상품후기</a></li>
									<li><a href="/my10x10/qna/myqnalist.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','qna|<%=Request.ServerVariables("PATH_INFO")%>');">1:1 상담</a></li>
									<li><a href="/my10x10/myeventmaster.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','eventmaster|<%=Request.ServerVariables("PATH_INFO")%>');">당첨안내</a></li>
									<li><a href="/my10x10/userinfo/confirmuser.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','confirmuser|<%=Request.ServerVariables("PATH_INFO")%>');">개인정보수정</a></li>
									<li><a href="" onclick="TnLogOut(); fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','logout|<%=Request.ServerVariables("PATH_INFO")%>'); return false;">로그아웃</a></li>
								</ul>
							</div>
						</li>
					<% End If %>
					<li class="util-alarm">
						<a href="/my10x10/">알림</a>
						<% If (IsUserLoginOK) Then %>
							<!-- #include file="incHeaderAlaram_2018.asp" -->
						<% End If %>
					</li>
					<li class="util-order"><a href="/my10x10/order/myorderlist.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','orer|<%=Request.ServerVariables("PATH_INFO")%>');">주문/배송</a></li>
					<li class="util-cs"><a href="/cscenter/" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','cs|<%=Request.ServerVariables("PATH_INFO")%>');">고객센터</a></li>
					<li class="util-cart">
						<a href="" onclick="TnGotoShoppingBag();fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','basket|<%=Request.ServerVariables("PATH_INFO")%>');return false;"><span class="icoV18"></span> 장바구니 <span id="ibgaCNT" name="ibgaCNT"><%= GetCartCount %></span><span class="arrow-bottom bottom1" id="basketDropIcon"></span></a>
						<!-- #include file="incHeaderShBag_2018.asp" -->
					</li>
				</ul>
			</div>
		</div>
	</div>

	<div class="header-wrap anniv18">
		<div class="headerV18 headerVnew">
			<div class="inner">
				<%
					'// 텐바이텐 로고 Class 변경(인데스를 제외한 페이지에서 표시 됨)
					Dim sTenLogoClass: sTenLogoClass = ""
					if (Date>="2017-10-09" and Date<="2017-10-09") then
						'2017년 한글날
						sTenLogoClass = "class=""hangulDay2017"""				
					elseif (Date>="2018-11-23" and Date<="2018-12-25") then
						'크리스마스
						sTenLogoClass = "style=""top:5px; left:-40px; width:266px; height:74px; background-image:url(http://fiximage.10x10.co.kr/web2018/xmas2018/logo.gif);"""										
					elseif (Date>="2020-10-05" and Date<="2020-10-29") then
						'19주년
						sTenLogoClass = "style=""width:180px; top:15px; height:59px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/img_ten_anni.gif); background-position:50% 50%;"""
					elseif (Date>="2022-03-28" and Date<"2022-04-26") then
						'맛있는 정기세일
						sTenLogoClass = "style=""width:208px; height:52px; top:15px; left:-15px; background-image:url(//fiximage.10x10.co.kr/web2021/anniv2021/img_ten_anni22.png); background-position:50% 50%;background-size: 100%;"""
					elseif application("Svr_Info")="staging" and Date>="2022-03-22" and Date<"2022-04-26" then
						sTenLogoClass = "style=""width:208px; height:52px; top:15px; left:-15px; background-image:url(//fiximage.10x10.co.kr/web2021/anniv2021/img_ten_anni22.png); background-position:50% 50%;background-size: 100%;"""										
					end if
				%>			
				<h1 <%=sTenLogoClass%>><a href="<%=SSLUrl%>/" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','logo|<%=Request.ServerVariables("PATH_INFO")%>');">10X10</a></h1>
				<div class="head-service">
					<ul class="nav">
						<% If now()>="2020-10-05" And now() < "2020-10-29" Then %>
							<li class="nav-anniv"><a href="<%=SSLUrl%>/event/19th/index.asp">9월세일</a></li>
						<% End If %>
						<!--<li class="nav-apple"><a href="/event/apple/?gaparam=main_menu_apple" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','apple|<%=Request.ServerVariables("PATH_INFO")%>');">애플</a></li>-->
						<% If now()>="2019-03-29" And now() < "2019-04-22" Then %>
							<li class="nav-april"><a href="<%=SSLUrl%>/event/salelife/index.asp?gaparam=main_menu_april">4월세일</a></li>
						<% End If %>
						<!--<li><a href="/event/eventmain.asp?eventid=107600&gaparam=main_menu_inirental">렌탈하기</a></li> -->
						<% If now()>="2022-03-28" And now() < "2022-04-26" Then %>
							<li class="nav-diarystory"><a href="/event/eventmain.asp?eventid=117614&gaparam=main_menu_april">시작! 맛있는세일</a></li>
						<% End If %>
						<% If now()>="2022-09-01" And now() < "2023-02-01" Then %>
							<li class="nav-diarystory2023_v2"><a href="/diarystory2023/index.asp" style="color:#FF603E;">2023 텐텐다꾸</a></li>
						<% elseif application("Svr_Info")="Dev" or application("Svr_Info")="staging" Then %>
							<li class="nav-diarystory2023_v2"><a href="/diarystory2023/index.asp" style="color:#FF603E;">2023 텐텐다꾸</a></li>
						<% End If %>
						<li class="nav-april"><a href="/universal/?gaparam=main_menu_new" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','universal|<%=Request.ServerVariables("PATH_INFO")%>');">유니버설 공식스토어</a></li>
						<!--<li class="nav-gift"><a href="<%=SSLUrl%>/gift/talk/?gaparam=main_menu_gift">선물의 참견</a></li> -->
						<li class="nav-new"><a href="<%=SSLUrl%>/shoppingtoday/shoppingchance_newitem.asp?gaparam=main_menu_new" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','new|<%=Request.ServerVariables("PATH_INFO")%>');">신상품</a></li>
						<li class="nav-best"><a href="<%=SSLUrl%>/award/awardlist.asp?atype=b&gaparam=main_menu_best" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','best|<%=Request.ServerVariables("PATH_INFO")%>');">베스트</a></li>
						<li class="nav-sale"><a href="<%=SSLUrl%>/shoppingtoday/shoppingchance_saleitem.asp?gaparam=main_menu_sale" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','sale|<%=Request.ServerVariables("PATH_INFO")%>');">할인특가</a></li>
						<li class="nav-event"><a href="<%=SSLUrl%>/shoppingtoday/shoppingchance_allevent.asp?gaparam=main_menu_event" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','event|<%=Request.ServerVariables("PATH_INFO")%>');">기획전</a></li>
						<li class="nav-brand"><a href="<%=SSLUrl%>/street/?gaparam=main_menu_brand" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','brand|<%=Request.ServerVariables("PATH_INFO")%>');">브랜드</a></li>
					</ul>
					<div class="search-form">
						<%' Top Search Area %>
						<%
							'검색어 링크 Parsing
							dim tvsLnk, tvsTxt, tvsImg

							'// 인덱스/일반에 따른 분류
							if (nowViewPage="_index.asp" or nowViewPage="index.asp") and ubound(splTemp)<=1 then
								if AppTopVar(0)<>"" then
									if inStr(AppTopVar(0),"href") then
										tvsLnk = Mid(AppTopVar(0),inStr(AppTopVar(0),"href")+6,inStr(AppTopVar(0),"onFocus")-12)
										tvsTxt = ReverseBracket(Replace(trim(stripHTML(AppTopVar(0))),"""",""))
									end if
								end if
							else
								if AppTopVar(1)<>"" then
									if inStr(AppTopVar(1),"href") then
										tvsLnk = Mid(AppTopVar(1),inStr(AppTopVar(1),"href")+6,inStr(AppTopVar(1),"onFocus")-12)
										tvsTxt = ReverseBracket(Replace(trim(stripHTML(AppTopVar(1))),"""",""))
									end if
								end if
							end if
						%>
						<form name="searchForm" method="get" action="<%=SSLUrl%>/search/search_result.asp" onSubmit="return false;">
						<input type="hidden" name="rect" value="">
						<input type="hidden" name="cpg" value="">
						<input type="hidden" name="extUrl" value="<%=tvsLnk%>">
						<input type="hidden" name="tvsTxt" value="<%=tvsTxt%>">
						<input type="hidden" name="gaparam" value="main_menu_search">
						<input type="search" name="sTtxt" id="sTtxt" value="<%=tvsTxt%>" onkeyup="fnKeyInput(keyCode(event))" onkeyup="if(keyCode(event)==13) {fnTopSearch(document.searchForm.rect,$('#sTtxt').val());}" onFocus="chkFocusTopSearchTxt(this.value,'S');CancelHideSACLayer();fnSACLayerOnOff(true);" onblur="chkFocusTopSearchTxt(this.value,'U');HideSACLayer()" autocomplete="off" />
						<button type="submit" class="btn-search" onclick="fnAmplitudeEventMultiPropertiesAction('click_search','keyword',$('#sTtxt').val()); fnTopSearch(document.searchForm.rect,$('#sTtxt').val());AmplitudeEventSend('TopMenuSearch','','event');return false;"><span class="icoV18">검색</span></button>
						<div name="atl" id="atl" style="display:none;" onFocus="chkFocusTopSearchTxt(this.value,'S');CancelHideSACLayer();fnSACLayerOnOff(true);" onblur="chkFocusTopSearchTxt(this.value,'U');HideSACLayer()" class="schExample"></div>
						</form>
						<script type="text/javascript">
						function chkFocusTopSearchTxt(dv,md) {
							if(dv=="<%=tvsTxt%>"&&md=="S") {
								document.searchForm.sTtxt.value="";
								document.searchForm.extUrl.value="";
							} else if(dv==""&&md=="U") {
								document.searchForm.sTtxt.value="<%=tvsTxt%>";
								document.searchForm.extUrl.value = "<%=tvsLnk%>";
							}
						}
						</script>
						<%' // Top Search Area %>
					</div>
				</div>
			</div>
		</div>
		<div class="gnb-wrap">
			<!-- #include virtual="/lib/inc/incTopCateMenu_2018PrdDetail.asp" -->
		</div>
	</div>
<% End If %>



<script>
$(function() {
	//GNB


	$('.gnbV18 li').mouseover(function() {
		$('.gnbV18 li').removeClass('on');
		$(this).addClass('on');
		$('.gnb-sub-wrap').show()
			.mouseover(function() {$(this).show();})
			.mouseleave(function() {$(this).hide();});
		$('.gnb-sub').hide();
		var subGnbId = $(this).attr('name');
		$("div[class|='gnb-sub'][id|='"+ subGnbId +"']").show()
		.mouseover(function() {
			$(this).show();
			$('.gnbV18 li[name="'+subGnbId+'"]').addClass('on');
		})
		.mouseleave(function() {
			$(this).hide();
			$('.gnbV18 li').removeClass('on');
		});
	});

	$('.gnbV18 li').mouseleave(function() {
		$(this).removeClass('on');
		$('.gnb-sub-wrap').hide();
	});
});
</script>

<script type="text/javascript">
    /*
    * 모비온 스크립트
    * */
    (function(a,g,e,n,t){a.enp=a.enp||function(){(a.enp.q=a.enp.q||[]).push(arguments)};n=g.createElement(e);n.async=!0;n.defer=!0;n.src="https://cdn.megadata.co.kr/dist/prod/enp_tracker_self_hosted.min.js";t=g.getElementsByTagName(e)[0];t.parentNode.insertBefore(n,t)})(window,document,"script");
    enp('create', 'common', 'your10x10', { device: 'W' });  // W:웹, M: 모바일, B: 반응형
    enp('send', 'common', 'your10x10');
</script>