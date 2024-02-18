<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2021-02-19"
    'response.write currentdate
    
    Dim vEventID
	vEventID = requestCheckVar(Request("eventid"),9)
%>
<style type="text/css">
.navigator {background:#fff;}
.navigator ul {display:flex; width:1050px; margin:0 auto; padding-left:5px;}
.navigator li { width:170px; height:47px; margin:23px 5px 0 0; text-align:center;}
.navigator li.open {width:181px; height:70px; margin-top:0;}
.navigator li span,
.navigator li a {display:block; height:100%; font-size:18px; line-height:48px; color:#a5a5a5; font-weight:300; background:#dfdfdf; border-radius:36px 36px 0 0;}
.navigator li a {padding-top:9px; color:#000; font-weight:400; font-size:21px; line-height:1.3; background:#ffdd4a; text-decoration:none;}
.navigator li.current a {background:#ffb739;}
.navigator li strong {display:block; font-size:18px; font-weight:700;}
</style>
<script type="text/javascript">
$(function(){
	$('.navigator .coming').on('click', function(e){
		e.preventDefault();
		alert("오픈 예정 기획전 입니다 :)");
	});
});
</script>
</head>
<body>
<div id="navigator" class="navigator">
    <ul>
        <li class="open  <%=CHKIIF(vEventID="102525","current","")%>"><a href="/event/eventmain.asp?eventid=102525" target="_top">1st<strong>마스킹테이프</strong></a></li>

        <% if currentdate < "2020-05-25" then %>
        <li class="coming"><span>coming soon</span>
        <% Else %>
        <li class="open <%=CHKIIF(vEventID="102930"," current","")%>">
        <% End If %>
            <a href="/event/eventmain.asp?eventid=102930" target="_top">2nd<strong>피너츠엽서</strong></a>
        </li>

        <% if currentdate < "2020-06-02" then %>
        <li class="coming"><span>coming soon</span>
        <% Else %>
        <li class="open <%=CHKIIF(vEventID="103082"," current","")%>">
        <% End If %>
            <a href="/event/eventmain.asp?eventid=103082" target="_top">3rd<strong>디즈니 스티키노트</strong></a>
        </li>

        <% if currentdate < "2020-06-09" then %>
        <li class="coming"><span>coming soon</span>
        <% Else %>
        <li class="open <%=CHKIIF(vEventID="103180"," current","")%>">
        <% End If %>
            <a href="/event/eventmain.asp?eventid=103180" target="_top">4th<strong>코믹스 스티커</strong></a>
        </li>

        <% if currentdate < "2021-02-19" then %>
        <li class="coming"><span>coming soon</span>
        <% Else %>
        <li class="open <%=CHKIIF(vEventID="000000"," current","")%>">
        <% End If %>
            <a href="/event/eventmain.asp?eventid=000000" target="_top"></a>
        </li>

        <% if currentdate < "2021-02-19" then %>
        <li class="coming"><span>coming soon</span>
        <% Else %>
        <li class="open <%=CHKIIF(vEventID="000000"," current","")%>">
        <% End If %>
            <a href="/event/eventmain.asp?eventid=000000" target="_top"></a>
        </li>
    </ul>
</div>
</body>
</html>