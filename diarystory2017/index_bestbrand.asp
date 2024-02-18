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
<!-- #include virtual="/diarystory2016/lib/classes/specialbrandCls.asp" -->
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




''스페셜 브랜드 테스트
dim research, isusing, page, brandid

	page    = requestcheckvar(request("page"),16)

if page="" then page=1

dim oSpecialBrand
set oSpecialBrand = new DiaryCls
	oSpecialBrand.FPageSize = 10
	oSpecialBrand.FCurrPage = page
	oSpecialBrand.fcontents_list
	
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

		
		<% if oSpecialBrand.FResultCount > 0 then %>
			<% for i=0 to oSpecialBrand.FResultCount - 1 %>
						<%= oSpecialBrand.FItemList(i).Fbrandid %><br>
					   <img src="<%=uploadUrl%>/diary/specialbrand/<%= oSpecialBrand.FItemList(i).fmainbrandimg %>" border="0" width="70" height="70"><br>
					   <%= oSpecialBrand.FItemList(i).fbrandtext %><br>
					   <%'= oSpecialBrand.FItemList(i).fitemimgid %>
<%
dim itemarr, imgarr, itemcnt, j, itembasicimg, itembasicid
if isarray(split(oSpecialBrand.FItemList(i).fitemimgid,",")) then
	itemarr = split(oSpecialBrand.FItemList(i).fitemimgid,",")
	'imgarr = split(itemarr,"/!/")
	itemcnt = UBound(itemarr)+1

	for j = 0 to itemcnt-1
		itembasicimg	= split(itemarr(j),"/!/")(0)
		itembasicid	= split(itemarr(j),"/!/")(1)
		
		response.write itembasicimg &"........"&itembasicid&"<Br>"
'		response.write itemarr(j) & "....."
	next
end if
%>
<br><br><br>
			<% next %>
		<% end if %>




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