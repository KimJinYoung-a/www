<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'######################################################################
' Description : 다이어리 스토리 2020 다꾸톡톡 태그한 상품 리스트
' History : 2019-09-17 원승현 생성
'######################################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2020/lib/classes/daccutoktokcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
    dim LoginUserid, i, vPrevRegDate, pageSize, currPage, refer, MasterIdx

    LoginUserid = getEncLoginUserID()
    refer 		= request.ServerVariables("HTTP_REFERER") '// 레퍼러
    MasterIdx   = request("MasterIdx")

    dim oDaccuTokTokDetailItemList
    set oDaccuTokTokDetailItemList = new CDaccuTokTok
    oDaccuTokTokDetailItemList.FRectUserID = LoginUserid
    oDaccuTokTokDetailItemList.FRectMasterIdx = MasterIdx
    oDaccuTokTokDetailItemList.GetDaccuTokTokDetailItemList
%>
    <% If oDaccuTokTokDetailItemList.FResultCount > 0 Then  %>
        <% FOR i = 0 to oDaccuTokTokDetailItemList.FResultCount-1 %>
            <li>
                <div class="item-wrap">
                    <!-- 정방형 이미지 --><div class="thumbnail"><img src="<%=oDaccuTokTokDetailItemList.FItemList(i).FDetailListImage120%>" alt=""></div>
                    <div class="desc">
                        <p class="name"><%=oDaccuTokTokDetailItemList.FItemList(i).FDetailItemName%></p>
                        <p class="brand"><%=oDaccuTokTokDetailItemList.FItemList(i).FDetailBrandName%></p>
                    </div>
                </div>
            </li>
        <% Next %>
    <% Else %>
        <li>
            <div class="item-wrap">
                이미지에서 태그할 영역을 선택해주세요.
            </div>
        </li>
    <% End If %>
<%
    set oDaccuTokTokDetailItemList = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->