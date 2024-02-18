<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 지구를 돌려라
' History : 2016-06-17 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	dim snscnt1, snscnt2, totalokcnt
	Dim mainbannercnt, totalcnt, getitemgocnt
	Dim wincnt1, wincnt2, wincnt3, wincnt4, wincnt5, wincnt6, wincnt7, wincnt8, wincnt9, wincnt10, wincnt11, wincnt12, wincnt13, wincnt14, wincnt15, wincnt16
	Dim wincnt17, wincnt18, wincnt19, wincnt20, wincnt21, wincnt22, wincnt23, wincnt24, wincnt25, wincnt26, wincnt27, wincnt28, wincnt29, wincnt30, wincnt31, wincnt32, wincnt33, wincnt34, wincnt35
	Dim wincnt36, wincnt37, wincnt38, wincnt39, wincnt40, wincnt41, wincnt42, wincnt43, wincnt44
	Dim eCode, userid, sqlStr
	Dim returndate  : returndate = 	request("returndate")

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "66153"
	Else
		eCode 		= "71239"
	End If

If userid="baboytw" Or userid="greenteenz" Or userid= "helele223" Or userid="cogusdk" Or userid="jjh" Then

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
	''총 응모인원
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	''총 당첨인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And convert(varchar(10),regdate,120) ='"&returndate&"' and sub_opt2<> 0 "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalokcnt = rsget(0)
	End IF
	rsget.close
	
	''sns 클릭수
	sqlstr = "SELECT " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt3 = 'fb' then 1 else 0 end),0) as sns1, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt3 = 'ka' then 1 else 0 end),0) as sns2 " + vbcrlf
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript where evt_code = '"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' " 
	rsget.Open sqlstr,dbget,1
	IF Not rsget.Eof Then
		snscnt1 = rsget("sns1")	''페이스북
		snscnt2 = rsget("sns2")	''카카오톡
	End If
	rsget.close()

	''상품별 당첨자
	sqlstr = "SELECT " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '1' then 1 else 0 end),0) as item1, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '2' then 1 else 0 end),0) as item2, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '3' then 1 else 0 end),0) as item3, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '4' then 1 else 0 end),0) as item4, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '5' then 1 else 0 end),0) as item5, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '6' then 1 else 0 end),0) as item6, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '7' then 1 else 0 end),0) as item7, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '8' then 1 else 0 end),0) as item8, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '9' then 1 else 0 end),0) as item9, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '10' then 1 else 0 end),0) as item10, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '11' then 1 else 0 end),0) as item11, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '12' then 1 else 0 end),0) as item12, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '13' then 1 else 0 end),0) as item13, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '14' then 1 else 0 end),0) as item14, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '15' then 1 else 0 end),0) as item15, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '16' then 1 else 0 end),0) as item16, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '17' then 1 else 0 end),0) as item17, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '18' then 1 else 0 end),0) as item18, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '19' then 1 else 0 end),0) as item19, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '20' then 1 else 0 end),0) as item20, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '21' then 1 else 0 end),0) as item21, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '22' then 1 else 0 end),0) as item22, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '23' then 1 else 0 end),0) as item23, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '24' then 1 else 0 end),0) as item24, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '25' then 1 else 0 end),0) as item25, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '26' then 1 else 0 end),0) as item26, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '27' then 1 else 0 end),0) as item27, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '28' then 1 else 0 end),0) as item28, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '29' then 1 else 0 end),0) as item29, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '30' then 1 else 0 end),0) as item30, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '31' then 1 else 0 end),0) as item31, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '32' then 1 else 0 end),0) as item32, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '33' then 1 else 0 end),0) as item33, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '34' then 1 else 0 end),0) as item34, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '35' then 1 else 0 end),0) as item35, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '36' then 1 else 0 end),0) as item36, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '37' then 1 else 0 end),0) as item37, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '38' then 1 else 0 end),0) as item38, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '39' then 1 else 0 end),0) as item39, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '40' then 1 else 0 end),0) as item40, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '41' then 1 else 0 end),0) as item41, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '42' then 1 else 0 end),0) as item42, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '43' then 1 else 0 end),0) as item43, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '44' then 1 else 0 end),0) as item44 " + vbcrlf
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript where evt_code = '"& eCode &"'  " 
	rsget.Open sqlstr,dbget,1
	IF Not rsget.Eof Then
		wincnt1 = rsget("item1")	''인스탁스
		wincnt2 = rsget("item2")	''스티키몬스터
		wincnt3 = rsget("item3")	''선풍기
		wincnt4 = rsget("item4")	''마일리지
		wincnt5	= rsget("item5")	''
		wincnt6	= rsget("item6")	''
		wincnt7	= rsget("item7")	''
		wincnt8	= rsget("item8")	''
		wincnt9	= rsget("item9")	''
		wincnt10	= rsget("item10")	''
		wincnt11	= rsget("item11")	''
		wincnt12	= rsget("item12")	''
		wincnt13	= rsget("item13")	''
		wincnt14	= rsget("item14")	''
		wincnt15	= rsget("item15")	''
		wincnt16	= rsget("item16")	''
		wincnt17	= rsget("item17")	''
		wincnt18	= rsget("item18")	''
		wincnt19	= rsget("item19")	''
		wincnt20	= rsget("item20")	''
		wincnt21	= rsget("item21")	''
		wincnt22	= rsget("item22")	''
		wincnt23	= rsget("item23")	''
		wincnt24	= rsget("item24")	''
		wincnt25	= rsget("item25")	''
		wincnt26	= rsget("item26")	''
		wincnt27	= rsget("item27")	''
		wincnt28	= rsget("item28")	''
		wincnt29	= rsget("item29")	''
		wincnt30	= rsget("item30")	''
		wincnt31	= rsget("item31")	''
		wincnt32	= rsget("item32")	''
		wincnt33	= rsget("item33")	''
		wincnt34	= rsget("item34")	''
		wincnt35	= rsget("item35")	''
		wincnt36	= rsget("item36")	''
		wincnt37	= rsget("item37")	''
		wincnt38	= rsget("item38")	''
		wincnt39	= rsget("item39")	''
		wincnt40	= rsget("item40")	''
		wincnt41	= rsget("item41")	''
		wincnt42	= rsget("item42")	''
		wincnt43	= rsget("item43")	''
		wincnt44	= rsget("item44")	''
	End If
	rsget.close()

%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>정기세일 빙고게임</strong></th>
</tr>

</table>
<table class="table" style="width:90%;">
<colgroup>
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
</colgroup>
<tr align="center" bgcolor="#E6E6E6">
	<th colspan="12"><strong>날짜</strong></th>
</tr>
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_71239_manage.asp?returndate=2016-06-20">2016-06-20 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_71239_manage.asp?returndate=2016-06-21">2016-06-21 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_71239_manage.asp?returndate=2016-06-22">2016-06-22 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_71239_manage.asp?returndate=2016-06-23">2016-04-23 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_71239_manage.asp?returndate=2016-06-24">2016-06-24 (금)</a></td>
</tr>																				            
</table>
<br>

<table class="table" style="width:90%;">

	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr>
		<Td colspan="12"><font size="5">기준일 : <%=returndate%>, 총 응모자 : <%=totalcnt%>명, 총 당첨자 : <%=totalokcnt%>명</font></td>
	</tr>

	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>페이스북</strong></th>
		<th><strong>카카오톡</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= snscnt1 %><br></td>
		<td bgcolor=""><%= snscnt2 %><br></td>
	</tr>

	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>스티키몬스터 한국</strong></th>
		<th><strong>마이뷰티다이어리마스크팩 한국</strong></th>
		<th><strong>피크닉매트 한국</strong></th>
		<th><strong>오야스미양 쿨팩 한국-</strong></th>
		<th><strong>커피메이커오븐 파리</strong></th>
		<th><strong>토드라팡 네일 파리</strong></th>
		<th><strong>키티버니포니파우치 파리</strong></th>
		<th><strong>델리삭스양말세트 파리</strong></th>
		<th><strong>요거트메이커 덴마크</strong></th>

	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td <% if wincnt1 >= 2 then %>bgcolor="pink"<% end if %>><%= wincnt1 %>/2<br></td>
		<td  <% if wincnt2>= 0 then %>bgcolor="pink"<% end if %>><%= wincnt2 %>/0<br></td>
		<td  <% if wincnt3>=100 then %>bgcolor="pink"<% end if %>><%= wincnt3 %>/100</td>
		<td  <% if wincnt4>=30 then %>bgcolor="red"<% end if %>><%= wincnt4 %>/30</td>
		<td  <% if wincnt5>=8 then %>bgcolor="red"<% end if %>><%= wincnt5 %>/8</td>
		<td  <% if wincnt6>=196 then %>bgcolor="pink"<% end if %>><%= wincnt6 %>/196</td>
		<td  <% if wincnt7>=89 then %>bgcolor="pink"<% end if %>><%= wincnt7 %>/89</td>
		<td  <% if wincnt8>=18 then %>bgcolor="red"<% end if %>><%= wincnt8 %>/18</td>
		<td  <% if wincnt9>=50 then %>bgcolor="pink"<% end if %>><%= wincnt9 %>/50</td>
	</tr>
	<tr>
		<td colspan="12" height="20"></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>스파이더맨선풍기 미국</strong></th>
		<th><strong>미니마우스물총미국</strong></th>
		<th><strong>디즈니플레잉카드미국</strong></th>
		<th><strong>아이코닉코인월렛오사카</strong></th>
		<th><strong>아이코닉코인월렛다낭</strong></th>
		<th><strong>슈퍼피플선글라스다낭</strong></th>
		<th><strong>여행노트클립펜세부</strong></th>
		<th><strong>여행노트클립펜괌</strong></th>
		<th><strong>여행노트클립펜홍콩</strong></th>

	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td <% if wincnt10>=5 then %> bgcolor="red"<% end if %>><%= wincnt10 %>/5<br></td>
		<td <% if wincnt11>=300 then %> bgcolor="pink"<% end if %>><%= wincnt11 %>/300<br></td>
		<td <% if wincnt12>=73 then %> bgcolor="pink"<% end if %>><%= wincnt12 %>/73</td>
		<td <% if wincnt13>=43 then %> bgcolor="red"<% end if %>><%= wincnt13 %>/43</td>
		<td <% if wincnt14>=29 then %> bgcolor="pink"<% end if %>><%= wincnt14 %>/29</td>
		<td <% if wincnt15>=3 then %> bgcolor="red"<% end if %>><%= wincnt15 %>/3</td>
		<td <% if wincnt16>=70 then %> bgcolor="pink"<% end if %>><%= wincnt16 %>/70</td>
		<td <% if wincnt17>=8 then %> bgcolor="red"<% end if %>><%= wincnt17 %>/8</td>
		<td <% if wincnt18>=67 then %> bgcolor="pink"<% end if %>><%= wincnt18 %>/67</td>
	</tr>
	<tr>
		<td colspan="12" height="20"></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>여행노트클립펜호놀룰루</strong></th>
		<th><strong>여행노트클립펜오사카</strong></th>
		<th><strong>여행노트클립펜타이페이</strong></th>
		<th><strong>여행노트클립펜다낭</strong></th>
		<th><strong>모노폴리파우치세부</strong></th>
		<th><strong>모노폴리파우치괌</strong></th>
		<th><strong>모노폴리파우치홍콩</strong></th>
		<th><strong>모노폴리파우치호놀룰루</strong></th>
		<th><strong>모노폴리파우치오사카</strong></th>

	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td <% if wincnt19>=37 then %> bgcolor="red"<% end if %>><%= wincnt19 %>/37<br></td>
		<td <% if wincnt20>=43 then %> bgcolor="pink"<% end if %>><%= wincnt20 %>/43<br></td>
		<td <% if wincnt21>=61 then %> bgcolor="pink"<% end if %>><%= wincnt21 %>/61</td>
		<td <% if wincnt22>=18 then %> bgcolor="red"<% end if %>><%= wincnt22 %>/18</td>
		<td <% if wincnt23>=61 then %> bgcolor="pink"<% end if %>><%= wincnt23 %>/61</td>
		<td <% if wincnt24>=8 then %> bgcolor="red"<% end if %>><%= wincnt24 %>/8</td>
		<td <% if wincnt25>=58 then %> bgcolor="pink"<% end if %>><%= wincnt25 %>/58</td>
		<td <% if wincnt26>=37 then %> bgcolor="red"<% end if %>><%= wincnt26 %>/37</td>
		<td <% if wincnt27>=43 then %> bgcolor="pink"<% end if %>><%= wincnt27 %>/43</td>
	</tr>
	<tr>
		<td colspan="12" height="20"></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>모노폴리파우치타이페이</strong></th>
		<th><strong>모노폴리파우치다낭</strong></th>
		<th><strong>멀티플러그십일자형오사카</strong></th>
		<th><strong>아이코닉행키홍콩</strong></th>
		<th><strong>아이코닉행키타이페이</strong></th>
		<th><strong>아이코닉사이드백홍콩</strong></th>
		<th><strong>아이코닉사이드백타이페이</strong></th>
		<th><strong>서커스타투세부</strong></th>
		<th><strong>서커스타투괌</strong></th>

	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td <% if wincnt28>=82 then %> bgcolor="pink"<% end if %>><%= wincnt28 %>/82<br></td>
		<td <% if wincnt29>=18 then %> bgcolor="red"<% end if %>><%= wincnt29 %>/18<br></td>
		<td <% if wincnt30>=43 then %> bgcolor="pink"<% end if %>><%= wincnt30 %>/43</td>
		<td <% if wincnt31>=67 then %> bgcolor="pink"<% end if %>><%= wincnt31 %>/67</td>
		<td <% if wincnt32>=91 then %> bgcolor="pink"<% end if %>><%= wincnt32 %>/91</td>
		<td <% if wincnt33>=67 then %> bgcolor="pink"<% end if %>><%= wincnt33 %>/67</td>
		<td <% if wincnt34>=91 then %> bgcolor="pink"<% end if %>><%= wincnt34 %>/91</td>
		<td <% if wincnt35>=60 then %> bgcolor="pink"<% end if %>><%= wincnt35 %>/60</td>
		<td <% if wincnt36>=8 then %> bgcolor="red"<% end if %>><%= wincnt36 %>/8</td>
	</tr>
	<tr>
		<td colspan="12" height="20"></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>서커스타투호놀룰루</strong></th>
		<th><strong>방수팩세부</strong></th>
		<th><strong>방수팩괌</strong></th>
		<th><strong>방수팩호놀룰루</strong></th>
		<th><strong>아이리뷰선풍기한국</strong></th>
		<th><strong>걸볼모바일한국</strong></th>
		<th><strong>여행상품권100만원</strong></th>
		<th><strong>보냉백한국</strong></th>

	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td <% if wincnt37>=37 then %> bgcolor="red"<% end if %>><%= wincnt37 %>/37<br></td>
		<td <% if wincnt38>=62 then %> bgcolor="pink"<% end if %>><%= wincnt38 %>/62<br></td>
		<td <% if wincnt39>=8 then %> bgcolor="red"<% end if %>><%= wincnt39 %>/8</td>
		<td <% if wincnt40>=37 then %> bgcolor="pink"<% end if %>><%= wincnt40 %>/37</td>
		<td <% if wincnt41>=8 then %> bgcolor="red"<% end if %>><%= wincnt41 %>/8</td>
		<td <% if wincnt42>=22 then %> bgcolor="red"<% end if %>><%= wincnt42 %>/22</td>
		<td <% if wincnt43>=1 then %> bgcolor="red"<% end if %>><%= wincnt43 %>/1</td>
		<td <% if wincnt44>=55 then %> bgcolor="red"<% end if %>><%= wincnt44 %>/55</td>
	</tr>
</table>
<br>

<!-- #include virtual="/lib/db/dbclose.asp" -->