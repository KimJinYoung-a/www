<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'######################################################################
' Description : 다이어리 스토리 2020 다꾸톡톡 내 주문 리스트
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
    dim LoginUserid, i, vPrevRegDate, pageSize, currPage, refer

    LoginUserid = getEncLoginUserID()
    pageSize = 1000
    currPage = 1
    refer 		= request.ServerVariables("HTTP_REFERER") '// 레퍼러

    LoginUserid = getEncLoginUserID()

    '// 로그인시에만 작성가능
    If not(IsUserLoginOK()) Then
        Response.Write "<script>alert('로그인이 필요한 서비스 입니다.');return false;</script>"
        Response.End
    End If

    pageSize = 1000
    currPage = 1

    dim oDaccuTokTokMyOrder
    set oDaccuTokTokMyOrder = new CDaccuTokTok
    oDaccuTokTokMyOrder.FPageSize = pageSize
    oDaccuTokTokMyOrder.FCurrPage = currPage
    oDaccuTokTokMyOrder.FRectUserID = LoginUserid
    oDaccuTokTokMyOrder.GetDaccuTokTokMyOrderList
%>
    <% If oDaccuTokTokMyOrder.FResultCount > 0 Then  %>
        <% FOR i = 0 to oDaccuTokTokMyOrder.FResultCount-1 %>
            <% If i = 0 Then %>
                <li>
                    <div class="date"><%=Left(oDaccuTokTokMyOrder.FItemList(i).FOrderRegDate, 4)&"."&Mid(oDaccuTokTokMyorder.FItemList(i).ForderRegDate, 6, 2)&"."&mid(oDaccuTokTokMyOrder.FItemList(i).FOrderRegDate, 9, 2)%> 구매</div>
                    <ul class="dctem-list">
            <% ElseIf vPrevRegDate <> Left(oDaccuTokTokMyOrder.FItemList(i).FOrderRegDate, 10) And i > 0 Then %>
                    </ul>
                </li>
                <li>
                    <div class="date"><%=Left(oDaccuTokTokMyOrder.FItemList(i).FOrderRegDate, 4)&"."&Mid(oDaccuTokTokMyorder.FItemList(i).ForderRegDate, 6, 2)&"."&mid(oDaccuTokTokMyOrder.FItemList(i).FOrderRegDate, 9, 2)%> 구매</div>
                    <ul class="dctem-list">
            <% End If %>
            <li>
                <input type="radio" id="item1-<%=i+1%>" name="chk-item">
                <label for="item1-<%=i+1%>" class="item-wrap" onclick="clickOrderList('<%=oDaccuTokTokMyOrder.FItemList(i).ForderItemId%>','<%=oDaccuTokTokMyOrder.FItemList(i).FOrderItemOption%>');">
                    <%' 정방형 이미지 %> <div class="thumbnail"> <img src="<%=oDaccuTokTokMyOrder.FItemList(i).FOrderListImage120%>?cmd=thumbnail&w=400&h=400&fit=true&ws=false" alt=""></div>
                    <div class="desc">
                        <p class="name"><%=oDaccuTokTokMyOrder.FItemList(i).FOrderItemName%></p>
                        <p class="brand"><%=oDaccuTokTokMyOrder.FItemList(i).FOrderBrandName%></p>
                    </div>
                </label>
            </li>
            <% vPrevRegDate = Left(oDaccuTokTokMyOrder.FItemList(i).FOrderRegDate, 10) %>
        <% Next %>
    <% Else %>
        <li>
            구매한 내역이 없습니다.
        </li>
    <% End If %>
<%
    set oDaccuTokTokMyOrder = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->