<%
'################################################
'	디자인 핑거스
'	2008.03.18 정윤정 생성
'################################################

	Class CDesignFingers
	public FDFSeq
	public FDFCodeSeq
	public FPCodeSeq
	public FCategory
	public FSort
	public FSearchTxt
	public FUserId
	public FGubun

	public FDFType
	public FTitle
	public FContents
	public FPrizeDate
	public FCommentTxt

	public FTotCnt
	public FCPage
	public FPSize
	public FPerCnt

	public FTopImgURL
	public FEventLeftImg
	public FEventRightImg

	public FArrWinner
	public FArrImgAdd(50,3)
	public FArrSourceImgAdd(50,3)
	public FArrImg3dv(10,4)
	public FListImg

	public FCategoryPrdList()
	public FResultCount
	public FResultCountW

	public FRDFS
	public FRImgURL
	public FRTitle

	public FProdName
	public FProdSize
	public FProdColor
	public FProdJe
	public FProdGu
	public FProdSpe
	public FItemID
	public FResult
	public FIsMovie
	public FRegdate
	public FOpenDate
	public FLikeCnt
	public FItemList()

	Private Sub Class_Initialize()
		redim preserve FCategoryPrdList(0)
	End Sub

	Private Sub Class_Terminate()
	End Sub

		'//내용 보여주기
	public Function fnGetDFContents
			Dim strSql, arrImg
			Dim tmp3dv
			Dim i

			IF FDFSeq = "" THEN FDFSeq = 0

			'Get Text
			strSql ="[db_sitemaster].[dbo].sp_Ten_designfingers_GetContents ("&FDFSeq&")"
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				FDFSeq 		= rsget(0)
				FDFType 	= rsget(1)
				FTitle		= db2html(rsget(2))
				FContents	= nl2br(db2html(rsget(3)))
				FPrizeDate	= rsget(4)
				FCommentTxt	= db2html(rsget(5))
				FProdName	= db2html(rsget(9))
				FProdSize	= db2html(rsget(10))
				FProdColor	= db2html(rsget(11))
				FProdJe		= db2html(rsget(12))
				FProdGu		= db2html(rsget(13))
				FProdSpe	= db2html(rsget(14))
				FIsMovie	= rsget(15)
				FRegdate	= rsget(16)
				FOpenDate	= rsget(17)
				FLikeCnt	= rsget(18)
			END IF
			rsget.close

			'Get Image - 3dview, addimg
			strSql = "[db_sitemaster].[dbo].sp_Ten_designfingers_GetImage ("&FDFSeq&")"
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				arrImg = rsget.getRows()
			END IF
			rsget.close

			IF isArray(arrImg) THEN
				For intLoop = 0 To UBound(arrImg,2)
					IF arrImg(1,intLoop) = 4 THEN '//List 이미지
						FListImg = arrImg(3,intLoop)
					ElseIF arrImg(1,intLoop) = 2 THEN '//main top 이미지
						FTopImgURL = arrImg(3,intLoop)
					ELSEIF arrImg(1,intLoop) = 5 THEN	'//add image
						FArrImgAdd(arrImg(2,intLoop),0)  =  arrImg(2,intLoop)	'이미지 ID
						FArrImgAdd(arrImg(2,intLoop),1)  =  arrImg(3,intLoop)	'이미지 url
						FArrImgAdd(arrImg(2,intLoop),2) =  db2html(arrImg(4,intLoop))	'맵
						FArrImgAdd(arrImg(2,intLoop),3) =  arrImg(1,intLoop)	'구분

					ELSEIF arrImg(1,intLoop) = 25 THEN	'//add image 퍼가기용
						FArrSourceImgAdd(arrImg(2,intLoop),0)  =  arrImg(2,intLoop)	'이미지 ID
						FArrSourceImgAdd(arrImg(2,intLoop),1)  =  arrImg(3,intLoop)	'이미지 url
						FArrSourceImgAdd(arrImg(2,intLoop),2) =  db2html(arrImg(4,intLoop))	'맵
						FArrSourceImgAdd(arrImg(2,intLoop),3) =  arrImg(1,intLoop)	'구분

					ELSEIF 	arrImg(1,intLoop) = 7 THEN '// 3dview image
						FArrImg3dv(arrImg(2,intLoop),0) = arrImg(2,intLoop)		'이미지 ID
						FArrImg3dv(arrImg(2,intLoop),1) = arrImg(3,intLoop)		'이미지 url
						tmp3dv = split(arrImg(3,intLoop),"/")
						FArrImg3dv(arrImg(2,intLoop),2) = replace(arrImg(3,intLoop),tmp3dv(uBound(tmp3dv)),"icon/icon_"&tmp3dv(uBound(tmp3dv)))	'아이콘 이미지
						FArrImg3dv(arrImg(2,intLoop),3) = arrImg(6,intLoop)		'이미지 위치명
					ElseIf arrImg(1,intLoop) = 22 THEN '//event left 이미지
						FEventLeftImg = arrImg(3,intLoop)
					ElseIf arrImg(1,intLoop) = 23 THEN '//event right 이미지
						FEventRightImg = arrImg(3,intLoop)
					END IF
					IF FTopImgURL = "" AND arrImg(1,intLoop) = 2 Then
						FTopImgURL = arrImg(3,intLoop)
					END IF
				Next
			END IF

			'Get Winner
			strSql ="[db_sitemaster].[dbo].sp_Ten_designfingers_GetWinner ("&FDFSeq&")"
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				FArrWinner = rsget.getRows()
			END IF
			rsget.close

			'Get item
			strSql ="[db_item].[dbo].[sp_Ten_designfingers_GetItem]("&FDFSeq&")"
			rsget.CursorLocation = adUseClient
			rsget.Open strSql, dbget, adOpenStatic ,adLockOptimistic, adCmdStoredProc
			FResultCount = rsget.RecordCount
			redim preserve FCategoryPrdList(FResultCount)
			IF Not (rsget.EOF OR rsget.BOF) THEN
				i=0
				do until rsget.eof
			set FCategoryPrdList(i) = new CCategoryPrdItem
				FCategoryPrdList(i).FItemID  		= rsget("itemid")
				FCategoryPrdList(i).Fitemname    	= db2html(rsget("itemname"))

				FCategoryPrdList(i).FSellcash     	= rsget("sellcash")
				FCategoryPrdList(i).FOrgPrice   	= rsget("orgprice")
				FCategoryPrdList(i).FMakerID 		= rsget("makerid")
				FCategoryPrdList(i).FBrandName		= rsget("BrandName")

				FCategoryPrdList(i).FSellYn       	= rsget("sellyn")
				FCategoryPrdList(i).FSaleYn    		= rsget("sailyn")

				FCategoryPrdList(i).FLimitYn      	= rsget("limityn")
				FCategoryPrdList(i).FLimitNo      	= rsget("limitno")
				FCategoryPrdList(i).FLimitSold    	= rsget("limitsold")

				FCategoryPrdList(i).FDeliverytype 	= rsget("deliverytype")
				FCategoryPrdList(i).FReipgodate		= rsget("reipgodate")

				FCategoryPrdList(i).FItemCouponValue= rsget("ItemCouponValue")
				FCategoryPrdList(i).Fitemcouponyn 	= rsget("itemcouponyn")
				FCategoryPrdList(i).Fitemcoupontype	= rsget("itemcoupontype")

				FCategoryPrdList(i).Fevalcnt 		= rsget("evalcnt")
				FCategoryPrdList(i).Ffavcount 		= rsget("favcount")
				FCategoryPrdList(i).FRegdate 		= rsget("regdate")

				FCategoryPrdList(i).FImageSmall 	= "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FCategoryPrdList(i).FItemID) + "/" + rsget("smallimage")
				FCategoryPrdList(i).FImageList 		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FCategoryPrdList(i).FItemID) + "/" + rsget("listimage")
				FCategoryPrdList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(FCategoryPrdList(i).FItemID) + "/" + rsget("listimage120")
				FCategoryPrdList(i).FImageIcon1		= "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(FCategoryPrdList(i).FItemID) + "/" + rsget("icon1image")
				rsget.movenext
				i=i+1
				loop
			End IF
			rsget.close

	End Function

		'//set type image URL
	private Function fnSetFTypeImg(ByVal iDFType)
			fnSetFTypeImg = "http://fiximage.10x10.co.kr/web2008/designfingers/title01_"&iDFType&".gif"
	End Function


		'// 최근
	public Function fnGetRecent
		Dim strSql
			strSql = "[db_sitemaster].[dbo].sp_Ten_designfingers_GetRecent"
				rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
				IF Not (rsget.EOF OR rsget.BOF) THEN
					FRDFS 	 = rsget(0)
					FRTitle	 = db2html(rsget(1))
					FRImgURL = rsget(2)
				END IF
				rsget.close
	End Function

		'// 리스트
	public Function fnGetList
			Dim strSqlCnt, strSql
			IF FRDFS ="" THEN FRDFS = 0

			strSqlCnt = "[db_sitemaster].[dbo].[sp_Ten_designfingers_GetListCnt] ("&FRDFS&","&FDFCodeSeq&","&FCategory&",'"&FSort&"','"&FSearchTxt&"') "
			rsget.Open strSqlCnt, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not rsget.EOF THEN
				FTotCnt = rsget(0)
			END IF
			rsget.close

			IF FTotCnt >0 THEN
				strSql = "[db_sitemaster].[dbo].sp_Ten_designfingers_GetList("&FRDFS&","&FDFCodeSeq&","&FCategory&",'"&FSort&"','"&FSearchTxt&"',"&FCPage&","&FPSize&")"
				rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
				IF Not (rsget.EOF OR rsget.BOF) THEN
					fnGetList =rsget.getRows()
				END IF
				rsget.close
			END IF
	End Function



	public sub sbGetSmallListDisplayAjax
		Dim arrList,intLoop
		Dim iStartPage, iEndPage, iTotalPage, ix


		IF FCPage = "" THEN	FCPage = 1
		FPerCnt = 3		'보여지는 페이지 간격
	 	'FPSize = 12	'페이지 사이즈

	 	FTotCnt = FTotCnt '배너리스트 총 갯수

		iTotalPage 	=  Int(FTotCnt/FPSize)	'전체 페이지 수
		IF (FTotCnt MOD FPSize) > 0 THEN	iTotalPage = iTotalPage + 1


		iStartPage = (Int((FCPage-1)/FPerCnt)*FPerCnt) + 1

		If (FCPage mod FPerCnt) = 0 Then
			iEndPage = FCPage
		Else
			iEndPage = iStartPage + (FPerCnt-1)
		End If

		IF iTotalPage < 1 THEN
      		Response.Write "<table><tr><td style='padding:5px 0'>[등록하신 관심핑거스가 없습니다.]</td></tr></table>"
      	Else
%>
							<div class="paging tMar10">
								<a href="javascript:CtgBestRefresh(1,'<%=FGubun%>','o')" class="first arrow"><span>맨 처음 페이지로 이동</span></a>
							<% if Cint(iStartPage-1 )> 0 then %>
								<a href="javascript:CtgBestRefresh(<%= iStartPage-1 %>,'<%=FGubun%>','o')" class="prev arrow"><span>이전페이지로 이동</span></a>
							<% else %>
								<a class="prev arrow"><span>이전페이지로 이동</span></a>
							<% end if %>

							<% IF iTotalPage < 1 THEN %>
								<a class="current"><span>1</span></a>
							 <% ELSE
									for ix = iStartPage  to iEndPage
										if (ix > iTotalPage) then Exit for
										if Cint(ix) = Cint(FCPage) then
						 	  %>
						   <a href="javascript:CtgBestRefresh(<%= ix %>,'<%=FGubun%>','o')" class="current"><span><%=ix%></span></a>
						    <%			else %>
						    <a href="javascript:CtgBestRefresh(<%= ix %>,'<%=FGubun%>','o')"><span><%=ix%></span></a>
							  <%
										end if
									next
								END IF
							  %>

							<% if Cint(iTotalPage) > Cint(iEndPage)   then %>
								<a href="javascript:CtgBestRefresh(<%= ix%>,'<%=FGubun%>','o')" class="next arrow"><span>다음 페이지로 이동</span></a>
							<% else %>
								<a class="next arrow"><span>다음 페이지로 이동</span></a>
							<% End If %>
								<a href="javascript:CtgBestRefresh(<%= iTotalPage %>,'<%=FGubun%>','o')" class="end arrow"><span>맨 마지막 페이지로 이동</span></a>
							</div>


<%
		End If
		End sub


		'// 카테고리 코드값 가져오기
		public Function fnGetCode
			Dim strSql, strSearch
			strSql = " [db_sitemaster].[dbo].sp_Ten_designfingers_CodeList (" & FPCodeSeq & ") "
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				fnGetCode =rsget.getRows()
			END IF
			rsget.Close
		End Function


		'// 핑거위시 처리하기
		public Function fnFingerWishProc
			Dim strSql, i
			For i = LBound(Split(FPCodeSeq,",")) To UBound(Split(FPCodeSeq,","))
				strSql = " [db_sitemaster].[dbo].sp_Ten_designfingers_wishProc ('" & FGubun & "'," & Split(FPCodeSeq,",")(i) & ",'" & FUserId & "','W') "
				dbget.Execute strSql
			Next
		End Function


		'// 핑거위시 카운트
		public Function fnFingerWishProcCheck
			Dim strSql, i
			strSql = " [db_sitemaster].[dbo].sp_Ten_designfingers_wishProc ('C','" & FPCodeSeq & "','" & FUserId & "','W') "
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				fnFingerWishProcCheck =rsget.getRows()
			END IF
			rsget.Close
		End Function


		'// 핑거위시리스트
		public Function fnGetWishList
				Dim strSqlCnt, strSql
				IF FRDFS ="" THEN FRDFS = 0

				strSqlCnt = "[db_sitemaster].[dbo].[sp_Ten_designfingers_GetWishListCnt] ('"&FUserID&"',"&FRDFS&","&FDFCodeSeq&","&FCategory&",'"&FSort&"','"&FSearchTxt&"') "
				rsget.Open strSqlCnt, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
				IF Not rsget.EOF THEN
				FTotCnt = rsget(0)
				END IF
				rsget.close

				IF FTotCnt > 0 THEN
				strSql = "[db_sitemaster].[dbo].sp_Ten_designfingers_GetWishList('"&FUserID&"',"&FRDFS&","&FDFCodeSeq&","&FCategory&",'"&FSort&"','"&FSearchTxt&"',"&FCPage&","&FPSize&")"

					rsget.CursorLocation = adUseClient
					rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
					IF Not (rsget.EOF OR rsget.BOF) THEN
						fnGetWishList = rsget.getRows()
						FResultCountW = rsget.RecordCount
					Else
						FResultCountW = 1
					END IF
					rsget.close
				END IF
		End Function


		'// 최근 코맨트 4개 가져오기
		public Function fnGetRecentComment
			Dim strSql, strSearch
			strSql = " [db_sitemaster].[dbo].sp_Ten_designfingers_RecentComment "
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				fnGetRecentComment =rsget.getRows()
			END IF
			rsget.Close
		End Function


		'// 최근 코맨트 4개 가져오기
		public Function fnGetMainOne
			Dim strSql, strSearch
			strSql = " [db_sitemaster].[dbo].sp_Ten_designfingers_Main_One "
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				fnGetMainOne =rsget.getRows()
			END IF
			rsget.Close
		End Function


		'// 베스트 코맨트 3개 가져오기
		public Function fnGetTop3Comment
			Dim strSql, strSearch
			strSql = " [db_sitemaster].[dbo].[sp_Ten_designfingers_Top3Comment](" & FDFCodeSeq & ") "
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			IF Not (rsget.EOF OR rsget.BOF) THEN
				fnGetTop3Comment =rsget.getRows()
			END IF
			rsget.Close
		End Function


		'####### 핑거스에 추천하기 처리
		public Function fnFingersRecommendProc
			Dim strSql
			strSql = "EXEC [db_sitemaster].[dbo].[sp_Ten_designfingers_Recommend_Proc] '" & FGUbun & "','" & FUserID & "', '" & FItemID & "', '" & FContents & "'"
			dbget.Execute strSql
		End Function


	End Class


	'지정된 날짜로 그달의 주차 반환 함수
	Function getWeekSerial(dt)
		dim startWeek, totalWeek
		totalWeek = DatePart("ww", dt)	'전체 주차
		startWeek = DatePart("ww", DateSerial(year(dt),month(dt),"01"))		'첫째일 주차

		'계산 및 값 반환
		getWeekSerial = totalWeek - startWeek + 1
	end Function
%>
