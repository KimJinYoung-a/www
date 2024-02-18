<%
    dim isSoldOut , RemainCount
%>
<div class="time-ing">
    <% if fnGetCurrentType(isAdmin,currentType) > 0 then %>
    <div class="time-top">
        <div class="inner">
            <% if fnGetCurrentType(isAdmin,currentType) = "1" then '첫번째 타임세일 %>
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_intro1_1.png" alt="시작합니다. 오늘의 첫번째 타임세일"></h2>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_intro1_2.png" alt="첫번째 세일 종료까지"></p>
            <% end if %>

            <% if fnGetCurrentType(isAdmin,currentType) = "2" then '두번째 타임세일 %>
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_intro2_1.png" alt="이어집니다. 오늘의 두번째 타임세일"></h2>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_intro2_2.png" alt="두번째 세일 종료까지"></p>
            <% end if %>

            <% if fnGetCurrentType(isAdmin,currentType) = "3" then '세번째 타임세일 %>
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_intro3_1.png" alt="두번 남았어요. 오늘의 세번째 타임세일"></h2>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_intro3_2.png" alt="세번째 세일 종료까지"></p>
            <% end if %>

            <% if fnGetCurrentType(isAdmin,currentType) = "4" then '네번째 타임세일 %>
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_intro4_1.png" alt="이번엔 꼭! 오늘의 마지막 타임세일"></h2>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_intro4_2.png" alt="마지막 세일 종료까지"></p>
            <% end if %>
            <div class="sale-timer"><span>-</span><span id="countdown">00:00:00</span></div>

            <%=fnGettimeNavHtml(fnGetCurrentType(isAdmin,currentType))%>
        </div>
    </div>
    <% end if %>

    <% if NOT isnull(fnGetCurrentType(isAdmin,currentType)) THEN %>
    <%'!-- 첫번째 ~ 네번째 타임세일 --%>
    <div class="time-items-on time-items">
        <ul>
            <%                
                FOR loopInt = 0 TO oTimeSale.FResultCount - 1                    
                    isItem = oTimeSale.FitemList(loopInt).FcontentType = 1'콘텐츠 구분 추가
                    IF oTimeSale.FitemList(loopInt).Fround = Cint(fnGetCurrentType(isAdmin,currentType)) THEN
                        if isItem then
                            call oTimeSale.FitemList(loopInt).fnItemLimitedState(isSoldOut,RemainCount)
                            call oTimeSale.FitemList(loopInt).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)
                        end if    
            %>
                    <li <%=chkiif(isSoldOut and isItem,"class=""sold-out""","")%>>
                        <% IF oTimeSale.FitemList(loopInt).Fsortnumber > 1 THEN %>
                            <% if isItem then %>
                                <a href="/shopping/category_prd.asp?itemid=<%=oTimeSale.FitemList(loopInt).Fitemid%>&pEtr=<%=eCode%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_timesale_item','idx|itemid','<%=loopInt%>|<%=oTimeSale.FitemList(loopInt).Fitemid%>')">
                            <% else %>
                                <a href="/event/eventmain.asp?eventid=<%=oTimeSale.FitemList(loopInt).FevtCode%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_timesale_event','idx|evtcode','<%=loopInt%>|<%=oTimeSale.FitemList(loopInt).FevtCode%>')">                            
                            <% end if %>
                        <% END IF%>
                            <div class="thumbnail">
                                <img src="<%=oTimeSale.FitemList(loopInt).FprdImage%>" alt= "">
                                <div class="label-box">
                                    <span class="label">한정판매</span><%'갯수 노출 안함%>
                                </div>
                            </div>
                            <div class="desc">
                                <div class="name"><%=oTimeSale.FitemList(loopInt).FcontentName%></div>
                                <div class="price">
                                    <p style="display:<%=chkiif(isItem, "","none") %>">
                                    <% IF oTimeSale.FitemList(loopInt).Fitemdiv <> "21" THEN %>
                                        <b><%=formatnumber(oTimeSale.FitemList(loopInt).Forgprice,0)%></b>
                                    <% END IF %>
                                    <em><%=chkiif(oTimeSale.FitemList(loopInt).Fitemdiv = "21",formatnumber(oTimeSale.FitemList(loopInt).FmasterSellCash,0)&"~",totalPrice)%><span>원</span></em>
                                    </p>
                                    <% if isItem then %>                      
                                        <% IF oTimeSale.FitemList(loopInt).Fitemdiv = "21" THEN %>
                                            <% IF oTimeSale.FitemList(loopInt).FmasterDiscountRate > 0 THEN %><i class="sale">~<%=oTimeSale.FitemList(loopInt).FmasterDiscountRate%>%</i><% end if %>
                                        <% ELSE %>
                                            <% if totalSalePercent <> "0" then %><i class="sale"><%=totalSalePercent%></i><% end if %>
                                        <% END IF %>
                                    <% else %>
                                        <%if oTimeSale.FitemList(loopInt).FevtSale <> 0 then%><i class="sale">~<%=oTimeSale.FitemList(loopInt).FevtSale%>%</i><%end if%>
                                    <% end if %>
                                </div>
                            </div>
                        <% IF oTimeSale.FitemList(loopInt).Fsortnumber > 1 THEN %>
                        </a>
                        <% END IF%>
                    </li>
            <%
                    END IF
                NEXT
            %>
        </ul>
    </div>
    <% end if %>

    <%'!-- 타임세일 (예고)--%>
    <div class="coming-section" <%=fnNextDisplayCheck(fnGetCurrentType(isAdmin,currentType))(4)%>>
        <div class="inner">
            <div class="alarm"><button class="btn-alarm btn-alarm2">세일 시작전 알림받기</button> </div>
            <%'!-- 두번째 타임세일(예고) --%>
            <%
                FOR loopInt = 0 TO oTimeSale.FResultCount - 1

                    isItem = oTimeSale.FitemList(loopInt).FcontentType = 1
                    IF oTimeSale.FitemList(loopInt).Fround > 1 THEN
                        if isItem then
                            call oTimeSale.FitemList(loopInt).fnItemLimitedState(isSoldOut,RemainCount)
                            call oTimeSale.FitemList(loopInt).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)
                        end if
                        IF oTimeSale.FitemList(loopInt).Fsortnumber = 1 THEN
            %>
            <div class="time-items" <%=fnNextDisplayCheck(fnGetCurrentType(isAdmin,currentType))(oTimeSale.FitemList(loopInt).Fround)%>>
                <p class="txt-time"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/tit_time1_<%=oTimeSale.FitemList(loopInt).Fround%>.png" alt="<%=oTimeSale.FitemList(loopInt).Fround%>회 세일"></p>
                <ul>
            <%
                        END IF
            %>
                    <li>
                        <div class="thumbnail">
                            <img src="<%=oTimeSale.FitemList(loopInt).FprdImage%>" alt= "">
                            <div class="label-box">
                                <span class="label">한정판매</span><%'갯수 노출 안함%>
                            </div>
                        </div>
                        <div class="desc">
                            <div class="name"><%=oTimeSale.FitemList(loopInt).FcontentName%></div>
                            <div class="price">
                                <p style="display:<%=chkiif(isItem, "","none") %>">
                                <% IF oTimeSale.FitemList(loopInt).Fitemdiv <> "21" THEN %>
                                    <b><%=formatnumber(oTimeSale.FitemList(loopInt).Forgprice,0)%></b>
                                <% END IF %>
                                <em><%=chkiif(oTimeSale.FitemList(loopInt).Fitemdiv = "21",formatnumber(oTimeSale.FitemList(loopInt).FmasterSellCash,0)&"~",totalPrice)%><span>원</span></em>
                                </p>
                                <% if isItem then %>                      
                                    <% IF oTimeSale.FitemList(loopInt).Fitemdiv = "21" THEN %>
                                        <% IF oTimeSale.FitemList(loopInt).FmasterDiscountRate > 0 THEN %><i class="sale">~<%=oTimeSale.FitemList(loopInt).FmasterDiscountRate%>%</i><% end if %>
                                    <% ELSE %>
                                        <% if totalSalePercent <> "0" then %><i class="sale"><%=totalSalePercent%></i><% end if %>
                                    <% END IF %>
                                <% else %>
                                    <%if oTimeSale.FitemList(loopInt).FevtSale <> 0 then%><i class="sale">~<%=oTimeSale.FitemList(loopInt).FevtSale%>%</i><%end if%>
                                <% end if %>
                            </div>
                        </div>
                    </li>
            <%
                        IF oTimeSale.FitemList(loopInt).Fsortnumber = 12 THEN
            %>
                </ul>
            </div>
            <%
                        END IF
                    END IF
                NEXT
            %>
        </div>
    </div>

    <% if fnGetCurrentType(isAdmin,currentType) <>"4" then '네번째 타임세일 %>
    <div class="alarm">
        <div class="inner">
            <div>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/txt_time_nav.png" alt="하루, 단 4번의 세일찬스. 놓치면 정말정말 아깝다구요!"></p>
                <%=fnGettimeNavHtml(fnGetCurrentType(isAdmin,currentType))%>
            </div>
            <button class="btn-alarm btn-alarm1">세일 시작 전 알림받기</button>
        </div>
    </div>
    <% end if %>
</div>