<%
	Dim vIsExistTopImg
	vIsExistTopImg = "x"
	IF isArray(arrGroup) Then
%>
	<% If arrGroup(4,0) <> "" Then %>
	<div class="eventContV15 tMar15">
		<div class="contF <%=CHKIIF(vIsWide=True,"contW","")%>">
		<% If slide_w_flag ="Y" Then %><% sbSlidetemplate '//slide template %><% End If %>
		<%=db2html(arrGroup(4,intG))%>
		<% If vDateView = False Then %><div class="evtTermWrap"><div class="evtTerm"><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></div></div><% End If %>
		</div>
		<%=strExpireMsg%>
	</div>
	<%
	j = 1
	vIsExistTopImg = "o"
	End If %>
	
	<div class="evtFullZigZagV15">
		<div class="evtPdtListV15">
			<div class="evtPdtWrapV15">
			<%
			For intG = j To UBound(arrGroup,2)
				egCode = arrGroup(0,intG)

				If intG <> j AND vIsExistTopImg = "o" Then
					Response.Write "</div><div class=""evtPdtListV15""><div class=""evtPdtWrapV15"">"
				End If
			%>
				<% if arrGroup(3,intG) <> "" then %>
				<div class="pdtGroupBar" id="groupBar<%=intG%>" name="groupBar<%=intG%>">
					<a name="event_namelink<%=intG%>"></a>
					<img src="<%=arrGroup(3,intG)%>" usemap="#mapGroup<%=egCode%>" alt="" />
					<% If vIsExistTopImg = "x" Then %>
					<% If vDateView = False Then %><div class="evtTermWrap"><div class="evtTerm"><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></div></div><% End If %>
					<%
					vIsExistTopImg = "o"
					End If %>
				</div>
				<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,intG))%></map>
				<div class="pdtWrap pdt150V15" id="groupBarItem<%=intG%>">
					<ul class="pdtList">
						<%=fnZigZagItemList(eCode,egCode,eitemsort)%>
					</ul>
				</div>
				<%end if%>
			<%
			Next
	Response.Write "</div></div>"
	END IF
%>


				
<%
Function fnZigZagItemList(eCode,egCode,eitemsort)
	Dim vBody, intIx, sBadges

	intI = 0
set cEventItem = new ClsEvtItem
	cEventItem.FECode 	= eCode
	cEventItem.FEGCode 	= egCode
	cEventItem.FEItemCnt= 105
	cEventItem.FItemsort= eitemsort
	cEventItem.fnGetEventItem
	iTotCnt = cEventItem.FTotCnt

	IF itemid = "" THEN
		itemid = cEventItem.FItemArr
	ELSE
		itemid = itemid&","&cEventItem.FItemArr
	END IF

	IF (iTotCnt >= 0) THEN
		vBody = ""
		For intI =0 To iTotCnt
		'For intI =0 To 1

			vBody = vBody & "<li "& chkIIF(cEventItem.FCategoryPrdList(intI).isSoldOut," class=""soldOut""","")&">" & vbCrLf
			vBody = vBody & "<div class=""pdtBox"">" & vbCrLf
			vBody = vBody & "	<div class=""pdtPhoto"">" & vbCrLf
			vBody = vBody & "		<a href=""/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID &"""><span class=""soldOutMask""></span><img src="""&getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FImageBasic,"150","150","true","false")&""" alt="""& cEventItem.FCategoryPrdList(intI).FItemName&""" />" & vbCrLf
									if cEventItem.FCategoryPrdList(intI).FAddimage<>"" then 
			vBody = vBody & "		<dfn><img src="""&getThumbImgFromURL(cEventItem.FCategoryPrdList(intI).FAddimage,"150","150","true","false")&""" alt="""& Replace(cEventItem.FCategoryPrdList(intI).FItemName,"""","")&""" /></dfn>"
									end if
			vBody = vBody & "		</a>" & vbCrLf
			vBody = vBody & "	</div>" & vbCrLf
			vBody = vBody & "	<div class=""pdtInfo"">" & vbCrLf
			vBody = vBody & "		<p class=""pdtBrand tPad20""><a href=""/street/street_brand.asp?makerid="& cEventItem.FCategoryPrdList(intI).FMakerId &""">"& cEventItem.FCategoryPrdList(intI).FBrandName &"</a></p>" & vbCrLf
			vBody = vBody & "		<p class=""pdtName tPad07""><a href=""/shopping/category_prd.asp?itemid="& cEventItem.FCategoryPrdList(intI).FItemID &""">"& cEventItem.FCategoryPrdList(intI).FItemName &"</a></p>" & vbCrLf
									if cEventItem.FCategoryPrdList(intI).IsSaleItem or cEventItem.FCategoryPrdList(intI).isCouponItem Then
										IF cEventItem.FCategoryPrdList(intI).IsSaleItem then
			'vBody = vBody & "			<p class=""pdtPrice tPad10""><span class=""txtML"">"& FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)&"원</span></p>" & vbCrLf
			vBody = vBody & "			<p class=""pdtPrice""><span class=""finalP"">"& FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0) &"원</span> <strong class=""cRd0V15"">["& cEventItem.FCategoryPrdList(intI).getSalePro &"]</strong></p>" & vbCrLf
										End If
										IF cEventItem.FCategoryPrdList(intI).IsCouponItem Then
											if Not(cEventItem.FCategoryPrdList(intI).IsFreeBeasongCoupon() or cEventItem.FCategoryPrdList(intI).IsSaleItem) Then
			'vBody = vBody & "			<p class=""pdtPrice tPad10""><span class=""txtML"">"& FormatNumber(cEventItem.FCategoryPrdList(intI).getOrgPrice,0)&"원</span></p>" & vbCrLf
											end If
			vBody = vBody & "			<p class=""pdtPrice""><span class=""finalP"">"& FormatNumber(cEventItem.FCategoryPrdList(intI).GetCouponAssignPrice,0) &"원</span> <strong class=""cGr0V15"">["& cEventItem.FCategoryPrdList(intI).GetCouponDiscountStr&"]</strong></p>" & vbCrLf
										End If
									Else 
			vBody = vBody & "			<p class=""pdtPrice""><span class=""finalP"">"& FormatNumber(cEventItem.FCategoryPrdList(intI).getRealPrice,0) & chkIIF(cEventItem.FCategoryPrdList(intI).IsMileShopitem,"Point","원")&"</span></p>" & vbCrLf
									End If
			vBody = vBody & "		<p class=""pdtStTag tPad10"">" & vbCrLf
										IF cEventItem.FCategoryPrdList(intI).isSoldOut Then
			vBody = vBody & "				<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif"" alt=""SOLDOUT"" />" & vbCrLf
										Else
											IF cEventItem.FCategoryPrdList(intI).isTempSoldOut Then
				vBody = vBody & "				<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif"" alt=""SOLDOUT"" />" & vbCrLf
											end if
											IF cEventItem.FCategoryPrdList(intI).isSaleItem Then 
				vBody = vBody & "				<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif"" alt=""SALE"" />" & vbCrLf
											end if
											IF cEventItem.FCategoryPrdList(intI).isCouponItem Then
				vBody = vBody & "				<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif"" alt=""쿠폰"" />" & vbCrLf
											end if
											IF cEventItem.FCategoryPrdList(intI).isLimitItem Then
				vBody = vBody & "				<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif"" alt=""한정"" />" & vbCrLf
											end if
											IF cEventItem.FCategoryPrdList(intI).IsTenOnlyitem Then 
				vBody = vBody & "				<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif"" alt=""ONLY"" />" & vbCrLf
											end if
											IF cEventItem.FCategoryPrdList(intI).isNewItem Then 
				vBody = vBody & "				<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif"" alt=""NEW"" />" & vbCrLf
											end if
										end if
			vBody = vBody & "		</p>" & vbCrLf
			vBody = vBody & "	</div>" & vbCrLf
'			vBody = vBody & "	<ul class=""pdtActionV15"">" & vbCrLf
'			vBody = vBody & "		<li class=""largeView""><a href="""" onclick=""ZoomItemInfo('"& cEventItem.FCategoryPrdList(intI).FItemid &"'); return false;""><img src=""http://fiximage.10x10.co.kr/web2015/common/btn_quick.png"" alt=""QUICK"" /></a></li>" & vbCrLf
'			vBody = vBody & "		<li class=""postView""><a href="""" "& chkIIF(cEventItem.FCategoryPrdList(intI).Fevalcnt>0,"onclick=""popEvaluate('" & cEventItem.FCategoryPrdList(intI).FItemid & "');return false;""","onclick=""return false;""")&"><span>"& FormatNumber(cEventItem.FCategoryPrdList(intI).Fevalcnt,0)&"</span></a></li>" & vbCrLf
'
'			vBody = vBody & "		<li class=""wishView""><a href="""" "& vbCrLf
'			vBody = vBody &	" onclick=""&TnAddFavorite('"&cEventItem.FCategoryPrdList(intI).FItemid &"');return false;"""& vbCrLf
'			vBody = vBody &	"><span>"& FormatNumber(cEventItem.FCategoryPrdList(intI).FfavCount,0) &"</span></a></li>" & vbCrLf
'			vBody = vBody & "	</ul>" & vbCrLf
			vBody = vBody & "</div>" & vbCrLf
			vBody = vBody & "</li>" & vbCrLf
			
			If intI = 5 Then
				vBody = vBody & "</ul></div></div><div class=""pdtWrap pdt150V15""><ul class=""pdtList"">" & vbCrLf
			End If
		Next
	End IF
	Set cEventItem = nothing
	fnZigZagItemList = vBody
End Function
%>