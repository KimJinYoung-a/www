<%@ codepage="65001" language="VBScript" %>
<% option Explicit 
Response.CharSet = "UTF-8"
%>
<%
'#######################################################
'	Description : 상품후기 전체보기
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 상품후기 보기"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
dim itemid,i,page,sortMethod,ix, itemoption
dim oEval,j,oEvalCnt
dim cookieuserid, arrUserid, bdgUid, bdgBno

itemid = getNumeric(RequestCheckVar(request("itemid"),10))
itemoption = RequestCheckVar(request("itemoption"),4)
page = getNumeric(RequestCheckVar(request("page"),10))
sortMethod = RequestCheckVar(request("sortMtd"),2)

If sortMethod=""  then
sortMethod = RequestCheckVar(request("sortMethod"),2)
End If 

if sortMethod="" or sortMethod="un" then sortMethod="ne"

if itemid="" then itemid=0
if page="" then page=1


cookieuserid = GetLoginUserID

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
else
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
		document.frm.sortMethod.value = "ph";
		TnMovePage(1);
	} else if (md=="t"){
		document.frm.sortMtd.value = "";
		document.frm.sortMethod.value = "tt";
		TnMovePage(1);
	} else {
		document.frm.sortMethod.value = "ne";
		TnMovePage(1);
	}
}
$(function(){
	<% if sortMethod = "ne" or  sortMethod = "be" or   sortMethod = "" then %>
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
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
		<!-- // 본문 시작 //-->
			<div class="popHeader">
				<h1><img src="//fiximage.10x10.co.kr/web2013/my10x10/tit_product_review.gif" alt="상품후기" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="popReview">
					<div class="titleArea">
						<h2>상품명 : <strong><%=oEvalCnt.FEvalItem.FItemname%></strong></h2>
						<span>Total : <%=formatNumber(oEvalCnt.FEvalItem.FEvalCnt,0)%></span>
					</div>

					<%
					'//상품고시관련 상품후기 제외 상품일 경우
					if Eval_excludeyn="Y" then
					%>
						<p class="bPad10" style="margin-top:-4px;">* 본 상품은 건강식품 및 의료기기에 해당되는 상품으로 고객 상품평 이용이 제한됩니다</p>
					<% end if %>
					
					<div class="sorting">
					<form name="frm" method="GET" action="">
					<input type="hidden" name="itemid" value="<%=itemid%>">
					<input type="hidden" name="page" value="<%=page%>">
					<input type="hidden" name="sortMethod" value="<%=sortMethod%>">
						<ul class="tabMenu">
							<li><a href="#" <%=chkiif(sortMethod="" or sortMethod="ne" or sortMethod="be","class=""on""","")%> onclick="chgEvalVal('a');return false;">전체 (<strong><%=formatNumber(oEvalCnt.FEvalItem.FEvalCnt,0)%></strong>)</a></li>
							
							<%
							'//상품고시관련 상품후기 제외 상품이 아닐경우
							if Eval_excludeyn="N" then
							%>							
								<% if oEvalCnt.FEvalItem.FEvalcnt_photo>0 then %>
									<li><a href="#" <%=chkiif(sortMethod="ph","class=""on""","")%> onclick="chgEvalVal('p');return false;">포토 후기 (<strong><%=formatNumber(oEvalCnt.FEvalItem.FEvalcnt_photo,0)%></strong>)</a></li>
								<% end if %>
							<% end if %>
							
							<% if oEvalCnt.FEvalItem.FEvalcnt_tester>0 then %>
								<li><a href="#" <%=chkiif(sortMethod="tt","class=""on""","")%> onclick="chgEvalVal('t');return false;">테스터 후기 (<strong><%=formatNumber(oEvalCnt.FEvalItem.FEvalcnt_tester,0)%></strong>)</a></li>
							<% end if %>
						</ul>

						<div class="option">
							<%=getItemEvalOptSelectbox("itemoption",itemoption,itemid,"title=""상품옵션 선택"" class=""optSelect2"" onchange=""TnMovePage(1)""")%>

							<% if sortMethod="" or sortMethod="ne" or sortMethod="be" then %>
							<select name="sortMtd" title="상품 후기 정렬" class="optSelect2" onchange="TnMovePage(1)">
								<option value="ne" <%=chkiif(sortMethod="ne","selected","")%>>최신후기순</option>
								<option value="be" <%=chkiif(sortMethod="be","selected","")%>>우수상품후기순</option>
							</select>
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
										<li><span>상품평</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FTotalPoint%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FTotalPoint%>개" /></li>
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
										<b><u>아쉬운 점</u></b><br/>
										<% = nl2br(oEval.FItemList(i).FUseETC) %>
									</p>
								</div>
								<div class="imgArea">
									<% if oEval.FItemList(i).Flinkimg1<>"" then %>
									<img src="<%= oEval.FItemList(i).Flinkimg1 %>" style="cursor:pointer;" onclick="popShowImg('<%= oEval.FItemList(i).Flinkimg1 %>');"><br/ >
									<% end if %>
									<% if oEval.FItemList(i).Flinkimg2<>"" then %>
									<img src="<% = oEval.FItemList(i).Flinkimg2 %>" style="cursor:pointer;" onclick="popShowImg('<%= oEval.FItemList(i).Flinkimg2 %>');"><br/ >
									<% end if %>
									<% if oEval.FItemList(i).Flinkimg3<>"" then %>
									<img src="<% = oEval.FItemList(i).Flinkimg3 %>" style="cursor:pointer;" onclick="popShowImg('<%= oEval.FItemList(i).Flinkimg3 %>');">
									<% end if %>
								</div>
							<% else %><!-- 상품후기 -->
								<% if Not(oEval.FItemList(i).FOptionName="" or isNull(oEval.FItemList(i).FOptionName)) then %>
								<div class="purchaseOption"><em>[ 구매옵션 : <%=oEval.FItemList(i).FOptionName%> ]</em></div>
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
						<table class="talkList healthReview">
						<caption>상품후기 목록</caption>
						<colgroup>
							<col width="*" /> <col width="135" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">평점</th>
							<th scope="col">작성일자 및 작성자</th>
						</tr>
						</thead>
						<tbody>
						<% for i = 0 to oEval.FResultCount - 1 %>
						<tr>
							<td>
								<div class="rating">
									<ul>
										<li><span>기능</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_fun%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_fun%>개" /></li>
										<li><span>디자인</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_dgn%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_dgn%>개" /></li>
										<li><span>가격</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_prc%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_prc%>개" /></li>
										<li><span>만족도</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_stf%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_stf%>개" /></li>
									</ul>
								</div>
								<!--<div class="imgArea"></div>-->
							</td>
							<td class="ct">
								<div><%= FormatDate(oEval.FItemList(i).FRegdate,"0000/00/00") %></div>
								<div><%= printUserId(oEval.FItemList(i).FUserID,2,"*") %></div>
							</td>
						</tr>
						<% next %>
						</tbody>
						</table>
					<% end if %>
					
					<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(oEval.FCurrpage,oEval.FTotalCount,oEval.FPageSize,10,"TnMovePage") %></div>
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
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->