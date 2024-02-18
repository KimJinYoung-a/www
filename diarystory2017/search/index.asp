<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2017 검색결과페이지
' History : 2016.09.26 유태욱 생성
'####################################################
%>
<!-- #include virtual="/diarystory2017/lib/worker_only_view.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/diarystory2017/lib/classes/diary_class_B.asp" -->
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
		PageSize = 8
	Else
		PageSize = 8
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

    dim rstWishItem: rstWishItem=""
	dim rstWishCnt: rstWishCnt=""

	dim oMainContents
	set oMainContents = new cdiary_list
'	oMainContents.FRectIdx = idx
	oMainContents.fcontents_oneitem
%>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2017.css" />
<script type="text/javascript">
$(function(){
	<% if Request("cpg") <> "" then %>
		window.parent.$('html,body').animate({scrollTop:$("#diaryscList").offset().top}, 0);
	<% end if %>
});
	
$(function(){
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
function fnSearch(frmnm,frmval){
	frmnm.value = frmval;
	var frm = document.frm_search1;
	frm.cpg.value=1;
	goSearchDiary();
}

function jsGoPage(iP){
	location.href = "<%=CurrURL()%>?cpg="+iP+"&srm=<%=SortMet%><%=vParaMeter%>";
}

//체크박스 전체선택 해제
$( document ).ready( function() {
	$( '.check-all' ).click( function() {
	  $( '.check' ).prop( 'checked', false );
		var tmp1;
		for(var i=0;i<document.frm_search1.chkIcd.length;i++) {
			tmp1 = document.frm_search1.chkIcd[i].value;
			$("#barCLChp" + tmp1).removeClass("selected");
			$("#barCLChp" + tmp1).attr("summary","N");
		}
		document.frm_search1.iccd.value="0";
		$("#barCLChp0").addClass("selected");
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
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diarystory2017">
		<div id="contentWrap">
			<!-- #include virtual="/diarystory2017/inc/head.asp" -->
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
			<input type="hidden" name="srm" value="<%= PrdBrandList.ftectSortMet %>"/>
			<div class="diaryContent diarySearchResult">
				<div class="diarySearch">
					<div class="diarySearchWrap">
						<h3><strong>원하는 항목에 체크해 주세요. <em class="cRd0V15">중복체크도 가능</em>합니다.</strong></h3>
						<p class="goPlanner"><a href="/event/eventmain.asp?eventid=73328">혹시 플래너를 찾으시나요?</a></p>
						<div class="searchOption">
							<dl class="optionType01">
								<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tit_design.png" alt="DESIGN" /></dt>
								<dd>
									<ul class="optionList">
										<li><input type="checkbox" class="check" id="optS01" name="design" value="10" <%= getchecked(ArrDesign,10) %> /> <label for="optS01">Simple</label></li>
										<li><input type="checkbox" class="check" id="optS02" name="design" value="20" <%= getchecked(ArrDesign,20) %> /> <label for="optS02">Illust</label></li>
										<li><input type="checkbox" class="check" id="optS03" name="design" value="30" <%= getchecked(ArrDesign,30) %> /> <label for="optS03">Pattern</label></li>
										<li><input type="checkbox" class="check" id="optS04" name="design" value="40" <%= getchecked(ArrDesign,40) %> /> <label for="optS04">Photo</label></li>
									</ul>
								</dd>
							</dl>
							<dl class="optionType02">
								<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tIt_contents.png" alt="CONTENTS" /></dt>
								<dd>
									<dl class="dateType">
										<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_date.png" alt="DATE TYPE" /></dt>
										<dd>
											<ul class="optionList">
												<li><input type="checkbox" class="check" id="optCt01" name="contents" value="'only 2017'" <%= getchecked(arrcontents,"'only 2017'") %>/> <label for="optCt01">Only 2017</label></li>
												<li><input type="checkbox" class="check" id="optCt02" name="contents" value="'만년'" <%= getchecked(arrcontents,"'만년'") %>/> <label for="optCt02">만년 다이어리</label></li>
											</ul>
										</dd>
									</dl>
									<dl class="layout">
										<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_layout.png" alt="PAGE LAYOUT" /></dt>
										<dd>
											<ul class="optionList">
												<li><input type="checkbox" class="check" id="optCt03" name="contents" value="'half diary'" <%= getchecked(arrcontents,"'half diary'") %> /> <label for="optCt03">Half diary</label></li>
												<li><input type="checkbox" class="check" id="optCt04" name="contents" value="'yearly'" <%= getchecked(arrcontents,"'yearly'") %> /> <label for="optCt04">Yearly</label></li>
												<li><input type="checkbox" class="check" id="optCt05" name="contents" value="'monthly'" <%= getchecked(arrcontents,"'monthly'") %> /> <label for="optCt05">Monthly</label></li>
												<li><input type="checkbox" class="check" id="optCt06" name="contents" value="'weekly'" <%= getchecked(arrcontents,"'weekly'") %> /> <label for="optCt06">Weekly</label></li>
												<li><input type="checkbox" class="check" id="optCt07" name="contents" value="'daily'" <%= getchecked(arrcontents,"'daily'") %> /> <label for="optCt07">Daily</label></li>
											</ul>
										</dd>
									</dl>
									<dl class="option">
										<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_option.png" alt="OPTION" /></dt>
										<dd>
											<ul class="optionList">
												<li><input type="checkbox" class="check" id="optCt08" name="contents" value="'cash'" <%= getchecked(arrcontents,"'cash'") %> /> <label for="optCt08">Cash</label></li>
												<li><input type="checkbox" class="check" id="optCt09" name="contents" value="'pocket'" <%= getchecked(arrcontents,"'pocket'") %> /> <label for="optCt09">Pocket</label></li>
												<li><input type="checkbox" class="check" id="optCt10" name="contents" value="'band'" <%= getchecked(arrcontents,"'band'") %> /> <label for="optCt10">Band</label></li>
												<li><input type="checkbox" class="check" id="optCt11" name="contents" value="'pen holder'" <%= getchecked(arrcontents,"'pen holder'") %> /> <label for="optCt11">Pen holder</label></li>
											</ul>
										</dd>
									</dl>
								</dd>
							</dl>
							<dl class="optionType03">
								<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tit_cover.png" alt="COVER" /></dt>
								<dd>
									<dl class="material">
										<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_material.png" alt="MATERIAL" /></dt>
										<dd>
											<ul class="optionList">
												<li><input type="checkbox" class="check" id="optCv01" name="keyword" value="37" <%= getchecked(arrkeyword,"37") %> /> <label for="optCv01">Paper soft</label></li>
												<li><input type="checkbox" class="check" id="optCv02" name="keyword" value="38" <%= getchecked(arrkeyword,"38") %> /> <label for="optCv02">Paper hard</label></li>
												<li><input type="checkbox" class="check" id="optCv03" name="keyword" value="39" <%= getchecked(arrkeyword,"39") %> /> <label for="optCv03">Leather</label></li>
												<li><input type="checkbox" class="check" id="optCv04" name="keyword" value="40" <%= getchecked(arrkeyword,"40") %> /> <label for="optCv04">PVC</label></li>
												<li><input type="checkbox" class="check" id="optCv05" name="keyword" value="42" <%= getchecked(arrkeyword,"42") %> /> <label for="optCv05">Fabric</label></li>
											</ul>
										</dd>
									</dl>
									<dl class="color">
										<dt><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_color.png" alt="COLOR" /></dt>
										<dd>
											<ul class="optionList colorchips">
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
												<li class="check <%= getcheckedcolorclass(arrColorCode,"43") %>"	onclick="fnSelColorChip(43)" id="barCLChp43" summary="<%=getcheckediccd(arrColorCode,"43")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="43" class="check"><label for="check">Check</label></li>
												<li class="stripe <%= getcheckedcolorclass(arrColorCode,"44") %>"	onclick="fnSelColorChip(44)" id="barCLChp44" summary="<%=getcheckediccd(arrColorCode,"44")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="44" class="check"><label for="stripe">Stripe</label></li>
												<li class="dot <%= getcheckedcolorclass(arrColorCode,"45") %>"		onclick="fnSelColorChip(45)" id="barCLChp45" summary="<%=getcheckediccd(arrColorCode,"45")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="45" class="check"><label for="dot">Dot</label></li>
												<li class="flower <%= getcheckedcolorclass(arrColorCode,"48") %>"	onclick="fnSelColorChip(48)" id="barCLChp48" summary="<%=getcheckediccd(arrColorCode,"48")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="48" class="check"><label for="flower">Flower</label></li>
												<li class="drawing <%= getcheckedcolorclass(arrColorCode,"46") %>"	onclick="fnSelColorChip(46)" id="barCLChp46" summary="<%=getcheckediccd(arrColorCode,"46")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="46" class="check"><label for="drawing">Drawing</label></li>
												<li class="animal <%= getcheckedcolorclass(arrColorCode,"47") %>"	onclick="fnSelColorChip(47)" id="barCLChp47" summary="<%=getcheckediccd(arrColorCode,"47")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="47" class="check"><label for="animal">Animal</label></li>
												<li class="geometric <%= getcheckedcolorclass(arrColorCode,"49")%>"	onclick="fnSelColorChip(49)" id="barCLChp49" summary="<%=getcheckediccd(arrColorCode,"49")%>">	<input type="hidden" name="chkIcd" id="chkIcd" value="49" class="check"><label for="geometric">Geometric</label></li>
											</ul>
										</dd>
									</dl>
								</dd>
							</dl>
						</div>
						<div class="clearAll"><input type="checkbox" id="checkAll" class="check-all" /> <label for="checkAll">전체선택 해제</label></div>
						<div class="searchBtn"><input type="submit" value="검색" onclick="goSearchDiary();" class="btn btnB1 btnRed" /></div>
					</div>
				</div>

				<a name="diaryscList" id="diaryscList"></a>

				<!--// 검색영역 -->
				<div class="diaryCtgy">
					<div class="array">
						<p><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_total.png" alt="Total" /> (<%=PrdBrandList.FTotalCount%>)</p>
						<div class="option">
							<select name="select" class="optSelect" onchange="fnSearch(this.form.srm,this.value);" title="다이어리 정렬 방식 선택">
								<option value="best" <%=CHKIIF(SortMet="best","selected","")%>>인기상품순</option>
								<option value="newitem" <%=CHKIIF(SortMet="newitem","selected","")%>>신상품순</option>
								<option value="min" <%=CHKIIF(SortMet="min","selected","")%>>낮은가격순</option>
								<option value="hi" <%=CHKIIF(SortMet="hi","selected","")%>>높은가격순</option>
								<option value="hs" <%=CHKIIF(SortMet="hs","selected","")%>>높은할인율순</option>
							</select>
						</div>
					</div>
					<div class="diaryList">
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
							<%' for dev msg : 상품은 16개씩 노출됩니다 / 품절일경우 클래스 soldOut 붙여주세요 %>
							<li <% if PrdBrandList.FItemList(i).IsSoldOut then %>class="soldOut"<% end if %>>
								<div class="pPhoto">
									<% if PrdBrandList.FItemList(i).IsSoldOut then %>
										<span class="soldOutMask"></span>
									<% end if %>
									<%' 미리보기 %>
									<% If IsNull(PrdBrandList.FItemList(i).FpreviewImg) Or PrdBrandList.FItemList(i).FpreviewImg="" Then %>
									<% Else %>
										<a href="#lyrPreview" onclick="fnviewPreviewImg('<%= PrdBrandList.FItemList(i).FpreviewImg %>'); return false;" target="_top" class="btnPreview">미리보기</a>
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
										<p class="name"><%= PrdBrandList.FItemList(i).FItemName %></p>
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
							Next
						%>							
						</ul>
						<% else %>
							<div class="nodata">
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
<div id="lyrPreview" style="display:none;">
	<div class="diaryPreview">
		<div class="previewBody" id="previewLoad"></div>
	</div>
</div>
</body>
</html>
<%
	Set PrdBrandList = Nothing
	Set oMainContents = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->