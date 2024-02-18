<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2020 다꾸톡톡 페이지
' History : 2019-09-17 원승현 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2020/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2020/lib/classes/daccutoktokcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
    Dim userid, referer, refip, masterIdx, i, prevMasterIdx, nextMasterIdx

    referer = request.ServerVariables("HTTP_REFERER")
    refip = request.ServerVariables("REMOTE_ADDR")

    if InStr(referer,"10x10.co.kr")<1 Then
        'Response.Write "<script>alert('잘못된 접속입니다.');history.back();</script>"
        'Response.End
    end If

    masterIdx = request("masterIdx")

    '// viewCountUpdate
    Dim oDaccuTalkViewCount
    set oDaccuTalkViewCount = new CDaccuTokTok
    oDaccuTalkViewCount.FRectMasterIdx = masterIdx
    oDaccuTalkViewCount.UpdDaccuTokTokUserMaster

    '// 사용자 작성 정보
    Dim oDaccuTalkMasterOne
    set oDaccuTalkMasterOne = new CDaccuTokTok
    oDaccuTalkMasterOne.FRectMasterIdx = masterIdx
    oDaccuTalkMasterOne.GetDaccuTokTokUserMasterOne

    '// 사용자 작성 상품 리스트
    Dim oDaccuTalkDetailList
    set oDaccuTalkDetailList = new CDaccuTokTok
    oDaccuTalkDetailList.FRectMasterIdx = masterIdx
    oDaccuTalkDetailList.GetDaccuTokTokDetailUserList

    '// 이전글 가져오기
    Dim oDaccuTalkMasterPrev
    set oDaccuTalkMasterPrev = new CDaccuTokTok
    oDaccuTalkMasterPrev.FRectMasterIdx = masterIdx
    oDaccuTalkMasterPrev.GetDaccuTokTokUserMasterOnePrev
    prevMasterIdx = oDaccuTalkMasterPrev.FOneItem.FUserMasterPrevIdx
    set oDaccuTalkMasterPrev = Nothing

    '// 다음글 가져오기
    Dim oDaccuTalkMasterNext
    set oDaccuTalkMasterNext = new CDaccuTokTok
    oDaccuTalkMasterNext.FRectMasterIdx = masterIdx
    oDaccuTalkMasterNext.GetDaccuTokTokUserMasterOneNext
    nextMasterIdx = oDaccuTalkMasterNext.FOneItem.FUserMasterNextIdx
    set oDaccuTalkMasterNext = Nothing    
%>
<%' POPUP SET %>
<button type="button" class="btn-close" onclick="fnCloseModal();return false;">팝업 닫기</button>
<%' 팝업 왼쪽 영역 %>
<div class="dctem-left">
    <div class="dctem-thumb">
        <img src="<%=oDaccuTalkMasterOne.FOneItem.FUserMasterImage%>" alt="">
        <ul class="mark-list">
            <%' for dev msg : 등록된 태그들 %>
            <% If oDaccuTalkDetailList.FResultCount > 0 Then  %>
                <% FOR i = 0 to oDaccuTalkDetailList.FResultCount-1 %>
                    <li class="mark" style="left:<%=oDaccuTalkDetailList.FItemList(i).FUserDetailXValue%>%; top:<%=oDaccuTalkDetailList.FItemList(i).FUserDetailYValue%>%;">
                        <a href="/shopping/category_prd.asp?itemid=<%=oDaccuTalkDetailList.FItemList(i).FUserDetailItemID%>" target="_blank">
                            <i class="ico-plus"></i>
                            <div class="box">
                                <p class="name"><%=oDaccuTalkDetailList.FItemList(i).FUserDetailItemName%></p>
                            </div>
                        </a>
                    </li>
                <% Next %>
            <% End If %>
        </ul>
    </div>
</div>
<%' 팝업 오른쪽 영역 %>
<div class="dctem-right">
    <div class="dctem-head">
        <p class="tit"><%=oDaccuTalkMasterOne.FOneItem.FUserMasterTitle%></p>
        <p class="user-id"><%=printUserId(oDaccuTalkMasterOne.FOneItem.FUserMasterUserId,2,"*")%></p>
    </div>
    <div class="dctem-conts">
        <div class="scrollbarwrap1">
            <div class="scrollbar"><div class="thumb"></div></div>
            <div class="viewport">
                <div class="overview">
                    <%' 리스트 영역 %>
                    <ul class="dctem-list">
                        <% If oDaccuTalkDetailList.FResultCount > 0 Then  %>
                            <% FOR i = 0 to oDaccuTalkDetailList.FResultCount-1 %>                    
                                <li>
                                    <a href="/shopping/category_prd.asp?itemid=<%=oDaccuTalkDetailList.FItemList(i).FUserDetailItemID%>" target="_blank">
                                        <div class="item-wrap">
                                            <div class="thumbnail"><img src="<%=oDaccuTalkDetailList.FItemList(i).FUserDetailListImage120%>" alt=""></div>
                                            <div class="desc">
                                                <p class="name"><%=oDaccuTalkDetailList.FItemList(i).FUserDetailItemName%></p>
                                                <p class="brand"><%=oDaccuTalkDetailList.FItemList(i).FUserDetailBrandName%></p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            <% Next %>
                        <% End If %>
                    </ul>
                    <%' // 리스트 영역 %>
                </div>
            </div>
        </div>
    </div>
</div>
<%' for dev msg : 읽기 (view) %>
<div class="bot-area">
    <% If prevMasterIdx <> "" Then %>
        <button type="button" class="btn-next ftLt" onclick="fnDaccuMoveView('<%=prevMasterIdx%>');">이전글</button>
    <% End If %>
    <% If nextMasterIdx <> "" Then %>
        <button type="button" class="btn-next ftRt" onclick="fnDaccuMoveView('<%=nextMasterIdx%>');">다음글</button>
    <% End If %>
</div>
<%
    Set oDaccuTalkViewCount = Nothing
    Set oDaccuTalkMasterOne = Nothing
    Set oDaccuTalkDetailList = Nothing
%>
<%' POPUP SET %>
<!-- #include virtual="/lib/db/dbclose.asp" -->