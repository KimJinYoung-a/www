<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2018 검색결과페이지
' History : 2017.09.22 유태욱 생성
'####################################################
%>
<!-- #include virtual="/diarystory2018/lib/worker_only_view.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/diarystory2018/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
	Dim ArrDesign , tmp , iTmp , ctmp, ktmp, arrcontents ,arrkeyword , userid, limited
	dim cate , PageSize , ttpgsz , CurrPage, vGubun, vMDPick, vParaMeter
	dim SortMet	,page
	Dim ListDiv

	ListDiv	= requestcheckvar(request("ListDiv"),4)
	If ListDiv = "" Then ListDiv = "item"

	If ListDiv = "list" Then
		PageSize = 16
	Else
		PageSize = 16
	End If

	IF SortMet = "" Then SortMet = "newitem"

	ArrDesign = request("arrds")
	arrcontents = request("arrcont")
	arrkeyword = request("arrkey")
	arrColorCode = request("iccd")

	limited = request("limited")
	if limited = "" then limited = "X"

	page 		= requestcheckvar(request("page"),2)
	SortMet 	= requestCheckVar(request("srm"),9)
	CurrPage 	= requestCheckVar(request("cpg"),9)
	userid		= getEncLoginUserID

	IF CurrPage = "" then CurrPage = 1
	IF SortMet = "" Then SortMet = "newitem"
	if page = "" then page = 1

	ArrDesign = split(ArrDesign,",")
	arrcontents = split(arrcontents,",")
	arrkeyword = split(arrkeyword,",")
	arrColorCode = Split(arrColorCode,",")

	For iTmp =0 to Ubound(ArrDesign)-1
		IF ArrDesign(iTmp)<>"" Then
			tmp  = tmp & requestcheckvar(ArrDesign(iTmp),2) &","
		End IF
	Next
	ArrDesign = tmp

	tmp = ""
	For cTmp =0 to Ubound(arrcontents)-1
		IF arrcontents(cTmp)<>"" Then
			tmp  = tmp & "'" & requestcheckvar(arrcontents(cTmp),10) & "'" &","
		End IF
	Next
	arrcontents = tmp

	tmp = ""
	For ktmp =0 to Ubound(arrkeyword)-1
		IF arrkeyword(ktmp)<>"" Then
			tmp  = tmp & requestcheckvar(arrkeyword(ktmp),2) &","
		End IF
	Next
	arrkeyword = tmp

	tmp = ""
	For ktmp =0 to Ubound(arrColorCode)-1
		IF arrColorCode(ktmp)<>"" Then
			tmp  = tmp & requestcheckvar(arrColorCode(ktmp),2) &","
		End IF
	Next
	arrColorCode = tmp

	Dim sArrDesign,sarrcontents,sarrkeyword,sarrColorCode
	sArrDesign =""
	sarrcontents =""
	sarrkeyword =""
	sarrColorCode =""
	IF ArrDesign <> "" THEN sArrDesign =  left(ArrDesign,(len(ArrDesign)-1))
	IF arrcontents <> "" THEN sarrcontents =  left(arrcontents,(len(arrcontents)-1))
	IF arrkeyword <> "" THEN
		If arrColorCode = "" then
		sarrkeyword =  left(arrkeyword,(len(arrkeyword)-1))
		else
		sarrkeyword =  arrkeyword & left(arrColorCode,(len(arrColorCode)-1))
		End If
	else
		If arrColorCode <> "" then
		sarrkeyword =  left(arrColorCode,(len(arrColorCode)-1))
		End If
	End If

	vParaMeter = "&arrds="&ArrDesign&"&arrcont="&arrcontents&"&arrkey="&arrkeyword&"&iccd="&arrColorCode&"&ListDiv="&ListDiv&"&limited="&limited&""
	Dim PrdBrandList, i

	set PrdBrandList = new cdiary_list
		PrdBrandList.FPageSize = PageSize
		PrdBrandList.FCurrPage = CurrPage
		PrdBrandList.frectdesign = sArrDesign
		PrdBrandList.frectcontents = arrcontents
		PrdBrandList.frectkeyword = sarrkeyword
		PrdBrandList.fmdpick = vMDPick
		PrdBrandList.frectlimited = limited
		PrdBrandList.ftectSortMet = SortMet
		''PrdBrandList.fuserid = userid
		PrdBrandList.getDiaryItemLIst
%>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2018.css" />
<script type="text/javascript">
$(function(){
	<% if Request("cpg") <> "" then %>
		window.parent.$('html,body').animate({scrollTop:$("#diaryscList").offset().top}, 0);
	<% end if %>
});

$(function(){
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
	return false;
}

function goSearchDiary()
{
	var nm  = document.getElementsByName('design');
	var cm  = document.getElementsByName('contents');
	var km  = document.getElementsByName('keyword');

	document.frm_search1.arrds.value = "";
	document.frm_search1.arrcont.value = "";
	document.frm_search1.arrkey.value = "";

	for (var i=0;i<nm.length;i++){

		if (nm[i].checked){
			document.frm_search1.arrds.value = document.frm_search1.arrds.value  + nm[i].value + ",";
		}
	}
	for (var i=0;i<cm.length;i++){

		if (cm[i].checked){
			document.frm_search1.arrcont.value = document.frm_search1.arrcont.value  + cm[i].value + ",";
		}
	}

	for (var i=0;i<km.length;i++){

		if (km[i].checked){
			document.frm_search1.arrkey.value = document.frm_search1.arrkey.value  + km[i].value + ",";
		}
	}

	document.frm_search1.cpg.value = "1";
	document.frm_search1.action = "/<%=g_HomeFolder%>/search/";
	document.frm_search1.submit();
}
function fnSearch(frmval){
//	frmnm.value = frmval;
	$("#srm").val(frmval);
	var frm = document.frm_search1;
	frm.cpg.value=1;
	goSearchDiary();
}

function jsGoPage(iP){
	location.href = "<%=CurrURL()%>?cpg="+iP+"&srm=<%=SortMet%><%=vParaMeter%>";
}

//체크박스 전체선택 해제
$( document ).ready( function() {
	$( '#checkAll' ).click( function() {
	  $( '.check' ).prop( 'checked', false );
		var tmp1;
		for(var i=0;i<document.frm_search1.chkIcd.length;i++) {
			tmp1 = document.frm_search1.chkIcd[i].value;
			$("#barCLChp" + tmp1).removeClass("selected");
			$("#barCLChp" + tmp1).attr("summary","N");
		}
		document.frm_search1.iccd.value="0";
		$("#barCLChp0").addClass("selected");
		return false;
	} );
	
} );

function fnSelColorChip(iccd) {
	var tmp;
	var chkCnt = 0;
		if(iccd==0) {
		//전체 선택-리셋
		for(var i=0;i<document.frm_search1.chkIcd.length;i++) {
			tmp = document.frm_search1.chkIcd[i].value;
			$("#barCLChp" + tmp).removeClass("selected");
			$("#barCLChp" + tmp).attr("summary","N");
		}
		document.frm_search1.iccd.value="0";
		$("#barCLChp0").addClass("selected");
	} else {
		// 지정색 On/Off

		$("#barCLChp0").removeClass("selected");
		if ($("#barCLChp" + iccd).attr("summary") == "Y"){
			$("#barCLChp" + iccd).removeClass("selected");
			$("#barCLChp" + iccd).attr("summary","N");
		} else {
			$("#barCLChp" + iccd).addClass("selected");
			$("#barCLChp" + iccd).attr("summary","Y");
		}

		//컬러 마지막 선택 빠질경우 없음으로 되돌아가기
		$(".colorChip li:not('#barCLChp0')").each(function(){
			if($(this).hasClass("selected")) {
				chkCnt++;
			}
		});
		if(chkCnt<=0) {
			document.frm_search1.iccd.value="0";
			$("#barCLChp0").attr("class","selected");
		} else {
			$("#barCLChp0").removeClass("selected");
		}

		document.frm_search1.iccd.value="";
		for(var i=0;i<document.frm_search1.chkIcd.length;i++) {
			tmp = document.frm_search1.chkIcd[i].value;
			if($("#barCLChp" + tmp).attr("summary") =="Y") {
				if(document.frm_search1.iccd.value!="") {
					document.frm_search1.iccd.value = document.frm_search1.iccd.value + tmp + ",";
				} else {
					document.frm_search1.iccd.value = tmp+ ",";
				}
			}
		}
	}
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2018">
		<div id="contentWrap" class="search-result">
			<!-- #include virtual="/diarystory2018/inc/head.asp" -->
			<form name="frm_search1" method="post" action="#diaryscList" style="margin:0px;">
			<input type="hidden" name="arrds" value="">
			<input type="hidden" name="arrcont" value="">
			<input type="hidden" name="arrkey" value="">
			<input type="hidden" name="arrds_temp" value="<%= request("arrds") %>">
			<input type="hidden" name="arrcont_temp" value="<%= request("arrcont") %>">
			<input type="hidden" name="arrkey_temp" value="<%= request("arrkey") %>">
			<input type="hidden" name="iccd" value="<%= request("iccd") %>">
			<input type="hidden" name="ListDiv" value="<%=ListDiv%>"/>
			<input type="hidden" name="cpg" value="<%=PrdBrandList.FCurrPage %>"/>
			<input type="hidden" name="page" value="<%= PrdBrandList.FPageSize %>"/>
			<input type="hidden" name="srm" id="srm" value="<%= PrdBrandList.ftectSortMet %>"/>
			<div class="diary-content">
				<!-- 검색영역 -->
				<div class="search-wrap">
					<div class="diary-search">
						<h3><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tit_find_2.png" alt="나만의 다이어리 찾기" /><strong>원하는 항목에 체크해 주세요. <em class="cRd0V15">중복체크도 가능</em>합니다.</strong></h3>
						<!--<a href="" class="btn-planner">혹시 플래너를 찾으시나요?</a>-->
						<div class="search-option">
							<dl class="type1">
								<dt><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_design.png" alt="DESIGN" /></dt>
								<dd>
									<ul class="option-list">
										<li><input type="checkbox" class="check" id="optS1" name="design" value="10" <%= getchecked(ArrDesign,10) %> /> <label for="optS1">심플</label></li>
										<li><input type="checkbox" class="check" id="optS2" name="design" value="20" <%= getchecked(ArrDesign,20) %> /> <label for="optS2">일러스트</label></li>
										<li><input type="checkbox" class="check" id="optS3" name="design" value="30" <%= getchecked(ArrDesign,30) %> /> <label for="optS3">패턴</label></li>
										<li><input type="checkbox" class="check" id="optS4" name="design" value="40" <%= getchecked(ArrDesign,40) %> /> <label for="optS4">포토</label></li>
									</ul>
								</dd>
							</dl>
							<dl class="type02">
								<dt><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_contents.png" alt="CONTENTS" /></dt>
								<dd>
									<dl>
										<dt>날짜</dt>
										<dd>
											<ul class="option-list">
												<li><input type="checkbox" class="check" id="optCt1-1" name="contents" value="'2018 날짜형'" <%= getchecked(arrcontents,"'2018 날짜형'") %> /> <label for="optCt1-1">2018 날짜형</label></li>
												<li><input type="checkbox" class="check" id="optCt1-2" name="contents" value="'만년형'" <%= getchecked(arrcontents,"'만년형'") %> /> <label for="optCt1-2">만년형</label></li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>기간</dt>
										<dd>
											<ul class="option-list">
												<li><input type="checkbox" class="check" id="optCt2-1" name="contents" value="'1개월'" <%= getchecked(arrcontents,"'1개월'") %> /> <label for="optCt2-1">1개월</label></li>
												<li><input type="checkbox" class="check" id="optCt2-2" name="contents" value="'분기별'" <%= getchecked(arrcontents,"'분기별'") %> /> <label for="optCt2-2">분기별</label></li>
												<li><input type="checkbox" class="check" id="optCt2-3" name="contents" value="'6개월'" <%= getchecked(arrcontents,"'6개월'") %> /> <label for="optCt2-3">6개월</label></li>
												<li><input type="checkbox" class="check" id="optCt2-4" name="contents" value="'1년'" <%= getchecked(arrcontents,"'1년'") %> /> <label for="optCt2-4">1년</label></li>
												<li><input type="checkbox" class="check" id="optCt2-5" name="contents" value="'1년 이상'" <%= getchecked(arrcontents,"'1년 이상'") %> /> <label for="optCt2-5">1년 이상</label></li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>내지 구성</dt>
										<dd>
											<ul class="option-list">
												<li><input type="checkbox" class="check" id="optCt3-1" name="contents" value="'연간스케줄'" <%= getchecked(arrcontents,"'연간스케줄'") %> /> <label for="optCt3-1">연간스케줄</label></li>
												<li><input type="checkbox" class="check" id="optCt3-2" name="contents" value="'월간스케줄'" <%= getchecked(arrcontents,"'월간스케줄'") %> /> <label for="optCt3-2">월간스케줄</label></li>
												<li><input type="checkbox" class="check" id="optCt3-3" name="contents" value="'주간스케줄'" <%= getchecked(arrcontents,"'주간스케줄'") %> /> <label for="optCt3-3">주간스케줄</label></li>
												<li><input type="checkbox" class="check" id="optCt3-4" name="contents" value="'일스케줄'" <%= getchecked(arrcontents,"'일스케줄'") %> /> <label for="optCt3-4">일스케줄</label></li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>옵션</dt>
										<dd>
											<ul class="option-list">
												<li><input type="checkbox" class="check" id="optCt4-1" name="contents" value="'캐시북'" <%= getchecked(arrcontents,"'캐시북'") %> /> <label for="optCt4-1">캐시북</label></li>
												<li><input type="checkbox" class="check" id="optCt4-2" name="contents" value="'포켓'" <%= getchecked(arrcontents,"'포켓'") %> /> <label for="optCt4-2">포켓</label></li>
												<li><input type="checkbox" class="check" id="optCt4-3" name="contents" value="'밴드'" <%= getchecked(arrcontents,"'밴드'") %> /> <label for="optCt4-3">밴드</label></li>
												<li><input type="checkbox" class="check" id="optCt4-4" name="contents" value="'펜홀더'" <%= getchecked(arrcontents,"''펜홀더") %> /> <label for="optCt4-4">펜홀더</label></li>
											</ul>
										</dd>
									</dl>
								</dd>
							</dl>
							<dl class="type03">
								<dt><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_cover.png" alt="COVER" /></dt>
								<dd>
									<dl>
										<dt>재질</dt>
										<dd>
											<ul class="option-list">
												<li><input type="checkbox" class="check" id="optCv1-1" name="keyword" value="50" <%= getchecked(arrkeyword,"50") %> /> <label for="optCv1-1">소프트커버</label></li>
												<li><input type="checkbox" class="check" id="optCv1-2" name="keyword" value="51" <%= getchecked(arrkeyword,"51") %> /> <label for="optCv1-2">하드커버</label></li>
												<li><input type="checkbox" class="check" id="optCv1-3" name="keyword" value="52" <%= getchecked(arrkeyword,"52") %> /> <label for="optCv1-3">가죽</label></li>
												<li><input type="checkbox" class="check" id="optCv1-4" name="keyword" value="53" <%= getchecked(arrkeyword,"53") %> /> <label for="optCv1-4">PVC</label></li>
												<li><input type="checkbox" class="check" id="optCv1-5" name="keyword" value="54" <%= getchecked(arrkeyword,"54") %> /> <label for="optCv1-5">패브릭</label></li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>제본</dt>
										<dd>
											<ul class="option-list">
												<li><input type="checkbox" class="check" id="optCv2-1" name="keyword" value="55" <%= getchecked(arrkeyword,"55") %> /> <label for="optCv2-1">양장/무선</label></li>
												<li><input type="checkbox" class="check" id="optCv2-2" name="keyword" value="56" <%= getchecked(arrkeyword,"56") %> /> <label for="optCv2-2">스프링</label></li>
												<li><input type="checkbox" class="check" id="optCv2-3" name="keyword" value="57" <%= getchecked(arrkeyword,"57") %> /> <label for="optCv2-3">바인더</label></li>
											</ul>
										</dd>
									</dl>
									<dl class="tMar15">
										<dt>컬러</dt>
										<dd>
											<ul class="option-list colorchips">
												<li class="wine <%= getcheckedcolorclass(arrColorCode,"28") %>"		onclick="fnSelColorChip(28)" id="barCLChp28" summary="<%=getcheckediccd(arrColorCode,"28")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="28" class="check"><label for="wine">Wine</label></li>
												<li class="red <%= getcheckedcolorclass(arrColorCode,"2") %>"		onclick="fnSelColorChip(2)"  id="barCLChp2"  summary="<%=getcheckediccd(arrColorCode,"2")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="2"  class="check"><label for="red">Red</label></li>
												<li class="orange <%= getcheckedcolorclass(arrColorCode,"16") %>"	onclick="fnSelColorChip(16)" id="barCLChp16" summary="<%=getcheckediccd(arrColorCode,"16")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="16" class="check"><label for="orange">Orange</label></li>
												<li class="brown <%= getcheckedcolorclass(arrColorCode,"24") %>"	onclick="fnSelColorChip(24)" id="barCLChp24" summary="<%=getcheckediccd(arrColorCode,"24")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="24" class="check"><label for="brown">Brown</label></li>
												<li class="camel <%= getcheckedcolorclass(arrColorCode,"29") %>"	onclick="fnSelColorChip(29)" id="barCLChp29" summary="<%=getcheckediccd(arrColorCode,"29")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="29" class="check"><label for="camel">Camel</label></li>
												<li class="yellow <%= getcheckedcolorclass(arrColorCode,"17") %>"	onclick="fnSelColorChip(17)" id="barCLChp17" summary="<%=getcheckediccd(arrColorCode,"17")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="17" class="check"><label for="yellow">Yellow</label></li>
												<li class="beige <%= getcheckedcolorclass(arrColorCode,"18") %>"	onclick="fnSelColorChip(18)" id="barCLChp18" summary="<%=getcheckediccd(arrColorCode,"18")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="18" class="check"><label for="beige">Beige</label></li>
												<li class="ivory <%= getcheckedcolorclass(arrColorCode,"30") %>"	onclick="fnSelColorChip(30)" id="barCLChp30" summary="<%=getcheckediccd(arrColorCode,"30")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="30" class="check"><label for="ivory">Ivory</label></li>
												<li class="khaki <%= getcheckedcolorclass(arrColorCode,"31") %>"	onclick="fnSelColorChip(31)" id="barCLChp31" summary="<%=getcheckediccd(arrColorCode,"31")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="31" class="check"><label for="khaki">Khaki</label></li>
												<li class="green <%= getcheckedcolorclass(arrColorCode,"19") %>"	onclick="fnSelColorChip(19)" id="barCLChp19" summary="<%=getcheckediccd(arrColorCode,"19")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="19" class="check"><label for="green">Green</label></li>
												<li class="mint <%= getcheckedcolorclass(arrColorCode,"32") %>"		onclick="fnSelColorChip(32)" id="barCLChp32" summary="<%=getcheckediccd(arrColorCode,"32")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="32" class="check"><label for="mint">Mint</label></li>
												<li class="skyblue <%= getcheckedcolorclass(arrColorCode,"20") %>"	onclick="fnSelColorChip(20)" id="barCLChp20" summary="<%=getcheckediccd(arrColorCode,"20")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="20" class="check"><label for="skyblue">SkyBlue</label></li>
												<li class="blue <%= getcheckedcolorclass(arrColorCode,"21") %>"		onclick="fnSelColorChip(21)" id="barCLChp21" summary="<%=getcheckediccd(arrColorCode,"21")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="21" class="check"><label for="blue">Blue</label></li>
												<li class="navy <%= getcheckedcolorclass(arrColorCode,"33") %>"		onclick="fnSelColorChip(33)" id="barCLChp33" summary="<%=getcheckediccd(arrColorCode,"33")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="33" class="check"><label for="navy">Navy</label></li>
												<li class="violet <%= getcheckedcolorclass(arrColorCode,"22") %>"	onclick="fnSelColorChip(22)" id="barCLChp22" summary="<%=getcheckediccd(arrColorCode,"22")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="22" class="check"><label for="violet">violet</label></li>
												<li class="lilac <%= getcheckedcolorclass(arrColorCode,"34") %>"	onclick="fnSelColorChip(34)" id="barCLChp34" summary="<%=getcheckediccd(arrColorCode,"34")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="34" class="check"><label for="lilac">Lilac</label></li>
												<li class="babypink <%= getcheckedcolorclass(arrColorCode,"35") %>" onclick="fnSelColorChip(35)" id="barCLChp35" summary="<%=getcheckediccd(arrColorCode,"35")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="35" class="check"><label for="babypink">BabyPink</label></li>
												<li class="pink <%= getcheckedcolorclass(arrColorCode,"23") %>"		onclick="fnSelColorChip(23)" id="barCLChp23" summary="<%=getcheckediccd(arrColorCode,"23")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="23" class="check"><label for="pink">Pink</label></li>
												<li class="white <%= getcheckedcolorclass(arrColorCode,"7") %>"		onclick="fnSelColorChip(7)"  id="barCLChp7"  summary="<%=getcheckediccd(arrColorCode,"7")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="7"  class="check"><label for="white">White</label></li>
												<li class="grey <%= getcheckedcolorclass(arrColorCode,"25") %>"		onclick="fnSelColorChip(25)" id="barCLChp25" summary="<%=getcheckediccd(arrColorCode,"25")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="25" class="check"><label for="grey">Light Grey</label></li>
												<li class="charcoal <%= getcheckedcolorclass(arrColorCode,"36") %>" onclick="fnSelColorChip(36)" id="barCLChp36" summary="<%=getcheckediccd(arrColorCode,"36")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="36" class="check"><label for="charcoal">Charcoal</label></li>
												<li class="black <%= getcheckedcolorclass(arrColorCode,"8") %>"		onclick="fnSelColorChip(8)"  id="barCLChp8"  summary="<%=getcheckediccd(arrColorCode,"8")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="8"  class="check"><label for="black">Black</label></li>
												<li class="silver <%= getcheckedcolorclass(arrColorCode,"26") %>"	onclick="fnSelColorChip(26)" id="barCLChp26" summary="<%=getcheckediccd(arrColorCode,"26")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="26" class="check"><label for="silver">Silver</label></li>
												<li class="gold <%= getcheckedcolorclass(arrColorCode,"27") %>"		onclick="fnSelColorChip(27)" id="barCLChp27" summary="<%=getcheckediccd(arrColorCode,"27")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="27" class="check"><label for="gold">Gold</label></li>
												<!--
												<li class="check <%= getcheckedcolorclass(arrColorCode,"43") %>"	onclick="fnSelColorChip(43)" id="barCLChp43" summary="<%=getcheckediccd(arrColorCode,"43")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="43" class="check"><label for="check">Check</label></li>
												<li class="stripe <%= getcheckedcolorclass(arrColorCode,"44") %>"	onclick="fnSelColorChip(44)" id="barCLChp44" summary="<%=getcheckediccd(arrColorCode,"44")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="44" class="check"><label for="stripe">Stripe</label></li>
												<li class="dot <%= getcheckedcolorclass(arrColorCode,"45") %>"		onclick="fnSelColorChip(45)" id="barCLChp45" summary="<%=getcheckediccd(arrColorCode,"45")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="45" class="check"><label for="dot">Dot</label></li>
												<li class="flower <%= getcheckedcolorclass(arrColorCode,"48") %>"	onclick="fnSelColorChip(48)" id="barCLChp48" summary="<%=getcheckediccd(arrColorCode,"48")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="48" class="check"><label for="flower">Flower</label></li>
												<li class="drawing <%= getcheckedcolorclass(arrColorCode,"46") %>"	onclick="fnSelColorChip(46)" id="barCLChp46" summary="<%=getcheckediccd(arrColorCode,"46")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="46" class="check"><label for="drawing">Drawing</label></li>
												<li class="animal <%= getcheckedcolorclass(arrColorCode,"47") %>"	onclick="fnSelColorChip(47)" id="barCLChp47" summary="<%=getcheckediccd(arrColorCode,"47")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="47" class="check"><label for="animal">Animal</label></li>
												<li class="geometric <%= getcheckedcolorclass(arrColorCode,"49")%>"	onclick="fnSelColorChip(49)" id="barCLChp49" summary="<%=getcheckediccd(arrColorCode,"49")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="49" class="check"><label for="geometric">Geometric</label></li>
												-->
												<li class="hologram <%= getcheckedcolorclass(arrColorCode,"58")%>"	onclick="fnSelColorChip(58)" id="barCLChp58" summary="<%=getcheckediccd(arrColorCode,"58")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="58" class="check"><label for="hologram">HOLOGRAM</label></li>
											</ul>
										</dd>
									</dl>
								</dd>
							</dl>
						</div>
						<div class="btn-group">
							<input type="submit" value="초기화"  id="checkAll" class="btn btnB1 btnWhite" />
							<input type="submit" value="검색" onclick="goSearchDiary();" class="btn btnB1 btnRed" />
						</div>
					</div>
				</div>

				<a name="diaryscList" id="diaryscList"></a>

				<!-- 검색 결과 -->
				<div class="search-list">
					<ul class="tab">
						<!-- 선택시 클래스 current 붙여주세요 -->
						<li <%=CHKIIF(SortMet="best","class='current'","")%>><a href="" onclick="fnSearch('best'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_popular.png" alt="인기상품순" /></a></li>
						<li <%=CHKIIF(SortMet="newitem","class='current'","")%>><a href="" onclick="fnSearch('newitem'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_new.png" alt="신상품순" /></a></li>
						<li <%=CHKIIF(SortMet="min","class='current'","")%>><a href="" onclick="fnSearch('min'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_low.png" alt="낮은가격순" /></a></li>
						<li <%=CHKIIF(SortMet="hi","class='current'","")%>><a href="" onclick="fnSearch('hi'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_high.png" alt="높은가격순" /></a></li>
						<li <%=CHKIIF(SortMet="hs","class='current'","")%>><a href="" onclick="fnSearch('hs'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_discount.png" alt="높은할인율순" /></a></li>
					</ul>
					<div class="diary-list">
						<% If PrdBrandList.FResultCount > 0 Then %>
							<ul>
								<%
								For i = 0 To PrdBrandList.FResultCount - 1
		
									Dim tempimg, tempimg2
									dim imgSz : imgSz = 240
		
									If ListDiv = "item" Then
										tempimg = PrdBrandList.FItemList(i).FDiaryBasicImg
										tempimg2 = PrdBrandList.FItemList(i).FDiaryBasicImg2
									End If
									If ListDiv = "list" Then
										tempimg = PrdBrandList.FItemList(i).FDiaryBasicImg2
									End If
		
									IF application("Svr_Info") = "Dev" THEN
										tempimg = left(tempimg,7)&mid(tempimg,12)
										tempimg2 = left(PrdBrandList.FItemList(i).FDiaryBasicImg2,7)&mid(PrdBrandList.FItemList(i).FDiaryBasicImg2,12)''마우스오버 활용컷
									end if
										
								%>
									<li <% if PrdBrandList.FItemList(i).IsSoldOut then %>class="soldOut"<% end if %>>
										<a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%>" target="_blank">
											<div class="pdtPhoto">
												<% if PrdBrandList.FItemList(i).IsSoldOut then %>
													<span class="soldOutMask"></span>
												<% end if %>
												<img src="<%=tempimg %>" alt="<%= PrdBrandList.FItemList(i).FItemName %>" />
												<% If IsNull(PrdBrandList.FItemList(i).FpreviewImg) Or PrdBrandList.FItemList(i).FpreviewImg="" Then %>
												<% Else %>
													<button type="button" onclick="fnviewPreviewImg('<%= PrdBrandList.FItemList(i).FpreviewImg %>'); return false;" target="_top" class="btn-preview">미리보기</button>
												<% End If %>
											</div>
										</a>
										<div class="pdtInfo">
											<p class="brand"><a href="/street/street_brand.asp?makerid=<%= PrdBrandList.FItemList(i).FMakerId %>" target="_blank"><%= PrdBrandList.FItemList(i).Fsocname %></a></p>
											<p class="name"><a href="/shopping/category_prd.asp?itemid=<%=PrdBrandList.FItemList(i).FItemid%>" target="_blank"><%= PrdBrandList.FItemList(i).FItemName %></a></p>
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
										</div>
									</li>
								<%
								Next
								%>
							</ul>
						<% else %>
							<div class="nodata ct">
								<p><img src="http://fiximage.10x10.co.kr/web2013/common/txt_search_no.png" alt="흠… 검색 결과가 없습니다."></p>
								<p class="tMar10">해당상품이 품절 되었을 경우 검색이 되지 않습니다.</p>
							</div>
						<% end if %>

						<% If PrdBrandList.FResultCount > 0 Then %>
							<div class="pageWrapV15">
								<%= fnDisplayPaging_New(CurrPage,PrdBrandList.FTotalCount,PageSize,10,"jsGoPage") %>
							</div>
						<% end if %>
					</div>
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
	Set PrdBrandList = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->