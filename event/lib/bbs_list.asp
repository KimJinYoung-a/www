<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<% 
'#### 변수선언 #################################
dim eCode : eCode   = requestCheckVar(Request("eventid"),10) '이벤트 코드번호
Dim iTotCnt, arrList,intLoop
Dim iPageSize, iCurrpage ,iDelCnt
Dim iStartPage, iEndPage, iTotalPage, ix,iPerCnt	
Dim sOrder, sSArea, sSTxt, vIsMine
Dim cEBBS 
dim blnFull, cdl, com_egCode
	 blnFull   = requestCheckVar(Request("blnF"),10)
	 IF blnFull = "" THEN blnFull = True
	 	
	iCurrpage = requestCheckVar(Request("iC"),10)	'현재 페이지 번호
	iTotCnt = requestCheckVar(Request("iTot"),10)	
	vIsMine = requestCheckVar(Request("ismine"),1)
		
	IF iCurrpage = "" THEN
		iCurrpage = 1	
	END IF	  
	IF iTotCnt = "" THEN
		iTotCnt = -1	
	END IF	 
	iPageSize = 8		'한 페이지의 보여지는 열의 수
	iPerCnt = 10		'보여지는 페이지 간격

	set cEBBS =  new ClsEvtBBS
		cEBBS.FECode = eCode
		cEBBS.FCPage = iCurrpage
		cEBBS.FPSize = iPageSize
		cEBBS.FTotCnt = iTotCnt
		If vIsMine = "o" Then
		cEBBS.Fuserid = GetLoginUserID
		End If
		arrList = cEBBS.fnGetBBSList
		iTotCnt = cEBBS.FTotCnt 		
	set cEBBS = nothing
	iTotalPage 	=  Int(iTotCnt/iPageSize)	'전체 페이지 수
	IF (iTotCnt MOD iPageSize) > 0 THEN	iTotalPage = iTotalPage + 1			
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/css/numSpinner.css" />
<script>
function ZoomBPhotoInfo(bidx) {
	var winWBBSD; 
	winWBBSD = window.open('/event/lib/bbs_view.asp?bidx='+bidx+'&eventid=<%=eCode%>','winWBBSD','width=783,height=690,status=no,resizable=yes,scrollbars=yes');
	winWBBSD.focus();
}

function jsSearch(){
	document.frmbbs.submit();
}
  
function jsGoPage(iP){
	document.frmbbs.iC.value = iP;
	document.frmbbs.iTot.value = "<%=iTotCnt%>";
	document.frmbbs.submit();	
}

function jsIsMine(sw){
	if(sw=="Y") {
		document.frmbbs.ismine.value = "o";
	} else {
		document.frmbbs.ismine.value = "";
	}
	document.frmbbs.submit();
}

function NewWindow(v){
	  var p = (v);
	  w = window.open("/common/showimage.asp?img=" + v, "imageView", "status=no,resizable=yes,scrollbars=yes");
}
	
function jsWriteBbs(){
	var winWBBS; 
	winWBBS = window.open('/event/lib/bbs_regist.asp?eventid=<%=eCode%>&blnF=<%=blnFull%>','winWBBS','width=810,height=690,status=no,resizable=yes,scrollbars=yes');
	winWBBS.focus();
}

</script>
</head>
<body>
<div class="photoCmt">
<form name="frmbbs" method="post" style="margin:0px;">
<input type="hidden" name="iC">
<input type="hidden" name="iTot">
<input type="hidden" name="ismine" value="<%=vIsMine%>">
<input type="hidden" name="eventid" value="<%=eCode%>">  
	<div class="photoCmtHead">
		<span class="badgeInfo addInfo"><strong>10x10 BADGE</strong>
			<div class="contLyr" style="width:210px;">
				<div class="contLyrInner">
					<dl class="badgeDesp">
						<dt><strong>10X10 BADGE?</strong></dt>
						<dd>
							<p>고객님의 쇼핑패턴을 분석하여 자동으로 달아드리는 뱃지입니다. <br />후기작성 및 코멘트 이벤트 참여시 획득한 뱃지를 통해 타인에게 신뢰 및 어드바이스를 전달 해줄 수 있습니다.</p>
							<p class="tPad10">나의 뱃지는 <a href="/my10x10/" target="_top" class="cr000 txtL">마이텐바이텐</a>에서 확인하실 수 있습니다.</p>
						</dd>
					</dl>
				</div>
			</div>
		</span>
     	<% if IsUserLoginOK then %>
     	<a href="#" onclick="jsIsMine('<%=chkIIF(vIsMine="o","N","Y")%>');return false;" class="btn btnS2 btnGrylight btnW130"><em class="fn gryArr01"><%=chkIIF(vIsMine="o","전체 코멘트 보기","내가 쓴 코멘트 보기")%></em></a>
     	<a href="#" onclick="jsWriteBbs();return false;" class="btn btnS2 btnRed fn btnW130">포토 코멘트 쓰기</a>
     	<% else %>
     	<a href="#" onclick="jsChklogin('<%=IsUserLoginOK%>');return false;" class="btn btnS2 btnRed fn btnW130">포토 코멘트 쓰기</a>
     	<% end if %>
		
	</div>
	<div class="pdtWrap pdt200">
		<ul class="pdtList">
		<%IF isArray(arrList) THEN%>
		<!-- 리스트 -->
		<%
			dim arrUserid, bdgUid, bdgBno
			for intLoop = 0 to UBound(arrList,2)
				arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(arrList(1,intLoop)) & "''"
			next
					
			Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")
			
			For intLoop=0 To UBound(arrList,2) %>
			<li>
				<div class="pdtBox">
					<div class="pdtPhoto">
					<%IF arrList(8,intLoop) <> "" THEN%>
						<p><a href="javascript:ZoomBPhotoInfo('<%=arrList(0,intLoop)%>');"><img src="<%=getThumbImgFromURL(staticImgUrl & "/contents/photo_event/" & eCode & "/" & arrList(8,intLoop),200,200,"true","false")%>" width="200px" height="200px" alt="<%=arrList(0,intLoop)%>번글 첨부이미지" /></a></p>
					<%ELSE%>
						<p><a href="javascript:ZoomBPhotoInfo('<%=arrList(0,intLoop)%>');"><img src="http://fiximage.10x10.co.kr/web2010/enjoyevent/noimg.gif" width="200px" height="200px" alt="<%=arrList(0,intLoop)%>번글 첨부이미지" /></a></p>
					<%END IF%>
					</div>
					<div class="ptCmtInfo">
						<p>
							<a href="javascript:ZoomBPhotoInfo('<%=arrList(0,intLoop)%>');">
								<span class="ptCmtNum">No.<%=iTotCnt-intLoop-(iPageSize*(iCurrpage-1))%><% If DateDiff("h",arrList(6,intLoop),now()) < 24 Then %> <img src="http://fiximage.10x10.co.kr/web2013/cscenter/ico_new.gif" class="new" alt="NEW" /><% End If %></span>
								<span class="ptCmtTit"><%=chrbyte(db2html(arrList(2,intLoop)),30,"Y")%></span>
							</a>
						</p>
						<p class="ptCmtDate">view <%=FormatNumber(arrList(4,intLoop),0)%> <span class="bar">l</span> <%=FormatDate(arrList(6,intLoop),"0000.00.00")%></p>
						<div class="ptCmtWriter">
							<p><%=printUserId(arrList(1,intLoop),2,"*")%></p>
							<p class="badgeView"><%=getUserBadgeIcon(arrList(1,intLoop),bdgUid,bdgBno,3)%></p>
						</div>
					</div>
				</div>
			</li>
		<% Next %>
		<% ELSE %>
		<li class="noData"><strong>등록된 코멘트가 없습니다.</strong></p></li>
		<% END If %>
		</ul>
	</div>
	<div class="pageWrapV15 tMar20">
		<%= fnDisplayPaging_New(iCurrpage,iTotCnt,iPageSize,iPerCnt,"jsGoPage") %>
	</div>
</form>
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->