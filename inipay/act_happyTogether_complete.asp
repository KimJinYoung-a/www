<%@ codepage="65001" language="VBScript" %>
<% option Explicit
	response.Charset="UTF-8"
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
	ReDim vMtd(5), vLnk(5)

	chkHT = requestCheckVar(request("chk"),1)		'RecoPick A/B 테스트용 구분 (N:recoPick, O:텐바이텐 로직)
	itemid = requestCheckVar(request("itemid"),9)	'상품코드
	catecode = requestCheckVar(request("disp"),18)	'전시카테고리
	rcpUid = requestCheckVar(request("ruid"),32)	'recoPick 사용자번호
	vPrdList = requestCheckVar(request("prdlist"), 128) 'recopick에서 가져온 추천리스트 itemid값
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
	end if
	if oHTBCItem.FResultCount>0 then
%>
<div class="cartBox tMar40">
	<div class="happyTogether" id="detail06">
		<div class="tit">
			<h3>Enjoy<br />Together</h3>
			<p>함께 구매하면 즐거움이 2배!</p>
		</div>
		<div class="pdtWrap pdt120 pad0">
			<ul class="pdtList">
			<%	For lp = 0 To oHTBCItem.FResultCount - 1 %>
			<% if lp>4 then Exit For %>
				<li>
					<div class="pdtBox">
						<div class="pdtPhoto">
							<p><a href="#" onclick="FnGoProdItem(<%=oHTBCItem.FItemList(lp).FItemId %>,<%=itemid%>,'<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R",vMtd(lp),"30")%>','<%=oHTBCItem.FItemList(lp).FUseETC%>','<%=rcpUid%>','<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R",vLnk(lp),"")%>','<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R","recopick_c","10x10_c")%>'); return false;"><img src="<%=oHTBCItem.FItemList(lp).FImageList120 %>" width="120px" height="120px" alt="<%=oHTBCItem.FItemList(lp).FItemName%>" /></a></p>
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
							<p class="pdtName tPad07"><a href="#" onclick="FnGoProdItem(<%=oHTBCItem.FItemList(lp).FItemId %>,<%=itemid%>,'<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R",vMtd(lp),"30")%>','<%=oHTBCItem.FItemList(lp).FUseETC%>','<%=rcpUid%>','<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R",vLnk(lp),"")%>','<%=chkIIF(oHTBCItem.FItemList(lp).FUseETC="R","recopick_c","10x10_c")%>'); return false;"><%=oHTBCItem.FItemList(lp).FItemName%></a></p>
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
	</div>
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