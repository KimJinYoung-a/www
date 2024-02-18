<% if request.ServerVariables("SCRIPT_NAME")="/diarystory2018/search/index.asp" then %>
	<div class="diary-head">
		<h2><a href="/diarystory2018/"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tit_diary_story.png" alt="DIARY STORY 2018" /></a></h2>
		<ul class="nav">
			<!-- for dev msg : 현재 페이지에 클래스 current -->
			<li class="calendar"><a href="/event/eventmain.asp?eventid=83443"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/nav_calendar.png" alt="캘린더 이벤트" /></a></li>
			<li class="event current"><a href="/diarystory2018/event.asp"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/nav_diary.png" alt="다이어리 이벤트" /></a></li>
			<li class="finder"><a href="" onclick="return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/btn_search.png" alt="다이어리 검색" /></a></li>
		</ul>
	</div>
<% else %>
	<div class="diary-head">
		<h2><a href="/diarystory2018/"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tit_diary_story.png" alt="DIARY STORY 2018" /></a></h2>
		<ul class="nav">
			<!-- for dev msg : 현재 페이지에 클래스 current -->
			<li class="calendar"><a href="/event/eventmain.asp?eventid=83443"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/nav_calendar.png" alt="캘린더 이벤트" /></a></li>
			<li class="event <% if request.ServerVariables("SCRIPT_NAME")="/diarystory2018/event.asp" then %>current<% end if %>"><a href="/diarystory2018/event.asp"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/nav_diary.png" alt="다이어리 이벤트" /></a></li>
			<li class="finder"><a href="#" onclick="viewPoupLayer('modal',$('#lyrDiarySch').html());return false;" target="_top"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/btn_search.png" alt="다이어리 검색" /></a></li>
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

	If GetPolderName(2) = "search" OR CurrURL() = "/diarystory2018/index.asp" OR GetPolderName(2) = "event" OR CurrURL() = "/diarystory2018/diary_prd.asp" Then
		vMenuNum = -1
	End IF
	%>
	<link rel="stylesheet" type="text/css" href="/lib/css/diary2018.css" />
	<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
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

	<!-- 다이어리 검색 레이어 -->
	<div id="lyrDiarySch" style="display:none;">
		<div class="diary-search">
			<h3><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tit_find_2.png" alt="나만의 다이어리 찾기" /><strong>원하는 항목에 체크해 주세요. <em class="cRd0V15">중복체크도 가능</em>합니다.</strong></h3>
			<a href="/event/eventmain.asp?eventid=80908" target="_top" class="btn-planner">혹시 플래너를 찾으시나요?</a>
			<div class="search-option">
				<dl class="type1">
					<dt><img src="http://fiximage.10x10.co.kr/web2017/diary2018/txt_design.png" alt="DESIGN" /></dt>
					<dd>
						<ul class="option-list">
							<li><input type="checkbox" class="check" id="optS01" name="design" value="10" /> <label for="optS01">Simple</label></li>
							<li><input type="checkbox" class="check" id="optS02" name="design" value="20" /> <label for="optS02">Illust</label></li>
							<li><input type="checkbox" class="check" id="optS03" name="design" value="30" /> <label for="optS03">Pattern</label></li>
							<li><input type="checkbox" class="check" id="optS04" name="design" value="40"/> <label for="optS04">Photo</label></li>
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
									<li><input type="checkbox" class="check" id="optCt01" name="contents" value="'2018 날짜형'" /> <label for="optCt01">2018 날짜형</label></li>
									<li><input type="checkbox" class="check" id="optCt02" name="contents" value="'만년형'" /> <label for="optCt02">만년형</label></li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>기간</dt>
							<dd>
								<ul class="option-list">
									<li><input type="checkbox" class="check" id="optCt2-1" name="contents" value="'1개월'"  /> <label for="optCt2-1">1개월</label></li>
									<li><input type="checkbox" class="check" id="optCt2-2" name="contents" value="'분기별'"  /> <label for="optCt2-2">분기별</label></li>
									<li><input type="checkbox" class="check" id="optCt2-3" name="contents" value="'6개월'"  /> <label for="optCt2-3">6개월</label></li>
									<li><input type="checkbox" class="check" id="optCt2-4" name="contents" value="'1년'"  /> <label for="optCt2-4">1년</label></li>
									<li><input type="checkbox" class="check" id="optCt2-5" name="contents" value="'1년 이상'"  /> <label for="optCt2-5">1년 이상</label></li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>내지 구성</dt>
							<dd>
								<ul class="option-list">
									<li><input type="checkbox" class="check" id="optCt3-1" name="contents" value="'연간스케줄'"  /> <label for="optCt3-1">연간스케줄</label></li>
									<li><input type="checkbox" class="check" id="optCt3-2" name="contents" value="'월간스케줄'"  /> <label for="optCt3-2">월간스케줄</label></li>
									<li><input type="checkbox" class="check" id="optCt3-3" name="contents" value="'주간스케줄'"  /> <label for="optCt3-3">주간스케줄</label></li>
									<li><input type="checkbox" class="check" id="optCt3-4" name="contents" value="'일스케줄'"  /> <label for="optCt3-4">일스케줄</label></li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>옵션</dt>
							<dd>
								<ul class="option-list">
									<li><input type="checkbox" class="check" id="optCt4-1" name="contents" value="'캐시북'"  /> <label for="optCt4-1">캐시북</label></li>
									<li><input type="checkbox" class="check" id="optCt4-2" name="contents" value="'포켓'"  /> <label for="optCt4-2">포켓</label></li>
									<li><input type="checkbox" class="check" id="optCt4-3" name="contents" value="'밴드'"  /> <label for="optCt4-3">밴드</label></li>
									<li><input type="checkbox" class="check" id="optCt4-4" name="contents" value="'펜홀더'"  /> <label for="optCt4-4">펜홀더</label></li>
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
									<li><input type="checkbox" class="check" id="optCv1-1" name="keyword" value="50"  /> <label for="optCv1-1">소프트커버</label></li>
									<li><input type="checkbox" class="check" id="optCv1-2" name="keyword" value="51" /> <label for="optCv1-2">하드커버</label></li>
									<li><input type="checkbox" class="check" id="optCv1-3" name="keyword" value="52" /> <label for="optCv1-3">가죽</label></li>
									<li><input type="checkbox" class="check" id="optCv1-4" name="keyword" value="53" /> <label for="optCv1-4">PVC</label></li>
									<li><input type="checkbox" class="check" id="optCv1-5" name="keyword" value="54" /> <label for="optCv1-5">패브릭</label></li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>제본</dt>
							<dd>
								<ul class="option-list">
									<li><input type="checkbox" class="check" id="optCv2-1" name="keyword" value="55" /> <label for="optCv2-1">양장/무선</label></li>
									<li><input type="checkbox" class="check" id="optCv2-2" name="keyword" value="56" /> <label for="optCv2-2">스프링</label></li>
									<li><input type="checkbox" class="check" id="optCv2-3" name="keyword" value="57" /> <label for="optCv2-3">바인더</label></li>
								</ul>
							</dd>
						</dl>
						<dl class="tMar15">
							<dt>컬러</dt>
							<dd>
								<ul class="option-list colorchips">
									<%'<li class="all" id="barCLChp0" summary=""><input type="radio" name="chkIcd" id="chkIcd" value="0" class="check" /><label for="all">ALL</label></li>%>
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
				<input type="submit" id="checkAll" onclick="fnchkfal();" value="초기화" class="btn btnB1 btnWhite" />
				<input type="submit" onclick="javascript:goSearchDiary();" value="검색" class="btn btnB1 btnRed" />
			</div>
			<button type="button" class="btn-close" onclick="ClosePopLayer();"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/btn_close.png" alt="닫기" /></button>
		</div>
	</div>
	</form>
<% end if %>
