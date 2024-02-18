<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'==========================================================================
'	Description: 오프라인 실물카드 발행 (주문처리)
'	History: 2011.12.08 허진원 - 생성
'	         2011.12.28 허진원 - 실물카드 풀을 채우는것으로 변경
'	http://www.10x10.co.kr/inipay/giftcard/make_Real_GiftCard_Order.asp?mcnt=100
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
	dim strRst, makeCnt, strSql, lp, tmpMstCd, idxNo, sh
	makeCnt = Request("mcnt")

	'// 특정사용자만 실행가능
	if Not(GetLoginUserID="kobula" or GetLoginUserID="eastone") then
		Call Alert_Close("잘못된 접속입니다.")
		dbget.Close(): response.End
	end if

	if makeCnt="" or Not(isNumeric(makeCnt)) then
		Call Alert_Close("생성할 기프트카드의 수를 입력해주세요.")
		dbget.Close(): response.End
	end if

	'기존값 카운트
	strSql = "Select count(masterCardCode) from db_order.dbo.tbl_giftcard_offMasterCd "
	rsget.Open strSql,dbget,1
		idxNo = rsget(0)
	rsget.close

	'// 주문건 생성 도돌이
	For lp=1 to makeCnt
		sh=0: tmpMstCd=""
		'@카드번호 생성
		tmpMstCd = getMasterCodeOff(idxNo + lp,16,sh)

		if tmpMstCd<>"" then
			'@카드번호 저장
			strSql = "Insert Into db_order.dbo.tbl_giftcard_offMasterCd (masterCardCode)" & vbCrlf
			strSql = strSql + " Values ('" & CStr(tmpMstCd) & "')" & vbCrlf
			dbget.Execute strSql
		end if

		strRst = strRst & lp & ". " & tmpMstCd & " (" & sh & "," & idxNo+lp & "," & chkMasterCode(tmpMstCd) & ")<br>"
	Next

	'#### 결과 출력
	response.Write strRst
%>