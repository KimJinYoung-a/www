<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>

<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<%
function SendMailOrder2(orderserial,mailfrom)
        dim sql,discountrate,paymethod, i, pggubun
        dim mailto, mailtitle, mailcontent,itemHtml,itemHtmlOri
        dim fs,objFile,dirPath,fileName,beforeItemHtml,afterItemHtml,itemHtmlTotal, ttlsumHTML, ttSumsale
		dim vIsPojangcompleteExists, pojangcash, pojangcnt, tmpitemcnt, tmpitemnosum
			vIsPojangcompleteExists=FALSE
			pojangcash=0
			pojangcnt=0
			tmpitemcnt=0
			tmpitemnosum=0

        mailtitle = "주문이 정상적으로 접수되었습니다!"

        dim myorder
        set myorder = new CMyOrder
        myorder.FRectOrderserial = orderserial
        myorder.GetOneOrder

        if (myorder.FResultCount<1) then Exit function

        dim myorderdetail
        set myorderdetail = new CMyOrder
        myorderdetail.FRectOrderserial = orderserial
        myorderdetail.FRectUserID = myorder.FOneItem.Fuserid
        myorderdetail.GetOrderDetail

        ' 파일을 불러와서 ---------------------------------------------------------------------------
        Set fs = Server.CreateObject("Scripting.FileSystemObject")
        dirPath = server.mappath("/lib/email")

        fileName = dirPath&"\\email_new_order.html"


        Set objFile = fs.OpenTextFile(fileName,1)
        mailcontent = objFile.readall
'        mailcontent = replace(mailcontent,":USERNAME:",userName)


		dim SpendMile, tencardspend
		dim IsForeighDeliver : IsForeighDeliver = false
        '주문정보 확인.---------------------------------------------------------------------------

		'선물포장서비스 노출		'/2015.11.11 한용민 생성
		IF myorderdetail.FResultCount>0 then
			for i=0 to myorderdetail.FResultCount - 1
				'/선물포장비 있을경우
				If myorderdetail.FItemList(i).FItemid = 100 Then
					'/선물포장완료상품존재
					vIsPojangcompleteExists=TRUE
					pojangcash = pojangcash + myorderdetail.FItemList(i).FItemCost * myorderdetail.FItemList(i).Fitemno		'/포장비
					pojangcnt = pojangcnt + myorderdetail.FItemList(i).Fitemno		'/포장박스갯수
				end if
			next
		end if

        mailto = myorder.FOneItem.Fbuyemail
        paymethod = trim(myorder.FOneItem.Faccountdiv)
        pggubun   = myorder.FOneItem.Fpggubun                   ''2016/08/04 추가
        
        if paymethod = "7" then    ' 무통장
            mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "무통장입금")
            mailcontent = replace(mailcontent,":IPKUMSTATUS:", "입금전 상태")
        elseif paymethod = "100" then   ' 신용카드
            if (pggubun="NP") then
                mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "네이버페이")
            else
                mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "신용카드")
            end if
            mailcontent = replace(mailcontent,":IPKUMSTATUS:", "결제완료")
        elseif paymethod = "20" then   ' 실시간이체
            if (pggubun="NP") then
                mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "네이버페이")
            else
                mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "실시간이체")
            end if
            mailcontent = replace(mailcontent,":IPKUMSTATUS:", "결제완료")
        elseif paymethod = "80" then   ' 올앳
            mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "올앳카드")
            mailcontent = replace(mailcontent,":IPKUMSTATUS:", "결제완료")
        elseif paymethod = "110" then   ' OKCashbag+신용카드
            mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "OKCashbag+신용카드")
            mailcontent = replace(mailcontent,":IPKUMSTATUS:", "결제완료")
        elseif paymethod = "400" then   ' 핸드폰결제
            mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "핸드폰")
            mailcontent = replace(mailcontent,":IPKUMSTATUS:", "결제완료")
        elseif paymethod = "550" then   ' 기프팅
            mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "기프팅")
            mailcontent = replace(mailcontent,":IPKUMSTATUS:", "결제완료")
        elseif paymethod = "560" then   ' 기프티콘
            mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "기프티콘")
            mailcontent = replace(mailcontent,":IPKUMSTATUS:", "결제완료")
        else
        	mailcontent = replace(mailcontent,":ACCOUNTDIVNAME:", "")
        end if

        if (paymethod<>"7") then
            mailcontent = ReplaceText(mailcontent,"(<!-----bankinfo------>)[\s\S]*(<!-----/bankinfo------>)","")
            mailcontent = ReplaceText(mailcontent,"(<!-----banknotiinfo------>)[\s\S]*(<!-----/banknotiinfo------>)","")
        end if

        IsForeighDeliver = myorder.FOneItem.IsForeignDeliver

		'// 개인정보 모두 별표처리
		if IsNull(myorder.FOneItem.Freqhp) then myorder.FOneItem.Freqhp = ""
		if IsNull(myorder.FOneItem.Fbuyname) then myorder.FOneItem.Fbuyname = ""
		if IsNull(myorder.FOneItem.Freqname) then myorder.FOneItem.Freqname = ""
		if IsNull(myorder.FOneItem.Freqaddress) then myorder.FOneItem.Freqaddress = ""
		if IsNull(myorder.FOneItem.Freqphone) then myorder.FOneItem.Freqphone = ""
		if IsNull(myorder.FOneItem.Fcomment) then myorder.FOneItem.Fcomment = ""

		myorder.FOneItem.Freqhp = AstarPhoneNumber(myorder.FOneItem.Freqhp)
		myorder.FOneItem.Fbuyname = AstarUserName(myorder.FOneItem.Fbuyname)
		myorder.FOneItem.Freqname = AstarUserName(myorder.FOneItem.Freqname)
		myorder.FOneItem.Freqaddress = "(이하생략)"
		myorder.FOneItem.Freqphone = AstarPhoneNumber(myorder.FOneItem.Freqphone)
		myorder.FOneItem.Fcomment = "(생략)"

        if (IsForeighDeliver) then
            'mailcontent = replace(mailcontent,":REQHPORREQEMAIL:", "연락처") ' 수령인 이메일
            mailcontent = replace(mailcontent,":REQHP:", myorder.FOneItem.Freqemail) ' 수령인 전화번호=>이메일로
            mailcontent = replace(mailcontent,":COUNTRYNAME:", myorder.FOneItem.FDlvcountryName) ' 국가.
            mailcontent = replace(mailcontent,":REQZIPCODE:", myorder.FOneItem.FemsZipCode) ' 배송우편번호
        else
            'mailcontent = replace(mailcontent,":REQHPORREQEMAIL:", "연락처") ' 휴대폰번호
            mailcontent = replace(mailcontent,":REQHP:", myorder.FOneItem.Freqhp) ' 수령인 전화번호
            mailcontent = replace(mailcontent,":REQZIPCODE:", myorder.FOneItem.Freqzipcode) ' 배송우편번호
            mailcontent = ReplaceText(mailcontent,"(<!-- foreigndelivery -->)[\s\S]*(<!--/foreigndelivery -->)","")
        end if

        mailcontent = replace(mailcontent,":BUYNAME:", myorder.FOneItem.Fbuyname) ' 주문자 이름
        mailcontent = replace(mailcontent,":ORDERSERIAL:", orderserial) ' 주문번호
        mailcontent = replace(mailcontent,":REQNAME:", myorder.FOneItem.Freqname) ' 수령인 이름
        mailcontent = replace(mailcontent,":REQALLADDRESS:", myorder.FOneItem.FreqZipaddr + " " + myorder.FOneItem.Freqaddress) ' 배송주소
        mailcontent = replace(mailcontent,":REQPHONE:", myorder.FOneItem.Freqphone) ' 수령인 전화번호

        mailcontent = replace(mailcontent,":BEASONGMEMO:", myorder.FOneItem.Fcomment) ' 배송메모

        ''현장수령
        IF (myorder.FOneItem.IsReceiveSiteOrder) then
            mailcontent = replace(mailcontent,"감사의 마음을 담아 빠른 배송이 이루어 질 수 있도록 노력하겠습니다.","<img src='http://company.10x10.co.kr/barcode/barcode.asp?image=3&type=23&data="&orderserial&"&height=50&barwidth=1'>")
            mailcontent = replace(mailcontent,"주문후 7일이내에","주문후 3일이내에")
            mailcontent = replace(mailcontent,"http://fiximage.10x10.co.kr/web2011/mail/tit_orderer.gif","http://fiximage.10x10.co.kr/web2011/mail/tit_orderer_sm.gif")
    	    mailcontent = ReplaceText(mailcontent,"(<!-- dlvaddressNinfo -->)[\s\S]*(<!--/dlvaddressNinfo -->)","")
        end if

    	if (paymethod="110") then
    	    mailcontent = replace(mailcontent,":MAJORTOTALPRICE:", formatNumber(myorder.FOneItem.TotalMajorPaymentPrice,0) & " (신용카드:" &FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice-myorder.FOneItem.FokcashbagSpend,0)& ",  OKCashbag:" &FormatNumber(myorder.FOneItem.FokcashbagSpend,0) &")") ' 결제총액
    	else
    	    mailcontent = replace(mailcontent,":MAJORTOTALPRICE:", formatNumber(myorder.FOneItem.TotalMajorPaymentPrice,0)) ' 결제총액
        end if

        mailcontent = replace(mailcontent,":ACCOUNTNO:", myorder.FOneItem.Faccountno) ' 입금계좌

        if (myorder.FOneItem.FspendTenCash<>0) then
            mailcontent = replace(mailcontent,":SPENDTENCASH:", FormatNumber(myorder.FOneItem.FspendTenCash,0))
        else
            mailcontent = ReplaceText(mailcontent,"(<!-----spendtencash------>)[\s\S]*(<!-----/spendtencash------>)","")
        end if

        if (myorder.FOneItem.FspendGiftMoney<>0) then
            mailcontent = replace(mailcontent,":SPENDGIFTMONEY:", FormatNumber(myorder.FOneItem.FspendGiftMoney,0))
        else
            mailcontent = ReplaceText(mailcontent,"(<!-----spendgiftmoney------>)[\s\S]*(<!-----/spendgiftmoney------>)","")
        end if

		'주문아이템 정보 확인.-----------------------------------------------------------------------------
itemHtml = itemHtml & "<table border=""0"" cellpadding=""0"" cellspacing=""0"" style=""width:100%; font-size:12px; font-family:dotum, '돋움', sans-serif; color:#707070;"">"&vbcrlf
itemHtml = itemHtml & "<tr>"&vbcrlf
itemHtml = itemHtml & "	<th style=""width:50px; height:44px; margin:0; padding:0; border-bottom:solid 1px #eaeaea; background:#f8f8f8; color:#707070; font-size:12px; line-height:12px; font-family:dotum, '돋움', sans-serif; text-align:center;"">상품</th>"&vbcrlf
itemHtml = itemHtml & "	<th style=""width:100px; height:44px; margin:0; padding:0; border-bottom:solid 1px #eaeaea; background:#f8f8f8; color:#707070; font-size:12px; line-height:12px; text-align:center; font-family:dotum, '돋움', sans-serif;"">상품코드</th>"&vbcrlf
itemHtml = itemHtml & "	<th style=""width:240px; height:44px; margin:0; padding:0; border-bottom:solid 1px #eaeaea; background:#f8f8f8; color:#707070; font-size:12px; line-height:12px; text-align:center; font-family:dotum, '돋움', sans-serif;"">상품명[옵션]</th>"&vbcrlf
itemHtml = itemHtml & "	<th style=""width:85px; height:44px; margin:0; padding:0; border-bottom:solid 1px #eaeaea; background:#f8f8f8; color:#707070; font-size:12px; line-height:12px; text-align:right; font-family:dotum, '돋움', sans-serif;"">판매가격</th>"&vbcrlf
itemHtml = itemHtml & "	<th style=""width:22px; height:44px; border-bottom:solid 1px #eaeaea; background:#f8f8f8; color:#707070; font-size:12px; font-family:dotum, '돋움', sans-serif;""></th>"&vbcrlf
itemHtml = itemHtml & "	<th style=""width:35px; height:44px; margin:0; padding:0; border-bottom:solid 1px #eaeaea; background:#f8f8f8; color:#707070; font-size:12px; line-height:12px; text-align:center; font-family:dotum, '돋움', sans-serif;"">수량</th>"&vbcrlf
itemHtml = itemHtml & "	<th style=""width:85px; height:44px; margin:0; padding:0; border-bottom:solid 1px #eaeaea; background:#f8f8f8; color:#707070; font-size:12px; line-height:12px; text-align:right; font-family:dotum, '돋움', sans-serif;"">주문금액</th>"&vbcrlf
itemHtml = itemHtml & "	<th style=""width:23px; border-bottom:solid 1px #eaeaea; background:#f8f8f8;""></th>"&vbcrlf
itemHtml = itemHtml & "</tr> "&vbcrlf

        for i=0 to myorderdetail.FResultCount-1
			'/선물포장 일경우 포장비 안뿌림
			If myorderdetail.FItemList(i).FItemid <> 100 Then
itemHtml = itemHtml & "<tr>"&vbcrlf
itemHtml = itemHtml & "	<td style=""width:50px; padding:6px 0;border-bottom:solid 1px #eaeaea;""><img src=""" &  myorderdetail.FItemList(i).FImageSmall & """ width='50' height='50' alt="""" /></td>"&vbcrlf
itemHtml = itemHtml & "	<td style=""width:100px; margin:0; padding:6px 0; border-bottom:solid 1px #eaeaea; text-align:center; color:#707070; font-size:11px; line-height:11px; font-family:dotum, '돋움', sans-serif;"">"& myorderdetail.FItemList(i).FItemID&"</td>"&vbcrlf
itemHtml = itemHtml & "	<td style=""width:240px; margin:0; padding:6px 0; border-bottom:solid 1px #eaeaea; text-align:left; color:#707070; font-size:11px; line-height:17px; font-family:dotum, '돋움', sans-serif;"">["&myorderdetail.FItemList(i).Fbrandname&"]<br /> " & myorderdetail.FItemList(i).FItemName
if ( myorderdetail.FItemList(i).FItemOptionName <>"") then
itemHtml = itemHtml & "            ["&myorderdetail.FItemList(i).FItemOptionName&"]"
end if
itemHtml = itemHtml & "	</td>"&vbcrlf
itemHtml = itemHtml & "	<td style=""width:85px; margin:0; padding:6px 0; border-bottom:solid 1px #eaeaea; text-align:right; font-family:dotum, '돋움', sans-serif;"">"&vbcrlf

if (myorderdetail.FItemList(i).IsSaleItem) then
itemHtml = itemHtml & "		<span style=""margin:0; padding:6px 0; font-size:11px; line-height:16px; color:#707070; font-family:dotum, '돋움', sans-serif; text-decoration:line-through; text-align:right;"">"&FormatNumber(myorderdetail.FItemList(i).Forgitemcost,0)&"원</span>"&vbcrlf
itemHtml = itemHtml & "		<br /><span style=""margin:0; padding:6px 0; color:#dd5555; font-size:12px; line-height:16px; font-weight:bold; font-family:dotum, '돋움', sans-serif; text-align:right;"">"&FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0)&"원</span><br />"&vbcrlf
else
itemHtml = itemHtml & "		<span style=""margin:0; padding:0; font-weight:bold; color:#707070; font-size:12px; line-height:17px; font-family:dotum, '돋움', sans-serif; text-align:right;"">"&FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0)&"원</span>"&vbcrlf
end if

if (myorderdetail.FItemList(i).IsItemCouponAssignedItem) then
itemHtml = itemHtml & "		<br /><span style=""margin:0; padding:6px 0; color:#dd5555; font-size:11px; line-height:17px; text-align:right; font-family:dotum, '돋움', sans-serif;""><img src=""http://mailzine.10x10.co.kr/2017/ico_coupon.png"" alt=""쿠폰적용"" style=""margin:0; vertical-align:-2px; padding-right:2px; font-size:11px; line-height:17px; text-align:right; font-family:dotum, '돋움', sans-serif;""/>"&FormatNumber(myorderdetail.FItemList(i).FItemCost)&"원</span>"&vbcrlf
end if
itemHtml = itemHtml & "	</td>"&vbcrlf
itemHtml = itemHtml & "	<td style=""width:22px; padding:6px 0; border-bottom:solid 1px #eaeaea;""></td>"&vbcrlf
itemHtml = itemHtml & "	<td style=""width:35px; margin:0; padding:6px 0; border-bottom:solid 1px #eaeaea; font-size:13px; line-height:13px; color:#707070; text-align:center; font-weight:bold; font-family:dotum, '돋움', sans-serif;"">"&myorderdetail.FItemList(i).FItemNo&"</td>"&vbcrlf
itemHtml = itemHtml & "	<td style=""width:85px; padding:6px 0; border-bottom:solid 1px #eaeaea; font-size:12px; text-align:right; font-family:dotum, '돋움', sans-serif;"">"&vbcrlf
itemHtml = itemHtml & "		<span style=""margin:0; padding:0; font-weight:bold; color:#707070; font-size:12px; line-height:17px; font-family:dotum, '돋움', sans-serif; text-align:right;"">"&FormatNumber(myorderdetail.FItemList(i).FItemCost*myorderdetail.FItemList(i).FItemNo,0) &"원</span>"&vbcrlf
if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then
itemHtml = itemHtml & "		<br /><span style=""margin:0; padding:6px 0; color:#dd5555; font-size:11px; line-height:17px; text-align:right; font-family:dotum, '돋움', sans-serif;""><img src=""http://mailzine.10x10.co.kr/2017/ico_coupon.png"" alt=""쿠폰적용"" style=""margin:0; vertical-align:-2px; padding-right:2px; font-size:11px; line-height:17px; text-align:right; font-family:dotum, '돋움', sans-serif;""/>"&FormatNumber(myorderdetail.FItemList(i).getReducedPrice*myorderdetail.FItemList(i).FItemNo,0)&"원</span>"&vbcrlf
end if
itemHtml = itemHtml & "	</td>"&vbcrlf
itemHtml = itemHtml & "	<td style=""width:23px; padding:6px 0; border-bottom:solid 1px #eaeaea;"">&nbsp;</td>"&vbcrlf
itemHtml = itemHtml & "</tr>"&vbcrlf
				tmpitemcnt = tmpitemcnt + 1
				tmpitemnosum = tmpitemnosum + myorderdetail.FItemList(i).FItemNo
			end if
        next
itemHtml = itemHtml & "</table>"

		itemHtmlTotal = replace(mailcontent,":INNERORDERTABLE:", itemHtml) ' 주문정보테이블 넣기

        mailcontent = itemHtmlTotal

'가격 Table
		IF (myorder.FOneItem.Fmiletotalprice<>0) then
			ttSumsale = ttSumsale + myorder.FOneItem.Fmiletotalprice
		End If
		IF (myorder.FOneItem.Ftencardspend<>0) then
		    ttSumsale = ttSumsale + myorder.FOneItem.Ftencardspend
		end if
		if (myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership<>0) then
			ttSumsale = ttSumsale + myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership
		end if
		if (myorder.FOneItem.FDeliverpriceCouponNotApplied>myorder.FOneItem.FDeliverprice) then
    		ttSumsale = ttSumsale + (myorder.FOneItem.FDeliverpriceCouponNotApplied - myorder.FOneItem.FDeliverprice)
		end if

		ttlsumHTML = ""
		ttlsumHTML = ttlsumHTML & "<table border=""0"" cellpadding=""0"" cellspacing=""0"" style=""width:100%;"">"&vbcrlf
		ttlsumHTML = ttlsumHTML & "<tr>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "	<td style=""border:solid 5px #eaeaea;"">"&vbcrlf
		ttlsumHTML = ttlsumHTML & "		<table border=""0"" cellpadding=""0"" cellspacing=""0"" style=""width:100%;"">"&vbcrlf
		ttlsumHTML = ttlsumHTML & "			<tr>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<th style=""width:123px; height:45px; margin:0; padding:0; background:#f8f8f8; font-size:14px; line-height:14px; color:#707070; text-align:center; font-family:dotum, '돋움', sans-serif; font-weight:bold;"">구매 총 금액</th>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<th style=""width:20px; height:45px; background:#f8f8f8;""></th>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<th style=""width:130px; height:45px; margin:0; padding:0; background:#f8f8f8; font-size:14px; line-height:14px; color:#707070; text-align:center; font-family:dotum, '돋움', sans-serif; font-weight:bold;"">배송비</th>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<th style=""width:20px; height:45px; background:#f8f8f8;""></th>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<th style=""width:123px; height:45px; margin:0; padding:0; background:#f8f8f8; font-size:14px; line-height:14px; color:#707070; text-align:center; font-family:dotum, '돋움', sans-serif; font-weight:bold;"">할인 금액</th>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<th style=""width:20px; height:45px; background:#f8f8f8;""></th>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<th style=""width:194px; height:45px; margin:0; padding:0; background:#f8f8f8; font-size:14px; line-height:14px; color:#707070; text-align:center; font-family:dotum, '돋움', sans-serif; font-weight:bold;"">총 주문 금액</th>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "			</tr>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "			<tr>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<td style=""width:123px; height:68px; margin:0; padding:0; font-size:15px; line-height:15px; color:#000; text-align:center; font-family:verdana;""><span style=""margin:0; padding:0; font-size:15px; line-height:15px; color:#000; text-align:center; font-family:verdana; font-weight:bold;"">"& FormatNumber(myorder.FOneItem.FTotalSum - myorder.FOneItem.FDeliverPrice - pojangcash,0) &"</span>원</td>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<td style=""width:20px; height:68px; margin:0; padding:0; font-size:15px; line-height:25px; font-weight:bold; vertical-align:middle; font-family:verdana;"">+</td>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<td style=""width:130px; height:68px; margin:0; padding:0; font-size:15px; line-height:15px; color:#000; text-align:center; font-family:verdana;""><span style=""margin:0; padding:0; font-size:15px; line-height:15px; color:#000; text-align:center; font-family:verdana; font-weight:bold;"">"& FormatNumber(myorder.FOneItem.FDeliverpriceCouponNotApplied,0) &"</span>원</td>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<td style=""width:20px; height:68px; margin:0; padding:0; font-size:20px; line-height:20px; font-weight:bold; vertical-align:middle; font-family:verdana;"">-</td>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<td style=""width:123px; height:68px; margin:0; padding:0; font-size:15px; line-height:15px; color:#000; text-align:center; font-family:verdana;""><span style=""margin:0; padding:0; font-size:15px; line-height:15px; color:#000; text-align:center; font-family:verdana; font-weight:bold;"">"& FormatNumber(ttSumsale,0) &"</span>원</td>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<td style=""width:20px; height:68px; margin:0; padding:0; font-size:20px; line-height:20px; font-weight:bold; vertical-align:middle; font-family:verdana;"">=</td>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "				<td style=""width:194px; height:68px; margin:0; padding:0; font-size:24px; line-height:24px; color:#dd5555; text-align:center; font-family:verdana; font-weight:bold;""><span style=""margin:0; padding:0; font-size:24px; line-height:24px; color:#dd5555; text-align:center; font-family:verdana; font-weight:bold; font-family:verdana;"">"& FormatNumber(myorder.FOneItem.FsubtotalPrice,0) &"</span>원</td>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "			</tr>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "		</table>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "	</td>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "</tr>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "<tr>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "	<td style=""padding-top:9px; text-align:right; font-size:11px; line-height:11px; color:#808080; font-family:dotum, '돋움', sans-serif;"">적립마일리지 <span style=""color:#dd5555; font-weight:bold;"">"& FormatNumber(myorder.FOneItem.Ftotalmileage,0) &"P</span></td>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "</tr>"&vbcrlf
		ttlsumHTML = ttlsumHTML & "</table>"
'가격 Table끝

        mailcontent = replace(mailcontent,":ORDERPRICESUMMARY:", ttlsumHTML) ' 주문 합계금액
        set myorder = Nothing
        set myorderDetail = Nothing

        call sendmail(mailfrom, mailto, mailtitle, mailcontent)
end function






	'// 특정사용자만 실행가능
	if Not(GetLoginUserID="kjy8517") then
		Call Alert_Close("잘못된 접속입니다.")
		dbget.Close(): response.End
	end if

	Dim OrdSn
	OrdSn = "17092803540"

	'주문서 발송
	call SendMailOrder2(OrdSn,"텐바이텐<customer@10x10.co.kr>")
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->