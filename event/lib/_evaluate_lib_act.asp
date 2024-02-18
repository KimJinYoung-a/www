<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<%
response.Charset="UTF-8" 
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoriteEventCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%

dim eCode, oEval,ix, intEval, oEvPhoto, vCurrPage, sortMethod
eCode = RequestCheckVar(request("ecode"),10)
vCurrPage = RequestCheckVar(request("page"),5)
sortMethod = RequestCheckVar(request("sortMtd"),2)

if sortMethod="" or sortMethod="un" then sortMethod="ne"

If eCode = "" Then
	dbget.close()
	Response.End
End If
If isNumeric(eCode) = False Then
	dbget.close()
	Response.End
End If

If vCurrPage = "" Then
	dbget.close()
	Response.End
End If
If isNumeric(vCurrPage) = False Then
	dbget.close()
	Response.End
End If

set oEval = new CEvaluateSearcher

oEval.FPageSize = 5
oEval.FCurrpage = vCurrPage
oEval.FECode = eCode
oEval.FsortMethod = sortMethod
oEval.GetTopEventGoodUsingList_B
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
<%
	if oEval.FResultCount > 0 then
		'사용자 아이디 모음 생성(for Badge)
		dim arrUserid, bdgUid, bdgBno, i
		for i = 0 to oEval.FResultCount -1
			arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oEval.FItemList(i).FUserID) & "''"
		next
		
		'뱃지 목록 접수(순서 랜덤)
		Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")

		for i = 0 to oEval.FResultCount - 1
%>
		<tr>
			<td><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(i).FTotalPoint%>.png" alt="별<%=oEval.FItemList(i).FTotalPoint%>개" /></td>
			<td class="lt"><a href="javascript:" class="talkShort"><%= chkiif(eva_db2html(oEval.FItemList(i).getUsingTitle(50))="",oEval.FItemList(i).FItemname,eva_db2html(oEval.FItemList(i).getUsingTitle(50))) %><% if oEval.FItemList(i).IsPhotoExist then %> <img src="//fiximage.10x10.co.kr/web2013/common/ico_photo.gif" alt="포토" /></a></td><% End If %>
			<td><%= FormatDate(oEval.FItemList(i).FRegdate,"0000/00/00") %></td>
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
						<% if Not(oEval.FItemList(i).FItemname="" or isNull(oEval.FItemList(i).FItemname)) then %>
						<h4><%=oEval.FItemList(i).FItemname%></h4>
						<% end if %>
						<% if Not(oEval.FItemList(i).FOptionName="" or isNull(oEval.FItemList(i).FOptionName)) then %>
						<div class="purchaseOption"><em>· 옵션 : <%=oEval.FItemList(i).FOptionName%></em></div>
						<% end if %>
						<div class="textArea"><p><% = eva_db2html(nl2br(oEval.FItemList(i).FUesdContents)) %></p></div>
						<% if oEval.FItemList(i).Flinkimg1<>"" then %>
						<div class="imgArea"><img src="<%= oEval.FItemList(i).getLinkImage1 %>" alt="file1<% = i %>" /></div>
						<% end if %>
						<% if oEval.FItemList(i).Flinkimg2<>"" then %>
						<div class="imgArea"><img src="<%= oEval.FItemList(i).getLinkImage2 %>" alt="file2<% = i %>" /></div>
						<% end if %>
						<% If GetLoginUserID = oEval.FItemList(i).FUserID Then %>
						<div class="btnArea"><a href="my10x10/goodsusing.asp?EvaluatedYN=Y" class="btn btnS2 btnGry2"><span class="fn">수정</span></a></div>
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

<% if oEval.FResultCount > 0 then %>
<div class="pageWrapV15 tMar20">
<%= fnDisplayPaging_New(oEval.FCurrpage,oEval.FTotalCount,oEval.FPageSize,10,"fnChgEvalMove") %>
</div>
<% end if %>
<%
set oEval = Nothing

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