<% Response.Addheader "P3P","policyref=""/w3c/p3p.xml"", CP=""CONi NOI DSP LAW NID PHY ONL OUR IND COM"""%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<%
	'세션 UTF-8 지정
	Session.CodePage = "65001"

	'# 현재 포함된 페이지명 접수
	dim nowViewPage, splTemp
	splTemp = Split(request.ServerVariables("SCRIPT_NAME"),"/")
	nowViewPage = splTemp(Ubound(splTemp))


	'####### .js 파일 연동시 사용 - CC_currentyyyymmdd=V_CURRENTYYYYMM 변수로 .js에서 해당 날짜 이미지/링크등 뿌려줌
	dim CC_currentyyyymmdd
	On Error Resume Next
	CC_currentyyyymmdd=request("yyyymmdd")
	On Error Goto 0
	if CC_currentyyyymmdd="" then CC_currentyyyymmdd = Left(now(),10)
	'#########################################################################

	'// 페이지 환경 변수
	Dim strPageTitle, strPageDesc, strPageUrl, strHeaderAddMetaTag, strPageImage
	Dim strRecoPickMeta		'RecoPick환경변수

	if strPageTitle="" then strPageTitle = "텐바이텐 10X10 : 감성채널 감성에너지"
	if strPageDesc="" then strPageDesc = "생활감성채널 10x10(텐바이텐)은 디자인소품, 아이디어상품, 독특한 인테리어 및 패션 상품 등으로 고객에게 즐거운 경험을 주는 디자인전문 쇼핑몰 입니다."

	'######################### B2B ###############################
    Dim b2bCurrentPage : b2bCurrentPage = Request.ServerVariables("HTTP_URL")

    '// B2B User 여부
	Dim isBizUser : isBizUser = chkiif(GetLoginUserLevel="7" OR (GetLoginUserLevel="9" AND Session("ssnuserbizconfirm")="Y"), "Y", "N")
	'// 인덱스로 이동했다면 비즈모드 쿠키 만료시킴
	If b2bCurrentPage = "/" OR b2bCurrentPage = "/index.asp" Then
		response.Cookies("bizMode").domain = "10x10.co.kr"
		response.cookies("bizMode") = ""
		response.Cookies("bizMode").Expires = Date - 1

	'// b2b경로로 들어왔지만 쿠키가 없거나 값이 N이라면 Y값으로 쿠키 생성
	ElseIf LEFT(b2bCurrentPage, 4) = "/biz" And request.cookies("bizMode") <> "Y" Then
		Response.Cookies("bizMode").domain = "10x10.co.kr"
    	Response.Cookies("bizMode") = "Y"
	End If

	'// 현재 B2B모드인지 여부
	Dim bizCookie : bizCookie = request.cookies("bizMode")
	Dim isBizMode : isBizMode = chkiif(bizCookie="Y", "Y", "N")
    '#############################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="description" content="<%=strPageDesc%>" />
	<meta name="keywords" content="커플, 선물, 커플선물, 감성디자인, 디자인, 아이디어상품, 디자인용품, 판촉, 스타일, 10x10, 텐바이텐, 큐브" />
	<meta name="classification" content="비즈니스와 경제, 쇼핑과 서비스(B2C, C2C), 선물, 특별상품" />
	<meta name="application-name" content="텐바이텐" />
	<meta name="msapplication-task" content="name=텐바이텐;action-uri=http://www.10x10.co.kr/;icon-uri=/icons/10x10_140616.ico" />
	<meta name="msapplication-tooltip" content="생활감성채널 텐바이텐" />
	<meta name="msapplication-navbutton-color" content="#FFFFFF" />
	<meta name="msapplication-TileImage" content="/lib/ico/mstileLogo144.png"/>
	<meta name="msapplication-TileColor" content="#c91314"/>
	<meta name="msapplication-starturl" content="<%=wwwUrl%>/" />
	<%=strHeaderAddMetaTag%>
	<link rel="SHORTCUT ICON" href="/fiximage/icons/10x10_140616.ico" />
	<link rel="apple-touch-icon" href="/lib/ico/10x10TouchIcon_150303.png" />
	<link rel="search" type="application/opensearchdescription+xml" href="<%=wwwUrl%>/lib/util/10x10_brws_search.xml" title="텐바이텐 상품검색" />
	<link rel="alternate" type="application/rss+xml" href="<%=wwwUrl%>/shoppingtoday/shoppingchance_rss.asp" title="텐바이텐 신상품소식 구독" />
	<link rel="alternate" type="application/rss+xml" href="<%=wwwUrl%>/just1day/just1day_rss.asp" title="텐바이텐 Just 1Day 구독" />
	<link rel="alternate" type="application/rss+xml" href="http://www.thefingers.co.kr/lecture/lecture_rss.xml" title="더핑거스 새로운 강좌 구독" />
	<title><%=strPageTitle%></title>
	<link rel="stylesheet" type="text/css" href="/lib/css/default.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/common.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/content.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/mytenten.css" />
	<!--[if IE]>
		<link rel="stylesheet" type="text/css" href="/lib/css/preVst/ie.css" />
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="/lib/css/commonV15.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/productV15.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/mytentenV15.css" />
	<!--[if lt IE 9]>
		<script src="/lib/js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
	<script type="text/javascript" src="/lib/js/swiper-2.1.min.js"></script>
	<script type="text/javascript" src="/lib/js/common.js"></script>
	<script type="text/javascript" src="/lib/js/tenbytencommon.js?v=1.0"></script>

