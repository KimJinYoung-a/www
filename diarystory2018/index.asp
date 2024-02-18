<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2018 MAIN
' History : 2017.09.18 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2018/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2018/lib/classes/diary_class_B.asp" -->
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

Dim weekDate, design, keyword, contents
Dim i , PrdBrandList , userid, imglink
Dim ListDiv
Dim PageSize , SortMet , CurrPage , vParaMeter , GiftSu

weekDate = weekDayName(weekDay(now)) '// 요일 구하기 내장 함수
if date = "2017-12-25" then
	weekDate = "공휴일"
end if

'if date >= "2016-10-03" and  date < "2016-10-17" then
'	weekDate = "공휴일"
'end if

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
	PageSize = 16
Else
	PageSize = 16
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

Set PrdBrandList = new cdiary_list
	'아이템 리스트
	PrdBrandList.FPageSize = PageSize
	PrdBrandList.FCurrPage = 1	'CurrPage
	PrdBrandList.frectdesign = ""
	PrdBrandList.frectcontents = ""
	PrdBrandList.frectkeyword = ""
	PrdBrandList.fmdpick = ""
	PrdBrandList.ftectSortMet = SortMet
	''PrdBrandList.fuserid = userid   '' 의미없음.
	PrdBrandList.getDiaryItemLIst

IF application("Svr_Info") = "Dev" THEN
	imglink = "test"
Else
	imglink = "o"
End If
%>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2018.css" />
<script type="text/javascript">
$(function(){
	/* main swipe */
	$('.main-rolling').slidesjs({
		width:"1280",
		height:"680",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2800, effect:"fade", auto:false},
		effect:{fade:{speed:800, crossfade:true}},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.main-rolling').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$("#type0").prop('checked', true);
	diarybestlist('b');

	// best award tab
//	$('.diary-best .diary-list').hide();
	$('.diary-best .tab').find('li:first').addClass('current');
	$('.diary-best .tab-container').find('.diary-list:first').show();
	$('.diary-best .tab li').click(function() {
		$('.diary-best .tab li').removeClass('current');
		$(this).addClass('current');
//		$('.diary-best .diary-list').hide();
		var activeTab = $(this).find('a').attr('href');
		$(activeTab).show();
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
		url: "/diarystory2018/inc/ajax_diary_best.asp",
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
		url: "/diarystory2018/previewImg_Ajax.asp",
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

function drlist(){
	var srm = $("#sortmet").val();
	var dsn = $("#design").val();
	var kwd = $("#keyword").val();
	var ctt = $("#contents").val();
	var page = $("#cpg").val();
	if (page==''){
		page=1;
	}

	$.ajax({
	    url : "/diarystory2018/ajax_diaryItemList.asp?cpg="+page+"&srm="+srm+"&dsn="+dsn+"&ctt="+ctt,
	    dataType : "html",
	    type : "get",
	    success : function(result){
	        $("#diarysearch").empty();
	        $("#diarysearch").html(result);
	    }
	});
}

//정렬
function drlisttab(page,srm){
	$('.diary-category .tab li').removeClass('current');
	$("#tab"+srm).addClass('current');
	$("#sortmet").val(srm);
	$("#cpg").val('1');

	drlistJson();
//drlist();
	return false;
}

//디자인
function drlistdsn(page,dsn){
	var dsnid = "type"+dsn;
	var tmpdsnYN = $("#"+dsnid).prop("checked");
	var dsnchkval = document.getElementById('design');
	
	if(tmpdsnYN){
//		alert('체크해제함');
		$("#"+dsnid).prop('checked', false);
		dsnchkval.value = dsnchkval.value.replace(dsn+",", '');
		dsnchkval.value = dsnchkval.value.replace(","+dsn, '');
		dsnchkval.value = dsnchkval.value.replace(dsn, '');
	}else{
//		alert('체크함');
		$("#"+dsnid).prop('checked', true);
		var tmpdsnval = $("#design").val();
		var arrdsnval
		if(!tmpdsnval){
			arrdsnval = dsn
		}else{
			arrdsnval = tmpdsnval+","+dsn
		}
		$("#design").val(arrdsnval);		
	}
	
	var dsnchklen = $("input:checkbox[name=dsnchkbox]:checked").length;
	var kwdchklen = $("input:checkbox[name=kwdchkbox]:checked").length;
	var cttchklen = $("input:checkbox[name=cttchkbox]:checked").length;
	var chklen = dsnchklen+kwdchklen+cttchklen
	if(chklen>0){
		$("#type0").prop('checked', false);
	}else{
		$("#type0").prop('checked', true);
	}
	$("#cpg").val('1');
	drlistJson();
//drlist();
	return false;
}

//키워드
function drlistkwd(page,kwd){
	var kwdid = "type"+kwd;
	var tmpkwdYN = $("#"+kwdid).prop("checked");
	var kwdchkval = document.getElementById('keyword');
	
	if(tmpkwdYN){
//		alert('체크해제함');
		$("#"+kwdid).prop('checked', false);
		kwdchkval.value = kwdchkval.value.replace(kwd+",", '');
		kwdchkval.value = kwdchkval.value.replace(","+kwd, '');
		kwdchkval.value = kwdchkval.value.replace(kwd, '');
	}else{
//		alert('체크함');
		$("#"+kwdid).prop('checked', true);
		var tmpkwdval = $("#keyword").val();
		var arrkwdval
		if(!tmpkwdval){
			arrkwdval = kwd
		}else{
			arrkwdval = tmpkwdval+","+kwd
		}
		$("#keyword").val(arrkwdval);		
	}
	
	var dsnchklen = $("input:checkbox[name=dsnchkbox]:checked").length;
	var kwdchklen = $("input:checkbox[name=kwdchkbox]:checked").length;
	var cttchklen = $("input:checkbox[name=cttchkbox]:checked").length;
	var chklen = dsnchklen+kwdchklen+cttchklen
	if(chklen>0){
		$("#type0").prop('checked', false);
	}else{
		$("#type0").prop('checked', true);
	}
	$("#cpg").val('1');
	drlistJson();
//drlist();
	return false;
}

//콘텐츠
function drlistctt(page,ctt){
	var tmpcttid
		if(ctt=="만년형"){
			tmpcttid="8"
		}else{
			tmpcttid="9"
		}
	var cttid = "type"+tmpcttid;
	var tmpcttYN = $("#"+cttid).prop("checked");
	var cttchkval = document.getElementById('contents');
	
	if(tmpcttYN){
//		alert('체크해제함');
		$("#"+cttid).prop('checked', false);
//		cttchkval.value = cttchkval.value.replace("|"+ctt+"|"+",", '');
//		cttchkval.value = cttchkval.value.replace(","+"|"+ctt+"|", '');
//		cttchkval.value = cttchkval.value.replace("|"+ctt+"|", '');
		cttchkval.value = cttchkval.value.replace(""+ctt+""+",", '');
		cttchkval.value = cttchkval.value.replace(","+""+ctt+"", '');
		cttchkval.value = cttchkval.value.replace(""+ctt+"", '');
	}else{
//		alert('체크함');
		$("#"+cttid).prop('checked', true);
		var tmpcttval = $("#contents").val();
		var arrcttval
//		if(!tmpcttval){
//			arrcttval = "|"+ctt+"|"
//		}else{
//			arrcttval = tmpcttval+","+"|"+ctt+"|"
//		}
		if(!tmpcttval){
			arrcttval = ""+ctt+""
		}else{
			arrcttval = tmpcttval+","+""+ctt+""
		}
		$("#contents").val(arrcttval);		
	}
	
	var dsnchklen = $("input:checkbox[name=dsnchkbox]:checked").length;
	var kwdchklen = $("input:checkbox[name=kwdchkbox]:checked").length;
	var cttchklen = $("input:checkbox[name=cttchkbox]:checked").length;
	var chklen = dsnchklen+kwdchklen+cttchklen
	if(chklen>0){
		$("#type0").prop('checked', false);
	}else{
		$("#type0").prop('checked', true);
	}
	$("#cpg").val('1');

	drlistJson();
//drlist();
	return false;
}

//페이징
function drlistpg(page){
	$("#cpg").val(page);
	drlistJson();
	window.$('html,body').animate({scrollTop:$("#pgscroll").offset().top}, 400);
//drlist();
	return false;
}

//검색리셋
function drlistall(){
	$("#design").val('');
	$("#keyword").val('');
	$("#contents").val('');
	$("#cpg").val('1');
	$("input[type=checkbox]").prop("checked",false);
	$("#type0").prop('checked', true);
	drlistJson();
//drlist();
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
		type: "get",
		url: "/diarystory2018/ajax_diaryItemList_json.asp",
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

						listtext = listtext+"	<a href='/shopping/category_prd.asp?itemid="+this.itemid+"' target='_blank'>";
						listtext = listtext+"		<div class='pdtPhoto'>";

						if(this.soldout=="True") {
							listtext = listtext+"		<span class='soldOutMask'></span>";
						}

						listtext = listtext+"				<img src='"+this.image+"' alt='"+this.artitemname+"' />";
//						listtext = listtext+"				<button type='button' onclick='viewPoupLayer('modal',$('#lyrPreview').html());return false;' target='_top' class='btn-preview'>미리보기</button>";
						if(this.previewimg){
							listtext = listtext+"				<button type='button' onclick='fnviewPreviewImg("+this.previewimg+");return false;' target='_top' class='btn-preview'>미리보기</button>";
						}
						listtext = listtext+"		</div>";
						listtext = listtext+"	</a>";

						listtext = listtext+"	<div class='pdtInfo'>";
						listtext = listtext+"		<p class='brand'><a href='/street/street_brand.asp?makerid="+this.makerid+"'>"+this.makername+"</a></p>";
						listtext = listtext+"		<p class='name'><a href='/shopping/category_prd.asp?itemid="+this.itemid+"' target='_blank'>"+this.itemname+"</a></p>";
						listtext = listtext+"		<p class='price'>"+this.price+"</p>";
						listtext = listtext+"	</div>";
						listtext = listtext+"</li>";
						i++;
					});

					var totalpage = parseInt(message.diarylistpaging.totalpage);
					var currpage = parseInt(message.diarylistpaging.currpage);
					var scrollpage = parseInt(message.diarylistpaging.scrollpage);
					var scrollcount = parseInt(message.diarylistpaging.scrollcount);
					var totalcount = parseInt(message.diarylistpaging.totalcount);
					var falert = "alert('이전페이지가 없습니다.'); return false;"
					var nalert =  "alert('다음페이지가 없습니다.'); return false;"
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
	<div class="container diary2018">
		<div id="contentWrap" class="diary-main">
			<!-- #include virtual="/diarystory2018/inc/head.asp" -->
			<div class="diary-content">
				<%' 상단 메인 롤링 %>
				<div class="main-rolling">
					<% If weekDate = "토요일" Or weekDate = "일요일" Or weekDate = "공휴일" Then %>
					<% else %>
						<% If Left(Now(), 10) < "2018-01-01" Then %>
						<%'' 1+1, 1:1 배너 띄움 %>
							<% if cDiary.Ftotalcount > 0 then %>
								<div class="item <%=CHKIIF(cDiary.FOneItem.Fcolorcodeleft="center"," center","")%>"><%' 배너 텍스트 정렬이 가운데일 경우, 클래스 center 넣어주세요 %>
									<a href="" onclick="TnGotoProduct('<%=cDiary.FOneItem.FItemid%>'); return false;">
										<img src="<%= cDiary.FOneItem.FImage1 %>" alt="" /><!-- alt 값에 상품명 넣어주세요 -->
										<div class="label">
											<% IF GiftSu > 0 Then %>
												<% if cDiary.FOneItem.fplustype="1" then %>
													<span class="plus"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/ico_plus_one.png" alt="1+1" /></span>
												<% else %>
													<span class="colon"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/ico_colon_one.png" alt="1:1" /></span>
												<% end if %>
												<span class="count"><em><%= GiftSu %>개</em><br/>남음</span>
											<% end if %>
										</div>
									</a>
								</div>
							<% end if %>
						<% End If %>
					<% end if %>
	
					<%' 어드민 [ON]다이어리관리>>diary 리스트-이미지 관리 : 19=main_img1, 16=main_img2, 17=main_img3, 18=mobile_main %>
					<% If getDiaryEventMainImg("19") <> "" Then %>
					<%
						Dim tmpGetDiaryEventMainImg19, tmpcolorcode
						tmpGetDiaryEventMainImg19 = Split(getDiaryEventMainImg("19"), "|")
					%>
						<div class="item"><a href="<%=tmpGetDiaryEventMainImg19(1)%>"><img src="http://<%= imglink %>imgstatic.10x10.co.kr/diary/main/<%=tmpGetDiaryEventMainImg19(0)%>" alt="" /></a></div>
					<% end if %>
	
					<% If getDiaryEventMainImg("16") <> "" Then %>
					<%
						Dim tmpGetDiaryEventMainImg16
						tmpGetDiaryEventMainImg16 = Split(getDiaryEventMainImg("16"), "|")
					%>
						<div class="item"><a href="<%=tmpGetDiaryEventMainImg16(1)%>"><img src="http://<%= imglink %>imgstatic.10x10.co.kr/diary/main/<%=tmpGetDiaryEventMainImg16(0)%>" alt="" /></a></div>
					<% end if %>
	
					<% If getDiaryEventMainImg("17") <> "" Then %>
					<%
						Dim tmpGetDiaryEventMainImg17
						tmpGetDiaryEventMainImg17 = Split(getDiaryEventMainImg("17"), "|")
					%>
						<div class="item"><a href="<%=tmpGetDiaryEventMainImg17(1)%>"><img src="http://<%= imglink %>imgstatic.10x10.co.kr/diary/main/<%=tmpGetDiaryEventMainImg17(0)%>" alt="" /></a></div>
					<% end if %>
				</div>

				<% If Left(Now(), 10) < "2018-03-01" Then %>
					<!-- 사은품 -->
					<div class="diary-collabo">
						<h3><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tit_gift.png" alt="구매금액별 사은품 및 무료배송" /></h3>
						<div><img src="http://fiximage.10x10.co.kr/web2017/diary2018/bnr_gift_v2.jpg" alt="1만원 이상 - 마스킹 테이프 랜덤 증정/3만원 이상 - 홀로그램 파일/5만원 이상 - 메모판+자석" /></div>
						<a href="/diarystory2018/gift.asp"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/btn_gift.png" alt="사은품 안내 바로가기" /></a>
					</div>
				<% end if %>

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
					<!-- 나만의 다이어리 찾기 -->
					<div class="diary-category">
						<h3><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tit_find.png" alt="나만의 다이어리 찾기" /></h3>
						<ul class="type">
							<li class="type0" onclick="drlistall();">
								<input type="checkbox" id="type0" />
								<label for="type0"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_type_all.png" alt="ALL" /></label>
							</li>

							<li class="type10 lPad30" onclick="drlistdsn('1','10'); return false;" >
								<input type="checkbox" id="type10" name="dsnchkbox" />
								<label for="type10"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_type_1_v2.jpg" alt="심플" /></label>
							</li>

							<li class="type20" onclick="drlistdsn('1','20'); return false;">
								<input type="checkbox" id="type20" name="dsnchkbox" />
								<label for="type20"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_type_2_v2.jpg" alt="일러스트" /></label>
							</li>

							<li class="type30" onclick="drlistdsn('1','30'); return false;">
								<input type="checkbox" id="type30"  name="dsnchkbox" />
								<label for="type30"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_type_3_v2.jpg" alt="패턴" /></label>
							</li>

							<li class="type40" onclick="drlistdsn('1','40'); return false;">
								<input type="checkbox" id="type40" name="dsnchkbox" />
								<label for="type40"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_type_4_v2.jpg" alt="포토" /></label>
							</li>


							<li class="type56 lPad30" onclick="drlistkwd('1','56'); return false;">
								<input type="checkbox" id="type56" name="kwdchkbox" />
								<label for="type56"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_type_5_v2.jpg" alt="스프링제본" /></label>
							</li>

							<li class="type55" onclick="drlistkwd('1','55'); return false;">
								<input type="checkbox" id="type55" name="kwdchkbox" />
								<label for="type6"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_type_7_v2.jpg" alt="양장/무선제본" /></label>
							</li>

							<li class="type57" onclick="drlistkwd('1','57'); return false;">
								<input type="checkbox" id="type57"  name="kwdchkbox"/>
								<label for="type57"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_type_8_v2.jpg" alt="바인더스타일" /></label>
							</li>


							<li class="type8 lPad30" onclick="drlistctt('1','만년형'); return false;">
								<input type="checkbox" id="type8"  name="cttchkbox"/>
								<label for="type8"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_type_8.jpg" alt="만년" /></label>
							</li>

							<li class="type9" onclick="drlistctt('1','2018 날짜형'); return false;">
								<input type="checkbox" id="type9" name="cttchkbox" />
								<label for="type9"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_type_9.jpg" alt="2018" /></label>
							</li>
						</ul>
						<ul class="tab" id="pgscroll">
							<!-- 선택시 클래스 current 붙여주세요 -->
							<li class="<%=CHKIIF(SortMet="best","current","")%>" id="tabbest"><a href="" onclick="drlisttab('1','best'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_popular.png" alt="인기상품순" /></a></li>
							<li class="<%=CHKIIF(SortMet="newitem","selected","")%>" id="tabnewitem"><a href="" onclick="drlisttab('1','newitem'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_new.png" alt="신상품순" /></a></li>
							<li class="<%=CHKIIF(SortMet="min","selected","")%>" id="tabmin"><a href="" onclick="drlisttab('1','min'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_low.png" alt="낮은가격순" /></a></li>
							<li class="<%=CHKIIF(SortMet="hi","selected","")%>" id="tabhi"><a href="" onclick="drlisttab('1','hi'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_high.png" alt="높은가격순" /></a></li>
							<li class="<%=CHKIIF(SortMet="hs","selected","")%>" id="tabhs"><a href="" onclick="drlisttab('1','hs'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_discount.png" alt="높은할인율순" /></a></li>
						</ul>
						<div class="diary-list" id="diarysearch">
							<ul id="jsonlist">
							<%
							Dim tempimg, tempimg2
							dim imgSz : imgSz = 240
							If PrdBrandList.FResultCount > 0 Then
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
							%>
									<%' for dev msg : 리스트 16개씩 노출 / 품절일경우 클래스 soldOut 붙여주세요 %>
									<li <% if PrdBrandList.FItemList(i).IsSoldOut then %>class="soldOut"<% end if %>>
										<a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%>" target="_blank">
											<div class="pdtPhoto">
												<% if PrdBrandList.FItemList(i).IsSoldOut then %>
													<span class="soldOutMask"></span>
												<% end if %>
												<img src="<%=tempimg %>" alt="<%= PrdBrandList.FItemList(i).FItemName %>" />

												<%' 미리보기 %>
												<% If IsNull(PrdBrandList.FItemList(i).FpreviewImg) Or PrdBrandList.FItemList(i).FpreviewImg="" Then %>
												<% Else %>
													<button type="button" onclick="fnviewPreviewImg('<%= PrdBrandList.FItemList(i).FpreviewImg %>'); return false;" target="_top" class="btn-preview">미리보기</button>
												<% end if %>
											</div>
										</a>
										<div class="pdtInfo">
											<p class="brand"><a href="/street/street_brand.asp?makerid=<%= PrdBrandList.FItemList(i).FMakerId %>" target="_blank"><%= PrdBrandList.FItemList(i).Fsocname %></a></p>
											<p class="name">
												<a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%>" target="_blank">
													<% If PrdBrandList.FItemList(i).isSaleItem Or PrdBrandList.FItemList(i).isLimitItem Then %>
														<%= chrbyte(PrdBrandList.FItemList(i).FItemName,30,"Y") %>
													<% Else %>
														<%= PrdBrandList.FItemList(i).FItemName %>
													<% End If %>
												</a>
											</p>
											<% if PrdBrandList.FItemList(i).IsSaleItem or PrdBrandList.FItemList(i).isCouponItem Then %>
												<% IF PrdBrandList.FItemList(i).IsSaleItem then %>
													<p class="price"><%=FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0)%>원<strong class="cRd0V15">[<%=PrdBrandList.FItemList(i).getSalePro%>]</strong></p>
												<% End If %>
												<% IF PrdBrandList.FItemList(i).IsCouponItem Then %>
													<p class="price"><%=FormatNumber(PrdBrandList.FItemList(i).GetCouponAssignPrice,0)%>원<strong class="cGr0V15">[<%=PrdBrandList.FItemList(i).GetCouponDiscountStr%>]</strong></p>
												<% end if %>
											<% else %>
												<p class="price"><%=FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0) & chkIIF(PrdBrandList.FItemList(i).IsMileShopitem,"Point","원")%></p>
											<% end if %>
										</div>
									</li>
							<%
								next
							End If
							%>
							</ul>
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
					</div>
				</form>

				<div class="related-event">
					<ul>
						<li><a href="/event/eventmain.asp?eventid=80907"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_event_1.jpg" alt="The Pen Story" /></a></li>
						<li><a href="/event/eventmain.asp?eventid=80908"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_event_2.jpg" alt="Planner" /></a></li>
						<li><a href="/shopping/category_list.asp?disp=101103"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_event_3.jpg" alt="Note" /></a></li>
						<li><a href="/shopping/category_list.asp?disp=101102102"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_event_4.jpg" alt="Organizer" /></a></li>
						<li><a href="/street/street_brand_sub06.asp?makerid=midori2"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_event_5.jpg" alt="Midori" /></a></li>
						<li class="big"><a href="/event/eventmain.asp?eventid=83443"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_event_6_v2.jpg" alt="Calendar" /></a></li>
						<li style="margin-top:-240px;"><a href="/event/eventmain.asp?eventid=80909"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_event_7.jpg" alt="Deco" /></a></li>
						<li style="margin-top:-240px;"><a href="/event/eventmain.asp?eventid=80912"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/img_event_8.jpg" alt="Moleskine" /></a></li>
					</ul>
				</div>

				<!-- 베스트 어워드 -->
				<div class="diary-best">
					<h3><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tit_best.png" alt="다이어리 베스트 어워드" /></h3>
					<ul class="tab">
						<li><a href="" onclick="diarybestlist('b'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_seller.png" alt="Seller" /></a></li>
						<li><a href="" onclick="diarybestlist('f'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_wish.png" alt="Wish" /></a></li>
						<li><a href="" onclick="diarybestlist('r'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_review.png" alt="Review" /></a></li>
						<li><a href="" onclick="diarybestlist('e'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_event.png" alt="Event" /></a></li>
					</ul>
					<div class="tab-container" id="divdiarybest"></div>
				</div>
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