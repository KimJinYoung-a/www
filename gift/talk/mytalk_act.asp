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
Dim vCurrPage, vSelectUserID, i, j, vSort, UserProfileImg, cTalkComm, beforepageminidx, beforepagedispyn
dim vtmpitemid, vtmpImageBasic, vtmpidx, vtmpTalkIdx, vtmpSelectoxab, vtmpgood
	vCurrPage = requestCheckVar(Request("cpg"),5)
	vSort = requestCheckVar(Request("sort"),1)
	beforepageminidx = getNumeric(requestCheckVar(request("beforepageminidx"),10))

If vCurrPage = "" Then vCurrPage = 1
beforepagedispyn="Y"

If isNumeric(vCurrPage) = False Then
	Response.Write "<script>alert('잘못된 경로입니다.');</script>"
	dbget.close() : Response.End
End If

vSelectUserID = GetLoginUserID()

Dim cTalk
SET cTalk = New CGiftTalk
	cTalk.FPageSize = 16
	cTalk.FCurrpage = vCurrPage
	cTalk.FRectUserId = GetLoginUserID()
	cTalk.FRectselectuserid = vSelectUserID
	'cTalk.FRectItemId = vItemID
	'cTalk.FRectTheme = vTheme
	'cTalk.FRectSort = vSort
	cTalk.FRectUseYN = "y"
	cTalk.getGiftTalkList

%>

<% If (cTalk.FResultCount < 1) Then %>
	<% if vCurrPage="1" then %>
		<script type="text/javascript">$("#nodata").show();</script>
	<% else %>
		<!--<script type="text/javascript">$("#nodata_act").show();</script>-->
	<% end if %>
<% Else %>
	<% ' <!-- for dev msg : A/B 선택일 경우에 클래스 wide 붙여주세요 class="article" → class="article wide" --> %>
	<% For i = 0 To cTalk.FResultCount-1 %>
	<%
	if vCurrPage>1 then
		'/이전페이지에 있는 내용은 제낀다.
		if CStr(beforepageminidx) > CStr(cTalk.FItemList(i).FTalkIdx) then
			
			beforepagedispyn="Y"
		else
			beforepagedispyn="N"
		end if
		'response.write beforepageminidx & "/" &  cTalk.FItemList(i).FTalkIdx & "/" & beforepagedispyn & "<br>"
	end if

	if beforepagedispyn="Y" then
	%>
		<%
		'//상품 2개 짜리
		If cTalk.FItemList(i).FTheme = "2" Then
		%>
			<%
			'//페이지 부하로 인하여 쿼리(조인방식으로 변경)해서 가져온후, 필요한 부분만 가공해서 뿌린다.		'//서이사님 지시
			if (CStr(vtmpTalkIdx)=CStr(cTalk.FItemList(i).FTalkIdx)) then
			%>
				<div class="article wide">
					<div class="desc">
						<div class="thumb">
							<a href="/shopping/category_prd.asp?itemid=<%= vtmpitemid %>" target="_blank" title="새창">
							<img src="<%=getThumbImgFromURL(vtmpImageBasic,230,230,"true","false")%>" alt="<%= vtmpitemid %>" width='230' height='230' /></a>
							<a href="/shopping/category_prd.asp?itemid=<%= cTalk.FItemList(i).fitemid %>" target="_blank" title="새창">
							<img src="<%=getThumbImgFromURL(cTalk.FItemList(i).FImageBasic,230,230,"true","false")%>" alt="<%= cTalk.FItemList(i).fitemid %>" width='230' height='230' /></a>
						</div>
						<div class="vote">
							<div class="button">
								<span id="btgood<%= vtmpIdx %>" <% If vtmpSelectoxab ="A" then%> class='on' <% End if %>>
								<button onclick="jsTalkvote('<%= vtmpidx %>','<%= vtmpTalkIdx %>','good','<%= i %>','<%= cTalk.FItemList(i).FTheme %>','A'); return false;" type="button">A 선택 </button> 
								<em id="countgood<%= vtmpIdx %>"><%= vtmpgood %></em></span>
							</div>
							<div class="button">
								<span id="btgood<%= cTalk.FItemList(i).FIdx %>" <% If cTalk.FItemList(i).FSelectoxab ="B" then%> class='on' <% End if %>>
								<button onclick="jsTalkvote('<%= cTalk.FItemList(i).Fidx %>','<%= cTalk.FItemList(i).FTalkIdx %>','good','<%= i %>','<%= cTalk.FItemList(i).FTheme %>','B'); return false;" type="button">B 선택 </button> 
								<em id="countgood<%= cTalk.FItemList(i).FIdx %>"><%= cTalk.FItemList(i).fgood %></em></span>
							</div>
						</div>
					</div>
				
					<div class="topic">
						<p class="question"><%=chrbyte(cTalk.FItemList(i).FContents,200,"Y")%></p>
						<div class="profile">
							<strong class="id"><%=printUserId(cTalk.FItemList(i).FUserID,2,"*")%> <% If cTalk.FItemList(i).FDevice = "m" Then %><img src="http://fiximage.10x10.co.kr/web2013/gift/ico_mobile.gif" alt="모바일에서 작성" /><% End If %></strong>
							<span class="date"><%=FormatDate(cTalk.FItemList(i).FRegdate,"0000.00.00")%></span>
						</div>
		
						<% If cTalk.FItemList(i).FUserID = GetLoginUserID() Then %>
							<div class="btnwrap">
								<a href="" onClick="goPopTalkModify('<%= cTalk.FItemList(i).FTalkIdx %>'); return false;" >수정</a>
								<button onClick="jsMyTalkEdit('<%=cTalk.FItemList(i).FTalkIdx%>'); return false;" type="button">삭제</button>
							</div>
						<% end if %>
					</div>
					<div class="comment">
						<% '<!-- for dev msg : 코멘트가 없는 경우 a에 클래스 nocmt를 붙여주세요 / 코멘트가 있는 경우에는 total --> %>
						<p class="headline" id="commentcnt<%= cTalk.FItemList(i).FTalkIdx %>" commentcnt="<%= cTalk.FItemList(i).FCommCnt %>">
							<% If cTalk.FItemList(i).FCommCnt > 0 Then %>
								<a href='' onclick="getcommentlist_act('1','<%=cTalk.FItemList(i).FTalkIdx%>'); return false;" talkidx='<%= cTalk.FItemList(i).FTalkIdx %>' class='total'>
								<strong><%= cTalk.FItemList(i).FCommCnt %></strong>개의 코멘트</a>
							<% else %>
								<a href='' onclick="dispcomment('<%=cTalk.FItemList(i).FTalkIdx%>','1'); return false;" class='nocmt'>코멘트를 작성해주세요.</a>
							<% End if %>
		
							<a href='' onclick="dispcomment('<%=cTalk.FItemList(i).FTalkIdx%>','1'); return false;" class='btnwrite'>쓰기</a>
						</p>
					</div>
					<div class="cmtwrite" id="cmtwrite<%= cTalk.FItemList(i).FTalkIdx %>">
						<div class="inner">
							<fieldset>
							<legend>코멘트 작성하기</legend>
								<textarea id="contents<%= cTalk.FItemList(i).FTalkIdx %>" name="contents<%= cTalk.FItemList(i).FTalkIdx %>" onClick="jsCheckLimit('<%= cTalk.FItemList(i).FTalkIdx %>');" onKeyUp="jsCheckLimit('<%= cTalk.FItemList(i).FTalkIdx %>');" <%IF  NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="50" rows="50" title="코멘트 작성"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% Else %>100자 이내로 입력해주세요.<%END IF%></textarea>
								<p class="etiquette">주제와 적합하지 않은 의견은 삭제 될 수 있습니다.</p>
								<input type="submit" onclick="talkcommentreg('<%= cTalk.FItemList(i).FTalkIdx %>'); return false;" value="남기기" />
							</fieldset>
						</div>
						<div class="btnclose"><button type="button" onclick="dispcomment('<%=cTalk.FItemList(i).FTalkIdx%>','2'); return false;"><span>닫기</span></button></div>
					</div>
					<div id="comment<%= cTalk.FItemList(i).FTalkIdx %>" class="commentlist"></div>
				</div>
				<%
				vtmpitemid=""
				vtmpImageBasic=""
				vtmpidx=""
				vtmpTalkIdx=""
				vtmpSelectoxab=""
				vtmpgood=""
				%>	
			<% else %>
				<%
				vtmpitemid=cTalk.FItemList(i).fitemid
				vtmpImageBasic=cTalk.FItemList(i).FImageBasic
				vtmpidx=cTalk.FItemList(i).Fidx
				vtmpTalkIdx=cTalk.FItemList(i).FTalkIdx
				vtmpSelectoxab=cTalk.FItemList(i).FSelectoxab
				vtmpgood=cTalk.FItemList(i).fgood
				%>
			<% end if %>
	
		<%
		'/상품 1개 짜리
		Else
		%>
			<div class="article">
				<div class="desc">
					<div class="thumb">
						<a href="/shopping/category_prd.asp?itemid=<%= cTalk.FItemList(i).fitemid %>" target="_blank" title="새창">
						<img src="<%=getThumbImgFromURL(cTalk.FItemList(i).FImageBasic,230,230,"true","false")%>" alt="<%= cTalk.FItemList(i).fitemid %>" width='230' height='230' /></a>
					</div>
					<div class="vote">
						<div class="button">
							<span id="btgood<%= cTalk.FItemList(i).FIdx %>" <% If cTalk.FItemList(i).FSelectoxab ="O" then%> class='on' <% End if %>>
							<button onclick="jsTalkvote('<%= cTalk.FItemList(i).fidx %>','<%=cTalk.FItemList(i).FTalkIdx%>','good','<%=i%>','<%=cTalk.FItemList(i).FTheme%>','O');" type="button">찬성</button> 
							<em id="countgood<%= cTalk.FItemList(i).FIdx %>"><%= cTalk.FItemList(i).fgood %></em></span>
						</div>
						<div class="button">
							<span id="btbad<%= cTalk.FItemList(i).FIdx %>" <% If cTalk.FItemList(i).FSelectoxab ="X" then%> class='on' <% End if %>>
							<button onclick="jsTalkvote('<%= cTalk.FItemList(i).fidx %>','<%=cTalk.FItemList(i).FTalkIdx%>','bad','<%=i%>','<%=cTalk.FItemList(i).FTheme%>','X');" type="button">반대</button> 
							<em id="countbad<%= cTalk.FItemList(i).FIdx %>"><%= cTalk.FItemList(i).fbad %></em></span>
						</div>
					</div>
				</div>
	
				<div class="topic">
					<p class="question"><%=chrbyte(cTalk.FItemList(i).FContents,200,"Y")%></p>
					<div class="profile">
						<strong class="id"><%=printUserId(cTalk.FItemList(i).FUserID,2,"*")%> <% If cTalk.FItemList(i).FDevice = "m" Then %><img src="http://fiximage.10x10.co.kr/web2013/gift/ico_mobile.gif" alt="모바일에서 작성" /><% End If %></strong>
						<span class="date"><%=FormatDate(cTalk.FItemList(i).FRegdate,"0000.00.00")%></span>
					</div>
	
					<% If cTalk.FItemList(i).FUserID = GetLoginUserID() Then %>
						<div class="btnwrap">
							<a href="" onClick="goPopTalkModify('<%= cTalk.FItemList(i).FTalkIdx %>'); return false;" >수정</a>
							<button onClick="jsMyTalkEdit('<%=cTalk.FItemList(i).FTalkIdx%>'); return false;" type="button" class="del">삭제</button>
						</div>
					<% end if %>
				</div>
				<div class="comment">
					<p class="headline" id="commentcnt<%= cTalk.FItemList(i).FTalkIdx %>" commentcnt="<%= cTalk.FItemList(i).FCommCnt %>">
						<% If cTalk.FItemList(i).FCommCnt > 0 Then %>
							<a href='' onclick="getcommentlist_act('1','<%=cTalk.FItemList(i).FTalkIdx%>'); return false;" talkidx='<%= cTalk.FItemList(i).FTalkIdx %>' class='total'>
							<strong><%= cTalk.FItemList(i).FCommCnt %></strong>개의 코멘트</a> 
						<% else %>
							<a href='' onclick="dispcomment('<%=cTalk.FItemList(i).FTalkIdx%>','1'); return false;" class='nocmt'>코멘트를 작성해주세요.</a> 
						<% End if %>
	
						<a href='' onclick="dispcomment('<%=cTalk.FItemList(i).FTalkIdx%>','1'); return false;" class='btnwrite'>쓰기</a>
					</p>
				</div>
				<div class="cmtwrite" id="cmtwrite<%= cTalk.FItemList(i).FTalkIdx %>">
					<div class="inner">
						<fieldset>
						<legend>코멘트 작성하기</legend>
							<textarea id="contents<%= cTalk.FItemList(i).FTalkIdx %>" name="contents<%= cTalk.FItemList(i).FTalkIdx %>" onClick="jsCheckLimit('<%= cTalk.FItemList(i).FTalkIdx %>');" onKeyUp="jsCheckLimit('<%= cTalk.FItemList(i).FTalkIdx %>');" <%IF  NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="50" rows="50" title="코멘트 작성"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% Else %>100자 이내로 입력해주세요.<%END IF%></textarea>
							<p class="etiquette">주제와 적합하지 않은 의견은 삭제 될 수 있습니다.</p>
							<input type="submit" onclick="talkcommentreg('<%= cTalk.FItemList(i).FTalkIdx %>'); return false;" value="남기기" />
						</fieldset>
					</div>
					<div class="btnclose"><button type="button" onclick="dispcomment('<%=cTalk.FItemList(i).FTalkIdx%>','2'); return false;"><span>닫기</span></button></div>
				</div>
				<div id="comment<%= cTalk.FItemList(i).FTalkIdx %>" class="commentlist"></div>
			</div>
		<% end if %>
	<% End If %>
	
	<% if i = cTalk.FResultCount-1 then %>
		<script type="text/javascript">
			mygiftfrm.beforepageminidx.value="<%= cTalk.FItemList(i).FTalkIdx %>"
		</script>
	<% End If %>
	<% Next %>
<% End If %>

<% SET cTalk = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->