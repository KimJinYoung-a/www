<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/_sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 상품후기"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

Dim pushType, vAmplitudeFirstReview, vAmplitudeMileage, regcomp 
dim userid, page,  pagesize, SortMethod,cateCode, EvaluatedYN, i, j
userid      = getEncLoginUserID
vAmplitudeFirstReview = "N"
vAmplitudeMileage = 100
page        = requestCheckVar(request("page"),9)
pagesize    = requestCheckVar(request("pagesize"),9)
SortMethod  = requestCheckVar(request("SortMethod"),10)
cateCode	= requestCheckVar(request("cateCode"),3)
EvaluatedYN	= requestCheckVar(request("EvaluatedYN"),2)
pushType 	= requestCheckVar(request("pushtype"),10)
regcomp		= requestCheckVar(request("regcomp"),2)

if page="" then page=1
if pagesize="" then pagesize="16"
if EvaluatedYN="" then EvaluatedYN="N"
if SortMethod ="" then
	'고객작성후기라면 정렬기본값은 작성일자순(2008.04.28;허진원)
	if EvaluatedYN="Y" then
		SortMethod ="Reg"
	else
		SortMethod ="Buy"
	end if
end if

if EvaluatedYN="Y" then
	pagesize="5"
else
	pagesize="16"
end if

dim EvList
set EvList = new CEvaluateSearcher
EvList.FRectUserID = Userid
EvList.FPageSize = pagesize
EvList.FCurrPage	= page
EvList.FScrollCount = 10

''EvList.FRectcdL= cdL
EvList.FCateCode = cateCode

EvList.FRectEvaluatedYN=EvaluatedYN
EvList.FSortMethod = SortMethod

if EvaluatedYN="Y" then
	EvList.EvalutedItemListNew ''후기 가져오기
else
	EvList.NotEvalutedItemListNew ''후기 안쓰인 상품 가져오기
end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script language="javascript">
fnAmplitudeEventMultiPropertiesAction("view_my_review_list","pushtype","<%=pushType%>");
<%if EvaluatedYN = "Y" then%>
fnAmplitudeEventMultiPropertiesAction("complete_my_review_regist","","");
<%end if%>

$(document).unbind("dblclick");

function SwapCate(comp){
    // var cdl = comp.value;
    var frm = comp.form;
	// frm.cdL.value = cdl;
	frm.submit();
}

function DelEval(OrdSr,ItID,Opt){
	if (confirm('상품평을 삭제 하시겠습니까? \n\n삭제후 재작성이 불가능합니다.')){
	    var frm = document.dFrm;
	    frm.orderserial.value = OrdSr;
	    frm.itemid.value = ItID;
	    frm.optionCD.value = Opt;

	    frm.action="/my10x10/goodsUsing_delProc.asp";
	    frm.submit();

	}
}

function goPage(page){
    var frm = document.evaluateFrm;
    frm.page.value=page;
    frm.submit();
}

</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="//fiximage.10x10.co.kr/web2013/my10x10/tit_my_product_review.gif" alt="상품후기" /></h3>
						<ul class="list">
							<li>구매하신 상품에 대한 유용한 정보를 다른 고객과 공유하는 곳으로 솔직 담백한 상품후기를 올려주세요.</li>
							<li>상품후기를 작성하시면 100point가 적립되며 배송정보[출고완료]이후부터 작성하실 수 있습니다.</li>
							<li>상품별로 첫 상품후기 작성시에는 마일리지 200point가 적립됩니다.</li>
							<li>취소/반품/교환의 경우 해당상품의 후기 및 적립된 마일리지는 자동삭제 됩니다.</li>
							<li>절판된 상품 및 6개월 이전 구매상품에 대한 후기는 작성하실 수 없습니다.</li>
							<li>적립 예상 마일리지는 현시점에 예상된 금액으로, 후기 작성 시점에 따라 달라질 수 있습니다.</li>

							<% If Now() > #04/25/2018 00:00:00# AND Now() < #04/29/2018 23:59:59# Then %>
								<li>상품후기를 남기면 마일리지를 2배로 적립해드리는 이벤트를 진행 중입니다. (기간: ~2018년 4월 29일까지)</li>
							<% end if %>
						</ul>
						
						<!-- #include virtual="/my10x10/inc_goodusing_mileage.asp" -->
					</div>

					<div class="mySection">
						<div class="myWishWrap">
							<div class="sorting bPad30">
								<ul class="tabMenu addArrow tabReview">
									<li><a href="?EvaluatedYN=N" <%= ChkIIF(EvaluatedYN="N","class='on'","") %> ><span>상품후기 작성</span></a></li>
									<li><a href="?EvaluatedYN=Y" <%= ChkIIF(EvaluatedYN="Y","class='on'","") %> ><span>작성된 후기관리</span></a></li>
								</ul>

								<form name="evaluateFrm" method="get" action="">
								<input type="hidden" name="mode" value="" />
								<input type="hidden" name="page" value="" />
								<input type="hidden" name="EvaluatedYN" value="<%= EvaluatedYN %>" />
								<input type="hidden" name="orderserial" value="" />
								<input type="hidden" name="itemid" value="" />
								<input type="hidden" name="optionCD" value="" />

								<div class="option">
									<select name="cateCode" title="카테고리 옵션 선택" class="optSelect2"  onChange="SwapCate(this);">
										<%=CategorySelectBoxOption(cateCode)%>
									</select>

									<select name="sortmethod" title="상품 후기 정렬 옵션" class="optSelect2" onchange="this.form.submit();">
										<option value="Buy"   <% if SortMethod="Buy" then response.write "selected" %>>구매일자순</option>
										<option value="Best"  <% if SortMethod="Best" then response.write "selected" %>>베스트상품순</option>
										<% if (EvaluatedYN="Y") then %>
										<option value="Reg"   <% if SortMethod="Reg" then response.write "selected" %>>작성 일자순</option>
										<option value="Photo" <% if SortMethod="Photo" then response.write "selected" %>>포토상품후기순</option>
										<% end if %>
									</select>
								</div>

								</form>
							</div>

							<% if EvaluatedYN="Y" then '' 상품후기 조회/수정 %>

							<div class="myItemList">
							<% if EvList.FResultCount > 0 then %>
								<% for  i = 0 to EvList.FResultCount-1 %>
								<div class="myItem">
									<div class="pdfInfo">
										<div class="pdtPhoto"><a href="javascript:TnGotoProduct('<%= EvList.FItemList(i).FItemID %>');" title="상품 페이지로 이동"><img src="<%= EvList.FItemList(i).FImageList120 %>" width="120" height="120" alt="" /></a></div>
										<p class="pdtBrand"><a href="javascript:GoToBrandShop('<% = EvList.FItemList(i).FMakerID %>');" title="브랜드 샵으로 이동"><%=EvList.FItemList(i).FMakerName%></a></p>
										<p class="pdtName tPad10"><a href="javascript:TnGotoProduct('<%= EvList.FItemList(i).FItemID %>');" title="상품 페이지로 이동"><%= EvList.FItemList(i).FItemName %></a></p>
									</div>
									<div class="reviewInfo">
										<div class="rating">
											<ul>
												<li><span>총평</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=EvList.FItemList(i).FTotalPoint%>.png" class="pngFix" alt="별<%=EvList.FItemList(i).FTotalPoint%>개" /></li>
												<% if EvList.FItemList(i).FPoint_fun <> 0 then %>
												<li><span>기능</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=EvList.FItemList(i).FPoint_fun%>.png" class="pngFix" alt="별<%=EvList.FItemList(i).FPoint_fun%>개" /></li>
												<li><span>디자인</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=EvList.FItemList(i).FPoint_dgn%>.png" class="pngFix" alt="별<%=EvList.FItemList(i).FPoint_dgn%>개" /></li>
												<li><span>가격</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=EvList.FItemList(i).FPoint_prc%>.png" class="pngFix" alt="별<%=EvList.FItemList(i).FPoint_prc%>개" /></li>
												<li><span>만족도</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=EvList.FItemList(i).FPoint_stf%>.png" class="pngFix" alt="별<%=EvList.FItemList(i).FPoint_stf%>개" /></li>
												<% end if %>
											</ul>
										</div>

										<div class="comment">
											<p><%= FormatDate(EvList.FItemList(i).FRegDate, "0000/00/00") %><% If EvList.FItemList(i).FShopName<>"" Then %> <span class="cMt0V15 lPad03 "><% = EvList.FItemList(i).FShopName %></span><% End If %></p>
											<% if (EvList.FItemList(i).FOptionName <> "") then %>
											<div class="purchaseOption"><em>[ 구매옵션 : <%= EvList.FItemList(i).FOptionName %> ]</em></div>
											<% end if %>
											<div class="textArea">
												<% if EvList.FItemList(i).fEval_excludeyn="N" then %>
													<p><%= nl2br(EvList.FItemList(i).FUesdContents) %></p>
												<% end if %>
											</div>
											<% if EvList.FItemList(i).Flinkimg1<>"" then %>
											<div class="imgArea"><a href="javascript:popShowImg('<%= EvList.FItemList(i).getLinkImage1 %>');" title="상품 후기 이미지 자세히 보기"><img src="<%= EvList.FItemList(i).getLinkImage1 %>" name="image_fix_1_<%= i %>" id="image_fix_1_<%= i %>" onload="Resizeimg('400','image_fix_1_<%= i %>');" alt="상품 후기 등록 이미지" /></a></div>
											<% end if %>
											<% if EvList.FItemList(i).Flinkimg2<>"" then %>
											<div class="imgArea"><a href="javascript:popShowImg('<%= EvList.FItemList(i).getLinkImage2 %>');" title="상품 후기 이미지 자세히 보기"><img src="<%= EvList.FItemList(i).getLinkImage2 %>" name="image_fix_2_<%= i %>" id="image_fix_2_<%= i %>" onload="Resizeimg('400','image_fix_2_<%= i %>');" alt="상품 후기 등록 이미지" /></a></div>
											<% end if %>
											<% if EvList.FItemList(i).Flinkimg3>"" then %>
											<div class="imgArea"><a href="javascript:popShowImg('<%= EvList.FItemList(i).getLinkImage3 %>');" title="상품 후기 이미지 자세히 보기"><img src="<%= EvList.FItemList(i).getLinkImage3 %>" name="image_fix_3_<%= i %>" id="image_fix_3_<%= i %>" onload="Resizeimg('400','image_fix_3_<%= i %>');" alt="상품 후기 등록 이미지" /></a></div>
											<% end if %>
											<% if EvList.FItemList(i).Flinkimg4>"" then %>
											<div class="imgArea"><a href="javascript:popShowImg('<%= EvList.FItemList(i).getLinkImage4 %>');" title="상품 후기 이미지 자세히 보기"><img src="<%= EvList.FItemList(i).getLinkImage4 %>" name="image_fix_4_<%= i %>" id="image_fix_4_<%= i %>" onload="Resizeimg('400','image_fix_4_<%= i %>');" alt="상품 후기 등록 이미지" /></a></div>
											<% end if %>
											<% if EvList.FItemList(i).Flinkimg5>"" then %>
											<div class="imgArea"><a href="javascript:popShowImg('<%= EvList.FItemList(i).getLinkImage5 %>');" title="상품 후기 이미지 자세히 보기"><img src="<%= EvList.FItemList(i).getLinkImage5 %>" name="image_fix_5_<%= i %>" id="image_fix_5_<%= i %>" onload="Resizeimg('400','image_fix_5_<%= i %>');" alt="상품 후기 등록 이미지" /></a></div>
											<% end if %>
											<div class="btnArea">
												<a href="javascript:AddEval('<%= EvList.FItemList(i).FOrderSerial %>','<%= EvList.FItemList(i).FItemID %>','<%= EvList.FItemList(i).FItemOption %>','<%= EvList.FItemList(i).FDetailIDX %>');" title="상품 후기 수정하기" class="btn btnS2 btnGry2"><span class="fn">수정</span></a>
												<a href="javascript:DelEval('<%= EvList.FItemList(i).FOrderSerial %>','<%= EvList.FItemList(i).FItemID %>','<%= EvList.FItemList(i).FItemOption %>');" title="상품 후기 삭제하기" class="btn btnS2 btnGry2"><span class="fn">삭제</span></a>
											</div>
										</div>
									</div>
								</div>
								<% next %>
							<% else %>
								<p class="noData"><strong>등록하신 상품후기가 없습니다.</strong></p>
							<% end if %>
							</div>

							<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(EvList.FcurrPage, EvList.FtotalCount, EvList.FPageSize, EvList.FScrollCount, "goPage") %></div>

							<% else '' 상품후기 작성 %>

							<div class="pdtWrap pdt150V15">
							<% if EvList.FResultCount > 0 then %>
								<ul class="pdtList reviewList">
								<% for i = 0 to EvList.FResultCount - 1 %>
									<li>
										<div class="pdtBox">
											<div class="pdtPhoto">
												<a href="javascript:TnGotoProduct('<%= EvList.FItemList(i).FItemID %>')">
													<span class="soldOutMask"></span>
													<img src="<%=getThumbImgFromURL(EvList.FItemList(i).FIcon2,"150","150","true","false")%>" alt="<%= EvList.FItemList(i).FItemName %>" />
												</a>
											</div>
											<div class="pdtInfo">
												<p class="pdtBrand tPad20"><a href="" onclick="GoToBrandShop('<% = EvList.FItemList(i).FMakerID %>');return false;"><%= EvList.FItemList(i).FMakerName %></a></p>
												<p class="pdtName tPad07"><a href="" onclick="TnGotoProduct('<%= EvList.FItemList(i).FItemID %>');return false;"><%= EvList.FItemList(i).FItemName %></a></p>
												<p class="pdtPrice"><span class="finalP"><%= FormatNumber(EvList.FItemList(i).FItemCost,0) %>원</span></p>
												<% If EvList.FItemList(i).FShopName<>"" Then %>
												<p class="offshop tPad10 cMt0V15"><% = EvList.FItemList(i).FShopName %></p>
												<% End If %>
												<p class="pdtDate">구매일 | <%= Left(CStr(EvList.FItemList(i).FOrderDate),10) %></p>
											</div>
											<div class="cartBtn">
												<%
													if EvList.FItemList(i).FEvalCnt=0 then
														vAmplitudeFirstReview = "Y"
														vAmplitudeMileage = 200																									
													end if
												%>
												<a href="" onclick="AddEval('<%= EvList.FItemList(i).FOrderSerial %>','<%= EvList.FItemList(i).FItemID %>','<%= EvList.FItemList(i).FItemOption %>','<%= EvList.FItemList(i).FDetailIDX %>'); fnAmplitudeEventMultiPropertiesAction('click_my_review_write','firstreview|productname|brandname|mileage','<%=vAmplitudeFirstReview%>|<%=EvList.FItemList(i).FItemname%>|<%=EvList.FItemList(i).FMakerName%>|<%=vAmplitudeMileage%>'); return false;" class="btn btnM2 btnWhite btnW150">상품후기</a>
												<% if EvList.FItemList(i).FEvalCnt=0 then %>
												<p class="firstReview"><em>★첫후기 200 Point</em></p>
												<% end if %>
											</div>
											<ul class="pdtActionV15">
												<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=EvList.FItemList(i).FItemID %>');return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
												<li class="postView"><a href="" <%=chkIIF(EvList.FItemList(i).FEvalCnt>0,"onclick=""popEvaluate('" & EvList.FItemList(i).FItemID & "');""","")%>><span><%=formatNumber(EvList.FItemList(i).FEvalCnt,0)%></span></a></li>
												<li class="wishView" id="wsIco<%=EvList.FItemList(i).FItemID %>"><a href="" onclick="TnAddFavorite('<%=EvList.FItemList(i).FItemID %>');return false;"><span><%=formatNumber(EvList.FItemList(i).FFavCount,0)%></span></a></li>
											</ul>
										</div>
									</li>
								<% next %>
								</ul>
							<% else %>
								<p class="noData"><strong>작성하실 상품후기가 없습니다.</strong></p>
							<% end if %>
							</div>
							<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(EvList.FcurrPage, EvList.FtotalCount, EvList.FPageSize, EvList.FScrollCount, "goPage") %></div>
						</div>
					<% end if %>
					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

<form name="dFrm" method="post" action="">
<input type="hidden" name="orderserial" value="">
<input type="hidden" name="itemid" value="">
<input type="hidden" name="optionCD" value="">
</form>

</body>
</html>
<%

set EvList= nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
