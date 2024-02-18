<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- INCLUDE Virtual="/lib/chkDevice.asp" -->

<%
dim currentdate
	currentdate = date()
	'currentdate = "2015-03-09"
	
	'response.write currentdate
%>
<style type="text/css">
body {background-color:transparent;}
.monthly {position:relative; height:28px; padding-left:84px;}
.monthly strong {position:absolute; top:0; left:12px;}
.monthly ul {overflow:hidden;}
.monthly ul li {float:left; height:28px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68295/bg_monthly.png) no-repeat 0 0;}
.monthly ul li span {display:block; width:100%; height:100%; text-indent:-999em;}
.monthly ul li a {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68295/bg_monthly.png) no-repeat 0 0; transition:.1s ease;}
.monthly ul li.jan {width:38px; background-position:0 0; background:none;}
.monthly ul li.jan a {background-position:0 -28px;}
.monthly ul li.jan a:hover, .monthly ul li.jan a.on {background-position:0 100%;}
.monthly ul li.feb {width:51px; background-position:-38px 0; background:none;}
.monthly ul li.feb a {background-position:-38px -28px;}
.monthly ul li.feb a:hover, .monthly ul li.feb a.on {background-position:-38px 100%;}
.monthly ul li.mar {width:51px; background-position:-89px 0; background:none;}
.monthly ul li.mar a {background-position:-89px -28px;}
.monthly ul li.mar a:hover, .monthly ul li.mar a.on {background-position:-89px 100%;}
.monthly ul li.apr {width:52px; background-position:-140px 0; background:none;}
.monthly ul li.apr a {background-position:-140px -28px;}
.monthly ul li.apr a:hover, .monthly ul li.apr a.on {background-position:-140px 100%;}
.monthly ul li.may {width:53px; background-position:-192px 0; background:none;}
.monthly ul li.may a {background-position:-192px -28px;}
.monthly ul li.may a:hover, .monthly ul li.may a.on {background-position:-192px 100%;}
.monthly ul li.jun {width:51px; background-position:-245px 0;}
.monthly ul li.jun a {background-position:-245px -28px;}
.monthly ul li.jun a:hover, .monthly ul li.jun a.on {background-position:-245px 100%;}
.monthly ul li.jul {width:52px; background-position:-296px 0;}
.monthly ul li.jul a {background-position:-296px -28px;}
.monthly ul li.jul a:hover, .monthly ul li.jul a.on {background-position:-296px 100%;}
.monthly ul li.aug {width:51px; background-position:-348px 0;}
.monthly ul li.aug a {background-position:-348px -28px;}
.monthly ul li.aug a:hover, .monthly ul li.aug a.on {background-position:-348px 100%;}
.monthly ul li.sep {width:52px; background-position:-398px 0;}
.monthly ul li.sep a {background-position:-398px -28px;}
.monthly ul li.sep a:hover, .monthly ul li.sep a.on {background-position:-398px 100%;}

.monthly ul li.oct {width:50px; background-position:-450px 0;}
.monthly ul li.oct a {background-position:-450px -28px;}
.monthly ul li.oct a:hover, .monthly ul li.oct a.on {background-position:-450px 100%;}

.monthly ul li.nov {width:48px; background-position:-500px 0;}
.monthly ul li.nov a {background-position:-500px -28px;}
.monthly ul li.nov a:hover, .monthly ul li.nov a.on {background-position:-500px 100%;}

.monthly ul li.dec {width:41px; background-position:-548px 0;}
.monthly ul li.dec a {background-position:-548px -28px;}
.monthly ul li.dec a:hover, .monthly ul li.dec a.on {background-position:-548px 100%;}

<% If Request("eventid") = 68295 Then		'### 1월 %>
	.monthly ul li {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68295/bg_monthly.png);}
	.monthly ul li span a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68295/bg_monthly.png);}
<% ElseIf Request("eventid") = 68812 Then		'### 2월 %>
	.monthly ul li {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
	.monthly ul li span a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
<% ElseIf Request("eventid") = 69868 Then		'### 4월 %>
	.monthly ul li {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
	.monthly ul li span a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
<% ElseIf Request("eventid") = 70301 Then		'### 5월 %>
	.monthly ul li {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
	.monthly ul li span a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
<% ElseIf Request("eventid") = 71551 Then		'### 7월 %>
	.monthly ul li {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
	.monthly ul li span a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
<% ElseIf Request("eventid") = 72168 Then		'### 8월 %>
	.monthly ul li {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72168/bg_monthly.png);}
	.monthly ul li span a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72168/bg_monthly.png);}
<% ElseIf Request("eventid") = 72886 Then		'### 9월 %>
	.monthly ul li {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
	.monthly ul li span a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
<% ElseIf Request("eventid") = 73361 Then		'### 10월 %>
	.monthly ul li {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
	.monthly ul li span a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/68812/bg_monthly.png);}
<% End If %>
</style>
</head>
<body>
	<div class="monthly">
		<strong><img src="http://webimage.10x10.co.kr/eventIMG/2015/68295/txt_year.png" alt="2016" /></strong>
		<ul>
			<!-- for dev msg : <a href="">....</a> 생성한후 a에 현재 보고 있는 탭에 클래스 on 붙여주세요 -->
			<li class="jan"><span><a href="/event/eventmain.asp?eventid=68295" target="_top" <% If Request("eventid") = "68295" Then %>class="on"<% End If %>>1월</a></span></li>
			
			<% If currentdate < "2016-02-03" then %>
				<li class="feb"><span>2월</span></li>
			<% Else %>
				<li class="feb"><span><a href="/event/eventmain.asp?eventid=68812" target="_top" <% If Request("eventid") = "68812" Then %>class="on"<% End If %>>2월</a></span></li>
			<% End If %>
			
			<% if currentdate < "2016-03-09" then %>
				<li class="mar"><span>3월</span></li>
			<% Else %>
				<li class="mar"><span><a href="/event/eventmain.asp?eventid=69172" target="_top" <% If Request("eventid") = "69172" Then %>class="on"<% End If %>>3월</a></span></li>
			<% End If %>
			
			<% if currentdate < "2016-04-06" then %>
				<li class="apr"><span>4월</span></li>
			<% Else %>
				<li class="apr"><span><a href="/event/eventmain.asp?eventid=69868" target="_top" <% If Request("eventid") = "69868" Then %>class="on"<% End If %>>4월</a></span></li>
			<% End If %>

			<% if currentdate < "2016-05-04" then %>
				<li class="may"><span>5월</span></li>
			<% Else %>
				<li class="may"><span><a href="/event/eventmain.asp?eventid=70301" target="_top" <% If Request("eventid") = "70301" Then %>class="on"<% End If %>>5월</a></span></li>
			<% End If %>

			<% if currentdate < "2016-06-01" then %>
				<li class="jun"><span>6월</span></li>
			<% Else %>
				<li class="jun"><span><a href="/event/eventmain.asp?eventid=70821" target="_top" <% If Request("eventid") = "70821" Then %>class="on"<% End If %>>6월</a></span></li>
			<% End If %>

			<% if currentdate < "2016-07-06" then %>
				<li class="jul"><span>7월</span></li>
			<% Else %>
				<li class="jul"><span><a href="/event/eventmain.asp?eventid=71551" target="_top" <% If Request("eventid") = "71551" Then %>class="on"<% End If %>>7월</a></span></li>
			<% End If %>

			<% if currentdate < "2016-08-03" then %>
				<li class="aug"><span>8월</span></li>
			<% Else %>
				<li class="aug"><span><a href="/event/eventmain.asp?eventid=72168" target="_top" <% If Request("eventid") = "72168" Then %>class="on"<% End If %>>8월</a></span></li>
			<% End If %>

			<% if currentdate < "2016-09-07" then %>
				<li class="sep"><span>9월</span></li>
			<% Else %>
				<li class="sep"><span><a href="/event/eventmain.asp?eventid=72886" target="_top" <% If Request("eventid") = "72886" Then %>class="on"<% End If %>>9월</a></span></li>
			<% End If %>

			<% if currentdate < "2016-10-05" then %>
				<li class="oct"><span>10월</span></li>
			<% Else %>
				<li class="oct"><span><a href="/event/eventmain.asp?eventid=73361" target="_top" <% If Request("eventid") = "73361" Then %>class="on"<% End If %>>10월</a></span></li>
			<% End If %>

			<% if currentdate < "2016-11-02" then %>
				<li class="nov"><span>11월</span></li>
			<% Else %>
				<li class="nov"><span><a href="/event/eventmain.asp?eventid=73952" target="_top" <% If Request("eventid") = "73952" Then %>class="on"<% End If %>>11월</a></span></li>
			<% End If %>

			<% if currentdate < "2016-11-30" then %>
				<li class="dec"><span>12월</span></li>
			<% Else %>
				<li class="dec"><span><a href="/event/eventmain.asp?eventid=74649" target="_top" <% If Request("eventid") = "74649" Then %>class="on"<% End If %>>12월</a></span></li>
			<% End If %>
		</ul>
	</div>
</body>
</html>