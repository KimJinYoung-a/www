<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/diarystory2021/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<%
dim mktevent, hoteventlist, selOp, scType, CurrPage, i, itemCheck
scType 		= requestCheckVar(Request("scT"),4) '쇼핑찬스 분류
CurrPage 	= requestCheckVar(request("cpg"),9)

set mktevent = new cdiary_list
    mktevent.fnGetDiaryMKTEvent

set hoteventlist = new cdiary_list
    hoteventlist.FCurrPage  = CurrPage
    hoteventlist.FPageSize	= 20
    hoteventlist.FselOp		= 0
    hoteventlist.FSCType 	= scType    	'이벤트구분(전체,세일,사은품,상품후기, 신규,마감임박)
    hoteventlist.FEvttype   = "1,13"
    hoteventlist.Fisweb	 	= "1"
    hoteventlist.Fismobile	= "0"
    hoteventlist.Fisapp	 	= "0"
if scType<>"P" then
    hoteventlist.fnGetdievent
end if
%>
<!-- md -->
<% if mktevent.FOneItem.FEvt_code<>"" and CurrPage="1" and (scType="P" or scType="all") then %>
<div class="dr-evt-wrap dr-evt-mkt" id="mktevt">
    <article class="dr-evt-item">
        <figure class="dr-evt-img"><img src="<%=mktevent.FOneItem.FEvt_bannerimg%>" alt=""></figure>
        <div class="dr-evt-info">
            <div class="dr-evt-badge">
                <span class="badge-type1">쇼핑꿀팁</span>
            </div>
            <p class="dr-evt-name"><%=mktevent.FOneItem.FEvt_name%></p>
        </div>
        <a href="/event/eventmain.asp?eventid=<%=mktevent.FOneItem.FEvt_code%>" class="dr-evt-link"><span class="blind">이벤트바로가기</span></a>
    </article>
</div>
<% end if %>
<% If hoteventlist.FResultCount > 0 and scType<>"P" Then  %>
<% for i = 0 to hoteventlist.FResultCount-1 %>
<% itemCheck = fngetDiaryEvtItemHtml(hoteventlist.FItemList(i).FEvt_code) %>
<div class="dr-evt-wrap<% if itemCheck = "" then %> dr-evt-mkt<% end if %>">
    <article class="dr-evt-item">
        <% if itemCheck <> "" then %>
        <figure class="dr-evt-img"><img src="<%=hoteventlist.FItemList(i).fevt_mo_listbanner %>" alt=""></figure>
        <% else %>
        <figure class="dr-evt-img"><img src="<%=hoteventlist.FItemList(i).Fetc_itemimg %>" alt=""></figure>
        <% end if %>
        <div class="dr-evt-info">
            <div class="dr-evt-badge">
                <% if hoteventlist.FItemList(i).fissale and hoteventlist.FItemList(i).FSalePer <> "" and hoteventlist.FItemList(i).FSalePer <> "0"  then %><span class="badge-type2"><%=hoteventlist.FItemList(i).FSalePer%>%</span><% end if %>
                <% If hoteventlist.FItemList(i).fisgift Then %><span class="badge-type1">사은품</span><% end if %>
                <% If hoteventlist.FItemList(i).FGiftCnt>0 Then %><span class="badge-type1"><%=formatnumber(hoteventlist.FItemList(i).FGiftCnt,0)%>개 남음</span><% end if %>
                <% If hoteventlist.FItemList(i).fisOnlyTen Then %><span class="badge-type1">단독</span><% end if %>
            </div>
            <p class="dr-evt-name"><%=split(hoteventlist.FItemList(i).FEvt_name,"|")(0)%></p>
        </div>
        <a href="/event/eventmain.asp?eventid=<%=hoteventlist.FItemList(i).fevt_code %>" class="dr-evt-link"><span class="blind">이벤트바로가기</span></a>
    </article>
    <div class="prd-list">
        <%=fngetDiaryEvtItemHtml(hoteventlist.FItemList(i).FEvt_code)%>
    </div>
</div>
<% next %>
<% else '<!-- 결과 없을떄 -->%>
    <% if CurrPage="1" then %>
	<section class="nodata nodata_search">
		<p><b>아쉽게도 일치하는 내용이 없습니다</b></p>
		<p>품절 또는 종료된 경우에는 검색되지 않습니다</p>
	</section>
    <% end if %>
<% end if %>
<%
set mktevent = nothing
set hoteventlist = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->