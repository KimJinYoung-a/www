<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
Response.Expires = -1
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cahce"
Response.AddHeader "cache-Control", "no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/designfingers/designfingersCls.asp" -->
<!-- #include virtual="/lib/classes/designfingers/dfCommentCls.asp" -->


<%
Dim clsDF
Dim iDFSeq,sTitle,txtContents,dPrizeDate, sCommentTxt, sDFType, sTopImgURL
Dim arrImg3dv, arrImgAdd, arrWinner, intLoop, iWishListCurrentPage
Dim i, k, iListCurrentPage, iTotCnt, arrMainList, arrCateList, arrRecentComm, arrMain, arrMainWishList, iTotWishCnt
Dim iRecentDFS, sRecentImgURL, sRecentTitle, iCate, sSort, sSearchTxt
Dim arrProdName, arrProdSize, arrProdColor, arrProdJe, arrProdGu, arrProdSpe, sGubun, sImg

	iDFSeq 	  			= NullFillWith(requestCheckVar(request("fingerid"),10),0)
	iListCurrentPage	= NullFillWith(requestCheckVar(request("iLC"),10),1)
	iWishListCurrentPage= NullFillWith(requestCheckVar(request("iWLC"),10),1)
	iCate				= NullFillWith(requestCheckVar(request("category"),10),0)
	sSort				= NullFillWith(requestCheckVar(request("sort"),10),"1")
	sSearchTxt			= NullFillWith(requestCheckVar(request("searchtxt"),50),"")
	sGubun				= NullFillWith(requestCheckVar(request("gubun"),1),"F")
	If sGubun = "F" Then
		sImg = "1"
	Else
		sImg = "2"
	End If

	set clsDF = new CDesignFingers

	If sGubun = "F" Then
		'메인리스트
		clsDF.FRDFS 		= iDFSeq
		clsDF.FDFCodeSeq 	= 3		'list용 이미지
		clsDF.FCategory		= iCate
		clsDF.FSort			= sSort
		clsDF.FSearchTxt	= sSearchTxt
		clsDF.FCPage 		= iListCurrentPage
		clsDF.FPSize 		= 10
		arrMainList = clsDF.fnGetList
		iTotCnt = clsDF.FTotCnt
	Else
		'메인위시리스트
		clsDF.FUserID 		= GetLoginUserID
		clsDF.FRDFS 		= iDFSeq
		clsDF.FDFCodeSeq 	= 3		'list용 이미지
		clsDF.FCategory		= iCate
		clsDF.FSort			= sSort
		clsDF.FSearchTxt	= sSearchTxt
		clsDF.FCPage 		= iListCurrentPage
		clsDF.FPSize 		= 5
		arrMainList = clsDF.fnGetWishList
		iTotCnt = clsDF.FTotCnt
		iTotWishCnt = clsDF.FResultCountW

		If iTotWishCnt = 1 Then
			iWishListCurrentPage = iListCurrentPage - 1
		Else
			iWishListCurrentPage = iListCurrentPage
		End If
	End If
%>
				<table>
				<caption>내가 담은 관심 디자인핑거스 목록</caption>
				<colgroup>
					<col width="60px" /><col  width="" />
				</colgroup>
				<tbody>
				<%
			If iTotCnt <> 0 Then
				IF isArray(arrMainList) THEN
					For intLoop = 0 To UBound(arrMainList,2)
				%>
				<tr>
					<td><img src="<%=arrMainList(2,intLoop)%>" alt="<%=chrbyte(arrMainList(1,intLoop),45,"Y")%>" width="50" height="50" /></td>
					<td>
						<p><strong>No.<%=arrMainList(0,intLoop)%></strong></p>
						<p><a href="/play/playdesignfingers.asp?fingerid=<%=arrMainList(0,intLoop)%>"><%=chrbyte(arrMainList(1,intLoop),45,"Y")%></a></p>
					</td>
				</tr>
				<%
						Next
					End If
				End If
				%>
				</tbody>
				</table>

				<div class="paging tMar10">
				<%
					clsDF.FCPage = iListCurrentPage
					clsDF.FPSize = 5
					clsDF.FTotCnt = iTotCnt
					clsDF.FGubun = sGubun
					clsDF.sbGetSmallListDisplayAjax
				%>
				</div>
<%
	set clsDF = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
