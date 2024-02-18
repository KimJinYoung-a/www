<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/newawardcls_B.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls_B.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'####################################################
' Description : 정기세일 BEST 기간별
' History : 2020-03-20 이종화
'####################################################
Dim flag, atype, vDisp, vSaleFreeDeliv
dim Dategubun : Dategubun = RequestCheckVar(request("dategubun"),1)	'기간별 검색 w:주간, m:월간 , d:일간
dim CurrPage : CurrPage = getNumeric(request("cpg"))
Dim gaparam, userid
dim classStr, adultChkFlag, adultPopupLink, linkUrl
dim minPrice '검색 최저가

dim bdgUid, bdgBno, arrUserid
dim oEval, lp, lp2

vDisp = RequestCheckVar(request("vdisp"),3)
flag = RequestCheckVar(request("flag"),1)
atype = RequestCheckVar(request("atype"),2)
userid = getLoginUserid()

if CurrPage="" then CurrPage=1
if atype="" then atype="dt"		'fnATYPErandom()

Dim oaward, i, iLp, sNo, eNo, tPg, chgtype, vWishArr, vZzimArr

'// 정렬방법 통일로 인한 코드 변환
Select Case atype
	Case "ne":
		chgtype = "n"
		minPrice=4500		'신상품
		gaparam = "&gaparam=tbest_new_"
	Case "st":
		chgtype = "t"
		minPrice=4500		'스테디셀러
		gaparam = "&gaparam=tbest_steady_"
	Case "vi":
		chgtype = "i"
		minPrice=10000		'후기
		gaparam = "&gaparam=tbest_vip_"
	Case "dt": 
		chgtype = "d" 
		minPrice=5000		'기간별 베스트
		gaparam = "&gaparam=tbest_date_"
	Case Else:
		chgtype = "b"
		minPrice=4500		'기본값(인기순)
End Select

if chgtype="n" then
    ''신상품 베스트
    set oaward = new SearchItemCls
	    oaward.FListDiv 		= "newlist"
	    oaward.FRectSortMethod	= "be"
	    oaward.FRectSearchFlag 	= "newitem"
	    oaward.FPageSize 		= 200
	    oaward.FCurrPage 		= 1
	    oaward.FSellScope		= "Y"
	    oaward.FScrollCount 	= 1
	    oaward.FRectSearchItemDiv ="D"
	    oaward.FRectCateCode	  = vDisp
	    oaward.FminPrice	= minPrice
	    oaward.FSalePercentLow = 0.89
	    oaward.getSearchList
ElseIf chgtype = "t" Then  '//스테디 베스트
	set oaward = new CAWard
		oaward.FPageSize = 200
		oaward.FRectCateCode		= vDisp
		oaward.GetSteadyItemList_2017

	If (oaward.FResultCount < 3) Then
		set oaward = Nothing
		set oaward = new SearchItemCls
			oaward.FListDiv 			= "bestlist"
			oaward.FRectSortMethod	    = "be"
			''oaward.FRectSearchFlag 	= "newitem"  ''검색범위
			oaward.FPageSize 			= 200
			oaward.FCurrPage 			= 1
			oaward.FSellScope			= "Y"
			oaward.FScrollCount 		= 1
			oaward.FRectSearchItemDiv   ="D"
			oaward.FRectCateCode		= vDisp
			oaward.FminPrice	= minPrice
			oaward.getSearchList
	End if
ElseIf chgtype = "i" Then
    IF CurrPage > 10 THEN 
        response.end
    END IF

	set oEval = new CSpecial
        oEval.FCurrpage = CurrPage
        oEval.FScrollCount = 1
        oEval.FRectSort = "pnt"
        oEval.FRectCateCode = vDisp
        oEval.FPageSize = 20
        oEval.FRectMode = "item"
        oEval.FRegdateS = Left(dateAdd("d",-14,now()),10) 	''검색 느림 날짜 조건 추가 /eastone /1달=>14일로 수정 필요
        ''oEval.FRegdateS = Left(dateAdd("yyyy",-4,date()),10)
        oEval.FRegdateE = Left(dateAdd("d",+1,now()),10)   	''검색 느림 날짜 조건 추가 /eastone
        
        oEval.GetBestReviewAllList

ElseIf chgtype = "d" Then 	'기간별 검색
	if Dategubun <> "d" then
		set oaward = new CAWard
			oaward.FPageSize = 200
			oaward.FRectDategubun 		= Dategubun
			oaward.FRectCateCode		= vDisp
			oaward.GetDateItemList
	else
		set oaward = Nothing
		set oaward = new SearchItemCls
			oaward.FListDiv 			= "bestlist"
			oaward.FRectSortMethod	    = "be"
			''oaward.FRectSearchFlag 	= "newitem"  ''검색범위
			oaward.FPageSize 			= 200
			oaward.FCurrPage 			= 1
			oaward.FSellScope			= "Y"
			oaward.FScrollCount 		= 1
			oaward.FRectSearchItemDiv   ="D"
			oaward.FRectCateCode		= vDisp
			oaward.FminPrice			= minPrice
			oaward.FawardType			= "period"
			oaward.getSearchList
	end if
	If (oaward.FResultCount < 3) Then
		set oaward = Nothing
		set oaward = new SearchItemCls
			oaward.FListDiv 			= "bestlist"
			oaward.FRectSortMethod	    = "be"
			''oaward.FRectSearchFlag 	= "newitem"  ''검색범위
			oaward.FPageSize 			= 200
			oaward.FCurrPage 			= 1
			oaward.FSellScope			= "Y"
			oaward.FScrollCount 		= 1
			oaward.FRectSearchItemDiv   ="D"
			oaward.FRectCateCode		= vDisp
			oaward.FminPrice			= minPrice
			oaward.FawardType			= "period"
			oaward.getSearchList
	End if
else
    set oaward = new CAWard
	    oaward.FPageSize = 200
	    oaward.FRectDisp1   = vDisp
		oaward.FRectAwardgubun = chgtype
		oaward.GetNormalItemList

	If (oaward.FResultCount < 3) Then
		set oaward = Nothing
		set oaward = new SearchItemCls
	        oaward.FListDiv 			= "bestlist"
	        oaward.FRectSortMethod	    = "be"
	        ''oaward.FRectSearchFlag 	= "newitem"  ''검색범위
	        oaward.FPageSize 			= 200
	        oaward.FCurrPage 			= 1
	        oaward.FSellScope			= "Y"
	        oaward.FScrollCount 		= 1
	        oaward.FRectSearchItemDiv   ="D"
	        oaward.FRectCateCode		= vDisp
	        oaward.FminPrice	= minPrice
	        oaward.getSearchList
	End if
end If

'//기본형 
If atype = "ne" Or atype = "be" Or atype = "ws" Or atype = "hs" Or atype = "st" Or atype = "dt" Or atype = "lv" Or atype = "ag"  Or atype = "mz" Or atype = "fo" Then
	if CurrPage=1 then
		sNo=0
		eNo=19
	else
		sNo=(CurrPage-1) * 20
		eNo=(CurrPage * 20)-1
	end if

	if (oaward.FResultCount-1)<eNo then eNo = oaward.FResultCount-1

	tPg = (oaward.FResultCount\20)
	if (tPg<>(oaward.FResultCount/20)) then tPg = tPg +1

	If oaward.FResultCount > sNo Then
		If oaward.FResultCount Then
			For i=sNo to eNo
				classStr = ""
				linkUrl = "/shopping/category_prd.asp?itemid="& oaward.FItemList(i).FItemID & gaparam & i+1
				adultChkFlag = session("isAdult") <> true and oaward.FItemList(i).FadultType = 1																	
				
				if adultChkFlag then
					classStr = addClassStr(classStr,"adult-item")								
				end if					
%>
                <li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%>> 
                    <a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemID %>">
                        <div class="thumbnail">
                            <img src="<%=getThumbImgFromURL(oaward.FItemList(i).FImageBasic,"286","286","true","false") %>" alt="" />
							<% if adultChkFlag then %>									
							<div class="adult-hide">
								<p>19세 이상만 <br />구매 가능한 상품입니다</p>
							</div>
							<% end if %>
							<div class="badge"><%= i+1 %></div>
							<% IF oaward.FItemList(i).IsCouponItem AND oaward.FItemList(i).GetCouponDiscountStr = "무료배송" Then %>
							<div class="badge-group">
								<div class="badge-item badge-delivery">무료배송</div>
							</div>
							<% End If %>
                        </div>
                        <div class="desc">
                            <div class="price-area">
								<%
									If oaward.FItemList(i).IsSaleItem AND oaward.FItemList(i).isCouponItem Then	'### 쿠폰 O 세일 O
										Response.Write "<span class=""price"">" & FormatNumber(oaward.FItemList(i).GetCouponAssignPrice,0) & "</span>"
										Response.Write "<b class=""discount sale"">" & oaward.FItemList(i).getSalePro & "</b>"
										If oaward.FItemList(i).Fitemcoupontype <> "3" Then	'### 무료배송아닌것
											If InStr(oaward.FItemList(i).GetCouponDiscountStr,"%") < 1 Then	'### 금액 쿠폰은 쿠폰으로 표시
												Response.Write "<b class=""discount coupon""><small>쿠폰</small></b>"
											Else
												Response.Write "<b class=""discount coupon"">" & oaward.FItemList(i).GetCouponDiscountStr & "</b>"
											End If
										End If
										
									ElseIf oaward.FItemList(i).IsSaleItem AND (Not oaward.FItemList(i).isCouponItem) Then	'### 쿠폰 X 세일 O
										Response.Write "<span class=""price"">" & FormatNumber(oaward.FItemList(i).getRealPrice,0) & "</b>"
										Response.Write "<b class=""discount sale"">" & oaward.FItemList(i).getSalePro & "</b>"
										
									ElseIf oaward.FItemList(i).isCouponItem AND (NOT oaward.FItemList(i).IsSaleItem) Then	'### 쿠폰 O 세일 X
										Response.Write "<span class=""price"">" & FormatNumber(oaward.FItemList(i).GetCouponAssignPrice,0) & "</b>"
										If oaward.FItemList(i).Fitemcoupontype <> "3" Then	'### 무료배송아닌것
											If InStr(oaward.FItemList(i).GetCouponDiscountStr,"%") < 1 Then	'### 금액 쿠폰은 쿠폰으로 표시
												Response.Write "<b class=""discount coupon""><small>쿠폰</small></b>"
											Else
												Response.Write "<b class=""discount coupon"">" & oaward.FItemList(i).GetCouponDiscountStr & "</b>"
											End If
										End If
									Else
										Response.Write "<span class=""price"">" & FormatNumber(oaward.FItemList(i).getRealPrice,0) & "</span>" &  vbCrLf
									End If
								%>
							</div>
                            <p class="name"><%=oaward.FItemList(i).FItemName %></p>
                        </div>
                    </a>
                </li>
<% 
			vSaleFreeDeliv = ""
			Next 
		End If
	End If
End If
' 후기
If atype = "vi" Then

    '사용자 아이디 모음 생성(for Badge)
    For lp = 0 To oEval.FResultCount-1
        arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oEval.FItemList(lp).FUserID) & "''"
    Next

    '뱃지 목록 접수(순서 랜덤)
    Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")
    
    For lp=0 To (oEval.FResultCount-1)
%>
            <li>
                <div class="pdtBox">
                    <div class="pdtPhoto">
                        <% IF oEval.FItemList(lp).isTempSoldOut Then %>
                        <span class="soldOutMask"></span>
                        <% end if %>
                        <a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%>"><span <% if oEval.FItemList(lp).isSoldOut then response.write "class='soldOutMask'" %>></span><img src="<%=oEval.FItemList(lp).FImageBasic%>"  alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
                    </div>
                    <div class="pdtInfo ftRt">
                        <p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oEval.FItemList(lp).FMakerId%>"><%=oEval.FItemList(lp).Fbrandname%></a></p>
                        <p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%>"><%=oEval.FItemList(lp).Fitemname%></a></p>
						<p class="pdtPrice">
                        <%
                            if oEval.FItemList(lp).IsSaleItem or oEval.FItemList(lp).isCouponItem Then
                                Response.Write "<span class=""txtML"">" & FormatNumber(oEval.FItemList(lp).getOrgPrice,0) & "원</span>"
                                IF oEval.FItemList(lp).IsSaleItem then
                                    Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
                                ELSEIF oEval.FItemList(lp).IsCouponItem then
                                    Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).GetCouponAssignPrice,0) & "원</span>"
                                End IF
                            Else
                                Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
                            End if
                        %>
						</p>
                        <p class="pdtStTag badge-area tPad10">
                            <% IF oEval.FItemList(lp).isSaleItem Then %><em class="badge-sale"><%=oEval.FItemList(lp).getSalePro%></em><% end if %>
                            <% IF oEval.FItemList(lp).isCouponItem Then %><em class="badge-cpn"><%=oEval.FItemList(lp).GetCouponDiscountStr%></em><% end if %>
                            <% IF oEval.FItemList(lp).IsTenOnlyitem Then %><em class="badge-only">ONLY</em><% end if %>
                            <% IF oEval.FItemList(lp).isNewItem Then %><em class="badge-launch">런칭</em><% end if %>
                        </p>
                    </div>
                    <ul class="pdtActionV15">
                        <li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oEval.FItemList(lp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
                        <li class="postView"><a href="" <%=chkIIF(oEval.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oEval.FItemList(lp).Fitemid & "'); return false;""","")%>><span><%=oEval.FItemList(lp).FEvalcnt%></span></a></li>
                        <li class="wishView"><a href="" onclick="TnAddFavorite('<%=oEval.FItemList(lp).Fitemid %>'); return false;"><span><%= oEval.FItemList(lp).FfavCount %></span></a></li>
                    </ul>
                </div>
                <div class="reviewBoxV15">
                    <%
                    '//상품고시관련 상품후기 제외 상품이 아닐경우
                    if oEval.FItemList(lp).fEval_excludeyn="N" then
                    %>
                        <p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoints%>.png" alt="별<%=oEval.FItemList(lp).FPoints%>개" /></p>
                        <div class="reviewTxt">
                            <a href="" onclick="popEvaluateDetail(<%=oEval.FItemList(lp).Fitemid%>,<%=oEval.FItemList(lp).Fidx%>);return false;" title="상세 리뷰 보기"><% = chrbyte(oEval.FItemList(lp).Fcontents,160,"Y") %></a>
                        </div>
                    <%
                    '//상품고시관련 상품후기 제외 상품일경우
                    else
                    %>
                        <p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoints%>.png" alt="별<%=oEval.FItemList(lp).FPoints%>개" /></p>
                        <ul class="reviewFoodV15">
                            <li><span>기능</span><em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_fun%>.png" alt="별<%=oEval.FItemList(lp).FPoint_fun%>개" /></em></li>
                            <li><span>가격</span><em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_prc%>.png" alt="별<%=oEval.FItemList(lp).FPoint_prc%>개" /></em></li>
                            <li><span>디자인</span><em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_dgn%>.png" alt="별<%=oEval.FItemList(lp).FPoint_dgn%>개" /></em></li>
                            <li><span>만족도</span><em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_stf%>.png" alt="별<%=oEval.FItemList(lp).FPoint_stf%>개" /></em></li>
                        </ul>
                    <% end if %>
                    <a href="" onclick="popEvaluate(<%=oEval.FItemList(lp).Fitemid%>);return false;" title="상품 전체 리뷰 보기" class="more1V15">상품 전체 리뷰보기</a>
                    <div class="reviewWriteV15">
                        <p>
                            <span><% = printUserId(oEval.FItemList(lp).Fuserid,2,"*") %></span>
                            <%=getUserBadgeIcon(oEval.FItemList(lp).FUserID,bdgUid,bdgBno,3)%>
                        </p>
                        <em>ㅣ</em>
                        <span><% = FormatDate(oEval.FItemList(lp).FBRWriteRegdate,"0000/00/00") %></span>
                    </div>
                </div>
            </li>
<% 
    NEXT
END IF
set oaward = Nothing
set oEval = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->