<%
Class cGiftcardOrderItem
	public Fgiftorderserial
	public Fregdate
	public Ftotalsum
	public Fipkumdiv
	public Fcancelyn
	public Fsubtotalprice
	public FCarditemname
	public Fjumundiv
	public Fbuyhp
	public FbuyPhone
	public Fbuyemail
	public Fbuyname
	public FsendDate
	public Fsendhp
	public Fsendemail
	public Freqhp
	public Freqemail
	public FbookingYn
	public FbookingDate
	public Faccountdiv
	public Faccountname
	public Faccountno
	public Fipkumdate
	public Fcanceldate
	public FsendDiv
	public Fpaydateid                  ''변경 //
	public FdesignId
	public FMMSTitle
	public FMMSContent
	public FemailTitle
	public FemailContent
	public Fsmallimage
	public FcardSellCash
	public FInsureCd
	public FcashreceiptReq
	public FAuthCode
	public FcardItemid
	public FcardOption
	public FcardOptionName
	public FresendCnt
	public FResultmsg
	public FUserImage
	public FmasterCardCode

	Public Function GetSmallImage()
		if (Left(FSmallImage, 4) = "http") then
			GetSmallImage = FSmallImage
		else
			GetSmallImage = webImgUrl & FSmallImage
		end if
	End Function

    function GetAccountdivName()
        dim oacctdiv
        if IsNULL(FAccountdiv) then Exit function
        oacctdiv = Trim(FAccountdiv)

        select case oacctdiv
            case "7"
                : GetAccountdivName = "무통장"
            case "100"
                : GetAccountdivName = "신용카드"
            case "20"
                : GetAccountdivName = "실시간계좌이체"
            case "80"
                : GetAccountdivName = "All@멤버쉽카드"
            case "50"
                : GetAccountdivName = "외부몰결제"
            case "30"
                : GetAccountdivName = "포인트"
            case "90"
                : GetAccountdivName = "상품권"
            case "110"
                : GetAccountdivName = "신용카드+OK캐쉬백"
            case "400"
                : GetAccountdivName = "핸드폰결제"
            case else
                : GetAccountdivName = ""
        end select
    end function

    function GetIpkumDivName()
        dim oipkumdiv
        if IsNULL(Fipkumdiv) then Exit function
        oipkumdiv = Trim(Fipkumdiv)

        select case oipkumdiv
            case "0"
                : GetIpkumDivName = "주문실패"
            case "1"
                : GetIpkumDivName = "주문실패"
            case "2"
                : GetIpkumDivName = "주문접수"
            case "3"
                : GetIpkumDivName = "입금대기"
            case "4"
                : GetIpkumDivName = "결제완료"
            case "5"
                : GetIpkumDivName = "전송대기"
            case "8"
                : GetIpkumDivName = "전송완료"
            case "9"
                : GetIpkumDivName = "주문취소"
            case else
                : GetIpkumDivName = ""
        end select
    end function

    function GetJumunDivColor()
        dim ojumundiv
        GetJumunDivColor = "#000000"
        if IsNULL(Fjumundiv) then Exit function
        ojumundiv = Trim(Fjumundiv)

        select case ojumundiv
            case "1"
                : GetJumunDivColor = "crGrn"
            case "3"
                : GetJumunDivColor = "crGrn"
            case "5"
                : GetJumunDivColor = "cMt0V15"
            case "7"
                : GetJumunDivColor = "crRedV15"
            case "9"
                : GetJumunDivColor = "cr555"
            case else
                : GetJumunDivColor = "cr000"
        end select
    end function

    function GetJumunDivName()
        dim ojumundiv
        if IsNULL(Fjumundiv) then Exit function
        ojumundiv = Trim(Fjumundiv)

        select case ojumundiv
            case "1"
                : GetJumunDivName = "결제대기"
            case "3"
                : GetJumunDivName = "전송대기"
            case "5"
                : GetJumunDivName = "전송완료"
            case "7"
                : GetJumunDivName = "등록완료"
            case "9"
                : GetJumunDivName = "주문취소"
            case else
                : GetJumunDivName = ""
        end select
    end function

	function getSendDivName()
		Select Case FsendDiv
			Case "S"
				getSendDivName = "모바일"
			Case "E"
				getSendDivName = "모바일 / e-mail"
		End Select
	end function

    ''주문취소 (웹 취소가능)
    public function IsWebOrderCancelEnable()
        IsWebOrderCancelEnable = false
        if (Not IsValidOrder) then Exit function

        IsWebOrderCancelEnable = (Fjumundiv<7)

    end function

    public function IsValidOrder()
        IsValidOrder = (FIpkumdiv>1) and (FCancelyn="N")
    end function

    ''=================================================================================================
    '' 각종 증명서 관련  R(현금영수증 요청), S(현금영수증발행) ,T(계산서요청),U(계산서발행)

    ''전자보증서 존재
    public function IsInsureDocExists()
        IsInsureDocExists = (FInsureCd="0")
    end function

	'증빙서류신청이 있었는지
    public function IsPaperRequestExist()
        IsPaperRequestExist = false

        if (IsPaperRequested or IsPaperFinished) then
        	IsPaperRequestExist = true
        end if
    end function

	'증빙서류 발급신청상태인지
    public function IsPaperRequested()
        IsPaperRequested = false

        if (Faccountdiv = "7") or (Faccountdiv = "20") then
        	if ((FcashreceiptReq = "R") or (FcashreceiptReq = "T")) and ( FAuthCode = "") then
        		IsPaperRequested = true
        	end if
		else
			if (FcashreceiptReq = "R") or (FcashreceiptReq = "T") then
				IsPaperRequested = true
			end if
        end if
    end function

	'증빙서류 발급완료상태인지
    public function IsPaperFinished()
        IsPaperFinished = false

        if (Faccountdiv = "7") or (Faccountdiv = "20") then
        	if ((FcashreceiptReq = "R") or (FcashreceiptReq = "T")) and (FAuthCode <> "") then
        		IsPaperFinished = true
        	elseif (FAuthCode <> "") then
        		IsPaperFinished = true
        	end if
		else
			if (FcashreceiptReq = "S") or (FcashreceiptReq = "U") then
				IsPaperFinished = true
			end if
        end if
    end function

	'증빙서류 종류
    public function GetPaperType()
        GetPaperType = ""

        if (FcashreceiptReq = "R") or (FcashreceiptReq = "S") then
        	GetPaperType = "R"
        	Exit function
        end if

        if (FcashreceiptReq = "T") or (FcashreceiptReq = "U") then
        	GetPaperType = "T"
        	Exit function
        end if

        if ((Faccountdiv = "7") or (Faccountdiv = "20")) and (FAuthCode <> "") then
        	GetPaperType = "R"
        end if
    end function

    ''이니시스 실시간 이체시 같이 발급되는 현금영수증 (2011-04-18 이전)
    public function IsDirectBankCashreceiptExists()
        IsDirectBankCashreceiptExists = ((Faccountdiv = "20") and (FAuthCode<>"") and (FcashreceiptReq="") and FIpkumdiv>3)
    end function

	Private Sub Class_Initialize()
	End Sub
	Private Sub Class_Terminate()
	End Sub
end Class


Class cGiftcardOrder
	public FItemList()
	public FOneItem
	public FTotalCount
	public FResultCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FScrollCount
	public FUserID
	public Fgiftorderserial


	public Sub getGiftcardOrderList()
		dim sqlStr, i, pagetop
		sqlStr = "EXEC [db_my10x10].[dbo].[sp_Ten_GiftCard_orderList_Cnt] '" & FUserID & "','" & FPageSize & "','',''"
	    rsget.CursorLocation = adUseClient
	    rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly
	    If Not rsget.Eof Then
		    FTotalcount = rsget(0)
		    FResultcount = FTotalcount
		    FTotalPage	= rsget(1)
		End If
		rsget.close

		'지정페이지가 전체 페이지보다 클 때 함수종료
		if Cint(FCurrPage)>Cint(FTotalPage) then
			FResultCount = 0
			exit sub
		end if

		If FTotalcount > 0 Then
			pagetop = FPageSize*FCurrPage

			sqlStr = "EXEC [db_my10x10].[dbo].[sp_Ten_GiftCard_orderList] '" & FUserID & "','" & pagetop & "','',''"
	        rsget.CursorLocation = adUseClient
	        rsget.pagesize = FPageSize
	        rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly

			FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
	        if (FResultCount<1) then FResultCount=0
			redim preserve FItemList(FResultCount)
			
	        i = 0
	        if Not rsget.Eof then
	        	rsget.absolutepage = FCurrPage
				do until rsget.Eof
					set FItemList(i) = new cGiftcardOrderItem
					FItemList(i).Fgiftorderserial   = rsget("giftOrderSerial")
					FItemList(i).Fregdate			= rsget("regdate")
					FItemList(i).Ftotalsum			= rsget("totalsum")
					FItemList(i).Fipkumdiv			= rsget("ipkumdiv")
					FItemList(i).Fcancelyn			= rsget("cancelyn")
					FItemList(i).Fsubtotalprice		= rsget("subtotalprice")
					FItemList(i).FCarditemname		= rsget("Carditemname")
					FItemList(i).Fjumundiv			= rsget("jumundiv")
					FItemList(i).FcardOptionName	= rsget("cardOptionName")

					i=i+1
					rsget.movenext
				loop
			End If
			rsget.close
		End If
	End Sub


	public Sub getGiftcardOrderDetail()
		dim sqlStr, i

		sqlStr = "EXEC [db_my10x10].[dbo].[sp_Ten_GiftCard_orderDetail] '" & FUserID & "','" & Fgiftorderserial & "'"
        rsget.CursorLocation = adUseClient
        rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly
        FResultcount = rsget.Recordcount

        if Not rsget.Eof then
			set FOneItem = new cGiftcardOrderItem
			FOneItem.Fgiftorderserial	= rsget("giftOrderSerial")
			FOneItem.Fregdate			= rsget("regdate")
			FOneItem.Ftotalsum			= rsget("totalsum")
			FOneItem.Fipkumdiv			= rsget("ipkumdiv")
			FOneItem.Fcancelyn			= rsget("cancelyn")
			FOneItem.Fsubtotalprice		= rsget("subtotalprice")
			FOneItem.FCarditemname		= rsget("Carditemname")
			FOneItem.Fjumundiv			= rsget("jumundiv")
			FOneItem.Fbuyhp				= rsget("buyhp")
			FOneItem.FbuyPhone			= rsget("buyPhone")
			FOneItem.Fbuyemail			= rsget("buyemail")
			FOneItem.Fbuyname			= rsget("buyname")
			FOneItem.FsendDate			= rsget("sendDate")
			FOneItem.Fsendhp			= rsget("sendhp")
			FOneItem.Fsendemail			= rsget("sendemail")
			FOneItem.Freqhp				= rsget("reqhp")
			FOneItem.Freqemail			= rsget("reqemail")
			FOneItem.FbookingYn			= rsget("bookingYn")
			FOneItem.FbookingDate		= rsget("bookingDate")
			FOneItem.Faccountdiv		= rsget("accountdiv")
			FOneItem.Faccountname		= rsget("accountname")
			FOneItem.Faccountno			= rsget("accountno")
			FOneItem.Fipkumdate			= rsget("ipkumdate")
			FOneItem.Fcanceldate		= rsget("canceldate")
			FOneItem.FsendDiv			= rsget("sendDiv")
			FOneItem.Fpaydateid		    = rsget("paydateid")
			FOneItem.FdesignId			= rsget("designid")
			FOneItem.FMMSTitle			= rsget("MMSTitle")
			FOneItem.FMMSContent		= rsget("MMSContent")
			FOneItem.FemailTitle		= rsget("emailTitle")
			FOneItem.FemailContent		= rsget("emailContent")
			FOneItem.Fsmallimage		= webImgUrl & "/giftcard/small/" & GetImageSubFolderByItemid(rsget("cardItemid")) & "/" & rsget("smallImage")
			FOneItem.FcardSellCash		= rsget("cardSellCash")
			FOneItem.FcashreceiptReq	= rsget("cashreceiptreq")
			FOneItem.FAuthCode			= rsget("authcode")
			FOneItem.FInsureCd			= rsget("insureCd")
			FOneItem.FcardItemid		= rsget("cardItemid")
			FOneItem.FcardOption		= rsget("cardOption")
			FOneItem.FcardOptionName	= rsget("cardOptionName")
			FOneItem.FResultmsg         = rsget("Resultmsg")
			FOneItem.FresendCnt         = rsget("resendCnt")
			FOneItem.FUserImage			= Trim(rsget("userImage"))
			FOneItem.FmasterCardCode	= rsget("masterCardCode")

		End If
		rsget.close
	End Sub

	'// 이번달 총 주무 금액 반환
	public Function getGiftcardOrderTotalPrice()
		dim sqlStr
		sqlStr = "Select sum(totalsum) as monthlyTotal "
		sqlStr = sqlStr & " From db_order.dbo.tbl_giftcard_order "
		sqlStr = sqlStr & " Where userid='" & FUserID & "'"
		sqlStr = sqlStr & "		and datediff(month,regdate,getdate())=0 "
		sqlStr = sqlStr & "		and cancelyn='N' "
		sqlStr = sqlStr & "		and ipkumdiv Not in ('0','1','9') "
		sqlStr = sqlStr & " group by userid "
		rsget.Open sqlStr, dbget, 1
		if Not rsget.Eof then
			getGiftcardOrderTotalPrice = rsget(0)
		else
			getGiftcardOrderTotalPrice = 0
		end if
		rsget.Close
	end Function

	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 10
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
	End Sub
	Private Sub Class_Terminate()
	End Sub


	public Function HasPreScroll()
		HasPreScroll = StartScrollPage > 1
	end Function

	public Function HasNextScroll()
		HasNextScroll = FTotalPage > StartScrollPage + FScrollCount -1
	end Function

	public Function StartScrollPage()
		StartScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	end Function
end Class

Class COrderParams
	public Fidx
	public FgiftOrderSerial
    public Fjumundiv
    public Fuserid
    public Fipkumdiv
    public Faccountdiv
    public Fsubtotalprice
    public Fdiscountrate
    public FcardItemid
    public FcardOption
    public FcardPrice
    public Faccountname
    public Faccountno
    public Fbuyname
    public Fbuyphone
    public Fbuyhp
    public Fbuyemail
    public Fsendhp
    public Fsendemail
    public Freqhp
    public Freqemail
    public FbookingYN
    public FbookingDate
    public FMMSTitle
    public FMMSContent
    public FsendDiv
    public Fdesignid
    public FemailTitle
    public FemailContent
    public Freferip
    public Fuserlevel
    public FuserImage
    public Frdsite

    ''카드사 코드등.
    public FPayEtcResult

	public Fresultmsg
	public Fauthcode
	public Fpaygatetid
	public IsSuccess

    ''가상계좌
    public FIsCyberAccount
    public FFINANCECODE
    public FACCOUNTNUM
    public FCLOSEDATE

    Private Sub Class_Initialize()
        Fdiscountrate = 1
        Fipkumdiv     = "0"

        Fsubtotalprice  = 0

        FIsCyberAccount = false
	End Sub

	Private Sub Class_Terminate()

	End Sub
end Class


class COrderGiftCard
	public FgiftOrderSerial
	public FDiscountRate
	public FIDX

    public FItemList()
	public FRectUserID

	Private Sub Class_Initialize()
		redim FItemList(0)
		FDiscountRate = 1
	End Sub

	Private Sub Class_Terminate()
	End Sub

    '' 주문 내역 저장. PG 통신 이전.
    public function SaveOrderDefaultDB(byval iOrderParams, byRef ErrStr)
        dim sqlStr, iid, masterCardCode
        dim rndjumunno

        Randomize
		rndjumunno = CLng(Rnd * 100000) + 1
		rndjumunno = CStr(rndjumunno)

		'' Tran 시작.
		dbget.BeginTrans
		On Error Resume Next
''rw rndjumunno
''rw iOrderParams.FcardItemid
''rw iOrderParams.FcardOption
''rw CStr(iOrderParams.Fuserid)
''rw iOrderParams.Fbuyname
''rw iOrderParams.Fbuyphone
''rw iOrderParams.Freqhp      '''??
''rw iOrderParams.Freqemail   '''??
''rw iOrderParams.FcardPrice
''rw iOrderParams.Fjumundiv
''rw iOrderParams.Faccountdiv
''rw iOrderParams.Faccountname '''
''rw iOrderParams.Faccountno   '''
''rw iOrderParams.Fipkumdiv
''rw iOrderParams.Fdiscountrate
''rw CLNG(iOrderParams.Fsubtotalprice)
''rw iOrderParams.Freferip
''rw iorderParams.FsendDiv
''rw iorderParams.FbookingYn   '''
''rw iorderParams.FbookingDate
''rw iorderParams.FdesignId
''rw iorderParams.FMMSTitle
''rw iorderParams.FMMSContent
''rw iorderParams.FemailTitle
''rw iorderParams.FemailContent
''rw iOrderParams.FUserLevel


		sqlStr = "select * from [db_order].[dbo].tbl_giftcard_order where 1=0"
		rsget.Open sqlStr,dbget,1,3
		rsget.AddNew
			rsget("giftOrderSerial")	= rndjumunno
			rsget("cardItemid")		= iOrderParams.FcardItemid
			rsget("cardOption")		= iOrderParams.FcardOption
		    rsget("userid")         = CStr(iOrderParams.Fuserid)
    		rsget("buyname")        = iOrderParams.Fbuyname
    		rsget("buyemail")       = iOrderParams.Fbuyemail
    		rsget("buyhp")          = iOrderParams.Fbuyhp
    		rsget("buyphone")       = iOrderParams.Fbuyphone
    		rsget("sendhp")         = iOrderParams.Fsendhp
    		rsget("sendemail")		= iOrderParams.Fsendemail
    		rsget("reqhp")          = iOrderParams.Freqhp
    		rsget("reqemail")       = iOrderParams.Freqemail
    		rsget("totalsum")       = CLNG(iOrderParams.FcardPrice)		'Gift카드 표시가격
		    rsget("jumundiv")       = iOrderParams.Fjumundiv
    		rsget("accountdiv")     = iOrderParams.Faccountdiv
    		rsget("accountname")    = iOrderParams.Faccountname
    		rsget("accountno")      = iOrderParams.Faccountno
		    rsget("ipkumdiv")       = iOrderParams.Fipkumdiv
    		rsget("cancelyn")       = "N"
    		rsget("discountrate")   = iOrderParams.Fdiscountrate
    		rsget("subtotalprice")  = CLNG(iOrderParams.Fsubtotalprice)
    		rsget("miletotalprice")	= 0
    		rsget("tencardspend")	= 0
            rsget("referip")		= iOrderParams.Freferip
    		rsget("sumPaymentEtc")	= 0
    		rsget("sendDiv")		= iorderParams.FsendDiv
    		rsget("bookingYn")		= iorderParams.FbookingYn
    		if (iorderParams.FbookingDate<>"") then
    		    rsget("bookingDate")	= iorderParams.FbookingDate
    	    end if
    		rsget("designId")		= iorderParams.FdesignId

    		rsget("MMSTitle")		= iorderParams.FMMSTitle
    		rsget("MMSContent")		= iorderParams.FMMSContent
    		rsget("emailTitle")		= iorderParams.FemailTitle
    		rsget("emailContent")	= iorderParams.FemailContent

    		rsget("userImage")		= iorderParams.FuserImage
    		rsget("rdsite")			= iorderParams.Frdsite

    		if (iOrderParams.FUserLevel<>"") then rsget("userlevel") = iOrderParams.FUserLevel
    		if (iorderParams.FbookingYn="Y") then                           ''확인 확인.
    			rsget("sendDate")		= NULL                              '''iorderParams.FbookingDate
    		else
    			rsget("sendDate")		= now()
    		end if

    		rsget.update
			iid = rsget("idx")
		rsget.close

		IF (Err) then
		    ErrStr = "[Err-ORD-001.]" & Err.Description & rndjumunno
		    dbget.RollBackTrans
		    On Error Goto 0
		    Exit Function
		end if


		'' 실 주문번호/카드코드 Setting
		if (Not IsNull(iid)) and (iid<>"") then
			dim sh: sh=0
			giftOrderSerial = "G" & Mid(replace(CStr(DateSerial(Year(now),month(now),Day(now))),"-",""),4,256)
			giftOrderSerial = giftOrderSerial & Format00(5,Right(CStr(iid),5))
			masterCardCode = getMasterCode(iid,16,sh)

			sqlStr = " update [db_order].[dbo].tbl_giftcard_order" + vbCrlf
			sqlStr = sqlStr + " set giftOrderSerial='" + giftOrderSerial + "'" + vbCrlf
			sqlStr = sqlStr + " ,masterCardCode='" + masterCardCode + "'" + vbCrlf
			sqlStr = sqlStr + " where idx=" + CStr(iid) + vbCrlf

			dbget.Execute sqlStr

			'# 기프트카드 인증번호 발급 로그 저장
			Call putGiftCardMasterCDLog(giftOrderSerial,masterCardCode,sh-1)

			IF (Err) then
    		    ErrStr = "[Err-ORD-002]" & Err.Description
    		    dbget.RollBackTrans
    		    On Error Goto 0
    		    Exit Function
    		end if
	    end if

        IF (Err) then
		    ErrStr = "[Err-ORD-003]" &Err.Description
		    dbget.RollBackTrans
		    On Error Goto 0
		    Exit Function
		ELSE
		    dbget.CommitTrans
		    On Error Goto 0
		end if

	    SaveOrderDefaultDB = giftOrderSerial

        FgiftOrderSerial = giftOrderSerial
	    FIDX = iid

    end function


    '' PG 통신 후 결제 결과 저장.
    public function SaveOrderResultDB(byval iOrderParams, byRef ErrStr)
        dim sqlStr
		dim itemcouponidxArr
        dim IsRealTimePay

        '' Tran 시작.
		dbget.BeginTrans
		On Error Resume Next

        IsRealTimePay = (iOrderParams.Faccountdiv="100") or (iOrderParams.Faccountdiv="110") or (iOrderParams.Faccountdiv="80") or (iOrderParams.Faccountdiv="90") or (iOrderParams.Faccountdiv="20") or (iOrderParams.Faccountdiv="400")
        ''무통장 0원 바로결제. 2010-11 추가
        IsRealTimePay = IsRealTimePay or ((iOrderParams.Faccountdiv="7") and (iorderParams.Fsubtotalprice=0))

        IF (Err) then
		    ErrStr = "[Err-ORD-011]" & Err.Description
		    dbget.RollBackTrans
		    On Error Goto 0
		    Exit Function
		end if

		''' 주문 마스타 서머리 재저장
		sqlStr = " update [db_order].[dbo].tbl_giftcard_order" + vbCrlf
		if (IsRealTimePay) then
			if (iOrderParams.IsSuccess) then
				sqlStr = sqlStr + " Set ipkumdiv='4'" + vbCrlf
				sqlStr = sqlStr + " ,jumunDiv='3'" + vbCrlf
				sqlStr = sqlStr + " ,ipkumdate=getdate()" + vbCrlf
			else
				sqlStr = sqlStr + " Set ipkumdiv='1'" + vbCrlf
			end if
	    else
	        ''가상계좌/무통장의 경우 ''2010-04추가
	        if (iOrderParams.FIsCyberAccount) then
    	        if (iOrderParams.IsSuccess) then
    	            sqlStr = sqlStr + " Set accountno='" + iorderParams.Faccountno + "'" + vbCrlf
    	            sqlStr = sqlStr + " ,accountname='" + iorderParams.Faccountname + "'" + vbCrlf
    	            sqlStr = sqlStr + " ,ipkumdiv='2'" + vbCrlf  ''주문접수==입금대기=>2 로
    	        else
    	            ''가상계좌 발행 실패
    	            if (iorderParams.Faccountno="") then
    	                sqlStr = sqlStr + " Set ipkumdiv='1'" + vbCrlf
    	            end if
    	        end if
    	    end if
		end if

		if (iOrderParams.Fpaygatetid<>"") then
		    sqlStr = sqlStr + " ,paydateid='" + iOrderParams.Fpaygatetid + "'" + vbCrlf
		end if

		if (iOrderParams.Fresultmsg<>"") then
		    sqlStr = sqlStr + " ,resultmsg=convert(varchar(100),'" + iOrderParams.Fresultmsg + "')" + vbCrlf
		end if

		if (iOrderParams.Fauthcode<>"") then
		    sqlStr = sqlStr + " ,authcode=convert(varchar(64),'" + iOrderParams.Fauthcode + "')" + vbCrlf
		end if

		sqlStr = sqlStr + " where giftOrderSerial='" + CStr(FgiftOrderSerial) + "'" + vbCrlf
''response.write sqlStr
		dbget.Execute(sqlStr)

        IF (Err) then
		    ErrStr = "[Err-ORD-012]" & Err.Description
		    dbget.RollBackTrans
		    On Error Goto 0
		    Exit Function
		end if

        ''############ 가상계좌 로그 ############ // 로그 사용 안함.
''        if  (iOrderParams.IsSuccess) and (iOrderParams.FIsCyberAccount) and (iOrderParams.FCLOSEDATE<>"") then
''            sqlStr = " insert into db_order.dbo.tbl_order_CyberAccountLog"
''            sqlStr = sqlStr & " (orderserial, differencekey, userid, FINANCECODE, ACCOUNTNUM, subtotalPrice, CLOSEDATE, RefIP)"
''            sqlStr = sqlStr & " values('" & FgiftOrderSerial & "'"
''            sqlStr = sqlStr & " ,0"
''            sqlStr = sqlStr & " ,'" & iOrderParams.Fuserid & "'"
''            sqlStr = sqlStr & " ,'" & iOrderParams.FFINANCECODE & "'"
''            sqlStr = sqlStr & " ,'" & iOrderParams.FACCOUNTNUM & "'"
''            sqlStr = sqlStr & " ,'" & iOrderParams.Fsubtotalprice & "'"
''            sqlStr = sqlStr & " ,'" & Left(iOrderParams.FCLOSEDATE,4) + "-" + Mid(iOrderParams.FCLOSEDATE,5,2) + "-" + Mid(iOrderParams.FCLOSEDATE,7,2) & "'"
''            sqlStr = sqlStr & " ,'" & iOrderParams.Freferip & "'"
''            sqlStr = sqlStr & " )"
''
''            dbget.Execute sqlStr
''
''            IF (Err) then
''                ErrStr = "[Err-ORD-016.1]" &Err.Description
''    		    dbget.RollBackTrans
''    		    On Error Goto 0
''    		    Exit Function
''    		End IF
''        end if

        IF (Err) then
		    ErrStr = "[Err-ORD-017]" &Err.Description
		    dbget.RollBackTrans
		    On Error Goto 0
		    Exit Function
		ELSE
		    dbget.CommitTrans
		    On Error Goto 0
		end if

    end function

	public function SaveOrderSendOKDB(isn)
        dim sqlStr

        '' Tran 시작.
		dbget.BeginTrans
		On Error Resume Next

		sqlStr = " update [db_order].[dbo].tbl_giftcard_order" + vbCrlf
		sqlStr = sqlStr + " Set ipkumdiv='8'" + vbCrlf
		sqlStr = sqlStr + " ,jumunDiv='5'" + vbCrlf
		sqlStr = sqlStr + " ,senddate=getdate()" + vbCrlf
		sqlStr = sqlStr + " Where giftOrderSerial='" & isn & "'"
		dbget.Execute sqlStr

        IF (Err) then
		    dbget.RollBackTrans
		    On Error Goto 0
		    Exit Function
		ELSE
		    dbget.CommitTrans
		    On Error Goto 0
		end if
	end function

	'// 전자보증서 결과 저장 (2006.06.14; 운영관리팀 허진원)
	public sub PutInsureMsg(isn, icd, imsg)
		dim SQL
		SQL =	" Update db_order.[dbo].tbl_giftcard_order " &_
				" Set InsureCd='" & icd & "', InsureMsg='" & imsg & "' " &_
				" Where giftOrderSerial='" & isn & "'"
		dbget.Execute(SQL)
	end sub


end Class

Function fnGetGiftOrderSerial(mastercardcode)
	dim strSql, tmp
	strSql = "Select giftOrderSerial, userid From db_order.dbo.tbl_giftcard_order Where masterCardCode='" & mastercardcode & "'"
	rsget.CursorLocation = adUseClient
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
	if not rsget.EOF then
		tmp = rsget("giftOrderSerial") & "|||" & rsget("userid")
	else
		tmp = ""
	end if
	rsget.Close
	fnGetGiftOrderSerial = tmp
End Function
%>
