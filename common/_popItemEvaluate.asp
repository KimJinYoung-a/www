<%@ codepage="65001" language="VBScript" %>
<% option Explicit
Response.CharSet = "UTF-8"
%>
<%
'#######################################################
'	Description : 상품후기 전체보기
'   etc : 팝업 창 사이즈 width=800, height=820
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 상품후기 보기"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/_sp_evaluatesearchercls.asp" -->
<%
dim itemid,i,page,sortMethod,ix, itemoption
dim oEval,j,oEvalCnt, EvalDiv
dim arrUserid, bdgUid, bdgBno

itemid = getNumeric(RequestCheckVar(request("itemid"),10))
itemoption = RequestCheckVar(request("itemoption"),4)
page = getNumeric(RequestCheckVar(request("page"),10))
sortMethod = RequestCheckVar(request("sortMtd"),2)
EvalDiv=RequestCheckVar(request("evaldiv"),1)

If sortMethod=""  then
sortMethod = RequestCheckVar(request("sortMethod"),2)
End If

if sortMethod="" or sortMethod="un" then sortMethod="ne"

if itemid="" then itemid=0
if page="" then page=1

if itemid=0 then
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

'// 상품후기 총 평가점수
dim vFdEvalTT, vFdEvalFun, vFdEvalDgn, vFdEvalPrc, vFdEvalStf
vFdEvalTT=0: vFdEvalFun=0: vFdEvalDgn=0: vFdEvalPrc=0: vFdEvalStf=0
Set oEvalCnt = new CEvaluateSearcher
oEvalCnt.FRectItemID = itemid
oEvalCnt.getItemEvalTotalPoint
if oEvalCnt.FResultCount>0 then
	vFdEvalTT = oEvalCnt.FEvalItem.FTotalPoint
	vFdEvalFun = oEvalCnt.FEvalItem.FPoint_fun
	vFdEvalDgn = oEvalCnt.FEvalItem.FPoint_dgn
	vFdEvalPrc = oEvalCnt.FEvalItem.FPoint_prc
	vFdEvalStf = oEvalCnt.FEvalItem.FPoint_stf
end if
Set oEvalCnt = Nothing

'// 상품후기 목록 접수
Set oEvalCnt = new CEvaluateSearcher
oEvalCnt.FRectItemID = itemid
if itemoption<>"" then oEvalCnt.FRectOption = itemoption
oEvalCnt.getEvaluatedItem_cnt

	set oEval = new CEvaluateSearcher
	oEval.FPageSize = 8
	oEval.FCurrpage = page
	oEval.FRectItemID = itemid
	if itemoption<>"" then oEval.FRectOption = itemoption
If sortMethod = "tt" Then
	oEval.FsortMethod = "ne" '테스터 후기
	oEval.getItemEvalPopup()
Else
	oEval.FEvalDiv = EvalDiv
	oEval.FsortMethod = sortMethod
	oEval.getItemEvalList
End If

'/상품고시관련 상품후기 제외 상품
dim Eval_excludeyn : Eval_excludeyn="N"
	Eval_excludeyn=getEvaluate_exclude_Itemyn(itemid)
%>

<script type="text/JavaScript">


//페이지 이동
function TnMovePage(icomp){
	document.frm.page.value=icomp;
	document.frm.submit();
}

function chgEvalVal(md) {
	if(md=="p") {
		document.frm.sortMtd.value = "";
		document.frm.evaldiv.value = "p";
		TnMovePage(1);
	} else if (md=="t"){
		document.frm.sortMtd.value = "";
		document.frm.evaldiv.value = "t";
		TnMovePage(1);
	} else if (md=="o"){
		document.frm.sortMtd.value = "";
		document.frm.evaldiv.value = "o";
		TnMovePage(1);
	} else {
		document.frm.evaldiv.value = "a";
		TnMovePage(1);
	}
}
$(function(){
	<% if EvalDiv = "a" or  EvalDiv = "o" or EvalDiv = "" then %>
	$("#lyEvalSelBox").show();
	<% else %>
	$("#lyEvalSelBox").hide();
	<% end if %>
});

</script>

	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
		<!-- // 본문 시작 //-->
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_product_review.gif" alt="상품후기" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="popReviewV15">
					<!-- 상품 정보 -->
					<div class="reviewPdtV15">
						<div class="pdtBox">
							<div class="pdtPhoto"><img src="<%=getThumbImgFromURL(oitem.Prd.FImageBasic,120,120,"true","false")%>" alt="<%=replace(oItem.Prd.FItemName,"""","")%>"></div>
							<div class="pdtInfo">
								<p class="pdtBrand tPad15"><a href="/street/street_brand.asp?makerid=<%= oItem.Prd.FMakerid %>" target="_blank"><%= UCase(oItem.Prd.FBrandName) %></a></a></p>
								<p class="pdtName tPad07"><%=oItem.Prd.FItemName%></p>
								<p class="pdtPrice">
									<span class="finalP"><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원")%></span>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %><strong class="cRd0V15">[<% = oItem.Prd.getSalePro %>]</strong><% end if %>
									<% if oitem.Prd.isCouponItem Then %><strong class="cGr0V15">[<%= oItem.Prd.GetCouponDiscountStr %>]</strong><% end if %>
								</p>
							</div>
						</div>
					</div>

					<!-- 후기 목록 -->
					<div class="review pdtReviewV15">
						<div class="sorting">
						<form name="frm" method="GET" action="">
						<input type="hidden" name="itemid" value="<%=itemid%>">
						<input type="hidden" name="page" value="<%=page%>">
						<input type="hidden" name="sortMethod" value="<%=sortMethod%>">
						<input type="hidden" name="evaldiv" value="<%=EvalDiv%>">
							<% if Eval_excludeyn="N" then '//일반상품 %>
							<ul class="tabMenuV15">
								<li><a href="" <%=chkiif(EvalDiv="" or EvalDiv="ne" or EvalDiv="be","class=""on""","")%> onclick="chgEvalVal('a'); return false;" id="evalall">전체 (<strong><%= formatNumber(oEvalCnt.FEvalItem.FEvalCnt,0) %></strong>)</a></li>
								<li><a href="" <%=chkiif(EvalDiv="p","class=""on""","")%> onclick="chgEvalVal('p'); return false;" id="evalph">포토 (<strong><%= formatNumber(oEvalCnt.FEvalItem.FEvalcnt_photo,0) %></strong>)</a></li>
								<% if oEvalCnt.FEvalItem.FEvalcnt_tester>0 then %>
								<li><a href="" <%=chkiif(EvalDiv="t","class=""on""","")%> onclick="chgEvalVal('t'); return false;" id="evaltester">테스터 후기 (<strong><%= formatNumber(oEvalCnt.FEvalItem.FEvalcnt_tester,0) %></strong>)</a></li>
								<% end if %>
								<li><a href="#" <%=chkiif(EvalDiv="o","class=""on""","")%> onclick="chgEvalVal('o'); return false;" id="evaloff">매장 (<strong><%= formatNumber(oEvalCnt.FEvalItem.FEvalOffCnt,0) %></strong>)</a></li>
							</ul>
							<% else		'//상품고시관련 상품후기(음식,식약품) %>
							<h3>상품 총 평점 <span class="fn fs11">(<strong><%= formatNumber(oEvalCnt.FEvalItem.FEvalCnt,0) %></strong>개 상품 후기 기준)</span></h3>
							<% end if %>
							<div class="option">
							<% if Eval_excludeyn="N" then %>
								<%=getItemEvalOptSelectbox("itemoption",itemoption,itemid,"title=""상품옵션 선택"" class=""optSelect2"" onchange=""TnMovePage(1)""")%>

								<% If sortMethod <> "ph" Then %>
								<span id="lyEvalSelBox">
								<select name="sortMtd" title="상품 후기 정렬 옵션" class="optSelect2" onchange="$('#sortMethod').val(this.value);TnMovePage(1);">
									<option value="ne"<%=chkiif(sortMethod="ne"," selected","")%>>최신후기순</option>
									<option value="be"<%=chkiif(sortMethod="be"," selected","")%>>우수상품후기순</option>
								</select>
								</span>
								<% else %>
								<input type="hidden" name="sortMtd" value="">
								<% end if %>
							<% end if %>
							</div>
						</form>
						</div>
					<%
					if oEval.FResultCount > 0 then
						'사용자 아이디 모음 생성(for Badge)
						for i = 0 to oEval.FResultCount - 1
							arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oEval.FItemList(i).FUserID) & "''"
						next

						'뱃지 목록 접수(순서 랜덤)
						Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")
					%>
					<%
					'//상품고시관련 상품후기 제외 상품이 아닐경우
					if Eval_excludeyn="N" then
					%>
						<table class="talkList">
						<caption>상품후기 목록</caption>
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
						<% for i = 0 to oEval.FResultCount - 1 %>
						<tr>
							<td>
								<div class="rating">
									<ul>
										<!--<li><span>상품평</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FTotalPoint%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FTotalPoint%>개" /></li>-->
										<li><span>기능</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_fun%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_fun%>개" /></li>
										<li><span>디자인</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_dgn%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_dgn%>개" /></li>
										<li><span>가격</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_prc%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_prc%>개" /></li>
										<li><span>만족도</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_stf%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_stf%>개" /></li>
									</ul>
								</div>
							</td>
							<td class="comment">
							<% If sortMethod="tt" Then %><!-- 테스터후기 -->
								<div class="textArea">
									<p>
										<b><u>총평</u></b><br/>
										<% = nl2br(oEval.FItemList(i).FUesdContents) %><br/><br/>
										<b><u>좋았던 점</u></b><br/>
										<% = nl2br(oEval.FItemList(i).FUseGood) %><br/><br/>
										<b><u>특이한 점 및 이용 TIP</u></b><br/>
										<% = nl2br(oEval.FItemList(i).FUseETC) %>
									</p>
								</div>
								<div class="imgArea">
									<% if oEval.FItemList(i).Flinkimg1<>"" then %><img src="<%= oEval.FItemList(i).Flinkimg1 %>" style="cursor:pointer;" onclick="popShowImg('<%= oEval.FItemList(i).Flinkimg1 %>');"><br/ ><% end if %>
									<% if oEval.FItemList(i).Flinkimg2<>"" then %><img src="<%= oEval.FItemList(i).Flinkimg2 %>" style="cursor:pointer;" onclick="popShowImg('<%= oEval.FItemList(i).Flinkimg2 %>');"><br/ ><% end if %>
									<% if oEval.FItemList(i).Flinkimg3<>"" then %><img src="<%= oEval.FItemList(i).Flinkimg3 %>" style="cursor:pointer;" onclick="popShowImg('<%= oEval.FItemList(i).Flinkimg3 %>');"><br/ ><% end if %>
									<% if oEval.FItemList(i).Flinkimg4<>"" then %><img src="<%= oEval.FItemList(i).Flinkimg4 %>" style="cursor:pointer;" onclick="popShowImg('<%= oEval.FItemList(i).Flinkimg4 %>');"><br/ ><% end if %>
									<% if oEval.FItemList(i).Flinkimg5<>"" then %><img src="<%= oEval.FItemList(i).Flinkimg5 %>" style="cursor:pointer;" onclick="popShowImg('<%= oEval.FItemList(i).Flinkimg5 %>');"><% end if %>
								</div>
							<% else %><!-- 상품후기 -->
								<% if Not(oEval.FItemList(i).FOptionName="" or isNull(oEval.FItemList(i).FOptionName)) then %>
								<div class="purchaseOption"><em><strong>구매옵션</strong> : <%=oEval.FItemList(i).FOptionName%></em></div>
								<% end if %>
								<div class="textArea">
									<p><% = nl2br(oEval.FItemList(i).FUesdContents) %></p>
								</div>
								<div class="imgArea">
									<% if oEval.FItemList(i).Flinkimg1<>"" then %>
									<img src="<%= oEval.FItemList(i).getLinkImage1 %>" id="file1<% = i %>"><br/>
									<% end if %>
									<% if oEval.FItemList(i).Flinkimg2<>"" then %>
									<img src="<% = oEval.FItemList(i).getLinkImage2 %>" id="file2<% = i %>">
									<% end if %>
								</div>
							<% end if %>
							</td>
							<td class="ct">
								<div><%= FormatDate(oEval.FItemList(i).FRegdate,"0000/00/00") %></div>
								<% If oEval.FItemList(i).FShopName<>"" Then %><div class="offshop cMt0V15"><% = oEval.FItemList(i).FShopName %></div><% End If %>
								<div><%= printUserId(oEval.FItemList(i).FUserID,2,"*") %></div>
								<p class="badgeView tPad05"><%=getUserBadgeIcon(oEval.FItemList(i).FUserID,bdgUid,bdgBno,3)%></p>
							</td>
						</tr>
						<% next %>
						</tbody>
						</table>
					<%
					'//상품고시관련 상품후기 제외 상품일경우
					else
					%>
						<div class="generalReviewV15">
							<h4>&lt;<span>총평 <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalTT)%>.png" alt="별<%=cInt(vFdEvalTT)%>개" /> <%=cInt(vFdEvalTT*25)%>점</span>&gt;</h4>
							<ul>
								<li>
									<strong>기능</strong>
									<p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalFun)%>.png" alt="별<%=cInt(vFdEvalFun)%>개" /> <%=cInt(vFdEvalFun*25)%>점</p>
								</li>
								<li>
									<strong>디자인</strong>
									<p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalDgn)%>.png" alt="별<%=cInt(vFdEvalDgn)%>개" /> <%=cInt(vFdEvalDgn*25)%>점</p>
								</li>
								<li>
									<strong>가격</strong>
									<p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalPrc)%>.png" alt="별<%=cInt(vFdEvalPrc)%>개" /> <%=cInt(vFdEvalPrc*25)%>점</p>
								</li>
								<li>
									<strong>만족도</strong>
									<p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=cInt(vFdEvalStf)%>.png" alt="별<%=cInt(vFdEvalStf)%>개" /> <%=cInt(vFdEvalStf*25)%>점</p>
								</li>
							</ul>
							<p>* 주관적인 의견에 의해 기능 및 효과에 대한 오해의 소지가 있는 상품은 후기를 게시하지 않습니다.</p>
						</div>

						<h3 class="tMar40 fs11 fn">전체 (<strong><%=formatNumber(oEval.FTotalCount,0)%></strong>)</h3>
						<table class="healthReview tMar05">
						<caption>상품후기 목록</caption>
						<colgroup>
							<col width="20%" /><col width="20%" /><col width="20%" /><col width="20%" /><col width="" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">기능</th>
							<th scope="col">디자인</th>
							<th scope="col">가격</th>
							<th scope="col">만족도</th>
							<th scope="col">작성일자 및 작성자</th>
						</tr>
						</thead>
						<tbody>
						<% for i = 0 to oEval.FResultCount - 1 %>
						<tr>
							<td><p>기능</p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_fun%>.png" alt="별<%=oEval.FItemList(i).FPoint_fun%>개" /></td>
							<td><p>디자인</p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_dgn%>.png" alt="별<%=oEval.FItemList(i).FPoint_dgn%>개" /></td>
							<td><p>가격</p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_prc%>.png" alt="별<%=oEval.FItemList(i).FPoint_prc%>개" /></td>
							<td><p>만족도</p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_stf%>.png" alt="별<%=oEval.FItemList(i).FPoint_stf%>개" /></td>
							<td class="ct">
								<div><%= FormatDate(oEval.FItemList(i).FRegdate,"0000/00/00") %></div>
								<div><%= printUserId(oEval.FItemList(i).FUserID,2,"*") %></div>
								<p class="badgeView tPad01"><%=getUserBadgeIcon(oEval.FItemList(i).FUserID,bdgUid,bdgBno,3)%></p>
							</td>
						</tr>
						<% next %>
						</tbody>
						</table>
					<% end if %>

					<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(oEval.FCurrpage,oEval.FTotalCount,oEval.FPageSize,10,"TnMovePage") %></div>
				<% else %>
					<table class="talkList">
					<tbody>
					<tr>
						<td class="noData" style="text-align:center;padding:55px 0 35px 0;"><strong>등록된 상품 후기가 없습니다</strong></td>
					</tr>
					</tbody>
					</table>
				<% end if %>
				</div>
				<!-- //content -->
			</div>
		<!-- // 본문 끝 //-->
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%
	set oEval = nothing
	set oEvalCnt = nothing
	set oItem = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->