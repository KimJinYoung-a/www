<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2017 MAIN
' History : 2016.09.26 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2017/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2017/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/diarystory2018/"
			REsponse.End
		end if
	end if
end if

Response.Redirect "/diarystory2018/"
REsponse.End

Dim weekDate
Dim i , PrdBrandList , userid, imglink
Dim ListDiv
Dim PageSize , SortMet , CurrPage , vParaMeter , GiftSu

weekDate = weekDayName(weekDay(now)) '// 요일 구하기 내장 함수
'if date >= "2016-10-03" and  date < "2016-10-17" then
'	weekDate = "공휴일"
'end if

ListDiv	= requestcheckvar(request("ListDiv"),4)
If ListDiv = "" Then ListDiv = "item"

PageSize	= requestcheckvar(request("page"),2)
SortMet 	= requestCheckVar(request("srm"),9)
CurrPage 	= requestCheckVar(request("cpg"),9)
userid		= getEncLoginUserID

If userid <> "baboytw" Then
	response.redirect("/")
End If

GiftSu=0
IF CurrPage = "" then CurrPage = 1
IF SortMet = "" Then SortMet = "best"

If ListDiv = "list" Then
	PageSize = 8
Else
	PageSize = 8
End If

Dim ArrDesign , tmp , iTmp , ctmp, ktmp, arrcontents ,arrkeyword
ArrDesign = request("arrds")
ArrDesign = split(ArrDesign,",")

For iTmp =0 to Ubound(ArrDesign)-1
	IF ArrDesign(iTmp)<>"" Then
		tmp  = tmp & requestcheckvar(ArrDesign(iTmp),2) &","
	End IF
Next
ArrDesign = tmp

Dim sArrDesign,sarrcontents,sarrkeyword
sArrDesign =""
IF ArrDesign <> "" THEN sArrDesign =  left(ArrDesign,(len(ArrDesign)-1))

vParaMeter = "&arrds="&ArrDesign&""

dim cDiary
Set cDiary = new cdiary_list
	cDiary.getOneplusOneDaily '1+1
	
if cDiary.ftotalcount>0 then
	GiftSu = cDiary.getGiftDiaryExists(cDiary.FOneItem.Fitemid) '사은품 수
		if GiftSu = false then GiftSu=0
else
	GiftSu=0
end if

dim cDiarycnt
Set cDiarycnt = new cdiary_list
	cDiarycnt.getDiaryCateCnt '상태바 count



Set PrdBrandList = new cdiary_list
	'아이템 리스트
	PrdBrandList.FPageSize = PageSize
	PrdBrandList.FCurrPage = CurrPage
	PrdBrandList.frectdesign = sArrDesign
	PrdBrandList.frectcontents = ""
	PrdBrandList.frectkeyword = ""
	PrdBrandList.fmdpick = ""
	PrdBrandList.ftectSortMet = SortMet
	''PrdBrandList.fuserid = userid   '' 의미없음.
	PrdBrandList.getDiaryItemLIst



	dim rstWishItem: rstWishItem=""
	dim rstWishCnt: rstWishCnt=""

dim oMainContents
	set oMainContents = new cdiary_list
'	oMainContents.FRectIdx = idx
	oMainContents.fcontents_oneitem
	
IF application("Svr_Info") = "Dev" THEN
	imglink = "test"
Else
	imglink = "o"
End If
%>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2017.css" />
<script type="text/javascript">
$(function(){
	<% if Request("tab") <> "" then %>
		window.parent.$('html,body').animate({scrollTop:$("#cmtListList").offset().top}, 0);
	<% end if %>
});

$(function(){
	/* main swipe */
	var mySwiper = new Swiper('.mainRolling .swiper-container',{
		loop: true,
		speed:1500,
		autoplay:false,
		pagination:'.mainRolling .pagination',
		paginationClickable:true
	})
	$('.mainRolling .prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	})
	$('.mainRolling .next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});

	diarybestlist('b');

	// best award tab
	$('.diaryBest .diaryList').hide();
	$('.diaryBest .array').find('li:first').addClass('current');
	$('.diaryBest .tabContainer').find('.diaryList:first').show();
	$('.diaryBest .array li').click(function() {
		$(this).siblings('li').removeClass('current');
		$(this).addClass("current");
//		$(this).closest('.array').nextAll('.tabContainer:first').find('.diaryList').hide();
		var activeTab = $(this).find('a').attr('href');
		$(activeTab).show();
		return false;
	});

	// preview layer
	function diaryPreviewSlide(){
		$('.diaryPreview .slide').slidesjs({
			width:"670",
			height:"470",
			pagination:false,
			navigation:{effect:"fade"},
			play:{interval:2800, effect:"fade", auto:true},
			effect:{fade: {speed:800, crossfade:true}
			},
			callback: {
				complete: function(number) {
					var pluginInstance = $('.diaryPreview .slide').data('plugin_slidesjs');
					setTimeout(function() {
						pluginInstance.play(true);
					}, pluginInstance.options.play.interval);
				}
			}
		});
	}
	$('.btnPreview').click(function(){
		diaryPreviewSlide();
	});

	// 마우스 오버시 활용컷보기
	$(function() {
		$('.diaryList li .pPhoto').mouseenter(function(e){
			$(this).find('dfn').fadeIn(150);
		}).mouseleave(function(e){
			$(this).find('dfn').fadeOut(150);
		});
	});
});

function searchlink(v,l){
	if (v == "")
	{
		document.location = "/<%=g_HomeFolder%>/index.asp?tab="+l;
	}else{
		document.location = "/<%=g_HomeFolder%>/index.asp?arrds=" + v + ",&tab="+l;
	}
}

function jsGoPage(iP){
document.sFrm.cpg.value = iP;
document.sFrm.submit();
}

function fnSearch(frmnm,frmval){
	frmnm.value = frmval;
	var frm = document.sFrm;
	frm.cpg.value=1;
	frm.submit();
}

function diarybestlist(bestgubun){
	var vbestgubun =bestgubun;
	if (vbestgubun==''){
		vbestgubun='b';
	}
	var str = $.ajax({
		type: "GET",
		url: "/diarystory2017/inc/ajax_diary_best.asp",
		data: "bestgubun="+vbestgubun,
		dataType: "text",
		async: false
	}).responseText;

	$('#divdiarybest').empty().html(str);
}

function fnviewPreviewImg(didx){
	var str = $.ajax({
		type: "GET",
		url: "/diarystory2017/previewImg_Ajax.asp",
		data: "diary_idx="+didx,
		dataType: "text",
		async: false
	}).responseText;
	$('#previewLoad').empty().html(str);

	viewPoupLayer('modal',$('#lyrPreview').html());
	return false;
}

//review 상품후기 더보기
function popEvalList(iid) {
	popEvaluate(iid,'ne');
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diarystory2017">
		<div id="contentWrap">
			<!-- #include virtual="/diarystory2017/inc/head.asp" -->
			<div class="diaryContent">
				<%' 상단 메인 롤링 %>
				<div class="mainRolling">
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<%'  for dev msg : 슬라이드 한개당 3개영역(중앙 메인 이미지, 왼쪽배경,오른쪽배경) 등록 %>
							<% If weekDate = "토요일" Or weekDate = "일요일" Or weekDate = "공휴일" Then %>
							<% else %>
								<% If Left(Now(), 10) < "2017-01-01" Then %>
								<%'' 1+1, 1:1 배너 띄움 %>
									<% if cDiary.Ftotalcount > 0 then %>
										<div class="swiper-slide">
											<div class="mainPic" style="background-image:url(<%= cDiary.FOneItem.FImage1 %>);">롤링이미지1</div>
											<div class="bg left" style="background-color:#<%= cDiary.FOneItem.Fcolorcodeleft %>;">왼쪽 배경</div>
											<div class="bg right" style="background-color:#<%= cDiary.FOneItem.Fcolorcoderight %>;">오른쪽 배경</div>
											<div class="linkArea">
												<a href="" onclick="TnGotoProduct('<%=cDiary.FOneItem.FItemid%>'); return false;"><!-- 링크영역 --></a>
											<% IF GiftSu > 0 Then %>
												<% if cDiary.FOneItem.fplustype="1" then %>
													<% If Left(Now(), 10) >= "2016-12-13" Then %>
														<strong class="plus"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/ico_gift.png" alt="Gift" /></strong>
													<% else %>
														<strong class="plus"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/ico_plus_one.png" alt="1+1" /></strong>
													<% end if %>
												<% else %>
													<% If Left(Now(), 10) >= "2016-12-13" Then %>
														<strong class="plus"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/ico_gift.png" alt="1:1" /></strong>
													<% else %>
														<strong class="plus"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/ico_colon_one.png" alt="1:1" /></strong>
													<% end if %>
												<% end if %>
												<span class="count"><%= GiftSu %>개 남음</span>
											<% end if %>
											</div>
										</div>
									<% end if %>
								<% End If %>
							<% end if %>

							<% If getDiaryEventMainImg("19") <> "" Then %>
							<%
								Dim tmpGetDiaryEventMainImg19, tmpcolorcode
								tmpGetDiaryEventMainImg19 = Split(getDiaryEventMainImg("19"), "|")
							'	tmpcolorcode = = Split(getDiaryEventMainImg("19"), "|")
							%>
							<div class="swiper-slide">
								<div class="mainPic" style="background-image:url(http://<%= imglink %>imgstatic.10x10.co.kr/diary/main/<%=tmpGetDiaryEventMainImg19(0)%>);">롤링이미지1</div>
								<div class="bg left" style="background-color:#<%=tmpGetDiaryEventMainImg19(2)%>;">왼쪽 배경</div>
								<div class="bg right" style="background-color:#<%=tmpGetDiaryEventMainImg19(3)%>;">오른쪽 배경</div>
								<div class="linkArea">
									<a href="<%=tmpGetDiaryEventMainImg19(1)%>"><!-- 링크영역 --></a>
								</div>
							</div>
							<% end if %>
							<% If getDiaryEventMainImg("16") <> "" Then %>
							<%
								Dim tmpGetDiaryEventMainImg16
								tmpGetDiaryEventMainImg16 = Split(getDiaryEventMainImg("16"), "|")
							%>
							<div class="swiper-slide">
								<div class="mainPic" style="background-image:url(http://<%= imglink %>imgstatic.10x10.co.kr/diary/main/<%=tmpGetDiaryEventMainImg16(0)%>);">롤링이미지1</div>
								<div class="bg left" style="background-color:#<%=tmpGetDiaryEventMainImg16(2)%>;">왼쪽 배경</div>
								<div class="bg right" style="background-color:#<%=tmpGetDiaryEventMainImg16(3)%>;">오른쪽 배경</div>
								<div class="linkArea">
									<a href="<%=tmpGetDiaryEventMainImg16(1)%>"><!-- 링크영역 --></a>
								</div>
							</div>
							<% end if %>
							<% If getDiaryEventMainImg("17") <> "" Then %>
							<%
								Dim tmpGetDiaryEventMainImg17
								tmpGetDiaryEventMainImg17 = Split(getDiaryEventMainImg("17"), "|")
							%>
							<div class="swiper-slide">
								<div class="mainPic" style="background-image:url(http://<%= imglink %>imgstatic.10x10.co.kr/diary/main/<%=tmpGetDiaryEventMainImg17(0)%>);">롤링이미지1</div>
								<div class="bg left" style="background-color:#<%=tmpGetDiaryEventMainImg17(2)%>;">왼쪽 배경</div>
								<div class="bg right" style="background-color:#<%=tmpGetDiaryEventMainImg17(3)%>;">오른쪽 배경</div>
								<div class="linkArea">
									<a href="<%=tmpGetDiaryEventMainImg17(1)%>"><!-- 링크영역 --></a>
								</div>
							</div>
							<% end if %>
						</div>
					</div>
					<button type="button" class="btnNav prev">이전</button>
					<button type="button" class="btnNav next">다음</button>
					<div class="pagination"></div>
				</div>

				<% If Left(Now(), 10) < "2017-03-01" Then %>
					<div class="diaryGift">
						<a href="/diarystory2017/gift.asp">
						
						</a>
					</div>
				<% end if %>

				<form name="sFrm" method="get" action="#cmtListList">
				<input type="hidden" name="cpg" value="<%=PrdBrandList.FCurrPage %>"/>
				<input type="hidden" name="page" value="<%= PrdBrandList.FPageSize %>"/>
				<input type="hidden" name="srm" value="<%= PrdBrandList.ftectSortMet %>"/>
				<input type="hidden" name="arrds" value="<%= ArrDesign %>"/>
				<input type="hidden" name="ListDiv" value="<%=ListDiv%>"/>
				<%' 카테고리별 다이어리 %>
				<a name="cmtListList" id="cmtListList"></a>
				<div class="diaryCtgy">
					<div class="array">
						<ul class="tab">
							<!-- for dev msg : 선택시 클래스 current 넣어주세요 -->
							<li  class="<%=chkiif(ArrDesign="","current","")%>">
								<a href="javascript:searchlink('','all')">
									<p>
										<span>
											<img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_all.png" alt="ALL" /> (
											<% if cDiarycnt.fresultcount > 1 then %>
												<%=cDiarycnt.FItemList(2).Fdiarytotcnt %>
											<% else %>
												0
											<% end if %>	
											)
										</span>
									</p>
								</a>
							</li>

							<li class="<%=chkiif(ArrDesign="10,","current","10")%>">
								<a href="javascript:searchlink('10','sim')">
									<p>
										<span>
											<img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_simple.png" alt="Simple" /> (
											<% if cDiarycnt.fresultcount > 1 then %>
												<%=cDiarycnt.FItemList(2).FdiaryCount1 %>
											<% else %>
												0
											<% end if %>
											)
										</span>
									</p>
								</a>
							</li>

							<li class="<%=chkiif(ArrDesign="20,","current","20")%>">
								<a href="javascript:searchlink('20','ill')"">
									<p>
										<span>
											<img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_illust.png" alt="illust" /> (
											<% if cDiarycnt.fresultcount > 1 then %>
												<%=cDiarycnt.FItemList(2).FdiaryCount2 %>
											<% else %>
												0
											<% end if %>
											)
										</span>
									</p>
								</a>
							</li>

							<li class="<%=chkiif(ArrDesign="30,","current","30")%>">
								<a href="javascript:searchlink('30','pat')"">
									<p>
										<span>
											<img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_pattern.png" alt="Pattern" /> (
											<% if cDiarycnt.fresultcount > 1 then %>
												<%=cDiarycnt.FItemList(2).FdiaryCount3 %>
											<% else %>
												0
											<% end if %>
											)
										</span>
									</p>
								</a>
							</li>

							<li class="<%=chkiif(ArrDesign="40,","current","40")%>">
								<a href="javascript:searchlink('40','pho')">
									<p>
										<span>
											<img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_photo.png" alt="Photo" /> (
											<% if cDiarycnt.fresultcount > 1 then %>
												<%=cDiarycnt.FItemList(2).FdiaryCount4 %>
											<% else %>
												0
											<% end if %>
											)
										</span>
									</p>
								</a>
							</li>
						</ul>
						<div class="option">
							<select class="optSelect" onchange="fnSearch(this.form.srm,this.value);" title="다이어리 정렬 방식 선택">
								<option value="best" <%=CHKIIF(SortMet="best","selected","")%>>인기상품순</option>
								<option value="newitem" <%=CHKIIF(SortMet="newitem","selected","")%>>신상품순</option>
								<option value="min" <%=CHKIIF(SortMet="min","selected","")%>>낮은가격순</option>
								<option value="hi" <%=CHKIIF(SortMet="hi","selected","")%>>높은가격순</option>
								<option value="hs" <%=CHKIIF(SortMet="hs","selected","")%>>높은할인율순</option>
							</select>
						</div>
					</div>
					<div class="diaryList">
						<ul>
						<%
							If PrdBrandList.FResultCount > 0 Then
								For i = 0 To PrdBrandList.FResultCount - 1

		
									Dim tempimg, tempimg2
									dim imgSz : imgSz = 240
		
									If ListDiv = "item" Then
										tempimg = PrdBrandList.FItemList(i).FDiaryBasicImg
										tempimg2 = PrdBrandList.FItemList(i).FDiaryBasicImg2
									End If
									If ListDiv = "list" Then''2016 사용안함(활용컷-마우스오버로)
										tempimg = PrdBrandList.FItemList(i).FDiaryBasicImg2
									End If

									IF application("Svr_Info") = "Dev" THEN
										tempimg = left(tempimg,7)&mid(tempimg,12)
										tempimg2 = left(PrdBrandList.FItemList(i).FDiaryBasicImg2,7)&mid(PrdBrandList.FItemList(i).FDiaryBasicImg2,12)''마우스오버 활용컷
									end if
						%>
									<!-- for dev msg : 상품은 16개씩 노출됩니다 / 품절일경우 클래스 soldOut 붙여주세요-->
									<li <% if PrdBrandList.FItemList(i).IsSoldOut then %>class="soldOut"<% end if %>>
										<div class="pPhoto">
											<% if PrdBrandList.FItemList(i).IsSoldOut then %>
												<span class="soldOutMask"></span>
											<% end if %>
											<!-- 미리보기 -->
											<% If IsNull(PrdBrandList.FItemList(i).FpreviewImg) Or PrdBrandList.FItemList(i).FpreviewImg="" Then %>
											<% Else %>
												<a href="#lyrPreview" onclick="fnviewPreviewImg('<%= PrdBrandList.FItemList(i).FpreviewImg %>'); return false;" target="_top" class="btnPreview"></a>
											<% End If %>

											<a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%>">
												<img src="<%=tempimg %>" width="240" height="240" alt="<%= PrdBrandList.FItemList(i).FItemName %>" />
												<% if tempimg2 <>"" then %>
													<dfn>
														<img src="<%=getThumbImgFromURL(tempimg2,imgSz,imgSz,"true","false")%>" width="240" height="240" alt="<%=Replace(PrdBrandList.FItemList(i).FItemName,"""","")%>" />
													</dfn>
												<% end if %>
											</a>
										</div>
										<div class="pdtInfo">
											<p class="brand"><a href="" onclick="GoToBrandShop('<%= PrdBrandList.FItemList(i).FMakerId %>'); return false;"><%= PrdBrandList.FItemList(i).Fsocname %></a></p>
											<a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%>">
												<p class="name">
												<% If PrdBrandList.FItemList(i).isSaleItem Or PrdBrandList.FItemList(i).isLimitItem Then %>
													<%= chrbyte(PrdBrandList.FItemList(i).FItemName,30,"Y") %>
												<% Else %>
													<%= PrdBrandList.FItemList(i).FItemName %>
												<% End If %>
												</p>

												<% if PrdBrandList.FItemList(i).IsSaleItem or PrdBrandList.FItemList(i).isCouponItem Then %>
													<% IF PrdBrandList.FItemList(i).IsSaleItem then %>
														<p class="price"><%=FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0)%>원 <strong class="cRd0V15">[<%=PrdBrandList.FItemList(i).getSalePro%>]</strong></p>
													<% End If %>
													<% IF PrdBrandList.FItemList(i).IsCouponItem Then %>
														<p class="price"><%=FormatNumber(PrdBrandList.FItemList(i).GetCouponAssignPrice,0)%>원 <strong class="cGr0V15">[<%=PrdBrandList.FItemList(i).GetCouponDiscountStr%>]</strong></p>
													<% end if %>
												<% else %>
													<p class="price"><%=FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0) & chkIIF(PrdBrandList.FItemList(i).IsMileShopitem,"Point","원")%></p>
												<% end if %>
											</a>
										</div>
									</li>
						<%
								next
							End If
						%>
						</ul>
						<div class="pageWrapV15">
							<%= fnDisplayPaging_New(CurrPage,PrdBrandList.FTotalCount,PageSize,10,"jsGoPage") %>
						</div>
					</div>
				</div>
				</form>

				<!-- 관련 이벤트 -->
				<div class="relatedEvent">
					<div>
						<img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/img_related_item.jpg" alt="" usemap="#eventMap" />
						<map name="eventMap" id="eventMap">
							<area shape="rect" coords="39,1,612,212" onfocus="this.blur();" href="/event/eventmain.asp?eventid=73013" alt="#The Pen Fair - 펜과 함께하는 삶" />
							<area shape="rect" coords="640,1,912,212" onfocus="this.blur();" href="/event/eventmain.asp?eventid=73328" alt="#Planner - 오늘 할 일 미루지 말고 플래너와 함께" />
							<area shape="rect" coords="941,1,1212,212" onfocus="this.blur();" href="/event/eventmain.asp?eventid=73355" alt="#Note - 노트도 새롭게 바꿔볼까?" />
							<area shape="rect" coords="39,250,310,461" onfocus="this.blur();" href="/event/eventmain.asp?eventid=73356" alt="#Calender - 허전한 책상 캘린더로 채워볼까?" />
							<area shape="rect" coords="340,250,611,461" onfocus="this.blur();" href="/shopping/category_list.asp?disp=101102102" alt="#Organizer - 샘솟는 정리 본능, 오거나이저" />
							<area shape="rect" coords="640,250,911,461" onfocus="this.blur();" href="/event/eventmain.asp?eventid=73358" alt="#Premium - 헤어나올 수 없는 몰스킨&amp;미도리" />
							<area shape="rect" coords="941,250,1210,461" onfocus="this.blur();" href="/event/eventmain.asp?eventid=73327" alt="#Deco - 손재주 없어도 예쁘게 꾸미기" />
						</map>
					</div>
				</div>
				<!--//  관련 이벤트 -->

				<!-- Best Award -->
				<div class="diaryBest">
					<h3><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tit_best.png" alt="BEST AWARD" /></h3>
					<div class="array">
						<ul class="tab">
							<li><a href="" onclick="diarybestlist('b'); return false;"><p><span><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_seller.png" alt="Seller" /></span></p></a></li>
							<li><a href="" onclick="diarybestlist('f'); return false;"><p><span><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_wish.png" alt="Wish" /></span></p></a></li>
							<li><a href="" onclick="diarybestlist('r'); return false;"><p><span><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_review.png" alt="Review" /></span></p></a></li>
							<li><a href="" onclick="diarybestlist('e'); return false;"><p><span><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_event.png" alt="Event" /></span></p></a></li>
						</ul>
					</div>

					<div class="tabContainer" id="divdiarybest"></div>
				</div>
				<!--// Best Award -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

<%' 미리보기 레이어 %>
<div id="lyrPreview" style="display:none;">
	<div class="diaryPreview">
		<div class="previewBody" id="previewLoad"></div>
	</div>
</div>

</body>
</html>
<%
	Set cDiary = Nothing
	Set cDiarycnt = Nothing
	Set PrdBrandList = Nothing
	Set oMainContents = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->