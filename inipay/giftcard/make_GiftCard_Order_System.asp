<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'==========================================================================
'	Description: 사은품용 카드 발행 (주문처리)
'	History: 2011.12.08 허진원 - 생성
'	http://www.10x10.co.kr/inipay/giftcard/make_GiftCard_Order_System.asp?mcnt=100&iid=101&opt=0006
'	옵션 :	0000 수기입력
'			0001 1만원권
'			0002 2만원권
'			0003 3만원권
'			0004 5만원권
'			0005 8만원권
'			0006 10만원권
'			0007 15만원권
'			0008 20만원권
'			0009 30만원권
'==========================================================================

    Response.AddHeader "Cache-Control","no-cache"
    Response.AddHeader "Expires","0"
    Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/MD5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<%
	dim strRst, makeCnt, strSql, lp, tmpOrdSn, tmpMstCd, ordIdx
	dim giftItemid, giftOption, giftcardPrice
	dim rndjumunno, ordUserid, ordUserNm
	makeCnt = Request("mcnt")
	giftItemid = Request("iid")
	giftOption = Request("opt")

	'// 특정사용자만 실행가능
	if Not(GetLoginUserID="kobula" or GetLoginUserID="eastone" or GetLoginUserID="tozzinet") then
		Call Alert_Close("잘못된 접속입니다.")
		dbget.Close(): response.End
	end if

	if makeCnt="" or Not(isNumeric(makeCnt)) then
		Call Alert_Close("생성할 기프트카드의 수를 입력해주세요.")
		dbget.Close(): response.End
	end if

	'기프트카드 상품정보
	if giftItemid="" then giftItemid=101

	strSql = "Select top 1 cardSellCash " &_
			" From db_item.dbo.tbl_giftcard_option " &_
			" Where cardItemid=" & giftItemid &_
			"	and cardOption='" & giftOption & "'" &_
			"	and optSellYn='Y' and optIsUsing='Y' "
	rsget.Open strSql, dbget, 1
	if Not(rsget.EOF or rsget.BOF) then
		giftcardPrice = rsget(0)
	elseif giftOption="0000" then		'수기입력
		giftcardPrice = 0
	else
		Call Alert_Close("지정한 옵션이 없습니다.")
		rsget.Close(): dbget.Close(): response.End
	end if
	rsget.Close
	

	'주문자
	ordUserid = "system"
	'ordUserid = "10x10phone"
	ordUserNm = "텐바이텐"

	'// 주문건 생성 도돌이
	For lp=1 to makeCnt
		tmpOrdSn="": tmpMstCd=""
	    '임시주문번호 생성
	    Randomize
		rndjumunno = CLng(Rnd * 100000) + 1
		rndjumunno = CStr(rndjumunno)

		'@주문건 저장 (GiftCardGbn:0, 추후 1으로 변경;POS수정후)
		strSql = "Insert Into [db_order].[dbo].tbl_giftcard_order "
		strSql = strSql & " (giftOrderSerial,cardItemid,cardOption,masterCardCode,userid,buyname,totalsum,jumundiv,accountdiv,ipkumdiv,ipkumdate "
		strSql = strSql & " ,discountrate,subtotalprice,miletotalprice,tencardspend,referip,userlevel,sumPaymentEtc,designId,resendCnt,GiftCardGbn,notRegSpendSum) "
		strSql = strSql & " Values "
		strSql = strSql & " ('" & rndjumunno & "'," & giftItemid & ",'" & giftOption & "','','" & ordUserid & "','" & ordUserNm & "'," & giftcardPrice
		strSql = strSql & " ,'5','10','8',getdate(),1," & giftcardPrice & ",0,0,'" & Left(request.ServerVariables("REMOTE_ADDR"),32) & "'"
		strSql = strSql & " ,7,0,'101',0,0,0)"
		dbget.Execute strSql

		'@IDX접수
		strSql = "Select IDENT_CURRENT('[db_order].[dbo].tbl_giftcard_order') as maxitemid "
		rsget.Open strSql,dbget,1
			ordIdx = rsget("maxitemid")
		rsget.close

		'## 실 주문번호/카드코드 Setting
		if (Not IsNull(ordIdx)) and (ordIdx<>"") then
			dim sh: sh=0
			tmpOrdSn = "G" & Mid(replace(CStr(DateSerial(Year(now),month(now),Day(now))),"-",""),4,256)
			tmpOrdSn = tmpOrdSn & Format00(5,Right(CStr(ordIdx),5))
			tmpMstCd = getMasterCode(ordIdx,16,sh)

			strSql = " update [db_order].[dbo].tbl_giftcard_order" + vbCrlf
			strSql = strSql + " set giftOrderSerial='" + tmpOrdSn + "'" + vbCrlf
			strSql = strSql + " ,masterCardCode='" + tmpMstCd + "'" + vbCrlf
			strSql = strSql + " where idx=" + CStr(ordIdx) + vbCrlf

			dbget.Execute strSql

			'# 기프트카드 인증번호 발급 로그 저장
			Call putGiftCardMasterCDLog(tmpOrdSn,tmpMstCd,sh-1)
	    end if

		strRst = strRst & "- " & tmpOrdSn & " : " & tmpMstCd & "<br>"
	Next

	'#### 결과 출력
	response.Write strRst
%>