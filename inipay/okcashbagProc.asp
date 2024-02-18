<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2008-10-30 김정인
'	Description : 캐쉬백 카드정보 입력
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->

<%
dim CardNo,OrderSerial
dim Num1,Num2,Num3,Num4

Num1 = RequestCheckVar(request("num1"),4)
Num2 = RequestCheckVar(request("num2"),4)
Num3 = RequestCheckVar(request("num3"),4)
Num4 = RequestCheckVar(request("num4"),4)
OrderSerial = RequestCheckVar(request("ods"),20)

IF Not (Len(Num1)=4 and Len(Num2)=4 and Len(Num3)=4 and Len(Num4)=4) Then
	Alert_Return("카드번호를 확인해주세요.")
	response.end
END IF

CardNo = Num1 &"-"& Num2 &"-"& Num3 &"-"& Num4

IF CardNo="" or OrderSerial="" THEN
    Alert_Return("처리중 오류가 발생했습니다.")
    dbget.Close:response.end
End IF

dim strSQL,ChkCnt
dim rdsite
strSQL = "select isNULL(rdsite,'') as rdsite from db_order.dbo.tbl_order_master"&VbCRLF
strSQL =strSQL&" where orderserial ='"& OrderSerial&"'"
rsget.open strSQL ,dbget
if Not rsget.Eof then
    rdsite = rsget("rdsite")
end if
rsget.close

if (Trim(LCASE(rdsite))<>"okcashbag") and (Trim(LCASE(rdsite))<>"pickle") then
    Alert_Return("처리중 오류가 발생했습니다.")
	dbget.Close:response.end
end if

On Error Resume Next
''//적립 신청여부 체크
dbget.BeginTrans
	strSQL =" select Count(*) from db_order.dbo.tbl_okcashbag_info "&VbCRLF
	strSQL =strSQL&" where orderserial ='"& OrderSerial&"'"

	rsget.open strSQL ,dbget,2

	IF not rsget.eof Then
		ChkCnt = rsget(0)
	End IF
	rsget.close

IF ChkCnt>0 Then
	Alert_Close("이미 적립신청이 되었습니다.")
	dbget.Close:response.end
ELSE
	'strSQL =" insert into db_order.dbo.tbl_okcashbag_info(cardno,orderserial,encmethod,enccardno) " &VbCRLF
	'strSQL =strSQL&	" values('0000-0000-0000-0000' ,'"& OrderSerial &"','PH1',db_cs.dbo.uf_EncAcctPH1('"& CardNo &"'))"
	'dbget.execute(strSQL)
	
	strSQL = "exec db_cs.[dbo].[sp_Ten_AddOkcashBagEncInfo] '"&CardNo&"','"&OrderSerial&"','AE2'"
	dbget.execute(strSQL)
End IF

IF Err.number=0 Then
	dbget.CommitTrans
	Alert_Close("적립신청 되었습니다. 감사합니다.")
	dbget.Close:response.end
ELSE
	dbget.RollbackTrans
	Alert_Return("처리중 오류가 발생했습니다.")
	dbget.Close:response.end
End IF

%>

<!-- #include virtual="/lib/db/dbclose.asp" -->
