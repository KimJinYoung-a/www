<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  당신은 욕심부릴 자격이 있습니다. 시리즈
' History : 2014.07.14 한용민 생성(1차 생성)
'			2014.07.14 한용민 (2차 추가)
'####################################################

dim currentevt_code
	currentevt_code=requestcheckvar(request("currentevt_code"),10)

dim evt_code1, evt_code2, evt_code3, evt_code4
	IF application("Svr_Info") = "Dev" THEN
		evt_code1 = 21227
		evt_code2 = 21228
		evt_code3 = ""
		evt_code4 = ""
	Else
		evt_code1 = 52242
		evt_code2 = 53013
		evt_code3 = ""
		evt_code4 = ""
	End If

if currentevt_code="" then currentevt_code=evt_code1

%>

<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- INCLUDE Virtual="/lib/chkDevice.asp" -->

</head>
<div class="myBathroomNav">
		<% if cstr(evt_code1)=cstr(currentevt_code) then %>
        	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2014/52242/tit_bathroom.gif" alt="당신은 욕심부릴 자격이 있습니다! 욕심부릴 곳, 따로 있나요? 욕실에 투자해보세요." /></h2>
			<style type="text/css">
			.myBathroomNav {position:relative; height:106px; text-align:left; background:#159dcf;}
			.myBathroomNav h2 {padding:36px 0 0 55px;}
			.myBathroomNav ul {position:absolute; right:11px; top:34px; overflow:hidden; min-height:22px;}
			.myBathroomNav ul li {float:left; padding:0 18px 0 19px;background:url(http://webimage.10x10.co.kr/eventIMG/2014/52242/bg_menu_bar.gif) left center no-repeat;}
			.myBathroomNav ul li:first-child {background:none;}
			.myBathroomNav ul li a {display:block; width:20px; height:40px; cursor:default; background-position:left top; background-repeat:no-repeat; text-indent:-9999px;}
			.myBathroomNav ul li.open a {cursor:pointer;}
			.myBathroomNav ul li .nav01 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav01_off.png)}
			.myBathroomNav ul li .nav02 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav02_off.png)}
			.myBathroomNav ul li .nav03 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav03_off.png)}
			.myBathroomNav ul li .nav04 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav04_off.png)}
			.myBathroomNav ul li.on .nav01 {width:161px; background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav01_on.gif)}
			.myBathroomNav ul li.on .nav02 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav02_on.gif)}
			.myBathroomNav ul li.on .nav03 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav03_on.gif)}
			.myBathroomNav ul li.on .nav04 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav04_on.gif)}
			</style>
        <% elseif cstr(evt_code2)=cstr(currentevt_code) then %>
        	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2014/53013/tit_bathroom.gif" alt="당신은 욕심부릴 자격이 있습니다! 욕심부릴 곳, 따로 있나요? 욕실에 투자해보세요." /></h2>
	        <style type="text/css">
	        .myBathroomNav {position:relative; height:106px; text-align:left; background:#9489ef;}
	        .myBathroomNav h2 {padding:36px 0 0 55px;}
	        .myBathroomNav ul {position:absolute; right:11px; top:34px; overflow:hidden; min-height:22px;}
	        .myBathroomNav ul li {float:left; padding:0 18px 0 19px; background:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav_bar.png) left center no-repeat;}
	        .myBathroomNav ul li:first-child {background:none;}
	        .myBathroomNav ul li a {display:block; width:20px; height:40px; cursor:default; background-position:left top; background-repeat:no-repeat; text-indent:-9999px;}
	        .myBathroomNav ul li.open a {cursor:pointer;}
	        .myBathroomNav ul li .nav01 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav01_off.png)}
	        .myBathroomNav ul li .nav02 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav02_off.png)}
	        .myBathroomNav ul li .nav03 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav03_off.png)}
	        .myBathroomNav ul li .nav04 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav04_off.png)}
	        .myBathroomNav ul li.on .nav01 {width:161px; background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav01_on.gif)}
	        .myBathroomNav ul li.on .nav02 {width:161px; background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav02_on.gif)}
	        .myBathroomNav ul li.on .nav03 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav03_on.gif)}
	        .myBathroomNav ul li.on .nav04 {background-image:url(http://fiximage.10x10.co.kr/web2013/event/series/bathroom_nav04_on.gif)}
	        </style>
        <% end if %>

        <ul>
			<li class="open <% if cstr(evt_code1)=cstr(currentevt_code) then %>on<% end if %>"><a href="/event/eventmain.asp?eventid=<%= evt_code1 %>" class="nav01" target="_top">#1.TOOTHBRUSH</a></li>
            
            <% if date()>="2014-07-09" then %>
            	<li class="open <% if cstr(evt_code2)=cstr(currentevt_code) then %>on<% end if %>"><a href="/event/eventmain.asp?eventid=<%= evt_code2 %>" class="nav02" target="_top">#2</a></li>
            <% else %>
            	<li><a href="#" class="nav02">#2</a></li>
            <% end if %>

            <li><a href="#" class="nav03">#3</a></li>
            <li><a href="#" class="nav04">#4</a></li>
        </ul>
</div>
</body>
</html>