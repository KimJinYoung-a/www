<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/classes/item/dealCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/ItemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<%
dim itemid, oItem, itEvtImg, itEvtImgMap, itEvtImgNm, sCatNm, lp, LoginUserid, cpid, addEx, viewnum, preitemid, nextitemid
dim oADD, i, ix, catecode, cTalk, vTalkCnt, makerid, itemVideos, IsTicketItem, vOrderBody, clsDiaryPrdCheck, dealitemid, Safety
itemid = requestCheckVar(request("itemid"),9)
viewnum = requestCheckVar(request("viewnum"),2)
dealitemid = requestCheckVar(request("dealitemid"),9)
LoginUserid = getLoginUserid()

'======================================== 상품코드 정확성체크 및 상품관련내용 ====================================
if itemid="" or itemid="0" then
	Call Alert_Return("상품번호가 없습니다.")
	response.End
elseif Not(isNumeric(itemid)) then
	Call Alert_Return("잘못된 상품번호입니다.")
	response.End
else	'정수형태로 변환
	itemid=CLng(getNumeric(itemid))
end if

if itemid=0 then
	Call Alert_Return("잘못된 상품번호입니다.")
	response.End
end if

if Not(isNumeric(dealitemid)) then
	Call Alert_Return("딜 상품 정보가 부족합니다.")
	response.End
end if

set oItem = new CatePrdCls
oItem.GetItemData itemid

if oItem.FResultCount=0 then
	Call Alert_Return("존재하지 않는 상품입니다.")
	response.End
end if
if oItem.Prd.Fisusing="N" then
	if GetLoginUserLevel()=7 then
		'STAFF는 종료상품도 표시
		Response.Write "<script>alert('판매가 종료되었거나 삭제된 상품입니다.');</script>"
	else
		'// 수정 2017-03-09 이종화 - 종료 상품일시 - page redirect
		'Call Alert_Return("판매가 종료되었거나 삭제된 상품입니다.")
		'response.End
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	end if
end if

itemid = oItem.Prd.FItemid
makerid = oItem.Prd.FMakerid
catecode = requestCheckVar(request("disp"),18)
If catecode <> "" Then
	If IsNumeric(catecode) = False Then
		catecode = ""
	End If
End If

if catecode="" or (len(catecode) mod 3)<>0 then catecode = oItem.Prd.FcateCode

'// 상품설명 추가
set addEx = new CatePrdCls
	addEx.getItemAddExplain itemid

'//제품 안전 인증 정보
set Safety = new CatePrdCls
Safety.getItemSafetyCert itemid

'// 상품상세설명 동영상 추가
Set itemVideos = New catePrdCls
	itemVideos.fnGetItemVideos itemid, "video1"

'=============================== 추가 이미지 & 추가 이미지-메인 이미지 ==========================================
set oADD = new CatePrdCls
oADD.getAddImage itemid

function ImageExists(byval iimg)
	if (IsNull(iimg)) or (trim(iimg)="") or (Right(trim(iimg),1)="\") or (Right(trim(iimg),1)="/") then
		ImageExists = false
	else
		ImageExists = true
	end if
end function

Function getFirstAddimage()
	if ImageExists(oitem.Prd.FImageBasic) then
		getFirstAddimage= oitem.Prd.FImageBasic
	elseif ImageExists(oitem.Prd.FImageMask) then
		getFirstAddimage= oitem.Prd.FImageMask
	elseif (oAdd.FResultCount>0) then
		if ImageExists(oAdd.FADD(0).FAddimage) then
			getFirstAddimage= oAdd.FADD(0).FAddimage
		end if
	else
		getFirstAddimage= oitem.Prd.FImageMain
	end if
end Function

'=============================== 딜 추가 정보 ==========================================
Dim oDeal, ArrDealItem, intLoop
Set oDeal = New DealCls
oDeal.GetIDealInfo dealitemid
If oDeal.Prd.FDealCode="" Then
	Response.write "<script>alert('딜 상품 정보가 부족합니다.');history.back();</script>"
	Response.End
End If
ArrDealItem=oDeal.GetDealItemList(oDeal.Prd.FDealCode)
Set oDeal = Nothing
Dim FirstItem, LastItem, Tcnt
If isArray(ArrDealItem) Then
	Tcnt = UBound(ArrDealItem,2)
	For intLoop = 0 To UBound(ArrDealItem,2)
		If intLoop=0 Then
			FirstItem = ArrDealItem(0,intLoop)
		End If
		If intLoop=UBound(ArrDealItem,2) Then
			LastItem=ArrDealItem(0,intLoop)
		End If
	Next
	For intLoop = 0 To UBound(ArrDealItem,2)
		If itemid=ArrDealItem(0,intLoop) Then
			If intLoop=0 Then
				preitemid=LastItem
			Else
				preitemid=ArrDealItem(0,intLoop-1)
			End If
			If intLoop=UBound(ArrDealItem,2) Then
				nextitemid=FirstItem
			Else
				nextitemid=ArrDealItem(0,intLoop+1)
			End If
		End If
	Next
End If

%>
			<div class="slide">
				<p class="title">[상품<%=viewnum%>] <%= replace(replace(oItem.Prd.FItemName,"<br>"," "),"<br />"," ") %></p>
				<div class="contents">
					<div class="itemArea itemDeal">
						<% If oItem.Prd.isSoldout or oItem.Prd.isTempSoldOut Then %>
						<p class="soldout">일시 품절된 상품입니다.</p>
						<% End If %>
						<div class="pdtInfo">
							<span class="no">상품 <span><%=viewnum%></span></span>
							<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%= oItem.Prd.FMakerid %>&ab=012_a_1" target="_blank"><%= UCase(oItem.Prd.FBrandName) %></a></p>
							<p class="pdtName"><%= replace(replace(oItem.Prd.FItemName,"<br>"," "),"<br />"," ") %></p>
							<% if oitem.Prd.IsSaleItem Then %>
							<p class="pdtPrice cRd0V15">
							<% ElseIf  oitem.Prd.isCouponItem Then %>
							<p class="pdtPrice cGr0V15">
							<% Else %>
							<p class="pdtPrice">
							<% End If %>
							<%
								If oitem.Prd.isCouponItem Then
								Response.Write FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & "<span>원"
								Else
								Response.Write FormatNumber(oItem.Prd.FSellCash,0) & "<span>원"
								End If
								If oitem.Prd.IsSaleItem Then
									Response.Write " [" & CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) & "%]</span>"
								ElseIf oitem.Prd.isCouponItem Then
									Response.Write " [" & oItem.Prd.GetCouponDiscountStr & "]</span>"
								End If
							%>
							<% if oitem.Prd.isCouponItem Then %>
							<a href="javascript:DownloadCouponDeal()" class="btn btnS2 btnGrn fn btnW75"><span class="download">쿠폰다운</span></a>
							<% End If %>
							</p>
						</div>
						<ul>
							<% if oItem.Prd.FMileage then %>
							<%'// 2018 회원등급 개편%>
							<li><span>마일리지</span> <span><b><% = formatNumber(oItem.Prd.FMileage,0) %> Point <% If Not(IsUserLoginOK()) Then %>~<% End If %></b></span></li>
							<% End If %>
							<% if oItem.Prd.IsAboardBeasong then %>
							<li><span>배송구분</span> <span>텐텐<%=chkIIF(oItem.Prd.IsFreeBeasong,"무료","")%>배송</span></li>
							<% else %>
							<li><span>배송구분</span> <span><% = oItem.Prd.GetDeliveryName %></span></li>
							<% End If %>
							<li><span>원산지</span> <span><b><% = oItem.Prd.FSourceArea %></b></span></li>
							<% If G_IsPojangok Then %>
							<% If oItem.Prd.IsPojangitem Then %>
							<li><span>선물포장</span> <span><b class="ico cRd0V15 fn"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="" /> 포장가능</b></span></li>
							<% End If %>
							<% End If %>
						</ul>
					</div>
					<div class="imgArea">
						<!-- #include file="./inc_OrderNotice.asp" -->
					</div>
					<!-- 상세 이미지 영역 -->
					<div class="imgArea" id="imgArea">
						<!-- #include file="./inc_ItemDescription.asp" -->
					</div>
					<div class="infoArea">
					<!-- #include file="./inc_ItemInfomation.asp" -->
					</div>
				</div>
			</div>
<%
Dim prevnum, nextnum
If viewnum=1 Then
	prevnum=Tcnt+1
	nextnum=viewnum+1
ElseIf viewnum=Cstr(Tcnt+1) Then
	prevnum=viewnum-1
	nextnum=1
Else
	prevnum=viewnum-1
	nextnum=viewnum+1
End If
%>
			<button type="button" class="btnNav btnPrev" onClick="fnDealOtherItemView(<%=preitemid%>,<%=prevnum%>)">이전</button>
			<button type="button" class="btnNav btnNext" onClick="fnDealOtherItemView(<%=nextitemid%>,<%=nextnum%>)">다음</button>
<%
	Set oItem = Nothing
	Set oADD = Nothing
	Set itemVideos = Nothing
	Set addEx = Nothing
	Set Safety = Nothing
	
	'' 비회원 식별조회 2018/04/30
	Call fn_CheckNMakeGGsnCookie

	CALL fn_AddIISAppendToLOG_GGSN()
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->