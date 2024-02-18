<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<% 
'#### 변수선언 #################################
dim userid : userid = GetLoginUserID
dim bidx,eCode
dim cEBView
dim suserid, stitle, scontent, soimg1, soimg2, simg1, simg2, shit,scomcnt, sregdate
dim sidx, iCurrpage
dim blnFull, cdl, cdm, cds, com_egCode
	 cdl   = requestCheckVar(Request("cdl"),3)
	 blnFull   = requestCheckVar(Request("blnF"),10)
	 IF blnFull = "" THEN blnFull = True
eCode   = requestCheckVar(Request("eventid"),10) '이벤트 코드번호
bidx   = requestCheckVar(Request("bidx"),10) '게시판 번호
iCurrpage = requestCheckVar(Request("iC"),10)	'현재 페이지 번호
IF iCurrpage = "" THEN iCurrpage = 1	

IF bidx = "" THEN
	Alert_return("유입경로에 문제가 발생하였습니다. 관리자에게 문의해 주세요")  
dbget.close()	:	response.End
END IF	


'#### 데이터 가져오기 #################################
 set cEBView = new ClsEvtBBS
 	cEBView.FECode  =  eCode
 	cEBView.FEBidx  =  bidx 
 	
 	cEBView.fnGetBBSContent
	suserid 	= cEBView.Fuserid   
	stitle  	= cEBView.FEBsubject
	scontent	= cEBView.FEBcontent
	simg1 		= cEBView.FEBimg1   
	simg2 		= cEBView.FEBimg2   
	soimg1		= cEBView.FEBOimg1   
	soimg2		= cEBView.FEBOimg2  
	shit 		= cEBView.FEBhit    
	scomcnt 	= cEBView.FEBcommcnt
	sregdate 	= cEBView.FEBregdate
 set cEBView = nothing
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/popup.css" />
<script>
function jsEditBbs(bidx){
	location.href = '/event/lib/bbs_modify.asp?bidx='+bidx+'&eventid=<%=eCode%>&blnF=<%=blnFull%>';
}

function jsDel(){
	if(confirm("삭제하시겠습니까?")){
		document.frmDel.submit();
	}
}
</script>
</head>
<body LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0">
<div id="photoCmtLyr" class="window photoCmtLyr bdrLyr" style="display:block;">
<div class="popTop pngFix"><div class="pngFix"></div></div>
<div class="popContWrap pngFix">
<form name="frmDel" method="post" action="<%=staticImgUpUrl%>/linkweb/enjoy/eventbbs_process_new.asp" enctype="multipart/form-data" style="margin:0px;">
<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="bidx" value="<%=bidx%>">
<input type="hidden" name="userid" value="<%=userid%>">	
<input type="hidden" name="mode" value="D">
</form>
	<div class="popCont pngFix">
		<div class="popBody">
			<div class="pdtBox">
				<div class="ptCmtInfo">
					<p class="ptCmtNum">No.<%=bidx%></p>
					<p class="ptCmtTit"><%=db2html(stitle)%></p>
					<div class="ptCmtDate">
						<span>view <%=FormatNumber(shit,0)%></span>
						<span class="bar">l</span>
						<span><%=FormatDate(sregdate,"0000.00.00")%></span>
						<span class="bar">l</span>
						<span><%=printUserId(suserid,2,"*")%></span>
						<span class="badgeView">
						<%
						dim bdgUid, bdgBno
						Call getUserBadgeList("''" & suserid & "''",bdgUid,bdgBno,"Y")
						%><%=getUserBadgeIcon(suserid,bdgUid,bdgBno,3)%>
						</span>
					</div>
				</div>
				<div class="ptCmtCont">
					<p class="txt"><%=nl2br(db2html(scontent))%></p>
					<p class="pic">
					<%IF soimg1 <> "" THEN %>
						<a href="javascript:opener.NewWindow('<%=staticImgUrl%><%=simg1%>')"><img src="<%=staticImgUrl%><%=simg1%>"  id="file1" border="0" style="max-width:600px;max-height:340px;" alt="포토코멘트 이미지"></a><br/>
					<%END IF%>
					<%IF soimg2 <> "" THEN %>
						<a href="javascript:opener.NewWindow('<%=staticImgUrl%><%=simg2%>')"><img src="<%=staticImgUrl%><%=simg2%>"  id="file2" border="0" style="max-width:600px;max-height:340px;" alt="포토코멘트 이미지"></a><br>
					<%END IF%>
					</p>
				</div>
				<div class="btnArea">
					<a href="javascript:jsEditBbs('<%=bidx%>');" class="btn btnS2 btnGry2 fn">수정</a>
					<a href="javascript:jsDel();" class="btn btnS2 btnGry2 fn">삭제</a>
				</div>
			</div>
			<p class="lyrClose"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_pop_close02.gif" alt="닫기" onclick="window.close()" /></p>
		</div>
	</div>
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->