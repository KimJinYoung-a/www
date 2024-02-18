<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 냉동실을 부탁해 당첨자조회
' History : 2015-06-26 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	dim arrList, i, returncnt
	Dim eCode, userid, sqlStr
	Dim pdname1, pdname2, pdname3, pdname4
	Dim returnuserid  : returnuserid = 	request("returnval")

	If returnuserid = "" Then returnuserid = "a"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  64837
	Else
		eCode   =  65010
	End If
  
If userid="baboytw" or userid="ilovecozie" or userid="boyishP" Then

Else
	response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
	response.End
End If

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.table {width:900px; margin:0 auto; font-family:'malgun gothic'; border-collapse:collapse;}
.table th {padding:12px 0; font-size:13px; font-weight:bold;  color:#fff; background:#444;}
.table td {padding:12px 3px; font-size:12px; border:1px solid #ddd; border-bottom:2px solid #ddd;}
.table td.lt {text-align:left; padding:12px 10px;}
.tBtn {display:inline-block; border:1px solid #2b90b6; background:#03a0db; padding:0 10px 2px; line-height:26px; height:26px; font-weight:bold; border-radius:5px; color:#fff !important;}
.tBtn:hover {text-decoration:none;}
.table td input {border:1px solid #ddd; height:30px; padding:0 3px; font-size:14px; color:#ec0d02; text-align:right;}
</style>
</head>
<body>
<%
	'// 당첨확인
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And userid='"&returnuserid&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		returncnt = rsget(0)
	End IF
	rsget.close
	
	sqlstr = "select userid, sub_opt2, regdate "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And userid='"&returnuserid&"' "
	rsget.Open sqlstr, dbget, 1

	IF Not rsget.EOF THEN
		arrList = rsget.getRows()
	END IF
	rsget.Close
%>
<script type="text/javascript">
	function searchFrm(){
		frm.submit();
	}
</script>

<form name="frm" action="iframe_65010_manage_cs.asp" method="get">
<table class="table" style="width:90%;">
	<tr bgcolor="#ABF200">
		<td>
			APP 전용 이벤트 : 냉동실을 부탁해 [ 이벤트코드 : 65010 ] 응모자 검색
		</td>
	</tr>
	<tr bgcolor="#00D8FF">
		<td>
			응모자 ID <input type="text" name="returnval" class="button" size="10" maxlength="20">
			<input type="button" class="button" value="검색" onclick="searchFrm('');">
		</td>
	</tr>
</table>
</form>

<table class="table" style="width:90%;">
	<tr align="center" bgcolor="#B2EBF4">
	<b>
		<td>
			응모자 ID
		</td>
		<td>
			당첨 상품
		</td>
		<td>
			당첨 일시
		</td>
	</b>
	</tr>
<%
if returncnt > 0 then
	for i = 0 to returncnt -1

	If left(arrLIst(2,i),10) <"2015-07-27" or left(arrLIst(2,i),10)="2015-08-03" Then
		pdName1 = "베스킨라빈스 베리베리스트로베리 아빙"
		pdName2 = "설레임밀크"
		pdName3 = "파리바게트 팥빙수"
	elseif left(arrLIst(2,i),10)="2015-07-28" or left(arrLIst(2,i),10)="2015-08-04"Then
		pdName1 = "던킨도너츠 아이스 카페모카"
		pdName2 = "우유속에 모카치노"
		pdName3 = "스타벅스 아이스커피 tall"
	elseif left(arrLIst(2,i),10)="2015-07-29" or left(arrLIst(2,i),10)="2015-08-05" Then
		pdName1 = "스무디킹 스트로베리익스트림[S]"
		pdName2 = "메로나"
		pdName3 = "베스킨라빈스 청송달콤사과 블라스트"
	elseif left(arrLIst(2,i),10)="2015-07-30" or left(arrLIst(2,i),10)="2015-08-06"Then
		pdName1 = "베스킨라빈스 엄마는 외계인 아빙"
		pdName2 = "베스킨라빈스 아이스크림 롤"
		pdName3 = "스타벅스 시그니처 초콜릿"
	elseif left(arrLIst(2,i),10)="2015-07-31" or left(arrLIst(2,i),10)>="2015-08-07" Then
		pdName1 = "베스킨라빈스 감사합니다 케이크"
		pdName2 = "베스킨라빈스 아이스 마카롱"
		pdName3 = "베스킨라빈스 싱글레귤러"
	end if
	%>
	<tr align="center" bgcolor="#D4F4FA">
		<td>
			<%= arrLIst(0,i) %>
		</td>
		<td>
			<%
			Select Case (arrLIst(1,i))
				Case "0"
					Response.Write "무료배송쿠폰(꽝)"
				Case "1111111"
					Response.Write pdName1
				Case "2222222"
					Response.Write pdName2
				Case "3333333"
					Response.Write pdName3
				Case "4444444"
					Response.Write pdName4
			End Select
			  %>
		</td>
		<td>
			<%= arrLIst(2,i) %>
		</td>
	</tr>
	<%
	next
else
%>
응모 내역이 없습니다.
<%
end if
%>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->