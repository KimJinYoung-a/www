<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2019-12-02"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "102798" Then '// 01
		vStartNo = "0"
	ElseIf vEventID = "103349" Then '// 02
		vStartNo = "0"
	ElseIf vEventID = "104468" Then '// 03
		vStartNo = "0"
	ElseIf vEventID = "105200" Then '// 04
		vStartNo = "1"
	Else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigator {position:relative; display:flex; width:500px; height:42px; padding:0 35px;}
.navigator .menu {width:33.33333%; height:42px; text-align:center; color:#c5c5c5; font-size:17px; line-height:1.1;}
.navigator .menu b {display:block; padding-bottom:6px; font-weight:400;}
.navigator .menu a {color:#c5c5c5; text-decoration:none;}
.navigator .current a {color:#fff;}
.navigator .slick-arrow {width:35px; height:42px; top:0;}
.navigator .slick-arrow:after {content:''; position:absolute; left:50%; top:50%; width:10px; height:10px; margin:-5px 0 0 -5px; border:0; border-top:3px solid #fff; border-left:3px solid #fff; transform:rotate(-45deg);}
.navigator .slick-prev {left:0;}
.navigator .slick-next {right:0; transform:rotate(180deg);}
</style>
<script type="text/javascript">
$(function(){
	$("#navigator").slick({
		slidesToShow:3,
        arrow:true,
		infinite:false,
		initialSlide:<%=vStartNo%>
	});
	 $(".navigator .coming").on('click', function(e){
		e.preventDefault();
		alert("오픈 예정 기획전 입니다 :)");
	});
});
</script>
</head>
<body>
<div id="navigator" class="navigator">
    <div class="menu open<%=CHKIIF(vEventID="102798"," current","")%>"><a href="/event/eventmain.asp?eventid=102798" target="_top"><b>01</b>빌리엔젤</a></div>

    <% if currentdate < "2020-06-15" then %>
    <div class="menu coming"><span><b>02</b>Coming Soon</span>
    <% Else %>
    <div class="menu open<%=CHKIIF(vEventID="103349"," current","")%>">
        <a href="/event/eventmain.asp?eventid=103349" target="_top"><b>02</b>프루터리</a>
    <% End If %>
    </div>

    <% if currentdate < "2020-07-21" then %>
    <div class="menu coming"><span><b>03</b>Coming Soon</span>
    <% Else %>
    <div class="menu open<%=CHKIIF(vEventID="104468"," current","")%>">
        <a href="/event/eventmain.asp?eventid=104468" target="_top"><b>03</b>mtl</a>
    <% End If %>
	</div>
	
	<% if currentdate < "2020-08-19" then %>
    <div class="menu coming"><span><b>04</b>Coming Soon</span>
    <% Else %>
    <div class="menu open<%=CHKIIF(vEventID="105200"," current","")%>">
        <a href="/event/eventmain.asp?eventid=105200" target="_top"><b>04</b>평화다방</a>
    <% End If %>
    </div>
</div>
</body>
</html>