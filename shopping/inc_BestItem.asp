<%
	dim iid: iid=""
	dim chkSale: chkSale="N"

	'// BEST 상품 출력 (1개상품)
	public Sub PrintBestOneItem(srtMth, dispCate, ByRef iid, ByRef chkSale)
		dim oBDoc, oChk, strRst, lp, sMth
		
		'//세일/쿠폰 상품 존재여부 확인
		if chkSale="N" then
			set oChk = new SearchItemCls
			oChk.FRectCateCode	= dispCate
			oChk.FRectSearchCateDep = "T"
			oChk.FRectSearchItemDiv = "n"
			oChk.FCurrPage = 1
			oChk.FPageSize = 3
			oChk.FScrollCount = 0
			oChk.FListDiv = "list"
			oChk.FSellScope="Y"
			oChk.FRectSearchFlag = "sc"
			If vDepth = "2" Then
				oChk.FminPrice	= "6000"
			End If
			oChk.FAddLogRemove = true
			oChk.getSearchList	
			if oChk.FResultCount>0 then
				chkSale = true
			else
				'존재하지 않으면 BEST셀러만 프린트
				chkSale = false
			end if
			set oChk = Nothing
		end if
		if chkSale then sMth = srtMth: else: sMth = "be" :end If
		
		'//상품 접수
		set oBDoc = new SearchItemCls
		oBDoc.FRectSortMethod	= sMth
		oBDoc.FRectCateCode	= dispCate
		oBDoc.FRectSearchCateDep = "T"
		oBDoc.FRectSearchItemDiv = "n"
		oBDoc.FCurrPage = 1
		oBDoc.FPageSize = 3
		oBDoc.FScrollCount = 0
		oBDoc.FListDiv = "list"
		oBDoc.FSellScope="Y"
		if sMth="hs" then
			oBDoc.FRectSearchFlag = "sc"
		end if
		If vDepth = "2" Then
			oBDoc.FminPrice	= "6000"
		End If
		oBDoc.FAddLogRemove = true
		oBDoc.getSearchList

		if oBDoc.FResultCount>0 then
			lp=0
			if iid="" then
				iid=oBDoc.FItemList(lp).FItemid
			else
				'중복 진열 회피
				for lp=0 To oBDoc.FResultCount -1
					if inStr(iid,oBDoc.FItemList(lp).FItemid)=0 then
						iid=iid & "," & oBDoc.FItemList(lp).FItemid
						Exit For
					end if
				next
			end if
			
			dim tmpScript
			For lp = 0 To 2
				'만약 중복된것들을 제외했는데 상품이 없다면 제낌
				if lp>oBDoc.FResultCount -1 then Exit Sub
					classStr = ""
					linkUrl = "/shopping/category_prd.asp?itemid="& oBDoc.FItemList(lp).FItemID &"&disp="&getArrayDispCate(dispCate,oBDoc.FItemList(lp).FarrCateCd) & logparam
					adultChkFlag = false
					adultChkFlag = session("isAdult") <> true and oBDoc.FItemList(lp).FadultType = 1						

					if adultChkFlag then
						classStr = addClassStr(classStr,"adult-item")								
					end if
					tmpScript = chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")				
					'crID 	= crID & "'"&oBDoc.FItemList(lp).FItemid &"'"&chkiif(lp < oBDoc.FResultCount -1, ",", "")&""
				strRst = strRst & "<li class="""& classStr &""""& tmpScript &" >" & vbCrLf
				strRst = strRst & "	<p class=""ranking""><img src=""http://fiximage.10x10.co.kr/web2015/shopping/ico_best"& lp+1 &".png"" alt=""BEST "& lp+1 &""" /></p>" & vbCrLf
				strRst = strRst & "	<div class=""pdtBox"">" & vbCrLf
					if oBDoc.FItemList(lp).Fiskimtentenrecom="Y" or oBDoc.FItemList(lp).IsSaleItem or oBDoc.FItemList(lp).isCouponItem then
						if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then
							If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then
								strRst = strRst & "		<span class=""badge_anniv21""><img src=""//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2"" alt=""21주년""></span>" & vbCrLf
							end if
						else
							If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then
								strRst = strRst & "		<span class=""badge_anniv21""><img src=""//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2"" alt=""21주년""></span>" & vbCrLf
							end if
						end if
					end if
					if oBDoc.FItemList(lp).FGiftDiv>0 then
						If now() >= #2022-09-01 00:00:00# and now() < #2023-02-01 00:00:00# Then
							if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then
								If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then
								else
									strRst = strRst & "		<i class=""diary2023Badge""></i>" & vbCrLf
								end if
							else
								If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then
								else
									strRst = strRst & "		<i class=""diary2023Badge""></i>" & vbCrLf
								end if
							end if
						end if
					end if
				strRst = strRst & "		<div class=""pdtPhoto"">" & vbCrLf
				if adultChkFlag then
				strRst = strRst & " <div class=""adult-hide""> "& vbCrLf
				strRst = strRst & "	<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p> "& vbCrLf
				strRst = strRst & " </div> "& vbCrLf
				end if
				strRst = strRst & "			<a href=""/shopping/category_prd.asp?itemid=" & oBDoc.FItemList(lp).FItemid & "&disp=" & getArrayDispCate(dispCate,oBDoc.FItemList(lp).FarrCateCd) & logparam & """ onclick=""window.event.cancelBubble=true; fnAmplitudeEventMultiPropertiesAction('click_category_list_best3item','indexnumber|itemid|categoryname|brand_id','"& lp+1 &"|"& oBDoc.FItemList(lp).FItemid &"|"& fnItemIdToCategory1DepthName(oBDoc.FItemList(lp).FItemid)& "|" & fnItemIdToBrandName(oBDoc.FItemList(lp).FItemid) &"');"" >" & vbCrLf
				strRst = strRst & "				<span class=""soldOutMask""></span>" & vbCrLf
				strRst = strRst & "				<img src=""" & getThumbImgFromURL(oBDoc.FItemList(lp).FImageBasic,240,240,"true","false") & """ alt=""" & Replace(oBDoc.FItemList(lp).FItemName,"""","") & """ />" & vbCrLf
				if oBDoc.FItemList(lp).FAddimage<>"" then
					strRst = strRst & "				<dfn><img src=""" & getThumbImgFromURL(oBDoc.FItemList(lp).FAddimage,240,240,"true","false") & """ alt=""" & Replace(oBDoc.FItemList(lp).FItemName,"""","") & """ /></dfn>" & vbCrLf
				end if
				strRst = strRst & "			</a>" & vbCrLf
				'### 위시 기능은 아래 상품리스트의 동일 상품 id 중복으로 인하여 안됨. 모두삭제.
				strRst = strRst & "		</div>" & vbCrLf
				strRst = strRst & "		<div class=""pdtInfo"">" & vbCrLf
				strRst = strRst & "			<p class=""pdtBrand tPad20""><a href=""/street/street_brand.asp?makerid=" & oBDoc.FItemList(lp).FMakerid & """ onclick=fnAmplitudeEventMultiPropertiesAction('click_category_list_best3item_brand','indexnumber|itemid|categoryname|brand_id','"& lp+1 &"|"& oBDoc.FItemList(lp).FItemid &"|"& fnItemIdToCategory1DepthName(oBDoc.FItemList(lp).FItemid)& "|" & fnItemIdToBrandName(oBDoc.FItemList(lp).FItemid) &"');>" & oBDoc.FItemList(lp).FBrandName & "</a></p>" & vbCrLf
				strRst = strRst & "			<p class=""pdtName tPad07""><a href=""/shopping/category_prd.asp?itemid=" & oBDoc.FItemList(lp).FItemid & "&disp=" & getArrayDispCate(dispCate,oBDoc.FItemList(lp).FarrCateCd) & logparam & """ onclick=""window.event.cancelBubble=true; fnAmplitudeEventMultiPropertiesAction('click_category_list_best3item','indexnumber|itemid|categoryname|brand_id','"& lp+1 &"|"& oBDoc.FItemList(lp).FItemid &"|"& fnItemIdToCategory1DepthName(oBDoc.FItemList(lp).FItemid)& "|" & fnItemIdToBrandName(oBDoc.FItemList(lp).FItemid) &"');"" >" & oBDoc.FItemList(lp).FItemName & "</a></p>" & vbCrLf
				strRst = strRst & "			<p class=""pdtPrice"">"

				If oBDoc.FItemList(lp).IsSaleItem or oBDoc.FItemList(lp).isCouponItem Then
					If (oBDoc.FItemList(lp).IsSaleItem AND oBDoc.FItemList(lp).isCouponItem) OR (oBDoc.FItemList(lp).IsSaleItem AND Not oBDoc.FItemList(lp).isCouponItem) Then
						strRst = strRst & "<span class=""finalP"">" & FormatNumber(oBDoc.FItemList(lp).getRealPrice,0) & "원</span> <strong class=""cRd0V15"">["&oBDoc.FItemList(lp).getSalePro&"]</strong>"
					End If
					If Not oBDoc.FItemList(lp).IsSaleItem AND oBDoc.FItemList(lp).isCouponItem Then
						strRst = strRst & "<span class=""finalP"">" & FormatNumber(oBDoc.FItemList(lp).GetCouponAssignPrice,0) & "원</span> <strong class=""cGr0V15"">["&oBDoc.FItemList(lp).GetCouponDiscountStr&"]</strong>"
					End If
				Else
					strRst = strRst & "<span class=""finalP"">" & FormatNumber(oBDoc.FItemList(lp).getRealPrice,0) & ""
					If oBDoc.FItemList(lp).IsMileShopitem Then
					strRst = strRst &"Point"
					Else
					strRst = strRst & "원"
					End If
					strRst = strRst & "</span>"
				End If
				
				strRst = strRst & "			</p>" & vbCrLf
				strRst = strRst & "			<p class=""pdtStTag tPad10"">" & vbCrLf
				
				IF oBDoc.FItemList(lp).isSoldOut Then
					strRst = strRst & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif"" alt=""SOLDOUT"" />" & vbCrLf
				else
					IF oBDoc.FItemList(lp).isTempSoldOut Then
						strRst = strRst & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif"" alt=""SOLDOUT"" />" & vbCrLf
					end if
					IF oBDoc.FItemList(lp).isSaleItem Then
						strRst = strRst & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif"" alt=""SALE"" />" & vbCrLf
					end if
					IF oBDoc.FItemList(lp).isCouponItem Then
						strRst = strRst & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif"" alt=""쿠폰"" />" & vbCrLf
					end if
					IF oBDoc.FItemList(lp).IsGiftItem Then
						strRst = strRst & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_gift.gif"" alt=""GIFT"" />" & vbCrLf
					end if
					IF oBDoc.FItemList(lp).isLimitItem Then
						strRst = strRst & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif"" alt=""한정"" />" & vbCrLf
					end if
					IF oBDoc.FItemList(lp).IsTenOnlyitem Then
						strRst = strRst & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif"" alt=""ONLY"" />" & vbCrLf
					end if
					IF oBDoc.FItemList(lp).isNewItem Then
						strRst = strRst & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif"" alt=""NEW"" />" & vbCrLf
					end if
					If G_IsPojangok Then
					IF oBDoc.FItemList(lp).IsPojangitem Then
						strRst = strRst & "<span class=""icoWrappingV15a""><img src=""http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png"" alt=""선물포장가능""><em><img src=""http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png"" alt=""선물포장가능""></em></span>" & vbCrLf
					end if
					end if
				end if

				strRst = strRst & "			</p>" & vbCrLf
				strRst = strRst & "		</div>" & vbCrLf
				strRst = strRst & "   <ul class=""pdtActionV15"">"
				strRst = strRst & "		<li class=""largeView""><a href='' onclick=""fnAmplitudeEventMultiPropertiesAction('click_category_list_best3item_info','type','quick'); ZoomItemInfo('"& oBDoc.FItemList(lp).FItemid &"'); return false;""><img src=""http://fiximage.10x10.co.kr/web2015/common/btn_quick.png"" alt=""QUICK"" /></a></li>"
				strRst = strRst & "		<li class=""postView""><a href='' onclick="""& chkIIF(oBDoc.FItemList(lp).FEvalCnt>0,"popEvaluate('" & oBDoc.FItemList(lp).FItemid & "');","")&"fnAmplitudeEventMultiPropertiesAction('click_category_list_best3item_info','type','review'); return false;""><span>"& oBDoc.FItemList(lp).FEvalCnt &"</span></a></li>"
				strRst = strRst & "		<li class=""wishView""><a href='' onclick=""TnAddFavorite('"& oBDoc.FItemList(lp).FItemid &"'); fnAmplitudeEventMultiPropertiesAction('click_category_list_best3item_info','type','wish'); return false;""><span>"& oBDoc.FItemList(lp).FfavCount &"</span></a></li>"
				strRst = strRst & "	  </ul>"
				strRst = strRst & "	</div>" & vbCrLf
				strRst = strRst & "</li>" & vbCrLf
			next
		end if

		Response.Write strRst

		set oBDoc = Nothing
	End Sub
%>
<div class="ctgyBestV15">
	<div class="pdt240V15">
		<ul class="pdtList">
			<% Call PrintBestOneItem("be", dispCate, iid, chkSale) %>
		</ul>
	</div>
</div>