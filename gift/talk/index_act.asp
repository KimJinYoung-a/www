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
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/classes/gift/giftCls.asp" -->
<!-- #include virtual="/gift/lib/giftFunction.asp" -->
<!-- #include virtual="/gift/Underconstruction_gift.asp" -->
<%
Dim vCurrPage, vSelectUserID, i, j, vSort, UserProfileImg, cTalkComm
dim vtmpitemid, vtmpImageBasic, vtmpidx, vtmpTalkIdx, vtmpSelectoxab, vtmpgood
	vCurrPage = requestCheckVar(Request("cpg"),5)
	vSort = requestCheckVar(Request("sort"),1)

If vCurrPage = "" Then vCurrPage = 1

If isNumeric(vCurrPage) = False Then
	Response.Write "<script>alert('잘못된 경로입니다.');</script>"
	dbget.close() : Response.End
End If

vSelectUserID = GetLoginUserID()

dim maxvCurrPage, PageSize1, PageSize2
IF application("Svr_Info")="Dev" THEN
	maxvCurrPage=5
else
	maxvCurrPage=50
end if
PageSize1=8
PageSize2=8

'//기획단에서 원하는것을 구현하기 위해서, 페이징을 2개를 따로 두고 하나의 페이지로 뿌리기로 합의봄.
'//서로다른 페이징 값을 가져 와서 뿌려서, 페이지 뒤로가면, 에러가 무조건 나게되니 그부분 짤라버림.
Dim cTalk1
SET cTalk1 = New CGiftTalk
	cTalk1.FPageSize = PageSize1
	cTalk1.FCurrpage = vCurrPage
	'cTalk1.FRectUserId = GetLoginUserID()
	cTalk1.FRectselectuserid = vSelectUserID
	'cTalk1.FRectItemId = vItemID
	cTalk1.FRectTheme = "1"
	'cTalk1.FRectSort = vSort
	cTalk1.FRectUseYN = "y"

	'//맥스페이지 뒤로 짤라버림
	if clng(maxvCurrPage) > clng(vCurrPage) then
		cTalk1.getGiftTalkmain
	end if

Dim cTalk2
SET cTalk2 = New CGiftTalk
	cTalk2.FPageSize = PageSize2
	cTalk2.FCurrpage = vCurrPage
	'cTalk2.FRectUserId = GetLoginUserID()
	cTalk2.FRectselectuserid = vSelectUserID
	'cTalk2.FRectItemId = vItemID
	cTalk2.FRectTheme = "2"
	'cTalk2.FRectSort = vSort
	cTalk2.FRectUseYN = "y"

	'//맥스페이지 뒤로 짤라버림
	if clng(maxvCurrPage) > clng(vCurrPage) then
		cTalk2.getGiftTalkmain
	end if

%>
<% 
'/갯수가 정확하게 맞지 않으면 뿌리지 않음 다 짤라버림
If cTalk1.FResultCount < 1 or cTalk1.FResultCount < PageSize1 or cTalk2.FResultCount < PageSize2 Then
%>
	<% if vCurrPage="1" then %>
		<script type="text/javascript">$("#nodata").show();</script>
	<% else %>
		<!--<script type="text/javascript">$("#nodata_act").show();</script>-->
	<% end if %>
<% Else %>
	<% ' <!-- for dev msg : A/B 선택일 경우에 클래스 wide 붙여주세요 class="article" → class="article wide" --> %>
	<%
	'/2개짜리 첫번째 (1개만 뿌림)
	if cTalk2.FResultCount > 1 then
	%>
		<% For j = 0 To 1 %>
		<% If cTalk2.FItemList(j).FTheme = "2" Then %>
			<%
			'//페이지 부하로 인하여 쿼리(조인방식으로 변경)해서 가져온후, 필요한 부분만 가공해서 뿌린다.		'//서이사님 지시
			if (CStr(vtmpTalkIdx)=CStr(cTalk2.FItemList(j).FTalkIdx)) then
			%>
				<div class="article wide">
					<div class="desc">
						<div class="thumb">
							<a href="/shopping/category_prd.asp?itemid=<%= vtmpitemid %>" target="_blank" title="새창">
							<img src="<%=getThumbImgFromURL(vtmpImageBasic,230,230,"true","false")%>" alt="<%= vtmpitemid %>" width='230' height='230' /></a>
							<a href="/shopping/category_prd.asp?itemid=<%= cTalk2.FItemList(j).fitemid %>" target="_blank" title="새창">
							<img src="<%=getThumbImgFromURL(cTalk2.FItemList(j).FImageBasic,230,230,"true","false")%>" alt="<%= cTalk2.FItemList(j).fitemid %>" width='230' height='230' /></a>
						</div>
						<div class="vote">
							<div class="button">
								<span id="btgood<%= vtmpIdx %>" <% If vtmpSelectoxab ="A" then%> class='on' <% End if %>>
								<button onclick="jsTalkvote('<%= vtmpidx %>','<%= vtmpTalkIdx %>','good','<%= i %>','<%= cTalk2.FItemList(j).FTheme %>','A'); return false;" type="button">A 선택 </button> 
								<em id="countgood<%= vtmpIdx %>"><%= vtmpgood %></em></span>
							</div>
							<div class="button">
								<span id="btgood<%= cTalk2.FItemList(j).FIdx %>" <% If cTalk2.FItemList(j).FSelectoxab ="B" then%> class='on' <% End if %>>
								<button onclick="jsTalkvote('<%= cTalk2.FItemList(j).Fidx %>','<%= cTalk2.FItemList(j).FTalkIdx %>','good','<%= i %>','<%= cTalk2.FItemList(j).FTheme %>','B'); return false;" type="button">B 선택 </button> 
								<em id="countgood<%= cTalk2.FItemList(j).FIdx %>"><%= cTalk2.FItemList(j).fgood %></em></span>
							</div>
						</div>
					</div>
				
					<div class="topic">
						<p class="question"><%=chrbyte(cTalk2.FItemList(j).FContents,200,"Y")%></p>
						<div class="profile">
							<strong class="id"><%=printUserId(cTalk2.FItemList(j).FUserID,2,"*")%> <% If cTalk2.FItemList(j).FDevice = "m" Then %><img src="http://fiximage.10x10.co.kr/web2013/gift/ico_mobile.gif" alt="모바일에서 작성" /><% End If %></strong>
							<span class="date"><%=FormatDate(cTalk2.FItemList(j).FRegdate,"0000.00.00")%></span>
						</div>
		
						<% If cTalk2.FItemList(j).FUserID = GetLoginUserID() Then %>
							<div class="btnwrap">
								<a href="" onClick="goPopTalkModify('<%= cTalk2.FItemList(j).FTalkIdx %>'); return false;" >수정</a>
								<button onClick="jsMyTalkEdit('<%=cTalk2.FItemList(j).FTalkIdx%>'); return false;" type="button">삭제</button>
							</div>
						<% end if %>
					</div>
					<div class="comment">
						<% '<!-- for dev msg : 코멘트가 없는 경우 a에 클래스 nocmt를 붙여주세요 / 코멘트가 있는 경우에는 total --> %>
						<p class="headline" id="commentcnt<%= cTalk2.FItemList(j).FTalkIdx %>" commentcnt="<%= cTalk2.FItemList(j).FCommCnt %>">
							<% If cTalk2.FItemList(j).FCommCnt > 0 Then %>
								<a href='' onclick="getcommentlist_act('1','<%=cTalk2.FItemList(j).FTalkIdx%>'); return false;" talkidx='<%= cTalk2.FItemList(j).FTalkIdx %>' class='total'>
								<strong><%= cTalk2.FItemList(j).FCommCnt %></strong>개의 코멘트</a>
							<% else %>
								<a href='' onclick="dispcomment('<%=cTalk2.FItemList(j).FTalkIdx%>','1'); return false;" class='nocmt'>코멘트를 작성해주세요.</a>
							<% End if %>
		
							<a href='' onclick="dispcomment('<%=cTalk2.FItemList(j).FTalkIdx%>','1'); return false;" class='btnwrite'>쓰기</a>
						</p>
					</div>
					<div class="cmtwrite" id="cmtwrite<%= cTalk2.FItemList(j).FTalkIdx %>">
						<div class="inner">
							<fieldset>
							<legend>코멘트 작성하기</legend>
								<textarea id="contents<%= cTalk2.FItemList(j).FTalkIdx %>" name="contents<%= cTalk2.FItemList(j).FTalkIdx %>" onClick="jsCheckLimit('<%= cTalk2.FItemList(j).FTalkIdx %>');" onKeyUp="jsCheckLimit('<%= cTalk2.FItemList(j).FTalkIdx %>');" <%IF  NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="50" rows="50" title="코멘트 작성"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% Else %>100자 이내로 입력해주세요.<%END IF%></textarea>
								<p class="etiquette">주제와 적합하지 않은 의견은 삭제 될 수 있습니다.</p>
								<input type="submit" onclick="talkcommentreg('<%= cTalk2.FItemList(j).FTalkIdx %>'); return false;" value="남기기" />
							</fieldset>
						</div>
						<div class="btnclose"><button type="button" onclick="dispcomment('<%=cTalk2.FItemList(j).FTalkIdx%>','2'); return false;"><span>닫기</span></button></div>
					</div>
					<div id="comment<%= cTalk2.FItemList(j).FTalkIdx %>" class="commentlist"></div>
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
				vtmpitemid=cTalk2.FItemList(j).fitemid
				vtmpImageBasic=cTalk2.FItemList(j).FImageBasic
				vtmpidx=cTalk2.FItemList(j).Fidx
				vtmpTalkIdx=cTalk2.FItemList(j).FTalkIdx
				vtmpSelectoxab=cTalk2.FItemList(j).FSelectoxab
				vtmpgood=cTalk2.FItemList(j).fgood
				%>
			<% end if %>
		<% end if %>
		<% next %>
	<% end if %>

	<%
	'/1개짜리 첫번째 (4개 연이어 뿌림)
	if cTalk1.FResultCount > 3 then
	%>
		<% For i = 0 To 3 %>
		<% If cTalk1.FItemList(i).FTheme = "1" Then %>
		<div class="article">
			<div class="desc">
				<div class="thumb">
					<a href="/shopping/category_prd.asp?itemid=<%= cTalk1.FItemList(i).fitemid %>" target="_blank" title="새창">
					<img src="<%=getThumbImgFromURL(cTalk1.FItemList(i).FImageBasic,230,230,"true","false")%>" alt="<%= cTalk1.FItemList(i).fitemid %>" width='230' height='230' /></a>
				</div>
				<div class="vote">
					<div class="button">
						<span id="btgood<%= cTalk1.FItemList(i).FIdx %>" <% If cTalk1.FItemList(i).FSelectoxab ="O" then%> class='on' <% End if %>>
						<button onclick="jsTalkvote('<%= cTalk1.FItemList(i).fidx %>','<%=cTalk1.FItemList(i).FTalkIdx%>','good','<%=i%>','<%=cTalk1.FItemList(i).FTheme%>','O');" type="button">찬성</button> 
						<em id="countgood<%= cTalk1.FItemList(i).FIdx %>"><%= cTalk1.FItemList(i).fgood %></em></span>
					</div>
					<div class="button">
						<span id="btbad<%= cTalk1.FItemList(i).FIdx %>" <% If cTalk1.FItemList(i).FSelectoxab ="X" then%> class='on' <% End if %>>
						<button onclick="jsTalkvote('<%= cTalk1.FItemList(i).fidx %>','<%=cTalk1.FItemList(i).FTalkIdx%>','bad','<%=i%>','<%=cTalk1.FItemList(i).FTheme%>','X');" type="button">반대</button> 
						<em id="countbad<%= cTalk1.FItemList(i).FIdx %>"><%= cTalk1.FItemList(i).fbad %></em></span>
					</div>
				</div>
			</div>

			<div class="topic">
				<p class="question"><%=chrbyte(cTalk1.FItemList(i).FContents,200,"Y")%></p>
				<div class="profile">
					<strong class="id"><%=printUserId(cTalk1.FItemList(i).FUserID,2,"*")%> <% If cTalk1.FItemList(i).FDevice = "m" Then %><img src="http://fiximage.10x10.co.kr/web2013/gift/ico_mobile.gif" alt="모바일에서 작성" /><% End If %></strong>
					<span class="date"><%=FormatDate(cTalk1.FItemList(i).FRegdate,"0000.00.00")%></span>
				</div>

				<% If cTalk1.FItemList(i).FUserID = GetLoginUserID() Then %>
					<div class="btnwrap">
						<a href="" onClick="goPopTalkModify('<%= cTalk1.FItemList(i).FTalkIdx %>'); return false;" >수정</a>
						<button onClick="jsMyTalkEdit('<%=cTalk1.FItemList(i).FTalkIdx%>'); return false;" type="button" class="del">삭제</button>
					</div>
				<% end if %>
			</div>
			<div class="comment">
				<p class="headline" id="commentcnt<%= cTalk1.FItemList(i).FTalkIdx %>" commentcnt="<%= cTalk1.FItemList(i).FCommCnt %>">
					<% If cTalk1.FItemList(i).FCommCnt > 0 Then %>
						<a href='' onclick="getcommentlist_act('1','<%=cTalk1.FItemList(i).FTalkIdx%>'); return false;" talkidx='<%= cTalk1.FItemList(i).FTalkIdx %>' class='total'>
						<strong><%= cTalk1.FItemList(i).FCommCnt %></strong>개의 코멘트</a> 
					<% else %>
						<a href='' onclick="dispcomment('<%=cTalk1.FItemList(i).FTalkIdx%>','1'); return false;" class='nocmt'>코멘트를 작성해주세요.</a> 
					<% End if %>

					<a href='' onclick="dispcomment('<%=cTalk1.FItemList(i).FTalkIdx%>','1'); return false;" class='btnwrite'>쓰기</a>
				</p>
			</div>
			<div class="cmtwrite" id="cmtwrite<%= cTalk1.FItemList(i).FTalkIdx %>">
				<div class="inner">
					<fieldset>
					<legend>코멘트 작성하기</legend>
						<textarea id="contents<%= cTalk1.FItemList(i).FTalkIdx %>" name="contents<%= cTalk1.FItemList(i).FTalkIdx %>" onClick="jsCheckLimit('<%= cTalk1.FItemList(i).FTalkIdx %>');" onKeyUp="jsCheckLimit('<%= cTalk1.FItemList(i).FTalkIdx %>');" <%IF  NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="50" rows="50" title="코멘트 작성"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% Else %>100자 이내로 입력해주세요.<%END IF%></textarea>
						<p class="etiquette">주제와 적합하지 않은 의견은 삭제 될 수 있습니다.</p>
						<input type="submit" onclick="talkcommentreg('<%= cTalk1.FItemList(i).FTalkIdx %>'); return false;" value="남기기" />
					</fieldset>
				</div>
				<div class="btnclose"><button type="button" onclick="dispcomment('<%=cTalk1.FItemList(i).FTalkIdx%>','2'); return false;"><span>닫기</span></button></div>
			</div>
			<div id="comment<%= cTalk1.FItemList(i).FTalkIdx %>" class="commentlist"></div>
		</div>
		<% end if %>
		<% next %>
	<% end if %>

	<%
	'/2개짜리 두번째 (2개 뿌림)
	if cTalk2.FResultCount > 5 then
	%>
		<% For j = 2 To 5 %>
		<% If cTalk2.FItemList(j).FTheme = "2" Then %>
			<%
			if (CStr(vtmpTalkIdx)=CStr(cTalk2.FItemList(j).FTalkIdx)) then
			%>
				<div class="article wide">
					<div class="desc">
						<div class="thumb">
							<a href="/shopping/category_prd.asp?itemid=<%= vtmpitemid %>" target="_blank" title="새창">
							<img src="<%=getThumbImgFromURL(vtmpImageBasic,230,230,"true","false")%>" alt="<%= vtmpitemid %>" /></a>
							<a href="/shopping/category_prd.asp?itemid=<%= cTalk2.FItemList(j).fitemid %>" target="_blank" title="새창">
							<img src="<%=getThumbImgFromURL(cTalk2.FItemList(j).FImageBasic,230,230,"true","false")%>" alt="<%= cTalk2.FItemList(j).fitemid %>" /></a>
						</div>
						<div class="vote">
							<div class="button">
								<span id="btgood<%= vtmpIdx %>" <% If vtmpSelectoxab ="A" then%> class='on' <% End if %>>
								<button onclick="jsTalkvote('<%= vtmpidx %>','<%= vtmpTalkIdx %>','good','<%= i %>','<%= cTalk2.FItemList(j).FTheme %>','A'); return false;" type="button">A 선택 </button> 
								<em id="countgood<%= vtmpIdx %>"><%= vtmpgood %></em></span>
							</div>
							<div class="button">
								<span id="btgood<%= cTalk2.FItemList(j).FIdx %>" <% If cTalk2.FItemList(j).FSelectoxab ="B" then%> class='on' <% End if %>>
								<button onclick="jsTalkvote('<%= cTalk2.FItemList(j).Fidx %>','<%= cTalk2.FItemList(j).FTalkIdx %>','good','<%= i %>','<%= cTalk2.FItemList(j).FTheme %>','B'); return false;" type="button">B 선택 </button> 
								<em id="countgood<%= cTalk2.FItemList(j).FIdx %>"><%= cTalk2.FItemList(j).fgood %></em></span>
							</div>
						</div>
					</div>
				
					<div class="topic">
						<p class="question"><%=chrbyte(cTalk2.FItemList(j).FContents,200,"Y")%></p>
						<div class="profile">
							<strong class="id"><%=printUserId(cTalk2.FItemList(j).FUserID,2,"*")%> <% If cTalk2.FItemList(j).FDevice = "m" Then %><img src="http://fiximage.10x10.co.kr/web2013/gift/ico_mobile.gif" alt="모바일에서 작성" /><% End If %></strong>
							<span class="date"><%=FormatDate(cTalk2.FItemList(j).FRegdate,"0000.00.00")%></span>
						</div>
		
						<% If cTalk2.FItemList(j).FUserID = GetLoginUserID() Then %>
							<div class="btnwrap">
								<a href="" onClick="goPopTalkModify('<%= cTalk2.FItemList(j).FTalkIdx %>'); return false;" >수정</a>
								<button onClick="jsMyTalkEdit('<%=cTalk2.FItemList(j).FTalkIdx%>'); return false;" type="button">삭제</button>
							</div>
						<% end if %>
					</div>
					<div class="comment">
						<% '<!-- for dev msg : 코멘트가 없는 경우 a에 클래스 nocmt를 붙여주세요 / 코멘트가 있는 경우에는 total --> %>
						<p class="headline" id="commentcnt<%= cTalk2.FItemList(j).FTalkIdx %>" commentcnt="<%= cTalk2.FItemList(j).FCommCnt %>">
							<% If cTalk2.FItemList(j).FCommCnt > 0 Then %>
								<a href='' onclick="getcommentlist_act('1','<%=cTalk2.FItemList(j).FTalkIdx%>'); return false;" talkidx='<%= cTalk2.FItemList(j).FTalkIdx %>' class='total'>
								<strong><%= cTalk2.FItemList(j).FCommCnt %></strong>개의 코멘트</a>
							<% else %>
								<a href='' onclick="dispcomment('<%=cTalk2.FItemList(j).FTalkIdx%>','1'); return false;" class='nocmt'>코멘트를 작성해주세요.</a>
							<% End if %>
		
							<a href='' onclick="dispcomment('<%=cTalk2.FItemList(j).FTalkIdx%>','1'); return false;" class='btnwrite'>쓰기</a>
						</p>
					</div>
					<div class="cmtwrite" id="cmtwrite<%= cTalk2.FItemList(j).FTalkIdx %>">
						<div class="inner">
							<fieldset>
							<legend>코멘트 작성하기</legend>
								<textarea id="contents<%= cTalk2.FItemList(j).FTalkIdx %>" name="contents<%= cTalk2.FItemList(j).FTalkIdx %>" onClick="jsCheckLimit('<%= cTalk2.FItemList(j).FTalkIdx %>');" onKeyUp="jsCheckLimit('<%= cTalk2.FItemList(j).FTalkIdx %>');" <%IF  NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="50" rows="50" title="코멘트 작성"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% Else %>100자 이내로 입력해주세요.<%END IF%></textarea>
								<p class="etiquette">주제와 적합하지 않은 의견은 삭제 될 수 있습니다.</p>
								<input type="submit" onclick="talkcommentreg('<%= cTalk2.FItemList(j).FTalkIdx %>'); return false;" value="남기기" />
							</fieldset>
						</div>
						<div class="btnclose"><button type="button" onclick="dispcomment('<%=cTalk2.FItemList(j).FTalkIdx%>','2'); return false;"><span>닫기</span></button></div>
					</div>
					<div id="comment<%= cTalk2.FItemList(j).FTalkIdx %>" class="commentlist"></div>
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
				vtmpitemid=cTalk2.FItemList(j).fitemid
				vtmpImageBasic=cTalk2.FItemList(j).FImageBasic
				vtmpidx=cTalk2.FItemList(j).Fidx
				vtmpTalkIdx=cTalk2.FItemList(j).FTalkIdx
				vtmpSelectoxab=cTalk2.FItemList(j).FSelectoxab
				vtmpgood=cTalk2.FItemList(j).fgood
				%>
			<% end if %>
		<% end if %>
		<% next %>
	<% end if %>
	
	<%
	'/1개짜리 두번째 (4개 연이어 뿌림)
	if cTalk1.FResultCount > 7 then
	%>
		<% For i = 4 To 7 %>
		<% If cTalk1.FItemList(i).FTheme = "1" Then %>
		<div class="article">
			<div class="desc">
				<div class="thumb">
					<a href="/shopping/category_prd.asp?itemid=<%= cTalk1.FItemList(i).fitemid %>" target="_blank" title="새창">
					<img src="<%=getThumbImgFromURL(cTalk1.FItemList(i).FImageBasic,230,230,"true","false")%>" alt="<%= cTalk1.FItemList(i).fitemid %>" /></a>
				</div>
				<div class="vote">
					<div class="button">
						<span id="btgood<%= cTalk1.FItemList(i).FIdx %>" <% If cTalk1.FItemList(i).FSelectoxab ="O" then%> class='on' <% End if %>>
						<button onclick="jsTalkvote('<%= cTalk1.FItemList(i).fidx %>','<%=cTalk1.FItemList(i).FTalkIdx%>','good','<%=i%>','<%=cTalk1.FItemList(i).FTheme%>','O');" type="button">찬성</button> 
						<em id="countgood<%= cTalk1.FItemList(i).FIdx %>"><%= cTalk1.FItemList(i).fgood %></em></span>
					</div>
					<div class="button">
						<span id="btbad<%= cTalk1.FItemList(i).FIdx %>" <% If cTalk1.FItemList(i).FSelectoxab ="X" then%> class='on' <% End if %>>
						<button onclick="jsTalkvote('<%= cTalk1.FItemList(i).fidx %>','<%=cTalk1.FItemList(i).FTalkIdx%>','bad','<%=i%>','<%=cTalk1.FItemList(i).FTheme%>','X');" type="button">반대</button> 
						<em id="countbad<%= cTalk1.FItemList(i).FIdx %>"><%= cTalk1.FItemList(i).fbad %></em></span>
					</div>
				</div>
			</div>

			<div class="topic">
				<p class="question"><%=chrbyte(cTalk1.FItemList(i).FContents,200,"Y")%></p>
				<div class="profile">
					<strong class="id"><%=printUserId(cTalk1.FItemList(i).FUserID,2,"*")%> <% If cTalk1.FItemList(i).FDevice = "m" Then %><img src="http://fiximage.10x10.co.kr/web2013/gift/ico_mobile.gif" alt="모바일에서 작성" /><% End If %></strong>
					<span class="date"><%=FormatDate(cTalk1.FItemList(i).FRegdate,"0000.00.00")%></span>
				</div>

				<% If cTalk1.FItemList(i).FUserID = GetLoginUserID() Then %>
					<div class="btnwrap">
						<a href="" onClick="goPopTalkModify('<%= cTalk1.FItemList(i).FTalkIdx %>'); return false;" >수정</a>
						<button onClick="jsMyTalkEdit('<%=cTalk1.FItemList(i).FTalkIdx%>'); return false;" type="button" class="del">삭제</button>
					</div>
				<% end if %>
			</div>
			<div class="comment">
				<p class="headline" id="commentcnt<%= cTalk1.FItemList(i).FTalkIdx %>" commentcnt="<%= cTalk1.FItemList(i).FCommCnt %>">
					<% If cTalk1.FItemList(i).FCommCnt > 0 Then %>
						<a href='' onclick="getcommentlist_act('1','<%=cTalk1.FItemList(i).FTalkIdx%>'); return false;" talkidx='<%= cTalk1.FItemList(i).FTalkIdx %>' class='total'>
						<strong><%= cTalk1.FItemList(i).FCommCnt %></strong>개의 코멘트</a> 
					<% else %>
						<a href='' onclick="dispcomment('<%=cTalk1.FItemList(i).FTalkIdx%>','1'); return false;" class='nocmt'>코멘트를 작성해주세요.</a> 
					<% End if %>

					<a href='' onclick="dispcomment('<%=cTalk1.FItemList(i).FTalkIdx%>','1'); return false;" class='btnwrite'>쓰기</a>
				</p>
			</div>
			<div class="cmtwrite" id="cmtwrite<%= cTalk1.FItemList(i).FTalkIdx %>">
				<div class="inner">
					<fieldset>
					<legend>코멘트 작성하기</legend>
						<textarea id="contents<%= cTalk1.FItemList(i).FTalkIdx %>" name="contents<%= cTalk1.FItemList(i).FTalkIdx %>" onClick="jsCheckLimit('<%= cTalk1.FItemList(i).FTalkIdx %>');" onKeyUp="jsCheckLimit('<%= cTalk1.FItemList(i).FTalkIdx %>');" <%IF  NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="50" rows="50" title="코멘트 작성"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% Else %>100자 이내로 입력해주세요.<%END IF%></textarea>
						<p class="etiquette">주제와 적합하지 않은 의견은 삭제 될 수 있습니다.</p>
						<input type="submit" onclick="talkcommentreg('<%= cTalk1.FItemList(i).FTalkIdx %>'); return false;" value="남기기" />
					</fieldset>
				</div>
				<div class="btnclose"><button type="button" onclick="dispcomment('<%=cTalk1.FItemList(i).FTalkIdx%>','2'); return false;"><span>닫기</span></button></div>
			</div>
			<div id="comment<%= cTalk1.FItemList(i).FTalkIdx %>" class="commentlist"></div>
		</div>
		<% end if %>
		<% next %>
	<% end if %>

	<%
	'/2개짜리 세번째 (1개 뿌림)
	if cTalk2.FResultCount > 7 then
	%>
		<% For j = 6 To 7 %>
		<% If cTalk2.FItemList(j).FTheme = "2" Then %>
			<%
			if (CStr(vtmpTalkIdx)=CStr(cTalk2.FItemList(j).FTalkIdx)) then
			%>
				<div class="article wide">
					<div class="desc">
						<div class="thumb">
							<a href="/shopping/category_prd.asp?itemid=<%= vtmpitemid %>" target="_blank" title="새창">
							<img src="<%=getThumbImgFromURL(vtmpImageBasic,230,230,"true","false")%>" alt="<%= vtmpitemid %>" /></a>
							<a href="/shopping/category_prd.asp?itemid=<%= cTalk2.FItemList(j).fitemid %>" target="_blank" title="새창">
							<img src="<%=getThumbImgFromURL(cTalk2.FItemList(j).FImageBasic,230,230,"true","false")%>" alt="<%= cTalk2.FItemList(j).fitemid %>" /></a>
						</div>
						<div class="vote">
							<div class="button">
								<span id="btgood<%= vtmpIdx %>" <% If vtmpSelectoxab ="A" then%> class='on' <% End if %>>
								<button onclick="jsTalkvote('<%= vtmpidx %>','<%= vtmpTalkIdx %>','good','<%= i %>','<%= cTalk2.FItemList(j).FTheme %>','A'); return false;" type="button">A 선택 </button> 
								<em id="countgood<%= vtmpIdx %>"><%= vtmpgood %></em></span>
							</div>
							<div class="button">
								<span id="btgood<%= cTalk2.FItemList(j).FIdx %>" <% If cTalk2.FItemList(j).FSelectoxab ="B" then%> class='on' <% End if %>>
								<button onclick="jsTalkvote('<%= cTalk2.FItemList(j).Fidx %>','<%= cTalk2.FItemList(j).FTalkIdx %>','good','<%= i %>','<%= cTalk2.FItemList(j).FTheme %>','B'); return false;" type="button">B 선택 </button> 
								<em id="countgood<%= cTalk2.FItemList(j).FIdx %>"><%= cTalk2.FItemList(j).fgood %></em></span>
							</div>
						</div>
					</div>
				
					<div class="topic">
						<p class="question"><%=chrbyte(cTalk2.FItemList(j).FContents,200,"Y")%></p>
						<div class="profile">
							<strong class="id"><%=printUserId(cTalk2.FItemList(j).FUserID,2,"*")%> <% If cTalk2.FItemList(j).FDevice = "m" Then %><img src="http://fiximage.10x10.co.kr/web2013/gift/ico_mobile.gif" alt="모바일에서 작성" /><% End If %></strong>
							<span class="date"><%=FormatDate(cTalk2.FItemList(j).FRegdate,"0000.00.00")%></span>
						</div>
		
						<% If cTalk2.FItemList(j).FUserID = GetLoginUserID() Then %>
							<div class="btnwrap">
								<a href="" onClick="goPopTalkModify('<%= cTalk2.FItemList(j).FTalkIdx %>'); return false;" >수정</a>
								<button onClick="jsMyTalkEdit('<%=cTalk2.FItemList(j).FTalkIdx%>'); return false;" type="button">삭제</button>
							</div>
						<% end if %>
					</div>
					<div class="comment">
						<% '<!-- for dev msg : 코멘트가 없는 경우 a에 클래스 nocmt를 붙여주세요 / 코멘트가 있는 경우에는 total --> %>
						<p class="headline" id="commentcnt<%= cTalk2.FItemList(j).FTalkIdx %>" commentcnt="<%= cTalk2.FItemList(j).FCommCnt %>">
							<% If cTalk2.FItemList(j).FCommCnt > 0 Then %>
								<a href='' onclick="getcommentlist_act('1','<%=cTalk2.FItemList(j).FTalkIdx%>'); return false;" talkidx='<%= cTalk2.FItemList(j).FTalkIdx %>' class='total'>
								<strong><%= cTalk2.FItemList(j).FCommCnt %></strong>개의 코멘트</a>
							<% else %>
								<a href='' onclick="dispcomment('<%=cTalk2.FItemList(j).FTalkIdx%>','1'); return false;" class='nocmt'>코멘트를 작성해주세요.</a>
							<% End if %>
		
							<a href='' onclick="dispcomment('<%=cTalk2.FItemList(j).FTalkIdx%>','1'); return false;" class='btnwrite'>쓰기</a>
						</p>
					</div>
					<div class="cmtwrite" id="cmtwrite<%= cTalk2.FItemList(j).FTalkIdx %>">
						<div class="inner">
							<fieldset>
							<legend>코멘트 작성하기</legend>
								<textarea id="contents<%= cTalk2.FItemList(j).FTalkIdx %>" name="contents<%= cTalk2.FItemList(j).FTalkIdx %>" onClick="jsCheckLimit('<%= cTalk2.FItemList(j).FTalkIdx %>');" onKeyUp="jsCheckLimit('<%= cTalk2.FItemList(j).FTalkIdx %>');" <%IF  NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="50" rows="50" title="코멘트 작성"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% Else %>100자 이내로 입력해주세요.<%END IF%></textarea>
								<p class="etiquette">주제와 적합하지 않은 의견은 삭제 될 수 있습니다.</p>
								<input type="submit" onclick="talkcommentreg('<%= cTalk2.FItemList(j).FTalkIdx %>'); return false;" value="남기기" />
							</fieldset>
						</div>
						<div class="btnclose"><button type="button" onclick="dispcomment('<%=cTalk2.FItemList(j).FTalkIdx%>','2'); return false;"><span>닫기</span></button></div>
					</div>
					<div id="comment<%= cTalk2.FItemList(j).FTalkIdx %>" class="commentlist"></div>
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
				vtmpitemid=cTalk2.FItemList(j).fitemid
				vtmpImageBasic=cTalk2.FItemList(j).FImageBasic
				vtmpidx=cTalk2.FItemList(j).Fidx
				vtmpTalkIdx=cTalk2.FItemList(j).FTalkIdx
				vtmpSelectoxab=cTalk2.FItemList(j).FSelectoxab
				vtmpgood=cTalk2.FItemList(j).fgood
				%>
			<% end if %>
		<% end if %>
		<% next %>
	<% end if %>

<% End If %>

<%
SET cTalk1 = Nothing
SET cTalk2 = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->