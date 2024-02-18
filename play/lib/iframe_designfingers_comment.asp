<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/classes/designfingers/dfCommentCls.asp" -->
<%
'#######################################################
'	History	:  2008.03.18 정윤정 생성
'	Description : 디자인핑거스 코멘트 - iframe 처리
'#######################################################
 	Dim clsDFComm, arrComm
 	Dim iDFSeq, iComCurrentPage, id, commentGubun, iResult, isMyComm
 	commentGubun = requestCheckVar(request("commentGubun"),10)
 	id = NullFillWith(requestCheckVar(request("id"),10),"")

 	iDFSeq = requestCheckVar(request("iDFS"),10)
 	iComCurrentPage = requestCheckVar(request("iCC"),10)
 	if iComCurrentPage="" then iComCurrentPage=1
 	isMyComm = requestCheckVar(request("isMC"),1)

 	If commentGubun = "V" Then

	 	If id = "" Then
	 		Response.Write "<script>alert('잘못된 접근입니다.');location.href='http://www.10x10.co.kr';"
	 		dbget.close()
	 		Response.End
	 	End If
%>
		<html>
		<head>
		<link href="/lib/css/2011ten.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
		</head>
		<body>
			<div id="getDFComm">
			<%
				set clsDFComm = new CProcDesignFingers
					iResult = clsDFComm.fnUpdateComment("V",id,GetLoginUserID,"")
		    	set clsDFComm = nothing

		    	arrComm = split(iResult,"||,||")

				'// 2010-06 핑거스 이벤트면 URL입력창 활성화
				if iDFSeq>=740 and iDFSeq<=761 then
			%>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><textarea name="tx_comment" id="tx_comment" class="input_default" style="width:100%; height:54px;" onClick="jsChklogin('<%=IsUserLoginOK%>');" onKeyUp="jsChklogin('<%=IsUserLoginOK%>');" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<%END IF%>
						<%=db2Html(arrComm(0))%></textarea></td>
					<td width="162" align="right" rowspan="2" valign="top" style="padding:2 0 0 8px;"><img src="http://fiximage.10x10.co.kr/web2010/common/cmt_ok2.gif" width="149" height="94" style="cursor:pointer" onClick="UpdateComments('<%=id%>');"></td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="75" class="gray11px02b">블로그 주소</td>
							<td><input name="tx_commentURL" id="tx_commentURL" type="text" class="input_default" style="width:100%;" value="<% if ubound(arrComm)>0 then Response.Write db2Html(arrComm(1)) %>"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="padding:2px 0 0 75px;">- 입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</td>
				</tr>
				<script language="javascript">
				<!--
					parent.document.all.setDFCommTxt.innerHTML = document.all.getDFComm.innerHTML;
					self.location.href = "about:blank";
				//-->
				</script>
				</table>
			<%	else %>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><textarea name="tx_comment" id="tx_comment" class="input_default" style="width:100%; height:54px;" onClick="jsChklogin('<%=IsUserLoginOK%>');" onKeyUp="jsChklogin('<%=IsUserLoginOK%>');" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<%END IF%><%=db2Html(arrComm(0))%></textarea></td>
					<td width="164" align="right" valign="top" style="padding:2 0 0 8px;"><img src="http://fiximage.10x10.co.kr/web2009/common/cmt_ok.gif" width="151" height="63" style="cursor:pointer" onClick="UpdateComments('<%=id%>');"></td>
				</tr>
				<tr>
					<td style="padding-top:8px;"><img src="http://fiximage.10x10.co.kr/web2011/designfingers/cmt_info.gif"></td>
				</tr>
				</table>
				<input name="tx_commentURL" id="tx_commentURL" type="hidden">
				<script language="javascript">
				<!--
					parent.document.all.setDFCommTxt.innerHTML = document.all.getDFComm.innerHTML;
					self.location.href = "about:blank";
				//-->
				</script>
			<%	end if %>
			</div>
		</body>
		</html>
<%
	Else

	 	If iDFSeq = "" Then
	 		Response.Write "<script>alert('잘못된 접근입니다.');top.location.href='http://www.10x10.co.kr';"
	 		dbget.close()
	 		Response.End
	 	End If
%>
		<html>
		<head>
		<link href="/lib/css/2011ten.css" rel="stylesheet" type="text/css">
		</head>
		<body>
			<div id="getDFComm">
			<%
				set clsDFComm = new CDesignFingersComment
					clsDFComm.FRectFingerID = iDFSeq
		        	clsDFComm.FCurrPage		= iComCurrentPage
		        	if isMyComm="Y" then clsDFComm.frectUserid = GetLoginUserID
		        	clsDFComm.sbGetCommentDisplay
		    	set clsDFComm = nothing
			%>
			</div>
			<script language="javascript">
			<!--
				parent.document.all.setDFComm.innerHTML = document.all.getDFComm.innerHTML;
				self.location.href = "about:blank";
			//-->
			</script>
		</body>
		</html>
<%
	End If
%>