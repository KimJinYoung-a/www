<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.Buffer = True
%>
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<%
    '' 2차서버로 변경 2014/09/30 dbopen.asp => dbCTopen.asp, dbclose.asp =>dbCTclose.asp, fnPopularList => fnPopularList_CT
	Dim cPopular, vDisp, vSort, vCurrPage, i, j, vArrEval
	vDisp = RequestCheckVar(Request("disp"),18)
	vSort = NullFillWith(RequestCheckVar(Request("sort"),1),"1")
	vCurrPage = RequestCheckVar(Request("cpg"),5)
	
	If vCurrPage = "" Then vCurrPage = 1
	

	SET cPopular = New CMyFavorite
	cPopular.FPageSize = 24
	cPopular.FCurrpage = vCurrPage
	cPopular.FRectDisp = vDisp
	cPopular.FRectSortMethod = vSort
	cPopular.FRectUserID = GetLoginUserID()
	cPopular.fnPopularList_CT
%>

<% If (cPopular.FResultCount > 0) Then %>
	<% If vCurrPage > 70 Then %>
		<script>$("#popwishnodata").show();</script>
	<% Else %>
			<% For i = 0 To cPopular.FResultCount-1 %>
			<div class="box">
				<div class="time"><strong><%= cPopular.FItemList(i).FRegTime %></strong></div>
				<div class="info" onClick="window.open('/shopping/category_prd.asp?itemid=<%= cPopular.FItemList(i).FItemID %>&pEtr=85144','','width=1200,height=800,toolbar=yes, location=yes, directories=yes, status=yes, menubar=yes, scrollbars=yes, copyhistory=yes, resizable=yes');">
					<div><img src="<%= cPopular.FItemList(i).FImageBasic %>" width="250" height="250" alt="<%= cPopular.FItemList(i).FItemName %>" /></div>
					<div class="account">
						<strong class="name"><%= cPopular.FItemList(i).FBrandName %></strong>
						<span><%= cPopular.FItemList(i).FItemName %></span>
						<%
							If cPopular.FItemList(i).IsSaleItem AND cPopular.FItemList(i).isCouponItem Then
								Response.Write "<strong>" & FormatNumber(cPopular.FItemList(i).getRealPrice,0) & "원 [" & cPopular.FItemList(i).getSalePro & "]</strong>" &  vbCrLf
							ElseIf cPopular.FItemList(i).IsSaleItem Then
								Response.Write "<strong>" & FormatNumber(cPopular.FItemList(i).getRealPrice,0) & "원 [" & cPopular.FItemList(i).getSalePro & "]</strong>" &  vbCrLf
							ElseIf cPopular.FItemList(i).isCouponItem Then
								Response.Write "<strong>" & FormatNumber(cPopular.FItemList(i).GetCouponAssignPrice,0) & "원 [" & cPopular.FItemList(i).GetCouponDiscountStr & "]</strong>" &  vbCrLf
							Else
								Response.Write "<strong>" & FormatNumber(cPopular.FItemList(i).getRealPrice,0) & "원</strong>" &  vbCrLf
							End If
						%>
					</div>
				</div>
				<div class="count">
					<ul>
						<li class="postView"><p onclick="javascript:popEvaluate('<%= cPopular.FItemList(i).FItemID %>');"><span><%= FormatNumber(cPopular.FItemList(i).FEvalCnt,0) %></span></p></li>
						<li class="wishView <%=CHKIIF(cPopular.FItemList(i).FMyCount>0,"myWishOn","")%>"><p onclick="javascript:TnAddFavorite('<%= cPopular.FItemList(i).FItemID %>');"><span><%= FormatNumber(cPopular.FItemList(i).FFavCount,0) %></span></p></li>
					</ul>
				</div>
				<%
				vArrEval = cPopular.FItemList(i).FEvaluate
				If vArrEval <> "" Then
					
					'//상품고시관련 상품후기 제외 상품이 아닐경우
					if cPopular.FItemList(i).fEval_excludeyn="N" then
				%>
						<div class="comment">
							<ul>
							<%
							For j = LBound(Split(vArrEval,"|^|")) To UBound(Split(vArrEval,"|^|"))
								On Error Resume Next		'간혹 후기 내용이 NULL일 경우 구분값의 짝이 안맞는 Case가 있음 > DB 프로시저에서도 isNull 처리 완료(20150415; 허진원)
								Response.Write "<li><strong>" & printUserId(Split(Split(vArrEval,"|^|")(j),	"|*|")(0),2,"*") & "</strong><span>" & chrbyte(db2html(Split(Split(vArrEval,"|^|")(j),"|*|")(1)),60,"Y") & "</span></li>" & vbCrLf
								On Error Goto 0
							Next
							%>
							</ul>
						</div>
					<%
					'//상품고시관련 상품후기 제외 상품일경우
					else
					%>
						<div class="comment healthReview">
							<ul>
								<%
									For j = LBound(Split(vArrEval,"|^|")) To UBound(Split(vArrEval,"|^|"))
										On Error Resume Next
								%>
								<li>
									<strong><%= printUserId(Split(Split(vArrEval,"|^|")(j),	"|*|")(0),2,"*") %></strong>
									<span><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%= Split(Split(vArrEval,"|^|")(j),	"|*|")(2) %>.png" alt="별<%= Split(Split(vArrEval,"|^|")(j),	"|*|")(2) %>개"></span>
								</li>
								<%
										On Error Goto 0
									next
								%>
							</ul>
						</div>
					<% End If %>
				<% End If %>
			</div>
			<% Next %>
	<% End If %>
<%
Else
%>
<script>$("#popwishnodata").show();</script>
<%
End If
SET cPopular = Nothing
%>

<!-- #include virtual="/lib/db/dbCTclose.asp" -->