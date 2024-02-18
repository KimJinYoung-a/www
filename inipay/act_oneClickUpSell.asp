<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/JSON2.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<%
'#######################################################
'	History	:  2017.09.14 원승현
'	Description : 원클릭 업셀 상품 출력
'#######################################################
%>
<script language="jscript" runat="server" src="/lib/util/JSON_PARSER_JS.asp"></script>
<%

	Const sitename = "10x10"

	dim userid, guestSessionID, i, j, isBaguniUserLoginOK, sqlStr, limitDefaultDeliveryCost, oOneClickItem, lp, btp
	If IsUserLoginOK() Then
		userid = getEncLoginUserID ''GetLoginUserID
		isBaguniUserLoginOK = true
	Else
		userid = GetLoginUserID
		isBaguniUserLoginOK = false
	End If
	guestSessionID = GetGuestSessionKey


	dim oUserInfo, chkKakao
	set oUserInfo = new CUserInfo
	oUserInfo.FRectUserID = userid
	if (userid<>"") then
		oUserInfo.GetUserData
	end if

	if (oUserInfo.FresultCount<1) then
		''Default Setting
		set oUserInfo.FOneItem    = new CUserInfoItem
	end if

	dim oshoppingbag
	set oshoppingbag = new CShoppingBag
	oshoppingbag.FRectUserID = userid
	oshoppingbag.FRectSessionID = guestSessionID
	oShoppingBag.FRectSiteName  = sitename


	oshoppingbag.GetShoppingBagDataDB_Checked

	''위치변경
	if oshoppingbag.IsShoppingBagVoid then
		response.write ""
		response.end
	end If
	
	''업체 개별 배송비 상품이 있는경우
	if (oshoppingbag.IsUpcheParticleBeasongInclude)  then
		oshoppingbag.GetParticleBeasongInfoDB_Checked
	end if

	dim goodname
	goodname = oshoppingbag.getGoodsName
	goodname = replace(goodname,"'","")

	Dim tmpMakerId, sameChkMakerId, tenbaeChk, viewChk, tenbaeChkCnt, shoArr, dispItemId, dispCode

	sameChkMakerId = False
	tenbaeChk = False
	viewChk = False
	tenbaeChkCnt = 0
	shoArr = ""


'	텐바이텐 배송 - 1 텐바이텐 배송만 따로 아니면 업배처리 부분 그대로 가지고감.
	for i=0 to oshoppingbag.FShoppingBagItemCount - 1
		'// shoArr을 만든다.
		shoArr = shoArr&oshoppingbag.FItemList(i).FitemId&","&oshoppingbag.FItemList(i).Fitemoption&","&oshoppingbag.FItemList(i).Fitemea&"|"

		If Trim(oshoppingbag.FItemList(i).Fdeliverytype) <> "1" Then
			tenbaeChkCnt = tenbaeChkCnt+1
		End If

		dispItemId = oshoppingbag.FItemList(i).FitemId
	Next

	shoArr = left(shoArr, Len(shoArr)-1)

	If tenbaeChkCnt > 0 Then
		tenbaeChk = False
	Else
		tenbaeChk = True
	End If

	If Not(tenbaeChk) Then
		for i=0 to oshoppingbag.FShoppingBagItemCount - 1
			If i=0 Then
				tmpMakerId = oshoppingbag.FItemList(i).FMakerId
				sameChkMakerId = True
			Else
				If Trim(oshoppingbag.FItemList(i).FMakerId) = Trim(tmpMakerId) Then
					sameChkMakerId = True
				Else
					sameChkMakerId = False
				End If
			End If
		Next
	End If
	
	


	'// 텐바이텐 배송과 업체배송은 혼용될 수 없다.
	If tenbaeChk And sameChkMakerId Then
		viewChk = False
	End If

	If Not(tenbaechk) And sameChkMakerId Then
		viewChk = True
	End If

	If tenbaechk And Not(sameChkMakerId) Then
		viewChk = True
	End If

	If viewChk And oshoppingbag.GetOrgBeasongPrice > 0  Then

		If sameChkMakerId Then
			sqlStr = "select defaultFreeBeasongLimit "
			sqlStr = sqlStr + " from [db_user].[dbo].tbl_user_c"
			sqlStr = sqlStr + " where isusing='Y' And userid='" & Trim(tmpMakerId) &"' "
			rsget.Open sqlStr,dbget,1
			If Not(rsget.bof Or rsget.eof) Then
				limitDefaultDeliveryCost = rsget(0)
			End If
			rsget.close
		End If


		If tenbaeChk Then
			limitDefaultDeliveryCost = oshoppingbag.getFreeBeasongLimit
			sqlStr = " Select top 1 * From db_item.dbo.tbl_item Where itemid='"&dispItemId&"' "
			rsget.Open sqlStr,dbget,1
			If Not(rsget.bof Or rsget.eof) Then
				dispCode = rsget("dispcate1")
			End If
			rsget.close
			If Trim(dispcode)="" Then
				dispcode = "101"
			End If
		End If


		set oOneClickItem = New CAutoCategory
		oOneClickItem.FRectDelLimitCost = limitDefaultDeliveryCost - (oshoppingbag.GetTotalItemOrgPrice-oshoppingbag.GetMileageShopItemPrice)
		If tenbaeChk Then
			oOneClickItem.FRectTenBaeChk = tenbaeChk
			oOneClickItem.FRectDisp = dispCode
		Else
			oOneClickItem.FRectMakerID = tmpMakerId
		End If

		If Trim(userid)="" Then
			oOneClickItem.FRectUserId = GetGuestSessionKey
		Else
			oOneClickItem.FRectUserId = userid
		End If
		oOneClickItem.GetOneClickUpSellItemList

		if oOneClickItem.FResultCount>0 then


%>
<% If oOneClickItem.FResultCount >= 5 Then %>
<style>
.pdtRecommend {margin-left:-20px; margin-right:-20px;}
.pdtRecommend .pdtWrap {background:none; margin-top:21px;}
.pdtRecommend .pdtWrap .pdtList {margin-bottom:0;}
.pdtRecommend .pdt120 .pdtList {display:table; width:100%; background:none;}
.pdtRecommend .pdt120 .pdtList > li {display:table-cell; float:none; width:auto; background:none; border-left:1px solid #ddd;}
.pdtRecommend .pdt120 .pdtList > li:first-child {border-left:0;}
.pdtRecommend .pdt120 .pdtInfo {min-height:94px;}
.pdtRecommend .pdt120 .pdtInfo .pdtBrand {font-family:tahoma, dotum, '돋움', sans-serif;}
.pdtRecommend .pdt120 .pdtInfo .pdtName {min-height:auto; padding-top:7px; padding-bottom:6px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;}
.pdtRecommend .pdt120 .btnM2 {padding-top:8px; padding-bottom:8px;}
</style>
<script>
function addOnclickUpsell(itemid, realprice)
{
	var frm = document.sbagfrm;

	//alert(sAddBagArr);
	frm.mode.value = "UPS";
    frm.itemid.value = itemid;
    frm.itemoption.value = "0000";
    frm.itemea.value = 1;
	frm.action="/inipay/shoppingbag_process.asp";
	frm.submit();
}
</script>
<form name="sbagfrm" method="post" action="" style="margin:0px;">
<input type="hidden" name="sitename" value="<%= session("rd_sitename") %>">
<input type="hidden" name="itemid">
<input type="hidden" name="itemoption">
<input type="hidden" name="itemea">
<input type="hidden" name="mode">
<% If Trim(userid)="" Then %>
	<input type="hidden" name="userid" value="<%= userid %>">
<% Else %>
	<input type="hidden" name="userid" value="<%= guestSessionID %>">
<% End If %>
<input type="hidden" name="itemPrice" value="">
<div class="pdtRecommend tMar40">
	<div class="overHidden tPad05">
		<span class="fs14 tPad05 lPad30 cr000"><img src="http://fiximage.10x10.co.kr/web2017/common/blt_arrow_check_red.png" alt="" class="rMar05" />아래 상품 중 1개를 같이 구매하면 <strong class="crRed">배송비가 무료!</strong></span>
	</div>
	<div class="pdtWrap pdt120">
		<ul class="pdtList">
			<%	For lp = 0 To oOneClickItem.FResultCount - 1 %>
			<% if lp>5 then Exit For %>
			<% If Not(oOneClickItem.FItemList(lp).isSoldOut) Then %>
				<li>
					<div class="pdtBox">
						<div class="pdtPhoto">
							<p><a href="/shopping/category_prd.asp?itemid=<%= oOneClickItem.FItemList(lp).Fitemid %>&rc=item_oneupsell_<%=lp+1%>" target="_blank"><img src="<%=oOneClickItem.FItemList(lp).FIcon1Image %>" width="120px" height="120px" alt="<%=oOneClickItem.FItemList(lp).FItemName%>" /></a></p>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oOneClickItem.FItemList(lp).FMakerID%>&rc=item_oneupsell_<%=lp+1%>" target="_blank"><%=oOneClickItem.FItemList(lp).FBrandName%></a></p>
							<p class="pdtName"><a href="/shopping/category_prd.asp?itemid=<%= oOneClickItem.FItemList(lp).Fitemid %>&rc=item_oneupsell_<%=lp+1%>" target="_blank"><%=chrbyte(oOneClickItem.FItemList(lp).FItemName, 20, "Y")%></a></p>
							<p class="pdtPrice"><span class="finalP"><% = FormatNumber(oOneClickItem.FItemList(lp).getRealPrice,0) %>원</span> 
								<% IF oOneClickItem.FItemList(lp).IsSaleItem Then %>
									<strong class="cRd0V15">[<% = oOneClickItem.FItemList(lp).getSalePro %>]</strong>
								<% End If %>
							</p>
						</div>
						<p class="cartBtn">
							<a href="" onclick="addOnclickUpsell('<%=oOneClickItem.FItemList(lp).FItemid%>','<%=oOneClickItem.FItemList(lp).getRealPrice%>');return false;" class="btn btnM2 btnWhite btnW120 fs11">주문추가</a>
						</p>
					</div>
				</li>
			<% End If %>
			<%	next %>
		</ul>
	</div>
</div>
</form>
<%
	Set oOneClickItem = Nothing
	Set oshoppingbag = Nothing
	Set oUserInfo = Nothing
	
    '' 비회원 식별조회 2017/08/11
    Call fn_CheckNMakeGGsnCookie

    CALL fn_AddIISAppendToLOG_GGSN()

    CALL fn_AddIISAppendToLOG("&upsellview=1")
%>
<% End If %>
<% End If %>
<% End If %>
<%
'' 비회원 식별조회 2017/08/11
    Call fn_CheckNMakeGGsnCookie

    CALL fn_AddIISAppendToLOG_GGSN()
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->