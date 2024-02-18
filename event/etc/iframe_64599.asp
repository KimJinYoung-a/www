<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 브랜드 어워드
' History : 2015.07.09 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim evt_code13 , evt_code14, evt_code15 , evt_code16 , evt_code17 , evt_code20 , evt_code21 , evt_code22 , evt_code23, evt_code24
Dim evt_code, userid
	evt_code = request("eventid")
	userid = getloginuserid()

dim currenttime
	currenttime =  now()
	'currenttime = #07/13/2015 09:00:00#

	IF application("Svr_Info") = "Dev" THEN
		evt_code13 = 64820
		evt_code14 = 64738
		evt_code15 = 64890
		evt_code16 = 64754
		evt_code17 = 64829
		evt_code20 = 64733
		evt_code21 = 64981
		evt_code22 = 65052
		evt_code23 = 65059
		evt_code24 = 65109
	Else
		evt_code13 = 64599
		evt_code14 = 64738
		evt_code15 = 64890
		evt_code16 = 64754
		evt_code17 = 64829
		evt_code20 = 64733
		evt_code21 = 64981
		evt_code22 = 65052
		evt_code23 = 65059
		evt_code24 = 65109
	End If
%>

<!-- #include virtual="/lib/inc/head.asp" -->

<style type="text/css">
/* iframe */
.brandTab {height:193px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/bg_rookie_brand_tab.png) no-repeat 0 0;}
.brandTab ul {width:885px; padding:10px 0 0 1px; margin:0 auto;}
.brandTab ul:after {content:' '; display:block; clear:both;}
.brandTab li {position:relative; overflow:visible; float:left; width:176px; height:76px; margin:0 1px 1px 0; background-position:50% 0; background-repeat:no-repeat;}
.brandTab li span {display:none;}
.brandTab li a {overflow:hidden; display:block; width:100%; height:100%; background-repeat:no-repeat; text-indent:-9999px;}
.brandTab li.brand01, .brandTab li.brand01 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_rookie_brand01.png);}
.brandTab li.brand02, .brandTab li.brand02 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_rookie_brand02.png);}
.brandTab li.brand03, .brandTab li.brand03 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_rookie_brand03.png);}
.brandTab li.brand04, .brandTab li.brand04 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_rookie_brand04.png);}
.brandTab li.brand05, .brandTab li.brand05 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_rookie_brand05.png);}
.brandTab li.brand06, .brandTab li.brand06 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_rookie_brand06.png);}
.brandTab li.brand07, .brandTab li.brand07 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_rookie_brand07.png);}
.brandTab li.brand08, .brandTab li.brand08 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_rookie_brand08.png);}
.brandTab li.brand09, .brandTab li.brand09 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_rookie_brand09.png);}
.brandTab li.brand10, .brandTab li.brand10 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_rookie_brand10.png);}
.brandTab li.open span, .brandTab li.current span, .brandTab li.today span {display:block; width:100%; height:100%;}
.brandTab li.open a {background-position:50% -76px; background-color:#fff;}
.brandTab li.today a {background-position:50% -152px; background-color:#1a8fff !important;}
.brandTab li.today em {display:inline-block; position:absolute; left:50%; top:-10px; width:116px; height:24px; margin-left:-58px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/ico_rookie_today.png) no-repeat 0 0; text-indent:-9999px;}
.brandTab li.current a {background-position:50% -152px !important; background-color:#56de9c;}
</style>
<script type="text/javascript">
$(function(){
	//iframe
	$('.brandTab li.today').append('<em>today</em>');
	$(".goCmt").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
});
</script>
</head>
<body>
<% '<!-- iframe --> %>
<div class="brandTab">
	<ul>
		<% '<!-- 오픈:open / 투데이브랜드:today / 현재보고있는페이지:current 클래스 붙여주세요 --> %>
		<li class="brand01 <%=chkiif(left(currenttime,10)>="2015-07-13"," open","")%> <%=chkiif(left(currenttime,10)="2015-07-13"," today","")%> <% if CStr(evt_code) = CStr(evt_code13) then response.write " current" %>">
			<span><a href="/event/eventmain.asp?eventid=<%= evt_code13 %>" target="_top">coco humming</a></span>
		</li>
		<li class="brand02 <%=chkiif(left(currenttime,10)>="2015-07-14"," open","")%> <%=chkiif(left(currenttime,10)="2015-07-14"," today","")%> <% if CStr(evt_code) = CStr(evt_code14) then response.write " current" %>">
			<span><a href="/event/eventmain.asp?eventid=<%= evt_code14 %>" target="_top">Karel capek</a></span>
		</li>
		<li class="brand03 <%=chkiif(left(currenttime,10)>="2015-07-15"," open","")%> <%=chkiif(left(currenttime,10)="2015-07-15"," today","")%> <% if CStr(evt_code) = CStr(evt_code15) then response.write " current" %>">
			<span><a href="/event/eventmain.asp?eventid=<%= evt_code15 %>" target="_top">Novesta</a></span>
		</li>
		<li class="brand04 <%=chkiif(left(currenttime,10)>="2015-07-16"," open","")%> <%=chkiif(left(currenttime,10)="2015-07-16"," today","")%> <% if CStr(evt_code) = CStr(evt_code16) then response.write " current" %>">
			<span><a href="/event/eventmain.asp?eventid=<%= evt_code16 %>" target="_top">Houmming K&L</a></span>
		</li>
		<li class="brand05 <%=chkiif(left(currenttime,10)>="2015-07-17"," open","")%> <%=chkiif(left(currenttime,10)="2015-07-17"," today","")%> <% if CStr(evt_code) = CStr(evt_code17) then response.write " current" %>">
			<span><a href="/event/eventmain.asp?eventid=<%= evt_code17 %>" target="_top">Gudetama</a></span>
		</li>
		<li class="brand06 <%=chkiif(left(currenttime,10)>="2015-07-20"," open","")%> <%=chkiif(left(currenttime,10)="2015-07-20"," today","")%> <% if CStr(evt_code) = CStr(evt_code20) then response.write " current" %>">
			<span><a href="/event/eventmain.asp?eventid=<%= evt_code20 %>" target="_top">dailymonday</a></span>
		</li>
		<li class="brand07 <%=chkiif(left(currenttime,10)>="2015-07-21"," open","")%> <%=chkiif(left(currenttime,10)="2015-07-21"," today","")%> <% if CStr(evt_code) = CStr(evt_code21) then response.write " current" %>">
			<span><a href="/event/eventmain.asp?eventid=<%= evt_code21 %>" target="_top">Container factory</a></span>
		</li>
		<li class="brand08 <%=chkiif(left(currenttime,10)>="2015-07-22"," open","")%> <%=chkiif(left(currenttime,10)="2015-07-22"," today","")%> <% if CStr(evt_code) = CStr(evt_code22) then response.write " current" %>">
			<span><a href="/event/eventmain.asp?eventid=<%= evt_code22 %>" target="_top">Logos</a></span>
		</li>
		<li class="brand09 <%=chkiif(left(currenttime,10)>="2015-07-23"," open","")%> <%=chkiif(left(currenttime,10)="2015-07-23"," today","")%> <% if CStr(evt_code) = CStr(evt_code23) then response.write " current" %>">
			<span><a href="/event/eventmain.asp?eventid=<%= evt_code23 %>" target="_top">sseko</a></span>
		</li>
		<li class="brand10 <%=chkiif(left(currenttime,10)>="2015-07-24"," open","")%> <%=chkiif(left(currenttime,10)="2015-07-24"," today","")%> <% if CStr(evt_code) = CStr(evt_code24) then response.write " current" %>">
			<span><a href="/event/eventmain.asp?eventid=<%= evt_code24 %>" target="_top">Amber</a></span>
		</li>
	</ul>
</div>
<% '<!--// iframe --> %>

</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->