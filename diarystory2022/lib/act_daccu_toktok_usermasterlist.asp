<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'######################################################################
' Description : 다이어리 스토리 2020 다꾸톡톡 사용자 리스트 불러오기
' History : 2019-09-17 원승현 생성
'######################################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2022/lib/classes/daccutoktokcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
    dim i, pageSize, currPage, refer, MasterIdx, oDaccuTalkUserList

    refer 		= request.ServerVariables("HTTP_REFERER") '// 레퍼러

    pageSize = request("pagesize")
    currpage = request("userCurrPage")

    pagesize = 6
    If currpage = "" Then
        currpage = 1
    end if

    set oDaccuTalkUserList = new CDaccuTokTok
    oDaccuTalkUserList.FPageSize = pageSize
    oDaccuTalkUserList.FCurrPage = currpage
    oDaccuTalkUserList.GetDaccuTokTokUserMasterList
%>
    <% If oDaccuTalkUserList.FResultCount > 0 Then  %>
        <% FOR i = 0 to oDaccuTalkUserList.FResultCount-1 %>
            <li>
                <% If ((GetEncLoginUserID = oDaccuTalkUserList.FItemList(i).FUserMasterUserId) or (GetEncLoginUserID = "10x10")) and ( oDaccuTalkUserList.FItemList(i).FUserMasterUserId<>"") Then %>
                    <button type="button" class="btn-del" onclick="fnDeleteDaccu('<%=oDaccuTalkUserList.FItemList(i).FUserMasterIdx%>');">삭제</button>
                <% End If %>
                <a href="" onclick="daccutoktokView('<%=oDaccuTalkUserList.FItemList(i).FUserMasterIdx%>');return false;">
                    <div class="thumbnail"><img src="<%=oDaccuTalkUserList.FItemList(i).FUserMasterImage%>" alt=""></div>
                    <div class="desc">
                        <%' for dev msg : 제목 2줄 이상은 말줄임 처리 해주세요 %>
                        <p class="tit"><%=chrbyte(oDaccuTalkUserList.FItemList(i).FUserMasterTitle,35,"Y")%></p>
                        <span class="user-id"><%=printUserId(oDaccuTalkUserList.FItemList(i).FUserMasterUserId,2,"*")%></span>
                        <span class="view"><b>조회수</b> <%=formatnumber(oDaccuTalkUserList.FItemList(i).FUserMasterViewCount, 0)%></span>
                    </div>
                </a>
            </li>
        <% Next %>
    <% End If %>
<%
    set oDaccuTalkUserList = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->