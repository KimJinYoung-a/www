<%
'#######################################################
'	History	:  2013.08.21 허진원 생성
'	Description : 검색 필터링 / 상품속성 그룹핑 검색 결과(Ajax용)
'	/street/act_shop_category.asp 에서도 사용
'#######################################################

	'// 결과에 해당되는 컬러칩만 표시 //
	dim oGrAtt, tmpAttr1, tmpArrAttrNm
	chkTempCount = 0
	set oGrAtt = new SearchItemCls
	'' oGrAtt.FRectSortMethod = SortMet		'상품정렬 방법
	oGrAtt.FRectSearchTxt = DocSearchText
	oGrAtt.FRectExceptText = ExceptText
	'' oGrAtt.FminPrice	= minPrice		'가격범위(최소)
	'' oGrAtt.FmaxPrice	= maxPrice		'가격범위(최대)
	'' oGrAtt.FdeliType	= deliType		'배송방법
	oGrAtt.FRectMakerid = makerid
	oGrAtt.FRectSearchCateDep = SearchCateDep
	oGrAtt.FRectCateCode = dispCate
	oGrAtt.FarrCate=arrCate
	oGrAtt.FCurrPage = 1
	oGrAtt.FPageSize = 200
	oGrAtt.FScrollCount =10
	oGrAtt.FListDiv = ListDiv
	oGrAtt.FSellScope=SellScope			'판매/품절상품 포함 여부
	oGrAtt.FLogsAccept = False

	oGrAtt.getGroupbyAttribList

	If oGrAtt.FResultCount>0 Then
		tmpAttr1 = ""

		FOR lp=0 to oGrAtt.FResultCount-1
			tmpArrAttrNm = split(oGrAtt.FItemList(lp).FAttribName,"||")
			if ubound(tmpArrAttrNm)>0 then
				'행구분 시작 확인
				if tmpAttr1<>left(oGrAtt.FItemList(lp).FAttribCd,3) then
					tmpAttr1 = left(oGrAtt.FItemList(lp).FAttribCd,3)
					Response.Write "<dl><dt>" & tmpArrAttrNm(0) & "</dt><dd><ul>"
				end if

				Response.Write "<li><input type=""checkbox"" id=""Attr" & oGrAtt.FItemList(lp).FAttribCd & """ class=""check"" value=""" & oGrAtt.FItemList(lp).FAttribCd & """ " & chkiif(chkArrValue(AttribCd,oGrAtt.FItemList(lp).FAttribCd),"checked","") & " /> <label for=""Attr" & oGrAtt.FItemList(lp).FAttribCd & """ prv=""" & tmpArrAttrNm(0) & """>" & tmpArrAttrNm(1) & "</label></li>"

				'행구분 종료 확인
				if lp<(oGrAtt.FResultCount-1) then
					if tmpAttr1<>left(oGrAtt.FItemList(lp+1).FAttribCd,3) then
					Response.Write "</ul></dd></dl>"
					end if
				end if
			end if
		NEXT
		if tmpAttr1<>"" then
			Response.Write "</ul></dd></dl>"
		end if
	else
		'검색된 속성이 없으면 속성탭버튼 숨김
		Response.Write "<script style='text/javascript'>document.getElementById('tabAttribute').style.display='none';</script>"
	end if

	'set oGrAtt = Nothing
%>