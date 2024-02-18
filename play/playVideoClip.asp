<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
'#############################################
' 비디오클립 상세 - 이종화
' 2013-09-14
'#############################################
	strPageTitle = "텐바이텐 10X10 : 비디오클립"

%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Dim idx , oVideoClip , viewno , i , ii , oVideoClipItem
	Dim playcode : playcode = 6 '메뉴상단 번호를 지정 해주세요
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg

	idx = getNumeric(requestCheckVar(request("idx"),8))
	viewno = getNumeric(requestCheckVar(request("viewno"),8))

	If idx = "" Then
		Call Alert_Return("올바른 접근이 아닙니다.")
		dbget.close(): Response.End
	End If

	set oVideoClip = new CPlayContents
		oVideoClip.FRectviewno = viewno
		oVideoClip.FRectIdx = idx
		oVideoClip.Fplaycode = playcode
		oVideoClip.Fuserid = GetLoginUserID
		oVideoClip.GetOneRowVideoClipContent() '1row
		oVideoClip.GetRowTagContent() ' taglist

		snpTitle = Server.URLEncode("No."&oVideoClip.FOneItem.Fviewno&" "&oVideoClip.FOneItem.Fviewtitle)
		snpLink = Server.URLEncode("http://10x10.co.kr/play/playVideoClip.asp?idx=" & idx&"&viewno="& viewno &"")
		snpPre = Server.URLEncode("텐바이텐 비디오클립")
		snpTag = Server.URLEncode("텐바이텐 " & Replace("#"&oVideoClip.FOneItem.Fviewno&" "&oVideoClip.FOneItem.Fviewtitle," ",""))
		snpTag2 = Server.URLEncode("#10x10")
		snpImg = Server.URLEncode(oVideoClip.FOneItem.Flistimg)

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script>
<!--
// -- iframe z-index 문제 해결 JQUERY
    $(document).ready(function() {
		$("iframe").each(function() {
			var ifr_source = $(this).attr('src');
			var wmode = "wmode=transparent";
				if(ifr_source.indexOf('?') != -1) {
					var getQString = ifr_source.split('?');
					var oldString = getQString[1];
					var newString = getQString[0];
					$(this).attr('src',newString+'?'+wmode+'&'+oldString);
				}
				else $(this).attr('src',ifr_source+'?'+wmode);
		});
});
//-->
</script>
</head>
<body>
<div class="wrap playWrapV15" id="playSub">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- #include virtual="/lib/inc/incPlayHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="playTit">
				<h2 class="ftLt" style="margin-bottom:-8px;"><a href="/play/playVideoClipList.asp"><img src="http://fiximage.10x10.co.kr/web2013/play/tit_video.gif" alt="Video Clip" /></a></h2>
				<a href="/play/playVideoClipList.asp" class="btnListView">리스트 보기</a>
			</div>

			<div class="videoWrap">
				<div class="snsArea">
					<strong class="ftLt tPad03 lPad10 crWhite fs13">No. <%=oVideoClip.FOneItem.Fviewno%></strong>
					<div class="sns rPad10">
						<ul>
							<!-- <li><a href="" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li> -->
							<li><a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
							<li><a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
							<li><a href="" onClick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
						</ul>
						<div id="mywish<%=idx%>" class="favoriteAct <%=chkiif(oVideoClip.FOneItem.Fchkfav > 0 ,"myFavor","")%>" <% If GetLoginUserID <> "" Then %>onclick="TnAddPlaymywish('<%=playcode%>','<%= oVideoClip.FOneItem.Fidx %>','');"<% Else %>onclick="jsChklogin();"<% End If %>><strong><%= FormatNumber(oVideoClip.FOneItem.Ffavcnt,0) %></strong></div>
					</div>
				</div>
				<div class="videoArea"><%=oVideoClip.FOneItem.Fvideourl%></div>
				<dl class="videoCont tPad25">
					<dt>
						<strong><%=oVideoClip.FOneItem.Fviewtitle%></strong>
						<span><%=FormatDate(oVideoClip.FOneItem.Fregdate,"0000.00.00")%></span>
					</dt>
					<dd><%=nl2br(oVideoClip.FOneItem.Fviewtext)%></dd>
				</dl>
				<dl class="tagView tMar55">
					<% If oVideoClip.FTotalCount > 0 Then %>
					<dt class="ftLt">Tag</dt>
					<dd class="ftLt">
						<ul>
							<% For i = 0 To oVideoClip.FTotalCount -1 %>
							<li><span><a href="<%=chkiif(oVideoClip.FItemList(i).Ftagurl="","/search/search_result.asp?rect="&oVideoClip.FItemList(i).Ftagname&"",oVideoClip.FItemList(i).Ftagurl)%>"><%=oVideoClip.FItemList(i).Ftagname%></a></span></li>
							<% Next %>
						</ul>
					</dd>
					<% End If %>
				</dl>
			</div>
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