<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
    Dim userID : userID = GetEncLoginUserID()
    Dim cEComment, iCTotCnt, arrCList, intCLoop
    Dim currentPage : currentPage = requestCheckVar(request("iCC"),10)
    Dim eventID : eventID = requestCheckVar(request("eventid"),10)
    Dim pageSize : pageSize = 15

    if currentPage = "" then currentPage = 1

    '// comment info
    SET cEComment = new ClsEvtComment
        cEComment.FECode        = eventID '이벤트ID
        cEComment.FCPage        = currentPage '현재페이지
        cEComment.FPSize        = pageSize '페이지 사이즈
        cEComment.FTotCnt       = -1  '전체 레코드 수
        arrCList = cEComment.fnGetComment
        iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
    SET cEComment = nothing
%>
<% If isArray(arrCList) Then %>
<div class="total">총 <b><%=iCTotCnt%></b>개의 댓글이 있습니다.</div>
<ul id="commentList">
    <% For intCLoop = 0 To UBound(arrCList,2) %>
    <li>
        <div class="reply-cont">
            <p><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
            <div class="info">
                <span class="writer"><%=printUserId(arrCList(2,intCLoop),4,"*")%></span>
                <span class="date"><%= FormatDate(arrCList(4,intCLoop),"0000.00.00") %></span>
            </div>
            <% if ((userID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
            <div class="edit">
                <button class="btn-modify" onclick="fnUdtComment('<% = arrCList(0,intCLoop) %>', event);">수정</button>
                <button class="btn-delete" onclick="fnDelComment('<% = arrCList(0,intCLoop) %>');">삭제</button>
            </div>
            <% End If %>
        </div>
    </li>
    <% next %>
</ul>
<div class="pageWrapV15">
    <%= fnDisplayPaging_New_nottextboxdirect(currentPage,iCTotCnt,pageSize,10,"jsGoComPage") %>
</div>
<% else %>
<p class="no-data" style="display:none">해당 게시물이 없습니다.</p>
<% end if %>
<!-- #include virtual="/lib/db/dbclose.asp" -->