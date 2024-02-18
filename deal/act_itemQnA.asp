<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
%>
<%
'#######################################################
'	History	:  2012.03.27 허진원
'	Description : 상품문의 보기 Ajax 치환 내용
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_item_qnacls.asp" -->
<%
	dim itemid,i,page,ix
	dim oQna, LoginUserid

	LoginUserid = getLoginUserid()
	itemid = RequestCheckVar(request("itemid"),10)
	page = RequestCheckVar(request("page"),10)
	
	if itemid="" then itemid=0
	if page="" then page=1

	set oQna = new CItemQna
	
	oQna.FRectItemID = itemid
	oQna.FPageSize = 5
	oQna.FCurrPage = page
	oQna.ItemQnaList
%>
	<table class="talkList">
		<caption>Q&amp;A 목록</caption>
		<colgroup>
			<col width="140" /> <col width="" /> <col width="90" /> <col width="120" />
		</colgroup>
		<thead>
		<tr>
			<th scope="col">답변여부</th>
			<th scope="col">답변내용</th>
			<th scope="col">작성일자</th>
			<th scope="col">작성자</th>
		</tr>
		</thead>
		<tbody>
	<% if oQna.FTotalCount>0 then  %>
		<% for i = 0 to oQna.FResultCount - 1 %>
		<tr <%=chkIIF(oQna.FItemList(i).Fsecretyn="Y","class='secretV17'","")%>>
			<td><% if oQna.FItemList(i).IsReplyOk then %><strong>&lt;답변완료&gt;</strong><% else %><strong class="cr999">&lt;답변중&gt;</strong><% end if %></td>
			<td class="lt">
				<% if oQna.FItemList(i).Fsecretyn="Y" and LoginUserid <> oQna.FItemList(i).FUserid then %>
					비밀글 입니다.
				<% else %>
					<a href="javascript:" class="talkShort"><% = oQna.FItemList(i).FTitle %></a>
				<% end if %>
			</td>
			<td><%= FormatDate(oQna.FItemList(i).FRegdate,"0000/00/00") %></td>
			<td><%= printUserId(oQna.FItemList(i).FUserid,2,"*") %></td>
		</tr>
		<tr class="talkMore <%=chkIIF(oQna.FItemList(i).Fsecretyn="Y","secretV17","")%>">
			<td colspan="4">
				<div class="qnaList">
					<div class="question">
						<strong class="title"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_q.png" alt="질문" /></strong>
						<div class="account">
							<% if oQna.FItemList(i).Fsecretyn="Y" and LoginUserid <> oQna.FItemList(i).FUserid then %>
								비밀글 입니다.
							<% else %>
								<p><% = nl2br(oQna.FItemList(i).FContents) %></p>
							<% end if %>
							<% if (getLoginUserid<>"") and (getLoginUserid=oQna.FItemList(i).FUserid) then %>
							<div class="btnArea">
								<% IF Not(oQna.FItemList(i).IsReplyOk) THEN %><a href="" class="btn btnS2 btnGry2" onClick="modiItemQna('<%= oQna.FItemList(i).Fid %>','<% = oQna.FResultCount + 1 %>');return false;"><span class="fn">수정</span></a><% end if %>
								<a href="javascript:" class="btn btnS2 btnGry2" onclick="delItemQna('<%= oQna.FItemList(i).Fid %>');"><span class="fn">삭제</span></a>
							</div>
							<% end if %>
						</div>
					</div>
					<% IF oQna.FItemList(i).IsReplyOk THEN %>
					<div class="answer">
						<strong class="title"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_a.png" alt="답변" /></strong>
						<div class="account">
							<% if oQna.FItemList(i).Fsecretyn="Y" then %>
								<% if LoginUserid = oQna.FItemList(i).FUserid then %>
									<p><%= nl2br(oQna.FItemList(i).FReplycontents) %></p>
								<% else %>
									<p>비밀글 입니다.</p>
								<% end if %>
							<% else %>
								<p><%= nl2br(oQna.FItemList(i).FReplycontents) %></p>
							<% end if %>
						</div>
					</div>
					<% end if %>
				</div>
			</td>
		</tr>
		<% Next %>
	<% else %>
		<tr>
			<td colspan="4" class="noData"><strong>등록된 상품 문의가 없습니다</strong></td>
		</tr>
	<% end if %>
		</tbody>
	</table>
	<% if oQna.FTotalCount>0 then  %>
	<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(oQna.FCurrpage,oQna.FTotalCount,oQna.FPageSize,10,"fnChgQnAMove") %></div>
	<% end if %>
<script type="text/javascript">
<!--
$(function(){
	$("#qacurrentcnt").empty().append("<%=formatNumber(oQna.FTotalCount,0)%>");
	$("#lyQnACnt").empty().append("<%=formatNumber(oQna.FTotalCount,0)%>");
});
//-->
</script>
<%
Set oQna = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->