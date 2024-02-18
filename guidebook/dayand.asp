<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCommonCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/dayAndCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoriteEventCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'#######################################################
'	History	:  2010.04.09 허진원 생성
'							2012.04.06 정윤정 리뉴얼 디자인 변경
'	Description : DAY&
'#######################################################
 Dim clsEvtDayand
 Dim eCode,idx, ename, page, lp
 Dim sMimg,sMhtml, sTemplate,iLinkECode, dPrizeDate, dEndDate,sBrand,isComment,isBBS
 Dim iEvtKind, strMainCont, bimg
 Dim evt_firstCd, evt_lastCd, evt_preCd, evt_NextCd, favCnt
 Dim isMyFavEvent : isMyFavEvent=false
 
 	iEvtKind	= 22		'데이앤드 이벤트 분류 코드
	eCode		= getNumeric(requestCheckVar(request("eventid"),10))
	idx 	  	= getNumeric(requestCheckVar(request("idx"),10))
	page 	  	= getNumeric(requestCheckVar(request("page"),8))
	if eCode 	= "" then eCode = 0
	if idx 		= "" then idx 	= 0
	if page		= "" then page 	= 1

	'// 메인내용 접수
	set clsEvtDayand = new ClsDayAnd
		clsEvtDayand.FECode = eCode		
		clsEvtDayand.FIdx 	= idx
		
		clsEvtDayand.fnGetEventCont
		
		eCode 		= clsEvtDayand.FECode 
		ename		= clsEvtDayand.FEName
		sTemplate 	= clsEvtDayand.Fevt_template
		sMimg 		= clsEvtDayand.Fevt_mainimg
		sMhtml 		= clsEvtDayand.Fevt_html
		sBrand		= clsEvtDayand.Fbrand
		dEndDate	= clsEvtDayand.Fevt_enddate
		dPrizeDate 	= clsEvtDayand.Fevt_prizedate
		iLinkECode	= clsEvtDayand.Fevt_linkcode 
		IF iLinkECode = 0 THEN iLinkECode = ""
		isComment	= clsEvtDayand.Fiscomment
		isBBS		= clsEvtDayand.Fisbbs
		evt_firstCd	= clsEvtDayand.Fevt_firstCd
		evt_lastCd	= clsEvtDayand.Fevt_lastCd
		evt_preCd	= clsEvtDayand.Fevt_preCd
		evt_NextCd	= clsEvtDayand.Fevt_NextCd
		favCnt		= clsEvtDayand.FfavCnt
		if isNull(evt_lastCd) then evt_lastCd=""

	set clsEvtDayand = nothing

	strMainCont = sMhtml

	'// 내 관심 데이엔드 확인 (관심이벤트 확인과 동일)
	if IsUserLoginOK then
		set clsEvtDayand = new CMyFavoriteEvent
			clsEvtDayand.FUserId = getEncLoginUserID
			clsEvtDayand.FevtCode = eCode
			isMyFavEvent = clsEvtDayand.fnIsMyFavEvent
		set clsEvtDayand = nothing
	end if

	IF sMimg <> "" THEN strMainCont = strMainCont & "<img src='" & sMimg & "' usemap='#mapMain' alt='" & replace(ename,"'","") & "'>"

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : Day& " & replace(ename,"""","")		'페이지 타이틀 (필수)
	strPageImage = bimg		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://10x10.co.kr/day/" & eCode			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
$(function(){
	<% if Not(evt_preCd="" or isNull(evt_preCd)) then %>
	$("#goPrev").click(function(){
		viewCont(<%=evt_preCd%>,1);
	});
	<% end if %>
	<% if Not(evt_nextCd="" or isNull(evt_nextCd)) then %>
	$("#goNext").click(function(){
		viewCont(<%=evt_nextCd%>,1);
	});
	<% end if %>
});

// 페이지 이동(Ajax)
function goPage(pg) {
	var str = $.ajax({
		type: "GET",
		url: "/guidebook/ajax_dayandList.asp",
		data: "eventid=<%=eCode%>&page="+pg,
		dataType: "text",
		async: false
	}).responseText;

	if(str!="") {
		$("#dayandList").html(str);
	}
}

function viewCont(id,pg) {
	self.location.href="?eventid="+id+"&page="+pg;
}

function fnMyEvent() {
<% If IsUserLoginOK Then %> 
	//AJAX처리 후 레이어처리
	$.ajax({
		url: "/my10x10/myfavorite_eventProc.asp?hidM=I&eventid=<%=eCode%>&pop=L",
		cache: false,
		async: false,
		success: function(message) {
			if(message!="0") {
				//확인 창 Open
				var vPopLayer = '<div class="window putDayandLyr" style="width:400px; height:315px;">';
				vPopLayer += '	<div class="popTop pngFix"><div class="pngFix"></div></div>';
				vPopLayer += '	<div class="popContWrap pngFix">';
				vPopLayer += '		<div class="popCont pngFix">';
				vPopLayer += '			<div class="popBody">';
				vPopLayer += '				<div class="popAlert">';
				if(message=="1") {
					vPopLayer += '					<p class="msg"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_dayand_message.gif" alt="관심 Day&amp;로 등록되었습니다." /></p>';
				} else {
					vPopLayer += '					<p class="msg"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_dayand_message_reput.gif" alt="이미 관심 Day&amp;로 등록되었습니다." /></p>';
				}
				vPopLayer += '					<div class="btnArea">';
				vPopLayer += '						<a href="/my10x10/myfavorite_dayand.asp" class="btn btnRed btnW140">관심 Day&amp; 확인하기</a>';
				vPopLayer += '						<a href="" onclick="ClosePopLayer();return false;" class="btn btnWhite btnW140">Day&amp; 계속보기</a>';
				vPopLayer += '					</div>';
				vPopLayer += '				</div>';
				vPopLayer += '			</div>';
				vPopLayer += '		</div>';
				vPopLayer += '	</div>';
				vPopLayer += '</div>';
				viewPoupLayer('modal',vPopLayer);

				//관심 체크표시
				if(!$("#evtFavCnt").hasClass("myFavor")) {
					var $opObj = $("#evtFavCnt");
					var fcnt = $opObj.find("strong").text().replace(/,/g,"");
					fcnt++;
					wfnt = setComma(fcnt);
					$opObj.find("strong").text(fcnt);
					$opObj.addClass('myFavor');
				}
			} else {
				alert("처리중 오류가 발생했습니다.");
			}
		}
	});
<% Else %>
	if(confirm("로그인 하시겠습니까?") == true) {
		top.location.href = "/login/loginpage.asp?backpath=<%=server.URLEncode(request.ServerVariables("URL"))%>&strGD=<%=server.URLEncode(request.ServerVariables("QUERY_STRING"))%>&strPD=<%=server.URLEncode(fnMakePostData)%>";
	 }
		return  ; 
<% End If %>
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="dayAndWrap">
				<div class="overHidden">
					<h2 class="ftLt"><img src="http://fiximage.10x10.co.kr/web2013/dayand/tit_dayand.gif" alt="DAY&" /></h2>
					<p class="contMove">
						<span id="goPrev" class="contGoPrev">PREV</span>
						<span id="goNext" class="contGoNext">NEXT</span>
					</p>
				</div>
				<div class="tMar10 dayAndCont">
					<% 'autoForm / handForm %>
					<%=strMainCont%>
				</div>

				<div class="snsArea tMar10">
					<div class="sns">
						<ul>
						<%
							'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
							dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
							snpTitle = Server.URLEncode(ename)
							snpLink = Server.URLEncode("http://10x10.co.kr/day/" & ecode)
							snpPre = Server.URLEncode("텐바이텐 DAY&")
							snpTag = Server.URLEncode("텐바이텐 " & Replace(ename," ",""))
							snpTag2 = Server.URLEncode("#10x10")
							snpImg = Server.URLEncode(sMimg)
						%>
							<li><a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
							<li><a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
							<li><a href="" onclick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>');return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
						</ul>
						<div id="evtFavCnt" class="favoriteAct <%=chkIIF(isMyFavEvent,"myFavor","")%>" onclick="fnMyEvent()"><strong><%=formatNumber(favCnt,0)%></strong></div>
					</div>
				</div>
			</div>

			<% IF isComment THEN %>
			<div class="basicCmtWrap tMar40">
				<!-- 코멘트 -->
				<iframe id="evt_cmt" src="/event/lib/iframe_comment.asp?eventid=<%=eCode%>" width="100%" height="100" class="autoheight"  frameborder="0" scrolling="no"></iframe>
			</div>
			<% end if %>
			<% IF isBBS THEN %>
			<div class="tMar40">
				<!-- 게시판 -->
				<iframe id="evt_bbs" src="/event/lib/bbs_list.asp?eventid=<%=eCode%>" width="100%" class="autoheight" frameborder="0" scrolling="no"></iframe>
			</div>
			<% end if %>
			
			<h3 class="ct tMar80"><img src="http://fiximage.10x10.co.kr/web2013/dayand/subtit_past_dayand.gif" alt="지난 데이앤드 보기" /></h3>
		<%
			Dim idaTotCnt, idaTotPg, arrDA, intDA
			set clsEvtDayand = new ClsDayAnd
			clsEvtDayand.FCurrPage = page
			clsEvtDayand.FPageSize = 10
			clsEvtDayand.FScrollCount = 10 
			arrDA = clsEvtDayand.fnGetDayAndList
			idaTotCnt = clsEvtDayand.FTotCnt
			idaTotPg = clsEvtDayand.FTotalPage
			set clsEvtDayand = nothing
		%>
			<div id="dayandList" class="pastDayAndWrap">
			<%	if isArray(arrDA) then %>
				<ul class="pastDayandList">
				<% for intDA=0 to ubound(arrDA,2) %>
					<li <%=chkIIF(cStr(eCode)=cStr(arrDa(0,intDa)),"class=""current""","")%> onclick="viewCont(<%=arrDa(0,intDa)%>,<%=page%>)">
						<p class="thumb"><img src="<%=arrDa(3,intDa)%>" alt="<%=replace(arrDa(1,intDa),"""","")%>" /><span></span></p>
						<p class="tPad05" style="cursor:pointer;"><%=arrDa(1,intDa)%></p>
					</li>
				<% next %>
				</ul>
				<span class="listMove goListPrev" <% if Int(page)>1 then %>onclick="goPage(<%=page-1%>)"<% end if %>>이전페이지로 이동</span>
				<span class="listMove goListNext" <% if Int(page)<Int(idaTotPg) then %>onclick="goPage(<%=page+1%>)"<% end if %>>다음페이지로 이동</span>
				<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(page,idaTotCnt,10,10,"goPage") %></div>
			<%	end if %>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/lib/js/jquery.iframe-auto-height.js"></script>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->