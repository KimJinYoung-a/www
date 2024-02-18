<%
function chkReqReceipt(orderserial)
    Dim SQL

	SQL = 	" Select resultcode " & VbCRLF
	SQL = SQL & " From [db_log].[dbo].tbl_cash_receipt " & VbCRLF
	SQL = SQL & " Where orderserial='" & orderserial & "'" & VbCRLF
	SQL = SQL & "	and cancelyn='N'" & VbCRLF
	SQL = SQL & "	and resultcode in ('00','R')"

	rsget.Open sql, dbget, 1
		if rsget.EOF or rsget.BOF then
			chkReqReceipt = "none"
		else
			chkReqReceipt = rsget(0)
		end if
	rsget.Close


end function

''201004 추가 데이콤 현금영수증.
function chkDacomCyberPayCashReciptExists(orderserial, byref retAuthcode)
    Dim SQLStr
    Dim authcode, accountno, paygateTid

    chkDacomCyberPayCashReciptExists = false
    retAuthcode = ""

    SQLStr = " select IsNULL(authcode,'') as authcode, accountno, IsNULL(paygateTid,'') as paygateTid"
    SQLStr = SQLStr + " from db_order.dbo.tbl_order_master "
    SQLStr = SQLStr + " where orderserial='" & orderserial & "'"
    SQLStr = SQLStr + " and accountdiv='7'"
    rsget.Open SQLStr, dbget, 1
    if Not rsget.EOF then
        authcode    = rsget("authcode")
        accountno   = rsget("accountno")
        paygateTid  = rsget("paygateTid")
    end if
    rsget.Close

    ''무통장이고 Tid 값이 있으면 Dacom
    if (authcode="") or (paygateTid="") then Exit function
    if (LEft(authcode,2)<>"15") then  Exit function             '' Dacom 15 : INI 26
    retAuthcode = authcode
    chkDacomCyberPayCashReciptExists = true
end function

function GetReceiptMinusOrderSUM(orderserial)
	dim sqlStr

	GetReceiptMinusOrderSUM = 0
    if (orderserial="") then Exit function
        
	sqlStr = " select IsNull(sum(subtotalprice),0) as subtotalprice " &VbCRLF
	sqlStr = sqlStr + " from [db_order].[dbo].tbl_order_master " &VbCRLF
	sqlStr = sqlStr + " where orderserial in ( " &VbCRLF
	sqlStr = sqlStr + " 	select refminusorderserial " &VbCRLF
	sqlStr = sqlStr + " 	from [db_cs].[dbo].[tbl_new_as_list] " &VbCRLF
	sqlStr = sqlStr + " 	where orderserial = '" & orderserial & "' and divcd in ('A004', 'A010') " &VbCRLF
	sqlStr = sqlStr + " ) " &VbCRLF
	sqlStr = sqlStr + " and cancelyn = 'N' "

	rsget.CursorLocation = adUseClient
    rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly
		GetReceiptMinusOrderSUM = rsget("subtotalprice")
	rsget.close

end function

''네이버페이 포인트사용잔액 (ten) 2016/07/26
function fnGetNpaySpendPointSUM(orderserial)
    dim sqlStr
    fnGetNpaySpendPointSUM=0
    if (orderserial="") then Exit function
        
    sqlStr = " select top 1 realPayedsum " &VbCRLF
    sqlStr = sqlStr + " from db_order.dbo.tbl_order_PaymentEtc " &VbCRLF
    sqlStr = sqlStr + " where orderserial='"&orderserial&"'" &VbCRLF
    sqlStr = sqlStr + " and acctdiv='120'" &VbCRLF
    rsget.CursorLocation = adUseClient
    rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly
    if NOT rsget.Eof then
        fnGetNpaySpendPointSUM = rsget("realPayedsum")
    end if
    rsget.close
end function

class CCashReceiptItem
	public Fidx
	public Forderserial
	public Fuserid
	public Fsitename
	public Fgoodname
	public Fcr_price
	public Fsup_price
	public Ftax
	public Fsrvc_price
	public Fbuyername
	public Fbuyeremail
	public Fbuyertel
	public Freg_num
	public Fuseopt
	public Ftid
	public Fresultcode
	public Fresultmsg
	public Fpaymethod
	public Fauthcode
	public Fresultcashnoappl
	public Fcancelyn
	public FcancelTid
	public FEvalDT

    public function getUseoptName
        if (Fuseopt="0") then
            getUseoptName= "소비자 소득공제용"
        elseif (Fuseopt="1") then
            getUseoptName="사업자 지출증빙용"
        end if
    end function

    public function getResultStateName()
        if (Fresultcode="00") then
            getResultStateName = "발급완료"
        end if

        if (Fresultcode="R") then
            getResultStateName = "발급요청중"
        end if

        if (Fcancelyn="Y") then
            getResultStateName = "발급취소"
        end if

        if (IsSelfEvalReceipt) then  ''2016/06/22 추가.
            getResultStateName = getResultStateName &"<br>(자진발급)"
        end if
    end function

    public function IsSelfEvalReceipt() ''2016/06/22 추가.
        IsSelfEvalReceipt = (Freg_num="0100001234")
    end function

	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub

end Class

class CCashReceipt
	public FItemList()
	public FOneItem

	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount

	public FRectUserID
	public FRectSiteName
	public FRectOrderserial
	public FRectIdx
	public FRectCancelyn
	public FRectIsSucces
	public FRectSuccAndReq

	public sub GetOneCashReceipt()
		dim sqlStr,i
		sqlStr = "select top 1 * from [db_log].[dbo].tbl_cash_receipt"
		sqlStr = sqlStr + " where idx=" + CStr(FRectIdx)
		rsget.Open sqlStr,dbget,1
		FResultcount = rsget.Recordcount

		set FOneItem = new CCashReceiptItem
		if Not rsget.Eof then

			FOneItem.Fidx              = rsget("idx")
			FOneItem.Forderserial      = rsget("orderserial")
			FOneItem.Fuserid           = rsget("userid")
			FOneItem.Fsitename         = rsget("sitename")
			FOneItem.Fgoodname         = db2html(rsget("goodname"))
			FOneItem.Fcr_price         = rsget("cr_price")
			FOneItem.Fsup_price        = rsget("sup_price")
			FOneItem.Ftax              = rsget("tax")
			FOneItem.Fsrvc_price       = rsget("srvc_price")
			FOneItem.Fbuyername        = db2html(rsget("buyername"))
			FOneItem.Fbuyeremail       = db2html(rsget("buyeremail"))
			FOneItem.Fbuyertel         = rsget("buyertel")
			FOneItem.Freg_num          = rsget("reg_num")
			FOneItem.Fuseopt           = rsget("useopt")
			FOneItem.Ftid              = rsget("tid")
			FOneItem.Fresultcode       = rsget("resultcode")
			FOneItem.Fresultmsg        = rsget("resultmsg")
			FOneItem.Fpaymethod        = rsget("paymethod")
			FOneItem.Fauthcode         = rsget("authcode")
			FOneItem.Fresultcashnoappl = rsget("resultcashnoappl")
			FOneItem.Fcancelyn         = rsget("cancelyn")
			FOneItem.FcancelTid			= rsget("cancelTid")
		end if
		rsget.close
	end sub

    public sub GetReceiptListByOrderSerial()
		dim sqlStr,i
		sqlStr = "select top 100 * from [db_log].[dbo].tbl_cash_receipt"
		sqlStr = sqlStr + " where orderserial='" + FRectOrderserial + "'"
        sqlStr = sqlStr + " and orderserial<>''"
		if FRectUserID<>"" then
			sqlStr = sqlStr + " and userid='" + FRectUserID + "'"
		end if

		if FRectSiteName<>"" then
			sqlStr = sqlStr + " and sitename='" + FRectSiteName + "'"
		end if

		if FRectCancelyn<>"" then
			sqlStr = sqlStr + " and cancelyn='" + FRectCancelyn + "'"
		end if

        if (FRectSuccAndReq<>"") then
            sqlStr = sqlStr + " and resultcode in ('00','R')"
        end if

		if FRectIsSucces<>"" then
			sqlStr = sqlStr + " and resultcode='00'"
		end if
		sqlStr = sqlStr + " and cancelyn<>'D'"
		sqlStr = sqlStr + " order by idx desc"

		rsget.Open sqlStr,dbget,1
		FTotalcount = rsget.Recordcount
		FResultcount = FTotalcount

        if (FResultcount<1) then FResultcount=0

        redim preserve FItemList(FResultCount)


		if  not rsget.EOF  then
			do until rsget.eof
			set FItemList(i) = new CCashReceiptItem
			FItemList(i).Fidx              = rsget("idx")
			FItemList(i).Forderserial      = rsget("orderserial")
			FItemList(i).Fuserid           = rsget("userid")
			FItemList(i).Fsitename         = rsget("sitename")
			FItemList(i).Fgoodname         = db2html(rsget("goodname"))
			FItemList(i).Fcr_price         = rsget("cr_price")			'// 거래금액
			FItemList(i).Fsup_price        = rsget("sup_price")
			FItemList(i).Ftax              = rsget("tax")
			FItemList(i).Fsrvc_price       = rsget("srvc_price")
			FItemList(i).Fbuyername        = db2html(rsget("buyername"))
			FItemList(i).Fbuyeremail       = db2html(rsget("buyeremail"))
			FItemList(i).Fbuyertel         = rsget("buyertel")
			FItemList(i).Freg_num          = rsget("reg_num")
			FItemList(i).Fuseopt           = rsget("useopt")
			FItemList(i).Ftid              = rsget("tid")
			FItemList(i).Fresultcode       = rsget("resultcode")
			FItemList(i).Fresultmsg        = rsget("resultmsg")
			FItemList(i).Fpaymethod        = rsget("paymethod")
			FItemList(i).Fauthcode         = rsget("authcode")
			FItemList(i).Fresultcashnoappl = rsget("resultcashnoappl")	'// 승인번호
			FItemList(i).Fcancelyn         = rsget("cancelyn")
			FItemList(i).FcancelTid			= rsget("cancelTid")
			FItemList(i).FEvalDT			= rsget("EvalDT")			'// 발행일자(거래일자)

		    i=i+1
			rsget.movenext
			loop
		end if

		rsget.Close
	end sub

	public sub GetReceiptByOrderSerial()
		dim sqlStr,i
		sqlStr = "select top 1 * from [db_log].[dbo].tbl_cash_receipt"
		sqlStr = sqlStr + " where orderserial='" + FRectOrderserial + "'"

		if FRectUserID<>"" then
			sqlStr = sqlStr + " and userid='" + FRectUserID + "'"
		end if

		if FRectSiteName<>"" then
			sqlStr = sqlStr + " and sitename='" + FRectSiteName + "'"
		end if

		if FRectCancelyn<>"" then
			sqlStr = sqlStr + " and cancelyn='" + FRectCancelyn + "'"
		end if

		if FRectIsSucces<>"" then
			sqlStr = sqlStr + " and resultcode='00'"
		end if

		sqlStr = sqlStr + " order by idx desc"

		rsget.Open sqlStr,dbget,1
		FTotalcount = rsget.Recordcount
		FResultcount = FTotalcount

		set FOneItem = new CCashReceiptItem
		if Not rsget.Eof then
			FOneItem.Fidx              = rsget("idx")
			FOneItem.Forderserial      = rsget("orderserial")
			FOneItem.Fuserid           = rsget("userid")
			FOneItem.Fsitename         = rsget("sitename")
			FOneItem.Fgoodname         = db2html(rsget("goodname"))
			FOneItem.Fcr_price         = rsget("cr_price")
			FOneItem.Fsup_price        = rsget("sup_price")
			FOneItem.Ftax              = rsget("tax")
			FOneItem.Fsrvc_price       = rsget("srvc_price")
			FOneItem.Fbuyername        = db2html(rsget("buyername"))
			FOneItem.Fbuyeremail       = db2html(rsget("buyeremail"))
			FOneItem.Fbuyertel         = rsget("buyertel")
			FOneItem.Freg_num          = rsget("reg_num")
			FOneItem.Fuseopt           = rsget("useopt")
			FOneItem.Ftid              = rsget("tid")
			FOneItem.Fresultcode       = rsget("resultcode")
			FOneItem.Fresultmsg        = rsget("resultmsg")
			FOneItem.Fpaymethod        = rsget("paymethod")
			FOneItem.Fauthcode         = rsget("authcode")
			FOneItem.Fresultcashnoappl = rsget("resultcashnoappl")
			FOneItem.Fcancelyn         = rsget("cancelyn")
			FOneItem.FcancelTid			= rsget("cancelTid")
		end if
		rsget.close
	end sub

	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
end Class

''class CmyOrderDetailItem
''	public FOrderSerial
''	public FItemId
''	public FItemName
''	public FItemOption
''	public FItemEa
''	public FItemOptionName
''	public FImageSmall
''	public FImageList
''	public FCurrState
''	public FSongJangNo
''	public FSongjangDiv
''	public FDesigner
''	public FItemCost
''
''
''	public FMasterDiscountRate
''
''	public function GetDiscountPrice()
''		GetDiscountPrice = FItemCost
''		on Error resume next
''		if CDbl(FMasterDiscountRate)=1 then
''			GetDiscountPrice = FItemCost
''		else
''			GetDiscountPrice = CLng(round(CDbl(FMasterDiscountRate) * FItemCost / 100) * 100)
''		end if
''		on error goto 0
''	end function
''
''	public FCancelYn
''	public FDeiveryType
''
''	public FMasterSongJangNo
''	public FMasterIpkumDiv
''
''	public function GetDeliverState()
''		if (IsUpcheBeasong) then
''			GetDeliverState = NormalUpcheDeliverState(FCurrState)
''		else
''			GetDeliverState = NormalIpkumDivName(FMasterIpkumDiv)
''		end if
''	end function
''
''	public function IsUpcheBeasong()
''		if (FDeiveryType="2") or (FDeiveryType="5") then
''			IsUpcheBeasong = true
''		else
''			IsUpcheBeasong = false
''		end if
''	end function
''
''	public function GetDeiveryNo()
''		if IsUpcheBeasong then
''			GetDeiveryNo = FSongJangNo
''		else
''			GetDeiveryNo = FMasterSongJangNo
''		end if
''	end function
''
''	Private Sub Class_Initialize()
''
''	End Sub
''
''	Private Sub Class_Terminate()
''
''	End Sub
''end Class
''
''class CMyOrderMasterItem
''	public FOrderSerial
''	public FBuyName
''	public FBuyPhone
''	public FBuyhp
''	public FBuyEmail
''
''	public FReqName
''	public FReqPhone
''	public FReqHp
''	public FReqZip
''	public FReqAddr1
''	public FReqAddr2
''	public FIpkumDiv
''	public FReqEtc
''
''	public FAccountDiv
''	public FRegDate
''	public FSongjangNo
''	public FCancelYN
''
''	public FSiteName
''	public FResultmsg
''	public FDeliverOption
''	public FDiscountRate
''	public FsubtotalPrice
''
''	public FUserID
''	public FPaygateTID
''	public FUserJumin
''
''	public function GetUserJumin()
''		GetUserJumin = replace(FUserJumin,"-","")
''	end function
''
''	public function GetSuppPrice()
''		GetSuppPrice = CLng(FsubtotalPrice/1.1)
''	end function
''
''	public function GetTaxPrice()
''		GetTaxPrice = FsubtotalPrice-GetSuppPrice
''	end function
''
''	public function IsAcctPay()
''		IsAcctPay = (Trim(FAccountDiv)="7")
''	end function
''
''	public function IsPayOK()
''		IsPayOK = (FCancelYN="N") and (CInt(FIpkumDiv)>3)
''	end function
''
''	public function GetAcctDivName()
''		GetAcctDivName = NormalAcctDivName(FAccountDiv)
''	end function
''
''	public function GetDeliverOptionName()
''		GetDeliverOptionName = NormalDeliverOptionName(FDeliverOption)
''	end function
''
''	Private Sub Class_Initialize()
''
''	End Sub
''
''	Private Sub Class_Terminate()
''
''	End Sub
''end class
''
''class CMyOrderListItem
''	public FOrderSerial
''	public FRegdate
''	public FItemNames
''	public FSubTotalPrice
''	public FAcctountDiv
''	public FIpkumDiv
''	public FSongJangDiv
''	public FSongJangNo
''	public FItemCount
''
''	public function GetItemNames()
''		if FItemCount>1 then
''			GetItemNames = FItemNames + " 외 " + CStr(FItemCount-1) + "건"
''		else
''			GetItemNames = FItemNames
''		end if
''	end function
''
''	public function IsDeliveryFinished()
''		IsDeliveryFinished = false
''	end function
''
''	public function GetIpkumDivColor()
''		GetIpkumDivColor = NormalIpkumDivColor(FIpkumDiv)
''	end function
''
''	public function GetIpkumDivName()
''		GetIpkumDivName = NormalIpkumDivName(FIpkumDiv)
''	end function
''
''	Private Sub Class_Initialize()
''
''	End Sub
''
''	Private Sub Class_Terminate()
''
''	End Sub
''end Class
''
''Class CMyOrder
''	public FItemList()
''	public FMasterItem
''
''	public FTotalSum
''	public FTotalCount
''	public FCurrPage
''	public FTotalPage
''	public FPageSize
''	public FResultCount
''	public FScrollCount
''
''	public FRectUserID
''	public FRectSiteName
''	public FRectOrderserial
''
''	public FOrderExist
''	public FOrderErrorMSG
''
''	public function GetGoodsName()
''		dim i, buf
''		for i=0 to FResultCount-1
''			buf = FItemList(i).FItemName
''			exit for
''		next
''
''		if FResultCount>1 then
''			buf = buf + "외 " + Cstr(FResultCount-1) + "건"
''		end if
''
''		GetGoodsName = buf
''	end function
''
''	public function IsTenBeasongExists()
''		dim i
''		IsTenBeasongExists = false
''		for i=0 to FResultCount-1
''			IsTenBeasongExists = IsTenBeasongExists or (Not FItemList(i).IsUpcheBeasong)
''		next
''	end function
''
''	public function IsUpcheBeasongExists()
''		dim i
''		IsUpcheBeasongExists = false
''		for i=0 to FResultCount-1
''			IsUpcheBeasongExists = IsUpcheBeasongExists or FItemList(i).IsUpcheBeasong
''		next
''	end function
''
''	Private Sub Class_Initialize()
''		'redim preserve FItemList(0)
''		redim  FItemList(0)
''
''		FCurrPage =1
''		FPageSize = 12
''		FResultCount = 0
''		FScrollCount = 10
''		FTotalCount =0
''	End Sub
''
''	Private Sub Class_Terminate()
''
''	End Sub
''
''	public Sub GetOneReceiptOrder()
''		dim sqlStr,i
''
''		sqlStr = "select top 1 m.orderserial, m.reqname, m.userid, m.paygatetid,"
''		sqlStr = sqlStr + " m.buyname, m.buyphone, m.buyhp, m.buyemail, m.reqphone, m.reqhp,"
''		sqlStr = sqlStr + " m.reqzipcode, m.reqzipaddr, m.reqaddress, m.ipkumdiv, m.comment, convert(varchar(20),m.regdate,20) as regdate,"
''		sqlStr = sqlStr + " m.deliverno, m.cancelyn, m.accountdiv, m.sitename, m.resultmsg, m.discountrate, d.itemoption "
''
''		'무통장/실시간 = 전체금액, 나머지 = 보조결제금액만
''		sqlStr = sqlStr + " , (case "
''		sqlStr = sqlStr + " 	when m.accountdiv in ('7','20') then m.subtotalprice "
''		sqlStr = sqlStr + " 	else IsNull(m.sumPaymentEtc, 0) "
''		sqlStr = sqlStr + " end) as subtotalprice "
''
''		sqlStr = sqlStr + " from [db_order].[dbo].tbl_order_master m "
''		sqlStr = sqlStr + " left join [db_order].[dbo].tbl_order_detail d on m.orderserial=d.orderserial and d.itemid=0 and d.cancelyn<>'Y'"
''		sqlStr = sqlStr + " where m.orderserial='" + FRectOrderserial + "'"
''		sqlStr = sqlStr + " and m.cancelyn='N'"
''		sqlStr = sqlStr + " and m.ipkumdiv>3"
''		'sqlStr = sqlStr + " and m.accountdiv in ('7','20')"				'모든 결제에 대해 증빙서류발급 필요(보조결제)
''
''		sqlStr = sqlStr + " and ( "
''		sqlStr = sqlStr + " 	((m.accountdiv in ('7','20')) and (m.subtotalprice > 0)) "
''		sqlStr = sqlStr + " 	or "
''		sqlStr = sqlStr + " 	((m.accountdiv not in ('7','20')) and (IsNull(m.sumPaymentEtc, 0) > 0)) "
''		sqlStr = sqlStr + " ) "
''
''		sqlStr = sqlStr + " and m.regdate>='2005-01-01'"
''
''		if FRectUserID<>"" then
''			sqlStr = sqlStr + " and m.userid='" + FRectUserID + "'"
''		end if
''
''		if FRectSiteName<>"" then
''			sqlStr = sqlStr + " and m.sitename='" + FRectSiteName + "'"
''		end if
''		'response.write sqlStr
''		rsget.Open sqlStr,dbget,1
''
''
''		set FMasterItem = new CMyOrderMasterItem
''		if Not Rsget.Eof then
''			FOrderExist = true
''
''			FMasterItem.FOrderSerial = FRectOrderserial
''			FMasterItem.FBuyName   = db2html(rsget("buyname"))
''			FMasterItem.Fuserid    = rsget("userid")
''			FMasterItem.FBuyPhone  = rsget("buyphone")
''			FMasterItem.FBuyhp     = rsget("buyhp")
''			FMasterItem.FBuyEmail  = rsget("buyemail")
''
''			FMasterItem.FReqPhone  = rsget("reqphone")
''			FMasterItem.FReqhp     = rsget("reqhp")
''
''			FMasterItem.FReqName   = rsget("reqname")
''			FMasterItem.FReqZip    = rsget("reqzipcode")
''			FMasterItem.FReqAddr1  = db2html(rsget("reqzipaddr"))
''			FMasterItem.FReqAddr2  = db2html(rsget("reqaddress"))
''			FMasterItem.FIpkumDiv  = rsget("ipkumdiv")
''			FMasterItem.FReqEtc    = db2html(rsget("comment"))
''
''			FMasterItem.FRegDate   = rsget("regdate")
''			FMasterItem.FSongjangNo= rsget("deliverno")
''			FMasterItem.FCancelYN  = rsget("cancelyn")
''			FMasterItem.FAccountDiv= rsget("accountdiv")
''			FMasterItem.FSiteName= rsget("sitename")
''			FMasterItem.FResultmsg = rsget("resultmsg")
''			FMasterItem.FDeliverOption = rsget("itemoption")
''			FMasterItem.FDiscountRate = rsget("discountrate")
''			FMasterItem.FsubtotalPrice = rsget("subtotalprice")
''
''			FMasterItem.FPaygateTID = rsget("paygatetid")
''
''			FOrderExist = (FMasterItem.FsubtotalPrice > 0)
''			if (Not FOrderExist) then
''				FOrderErrorMSG = "발급대상금액이 없습니다."
''				FOrderExist = false
''			end if
''		else
''			FOrderErrorMSG = "결제완료 이전 또는 취소된 주문입니다."
''		end if
''		rsget.Close
''
''		i=0
''		if (FOrderExist) then
''			sqlStr = "select d.idx, d.itemid, d.itemoption, d.itemno, d.itemoptionname, d.itemcost,"
''			sqlStr = sqlStr + " d.itemname, d.itemcost, d.makerid, d.currstate, d.songjangno, d.songjangdiv,"
''			sqlStr = sqlStr + " d.cancelyn, i.deliverytype, i.smallimage, i.listimage"
''			sqlStr = sqlStr + " from [db_order].[dbo].tbl_order_detail d, [db_item].[dbo].tbl_item i"
''			sqlStr = sqlStr + " where d.orderserial='" + FRectOrderserial + "'"
''			sqlStr = sqlStr + " and d.itemid=i.itemid"
''			sqlStr = sqlStr + " and d.itemid<>0"
''			sqlStr = sqlStr + " order by i.deliverytype"
''
''			rsget.Open sqlStr,dbget,1
''			FTotalcount = rsget.Recordcount
''			FResultcount = FTotalcount
''
''			do until rsget.Eof
''				redim preserve FItemList(FTotalcount)
''				set FItemList(i) = new CmyOrderDetailItem
''				FItemList(i).FOrderSerial   = FRectOrderserial
''				FItemList(i).FItemId        = rsget("itemid")
''				FItemList(i).FItemName       = db2html(rsget("itemname"))
''				FItemList(i).FItemOption     = rsget("itemoption")
''				FItemList(i).FItemEa         = rsget("itemno")
''				FItemList(i).FItemOptionName = rsget("itemoptionname")
''				FItemList(i).FImageSmall     = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("smallimage")
''				FItemList(i).FImageList      = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("listimage")
''				FItemList(i).FSongJangNo     = rsget("songjangno")
''				FItemList(i).FSongjangDiv    = rsget("songjangdiv")
''				FItemList(i).FDesigner       = rsget("makerid")
''				FItemList(i).FItemCost		 = rsget("itemcost")
''
''				FItemList(i).FCancelYn      = rsget("cancelyn")
''				FItemList(i).FDeiveryType   = rsget("deliverytype")
''
''				FItemList(i).FMasterSongJangNo = FMasterItem.FSongjangNo
''				FItemList(i).FMasterIpkumDiv   = FMasterItem.FIpkumDiv
''				FItemList(i).FMasterDiscountRate = FMasterItem.FDiscountRate
''				i=i+1
''				rsget.movenext
''			loop
''
''			rsget.close
''		end if
''
''		if (FOrderExist) and (FMasterItem.Fuserid<>"") and ((FRectSiteName="10x10") or (FRectSiteName="way2way")) then
''			sqlStr = " select top 1 juminno from [db_user].[dbo].tbl_user_n"
''			sqlStr = sqlStr + " where userid='" + FMasterItem.Fuserid + "'"
''			rsget.Open sqlStr,dbget,1
''			if Not rsget.Eof then
''				FMasterItem.FUserJumin = rsget("juminno")
''			end if
''			rsget.Close
''
''		end if
''	end Sub
''
''
''	public Function HasPreScroll()
''		HasPreScroll = StarScrollPage > 1
''	end Function
''
''	public Function HasNextScroll()
''		HasNextScroll = FTotalPage > StarScrollPage + FScrollCount -1
''	end Function
''
''	public Function StarScrollPage()
''		StarScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
''	end Function
''end Class
%>
