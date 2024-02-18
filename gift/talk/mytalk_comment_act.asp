<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'###########################################################
' Description :  기프트
' History : 2015.02.09 한용민 생성
'###########################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/classes/gift/giftCls.asp" -->
<!-- #include virtual="/gift/lib/giftFunction.asp" -->
<!-- #include virtual="/gift/Underconstruction_gift.asp" -->
<%
dim talkidx, arrUserid, bdgUid, bdgBno, z, vCurrPage
	talkidx = requestCheckVar(Request("talkidx"),10)
	vCurrPage = requestCheckVar(Request("cpg"),5)

If vCurrPage = "" Then vCurrPage = 1

If isNumeric(vCurrPage) = False Then
	Response.Write "<script>alert('잘못된 경로입니다[1].');</script>"
	dbget.close() : Response.End
End If
If isNumeric(talkidx) = False Then
	Response.Write "<script>alert('잘못된 경로입니다[2].');</script>"
	dbget.close() : Response.End
End If

dim cTalkComm
SET cTalkComm = New CGiftTalk
	cTalkComm.FPageSize = 3
	cTalkComm.FCurrpage = vCurrPage
	cTalkComm.FRectTalkIdx = talkidx
	'cTalkComm.FRectUserId = vUserID
	cTalkComm.FRectUseYN = "y"
	cTalkComm.fnGiftTalkCommList
%>
<% If (cTalkComm.FResultCount > 0) Then %>
	<ul>
		<%
		'사용자 아이디 모음 생성(for Badge)
		For z = 0 To cTalkComm.FResultCount-1
			arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(cTalkComm.FItemList(z).FUserID) & "''"
		Next
	
		'뱃지 목록 접수(순서 랜덤)
		Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")
		
		For z = 0 To cTalkComm.FResultCount-1 
		%>
		<li>
			<span class="no"><%=cTalkComm.FTotalCount-z-(cTalkComm.FPageSize*(cTalkComm.FCurrPage-1))%></span>
			<div class="substance">
				<p>
					<%=cTalkComm.FItemList(z).FContents%>
				</p>
				<div class="author">
					<div class="badge">
						<strong class="id"><%=CHKIIF(cTalkComm.FItemList(z).FUserID="10x10","텐바이텐",printUserId(cTalkComm.FItemList(z).FUserID,2,"*"))%></strong>
						<span>
							<%=getUserBadgeIcon(cTalkComm.FItemList(z).FUserID,bdgUid,bdgBno,3)%>
						</span>

						<% If cTalkComm.FItemList(z).FUserID = GetLoginUserID() Then %>
							<button type="button" onClick="DelComments('<%=talkidx%>','<%=cTalkComm.FItemList(z).FIdx%>'); return false;" class="del">삭제</button>
						<% End if %>						
					</div>
					<span class="date">
						<%=FormatDate(cTalkComm.FItemList(z).FRegdate,"0000.00.00")%>
	
						<% If cTalkComm.FItemList(z).FDevice = "m" Then %>
							<img src="http://fiximage.10x10.co.kr/web2013/gift/ico_mobile.gif" alt="모바일에서 작성" />
						<% end if %>
					</span>
				</div>
			</div>
		</li>
		<% next %>
	</ul>
	<!-- paging -->
	<div class="paging">
		<a href="" onclick="getcommentlist_act('1','<%= talkidx %>'); return false;" class="first arrow"><span>맨 처음 페이지로 이동</span></a>
		
		<% if cTalkComm.FCurrPage > 1 then %>
			<a href="" onclick="getcommentlist_act('<%= cTalkComm.FCurrPage-1 %>','<%= talkidx %>'); return false;" class="prev arrow"><span>이전페이지로 이동</span></a>
		<% else %>
			<a href="" onclick="alert('이전페이지가 없습니다.'); return false;" class="prev arrow"><span>이전페이지로 이동</span></a>
		<% end if %>

		<% for z = 0 + cTalkComm.StartScrollPage to cTalkComm.StartScrollPage + cTalkComm.FScrollCount - 1 %>
			<% if (z > cTalkComm.FTotalpage) then Exit for %>
			<% if CStr(z) = CStr(cTalkComm.FCurrPage) then %>
				<a href="" onclick="return false;" class="current"><span><%= z %></span></a>
			<% else %>
				<a href="" onclick="getcommentlist_act('<%= z %>','<%= talkidx %>'); return false;"><span><%= z %></span></a>
			<% end if %>
		<% next %>
		
		<% if clng(cTalkComm.FTotalpage) > clng(cTalkComm.FCurrPage) then %>
			<a href="" onclick="getcommentlist_act('<%= cTalkComm.FCurrPage+1 %>','<%= talkidx %>'); return false;" class="next arrow"><span>다음 페이지로 이동</span></a>
		<% else %>
			<a href="" onclick="alert('다음페이지가 없습니다.'); return false;" class="next arrow"><span>다음 페이지로 이동</span></a>
		<% end if %>

		<a href="" onclick="getcommentlist_act('<%= cTalkComm.FTotalpage %>','<%= talkidx %>'); return false;" class="end arrow"><span>맨 마지막 페이지로 이동</span></a>
	</div>
	<div class="btnclose"><button type="button" onclick="dispcommentlist('<%=talkidx%>','2'); return false;">닫기</button></div>
<% End if %>

<% SET cTalkComm = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
