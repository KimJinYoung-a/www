<%

function CheckPartialCancelValid(orderserial, checkidxArr)
	dim sqlStr
	dim errCnt, MakerCnt, MakerID, masterCanceled

	sqlStr = " select "
	sqlStr = sqlStr + "		sum(case "
	sqlStr = sqlStr + "				when m.cancelyn <> 'N' then 1 "
	sqlStr = sqlStr + "				when d.cancelyn = 'Y' then 1 "
	sqlStr = sqlStr + "				when d.itemid = 0 then 1 "
	sqlStr = sqlStr + "				when d.currstate = '7' then 1 "
	sqlStr = sqlStr + "				else 0 end) as errCnt, "
	sqlStr = sqlStr + "		count(distinct (case "
	sqlStr = sqlStr + "				when d.isupchebeasong = 'Y' then d.makerid "
	sqlStr = sqlStr + "				when d.isupchebeasong = 'N' then '' "
	sqlStr = sqlStr + "				else NULL end)) as MakerCnt, "
	sqlStr = sqlStr + "		max(distinct (case "
	sqlStr = sqlStr + "				when d.isupchebeasong = 'Y' then d.makerid "
	sqlStr = sqlStr + "				when d.isupchebeasong = 'N' then '' "
	sqlStr = sqlStr + "				else NULL end)) as MakerID, "
	sqlStr = sqlStr + "		max(m.cancelyn) as cancelyn "
	sqlStr = sqlStr + "	from "
	sqlStr = sqlStr + "		[db_order].[dbo].[tbl_order_master] m "
	sqlStr = sqlStr + "		join [db_order].[dbo].[tbl_order_detail] d on m.orderserial = d.orderserial "
	sqlStr = sqlStr + "	where "
	sqlStr = sqlStr + "		1 = 1 "
	sqlStr = sqlStr + "		and m.orderserial = '" & orderserial & "' "
	sqlStr = sqlStr + "		and d.idx in (" & checkidxArr & ") "

	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly
	if Not rsget.Eof then
		errCnt = rsget("errCnt")
		MakerCnt = rsget("MakerCnt")
		MakerID = rsget("MakerID")
		masterCanceled = rsget("cancelyn")
	end if
	rsget.close

	''response.write errCnt & "<br />"
	''response.write MakerCnt & "<br />"
	''response.write MakerID & "<br />"
	if errCnt > 0 then
		CheckPartialCancelValid = "ERR[0]"
	elseif MakerCnt > 1 then
		CheckPartialCancelValid = "ERR[1]"
	elseif masterCanceled = "Y" then
		CheckPartialCancelValid = "ERR[2]"
	else
		CheckPartialCancelValid = MakerID
	end if
end function

function GetPartialCancelDisableArr(orderserial, makerid)
	dim sqlStr
	dim result

	sqlStr = " select d.idx "
	sqlStr = sqlStr + "	from "
	sqlStr = sqlStr + "		[db_order].[dbo].[tbl_order_master] m "
	sqlStr = sqlStr + "		join [db_order].[dbo].[tbl_order_detail] d on m.orderserial = d.orderserial "
	sqlStr = sqlStr + "	where "
	sqlStr = sqlStr + "		1 = 1 "
	sqlStr = sqlStr + "		and m.orderserial = '" & orderserial & "' "
	sqlStr = sqlStr + "		and d.cancelyn <> 'Y' "
	sqlStr = sqlStr + "		and d.itemid <> 0 "
	sqlStr = sqlStr + "		and d.currstate <> '7' "
	if (makerid = "") then
		sqlStr = sqlStr + "		and (d.isupchebeasong = 'Y') "
	else
		sqlStr = sqlStr + "		and (d.makerid <> '" & makerid & "') "
	end if

	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly

	if  not rsget.EOF  then
		do until rsget.eof
			result = CHKIIF(result="",rsget("idx"), result&","&rsget("idx"))
			rsget.movenext
		loop
	end if
	rsget.Close

	GetPartialCancelDisableArr = result
end function

function InsertUpdateCancelItemNo(byVal checkidxArr, byVal regitemnoArr)
	dim sqlStr, i
	dim orgcheckidxArr

	orgcheckidxArr = checkidxArr

	checkidxArr = Split(checkidxArr, ",")
	regitemnoArr = Split(regitemnoArr, ",")
	for i = 0 to UBound(checkidxArr)
		if Trim(checkidxArr(i)) <> "" and Trim(regitemnoArr(i)) <> "" then
			sqlStr = " if not exists(select top 1 idx from [db_temp].[dbo].[tbl_order_detail_for_cancel] where idx = " & checkidxArr(i) & ") "
			sqlStr = sqlStr + "	begin "
			sqlStr = sqlStr + "		insert into [db_temp].[dbo].[tbl_order_detail_for_cancel](idx, cancelitemno) "
			sqlStr = sqlStr + "		values(" & checkidxArr(i) & ", " & regitemnoArr(i) & ") "
			sqlStr = sqlStr + "	end "
			sqlStr = sqlStr + "	else "
			sqlStr = sqlStr + "	begin "
			sqlStr = sqlStr + "		update [db_temp].[dbo].[tbl_order_detail_for_cancel] "
			sqlStr = sqlStr + "		set cancelitemno = " & regitemnoArr(i) & " "
			sqlStr = sqlStr + "		where idx = " & checkidxArr(i) & " "
			sqlStr = sqlStr + "	end "
			dbget.Execute sqlStr
		end if
	next

	sqlStr = " update c "
	sqlStr = sqlStr + "	set c.cancelitemno = (case when IsNull(c.cancelitemno, 0) < 0 then 0 when IsNull(c.cancelitemno, 0) > d.itemno then d.itemno else IsNull(c.cancelitemno, 0) end) "
	sqlStr = sqlStr + "	from "
	sqlStr = sqlStr + "		[db_order].[dbo].[tbl_order_detail] d "
	sqlStr = sqlStr + "		join [db_temp].[dbo].[tbl_order_detail_for_cancel] c on c.idx = d.idx "
	sqlStr = sqlStr + "	where "
	sqlStr = sqlStr + "		1 = 1 "
	sqlStr = sqlStr + "		and c.idx in (" & orgcheckidxArr & ") "
	sqlStr = sqlStr + "		and ((IsNull(c.cancelitemno, 0) < 0) or (IsNull(c.cancelitemno, 0) > d.itemno)) "
	dbget.Execute sqlStr
end function

function GetDataForPartialCancel(orderserial, checkidxArr, makerid, byRef totItemPay, byRef totDeliveryPay, byRef cancelItemPay, byRef freeDeliveryItemCnt, byRef defaultfreebeasonglimit, byRef defaultdeliverpay)
	dim sqlStr

	if (makerid = "") then
		'// 텐바이텐 배송
		'// 회원혜택
		'// if ((makerid == '') && (UserLevel == 'STAFF')) { return 0; }
		'// if ((makerid == '') && (UserLevel == 'VVIP')) { return 0; }
		'// if ((makerid == '') && (UserLevel == 'VIP GOLD')) { return 10000; }
		'// if ((makerid == '') && (UserLevel == 'VIP')) { return 20000; }
		'// // 없으면 텐바이텐 기준금액
		'// return 30000;

		sqlStr = " select "
		sqlStr = sqlStr + "		sum(case "
		sqlStr = sqlStr + "				when d.itemid <> 0 then d.reducedPrice*d.itemno "
		sqlStr = sqlStr + "				else 0 end) as totItemPay, "
		sqlStr = sqlStr + "		sum(case "
		sqlStr = sqlStr + "				when d.itemid = 0 then d.reducedPrice*d.itemno "
		sqlStr = sqlStr + "				else 0 end) as totDeliveryPay, "
		sqlStr = sqlStr + "		sum(case "
		sqlStr = sqlStr + "				when d.itemid <> 0 then d.reducedPrice*(case "
		sqlStr = sqlStr + "															when d.itemno < IsNull(c.cancelitemno, 0) then d.itemno "
		sqlStr = sqlStr + "															when IsNull(c.cancelitemno, 0) < 1 then 0 "
		sqlStr = sqlStr + "															else IsNull(c.cancelitemno, 0) end) "
		sqlStr = sqlStr + "				else 0 end) as cancelItemPay, "
		sqlStr = sqlStr + "		sum(case "
		sqlStr = sqlStr + "				when d.itemid <> 0 and d.odlvtype in ('2', '4', '7') and d.itemno > IsNull(c.cancelitemno, 0) then 1 "
		sqlStr = sqlStr + "				else 0 end) as freeDeliveryItemCnt, "
		sqlStr = sqlStr + "		max(case "
		sqlStr = sqlStr + "				when m.userlevel = '2' then 20000 "
		sqlStr = sqlStr + "				when m.userlevel = '3' then 10000 "
		sqlStr = sqlStr + "				when m.userlevel in ('4', '6') then 0 "
		sqlStr = sqlStr + "				when m.userlevel = '7' then 0 "
		sqlStr = sqlStr + "				else 30000 end) as defaultfreebeasonglimit, "
		sqlStr = sqlStr + "		2500 as defaultdeliverpay "
		sqlStr = sqlStr + "	from "
		sqlStr = sqlStr + "		[db_order].[dbo].[tbl_order_master] m "
		sqlStr = sqlStr + "		join [db_order].[dbo].[tbl_order_detail] d on m.orderserial = d.orderserial "
		sqlStr = sqlStr + "		left join [db_temp].[dbo].[tbl_order_detail_for_cancel] c on c.idx = d.idx and c.idx in (" & checkidxArr & ") "
		sqlStr = sqlStr + "	where "
		sqlStr = sqlStr + "		1 = 1 "
		sqlStr = sqlStr + "		and d.orderserial = '" & orderserial & "' "
		sqlStr = sqlStr + "		and d.cancelyn <> 'Y' "
		sqlStr = sqlStr + "		and ( "
		sqlStr = sqlStr + "			(d.makerid = '' and d.itemid = 0) "
		sqlStr = sqlStr + "			or "
		sqlStr = sqlStr + "			(d.isupchebeasong = 'N' and d.itemid <> 0) "
		sqlStr = sqlStr + "		) "
	else
		'// 업체배송
		sqlStr = " select "
		sqlStr = sqlStr + "		sum(case "
		sqlStr = sqlStr + "				when d.itemid <> 0 then d.reducedPrice*d.itemno "
		sqlStr = sqlStr + "				else 0 end) as totItemPay, "
		sqlStr = sqlStr + "		sum(case "
		sqlStr = sqlStr + "				when d.itemid = 0 then d.reducedPrice*d.itemno "
		sqlStr = sqlStr + "				else 0 end) as totDeliveryPay, "
		sqlStr = sqlStr + "		sum(case "
		sqlStr = sqlStr + "				when d.itemid <> 0 then d.reducedPrice*(case "
		sqlStr = sqlStr + "															when d.itemno < IsNull(c.cancelitemno, 0) then d.itemno "
		sqlStr = sqlStr + "															when IsNull(c.cancelitemno, 0) < 1 then 0 "
		sqlStr = sqlStr + "															else IsNull(c.cancelitemno, 0) end) "
		sqlStr = sqlStr + "				else 0 end) as cancelItemPay, "
		sqlStr = sqlStr + "		sum(case "
		sqlStr = sqlStr + "				when d.itemid <> 0 and d.odlvtype in ('2', '4', '7') and d.itemno > IsNull(c.cancelitemno, 0) then 1 "
		sqlStr = sqlStr + "				else 0 end) as freeDeliveryItemCnt, "
		sqlStr = sqlStr + "		max(IsNull(b.defaultfreebeasonglimit, 30000)) as defaultfreebeasonglimit, "
		sqlStr = sqlStr + "		max(IsNull(b.defaultdeliverpay, 2500)) as defaultdeliverpay "
		sqlStr = sqlStr + "	from "
		sqlStr = sqlStr + "		[db_order].[dbo].[tbl_order_detail] d "
		sqlStr = sqlStr + "		join db_user.dbo.tbl_user_c b on d.makerid = b.userid "
		sqlStr = sqlStr + "		left join [db_temp].[dbo].[tbl_order_detail_for_cancel] c on c.idx = d.idx and c.idx in (" & checkidxArr & ") "
		sqlStr = sqlStr + "	where "
		sqlStr = sqlStr + "		1 = 1 "
		sqlStr = sqlStr + "		and d.orderserial = '" & orderserial & "' "
		sqlStr = sqlStr + "		and d.cancelyn <> 'Y' "
		sqlStr = sqlStr + "		and d.makerid = '" & makerid & "' "
	end if

    rsget.Open sqlStr,dbget,1
    if Not rsget.Eof then
		totItemPay				= rsget("totItemPay")
		totDeliveryPay			= rsget("totDeliveryPay")
		cancelItemPay			= rsget("cancelItemPay")
		freeDeliveryItemCnt		= rsget("freeDeliveryItemCnt")
		defaultfreebeasonglimit	= rsget("defaultfreebeasonglimit")
		defaultdeliverpay		= rsget("defaultdeliverpay")
    end if
	rsget.close
end function

function TicketOrderCheck(iorderserial,ByRef mayTicketCancelChargePro,ByRef ticketCancelDisabled,ByRef ticketCancelStr)
    Dim sqlStr, D9Day, D6Day, D2Day, DDay, returnExpiredate
    Dim nowDate, R8Day

    mayTicketCancelChargePro = 0
    ticketCancelDisabled     = false

    sqlStr = " select top 1 "
    sqlStr = sqlStr & "  dateadd(d,-9,tk_StSchedule) as D9"
    sqlStr = sqlStr & " ,dateadd(d,-6,tk_StSchedule) as D6"
    sqlStr = sqlStr & " ,dateadd(d,-2,tk_StSchedule) as D2"
    sqlStr = sqlStr & " ,tk_StSchedule as Dday"
    sqlStr = sqlStr & " ,tk_EdSchedule"
    sqlStr = sqlStr & " ,returnExpiredate"
    sqlStr = sqlStr & " ,getdate() as nowDate"
	sqlStr = sqlStr & " ,dateadd(d,8,m.regDate) as R8"
    sqlStr = sqlStr & " from db_order.dbo.tbl_order_master m "
	sqlStr = sqlStr & " 	join db_order.dbo.tbl_order_detail d "
	sqlStr = sqlStr & " 	on m.orderserial = d.orderserial "
    sqlStr = sqlStr & "	    Join db_item.dbo.tbl_ticket_Schedule s"
    sqlStr = sqlStr & "	    on d.itemid=s.tk_itemid"
    sqlStr = sqlStr & "	    and d.itemoption=s.tk_itemoption"
    sqlStr = sqlStr & " where d.orderserial='"&iorderserial&"'"
    sqlStr = sqlStr & " and d.itemid<>0"
    sqlStr = sqlStr & " and d.cancelyn<>'Y'"
	''rw sqlStr

    rsget.Open sqlStr,dbget,1
    if Not rsget.Eof then
		D9Day               = rsget("D9")
		D6Day               = rsget("D6")
		D2Day               = rsget("D2")
		DDay                = rsget("Dday")
		returnExpiredate    = rsget("returnExpiredate")
		nowDate             = rsget("nowDate")
		R8Day               = rsget("R8")			'// 예매일+8일
    end if
	rsget.close

    if (returnExpiredate="") then Exit function

    ' if (nowDate<D10Day) then
    '     exit function
    ' end If

    if (nowDate>returnExpiredate) then
        ticketCancelDisabled = true
        ticketCancelStr      = "취소 마감기간은 "&CStr(returnExpiredate)&" 까지 입니다."
        Exit function
    end If

    if (nowDate<D9Day) and (nowDate=>R8Day) Then
		'//예매 후 8일~관람일 10일전까지, 장당 2,000원(티켓금액의 10%한도)
        mayTicketCancelChargePro = 2000
        ticketCancelStr = "예매 후 8일~관람일 10일전 취소시 (관람일 : "&CStr(Dday)&") "
        Exit function
    end if

    if (nowDate>D9Day) and (nowDate=<D6Day) then
        mayTicketCancelChargePro = 10
        ticketCancelStr = "관람일 9일~7일전 취소시 (관람일 : "&CStr(Dday)&") "
        Exit function
    end if

    if (nowDate>D6Day) and (nowDate=<D2Day) then
        mayTicketCancelChargePro = 20
        ticketCancelStr = "관람일 6일~3일전 취소시 (관람일 : "&CStr(Dday)&") "
        Exit function
    end if

    if (nowDate>D2Day) and (nowDate=<DDay) then
        mayTicketCancelChargePro = 30
        ticketCancelStr = "관람일 2일~1일전 취소시 (관람일 : "&CStr(Dday)&") "
        Exit function
    end if


end function

'' 2015/07/15 쿠키 검사 require MD5.asp
function TenOrderSerialHash(iorderserial)
    TenOrderSerialHash = LEFT(MD5(iorderserial&"ten"&iorderserial),20)
end Function

Function getUserRecentOrder(iUserID)
    if (iUserID="") then Exit function
    Dim sqlStr
    iUserID = requestCheckvar(iUserID,32)
    sqlStr = "select top 1 orderserial from db_order.dbo.tbl_order_master"&VbCRLF
    sqlStr = sqlStr & " where userid='"&iUserID&"'"&VbCRLF
    sqlStr = sqlStr & " and ipkumdiv>1 "&VbCRLF
    sqlStr = sqlStr & " and cancelyn='N'"&VbCRLF
    sqlStr = sqlStr & " and jumundiv<>'9'"&VbCRLF
    sqlStr = sqlStr & " and (userDisplayYn is null or userDisplayYn='Y')"&VbCRLF
    sqlStr = sqlStr & " order by idx desc"&VbCRLF

    rsget.CursorLocation = adUseClient
    rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly
    If Not rsget.Eof then
        getUserRecentOrder = rsget("orderserial")
    end if
    rsget.Close
end Function

Function getUserShopRecentOrder(iUserID)
    if (iUserID="") then Exit function
    Dim sqlStr
    iUserID = requestCheckvar(iUserID,32)
    sqlStr = "select top 1 M.orderno from [db_shop].[dbo].[tbl_shopjumun_master] M"&VbCRLF
    sqlStr = sqlStr & " JOIN [db_shop].[dbo].[tbl_total_shop_card] C ON M.pointuserno = C.CardNo AND C.useYN='Y'"&VbCRLF
	sqlStr = sqlStr & " LEFT JOIN [db_shop].[dbo].[tbl_total_shop_user] U ON C.UserSeq = U.UserSeq"&VbCRLF
    sqlStr = sqlStr & " where U.OnlineUserID='"&iUserID&"'"&VbCRLF
    sqlStr = sqlStr & " and M.cancelyn='N'"&VbCRLF
    sqlStr = sqlStr & " order by M.idx desc"&VbCRLF

    rsget.CursorLocation = adUseClient
    rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly
    If Not rsget.Eof then
        getUserShopRecentOrder = rsget("orderno")
    end if
    rsget.Close
end Function

class COrderSubPaymentItem
    public Forderserial
    public Facctdiv
    public Facctamount
    public FrealPayedsum
    public FacctAuthCode
    public FacctAuthDate

    ''보조결제수단인지(상품권, 예치금)
    public function IsSubPayment()
        IsSubPayment = false
        if (Facctdiv="200") then
            IsSubPayment = true
        end if
    end function

    public function GetAcctdivName()
        dim oacctdiv
        if IsNULL(Facctdiv) then Exit function
        oacctdiv = Trim(Facctdiv)

        select case oacctdiv
            case "7"
                : GetAcctdivName = "무통장"
            case "100"
                : GetAcctdivName = "신용카드"
            case "20"
                : GetAcctdivName = "실시간계좌이체"
            case "80"
                : GetAcctdivName = "All@멤버쉽카드"
            case "50"
                : GetAcctdivName = "외부몰결제"
            case "30"
                : GetAcctdivName = "포인트"
            case "90"
                : GetAcctdivName = "상품권"
            case "110"
                : GetAcctdivName = "OK캐쉬백"
            case "400"
                : GetAcctdivName = "핸드폰결제"
            case "200"
                : GetAcctdivName = "예치금"
            case else
                : GetAcctdivName = ""
        end select
    end function

    Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub

end Class

class CMyOrderDetailItem
    public Forderserial
    public Fitemid
    public Fitemoption
    public Fidx
    public Fmasteridx
    public Fmakerid
    public Fitemno
	public Fitemlackno
    public Fitemcost
    public FreducedPrice
    public Fmileage
    public Fcancelyn
    public Fcurrstate
    public Fsongjangno
    public Fsongjangdiv
    public Fitemname
    public Fitemoptionname
    public Fvatinclude
    public Fbeasongdate
    public Fisupchebeasong
    public Fissailitem
    public Fupcheconfirmdate
    public Foitemdiv
    public FomwDiv
    public FodlvType
    public Frequiredetail
	public FrequireDetailUTF8
	public Flimityn
    public FImageSmall
    public FImageList
    public Fbrandname
    public FItemDiv
    public Fmibeasoldoutyn

    public FDeliveryName    ''택배사
    public FDeliveryUrl
    public FDeliveryTel

    public Forgitemcost
    public FitemcostCouponNotApplied
    public Fodlvfixday
    public FplussaleDiscount
    public FspecialShopDiscount
    public Fitemcouponidx
    public Fbonuscouponidx
    public FPojangok
    public FIsPacked
    public FOrderSheetYN

	public FSellPrice
    public FRealSellPrice
    public FSuplyPrice
    public Foffimgsmall
    public Fitemgubun
	public FKeywords
    public Fdlvfinishdt
    'public Fbuyvat,Fitemgubun

    public function IsTicketItem
        IsTicketItem = (Foitemdiv="08")
    end function

    public function getReducedPrice()
        getReducedPrice = FreducedPrice
    end function

    '''기존 버전 고려
    public function getItemcostCouponNotApplied
        if (FitemcostCouponNotApplied<>0) then
            getItemcostCouponNotApplied = FitemcostCouponNotApplied
        else
            getItemcostCouponNotApplied = FItemCost
        end if
    end function

    public function getItemCouponDiscount()
        '''기존버전 고려
        If (FitemcostCouponNotApplied>FItemCost) then
            getItemCouponDiscount = FitemcostCouponNotApplied-FItemCost
        else
            getItemCouponDiscount = 0
        end if
    end function

    public function IsSaleItem()
        IsSaleItem = (FIsSailItem="Y") or (FplussaleDiscount>0) or (FspecialShopDiscount>0)  '''or (FIsSailItem="P")  플러스세일인 플러스 세일금액이 있으면. 으로 바뀜. 20110401 부터
        IsSaleItem = IsSaleItem and (Forgitemcost>FitemcostCouponNotApplied)
    end function

    public function IsItemCouponAssignedItem()
        IsItemCouponAssignedItem = (Fitemcouponidx>0) and (FitemcostCouponNotApplied>FItemCost)
    end function

    public function IsSaleBonusCouponAssignedItem()
        IsSaleBonusCouponAssignedItem = (Fbonuscouponidx<>0)  ''2018/04/18 (>0 => <>0)
    end function

    '// 해외 직구 상품 주문인지.
    public function IsGlobalDirectPurchaseItem()
		if isNULL(Fodlvfixday) then
			IsGlobalDirectPurchaseItem = false
		end If

		if Fodlvfixday="G" then
			IsGlobalDirectPurchaseItem = true
		else
			IsGlobalDirectPurchaseItem = false
		end if
	End Function

    public function getDeliveryTypeName()
        if (Fisupchebeasong="N") Then
			'// 해외 직구
			If Fodlvfixday="G" Then
				getDeliveryTypeName = "해외직구배송"
			Else
	            getDeliveryTypeName = "텐바이텐배송"
			End If
        Else
			If Fodlvfixday="G" Then
				getDeliveryTypeName = "해외직구배송"
			Else
				if (FodlvType="9") then
					getDeliveryTypeName = "업체개별배송"
				else
					getDeliveryTypeName = "업체배송"
				end If
			End If
        end if

        ''티켓(및 현장수령)관련
        if (FodlvType="3") or (FodlvType="6") then
            getDeliveryTypeName = "현장수령"
        end if

        ''Present상품
        if Foitemdiv="09" then
            getDeliveryTypeName = "10x10 Present"
        end if

        ''바로배송
        if (Fodlvfixday="Q") then
            getDeliveryTypeName = "바로배송"
        end if
    end function

    ''All@ 할인된가격
    public function getAllAtDiscountedPrice()
        getAllAtDiscountedPrice =0
        ''기존 상품쿠폰 할인되는경우 추가할인없음.
        ''마일리지샾 상품 추가 할인 없음.
	    ''세일상품 추가할인 없음
	    '' 20070901추가 : 정율할인 보너스쿠폰사용시 추가할인 없음.


        if (Fitemcouponidx<>0) or (IsMileShopSangpum) or (Fissailitem="Y") then
			getAllAtDiscountedPrice = 0
		else
			getAllAtDiscountedPrice = round(((1-0.94) * FItemCost / 100) * 100 ) * FItemNo
		end if
    end function

     ''마일리지샵 상품
    public function IsMileShopSangpum()
		IsMileShopSangpum = false

		if Foitemdiv="82" then
			IsMileShopSangpum = true
		end if
	end function

    ''주문제작 상품
    public function IsRequireDetailExistsItem()
        IsRequireDetailExistsItem = (Foitemdiv="06") or (Frequiredetail<>"")
    end function

    public function getRequireDetailHtml()
		If FrequiredetailUTF8 = "" Then
			getRequireDetailHtml = nl2br(Frequiredetail)
		Else
			getRequireDetailHtml = nl2br(FrequiredetailUTF8)
		End If

		getRequireDetailHtml = replace(getRequireDetailHtml,CAddDetailSpliter,"<br><br>")
	end function

	''후지 포토북 상품 == 2010-06-14추가
    public function ISFujiPhotobookItem()
        ISFujiPhotobookItem = (FMakerid="fdiphoto")
    end function

    public function getPhotobookFileName()
        getPhotobookFileName =""
        if IsNULL(FRequireDetail) then Exit function

        dim buf : buf = split(FRequireDetail,".mpd")
        dim tFileName
        if IsArray(buf) then
            if UBound(buf)>0 then
                tFileName = Replace(buf(0),"[[포토룩스]:","")
                getPhotobookFileName = tFileName&".mpd"
            end if
        end if
    end function

    ''직접 취소 가능상태
    public function IsDirectCancelEnable()
        IsDirectCancelEnable = false

        if IsNULL(Fcurrstate) then
            IsDirectCancelEnable = true
            Exit function
        end if

		'// 상품준비중 이전상태
        IsDirectCancelEnable = (Fcurrstate<3)

        ''2014/06/27 추가 주문제작상품 (821380) 상품준비중 취소 불가------
        if (Fcurrstate=2) and (Fisupchebeasong="N") and (Foitemdiv="06") then
            IsDirectCancelEnable = false
        end if
        ''----------------------------------------------------------------
    end function

    ''직접 품절취소 가능상태
    public function IsDirectStockOutItemCancelEnable()
        IsDirectStockOutItemCancelEnable = false
		if Fmibeasoldoutyn<>"Y" then
			IsDirectStockOutItemCancelEnable = true
			exit function
		end if

        if IsNULL(Fcurrstate) then
            IsDirectStockOutItemCancelEnable = true
            Exit function
        end if

        IsDirectStockOutItemCancelEnable = (Fcurrstate<7)
        ''----------------------------------------------------------------
    end function

    ''취소 요청 가능상태
    public function IsRequireCancelEnable()
        IsRequireCancelEnable = false

		if GetRequireCancelUnableReason() = "" then
			IsRequireCancelEnable = true
		end if

    end function

	public function GetRequireCancelUnableReason()

        ''티켓 상품 취소불가
        if (Foitemdiv="08") then
            GetRequireCancelUnableReason = "티켓상품"
            Exit function
        end If

        ''여행 상품 취소불가
        if (Foitemdiv="18") then
            GetRequireCancelUnableReason = "여행상품"
            Exit function
        end if

        ''현장수령상품 취소불가
        if (FodlvType="6") then
            GetRequireCancelUnableReason = "현장수령상품"
            Exit function
        end if

        ''선물포장된 상품 web상에서 취소불가
        if (FIsPacked="Y") then
            GetRequireCancelUnableReason = "선물포장"
            Exit function
        end if

        '// 해외 직구 web상에서 취소불가
        If (Fodlvfixday="G") Then
            GetRequireCancelUnableReason = "해외직구"
            Exit function
        end if

        '// 바로배송  web상에서 취소불가
        If (Fodlvfixday="Q") Then
            GetRequireCancelUnableReason = "바로배송"
            Exit function
        end if

        ''마일리지샵 취소불가
        if (Foitemdiv="82") then
			GetRequireCancelUnableReason = "마일리지상품"
            Exit function
        end if

        if IsNULL(Fcurrstate) then
            GetRequireCancelUnableReason = ""
            Exit function
        end if

        ''주문제작(문구) 상품 취소불가
        if (Foitemdiv="06") and (Fcurrstate>2) then
            GetRequireCancelUnableReason = "주문제작상품"
            Exit function
        end if

        ''주문제작(일반) 상품 취소불가
        if (Foitemdiv="16") and (Fcurrstate>2) then
            GetRequireCancelUnableReason = "주문제작상품"
            Exit function
        end if

		if (Fcurrstate>6) then
			GetRequireCancelUnableReason = "기출고상품"
		end if

		GetRequireCancelUnableReason = ""
	end function

     ''반품 가능상태
    public function IsDirectReturnEnable()
        IsDirectReturnEnable = false

        if IsNULL(Fcurrstate) then
            IsDirectReturnEnable = false
            Exit function
        end if

        ''마일리지샵 반품불가
        if (Foitemdiv="82") then
            IsDirectReturnEnable = false
            Exit function
        end if

        ''주문제작(문구) 상품 반품불가
        if (Foitemdiv="06") then
            IsDirectReturnEnable = false
            Exit function
        end if

        ''주문제작(일반) 상품 반품불가
        if (Foitemdiv="16") then
            IsDirectReturnEnable = false
            Exit function
        end if

        ''티켓 상품 반품불가
        if (Foitemdiv="08") then
            IsDirectReturnEnable = false
            Exit function
        end If

        ''여행 상품 반품불가
        if (Foitemdiv="18") then
            IsDirectReturnEnable = false
            Exit function
        end if

        ''현장수령상품 반품불가
        if (FodlvType="6") then
            IsDirectReturnEnable = false
            Exit function
        end if

        ''선물포장된 상품 web상에서 반품불가
        if (FIsPacked="Y") then
            IsDirectReturnEnable = false
            Exit function
        end if

        '// 해외 직구 web상에서 반품불가 2018/06/07
        If (Fodlvfixday="G") Then
            IsDirectReturnEnable = false
            Exit function
        end if

        '// 바로배송  web상에서 반품불가 2018/07/05
        If (Fodlvfixday="Q") Then
            IsDirectReturnEnable = false
            Exit function
        end if

        if (IsNULL(Fbeasongdate) or (DateDiff("d",Fbeasongdate,now) > 8)) then  ''기존 14 에서 8로 (공휴일 제외 7일)
            IsDirectReturnEnable = false
            Exit function
        end if

        IsDirectReturnEnable = (Fcurrstate>3)
    end function

    '' 수정 가능상태
    public function IsEditAvailState()
        IsEditAvailState = false

        if IsNULL(Fcurrstate) then
            IsEditAvailState = true
            Exit function
        end if

        IsEditAvailState = (Fcurrstate<3)

        ''2015-10-01 추가 주문제작상품 (821380) 상품준비중 수정 불가------
        if (Fcurrstate=2) and (Fisupchebeasong="N") and (Foitemdiv="06") then
            IsEditAvailState = false
        end if
    end function

    ''수정 요청 가능상태
    public function IsRequireAvailState()
        IsRequireAvailState = false

        if IsNULL(Fcurrstate) then
            IsRequireAvailState = true
            Exit function
        end if

        IsRequireAvailState = (Fcurrstate<7)
    end function

    '' 마스터 현재상태를 같이 넘겨야함.
    public function GetItemDeliverStateName(CurrMasterIpkumDiv, CurrMasterCancelyn)
        if ((CurrMasterCancelyn="Y") or (CurrMasterCancelyn="D") or (Fcancelyn="Y")) then
            GetItemDeliverStateName = "취소"
        else
            if (CurrMasterIpkumDiv="0") then
                GetItemDeliverStateName = "결제 오류"
            elseif (CurrMasterIpkumDiv="1") then
                GetItemDeliverStateName = "주문 실패"
            elseif (CurrMasterIpkumDiv="2") or (CurrMasterIpkumDiv="3") then
                GetItemDeliverStateName = "결제 대기 중"
            elseif (CurrMasterIpkumDiv="9") then
                GetItemDeliverStateName = "반품"
            else
                if (IsNull(Fcurrstate) or (Fcurrstate=0)) then
            		GetItemDeliverStateName = "결제 완료"
                elseif Fcurrstate="2" then
                    GetItemDeliverStateName = "상품 확인 중"
            	elseif Fcurrstate="3" then
            		GetItemDeliverStateName = "상품 포장 중"
            	elseif Fcurrstate="7" then
            		GetItemDeliverStateName = "배송 시작"
            	else
            		GetItemDeliverStateName = ""
            	end if
            end if
        end if
    end function

    '' 마스터 현재상태를 같이 넘겨야함.
    public function GetItemDeliverStateNameNew(CurrMasterIpkumDiv, CurrMasterCancelyn)
        if ((CurrMasterCancelyn="Y") or (CurrMasterCancelyn="D") or (Fcancelyn="Y")) then
            GetItemDeliverStateNameNew = "취소"
        else
            if (CurrMasterIpkumDiv="0") then
                GetItemDeliverStateNameNew = "결제오류"
            elseif (CurrMasterIpkumDiv="1") then
                GetItemDeliverStateNameNew = "주문실패"
            elseif (CurrMasterIpkumDiv="2") or (CurrMasterIpkumDiv="3") then
                GetItemDeliverStateNameNew = "결제 대기 중"
            elseif (CurrMasterIpkumDiv="9") then
                GetItemDeliverStateNameNew = "반품"
            else
                if (IsNull(Fcurrstate) or (Fcurrstate=0)) then
            		GetItemDeliverStateNameNew = "결제완료"
                elseif Fcurrstate="2" then
                    GetItemDeliverStateNameNew = "상품 확인 중"
            	elseif Fcurrstate="3" then
            		GetItemDeliverStateNameNew = "상품 포장 중"
            	elseif Fcurrstate="7" and isnull(Fdlvfinishdt) then
            		GetItemDeliverStateNameNew = "배송 시작"
				elseif Fcurrstate="7" and not isnull(Fdlvfinishdt) then
            		GetItemDeliverStateNameNew = "배송 완료"
            	else
            		GetItemDeliverStateNameNew = ""
            	end if
            end if
        end if
    end function

    public function GetDeliveryName()
        if (Fcurrstate<>"7") then
			GetDeliveryName = ""
			exit function
		end if

        GetDeliveryName = FDeliveryName
    end function

    public function GetSongjangURL()
		if (Fcurrstate<>"7") then
			GetSongjangURL = ""
			exit function
		end if

		if (FDeliveryURL="" or isnull(FDeliveryURL)) or (FSongjangNO="" or isnull(FSongjangNO)) then
			GetSongjangURL = "<span onclick=""alert('▷▷▷▷▷ 화물추적 불능안내 ◁◁◁◁◁\n\n고객님께서 주문하신 상품의 배송조회는\n배송업체 사정상 조회가 불가능 합니다.\n이 점 널리 양해해주시기 바라며,\n보다 빠른 배송처리가 이뤄질수 있도록 최선의 노력을 다하겠습니다.');"" style=""cursor:pointer;"">" & FSongjangNO & "</span>"
		else
			GetSongjangURL = "<a href=" & db2html(FDeliveryURL) & FSongjangNO & " target=""_blank"">" & FSongjangNO & "</a>"
		end if
    end function

    Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
end Class

Class CUpcheBeasongPayItem

	public Fmakerid
	public Fdefaultfreebeasonglimit
	public Fdefaultdeliverpay

	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
end Class

class CMyOrderMasterItem
    public Forderserial
    public Fidx
    public Fjumundiv
    public Fuserid
    public Faccountname
    public Faccountdiv
    public Faccountno
    public Ftotalmileage
    public Ftotalsum
    public Fipkumdiv
    public Fipkumdate
    public Fregdate
    public Fbeadaldiv
    public Fbeadaldate
    public Fcancelyn
    public Fbuyname
    public Fbuyphone
    public Fbuyhp
    public Fbuyemail
    public Freqname
    public Freqzipcode
    public Freqzipaddr
    public Freqaddress
    public Freqphone
    public Freqhp
    public Fcomment
    public Fdeliverno
    public Fsitename
    public Fpaygatetid
	Public Fpggubun
    public Fdiscountrate
    public Fsubtotalprice

    public Fresultmsg
    public Frduserid
    public Fmiletotalprice

    public Fauthcode
    public Fsongjangdiv
    public Frdsite
    public Ftencardspend

    public Freqdate
    public Freqtime
    public Fcardribbon
    public Fmessage
    public Ffromname
    public Fcashreceiptreq
    public Finireceipttid
    public Freferip
    public Fuserlevel
    public Flinkorderserial
    public Fspendmembership
    public Fsentenceidx
    public Fbaljudate
    public Fallatdiscountprice
    public FInsureCd
    public FInsureMsg
    public FCancelDate
	public FcsReturnCnt
	public FOrderSheetYN

    ''public FDeliverOption
    public FDeliverPrice
    public FDeliverpriceCouponNotApplied
	Public FArriveDeliverCnt

    public FItemNames
    public FItemCount

    ''해외배송 관련 추가
    public FDlvcountryCode
    public FDlvcountryName
    public FemsAreaCode
    public FemsZipCode
    public FitemGubunName
    public FgoodNames
    public FitemWeigth
    public FitemUsDollar
    public FemsInsureYn
    public FemsInsurePrice
    public FReqEmail

    ''OkCashbag 추가
    public FokcashbagSpend
    ''예치금 추가
    public Fspendtencash
    ''Gift카드 추가
    public Fspendgiftmoney
    ''상품쿠폰제외금액(할인판매가)
    public FsubtotalpriceCouponNotApplied
    ''보조결제합계
    public FsumPaymentEtc
    public Fcash_receipt_tid

    ''티켓 취소 관련
    public FmayTicketCancelChargePro
    public FticketCancelDisabled
    public FticketCancelStr

    ''NPayPoint 추가
    public FspendNpayPoint

	'오프샵 주문 프론트 적용
	public FShopName
	public Frealsum
	public Fjumunmethod
	public Fshopregdate
	public Fspendmile
	public Fgainmile
	public Fcashsum
	public Fcardsum
	public FGiftCardPaySum
	public FTenGiftCardPaySum
	public FCashReceiptNo
	public FCardAppNo
	public FPoint
	public FUserName
	public FEmail
	public FTelNo
	public FHpNo
	public FdeliverEndCnt

    public function IsTicketOrder
        IsTicketOrder = (Fjumundiv="4")
    end function

    public function IsTravelOrder
        IsTravelOrder = (Fjumundiv="3")
    end function

    public function IsChangeOrder
        IsChangeOrder = (Fjumundiv="6")
    end function

    public function IsReceiveSiteOrder
        IsReceiveSiteOrder = (Fjumundiv="7")
    end function

    public function IsGiftiConCaseOrder
        IsGiftiConCaseOrder = (IsGifttingOrder or IsGiftiConOrder)
    end function

    public function IsGifttingOrder
        IsGifttingOrder = Faccountdiv = "550"
    end function

    public function IsGiftiConOrder
        IsGiftiConOrder = Faccountdiv = "560"
    end function

    ''' 상품쿠폰 미반영 금액이 없는경우.(2011-04 이전 데이타)
	public function IsNoItemCouponData
	    IsNoItemCouponData = (FsubtotalpriceCouponNotApplied<Fsubtotalprice)
	end function


    '''주결제수단 금액 = subtotalPrice-FsumPaymentEtc
    public function TotalMajorPaymentPrice()
        TotalMajorPaymentPrice = FsubtotalPrice-FsumPaymentEtc
    end function

    '''보조결제 수단 존재여부 (okCashBag, 예치금)
    public function IsSubPaymentExists()
        IsSubPaymentExists = (FsumPaymentEtc<>0)
    end function

    ''네이버페이 포인트 사용 금액 있는지.
    public function IsSpendNpayPointExists()
        IsSpendNpayPointExists = false
        if (Fpggubun="NP") then
            IsSpendNpayPointExists = (FspendNpayPoint<>0)
        end if
    end function

    public function getItemCouponDiscountPrice()
        getItemCouponDiscountPrice = FsubtotalpriceCouponNotApplied-Ftotalsum
    end function

    ''해외배송인지 여부 (해외배송 반품은..?)
    public function IsForeignDeliver()
        IsForeignDeliver = (Not IsNULL(FDlvcountryCode)) and (FDlvcountryCode<>"") and (FDlvcountryCode<>"KR") and (FDlvcountryCode<>"ZZ") and (FDlvcountryCode<>"Z4") and (FDlvcountryCode<>"QQ")  ''2017/12/15 QQ(퀵배송 추가)
    end function

    ''군부대 배송인지여부
    public function IsArmiDeliver()
        IsArmiDeliver = (Not IsNULL(FDlvcountryCode)) and (FDlvcountryCode="ZZ")
    end function

    ''퀵배송
    public function IsQuickDeliver()
        IsQuickDeliver = (Not IsNULL(FDlvcountryCode)) and (FDlvcountryCode="QQ")
    end function

    public function IsPayed()
        IsPayed = (FIpkumdiv>3)
    end function

    public function IsEtcDiscountExists()
        IsEtcDiscountExists = (FTotalSum<>Fsubtotalprice)
    end function

    public function GetTotalEtcDiscount()
        GetTotalEtcDiscount = Fspendmembership + Ftencardspend + Fmiletotalprice + Fallatdiscountprice
    end function

    public function IsValidOrder()
        IsValidOrder = (FIpkumdiv>1) and (FCancelyn="N")
    end function

    function getSubPaymentStr()
        dim disCountStr
         if Not (IsSubPaymentExists) then
            getSubPaymentStr = ""
            Exit function
         end if


        if (FspendTenCash>0) then
            disCountStr = disCountStr&"예치금 사용 : "& FormatNumber(FspendTenCash,0) & " 원 / "
        end if

        if (Fspendgiftmoney>0) then
            disCountStr = disCountStr&"Gift카드 사용 : "& FormatNumber(Fspendgiftmoney,0) & " 원 / "
        end if

        disCountStr = Trim(disCountStr)
        If Right(disCountStr,1)="/" then disCountStr=Left(disCountStr,Len(disCountStr)-1)

        ''If (disCountStr<>"") then
        ''    disCountStr = "=총 주문금액 : " & FormatNumber(FsubTotalPrice,0) & " - " & disCountStr
        ''end if
        getSubPaymentStr = disCountStr

    end function

    ''=================================================================================================
    ''주문정보 (웹 변경가능)
    public function IsWebOrderInfoEditEnable()
        IsWebOrderInfoEditEnable = false
        if (Not IsValidOrder) then Exit function
        if IsChangeOrder then Exit function

        IsWebOrderInfoEditEnable = (FIpkumdiv<6)
    end function

    ''입금자명 직접수정 가능여부
    public function IsEditEnable_AccountName()
        IsEditEnable_AccountName = false

        if (Fipkumdiv="2") then
            IsEditEnable_AccountName = true
        end if
    end function

    ''입금은행 직접수정 가능여부
    public function IsEditEnable_AccountNO()
        IsEditEnable_AccountNO = false

        if (Fipkumdiv="2") then
            IsEditEnable_AccountNO = true
        end if

        if (IsDacomCyberAccountPay) then
            IsEditEnable_AccountNO = false
        end if
    end function



    ''데이콤 가상계좌 결제인지
    public function IsDacomCyberAccountPay()
        IsDacomCyberAccountPay = false
        if (FAccountdiv<>"7") then Exit function

        if (FAccountNo="국민 470301-01-014754") _
            or (FAccountNo="신한 100-016-523130") _
            or (FAccountNo="우리 092-275495-13-001") _
            or (FAccountNo="하나 146-910009-28804") _
            or (FAccountNo="기업 277-028182-01-046") _
            or (FAccountNo="농협 029-01-246118") then
                IsDacomCyberAccountPay = false
        else
            IsDacomCyberAccountPay = true
        end if
    end function



    ''주문정보 (웹 변경불가 - CS요청시 가능)
    public function IsWebOrderInfoEditRequirable()
        IsWebOrderInfoEditRequirable = false
        if (Not IsValidOrder) then Exit function

        IsWebOrderInfoEditRequirable = ((FIpkumdiv=6) or (FIpkumdiv=7))
    end function

    ''=================================================================================================
    ''주문취소 (웹 취소가능, 전체취소)
    public function IsWebOrderCancelEnable()
        IsWebOrderCancelEnable = false
        if (Not IsValidOrder) then Exit function
        if IsChangeOrder then Exit function
        ''2012-01-26 추가
        if (IsGiftiConCaseOrder) then Exit function

        ''현장수령 5/26일 이후 취소 불가.
        ''if (IsReceiveSiteOrder) and (Now()>"2012-05-26") then Exit function

        IsWebOrderCancelEnable = (FIpkumdiv<6)

        if (IsTicketOrder) then
            if (FIpkumdiv<4) then Exit function

            if (FticketCancelDisabled) or (FmayTicketCancelChargePro>0) then
                IsWebOrderCancelEnable = false
                Exit function
            end if
        end if
    end function

	''주문취소 (웹 취소가능, 부분취소)
    public function IsWebOrderPartialCancelEnable()
        IsWebOrderPartialCancelEnable = false
        if (Not IsWebStockOutItemCancelEnable) then Exit function

		'// 결제완료 이전에는 일부취소 불가, 매출로그에 결제이전 추가배송비 처리안되어 있음
		'// 가상계좌 입금금액은 고정되어 있기 때문에 부분취소 불가
		'// 일부출고시에도 취소접수 가능
		IsWebOrderPartialCancelEnable = (FIpkumdiv<"8") and (FIpkumdiv>"3") ''and (Fuserid = "10x10green")
    end function

    ''=================================================================================================
    ''주문취소 (웹 품절취소 취소가능)
    public function IsWebStockOutItemCancelEnable()
        IsWebStockOutItemCancelEnable = false
        if (Not IsValidOrder) then Exit function
        if IsChangeOrder then Exit function
		if (IsGiftiConCaseOrder) then Exit function
		if (IsTicketOrder) then Exit function

        IsWebStockOutItemCancelEnable = (FIpkumdiv<8)
    end function

    ''주문취소 (웹 취소불가 - CS요청시 가능할 수 있음)
    public function IsWebOrderCancelRequirable()
        IsWebOrderCancelRequirable = false
        if (Not IsValidOrder) then Exit function

        IsWebOrderCancelRequirable = ((FIpkumdiv=6) or (FIpkumdiv=7))

        if (IsTicketOrder) then
            if (FticketCancelDisabled) then
                IsWebOrderCancelRequirable = false
            elseif (FmayTicketCancelChargePro>0) then
                IsWebOrderCancelRequirable = true
            end if
            Exit function
        end if
    end function

    ''=================================================================================================
    ''반품 (웹 반품가능)
    public function IsWebOrderReturnEnable()
        IsWebOrderReturnEnable = false
        if (Not IsValidOrder) then Exit function
        if IsChangeOrder then Exit function
        ''2012-01-26 추가
        if (IsGiftiConCaseOrder) then Exit function

        '' 출고 이후 N 일 이상된 상품은 반품 불가
        if IsNULL(Fbeadaldate) or (DateDiff("d",Fbeadaldate,now) > 14) then Exit function

        IsWebOrderReturnEnable = (FIpkumdiv>6)
        IsWebOrderReturnEnable = IsWebOrderReturnEnable and (FJumundiv<>9)          '''반품 주문은 불가.
        IsWebOrderReturnEnable = IsWebOrderReturnEnable and (not IsTicketOrder)     '''티켓 주문은 반품 불가.

    end function

    ''=================================================================================================


    ''=================================================================================================
    '' 각종 증명서 관련  R(현금영수증 요청), S(현금영수증발행) ,T(계산서요청),U(계산서발행)

    ''전자보증서 존재
    public function IsInsureDocExists()
        IsInsureDocExists = (FInsureCd="0")
    end function

    ''현금영수증 신청 기발행 내역 있는경우
    ''public function IsCashReceiptAlreadyEvaled()
    ''    IsCashReceiptAlreadyEvaled = ((FAccountDiv="7") or (FAccountDiv="20")) and (FAuthCode<>"") or (FcashreceiptReq="S")
    ''end function

    ''이니시스 실시간 이체시 같이 발급되는 현금영수증 (2011-04-18 이전)
    public function IsDirectBankCashreceiptExists()
        IsDirectBankCashreceiptExists = ((Faccountdiv = "20") and (FAuthCode<>"") and (FcashreceiptReq="") and FIpkumdiv>3)
    end function

    public function getCashDocTargetSum()
        getCashDocTargetSum = 0
        if (Fipkumdiv<"4") then Exit function

        if (Faccountdiv = "20") or (Faccountdiv = "7") then
            getCashDocTargetSum=FsubTotalPrice
            Exit function
        end if

        if (Not ((Faccountdiv = "20") or (Faccountdiv = "7"))) then
            getCashDocTargetSum=FsumPaymentEtc
            Exit function
        end if
    end function

	public function GetSuppPrice()
	    dim targetPrc : targetPrc=getCashDocTargetSum
		GetSuppPrice = CLng(targetPrc/1.1)
	end function

	public function GetTaxPrice()
	    dim targetPrc : targetPrc=getCashDocTargetSum
		GetTaxPrice = targetPrc-GetSuppPrice
	end function

    ''현금영수증/세금계산서 발행 가능한지
    public function IsCashDocReqValid()
        IsCashDocReqValid = false
        If (Not IsPayed) then Exit function
        if IsNULL(FIpkumdate) then Exit function
        if Not (dateDiff("d",Fipkumdate,date())<=61) then Exit function  '''두달이내만 신청 가능 => 3달 :: 2013/06/27 =>2달

        ''if (IsPaperRequestExist) then Exit function
        if (Not IsSubPaymentExists) and (NOT IsSpendNpayPointExists) and (Not ((Faccountdiv = "7") or (Faccountdiv = "20"))) then Exit function

        IsCashDocReqValid = true
    end function

    '증빙서류 발급가능한지
    public function GetPaperAvailableString()
        GetPaperAvailableString = ""

        if (Fcancelyn = "Y") then
        	GetPaperAvailableString = "취소된 주문입니다."
        	exit function
        end if

        if (FIpkumDiv < 4) then
        	GetPaperAvailableString = "결제이전 주문입니다."
        	exit function
        end if

        if (Faccountdiv <> "7") and (Faccountdiv <> "20") and (sumPaymentEtc < 1) then
        	GetPaperAvailableString = "발행대상 금액이 없습니다."
        	exit function
        end if
    end function

	'증빙서류신청이 있었는지
    public function IsPaperRequestExist()
        IsPaperRequestExist = false

        if (IsPaperRequested or IsPaperFinished) then
        	IsPaperRequestExist = true
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
    ''=================================================================================================

    ''마일리지 샵 상품 합계
    public function GetMileageShopItemPrice(idetail)
        dim i
        dim retVal
        retVal = 0

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        			    if (idetail.FItemList(i).IsMileShopSangpum) then
        			    retVal = retVal + idetail.FItemList(i).FItemNo*idetail.FItemList(i).Fitemcost
        			    end if
        			end if
        		end if
    		next
        end if

        GetMileageShopItemPrice = retVal
    end function

    '''상품판매가금액합계(상품쿠폰제외)
    public function GetTotalItemcostCouponNotAppliedSum(idetail)
        dim i
        dim costSum
        costSum = 0

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        			    costSum = costSum + idetail.FItemList(i).getItemcostCouponNotApplied*idetail.FItemList(i).FItemNo
        			end if
        		end if
    		next
        end if

        GetTotalItemcostCouponNotAppliedSum = costSum
    end function

    '''상품쿠폰 할인 금액 합계
    public function GetTotalItemcostCouponDiscountSum(idetail)
        dim i
        dim costSum
        costSum = 0

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        			    costSum = costSum + idetail.FItemList(i).getItemCouponDiscount*idetail.FItemList(i).FItemNo
        			end if
        		end if
    		next
        end if

        GetTotalItemcostCouponDiscountSum = costSum
    end function


    ''상품 총 갯수
    public function GetTotalOrderItemCount(idetail)
        dim i
        dim itemcountSum
        itemcountSum = 0

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        			    itemcountSum = itemcountSum + idetail.FItemList(i).FItemNo
        			end if
        		end if
    		next
        end if

        GetTotalOrderItemCount = itemcountSum
    end function

    ''플라워 지정일 배송 주문 존재여부
    public function IsFixDeliverItemExists()
        IsFixDeliverItemExists = Not(IsNULL(Freqdate)) and Not(IsReceiveSiteOrder)
    end function

    '' 플라워 지정일 시각
    public function GetReqTimeText()
        if IsNULL(Freqtime) then Exit function
        GetReqTimeText = Freqtime & "~" & (Freqtime+2) & "시 경"
    end function

    ''주문자정보 직접수정 가능여부
    public function IsEditEnable_BuyerInfo(idetail)
        dim i
        IsEditEnable_BuyerInfo = false

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if (Not (idetail.FItemList(i).IsEditAvailState)) then
        					IsEditEnable_BuyerInfo = false
        					Exit function
        				end if
        			end if
        		end if
    		next

    		IsEditEnable_BuyerInfo = true
        end if
    end function

    ''주문자정보 수정요청 가능여부
    public function IsRequireEnable_BuyerInfo(idetail)
        dim i
        IsRequireEnable_BuyerInfo = false

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if Not (idetail.FItemList(i).IsRequireAvailState) then
        					IsRequireEnable_BuyerInfo = false
        					Exit function
        				end if
        			end if
        		end if
    		next

    		IsRequireEnable_BuyerInfo = true
        end if

    end function


    ''배송정보 직접수정 가능여부
    public function IsEditEnable_ReceiveInfo(idetail)
        IsEditEnable_ReceiveInfo = IsEditEnable_BuyerInfo(idetail)
    end function

    ''배송정보 수정요청 가능여부
    public function IsRequireEnable_ReceiveInfo(idetail)
        IsRequireEnable_ReceiveInfo = IsRequireEnable_BuyerInfo(idetail)
    end function

    ''포토북 상품 존재 여부
    public function IsPhotoBookItemExists(idetail)
        IsPhotoBookItemExists = false

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if (idetail.FItemList(i).ISFujiPhotobookItem) then
        					IsPhotoBookItemExists = true
        					Exit function
        				end if
        			end if
        		end if
    		next
        end if
    end function

    ''주문제작 상품 존재 여부
    public function IsRequireDetailItemExists(idetail)
        IsRequireDetailItemExists = false

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if (idetail.FItemList(i).IsRequireDetailExistsItem) then
        					IsRequireDetailItemExists = true
        					Exit function
        				end if
        			end if
        		end if
    		next
        end if
    end function


    ''주문제작 문구 직접수정 가능여부 **
    public function IsEditEnable_HandmadeMsgExists(idetail)
        IsEditEnable_HandmadeMsgExists = false

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if (idetail.FItemList(i).IsRequireDetailExistsItem) and (idetail.FItemList(i).IsEditAvailState) then
        					IsEditEnable_HandmadeMsgExists = true
        					Exit function
        				end if
        			end if
        		end if
    		next
        end if
    end function

    ''주문제작 문구 수정요청 가능여부
    public function IsRequireEnable_HandmadeMsgExists(idetail)
        IsRequireEnable_HandmadeMsgExists = false

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if (idetail.FItemList(i).IsRequireDetailExistsItem) and (idetail.FItemList(i).IsRequireAvailState) then
        					IsRequireEnable_HandmadeMsgExists = true
        					Exit function
        				end if
        			end if
        		end if
    		next
        end if
    end function

    '' 해외 직구 포함 주문인가.
    public function IsGlobalDirectPurchaseItemExists(idetail)
        IsGlobalDirectPurchaseItemExists = false

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if (idetail.FItemList(i).IsGlobalDirectPurchaseItem) then
        					IsGlobalDirectPurchaseItemExists = true
        					Exit function
        				end if
        			end if
        		end if
    		next
        end if
    end function

    '' 해외 직구 통관번호 수정 가능한 상태인가? :: 출고 왈료상태는 수정못함.
    public function isUniPassNumberEditEnable(idetail)
        isUniPassNumberEditEnable = True

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if (idetail.FItemList(i).IsGlobalDirectPurchaseItem) and (idetail.FItemList(i).Fcurrstate>=7) then
        					isUniPassNumberEditEnable = false
        					Exit function
        				end if
        			end if
        		end if
    		next
        end if
    end function

    ''주문 Master 상태로 직접 취소 가능여부 확인 - > IsWebOrderCancelEnable로 변경
'    public function IsDirectCancelEnable()
'        IsDirectCancelEnable = (FCancelyn="N")
'        IsDirectCancelEnable = (IsDirectCancelEnable) And (FIpkumdiv<5)
'
'    end function

    ''전체 취소/요청 가능 여부
    public function IsDirectALLCancelEnable(idetail)
        IsDirectALLCancelEnable = false
        dim i

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if Not (idetail.FItemList(i).IsDirectCancelEnable) then
        					IsDirectALLCancelEnable = false
        					Exit function
        				end if
        			end if
        		end if
    		next
        end if

        IsDirectALLCancelEnable = true
    end function

    ''부분 취소신청 가능 여부
    public function IsRequestPartialCancelEnable(idetail)
        IsRequestPartialCancelEnable = false
        dim i

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if (idetail.FItemList(i).IsRequireCancelEnable) then
        					IsRequestPartialCancelEnable = true
        					Exit function
        				end if
        			end if
        		end if
    		next
        end if
    end function

    ''품절 취소/요청 가능 여부
    public function IsDirectStockOutPartialCancelEnable(idetail)
		dim stockOutItemExist : stockOutItemExist = False
        IsDirectStockOutPartialCancelEnable = false

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
						if (idetail.FItemList(i).Fmibeasoldoutyn = "Y") then
							stockOutItemExist = True

        					if Not (idetail.FItemList(i).IsDirectStockOutItemCancelEnable) then
        						Exit function
        					end if
						end if
        			end if
        		end if
    		next
        end if

		IsDirectStockOutPartialCancelEnable = stockOutItemExist
    end function


    ''선물포장 있는지.
    public function IsPackItemExists(idetail)
        dim vTemp, icnt, isum
        icnt = 0
        isum = 0

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				if (idetail.FItemList(i).FItemID = "100") then
        					icnt = icnt + idetail.FItemList(i).Fitemno
        					isum = isum + (idetail.FItemList(i).FItemCost * idetail.FItemList(i).Fitemno)
        				end if
        			end if
        		end if
    		next
        end if
        If icnt > 0 AND isum > 0 Then
        	vTemp = icnt & "," & isum
    	End If
    	IsPackItemExists = vTemp
    end function


    '' 전체 카드 취소 Type
    public function IsCardCancelRequire(IsAllCancell)
        IsCardCancelRequire = false

        if (Not IsPayed) then Exit function

        '' 신용카드 or All@ And 전체취소인경우
        if ((Faccountdiv="100") or (Faccountdiv="110") or (Faccountdiv="80")) and (IsAllCancell) then IsCardCancelRequire=true
    end function


    '' 실시간 이체 취소 Type
    public function IsRealTimeAcctCancelRequire(IsAllCancell)
        IsRealTimeAcctCancelRequire = false

        if (Not IsPayed) then Exit function

        '' 실시간 이체 And 전체취소인경우
        if (Faccountdiv="20") and (IsAllCancell) then IsRealTimeAcctCancelRequire=true
    end function


    '' 무통장 취소 환불 type
    public function IsAcctRefundRequire(IsAllCancell)
        IsAcctRefundRequire = false

        if (Not IsPayed) then Exit function

        ''무통장 입금인경우 or 부분취소
        if (Faccountdiv="7") or (Not IsAllCancell) then IsAcctRefundRequire = true
    end function


    '' 핸드폰 취소 환불 type
    public function IsMobileCancelRequire(IsAllCancell)
        IsMobileCancelRequire = false

        if (Not IsPayed) then Exit function

        ''핸드폰 And 전체취소인경우
        if (Faccountdiv="400") and (IsAllCancell) then IsMobileCancelRequire=true
    end function

    '' 네이버페이 취소 환불 type
    public function IsNPayCancelRequire(IsAllCancell)
        IsNPayCancelRequire = false

        if (Not IsPayed) then Exit function

        ''핸드폰 And 전체취소인경우
        if (Fpggubun="NP") and (IsAllCancell) then IsNPayCancelRequire=true
    end function

    public function IsTossPayCancelRequire(IsAllCancell)
        IsTossPayCancelRequire = false

        if (Not IsPayed) then Exit function

        ''핸드폰 And 전체취소인경우
        if (Fpggubun="TS") and (IsAllCancell) then IsTossPayCancelRequire=true
    end function

    ''취소 시 환불액
    public function getCancelRefundValue(idetail,IsAllCancell)
        dim orgBeasongPay
        getCancelRefundValue = 0
        orgBeasongPay = FDeliverprice

        '' 전체 취소 일경우 전체금액 환불
        if (IsAllCancell) then
            getCancelRefundValue = FSubTotalPrice - FsumPaymentEtc

            Exit function
        end if

        dim total_item_price
        total_item_price = 0
        ''부분 취소일 경우.

        if (isEmpty(idetail)) then Exit function
        if (idetail is Nothing) then Exit function

        if isArray(idetail.FItemList) then
            for i=LBound(idetail.FItemList) to UBound(idetail.FItemList)
                if Not (isEmpty(idetail.FItemList(i))) then
        			if Not (idetail.FItemList(i) is Nothing) then
        				total_item_price = total_item_price + idetail.FItemList(i).FItemNo*idetail.FItemList(i).FItemCost
        			end if
        		end if
    		next
        end if


        ''쿠폰등 사용으로 환불금액이 더 많아질경우 - 취소 불가.
        if (total_item_price>FSubTotalPrice) then
            getCancelRefundValue = 0
            Exit function
        end if

        ''취소시 마일리지 사용 기본값(30,000) 보다 원금액이 작을경우


        ''취소시 쿠폰 사용액 보다 원금액이 작을경우


        ''취소시 올엣/멤버십 할인보다 원금액이 작을경우


        getCancelRefundValue = total_item_price
    end function


    ''주문 상품 명
    public function GetItemNames()
		if (FItemCount>1) then
			GetItemNames = FItemNames + " 외 " + CStr(FItemCount-1) + "건"
		elseif (FItemCount=0) then
			GetItemNames = "배송비 추가결제"
		else
			GetItemNames = FItemNames
		end if
	end function

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
            case "550"
                : GetAccountdivName = "기프팅"
            case "560"
                : GetAccountdivName = "기프티콘"
            case else
                : GetAccountdivName = ""
        end select

		Select Case FpgGubun
			Case "KA"
				GetAccountdivName = "카카오페이(" & GetAccountdivName & ")"
			Case "NP"
				GetAccountdivName = "네이버페이"
			Case "PY"
				GetAccountdivName = "페이코간편결제"
            Case "KK"
                If oacctdiv = "20" Then
				    GetAccountdivName = "카카오페이(머니)"
                Else
				    GetAccountdivName = "카카오페이(카드결제)"
                End If
			Case "TS"
				If oacctdiv = "20" Then
					GetAccountdivName = "토스결제(머니)"
				Else
					GetAccountdivName = "토스결제(카드결제)"
				End If
			Case "CH"
				GetAccountdivName = "차이페이"
		End Select
    end function

    function GetIpkumDivName()
        dim oipkumdiv
        if IsNULL(Fipkumdiv) then Exit function
        oipkumdiv = Trim(Fipkumdiv)

        select case oipkumdiv
            case "0"
                : GetIpkumDivName = "주문 실패"
            case "1"
                : GetIpkumDivName = "주문 실패"
            case "2"
                : GetIpkumDivName = "결제 대기 중"
            case "3"
                : GetIpkumDivName = "결제 대기 중"
            case "4"
                : GetIpkumDivName = "결제 완료"
            case "5"
                : GetIpkumDivName = "상품 확인 중"
            case "6"
                : GetIpkumDivName = "상품 포장 중"
            case "7"
                : GetIpkumDivName = "부분 배송 시작"
            case "8"
                : if (Fjumundiv = "9") then
                	GetIpkumDivName = "반품 완료"
                else
                	GetIpkumDivName = "배송 시작"
                end if
            case "9"
                : GetIpkumDivName = "반품"
            case else
                : GetIpkumDivName = ""
        end select
    end function

	function GetIpkumDivNameNew()
        dim oipkumdiv
        if IsNULL(Fipkumdiv) then Exit function
        oipkumdiv = Trim(Fipkumdiv)

        select case oipkumdiv
            case "0"
                : GetIpkumDivNameNew = "주문 실패"
            case "1"
                : GetIpkumDivNameNew = "주문 실패"
            case "2"
                : GetIpkumDivNameNew = "결제 대기 중"
            case "3"
                : GetIpkumDivNameNew = "입금 대기"
            case "4"
                : GetIpkumDivNameNew = "결제 완료"
            case "5"
                : GetIpkumDivNameNew = "상품 확인 중"
            case "6"
                : GetIpkumDivNameNew = "상품 포장 중"
            case "7"
                : GetIpkumDivNameNew = "부분 배송 시작"
            case "8"
                : if (Fjumundiv = "9") then
                	GetIpkumDivNameNew = "반품 완료"
                else
                	if FItemCount=FdeliverEndCnt then
						GetIpkumDivNameNew = "배송 완료"
					else
						GetIpkumDivNameNew = "배송 시작"
					end if
                end if
            case "9"
                : GetIpkumDivNameNew = "반품"
            case else
                : GetIpkumDivNameNew = ""
        end select
    end function

    public function GetIpkumDivColor()
        dim oipkumdiv
        if IsNULL(Fipkumdiv) then Exit function
        oipkumdiv = Trim(Fipkumdiv)

        select case oipkumdiv
            case "0"
                : GetIpkumDivColor = ""
            case "1"
                : GetIpkumDivColor = ""
            case "2"
                : GetIpkumDivColor = ""
            case "3"
                : GetIpkumDivColor = ""
            case "4"
                : GetIpkumDivColor = "cMt0V15"
            case "5"
                : GetIpkumDivColor = ""
            case "6"
                : GetIpkumDivColor = ""
            case "7"
                : GetIpkumDivColor = ""
            case "8"
                : GetIpkumDivColor = "cRd0V15"
            case "9"
                : GetIpkumDivColor = ""
            case else
                : GetIpkumDivColor = ""
        end select
    end function

    public function GetIpkumDivCSS()
        dim oipkumdiv
        if IsNULL(Fipkumdiv) then Exit function
        oipkumdiv = Trim(Fipkumdiv)

        select case oipkumdiv
            case "0"
                : GetIpkumDivCSS = ""
            case "1"
                : GetIpkumDivCSS = ""
            case "2"
                : GetIpkumDivCSS = ""
            case "3"
                : GetIpkumDivCSS = ""
            case "4"
                : GetIpkumDivCSS = "crMint"
            case "5"
                : GetIpkumDivCSS = "crMint"
            case "6"
                : GetIpkumDivCSS = "crMint"
            case "7"
                : GetIpkumDivCSS = "crRed"
            case "8"
                : GetIpkumDivCSS = "crRed"
            case "9"
                : GetIpkumDivCSS = "crRed"
            case else
                : GetIpkumDivCSS = ""
        end select
    end function

    public function GetCardLibonText()
		if (Fcardribbon="1") then
			GetCardLibonText = "카드"
		elseif (Fcardribbon="2") then
			GetCardLibonText = "리본"
		else
			GetCardLibonText = "없음"
		end if
	end function

    Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
end class

Class CMyOrder
    public FItemList()
    public FOneItem

    public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount
	public FTotalCount

	public FTotalSum

	public FRectUserID
	public FRectSiteName
	public FRectOrderserial
	public FRectIdx
	public FRectOldjumun
	public FrectSearchGubun
	public FRectArea
	public FTotSubPaymentSum

	public FRectStartDate
	public FRectEndDate

	'''public FRectIdxArray

	public function GetGoodsName()
		dim i, buf
		for i=0 to FResultCount-1
			buf = FItemList(i).FItemName
			exit for
		next

		if FResultCount>1 then
			buf = buf + "외 " + Cstr(FResultCount-1) + "건"
		end if

		GetGoodsName = buf
	end function

	public function getPreCancelorAddItemCount()
	    dim sqlStr, mastertable, detailtable
	    getPreCancelorAddItemCount = 0
	    if (FRectOldjumun<>"") then
			mastertable = "[db_log].[dbo].tbl_old_order_master_2003"
			detailtable	= "[db_log].[dbo].tbl_old_order_detail_2003"
		else
			mastertable = "[db_order].[dbo].tbl_order_master"
			detailtable	= "[db_order].[dbo].tbl_order_detail"
		end if

		sqlStr = " SELECT count(*) as CNT"
		sqlStr = sqlStr & " FROM " + detailtable
		sqlStr = sqlStr & " WHERE orderserial='" + FRectOrderserial + "'"
		sqlStr = sqlStr & " and cancelyn<>'N'"

		rsget.Open sqlStr,dbget,1
        if Not rsget.Eof then
		    getPreCancelorAddItemCount = rsget("CNT")
		end if
		rsget.close
    end function

	' 내 주문 아이템 목록 전부 6개월 이내 최근만
	public Sub GetMyOrderItemList()
	    dim sqlStr, i
        sqlStr = " exec [db_order].[dbo].sp_Ten_MyOrderItemList '" & GetLoginUserID() & "'"

		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		FTotalCount = rsget.RecordCount
		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end If

		If FCurrPage >= FtotalPage Then
			FResultCount = FTotalCount Mod FPageSize
		Else
			FResultCount = FPageSize
		End If
        if (FResultCount<1) then FResultCount=0

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof Or i > FResultCount
				set FItemList(i) = new CMyOrderDetailItem
				FItemList(i).Fidx           = rsget("idx")
				FItemList(i).FOrderSerial   = rsget("Orderserial")
				FItemList(i).FItemId        = rsget("itemid")

				FItemList(i).FItemName       = db2html(rsget("itemname"))
				FItemList(i).FItemOption     = rsget("itemoption")
				FItemList(i).FItemNo         = rsget("itemno")
				FItemList(i).FItemOptionName = db2html(rsget("itemoptionname"))
				FItemList(i).FImageSmall     = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemID(FItemList(i).FItemId) + "/" + rsget("smallimage")
				FItemList(i).FImageList      = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemID(FItemList(i).FItemId) + "/" + rsget("listimage")
				FItemList(i).FSongJangNo     = rsget("songjangno")
				FItemList(i).FSongjangDiv    = rsget("songjangdiv")
				FItemList(i).Fmakerid        = rsget("makerid")
				FItemList(i).Fbrandname      = db2html(rsget("brandname"))
				FItemList(i).FItemCost		 = rsget("itemcost")
				FItemList(i).FreducedPrice   = rsget("reducedPrice")
				FItemList(i).FCurrState		 = rsget("currstate")
				FItemList(i).Fitemdiv		 = rsget("itemdiv")
				FItemList(i).FCancelYn       = rsget("cancelyn")
				FItemList(i).Fisupchebeasong = rsget("isupchebeasong")
                FItemList(i).Frequiredetail = db2html(rsget("requiredetail"))
				FItemList(i).FrequiredetailUTF8 = db2html(rsget("requiredetailUTF8"))
				FItemList(i).FMileage		= rsget("mileage")

                FItemList(i).Foitemdiv       = rsget("oitemdiv")
				FItemList(i).Fomwdiv         = rsget("omwdiv")
				FItemList(i).Fodlvtype       = rsget("odlvtype")

				FItemList(i).FisSailitem       = rsget("issailitem")

				'FItemList(i).FMasterSongJangNo   = FMasterItem.FSongjangNo

				i=i+1
				rsget.movenext
			loop
		end if

		rsget.Close


	End Sub

    public Sub getSubPaymentList()
        dim sqlStr, i
        if (FRectOldjumun<>"") then
	        sqlStr = " exec [db_order].[dbo].sp_TenSubPaymentList '" & FRectOrderserial & "',0"
        else
            sqlStr = " exec [db_order].[dbo].sp_TenSubPaymentList '" & FRectOrderserial & "',1"
        end if

        rsget.CursorLocation = adUseClient
        rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly
        FTotalcount = rsget.Recordcount
		FResultcount = FTotalcount

        redim preserve FItemList(FTotalcount)

        i = 0
        FTotSubPaymentSum = 0
        if Not rsget.Eof then
			do until rsget.Eof
				set FItemList(i) = new COrderSubPaymentItem
				FItemList(i).Forderserial   = rsget("orderserial")
                FItemList(i).Facctdiv       = rsget("acctdiv")
                FItemList(i).Facctamount    = rsget("acctamount")
                FItemList(i).FrealPayedsum  = rsget("realPayedsum")
                FItemList(i).FacctAuthCode  = rsget("acctAuthCode")
                FItemList(i).FacctAuthDate  = rsget("acctAuthDate")

                FTotSubPaymentSum = FTotSubPaymentSum + FItemList(i).Facctamount
				i=i+1
				rsget.movenext
			loop
		end if
		rsget.close
    End Sub

	'최초 주결제금액
	public Sub getMainPaymentInfo(byval paymethod, byref orgpayment, byref cardcancelok, byref cardcancelerrormsg, byref cardcancelcount, byref cardcancelsum, byref cardcode)
		dim sqlStr

		dim remailpayment, payetcresult
		dim jumundiv, orgorderserial, pggubun
		dim tmpArr

		orgpayment = 0
		cardcancelok = "N"
		cardcancelerrormsg = ""
		cardcancelcount = ""
		cardcode = ""

		'// 교환주문( jumundiv = 6 )이면 원주문에서 결제정보 가져온다.
		sqlStr = " select top 1 m.jumundiv, m.pggubun "
		sqlStr = sqlStr + " from "
		sqlStr = sqlStr + " 	db_order.dbo.tbl_order_master m "
		sqlStr = sqlStr + " where "
		sqlStr = sqlStr + " 	1 = 1 "
		sqlStr = sqlStr + " 	and m.orderserial = '" & FRectOrderserial & "' "
		rsget.Open sqlStr,dbget,1
		if Not rsget.Eof then
			jumundiv = rsget("jumundiv")
			pggubun  = rsget("pggubun")
		end if
		rsget.close

		if (jumundiv = "6") then
			sqlStr = " select top 1 c.orgorderserial "
			sqlStr = sqlStr + " from "
			sqlStr = sqlStr + " 	db_order.dbo.tbl_change_order c "
			sqlStr = sqlStr + " where "
			sqlStr = sqlStr + " 	1 = 1 "
			sqlStr = sqlStr + " 	and c.chgorderserial = '" & FRectOrderserial & "' "
			rsget.Open sqlStr,dbget,1
			if Not rsget.Eof then
				orgorderserial = rsget("orgorderserial")
			end if
			rsget.close
		else
			orgorderserial = FRectOrderserial
		end if

		sqlStr = " select top 1 IsNull(e.acctamount, 0) as orgpayment, IsNull(e.realPayedSum, 0) as remailpayment, IsNull(e.PayEtcResult, '') as payetcresult "
		sqlStr = sqlStr + " from "
		sqlStr = sqlStr + " 	[db_order].[dbo].tbl_order_PaymentEtc e "
		sqlStr = sqlStr + " where "
		sqlStr = sqlStr + " 	1 = 1 "
		sqlStr = sqlStr + " 	and e.orderserial = '" & FRectOrderserial & "' "
		sqlStr = sqlStr + " 	and e.acctdiv in ('7', '100', '550', '560', '20', '50', '80', '90', '400', '110') "							'OK CASH BAG 은 주결제수단이다.

        'response.write sqlStr &"<br>"
        IF (paymethod="110") then
            sqlStr = " select sum(IsNull(e.acctamount, 0)) as orgpayment, sum(IsNull(e.realPayedSum, 0)) as remailpayment, '' as payetcresult "
    		sqlStr = sqlStr + " from "
    		sqlStr = sqlStr + " 	[db_order].[dbo].tbl_order_PaymentEtc e "
    		sqlStr = sqlStr + " where "
    		sqlStr = sqlStr + " 	1 = 1 "
    		sqlStr = sqlStr + " 	and e.orderserial = '" & FRectOrderserial & "' "
    		sqlStr = sqlStr + " 	and e.acctdiv in ('100', '110') "
        END IF

		rsget.Open sqlStr,dbget,1
		if Not rsget.Eof then
			orgpayment = rsget("orgpayment")
			remailpayment = rsget("remailpayment")
			payetcresult = rsget("payetcresult")

			if Len(payetcresult) = 9 and UBound(Split(payetcresult, "|")) = 3 then
				'// 14|26|0|1 => 14|26|00|1
				tmpArr = Split(payetcresult, "|")
				payetcresult = tmpArr(0) & "|" & tmpArr(1) & "|" & "0" & tmpArr(2) & "|" & tmpArr(3)
			end If

			'// 페이코
			if Len(payetcresult) = 6 and UBound(Split(payetcresult, "|")) = 3 then
				'// ||00|1 => XX|XX|00|1
				tmpArr = Split(payetcresult, "|")
				payetcresult = "XX" & "|" & "XX" & "|" & tmpArr(2) & "|" & tmpArr(3)
			end if

			'// 토스
			if pggubun = "TS" then
				payetcresult = "XX|XX|00|1"
			end if
		end if
		rsget.close

        '' 네이버 페이 관련 추가 (포인트)
        if (pggubun="NP") or (pggubun="PY") then
            sqlStr = " select top 1 IsNull(e.acctamount, 0) as orgpayment, IsNull(e.realPayedSum, 0) as remailpayment, IsNull(e.PayEtcResult, '') as payetcresult "
            sqlStr = sqlStr + " from "
            sqlStr = sqlStr + " 	[db_order].[dbo].tbl_order_PaymentEtc e "
            sqlStr = sqlStr + " where "
            sqlStr = sqlStr + " 	1 = 1 "
            sqlStr = sqlStr + " 	and e.orderserial = '" & orgorderserial & "' "
            sqlStr = sqlStr + " 	and e.acctdiv='120'"

            rsget.Open sqlStr,dbget,1
            if Not rsget.Eof then
            	orgpayment = orgpayment + rsget("orgpayment")
            	remailpayment = remailpayment + rsget("remailpayment")

            	if Len(payetcresult) = 7 and UBound(Split(payetcresult, "|")) = 3 then
            		'// 14||0|1 => 14|26|00|1
            		tmpArr = Split(payetcresult, "|")
            		payetcresult = tmpArr(0) & "|" & "XX" & "|" & "0" & tmpArr(2) & "|" & tmpArr(3)
            	end If
            end if
            rsget.close

        end if

		if (paymethod <> "100") then
			if (paymethod = "110") then
				cardcancelerrormsg = "OK+신용(결제 부분취소불가)"
			elseif (paymethod = "20") and (pggubun="NP") then                              ''2016/07/21 추가
			    cardcancelok = "Y"
				cardcancelcount = 0
				cardcode = payetcresult
			elseif (paymethod = "20") and (pggubun="TS") then                              ''2019/10/22 추가
			    cardcancelok = "Y"
				cardcancelcount = 0
				cardcode = payetcresult
			elseif (paymethod = "20") and (pggubun="CH") then                              ''2020/04/24 추가
			    cardcancelok = "Y"
				cardcancelcount = 0
				cardcode = payetcresult
			else
				cardcancelerrormsg = "신용카드결제 아님"
			end if
		else
			if (orgpayment = 0) or (payetcresult = "") then
				cardcancelerrormsg = "신용카드정보 누락"
			else
				cardcancelok = "Y"
				cardcancelcount = 0
				cardcode = payetcresult
			end if
		end if

        cardcancelcount = 0
        cardcancelsum   = 0
		if (cardcancelok = "Y") and (orgpayment <> remailpayment) then
			sqlStr = " select count(orderserial) as cnt, isNULL(sum(cancelprice),0) as canceltotal "
			sqlStr = sqlStr + " from db_order.dbo.tbl_card_cancel_log "
			sqlStr = sqlStr + " where orderserial = '" & FRectOrderserial & "' and resultcode = '00' "
			rsget.Open sqlStr,dbget,1

			if Not rsget.Eof then
				cardcancelcount = rsget("cnt")
				cardcancelsum   = rsget("canceltotal")
			end if
			rsget.close

			'9회까지 부분취소가 가능하지만 만약을 위한 3번은 남겨놓는다.(CS 용)
			if (cardcancelcount >= 6) then
				cardcancelok = "N"
				cardcancelerrormsg = "부분취소 횟수 초과"
			end if
		end if

		if (cardcancelok = "Y") then
		    if (LEN(TRIM(cardcode))=10) then
                if (Right(cardcode,1)="1") then
                    ''cardcancelok = "Y"
                elseif (Right(cardcode,1)="0") then
                    cardcancelok = "N"
                    if (cardcancelerrormsg="") then cardcancelerrormsg  = "부분취소 <strong>불가</strong> 거래 (충전식 카드 or 복합거래)"
                end if
            end if

''          cardcode 맨 끝자리로 확인 가능.
'			if (InStr("11|00,06|04,12|00,14|26,01|05,04|00,03|00,16|11,17|81", Left(cardcode, 5)) <= 0) then
'				cardcancelok = "N"
'				cardcancelerrormsg = "부분취소 불가카드"
'
'				if (InStr("06,14,01", Left(cardcode, 2)) > 0) then
'					cardcancelerrormsg = "국민/신한/외환카드의 계열사카드는 부분취소 불가"
'				end if
'			end if
		end if

	end sub

	public Sub getUpcheBeasongPayList()
		dim sqlStr
		dim i

		sqlStr = " select distinct "
		sqlStr = sqlStr + " 	d.makerid, IsNull(b.defaultfreebeasonglimit, 0) as defaultfreebeasonglimit, IsNull(b.defaultdeliverpay, 0) as defaultdeliverpay "
		sqlStr = sqlStr + " from "
		sqlStr = sqlStr + " 	[db_order].[dbo].tbl_order_detail d "
		sqlStr = sqlStr + " 	join db_user.dbo.tbl_user_c b "
		sqlStr = sqlStr + " 	on "
		sqlStr = sqlStr + " 		d.makerid = b.userid "
		sqlStr = sqlStr + " where "
		sqlStr = sqlStr + " 	1 = 1 "
		sqlStr = sqlStr + " 	and d.orderserial = '" & FRectOrderserial & "' "
		sqlStr = sqlStr + " 	and d.cancelyn <> 'Y' "
		sqlStr = sqlStr + " 	and d.isupchebeasong <> 'N' "

        'response.write sqlStr &"<br>"
		rsget.CursorLocation = adUseClient
		rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly

		FTotalCount = rsget.RecordCount
		FResultCount = FTotalCount

		redim preserve FItemList(FResultCount)

		i=0
		do until rsget.eof
			set FItemList(i) = new CUpcheBeasongPayItem

			FItemList(i).Fmakerid     					= rsget("makerid")
			FItemList(i).Fdefaultfreebeasonglimit     	= rsget("defaultfreebeasonglimit")
			FItemList(i).Fdefaultdeliverpay     		= rsget("defaultdeliverpay")

			if (FItemList(i).Fdefaultdeliverpay = 0) then
				'기본배송비 설정 않되어 있으면 2500원(since 2012-06-18)
				FItemList(i).Fdefaultdeliverpay = 2500
			end if

			rsget.movenext
			i = i + 1
		loop
		rsget.close
	end sub

	public Sub GetOrderDetail()
	    dim sqlStr, i, arr, arrmibeasoldout
	    dim mastertable, detailtable

        IF (FRectOrderserial="") then
            EXIT Sub
        END IF

		'### 포장데이터 조회
		arr = fnMyPojangItemList(FRectUserID,FRectOrderserial)

		'/품절출고불가 상품		'/2016.03.31 한용민 추가
		arrmibeasoldout = fnmibeasoldout(FRectOrderserial)

	    if (FRectOldjumun<>"") then
	        sqlStr = " exec [db_order].[dbo].sp_Ten_OrderDetailList_New '" & FRectOrderserial & "',0"
        else
            sqlStr = " exec [db_order].[dbo].sp_Ten_OrderDetailList_New '" & FRectOrderserial & "',1"
        end if

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic

		rsget.Open sqlStr,dbget,1

		FTotalcount = rsget.Recordcount
		FResultcount = FTotalcount

        redim preserve FItemList(FTotalcount)

        if Not rsget.Eof then
			do until rsget.Eof
				set FItemList(i) = new CMyOrderDetailItem
				FItemList(i).Fidx           = rsget("idx")
				FItemList(i).FOrderSerial   = FRectOrderserial
				FItemList(i).FItemId        = rsget("itemid")
				FItemList(i).FItemName       = db2html(rsget("itemname"))
				FItemList(i).FItemOption     = rsget("itemoption")
				FItemList(i).FItemNo         = rsget("itemno")
				FItemList(i).FItemOptionName = db2html(rsget("itemoptionname"))
				FItemList(i).FImageSmall     = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemID(FItemList(i).FItemId) + "/" + rsget("smallimage")
				FItemList(i).FImageList      = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemID(FItemList(i).FItemId) + "/" + rsget("listimage")
				FItemList(i).FSongJangNo     = rsget("songjangno")
				FItemList(i).FSongjangDiv    = rsget("songjangdiv")
				FItemList(i).Fmakerid        = rsget("makerid")
				FItemList(i).Fbrandname      = db2html(rsget("brandname"))
				FItemList(i).FItemCost		 = rsget("itemcost")
				FItemList(i).FreducedPrice   = rsget("reducedPrice")
				FItemList(i).FCurrState		 = rsget("currstate")
				FItemList(i).Fitemdiv		 = rsget("itemdiv")
				FItemList(i).FCancelYn       = rsget("cancelyn")
				FItemList(i).Fisupchebeasong = rsget("isupchebeasong")
				FItemList(i).Fbeasongdate     = rsget("beasongdate")
                FItemList(i).Frequiredetail = db2html(rsget("requiredetail"))
				FItemList(i).FrequiredetailUTF8 = db2html(rsget("requiredetailUTF8"))
				FItemList(i).FMileage		= rsget("mileage")

				FItemList(i).FDeliveryName	 = rsget("divname")
				FItemList(i).FDeliveryURL	 = rsget("findurl")
				FItemList(i).FDeliveryTel    = rsget("DeliveryTel")

                FItemList(i).Foitemdiv       = rsget("oitemdiv")
				FItemList(i).Fomwdiv         = rsget("omwdiv")
				FItemList(i).Fodlvtype       = rsget("odlvtype")

				FItemList(i).FisSailitem       = rsget("issailitem")
				FItemList(i).Flimityn       = rsget("limityn")
				'FItemList(i).FMasterSongJangNo   = FMasterItem.FSongjangNo
				FItemList(i).FPojangok		 = rsget("pojangok")

	            if InStr(arr, (rsget("itemid")&rsget("itemoption"))) > 0 then
	            	FItemList(i).FIsPacked = "Y"
	        	end if

				'/품절출고불가 상품		'/2016.03.31 한용민 추가
				if rsget("cancelyn")="N" And rsget("currstate") < "7" then
		            if InStr(arrmibeasoldout, rsget("idx")) > 0 then
		            	FItemList(i).Fmibeasoldoutyn = "Y"
		        	end if
		        end if
				FItemList(i).Fitemlackno = rsget("itemlackno")
				'주문리스트 상단 UI관련 추가 2020-10-21 정태훈
				FItemList(i).Fdlvfinishdt = rsget("dlvfinishdt")

                '''2011 추가 check NULL Exists ==============================================
                FItemList(i).Forgitemcost               = rsget("orgitemcost")
                FItemList(i).FitemcostCouponNotApplied  = rsget("itemcostCouponNotApplied")
                FItemList(i).Fodlvfixday                = rsget("odlvfixday")
                FItemList(i).FplussaleDiscount          = rsget("plussaleDiscount")
                FItemList(i).FspecialShopDiscount       = rsget("specialShopDiscount")
                FItemList(i).Fitemcouponidx             = rsget("itemcouponidx")
                FItemList(i).Fbonuscouponidx            = rsget("bonuscouponidx")

                If IsNULL(FItemList(i).Forgitemcost) then FItemList(i).Forgitemcost=0
                If IsNULL(FItemList(i).FitemcostCouponNotApplied) then FItemList(i).FitemcostCouponNotApplied=0
                If IsNULL(FItemList(i).FplussaleDiscount) then FItemList(i).FplussaleDiscount=0
                If IsNULL(FItemList(i).FspecialShopDiscount) then FItemList(i).FspecialShopDiscount=0
                If IsNULL(FItemList(i).Fitemcouponidx) then FItemList(i).Fitemcouponidx=0
                If IsNULL(FItemList(i).Fbonuscouponidx) then FItemList(i).Fbonuscouponidx=0
                If IsNULL(FItemList(i).Fodlvfixday) then FItemList(i).Fodlvfixday=""

				i=i+1
				rsget.movenext
			loop
		end if
		rsget.close
    end Sub

	public Sub GetOrderResultDetail()
	    dim sqlStr, i, arr, arrmibeasoldout
	    dim mastertable, detailtable

        IF (FRectOrderserial="") then
            EXIT Sub
        END IF

		'### 포장데이터 조회
		arr = fnMyPojangItemList(FRectUserID,FRectOrderserial)

		'/품절출고불가 상품		'/2016.03.31 한용민 추가
		arrmibeasoldout = fnmibeasoldout(FRectOrderserial)

	    if (FRectOldjumun<>"") then
	        sqlStr = " exec [db_order].[dbo].sp_Ten_OrderDetailList_Keywords '" & FRectOrderserial & "',0"
        else
            sqlStr = " exec [db_order].[dbo].sp_Ten_OrderDetailList_Keywords '" & FRectOrderserial & "',1"
        end if

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic

		rsget.Open sqlStr,dbget,1

		FTotalcount = rsget.Recordcount
		FResultcount = FTotalcount

        redim preserve FItemList(FTotalcount)

        if Not rsget.Eof then
			do until rsget.Eof
				set FItemList(i) = new CMyOrderDetailItem
				FItemList(i).Fidx           = rsget("idx")
				FItemList(i).FOrderSerial   = FRectOrderserial
				FItemList(i).FItemId        = rsget("itemid")
				FItemList(i).FItemName       = db2html(rsget("itemname"))
				FItemList(i).FItemOption     = rsget("itemoption")
				FItemList(i).FItemNo         = rsget("itemno")
				FItemList(i).FItemOptionName = db2html(rsget("itemoptionname"))
				FItemList(i).FImageSmall     = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemID(FItemList(i).FItemId) + "/" + rsget("smallimage")
				FItemList(i).FImageList      = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemID(FItemList(i).FItemId) + "/" + rsget("listimage")
				FItemList(i).FSongJangNo     = rsget("songjangno")
				FItemList(i).FSongjangDiv    = rsget("songjangdiv")
				FItemList(i).Fmakerid        = rsget("makerid")
				FItemList(i).Fbrandname      = db2html(rsget("brandname"))
				FItemList(i).FItemCost		 = rsget("itemcost")
				FItemList(i).FreducedPrice   = rsget("reducedPrice")
				FItemList(i).FCurrState		 = rsget("currstate")
				FItemList(i).Fitemdiv		 = rsget("itemdiv")
				FItemList(i).FCancelYn       = rsget("cancelyn")
				FItemList(i).Fisupchebeasong = rsget("isupchebeasong")
				FItemList(i).Fbeasongdate     = rsget("beasongdate")
                FItemList(i).Frequiredetail = db2html(rsget("requiredetail"))
				FItemList(i).FrequiredetailUTF8 = db2html(rsget("requiredetailUTF8"))
				FItemList(i).FMileage		= rsget("mileage")

				FItemList(i).FDeliveryName	 = rsget("divname")
				FItemList(i).FDeliveryURL	 = rsget("findurl")
				FItemList(i).FDeliveryTel    = rsget("DeliveryTel")

                FItemList(i).Foitemdiv       = rsget("oitemdiv")
				FItemList(i).Fomwdiv         = rsget("omwdiv")
				FItemList(i).Fodlvtype       = rsget("odlvtype")

				FItemList(i).FisSailitem       = rsget("issailitem")
				FItemList(i).Flimityn       = rsget("limityn")
				'FItemList(i).FMasterSongJangNo   = FMasterItem.FSongjangNo
				FItemList(i).FPojangok		 = rsget("pojangok")

	            if InStr(arr, (rsget("itemid")&rsget("itemoption"))) > 0 then
	            	FItemList(i).FIsPacked = "Y"
	        	end if

				'/품절출고불가 상품		'/2016.03.31 한용민 추가
				if rsget("cancelyn")="N" then
		            if InStr(arrmibeasoldout, rsget("idx")) > 0 then
		            	FItemList(i).Fmibeasoldoutyn = "Y"
		        	end if
		        end if
				FItemList(i).Fitemlackno = rsget("itemlackno")

				'//2019.10.29 아이템 테그 키워드 추가
				FItemList(i).FKeywords = rsget("keywords")

                '''2011 추가 check NULL Exists ==============================================
                FItemList(i).Forgitemcost               = rsget("orgitemcost")
                FItemList(i).FitemcostCouponNotApplied  = rsget("itemcostCouponNotApplied")
                FItemList(i).Fodlvfixday                = rsget("odlvfixday")
                FItemList(i).FplussaleDiscount          = rsget("plussaleDiscount")
                FItemList(i).FspecialShopDiscount       = rsget("specialShopDiscount")
                FItemList(i).Fitemcouponidx             = rsget("itemcouponidx")
                FItemList(i).Fbonuscouponidx            = rsget("bonuscouponidx")

                If IsNULL(FItemList(i).Forgitemcost) then FItemList(i).Forgitemcost=0
                If IsNULL(FItemList(i).FitemcostCouponNotApplied) then FItemList(i).FitemcostCouponNotApplied=0
                If IsNULL(FItemList(i).FplussaleDiscount) then FItemList(i).FplussaleDiscount=0
                If IsNULL(FItemList(i).FspecialShopDiscount) then FItemList(i).FspecialShopDiscount=0
                If IsNULL(FItemList(i).Fitemcouponidx) then FItemList(i).Fitemcouponidx=0
                If IsNULL(FItemList(i).Fbonuscouponidx) then FItemList(i).Fbonuscouponidx=0
                If IsNULL(FItemList(i).Fodlvfixday) then FItemList(i).Fodlvfixday=""

				i=i+1
				rsget.movenext
			loop
		end if
		rsget.close
    end Sub

	public Sub GetShopOrderDetail()
	    dim sqlStr, i, arr, arrmibeasoldout
	    dim mastertable, detailtable

        IF (FRectOrderserial="") then
            EXIT Sub
        END IF

		'### 포장데이터 조회
		arr = fnMyPojangItemList(FRectUserID,FRectOrderserial)

		'/품절출고불가 상품		'/2016.03.31 한용민 추가
		arrmibeasoldout = fnmibeasoldout(FRectOrderserial)

        sqlStr = " exec [db_shop].[dbo].[usp_WWW_My10x10_ShopOrderItemList_Get] '" & FRectOrderserial & "'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic

		rsget.Open sqlStr,dbget,1

		FTotalcount = rsget.Recordcount
		FResultcount = FTotalcount

        redim preserve FItemList(FTotalcount)

        if Not rsget.Eof then
			do until rsget.Eof
				set FItemList(i) = new CMyOrderDetailItem
				FItemList(i).FOrderSerial   = FRectOrderserial
				FItemList(i).FItemId        = rsget("itemid")
				FItemList(i).FItemName       = db2html(rsget("itemname"))
				FItemList(i).FItemNo         = rsget("itemno")
				FItemList(i).Fitemgubun         = rsget("itemgubun")
				FItemList(i).FItemOptionName = db2html(rsget("itemoptionname"))
				FItemList(i).FImageSmall     = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemID(FItemList(i).FItemId) + "/" + rsget("smallimage")
				FItemList(i).FSellPrice     = rsget("sellprice")
				FItemList(i).FRealSellPrice    = rsget("realsellprice")
				FItemList(i).FSuplyPrice        = rsget("suplyprice")

				i=i+1
				rsget.movenext
			loop
		end if
		rsget.close
    End Sub

	public Sub GetOneOrderDetailIfOneItem(byRef itemid, byRef orderdetailidx)
		dim sqlStr, i
		dim mastertable, detailtable, requiretable

	    if (FRectOldjumun<>"") then
			detailtable	= "[db_log].[dbo].tbl_old_order_detail_2003"
		else
			detailtable	= "[db_order].[dbo].tbl_order_detail"
		end if

		sqlStr = " select max(itemid) as itemid, max(idx) as orderdetailidx, count(itemid) as cnt " & vbCrLf
		sqlStr = sqlStr & " from " & vbCrLf
		sqlStr = sqlStr & detailtable & vbCrLf
		sqlStr = sqlStr & " where orderserial = '" + FRectOrderserial + "' and itemid not in (0, 100) and cancelyn <> 'Y' " & vbCrLf
		rsget.CursorLocation = adUseClient
		rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

		itemid = ""
		orderdetailidx = ""
        if Not rsget.Eof then
			if rsget("cnt") = 1 then
				itemid = rsget("itemid")
				orderdetailidx = rsget("orderdetailidx")
			end if
		end if
		rsget.close
	End Sub

    public Sub GetOneOrderDetail()
	    dim sqlStr, i
	    dim mastertable, detailtable, requiretable

	    if (FRectOldjumun<>"") then
			mastertable = "[db_log].[dbo].tbl_old_order_master_2003"
			detailtable	= "[db_log].[dbo].tbl_old_order_detail_2003"
			requiretable = "[db_log].[dbo].tbl_old_order_require_2003"
		else
			mastertable = "[db_order].[dbo].tbl_order_master"
			detailtable	= "[db_order].[dbo].tbl_order_detail"
			requiretable = "[db_order].[dbo].tbl_order_require"
		end if

		sqlStr =	" SELECT d.idx, d.itemid, d.itemoption, d.itemno, d.itemoptionname, d.itemcost," &_
					" d.itemname, d.itemcost, d.makerid, d.currstate, replace(d.songjangno,'-','') as songjangno, d.songjangdiv," &_
					" d.cancelyn, d.isupchebeasong, d.mileage, d.requiredetail, d.oitemdiv," &_
					" i.smallimage, i.listimage, i.brandname, i.itemdiv" &_
					" ,s.divname,s.findurl ,s.tel as DeliveryTel, ISNULL(r.requiredetailUTF8,'') AS requiredetailUTF8 " &_
					" FROM " + detailtable + " d " &_
					" JOIN [db_item].[dbo].tbl_item i" &_
					"		ON d.itemid=i.itemid " &_
					" LEFT JOIN db_order.[dbo].tbl_songjang_div s " &_
					"		ON d.songjangdiv = s.divcd " &_
					" LEFT JOIN " + requiretable + " r " &_
					"		ON d.idx = r.detailidx " &_
					" WHERE d.orderserial='" + FRectOrderserial + "'" &_
					" and d.idx=" & FRectIdx &_
					" and d.itemid<>0" &_
					" and d.cancelyn<>'Y'" &_
					" order by i.deliverytype"
		rsget.Open sqlStr,dbget,1

		FTotalcount = rsget.Recordcount
		FResultcount = FTotalcount


        if Not rsget.Eof then
				set FOneItem = new CMyOrderDetailItem
				FOneItem.Fidx           = rsget("idx")
				FOneItem.FOrderSerial   = FRectOrderserial
				FOneItem.FItemId        = rsget("itemid")
				FOneItem.FItemName       = db2html(rsget("itemname"))
				FOneItem.FItemOption     = rsget("itemoption")
				FOneItem.FItemNo         = rsget("itemno")
				FOneItem.FItemOptionName = db2html(rsget("itemoptionname"))
				FOneItem.FImageSmall     = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemID(FOneItem.FItemId) + "/" + rsget("smallimage")
				FOneItem.FImageList      = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemID(FOneItem.FItemId) + "/" + rsget("listimage")
				FOneItem.FSongJangNo     = rsget("songjangno")
				FOneItem.FSongjangDiv    = rsget("songjangdiv")
				FOneItem.Fmakerid        = rsget("makerid")
				FOneItem.Fbrandname      = db2html(rsget("brandname"))
				FOneItem.FItemCost		 = rsget("itemcost")
				FOneItem.FCurrState		 = rsget("currstate")
				FOneItem.Fitemdiv		 = rsget("itemdiv")
				FOneItem.FCancelYn       = rsget("cancelyn")
				FOneItem.Fisupchebeasong = rsget("isupchebeasong")
                FOneItem.Frequiredetail = db2html(rsget("requiredetail"))
				FOneItem.FrequiredetailUTF8 = db2html(rsget("requiredetailUTF8"))
				FOneItem.FMileage		= rsget("mileage")

				FOneItem.FDeliveryName	 = rsget("divname")
				FOneItem.FDeliveryURL	 = rsget("findurl")
				FOneItem.FDeliveryTel    = rsget("DeliveryTel")

                FOneItem.Foitemdiv       = rsget("oitemdiv")

				'FOneItem.FMasterSongJangNo   = FMasterItem.FSongjangNo
				'FOneItem.FMasterDiscountRate = FMasterItem.FDiscountRate

		end if
		rsget.close
    end Sub

    public Sub GetMyOrderList()
		dim sqlStr, i,j
		dim mastertable, detailtable
		dim buforderserial
        '' 프로시져 변경요망.**

		'' response.write " GetMyOrderListProc() 사용할 것 "
		'' response.end

		'// 프로시져 버전 생성
		'// GetMyOrderListProc() 사용할 것

		if FRectOldjumun<>"" then
			mastertable = "[db_log].[dbo].tbl_old_order_master_2003"
			detailtable	= "[db_log].[dbo].tbl_old_order_detail_2003"
		else
			mastertable = "[db_order].[dbo].tbl_order_master"
			detailtable	= "[db_order].[dbo].tbl_order_detail"
		end if

		sqlStr = "select count(m.idx) as cnt, sum(m.subtotalprice) as tsum from " + mastertable + " m"
		if FRectUserID<>"" then
		    sqlStr = sqlStr + " where m.userid='" + FRectUserID +"'"
		else
		    sqlStr = sqlStr + " where m.orderserial='" + FRectOrderserial +"'"
	    end if

	    if (FRectStartDate<>"") then
	        sqlStr = sqlStr + " and m.regdate>='" + FRectStartDate + "'"
	    end if

	    if (FRectEndDate<>"") then
	        sqlStr = sqlStr + " and m.regdate<'" + FRectEndDate + "'"
	    end if

		if FrectSiteName<>"" then
			sqlStr = sqlStr + " and m.sitename='" + FrectSiteName + "'"
		end if

		Select Case FRectArea
			Case "KR"
				sqlStr = sqlStr + " and (m.DlvcountryCode='KR' or m.DlvcountryCode='ZZ' or m.DlvcountryCode is Null)"
			Case "AB"
				sqlStr = sqlStr + " and (m.DlvcountryCode<>'KR' and m.DlvcountryCode='ZZ' and m.DlvcountryCode is Not Null)"
		end Select

		if FrectSearchGubun<>"" then
		    if FrectSearchGubun="infoedit" then
		         sqlStr = sqlStr + " and (m.ipkumdiv >=2 and m.ipkumdiv <= 6)"
		    elseif FrectSearchGubun="cancel" then
		         sqlStr = sqlStr + " and (m.ipkumdiv >=2 and m.ipkumdiv <= 6)"
		    elseif FrectSearchGubun="return" then
		         sqlStr = sqlStr + " and (m.ipkumdiv >=7)"
		         sqlStr = sqlStr + " and (m.jumundiv <>9)"
		    elseif FrectSearchGubun="issue" then
		         sqlStr = sqlStr + " and (m.ipkumdiv >=4)"
		    end if
		else
		    sqlStr = sqlStr + " and m.ipkumdiv >=2"
	    end if

		sqlStr = sqlStr + " and m.cancelyn='N'"
		sqlStr = sqlStr + " and (m.userDisplayYn is null or m.userDisplayYn='Y')"   ''userDisplayYn<>'N'

		rsget.Open sqlStr,dbget,1
		    FTotalCount = rsget("cnt")
		    FTotalSum   = rsget("tsum")
		rsget.Close

		sqlStr = "select top " + CStr(FPageSize*FCurrPage) + " m.idx, m.orderserial, m.subtotalprice, m.totalmileage "
		sqlStr = sqlStr + " ,m.regdate, m.deliverno, m.accountdiv, m.ipkumdiv, m.ipkumdate, m.paygatetid, m.beadaldate"
		sqlStr = sqlStr + " , m.jumundiv, m.cancelyn,  IsNULL(m.cashreceiptreq,'') as cashreceiptreq, m.InsureCd, IsNULL(m.authcode,'') as authcode"
		sqlStr = sqlStr + " , IsNULL(m.linkorderserial,'') as linkorderserial"
		sqlStr = sqlStr + " ,(select count(d.idx) from " + detailtable + " d where m.orderserial=d.orderserial and d.itemid<>0 and d.cancelyn<>'Y') as itemcount"
		sqlStr = sqlStr + " ,(select max(d.itemname) from " + detailtable + " d where m.orderserial=d.orderserial and d.itemid<>0 and d.cancelyn<>'Y') as itemnames"
		sqlStr = sqlStr + " ,(select count(c.id) from [db_cs].[dbo].tbl_new_as_list as c where c.divcd in ('A004','A010') and c.orderserial=m.orderserial and deleteyn='N') as csReturnCnt"
		sqlStr = sqlStr + " , IsNull(m.sumPaymentEtc, 0) as sumPaymentEtc "
		sqlStr = sqlStr + " from " + mastertable + " m"
		if FRectUserID<>"" then
		    sqlStr = sqlStr + " where m.userid='" + FRectUserID +"'"
		else
		    sqlStr = sqlStr + " where m.orderserial='" + FRectOrderserial +"'"
	    end if

	    if (FRectStartDate<>"") then
	        sqlStr = sqlStr + " and m.regdate>='" + FRectStartDate + "'"
	    end if

	    if (FRectEndDate<>"") then
	        sqlStr = sqlStr + " and m.regdate<'" + FRectEndDate + "'"
	    end if

		if FrectSiteName<>"" then
			sqlStr = sqlStr + " and m.sitename='" + FrectSiteName + "'"
		end if
		Select Case FRectArea
			Case "KR"
				sqlStr = sqlStr + " and (m.DlvcountryCode='KR' or m.DlvcountryCode='ZZ' or m.DlvcountryCode is Null)"
			Case "AB"
				sqlStr = sqlStr + " and (m.DlvcountryCode<>'KR' and m.DlvcountryCode='ZZ' and m.DlvcountryCode is Not Null)"
		end Select

		if FrectSearchGubun<>"" then
		    if FrectSearchGubun="infoedit" then
		         sqlStr = sqlStr + " and (m.ipkumdiv >=2 and m.ipkumdiv <= 6)"
		    elseif FrectSearchGubun="cancel" then
		         sqlStr = sqlStr + " and (m.ipkumdiv >=2 and m.ipkumdiv <= 6)"
		    elseif FrectSearchGubun="return" then
		         sqlStr = sqlStr + " and (m.ipkumdiv >=7)"
		         sqlStr = sqlStr + " and (m.jumundiv <>9)"
		    elseif FrectSearchGubun="issue" then
		         sqlStr = sqlStr + " and (m.ipkumdiv >=4)"
		    end if
		else
		    sqlStr = sqlStr + " and m.ipkumdiv >=2"
	    end if

		sqlStr = sqlStr + " and m.cancelyn='N'"
		sqlStr = sqlStr + " and (m.userDisplayYn is null or m.userDisplayYn='Y')"
		sqlStr = sqlStr + " order by m.idx desc"

		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1


		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
        if (FResultCount<1) then FResultCount=0


		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CMyOrderMasterItem

				FItemList(i).Fidx  = rsget("idx")
				FItemList(i).FOrderSerial  = rsget("orderserial")
				FItemList(i).FRegdate      = rsget("regdate")
				FItemList(i).FSubTotalPrice= rsget("subtotalprice")

				'' char -> varchar 변경해야함.
				FItemList(i).Faccountdiv   = Trim(rsget("accountdiv"))
				FItemList(i).FIpkumDiv     = rsget("ipkumdiv")
				FItemList(i).Fipkumdate    = rsget("ipkumdate")
				FItemList(i).Fdeliverno    = rsget("deliverno")
				FItemList(i).FJumunDiv     = rsget("jumundiv")
				FItemList(i).FBeadaldate   = rsget("beadaldate")

				FItemList(i).FItemNames    = db2html(rsget("itemnames"))
				FItemList(i).FItemCount	   = rsget("itemcount")

				FItemList(i).FCancelyn     = rsget("cancelyn")

				FItemList(i).Fpaygatetid   = rsget("paygatetid")
				FItemList(i).Fcashreceiptreq = Trim(rsget("cashreceiptreq"))

				FItemList(i).Ftotalmileage = rsget("totalmileage")

				FItemList(i).FInsureCd 	= rsget("InsureCd")
				FItemList(i).Fauthcode  = rsget("authcode")

				FItemList(i).FcsReturnCnt  = rsget("csReturnCnt")	'반품신청수

				FItemList(i).FsumPaymentEtc  = rsget("sumPaymentEtc")
				FItemList(i).Flinkorderserial = rsget("linkorderserial")

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close



	end sub

    public Sub GetMyOrderListProc()
		dim sqlStr, i,j

		sqlStr = " EXEC [db_order].[dbo].[sp_Ten_MyOrderList_SUM] '" + CStr(FRectUserID) + "', '" + CStr(FRectOrderserial) + "', '" + CStr(FRectOldjumun) + "', '" + CStr(FRectStartDate) + "', '" + CStr(FRectEndDate) + "', '" + CStr(FrectSiteName) + "', '" + CStr(FRectArea) + "', '" + CStr(FrectSearchGubun) + "' "
		''response.write sqlStr

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic

		rsget.Open sqlStr,dbget,1
		    FTotalCount = rsget("cnt")
		    FTotalSum   = rsget("tsum")
		rsget.Close


		sqlStr = " EXEC [db_order].[dbo].[sp_Ten_MyOrderList_New] " + CStr(FPageSize) + ", " + CStr(FCurrPage) + ", '" + CStr(FRectUserID) + "', '" + CStr(FRectOrderserial) + "', '" + CStr(FRectOldjumun) + "', '" + CStr(FRectStartDate) + "', '" + CStr(FRectEndDate) + "', '" + CStr(FrectSiteName) + "', '" + CStr(FRectArea) + "', '" + CStr(FrectSearchGubun) + "' "

		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
        if (FResultCount<1) then FResultCount=0


		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CMyOrderMasterItem

				FItemList(i).Fidx  = rsget("idx")
				FItemList(i).FOrderSerial  = rsget("orderserial")
				FItemList(i).FRegdate      = rsget("regdate")
				FItemList(i).FSubTotalPrice= rsget("subtotalprice")

				'' char -> varchar 변경해야함.
				FItemList(i).Faccountdiv   = Trim(rsget("accountdiv"))
				FItemList(i).FIpkumDiv     = rsget("ipkumdiv")
				FItemList(i).Fipkumdate    = rsget("ipkumdate")
				FItemList(i).Fdeliverno    = rsget("deliverno")
				FItemList(i).FJumunDiv     = rsget("jumundiv")
				FItemList(i).FBeadaldate   = rsget("beadaldate")

				FItemList(i).FItemNames    = db2html(rsget("itemnames"))
				FItemList(i).FItemCount	   = rsget("itemcount")

				FItemList(i).FCancelyn     = rsget("cancelyn")

				FItemList(i).Fpaygatetid   = rsget("paygatetid")
				FItemList(i).Fcashreceiptreq = Trim(rsget("cashreceiptreq"))

				FItemList(i).Ftotalmileage = rsget("totalmileage")

				FItemList(i).FInsureCd 	= rsget("InsureCd")
				FItemList(i).Fauthcode  = rsget("authcode")

				FItemList(i).FcsReturnCnt  = rsget("csReturnCnt")	'반품신청수

				FItemList(i).FsumPaymentEtc  = rsget("sumPaymentEtc")
				FItemList(i).Flinkorderserial = rsget("linkorderserial")

				FItemList(i).Fpggubun = rsget("pggubun")
				'//배송 종료 건수 추가 2020-10-22 정태훈
				FItemList(i).FdeliverEndCnt  = rsget("deliverEndCnt")

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close

	end sub

    Public Sub GetMyShopOrderListProc()
		Dim sqlStr, i,j

		sqlStr = " EXEC [db_shop].[dbo].[usp_WWW_My10x10_ShopOrder_SUM_Get] '" + CStr(FRectUserID) + "', '" + CStr(FRectOrderserial) + "', '" + CStr(FRectStartDate) + "', '" + CStr(FRectEndDate) + "' "
		'response.write sqlStr

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic

		rsget.Open sqlStr,dbget,1
		    FTotalCount = rsget("cnt")
		rsget.Close


		sqlStr = " EXEC [db_shop].[dbo].[usp_WWW_My10x10_ShopOrder_Get] " + CStr(FPageSize) + ", " + CStr(FCurrPage) + ", '" + CStr(FRectUserID) + "', '" + CStr(FRectOrderserial) + "', '" + CStr(FRectStartDate) + "', '" + CStr(FRectEndDate) + "' "

		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
        if (FResultCount<1) then FResultCount=0


		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CMyOrderMasterItem

				FItemList(i).FOrderSerial  = rsget("orderno")
				FItemList(i).FRegdate      = rsget("regdate")
				FItemList(i).FSubTotalPrice= rsget("realsum")
				FItemList(i).FItemNames    = db2html(rsget("ItemName"))
				FItemList(i).FItemCount	   = rsget("ItemCount")
				FItemList(i).FShopName     = rsget("shopname")

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close

	End Sub

    '''취소된 주문건.
	public Sub GetMyCancelOrderList()
		dim sqlStr,i,j
		dim mastertable, detailtable
		dim buforderserial
        '' 프로시져 변경요망.

		if (FRectOldjumun<>"") then
			mastertable = "[db_log].[dbo].tbl_old_order_master_2003"
			detailtable	= "[db_log].[dbo].tbl_old_order_detail_2003"
		else
			mastertable = "[db_order].[dbo].tbl_order_master"
			detailtable	= "[db_order].[dbo].tbl_order_detail"
		end if

		sqlStr = "select count(m.idx) as cnt, sum(m.subtotalprice) as tsum from " + mastertable + " m" &VbCRLF
		if (FRectUserID<>"") then
		    sqlStr = sqlStr + " where m.userid='" + FRectUserID +"'" &VbCRLF
		else
		    sqlStr = sqlStr + " where m.orderserial='" + FRectOrderserial +"'" &VbCRLF
	    end if
	    if (FRectStartDate<>"") then
	        sqlStr = sqlStr + " and m.regdate>='" + FRectStartDate + "'"
	    end if

	    if (FRectEndDate<>"") then
	        sqlStr = sqlStr + " and m.regdate<'" + FRectEndDate + "'"
	    end if
		if FrectSiteName<>"" then
			sqlStr = sqlStr + " and m.sitename='" + FrectSiteName + "'" &VbCRLF
		end if

		sqlStr = sqlStr + " and m.ipkumdiv >1" &VbCRLF
		sqlStr = sqlStr + " and m.jumundiv <>9" &VbCRLF
		sqlStr = sqlStr + " and (m.userDisplayYn is null or m.userDisplayYn='Y')"
		sqlStr = sqlStr + " and m.cancelyn<>'N'" &VbCRLF '' Y, D

		sqlStr = sqlStr + " and DateAdd(d, (-1 * 365 * 5), getdate()) <= m.regdate "


		rsget.Open sqlStr,dbget,1

		    FTotalCount = rsget("cnt")
		    FTotalSum   = rsget("tsum")
		rsget.Close

		sqlStr = "select top " + CStr(FPageSize*FCurrPage) + " m.idx, m.orderserial, m.subtotalprice, m.totalmileage " &VbCRLF
		sqlStr = sqlStr + " ,m.regdate, m.canceldate, m.deliverno, m.accountdiv, m.ipkumdiv, m.ipkumdate, m.paygatetid " &VbCRLF
		sqlStr = sqlStr + " ,m.beadaldate, m.jumundiv, m.cancelyn,  IsNULL(m.cashreceiptreq,'') as cashreceiptreq, m.InsureCd, IsNULL(m.authcode,'') as authcode" &VbCRLF
		sqlStr = sqlStr + " ,(select count(d.idx) from " + detailtable + " d where m.orderserial=d.orderserial and d.itemid<>0 and d.cancelyn<>'Y') as itemcount"&VbCRLF
		sqlStr = sqlStr + " ,(select max(d.itemname) from " + detailtable + " d where m.orderserial=d.orderserial and d.itemid<>0 and d.cancelyn<>'Y') as itemnames"&VbCRLF
		sqlStr = sqlStr + " from " + mastertable + " m"&VbCRLF

		if FRectUserID<>"" then
		    sqlStr = sqlStr + " where m.userid='" + FRectUserID +"'"&VbCRLF
		else
		    sqlStr = sqlStr + " where m.orderserial='" + FRectOrderserial +"'"&VbCRLF
	    end if

	    if (FRectStartDate<>"") then
	        sqlStr = sqlStr + " and m.regdate>='" + FRectStartDate + "'"
	    end if

	    if (FRectEndDate<>"") then
	        sqlStr = sqlStr + " and m.regdate<'" + FRectEndDate + "'"
	    end if

		if FrectSiteName<>"" then
			sqlStr = sqlStr + " and m.sitename='" + FrectSiteName + "'"&VbCRLF
		end if

		sqlStr = sqlStr + " and m.ipkumdiv>1"&VbCRLF
		sqlStr = sqlStr + " and m.jumundiv<>9"&VbCRLF
		sqlStr = sqlStr + " and (m.userDisplayYn is null or m.userDisplayYn='Y')"
		sqlStr = sqlStr + " and m.cancelyn<>'N'"&VbCRLF  '' Y, D

		sqlStr = sqlStr + " and DateAdd(d, (-1 * 365 * 5), getdate()) <= m.regdate "

		sqlStr = sqlStr + " order by m.idx desc"

		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1


		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
        if (FResultCount<1) then FResultCount=0


		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CMyOrderMasterItem

				FItemList(i).Fidx  = rsget("idx")
				FItemList(i).FOrderSerial  = rsget("orderserial")
				FItemList(i).FRegdate      = rsget("regdate")
				FItemList(i).FSubTotalPrice= rsget("subtotalprice")

				'' char -> varchar 변경해야함.
				FItemList(i).Faccountdiv   = Trim(rsget("accountdiv"))
				FItemList(i).FIpkumDiv     = rsget("ipkumdiv")
				FItemList(i).Fipkumdate    = rsget("ipkumdate")
				FItemList(i).Fdeliverno    = rsget("deliverno")
				FItemList(i).FJumunDiv     = rsget("jumundiv")
				FItemList(i).FBeadaldate   = rsget("beadaldate")

				FItemList(i).FItemNames    = db2html(rsget("itemnames"))
				FItemList(i).FItemCount	   = rsget("itemcount")

				FItemList(i).FCancelyn     = rsget("cancelyn")

				FItemList(i).Fpaygatetid   = rsget("paygatetid")
				FItemList(i).Fcashreceiptreq = Trim(rsget("cashreceiptreq"))

				FItemList(i).Ftotalmileage = rsget("totalmileage")

				FItemList(i).FInsureCd 	= rsget("InsureCd")
				FItemList(i).Fauthcode  = rsget("authcode")

				FItemList(i).FCancelDate = rsget("canceldate")

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	end sub


	public Sub GetOneOrder()
	    dim sqlStr

	    IF (FRectOrderserial="") then
	        set FOneItem = new CMyOrderMasterItem
	        Exit Sub
	    End IF

	    '' ToDo 차후 PaymentEtc를 분리해서 쿼리하자..
	    if (FRectOldjumun<>"") then
	        sqlStr = " exec [db_order].[dbo].sp_Ten_OneOrderMaster '" & FRectOrderserial & "','" & FRectUserID & "',0"
        else
            sqlStr = " exec [db_order].[dbo].sp_Ten_OneOrderMaster '" & FRectOrderserial & "','" & FRectUserID & "',1"
        end if
		'response.write sqlStr

	    rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1

		FTotalcount = rsget.Recordcount
		FResultcount = FTotalcount

		set FOneItem = new CMyOrderMasterItem

		if Not Rsget.Eof then
			FOneItem.Fuserid   		= rsget("userid")
			FOneItem.Fuserlevel		= rsget("userlevel")
			FOneItem.FOrderSerial   = FRectOrderserial
			FOneItem.FBuyName       = db2html(rsget("buyname"))
			FOneItem.FBuyPhone      = rsget("buyphone")
			FOneItem.FBuyhp         = rsget("buyhp")
			FOneItem.FBuyEmail      = db2html(rsget("buyemail"))

			FOneItem.FReqPhone      = rsget("reqphone")
			FOneItem.FReqhp         = rsget("reqhp")

			FOneItem.FReqName       = db2html(rsget("reqname"))
			FOneItem.FReqZipCode    = rsget("reqzipcode")
			FOneItem.Freqzipaddr    = db2html(rsget("reqzipaddr"))
			FOneItem.Freqaddress    = db2html(rsget("reqaddress"))
			FOneItem.FIpkumDiv      = rsget("ipkumdiv")
			FOneItem.Fcomment       = db2html(rsget("comment"))

			FOneItem.FRegDate       = rsget("regdate")
			FOneItem.Fdeliverno     = rsget("deliverno")
			FOneItem.FCancelYN      = rsget("cancelyn")

			''추가 20100216
			FOneItem.FBeadaldate   = rsget("beadaldate")

			'' char -> varchar 변경해야함.
			FOneItem.FAccountDiv    = Trim(rsget("accountdiv"))
			FOneItem.Faccountname   = db2html(rsget("accountname"))
            FOneItem.Faccountno     = db2html(rsget("accountno"))

			FOneItem.FSiteName      = rsget("sitename")
			FOneItem.FResultmsg     = rsget("resultmsg")

			''FOneItem.FDeliverOption = rsget("itemoption")
			FOneItem.FDeliverprice  = rsget("deliverprice")
			if IsNULL(FOneItem.FDeliverprice) then FOneItem.FDeliverprice=0
			FOneItem.FDeliverpriceCouponNotApplied  = rsget("DeliverpriceCouponNotApplied")
			if IsNULL(FOneItem.FDeliverpriceCouponNotApplied) then FOneItem.FDeliverpriceCouponNotApplied=0
			FOneItem.FArriveDeliverCnt  = rsget("arriveDeliverCnt")

			FOneItem.Ftotalsum      = rsget("totalsum")
			FOneItem.FsubtotalPrice = rsget("subtotalprice")
			FOneItem.Ftotalmileage  = rsget("totalmileage")
			FOneItem.Fpaygatetid    = rsget("paygatetid")
			FOneItem.Fcashreceiptreq = Trim(rsget("cashreceiptreq"))

			FOneItem.Fmiletotalprice = rsget("miletotalprice")
			FOneItem.Ftencardspend  = rsget("tencardspend")

			FOneItem.Freqdate       = rsget("reqdate")
			FOneItem.Freqtime       = rsget("reqtime")
			FOneItem.Fcardribbon    = rsget("cardribbon")
			FOneItem.Fmessage       = db2html(rsget("message"))
			FOneItem.Ffromname      = db2html(rsget("fromname"))
			FOneItem.FIpkumDate     = rsget("ipkumdate")

            FOneItem.Fsentenceidx           = rsget("sentenceidx")
			FOneItem.Fspendmembership 	    = rsget("spendmembership")
			FOneItem.Fallatdiscountprice    = rsget("allatdiscountprice")

			FOneItem.FInsureCd 	= rsget("InsureCd")
			FOneItem.FInsureMsg = rsget("InsureMsg")
            FOneItem.Fauthcode  = rsget("authcode")
            if IsNULL(FOneItem.Fauthcode) then FOneItem.Fauthcode=""

            if IsNULL(FOneItem.Fmiletotalprice) then FOneItem.Fmiletotalprice=0
            if IsNULL(FOneItem.Ftencardspend) then FOneItem.Ftencardspend=0
            if IsNULL(FOneItem.Fspendmembership) then FOneItem.Fspendmembership=0
            if IsNULL(FOneItem.Fallatdiscountprice) then FOneItem.Fallatdiscountprice=0
            if IsNULL(FOneItem.Fcashreceiptreq) then FOneItem.Fcashreceiptreq=""

            FOneItem.FDlvcountryCode   = rsget("DlvcountryCode")
            if IsNULL(FOneItem.FDlvcountryCode) then FOneItem.FDlvcountryCode="KR"

            FOneItem.FReqEmail  = rsget("reqemail")
            FOneItem.Frdsite	= rsget("rdsite")
            FOneItem.Fjumundiv	= rsget("jumundiv")

            FOneItem.FokcashbagSpend    = rsget("okcashbagSpend")

            FOneItem.Fspendtencash    = rsget("spendtencash")
            FOneItem.Fspendgiftmoney    = rsget("spendgiftmoney")

            FOneItem.FsubtotalpriceCouponNotApplied = rsget("subtotalpriceCouponNotApplied")
            FOneItem.FsumPaymentEtc = rsget("sumPaymentEtc")

            '''2011-04 added
            IF IsNULL(FOneItem.Fspendtencash) then FOneItem.Fspendtencash=0
            IF IsNULL(FOneItem.Fspendgiftmoney) then FOneItem.Fspendgiftmoney=0
            IF IsNULL(FOneItem.FsubtotalpriceCouponNotApplied) then FOneItem.FsubtotalpriceCouponNotApplied=0
            IF IsNULL(FOneItem.FsumPaymentEtc) then FOneItem.FsumPaymentEtc=0
            FOneItem.Flinkorderserial = rsget("linkorderserial")
            FOneItem.Fidx             = rsget("idx")

			FOneItem.Fpggubun         = rsget("pggubun")
			IF IsNULL(FOneItem.Fpggubun) then FOneItem.Fpggubun = ""

			FOneItem.FOrderSheetYN	= rsget("ordersheetyn")

			'' 네이버페이 포인트 2016/08/09 추가
            FOneItem.FspendNpayPoint = rsget("spendNpayPoint")
		end if
		rsget.Close

        ''해외배송
	    if (FOneItem.FDlvcountryCode<>"KR") and (FOneItem.FDlvcountryCode<>"ZZ") and (FOneItem.FDlvcountryCode<>"QQ") and (FOneItem.FDlvcountryCode<>"Z4") then  ''2017/12/15 QQ(퀵배송 추가)
	        sqlStr = " exec [db_order].[dbo].sp_Ten_OneEmsOrderInfo '" & FRectOrderserial & "'"

	        rsget.CursorLocation = adUseClient
    		rsget.CursorType = adOpenStatic
    		rsget.LockType = adLockOptimistic
    		rsget.Open sqlStr,dbget,1

    		if Not rsget.Eof then
                FOneItem.FDlvcountryName  = rsget("countryNameEn")
                FOneItem.FemsAreaCode     = rsget("emsAreaCode")
                FOneItem.FemsZipCode      = rsget("emsZipCode")
                FOneItem.FitemGubunName   = rsget("itemGubunName")
                FOneItem.FgoodNames       = rsget("goodNames")
                FOneItem.FitemWeigth      = rsget("itemWeigth")
                FOneItem.FitemUsDollar    = rsget("itemUsDollar")
                FOneItem.FemsInsureYn     = rsget("InsureYn")
                FOneItem.FemsInsurePrice  = rsget("InsurePrice")

    		end if
    		rsget.Close
	    end if

        ''티켓주문
        if (FOneItem.IsTicketOrder) then
            Dim mayTicketCancelChargePro : mayTicketCancelChargePro =0
            Dim ticketCancelDisabled     : ticketCancelDisabled =false
            Dim ticketCancelStr          : ticketCancelStr = ""

            if (Left(CStr(FOneItem.FRegDate),10)=Left(CStr(now()),10)) or (dateDiff("h",FOneItem.FRegDate,now())<2) then ''당일 주문 또는 결제후 2시간 이내;
                ''default
                ''rw "dateDiff="&dateDiff("h",FOneItem.FRegDate,now())
            ELSE
                call TicketOrderCheck(FRectOrderserial, mayTicketCancelChargePro, ticketCancelDisabled, ticketCancelStr)
            end if

            FOneItem.FmayTicketCancelChargePro  = mayTicketCancelChargePro
            FOneItem.FticketCancelDisabled      = ticketCancelDisabled
            FOneItem.FticketCancelStr           = ticketCancelStr

        end if

	end Sub

	Public Sub GetShopOneOrder()
	    dim sqlStr

	    If (FRectOrderserial="") then
	        Set FOneItem = New CMyOrderMasterItem
	        Exit Sub
	    End If

        sqlStr = " exec [db_shop].[dbo].[usp_WWW_My10x10_ShopOrderViewData_Get] '" &FRectUserID & "','" &  FRectOrderserial & "'"
	    rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1

		FTotalcount = rsget.Recordcount
		FResultcount = FTotalcount

		Set FOneItem = New CMyOrderMasterItem

		If Not Rsget.Eof Then

			FOneItem.FOrderSerial   = FRectOrderserial
			FOneItem.Ftotalsum      = rsget("totalsum")
			FOneItem.Frealsum      = rsget("realsum")
			FOneItem.Fjumundiv	= rsget("jumundiv")
			FOneItem.Fjumunmethod	= rsget("jumunmethod")
			FOneItem.Fshopregdate = rsget("shopregdate")
			FOneItem.Fspendmile  		= rsget("spendmile")
			FOneItem.Fgainmile  		= rsget("gainmile")
			FOneItem.Fcashsum  		= rsget("cashsum")
			FOneItem.Fcardsum  		= rsget("cardsum")
			FOneItem.FGiftCardPaySum  		= rsget("GiftCardPaySum")
			FOneItem.FTenGiftCardPaySum  		= rsget("TenGiftCardPaySum")
			FOneItem.FCashReceiptNo  		= rsget("CashReceiptNo")
			FOneItem.FCardAppNo  		= rsget("CardAppNo")
			FOneItem.FPoint       = rsget("Point")
			FOneItem.FUserName      = rsget("UserName")
			FOneItem.FEmail      = db2html(rsget("Email"))
			FOneItem.FTelNo      = rsget("TelNo")
			FOneItem.FHpNo         = rsget("HpNo")

		end if
		rsget.Close
	End Sub

	public sub GetOldAddressList()
		dim sqlStr, i

		sqlStr = " exec [db_order].[dbo].sp_Ten_RecentDeliverAddress " & CStr(FPageSize) & ",'" & FRectUserID & "','" & FRectSitename & "'"

        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic

		rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount
		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
    		do until rsget.EOF
    			set FItemList(i) = new CMyOrderMasterItem
    			FItemList(i).Freqname       = db2html(rsget("reqname"))
    			FItemList(i).Freqzipcode    = rsget("reqzipcode")
    			FItemList(i).Freqaddress	= db2html(rsget("reqaddress"))
    			FItemList(i).Freqphone	    = rsget("reqphone")
    			FItemList(i).Freqhp	        = rsget("reqhp")
    			FItemList(i).Freqzipaddr	= db2html(rsget("reqzipaddr"))
    			i=i+1
    			rsget.movenext
    		loop
		end if
		rsget.Close
	end Sub

	' 상품별 ASList
    public Function GetOrderDetailASList(ByVal detailidx)
		Dim strSql
		strSql = "[db_cs].[dbo].sp_Ten_OrderDetailASList (" & detailidx & ")"
		GetOrderDetailASList = fnExecSPReturnRS(strSql)
    End Function

	' 반품 주문 카운트 ASList
    public Function getReturnOrderCount()
		Dim strSql
		strSql = "[db_cs].[dbo].sp_Ten_OrderReturnASList ('" & FRectOrderserial & "')"
		getReturnOrderCount = fnExecSPReturnArr(strSql, 1)
    End Function

	' 반품 상품별 ASList
    public Function GetOrderDetailReturnASList(ByVal detailidx)
		Dim strSql
		strSql = "[db_cs].[dbo].sp_Ten_OrderDetailReturnASList (" & detailidx & ")"
		GetOrderDetailReturnASList = fnExecSPReturnRS(strSql)
    End Function


	public function IsTenBeasongExists()
		dim i
		IsTenBeasongExists = false
		for i=0 to FResultCount-1
			IsTenBeasongExists = IsTenBeasongExists or (Not FItemList(i).IsUpcheBeasong)
		next
	end function

	public function IsUpcheBeasongExists()
		dim i
		IsUpcheBeasongExists = false
		for i=0 to FResultCount-1
			IsUpcheBeasongExists = IsUpcheBeasongExists or FItemList(i).IsUpcheBeasong
		next
	end function

	Private Sub Class_Initialize()
		redim preserve FItemList(0)
		FCurrPage =1
		FPageSize = 12
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
		FTotSubPaymentSum = 0
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

'/품절출고불가 상품		'/2016.03.31 한용민 생성
Function fnmibeasoldout(orderserial)
	Dim vQuery, arr

	if orderserial="" then exit Function

	vQuery = "select mi.detailidx, mi.orderserial"
	vQuery = vQuery & " from db_temp.dbo.tbl_mibeasong_list as mi"
	vQuery = vQuery & " where mi.code='05' and mi.orderserial = '" & orderserial & "'"

	'response.write vQuery & "<Br>"
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	if not rsget.eof then
		do until rsget.eof
			arr = arr & rsget(0) & ","
		rsget.movenext
		loop
		arr = "," & arr
	end if
	rsget.close

	fnmibeasoldout = arr
End Function

Function GetStockOutCancelBeasongPay(orderserial)
	Dim vQuery

	vQuery = " select IsNull(sum(T.reducedBeasongPriceSUM),0) as reducedBeasongPriceSUM "
	vQuery = vQuery & " from "
	vQuery = vQuery & " 	( "
	vQuery = vQuery & " 		select "
	vQuery = vQuery & " 			(case when d.isupchebeasong = 'Y' or d.itemid = 0 then d.makerid else '' end) as makerid "
	vQuery = vQuery & " 			, sum(case when d.itemid = 0 then d.reducedPrice*d.itemno else 0 end) as reducedBeasongPriceSUM "
	vQuery = vQuery & " 			, sum(case when d.itemid <> 0 then d.itemno else 0 end) as itemCnt "
	vQuery = vQuery & " 			, sum(case when d.itemid <> 0 and IsNull(m.code, '') = '05' then IsNull(m.itemlackno,0) else 0 end) as stockOutItemCnt "
	vQuery = vQuery & " 		from "
	vQuery = vQuery & " 		[db_order].[dbo].[tbl_order_detail] d "
	vQuery = vQuery & " 		left join db_temp.dbo.tbl_mibeasong_list m "
	vQuery = vQuery & " 		on "
	vQuery = vQuery & " 			d.idx = m.detailidx "
	vQuery = vQuery & " 		where "
	vQuery = vQuery & " 			1 = 1 "
	vQuery = vQuery & " 			and d.orderserial = '" & orderserial & "' "
	vQuery = vQuery & " 			and d.cancelyn <> 'Y' "
	vQuery = vQuery & " 		group by "
	vQuery = vQuery & " 			(case when d.isupchebeasong = 'Y' or d.itemid = 0 then d.makerid else '' end) "
	vQuery = vQuery & " 	) T "
	vQuery = vQuery & " where "
	vQuery = vQuery & " 	T.itemCnt = T.stockOutItemCnt "
	'response.write vQuery & "<Br>"
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	if not rsget.eof then
		GetStockOutCancelBeasongPay = rsget("reducedBeasongPriceSUM")
	end if
	rsget.close
End Function

function getBCpnCampaginCodeBybonuscouponidx(ibcpnIDX)
    dim sqlStr
    getBCpnCampaginCodeBybonuscouponidx = ""

    sqlStr = "select top 1 masteridx from db_user.dbo.tbl_user_coupon"&VbCRLF
    sqlStr = sqlStr & " where idx="&ibcpnIDX&VbCRLF
    rsget.CursorLocation = adUseClient
    rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
    If Not(rsget.eof) Then
        getBCpnCampaginCodeBybonuscouponidx = CSTR(rsget("masteridx"))
    end if
    rsget.Close
end function

'### 주문번호로 선물포장이 있는지 유무.
Function fnExistPojang(orderserial, cancelyn)
	Dim vQuery, addq
	If cancelyn <> "" Then
		addq = addq & " and cancelyn = '" & cancelyn & "'"
	End If

	vQuery = "select count(midx) from [db_order].[dbo].[tbl_order_pack_master] where orderserial = '" & orderserial & "' " & addq & ""
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	if rsget(0) > 0 then
		fnExistPojang = "Y"
	else
		fnExistPojang = "N"
	end if
	rsget.close
End Function

'### 내가 주문한 선물포장리스트. 상품ID&옵션코드를 쉼표로 분리. InStr로 유무처리.
Function fnMyPojangItemList(userid, orderserial)
	Dim vQuery, arr
	vQuery = "select d.itemid, d.itemoption from [db_order].[dbo].[tbl_order_pack_master] as m "
	vQuery = vQuery & "inner join [db_order].[dbo].[tbl_order_pack_detail] as d on m.midx = d.midx "
	''vQuery = vQuery & "where m.userid = '" & userid & "' and m.orderserial = '" & orderserial & "'"
	vQuery = vQuery & "where m.orderserial = '" & orderserial & "'"
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	if not rsget.eof then
		do until rsget.eof
			arr = arr & rsget(0) & rsget(1) & ","
		rsget.movenext
		loop
		arr = "," & arr
	end if
	rsget.close
	fnMyPojangItemList = arr
End Function

'### 주문번호의 상태값. 상태값(currstate)이 7(출고완료)부터는 선물포장메세지 수정불가.
Function fnGetOrderDetailStateList(orderserial)
	Dim vQuery, vTemp
	vQuery = "select currstate from [db_order].[dbo].[tbl_order_detail] "
	vQuery = vQuery & "where orderserial = '" & orderserial & "'"
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	if not rsget.eof then
		vTemp = rsget.getRows()
	end if
	rsget.close
	fnGetOrderDetailStateList = vTemp
End Function

'### 주문상세 내 상품리스트. 각 상품 당 선물포장에 담긴 상품 수.
Function fnGetPojangItemCount(orderserial, itemid, itemoption)
	Dim vQuery, a
	vQuery = "EXEC [db_order].[dbo].[sp_Ten_GetPojangItemCount] '" & orderserial & "','" & itemid & "','" & itemoption & "'"
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	if not rsget.eof then
		a = rsget(0)
	end if
	rsget.close
	fnGetPojangItemCount = a
End Function

'// 해외 직구여부
Public Function fnUniPassNumber(orderserial)
	Dim sqlStr , uniPassNumber
	sqlStr = "EXEC [db_order].[dbo].[usp_WWW_Order_DirectPurchase_Get] " & orderserial
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
	if not rsget.eof then
		uniPassNumber = rsget(1)
	end if
	rsget.close
	fnUniPassNumber = uniPassNumber
End Function

'// 기간별 회원등급명
function getUserLevelStrByDate(iuserlevel, baseDate)
    getUserLevelStrByDate = iuserlevel

    if baseDate >= "2018-08-01" then
        Select Case iuserlevel
            Case "0","5"
                getUserLevelStrByDate = "WHITE"
            Case "1"
                getUserLevelStrByDate = "RED"
            Case "2"
                getUserLevelStrByDate = "VIP"
            Case "3"
                getUserLevelStrByDate = "VIP GOLD"
            Case "4","6"
                getUserLevelStrByDate = "VVIP"
            Case "7"
                getUserLevelStrByDate = "STAFF"
            Case "8"
                getUserLevelStrByDate = "FAMILY"
            Case "50","51"
                getUserLevelStrByDate = "제휴몰"
            Case "99"
                getUserLevelStrByDate = "비회원"
            Case Else
                getUserLevelStrByDate = "비회원"
        End Select
    else
        Select Case iuserlevel
            Case "0"
                getUserLevelStrByDate = "YELLOW"
            Case "5"
               getUserLevelStrByDate = "ORANGE"
            Case "1"
               getUserLevelStrByDate = "GREEN"
            Case "2"
                getUserLevelStrByDate = "BLUE"
            Case "3"
                getUserLevelStrByDate = "VIP SILVER"
            Case "4"
                getUserLevelStrByDate = "VIP GOLD"
            Case "6"
                getUserLevelStrByDate = "VVIP"
            Case "7"
                getUserLevelStrByDate = "STAFF"
            Case "8"
                getUserLevelStrByDate = "FAMILY"
            Case "50","51"
                getUserLevelStrByDate = "제휴몰"
            Case "99"
                getUserLevelStrByDate = "비회원"
            Case Else
                getUserLevelStrByDate = "비회원"
        End Select
    end if
end function

function IsNumberOnly(str)
	dim chkNumber
	set chkNumber = new RegExp
	chkNumber.global = true
	chkNumber.pattern = "[0-9, ]"
	If chkNumber.Test(str) Then
		IsNumberOnly = True
	else
		IsNumberOnly = True
	end if
	set chkNumber = Nothing
end function

'// 마지막 주문 요청 메시지 
Public Function fnGetMyLastOrderComment(userid)
	Dim sqlStr , myComment
	sqlStr = "EXEC [db_order].[dbo].[usp_Ten_MyLastOrderComment_Get] '" & userid &"'"
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
	if not rsget.eof then
		myComment = rsget(0)
	end if
	rsget.close
	'// 코멘트에 들어 있는 쌍따옴표 처리
	myComment = replace(myComment,"""","")
	'// 개행문자 오류로 인해 개행문자 처리
	myComment = replace(myComment,chr(13),"")
	myComment = replace(myComment,chr(10),"")
	'myComment = replace(myComment,chr(32),"")

	fnGetMyLastOrderComment = myComment
End Function
%>
