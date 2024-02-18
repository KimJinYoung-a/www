<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'###########################################################
' Description :  기프트
' History : 2015.02.09 유태욱 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/gift/giftCls.asp" -->
<!-- #include virtual="/gift/Underconstruction_gift.asp" -->
<%
	Dim vNowItemCnt, vNowItemId, vItemID, vViewItemID
	vNowItemCnt = requestCheckVar(Request("nowcnt"),1)
	vNowItemId	= requestCheckVar(Request("nowitem"),20)
	vItemID		= requestCheckVar(Request("itemid"),7)

'vNowItemCnt = "1"
'vNowItemId = ",333333,"
'vItemID = "222222"

'	If vNowItemCnt = "" Then
'		dbget.close()
'		Response.End
'	End IF

'	If isNumeric(vNowItemCnt) = False Then
'		dbget.close()
'		Response.End
'	End IF

'	If vItemID = "" Then
'		dbget.close()
'		Response.End
'	End IF

'	If isNumeric(vItemID) = False Then
'		dbget.close()
'		Response.End
'	End IF

	If vNowItemCnt = "2" Then	'### 2개 선택되 있을때. 2개까지만 선택할 수 있으므로 그냥 1개로 만들면됨.
		vViewItemID = Replace(vNowItemId, ","&vItemID&",", ",")
		vViewItemID = fnItemIDSetting(vViewItemID)
	ElseIf vNowItemCnt = "1" Then	'### 1개 선택되 있을때.
		If vNowItemId = ","&vItemID&"," Then	'### 선택되 있는거랑 선택한게 같을때는 삭제.
			Response.Write ""
			dbget.close()
			Response.End
		Else	'### 선택되 있는거랑 선택한게 다를때는 추가.
			vViewItemID = vNowItemId & vItemID & ","
			vViewItemID = fnItemIDSetting(vViewItemID)
		End If
	ElseIf vNowItemCnt = "0" Then	'### 아무것도 선택되 있지 않을때.
		If vNowItemId = "," Then
			vViewItemID = vItemID
		Else
			Response.Write ""
			dbget.close()
			Response.End
		End If
	Else
'		Response.Write ""
'		dbget.close()
'		Response.End
	End If

	Dim cTalk, vArr
	SET cTalk = New CGiftTalk
	cTalk.FRectItemId = vViewItemID
	cTalk.fnGiftTalkItemAjaxList()
%>
<% If Request("ismodify") <> "o" Then %>
	<script type="text/javascript">
		$(function(){
			$("#field .caseB").append("<div class='line'></div>");
			$("#field .caseC").append("<div class='line'></div>");
	});
	</script>
<% End if %>
<%
if vViewItemID <> "" then
	If vNowItemCnt = "0" OR vNowItemCnt = "2" then
		IF cTalk.FResultCount > 0 then
%>
		<div class="add caseB">
			<div class="item">
				<div class="pdtBox">
					<img src="<%=cTalk.FItemList(0).FImageIcon1%>" width="200" height="200" alt="<%=cTalk.FItemList(0).FItemName%>" />
					<div class="pdtInfo">
						<p class="pdtBrand"><%=cTalk.FItemList(0).FBrandName%></p>
						<p class="pdtName tPad07"><%=cTalk.FItemList(0).FItemName%></p>
						<%
							If cTalk.FItemList(0).IsSaleItem or cTalk.FItemList(0).isCouponItem Then
								If cTalk.FItemList(0).Fitemcoupontype <> "3" Then
									Response.Write "<p class='pdtPrice tPad10'><span class='txtML'>" & FormatNumber(cTalk.FItemList(0).FOrgPrice,0) & "원 </span></p>"
								End If
								IF cTalk.FItemList(0).IsSaleItem Then
									Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(cTalk.FItemList(0).getRealPrice,0) & "원 </span>"
									Response.Write " <strong class='crRed'>[" & cTalk.FItemList(0).getSalePro & "]</strong></p>"
						 		End IF
						 		IF cTalk.FItemList(0).IsCouponItem Then
									Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(cTalk.FItemList(0).GetCouponAssignPrice,0) & "원 </span>"
									Response.Write " <strong class='crGrn'>[" & cTalk.FItemList(0).GetCouponDiscountStr & "]</strong></p>"
						 		End IF
							Else
								Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(cTalk.FItemList(0).getRealPrice,0) & "원 </span>"
							End If
						%>
					</div>
					<% If Request("ismodify") <> "o" Then %>
						<button type="button" class="btnDel" onClick="jsTalkSelectItem('<%= cTalk.FItemList(0).FItemID %>');">삭제</button>
					<% End If %>
				</div>
			</div>
			<% If Request("ismodify") <> "o" Then %>
			<div class="item">
				<p class="note"><span></span>상품을 하나 더 추가하시면<br /> 두가지 상품의 비교투표가 가능합니다!</p>
			</div>
			<% End if %>
			<div class="vote">
				<div class="button"><span><strong>찬성</strong> <em>0</em></span></div>
				<div class="button"><span><strong>반대</strong> <em>0</em></span></div>
			</div>
		</div>
<%
		End If
	ElseIf vNowItemCnt = "1" Then
		Dim a, b
		a = cTalk.F1Item
		b = cTalk.F2Item
%>
		<div class="add caseC">
			<div class="item">
				<div class="pdtBox">
					<img src="<%=cTalk.FItemList(a).FImageIcon1%>" width="200" height="200" alt="<%=cTalk.FItemList(a).FItemName%>" />
					<div class="pdtInfo">
						<p class="pdtBrand"><%=cTalk.FItemList(a).FBrandName%></p>
						<p class="pdtName tPad07"><%=cTalk.FItemList(a).FItemName%></p>
						<%
							If cTalk.FItemList(a).IsSaleItem or cTalk.FItemList(a).isCouponItem Then
								If cTalk.FItemList(a).Fitemcoupontype <> "3" Then
									Response.Write "<p class='pdtPrice tPad10'><span class='txtML'>" & FormatNumber(cTalk.FItemList(a).FOrgPrice,0) & "원 </span></p>"
								End If
								IF cTalk.FItemList(a).IsSaleItem Then
									Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(cTalk.FItemList(a).getRealPrice,0) & "원 </span>"
									Response.Write " <strong class='crRed'>[" & cTalk.FItemList(a).getSalePro & "]</strong></p>"
						 		End IF
						 		IF cTalk.FItemList(a).IsCouponItem Then
									Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(cTalk.FItemList(a).GetCouponAssignPrice,0) & "원 </span>"
									Response.Write " <strong class='crGrn'>[" & cTalk.FItemList(a).GetCouponDiscountStr & "]</strong></p>"
						 		End IF
							Else
								Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(cTalk.FItemList(a).getRealPrice,0) & "원 </span>"
							End If
						%>
					</div>
					<% If Request("ismodify") <> "o" Then %>
						<button type="button" class="btnDel" onClick="jsTalkSelectItem('<%= cTalk.FItemList(a).FItemID %>');">삭제</button>
					<% End If %>
				</div>
			</div>
			<div class="item">
				<div class="pdtBox">
					<img src="<%=cTalk.FItemList(b).FImageIcon1%>" width="200" height="200" alt="<%=cTalk.FItemList(b).FItemName%>" />
					<div class="pdtInfo">
						<p class="pdtBrand"><%=cTalk.FItemList(b).FBrandName%></p>
						<p class="pdtName tPad07"><%=cTalk.FItemList(b).FItemName%></p>
						<%
							If cTalk.FItemList(b).IsSaleItem or cTalk.FItemList(b).isCouponItem Then
								If cTalk.FItemList(b).Fitemcoupontype <> "3" Then
									Response.Write "<p class='pdtPrice tPad10'><span class='txtML'>" & FormatNumber(cTalk.FItemList(b).FOrgPrice,0) & "원 </span></p>"
								End If
								IF cTalk.FItemList(b).IsSaleItem Then
									Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(cTalk.FItemList(b).getRealPrice,0) & "원 </span>"
									Response.Write " <strong class='crRed'>[" & cTalk.FItemList(b).getSalePro & "]</strong></p>"
						 		End IF
						 		IF cTalk.FItemList(b).IsCouponItem Then
									Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(cTalk.FItemList(b).GetCouponAssignPrice,0) & "원 </span>"
									Response.Write " <strong class='crGrn'>[" & cTalk.FItemList(b).GetCouponDiscountStr & "]</strong></p>"
						 		End IF
							Else
								Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(cTalk.FItemList(b).getRealPrice,0) & "원 </span>"
							End If
						%>
					</div>
					<% If Request("ismodify") <> "o" Then %>
						<button type="button" class="btnDel" onClick="jsTalkSelectItem('<%= cTalk.FItemList(b).FItemID %>');">삭제</button>
					<% End if %>
				</div>
			</div>
			<div class="vote">
				<div class="button"><span><strong>A 선택</strong> <em>0</em></span></div>
				<div class="button"><span><strong>B 선택</strong> <em>0</em></span></div>
			</div>
		</div>
<%
	End If
else
%>
	<div class="add caseA">
		<div class="item">
			<p class="findGoods">빠른 상품 찾기에서<br /> 원하는 상품을 선택해주세요!</p>
		</div>
	</div>
<%
	SET cTalk = Nothing
end if
%>

<%
Function fnItemIDSetting(vNowItemId)
	If Len(vNowItemId) > 1 Then
		If Left(vNowItemId,1) = "," Then
			vNowItemId = Right(vNowItemId,Len(vNowItemId)-1)
		End If
		If Right(vNowItemId,1) = "," Then
			vNowItemId = Left(vNowItemId,Len(vNowItemId)-1)
		End If
	Else
		If vNowItemId = "," Then vNowItemId = "" End If
	End If
	fnItemIDSetting = vNowItemId
End Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->