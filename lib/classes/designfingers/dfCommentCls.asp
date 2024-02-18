<%
'// 디자인 핑거스 코멘트
Class CDesignFingersComment
	public FRectFingerID
	public FCommentList()
	public FTotalCount
	public FResultCount

	public FCurrPage
	public FTotalPage
	public FPageSize
	public FScrollCount

	public FRectDelete
	public FRectTitle
	public FRectSiteName
	public FPCount
	public FRectSort
	public FRectUserId

	Private Sub Class_Initialize()
		redim preserve FCommentList(0)
		FCurrPage =1
		FPageSize = 20
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
		FRectSiteName = "10x10"
	End Sub

	Private Sub Class_Terminate()
		dim i
		for i= 0 to FResultCount
			set FCommentList(i) = nothing
		next
	End Sub

	public sub GetFingerUsing()
		dim sqlStr,i

		IF FRectUserId <> "" then

		sqlStr = "exec [db_sitemaster].[dbo].sp_Ten_designfingers_GetMyCommentCnt '" + Cstr(FRectFingerID) + "','" + FRectSiteName + "','"+ FRectUserId + "'" + vbcrlf

		else

		sqlStr = "exec [db_sitemaster].[dbo].sp_Ten_designfingers_GetCommentCnt '" + Cstr(FRectFingerID) + "','" + FRectSiteName + "'" + vbcrlf

		end IF

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr, dbget, 1

		FTotalCount = rsget("cnt")
		rsget.Close

		sqlStr = "exec [db_sitemaster].[dbo].sp_Ten_designfingers_GetComment_2013 '" + Cstr(FPageSize*FCurrPage) + "','" + Cstr(FRectFingerID) + "','" + FRectSiteName + "','" + FRectUserId + "'" + vbcrlf
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open sqlStr, dbget, 1

		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FPCount = FCurrPage - 1

		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

		redim preserve FCommentList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FCommentList(i) = new CFingerCommentItem

				FCommentList(i).FID      	= rsget("id")
				FCommentList(i).FFingerID	= FRectFingerID
				FCommentList(i).FUserID  	= rsget("userid")
				FCommentList(i).FIconID  	= rsget("iconid")
				FCommentList(i).FComment 	= db2Html(rsget("comment"))
				FCommentList(i).FRegdate 	= rsget("regdate")
				FCommentList(i).FDevice		= rsget("device")

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	end sub

	public Function HasPreScroll()
		HasPreScroll = StarScrollPage > 1
	end Function

	public Function HasNextScroll()
		HasNextScroll = FTotalPage > StarScrollPage + FScrollCount -1
	end Function

	public Function StarScrollPage()
		StarScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	end Function

	public Sub sbGetCommentDisplay
		Dim ix,i, arrComm
		FPageSize = 20
		FRectSiteName = "10x10"
		IF FCurrPage = "" THEN FCurrPage = 1
		GetFingerUsing
%>
	<div class="rt">
		<span class="badgeInfo" onmouseover="$(this).children('.contLyr').show();" onmouseout="$(this).children('.contLyr').hide();"><strong>10x10 BADGE</strong>
			<div class="contLyr" style="width:210px;">
				<div class="contLyrInner">
					<dl class="badgeDesp">
						<dt><strong>10X10 BADGE?</strong></dt>
						<dd>
							<p>고객님의 쇼핑패턴을 분석하여 자동으로 달아드리는 뱃지입니다. <br />후기작성 및 코멘트 이벤트 참여시 획득한 뱃지를 통해 타인에게 신뢰 및 어드바이스를 전달 해줄 수 있습니다.</p>
							<p class="tPad10">나의 뱃지는 <a href="/my10x10/" class="cr000 txtL">마이텐바이텐</a>에서 확인하실 수 있습니다.</p>
						</dd>
					</dl>
				</div>
			</div>
		</span>
		<a href="javascript:fnMyComment('<%=chkIIF(isMyComm="Y","N","Y")%>')"  class="lMar10 btn btnS2 btnGrylight btnW130"><em class="fn gryArr01"><%=chkIIF(isMyComm="Y","전체 코멘트 보기","내가 쓴 코멘트 보기")%></em></a>
	</div>
	<table class="tMar10">
		<caption>코멘트 리스트</caption>
		<colgroup>
			<col width="60px" /><col width="*" /><col width="60px" /><col width="115px" /><col width="10px" />
		</colgroup>
		<tbody>

		<% if FResultcount<1 then %>
		<!-- // 게시글이없을경우 // -->
			<tr>
				<td colspan="5">
					<p class="fb fs12 pad15 cr555">등록된 코멘트가 없습니다.</p>
				</td>
			</tr>
		<!-- // 게시글이없을경우 끝 // -->
		<% else %>

			<%
					dim arrUserid, bdgUid, bdgBno
					'사용자 아이디 모음 생성(for Badge)
					for ix = 0 to FResultcount-1
						arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(FCommentList(ix).FUserID) & "''"
					next

					'뱃지 목록 접수(순서 랜덤)
					Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")

			%>

		<% for ix=0 to FResultcount-1 %>
			<tr>
				<td class="colNo">
					<p><strong><% = (FTotalCount - (FPageSize * FPCount))- ix %></strong></p>
					<% If FCommentList(ix).FDevice <> "W" Then %><p class="tPad05"><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨" /></p><% End If %>
				</td>
				<td class="colCont">
					<div>
					<%
						if Not(FCommentList(ix).FComment="" or isNull(FCommentList(ix).FComment)) then
							arrComm = split(FCommentList(ix).FComment,"||,||")
							Response.Write arrComm(0)
							'URL이 존재하고 본인 또는 STAFF가 접속해있다면 링크 표시
							if Ubound(arrComm)>0 then
								if trim(arrComm(1))<>"" and (GetLoginUserLevel=7 or FCommentList(ix).FUserID=GetLoginUserID) then
									Response.Write "<br /><strong>URL: </strong><a href='" & ChkIIF(left(trim(arrComm(1)),4)="http","","http://") & arrComm(1) & "' target='_blank'>" & arrComm(1) & "</a>"

								end if
							end if
						end if
					%>
					</div>
				</td>
				<td class="colDate"><% = FormatDate(FCommentList(ix).FRegDate,"0000.00.00") %></td>
				<td class="colWriter">
					<p><strong>
						<% if FCommentList(ix).FUserID="10x10" then %>

						<% else %>
						<% = printUserId(FCommentList(ix).FUserID,2,"*") %>
						<% end if %>
					</strong></p>
					<p class="badgeView tPad05">
							<%=getUserBadgeIcon(FCommentList(ix).FUserID,bdgUid,bdgBno,3)%>
					</p>
				</td>
				<td class="colDel">
					<% if ((GetLoginUserID = FCommentList(ix).Fuserid) or (GetLoginUserID = "10x10")) and (FCommentList(ix).Fuserid<>"") then %>
					<a href="javascript:DelComments('<% = FCommentList(ix).FID %>')"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제" /></a>
					<% End If %>
				</td>
			</tr>


		<% next %>
		<% end if %>
		<!-- // 게시글 끝 // -->

		</tbody>
	</table>


	<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(iComCurrentPage,FTotalCount,FPageSize,10,"jsGoCommPage") %></div>



<%		END Sub
End Class

Class CFingerCommentItem
	public FID
	public FFingerID
	public FUserID
	public FIconID
	public FComment
	public FRegdate
	public FDevice

	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
end Class

Class CProcDesignFingers

	public Function fnSaveComment(byval userid,byval masterid,byval gubuncd,byval tx_comment, byval sitename, byval iconid)
		dim strSql
		dim refip
		Dim objCmd
		Dim intResult

		refip = request.ServerVariables("REMOTE_ADDR")
		Set objCmd = Server.CreateObject("ADODB.Command")
		With objCmd
			.ActiveConnection =  dbget
			.CommandType = adCmdText
			.CommandText = "{?=call [db_sitemaster].[dbo].sp_Ten_designfingers_SetComment("&gubuncd&","&masterid&",'"&userid&"','"&sitename&"','"&iconid&"','"&tx_comment&"','"&refip&"','W') }"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
		End With
		intResult = objCmd(0).Value
		Set objCmd = nothing

		fnSaveComment = intResult
	end Function

	public Function fnDelComment (byval userid,Byval id)
		dim strSql
		dim refip
		Dim objCmd
		Dim intResult
		Set objCmd = Server.CreateObject("ADODB.Command")
		With objCmd
			.ActiveConnection =  dbget
			.CommandType = adCmdText
			.CommandText = "{?=call [db_sitemaster].[dbo].sp_Ten_designfingers_SetDelComment("&id&",'"&userid&"')}"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
		End With
		intResult = objCmd(0).Value
		Set objCmd = nothing

		fnDelComment = intResult
	End Function

	public Function fnUpdateComment (byval gubun,Byval id,byval userid,byval tx_comment)
		dim strSql
		dim refip
		Dim objCmd
		Dim intResult
		Set objCmd = Server.CreateObject("ADODB.Command")
		If gubun = "V" Then
			rsget.Open "[db_sitemaster].[dbo].sp_Ten_designfingers_SetUpdateComment ('"&gubun&"',"&id&",'"&userid&"','"&tx_comment&"')", dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				intResult	= rsget(0)
			END IF
			rsget.close
		Else
			With objCmd
				.ActiveConnection =  dbget
				.CommandType = adCmdText
				.CommandText = "{?=call [db_sitemaster].[dbo].sp_Ten_designfingers_SetUpdateComment('"&gubun&"',"&id&",'"&userid&"','"&tx_comment&"')}"
				.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
				.Execute, , adExecuteNoRecords
			End With
			intResult = objCmd(0).Value
		End If
		Set objCmd = nothing

		fnUpdateComment = intResult
	End Function

	public Function fnSetWinner(byval userid,Byval id)
		dim strSql
		dim refip
		Dim objCmd
		Dim intResult

		Set objCmd = Server.CreateObject("ADODB.Command")
		With objCmd
			.ActiveConnection =  dbget
			.CommandType = adCmdText
			.CommandText = "{?=call [db_sitemaster].[dbo].sp_Ten_designfingers_SetWinner("&id&",'"&userid&"')}"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
		End With
		intResult = objCmd(0).Value
		Set objCmd = nothing

		fnDelComment = intResult
	End Function

End Class
%>
