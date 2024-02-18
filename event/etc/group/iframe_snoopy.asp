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
	If vEventID = "101577" Then '// 봄
		vStartNo = "0"
	ElseIf vEventID = "" Then '// 여름
		vStartNo = "0"
	ElseIf vEventID = "" Then '// 가을
		vStartNo = "1"
	ElseIf vEventID = "" Then '// 겨울
		vStartNo = "2"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigator {width:1040px; margin:0 auto; text-align:center;}
.navigator h2 {padding:68px 0 64px;}
.navigator ul {display:flex; width:1036px; margin:0 auto; background:url(//webimage.10x10.co.kr/fixevent/event/2020/101577/bg_soon.png?v=2) 0 0 repeat-x;}
.navigator li {position:relative; width:179px; height:228px; margin:0 40px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/101577/txt_season.png) 0 100% no-repeat;}
.navigator li a {display:block; width:100%; height:100%; font-size:0; background-position:50% 0; background-repeat:no-repeat;}
.navigator li:nth-child(2) {background-position:-179px 100%;}
.navigator li:nth-child(3) {background-position:-358px 100%;}
.navigator li:nth-child(4) {background-position:100% 100%;}
.navigator li:nth-child(1).current a {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/101577/img_spring.jpg);}
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
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/101577/tit_meet.png" alt="계절이 바뀌면 찾아오는, 월간 스누피를 만나보세요."></h2>
        <ul>
            <%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
            <% if currentdate < "2020-03-27" then %>
            <li class="coming">
            <% Else %>
            <li class="open <%=CHKIIF(vEventID="101577"," current","")%>">
            <% End If %>
                <a href="/event/eventmain.asp?eventid=101577" target="_top">봄</a>
            </li>
    
            <% if currentdate < "2022-03-26" then %>
            <li class="coming">
            <% Else %>
            <li class="open <%=CHKIIF(vEventID="000"," current","")%>">
            <% End If %>
                <a href="/event/eventmain.asp?eventid=000" target="_top">여름</a>
            </li>
    
            <% if currentdate < "2022-01-01" then %>
            <li class="coming">
            <% Else %>
            <li class="open <%=CHKIIF(vEventID="000"," current","")%>">
            <% End If %>
                <a href="/event/eventmain.asp?eventid=000" target="_top">가을</a>
            </li>
    
            <% if currentdate < "2022-01-01" then %>
            <li class="coming">
            <% Else %>
            <li class="open <%=CHKIIF(vEventID="000"," current","")%>">
            <% End If %>
                <a href="/event/eventmain.asp?eventid=000" target="_top">겨울</a>
            </li>
    
        </ul>
    </div>
</body>
</html>