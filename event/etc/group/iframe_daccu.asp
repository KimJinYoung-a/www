<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2019-12-02"
	'response.write currentdate

	Dim vEventID
	vEventID = requestCheckVar(Request("eventid"),9)
%>
<style type="text/css">
.navigator {height:514px; text-align:center; border-top:16px solid #ff5555; background:#ffec4d;}
.navigator img {vertical-align:top;}
.navigator h2 {padding:72px 0 53px;}
.navigator ul {display:flex; width:960px; margin:0 auto;}
.navigator li {width:25%;}
</style>
<script type="text/javascript">
$(function(){
	$('.navigator .coming').on('click', function(e){
		e.preventDefault();
		alert("오픈 예정 기획전 입니다.");
	});
});
</script>
</head>
<body>
<div id="navigator" class="navigator">
	<h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/103179/tit_collection.png" alt="이달의 데꾸데리어"></h2>
	<ul>
        <li><a href="/event/eventmain.asp?eventid=102526" target="_top"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103179/tab_vol1.png" alt="vol1.메모지"></a></li>
        
        <% if currentdate < "2020-06-10" then %>
        <li><span><img src="//webimage.10x10.co.kr/fixevent/event/2020/103179/tab_coming_vol2.png" alt="vol2"></span>
        <% Else %>
        <li><a href="/event/eventmain.asp?eventid=103179" target="_top"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103179/tab_vol2.png" alt="vol2. 잇아이템"></a>
        <% End If %>
        </li>

        <% if currentdate < "2021-07-04" then %>
        <li><span><img src="//webimage.10x10.co.kr/fixevent/event/2020/103179/tab_coming_vol3.png" alt="vol3"></span>
        <% Else %>
        <li><a href="/event/eventmain.asp?eventid=000000" target="_top"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103179/tab_vol3.png" alt="vol3"></a>
        <% End If %>
        </li>

        <% if currentdate < "2021-08-04" then %>
        <li><span><img src="//webimage.10x10.co.kr/fixevent/event/2020/103179/tab_coming_vol4.png" alt="vol4"></span>
        <% Else %>
        <li><a href="/event/eventmain.asp?eventid=000000" target="_top"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103179/tab_vol4.png" alt="vol4"></a>
        <% End If %>
        </li>
    </ul>
</div>
</body>
</html>