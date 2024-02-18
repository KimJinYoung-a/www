<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
%>
<%
'#######################################################
'	History	:  2012.03.26 허진원
'              2015.03.31 허진원; 2015리뉴얼, UTF8 변환
'	Description : 상품후기 보기 Ajax 치환 내용
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
	dim itemid,i,page,sortMethod,ix, itemoption
	dim oEval, EvalDiv

	itemid = RequestCheckVar(request("itemid"),10)
	page = RequestCheckVar(request("page"),10)
	sortMethod = RequestCheckVar(request("sortMtd"),2)
	itemoption = RequestCheckVar(request("itemoption"),4)
	EvalDiv=RequestCheckVar(request("evaldiv"),1)

	if itemid="" then itemid=0
	if page="" then page=1
	if sortMethod="" or sortMethod="un" then sortMethod="ne"

    '==================== 상품코드 정확성체크 및 상품관련내용 ==================
    if itemid="" or itemid="0" then
	    Call Alert_Return("상품번호가 없습니다.")
	    response.End
    elseif Not(isNumeric(itemid)) then
	    Call Alert_Return("잘못된 상품번호입니다.")
	    response.End
    else	'정수형태로 변환
	    itemid=CLng(getNumeric(itemid))
    end if

    if itemid=0 then
	    Call Alert_Return("잘못된 상품번호입니다.")
	    response.End
    end if

    '============================= 페이지 정확성체크 ===========================
    if page="" or page="0" then
	    Call Alert_Return("잘못된 접속입니다.")
	    response.End
    elseif Not(isNumeric(page)) then
	    Call Alert_Return("잘못된 접속입니다.")
	    response.End
    else	'정수형태로 변환
	    page=CLng(getNumeric(page))
    end if

	set oEval = new CEvaluateSearcher

	oEval.FPageSize = 5
	oEval.FCurrpage = page
	oEval.FRectItemID = itemid
	oEval.FsortMethod = sortMethod
	oEval.FEvalDiv = EvalDiv
	if itemoption<>"" then oEval.FRectOption = itemoption

	oEval.getItemEvalList

dim arrUserid, bdgUid, bdgBno

'/상품고시관련 상품후기 제외 상품
dim Eval_excludeyn : Eval_excludeyn="N"
	Eval_excludeyn=getEvaluate_exclude_Itemyn(itemid)

'//상품고시관련 상품후기 제외 상품이 아닐경우
if Eval_excludeyn="N" then
%>
	<table class="talkList">
	<caption>상품후기 목록</caption>
	<colgroup>
		<col width="140" /><col width="" /><col width="90" /><col width="120" /><col width="95" />
	</colgroup>
	<thead>
	<tr>
		<th scope="col">평점</th>
		<th scope="col">내용</th>
		<th scope="col">작성일자</th>
		<th scope="col">작성자</th>
		<th scope="col">뱃지</th>
	</tr>
	</thead>
	<tbody>
	<% if oEval.FResultCount > 0 then %>
		<%
		'사용자 아이디 모음 생성(for Badge)
		for i = 0 to oEval.FResultCount -1
			arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oEval.FItemList(i).FUserID) & "''"
		next

		'뱃지 목록 접수(순서 랜덤)
		Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")

		for i = 0 to oEval.FResultCount - 1
		%>
			<tr>
				<td><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FTotalPoint%>.png" alt="별<%=oEval.FItemList(i).FTotalPoint%>개" /></td>
				<td class="lt">
					<% if Not(oEval.FItemList(i).FOptionName="" or isNull(oEval.FItemList(i).FOptionName)) then %>
					<p class="purchaseOption talkShort">구매옵션 : <%=oEval.FItemList(i).FOptionName%></p>
					<% end if %>
					<a href="" onclick="return false;" class="talkShort"><%= eva_db2html(oEval.FItemList(i).getUsingTitle(50)) %><% if oEval.FItemList(i).IsPhotoExist then %> <img src="http://fiximage.10x10.co.kr/web2013/common/ico_photo.gif" alt="포토" /><% End If %></a>
				</td>
				<td><%= FormatDate(oEval.FItemList(i).FRegdate,"0000/00/00") %><% If oEval.FItemList(i).FShopName<>"" Then %> <p class="offshop cMt0V15"><% = oEval.FItemList(i).FShopName %></p><% End If %></td>
				<td><%= printUserId(oEval.FItemList(i).FUserID,2,"*") %></td>
				<td>
					<p class="badgeView tPad01"><%=getUserBadgeIcon(oEval.FItemList(i).FUserID,bdgUid,bdgBno,3)%></p>
				</td>
			</tr>
			<tr class="talkMore">
				<td colspan="5">
					<div class="customerReview">
						<div class="rating">
							<ul>
								<li><span>기능</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_fun%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_fun%>개" /></li>
								<li><span>디자인</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_dgn%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_dgn%>개" /></li>
								<li><span>가격</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_prc%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_prc%>개" /></li>
								<li><span>만족도</span> <img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FPoint_stf%>.png" class="pngFix" alt="별<%=oEval.FItemList(i).FPoint_stf%>개" /></li>
							</ul>
						</div>
						<div class="comment">
							<% if Not(oEval.FItemList(i).FOptionName="" or isNull(oEval.FItemList(i).FOptionName)) then %>
							<div class="purchaseOption"><em><strong>구매옵션</strong> : <%=oEval.FItemList(i).FOptionName%></em></div>
							<% end if %>
							<div class="textArea"><p><% = eva_db2html(nl2br(oEval.FItemList(i).FUesdContents)) %></p></div>
							<% if oEval.FItemList(i).Flinkimg1<>"" then %>
							<div class="imgArea"><img src="<%= oEval.FItemList(i).getLinkImage1 %>" alt="file1<% = i %>" /></div>
							<% end if %>
							<% if oEval.FItemList(i).Flinkimg2<>"" then %>
							<div class="imgArea"><img src="<%= oEval.FItemList(i).getLinkImage2 %>" alt="file2<% = i %>" /></div>
							<% end if %>
							<% if oEval.FItemList(i).Flinkimg3<>"" then %>
							<div class="imgArea"><img src="<%= oEval.FItemList(i).getLinkImage3 %>" alt="file3<% = i %>" /></div>
							<% end if %>
							<% If GetLoginUserID = oEval.FItemList(i).FUserID Then %>
							<div class="btnArea"><a href="/my10x10/goodsusing.asp?EvaluatedYN=Y" class="btn btnS2 btnGry2"><span class="fn">수정</span></a></div>
							<% End If %>
						</div>
					</div>
				</td>
			</tr>
		<% Next %>
	<% else %>
	<tr>
		<td colspan="5" class="noData"><strong>등록된 상품 후기가 없습니다</strong></td>
	</tr>
	<% end if %>
	</tbody>
	</table>
<% end if %>

<% if oEval.FResultCount > 0 then %>
<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(oEval.FCurrpage,oEval.FTotalCount,oEval.FPageSize,10,"fnChgEvalMove") %></div>
<% end if %>
<%
Set oEval = Nothing
function eva_db2html(checkvalue)
	dim v
	v = checkvalue
	if Isnull(v) then Exit function

    On Error resume Next
    v = replace(v, "&amp;", "&")
    v = replace(v, "&lt;", "<")
    v = replace(v, "&gt;", ">")
    v = replace(v, "&quot;", "'")
    v = Replace(v, "", "<br />")
    v = Replace(v, "\0x5C", "\")
    v = Replace(v, "\0x22", "'")
    v = Replace(v, "\0x25", "'")
    v = Replace(v, "\0x27", "%")
    v = Replace(v, "\0x2F", "/")
    v = Replace(v, "\0x5F", "_")
	'v = Replace(v, "><!", "&gt;&lt;!")
	v = Replace(v, ">", "&gt;")
	v = Replace(v, "<", "&lt;")
	v = Replace(v, "&lt;br&gt;", "<br>")
	v = Replace(v, "&lt;br/&gt;", "<br/>")
	v = Replace(v, "&lt;br /&gt;", "<br />")

    eva_db2html = v
end function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
