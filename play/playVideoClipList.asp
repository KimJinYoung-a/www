<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
'#############################################
' 비디오클립 리스트 - 이종화
' 2013-09-14
'#############################################
	strPageTitle = "텐바이텐 10X10 : 비디오클립"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Dim CurrPage , oVideoClip , i
	Dim playcode : playcode = 6 '메뉴상단 번호를 지정 해주세요
	Dim pagesize : pagesize = 12
	CurrPage = getNumeric(requestCheckVar(request("cpg"),8))

	if CurrPage = "" then CurrPage = 1

	'//스타일 플러스 리스트
	set oVideoClip = new CPlayContents
		oVideoClip.FPageSize = pagesize
		oVideoClip.FCurrPage = CurrPage
		oVideoClip.Fplaycode = playcode
		oVideoClip.Fuserid = GetLoginUserID
		oVideoClip.fnGetVideoClipList()

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('img').load(function(){
			$(".videoList").masonry({
				itemSelector: '.box'
			});
		});
		$(".videoList").masonry({
			itemSelector: '.box'
		});
	});
	function jsGoPage(p){
		location.href = "/play/playVideoClipList.asp?cpg="+p+"";
	}
</script>
</head>
<body>
<div class="wrap playWrapV15" id="playSub">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- #include virtual="/lib/inc/incPlayHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="playTit">
				<h2 class="ftLt" style="margin-bottom:-8px;"><a href="/play/playVideoClipList.asp"><img src="http://fiximage.10x10.co.kr/web2013/play/tit_video.gif" alt="Video clip" /></a></h2>
			</div>
			<% if oVideoClip.FresultCount > 0 then %>
			<div class="videoList">
				<% for i=0 to oVideoClip.FresultCount-1 %>
				<div class="box">
					<p class="styleNo">No.<%=oVideoClip.FItemList(i).Fviewno%></p>
					<p><a href="/play/playVideoClip.asp?idx=<%=oVideoClip.FItemList(i).Fidx%>&viewno=<%=oVideoClip.FItemList(i).Fviewno%>"><img src="<%=oVideoClip.FItemList(i).Flistimg%>" alt="<%=oVideoClip.FItemList(i).Fviewtitle%>" /></a></p>
					<div class="favoriteWrap"><div id="mywish<%=oVideoClip.FItemList(i).Fidx%>" class="favoriteAct <%=chkiif(oVideoClip.FItemList(i).Fchkfav > 0 ,"myFavor","")%>" <% If GetLoginUserID <> "" Then %>onclick="TnAddPlaymywish('<%=playcode%>','<%= oVideoClip.FItemList(i).Fidx %>','');"<% Else %>onclick="jsChklogin();"<% End If %>><strong><%= FormatNumber(oVideoClip.FItemList(i).Ffavcnt,0) %></strong></div></div>
				</div>
				<% Next %>
			</div>
			<% End If %>

			<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(CurrPage,oVideoClip.FTotalCount,PageSize,10,"jsGoPage") %></div>
			<div id="tempdiv" style="display:none" ></div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
	Set oVideoClip = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->