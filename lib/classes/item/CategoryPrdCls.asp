<%

CLASS CatePrdCls

	Private Sub Class_Initialize()
		'FCurrPage =1
		'FPageSize = 10
		'FTotalPage = 1
		'FResultCount = 0
		'FScrollCount = 10
		'FTotalCount =0
	End Sub

	Private Sub Class_Terminate()
	End Sub

	dim Prd
	dim FADD
	dim FResultCount
	dim itEvtImg
	dim FItem
	dim FCaptureExist
	dim Frectmakerid

	Public Sub GetItemData(ByVal iid)


		dim strSQL, vIsTest
		IF application("Svr_Info") = "Dev" THEN
			'vIsTest = "test"
		Else
			vIsTest = ""
		End If

		strSQL = "execute [db_item].[dbo].sp_Ten_CategoryPrd @vItemID ='" & CStr(iid) & "'"

		rsget.CursorLocation = adUseClient
		rsget.CursorType=adOpenStatic
		rsget.Locktype=adLockReadOnly
		rsget.Open strSQL, dbget

		set Prd = new CCategoryPrdItem

		if  not rsget.EOF  then

			FResultCount = 1
			rsget.Movefirst

				Prd.FItemid    	= rsget("Itemid")  '상품 코드
				Prd.FcdL		= rsget("Cate_large")
				Prd.FcdM		= rsget("Cate_mid")
				Prd.FcdS		= rsget("Cate_small")
				Prd.FcateCode	= rsget("catecode")

				Prd.FMakerid 		= rsget("makerid") '업체 아이디(표시 브랜드)
				Prd.FOrgMakerID		= rsget("orgmakerid") '업체 아이디(원브랜드)

				Prd.Fitemname 			= db2html(rsget("itemname")) '상품명
				Prd.FMakerName 		= db2html(rsget("makername")) 	'제조사
				Prd.FOrgprice			= rsget("orgprice")		'원가
				Prd.FItemDiv 			= rsget("itemdiv")		'상품 속성
				Prd.FMileage				= rsget("mileage")	'마일리지

				''감성마니아 3배마일리지
				'// 2018 회원등급 개편
				if CStr(GetLoginUserLevel())="9" then
					Prd.FMileage   = CLng(Prd.FMileage) * 3
				end if

				'' VVIP 1.3(기존 vvip 등급인 6을 살려둔다.)
				'// 2018 회원등급 개편
				if CStr(GetLoginUserLevel())="4" Or CStr(GetLoginUserLevel())="6" then
					Prd.FMileage   = CLng(CLng(Prd.FMileage) * 2.6)
				end If
				
				'// vip, vip gold 구매금액의 1
				'// 2018 회원등급 개편
				if CStr(GetLoginUserLevel())="2" Or CStr(GetLoginUserLevel())="3" then
					Prd.FMileage   = CLng(CLng(Prd.FMileage) * 2)
				end If
				
				Prd.FSellCash 			= rsget("sellcash")		'판매가
				Prd.FLimitNo      = rsget("limitno")			'한정수량
				Prd.FLimitSold      = rsget("LimitSold")		'한정판매수량
				Prd.FKeyWords		= db2html(rsget("keyWords"))
				Prd.Fdeliverarea		= rsget("deliverarea")
				Prd.FSpecialUserItem = rsget("specialuseritem")
				Prd.FReipgodate			= rsget("reipgodate")
				Prd.FDeliverytype		= rsget("deliverytype")
				Prd.FEvalCnt				= rsget("evalcnt")
				Prd.FEvalOffCnt				= rsget("evaloffcnt")
				Prd.FEvalCnt_photo			= rsget("evalcnt_photo")
				Prd.FOptionCnt				= rsget("optioncnt")
				Prd.FQnaCnt					= rsget("qnaCnt")
				Prd.FAvgDlvDate					= rsget("AvgDlvDate")
				Prd.FItemSource 			= db2html(rsget("itemsource"))
				Prd.FSourceArea 			= db2html(rsget("sourcearea"))
				Prd.FItemSize 				= db2html(rsget("itemsize"))
				Prd.FCurrItemCouponIdx 		= rsget("curritemcouponidx")
				Prd.FitemWeight				= rsget("itemWeight")
				Prd.FdeliverOverseas 		= rsget("deliverOverseas")

				Prd.FfavCount				= rsget("favcount")
				Prd.FisUsing				= rsget("isUsing")
				Prd.FSellYn					= rsget("sellyn")
				Prd.FSaleYn					= rsget("sailyn")
				Prd.FLimitYn 				= rsget("limityn")
				Prd.FLimitDispYn			= rsget("limitdispyn")
				Prd.FItemCouponYN			= rsget("itemcouponyn")
				Prd.FItemCouponType 		= rsget("itemcoupontype")
				Prd.FItemCouponValue		= rsget("itemcouponvalue")
				Prd.FUsingHTML				= rsget("usinghtml")
				Prd.FTenOnlyYn			= rsget("tenOnlyYn")

				Prd.FDesignerComment	= db2html(Trim(rsget("designercomment")))
				Prd.FItemContent 		= db2html(rsget("itemcontent"))
				Prd.FItemContent 		= replace(Prd.FItemContent,"contentEditable","content")	'body 편집모드 지정태그 제거
				Prd.FOrderComment		= db2html(Trim(rsget("ordercomment")))

				Prd.FAvailPayType		= rsget("AvailPayType")
				Prd.FAdultType	= rsget("AdultType")

				Prd.FImageMain 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/main/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("mainimage")
				Prd.FImageMain2		= "http://"&vIsTest&"webimage.10x10.co.kr/image/main2/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("mainimage2")
				Prd.FImageMain3		= "http://"&vIsTest&"webimage.10x10.co.kr/image/main3/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("mainimage3")
				Prd.FImageList 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("listimage")
				Prd.FImageList120 	= "http://"&vIsTest&"twebimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("listimage120")
				Prd.FImageSmall 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("smallimage")
				
				If Prd.FItemDiv="21" Then
					if instr(rsget("basicimage"),"/") > 0 then
						Prd.FImageBasic 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/basic/" + rsget("basicimage")
						Prd.FImageBasic600 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/basic600/" + rsget("basicimage600")
					else
						Prd.FImageBasic 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("basicimage")
						Prd.FImageBasic600 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/basic600/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("basicimage600")
					end if
				Else
				Prd.FImageBasic 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("basicimage")
				Prd.FImageBasic600 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/basic600/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("basicimage600")
				End If
				Prd.FImageBasic1000 	= "http://"&vIsTest&"webimage.10x10.co.kr/image/basic1000/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("basicimage1000")
				Prd.FImageBasicIcon 	= "http://"&vIsTest&"webimage.10x10.co.kr/image/basicicon/" + GetImageSubFolderByItemid(Prd.FItemid) + "/C" + rsget("basicimage")

				If Not(isNull(rsget("maskimage")) OR rsget("maskimage") = "") Then
					Prd.FImageMask 	= "http://"&vIsTest&"webimage.10x10.co.kr/image/mask/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("maskimage")
					Prd.FImageMask1000 	= "http://"&vIsTest&"webimage.10x10.co.kr/image/mask1000/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("maskimage1000")
					Prd.FImageMaskIcon 	= "http://"&vIsTest&"webimage.10x10.co.kr/image/maskicon/" + GetImageSubFolderByItemid(Prd.FItemid) + "/C" + rsget("maskimage")
				end If
				
				If Not(isNull(rsget("tentenimage")) Or rsget("tentenimage") = "") Then
					Prd.Ftentenimage	= "http://"&vIsTest&"webimage.10x10.co.kr/image/tenten/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("tentenimage")
					Prd.Ftentenimage50	= "http://"&vIsTest&"webimage.10x10.co.kr/image/tenten50/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("tentenimage50")
					Prd.Ftentenimage200	= "http://"&vIsTest&"webimage.10x10.co.kr/image/tenten200/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("tentenimage200")
					Prd.Ftentenimage400	= "http://"&vIsTest&"webimage.10x10.co.kr/image/tenten400/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("tentenimage400")
					Prd.Ftentenimage600	= "http://"&vIsTest&"webimage.10x10.co.kr/image/tenten600/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("tentenimage600")
					Prd.Ftentenimage1000	= "http://"&vIsTest&"webimage.10x10.co.kr/image/tenten1000/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("tentenimage1000")
				End If

				Prd.FImageicon2 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("icon2image")
				Prd.FImageicon1 		= "http://"&vIsTest&"webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("icon1image")
				Prd.FRegdate 			= rsget("regdate")
				Prd.FBrandName	= db2Html(rsget("brandname"))
				Prd.FBrandName_kor	= db2Html(rsget("BrandName_Kor"))
				IF rsget("brandlogo")<>"" Then
					Prd.FBrandLogo	=	"http://"&vIsTest&"webimage.10x10.co.kr/image/brandlogo/" & db2html(rsget("brandlogo"))
				Else
					Prd.FBrandLogo	=	"http://"&vIsTest&"webimage.10x10.co.kr/web2008/street/brandimg_blank.gif"
				End IF
				Prd.FSpecialbrand = rsget("specialbrand") '상품문의 접수 여부
				Prd.FStreetUsing = rsget("streetusing") '브랜드 스트리트 사용 여부
				Prd.FBrandUsing = rsget("BrandUsing")			'브랜드 사용 여부
				Prd.Fuserdiv = rsget("userdiv")			'브랜드 구분
				Prd.FDefaultFreeBeasongLimit = rsget("DefaultFreeBeasongLimit")
				Prd.FDefaultDeliverPay = rsget("defaultDeliverPay")
				Prd.FRequireMakeDay	= rsget("requireMakeDay")	' 업체 코멘트

				Prd.ForderMinNum	= rsget("orderMinNum")	' 최소 구매수량
				Prd.ForderMaxNum	= rsget("orderMaxNum")	' 최대 구매수량

				Prd.FsafetyYN				= rsget("safetyYN")	' 안전인증대상
				Prd.FsafetyDiv				= rsget("safetyDiv")	' 안전인증구분 '10 ~ 50
				Prd.FsafetyNum			= rsget("safetyNum")	' 안전인증번호

				Prd.FisJust1day			= rsget("isJust1Day")	'금일의 Just 1day 상품 여부
				Prd.FCurrRank			= rsget("currrank")		'Best Award 순위 정보
				Prd.FPojangOk			= rsget("pojangok")		'선물포장 가능 여부

				prd.FreserveItemTp		= rsget("reserveItemTp")	'단독(예약)배송 상품 여부

				Prd.FDeliverFixDay		= rsget("DeliverFixDay") '해외 직구 배송

				Prd.FDeliveryCode		= rsget("deliverycode") '택배사 코드
				Prd.FDeliveryName		= rsget("deliveryname") '택배사 명
		else
			FResultCount = 0
		end if

		rsget.close

	End Sub
	
	'/컬러 상품 상세	'/2012.04.10 한용민 생성
	Public Sub GetItemDatacolor(ByVal iid)
		dim strSQL

		strSQL = "execute [db_item].[dbo].sp_Ten_CategoryPrd_color '" & CStr(iid) & "'"

		rsget.CursorLocation = adUseClient
		rsget.CursorType=adOpenStatic
		rsget.Locktype=adLockReadOnly
		rsget.Open strSQL, dbget

		set Prd = new CCategoryPrdItem

		if  not rsget.EOF  then

			FResultCount = 1
			rsget.Movefirst

				Prd.FItemid    	= rsget("Itemid")  '상품 코드
				Prd.FcdL		= rsget("Cate_large")
				Prd.FcdM		= rsget("Cate_mid")
				Prd.FcdS		= rsget("Cate_small")
				Prd.FMakerid 		= rsget("makerid") '업체 아이디
				Prd.Fitemname 			= db2html(rsget("itemname")) '상품명
				Prd.FMakerName 		= db2html(rsget("makername")) 	'제조사
				Prd.FOrgprice			= rsget("orgprice")		'원가
				Prd.FItemDiv 			= rsget("itemdiv")		'상품 속성
				Prd.FMileage				= rsget("mileage")	'마일리지
				''감성마니아 3배마일리지
				'// 2018 회원등급 개편
				if CStr(GetLoginUserLevel())="9" then
					Prd.FMileage   = CLng(Prd.FMileage) * 3
				end if

				'' VVIP 1.3(기존 vvip 등급인 6을 살려둔다.)
				'// 2018 회원등급 개편
				if CStr(GetLoginUserLevel())="4" Or CStr(GetLoginUserLevel())="6" then
					Prd.FMileage   = CLng(CLng(Prd.FMileage) * 2.6)
				end If
				
				'// vip, vip gold 구매금액의 1
				'// 2018 회원등급 개편
				if CStr(GetLoginUserLevel())="2" Or CStr(GetLoginUserLevel())="3" then
					Prd.FMileage   = CLng(CLng(Prd.FMileage) * 2)
				end if

				Prd.FSellCash 			= rsget("sellcash")		'판매가
				Prd.FLimitNo      = rsget("limitno")			'한정수량
				Prd.FLimitSold      = rsget("LimitSold")		'한정판매수량
				Prd.FKeyWords		= db2html(rsget("keyWords"))
				Prd.Fdeliverarea		= rsget("deliverarea")
				Prd.FSpecialUserItem = rsget("specialuseritem")
				Prd.FReipgodate			= rsget("reipgodate")
				Prd.FDeliverytype		= rsget("deliverytype")
				Prd.FEvalCnt				= rsget("evalcnt")
				Prd.FEvalCnt_photo			= rsget("evalcnt_photo")
				Prd.FOptionCnt				= rsget("optioncnt")
				Prd.FQnaCnt					= rsget("qnaCnt")
				Prd.FAvgDlvDate					= rsget("AvgDlvDate")
				Prd.FItemSource 			= db2html(rsget("itemsource"))
				Prd.FSourceArea 			= db2html(rsget("sourcearea"))
				Prd.FItemSize 				= db2html(rsget("itemsize"))
				Prd.FCurrItemCouponIdx 		= rsget("curritemcouponidx")
				Prd.FitemWeight				= rsget("itemWeight")
				Prd.FdeliverOverseas 		= rsget("deliverOverseas")
				Prd.FisUsing				= rsget("isUsing")
				Prd.FSellYn					= rsget("sellyn")
				Prd.FSaleYn					= rsget("sailyn")
				Prd.FLimitYn 				= rsget("limityn")
				Prd.FItemCouponYN			= rsget("itemcouponyn")
				Prd.FItemCouponType 		= rsget("itemcoupontype")
				Prd.FItemCouponValue		= rsget("itemcouponvalue")
				Prd.FUsingHTML				= rsget("usinghtml")
				Prd.FTenOnlyYn			= rsget("tenOnlyYn")
				Prd.FDesignerComment	= db2html(Trim(rsget("designercomment")))
				Prd.FItemContent 		= db2html(rsget("itemcontent"))
				Prd.FItemContent 		= replace(Prd.FItemContent,"contentEditable","content")	'body 편집모드 지정태그 제거
				Prd.FOrderComment		= db2html(Trim(rsget("ordercomment")))
				Prd.FAvailPayType		= rsget("AvailPayType")
				Prd.FAdultType	= rsget("AdultType")
				Prd.FImageMain 		= "http://webimage.10x10.co.kr/color/main/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("mainimage")
				Prd.FImageMain2		= "http://webimage.10x10.co.kr/color/main2/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("mainimage2")
				Prd.FImageList 		= "http://webimage.10x10.co.kr/color/list/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("listimage")
				Prd.FImageList120 	= "http://webimage.10x10.co.kr/color/list120/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("listimage120")
				Prd.FImageSmall 		= "http://webimage.10x10.co.kr/color/small/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("smallimage")
				Prd.FImageBasic 		= "http://webimage.10x10.co.kr/color/basic/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("basicimage")
				Prd.FImageBasicIcon 	= "http://webimage.10x10.co.kr/color/basicicon/" + GetImageSubFolderByItemid(Prd.FItemid) + "/C" + rsget("basicimage")
				Prd.FImageicon2 		= "http://webimage.10x10.co.kr/color/icon2/" + GetImageSubFolderByItemid(Prd.FItemid) + "/" + rsget("icon2image")
				Prd.FRegdate 			= rsget("regdate")
				Prd.FBrandName	= db2Html(rsget("brandname"))
				Prd.FBrandName_kor	= db2Html(rsget("BrandName_Kor"))
				
				IF rsget("brandlogo")<>"" Then
					Prd.FBrandLogo	=	"http://webimage.10x10.co.kr/image/brandlogo/" & db2html(rsget("brandlogo"))
				Else
					Prd.FBrandLogo	=	"http://fiximage.10x10.co.kr/web2008/street/brandimg_blank.gif"
				End IF
				
				Prd.FSpecialbrand = rsget("specialbrand") '상품문의 접수 여부
				Prd.FStreetUsing = rsget("streetusing") '브랜드 스트리트 사용 여부
				Prd.FBrandUsing = rsget("BrandUsing")			'브랜드 사용 여부
				Prd.Fuserdiv = rsget("userdiv")			'브랜드 구분
				Prd.FDefaultFreeBeasongLimit = rsget("DefaultFreeBeasongLimit")
				Prd.FDefaultDeliverPay = rsget("defaultDeliverPay")
				Prd.FRequireMakeDay	= rsget("requireMakeDay")	' 업체 코멘트
		else
			FResultCount = 0
		end if

		rsget.close
	End Sub
	
	Public Sub getAddImage(byval itemid)
			dim strSQL,ArrRows,i

			strSQL = "exec [db_item].[dbo].sp_Ten_CategoryPrd_AddImage @vItemid =" & CStr(itemid)

			rsget.CursorLocation = adUseClient
			rsget.CursorType=adOpenStatic
			rsget.Locktype=adLockReadOnly
			rsget.Open strSQL, dbget

			If Not rsget.EOF Then
				ArrRows 	= rsget.GetRows
			End if
			rsget.close

			if isArray(ArrRows) then

			FResultCount = Ubound(ArrRows,2) + 1

			redim  FADD(FResultCount)

				For i=0 to FResultCount-1
					Set FADD(i) = new CCategoryPrdItem
					FADD(i).FAddimageGubun	= ArrRows(0,i)
					FADD(i).FAddImageType	= ArrRows(1,i)
					IF ArrRows(1,i)="1" or ArrRows(1,i)="3" Then
						FADD(i).FAddimage 			= "http://webimage.10x10.co.kr/item/contentsimage/" & GetImageSubFolderByItemid(itemid) & "/" & ArrRows(2,i)
						If ArrRows(2,i) = "" OR isNull(ArrRows(2,i)) Then
							FADD(i).FIsExistAddimg = False
						Else
							FADD(i).FIsExistAddimg = True
						End If
						'FADD(i).FAddimageSmall	= "http://webimage.10x10.co.kr/image/add" & ArrRows(1,i) & "icon/" & GetImageSubFolderByItemid(itemid) & "/C" + ArrRows(2,i)
					Else
						FADD(i).FAddimage 			= "http://webimage.10x10.co.kr/image/add" & Cstr(FADD(i).FAddimageGubun) & "/" & GetImageSubFolderByItemid(itemid) & "/" & ArrRows(2,i)
						FADD(i).FAddimage600		= "http://webimage.10x10.co.kr/image/add" & Cstr(FADD(i).FAddimageGubun) & "_600/" & GetImageSubFolderByItemid(itemid) & "/" & ArrRows(3,i)
						FADD(i).FAddimage1000		= "http://webimage.10x10.co.kr/image/add" & Cstr(FADD(i).FAddimageGubun) & "_1000/" & GetImageSubFolderByItemid(itemid) & "/" & ArrRows(4,i)
						FADD(i).FAddimageSmall	= "http://webimage.10x10.co.kr/image/add" & Cstr(FADD(i).FAddimageGubun) & "icon/" & GetImageSubFolderByItemid(itemid) & "/C" & ArrRows(2,i)
					End IF

				next
			end if
	End Sub

	Public Sub getImageColorList(byval itemid)
			dim strSQL,ArrRows,i

			strSQL = "exec [db_item].[dbo].[sp_Ten_itemColor_itemImage_list] " & CStr(itemid)

			rsget.CursorLocation = adUseClient
			rsget.CursorType=adOpenStatic
			rsget.Locktype=adLockReadOnly
			rsget.Open strSQL, dbget

			If Not rsget.EOF Then
				ArrRows 	= rsget.GetRows
			End if
			rsget.close

			if isArray(ArrRows) then

			FResultCount = Ubound(ArrRows,2) + 1

			redim  FADD(FResultCount)

				For i=0 to FResultCount-1
					Set FADD(i) = new CCategoryPrdItem

					FADD(i).FcolorCode	= ArrRows(1,i)
					FADD(i).FImageBasic	= "http://webimage.10x10.co.kr/color/basic/" & GetImageSubFolderByItemid(itemid) & "/" & ArrRows(2,i)
					FADD(i).FcolorName	= ArrRows(3,i)

				next
			end if
	End Sub

	Public Function getDiaryEvt(byval itid)
		dim strSQL,tmpHTML
		tmpHTML =""

		strSQL =" SELECT TOP 10 A.evt_code , A.Evt_name , evt_startDate , evt_EndDate , A.evt_state , A.evt_Using , Evt_Template , Evt_mainimg , Evt_html "&_
				" FROM db_event.dbo.tbl_event A "&_
				" JOIN db_event.dbo.tbl_event_display B "&_
				" 	on A.evt_code = B.evt_code "&_
				" JOIN db_event.dbo.tbl_eventitem C "&_
				" 	on A.evt_code= C.evt_code "&_
				" WHERE C.itemid="& itid & " " &_
				" and A.evt_state=7 and A.evt_kind=17 and A.evt_using ='Y' and B.evt_LinkType='I'"&_
				" and getdate() between evt_startdate and dateadd(day,1,evt_enddate ) "
		'response.write strSQL
		rsget.open strSQL, dbget,2
		IF Not rsget.EOF Then

			Do Until rsget.EOF
				tmpHTML= tmpHTML & "<div align='center' style='padding: 5 0 0 0;'>"
				IF rsget("Evt_Template") =5 Then
					IF rsget("Evt_html")<>"" Then
						tmpHTML = tmpHTML & rsget("Evt_html")
					End IF
				ELSE
					IF trim(rsget("Evt_mainimg"))<>"" and not isNull(rsget("Evt_mainimg")) Then
						tmpHTML = tmpHTML & "<img src="""& rsget("Evt_mainimg") &"""  border=""0"">"
					End IF
				End IF
				tmpHTML = tmpHTML & "</div>"
				rsget.MoveNext
			Loop

		End IF

		rsget.Close
		getDiaryEvt= tmpHTML

	End Function

	'//1+1 사은품 증정 여부
	Public Function getGiftExists(itemid)

		dim tmpSQL,i
		dim blnTF

		tmpSQL = "Execute [db_item].[dbo].[sp_Ten_GiftExists] @vItemid = " & itemid

			rsget.CursorLocation = adUseClient
			rsget.CursorType=adOpenStatic
			rsget.Locktype=adLockReadOnly
			rsget.Open tmpSQL, dbget,2

			If Not rsget.EOF Then
				blnTF 	= true
			ELSE
				blnTF 	= false
			End if
			rsget.close

			getGiftExists = blnTF

	End Function

	'// 타겟쿠폰 내용 접수
	Public Sub getTargetCoupon(byval cpid, byval iid)
		dim strSQL
		strSQL = "exec [db_item].[dbo].[sp_Ten_checkTargetcoupon] " & cpid & ", " & iid
		rsget.CursorLocation = adUseClient
		rsget.CursorType=adOpenStatic
		rsget.Locktype=adLockReadOnly
		rsget.Open strSQL, dbget
		if Not(rsget.EOF) then
			Prd.FCurrItemCouponIdx	= cpid
			Prd.FItemCouponYN		= "Y"
			Prd.FItemCouponType 	= rsget("itemcoupontype")
			Prd.FItemCouponValue	= rsget("itemcouponvalue")
		end if
		rsget.Close
	end Sub

	'// 네이버 전용쿠폰 내용 접수 // 2018/03/09
	Public Sub getNaverTargetCoupon(byval iitemid)
		dim strSQL
		strSQL = "exec [db_item].[dbo].[sp_Ten_checkNaverOnlycoupon] " & iitemid & ""
		rsget.CursorLocation = adUseClient
		rsget.CursorType=adOpenStatic
		rsget.Locktype=adLockReadOnly
		rsget.Open strSQL, dbget
		if Not(rsget.EOF) then
			Prd.FCurrItemCouponIdx	= rsget("itemcouponidx")
			Prd.FItemCouponYN		= "Y"
			Prd.FItemCouponType 	= rsget("itemcoupontype")
			Prd.FItemCouponValue	= rsget("itemcouponvalue")
		end if
		rsget.Close
	end Sub
	
	public function getValidSecretItemCouponDownIdx(byval iuserid, byval iitemid)
		dim strSQL, bufitemcouponidx, bufitemcoupontype, bufitemcouponvalue, bufitemid, bufdownidx
		dim validsecretitemcpnExists : validsecretitemcpnExists = False

		getValidSecretItemCouponDownIdx = -1
		if (iuserid="") then Exit function

		bufdownidx = -1
		dim iprice : iprice = Prd.FSellCash
		dim idiscountprice : idiscountprice = Prd.GetCouponDiscountPrice
		strSQL = "exec [db_item].[dbo].[sp_Ten_checkValidSecretItemCouponExists] '" & iuserid & "'," & iitemid & "," & iprice & "," & idiscountprice

		rsget.CursorLocation = adUseClient
		rsget.Open strSQL, dbget, adOpenForwardOnly, adLockReadOnly

		if Not(rsget.EOF) then
			bufdownidx			= rsget("downidx")
			bufitemcouponidx	= rsget("itemcouponidx")
			bufitemcoupontype 	= rsget("itemcoupontype")
			bufitemcouponvalue	= rsget("itemcouponvalue")
			bufitemid			= rsget("itemid")  		'' 널이면 해당상품쿠폰이 현재쿠폰보다 좋지 않음.

			if Not isNULL(bufitemid) then 
				if CStr(bufitemid)=CStr(iitemid) then  '' 해당 상품쿠폰이 있는경우
					validsecretitemcpnExists  = true
				end if
			end if
		end if
		rsget.Close

		if NOT(validsecretitemcpnExists) then Exit function
		if isNULL(bufitemcoupontype) or isNULL(bufitemcouponvalue) or isNULL(bufitemcouponidx) then Exit function
	
		'' 해당쿠폰이 좋은지 여부는 proc 안에서 체크한다.
		if (validsecretitemcpnExists) then 
			Prd.FCurrItemCouponIdx	= bufitemcouponidx
			Prd.FItemCouponYN		= "Y"
			Prd.FItemCouponType 	= bufitemcoupontype
			Prd.FItemCouponValue	= bufitemcouponvalue

			getValidSecretItemCouponDownIdx = bufdownidx
		end if
	end function

	public function NN_getValidSecretItemCouponDownIdx(byval iuserid, byval iitemid)
		dim strSQL, bufitemcouponidx, bufitemcoupontype, bufitemcouponvalue, bufitemid, bufdownidx
		dim validsecretitemcpnExists : validsecretitemcpnExists = False

		NN_getValidSecretItemCouponDownIdx = -1
		if (iuserid="") then Exit function

		''너무 자주 체크하지 않기 위해 session 발행내역이 있는지 세션에 담아서 발행내역이 없는사람은 N분단위로만 체크 하자.
		Dim preTargetItemCpnChktime : preTargetItemCpnChktime = session("pscrcpntime")
		Dim reqReQuery : reqReQuery = False

		if isEmpty(preTargetItemCpnChktime) then
			reqReQuery = True
		else
			if isDate(preTargetItemCpnChktime) then
				if dateDiff("n",preTargetItemCpnChktime,now())>2 then ''3분에한번
					reqReQuery = True
				end if
			else
				reqReQuery = True
			end if
		end if

		if (NOT reqReQuery) then Exit function
		session("pscrcpntime")=now()

		bufdownidx = -1
		dim iprice : iprice = Prd.FSellCash
		dim idiscountprice : idiscountprice = Prd.GetCouponDiscountPrice
		strSQL = "exec [db_item].[dbo].[sp_Ten_checkValidSecretItemCouponExists] '" & iuserid & "'," & iitemid & "," & iprice & "," & idiscountprice

		rsget.CursorLocation = adUseClient
		rsget.Open strSQL, dbget, adOpenForwardOnly, adLockReadOnly

		if Not(rsget.EOF) then
			bufdownidx			= rsget("downidx")
			bufitemcouponidx	= rsget("itemcouponidx")
			bufitemcoupontype 	= rsget("itemcoupontype")
			bufitemcouponvalue	= rsget("itemcouponvalue")
			bufitemid			= rsget("itemid")  '' 널이면 해당상품쿠폰이 없다.

			session("pscrcpntime")=Empty  		'' 시크릿쿠폰을 하나라도 가지고 있다면 계속쿼리한다.
			if Not isNULL(bufitemid) then 
				if CStr(bufitemid)=CStr(iitemid) then  '' 해당 상품쿠폰이 있는경우
					validsecretitemcpnExists  = true
				end if
			end if
		else

		end if
		rsget.Close

		if NOT(validsecretitemcpnExists) then Exit function
		if isNULL(bufitemcoupontype) or isNULL(bufitemcouponvalue) or isNULL(bufitemcouponidx) then Exit function
	
		'' 해당쿠폰이 좋은지 여부는 proc 안에서 체크한다.
		if (validsecretitemcpnExists) then 
			Prd.FCurrItemCouponIdx	= bufitemcouponidx
			Prd.FItemCouponYN		= "Y"
			Prd.FItemCouponType 	= bufitemcoupontype
			Prd.FItemCouponValue	= bufitemcouponvalue

			NN_getValidSecretItemCouponDownIdx = bufdownidx
		end if
	end function

	'// 이미 발행 받은 (타겟) 상품 쿠폰이 있는지. // 2019/06/10 사용중지 getValidSecretItemCouponDownIdx 로 변경
	'' 다운받은 Valid 타겟 쿠폰이 존재하고, 현재조건 보다 좋을 경우, 현재상품쿠폰으로 세팅하고 True를 반환
	Public function getReceivedValidTargetItemCouponExists(byval iuserid, byval iitemid)
		dim strSQL, bufitemcouponidx, bufitemcoupontype, bufitemcouponvalue, bufitemid
		dim evalditemcpnExists : evalditemcpnExists = False
		dim currDiscountVal, evaledDiscountVal
		if (iuserid="") then Exit function

		getReceivedValidTargetItemCouponExists = false

		''너무 자주 체크하지 않기 위해 session 발행내역이 있는지 세션에 담아서 발행내역이 없는사람은 N분단위로만 체크 하자.
		Dim preEvaledItemCpnChktime : preEvaledItemCpnChktime = session("peicpnchktime")
		Dim reqReQuery : reqReQuery = False

		if isEmpty(preEvaledItemCpnChktime) then
			reqReQuery = True
		else
			if isDate(preEvaledItemCpnChktime) then
				if dateDiff("n",preEvaledItemCpnChktime,now())>4 then 
					reqReQuery = True
				end if
			else
				reqReQuery = True
			end if
		end if

''response.write isEmpty(preEvaledItemCpnChktime)&"::"&reqReQuery&"::"&dateDiff("n",preEvaledItemCpnChktime,now())&"::"
		if (NOT reqReQuery) then Exit function

		dim iprice : iprice = Prd.FSellCash
		session("peicpnchktime")=now()
		evalditemcpnExists  = false

		strSQL = "exec [db_item].[dbo].[sp_Ten_checkReceivedValidTargetItemCouponExists] '" & iuserid & "'," & iitemid & "," & iprice
		rsget.CursorLocation = adUseClient
		rsget.CursorType=adOpenStatic
		rsget.Locktype=adLockReadOnly
		rsget.Open strSQL, dbget

		if Not(rsget.EOF) then
			bufitemcouponidx	= rsget("itemcouponidx")
			bufitemcoupontype 	= rsget("itemcoupontype")
			bufitemcouponvalue	= rsget("itemcouponvalue")
			bufitemid			= rsget("itemid")  '' 널이면 해당상품쿠폰이 없다.

			session("peicpnchktime")=Empty  		'' 지정쿠폰을 하나라도 가지고 있다면 계속쿼리한다.
			if Not isNULL(bufitemid) then 
				if CStr(bufitemid)=CStr(iitemid) then  '' 해당 상품쿠폰이 있는경우
					evalditemcpnExists  = true
				end if
			end if
		else

		end if
		rsget.Close

		if NOT(evalditemcpnExists) then Exit function
		if isNULL(bufitemcoupontype) or isNULL(bufitemcouponvalue) then Exit function

		if (bufitemcoupontype="1") then
			evaledDiscountVal = CLNG(iprice*bufitemcouponvalue*1.0/100)  
		elseif (bufitemcoupontype="2") then
			evaledDiscountVal = bufitemcouponvalue
		elseif (bufitemcoupontype="3") then  ''무료배송쿠폰을 어케할지.. 일단 2500 =>0
			evaledDiscountVal = 0 ''2500
		end if
		

		if (Prd.FItemCouponYN="Y") then
			if isNULL(Prd.FItemCouponType) or isNULL(Prd.FItemCouponValue) then
				currDiscountVal = 0
			else
				if (Prd.FItemCouponType="1") then
					currDiscountVal = CLNG(iprice*Prd.FItemCouponValue*1.0/100)  ''이부분이 잘못됨 iitemcpntype=>iitemcpnvalue
				elseif (Prd.FItemCouponType="2") then
					currDiscountVal = Prd.FItemCouponValue
				elseif (Prd.FItemCouponType="3") then  ''무료배송쿠폰을 어케할지.. 일단 2500 =>0
					currDiscountVal = 0 ''2500
				end if
			end if
		else 
			currDiscountVal = 0
		end if

		if (evaledDiscountVal>=currDiscountVal) then
			Prd.FCurrItemCouponIdx	= bufitemcouponidx
			Prd.FItemCouponYN		= "Y"
			Prd.FItemCouponType 	= bufitemcoupontype
			Prd.FItemCouponValue	= bufitemcouponvalue

			getReceivedValidTargetItemCouponExists = True
		end if

	end function
	
	'// 상품 스타일 접수
	Public Sub getItemStyleList(byval itemid)
			dim strSQL,ArrRows,i

			strSQL = "exec [db_giftPlus].[dbo].[sp_Ten_itemStyleList] " & CStr(itemid)
			rsget.CursorLocation = adUseClient
			rsget.CursorType=adOpenStatic
			rsget.Locktype=adLockReadOnly
			rsget.Open strSQL, dbget

			If Not rsget.EOF Then
				ArrRows 	= rsget.GetRows
			End if
			rsget.close

			if isArray(ArrRows) then

			FResultCount = Ubound(ArrRows,2) + 1

			redim  FItem(FResultCount)

				For i=0 to FResultCount-1
					Set FItem(i) = new CCategoryPrdItem

					FItem(i).FStyleCd1		= ArrRows(0,i)
					FItem(i).FStyleCd1Nm	= ArrRows(1,i)

				next
			end if
	End Sub

	'// 상품 설명 new 버전 2012 - 이종화
	Public Sub getItemAddExplain(byval itemid)
			dim strSQL,ArrRows,i

			strSQL = "exec [db_item].[dbo].[sp_Ten_CategoryPrd_AddExplain] " & CStr(itemid)
			rsget.CursorLocation = adUseClient
			rsget.CursorType=adOpenStatic
			rsget.Locktype=adLockReadOnly
			rsget.Open strSQL, dbget

			If Not rsget.EOF Then
				ArrRows 	= rsget.GetRows
			End if
			rsget.close

			if isArray(ArrRows) then

			FResultCount = Ubound(ArrRows,2) + 1

			redim  FItem(FResultCount)

				For i=0 to FResultCount-1
					Set FItem(i) = new CCategoryPrdItem

					FItem(i).FInfoname		= ArrRows(0,i)
					FItem(i).FInfoContent	= ArrRows(1,i)
					FItem(i).FinfoCode		= ArrRows(2,i)

				next
			end if
	End Sub

	'브랜드 공지(2017-02-03 유태욱)
	Public Sub GetBrandNoticeData
		dim strSQL,ArrRows,i

		if Frectmakerid <> "" then
			strSQL = "exec [db_board].[dbo].[sp_Ten_Brand_notice] '"&Frectmakerid&"' "
'			response.write strSQL

			dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"ITBN",strSQL,180)
	        if (rsMem is Nothing) then Exit Sub
	        if  not rsMem.EOF  then
				ArrRows 	= rsMem.GetRows
			end if
			rsMem.Close

			if isArray(ArrRows) then
				FResultCount = Ubound(ArrRows,2) + 1
				redim  FItem(FResultCount)

				For i=0 to FResultCount-1
					Set FItem(i) = new CCategoryPrdItem
					FItem(i).FBrandNoticeGubun	= ArrRows(0,i)
					FItem(i).FBrandNoticeTitle	= ArrRows(1,i)
					FItem(i).FBrandNoticeText	= ArrRows(2,i)
				next
			ELSE
				FResultCount = 0
				exit sub
			end if
		end if
	End Sub

	'### 상품상세, 기프트톡 갯수.
	Public Function fnGetGiftTalkCount(byval itid)
		dim strSQL, vCount

		dim objConn, objCmd, rs

		set objConn = CreateObject("ADODB.Connection")
		objConn.Open Application("db_main") 
		Set objCmd = Server.CreateObject ("ADODB.Command")	

		strSQL = " SELECT TOP 1 talkCount FROM [db_board].[dbo].[tbl_gift_itemInfo] WHERE itemid = ? "

		objCmd.ActiveConnection = objConn
		objCmd.CommandType = adCmdText
		objCmd.CommandText = strSQL

		objCmd.Parameters.Append(objCmd.CreateParameter("itemid",adchar, adParamInput, Len(CStr(itid)), CStr(itid)))

		set rs = objCmd.Execute

		if  not rs.EOF  then
			vCount = rs("talkCount")
		else
			vCount = 0
		End if
		
		fnGetGiftTalkCount = vCount
		objConn.Close
		SET objConn = Nothing
	End Function

	Public Sub sbDetailCaptureViewCount(byval iid)
		dim strSQL
		strSQL = "exec [db_contents].[dbo].[sp_Ten_ItemDetailCaptureView] '" & iid & "'"
		rsget.CursorLocation = adUseClient
		rsget.Open strSQL, dbget, adOpenForwardOnly, adLockReadOnly
		If Not(rsget.EOF) then
			FCaptureExist = rsget(0)
			if (rsget(1)<3000) then FCaptureExist=0 ''컨텐츠 길이가 1만=7천=>3천 미만이면 원래 컨텐츠를 표시
		end if
		rsget.Close
	end Sub

    Public function sbDetailCaptureViewImages(byval iitemid)
        dim strSQL
        strSQL = "exec [db_contents].[dbo].[sp_Ten_ItemDetail_Capture_Images] " & iitemid & ""
		rsget.CursorLocation = adUseClient
		rsget.Open strSQL, dbget, adOpenForwardOnly, adLockReadOnly
		If Not(rsget.EOF) then
			sbDetailCaptureViewImages = rsget.getRows
		end if
		rsget.Close
		
	end function	

	'### 상품상세설명 동영상
	Public Function fnGetItemVideos(byval itemid, ByVal vgubun)
		dim strSQL, vCount
		strSQL = " SELECT TOP 1 videogubun, videotype, videourl, videowidth, videoheight, videofullurl FROM [db_item].[dbo].[tbl_item_videos] WHERE videogubun='"&vgubun&"' And itemid = '" & itemid & "'"
		'response.write strSQL
		rsget.open strSQL, dbget
		set Prd = new CCategoryPrdItem
		if  not rsget.EOF  then
			FResultCount = 1
			rsget.Movefirst
				Prd.FvideoUrl    	= rsget("videourl")
				Prd.FvideoWidth		= rsget("videowidth")
				Prd.FvideoHeight	= rsget("videoheight")
				Prd.Fvideogubun		= rsget("videogubun")
				Prd.FvideoType		= rsget("videotype")
				Prd.FvideoFullUrl	= rsget("videofullurl")
		Else
			FResultCount = 0
		End IF
		rsget.Close

	End Function

	'상품 판매 매장 목록
	Public Function GetSellOffShopList(itemid,minStock)
		dim strSQL

		if minStock="" then minStock=3

		if itemid <> "" then
			strSQL = "exec [db_summary].[dbo].[sp_Ten_getShopList_by_item] "&itemid&", " & minStock &" "
'			response.write strSQL

			dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"ITSHOP1",strSQL,5*60)
	        if (rsMem is Nothing) then Exit Function
	        if  not rsMem.EOF  then
				GetSellOffShopList	= rsMem.GetRows
			end if
			rsMem.Close
			
		end if
	End Function

	'// 제품 안전 인증 정보 - 정태훈 (2017-12-06)
	Public Sub getItemSafetyCert(byval itemid)
			dim strSQL,ArrRows,i

			strSQL = "exec [db_item].[dbo].[usp_WWW_Item_SafetyCert_Get] " & CStr(itemid)
			rsget.CursorLocation = adUseClient
			rsget.CursorType=adOpenStatic
			rsget.Locktype=adLockReadOnly
			rsget.Open strSQL, dbget

			If Not rsget.EOF Then
				ArrRows 	= rsget.GetRows
			End if
			rsget.close

			if isArray(ArrRows) then

			FResultCount = Ubound(ArrRows,2) + 1

			redim  FItem(FResultCount)

				For i=0 to FResultCount-1
					Set FItem(i) = new CCategoryPrdItem

					FItem(i).FSafetyYN		= ArrRows(0,i)
					FItem(i).FcertNum		= ArrRows(1,i)
					FItem(i).FcertDiv			= ArrRows(2,i)
					FItem(i).FcertUid			= ArrRows(3,i)
					FItem(i).FsafetyDiv		= ArrRows(4,i)
				next
			end if
	End Sub

	'카테고리 쿠폰 존재 검사
	Public function getCatebrandCPnTop1(byval itemid)
		dim strSQL,ArrRows,i
		'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
		Dim cTime , dummyName
		If (timer > 10 And Cint(timer/60) < 6) Then
			cTime = 60*1
			dummyName = "CBCPN_"&Cint(timer/60)
		Else
			cTime = 60*5
			dummyName = "CBCPN"
		End If

		strSQL = "exec [db_item].[dbo].[usp_Ten_CateBrandCouponTop1ByItemID] "&itemid&" "

		dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,dummyName,strSQL,cTime)
		if (rsMem is Nothing) then Exit function
		if  not rsMem.EOF  then
			getCatebrandCPnTop1 	= rsMem.GetRows
		end if
		rsMem.Close
	End function

    '// 보너스쿠폰 사용가능 여부 확인
	Public function getIsAvailableBonusCoupon(byval iItemid, byval sMakerid)
        dim strSQL
		getIsAvailableBonusCoupon = false
        strSQL = "exec [db_item].[dbo].[usp_Ten_Chk_BonusCouponAvailable] '" & iItemid & "','" & sMakerid & "'"
		rsget.CursorLocation = adUseClient
		rsget.Open strSQL, dbget, adOpenForwardOnly, adLockReadOnly
		If Not(rsget.EOF) then
			getIsAvailableBonusCoupon = rsget(0)<=0
		end if
		rsget.Close
	end function
End Class

'// 다이어리 상품 유무
Function isDiaryItem(itemid)
	dim strSql , isDiary

	strSQL = "SELECT top 1 itemid FROM db_diary2010.dbo.tbl_diarymaster where itemid = "&CStr(itemid)&" and isusing = 'Y' "
	rsget.CursorLocation = adUseClient
	rsget.CursorType=adOpenStatic
	rsget.Locktype=adLockReadOnly
	rsget.Open strSQL, dbget
	If Not rsget.EOF Then
		isDiary = true
	else
		isDiary = false
	End if
	rsget.close

	isDiaryItem = isDiary
end function
%>