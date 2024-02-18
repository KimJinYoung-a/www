<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'#############################################################
'	Description : 다이어리 메인 상품 리스트
'	History		: 2017.09.19 유태욱 생성
'#############################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/event/etc/2018ChristmasCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->

<%
Dim i , cEventItem, iTotCnt
dim eCode
dim eGroupCode : eGroupCode 	= requestCheckVar(request("srm"),9)	'그룹코드 받아옴

IF application("Svr_Info") = "Dev" THEN
	eCode   =  66425
'	eGroupCode = 137191
Else
	eCode   =  81816
'	eGroupCode = 224155
End If

IF eGroupCode = "" Then eGroupCode = "224155"	'기본 조명:224155( 트리&리스:224156, 오너먼트:224157, 캔들&디퓨저:224158, 선물:224159, 카드:224160 )
	set cEventItem = new ClsEvtItem
	cEventItem.FECode 	= eCode
	cEventItem.FEGCode 	= eGroupCode
	cEventItem.FEPGsize 	= 50
'				cEventItem.Frectminnum= 11
'				cEventItem.Frectmaxnum= 20
	cEventItem.fnGetEventItem_v2
	iTotCnt = cEventItem.FTotCnt
%>

	<ul class="pdtList">
	<%
	If (iTotCnt >= 0) Then
		For i =0 To iTotCnt
	%>
			<li <%=chkIIF(cEventItem.FCategoryPrdList(i).isSoldOut,"class='soldOut'","")%>>
				<div class="pdtBox">
					<div class="pdtPhoto">
						<span class="soldOutMask"></span>
						<a href="/shopping/category_prd.asp?itemid=<%= cEventItem.FCategoryPrdList(i).Fitemid %>&pEtr=81815" target="_blank">
							<img src="<%= getThumbImgFromURL(cEventItem.FCategoryPrdList(i).FImageBasic,400,400,"true","false") %>" alt="<% = cEventItem.FCategoryPrdList(i).FItemName %>" />
						</a>
					</div>
					<div class="pdtInfo">
						<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<% = cEventItem.FCategoryPrdList(i).FMakerId %>" target="_blank"><% = cEventItem.FCategoryPrdList(i).FBrandName %></a></p>
						<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= cEventItem.FCategoryPrdList(i).Fitemid %>&pEtr=81815" target="_blank"><% = cEventItem.FCategoryPrdList(i).FItemName %></a></p>
						<%
							If cEventItem.FCategoryPrdList(i).IsSaleItem or cEventItem.FCategoryPrdList(i).isCouponItem Then
								IF cEventItem.FCategoryPrdList(i).IsSaleItem Then
									Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(cEventItem.FCategoryPrdList(i).FOrgPrice,0) & "원 </span></p>"
									Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(cEventItem.FCategoryPrdList(i).getRealPrice,0) & "원 </span>"
									Response.Write "<strong class='cRd0V15'>[" & cEventItem.FCategoryPrdList(i).getSalePro & "]</strong></p>"
						 		End IF
						 		IF cEventItem.FCategoryPrdList(i).IsCouponItem Then
						 			if Not(cEventItem.FCategoryPrdList(i).IsFreeBeasongCoupon() or cEventItem.FCategoryPrdList(i).IsSaleItem) Then
						 				Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(cEventItem.FCategoryPrdList(i).FOrgPrice,0) & "원 </span></p>"
						 			end if
									Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(cEventItem.FCategoryPrdList(i).GetCouponAssignPrice,0) & "원 </span>"
									Response.Write "<strong class='cGr0V15'>[" & cEventItem.FCategoryPrdList(i).GetCouponDiscountStr & "]</strong></p>"
						 		End IF
							Else
								Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(cEventItem.FCategoryPrdList(i).getRealPrice,0) & "원 </span>"
							End If
						%>
					</div>
				</div>
			</li>
	<%
		next
	End If
	%>
	</ul>
<%
set cEventItem=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
