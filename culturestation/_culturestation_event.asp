<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2010.04.08 한용민 생성
'              2013.08.30 허진원 : 2013리뉴얼
'	Description : culturestation
'#######################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestationCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
dim oevent , idx_ix , eventstats, listisusing
dim page, evt_code, evt_type
	page = getNumeric(requestCheckVar(request("page"),5))
	if page = "" then page = 1
	evt_code = getNumeric(requestCheckVar(request("evt_code"),5))

'// 이벤트코드가 숫자인지 체크 아니면 팅겨냄
if evt_code = ""  or not(IsNumeric(evt_code)) then
	response.write "<script>"
	response.write "alert('이벤트코드가 없거나 승인된 페이지가 아닙니다.');"
	response.write "history.go(-1);"
	response.write "</script>"
	dbget.close()	:	response.End
end if

'// 이벤트 세부내용
set oevent = new cevent_list
	oevent.frectevt_type = evt_type
	oevent.frectevt_code =  evt_code
	oevent.frectevent_limit = 1
	oevent.fevent_view()

if oevent.ftotalcount = 0 then
	response.write "<script>"
	response.write "alert('존재 하지 않는 이벤트 입니다');"
	response.write "history.go(-1);"
	response.write "</script>"
	dbget.close()	:	response.End
end if

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 컬쳐스테이션 - " & replace(oevent.FOneItem.fevt_name,"""","")		'페이지 타이틀 (필수)
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = "http://10x10.co.kr/cts/" & evt_code			'페이지 URL(SNS 퍼가기용)

eventstats = datediff("d",oevent.FOneItem.fenddate,date())
evt_type= oevent.FOneItem.fevt_type
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
					<li class="feel<%=chkIIF(evt_type="0"," on","")%>"><a href="/culturestation/?etype=0">느껴봐</a></li>
					<li class="read<%=chkIIF(evt_type="1"," on","")%>"><a href="/culturestation/?etype=1">읽어봐</a></li>
					<li class="editor"><a href="culturestation_editor.asp">컬쳐에디터</a></li>
				</ul>
			</div>
			<div class="cultureContent cultureEvt">
				<!-- #include virtual="/culturestation/inc_culturestation_leftmenu.asp" -->
				<div class="content">
					<%IF eventstats > 0 THEN %>
					<% IF NOT(evt_code="2068") THEN %>
					<!-- 종료 이벤트 표시 -->
					<div class="evtEndWrap">
						<div class="evtEnd">
							<p <%=chkIIF(GetLoginUserLevel()=7,"onclick=""$('.evtEndWrap').hide();"" style=""cursor:pointer""","")%>><strong>앗! 죄송합니다! 종료된 이벤트 입니다.</strong></p>
							<p class="addInfo"><a href="/culturestation/"><span>이벤트 더 둘러보기</span></a></p>
						</div>
					</div>
					<% END IF %>
					<%END IF%>
					<% If oevent.FOneItem.fwrite_work <> "Y" or isnull(oevent.FOneItem.fwrite_work) = "True" Then %>
					<div class="fullImg">
						<% if oevent.FOneItem.fimage_main <> "" then %>
						<p><img src="<%=webImgUrl%>/culturestation/2009/main1/<%= oevent.FOneItem.fimage_main %>" usemap="#ImgMap1" style="max-width:898px;" /></p>
						<% end if %>
						<% if oevent.FOneItem.fimage_main2 <> "" then %>
						<p><img src="<%=webImgUrl%>/culturestation/2009/main2/<%= oevent.FOneItem.fimage_main2 %>" usemap="#ImgMap2" style="max-width:898px;" /></p>
						<% end if %>
						<% if oevent.FOneItem.fimage_main3 <> "" then %>
						<p><img src="<%=webImgUrl%>/culturestation/2009/main3/<%= oevent.FOneItem.fimage_main3 %>" usemap="#ImgMap3" style="max-width:898px;" /></p>
						<% end if %>
						<% if oevent.FOneItem.fimage_main4 <> "" then %>
						<p><img src="<%=webImgUrl%>/culturestation/2009/main4/<%= oevent.FOneItem.fimage_main4 %>" usemap="#ImgMap4" style="max-width:898px;" /></p>
						<% end if %>
						<% if oevent.FOneItem.fimage_main5 <> "" then %>
						<p><img src="<%=webImgUrl%>/culturestation/2009/main5/<%= oevent.FOneItem.fimage_main5 %>" usemap="#ImgMap5" style="max-width:898px;" /></p>
						<% end if %>
					</div>
					<% End If %>
					<%= oevent.FOneItem.fimage_main_link %>


					<% if oevent.foneitem.fcomment = "ON" then %>
					<!--코멘트 시작-->
					<div class="basicCmtWrap tMar40" id="cmt">
						<iframe id="view" name="view" src="/culturestation/culturestation_event_comment.asp?evt_code=<%=evt_code%>&eventstats=<%=eventstats%>" width="100%" class="autoheight" frameborder="0" scrolling="no"></iframe>
						<script type="text/javascript" src="/lib/js/jquery.iframe-auto-height.js"></script>
					</div>
					<% end if %>

				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
set oevent = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->