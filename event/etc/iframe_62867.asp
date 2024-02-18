<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  ## 10x10 SUMMER BRAND AWARD
' History : 2015-05-22 유태욱 생성
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #INCLUDE Virtual="/lib/util/pageformlib.asp" -->
<%
dim evt_code1, evt_code2, evt_code3, evt_code4, evt_code5, evt_code6, evt_code7, evt_code8 , evt_code9 , evt_code10, evt_code11, evt_code12, evt_code13, evt_code14
Dim evt_code : evt_code = request("eventid")

	IF application("Svr_Info") = "Dev" THEN	'	테섭이벤트코드
		evt_code1 =  62867		''5월26일

		evt_code2 =  63003		''5월27일
		evt_code3 =  63047		''5월28일
		evt_code4 =  63055		''5월29일
		evt_code5 =  63006		''6월01일
		evt_code6 =  63115		''6월02일
		evt_code7 =  63125		''6월03일
		evt_code8 =  63012		''6월04일
		evt_code9 =  63180		''6월05일
		evt_code10 = 63085		''6월08일
		evt_code11 = 63434		''6월09일
		evt_code12 = 63485		''6월10일
		evt_code13 = 63549		''6월11일
		evt_code14 = 63553		''6월12일
	Else									'	실섭이벤트코드
		evt_code1 =  62867		''5월26일

		evt_code2 =  63003		''5월27일
		evt_code3 =  63047		''5월28일
		evt_code4 =  63055		''5월29일
		evt_code5 =  63006		''6월01일
		evt_code6 =  63115		''6월02일
		evt_code7 =  63125		''6월03일
		evt_code8 =  63012		''6월04일
		evt_code9 =  63180		''6월05일
		evt_code10 = 63085		''6월08일
		evt_code11 = 63434		''6월09일
		evt_code12 = 63485		''6월10일
		evt_code13 = 63549		''6월11일
		evt_code14 = 63553		''6월12일
	End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.brandTab {height:187px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/bg_brand_tab.gif) no-repeat 0 0;}
.brandTab ul {width:912px; padding-top:18px; margin:0 auto;}
.brandTab ul:after {content:' '; display:block; clear:both;}
.brandTab li {position:relative; overflow:visible; float:left; width:126px; height:64px; margin:0 2px 2px 0; border:1px solid #fff; background-position:50% 0; background-repeat:no-repeat;}
.brandTab li span {display:none;}
.brandTab li a {display:block; width:100%; height:100%; background-repeat:no-repeat; text-indent:-9999px;}
.brandTab li.brand01, .brandTab li.brand01 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand01.png);}
.brandTab li.brand02, .brandTab li.brand02 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand02.png);}
.brandTab li.brand03, .brandTab li.brand03 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand03.png);}
.brandTab li.brand04, .brandTab li.brand04 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand04.png);}
.brandTab li.brand05, .brandTab li.brand05 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand05.png);}
.brandTab li.brand06, .brandTab li.brand06 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand06.png);}
.brandTab li.brand07, .brandTab li.brand07 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand07.png);}
.brandTab li.brand08, .brandTab li.brand08 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand08.png);}
.brandTab li.brand09, .brandTab li.brand09 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand09.png);}
.brandTab li.brand10, .brandTab li.brand10 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand10.png);}
.brandTab li.brand11, .brandTab li.brand11 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand11.png);}
.brandTab li.brand12, .brandTab li.brand12 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand12.png);}
.brandTab li.brand13, .brandTab li.brand13 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand13.png);}
.brandTab li.brand14, .brandTab li.brand14 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/tab_brand14.png);}
.brandTab li.open span, .brandTab li.current span, .brandTab li.today span {display:block; width:100%; height:100%;}
.brandTab li.open a {background-position:50% -66px; background-color:#fff;}
.brandTab li.today {border-color:#50c0fa;}
.brandTab li.today a {background-position:50% -132px; background-color:#50c0fa;}
.brandTab li.today em {display:inline-block; position:absolute; left:50%; top:-18px; width:105px; height:33px; margin-left:-52px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/ico_today.png) no-repeat 0 0; text-indent:-9999px;}
.brandTab li.current {border-color:#0b7fc9 !important;}
.brandTab li.current a {background-position:50% -132px !important; background-color:#0b7fc9 !important;}
.brandTab li.brand08 em,.brandTab li.brand09 em,.brandTab li.brand10 em,
.brandTab li.brand11 em,.brandTab li.brand12 em,.brandTab li.brand13 em,.brandTab li.brand14 em {top:52px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/brandaward/ico_today_v2.png);}
</style>
<script type="text/javascript">
$(function(){
	$('.brandTab li.today').append('<em>today</em>');
	$(".goCmt").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
});
</script>
</head>
<body>
<!-- iframe -->
<div class="brandTab">
	<ul>
		<li class="brand01<%=chkiif(date()>="2015-05-26"," open","")%> <%=chkiif(date()="2015-05-26"," today","")%><% if CStr(evt_code) = CStr(evt_code1) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code1 %>" target="_top">BLOOMING&amp;ME</a>
			</span>
		</li>
	
		<li class="brand02<%=chkiif(date()>="2015-05-27"," open","")%> <%=chkiif(date()="2015-05-27"," today","")%><% if CStr(evt_code) = CStr(evt_code2) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code2 %>" target="_top">BO WELL</a>
			</span>
		</li>

		<li class="brand03<%=chkiif(date()>="2015-05-28"," open","")%> <%=chkiif(date()="2015-05-28"," today","")%><% if CStr(evt_code) = CStr(evt_code3) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code3 %>" target="_top">INSTAX</a>
			</span>
		</li>

		<li class="brand04<%=chkiif(date()>="2015-05-29"," open","")%> <%=chkiif(date()="2015-05-29"," today","")%><% if CStr(evt_code) = CStr(evt_code4) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code4 %>" target="_top">MONOPOLY</a>
			</span>
		</li>

		<li class="brand05<%=chkiif(date()>="2015-06-01"," open","")%> <%=chkiif(date()="2015-06-01"," today","")%><% if CStr(evt_code) = CStr(evt_code5) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code5 %>" target="_top">LAUNDRY.MAT</a>
			</span>
		</li>

		<li class="brand06<%=chkiif(date()>="2015-06-02"," open","")%> <%=chkiif(date()="2015-06-02"," today","")%><% if CStr(evt_code) = CStr(evt_code6) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code6 %>" target="_top">I THINK SO</a>
			</span>
		</li>

		<li class="brand07<%=chkiif(date()>="2015-06-03"," open","")%> <%=chkiif(date()="2015-06-03"," today","")%><% if CStr(evt_code) = CStr(evt_code7) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code7 %>" target="_top">TEVA</a>
			</span>
		</li>

		<li class="brand08<%=chkiif(date()>="2015-06-04"," open","")%> <%=chkiif(date()="2015-06-04"," today","")%><% if CStr(evt_code) = CStr(evt_code8) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code8 %>" target="_top">MORIDAIN</a>
			</span>
		</li>

		<li class="brand09<%=chkiif(date()>="2015-06-05"," open","")%> <%=chkiif(date()="2015-06-05"," today","")%><% if CStr(evt_code) = CStr(evt_code9) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code9 %>" target="_top">PLAYMOBIL</a>
			</span>
		</li>

		<li class="brand10<%=chkiif(date()>="2015-06-08"," open","")%> <%=chkiif(date()="2015-06-08"," today","")%><% if CStr(evt_code) = CStr(evt_code10) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code10 %>" target="_top">ICONIC</a>
			</span>
		</li>

		<li class="brand11<%=chkiif(date()>="2015-06-09"," open","")%> <%=chkiif(date()="2015-06-09"," today","")%><% if CStr(evt_code) = CStr(evt_code11) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code11 %>" target="_top">IRIVER</a>
			</span>
		</li>

		<li class="brand12<%=chkiif(date()>="2015-06-10"," open","")%> <%=chkiif(date()="2015-06-10"," today","")%><% if CStr(evt_code) = CStr(evt_code12) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code12 %>" target="_top">KOKACHARM</a>
			</span>
		</li>

		<li class="brand13<%=chkiif(date()>="2015-06-11"," open","")%> <%=chkiif(date()="2015-06-11"," today","")%><% if CStr(evt_code) = CStr(evt_code13) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code13 %>" target="_top">TATTLY</a>
			</span>
		</li>

		<li class="brand14<%=chkiif(date()>="2015-06-12"," open","")%> <%=chkiif(date()="2015-06-12"," today","")%><% if CStr(evt_code) = CStr(evt_code14) then response.write " current" %>">
			<span>
				<a href="/event/eventmain.asp?eventid=<%= evt_code14 %>" target="_top">MARTHA IN THE GARRET</a>
			</span>
		</li>
	</ul>
</div>
<!--// iframe -->
</body>
</html>