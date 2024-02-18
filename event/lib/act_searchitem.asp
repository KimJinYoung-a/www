<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/classes/search/keywordcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim oDoc , i
dim SearchText : SearchText = requestCheckVar(request("rect"),100) '현재 입력된 검색어
dim SearchItemDiv : SearchItemDiv="y"	'기본 카테고리만
dim CurrPage : CurrPage = getNumeric(requestCheckVar(request("cpg"),6))
dim SearchFlag : SearchFlag = NullfillWith(requestCheckVar(request("sflag"),2),"n")
dim minPrice : minPrice = getNumeric(requestCheckVar(Replace(request("minPrc"),",",""),8))
dim maxPrice : maxPrice = getNumeric(requestCheckVar(Replace(request("maxPrc"),",",""),8))
dim CheckResearch : CheckResearch= request("chkr")
dim CheckExcept : CheckExcept= request("chke")
dim SellScope 	: SellScope=requestCheckVar(request("sscp"),1)			'품절상품 제외여부
dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),5))
dim SortMet		: SortMet = requestCheckVar(request("srm"),2)
Dim mode : mode = requestCheckVar(request("mode"),1) ''리스트형 썸네일형
Dim ListDiv : ListDiv = ReplaceRequestSpecialChar(request("lstdiv"))	'카테고리/검색 구분용
Dim linkUrl

Dim ListText

SELECT CASE minPrice
    CASE "690"
        ListText = "#1만원이하"
    CASE "10000"
        ListText = "#1만원대"
    CASE "20000"
        ListText = "#2만원대"
    CASE "30000"
        ListText = "#3만원이상"
    CASE ELSE
        ListText = "#1만원이하"
END SELECT

if SortMet="" then SortMet="bs"		'베스트:be, 신상:ne
if ListDiv="" then ListDiv="search"
if CurrPage = "" then CurrPage = 1
if PageSize = "" then PageSize = 5
if SellScope = "" then SellScope = "N"

SearchText = RepWord(SearchText,"[^ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9.&%+\-\_\(\)\/\\\[\]\~\s]","")

'//상품후기 총점수 %로 환산
Public function fnEvalTotalPointAVG2(t,g)
	dim vTmp
	vTmp = 0
	If t <> "" Then
		If isNumeric(t) Then
			If t > 0 Then
				If g = "search" Then
					vTmp = (t/5)
				Else
					vTmp = ((Round(t,2) * 100)/5)
				End If
				vTmp = Round(vTmp)
			End If
		End If
	End If
	fnEvalTotalPointAVG2 = vTmp
end function

set oDoc = new SearchItemCls
    oDoc.FRectSearchTxt = SearchText
    oDoc.FminPrice	= minPrice
	oDoc.FmaxPrice	= maxPrice
    oDoc.FCurrPage = CurrPage
	oDoc.FPageSize = PageSize
    oDoc.FListDiv  = ListDiv
    oDoc.FRectSortMethod = SortMet
    oDoc.FSellScope		= SellScope
    oDoc.FScrollCount 	= 1
    oDoc.FRectSearchItemDiv = SearchItemDiv
    oDoc.getSearchList

    linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(i).FItemID

    If oDoc.FTotalCount > 0 Then
%>
<p class="tit"><%=ListText%></p>
<ul class="item-list">
<%
        For i=0 To oDoc.FResultCount-1
%>
        <% If oDoc.FItemList(i).FItemDiv="21" Then %>
            <li>
                <a href="<%=linkUrl%>">
                    <div class="thumbnail">
                        <img src="<%= getThumbImgFromURL(oDoc.FItemList(i).FImageBasic,300,300,"true","false") %>" alt="<%=oDoc.FItemList(i).FItemName%>">
                        <% If oDoc.FItemList(i).isSoldOut Then Response.Write "<b class=""soldout"">일시 품절</b>" End If %>
                    </div>
                    <div class="desc">
                        <div class="price-area">
                            <div class="price">
                                <%
                                    If oDoc.FItemList(i).FOptionCnt="" Or oDoc.FItemList(i).FOptionCnt="0" Then	'### 쿠폰 X 세일 O
                                        Response.Write "<b class=""sum"">" & FormatNumber(oDoc.FItemList(i).getOrgPrice,0) & "<span class=""won"">" & CHKIIF(oDoc.FItemList(i).IsMileShopitem," Point","원") & "</span></b>" &  vbCrLf
                                    Else
                                        Response.Write "<b class=""sum"">" & FormatNumber(oDoc.FItemList(i).getOrgPrice,0) & "<span class=""won"">원</span></b>"
                                        Response.Write "<b class=""discount sale"">" & oDoc.FItemList(i).FOptionCnt & "%</b>"
                                    End If
                                %>
                            </div>
                        </div>
                        <p class="name"><%=oDoc.FItemList(i).FItemName%></p>
                    </div>
                    <% If oDoc.FItemList(i).FEvalCnt > 0 Then %>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:<%=fnEvalTotalPointAVG2(oDoc.FItemList(i).FPoints,"search")%>%;"></i></span><span class="counting" title="리뷰 갯수"><%=CHKIIF(oDoc.FItemList(i).FEvalCnt>999,"999+",oDoc.FItemList(i).FEvalCnt)%></span></div>
                    </div>
                    <% End If %>
                </a>
            </li>
        <% else %>
            <li>
                <a href="<%=linkUrl%>">
                    <div class="thumbnail">
                        <img src="<%= getThumbImgFromURL(oDoc.FItemList(i).FImageBasic,300,300,"true","false") %>" alt="<%=oDoc.FItemList(i).FItemName%>">
                        <% If oDoc.FItemList(i).isSoldOut Then Response.Write "<b class=""soldout"">일시 품절</b>" End If %>
                    </div>
                    <div class="desc">
                        <div class="price-area">
                            <div class="price">
                                <%
                                    If oDoc.FItemList(i).IsSaleItem AND oDoc.FItemList(i).isCouponItem Then	'### 쿠폰 O 세일 O
                                        Response.Write "<b class=""sum"">" & FormatNumber(oDoc.FItemList(i).GetCouponAssignPrice,0) & "<span class=""won"">원</span></b>"
                                        Response.Write "<b class=""discount color-red"">" & oDoc.FItemList(i).getSalePro & "</b>"
                                        If oDoc.FItemList(i).Fitemcoupontype <> "3" Then	'### 무료배송아닌것
                                            If InStr(oDoc.FItemList(i).GetCouponDiscountStr,"%") < 1 Then	'### 금액 쿠폰은 쿠폰으로 표시
                                                Response.Write "<b class=""discount color-green""><small>쿠폰</small></b>"
                                            Else
                                                Response.Write "<b class=""discount color-green"">" & oDoc.FItemList(i).GetCouponDiscountStr & "<small>쿠폰</small></b>"
                                            End If
                                        End If
                                    ElseIf oDoc.FItemList(i).IsSaleItem AND (Not oDoc.FItemList(i).isCouponItem) Then	'### 쿠폰 X 세일 O
                                        Response.Write "<b class=""sum"">" & FormatNumber(oDoc.FItemList(i).getRealPrice,0) & "<span class=""won"">원</span></b>"
                                        Response.Write "<b class=""discount color-red"">" & oDoc.FItemList(i).getSalePro & "</b>"
                                    ElseIf oDoc.FItemList(i).isCouponItem AND (NOT oDoc.FItemList(i).IsSaleItem) Then	'### 쿠폰 O 세일 X
                                        Response.Write "<b class=""sum"">" & FormatNumber(oDoc.FItemList(i).GetCouponAssignPrice,0) & "<span class=""won"">원</span></b>"
                                        If oDoc.FItemList(i).Fitemcoupontype <> "3" Then	'### 무료배송아닌것
                                            If InStr(oDoc.FItemList(i).GetCouponDiscountStr,"%") < 1 Then	'### 금액 쿠폰은 쿠폰으로 표시
                                                Response.Write "<b class=""discount color-green""><small>쿠폰</small></b>"
                                            Else
                                                Response.Write "<b class=""discount color-green"">" & oDoc.FItemList(i).GetCouponDiscountStr & "<small>쿠폰</small></b>"
                                            End If
                                        End If
                                    Else
                                        Response.Write "<b class=""sum"">" & FormatNumber(oDoc.FItemList(i).getRealPrice,0) & "<span class=""won"">" & CHKIIF(oDoc.FItemList(i).IsMileShopitem,"Point","원") & "</span></b>" &  vbCrLf
                                    End If
                                %>
                            </div>
                        </div>
                        <p class="name"><%=oDoc.FItemList(i).FItemName%></p>
                    </div>
                    <% If oDoc.FItemList(i).FEvalCnt > 0 Then %>
                    <div class="etc">
                        <div class="tag review"><span class="icon icon-rating"><i style="width:<%=fnEvalTotalPointAVG2(oDoc.FItemList(i).FPoints,"search")%>%;"></i></span><span class="counting" title="리뷰 갯수"><%=CHKIIF(oDoc.FItemList(i).FEvalCnt>999,"999+",oDoc.FItemList(i).FEvalCnt)%></span></div>
                    </div>
                    <% End If %>
                </a>
            </li>
        <% end if %>
<%
        next
%>
</ul>
<a href="/search/search_result.asp?search_on=on&rect=<%=SearchText%>&cpg=1&psz=15&minPrc=<%=minPrice%>&maxPrc=<%=maxPrice%>" class="btn-more">더 보러가기</a>
<%
    end if 
set oDoc = nothing
%>
