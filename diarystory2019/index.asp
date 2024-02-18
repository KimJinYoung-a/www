<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2019 MAIN
' History : 2018-08-22 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2019/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2019/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "//m.10x10.co.kr/diarystory2019/"
			REsponse.End
		end if
	end if
end if

Dim weekDate, design, keyword, contents
Dim i , PrdBrandList , userid, imglink
Dim ListDiv
Dim PageSize , SortMet , CurrPage , vParaMeter , GiftSu
dim gaParam : gaParam = "&gaparam=diarystory_"

weekDate = weekDayName(weekDay(now)) '// 요일 구하기 내장 함수
if date = "2018-12-25" then
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
IF SortMet = "" Then SortMet = "newitem"

If ListDiv = "list" Then
	PageSize = 16
Else
	PageSize = 16
End If

Dim ArrDesign , tmp , iTmp , ctmp, ktmp, arrcontents ,arrkeyword
ArrDesign = request("arrds")
ArrDesign = split(ArrDesign,",")

For iTmp =0 to Ubound(ArrDesign)-1
	IF ArrDesign(iTmp)<>"" Then
		tmp = tmp & requestcheckvar(ArrDesign(iTmp),2) &","
	End IF
Next
ArrDesign = tmp

Dim sArrDesign,sarrcontents,sarrkeyword
sArrDesign =""
IF ArrDesign <> "" THEN sArrDesign = left(ArrDesign,(len(ArrDesign)-1))

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

Set PrdBrandList = new cdiary_list
	'아이템 리스트
	PrdBrandList.FPageSize = PageSize
	PrdBrandList.FCurrPage = 1	'CurrPage
	PrdBrandList.frectdesign = ""
	PrdBrandList.frectcontents = ""
	PrdBrandList.frectkeyword = ""
	PrdBrandList.fmdpick = ""
	PrdBrandList.ftectSortMet = SortMet
	PrdBrandList.getDiaryItemLIst

IF application("Svr_Info") = "Dev" THEN
	imglink = "test"
Else
	imglink = "o"
End If

dim youtubetext
%>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(function(){
	// rolling banner
	var evtSwiper = new Swiper('.main-rolling .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		loopedSlides:6,
		speed:1400,
		autoplay:8000,
		simulateTouch:false,
		pagination:'.main-rolling .pagination',
		paginationClickable:true,
		nextButton:'.main-rolling .btn-nxt',
		prevButton:'.main-rolling .btn-prev',
		onSlideChangeStart: function (e){
			bnrChange();
		}
	})
	$('.mask.right').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
	$('.mask.left').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	});
	$('.main-rolling .btn-prev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.main-rolling .btn-next').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
	function bnrChange(){
		$('.main-rolling .swiper-slide.swiper-slide').addClass('start');
	}

	$("#type0").prop('checked', true);
	diarybestlist('s');btnmore();

	/* 2019 ver */
	// tab
	$(".tab-cont").hide();
	$(".tab-container").find(".tab-cont:first").show();
	$(".tabV18 li").click(function() {
		$(this).siblings("li").removeClass("current");
		$(this).addClass("current");
		return false;
	});
	$(".tabV18 li").click(function() {
		return false;
	});

	// preview layer
	function diaryPreviewSlide(){
		$('.diary-preview .slide').slidesjs({
			width:"670",
			height:"470",
			pagination:false,
			navigation:{effect:"fade"},
			play:{interval:2800, effect:"fade", auto:false},
			effect:{fade: {speed:800, crossfade:true}
			},
			callback: {
				complete: function(number) {
					var pluginInstance = $('.diary-preview .slide').data('plugin_slidesjs');
					setTimeout(function() {
						pluginInstance.play(true);
					}, pluginInstance.options.play.interval);
				}
			}
		});
	}
	$('.btn-preview').click(function(){
		diaryPreviewSlide();
	});

// check all type
//	$(".diary-all .type0").click(function() {
//		if($('.diary-all .type0 input[type=checkbox]').prop('checked')==true){
//			$('.diary-all .type input[type=checkbox]').attr('checked',false);
//			return false;
//		}else{
//			$('.diary-all .type input[type=checkbox]').attr('checked',true);
//			return false;
//		}
//	});

	// gift layer
	function diaryGiftSlide(){
		$('.gift-layer .slide').slidesjs({
			width:"670",
			height:"470",
			pagination:false,
			navigation:false,
			play:{interval:1000, effect:"fade", auto:true},
			effect:{fade: {speed:1000, crossfade:true}
			},
			callback: {
				complete: function(number) {
					var pluginInstance = $('.gift-layer .slide').data('plugin_slidesjs');
					setTimeout(function() {
						pluginInstance.play(true);
					}, pluginInstance.options.play.interval);
				}
			}
		});
	}
	$('.diary-gift').click(function(){
		diaryGiftSlide();
		$('.scrollbarwrap').tinyscrollbar();
	});

	// amplitude init
	fnAmplitudeEventAction("view_diarymain","","");
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
		vbestgubun='s';
	}
	var str = $.ajax({
		type: "GET",
		url: "/diarystory2019/inc/ajax_diary_best.asp",
		data: "bestgubun="+vbestgubun,
		dataType: "text",
		async: false
	}).responseText;
	$('#divdiarybest').empty().html(str);
}


function diaryPreviewSlideii(){
	$('.diary-preview .slide').slidesjs({
		width:"670",
		height:"470",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2800, effect:"fade", auto:false},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.diary-preview .slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
}

function fnviewPreviewImg(didx){
	var str = $.ajax({
		type: "GET",
		url: "/diarystory2019/previewImg_Ajax.asp",
		data: "diary_idx="+didx,
		dataType: "text",
		async: false
	}).responseText;
	$('#previewLoad').empty().html(str);

	
	viewPoupLayer('modal',$('#lyrPreview').html());
	diaryPreviewSlideii();
	return false;
}

//review 상품후기 더보기
function popEvalList(iid) {
	popEvaluate(iid,'ne');
}

//정렬
function drlisttab(page,srm){
	$('.diary-category .tab li').removeClass('current');
	$("#tab"+srm).addClass('current');
	$("#sortmet").val(srm);
	$("#cpg").val('1');

	drlistJson();
	return false;
}

//디자인
function drlistdsn(dsnid,dsn){
	var	tmpdsnYN = $("#type"+dsnid).prop("checked");	
	var dsnchkval = document.getElementById('design');
	var inputcount = 0;
	
	if(tmpdsnYN){
		dsnchkval.value = dsnchkval.value.replace(dsn+",", '');
		dsnchkval.value = dsnchkval.value.replace(","+dsn, '');
		dsnchkval.value = dsnchkval.value.replace(dsn, '');
		inputcount -= 1;
	}else{
		var tmpdsnval = $("#design").val();
		var arrdsnval
		if(!tmpdsnval){
			arrdsnval = dsn
		}else{
			arrdsnval = tmpdsnval+","+dsn
		}
		$("#design").val(arrdsnval);
		inputcount += 1;
	}
	
	var dsnchklen = $("input:checkbox[name='dsnchkbox']:checked").length;
	var kwdchklen = $("input:checkbox[name='kwdchkbox']:checked").length;
	var cttchklen = $("input:checkbox[name='cttchkbox']:checked").length;
	var chklen = dsnchklen+kwdchklen+cttchklen+inputcount;

	if(chklen>0){
		$("#type0").prop('checked', false);
	}else{
		$("#type0").prop('checked', true);
	}
	$("#cpg").val('1');
	drlistJson();
	return false;
}

//키워드
function drlistkwd(knumber,kwd){
	var tmpkwdYN = $("#type"+knumber).prop("checked");
	var kwdchkval = document.getElementById('keyword');
	var inputcount = 0;
	
	if(tmpkwdYN){
		kwdchkval.value = kwdchkval.value.replace(kwd+",", '');
		kwdchkval.value = kwdchkval.value.replace(","+kwd, '');
		kwdchkval.value = kwdchkval.value.replace(kwd, '');
		inputcount -= 1;
	}else{
		var tmpkwdval = $("#keyword").val();
		var arrkwdval
		if(!tmpkwdval){
			arrkwdval = kwd
		}else{
			arrkwdval = tmpkwdval+","+kwd
		}
		$("#keyword").val(arrkwdval);
		inputcount += 1;
	}
	
	var dsnchklen = $("input:checkbox[name=dsnchkbox]:checked").length;
	var kwdchklen = $("input:checkbox[name=kwdchkbox]:checked").length;
	var cttchklen = $("input:checkbox[name=cttchkbox]:checked").length;
	var chklen = dsnchklen+kwdchklen+cttchklen+inputcount;
	if(chklen>0){
		$("#type0").prop('checked', false);
	}else{
		$("#type0").prop('checked', true);
	}
	$("#cpg").val('1');
	drlistJson();
	return false;
}

//콘텐츠
function drlistctt(cnumber,ctt){
	 var tmpcttYN = $("#type"+cnumber).prop("checked");
	 var cttchkval = document.getElementById('contents');
	 var inputcount = 0;
	
	if(tmpcttYN){
		cttchkval.value = cttchkval.value.replace(""+ctt+""+",", '');
		cttchkval.value = cttchkval.value.replace(","+""+ctt+"", '');
		cttchkval.value = cttchkval.value.replace(""+ctt+"", '');
		inputcount -= 1;
	}else{
		var tmpcttval = $("#contents").val();
		var arrcttval
		if(!tmpcttval){
			arrcttval = ""+ctt+""
		}else{
			arrcttval = tmpcttval+","+""+ctt+""
		}
		$("#contents").val(arrcttval);
		inputcount += 1;	
	}
	
	var dsnchklen = $("input:checkbox[name=dsnchkbox]:checked").length;
	var kwdchklen = $("input:checkbox[name=kwdchkbox]:checked").length;
	var cttchklen = $("input:checkbox[name=cttchkbox]:checked").length;
	var chklen = dsnchklen+kwdchklen+cttchklen+inputcount;

	if(chklen>0){
		$("#type0").prop('checked', false);
	}else{
		$("#type0").prop('checked', true);
	}

	$("#cpg").val('1');
	drlistJson();
	return false;
}

//페이징
function drlistpg(page){
	setTimeout(function() {
		fnAmplitudeEventMultiPropertiesAction('click_diary_main_pagination','price|gubun|page_num',$("#sortmet").val() +"|cpg="+page+"&srm="+srm+"&dsn="+dsn+"&kwd="+kwd+"&ctt="+ctt+"|"+page);
	}, 100);
	$("#cpg").val(page);
	drlistJson();
	window.$('html,body').animate({scrollTop:$("#pgscroll").offset().top}, 400);
	return false;
}

//검색리셋
function drlistall(){
	$("#design").val('');
	$("#keyword").val('');
	$("#contents").val('');
	$("#cpg").val('1');
	$('.diary-all .type input[type=checkbox]').attr('checked',false);
	drlistJson();
	return false;
}

function drlistJson(){
	var srm = $("#sortmet").val();
	var dsn = $("#design").val();
	var kwd = $("#keyword").val();
	var ctt = $("#contents").val();
	var page = $("#cpg").val();
	if (page==''){
		page=1;
	}

	$.ajax({
		type: "post",
		url: "/diarystory2019/ajax_diaryItemList_json.asp",
		data: "cpg="+page+"&srm="+srm+"&dsn="+dsn+"&kwd="+kwd+"&ctt="+ctt,
		cache: false,
		success: function(message) {
			//console.log(message);
			if(typeof(message)=="object") {
				if(typeof(message.diarylist)=="object") {
					$("#jsonlist").empty();
					$("#jsonpaging").empty();
					var i=0;
					var listtext='';
					var listpaging='';
					$(message.diarylist).each(function(){
						if(this.soldout=="True") {
							listtext = listtext+"<li class='soldOut'>";
						}else{
							listtext = listtext+"<li>";
						}

						listtext = listtext+"	<a href='/shopping/category_prd.asp?itemid="+this.itemid+"&gaparam=diarystory_list_"+ parseInt(i+1) +"' target='_blank' onclick=fnAmplitudeEventMultiPropertiesAction('click_diary_main_searchitems','price_filter|gubun_filter|itemid','"+ $("#sortmet").val() +"|cpg="+page+"&srm="+srm+"&dsn="+dsn+"&kwd="+kwd+"&ctt="+ctt+"|"+ this.itemid +"');>";
						listtext = listtext+"		<span class='thumbnail'>";

						if(this.soldout=="True") {
							listtext = listtext+"		<span class='soldOutMask'></span>";
						}

						listtext = listtext+"				<img src='"+this.image+"' alt='"+this.artitemname+"' />";
						if(this.previewimg){
							listtext = listtext+"			<button type='button' onclick='fnviewPreviewImg("+this.previewimg+");return false;' target='_top' class='btn-preview'>미리보기</button>";
						}

						if(this.diaryitembedge){
							listtext = listtext + this.diaryitembedge;
						}
						listtext = listtext+"		</span>";

						listtext = listtext+"		<span class='desc'>";
						listtext = listtext+"			<span class='brand'>"+this.makername+"</span>";
						listtext = listtext+"			<span class='name'>"+this.itemname+"</span>";
						listtext = listtext+"			<span class='price'>"+this.price+"</span>";
						listtext = listtext+"		</span>";
						listtext = listtext+"	</a>";
						listtext = listtext+"</li>";
						i++;
					});
					var totalpage = parseInt(message.diarylistpaging.totalpage);
					var currpage = parseInt(message.diarylistpaging.currpage);
					var scrollpage = parseInt(message.diarylistpaging.scrollpage);
					var scrollcount = parseInt(message.diarylistpaging.scrollcount);
					var totalcount = parseInt(message.diarylistpaging.totalcount);
					var falert = "alert('이전페이지가 없습니다.'); return false;"
					var nalert = "alert('다음페이지가 없습니다.'); return false;"
					if(totalpage>1){
						listpaging +='<div class="paging">';	//'+totalcount+'
						listpaging +='	<a href="" onclick="drlistpg(1); return false;" class="first arrow"><span>맨 처음 페이지로 이동</span></a> ';
						if(currpage>1){
							listpaging +=' <a href="" onclick="drlistpg('+(currpage-1)+'); return false;" class="prev arrow"><span>이전페이지로 이동</span></a> ';
						}else{
							listpaging +=' <a href="" onclick="'+falert+'" class="prev arrow"><span>이전페이지로 이동</span></a> ';
						}
					 	for (var ii=(0+scrollpage); ii< (scrollpage+scrollcount); ii++) {
					 		if(ii > totalpage){
					 			break;
					 		}
					 		if(ii==currpage){
					 			listpaging +=' <a href="" class="current"><span>'+ii+'</span></a> '
					 		}else{
					 			listpaging +=' <a href="" onclick="drlistpg('+ii+'); return false;" ><span>'+ii+'</span></a> '
					 		}
					 	}
						if(currpage < totalpage){
							listpaging +=' <a href="" onclick="drlistpg('+(currpage+1)+'); return false;" class="next arrow"><span>다음 페이지로 이동</span></a>' ;
						}else{
							listpaging +=' <a href="" onclick="'+nalert+'" class="next arrow"><span>다음 페이지로 이동</span></a> ';
						}
						listpaging +=' <a href="" onclick="drlistpg('+totalpage+'); return false;" class="end arrow"><span>맨 마지막 페이지로 이동</span></a> ';
						listpaging +='</div>';
						listpaging +='<div class="pageMove">';
						listpaging +='<input type="text" style="width:24px;" /> /23페이지 <a href="" class="btn btnS2 btnGry2"><em class="whiteArr01 fn">이동</em></a>';
						listpaging +='</div>';
					}
					$("#jsonlist").html(listtext);
					$("#jsonpaging").html(listpaging);
				}else{
					$("#jsonlist").empty();
					$("#jsonpaging").empty();
				}
			}
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2019">
		<div id="contentWrap" class="diary-main">
			<!-- #include virtual="/diarystory2019/inc/head.asp" -->
			<div class="diary-content">
				<%'!-- 상단메인롤링 --%>
				<div class="main-rolling">
					<div class="swiper-container">
						<div class="swiper-wrapper">
						<% If Not(weekDate = "토요일" Or weekDate = "일요일" Or weekDate = "공휴일") Then %>
							<% If Left(Now(), 10) < "2019-01-01" Then %>
							<%'' 1+1, 1:1 배너 띄움 %>
								<% if cDiary.Ftotalcount > 0 then %>
									<!--<div class="item <%=CHKIIF(cDiary.FOneItem.Fcolorcodeleft="center"," center","")%>">-->
									<%' 배너 텍스트 정렬이 가운데일 경우, 클래스 center 넣어주세요 %>
									<div class="swiper-slide">
										<% if cDiary.FOneItem.Feventid <> "" then %>
										<a href="/event/eventmain.asp?eventid=<%=cDiary.FOneItem.Feventid%><%=gaParam&"item_1"%>" target="_blank" onclick="fnAmplitudeEventAction('click_diary_mainbanner','rolling_num','1');">
										<% else %>
										<a href="/shopping/category_prd.asp?itemid=<%=cDiary.FOneItem.FItemid%><%=gaParam&"item_1"%>" target="_blank" onclick="fnAmplitudeEventAction('click_diary_mainbanner','rolling_num','1');">
										<% end if %>
											<img src="<%= cDiary.FOneItem.FImage1 %>" alt="" />
											<div class="label">
												<% IF GiftSu > 0 Then %>
													<% if cDiary.FOneItem.fplustype="1" then %>
														<span class="plus"></span><%'1+1%>
													<% else %>
														<span class="gift"></span><%'1:1%>
													<% end if %>
													<span class="count"><em><%= GiftSu %>개</em><br />남음</span>
												<% end if %>
											</div>
										</a>
									</div>
								<% end if %>
							<% End If %>
						<% end if %>

						<%' 어드민 [ON]다이어리관리>>diary 리스트-이미지 관리 : 19=PC_롤링배너1, 16=PC_롤링배너2, 17=PC_롤링배너3 ,20=PC_롤링배너4, 18=M_메인배너 %>
						<% If getDiaryEventMainImg("19") <> "" Then %>
						<%
							Dim tmpGetDiaryEventMainImg19 , swipertext1
							tmpGetDiaryEventMainImg19 = Split(getDiaryEventMainImg("19"), "|")
							swipertext1 = tmpGetDiaryEventMainImg19(4)
						%>
							<div class="swiper-slide">
								<a href="<%=tmpGetDiaryEventMainImg19(1)%><%=gaParam&"item_2"%>" target="_blank" onclick="fnAmplitudeEventAction('click_diary_mainbanner','rolling_num','2');">
									<img src="//<%= imglink %>imgstatic.10x10.co.kr/diary/main/<%=tmpGetDiaryEventMainImg19(0)%>" alt="" />
								</a>
							</div>
						<% end if %>

						<% If getDiaryEventMainImg("16") <> "" Then %>
						<%
							Dim tmpGetDiaryEventMainImg16 , swipertext2
							tmpGetDiaryEventMainImg16 = Split(getDiaryEventMainImg("16"), "|")
							swipertext2 = tmpGetDiaryEventMainImg16(4)
						%>
							<div class="swiper-slide">
								<a href="<%=tmpGetDiaryEventMainImg16(1)%><%=gaParam&"item_3"%>" target="_blank" onclick="fnAmplitudeEventAction('click_diary_mainbanner','rolling_num','3');">
									<img src="//<%= imglink %>imgstatic.10x10.co.kr/diary/main/<%=tmpGetDiaryEventMainImg16(0)%>" alt="" />
								</a>
							</div>
						<% end if %>
		
						<% If getDiaryEventMainImg("17") <> "" Then %>
						<%
							Dim tmpGetDiaryEventMainImg17 , swipertext3
							tmpGetDiaryEventMainImg17 = Split(getDiaryEventMainImg("17"), "|")
							swipertext3 = tmpGetDiaryEventMainImg17(4)
						%>
							<div class="swiper-slide">
								<a href="<%=tmpGetDiaryEventMainImg17(1)%><%=gaParam&"item_4"%>" target="_blank" onclick="fnAmplitudeEventAction('click_diary_mainbanner','rolling_num','4');">
									<img src="//<%= imglink %>imgstatic.10x10.co.kr/diary/main/<%=tmpGetDiaryEventMainImg17(0)%>" alt="" />
								</a>
							</div>
						<% end if %>

						<% If getDiaryEventMainImg("20") <> "" Then %>
						<%
							Dim tmpGetDiaryEventMainImg20 , swipertext4
							tmpGetDiaryEventMainImg20 = Split(getDiaryEventMainImg("20"), "|")
							swipertext4 = tmpGetDiaryEventMainImg20(4)
						%>
							<div class="swiper-slide">
								<a href="<%=tmpGetDiaryEventMainImg20(1)%><%=gaParam&"item_5"%>" target="_blank" onclick="fnAmplitudeEventAction('click_diary_mainbanner','rolling_num','5');">
									<img src="//<%= imglink %>imgstatic.10x10.co.kr/diary/main/<%=tmpGetDiaryEventMainImg20(0)%>" alt="" />
								</a>
							</div>
						<% end if %>

						<%'youtube 롤링 배너 추가%>
						<% if date() < "2018-09-24" then '다이애나 %>
						<%
							youtubetext = "다이애나"
						%>
							<div class="swiper-slide">
								<div class="slide-vod">
									<a href="/event/eventmain.asp?eventid=89316" onclick="fnAmplitudeEventAction('click_diary_mainbanner','rolling_num','6');">
										<strong class="vod-tit">
											<strong>텐바이텐과 함께하는 유튜버 다이애나</strong>
											<span>루카랩 홀로홀로 다이어리와 <br />다이애나's Pick 다꾸 용품을 구경해보자!</span>
										</strong>
										<ul class="vod-thm-list">
											<li><a href="/shopping/category_prd.asp?itemid=2088180"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89316/img_vod_item_1.jpg" alt="2019 홀로홀로 다이어리 A5 - 홀로그램 에디션"></a></li>
											<li><a href="/shopping/category_prd.asp?itemid=2074976"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89316/img_vod_item_2.jpg" alt="2019피넛 데일리/레드 L"></a></li>
											<li><a href="/shopping/category_prd.asp?itemid=2054048"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89316/img_vod_item_3.jpg" alt="자문자답 다이어리 (일러스트 버전)"></a></li>
											<li class="btn-more"><a href="/event/eventmain.asp?eventid=89316"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89316/txt_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num">+11</span></a></li>
										</ul>
										<div class="vod-area">
											<iframe width="520" height="315" src="https://www.youtube.com/embed/mYyJ5aMjBsU" frameborder="0" allowfullscreen></iframe>
											<div class="vod-label">
												<img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube.png" alt="youtube">
											</div>
										</div>
									</a>
								</div>
							</div>
						<% elseif date() >= "2018-09-24" and date() < "2018-10-08" then '망고펜슬 %>
						<% 
							youtubetext = "망고펜슬"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/89423/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=89423" onclick="fnAmplitudeEventAction('click_diary_mainbanner','rolling_num','6');">
										<strong class="vod-tit">
											<strong>텐바이텐과 함께하는 유튜버 망고펜슬</strong>
											<span>이공 만년 다이어리와 망고펜슬's PICK<br />다꾸 용품을 구경해보자!</span>
										</strong>
										<ul class="vod-thm-list">
											<li><a href="/shopping/category_prd.asp?itemid=2054049"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89423/img_vod_item_1.jpg" alt=""></a></li>
											<li><a href="/shopping/category_prd.asp?itemid=1945359"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89423/img_vod_item_2.jpg" alt=""></a></li>
											<li><a href="/shopping/category_prd.asp?itemid=1800105"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89423/img_vod_item_3.jpg" alt=""></a></li>
											<li class="btn-more"><a href="/event/eventmain.asp?eventid=89423"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89423/txt_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num">+6</span></a></li>
										</ul>
										<div class="vod-area">
											<iframe width="520" height="315" src="https://www.youtube.com/embed/77bH75LNAKc?rel=0" frameborder="0" allowfullscreen></iframe>
											<div class="vod-label">
												<img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube.png" alt="youtube">
											</div>
										</div>
									</a>
								</div>
							</div>
						<% elseif date() >= "2018-10-08" and date() < "2018-10-15" then '달밍 %>
						<% 
							youtubetext = "유투버 달밍"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/89628/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=89628">
										<strong class="vod-tit">
											<strong>텐바이텐과 함께하는 유튜버 달밍</strong>
											<span>비온뒤 6공 다이어리와 달밍's PICK <br />다꾸 용품을 구경해보자!</span>
										</strong>
										<ul class="vod-thm-list">
											<li><a href="/shopping/category_prd.asp?itemid=2087688"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89628/img_vod_item_1.jpg" alt=""></a></li>
											<li><a href="/shopping/category_prd.asp?itemid=2067979"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89628/img_vod_item_2.jpg" alt=""></a></li>
											<li><a href="/shopping/category_prd.asp?itemid=1678575"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89628/img_vod_item_3.jpg" alt=""></a></li>
											<li class="btn-more"><a href="/event/eventmain.asp?eventid=89628"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89628/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num">+6</span></a></li>
										</ul>
										<div class="vod-area">
											<iframe width="520" height="315" src="https://www.youtube.com/embed/iSVUxr0GlcA" frameborder="0" allowfullscreen></iframe>
											<div class="vod-label">
												<img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube.png" alt="youtube">
											</div>
										</div>
									</a>
								</div>
							</div>
						<% elseif date() >= "2018-10-15" and date() < "2018-10-22" then '초은작가 %>
						<% 
							youtubetext = "초은 작가"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/89817/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=89817<%=gaParam&"item_youtube"%>">
										<strong class="vod-tit">
											<strong>텐바이텐과 함께하는 초은 작가</strong>
											<span>아기자기한 드로잉 다꾸 입문자?!<br />초은 작가님과 함께 해요!</span>
										</strong>
										<ul class="vod-thm-list">
											<li><a href="/shopping/category_prd.asp?itemid=2085679"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89817/img_vod_item_1.jpg" alt=""></a></li>
											<li><a href="/shopping/category_prd.asp?itemid=730936"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89817/img_vod_item_2.jpg" alt=""></a></li>
											<li><a href="/shopping/category_prd.asp?itemid=2052716"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89817/img_vod_item_3.jpg" alt=""></a></li>
											<li class="btn-more"><a href="/event/eventmain.asp?eventid=89817"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89817/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num">+34</span></a></li>
										</ul>
										<div class="vod-area">
											<iframe width="520" height="315" src="https://www.youtube.com/embed/KY74NgU_qNA" frameborder="0" allowfullscreen></iframe>
											<div class="vod-label">
												<img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_instagram.png" alt="instagram"> 
											</div>
										</div>
									</a>
								</div>
							</div>
						<% elseif date() >= "2018-10-22" and date() < "2018-10-29" then '너도밤나무 %>
						<% 
							youtubetext = "너도밤나무"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/89818/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=89818<%=gaParam&"item_youtube"%>">
										<strong class="vod-tit">
											<strong>텐바이텐과 함께하는<br>빈티지 다꾸 너도밤나무</strong>
											<span>가장 오래도록 남기고픈<br>나만의 기록, Vintage Diary</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=1487793"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89818/img_vod_item_1.jpg" alt=""></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2097268"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89818/img_vod_item_2.jpg" alt=""></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2053221"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89818/img_vod_item_3.jpg" alt=""></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=89818"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89818/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num">+81</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/ci57Upq1Xnw?rel=0" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											<img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_instagram.png" alt="instagram">
										</div>
									</div>
								</div>
							</div>
						<% elseif date() >= "2018-10-29" and date() < "2018-11-12" then '소담한작업실 %>
						<%
							youtubetext = "유투버 소담한 작업실"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/90070/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=90070<%=gaParam&"item_youtube"%>">
										<strong class="vod-tit">
											<strong>텐바이텐과 함께하는<br>소담한 작업실</strong>
											<span>루카랩 다이어리와 소담한 작업실'S PICK<br>다꾸 용품을 구경해보자!</span>
										</strong>
										<ul class="vod-thm-list">
											<li><a href="/shopping/category_prd.asp?itemid=2085679"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90070/img_vod_item_1.jpg" alt=""></a></li>
											<li><a href="/shopping/category_prd.asp?itemid=730936"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90070/img_vod_item_2.jpg" alt=""></a></li>
											<li><a href="/shopping/category_prd.asp?itemid=2052716"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90070/img_vod_item_3.jpg" alt=""></a></li>
											<li class="btn-more"><a href="/event/eventmain.asp?eventid=90070"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90070/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num">+28</span></a></li>
										</ul>
										<div class="vod-area">
											<iframe width="520" height="315" src="https://www.youtube.com/embed/0vOZ9drO1Mg" frameborder="0" allowfullscreen></iframe>
											<div class="vod-label">
												<img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube.png" alt="youtube">
											</div>
										</div>
									</a>
								</div>
							</div>
						<% elseif date() >= "2018-11-12" and date() < "2018-11-19" then '다꾸채널-깊은시간 %>
						<%
							youtubetext = "다꾸채널-깊은시간"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/90249/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=90249">
										<strong class="vod-tit">
											<strong>텐바이텐과 함께하는<br>오율하 - 라이브워크</strong>
											<span>BEST 감성다이어리 &lt;깊은시간 다이어리&gt;<br>디자이너가 직접꾸미는 다.꾸! </span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2094207"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90249/img_vod_item_1.jpg" alt="깊은시간 다이어리 ver.2 라지 (만년형)"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2094205"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90249/img_vod_item_2.jpg" alt="깊은시간 기록장 - 원고지"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=1990735"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90249/img_vod_item_3.jpg" alt="시화 PAPER TAPE"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=90249"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90249/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num">+24</span></a></li>
									</ul>
									<!-- 비디오 영역 -->
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/g1n5wAARvh8" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											<img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_instagram.png" alt="instagram">
										</div>
									</div>
								</div>
							</div>
						<% elseif date() >= "2018-11-19" and date() < "2018-12-03" then '마테, 그것이알고싶다 %>
						<%
							youtubetext = "마테, 그것이알고싶다"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/90582/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=90582">
										<strong class="vod-tit">
											<strong>그것이 알고싶다<br>마스킹테이프 1탄</strong>
											<span>다이어리 꾸미기 step1.<br>마스킹테이프를 알아보자!</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2022145"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90582/img_vod_item_1.jpg" alt="Masking tape slim 2p - 05 Cherry"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=1826459"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90582/img_vod_item_2.jpg" alt="COTTON 100 FABRIC TAPE 1.0"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2058116"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90582/img_vod_item_3.jpg" alt="루카랩 홀로홀로 마스킹테이프 세트"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=90582"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90582/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+122</span></a></li>
									</ul>
									<!-- 비디오 영역 -->
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/wCLPu9ku7cQ" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											 <img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_contents.png" alt="contents">
										</div>
									</div>
								</div>
							</div>
						<% elseif date() >= "2018-11-26" and date() < "2018-12-03" then '마테백과사전 vol.2 %>
						<%
							youtubetext = "신비한 마테백과사전"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/90718/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=90718">
										<strong class="vod-tit">
											<strong>신비한 <br>마테백과사전 vol.2</strong>
											<span>다이어리 꾸미기 필수템! <br>마스킹테이프를 알아보자!</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=1672720"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90718/img_vod_item_1.jpg" alt="크리스털 멀티 테이프 디스펜서"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=1918718"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90718/img_vod_item_2.jpg" alt="반 고흐 아몬드 나무 마스킹테이프"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=1989887"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90718/img_vod_item_3.jpg" alt="다정한 마테 작심한주_30mm"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=90718"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90718/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+153</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/m67Ee-St9Gs" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											<img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_contents.png" alt="contents">
										</div>
									</div>
								</div>
							</div>
						<% elseif date() >= "2018-12-03" and date() < "2018-12-10" then '텐바이텐 x 유튜버 '밥팅' %>
						<%
							youtubetext = "텐바이텐 x 유튜버 '밥팅'"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/90879/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=90879">
										<strong class="vod-tit">
											<strong>텐바이텐과 함께하는 <br> 유튜버 밥팅</strong>
											<span>이공 다이어리와 밥팅'S PICK <br>다꾸 용품을 구경해보자!</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2102877"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90879/img_vod_item_1.jpg" alt="아이코닉 라이블리 다이어리 2019"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2110037"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90879/img_vod_item_2.jpg" alt="글리터 만년다이어리-RASPBERRY SHOWER ver.""></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=1987971"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90879/img_vod_item_3.jpg" alt="123 STICKER (2sheets)"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=90879"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90879/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+29</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/6BaZIUiYsiM" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											 <img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube.png" alt="youtube">
										</div>
									</div>
								</div>
							</div>
						<% elseif date() >= "2018-12-10" and date() < "2018-12-17" then '다꾸의 정석, 데코다꾸' %>
						<%
							youtubetext = "다꾸의 정석, 데코다꾸"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/90871/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=90871">
										<strong class="vod-tit">
											<strong>다꾸의 정석,<br />데코 다꾸!</strong>
											<span>데일리라이크 디자이너는<br>어떤 다꾸를 할까?</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2104144"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90871/img_vod_item_1.jpg" alt="2019 메이크 잇 카운트 투데이"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2104140"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90871/img_vod_item_2.jpg" alt="2019 킵 더 메모리"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2155157"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90871/img_vod_item_3.jpg" alt="[텐바이텐 단독] 마스킹 테이프 크리스마스 9P set (파우치 증정)"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=90871"><img src="//webimage.10x10.co.kr/fixevent/event/2018/90871/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+116</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src=" https://www.youtube.com/embed/aFjmDZfFaiA" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											<img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_instagram.png" alt="instagram">
										</div>
									</div>
								</div>
							</div>
						<% elseif date() >= "2018-12-17" and date() < "2019-01-14" then '<텐텐 문방구>는 처음이지?' %>
						<%
							youtubetext = "<텐텐 문방구>는 처음이지?"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/91292/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=91292">
										<strong class="vod-tit">
											<strong>어서와, 이런<br />문방구는 처음이지?</strong>
											<span>DIY 와 뽀시래기의 천국<br />텐텐 문방구에 놀러오세요!</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2111986"><img src="//webimage.10x10.co.kr/fixevent/event/2018/91292/img_vod_item_1.jpg" alt="[텐텐문방구] 다이어리 스타터 패키지"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2108400"><img src="//webimage.10x10.co.kr/fixevent/event/2018/91292/img_vod_item_2.jpg" alt="[텐텐문방구] A5 글리터 커버 (6공다이어리용/7종)"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2139535"><img src="//webimage.10x10.co.kr/fixevent/event/2018/91292/img_vod_item_3.jpg" alt="[텐텐문방구] A5 플래너 리필속지 12종"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=91292"><img src="//webimage.10x10.co.kr/fixevent/event/2018/91292/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+237</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/aQscVzEK-Xo" frameborder="0" allowfullscreen></iframe>
									</div>
								</div>
							</div>
						<% elseif date() >= "2019-01-14" and date() < "2019-01-28" then '마테백과사전 vol.3' %>
						<%
							youtubetext = "마테백과사전 vol.3"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/91894/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=91894">
										<strong class="vod-tit">
											<strong>신비한<br />마테백과사전 vol.3</strong>
											<span>다이어리 꾸미기 필수템!<br />마스킹테이프를 알아보자!</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2025283"><img src="//webimage.10x10.co.kr/fixevent/event/2019/91894/img_vod_item_1.jpg?v=1.01" alt="카운트다운 마스킹테이프"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2019312"><img src="//webimage.10x10.co.kr/fixevent/event/2019/91894/img_vod_item_2.jpg" alt="SMILE"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=1934385"><img src="//webimage.10x10.co.kr/fixevent/event/2019/91894/img_vod_item_3.jpg" alt="반데 하트 Trois 마스킹테이프 BDA269"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=91894"><img src="//webimage.10x10.co.kr/fixevent/event/2019/91894/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+126</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/aQscVzEK-Xo" frameborder="0" allowfullscreen></iframe>
									</div>
								</div>
							</div>
						<% elseif date() >= "2019-01-28"and date() < "2019-04-11" then '올해의 다이어리' %>
						<%
							youtubetext = "올해의 다이어리"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/92235/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=92235">
										<strong class="vod-tit">
											<strong>우리가 기억하는<br />올해의 다이어리</strong>
											<span>다꾸채널 마지막편<br />- 6공의 감성</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2139609"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92235/img_vod_item_1.jpg" alt="A5 다이어리 하드커버 바인더"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2153306"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92235/img_vod_item_2.jpg" alt="다이어리 포스트카드 A5"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2084769"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92235/img_vod_item_3.jpg" alt="A5 육공 다이어리 리필속지_먼슬리"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=92235"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92235/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+126</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/1_CFVsssSLs" frameborder="0" allowfullscreen></iframe>
									</div>
								</div>
							</div>
						<% elseif date() >= "2019-04-11"and date() < "2019-04-18" then '유튜버 망고펜슬의 디즈니 다꾸' %>
						<%
							youtubetext = "유튜버 망고펜슬의 디즈니 다꾸"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/93796/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=93796">
										<strong class="vod-tit">
											<strong>세상 모든 <br>디즈니 아이템이 여기에!</strong>
											<span>망고펜슬이 좋아하는 디즈니 다꾸템은 무엇일까요?</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2209031"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93796/img_vod_item_1.jpg" alt="홀로그램 포스터 6공노트"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2080162"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93796/img_vod_item_3.jpg" alt="위니 더 푸 핸디스티키노트"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2191086"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93796/img_vod_item_2.jpg" alt="페이스스티커"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=93796"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93796/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+59</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/I2yxvTEqYwA" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											 <img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube.png" alt="youtube">
										</div>
									</div>
								</div>
							</div>
						<% elseif date() >= "2019-04-18" and date() < "2019-04-19" then '유튜버 츄삐의 디즈니 다꾸 방법!' %>
						<%
							youtubetext = "유튜버 츄삐의 디즈니 다꾸 방법!"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/93883/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=93883">
										<strong class="vod-tit">
											<strong>유튜버 츄삐의<br>다꾸 방법을 살펴보자!</strong>
											<span>세상에.. 디즈니 다꾸템으로 <br>이렇게까지 다꾸할 수 있었어?</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2209031"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93883/img_vod_item_1.jpg" alt="홀로그램 포스터 6공노트"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2202120"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93883/img_vod_item_3.jpg" alt="프린세스 스티커 세트"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2209033"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93883/img_vod_item_2.jpg" alt="포스터 6공노트"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=93883"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93883/img_vod_item_4.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+21</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/W25g66Uqt8s" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											 <img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube.png" alt="youtube">
										</div>
									</div>
								</div>
							</div>
						<% elseif date() >= "2019-04-19" and date() < "2019-06-03" then '유튜버 하영의 디즈니 언박싱' %>
						<%
							youtubetext = "유튜버 하영의 디즈니 언박싱"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/93887/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=93887">
										<strong class="vod-tit">
											<strong>유튜버 하영의 <br>디즈니 언박싱</strong>
											<span>디즈니 언박싱 구경하는 것만으로도 힐링..♥</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2209031"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93887/img_vod_item_1.jpg" alt="홀로그램 포스터 6공노트"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2202120"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93887/img_vod_item_3.jpg" alt="프린세스 스티커 세트"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2209033"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93887/img_vod_item_2.jpg" alt="포스터 6공노트"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=93887"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93887/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+21</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/BmWqVPRImz0" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											 <img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube.png" alt="youtube">
										</div>
									</div>
								</div>
							</div>
						<% elseif date() >= "2019-06-03" and date() < "2019-08-21" then '유튜버 망고펜슬' %>
						<%
							youtubetext = "유튜버 망고펜슬"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94995/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=94995">
										<strong class="vod-tit">
											<strong>망고펜슬과 함께하는<br>네온문X헬로키티</strong>
											<span>두근두근! 네온문X헬로키티<br>비밀일기장 언박싱을 함께해요</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2358150"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_vod_item_1.jpg" alt=""></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2358154"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_vod_item_3.jpg" alt=""></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2358158"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_vod_item_2.jpg" alt=""></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=94995"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num">+6</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src="https://www.youtube.com/embed/KBEPurAvNNA" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											 <img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube.png" alt="youtube">
										</div>
									</div>
								</div>
							</div>
						<% elseif date() >= "2019-08-21" then '나키’s 감성 다꾸' %>
						<%
							youtubetext = "나키’s 감성 다꾸"
						%>
							<div class="swiper-slide">
								<div class="slide-vod" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/96769/main_rolling_vod_bg.jpg)">
									<a href="/event/eventmain.asp?eventid=96769">
										<strong class="vod-tit">
											<strong>유튜버 나키의 <br> 감성다꾸</strong>
											<span>보기만 해도 감성에 파묻힌다..★</span>
										</strong>
									</a>
									<ul class="vod-thm-list">
										<li><a href="/shopping/category_prd.asp?itemid=2328829"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_vod_item_1.jpg" alt="Plain note 103 : grid note"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=1148996"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_vod_item_3.jpg" alt="Vintage Book Pages"></a></li>
										<li><a href="/shopping/category_prd.asp?itemid=2257070"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_vod_item_2.jpg" alt="SPLICE STAMP BSS-001002"></a></li>
										<li class="btn-more"><a href="/event/eventmain.asp?eventid=96769"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+19</span></a></li>
									</ul>
									<div class="vod-area">
										<iframe width="520" height="315" src=" https://www.youtube.com/embed/Zi7C6WuImXE" frameborder="0" allowfullscreen></iframe>
										<div class="vod-label">
											 <img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube.png" alt="youtube">
										</div>
									</div>
								</div>
							</div>
						<% end if %>
						</div>
						<div class="pagination"></div>
						<button class="slide-nav btn-prev" onfocus="this.blur();"><img src="//fiximage.10x10.co.kr/web2018/diary2019/btn_prev.png" alt="이전" /></button>
						<button class="slide-nav btn-next" onfocus="this.blur();"><img src="//fiximage.10x10.co.kr/web2018/diary2019/btn_next.png" alt="다음" /></button>
						<div class="mask left"></div>
						<div class="mask right"></div>
						<script>
							$(function(){
								// rolling banner pagination text
								var bnrTit = [];
								<% if cDiary.FOneItem.Fswipertext <> "" then %>
								bnrTit.push("<%=cDiary.FOneItem.Fswipertext%>");
								<% end if %>
								<% if swipertext1 <> "" then %>
								bnrTit.push("<%=swipertext1%>");
								<% end if %>
								<% if swipertext2 <> "" then %>
								bnrTit.push("<%=swipertext2%>");
								<% end if %>
								<% if swipertext3 <> "" then %>
								bnrTit.push("<%=swipertext3%>");
								<% end if %>
								<% if swipertext4 <> "" then %>
								bnrTit.push("<%=swipertext4%>");
								<% end if %>
								<% if youtubetext <> "" then %>
								bnrTit.push("<%=youtubetext%>");
								<% end if %>
								$('.pagination span').text(function(i){
									return bnrTit[i];
								});
							});
						</script>
					</div>
				</div>
				<%'!--// 상단메인롤링 --%>

				<% If Left(Now(), 10) < "2019-03-01" Then %>
				<%'!-- 모두에게드리는혜택 --%>
				<!--<div class="diary-gift" id="diary-gift">
					<h3 class="btn-gift ftLt"><img src="//fiximage.10x10.co.kr/web2018/diary2019/tit_diary_gift_v2.png" alt="모두에게 드리는 특별한 혜택 자세히 보러가기" /></h3>
					<div class="ftRt"><img src="//fiximage.10x10.co.kr/web2018/diary2019/img_gift_v2.jpg" alt="다이어리 스토리 전 품목 무료배송 사은품 전량 품절" /></div>
					<div class="ftRt"><img src="//fiximage.10x10.co.kr/web2018/diary2019/img_gift_snoopy.jpg" alt="다이어리 스토리 전 품목 무료배송 15,000원 이상 구매 시 스티커 2종 증정" style="margin-top:-25px;" /></div>
				</div>-->
				<%'!--// 모두에게드리는혜택 --%>

				<%'!-- 사은품 레이어 --%>
				<div id="lyrGift" style="display:none;">
					<div class="gift-layer">
						<% if date() > "2018-12-11" then %>
						<div class="slide">
							<div><img src="//fiximage.10x10.co.kr/web2018/diary2019/img_gift_slide_1.jpg" alt="" /></div>
							<div><img src="//fiximage.10x10.co.kr/web2018/diary2019/img_gift_slide_2.jpg" alt="" /></div>
							<div><img src="//fiximage.10x10.co.kr/web2018/diary2019/img_gift_slide_3.jpg" alt="" /></div>
						</div>
						<h3><img src="//fiximage.10x10.co.kr/web2018/diary2019/tit_gift.png" alt="텐바이텐 일러스트레이터 이공 콜라보 스탠다드러브 댄스" /></h3>
						<div class="scrollbarwrap">
							<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
							<div class="viewport">
								<div class="overview">
									<p><img src="//fiximage.10x10.co.kr/web2018/diary2019/txt_about_gift_v2.png?v=1.01" alt="" /></p>
									<ul class="noti">
										<li>- 기간 : 2018년 9월 17일 ~ 12월 31일 (한정수량으로 조기 품절 될 수 있습니다)</li>
										<li>- 사은품은 쿠폰 등과 같은 할인 수단 사용 후, 구매확정 금액을 기준으로 증정됩니다.</li>
										<li>- 다이어리 구매 개수에 관계없이 총 구매금액 조건 충족 시 사은품이 증정됩니다.</li>
										<li>- 환불 및 교환으로 인해 증정 기준 금액이 미달될 경우, 사은품을 반품해 주셔야 합니다.</li>
										<li>- 사은품 불량으로 인한 교환은 불가능합니다.</li>
										<li>- 비회원 구매 시 사은품 증정에서 제외됩니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<button type="button" class="btn-close" onclick="ClosePopLayer();"><img src="//fiximage.10x10.co.kr/web2018/diary2019/btn_close.png" alt="닫기" /></button>
						<% else %>
						<div class="slide" style="height:380px; background:url(//fiximage.10x10.co.kr/web2018/diary2019/img_pop_snoopy_1.jpg);">
							<div><img src="//fiximage.10x10.co.kr/web2018/diary2019/img_pop_snoopy_1.jpg" alt="" /></div>
							<div><img src="//fiximage.10x10.co.kr/web2018/diary2019/img_pop_snoopy_2.jpg" alt="" /></div>
							<div><img src="//fiximage.10x10.co.kr/web2018/diary2019/img_pop_snoopy_3.jpg" alt="" /></div>
						</div>
						<div class="scrollbarwrap">
							<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
							<div class="viewport">
								<div class="overview">
									<p><img src="//fiximage.10x10.co.kr/web2018/diary2019/txt_pop_snoopy_v2.png" alt="" /></p>
									<ul class="noti" style="margin-top:0; padding-top:43px; border-top:solid 1px #e3e3e3;">
										<li>- 기간 : 2018년 11월 25일 ~ 12월 31일 (한정수량으로 조기 품절 될 수 있습니다)</li>
										<li>- 사은품은 쿠폰 등과 같은 할인 수단 사용 후, 구매확정 금액을 기준으로 증정됩니다.</li>
										<li>- 다이어리 구매 개수에 관계없이 총 구매금액 조건 충족 시 사은품이 증정됩니다.</li>
										<li>- 환불 및 교환으로 인해 증정 기준 금액이 미달될 경우, 사은품을 반품해 주셔야 합니다.</li>
										<li>- 사은품 불량으로 인한 교환은 불가능합니다.</li>
										<li>- 비회원 구매 시 사은품 증정에서 제외됩니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<button type="button" class="btn-close" onclick="ClosePopLayer();"><img src="//fiximage.10x10.co.kr/web2018/diary2019/btn_close.png" alt="닫기" /></button>
						<% end if %>
					</div>
				</div>
				<%'!--// 사은품 레이어 --%>
				<% end if %>

				<%'!-- 추천다이어리 --%>
				<div class="diary-rcmd">
					<h3><img src="//fiximage.10x10.co.kr/web2018/diary2019/tit_rcmd_diary.png" alt="추천다이어리" /></h3>
					<div class="diary-list">
						<ul class="tabV18">
							<!--li class="current" onclick="diarybestlist('b');btnmore();fnAmplitudeEventAction('click_diary_bestmenu','bestname','best');return false;"><a href="#best">베스트셀러</a></li--><%'기존 mdpick %>
							<li class="current" onclick="diarybestlist('s');btnmore();fnAmplitudeEventAction('click_diary_bestmenu','bestname','sell'); return false;"><a href="#now">방금 판매된</a></li><%'신규 %>
							<li onclick="diarybestlist('f');btnmore();fnAmplitudeEventAction('click_diary_bestmenu','bestname','wish'); return false;"><a href="#popular">장바구니에 많이 담긴</a></li><%'기존 wish %>
							<li onclick="diarybestlist('e');btnmore();fnAmplitudeEventAction('click_diary_bestmenu','bestname','event'); return false;"><a href="#popular-event">많이보는 이벤트</a></li><%'기존 event %>
						</ul>
						<div class="tab-container" id="divdiarybest"></div>
					</div>
				</div>
				<%'!--// 추천다이어리 --%>
				<form name="sFrm" method="get" action="#cmtListList">
				<input type="hidden" name="cpg" id="cpg" value="<%=PrdBrandList.FCurrPage %>"/>
				<input type="hidden" name="page" value="<%= PrdBrandList.FPageSize %>"/>
				<input type="hidden" name="srm" value="<%= PrdBrandList.ftectSortMet %>"/>
				<input type="hidden" name="arrds" value="<%= ArrDesign %>"/>
				<input type="hidden" name="ListDiv" value="<%=ListDiv%>"/>
				<input type="hidden" name="sortmet" id="sortmet" value="<%= SortMet %>" >
				<input type="hidden" name="design" id="design" value="<%= design %>" >
				<input type="hidden" name="keyword" id="keyword" value="<%= keyword %>" >
				<input type="hidden" name="contents" id="contents" value="<%= contents %>" >
				<%'!-- 나만의 다이어리 찾기 --%>
				<div class="diary-all">
					<h3><img src="//fiximage.10x10.co.kr/web2018/diary2019/tit_all_diary.png" alt="세상의 모든 다이어리" /></h3>
					<ul class="type">
						<li class="type0"><input type="checkbox" id="type0"/><label for="type0" onclick="drlistall();fnAmplitudeEventAction('click_diary_main_searchfilter','gubun','all');">전체보기</label></li>
						<li class="type1"><input type="checkbox" id="type1" name="dsnchkbox"/><label for="type1" onclick="drlistdsn('1','10');fnAmplitudeEventAction('click_diary_main_searchfilter','gubun','simple');">심플</label></li>
						<li class="type2"><input type="checkbox" id="type2" name="dsnchkbox"/><label for="type2" onclick="drlistdsn('2','20');fnAmplitudeEventAction('click_diary_main_searchfilter','gubun','illustration');">일러스트</label></li>
						<li class="type3"><input type="checkbox" id="type3" name="dsnchkbox"/><label for="type3" onclick="drlistdsn('3','30');fnAmplitudeEventAction('click_diary_main_searchfilter','gubun','pattern');">패턴</label></li>
						<li class="type4"><input type="checkbox" id="type4" name="dsnchkbox"/><label for="type4" onclick="drlistdsn('4','40');fnAmplitudeEventAction('click_diary_main_searchfilter','gubun','photo');">포토</label></li>
						<li class="type5"><input type="checkbox" id="type5" name="kwdchkbox"/><label for="type5" onclick="drlistkwd('5','55');fnAmplitudeEventAction('click_diary_main_searchfilter','gubun','bound');">양장/무선</label></li>
						<li class="type6"><input type="checkbox" id="type6" name="kwdchkbox"/><label for="type6" onclick="drlistkwd('6','56');fnAmplitudeEventAction('click_diary_main_searchfilter','gubun','spring');">스프링</label></li>
						<li class="type7"><input type="checkbox" id="type7" name="kwdchkbox"/><label for="type7" onclick="drlistkwd('7','60');fnAmplitudeEventAction('click_diary_main_searchfilter','gubun','binder');">바인더</label></li>
						<li class="type8"><input type="checkbox" id="type8" name="cttchkbox"/><label for="type8" onclick="drlistctt('8','|2019|');fnAmplitudeEventAction('click_diary_main_searchfilter','gubun','2019');">2019</label></li>
						<li class="type9"><input type="checkbox" id="type9" name="cttchkbox"/><label for="type9" onclick="drlistctt('9','|만년형|');fnAmplitudeEventAction('click_diary_main_searchfilter','gubun','dailydiary');">만년</label></li>
					</ul>
					<div class="diary-list <%=chkiif(PrdBrandList.FResultCount=0,"no-data","")%>">
						<ul class="tabV18" id="pgscroll">
							<li class="<%=CHKIIF(SortMet="best","current","")%>" id="tabbest"><a href="" onclick="drlisttab('1','best');fnAmplitudeEventAction('click_diary_main_searchsorting','gubun','best'); return false;">인기상품순</a></li>
							<li class="<%=CHKIIF(SortMet="newitem","current","")%>" id="tabnewitem"><a href="" onclick="drlisttab('1','newitem');fnAmplitudeEventAction('click_diary_main_searchsorting','gubun','new'); return false;">신상품순</a></li>
							<li class="<%=CHKIIF(SortMet="min","current","")%>" id="tabmin"><a href="" onclick="drlisttab('1','min');fnAmplitudeEventAction('click_diary_main_searchsorting','gubun','lowprice'); return false;">낮은가격순</a></li>
							<li class="<%=CHKIIF(SortMet="hs","current","")%>" id="tabhs"><a href="" onclick="drlisttab('1','hs');fnAmplitudeEventAction('click_diary_main_searchsorting','gubun','highsale'); return false;">높은할인율순</a></li>
						</ul>
						<% If PrdBrandList.FResultCount > 0 Then %>
						<div class="tab-container">
							<div id="diarysearch" class="tab-cont items type-thumb item-240">
								<ul id="jsonlist">
								<%
								Dim tempimg, tempimg2
								dim imgSz : imgSz = 240

									dim diaryItemBedge

									For i = 0 To PrdBrandList.FResultCount - 1
										If ListDiv = "item" Then
											tempimg = PrdBrandList.FItemList(i).FDiaryBasicImg
											tempimg2 = PrdBrandList.FItemList(i).FDiaryBasicImg2
										End If
										If ListDiv = "list" Then''2016부터 사용안함(활용컷-마우스오버로)
											tempimg = PrdBrandList.FItemList(i).FDiaryBasicImg2
										End If

										IF application("Svr_Info") = "Dev" THEN
											tempimg = left(tempimg,7)&mid(tempimg,12)
											tempimg2 = left(PrdBrandList.FItemList(i).FDiaryBasicImg2,7)&mid(PrdBrandList.FItemList(i).FDiaryBasicImg2,12)''마우스오버 활용컷
										end if
										
										diaryItemBedge = ""

										if PrdBrandList.FItemList(i).FNewYN = "1" then 
											diaryItemBedge = "<span class=""label new""></span>"
										end if 

										if PrdBrandList.FItemList(i).FmdpickYN = "o" then 
											diaryItemBedge = "<span class=""label best""></span>"
										end if 
								%>
										<%' for dev msg : 리스트 16개씩 노출 / 품절일경우 클래스 soldOut 붙여주세요 %>
										<li <% if PrdBrandList.FItemList(i).IsSoldOut then %>class="soldOut"<% end if %>>
											<a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%><%=gaParam&"list_"&i+1%>" target="_blank" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_main_searchitems','price_filter|gubun_filter|itemid','||<%=PrdBrandList.FItemList(i).FItemid%>');">
												<span class="thumbnail">
													<% if PrdBrandList.FItemList(i).IsSoldOut then %>
														<span class="soldOutMask"></span>
													<% end if %>
													<img src="<%=tempimg %>" alt="<%= PrdBrandList.FItemList(i).FItemName %>" />

													<%' 미리보기 %>
													<% If IsNull(PrdBrandList.FItemList(i).FpreviewImg) Or PrdBrandList.FItemList(i).FpreviewImg="" Then %>
													<% Else %>
														<button type="button" onclick="fnviewPreviewImg('<%= PrdBrandList.FItemList(i).FpreviewImg %>'); return false;" target="_top" class="btn-preview">미리보기</button>
													<% end if %>

													<%=diaryItemBedge%>
												</span>
												<span class="desc">
													<span class="brand">
														<!--<a href="/street/street_brand.asp?makerid=<%= PrdBrandList.FItemList(i).FMakerId %>" target="_blank"><%= PrdBrandList.FItemList(i).Fsocname %></a> -->
														<%= PrdBrandList.FItemList(i).Fsocname %>
													</span>
													<span class="name">
														<!--<a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%>" target="_blank"> -->
															<% 
'																If PrdBrandList.FItemList(i).isSaleItem Or PrdBrandList.FItemList(i).isLimitItem Then 
'																	Response.write chrbyte(PrdBrandList.FItemList(i).FItemName,30,"Y") 
'																Else 
'																	Response.write PrdBrandList.FItemList(i).FItemName 
'																End If 
															%>
														<!--</a> -->
														<% If PrdBrandList.FItemList(i).isSaleItem Or PrdBrandList.FItemList(i).isLimitItem Then %>
															<%= chrbyte(PrdBrandList.FItemList(i).FItemName,30,"Y") %>
														<% Else %>
															<%= PrdBrandList.FItemList(i).FItemName %>
														<% End If %>
													</span>
													<% if PrdBrandList.FItemList(i).IsSaleItem or PrdBrandList.FItemList(i).isCouponItem Then %>
														<% IF PrdBrandList.FItemList(i).IsCouponItem Then %>
															<span class="price">
																<span class="sum"><%=FormatNumber(PrdBrandList.FItemList(i).GetCouponAssignPrice,0)%>원</span>
																<span class="discount color-red">[<%=PrdBrandList.FItemList(i).GetCouponDiscountStr%>]</span>
															</span>																											
														<% else'IF PrdBrandList.FItemList(i).IsSaleItem then %>
															<span class="price">
																<span class="sum"><%=FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0)%>원</span>
																<span class="discount color-red">[<%=PrdBrandList.FItemList(i).getSalePro%>]</span>
															</span>
														<% End If %>
													<% else %>
														<span class="price">
															<span class="sum"><%=FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0) & chkIIF(PrdBrandList.FItemList(i).IsMileShopitem,"Point","원")%></span>
														</span>
													<% end if %>
												</span>
											</a>
										</li>
								<%
									next
								%>
								</ul>
							</div>
							<% else %>
							<div class="no-diary">
								<div><img src="//fiximage.10x10.co.kr/web2018/diary2019/txt_no_data.png" alt="조건을 만족하는 다이어리가 없습니다" /></div>
								<a href="/diarystory2019/"><img src="//fiximage.10x10.co.kr/web2018/diary2019/btn_all.png" alt="전체보기" /></a>
							</div>
							<% end if %>
						</div>
					</div>
					<% if PrdBrandList.FtotalPage > 1 then %>
					<div class="pageWrapV15" id="jsonpaging">
						<div class="paging">
							<a href="" onclick="drlistpg('1'); return false;" class="first arrow"><span>맨 처음 페이지로 이동</span></a>
							<% if PrdBrandList.FCurrPage > 1 then %>
								<a href="" onclick="drlistpg('<%= PrdBrandList.FCurrPage-1 %>'); return false;" class="prev arrow"><span>이전페이지로 이동</span></a>
							<% else %>
								<a href="" onclick="alert('이전페이지가 없습니다.'); return false;" class="prev arrow"><span>이전페이지로 이동</span></a>
							<% end if %>
					
							<% for i = 0 + PrdBrandList.StartScrollPage to PrdBrandList.StartScrollPage + PrdBrandList.FScrollCount - 1 %>
								<% if (i > PrdBrandList.FTotalpage) then Exit for %>
								<% if CStr(i) = CStr(PrdBrandList.FCurrPage) then %>			
									<a href="" class="current"><span><%= i %></span></a>
								<% else %>
									<a href="" onclick="drlistpg('<%= i %>'); return false;" ><span><%= i %></span></a>
								<% end if %>
							<% next %>
							
							<% if cint(PrdBrandList.FCurrPage) < cint(PrdBrandList.FtotalPage) then %>
								<a href="" onclick="drlistpg('<%= PrdBrandList.FCurrPage+1 %>'); return false;" class="next arrow"><span>다음 페이지로 이동</span></a>
							<% else %>
								<a href="" onclick="alert('다음 페이지가 없습니다.'); return false;" class="next arrow"><span>다음 페이지로 이동</span></a>
							<% end if %>
							<a href="" onclick="drlistpg('<%= PrdBrandList.FTotalPage %>'); return false;" class="end arrow"><span>맨 마지막 페이지로 이동</span></a>
						</div>
						<div class="pageMove">
							<input type="text" style="width:24px;" /> /23페이지 <a href="" class="btn btnS2 btnGry2"><em class="whiteArr01 fn">이동</em></a>
						</div>
					</div>
					<% end if %>
				</div>
				</form>
				<%'!-- 관련기획전 --%>
				<!-- #include virtual="/diarystory2019/inc/inc_etcevent.asp" -->
				<%'!--// 관련기획전 --%>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<%' 미리보기 레이어 %>
<div id="lyrPreview" style="display:none;">
	<div class="diary-preview" id="previewLoad"></div>
</div>
</body>
</html>
<%
	Set cDiary = Nothing
	Set PrdBrandList = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->