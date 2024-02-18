<%@ codepage="65001" language="VBScript" %>
<% option Explicit 
Response.CharSet = "UTF-8"
%>
<%
'#######################################################
'	Description : 상품후기 전체보기
'               : 팝업 창 사이즈 width=800, height=820
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 상품후기 보기"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
	dim id,itemid, itemname
	id		= getNumeric(requestCheckVar(request("id"),10))
	itemid	= getNumeric(requestCheckVar(request("itemid"),10))

	if itemid="" then
		Call Alert_close("지정된 상품이 없습니다.")
		dbget.Close(): response.End
	end if

	'// 상품 기본 정보 접수
	dim oItem
	set oItem = new CatePrdCls
	oItem.GetItemData itemid
	
	if oItem.FResultCount=0 then
		Call Alert_close("존재하지 않는 상품입니다.")
		dbget.Close(): response.End
	end if
	
	if oItem.Prd.Fisusing="N" then
		Call Alert_close("판매가 종료되었거나 삭제된 상품입니다.")
		dbget.Close(): response.End
	end if

	'// 상품후기 내용 접수
	dim oEval, oEvalCnt, ix
	Set oEvalCnt = new CEvaluateSearcher
		oEvalCnt.FRectItemID = itemid
		oEvalCnt.getEvaluatedItem_cnt
		itemname = oEvalCnt.FEvalItem.FItemname
	Set oEvalCnt = Nothing

	set oEval = new CEvaluateSearcher
	oEval.FRectItemID = itemid
	oEval.FIdx = id

	oEval.getItemEvalOne

	if oEval.FResultCount<=0 then
		Call Alert_Close("삭제되었거나 없는 상품후기입니다.")
		dbget.Close: response.End
	end if

	dim bdgUid, bdgBno
	'뱃지 목록 접수(순서 랜덤)
	Call getUserBadgeList("''" & trim(oEval.FEvalItem.FUserID) & "''",bdgUid,bdgBno,"Y")

'/상품고시관련 상품후기 제외 상품
dim Eval_excludeyn : Eval_excludeyn="N"
	Eval_excludeyn=getEvaluate_exclude_Itemyn(itemid)	
%>
	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="//fiximage.10x10.co.kr/web2013/my10x10/tit_product_review.gif" alt="상품후기" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="popReviewV15">
					<div class="reviewPdtV15">
						<div class="pdtBox">
							<div class="pdtPhoto"><img src="<%=getThumbImgFromURL(oitem.Prd.FImageBasic,120,120,"true","false")%>" alt="<%=replace(oItem.Prd.FItemName,"""","")%>"></div>
							<div class="pdtInfo">
								<p class="pdtBrand tPad15"><a href="/street/street_brand.asp?makerid=<%= oItem.Prd.FMakerid %>" target="_blank"><%= UCase(oItem.Prd.FBrandName) %></a></a></p>
								<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=itemid%>" onclick="opener.TnGotoProduct(<%=itemid%>); self.close(); return false;" target="_blank"><%=oItem.Prd.FItemName%></a></p>
								<p class="pdtPrice">
									<span class="finalP"><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원")%></span>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %><strong class="cRd0V15">[<% = oItem.Prd.getSalePro %>]</strong><% end if %>
									<% if oitem.Prd.isCouponItem Then %><strong class="cGr0V15">[<%= oItem.Prd.GetCouponDiscountStr %>]</strong><% end if %>
								</p>
							</div>
						</div>
					</div>
					<a href="popItemEvaluate.asp?itemid=<%=itemid%>" class="redArr03 cRd0V15 lPad12">상품전체 리뷰보기 (<strong><%= formatNumber(oItem.Prd.FevalCnt,0) %></strong>)</a>

					<div class="review pdtReviewV15 tMar10">

						<table class="talkList">
						<caption>상품후기 상세보기</caption>
						<colgroup>
							<col width="110" /> <col width="" /> <col width="110" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">평점</th>
							<th scope="col">내용</th>
							<th scope="col">작성일자 및 작성자</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td>
								<div class="rating">
									<ul>
										<li><span>기능</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FEvalItem.FPoint_fun%>.png" class="pngFix" alt="별<%=oEval.FEvalItem.FPoint_fun%>개" /></li>
										<li><span>디자인</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FEvalItem.FPoint_dgn%>.png" class="pngFix" alt="별<%=oEval.FEvalItem.FPoint_dgn%>개" /></li>
										<li><span>가격</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FEvalItem.FPoint_prc%>.png" class="pngFix" alt="별<%=oEval.FEvalItem.FPoint_prc%>개" /></li>
										<li><span>만족도</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FEvalItem.FPoint_stf%>.png" class="pngFix" alt="별<%=oEval.FEvalItem.FPoint_stf%>개" /></li>
									</ul>
								</div>
							</td>
							<td class="comment">
								<% if Not(oEval.FEvalItem.FOptionName="" or isNull(oEval.FEvalItem.FOptionName)) then %>
									<div class="purchaseOption"><em><strong>구매옵션</strong> : <%=oEval.FEvalItem.FOptionName%></em></div>
								<% end if %>
	
								<%
								'//상품고시관련 상품후기 제외 상품이 아닐경우
								if Eval_excludeyn="N" then
								%>
									<div class="textArea">
										<p><% = nl2br(oEval.FEvalItem.FUesdContents) %></p>
									</div>
									<div class="imgArea">
										<% if oEval.FEvalItem.Flinkimg1<>"" then %>
										<img src="<%= oEval.FEvalItem.getLinkImage1 %>" id="file1"><br/>
										<% end if %>
										<% if oEval.FEvalItem.Flinkimg2<>"" then %>
										<img src="<% = oEval.FEvalItem.getLinkImage2 %>" id="file2">
										<% end if %>
									</div>
								<%
								'//상품고시관련 상품후기 제외 상품일경우
								else
								%>
									<div class="textArea">
										<p>* 본 상품은 건강식품 및 의료기기에 해당되는 상품으로 고객 상품평 이용이 제한됩니다</p>
									</div>
								<% end if %>
							</td>
							<td class="ct">
								<div><%= FormatDate(oEval.FEvalItem.FRegdate,"0000/00/00") %></div>
								<div><%= printUserId(oEval.FEvalItem.FUserID,2,"*") %></div>
								<p class="badgeView tPad01"><%=getUserBadgeIcon(oEval.FEvalItem.FUserID,bdgUid,bdgBno,3)%></p>
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>
<%
	set oItem = Nothing
	set oEval = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->