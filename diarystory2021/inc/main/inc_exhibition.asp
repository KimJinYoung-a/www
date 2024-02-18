<%
public function couponDisp(couponVal)
	if couponVal = "" or isnull(couponVal) then exit function
	couponDisp = chkIIF(couponVal > 100, couponVal, couponVal & "%")
end function
	dim mktevent, hoteventlist, PageSize, itemCheck
    if RBeventCodeArr<>"" then
        RBeventCodeArr = left(RBeventCodeArr,len(RBeventCodeArr)-1)
    end if

	set mktevent = new cdiary_list
		mktevent.fnGetDiaryMKTEvent

    If mktevent.FOneItem.FEvt_code <> "" Then
        PageSize = 3
    else
        PageSize = 4
    end if
	set hoteventlist = new cdiary_list
		hoteventlist.FCurrPage  = 1
		hoteventlist.FPageSize	= PageSize
		hoteventlist.FselOp		= 0 '0 신규순 1 종료 임박 2 인기순
		hoteventlist.FEvttype   = "1,13"
        hoteventlist.Fisweb	 	= "1"
        hoteventlist.Fismobile	= "0"
        hoteventlist.Fisapp	 	= "0"
        hoteventlist.FExcCode = RBeventCodeArr
		hoteventlist.fnGetdievent
%>
			<!-- 기획전 -->
			<section class="sect-evt">
				<h2><a href="/diarystory2021/exhibition.asp">주목해야 할 기획전</a></h2>
				<div class="evt-list">
					<% If mktevent.FOneItem.FEvt_code <> "" Then %>
					<div class="dr-evt-wrap dr-evt-mkt">
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
					<% If hoteventlist.FResultCount > 0 Then %>
                    <% for i = 0 to hoteventlist.FResultCount-1 %>
                    <%
                        itemCheck = fngetDiaryEvtItemHtml(hoteventlist.FItemList(i).FEvt_code)
                    %>
					<div class="dr-evt-wrap">
                        <article class="dr-evt-item<% if itemCheck = "" then %> dr-evt-mkt<% end if %>">
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
                            <%=itemCheck%>
						</div>
					</div>
                    <% next %>
                    <% end if %>
				</div>
				<a href="exhibition.asp" class="btn-gp">주목해야 할 기획전 전체보기</a>
			</section>