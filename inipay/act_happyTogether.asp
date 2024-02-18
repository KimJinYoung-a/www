<%@ codepage="65001" language="VBScript" %>
<% option Explicit
	response.Charset="UTF-8"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/login/checkBaguniLogin.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/JSON2.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<script language="jscript" runat="server" src="/lib/util/JSON_PARSER_JS.asp"></script>
<%
	dim oHTBCItem, chkHT, itemid, catecode, rcpUid, vPrdList, vMtdList, mtv, tmpArr, top3Itemid, NotInItemid, tmpItemid
	dim lp, vIid, vMtd(), vLnk(), IValue, ti, userid, isBaguniUserLoginOk, guestSessionID, userKey, strSql
	ReDim vMtd(5), vLnk(5)


	If IsUserLoginOK() Then
		userid = getEncLoginUserID ''GetLoginUserID '' ''
		isBaguniUserLoginOK = true
	Else
		userid = GetLoginUserID
		isBaguniUserLoginOK = false
	End If
	guestSessionID = GetGuestSessionKey


    if (userid<>"") then
	    userKey = userid
	elseif (guestSessionID<>"") then
	    userKey = guestSessionID
	end If
	

	'// 해당 유저의 가장 최근에 장바구니에 담은 상품코드를 가져온다.
	strSql = " Select top 10 itemid From db_my10x10.dbo.tbl_my_baguni Where userKey='"&userKey&"' order by lastupdate, regdate desc "
	rsget.Open strSql, dbget, 1
	If Not(rsget.bof Or rsget.eof) Then
		Do Until rsget.eof
			itemid = itemid&","&rsget("itemid")
		rsget.movenext
		Loop
	Else
		
		Response.write ""
		dbget.close()
		Response.End
	End If
	rsget.close

	'// 현재 유저의 장바구니에 담긴 상품 리스트를 가져온다.
	If left(itemid, 1)="," Then
		itemid = Right(itemid, Len(itemid)-1)
	Else
		Response.write ""
		dbget.close()
		Response.End
	End If

	'//클래스 선언
	set oHTBCItem = New CAutoCategory
	oHTBCItem.FRectItemId = itemid


	'// 텐바이텐 해피투게더 상품 목록
	oHTBCItem.GetCateRightHappyTogetherNCateBestItemShoppingBagList


	if oHTBCItem.FResultCount>0 then
%>


	<ul class="pdtList">
	<%	For lp = 0 To oHTBCItem.FResultCount - 1 %>
	<% if lp>4 then Exit For %>
		<li>
			<div class="pdtBox">
				<div class="pdtPhoto">
					<p>
						<a href="/shopping/category_prd.asp?itemid=<%= oHTBCItem.FItemList(lp).Fitemid %>&ab=001_b_5"><img src="<%=oHTBCItem.FItemList(lp).FIcon1Image %>" width="120px" height="120px" alt="<%=oHTBCItem.FItemList(lp).FItemName%>" /></a></p>
					<div class="pdtAction">
						<ul>
							<li class="largeView"><p onclick="ZoomItemInfo('<%=oHTBCItem.FItemList(lp).FItemid %>');"><span>크게보기</span></p></li>
							<li class="postView"><p <%=chkIIF(oHTBCItem.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oHTBCItem.FItemList(lp).FItemid & "');""","")%>><span><%=oHTBCItem.FItemList(lp).FEvalCnt%></span></p></li>
							<li class="wishView"><p onclick="TnAddFavorite('<%=oHTBCItem.FItemList(lp).FItemid %>');"><span><%=oHTBCItem.FItemList(lp).FfavCount%></span></p></li>
						</ul>
					</div>
				</div>
				<div class="pdtInfo">
					<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oHTBCItem.FItemList(lp).FMakerID%>"><%=oHTBCItem.FItemList(lp).FBrandName%></a></p>
					<p class="pdtName tPad07">
						<a href="/shopping/category_prd.asp?itemid=<%= oHTBCItem.FItemList(lp).Fitemid %>&ab=001_b_5"><%=oHTBCItem.FItemList(lp).FItemName%></a>
					</p>
					<% 
						If oHTBCItem.FItemList(lp).IsSaleItem or oHTBCItem.FItemList(lp).isCouponItem Then
							IF oHTBCItem.FItemList(lp).IsSaleItem then	'상품할인가
					%>	
							<p class="pdtPrice"><span class="txtML"><% = FormatNumber(oHTBCItem.FItemList(lp).getOrgPrice,0) %>원</span></p>
							<p class="pdtPrice"><span class="finalP"><% = FormatNumber(oHTBCItem.FItemList(lp).getRealPrice,0) %>원</span> <strong class="crRed">[<% = oHTBCItem.FItemList(lp).getSalePro %>]</strong></p>
					<% 		End IF %>
					<% 
							IF oHTBCItem.FItemList(lp).IsCouponItem then	'쿠폰할인가
								if Not(oHTBCItem.FItemList(lp).IsFreeBeasongCoupon() or oHTBCItem.FItemList(lp).IsSaleItem) then
					%>
								<p class="pdtPrice"><span class="txtML"><% = FormatNumber(oHTBCItem.FItemList(lp).getRealPrice,0) %>원</span></p>
					<%		 	end if %>
								<p class="pdtPrice"><span class="finalP"><% = FormatNumber(oHTBCItem.FItemList(lp).GetCouponAssignPrice,0) %>원</span> <strong class="crGrn">[<% = oHTBCItem.FItemList(lp).GetCouponDiscountStr %>]</strong></p>
					<%
							End IF
						Else
					%>
						<p class="pdtPrice"><span class="finalP"><% = FormatNumber(oHTBCItem.FItemList(lp).getRealPrice,0) & chkIIF(oHTBCItem.FItemList(lp).IsMileShopitem," Point", "원")%></span></p>
					<%	End If %>
					
					<!--p class="tPad05">
						<%
						'optionBoxHtml = ""
						''품절시 제외.
						'If (oHTBCItem.FItemList(lp).IsItemOptionExists) and (Not oHTBCItem.FItemList(lp).IsSoldOut) then
							'if (oHTBCItem.FItemList(lp).Fdeliverytype="6") then
								'optionBoxHtml = getOneTypeOptionBoxHtmlMile(oHTBCItem.FItemList(lp).FItemID,oHTBCItem.FItemList(lp).IsSoldOut,"class=""optSelect2"" style=""width:100%;""",false)
							'Else
								'optionBoxHtml = getOneTypeOptionBoxHtmlMile(oHTBCItem.FItemList(lp).FItemID,oHTBCItem.FItemList(lp).IsSoldOut,"class=""optSelect2"" style=""width:100%;""",true)
							'end if
						'End If

						'response.write optionBoxHtml
						%>
					</p-->
				</div>
				<!--p class="cartBtn">
					<% 'if oHTBCItem.FItemList(lp).IsSoldOut then %>
						<a href="" class="btn btnM2 btnWhite btnW150" onClick="return false;">품 절</a>
					<% 'else %>
						<a href="javascript:AddTogetherItem2('<%= oHTBCItem.FItemList(lp).FItemID %>');" class="btn btnM2 btnWhite btnW150" >장바구니</a>
					<% 'end if %>
				</p-->
			</div>
		</li>
	<%	next %>
	</ul>
<%
	else
%>
		<script>$(".happyTogether").hide();</script>
<%
	end if
	set oHTBCItem = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->