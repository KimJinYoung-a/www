<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<% 
strPageTitle = "텐바이텐 10X10 : 포토 코멘트 수정"
'#### 변수선언 #################################
dim userid : userid = GetLoginUserID
dim bidx,eCode
dim cEBView
dim suserid, stitle, scontent, soimg1, soimg2, simg1, simg2, shit,scomcnt, sregdate
dim blnFull, cdl, cdm, cds, com_egCode
	 cdl   = requestCheckVar(Request("cdl"),3)
	 blnFull   = requestCheckVar(Request("blnF"),10)
	 IF blnFull = "" THEN blnFull = True
	 	
eCode   = requestCheckVar(Request("eventid"),10) '이벤트 코드번호
bidx   = requestCheckVar(Request("bidx"),10) '게시판 번호		

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
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="javascript">
<!--
	function jsSubmitbbs(frm){
	
	 //제목
	 if(fnChkBlank(frm.title.value)) {
	  	alert("제목을 입력해주세요");
	  	frm.title.focus();
	  	return false;
	 }
	
	//내용
	 if(fnChkBlank(frm.contents.value)) {
	  alert("내용을 입력해주세요");
	  frm.contents.focus();
	  return false;
	 }
	 

}

function fnChkBlank(str)
{
    if (str == "" || str.split(" ").join("") == ""){
        return true;
	}
    else{
        return false;
	}
}	

//-->
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/event/tit_photo_commnet_edit.gif" alt="포토 코멘트 수정" /></h1>
			</div>
			<div class="popContent">
			<form name="frmbbs" method="post" action="<%=staticImgUpUrl%>/linkweb/enjoy/eventbbs_process_new2015.asp" onsubmit="return jsSubmitbbs(this);" enctype="multipart/form-data" style="margin:0px;">	
			<input type="hidden" name="bidx" value="<%=bidx%>">	
	        <input type="hidden" name="eventid" value="<%=eCode%>">
	        <input type="hidden" name="userid" value="<%=userid%>">	
	        <input type="hidden" name="cdl" value="<%=cdl%>">
	        <input type="hidden" name="blnF" value="<%=blnFull%>">
	        <input type="hidden" name="mode" value="U">
	        <input type="hidden" name="is2013renew" value="o">
				<!-- content -->
				<div class="mySection">
					<fieldset>
						<legend>포토 코멘트 수정</legend>
						<table class="baseTable rowTable docForm tMar15">
						<caption>포토 코멘트 수정</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row" class="ct"><label for="titleSubject">제목</label></th>
							<td><input type="text" id="titleSubject"  name="title" maxlength="64" class="txtInp" value="<%=stitle%>" style="width:94%;" value="<%=stitle%>" /></td>
						</tr>
						<tr>
							<th scope="row" class="ct"><label for="commentMsg">내용</label></th>
							<td>
								<textarea id="commentMsg" name="contents" cols="60" rows="8" class="fs12" style="width:95.5%; height:188px;"><%=scontent%></textarea>
								<p class="tPad07 fs11">통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며, 이벤트 참여에 제한을 받을 수 있습니다.</p>
							</td>
						</tr>
						<tr>
							<th scope="row" class="ct">첨부이미지</th>
							<td>
								<div class="attachFile">
									<input type="file" name="file1" title="첨부이미지 찾아보기" class="inputFile" style="width:85%;" />
									<div class="imgArea">
										<%IF soimg1 <> "" THEN%><img src="<%=staticImgUrl&"/contents/photo_event/"&eCode&"/"&soimg1%>" alt="첨부이미지1" /><%END IF%>
										<%IF soimg1 <> "" THEN%><%IF soimg2="" THEN%><span><input type="checkbox" id="imgDelete01" name="chkdelf1" class="check" /> <label for="imgDelete01">등록된 이미지 삭제</label></span><%END IF%><%END IF%>
									</div>
								</div>
								<div class="attachFile tMar10">
									<input type="file" name="file2" title="첨부이미지 찾아보기" class="inputFile" style="width:85%;" />
									<div class="imgArea">
										<%IF soimg2 <> "" THEN%><img src="<%=staticImgUrl&"/contents/photo_event/"&eCode&"/"&soimg2%>" alt="첨부이미지2" /><%END IF%>
										<%IF soimg2 <> "" THEN%><span><input type="checkbox" id="imgDelete02" name="chkdelf2" class="check" /> <label for="imgDelete02">등록된 이미지 삭제</label></span><%END IF%>
									</div>
								</div>
								<p class="tMar07 fs11">파일크기는 1MB이하, JPG 또는 GIF형식의 파일만 가능합니다. 사이즈는 가로 600px 이하로 설정해 주시기 바랍니다.</p>
							</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad30">
							<input type="submit" class="btn btnS1 btnRed btnW160" value="수정하기" />
							<button type="button" class="btn btnS1 btnGry btnW160" onClick="window.close();">취소하기</button>
						</div>
					</fieldset>
				</div>
				</form>
				<!-- //content -->
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>