<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<%
'####################################################
' Description : 웰컴투 소품랜드
' History : 2017-03-28 이종화
'####################################################
dim currentDate , i , init
	currentDate = date()
	init = 0

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=77060" & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

Dim eCode , egCode , intI , iTotCnt , itemid
Dim logparam 
dim cEventItem  
Dim eitemsort :	eitemsort = 1
Dim itemlimitcnt : itemlimitcnt = 105
Dim blnitempriceyn
Dim blnItemifno :  blnItemifno = True

	eCode = requestCheckVar(request("eventid"),5)
%>
<!-- #include virtual="/event/2017props/sns.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- <base href="http://www.10x10.co.kr/"> -->
<style type="text/css">
.sopumLand {background:url(http://webimage.10x10.co.kr/eventIMG/2017/77060/bg_pink.jpg) 0 0 repeat;}
.welcome {position:relative; height:1052px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/bg_characters_v4.png) 50% 0 no-repeat;}
.welcome h2 {position:relative; padding:117px 0 43px; z-index:2;}
.welcome .subTit {padding-bottom:65px;}
.welcome .balloon {position:absolute; top:56px; left:50%; margin-left:244px; z-index:1; animation:swing 2s infinite forwards ease-in-out; transform-origin:20% 100%;}
.welcome .itemList {padding:67px 0 0 ;}

.deco {position:relative; height:123px;}
.deco span{position:absolute; bottom:0; left:50%;}
.deco span:first-child{margin-left:-541px; bottom:-2px;}
.deco span:first-child + span{margin-left:450px; bottom:-8px;}
.deco span:first-child + span + span{top:-459px; margin-left:826px;}

.evntDate {position:relative; width:1010px; height:96px; margin:0 auto;}
.evntDate .swiper-container {height:96px; border-radius:9px;}
.evntDate .swiper-container:before {position:absolute; left:0; top:0; width:10px; height:90px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/img_slide_deco_lt_v2.png) no-repeat 0 0; content:''; z-index:10;}
.evntDate .swiper-container:after {position:absolute; right:0; top:0; width:10px; height:90px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/img_slide_deco_rt_v2.png) no-repeat 100% 0; content:''; z-index:10;}
.evntDate .swiper-wrapper {height:96px;}
.evntDate li {position:relative; float:left; width:202px; height:96px;}
.evntDate li a{display:block; height:90px; width:201px;}
.evntDate li a img{padding-top:24px;}
.evntDate button {position:absolute; top:0; padding:38px 20px; background:transparent;}
.evntDate .btnPrev {left:-50px;}
.evntDate .btnNext {right:-50px;}
.evntDate .open a {background:#812ea4;}
.evntDate .before a {background:#f79895;}
.evntDate .ing a {background:#f57380;}
.evntDate .open .tabOpen {position:absolute; left:50%; margin-left:-6px; bottom:0px;}
@keyframes swing { 0%,100%{transform:rotate(8deg);} 50% {transform:rotate(-3deg);} }
</style>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">
						<div class="sopum">
							<!-- #include virtual="/event/2017props/head.asp" -->
							<div class="sopumLand">
								<div class="welcome">
									<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/tit_welcome_v3.png" alt="웰컴 투 소품 랜드" /></h2>
									<p class="subTit"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/txt_subtit.png" alt="소품들의 환상적인 케미쇼 매일매일 다른 테마의 상품들을 구경해보세요!" /></p>
									<span class="balloon"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/img_balloon.png" alt="" /></span>
									<div class="evntDate">
										<div class="swiper-container">
											<ul class="swiper-wrapper">
												<%
													Dim ii , currentDate2 , tempevtcode , nowcnt
													ii = 0
													nowcnt = 0
													For ii=0 To 14
														currentDate2 = DateAdd("d", (ii), "2017-04-03") '// 기준일 가변
														tempevtcode  = "771"&chkiif((ii+1)<10,"0"&(ii+1),(ii+1)) '// 기준 이벤트 코드 선정
														If datediff("d", currentDate, currentDate2) = 0 Then '// 기준일과 오늘 비교 -- 오픈일

															If eCode = "" Then eCode = tempevtcode End If '//없을경우
												%>
													<li class="swiper-slide <%=chkiif(CStr(eCode) = CStr(tempevtcode) ," open"," ing")%>"><a href="?eventid=771<%=chkiif((ii+1)<10,"0"&(ii+1),(ii+1))%>"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/tab_<%=ii%>_end.png"></a>
													<% If CStr(eCode) = CStr(tempevtcode) Then %>
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/img_tab_on.png" alt="" class="tabOpen"/>
													<% End if%>
													</li>
												<%						
														ElseIf datediff("d", currentDate, currentDate2) > 0 Then '//기준일과 오늘 비교 -- 오픈전
												%>
													<li class="swiper-slide <%=chkiif(CStr(eCode) = CStr(tempevtcode)," open"," before")%>"><a href="" onclick="alert('coming soon');"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/tab_<%=ii%>.png"></a>
													<% If CStr(eCode) = CStr(tempevtcode) Then %>
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/img_tab_on.png" alt="" class="tabOpen"/>
													<% End if%>
													</li>
												<%						
														Else													'// 지난날짜
												%>
													<li class="swiper-slide <%=chkiif(CStr(eCode) = CStr(tempevtcode)," open"," ing")%>"><a href="?eventid=771<%=chkiif((ii+1)<10,"0"&(ii+1),(ii+1))%>"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/tab_<%=ii%>_end.png"></a>
													<% If CStr(eCode) = CStr(tempevtcode) Then %>
													<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/img_tab_on.png" alt="" class="tabOpen"/>
													<% End if%>
													</li>
												<%
														End If

														If CStr(eCode) = CStr(tempevtcode) Then '// 이벤트 코드 기준 현재 이벤트 코드 일때 위치 선정
															If ii < 3 Then
																init = 0
															ElseIf ii > 2  Then
																init = ii-2
															End If

															If init > 9 Then
																init = 10
															End If 
															nowcnt = ii
														End If
													Next
													'//로그파라메터
													logparam = "&pEtr="&eCode
												%>
											</ul>
										</div>
										<button class="btnPrev"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/btn_prev.png" alt="이전" /></button>
										<button class="btnNext"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/btn_next.png" alt="다음" /></button>
									</div>
									<div class="itemList">
										<%'!-- img_item_0.png ~ img_item_14.png로 이미지 서버에 올릴게요.--%>
										<%'!-- usemap="itemMap0 " ~ usemap="itemMap14 " --%>
										<%
											'//map itemid 
											Dim itemurl1, itemurl2 , itemurl3
											'//4월 3일부터 ~ 4월 17일 까지 배열
											itemurl1 = array(1465642,1260092,1538702,1578677,1659553,1575860,1677420,1575187,1168270,1659999,1619733,1606935,1660629,1444573,1510635)
											itemurl2 = array(1491856,1645913,1647131,1553075,1658352,1539868,1651986,1331701,1672000,1552889,1680298,1679326,1576373,1403604,1511959)
											itemurl3 = array(1673735,1446823,1667442,1663690,1575179,1680719,1662536,1551182,1317315,1428152,1427173,1291761,1238605,1644213,292182)

										%>
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/img_item_<%=nowcnt%>.png" alt="" usemap="#itemMap0" />
										<map name="itemMap0">
											<area shape="rect" coords="108,7,394,348" onfocus="this.blur();" href="/shopping/category_prd.asp?itemid=<%=itemurl1(nowcnt)%>&pEtr=77060" alt="">
											<area shape="rect" coords="425,7,712,348" onfocus="this.blur();" href="/shopping/category_prd.asp?itemid=<%=itemurl2(nowcnt)%>&pEtr=77060" alt="">
											<area shape="rect" coords="749,5,1032,349" onfocus="this.blur();" href="/shopping/category_prd.asp?itemid=<%=itemurl3(nowcnt)%>&pEtr=77060" alt="">
										</map>
									</div>
									<div class="deco">
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/ferrisWheel_v2.gif" alt=""/></span>
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/horse.gif" alt=""/></span>
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77060/train.gif" alt=""/></span>
									</div>
								</div>
							</div>
							<script type="text/javascript">
							$(function(){
								var evtSwiper = new Swiper('.evntDate .swiper-container',{
									initialSlide:<%=init%>,
									slidesPerView:5,
									speed:600
								})
								$('.evntDate .btnPrev').on('click', function(e){
									e.preventDefault();
									evtSwiper.swipePrev();
								})
								$('.evntDate .btnNext').on('click', function(e){
									e.preventDefault();
									evtSwiper.swipeNext();
								});
							});
							</script>
							<%'!-- sns --%>
							<div class="sns"><%=snsHtml%></div>
							<%'!-- sns --%>
							<%'이벤트 상품 리스트 %>
							<div class="evtPdtListWrapV15">
								<% sbEvtItemView %>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>