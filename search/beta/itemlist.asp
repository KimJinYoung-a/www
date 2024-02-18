<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
dim classStr, adultChkFlag, adultPopupLink, linkUrl
Dim catecode, lp,sPercent, flo1, flo2
dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),9))
dim SortMet		: SortMet = requestCheckVar(request("srm"),2)
dim searchFlag 	: searchFlag = "sale"
dim CurrPage 	: CurrPage = getNumeric(requestCheckVar(request("cpg"),9))
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)
dim ListDiv,ColsSize,ScrollCount
dim cdlNpage

ListDiv = "salelist"
ColsSize = 6
ScrollCount = 10

catecode = getNumeric(requestCheckVar(Request("disp"),3))
sPercent =	getNumeric(requestCheckVar(Request("sp"),2))
flo1 =	requestCheckVar(Request("flo1"),5) '// 무료배송
flo2 =	requestCheckVar(Request("flo2"),5) '// 한정판매

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)
'추가 이미지 사이즈
dim imgSz	: imgSz = chkIIF(icoSize="M",180,150)

if SortMet ="" then SortMet="be"
if CurrPage ="" then CurrPage=1
if PageSize ="" then PageSize = 32

if (PageSize>"96") then PageSize = 96 ''2016/09/09

if isNumeric(PageSize) then
	if CLNG(PageSize)<1 then PageSize=32
	if CLNG(PageSize)>96 then PageSize=96
end if

if isNumeric(CurrPage) then
	if CLNG(CurrPage)<1 then CurrPage=1
end if

Dim iMaxValidItemCount : iMaxValidItemCount= 32*300  ''최대 표시 가능상품수 페이지가 늘어나면 겸색엔진이 느려진다.
Dim iMaxPageSize : iMaxPageSize = iMaxValidItemCount/CHKIIF(PageSize<>0,PageSize,32)
if (CLNG(CurrPage)>CLNG(iMaxPageSize)) then CurrPage=iMaxPageSize

'rw sPercent & "!"
dim oDoc,iLp
set oDoc = new SearchItemCls

oDoc.FListDiv 			= ListDiv
oDoc.FRectSortMethod	= SortMet
oDoc.FRectSearchFlag 	= searchFlag
oDoc.FPageSize 			= PageSize
oDoc.FRectCateCode		= catecode
oDoc.FisFreeBeasong		= flo1	'// 무료배송
oDoc.FisLimit			= flo2	'// 한정판매
'oDoc.FisTenOnly			= flo

oDoc.FCurrPage 			= CurrPage
oDoc.FSellScope 		= "Y"
oDoc.FScrollCount 		= ScrollCount

'할인률 적용
Select Case sPercent
	Case "99"
		oDoc.FSalePercentLow = "0"
		oDoc.FSalePercentHigh = "0.3"
	Case "70"
		oDoc.FSalePercentLow = "0.3"
		oDoc.FSalePercentHigh = "0.5"
	Case "50"
		oDoc.FSalePercentLow = "0.5"
		oDoc.FSalePercentHigh = "0.8"
	Case "20"
		oDoc.FSalePercentLow = "0.8"
		oDoc.FSalePercentHigh = "1"
end Select

oDoc.getSearchList

IF oDoc.FResultCount >0 then
    dim i,TotalCnt
    dim cdlNTotCnt, icolS,icolE, cdlNCols
    dim maxLoop	,intLoop

    TotalCnt = oDoc.FResultCount

    For i=0 To TotalCnt-1
        IF (i <= TotalCnt-1) Then
        classStr = ""
        linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(i).FItemID & "&gaparam=nowonsale_" & CHKIIF(sPercent<>"",sPercent,"all") & "_" & i+1
        adultChkFlag = false
        adultChkFlag = session("isAdult") <> true and oDoc.FItemList(i).FadultType = 1								

        If oDoc.FItemList(i).FItemDiv="21" then
            classStr = addClassStr(classStr,"deal-item")							
        end if								
        If oDoc.FItemList(i).isSoldOut=true then
            classStr = addClassStr(classStr,"soldOut")							
        end if				
        if adultChkFlag then
            classStr = addClassStr(classStr,"adult-item")								
        end if				
%>
<li class="unit unit-product">
    <div class="inner">
        <div class="banner"><a href=""><img src="//thumbnail.10x10.co.kr/webimage/image/basic600/164/B001643866-1.jpg" alt="" /></a></div>
        <div class="desc">
            <p class="location">
                <a href="">푸드</a><i class="icoV19 ico-arrow-right"></i><a href="">반조리식품</a><i class="icoV19 ico-arrow-right"></i><a href="">면/파스타</a>
            </p>
            <a href="">
                <p class="name">바른 사회 생활 어른이 엽서ㅁㅇ</p>
            </a>
            <div class="overHidden">
                <div class="price ftLt">
                    <span class="sum">9,999,900</span>
                    <span class="discount color-green">5%</span>
                </div>
                <div class="ftRt">
                    <div class="icoV19 star-rating">
                        <span style="width:60%" class="ico_star">60점</span><!-- for dev msg: 별점 %로 -->
                    </div>
                    302
                </div>
            </div>
            <div class="btn-area">
                <button type="button" class="btn-wish on"> <!-- for dev msg : wish 추가시 클래스 on -->
                    <i class="icoV19"><svg xmlns="http://www.w3.org/2000/svg" width="15" height="15"><path class="switch" fill="none" stroke="#ff3365" d="M7.48 3.176l.418-.42a3.8 3.8 0 0 1 5.375 5.375l-.418.42.004.005-5.38 5.374L2.1 8.556l.005-.005-.42-.42a3.801 3.801 0 0 1 5.375-5.375l.42.42z"/></svg></i>
                    WISH
                </button>
                <button type="button" class="btn-buy">
                    <i class="icoV19"><svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="none" stroke="#ff3365"><path class="switch" d="M1.5 3.5h12v11h-12z"/><path stroke-linecap="round" d="M10 6.5V2.867C10 1.827 8.893.5 7.5.5S5 1.827 5 2.867V6.5"/></svg></i>
                    구매하기
                </button>
            </div>
        </div>
    </div>
</li>
    <% Next %>
<% End IF %>
<%
set oDoc = Nothing
%>