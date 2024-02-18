<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
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
<%
strPageTitle = "텐바이텐 10X10 : 전체 상품후기"

dim eCode, oEval,ix, intEval, oEvPhoto, vCurrPage, sortMethod, ename
eCode = RequestCheckVar(request("eventid"),10)
vCurrPage = RequestCheckVar(request("page"),5)
sortMethod = RequestCheckVar(request("sortMtd"),2)

'//logparam
Dim logparam : logparam = "&pEtr="&eCode

if sortMethod="" or sortMethod="un" then sortMethod="ne"
if vCurrPage=""  then vCurrPage="1"

If eCode = "" Then
	dbget.close()
	Response.End
End If
If isNumeric(eCode) = False Then
	dbget.close()
	Response.End
End If

rsget.Open "select evt_name from db_event.dbo.tbl_event where evt_code = '" & eCode & "'",dbget,1
if not rsget.eof then
ename = db2html(rsget("evt_name"))
end if
rsget.Close

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
oEval.GetTopEventGoodUsingList
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script>
<!--
function fnChgEvalMove(pg) {
	frm1.page.value = pg;
	frm1.submit();
}
-->
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="//fiximage.10x10.co.kr/web2013/my10x10/tit_product_review_all.gif" alt="전체 상품후기" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="popReview">
					<div class="titleArea">
						<h2>이벤트명 : <strong><%=ename%></strong></h2>
						<span>Total : <%= oEval.FTotalCount %></span>
					</div>

					<form name="frm1" method="get" action="">
					<input type="hidden" name="eventid" value="<%=eCode%>">
					<input type="hidden" name="page" value="">
					<div class="overHidden rt bPad05">
						<div class="option">
							<select name="sortMtd" title="상품 후기 정렬 옵션" class="optSelect2" onchange="fnChgEvalMove(1);">
								<option value="ne" <%=CHKIIF(sortMethod="ne","selected","")%>>최신후기순</option>
								<option value="be" <%=CHKIIF(sortMethod="be","selected","")%>>우수상품후기순</option>
							</select>
						</div>
					</div>
					</form>

					<div class="myItemList tBdr3 tMar04">
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
							<div class="myItem">
								<div class="pdfInfo lMar0">
									<div class="pdtPhoto"><img src="<%=oEval.FItemList(i).FImageList120%>" width="120" height="120" alt="" /></div>
									<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oEval.FItemList(i).FMakerID%>" target="_blank"><%=oEval.FItemList(i).FMakerName%></a></p>
									<p class="pdtName tPad10"><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(i).FItemID%><%=logparam%>" target="_blank"><%=oEval.FItemList(i).FItemname%></a></p>
								</div>
								<div class="reviewInfo">
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
										<div class="purchaseOption"><em>[ 구매옵션 : <%=oEval.FItemList(i).FOptionName%>]</em></div>
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
							</div>
							<% Next %>
						<% else %>
						<p class="noData"><strong>등록하신 상품후기가 없습니다.</strong></p>
						<% end if %>
					</div>

					<% if oEval.FResultCount > 0 then %>
					<div class="pageWrapV15 tMar20">
					<%= fnDisplayPaging_New_nottextboxdirect(oEval.FCurrpage,oEval.FTotalCount,oEval.FPageSize,10,"fnChgEvalMove") %>
					</div>
					<% end if %>

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