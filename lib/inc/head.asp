<% Response.Addheader "P3P","policyref=""/w3c/p3p.xml"", CP=""CONi NOI DSP LAW NID PHY ONL OUR IND COM"""%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/inc/incForceSSL_Common.asp" -->
<%
	'세션 UTF-8 지정
	Session.CodePage = "65001"

	'/서버 주기적 업데이트 위한 공사중 처리 '2011.11.11 한용민 생성
	'/리뉴얼시 이전해 주시고 지우지 말아 주세요
	Call serverupdate_underconstruction()

	'공사중 표시(리뉴얼시)
	''Call Underconstruction()

	'# 현재 포함된 페이지명 접수
	dim nowViewPage, splTemp
	splTemp = Split(request.ServerVariables("SCRIPT_NAME"),"/")
	nowViewPage = splTemp(Ubound(splTemp))

	Dim vSavedID
	vSavedID = tenDec(request.cookies("mSave")("SAVED_ID"))

	'####### .js 파일 연동시 사용 - CC_currentyyyymmdd=V_CURRENTYYYYMM 변수로 .js에서 해당 날짜 이미지/링크등 뿌려줌
	dim CC_currentyyyymmdd
	On Error Resume Next
	CC_currentyyyymmdd=request("yyyymmdd")
	On Error Goto 0
	if CC_currentyyyymmdd="" then CC_currentyyyymmdd = Left(now(),10)
	'#########################################################################


	'###### 제휴사 flag 관련 - 주문 저장시/회원가입시  제휴사 Flag 저장 ######
	dim irdsite20, arrRdSite, irdData
	irdsite20 = requestCheckVar(request("rdsite"),32)
	irdData = requestCheckVar(request("rddata"),100)	'기타 전송 데이터 (회원ID,이벤트 번호 등)
	'//파라메터가 겹쳐있는 경우 중복 제거
	if irdsite20<>"" then
		arrRdSite = split(irdsite20,",")
		irdsite20 = arrRdSite(0)
	end if

	if (irdsite20<>"") then
		if (request.cookies("rdsite")<>irdsite20) then
			response.cookies("rdsite").domain = "10x10.co.kr"
			response.cookies("rdsite") = irdsite20
		end if
		if (request.cookies("rddata")<>irdData) then
			response.cookies("rddata") = irdData
		end if
	else
		if request.cookies("rdsite")<>"" then irdsite20=request.cookies("rdsite")
	end if
	
	'#########################################################################

	'// 페이지 환경 변수
	Dim strPageTitle, strPageDesc, strPageUrl, strHeaderAddMetaTag, strPageImage, strPageKeyword
	Dim strRecoPickMeta		'RecoPick환경변수

	if strPageTitle="" then strPageTitle = "텐바이텐 10X10 : 감성채널 감성에너지"
	if strPageDesc="" then strPageDesc = "생활감성채널 10x10(텐바이텐)은 디자인소품, 아이디어상품, 독특한 인테리어 및 패션 상품 등으로 고객에게 즐거운 경험을 주는 디자인전문 쇼핑몰 입니다."

	'// 페이지 검색 키워드
	if strPageKeyword="" Then
		'// 기존 페이지 검색 키워드
		strPageKeyword = "감성디자인, 디자인상품, 아이디어상품, 즐거움, 선물, 문구, 소품, 인테리어, 가구, 가전, 패션, 화장품, 반려동물, 핸드폰케이스, 패브릭, 조명, 식품"

		'// 2018 리뉴얼 페이지 검색 키워드
		strPageKeyword = "커플, 선물, 커플선물, 감성디자인, 디자인, 아이디어상품, 디자인용품, 판촉, 스타일, 10x10, 텐바이텐, 큐브"
	else
		strPageKeyword = "10x10, 텐바이텐, 감성, 디자인, " & strPageKeyword
	end if

	'// Facebook 오픈그래프 메타태그 작성 (필요에 따라 변경요망)
	if strHeaderAddMetaTag = "" then
		strHeaderAddMetaTag = "<meta property=""og:title"" id=""meta_og_title"" content=""" & strPageTitle & """ />" & vbCrLf &_
							"	<meta property=""og:type"" content=""website"" />" & vbCrLf
	end if
	if strPageUrl<>"" then
		strHeaderAddMetaTag = strHeaderAddMetaTag & "	<meta property=""og:url"" content=""" & strPageUrl & """ />" & vbCrLf
	end if
	if Not(strPageImage="" or isNull(strPageImage)) then
		strHeaderAddMetaTag = strHeaderAddMetaTag & "	<meta property=""og:image"" id=""meta_og_image"" content=""" & strPageImage & """ />" & vbCrLf &_
													"	<link rel=""image_src"" href=""" & strPageImage & """ />" & vbCrLf
	else
		'기본 이미지
		strHeaderAddMetaTag = strHeaderAddMetaTag & "	<meta property=""og:image"" content=""https://fiximage.10x10.co.kr/page/title/pageImage_common_v1.jpg"" />" & vbCrLf &_
													"	<link rel=""image_src"" href=""https://fiximage.10x10.co.kr/page/title/pageImage_common_v1.jpg"" />" & vbCrLf
	end If
	if strRecoPickMeta<>"" then strHeaderAddMetaTag = strHeaderAddMetaTag & strRecoPickMeta

	'################# Amplitude에 들어갈 Referer 값 정의 ###################
	Dim AmpliduteReferer
	AmpliduteReferer = Request.ServerVariables("HTTP_REFERER")
	If Trim(AmpliduteReferer) <> "" Then
		If InStr(LCase(AmpliduteReferer), "tmailer.10x10.co.kr")>0 or InStr(LCase(AmpliduteReferer), "tms.10x10.co.kr")>0 Then
			response.cookies("CheckReferer") = AmpliduteReferer
		Else
			If Not(InStr(AmpliduteReferer, "10x10")>0) Then
				response.cookies("CheckReferer") = AmpliduteReferer
			End If
		End If
	End If
	'#########################################################################


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
	Dim isBizMode : isBizMode = chkiif(BizCookie="Y", "Y", "N")
	'#############################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="description" id="meta_og_description" content="<%=strPageDesc%>" />
	<meta name="keywords" content="<%=strPageKeyword%>" />
	<meta name="classification" content="비즈니스와 경제, 쇼핑과 서비스(B2C, C2C), 선물, 특별상품" />
	<meta name="application-name" content="텐바이텐" />
	<meta name="msapplication-task" content="name=텐바이텐;action-uri=http://www.10x10.co.kr/;icon-uri=/icons/10x10_140616.ico" />
	<meta name="msapplication-tooltip" content="생활감성채널 텐바이텐" />
	<meta name="msapplication-navbutton-color" content="#FFFFFF" />
	<meta name="msapplication-TileImage" content="/lib/ico/mstileLogo144.png"/>
	<meta name="msapplication-TileColor" content="#c91314"/>
	<meta name="msapplication-starturl" content="/" />
	<meta name="format-detection" content="telephone=no" />
	<%=strHeaderAddMetaTag%>
	<link rel="SHORTCUT ICON" href="//fiximage.10x10.co.kr/icons/10x10_140616.ico" />
	<link rel="apple-touch-icon" href="/lib/ico/10x10TouchIcon_150303.png" />
	<link rel="search" type="application/opensearchdescription+xml" href="/lib/util/10x10_brws_search.xml" title="텐바이텐 상품검색" />
	<link rel="alternate" type="application/rss+xml" href="/shoppingtoday/shoppingchance_rss.asp" title="텐바이텐 신상품소식 구독" />
	<link rel="alternate" type="application/rss+xml" href="/just1day/just1day_rss.asp" title="텐바이텐 Just 1Day 구독" />
	<title><%=strPageTitle%></title>
	<link rel="stylesheet" type="text/css" href="/lib/css/default.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/common.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/content.css?v=1.15" />
	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/mytenten.css" />
	<!--[if IE]>
		<link rel="stylesheet" type="text/css" href="/lib/css/preVst/ie.css" />
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="/lib/css/commonV18.css?v=1.20" />
	<link rel="stylesheet" type="text/css" href="/lib/css/productV15.css?v=1.10" />
	<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css?v=1.61" />
	<link rel="stylesheet" type="text/css" href="/lib/css/mytentenV15.css?v=1.00" />
	<!--link rel="stylesheet" href="https://js.appboycdn.com/web-sdk/1.6/appboy.min.css" /-->
	<!--[if lt IE 9]>
		<script src="/lib/js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript" src="/lib/js/amplitude.js?v=1.04"></script>
	<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js"></script>
	<%
	if GetLoginUserLevel = "7" Then 
	%>
	<script type="text/javascript">
		window.jQuery || document.write('<sc' + 'ript type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.7.1/jquery.min.js"></sc' + 'ript>');
	</script>
	<% Else %>
	<% End If %>

	<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
	<script type="text/javascript" src="/lib/js/swiper-2.1.min.js"></script>
	<script type="text/javascript" src="/lib/js/slick.min.js"></script>
	<script type="text/javascript" src="/lib/js/common.js?v=1.01"></script>
	<script type="text/javascript" src="/lib/js/tenbytencommon.js?v=1.4"></script>
	<script type="text/javascript" src="/lib/js/keyMovePage.js"></script>	
	<script type="text/javascript" src="/lib/js/buildV63.js"></script>
	<script type="text/javascript" src="https://cdn.branch.io/branch-2.52.2.min.js"></script>
	<script type="text/javascript" src="/lib/js/js.cookie.min.js"></script>
	<script type="text/javascript" src="/lib/js/errorhandler.js?v=4"></script>
	<script src="/shopping/api/pipeline.min.js"></script>
	<!--<script src="/shopping/api/pipeline-origin.js"></script>-->
	<% if irdsite20="okcashbag" then %>
	<script src="https://cashbagmall.okcashbag.com/mall/cTop410by10.js" charset="euc-kr"></script>
	<% end if %>