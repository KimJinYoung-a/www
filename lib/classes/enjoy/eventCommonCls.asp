<%
'===============================================================
' 이벤트 관련 공통 함수
'===============================================================
Class CEventCommon
	public FEvtKind
	public FTopCnt
	
	'이벤트 최근 리스트 가져오기
	public Function fnGetRecent
		Dim strSql
		strSql = "[db_event].[dbo].[sp_Ten_event_GetRecentList] ("&FEvtKind&","&FTopCnt&")"			
		rsget.Open strSql, dbget,  adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF not rsget.EOF THEN
			fnGetRecent = rsget.getRows()
		END IF	
		rsget.close
	End Function
End Class

'===============================================================
' 코멘트
'===============================================================
Class CEventComment
	public FECode
	public FEKind
	public FMidx
	
	public FCPage	'Set 현재 페이지
 	public FPSize	'Set 페이지 사이즈 	
 	public FTotCnt	'Get 전체 레코드 갯수
	
	'##### 위클리코디 코멘트 ######
	public Function fnGetWCComment
		Dim strSql 
		IF FECode = "" THEN FECode = 0
		IF FMidx = "" THEN FMidx = 0
		
		strSql ="[db_sitemaster].[dbo].sp_Ten_weeklycodicomment_GetList ("&FECode&", "&FMidx&","&FCPage&","&FPSize&","&FTotCnt&")"			
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
	
		IF Not (rsget.EOF OR rsget.BOF) THEN	
			IF isNull(rsget(0)) THEN 
				FTotCnt = 0				
			ELSE
				FTotCnt = rsget(4)	
				fnGetWCComment = rsget.GetRows()
			END IF				
		END IF	
		
		rsget.close					
	End Function			

	'##### 러브하우스 코멘트 ######
		public Function fnGetLHComment
		Dim strSql
		strSql ="[db_sitemaster].[dbo].sp_Ten_lovehousecomment_GetList ("&FMidx&","&FCPage&","&FPSize&","&FTotCnt&")"				
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN			
			IF isNull(rsget(0)) THEN 
				FTotCnt = 0				
			ELSE
				FTotCnt = rsget(4)	
				fnGetLHComment = rsget.GetRows()
			END IF					
		END IF	
		rsget.close								
	End Function
	
	'##### 코멘트 디스플레이 ######
	public Function sbGetComment
		Dim iPerCnt
		FPSize 	=12
		iPerCnt= 10

		IF CStr(FEKind) = "7" THEN
			sbGetComment = fnGetWCComment
		ELSEIF Cstr(FEKind) ="10" THEN
			sbGetComment = fnGetLHComment	
		END IF	
	End Function

	public Sub sbPrintCommentArray(arrList)
		Dim intLoop,iPerCnt
		FPSize 	=12
		iPerCnt= 10
%>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">	
	<%	IF isArray(arrList) THEN			
			For intLoop = 0 To UBound(arrList,2)					
	%>
	<tr>
		<td style="padding:20px 0 15px 0; border-bottom:1px solid #f0f0f0;"><!-- // 코멘트 리스트 시작 // -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr><!-- // 게시글 시작 12개 글 보여짐 // -->
				<td width="85" align="center"><font class="eng11pxgray"><%=FTotCnt-intLoop-(FPSize*(FCPage-1))%></td>
			    <td><%=nl2br(ReplaceBracket(db2html(arrList(1,intLoop))))%></td>
			    <td width="150" align="center">
			    	<font class="eng11px00">
			    	<%if arrList(2,intLoop) = "10x10" then%><img src="http://fiximage.10x10.co.kr/web2007/enjoy_event/1010_icon.gif"  border="0"><%else%><%=printUserId(arrList(2,intLoop),2,"*")%><%end if%>
			    	</font><br>
			    	<font class="verdanalgrey"><% = FormatDate(arrList(3,intLoop),"0000.00.00") %></font><br>
	           		<% if ((GetLoginUserID = arrList(2,intLoop)) or (GetLoginUserID = "10x10")) and ( arrList(2,intLoop)<>"") then %>
						&nbsp;<a href="javascript:jsDelComment('<% = arrList(0,intLoop) %>')"><img src="http://fiximage.10x10.co.kr/web2009/common/cmt_del.gif" width="19" height="11" style="margin-top:5px;"></a>
					<% end if %>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<%		Next
		ELSE
	%>	
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:30px 0 30px 0; border-bottom:1px solid #f0f0f0;" align="center">해당 게시물이 없습니다.</td>
			</tr>
			</table>
		</td>	
	</tr>
	<%	END IF	%>						
	<tr>
		<td height="34">
			<table border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <!-- // 코멘트넘버 시작 숫자 10페이지까지표시// -->
	          <td  align="center" style="padding:15px 0 0 0;"><%= fnDisplayPaging_New(FCPage,FTotCnt,FPSize,iPerCnt,"jsGoPage") %></td>
	        </tr>
	        <!-- // 코멘트넘버 끝// -->
	    	</table>
		</td>
	</tr>
	</table>
<%
	End Sub

End Class
'===============================================================
' 지난 리스트
'===============================================================
Class CEventLastList
	public FECode
	public FEKind
	public FMidx
	public FImgURL
		
	public FResultCount
	
	public FCPage	'Set 현재 페이지
 	public FPSize	'Set 페이지 사이즈 	
 	public FTotCnt	'Get 전체 레코드 갯수

	'##### 위클리코디  지난 리스트 ######
	public Function fnGetWCLastList
		Dim strSql, arrList				
			strSql ="[db_sitemaster].[dbo].sp_Ten_weeklycodi_GetLastList("&FPSize*FCPage&","&FTotCnt&")"			
			rsget.pagesize = FPSize	
			rsget.CursorLocation = adUseClient
			rsget.CursorType = adOpenStatic
			rsget.LockType = adLockOptimistic
			rsget.Open strSql,dbget,1
			FResultCount = rsget.Recordcount
			IF Not (rsget.EOF OR rsget.BOF) THEN	
				rsget.absolutepage = FCPage	
				IF isNull(rsget(0)) THEN 
					FTotCnt = 0				
				ELSE
					FTotCnt = rsget(5)	
					FImgURL = staticImgUrl&"/contents/weeklycodi/"
					fnGetWCLastList = rsget.GetRows()
				END IF
			END IF	
			rsget.close		
	End Function
	
	'##### 러브하우스 당첨  지난 리스트 ######
	public Function fnGetLHWinLastList
		Dim strSql 
		strSql ="[db_sitemaster].[dbo].sp_Ten_lovehousewinner_GetLastList("&FCPage&","&FPSize&","&FTotCnt&")"					
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN			
			IF isNull(rsget(0)) THEN 
					FTotCnt = 0				
			ELSE
				FTotCnt = rsget(5)	
				FImgURL = staticImgUrl&"/contents/lovehousewin/"				
				fnGetLHWinLastList = rsget.GetRows()
			END IF	
		END IF	
		rsget.close			
	End Function		

	'##### 디자인파이터  지난 리스트 ######
	public Function fnGetDFLastList
		Dim strSql 			
		strSql ="[db_sitemaster].[dbo].sp_Ten_designfighter_GetLastList("&FCPage&","&FPSize&","&FTotCnt&")"							
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN			
			IF isNull(rsget(0)) THEN 
					FTotCnt = 0				
			ELSE
				FTotCnt = rsget(5)	
				FImgURL = staticImgUrl&"/contents/designfighter/"			
				fnGetDFLastList = rsget.GetRows()
			END IF	
		END IF	
		rsget.close			
	End Function	
	
	'##### 지난리스트 디스플레이 ######
	public Sub sbGetLastList
		Dim arrList , inLX
		Dim intLoop,iPerCnt, iTotalPage,iStartPage,iEndPage,ix
		FPSize 	= 5
		iPerCnt= 10
		
		IF CStr(FEKind) = "7" THEN
			arrList = fnGetWCLastList
		ELSEIF Cstr(FEKind) = "10" THEN
			arrList = fnGetLHWinLastList	
		ELSEIF Cstr(FEKind) ="6" THEN
			arrList = fnGetDFLastList	
		END IF	
%>
	<script language="javascript">
	<!--
	// 리스트 페이지이동
	function jsGoListPage(iP){	
		iframeDB.location.href = "/guidebook/lib/iframe_lastlist.asp?eventid=<%=FECode%>&idx=<%=FMidx%>&iEK=<%=FEKind%>&iLTC=<%=FTotCnt%>&iLC="+iP;
	}
		
	//-->
	</script>
	<table width="930" border="0" cellspacing="0" cellpadding="0">
	<tr height="10"><td></td></tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="24">
			<tr>
				<td>
					<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="http://fiximage.10x10.co.kr/web2010/weekly/tit_weekly_list.gif"></td>
						<td style="padding:2px 0 0 10px;"><font class="verdanabk">/ Total</font> <font class="verdanabkbold"><%=arrList(5,intLoop)%></font></td>
					</tr>
					</table>
				</td>
			</tr>
			</table>
	    </td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="border-bottom:1px solid #eaeaea;padding:15px 0px 25px 0px;">
					<table border="0" cellspacing="0" cellpadding="0">
					<tr>
		<%	IF isArray(arrList) THEN
			    For intLoop = 0 To UBound(arrList,2)	
		%>
						<td width="195" valign="top">
							<table width="150" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<!-- 이미지 -->
			        			<%IF (Cstr(iEvtKind) = "7" and Cstr(arrList(0,intLoop)) <> "0") THEN%>
			       					<a href="javascript:jsLastGoUrl(<%=arrList(0,intLoop)%>,'0');" onFocus="this.blur();"><img src="<%=arrList(4,intLoop)%>" border="0"></a>
								<%ELSEIF (Cstr(iEvtKind) = "7" and Cstr(arrList(1,intLoop)) <> "0") THEN%>
									<a href="javascript:jsLastGoUrl(<%=arrList(0,intLoop)%>,'<%=arrList(1,intLoop)%>');" onFocus="this.blur();"><img src="<%=FImgURL&arrList(4,intLoop)%>" border="0"></a>
								<%ELSE%>
		                    		<a href="javascript:jsLastGoUrl(<%=arrList(0,intLoop)%>,'0');" onFocus="this.blur();"><img src="<%=FImgURL&arrList(4,intLoop)%>" border="0"></a>
								<%END IF%>
								</td>
							</tr>
							<tr>
								<td style="padding:10px 0 0 0;">
								<!-- 제목 -->
									<a href="javascript:jsLastGoUrl(<%=arrList(0,intLoop)%>,'0');" class="link_gray11px01" target="_top"><%IF iEvtKind="10" THEN %><%=FormatDate(arrList(3,intLoop),"0000.00")%><%ELSE%><%=chrbyte(db2html(arrList(3,intLoop)),45,"Y")%><%END IF%></a>
								</td>
							</tr>
							<tr>
								<td height="24">
									<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><img src="http://fiximage.10x10.co.kr/web2009/designfingers/df_list_cmt.gif" width="35" height="14" align="absmiddle" style="margin-left:4px;"></td>
										<td style="padding:0 0 0 5px;"><font class="verdanabkbold"><%=arrList(7,intLoop)%></font></td>
										<!--당첨자 발표 됐을 경우-->
										<% If arrList(6,intLoop)>0 Then %>
										<td style="padding:0 0 0 5px;"><a href="javascript:jsLastGoUrl(<%=arrList(0,intLoop)%>,'0');" onFocus="blur()" target="_top"><img src="http://fiximage.10x10.co.kr/web2009/designfingers/df_ico_winner.gif" width="57" height="11"></a></td>
										<% End If %>
									</tr>
									</table>
								</td>
							</tr>
							</table>
						</td>
		<%		Next	%>
		<%		For inLX = intLoop To 3	%>
		    			<td width="195">&nbsp;</td>
		<%		Next	%>
		<%	ELSE	%>
			    		<td align="center" class="dotum11">해당 게시물이 없습니다.</td>
		<%	END IF	%>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" height="30" valign="bottom" style="padding:15px 0 0 0;"><%= fnDisplayPaging_New(FCPage,FTotCnt,FPSize,iPerCnt,"jsGoListPage") %></td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
<%
	End Sub
End Class
%>
