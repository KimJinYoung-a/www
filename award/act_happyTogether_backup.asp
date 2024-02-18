<%@ codepage="949" language="VBScript" %>
<% option Explicit
	Response.CharSet="EUC-KR"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/JSON2.asp" -->
<!--<//script language="jscript" runat="server" src="/lib/util/JSON_PARSER_JS.asp"></script-->
<%

	dim oHTBCItem, chkHT, itemid, catecode, rcpUid, vPrdList, vMtdList, mtv, tmpArr
	dim lp, vIid, vMtd(), vLnk(), IValue
	ReDim vMtd(10), vLnk(10)

	chkHT = requestCheckVar(request("chk"),1)		'RecoPick A/B 테스트용 구분 (N:recoPick, O:텐바이텐 로직)
	itemid = requestCheckVar(request("itemid"),9)	'상품코드
	catecode = requestCheckVar(request("disp"),18)	'전시카테고리
	rcpUid = requestCheckVar(request("ruid"),32)	'recoPick 사용자번호
	vPrdList = requestCheckVar(request("prdlist"), 256) 'recopick에서 가져온 추천리스트 itemid값
	vMtdList = requestCheckVar(request("MtdList"), 32) 'recopick에서 가져온 method 값
	If Trim(vPrdList) <> "" Then
		vPrdList = CStr(vPrdList)
	End If

	If Trim(vMtdList) <> "" Then
		tmpArr = Split(vMtdList, ",")
		For mtv = 0 To UBound(tmpArr)
			vMtd(mtv) = tmpArr(mtv)
		Next
	End If

	'//클래스 선언
	set oHTBCItem = New CAutoCategory
	oHTBCItem.FRectItemId = itemid
	oHTBCItem.FRectDisp = catecode

	if chkHT="N" then
		If vPrdList<>"" Then
			oHTBCItem.FRectitemarr = vPrdList
			oHTBCItem.GetRecoPick_CateBestItemList
		Else
			oHTBCItem.GetCateRightHappyTogetherNCateBestItemList
		End If
	Else
		'// 텐바이텐 해피투게더 상품 목록
		oHTBCItem.GetCateRightHappyTogetherNCateBestItemList
	end If
	if oHTBCItem.FResultCount>0 then
%>

	<h3 class="tit"><img src="http://fiximage.10x10.co.kr/web2013/shopping/tit_popular_product.gif" alt="인기 급상승!" /><img src="http://fiximage.10x10.co.kr/web2013/shopping/txt_popular_product.gif" alt="현재 고객들이 구매를 가장 많이 하는 상품  TOP 10!" class="lPad15" /></h3>
	<div class="pdtWrap pdt200">
		<ul class="pdtList">
		<%	For lp = 0 To oHTBCItem.FResultCount - 1 %>
		<% if lp>9 then Exit For %>
			<li>
				<div class="pdtBox">
					<div class="pdtPhoto">
						<p><a href="" onclick="FnGoProdItem('<%=oHTBCItem.FItemList(lp).FItemId %>','<%=itemid%>','<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R",vMtd(lp),"10")%>','<%=oHTBCItem.FItemList(lp).FUseETC%>','<%=rcpUid%>','<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R",vLnk(lp),"")%>','<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R","recopick","10x10")%>'); return false;"><img src="<%=oHTBCItem.FItemList(lp).Ficon1image %>" width="200px" height="200px" alt="<%=oHTBCItem.FItemList(lp).FItemName%>" /></a></p>
						<div class="pdtAction">
							<ul>
								<li class="largeView"><p onclick="ZoomItemInfo('<%=oHTBCItem.FItemList(lp).FItemid %>');"><span>크게보기</span></p></li>
								<li class="postView"><p <%=chkIIF(oHTBCItem.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oHTBCItem.FItemList(lp).FItemid & "'); return false;""","")%>><span><%=formatNumber(oHTBCItem.FItemList(lp).FEvalCnt,0)%></span></p></li>
								<li class="wishView"><p onclick="TnAddFavorite('<%=oHTBCItem.FItemList(lp).FItemid %>'); return false;"><span><%=formatNumber(oHTBCItem.FItemList(lp).FfavCount,0)%></span></p></li>
							</ul>
						</div>
					</div>
					<div class="pdtInfo">
						<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oHTBCItem.FItemList(lp).FMakerID%>"><%=oHTBCItem.FItemList(lp).FBrandName%></a></p>
						<p class="pdtName tPad07"><a href="" onclick="FnGoProdItem('<%=oHTBCItem.FItemList(lp).FItemId %>','<%=itemid%>','<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R",vMtd(lp),"10")%>','<%=oHTBCItem.FItemList(lp).FUseETC%>','<%=rcpUid%>','<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R",vLnk(lp),"")%>','<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R","recopick","10x10")%>'); return false;"><%=oHTBCItem.FItemList(lp).FItemName%></a></p>
						<% 
							If oHTBCItem.FItemList(lp).IsSaleItem or oHTBCItem.FItemList(lp).isCouponItem Then
								IF oHTBCItem.FItemList(lp).IsSaleItem then	'상품할인가
						%>	
								<p class="pdtPrice tPad10"><span class="txtML"><% = FormatNumber(oHTBCItem.FItemList(lp).getOrgPrice,0) %>원</span></p>
								<p class="pdtPrice"><span class="finalP"><% = FormatNumber(oHTBCItem.FItemList(lp).getRealPrice,0) %>원</span> <strong class="crRed">[<% = oHTBCItem.FItemList(lp).getSalePro %>]</strong></p>
						<% 		End IF %>
						<% 
								IF oHTBCItem.FItemList(lp).IsCouponItem then	'쿠폰할인가
									if Not(oHTBCItem.FItemList(lp).IsFreeBeasongCoupon() or oHTBCItem.FItemList(lp).IsSaleItem) then
						%>
									<p class="pdtPrice tPad10"><span class="txtML"><% = FormatNumber(oHTBCItem.FItemList(lp).getRealPrice,0) %>원</span></p>
						<%		 	end if %>
									<p class="pdtPrice"><span class="finalP"><% = FormatNumber(oHTBCItem.FItemList(lp).GetCouponAssignPrice,0) %>원</span> <strong class="crGrn">[<% = oHTBCItem.FItemList(lp).GetCouponDiscountStr %>]</strong></p>
						<%
								End IF
							Else
						%>
							<p class="pdtPrice"><span class="finalP"><% = FormatNumber(oHTBCItem.FItemList(lp).getRealPrice,0) & chkIIF(oHTBCItem.FItemList(lp).IsMileShopitem," Point", "원")%></span></p>
						<%	End If %>
						
						<p class="pdtStTag tPad10">
							<% IF oHTBCItem.FItemList(lp).isSoldOut Then %>
								<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
							<% else %>
								<% IF oHTBCItem.FItemList(lp).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
								<% IF oHTBCItem.FItemList(lp).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
								<% IF oHTBCItem.FItemList(lp).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
								<% IF oHTBCItem.FItemList(lp).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
								<% IF oHTBCItem.FItemList(lp).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
								<% IF oHTBCItem.FItemList(lp).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
							<% end if %>
						</p>
					</div>
				</div>
			</li>
		<%	next %>
		</ul>
	</div>

<%
	else
%>
		<script>$("#tab06").hide();</script>
<%
	end if
	set oHTBCItem = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->