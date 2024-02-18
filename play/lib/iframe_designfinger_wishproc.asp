<%@ language=vbscript %>
<% option Explicit %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/designfingers/designfingersCls.asp" -->
<%
'#######################################################
'	History	:  2008.03.24 강준구 생성
'	Description : 디자인핑거스
'#######################################################

Dim clsDF, clsDFComm
Dim iDFSeq,sTitle,txtContents,dPrizeDate, sCommentTxt, sDFType, sTopImgURL
Dim arrImg3dv, arrImgAdd, arrWinner, intLoop, vGubun, vTopID, iLC
Dim i, k, iListCurrentPage,iComCurrentPage, iTotCnt, arrMainList, arrCateList, arrCount, vCount
Dim iRecentDFS, sRecentImgURL, sRecentTitle, iCate, sSort, sSearchTxt, sIsMain

	iDFSeq = requestCheckVar(request("fingerid"),100)
	sIsMain = requestCheckVar(request("ismain"),10)
	vGubun = requestCheckVar(request("wishgubun"),10)
	vTopID = requestCheckVar(request("topid"),10)
	iLC	= NullFillWith(requestCheckVar(request("iLC"),10),1)

	If iLC = 0 Then
		iLC = 1
	End If

	set clsDF = new CDesignFingers
	clsDF.FUserId	 	= GetLoginUserID

	If Instr(iDFSeq, ",") <> 0 Then
		For i = LBound(Split(iDFSeq,",")) To UBound(Split(iDFSeq,","))
			clsDF.FPCodeSeq		= Trim(Split(iDFSeq,",")(i))
			arrCount = clsDF.fnFingerWishProcCheck
			vCount = arrCount(0,0)

			If vCount = 0 OR vGubun = "D" Then
				clsDF.FGubun		= vGubun
				clsDF.FPCodeSeq		= Trim(Split(iDFSeq,",")(i))
				clsDF.FUserId	 	= GetLoginUserID
				arrMainList = clsDF.fnFingerWishProc
			End If
		Next
	Else
		clsDF.FPCodeSeq		= iDFSeq
		arrCount = clsDF.fnFingerWishProcCheck
		vCount = arrCount(0,0)

		If vCount = 0 OR vGubun = "D" Then
			clsDF.FGubun		= vGubun
			clsDF.FPCodeSeq		= iDFSeq
			clsDF.FUserId	 	= GetLoginUserID
			arrMainList = clsDF.fnFingerWishProc
		End If
	End IF

	set clsDF = nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->