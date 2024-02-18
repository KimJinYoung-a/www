<% if request.ServerVariables("SCRIPT_NAME")="/diarystory2016/search/index.asp" then %>
	<div class="diaryHead">
		<h2><a href="/diarystory2016/"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_diary_story.gif" alt="DIARY STORY - A DAY OF YOUR LIFE" /></a></h2>
		<ul class="diaryNav">
			<li><a href="/diarystory2016/event.asp"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/nav_diary_event.gif" alt="Diary Event" /></a></li>
			<li class="current"><a href="#" onclick="return false;"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/nav_diary_search.gif" alt="다이어리 검색" /></a></li>
		</ul>
	</div>
<% else %>
	<div class="diaryHead">
		<h2><a href="/diarystory2016/"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_diary_story.gif" alt="DIARY STORY - A DAY OF YOUR LIFE" /></a></h2>
		<ul class="diaryNav">
			<li <% if request.ServerVariables("SCRIPT_NAME")="/diarystory2016/event.asp" then %> class="current"<% end if %>><a href="/diarystory2016/event.asp"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/nav_diary_event.gif" alt="Diary Event" /></a></li>
			<li><a href="#" onclick="viewPoupLayer('modal',$('#lyrDiarySch').html());return false;" target="_top"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/nav_diary_search.gif" alt="다이어리 검색" /></a></li>
		</ul>
	</div>
	<%
		Dim vMenuNum, vCate, arrColorCode
		vCate = Request("arrds")
		Select Case Request("arrds")
			Case "10,"
				vMenuNum = 1
			Case "20,"
				vMenuNum = 2
			Case "30,"
				vMenuNum = 3
			Case "40,"
				vMenuNum = 4
			Case "50,"
				vMenuNum = 5
			Case Else
				vMenuNum = 0
		End Select
	
		If GetPolderName(2) = "search" OR CurrURL() = "/diarystory2016/index.asp" OR GetPolderName(2) = "event" OR CurrURL() = "/diarystory2016/diary_prd.asp" Then
			vMenuNum = -1
		End IF
	%>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2015.css" />
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript">
	function goSearchDiary()
	{
		var nm  = document.getElementsByName('design');
		var cm  = document.getElementsByName('contents');
		var km  = document.getElementsByName('keyword');
	
		document.frm_search.arrds.value = "";
		document.frm_search.arrcont.value = "";
		document.frm_search.arrkey.value = "";

		for (var i=0;i<nm.length;i++){
	
			if (nm[i].checked){
				document.frm_search.arrds.value = document.frm_search.arrds.value  + nm[i].value + ",";
			}
		}
	
		for (var i=0;i<cm.length;i++){
	
			if (cm[i].checked){
				document.frm_search.arrcont.value = document.frm_search.arrcont.value  + cm[i].value + ",";
			}
		}
	
		for (var i=0;i<km.length;i++){
	
			if (km[i].checked){
				document.frm_search.arrkey.value = document.frm_search.arrkey.value  + km[i].value + ",";
			}
		}
		
		if ($("input:checkbox[id='optS05']").is(":checked")==true){
			document.frm_search.sublimited.value = "o";
		}
		else{
			document.frm_search.sublimited.value = "x";
		}

		document.frm_search.limited.value = document.frm_search.sublimited.value;
		document.frm_search.action = "/<%=g_HomeFolder%>/search/";
		document.frm_search.submit();
	}

	//체크박스 전체선택 해제 onclick
	function fnchkfal(){
	  $( '.check' ).prop( 'checked', false );
		var tmp1;
		for(var i=0;i<document.frm_search.chkIcd.length;i++) {
			tmp1 = document.frm_search.chkIcd[i].value;
			$("#barCLChp" + tmp1).removeClass("selected");
			$("#barCLChp" + tmp1).attr("summary","N");
		}
		document.frm_search.iccd.value="0";
		$("#barCLChp0").addClass("selected");
	}

	function fnSelColorChip(iccd) {
		var tmp;
		var chkCnt = 0;
			if(iccd==0) {
			//전체 선택-리셋
			for(var i=0;i<document.frm_search.chkIcd.length;i++) {
				tmp = document.frm_search.chkIcd[i].value;
				$("#barCLChp" + tmp).removeClass("selected");
				$("#barCLChp" + tmp).attr("summary","N");
			}
			document.frm_search.iccd.value="0";
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
				document.frm_search.iccd.value="0";
				$("#barCLChp0").attr("class","selected");
			} else {
				$("#barCLChp0").removeClass("selected");
			}
	
			document.frm_search.iccd.value="";
			for(var i=0;i<document.frm_search.chkIcd.length;i++) {
				tmp = document.frm_search.chkIcd[i].value;
				if($("#barCLChp" + tmp).attr("summary") =="Y") {
					if(document.frm_search.iccd.value!="") {
						document.frm_search.iccd.value = document.frm_search.iccd.value + tmp + ",";
					} else {
						document.frm_search.iccd.value = tmp+ ",";
					}
				}
			}
		}
	}

</script>
<form name="frm_search" method="post" style="margin:0px;">
<input type="hidden" name="arrds" value="">
<input type="hidden" name="arrcont" value="">
<input type="hidden" name="arrkey" value="">
<input type="hidden" name="limited" value="">
<input type="hidden" name="arrds_temp" value="<%= request("arrds") %>">
<input type="hidden" name="arrcont_temp" value="<%= request("arrcont") %>">
<input type="hidden" name="arrkey_temp" value="<%= request("arrkey") %>">
<input type="hidden" name="iccd" value="">
<div id="lyrDiarySch" style="display:none">
	<div class="diarySearch">
		<div class="diarySearchWrap">
			<h3><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_diary_search.gif" alt="DIARY SEARCH" /> <strong>원하는 항목에 체크해 주세요. <em class="cRd0V15">중복체크도 가능</em>합니다.</strong></h3>
			<p class="goPlanner"><a href="/event/eventmain.asp?eventid=66140"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/btn_planner.gif" alt="혹시 플래너를 찾으시나요?" /></a></p>
			<div class="searchOption">
				<dl class="optionType01">
					<dt><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_check_style.gif" alt="STYLE - 스타일을 선택해 주세요" /></dt>
					<dd>
						<ul class="optionList">
							<li><input type="checkbox" class="check" id="optS01" name="design" value="10" /> <label for="optS01">Simple</label></li>
							<li><input type="checkbox" class="check" id="optS02" name="design" value="20" /> <label for="optS02">Illust</label></li>
							<li><input type="checkbox" class="check" id="optS03" name="design" value="30" /> <label for="optS03">Pattern</label></li>
							<li><input type="checkbox" class="check" id="optS04" name="design" value="40"/> <label for="optS04">Photo</label></li>
						</ul>
					</dd>
				</dl>
				<dl class="optionType02">
					<dt><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_check_contents.gif" alt="CONTENTS - 내부 구성을 선택해 주세요" /></dt>
					<dd>
						<dl class="dateType">
							<dt><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_date_type.gif" alt="DATE TYPE" /></dt>
							<dd>
								<ul class="optionList">
									<li><input type="checkbox" class="check" id="optCt01" name="contents" value="'only 2016'" /> <label for="optCt01">Only 2016</label></li>
									<li><input type="checkbox" class="check" id="optCt02" name="contents" value="'만년'" /> <label for="optCt02">만년 다이어리</label></li>
									<% '' 2016 리미티드 추가 %>
									<li class="sEdition"><input type="checkbox" class="check" id="optS05" name="sublimited" value="o"> <label for="optS05"><strong>10X10 SPECIAL EDITION</strong></label></li>									
								</ul>
							</dd>
						</dl>
						<dl class="layout">
							<dt><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_page_layout.gif" alt="PAGE LAYOUT" /></dt>
							<dd>
								<ul class="optionList">
									<li><input type="checkbox" class="check" id="optCt03" name="contents" value="'half diary'" /> <label for="optCt03">Half diary</label></li>
									<li><input type="checkbox" class="check" id="optCt04" name="contents" value="'yearly'" /> <label for="optCt04">Yearly</label></li>
									<li><input type="checkbox" class="check" id="optCt05" name="contents" value="'monthly'" /> <label for="optCt05">Monthly</label></li>
									<li><input type="checkbox" class="check" id="optCt06" name="contents" value="'weekly'" /> <label for="optCt06">Weekly</label></li>
									<li><input type="checkbox" class="check" id="optCt07" name="contents" value="'daily'" /> <label for="optCt07">Daily</label></li>
								</ul>
							</dd>
						</dl>
						<dl class="option">
							<dt><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_option.gif" alt="OPTION" /></dt>
							<dd>
								<ul class="optionList">
									<li><input type="checkbox" class="check" id="optCt08" name="contents" value="'cash'" /> <label for="optCt08">Cash</label></li>
									<li><input type="checkbox" class="check" id="optCt09" name="contents" value="'pocket'" /> <label for="optCt09">Pocket</label></li>
									<li><input type="checkbox" class="check" id="optCt10" name="contents" value="'band'" /> <label for="optCt10">Band</label></li>
									<li><input type="checkbox" class="check" id="optCt11" name="contents" value="'pen holder'"/> <label for="optCt11">Pen holder</label></li>
								</ul>
							</dd>
						</dl>
					</dd>
				</dl>
				<dl class="optionType03">
					<dt><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_check_cover.gif" alt="COVER - 커버 타입을 선택해 주세요" /></dt>
					<dd>
						<dl class="material">
							<dt><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_material.gif" alt="MATERIAL" /></dt>
							<dd>
								<ul class="optionList">
									<li><input type="checkbox" class="check" id="optCv01" name="keyword" value="37" /> <label for="optCv01">Paper soft</label></li>
									<li><input type="checkbox" class="check" id="optCv02" name="keyword" value="38" /> <label for="optCv02">Paper hard</label></li>
									<li><input type="checkbox" class="check" id="optCv03" name="keyword" value="39" /> <label for="optCv03">Leather</label></li>
									<li><input type="checkbox" class="check" id="optCv04" name="keyword" value="40" /> <label for="optCv04">PVC</label></li>
									<li><input type="checkbox" class="check" id="optCv05" name="keyword" value="42" /> <label for="optCv05">Fabric</label></li>
								</ul>
							</dd>
						</dl>
						<dl class="color">
							<dt><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_color.gif" alt="COLOR" /></dt>
							<dd>
								<ul class="optionList colorchips">
									<!--<li class="all selected"><input type="radio" id="all" /><label for="all">ALL</label></li>-->
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
			<div class="clearAll"><input type="checkbox" id="checkAll" class="check" onclick="fnchkfal();"/> <label for="checkAll">전체선택 해제</label></div>

			<div class="searchBtn"><input type="submit" onclick="javascript:goSearchDiary();" value="검색" class="btn btnB1 btnRed" /></div>

			<p class="close" onclick="ClosePopLayer();"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/btn_close.gif" alt="닫기" /></p>
		</div>
	</div>
</div>
</form>
<% end if %>