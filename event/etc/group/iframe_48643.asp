<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  이벤트코드 48643 Furniture magazine 시리즈
' History : 2014.02.14 이종화 생성
'			2014.02.18 한용민 수정(2차추가)
'			2014.03.21 유태욱 수정(3차추가)
'			2014.04.25 유태욱 수정(4차추가)
'			2014.05.30 유태욱 수정(5차추가)
'			2014.08.08 유태욱 수정(6차추가)
'			2014.09.19 유태욱 수정(7차추가)
'			2014.11.11 유태욱 수정(8차추가)
'####################################################

dim evt_code1, evt_code2, evt_code3, evt_code4, evt_code5, evt_code6, evt_code7, evt_code8, evt_code9,  evt_code10, evt_code11, evt_code12, evt_code13, evt_code14, evt_code15, evt_code16, evt_code17, evt_code18, evt_code19, evt_code20, evt_code21, evt_code22, evt_code23, evt_code24, evt_code25, evt_code26, evt_code27, evt_code28, evt_code29, evt_code30, evt_code31, evt_code32, evt_code33, evt_code34, evt_code35, evt_code36, evt_code37, evt_code38, evt_code39,evt_code40,evt_code41,evt_code42, evt_code43, evt_code44, evt_code45, evt_code46
	IF application("Svr_Info") = "Dev" THEN
		evt_code1 = 21088
		evt_code2 = 21089
		evt_code3 = 21118
		evt_code4 = 21158
		evt_code5 = 21191
		evt_code6 = 21261
		evt_code7 = 21304
		evt_code8 = 21304
		evt_code9 = 59794
		evt_code10 = 61714
		evt_code11 = 62833
		evt_code12 = 64100
		evt_code13 = 64913
		evt_code14 = 65570
		evt_code15 = 66209
		evt_code16 = 67565
		evt_code17 = 68137
		evt_code18 = 68735
		evt_code19 = 69170
		evt_code20 = 69785
		evt_code21 = 70287
		evt_code22 = 70815
		evt_code23 = 71344
		evt_code24 = 71803
		evt_code25 = 72477
		evt_code26 = 73177
		evt_code27 = 73178
		evt_code28 = 74021
		evt_code29 = 74700
		evt_code30 = 75409
		evt_code31 = 76103
		evt_code32 = 76287
		evt_code33 = 77045
		evt_code34 = 77719
		evt_code35 = 78205
		evt_code36 = 78793
		evt_code37 = 79552
		evt_code38 = 80336
		evt_code39 = 81225
		evt_code40 = 82035
		evt_code41 = 83005
		evt_code42 = 83570
		evt_code43 = 84478
		evt_code44 = 86034
		evt_code45 = 87686
		evt_code46 = 88386
	Else
		evt_code1 = 48643
		evt_code2 = 49523
		evt_code3 = 50233
		evt_code4 = 51321
		evt_code5 = 52253
		evt_code6 = 54087
		evt_code7 = 54770
		evt_code8 = 56395
		evt_code9 = 59794
		evt_code10 = 61714
		evt_code11 = 62833
		evt_code12 = 64100
		evt_code13 = 64913
		evt_code14 = 65570
		evt_code15 = 66209
		evt_code16 = 67565
		evt_code17 = 68137
		evt_code18 = 68735
		evt_code19 = 69170
		evt_code20 = 69785
		evt_code21 = 70287
		evt_code22 = 70815
		evt_code23 = 71344
		evt_code24 = 71803
		evt_code25 = 72477
		evt_code26 = 73177
		evt_code27 = 73178
		evt_code28 = 74021
		evt_code29 = 74700
		evt_code30 = 75409
		evt_code31 = 76103
		evt_code32 = 76287
		evt_code33 = 77045
		evt_code34 = 77719
		evt_code35 = 78205
		evt_code36 = 78793
		evt_code37 = 79552
		evt_code38 = 80336
		evt_code39 = 81225
		evt_code40 = 82035
		evt_code41 = 83005
		evt_code42 = 83570
		evt_code43 = 84478
		evt_code44 = 86034
		evt_code45 = 87686
		evt_code46 = 88386
	End If
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- INCLUDE Virtual="/lib/chkDevice.asp" -->
<style type="text/css">
.evtSelect dd {width:200px; padding:0 0 0 10px;}
.evtSelect dd ul {overflow-y:scroll; height:300px;}
.evtSelect dd li {width:180px;}
</style>
<script type="text/javascript">
$(function(){
	// Design Selectbox
	$(".evtSelect dt").click(function(){
		if($(".evtSelect dd").is(":hidden")){
			$(this).parent().children('dd').show("slide", { direction: "up" }, 300);
			$(this).addClass("over");
		}else{
			$(this).parent().children('dd').hide("slide", { direction: "up" }, 200);
		};
	});
	$(".evtSelect dd li").click(function(){
		var evtName = $(this).text();
		$(".evtSelect dt").removeClass("over");
		$(".evtSelect dd li").removeClass("on");
		$(this).addClass("on");
		$(this).parent().parent().parent().children('dt').children('span').text(evtName);
		$(this).parent().parent().hide("slide", { direction: "up" }, 200);
	});
	$(".evtSelect dd").mouseleave(function(){
		$(this).hide();
		$(".evtSelect dt").removeClass("over");
	});
});

</script>
</head>
<body style="background-color:transparent;">
<dl class="evtSelect">
	<dt><span>Furniture magazine 더보기</span></dt>
	<dd>
		<ul>
			<% if date()>="2018-09-18" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code46 %>" target="_top">Furniture magazine _ vol.46</a></li>
			<% end if %>

			<% if date()>="2018-07-18" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code45 %>" target="_top">Furniture magazine _ vol.45</a></li>
			<% end if %>

			<% if date()>="2018-05-09" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code44 %>" target="_top">Furniture magazine _ vol.44</a></li>
			<% end if %>

			<% if date()>="2018-02-26" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code43 %>" target="_top">Furniture magazine _ vol.43</a></li>
			<% end if %>

			<% if date()>="2018-01-17" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code42 %>" target="_top">Furniture magazine _ vol.42</a></li>
			<% end if %>

			<% if date()>="2017-12-25" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code41 %>" target="_top">Furniture magazine _ vol.41</a></li>
			<% end if %>

			<% if date()>="2017-11-29" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code40 %>" target="_top">Furniture magazine _ vol.40</a></li>
			<% end if %>

			<% if date()>="2017-10-30" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code39 %>" target="_top">Furniture magazine _ vol.39</a></li>
			<% end if %>

			<% if date()>="2017-09-19" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code38 %>" target="_top">Furniture magazine _ vol.38</a></li>
			<% end if %>

			<% if date()>="2017-08-09" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code37 %>" target="_top">Furniture magazine _ vol.37</a></li>
			<% end if %>

			<% if date()>="2017-07-10" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code36 %>" target="_top">Furniture magazine _ vol.36</a></li>
			<% end if %>

			<% if date()>="2017-06-21" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code35 %>" target="_top">Furniture magazine _ vol.35</a></li>
			<% end if %>

			<% if date()>="2017-05-10" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code34 %>" target="_top">Furniture magazine _ vol.34</a></li>
			<% end if %>

			<% if date()>="2017-04-11" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code33 %>" target="_top">Furniture magazine _ vol.33</a></li>
			<% end if %>

			<% if date()>="2017-03-08" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code32 %>" target="_top">Furniture magazine _ vol.32</a></li>
			<% end if %>

			<% if date()>="2017-02-22" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code31 %>" target="_top">Furniture magazine _ vol.31</a></li>
			<% end if %>

			<% if date()>="2017-01-18" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code30 %>" target="_top">Furniture magazine _ vol.30</a></li>
			<% end if %>

			<% if date()>="2016-12-14" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code29 %>" target="_top">Furniture magazine _ vol.29</a></li>
			<% end if %>

			<% if date()>="2016-11-07" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code28 %>" target="_top">Furniture magazine _ vol.28</a></li>
			<% end if %>

			<% if date()>="2016-10-26" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code27 %>" target="_top">Furniture magazine _ vol.27</a></li>
			<% end if %>

			<% if date()>="2016-09-28" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code26 %>" target="_top">Furniture magazine _ vol.26</a></li>
			<% end if %>

			<% if date()>="2016-08-24" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code25 %>" target="_top">Furniture magazine _ vol.25</a></li>
			<% end if %>

			<% if date()>="2016-07-27" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code24 %>" target="_top">Furniture magazine _ vol.24</a></li>
			<% end if %>

			<% if date()>="2016-05-23" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code23 %>" target="_top">Furniture magazine _ vol.23</a></li>
			<% end if %>

			<% if date()>="2016-05-23" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code22 %>" target="_top">Furniture magazine _ vol.22</a></li>
			<% end if %>

			<% if date()>="2016-04-20" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code21 %>" target="_top">Furniture magazine _ vol.21</a></li>
			<% end if %>

			<% if date()>="2016-03-23" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code20 %>" target="_top">Furniture magazine _ vol.20</a></li>
			<% end if %>

			<% if date()>="2016-02-24" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code19 %>" target="_top">Furniture magazine _ vol.19</a></li>
			<% end if %>

			<% if date()>="2016-01-25" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code18 %>" target="_top">Furniture magazine _ vol.18</a></li>
			<% end if %>

			<% if date()>="2015-12-16" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code17 %>" target="_top">Furniture magazine _ vol.17</a></li>
			<% end if %>

			<% if date()>="2015-11-25" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code16 %>" target="_top">Furniture magazine _ vol.16</a></li>
			<% end if %>

			<% if date()>="2015-09-21" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code15 %>" target="_top">Furniture magazine _ vol.15</a></li>
			<% end if %>

			<% if date()>="2015-08-19" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code14 %>" target="_top">Furniture magazine _ vol.14</a></li>
			<% end if %>

			<% if date()>="2015-07-22" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code13 %>" target="_top">Furniture magazine _ vol.13</a></li>
			<% end if %>

			<% if date()>="2015-06-29" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code12 %>" target="_top">Furniture magazine _ vol.12</a></li>
			<% end if %>

			<% if date()>="2015-05-27" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code11 %>" target="_top">Furniture magazine _ vol.11</a></li>
			<% end if %>

			<% if date()>="2015-04-27" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code10 %>" target="_top">Furniture magazine _ vol.10</a></li>
			<% end if %>

			<% if date()>="2015-04-23" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code9 %>" target="_top">Furniture magazine _ vol.9</a></li>
			<% end if %>

			<% if date()>="2014-11-11" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code8 %>" target="_top">Furniture magazine _ vol.8</a></li>
			<% end if %>

			<% if date()>="2014-09-19" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code7 %>" target="_top">Furniture magazine _ vol.7</a></li>
			<% end if %>

			<% if date()>="2014-08-08" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code6 %>" target="_top">Furniture magazine _ vol.6</a></li>
			<% end if %>

			<% if date()>="2014-06-01" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code5 %>" target="_top">Furniture magazine _ vol.5</a></li>
			<% end if %>

			<% if date()>="2014-04-28" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code4 %>" target="_top">Furniture magazine _ vol.4</a></li>
			<% end if %>

			<% if date()>="2014-03-24" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code3 %>" target="_top">Furniture magazine _ vol.3</a></li>
			<% end if %>

			<% if date()>="2014-02-19" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code2 %>" target="_top">Furniture magazine _ vol.2</a></li>
			<% end if %>

			<% if date()>="2014-01-17" then %>
				<li><a href="/event/eventmain.asp?eventid=<%= evt_code1 %>" target="_top">Furniture magazine _ vol.1</a></li>
			<% end if %>
		</ul>
	</dd>
</dl>
</body>
</html>