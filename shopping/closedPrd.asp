<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Dim itemid
	itemid = requestCheckVar(request("itemid"),9)

	if itemid="" or itemid="0" then
		Call Alert_Return("상품번호가 없습니다.")
		response.End
	elseif Not(isNumeric(itemid)) then
		Call Alert_Return("잘못된 상품번호입니다.")
		response.End
	else	'정수형태로 변환
		itemid=CLng(getNumeric(itemid))
	end if

	'// 에코마케팅용 레코벨 스크립트 용(2016.12.21) 
	Dim vPrtr
	vPrtr = requestCheckVar(request("pRtr"),200)
	
	Dim oItem , viBsimg , catecode
	set oItem = new CatePrdCls
	oItem.GetItemData itemid

	'// 구글 에널리틱스용
	function ImageExists(byval iimg)
		if (IsNull(iimg)) or (trim(iimg)="") or (Right(trim(iimg),1)="\") or (Right(trim(iimg),1)="/") then
			ImageExists = false
		else
			ImageExists = true
		end if
	end function

	if ImageExists(oitem.Prd.FImageBasic600) then
		viBsimg = oitem.Prd.FImageBasic600
	elseif ImageExists(oitem.Prd.FImageBasic) then
		viBsimg = oitem.Prd.FImageBasic
	end If
	
	if viBsimg<>"" then
		viBsimg = getThumbImgFromURL(viBsimg,500,500,"true","false")
	End If

	'//카테코드
	catecode = oItem.Prd.FcateCode
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<meta name="robots" content="noindex">
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
</head>
<body>
<div class="wrap searchWrapV15">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">

			<%'!-- 판매 종료된 상품 검색시 노출 --%>
			<div class="ct box3 closedPrdV17">
				<p><img src="http://fiximage.10x10.co.kr/web2017/search/txt_closed_prd.png" alt="죄송합니다. 판매가 종료된 상품입니다." /></p>
				<a href="/" class="btn btnRed btnGoShopping">쇼핑하러 가기</a>
			</div>
			<%'!-- //판매 종료된 상품 검색시 노출 --%>

			<%'!-- 이런 상품은 어때요?--%>
			<%
				'// 카테고리 베스트
				dim oCBDoc,iLp, ichk
				set oCBDoc = new SearchItemCls
					oCBDoc.FRectSortMethod	= "be"		'인기상품
					oCBDoc.FRectSearchFlag = "n"			'일반상품
					oCBDoc.FRectSearchItemDiv = "n"		'기본 카테고리만
					oCBDoc.FRectSearchCateDep = "T"		'하위 카테고리 포함
					oCBDoc.FRectCateCode	= catecode
					oCBDoc.FCurrPage = 1
					oCBDoc.FPageSize = 5					'5개 접수
					oCBDoc.FScrollCount = 5
					oCBDoc.FListDiv = "list"				'상품목록
					oCBDoc.FLogsAccept = False			'로그 기록안함
					oCBDoc.FAddLogRemove = true			'추가로그 기록안함
					oCBDoc.FSellScope= "Y"				'판매중인 상품만
					oCBDoc.getSearchList

				dim icoSize	: icoSize="M"	'상품 아이콘 기본(중간)
				dim imgSz	: imgSz = chkIIF(icoSize="M",240,150)

				'//카테코드 있을경우
				Dim TFflag 
				If oCBDoc.FResultCount > 0 Then
					TFflag = True
				Else
					TFflag = False
				End If

				If TFflag Then
					ichk = 1
			%>
			<div class="keywordPdtV15">
				<h2 class="cBk0V15">이런 상품은 어때요?</h2>
				<span class="goMore"><a href="/shopping/category_list.asp?srm=be&disp=<%=catecode%>">더보기 ></a></span>
				<div class="pdt200V15 kwdRecV17">
					<ul class="pdtList">
						<%
							For iLp=0 To oCBDoc.FResultCount-1
								if cStr(oCBDoc.FItemList(iLp).Fitemid)<>cStr(itemid) then	'현재보는 상품이 아니면 표시
						%>
						<li>
							<div class="pdtBox">
								<div class="pdtPhoto">
									<span class="soldOutMask"></span>
									<a href="/shopping/category_prd.asp?itemid=<%= oCBDoc.FItemList(iLp).Fitemid %>&rc=item_cate_<%=ichk%>">
										<img src="<%=oCBDoc.FItemList(iLp).FImageIcon2%>" alt="<%=Replace(oCBDoc.FItemList(iLp).FitemName,"""","")%>" />
										<% if oCBDoc.FItemList(iLp).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oCBDoc.FItemList(iLp).FAddimage,imgSz,imgSz,"true","false")%>" onerror="$(this).parent().empty();" alt="<%=Replace(oCBDoc.FItemList(iLp).FitemName,"""","")%>" /></dfn><% end if %>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oCBDoc.FItemList(iLp).FMakerid %>&rc=item_cate_<%=ichk%>"><% = oCBDoc.FItemList(iLp).FBrandName %></a></p>
									<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= oCBDoc.FItemList(iLp).Fitemid %>&rc=item_cate_<%=ichk%>"><% = oCBDoc.FItemList(iLp).FItemName %></a></p>

									<% if oCBDoc.FItemList(iLp).IsSaleItem or oCBDoc.FItemList(iLp).isCouponItem Then %>
										<% IF oCBDoc.FItemList(iLp).IsSaleItem then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oCBDoc.FItemList(iLp).getOrgPrice,0)%>원</span></p>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oCBDoc.FItemList(iLp).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=oCBDoc.FItemList(iLp).getSalePro%>]</strong></p>
										<% End If %>
										<% IF oCBDoc.FItemList(iLp).IsCouponItem Then %>
											<% if Not(oCBDoc.FItemList(iLp).IsFreeBeasongCoupon() or oCBDoc.FItemList(iLp).IsSaleItem) Then %>
										<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oCBDoc.FItemList(iLp).getOrgPrice,0)%>원</span></p>
											<% end If %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oCBDoc.FItemList(iLp).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=oCBDoc.FItemList(iLp).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oCBDoc.FItemList(iLp).getRealPrice,0) & chkIIF(oCBDoc.FItemList(iLp).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
									<p class="pdtStTag tPad10">
										<% IF oCBDoc.FItemList(iLp).isSoldOut Then %>
										<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
										<% else %>
											<% IF oCBDoc.FItemList(iLp).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
											<% IF oCBDoc.FItemList(iLp).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
											<% IF oCBDoc.FItemList(iLp).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
											<% IF oCBDoc.FItemList(iLp).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
											<% IF oCBDoc.FItemList(iLp).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
											<% IF oCBDoc.FItemList(iLp).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
											<% If G_IsPojangok Then %>
											<% IF oCBDoc.FItemList(iLp).IsPojangitem Then %><span class="icoWrappingV15a"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능"><em><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png" alt="선물포장가능"></em></span> <% end if %>
											<% End If %>
										<% end if %>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oCBDoc.FItemList(iLp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" onclick="<%=chkIIF(oCBDoc.FItemList(iLp).FEvalCnt>0,"popEvaluate('" & oCBDoc.FItemList(iLp).FItemid & "');","")%>return false;"><span><%=oCBDoc.FItemList(iLp).FEvalCnt%></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oCBDoc.FItemList(iLp).FItemid %>'); return false;"><span><%=oCBDoc.FItemList(iLp).FfavCount%></span></a></li>
								</ul>
							</div>
						</li>
						<%
								ichk = ichk+1
								end if
								if ichk>5 then Exit For
							Next
						%>
					</ul>
				</div>
			</div>
			<%
					set oCBDoc = Nothing
				Else 
			'//카테코드 없을경우
			Dim oaward , atype , i

			atype="b" '2015-09-17 b -> f 변경 기본b

			set oaward = new CAWard
			oaward.FPageSize = 5

			oaward.FRectAwardgubun = atype
			oaward.GetNormalItemList
			%>
			<div class="keywordPdtV15">
				<h2 class="cBk0V15">이런 상품은 어때요?</h2>
				<span class="goMore"><a href="/award/awardlist.asp?atype=b&gaparam=main_menu_best">더보기 ></a></span>
				<div class="pdt200V15 kwdRecV17">
					<ul class="pdtList">
						<%
							for i=0 to oaward.FPageSize
								If oaward.FResultCount>0 AND oaward.FResultCount > i Then
						%>
						<li>
							<div class="pdtBox">
								<div class="pdtPhoto">
									<span class="soldOutMask"></span>
									<a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemId%>">
										<img src="<%= oaward.FItemList(i).FImageBasic %>" alt="<%=oaward.FItemList(i).FItemName%>" />
										<dfn><img src="http://fiximage.10x10.co.kr/web2013/@temp/pdt01_400x400.jpg" alt="<%=oaward.FItemList(i).FItemName%>" /></dfn>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=oaward.FItemList(i).FMakerid%>"><%=oaward.FItemList(i).FBrandName%></a></p>
									<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemId%>"><%=oaward.FItemList(i).FItemName%></a></p>

									<%
										If oaward.FItemList(i).IsSaleItem or oaward.FItemList(i).isCouponItem Then
											IF oaward.FItemList(i).IsSaleItem Then
												Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oaward.FItemList(i).FOrgPrice,0) & "원 </span></p>"
												Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oaward.FItemList(i).getRealPrice,0) & "원 </span>"
												Response.Write "<strong class='cRd0V15'>[" & oaward.FItemList(i).getSalePro & "]</strong></p>"
											End IF
											IF oaward.FItemList(i).IsCouponItem Then
												if Not(oaward.FItemList(i).IsFreeBeasongCoupon() or oaward.FItemList(i).IsSaleItem) Then
													Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oaward.FItemList(i).FOrgPrice,0) & "원 </span></p>"
												end if
												Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oaward.FItemList(i).GetCouponAssignPrice,0) & "원 </span>"
												Response.Write "<strong class='cGr0V15'>[" & oaward.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
											End IF
										Else
											Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oaward.FItemList(i).getRealPrice,0) & "원 </span>"
										End If
									%>
									<p class="pdtStTag tPad10">
										<%
											IF oaward.FItemList(i).isSoldOut Then
												Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
											Else
												IF oaward.FItemList(i).isTenOnlyItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif' alt='ONLY' /> "
												IF oaward.FItemList(i).isSaleItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' /> "
												IF oaward.FItemList(i).isCouponItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' /> "
												IF oaward.FItemList(i).isLimitItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' /> "
												IF oaward.FItemList(i).isNewItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' /> "
											End If
										%>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oaward.FItemList(i).FItemid%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" onclick="popEvaluate('<%=oaward.FItemList(i).FItemid%>'); return false;"><span><%= oaward.FItemList(i).FEvalCnt %></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oaward.FItemList(i).FItemid %>'); return false;"><span><%= oaward.FItemList(i).FfavCount %></span></a></li>
								</ul>
							</div>
						</li>
						<%
								End If
							Next
						%>
					</ul>
				</div>
			</div>
			<%
				Set oaward = Nothing
			End If
			%>
			<%'!--// 이런 상품은 어때요? --%>
			<div id="dimed"></div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<%' 에코마케팅용 레코벨 스크립트 삽입(2016.12.21) %>
<script type="text/javascript">
  window._rblq = window._rblq || [];
  _rblq.push(['setVar','cuid','0f8265c6-6457-4b4a-b557-905d58f9f216']);
  _rblq.push(['setVar','device','PW']);
  _rblq.push(['setVar','itemId','<%=itemid%>']);
//  _rblq.push(['setVar','userId','{$userId}']); // optional
  _rblq.push(['setVar','searchTerm','<%=vPrtr%>']);
  _rblq.push(['track','view']);
  (function(s,x){s=document.createElement('script');s.type='text/javascript';
  s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+
  '://assets.recobell.io/rblc/js/rblc-apne1.min.js';
  x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>

<script>
// 구글 애널리틱스 관련
function fnGaSendCheckValue(bool)
{
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
   ga('create', 'UA-16971867-10', 'auto');

	// 구글 애널리틱스 값
	if (bool==true){
		ga('send', 'event', 'UX', 'click', 'add');
	}
	else
	{
		ga('send', 'event', 'UX', 'click', 'DO1');
	}
}
</script>

<script type="application/ld+json">
{
	"@context": "http://schema.org/",
	"@type": "Product",
	"name": "<%= Replace(oItem.Prd.FItemName,"""","") %>",
	<% if viBsimg<>"" then %>
	"image": "<%= viBsimg %>",
	<% end if %>
	"mpn": "<%= itemid %>",
	"brand": {
		"@type": "Brand",
    	"name": "<%= Replace(UCase(oItem.Prd.FBrandName),"""","") %>"
	}<%
	 if (oItem.Prd.FEvalCnt > 0) then
		 dim avgEvalPoint : avgEvalPoint = getEvaluateAvgPoint(itemid)
		 if (avgEvalPoint > 0) then
	 %>,
	"aggregateRating": {
		"@type": "AggregateRating",
		"ratingValue": "<%= avgEvalPoint %>",
		"reviewCount": "<%= oItem.Prd.FEvalCnt %>"
	}<%
	 	end if
	 end if
	 %>
}
</script>
</body>
</html>
<%
	Set oItem = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->