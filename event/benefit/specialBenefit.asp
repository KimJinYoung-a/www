<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 쿠폰 마일리지 이벤트
' History : 2021.11.23 정태훈
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/event/benefit/NewmemberAdvantageCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<%
dim newmemberInfoObj, couponList, mileageInfo, i
set newmemberInfoObj = new NewmemberAdvantageCls
couponList = newmemberInfoObj.getNewAutoCouponList()
mileageInfo = newmemberInfoObj.getAutoMileageInfo()

dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),9))
dim SortMet		: SortMet =  requestCheckVar(request("srm"),2)
dim searchFlag 	: searchFlag = "newitem"
dim CurrPage 	: CurrPage = getNumeric(requestCheckVar(request("cpg"),9))
dim catecode	: catecode = getNumeric(requestCheckVar(request("disp"),9))
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)

dim imgSz	: imgSz = chkIIF(icoSize="M",180,150)

Dim cntless : cntless  = True

if SortMet="" then SortMet="be"		'정렬 기본값 : 인기순

dim ListDiv,ColsSize,ScrollCount
dim cdlNpage
ListDiv="newlist"
ColsSize =6
ScrollCount = 10

if CurrPage="" then CurrPage=1
if PageSize ="" then PageSize =100

dim oDoc,iLp
set oDoc = new SearchItemCls

oDoc.FListDiv 			= ListDiv
oDoc.FRectSortMethod	= SortMet
oDoc.FRectSearchFlag 	= searchFlag
oDoc.FPageSize 			= PageSize

oDoc.FCurrPage 			= CurrPage
oDoc.FSellScope			= "Y"
oDoc.FScrollCount 		= ScrollCount
oDoc.FRectSearchItemDiv ="D"
oDoc.FRectCateCode			= catecode

oDoc.getSearchList
%>
<style type="text/css">
.special-benefit {background:#f8f8f8;}
.special-benefit .bg-benefit {max-width:1920px; width:100%; height:935px; background:url(//fiximage.10x10.co.kr/web2021/specialBenefit/bg_main.jpg) no-repeat 50% 0;}
.special-benefit .topic {position:relative; width:100%; height:935px; background:url(//fiximage.10x10.co.kr/web2021/specialBenefit/bg_main.gif) no-repeat 50% 0; text-align:center;}
.special-benefit .topic h2 {padding:180px 0 45px; font-size:100px; color:#fff; font-weight:600; line-height:1;}
.special-benefit .topic .sub-txt {font-size:30px; color:#fff; font-weight:300; letter-spacing:-0.045px;}
.special-benefit .topic .txt-rolling {position:absolute; left:50%; bottom:314px; transform:translateX(-50%); display:flex; align-items:flex-end; justify-content:center;}
.special-benefit .num-group {display:flex; align-items:flex-end; color:#9a807e;}
.special-benefit .num-group ul {height:124px; overflow: hidden;}
.special-benefit .num-group li {font-size:126px; font-weight:500; line-height:1;}
.special-benefit .num-group .comma {margin:0 -0.5rem; font-size:118px; font-weight:500; line-height:1;}
.special-benefit .num-group .won {padding-bottom:0.5rem; font-size:1.49rem; font-weight:600;}
.special-benefit .head-area {padding:150px 0 80px; text-align:center;}
.special-benefit .head-area .tit {padding-bottom:30px; font-size:60px; font-weight:600; color:#121212;}
.special-benefit .head-area .tit span {color:#ff214f;}
.special-benefit .head-area .day {font-size:25.6px; font-weight:300; color:#121212;}
.special-benefit .coupon-area {width:1315px; margin:0 auto;}
.special-benefit .coupon-area ul {display:flex; align-items:center; justify-content:center; flex-wrap:wrap;}
.special-benefit .coupon-area ul li {width:392px; height:177px; padding:0 23px; margin-top:20px; background:url(//fiximage.10x10.co.kr/web2021/specialBenefit/bg_coupon.jpg) no-repeat 50% 0; text-align:center;}
.special-benefit .coupon-area ul li:nth-child(1),
.special-benefit .coupon-area ul li:nth-child(2), 
.special-benefit .coupon-area ul li:nth-child(3) {margin-top:0;}
.special-benefit .coupon-area .num {padding-top:36px; font-size:64px; font-weight:500; color:#fff; line-height:1;}
.special-benefit .coupon-area .num span {font-size:30.4px; font-weight:500; color:#fff;}
.special-benefit .coupon-area .txt {padding-top:17px; font-size:22px; font-weight:300; color:#ffbac8;}
.special-benefit .coupon-area a {display:inline-block;}
.special-benefit .noti-area {width:100%; height:360px; background:#4e4e4e;}
.special-benefit .noti-area .noti-inner {display:flex; align-items:flex-start; justify-content:center; width:1140px; margin:0 auto; padding-top:150px;}
.special-benefit .noti-area .tit {padding-right:60px; font-size:28px; font-weight:600; color:#fff;}
.special-benefit .noti-area li {position:relative; padding:0 0 10px 16px; font-size:22.4px; font-weight:300; color:#fff; text-align:left;}
.special-benefit .noti-area li::before {content:""; display:inline-block; width:9px; height:2px; position:absolute; left:0; top:14px; background:#fff;}
/* 2021-11-23 추가 */
.special-benefit .item-area {padding:100px 0 50px; background:#fff;}
.special-benefit .item-area .tit {padding-bottom:50px; text-align:center;}
.special-benefit .item-area .tit h4 {font-size:60px; color:#121212; line-height:1.3; letter-spacing:-0.13rem; font-weight:700;}
</style>
<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
<script>
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt"><!-- for dev msg : 왼쪽메뉴(카테고리명) 사용시 클래스 : partEvt / 왼쪽메뉴(카테고리명) 사용 안할때 클래스 : fullEvt -->
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contF contW">
						<!-- 이번주 깜짝 혜택 -->
						<div class="special-benefit">
                            <div class="bg-benefit">
                                <div class="topic">
                                    <h2>이번 주 깜짝 혜택</h2>
                                    <p class="sub-txt">지금만 누릴 수 있는 혜택을 확인하세요</p>
                                </div>
                            </div>
                            <%
                                if isArray(couponList) then
                                dim sdt : sdt = formatDate(couponList(3,0),"00.00.00")
                                dim edt : edt = formatDate(couponList(4,0),"00.00")
                                dim restDt : restDt = couponList(5,0)
                            %>
                            <div class="head-area">
                                <h3 class="tit">#전 상품 <span>할인쿠폰</span></h3>
                                <p class="day">사용 기간 : <%=sdt%> ~ <%=edt%>까지</p>
                            </div>
                            <div class="coupon-area">
                                <ul>
                                    <% for i=0 to uBound(couponList,2) %>
                                    <li>
                                        <p class="num"><%=FormatNumber(couponList(1,i), 0)%><span><%=chkiif(couponList(6,i) = 1,"%","원")%></span></p>
                                        <p class="txt"><%=FormatNumber(couponList(2,i), 0)%>원 이상 주문 시</p>
                                    </li>
                                    <% next %>
                                </ul>
                                <a href="/my10x10/couponbook.asp?tab=2"><img src="//fiximage.10x10.co.kr/web2021/specialBenefit/btn_coupon.jpg" alt="쿠폰 확인하러 가기"></a>
                            </div>
                            <% end if %>
                            <%
                                if isArray(mileageInfo) then
                                dim msdt : msdt = formatDate(mileageInfo(0,0),"00.00.00")
                                dim medt : medt = formatDate(mileageInfo(1,0),"00.00")
                                dim mileage : mileage = mileageInfo(2,0)
                            %>
                            <div class="head-area">
                                <h3 class="tit">#보너스 <span>마일리지</span></h3>
                                <p class="day">사용 기간 : <%=msdt%> ~ <%=medt%>까지</p>
                            </div>
                            <div class="coupon-area">
                                <ul>
                                    <li>
                                        <p class="num"><%=FormatNumber(mileage, 0)%><span>원</span></p>
                                        <p class="txt">30,000원 이상 주문 시</p>
                                    </li>
                                </ul>
                                <a href="/my10x10/mymain.asp"><img src="//fiximage.10x10.co.kr/web2021/specialBenefit/btn_milige.jpg" alt="마일리지 확인하러 가기"></a>
                            </div>
                            <% end if %>
                            <div class="noti-area">
                                <div class="noti-inner">
                                    <p class="tit">유의사항</p>
                                    <ul>
                                        <li>마일리지는 결제 시, 현금처럼 사용할 수 있습니다.</li>
                                        <li>결제 시 할인정보 > 마일리지 칸에 사용 금액을 입력 후 적용 (3만원 이상 구매 시 사용 가능)</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="item-area">
                                <div class="tit"><h4>따근따근<br/>방금 나온 신상</h4></div>
                                <!-- 상품 목록 호출 -->
                                <div class="bestAwdV17">
                                <div class="hotSectionV15" style="width:928px; margin:0 auto;">
                                    <div class="hotArticleV15">
                                        <div class="ctgyBestV15">
                                            <div class="pdtWrap pdt240V15">
                                                <ul class="pdtList">
                                            <%
                                            IF oDoc.FResultCount >0 then
                                            dim cdlNTotCnt, TotalCnt
                                            dim maxLoop	,intLoop

                                            TotalCnt = oDoc.FResultCount

                                            dim classStr, adultChkFlag, adultPopupLink, linkUrl

                                                For i=0 To TotalCnt-1
                                                    IF (i <= TotalCnt-1) Then
                                                        classStr = ""
                                                        linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(i).FItemID
                                                        adultChkFlag = false
                                                        adultChkFlag = session("isAdult") <> true and oDoc.FItemList(i).FadultType = 1
                                                        
                                                        If oDoc.FItemList(i).GetLevelUpCount > "29" then
                                                            classStr = addClassStr(classStr,"bestUpV15")															
                                                        end if
                                                        If oDoc.FItemList(i).isSoldOut=true then
                                                            classStr = addClassStr(classStr,"soldOut")							
                                                        end if				
                                                        if adultChkFlag then
                                                            classStr = addClassStr(classStr,"adult-item")								
                                                        end if																										
                                                        If i < 3 then
                                            %>
                                                    <li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> > 						
                                                        <p class="ranking">BEST <%= i+1 %></p>
                                                        <div class="pdtBox">
                                                            <% '// 해외직구배송작업추가(원승현) %>
                                                            <% If oDoc.FItemList(i).IsDirectPurchase Then %>
                                                                <i class="abroad-badge">해외직구</i>
                                                            <% End If %>
                                                            <div class="pdtPhoto">
                                                            <% if adultChkFlag then %>									
                                                            <div class="adult-hide">
                                                                <p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
                                                            </div>
                                                            <% end if %>																				
                                                                <a href="javascript:TnGotoProduct('<%=oDoc.FItemList(i).FItemID %>')">
                                                                    <span class="soldOutMask"></span>
                                                                    <img src="<% = oDoc.FItemList(i).FImageBasic %>" alt="<% = oDoc.FItemList(i).FItemName %>" />
                                                                    <% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,240,240,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
                                                                </a>
                                                            </div>
                                                            <div class="pdtInfo">
                                                                <p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(i).FMakerId %>')"><%= oDoc.FItemList(i).FBrandName %></a></p>
                                                                <p class="pdtName tPad07"><a href="javascript:TnGotoProduct('<%=oDoc.FItemList(i).FItemID %>')"><%= oDoc.FItemList(i).FItemName %></a></p>
                                                                <%
                                                                    If oDoc.FItemList(i).IsSaleItem or oDoc.FItemList(i).isCouponItem Then
                                                                        'If oDoc.FItemList(i).Fitemcoupontype <> "3" Then
                                                                        '	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(i).FOrgPrice,0) & "원 </span></p>"
                                                                        'End If
                                                                        IF oDoc.FItemList(i).IsSaleItem Then
                                                                            Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(i).FOrgPrice,0) & "원 </span></p>"
                                                                            Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(i).getRealPrice,0) & "원 </span>"
                                                                            Response.Write "<strong class='cRd0V15'>[" & oDoc.FItemList(i).getSalePro & "]</strong></p>"
                                                                        End IF
                                                                        IF oDoc.FItemList(i).IsCouponItem Then
                                                                            if Not(oDoc.FItemList(i).IsFreeBeasongCoupon() or oDoc.FItemList(i).IsSaleItem) Then
                                                                                Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(i).FOrgPrice,0) & "원 </span></p>"
                                                                            end if
                                                                            Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(i).GetCouponAssignPrice,0) & "원 </span>"
                                                                            Response.Write "<strong class='cGr0V15'>[" & oDoc.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
                                                                        End IF
                                                                    Else
                                                                        Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(i).getRealPrice,0) & "원 </span>"
                                                                    End If
                                                                %>
                                                                <p class="pdtStTag tPad10">
                                                                <%
                                                                    IF oDoc.FItemList(i).isSoldOut Then
                                                                        Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
                                                                    Else
                                                                        IF oDoc.FItemList(i).isTenOnlyItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif' alt='ONLY' /> "
                                                                        IF oDoc.FItemList(i).isSaleItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' /> "
                                                                        IF oDoc.FItemList(i).isCouponItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' /> "
                                                                        IF oDoc.FItemList(i).isLimitItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' /> "
                                                                        IF oDoc.FItemList(i).isNewItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' /> "
                                                                        IF oDoc.FItemList(i).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
                                                                    End If
                                                                %>
                                                                </p>
                                                            </div>
                                                            <ul class="pdtActionV15">
                                                                <li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oDoc.FItemList(i).FItemid%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
                                                                <li class="postView"><a href="" onclick="popEvaluate('<%=oDoc.FItemList(i).FItemid%>'); return false;"><span><%= oDoc.FItemList(i).FEvalCnt %></span></a></li>
                                                                <li class="wishView"><a href="" onclick="TnAddFavorite('<%= oDoc.FItemList(i).FItemID %>'); return false;"><span><%= oDoc.FItemList(i).FFavCount %></span></a></li>
                                                            </ul>
                                                        </div>
                                                    </li>
                                                <%
                                                        end if
                                                    End If
                                                Next
                                            End if
                                            %>
                                                </ul>
                                            </div>
                                        </div>

                                        <div class="pdtWrap pdt150V15">
                                            <ul class="pdtList">
                                            <%
                                            IF oDoc.FResultCount >0 then
                                                For i=0 To TotalCnt-1
                                                    IF (i <= TotalCnt-1) Then
                                                        classStr = ""
                                                        linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(i).FItemID
                                                        adultChkFlag = false
                                                        adultChkFlag = session("isAdult") <> true and oDoc.FItemList(i).FadultType = 1
                                                        
                                                        If oDoc.FItemList(i).GetLevelUpCount > "29" then
                                                            classStr = addClassStr(classStr,"bestUpV15")															
                                                        end if
                                                        If oDoc.FItemList(i).isSoldOut=true then
                                                            classStr = addClassStr(classStr,"soldOut")							
                                                        end if				
                                                        if adultChkFlag then
                                                            classStr = addClassStr(classStr,"adult-item")								
                                                        end if	
                                                                                        
                                                        If i > 2 then %>
                                                <li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> > 						
                                                    <p class="ranking"><%= i+1 %>.</p>
                                                    <div class="pdtBox">
                                                        <% '// 해외직구배송작업추가(원승현) %>
                                                        <% If oDoc.FItemList(i).IsDirectPurchase Then %>
                                                            <i class="abroad-badge">해외직구</i>
                                                        <% End If %>
                                                        <div class="pdtPhoto">
                                                            <% if adultChkFlag then %>									
                                                            <div class="adult-hide">
                                                                <p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
                                                            </div>
                                                            <% end if %>																			
                                                            <a href="javascript:TnGotoProduct('<%=oDoc.FItemList(i).FItemID %>')">
                                                                <span class="soldOutMask"></span>
                                                                <img src="<% = oDoc.FItemList(i).FImageIcon1 %>" alt="<% = oDoc.FItemList(i).FItemName %>" />
                                                                <% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
                                                            </a>
                                                        </div>
                                                        <div class="pdtInfo">
                                                            <p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(i).FMakerId %>')"><%= oDoc.FItemList(i).FBrandName %></a></p>
                                                            <p class="pdtName tPad07"><a href="javascript:TnGotoProduct('<%=oDoc.FItemList(i).FItemID %>')"><%= oDoc.FItemList(i).FItemName %></a></p>
                                                            <%
                                                                If oDoc.FItemList(i).IsSaleItem or oDoc.FItemList(i).isCouponItem Then
                                                                    'If oDoc.FItemList(i).Fitemcoupontype <> "3" Then
                                                                    '	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(i).FOrgPrice,0) & "원 </span></p>"
                                                                    'End If
                                                                    IF oDoc.FItemList(i).IsSaleItem Then
                                                                        Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(i).FOrgPrice,0) & "원 </span></p>"
                                                                        Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(i).getRealPrice,0) & "원 </span>"
                                                                        Response.Write "<strong class='cRd0V15'>[" & oDoc.FItemList(i).getSalePro & "]</strong></p>"
                                                                    End IF
                                                                    IF oDoc.FItemList(i).IsCouponItem Then
                                                                        if Not(oDoc.FItemList(i).IsFreeBeasongCoupon() or oDoc.FItemList(i).IsSaleItem) Then
                                                                            Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(i).FOrgPrice,0) & "원 </span></p>"
                                                                        end if
                                                                        Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(i).GetCouponAssignPrice,0) & "원 </span>"
                                                                        Response.Write "<strong class='cGr0V15'>[" & oDoc.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
                                                                    End IF
                                                                Else
                                                                    Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(i).getRealPrice,0) & "원 </span>"
                                                                End If
                                                            %>
                                                            <p class="pdtStTag tPad10">
                                                            <%
                                                                IF oDoc.FItemList(i).isSoldOut Then
                                                                    Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
                                                                Else
                                                                    IF oDoc.FItemList(i).isTenOnlyItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif' alt='ONLY' /> "
                                                                    IF oDoc.FItemList(i).isSaleItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' /> "
                                                                    IF oDoc.FItemList(i).isCouponItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' /> "
                                                                    IF oDoc.FItemList(i).isLimitItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' /> "
                                                                    IF oDoc.FItemList(i).isNewItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' /> "
                                                                    IF oDoc.FItemList(i).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
                                                                End If
                                                            %>
                                                            </p>
                                                        </div>
                                                        <ul class="pdtActionV15">
                                                            <li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oDoc.FItemList(i).FItemid%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
                                                            <li class="postView"><a href="" onclick="popEvaluate('<%=oDoc.FItemList(i).FItemid%>'); return false;"><span><%= oDoc.FItemList(i).FEvalCnt %></span></a></li>
                                                            <li class="wishView"><a href="" onclick="TnAddFavorite('<%= oDoc.FItemList(i).FItemID %>'); return false;"><span><%= oDoc.FItemList(i).FFavCount %></span></a></li>
                                                        </ul>
                                                    </div>
                                                </li>
                                                <%
                                                        end if
                                                    End If
                                                Next
                                            End if
                                            %>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                                </div>
                                <!-- 상품 목록 호출 -->
                            </div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->