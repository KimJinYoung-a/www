<%
    '// 키워드
    dim arrKeywords , arrLoop
    arrKeywords = oMedia.getContentsKeywordList(vContentsidx)

    if isarray(arrKeywords) then		
%>
<div class="info-tags">
    <ul>
        <% for arrLoop = 0 to ubound(arrKeywords,2) %>
        <li><a href="javascript:void(0);">#<%=arrKeywords(2,arrLoop)%></a></li>
        <% next %>
    </ul>
</div>
<%
    end if 
%>