<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2016 MAIN
' History : 2015.09.21 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2016/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2016/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->

<%
Dim weekDate
Dim i , PrdBrandList , userid, imglink
Dim ListDiv
Dim PageSize , SortMet , CurrPage , vParaMeter , GiftSu

weekDate = weekDayName(weekDay(now)) '// 요일 구하기 내장 함수
if date = "2015-10-09" or date = "2015-12-25" then
	weekDate = "공휴일"
end if

ListDiv	= requestcheckvar(request("ListDiv"),4)
If ListDiv = "" Then ListDiv = "item"

PageSize	= requestcheckvar(request("page"),2)
SortMet 	= requestCheckVar(request("srm"),9)
CurrPage 	= requestCheckVar(request("cpg"),9)
userid		= getEncLoginUserID

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
<link rel="stylesheet" type="text/css" href="/lib/css/diary2016.css" />
<script type="text/javascript">
$(function(){
	<% if Request("tab") <> "" then %>
		window.parent.$('html,body').animate({scrollTop:$("#cmtListList").offset().top}, 0);
	<% end if %>
});

$(function() {
	// Item Image Control
	$(".pdtList li .pPhoto").mouseenter(function(e){
		$(this).find("dfn").fadeIn(150);
	}).mouseleave(function(e){
		$(this).find("dfn").fadeOut(150);
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
		url: "/diarystory2016/inc/ajax_diary_best.asp",
		data: "bestgubun="+vbestgubun,
		dataType: "text",
		async: false
	}).responseText;

	$('#divdiarybest').empty().html(str);
}

$(function(){
	/* main swipe */
	var mySwiper = new Swiper('.swiper-container',{
		loop: true,
		speed:1500,
		autoplay:false,
		pagination: '.pagination',
		paginationClickable:true
	})
	$('.prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	})
	$('.next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
	
	diarybestlist('b');

	// best award tab
	$('.diaryBest .diaryList').hide();
	$('.diaryBest .array').find('li:first a').addClass('current');
	$('.diaryBest .tabContainer').find('.diaryList:first').show();
	$('.diaryBest .array li').click(function() {
		$(this).siblings('li').find('a').removeClass('current');
		$(this).find('a').addClass("current");
		//$(this).closest('.array').nextAll('.tabContainer:first').find('.diaryList').hide();
		var activeTab = $(this).find('a').attr('href');
		$(activeTab).show();
		return false;
	});

	$(".diaryItem li a").mouseover(function(){
		$(this).find("span").fadeIn(200);
	});
	$(".diaryItem li a").mouseleave(function(){
		$(this).find("span").fadeOut(200);
	});

	// preview layer
	function diaryPreviewSlide(){
		$(".slide").slidesjs({
			width:"670",
			height:"470",
			pagination:{effect:"fade"},
			navigation:{effect:"fade"},
			play:{interval:2800, effect:"fade", auto:true},
			effect:{fade: {speed:800, crossfade:true}
			},
			callback: {
				complete: function(number) {
					var pluginInstance = $('.slide').data('plugin_slidesjs');
					setTimeout(function() {
						pluginInstance.play(true);
					}, pluginInstance.options.play.interval);
				}
			}
		});
	}

	$(".btnPreview").click(function(){
		diaryPreviewSlide()
	});
});

function fnviewPreviewImg(didx){
	var str = $.ajax({
		type: "GET",
		url: "/diarystory2016/previewImg_Ajax.asp",
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
	<div class="container diarystory2016">
		<div id="contentWrap">
			<!-- #include virtual="/diarystory2016/inc/head.asp" -->
			<div class="diaryContent">
				<!-- 상단 메인 롤링 -->
				<div class="mainRolling">
					<div class="diarySwiper">
						<div class="swiper">
							<div class="swiper-container">
								<div class="swiper-wrapper">
									<!-- for dev msg : 슬라이드 한개당 3개영역이 등록됩니다(중앙 메인 이미지, 왼쪽배경,오른쪽배경) -->
									<% If weekDate = "토요일" Or weekDate = "일요일" Or weekDate = "공휴일" Then %>
									<% else %>
										<% If Left(Now(), 10) < "2016-01-01" Then %>
										<%'' 1+1, 1:1 배너 띄움 %>
											<div class="swiper-slide">
												<div class="mainPic" style="background-image:url(<%= cDiary.FOneItem.FImage1 %>);">롤링이미지1</div>
												<div class="bg left" style="background-color:#<%= cDiary.FOneItem.Fcolorcodeleft %>;">왼쪽 배경</div>
												<div class="bg right" style="background-color:#<%= cDiary.FOneItem.Fcolorcoderight %>;">오른쪽 배경</div>
												<div class="linkArea">
													<a href="" onclick="TnGotoProduct('<%=cDiary.FOneItem.FItemid%>'); return false;"><!-- 링크영역 --></a>
												<% IF GiftSu > 0 Then %>
													<% if cDiary.FOneItem.fplustype="1" then %>
														<strong class="plus"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/ico_one_plus_one.png" alt="1+1" /></strong>
													<% else %>
														<strong class="plus"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/ico_one_colon_one.png" alt="1:1" /></strong>
													<% end if %>
													<strong class="count"><%= GiftSu %>개 남음</strong>
												<% end if %>
												</div>
											</div>
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
						</div>
						<button type="button" class="btnNav prev">이전</button>
						<button type="button" class="btnNav next">다음</button>
						<div class="pagination"></div>
					</div>
				</div>
				<!--// 상단 메인 롤링 -->
				
				<% If Left(Now(), 10) < "2016-03-01" Then %>
					<div class="diaryGift" style="display:none;">
						<a href="/diarystory2016/gift.asp">
							<img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/bnr_diary_gift.jpg" alt="DIARY GIFT" />
						</a>
					</div>
				<% end if %>

				<form name="sFrm" method="get" action="#cmtListList">
				<input type="hidden" name="cpg" value="<%=PrdBrandList.FCurrPage %>"/>
				<input type="hidden" name="page" value="<%= PrdBrandList.FPageSize %>"/>
				<input type="hidden" name="srm" value="<%= PrdBrandList.ftectSortMet %>"/>
				<input type="hidden" name="arrds" value="<%= ArrDesign %>"/>
				<input type="hidden" name="ListDiv" value="<%=ListDiv%>"/>
				<!-- 카테고리별 다이어리 -->
				<a name="cmtListList" id="cmtListList"></a>
				<div class="diaryCtgy">
					<div class="array">
						<ul>
							<!-- for dev msg : 선택시 클래스 current 넣어주세요 -->
							<li class="all">
								<a href="javascript:searchlink('','all')" class="<%=chkiif(ArrDesign="","current","")%>">
									<em><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tab_all.gif" alt="ALL" /></em> 
									 <span>(
										<% if cDiarycnt.fresultcount > 1 then %>
											<%=cDiarycnt.FItemList(2).Fdiarytotcnt %>
										<% else %>
											0
										<% end if %>	
									)</span>
								</a>
							</li>
							<li class="simple">
								<a href="javascript:searchlink('10','sim')" class="<%=chkiif(ArrDesign="10,","current","10")%>">
									<em><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tab_simple.gif" alt="Simple" /></em>
									 <span>(
										<% if cDiarycnt.fresultcount > 1 then %>
											<%=cDiarycnt.FItemList(2).FdiaryCount1 %>
										<% else %>
											0
										<% end if %>
									 	)</span>
								</a>
							</li>
							<li class="illust">
								<a href="javascript:searchlink('20','ill')"" class="<%=chkiif(ArrDesign="20,","current","20")%>">
									<em><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tab_illust.gif" alt="illust" /></em>
									 <span>(
										<% if cDiarycnt.fresultcount > 1 then %>
											<%=cDiarycnt.FItemList(2).FdiaryCount2 %>
										<% else %>
											0
										<% end if %>
									 	)</span>
								</a>
							</li>
							
							<li class="pattern">
								<a href="javascript:searchlink('30','pat')"" class="<%=chkiif(ArrDesign="30,","current","30")%>">
									<em><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tab_pattern.gif" alt="Pattern" /></em>
									 <span>(
										<% if cDiarycnt.fresultcount > 1 then %>
											<%=cDiarycnt.FItemList(2).FdiaryCount3 %>
										<% else %>
											0
										<% end if %>
									 	)</span>
								</a>
							</li>
							
							<li class="photo">
								<a href="javascript:searchlink('40','pho')" class="<%=chkiif(ArrDesign="40,","current","40")%>">
									<em><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tab_photo.gif" alt="Photo" /></em>
									 <span>(
										<% if cDiarycnt.fresultcount > 1 then %>
											<%=cDiarycnt.FItemList(2).FdiaryCount4 %>
										<% else %>
											0
										<% end if %>
									 	)</span>
								</a>
							</li>
						</ul>
						<div class="option">
							<a href="/diarystory2016/special.asp" class="btnSpecial">10X10 SPECIAL EDITION</a>
							<select title="다이어리 상품 정렬 방식 선택" onchange="fnSearch(this.form.srm,this.value);" class="optSelect">
								<option value="best" <%=CHKIIF(SortMet="best","selected","")%>>인기상품순</option>
								<option value="newitem" <%=CHKIIF(SortMet="newitem","selected","")%>>신상품순</option>
								<option value="min" <%=CHKIIF(SortMet="min","selected","")%>>낮은가격순</option>
								<option value="hi" <%=CHKIIF(SortMet="hi","selected","")%>>높은가격순</option>
								<option value="hs" <%=CHKIIF(SortMet="hs","selected","")%>>높은할인율순</option>
							</select>
						</div>
					</div>

					<div class="diaryList">
						<ul class="pdtList">
							<!-- for dev msg : 상품은 8개씩 노출됩니다 -->
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
							<li <% if PrdBrandList.FItemList(i).IsSoldOut then %>class="soldOut"<% end if %>>
								<div class="pPhoto">
									<% if PrdBrandList.FItemList(i).IsSoldOut then %>
										<span class="soldOutMask"></span>
									<% end if %>
									<% if PrdBrandList.FItemList(i).Flimited = "o" then %>
										<span class="special">
											<img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/ico_10x10_special.png" alt="10x10 Special" />
										</span>
									<% end if %>
									<% If IsNull(PrdBrandList.FItemList(i).FpreviewImg) Or PrdBrandList.FItemList(i).FpreviewImg="" Then %>
									<% Else %>
										<a href="#lyrPreview" onclick="fnviewPreviewImg('<%= PrdBrandList.FItemList(i).FpreviewImg %>'); return false;" target="_top" class="btnPreview"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/btn_preview.png" alt="미리보기" /></a>
									<% End If %>
									<a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%>">
										<img src="<%=tempimg %>" width="240" height="240" alt="<%= PrdBrandList.FItemList(i).FItemName %>">
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
													<p class="price"><span class="finalP"><%=FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=PrdBrandList.FItemList(i).getSalePro%>]</strong></p>
												<% End If %>
												<% IF PrdBrandList.FItemList(i).IsCouponItem Then %>
													<p class="price"><span class="finalP"><%=FormatNumber(PrdBrandList.FItemList(i).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=PrdBrandList.FItemList(i).GetCouponDiscountStr%>]</strong></p>
												<% end if %>
											<% else %>
												<p class="price"><span class="finalP"><%=FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0) & chkIIF(PrdBrandList.FItemList(i).IsMileShopitem,"Point","원")%></span></p>
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
				<!--// 카테고리별 다이어리 -->
				</form>

				<div class="diaryItem">
					<ul>
						<li><a href="/event/eventmain.asp?eventid=66094"><span></span><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/bnr_item_calendar.jpg" alt="허전한 벽, 캘린더로 채워볼까?" /></a></li>
						<li><a href="/event/eventmain.asp?eventid=66140"><span></span><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/bnr_item_planner.jpg" alt="오늘 할 일 미루지 말고 플래너와 함께" /></a></li>
						<li><a href="/event/eventmain.asp?eventid=66838"><span></span><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/bnr_item_moleskine.jpg" alt="헤어나올 수 없는 마성의 몰스킨" /></a></li>
						<li><a href="/event/eventmain.asp?eventid=66097"><span></span><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/bnr_item_deco.jpg" alt="손재주 없어도 예쁘게 꾸며요" /></a></li>
						<li><a href="/event/eventmain.asp?eventid=66096"><span></span><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/bnr_item_pen.jpg" alt="예쁜 다이어리에 모나미로 써요?" /></a></li>
						<li><a href="/event/eventmain.asp?eventid=66095"><span></span><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/bnr_item_note.jpg" alt="노트도 새롭게 바꿔볼까" /></a></li>
						<li><a href="/shopping/category_list.asp?disp=101102102"><span></span><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/bnr_item_organizer.jpg" alt="샘솟는 정리 본능, 오거나이저" /></a></li>
					</ul>
				</div>
				<!-- BEST AWARD -->
				<div class="diaryBest">
					<h3 class="bPad10 lPad15"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_best_award.gif" alt="BEST AWARD" /></h3>
					<div class="array">
						<ul>
							<li class="seller"><a href="" onclick="diarybestlist('b'); return false;" class="current"><em><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tab_seller.gif" alt="SELLER" /></em><span></span></a></li>
							<li class="wish"><a href="" onclick="diarybestlist('f'); return false;" ><em><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tab_wish.gif" alt="WISH" /></em><span></span></a></li>
							<li class="review"><a href="" onclick="diarybestlist('r'); return false;"><em><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tab_review.gif" alt="REVIEW" /></em><span></span></a></li>
							<li class="event"><a href="" onclick="diarybestlist('e'); return false;"><em><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tab_event.gif" alt="EVENT" /></em><span></span></a></li>
						</ul>
					</div>
					<div class="tabContainer" id="divdiarybest">
					</div>
				</div>
				<!--// BEST AWARD -->
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<!-- 미리보기 레이어 -->
<div id="lyrPreview" style="display:none;">
	<div class="diaryPreview">
		<div class="previewBody" id="previewLoad"></div>
	</div>
</div>
<!--// 미리보기 레이어 -->
</body>
</html>
<%
	Set cDiary = Nothing
	Set cDiarycnt = Nothing
	Set PrdBrandList = Nothing
	Set oMainContents = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->