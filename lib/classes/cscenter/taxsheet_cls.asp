<%

'##### 세금계산 요청서 레코드셋용 클래스 #####
class CBusiItem

	public FbusiIdx
	public FbusiNo
	public FbusiName
	public FbusiCEOName
	public FbusiAddr
	public FbusiType
	public FbusiItem
	public Fregdate
	public FconfirmYn

	public ForderIdx
	public FitemName
	public FtotalPrice
	public FtotalTax
	public FneoTaxNo

	public Fusername
	public Fusermail
	public Fusercell

    public Fipkumdate

    public function getMayTaxDate()
        getMayTaxDate = dateSerial(Year(date),Month(date),1)
        if IsNULL(Fipkumdate) then Exit function

        if datediff("m",Fipkumdate,date())=0 then
			'입급일이 현재달과 같으면 입금일로
			getMayTaxDate = dateSerial(Year(Fipkumdate),Month(Fipkumdate),Day(Fipkumdate))
		elseif datediff("m",Fipkumdate,date())=1 and datediff("d",date(),dateSerial(year(date),month(date),5))>=0 then
			'입급일이 지난달이면서 당월 5일 이전이라면 입금일로
			getMayTaxDate = dateSerial(Year(Fipkumdate),Month(Fipkumdate),Day(Fipkumdate))
		elseif datediff("m",Fipkumdate,date())>1 and datediff("d",date(),dateSerial(year(date),month(date),5))>=0 then
		    '입금일이 지난달 이전 5일이전이면 지난달 1일
		    getMayTaxDate = DateAdd("m",-1,dateSerial(Year(date),Month(date),1))
		else
			'그렇지 않으면 금월 1일로 세팅
			getMayTaxDate = dateSerial(Year(date),Month(date),1)
		end if
    end function

	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub

end Class


'##### 세금계산 요청서 클래스 #####
Class CBusi

	public FBusiList()
	public FTotalCount
	public FRectBusiIdx
	public FRectuserId
	public FRectorderserial

	'// 기본 변수값 지정
	Private Sub Class_Initialize()
		redim preserve FBusiList(0)

		FTotalCount       = 0
	End Sub

	Private Sub Class_Terminate()

	End Sub



	'// 등록 사업자등록증 목록 출력
	public Sub GetBusiList()
		dim SQL, lp

		'@ 데이터
		SQL =	" Select top 20 busiIdx, busiNo, busiName, busiCEOName, regdate, confirmYn " & VbCRLF
		SQL = SQL & " From db_order.[dbo].tbl_busiinfo " & VbCRLF
		SQL = SQL & " Where delYn = 'N' and userid='" & FRectuserId & "' " & VbCRLF
		SQL = SQL & " Order by busiIdx desc "

        ''비회원 추가.
        if (FRectuserId="") and (FRectorderserial<>"") then
            SQL =	" Select top 20  busiIdx, busiNo, busiName, busiCEOName, regdate, confirmYn " & VbCRLF
			SQL = SQL & " From db_order.[dbo].tbl_busiinfo " & VbCRLF
			SQL = SQL & " Where delYn = 'N' and guestOrderSerial='" & FRectorderserial & "' " & VbCRLF
			SQL = SQL & " Order by busiIdx desc "
        end if

		rsget.Open sql, dbget, 1

		'총 카운트
		FTotalCount = rsget.RecordCount

		redim FBusiList(FTotalCount)

		if Not(rsget.EOF or rsget.BOF) then

		    lp = 0
			do until rsget.eof
				set FBusiList(lp) = new CBusiItem

				FBusiList(lp).FbusiIdx		= rsget("busiIdx")
				FBusiList(lp).FbusiNo		= rsget("busiNo")
				FBusiList(lp).FbusiName		= rsget("busiName")
				FBusiList(lp).FbusiCEOName	= rsget("busiCEOName")
				FBusiList(lp).Fregdate		= rsget("regdate")
				FBusiList(lp).FconfirmYn		= rsget("confirmYn")

				lp=lp+1
				rsget.moveNext
			loop
		end if
		rsget.close

	end Sub



	'// 요청서 내용 보기
	public Sub GetBusiRead()
		dim SQL

		'## 사업자등록증 내용 접수
		SQL =	" Select busiIdx, busiNo, busiName, busiCEOName, regdate, confirmYn " & VbCRLF
		SQL = SQL & "		, busiAddr, busiType, busiItem " & VbCRLF
		SQL = SQL & " From db_order.[dbo].tbl_busiinfo " & VbCRLF
		SQL = SQL & " Where delYn = 'N' and BusiIdx = " & FRectBusiIdx

		rsget.Open sql, dbget, 1

		redim FBusiList(0)

		if Not(rsget.EOF or rsget.BOF) then

			set FBusiList(0) = new CBusiItem

			FBusiList(0).FbusiIdx		= rsget("busiIdx")
			FBusiList(0).FbusiNo		= rsget("busiNo")
			FBusiList(0).FbusiName		= rsget("busiName")
			FBusiList(0).FbusiCEOName	= rsget("busiCEOName")
			FBusiList(0).FbusiAddr		= rsget("busiAddr")
			FBusiList(0).FbusiType		= rsget("busiType")
			FBusiList(0).FbusiItem		= rsget("busiItem")
			FBusiList(0).Fregdate		= rsget("regdate")
			FBusiList(0).FconfirmYn		= rsget("confirmYn")

		end if
		rsget.close


		'## 정산내용 접수
		SQL =	"select idx " & VbCRLF
		SQL = SQL & "	,( select " & VbCRLF
		SQL = SQL & "			Case " & VbCRLF
		SQL = SQL & "				When count(idx)>1 Then max(itemname) + '외 ' + Cast((count(idx)-1) as varchar) + '건' " & VbCRLF
		SQL = SQL & "				Else max(itemname) " & VbCRLF
		SQL = SQL & "			End " & VbCRLF
		SQL = SQL & "		from db_order.[dbo].tbl_order_detail " & VbCRLF
		SQL = SQL & "		where orderserial='" & FRectorderserial & "' and itemid<>0 and cancelyn='N' group by orderserial " & VbCRLF
		SQL = SQL & "	) as itemname " & VbCRLF
		SQL = SQL & "	, subtotalprice, ipkumdate, accountdiv, IsNull(sumPaymentEtc, 0) as sumPaymentEtc " & VbCRLF
		SQL = SQL & "from db_order.[dbo].tbl_order_master " & VbCRLF
		SQL = SQL & "Where orderserial = '" & FRectorderserial & "'"
		rsget.Open sql, dbget, 1

		if Not(rsget.EOF or rsget.BOF) then

			FBusiList(0).ForderIdx		= rsget("idx")
			FBusiList(0).FitemName		= rsget("itemname")

			if (CStr(rsget("accountdiv")) = "7") or (CStr(rsget("accountdiv")) = "20") then
				'무통장, 실시간이체 : 전체금액
				FBusiList(0).FtotalPrice 	= rsget("subtotalprice")
				FBusiList(0).FtotalTax		= cLng(rsget("subtotalprice")/11)
			else
				'보조결제금액만
				FBusiList(0).FtotalPrice 	= rsget("sumPaymentEtc")
				FBusiList(0).FtotalTax		= cLng(rsget("sumPaymentEtc")/11)
			end if

            FBusiList(0).Fipkumdate     = rsget("ipkumdate")
		end if
		rsget.close


		'## 회원정보 접수
		SQL =	"select username, usercell, usermail " & VbCRLF
		SQL = SQL & "from db_user.[dbo].tbl_user_n " & VbCRLF
		SQL = SQL & "Where userid = '" & FRectuserId & "'"
		rsget.Open sql, dbget, 1

		if Not(rsget.EOF or rsget.BOF) then

			FBusiList(0).Fusername		= rsget("username")
			FBusiList(0).Fusercell		= rsget("usercell")
			FBusiList(0).Fusermail		= rsget("usermail")

		end if
		rsget.close


	end sub


	'// 세금계산서 프린트용 내용 접수
	public Sub GetBusiPrint()
		dim SQL

		'## 사업자등록증 내용 접수
		SQL =	" Select t1.neoTaxNo, t2.busiNo " & VbCRLF
		SQL = SQL & " From db_order.[dbo].tbl_taxSheet as t1 " & VbCRLF
		SQL = SQL & "	Join db_order.[dbo].tbl_busiinfo as t2 on t1.busiIdx=t2.busiIdx " & VbCRLF
		SQL = SQL & " Where t1.delYn = 'N' and t2.delYn = 'N' and t1.isueYn='Y' and t1.orderserial='" & FRectorderserial & "'"

		rsget.Open sql, dbget, 1

		'총 카운트
		FTotalCount = rsget.RecordCount

		redim FBusiList(0)

		if Not(rsget.EOF or rsget.BOF) then

			set FBusiList(0) = new CBusiItem

			FBusiList(0).FneoTaxNo		= rsget("neoTaxNo")
			FBusiList(0).FbusiNo		= rsget("busiNo")

		end if
		rsget.close
	end sub

end Class


'##### 세금계산 요청서 레코드셋용 클래스 #####
class CTaxItem

	public FtaxIdx
	public ForderIdx
	public Forderserial
	public Fuserid
	public Fitemname

	public FrepName
	public FrepEmail
	public FrepTel

	public FtotalPrice
	public FtotalTax
	public Fregdate
	public FisueYn
	public FneoTaxNo
	public FcurUserId
	public Fprintdate

	public FconfirmYn
	public FbusiIdx
	public FbusiNo
	public FbusiName
	public FbusiCEOName
	public FbusiAddr
	public FbusiType
	public FbusiItem

	public FisueDate
	public Fipkumdate
	public Fbuyname

    public FdelYn

    public Fbilldiv

    public Ftaxtype

    public function getResultStateName
        if (FisueYN="Y") then
            getResultStateName = "발급완료"
        else
            getResultStateName = "발급요청중"
        end if
    end function

	public function BillDivString()
		if Fbilldiv="01" then
			BillDivString ="소비자"
		elseif Fbilldiv="02" then
			BillDivString ="가맹점"
		elseif Fbilldiv="03" then
			BillDivString ="프로모션"
		elseif Fbilldiv="51" then
			BillDivString ="기타매출"
		elseif Fbilldiv="52" then
			BillDivString ="유아러걸"
		elseif Fbilldiv="53" then
			BillDivString ="아이띵소"
		else
			BillDivString ="기타"
		end if
	end function

	public function BillDivCompany()
		if (Fbilldiv="52") then
			BillDivCompany ="블루앤더블유"
		elseif (Fbilldiv="53") then
			BillDivCompany ="아이띵소"
		else
			BillDivCompany ="텐바이텐"
		end if
	end function

	public function TaxTypeString()
		if (Ftaxtype="Y") then
			TaxTypeString ="과세"
		elseif (Ftaxtype="N") then
			TaxTypeString ="면세"
		elseif (Ftaxtype="0") then
			TaxTypeString ="영세"
		else
			if ((FtotalTax <> "") and (CStr(FtotalTax) <> "0")) then
				TaxTypeString ="과세"
			else
				TaxTypeString = Ftaxtype
			end if
		end if
	end function

	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub

end Class


'##### 세금계산 요청서 클래스 #####
Class CTax

	public FTaxList()
	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount

	public FRecttaxIdx
	public FRectOrderserial

	public FRectSdate
	public FRectEdate
	public FRectchkTerm

	'// 기본 변수값 지정
	Private Sub Class_Initialize()
		redim preserve FTaxList(0)

		FCurrPage         = 1
		FPageSize         = 10
		FResultCount      = 0
		FScrollCount      = 10
		FTotalCount       = 0
	End Sub

	Private Sub Class_Terminate()

	End Sub


	'// 세금계산 요청서 목록 출력
	public Sub GetTaxList()
		dim SQL, AddSQL, lp

		SQL =	" select  top " & CStr(FPageSize*FCurrPage) & VbCRLF
		SQL = SQL&"	t1.taxIdx, t1.orderIdx, t1.orderserial, t1.userid " & VbCRLF
		SQL = SQL&"	, t1.itemname, t1.neoTaxNo " & VbCRLF
		SQL = SQL&"	, t1.totalPrice, t1.totalTax, t1.regdate, t1.isueYn, t1.billdiv, t2.confirmYn" & VbCRLF
		SQL = SQL&"	, t1.isueDate, t1.delYn, t2.busiName, t2.busiNo " & VbCRLF
		SQL = SQL&"	, t1.repName, t1.repEmail, t1.repTel " & VbCRLF
		SQL = SQL&"	, t2.busiCEOName, t2.busiAddr, t2.busiType, t2.busiItem " & VbCRLF
		SQL = SQL&" from db_order.[dbo].tbl_taxSheet as t1 " & VbCRLF
		SQL = SQL&"		Join db_order.[dbo].tbl_busiinfo as t2 on t1.busiIdx=t2.busiIdx " & VbCRLF
		SQL = SQL&" Where t1.orderserial='"&FRectOrderserial&"'"& VbCRLF
		SQL = SQL&" and t1.orderserial<>''"& VbCRLF
		SQL = SQL&" and t1.delYn = 'N' " & VbCRLF
		SQL = SQL&" Order by t1.taxIdx desc "

		'response.write sql
		rsget.pagesize = FPageSize
		rsget.Open sql, dbget, 1

		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

		redim FTaxList(FResultCount)

		if Not(rsget.EOF or rsget.BOF) then

		    lp = 0
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FTaxList(lp) = new CTaxItem

				FTaxList(lp).FtaxIdx		= rsget("taxIdx")
				FTaxList(lp).ForderIdx		= rsget("orderIdx")
				FTaxList(lp).Forderserial	= rsget("orderserial")
				FTaxList(lp).Fuserid		= rsget("userid")
				FTaxList(lp).Fitemname		= rsget("itemname")
				FTaxList(lp).FtotalPrice	= rsget("totalPrice")
				FTaxList(lp).FtotalTax		= rsget("totalTax")
				FTaxList(lp).Fregdate		= rsget("regdate")
				FTaxList(lp).FisueYn		= rsget("isueYn")
				FTaxList(lp).FconfirmYn		= rsget("confirmYn")
				FTaxList(lp).FisueDate		= rsget("isueDate")

                FTaxList(lp).FbusiNo        = rsget("busiNo")
                FTaxList(lp).FbusiName      = rsget("busiName")
                FTaxList(lp).FdelYn         = rsget("delYn")

                FTaxList(lp).Fbilldiv        = rsget("billdiv")

				FTaxList(lp).FrepName		= rsget("repName")
				FTaxList(lp).FrepEmail		= rsget("repEmail")
				FTaxList(lp).FrepTel		= rsget("repTel")

				FTaxList(lp).FbusiCEOName	= rsget("busiCEOName")
				FTaxList(lp).FbusiAddr		= rsget("busiAddr")
				FTaxList(lp).FbusiType		= db2html(rsget("busiType"))
				FTaxList(lp).FbusiItem		= db2html(rsget("busiItem"))

                FTaxList(lp).FneoTaxNo = rsget("neoTaxNo")
				lp=lp+1
				rsget.moveNext
			loop
		end if
		rsget.close

	end Sub



	'// 세금계산 요청서 내용 보기
	public Sub GetTaxRead()
		dim SQL

		SQL =	" select  top " & CStr(FPageSize*FCurrPage) & VbCRLF
		SQL = SQL & "	t1.taxIdx, t1.orderIdx, t1.orderserial, t1.userid " & VbCRLF
		SQL = SQL & "	, t1.itemname, t1.repName, t1.repEmail, t1.repTel " & VbCRLF
		SQL = SQL & "	, t1.totalPrice, t1.totalTax, t1.regdate, t1.isueYn " & VbCRLF
		SQL = SQL & "	, t1.neoTaxNo, t1.curUserId, t1.printdate, t1.taxtype " & VbCRLF
		SQL = SQL & "	, t2.confirmYn, t1.busiIdx, IsNull(t1.billdiv, '01') as billdiv " & VbCRLF
		SQL = SQL & "	, t2.busiNo, t2.busiName, t2.busiCEOName, t2.busiAddr, t2.busiType, t2.busiItem " & VbCRLF
		SQL = SQL & "	, t3.ipkumdate, t1.isueDate, t1.delYn " & VbCRLF
		SQL = SQL & " from db_order.[dbo].tbl_taxSheet as t1 " & VbCRLF
		SQL = SQL & "		Join db_order.[dbo].tbl_busiinfo as t2 on t1.busiIdx=t2.busiIdx " & VbCRLF
		SQL = SQL & "		left Join db_order.[dbo].tbl_order_master as t3 on t1.orderIdx=t3.idx " & VbCRLF
		SQL = SQL & " Where 1=1 " & VbCRLF
		SQL = SQL & "	and t1.taxIdx = " & FRecttaxIdx

		rsget.Open sql, dbget, 1

		redim FTaxList(0)

		if Not(rsget.EOF or rsget.BOF) then

			set FTaxList(0) = new CTaxItem

			FTaxList(0).FtaxIdx			= rsget("taxIdx")
			FTaxList(0).ForderIdx		= rsget("orderIdx")
			FTaxList(0).Forderserial	= rsget("orderserial")
			FTaxList(0).Fuserid			= rsget("userid")
			FTaxList(0).Fitemname		= rsget("itemname")
			FTaxList(0).FrepName		= rsget("repName")
			FTaxList(0).FrepEmail		= rsget("repEmail")
			FTaxList(0).FrepTel			= rsget("repTel")
			FTaxList(0).FtotalPrice		= rsget("totalPrice")
			FTaxList(0).FtotalTax		= rsget("totalTax")
			FTaxList(0).Fregdate		= rsget("regdate")
			FTaxList(0).FisueYn			= rsget("isueYn")
			FTaxList(0).FneoTaxNo		= rsget("neoTaxNo")
			FTaxList(0).FcurUserId		= rsget("curUserId")
			FTaxList(0).Fprintdate		= rsget("printdate")

			FTaxList(0).Ftaxtype		= rsget("taxtype")

			FTaxList(0).FconfirmYn		= rsget("confirmYn")
			FTaxList(0).FbusiIdx		= rsget("busiIdx")
			FTaxList(0).FbusiNo			= rsget("busiNo")
			FTaxList(0).FbusiName		= rsget("busiName")
			FTaxList(0).FbusiCEOName	= rsget("busiCEOName")
			FTaxList(0).FbusiAddr		= rsget("busiAddr")
			FTaxList(0).FbusiType		= db2html(rsget("busiType"))
			FTaxList(0).FbusiItem		= db2html(rsget("busiItem"))
			FTaxList(0).Fipkumdate		= rsget("ipkumdate")
			FTaxList(0).FisueDate		= rsget("isueDate")

            FTaxList(0).FdelYn           = rsget("delYn")

            FTaxList(0).Fbilldiv          = rsget("billdiv")

		end if
		rsget.close

	end sub

	public FPrevID
	public FNextID

	'// 이전 페이지 검사
	public Function HasPreScroll()
		HasPreScroll = StartScrollPage > 1
	end Function

	'// 다음 페이지 검사
	public Function HasNextScroll()
		HasNextScroll = FTotalPage > StartScrollPage + FScrollCount -1
	end Function

	'// 첫페이지 산출
	public Function StartScrollPage()
		StartScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	end Function
end Class


'#### 사용자 함수 ####

'// 사업자 등록 여부 확인
Function chkRegBusi(uid)
	Dim SQL

	SQL = "Select count(busiIdx) " & VbCRLF
	SQL = SQL& "From db_order.[dbo].tbl_busiInfo " & VbCRLF
	SQL = SQL& "Where userid='" & userid & "'"

	rsget.Open sql, dbget, 1
		chkRegBusi = rsget(0)
	rsget.Close

End Function


'// 비회원 사업자 등록 여부 확인
Function chkRegBusiByOrderserial(iorderserial)
	Dim SQL

	SQL =	"Select count(busiIdx) " & VbCRLF
	SQL = SQL& "From db_order.[dbo].tbl_busiInfo " & VbCRLF
	SQL = SQL& "Where guestOrderSerial='" & iorderserial & "'"

	rsget.Open sql, dbget, 1
		chkRegBusiByOrderserial = rsget(0)
	rsget.Close

End Function

'// 재발급 요청 확인
Function chkRegTax(ordSn)
	Dim SQL

	SQL = 	"Select isueYn " & VbCRLF
	SQL = SQL& "From db_order.[dbo].tbl_taxSheet " & VbCRLF
	SQL = SQL& "Where orderserial='" & ordSn & "'" & VbCRLF
	SQL = SQL& "	and delYn='N'"
	rsget.Open sql, dbget, 1
		if rsget.EOF or rsget.BOF then
			chkRegTax = "none"
		else
			chkRegTax = rsget(0)
		end if
	rsget.Close

End Function

'// 현재 주차 반환
Function nowWeekCount(nowdate)
	'변수 선언
	dim firstDay

	'지정일자의 첫달 지정
	firstDay = DateSerial(year(nowdate),month(nowdate),01)

	'주차 반환
	nowWeekCount = DatePart("ww",nowdate) - DatePart("ww",firstDay) + 1
End Function
%>
