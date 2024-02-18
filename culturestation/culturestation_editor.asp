<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2010.04.08 한용민 생성
'              2013.08.30 허진원 : 2013리뉴얼
'	History	:  2016.04.18 유태욱 : listisusing 추가
'	Description : culturestation
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestationCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
dim oeditor_list , editor_no, page, evt_type
dim listisusing
	editor_no = getNumeric(requestcheckvar(request("editor_no"),4))
	page = getNumeric(requestcheckvar(request("page"),5))
	if page="" then page=1
	evt_type = "E"		'컬쳐에디터 지정

	listisusing = ""
	if GetLoginUserLevel <> "7" then
		listisusing = "Y"
	end if

'// 에디터코드 파라메타 없을경우 최근 값을 가져온다		
set oeditor_list = new ceditor_list
	oeditor_list.frecteditor_no = editor_no
	oeditor_list.frectisusing = listisusing
	
	oeditor_list.feditor()

	if oeditor_list.ftotalcount = 0 then
		response.write "<script>"
		response.write "alert('진행중인 에디터가 없습니다');"
		response.write "history.go(-1);"
		response.write "</script>"	
		dbget.close()	:	response.End
	end if
	
	'// 최근 에디터코드 저장
	editor_no = oeditor_list.fitemlist(0).feditor_no

	'//카운트 로그
	editor_log(editor_no)	

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 컬쳐스테이션 - " & replace(oeditor_list.fitemlist(0).feditor_name,"""","")		'페이지 타이틀 (필수)
	strPageImage = oeditor_list.FItemList(0).fimage_list2		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/culturestation/culturestation_editor.asp?editor_no=" & editor_no			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.gnbWrapV15 {height:38px;}
</style>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container cultureStation">
		<div id="contentWrap">
			<div class="cult-head">
				<h2><a href="/culturestation/"><img src="http://fiximage.10x10.co.kr/web2017/culturestation/tit_cult.png" alt="CULTURE STATION" /></a></h2>
				<p><img src="http://fiximage.10x10.co.kr/web2017/culturestation/txt_cult.png" alt="" /></p>
				<ul class="nav">
					<!-- for dev msg : 선택된 li에 클래스 on 추가해주세요 -->
					<li class="feel"><a href="/culturestation/?etype=0">느껴봐</a></li>
					<li class="read"><a href="/culturestation/?etype=1">읽어봐</a></li>
					<li class="editor current"><a href="culturestation_editor.asp">컬쳐에디터</a></li>
				</ul>
			</div>
			<div class="cultureContent cultureEdt">
				<!-- #include virtual="/culturestation/inc_culturestation_leftmenu.asp" -->
				<div class="content">
					<div class="fullImg">
					<% if oeditor_list.fitemlist(0).fimage_main <> "" then %>
						<p><img src="<%=webImgUrl%>/culturestation/editor/2009/main1/<%= oeditor_list.fitemlist(0).fimage_main %>" usemap="#ImgMap1" alt="컬쳐에디터 이미지1" /></p>
					<% end if %>
					<% if oeditor_list.fitemlist(0).fimage_main2 <> "" then %>
						<p><img src="<%=webImgUrl%>/culturestation/editor/2009/main2/<%= oeditor_list.fitemlist(0).fimage_main2 %>" usemap="#ImgMap2" alt="컬쳐에디터 이미지2" /></p>
					<% end if %>
					<%= oeditor_list.fitemlist(0).fimage_main_link %>
					<% if oeditor_list.fitemlist(0).fimage_main3 <> "" then %>
						<p><img src="<%=webImgUrl%>/culturestation/editor/2009/main3/<%= oeditor_list.fitemlist(0).fimage_main3 %>" usemap="#ImgMap3" alt="컬쳐에디터 이미지3" /></p>
					<% end if %>
					<% if oeditor_list.fitemlist(0).fimage_main4 <> "" then %>
						<p><img src="<%=webImgUrl%>/culturestation/editor/2009/main4/<%= oeditor_list.fitemlist(0).fimage_main4 %>" usemap="#ImgMap4" alt="컬쳐에디터 이미지4" /></p>
					<% end if %>
					<% if oeditor_list.fitemlist(0).fimage_main5 <> "" then %>
						<p><img src="<%=webImgUrl%>/culturestation/editor/2009/main5/<%= oeditor_list.fitemlist(0).fimage_main5 %>" usemap="#ImgMap5" alt="컬쳐에디터 이미지5" /></p>
					<% end if %>
					</div>
					<% if oeditor_list.FItemList(0).fcomment_isusing = "ON" then %>
					<!--코멘트 시작-->
					<div class="basicCmtWrap tMar40">
						<iframe id="editor_comment" name="editor_comment" src="/culturestation/culturestation_editor_comment.asp?editor_no=<%=editor_no%>" width="100%" class="autoheight"  frameborder="0" scrolling="no"></iframe>
					</div>
					<script type="text/javascript" src="/lib/js/jquery.iframe-auto-height.js"></script>
					<% end if %>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% set oeditor_list = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->