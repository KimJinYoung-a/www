<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/playing/playingCls.asp" -->
<%
	Dim cPl, i, vIsAdmin, vStartDate, vState, vDIdx, vIsMine
	vStartDate = "getdate()"
	vState = "7"
	
	vIsAdmin = RequestCheckVar(request("isadmin"),1)
	If vIsAdmin = "o" Then
		If GetLoginUserLevel() = "7" Then
			vStartDate = "''" & RequestCheckVar(request("sdate"),10) & "''"
			vState = RequestCheckVar(request("state"),1)
		End If
	End If
	
	vDIdx = RequestCheckVar(request("didx"),10)
	
	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/playing/view.asp?didx="&vDIdx
			REsponse.End
		end if
	end if
	
	If vDIdx = "" Then
		Response.Write "<script>alert('잘못된 경로입니다.');top.location.href='/playing/';</script>"
		dbget.close()
		Response.End
	Else
		If Not isNumeric(vDidx) Then
			Response.Write "<script>alert('잘못된 경로입니다.');top.location.href='/playing/';</script>"
			dbget.close()
			Response.End
		End If
	End If
	
	SET cPl = New CPlay
	cPl.FRectDIdx			= vDIdx
	cPl.FRectStartdate 	= vStartDate
	cPl.FRectState 		= vState
	cPl.sbPlayCornerDetail()
	
	If cPl.FResultCount < 1 Then
		Response.Write "<script>alert('없는 코너 번호입니다.');top.location.href='/playing/';</script>"
		dbget.close()
		Response.End
	End If
	
	Dim vCate, vCateName, vTitle, vSubCopy, vContents, vIsExec, vExecFile, vBGColor, vImageList, vItemList, vSquareImg, vRectangleImg, vTitleStyle
	Dim vViewCntW, vViewCntM, vViewCntA, vTagAnnounce, vTagSDate, vTagEDate
	vCate 		= cPl.FOneItem.Fcate
	'vCateName 	= cPl.FOneItem.Fcatename
	vTitle 	= cPl.FOneItem.Ftitle
	vTitleStyle= cPl.FOneItem.Ftitlestyle
	vSubCopy	= cPl.FOneItem.Fsubcopy
	vStartDate	= cPl.FOneItem.Fstartdate
	vContents	= cPl.FOneItem.Fcontents
	vIsExec	= cPl.FOneItem.FisExec
	vExecFile	= cPl.FOneItem.Fexecfile
	vBGColor	= cPl.FOneItem.Fbgcolor
	vViewCntW	= cPl.FOneItem.FViewCnt_W
	vViewCntM	= cPl.FOneItem.FViewCnt_M
	vViewCntA	= cPl.FOneItem.FViewCnt_A
	vTagSDate	= cPl.FOneItem.FtagSDate
	vTagEDate	= cPl.FOneItem.FtagEDate
	vTagAnnounce = cPl.FOneItem.Ftag_announcedate
	
	vImageList 	= cPl.FImgArr
	
	''2017-01-26 유태욱 수정(정사각에서 직사각으로 변경)
	vSquareImg		= fnPlayImageSelect(vImageList,vCate,"1","i")
'	vSquareImg		= fnPlayImageSelect(vImageList,vCate,"11","i")
	vRectangleImg	= fnPlayImageSelect(vImageList,vCate,"1","i")
	
	
	'### 뷰 카운트 w,m,a. 미리보기 체크 X.
	If vIsAdmin <> "o" Then
		If cPl.FOneItem.Fstartdate <= date() Then
			Call fnPlayViewCount(vDIdx,"w")
		End If
	End If
	SET cPl = Nothing

	'### SNS 변수선언
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg, kakaotitle, kakaoimage, kakaoimg_width, kakaoimg_height, kakaolink_url 
	
	'### 다른 코너 보기 변수선언
	Dim clistmore, vListMoreArr, limo

	strPageTitle	= "[텐바이텐 PLAYing] "&vTitle
	strPageUrl		= "http://www.10x10.co.kr/playing/view.asp?didx="&vDIdx
	strPageImage	= vSquareImg
	strPageDesc = "[텐바이텐] PLAYing - 당신의 감성을 플레이하다"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include file="./inc_cssscript.asp" -->
</head>
<body>
<div id="playV16" class="wrap playV16">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<!-- #include file="./headerPlay.asp" -->
			<% If vCate = "1" Then	'### playlist %>
				<!-- #include file="./playlist.asp" -->
			<% ElseIf vCate = "21" OR vCate = "22" Then	'### inspiration design 과 style 같이 사용 %>
				<!-- #include file="./inspiration_design.asp" -->
			<% ElseIf vCate = "3" Then	'### azit %>
				<!-- #include file="./azit.asp" -->
			<%'// 2017.06.01 원승현 azit comma 스타일 추가%>
			<% ElseIf vCate = "31" Then	'### azitCOMMA %>
				<!-- #include file="./azitcomma.asp" -->
			<% ElseIf vCate = "41" Then	'### THING thing %>
				<!-- #include file="./thing.asp" -->
			<% ElseIf vCate = "42" Then	'### THING thingthing %>
				<!-- #include file="./thingthing.asp" -->
			<% ElseIf vCate = "43" Then	'### THING 배경화면 %>
				<!-- #include file="./wallpaper.asp" -->
			<% ElseIf vCate = "5" Then	'### COMMA %>
				<!-- #include file="./comma.asp" -->
			<% ElseIf vCate = "6" Then	'### HOWHOW %>
				<!-- #include file="./howhow.asp" -->
			<% End If %>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->