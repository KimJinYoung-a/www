<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
'####################################################
' Description : 정기세일 BEST WISH
' History : 2020-03-25 이종화
'####################################################
 '' 2차서버로 변경 2014/09/30 dbopen.asp => dbCTopen.asp, dbclose.asp =>dbCTclose.asp, fnPopularList => fnPopularList_CT
Dim cPopular, vDisp, vSort, vCurrPage, i, j, vArrEval , PageSize , vSaleFreeDeliv
vDisp = RequestCheckVar(Request("vdisp"),18)
vCurrPage = RequestCheckVar(Request("cpg"),5)

If vCurrPage = "" Then vCurrPage = 1

IF vCurrPage > 10 THEN 
    response.end
END IF

SET cPopular = New CMyFavorite
    cPopular.FPageSize = 20
    cPopular.FCurrpage = vCurrPage
    cPopular.FRectDisp = vDisp
    cPopular.FRectSortMethod = 1
    cPopular.fnPopularList_CT

Public Function fnCouponDiscountString(Fitemcoupontype , Fitemcouponvalue)
    Select Case Fitemcoupontype
        Case "1"
            fnCouponDiscountString = CStr(Fitemcouponvalue)
        Case "2"
            fnCouponDiscountString = CStr(Fitemcouponvalue)
        Case "3"
            fnCouponDiscountString = 0
        Case Else
            fnCouponDiscountString = Fitemcouponvalue
    End Select
End Function
%>

<% If (cPopular.FResultCount > 0) Then %>
	<% For i = 0 To cPopular.FResultCount-1 %>
        <li>
            <a href="/shopping/category_prd.asp?itemid=<%=cPopular.FItemList(i).FItemId%>">
                <div class="thumbnail">
                    <img src="<% = cPopular.FItemList(i).FImageBasic %>" alt="" />
                    <div class="badge badge-wish"><%=formatnumber(cPopular.FItemList(i).FFavCount,0)%>명</div>
                    <% IF cPopular.FItemList(i).FsellYn = "N" THEN %>
                    <span class="soldout"><span class="ico-soldout">일시품절</span></span>
                    <% END IF %>
                    <% IF cPopular.FItemList(i).IsCouponItem THEN %>
                        <% IF cPopular.FItemList(i).IsFreeBeasongCoupon() THEN %>
                    <div class="badge-group">
                        <div class="badge-item badge-delivery">무료배송</div>
                    </div>
                        <% END IF %>
                    <% END IF %>
                    
                </div>
                <div class="desc">
                    <div class="price-area">
                        <% if cPopular.FItemList(i).IsSaleItem or cPopular.FItemList(i).isCouponItem Then %>
                            <% IF cPopular.FItemList(i).IsSaleItem and cPopular.FItemList(i).isCouponItem then %>
                                <span class="price"><%=FormatNumber(cPopular.FItemList(i).GetCouponAssignPrice,0)%></span>
                            <% elseif cPopular.FItemList(i).IsSaleItem then %>
                                <span class="price"><%=FormatNumber(cPopular.FItemList(i).getRealPrice,0)%></span>
                            <% else %>
                                <span class="price"><%=FormatNumber(cPopular.FItemList(i).GetCouponAssignPrice,0)%></span>
                            <% End If %>
                        <% else %>
                            <span class="price"><%=FormatNumber(cPopular.FItemList(i).getRealPrice,0)%></span>
                        <% end if %>

                        <% if cPopular.FItemList(i).IsSaleItem or cPopular.FItemList(i).isCouponItem Then %>
                            <% IF cPopular.FItemList(i).IsSaleItem then %>
                            <b class="discount sale"><%=cPopular.FItemList(i).getSalePro%></b>
                            <% End If %>
                            <% IF fnCouponDiscountString(cPopular.FItemList(i).Fitemcoupontype,cPopular.FItemList(i).Fitemcouponvalue) > 0 THEN %>
                            <b class="discount coupon"><%=fnCouponDiscountString(cPopular.FItemList(i).Fitemcoupontype,cPopular.FItemList(i).Fitemcouponvalue)%>%</b>
                            <% END IF %>
                        <% end if %>
                    </div>
                    <p class="name"><%=cPopular.FItemList(i).Fitemname%></p>
                </div>
            </a>
        </li>
	<% Next %>
<% end if %>
<%
SET cPopular = Nothing
%>
<!-- #include virtual="/lib/db/dbCTclose.asp" -->