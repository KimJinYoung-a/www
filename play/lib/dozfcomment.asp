<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/designfingers/dfCommentCls.asp" -->
<%
dim clsProcDF
dim userid, masterid, gubuncd, txtcomm, txtcommURL, sitename, id, iComCurrentPage, commentGubun
dim iconid
dim sMode,iResult

sMode		= requestCheckVar(request.Form("sM"),1)
userid 		= requestCheckVar(GetLoginUserID,32)


SELECT Case sMode
	Case "I"
		masterid 	= requestCheckVar(request.Form("masterid"),10)
		gubuncd 	= requestCheckVar(request.Form("gubuncd"),1)
		txtcomm 	= request.Form("tx_comment")
		txtcommURL 	= request.Form("tx_commentURL")

		if checkNotValidTxt(txtcomm) then
			Alert_move "내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요.","about:blank"
			dbget.close()	:	response.End
		end if

		if trim(txtcommURL)="" then
			txtcomm = Html2Db(txtcomm)
		else
			txtcomm = Html2Db(txtcomm) & "||,||" & Html2Db(txtcommURL)
		end if
		sitename = requestCheckVar(request.Form("sitename"),50)
		iconid =  requestCheckVar(request.Form("iconid"),2)

		set clsProcDF = new CProcDesignFingers
			iResult = clsProcDF.fnSaveComment(userid,masterid,gubuncd,txtcomm,sitename,iconid)
		set clsProcDF = nothing
			if iResult = 2 THEN
				Alert_move "한번에 5회 이상 연속 등록 불가능합니다.","about:blank"
				dbget.close()	:	response.End
			elseif iResult = 0 then
				Alert_move "데이터처리에 문제가 발생했습니다. 관리자에게 문의해주세요","about:blank"
				dbget.close()	:	response.End
			end if
%>
				<script language="javascript">
				<!--
					self.location.href = "iframe_designfingers_comment.asp?iDFS=<%=masterid%>&iCC=1";
					parent.document.upcomment.tx_comment.value = "";
				//-->
				</script>
<%
				dbget.close()	:	response.End
	Case "D"
		masterid =requestCheckVar(request.Form("masterid"),10)
		id	= requestCheckVar(request.Form("id"),10)
		iComCurrentPage	= requestCheckVar(request("iCC"),10)
		set clsProcDF = new CProcDesignFingers
			iResult = clsProcDF.fnDelComment(userid,id)
		set clsProcDF = nothing

			if iResult <> 1 then
				Alert_move "데이터처리에 문제가 발생했습니다. 관리자에게 문의해주세요","about:blank"
				dbget.close()	:	response.End
			end if
%>
				<script language="javascript">
				<!--
					self.location.href = "iframe_designfingers_comment.asp?iDFS=<%=masterid%>&iCC=<%=iComCurrentPage%>";
				//-->
				</script>
<%
				dbget.close()	:	response.End
	Case "U"
		commentGubun = NullFillWith(requestCheckVar(request("commentGubun"),10),"U")
		id	= requestCheckVar(request.Form("id"),10)
		masterid 	= requestCheckVar(request.Form("masterid"),10)
		gubuncd 	= requestCheckVar(request.Form("gubuncd"),1)
		txtcomm 	= request.Form("tx_comment")
		txtcommURL 	= request.Form("tx_commentURL")

		if checkNotValidTxt(txtcomm) then
			Alert_move "내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요.","about:blank"
			dbget.close()	:	response.End
		end if

		if trim(txtcommURL)="" then
			txtcomm = Html2Db(txtcomm)
		else
			txtcomm = Html2Db(txtcomm) & "||,||" & Html2Db(txtcommURL)
		end if
		sitename = requestCheckVar(request.Form("sitename"),50)
		iconid =  requestCheckVar(request.Form("iconid"),2)

		set clsProcDF = new CProcDesignFingers
			iResult = clsProcDF.fnUpdateComment(commentGubun,id,userid,txtcomm)
		set clsProcDF = nothing
			if iResult = 2 THEN
				Alert_move "한번에 5회 이상 연속 등록 불가능합니다.","about:blank"
				dbget.close()	:	response.End
			elseif iResult = 0 then
				Alert_move "데이터처리에 문제가 발생했습니다. 관리자에게 문의해주세요","about:blank"
				dbget.close()	:	response.End
			end if
%>
				<div id="getDFComm">
				<%
					'// 2010-06 핑거스 이벤트면 URL입력창 활성화
					if masterid>=740 and masterid<=761 then
				%>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><textarea name="tx_comment" id="tx_comment" class="input_default" style="width:100%; height:54px;" onClick="jsChklogin('<%=IsUserLoginOK%>');" onKeyUp="jsChklogin('<%=IsUserLoginOK%>');" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<%END IF%></textarea></td>
						<td width="162" align="right" rowspan="2" valign="top" style="padding:2 0 0 8px;"><img src="http://fiximage.10x10.co.kr/web2010/common/cmt_ok2.gif" width="149" height="94" style="cursor:pointer" onClick="uploadcoment();"></td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="75" class="gray11px02b">블로그 주소</td>
								<td><input name="tx_commentURL" id="tx_commentURL" type="text" class="input_default" style="width:100%;"></td>
							</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style="padding:2px 0 0 75px;">- 입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</td>
					</tr>
					</table>
				<% else %>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><textarea name="tx_comment" id="tx_comment" class="input_default" style="width:100%; height:54px;" onClick="jsChklogin('<%=IsUserLoginOK%>');" onKeyUp="jsChklogin('<%=IsUserLoginOK%>');" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<%END IF%></textarea></td>
						<td width="164" align="right" valign="top" style="padding:2 0 0 8px;"><img src="http://fiximage.10x10.co.kr/web2009/common/cmt_ok.gif" width="151" height="63" style="cursor:pointer" onClick="uploadcoment();"></td>
					</tr>
					<tr>
						<td style="padding-top:8px;"><img src="http://fiximage.10x10.co.kr/web2011/designfingers/cmt_info.gif"></td>
					</tr>
					</table>
					<input name="tx_commentURL" id="tx_commentURL" type="hidden">
				<% end if %>
				</div>
				<script language="javascript">
				<!--
					parent.document.all.setDFCommTxt.innerHTML = document.all.getDFComm.innerHTML;
					self.location.href = "iframe_designfingers_comment.asp?iDFS=<%=masterid%>&iCC=1";
				//-->
				</script>
<%
				dbget.close()	:	response.End
	Case Else
			Alert_move "데이터처리에 문제가 발생했습니다. 관리자에게 문의해주세요","about:blank"
			dbget.close()	:	response.End
END SELECT



%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
