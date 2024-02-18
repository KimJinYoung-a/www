<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/sale2020/sale2020Cls.asp" -->
<%
'####################################################
' Description : 정기세일 기획전
' History : 2020-03-25 이종화
'####################################################
dim oExhibition , i
dim arrExhibitionLists
dim pageSize : pageSize = 20
dim eventId , eventMobileImage , eventTitle , eventSubTitle , eventSalePercent , eventCouponPercent
dim isSale , isCoupon , isGift , isComment , isBBS , isItemps , isApply , isOnlyTen , isOnePlusOne , isNew , isBookingSell , isFreedelivery
dim eName , eNameredsale

set oExhibition = new sale2020Cls
    arrExhibitionLists = oExhibition.getMainExhibitionListsForPC()
set oExhibition = nothing 

IF isArray(arrExhibitionLists) THEN
%>
<ul class="item-list exhibition">
<%
    FOR i = 0 TO Ubound(arrExhibitionLists,2)
        eventId             = arrExhibitionLists(0,i)
        eventMobileImage    = arrExhibitionLists(1,i)
        eventTitle          = arrExhibitionLists(2,i)
        eventSubTitle       = arrExhibitionLists(3,i)
        eventSalePercent    = arrExhibitionLists(4,i)
        eventCouponPercent  = arrExhibitionLists(5,i)
        isSale              = arrExhibitionLists(6,i)
        isCoupon            = arrExhibitionLists(7,i)
        isGift              = arrExhibitionLists(8,i)
        isComment           = arrExhibitionLists(9,i)
        isBBS               = arrExhibitionLists(10,i)
        isItemps            = arrExhibitionLists(11,i)
        isApply             = arrExhibitionLists(12,i)
        isOnlyTen           = arrExhibitionLists(13,i)
        isOnePlusOne        = arrExhibitionLists(14,i)
        isNew               = arrExhibitionLists(15,i)
        isBookingSell       = arrExhibitionLists(16,i)
        isFreedelivery      = arrExhibitionLists(17,i)

        If isSale Or isCoupon Then
            if ubound(Split(eventTitle,"|"))> 0 Then
                If isSale Or (isSale And isCoupon) then
                    eName	= cStr(Split(eventTitle,"|")(0))
                    eNameredsale	= cStr(Split(eventTitle,"|")(1))
                ElseIf isCoupon Then
                    eName	= cStr(Split(eventTitle,"|")(0))
                    eNameredsale	= cStr(Split(eventTitle,"|")(1))
                End If
            Else
                eName = eventTitle
                eNameredsale	= ""
            end If
        Else
            eName = eventTitle
            eNameredsale	= ""
        End If
%> 
    <li>
        <a href="/event/eventmain.asp?eventid=<%=eventId%>">
            <div class="thumbnail">
                <img src="<%=eventMobileImage%>" alt="">
            </div>
            <div class="desc">
                <div class="badge-area">
                    <% IF isSale THEN %><em class="badge-sale"><%=eNameredsale%></em><% END IF %>
                    <% IF isCoupon THEN %><em class="badge-cpn"><%=isCoupon%> 쿠폰</em><% END IF %>
                    <% IF isOnlyTen THEN %><em class="badge-only">ONLY</em><% END IF %>
                    <% IF isGift THEN %><em class="badge-gift">GIFT</em><% END IF %>
                    <% IF isOnePlusOne THEN %><em class="badge-plus">1+1</em><% END IF %>
                    <% IF isNew THEN %><em class="badge-launch">런칭</em><% END IF %>
                    <% IF isFreedelivery THEN %><em class="badge-free">무료배송</em><% END IF %>
                    <% IF isBookingSell THEN %><em class="badge-book">예약판매</em><% END IF %>
                </div>
                <div class="tit"><%=eName%></div>
                <div class="subcopy"><%=eventSubTitle%></div>
            </div>
        </a>
    </li>
<% 
    NEXT 
%>
</ul>
<%
END IF
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->