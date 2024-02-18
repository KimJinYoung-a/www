<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 10원의 기적 관리자 페이지
' History : 2014.07.23 원승현 생성
' History : 2014.07.23 이종화 추가 - 상품 입력 및 회차 초기화 - 일별통계
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim eCode, subscriptcount, userid, evtTotalCnt, sqlStr
Dim returndate  : returndate = 	request("returndate")
Dim mainbannercnt
Dim kakaocnt
Dim utotcnt
Dim roundnum1_1 , roundnum1_2 , roundnum2_1 , roundnum2_2

If returndate = "" Then returndate = Date()

userid=getloginuserid()


If userid = "motions" or userid = "greenteenz" Or userid = "cogusdk" Then

Else

	response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
	response.End

End If


dim cEvent, cEventItem, arrItem, arrGroup, intI, intG, rdmNo
dim arrRecent, intR
dim bidx
dim ekind, emanager, escope, ename, esdate, eedate, estate, eregdate, epdate
dim ecategory, ecateMid, blnsale, blngift, blncoupon, blncomment, blnbbs, blnitemps, blnapply
dim etemplate, emimg, ehtml, eitemsort, ebrand,gimg,blnFull,blnItemifno,blnBlogURL, bimg, edispcate, vDisp, vIsWide, j
dim itemid : itemid = ""
dim egCode, itemlimitcnt,iTotCnt, strBrandListURL
dim cdl, cdm, cds
dim com_egCode : com_egCode = 0
Dim blnitempriceyn, clsEvt, isMyFavEvent, favCnt, vDateView

IF application("Svr_Info") = "Dev" THEN
	eCode 		= "21344" 
Else
	'eCode 		= "55527" '//10월
	eCode 		= "64636" '//2015/07
End If

'// 응모자 수

sqlstr = sqlstr & " select count(distinct userid)"
sqlstr = sqlstr & "	from db_temp.dbo.tbl_MiracleOf10Won_list "
sqlstr = sqlstr & "	where evt_code = '"& eCode &"' and convert(varchar(10),regdate,120) = '"&returndate&"' "
rsget.Open sqlstr, dbget, 1

If Not rsget.Eof Then
	utotcnt = rsget(0)
Else
	utotcnt = 0
End If
rsget.close

'// 응모회 수 회차별
sqlstr = " select "
sqlstr = sqlstr & "	isnull(sum(case when roundnum = '11' then 1 else 0 end ),0) as roundnum1_1 "
sqlstr = sqlstr & "	,isnull(sum(case when roundnum = '12' then 1 else 0 end ),0) as roundnum1_2 "
sqlstr = sqlstr & "	,isnull(sum(case when roundnum = '21' then 1 else 0 end ),0) as roundnum2_1 "
sqlstr = sqlstr & "	,isnull(sum(case when roundnum = '22' then 1 else 0 end ),0) as roundnum2_2 "
sqlstr = sqlstr & " from db_temp.dbo.tbl_MiracleOf10Won_list "
sqlstr = sqlstr & " where evt_code = '"& eCode &"' and convert(varchar(10),regdate,120) = '"&returndate&"' "
rsget.Open sqlstr, dbget, 1

If Not rsget.Eof Then
	roundnum1_1 = rsget(0)
	roundnum1_2 = rsget(1)
	roundnum2_1 = rsget(2)
	roundnum2_2 = rsget(3)
End IF
rsget.close

'// 메인배너 클릭수
sqlstr = "select count(*) "
sqlstr = sqlstr & " from [db_temp].[dbo].[tbl_event_click_log]"
sqlstr = sqlstr & " where eventid='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And chkid = 'app_Main' "
rsget.Open sqlstr, dbget, 1

If Not rsget.Eof Then
	mainbannercnt = rsget(0)
End IF
rsget.close

'// 카톡 초대 클릭수
sqlstr = "select count(*) "
sqlstr = sqlstr & " from [db_temp].[dbo].[tbl_event_click_log]"
sqlstr = sqlstr & " where eventid='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And chkid = 'kakao' "
rsget.Open sqlstr, dbget, 1

If Not rsget.Eof Then
	kakaocnt = rsget(0)
End IF
rsget.close

%>

<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.evt52979 {text-align:center;}
.evt52979 .bookCategory {position:relative; height:573px; background:url(http://webimage.10x10.co.kr/eventIMG/2014/52979/bg_tab.jpg) left top no-repeat;}
.evt52979 .bookCategory .bookTab {height:112px; padding-left:126px; background:url(http://webimage.10x10.co.kr/eventIMG/2014/52979/bg_tab_line.png) left top no-repeat;}
.evt52979 .bookCategory .bookTab li {float:left; width:110px; height:112px; margin-right:45px;}
.evt52979 .bookCategory .bookTab li a {display:block; width:100%; height:100%; text-indent:-9999px; background:url(http://webimage.10x10.co.kr/eventIMG/2014/52979/img_tab_off.png) left top no-repeat;}
.evt52979 .bookCategory .bookTab li.current a {background:url(http://webimage.10x10.co.kr/eventIMG/2014/52979/img_tab_on.png) left top no-repeat;}
.evt52979 .bookCategory .bookTab li.t01 a {background-position:-126px top;}
.evt52979 .bookCategory .bookTab li.t02 a {background-position:-283px top;}
.evt52979 .bookCategory .bookTab li.t03 a {background-position:-438px top;}
.evt52979 .bookCategory .bookTab li.t04 a {background-position:-594px top;}
.evt52979 .bookCategory .bookTab li.t05 a {background-position:-750px top;}
.evt52979 .bookCategory .bookTab li.t06 {width:130px;}
.evt52979 .bookCategory .bookTab li.t06 a {background-position:-896px top;}
.evt52979 .bookCategory .bookCont {padding-bottom:6px;}
.evt52979 .bookCategory .man {position:absolute; right:85px; bottom:86px;}
.evt52979 .putBook {height:840px; padding:50px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2014/52979/bg_pink.gif) left top no-repeat #ffd8d6;}
.evt52979 .putBook .tit {padding-bottom:7px;}
.evt52979 .putBook .myCategory {position:relative; overflow:hidden;}
.evt52979 .putBook .bag {position:relative; width:596px; height:660px; margin-left:281px; background:url(http://webimage.10x10.co.kr/eventIMG/2014/52979/bg_bag.jpg) left top no-repeat;}
.evt52979 .putBook .bag li {position:absolute; width:170px; height:170px;}
.evt52979 .putBook .bag li.b01 {left:113px; top:174px;}
.evt52979 .putBook .bag li.b02 {left:305px; top:174px;}
.evt52979 .putBook .bag li.b03 {left:203px; top:356px;}
.evt52979 .putBook .bag li .delete {display:block; position:absolute; left:73px; top:136px; width:24px; height:24px; text-indent:-9999px; cursor:pointer; background:url(http://webimage.10x10.co.kr/eventIMG/2014/52979/bg_delete.png) left top no-repeat;}
.evt52979 .putBook .bag li.ct01 .delete {background-position:left top;}
.evt52979 .putBook .bag li.ct02 .delete {background-position:-24px top;}
.evt52979 .putBook .bag li.ct03 .delete {background-position:-48px top;}
.evt52979 .putBook .bag li.ct04 .delete {background-position:-72px top;}
.evt52979 .putBook .bag li.ct05 .delete {background-position:-96px top;}
.evt52979 .putBook .bag li.ct06 .delete {background-position:-120px top;}
.evt52979 .putBook .selectBook ul {overflow:hidden;}
.evt52979 .putBook .selectBook li {position:absolute; cursor:pointer;}
.evt52979 .putBook .selectBook li.ct01 {left:82px; top:54px;}
.evt52979 .putBook .selectBook li.ct02 {left:82px; top:253px;}
.evt52979 .putBook .selectBook li.ct03 {left:82px; top:448px;}
.evt52979 .putBook .selectBook li.ct04 {right:75px; top:54px;}
.evt52979 .putBook .selectBook li.ct05 {right:75px; top:253px;}
.evt52979 .putBook .selectBook li.ct06 {right:75px; top:448px;}
.evt52979 .putBook .selectBook li .mask {position:absolute; left:0; top:0; width:170px; height:170px; background:url(http://webimage.10x10.co.kr/eventIMG/2014/52979/bg_book_mask.png) left top no-repeat;}
.evt52979 .count {padding:45px 0 55px; text-align:center; background:#fff;}
.evt52979 .count span {display:inline-block; font-size:50px; line-height:50px; padding-bottom:18px; color:#fa7373; border-bottom:3px solid #6a6a6a;}
.evt52979 .count span img {vertical-align:middle; padding-left:8px;}
.evt52979 .finish {position:relative; top:-8px;}
.evt52979 .evtNoti {overflow:hidden; padding:40px 0 40px 160px; text-align:left; background:#f2f2f2;}
.evt52979 .evtNoti dt {float:left; width:252px;}
.evt52979 .evtNoti dd {float:left;}
.evt52979 .evtNoti li {color:#8b8b8b; font-size:12px; line-height:13px; padding-bottom:9px;}

.table {width:85%; margin:0 auto; font-family:'malgun gothic'; border-collapse:collapse;}
.table th {padding:12px 0; font-size:13px; font-weight:bold;  color:#fff; background:#444;}
.table td {padding:12px 3px; font-size:12px; border:1px solid #ddd; border-bottom:2px solid #ddd;}
.table td.lt {text-align:left; padding:12px 10px;}
.tBtn {display:inline-block; border:1px solid #2b90b6; background:#03a0db; padding:0 10px 2px; line-height:26px; height:26px; font-weight:bold; border-radius:5px; color:#fff !important;}
.tBtn1 {display:inline-block; border:1px solid #ff0000; background:#ff0000; padding:0 10px 2px; line-height:26px; height:26px; font-weight:bold; border-radius:3px; color:#fff !important;}
.tBtn2 {display:inline-block; border:1px solid #00b0f0; background:#00b0f0; padding:0 10px 2px; line-height:26px; height:26px; font-weight:bold; border-radius:3px; color:#fff !important;}
.tBtn:hover {text-decoration:none;}
.tBtn:hover {text-decoration:none;}
.tBtn:hover {text-decoration:none;}
.table td input {border:1px solid #ddd; height:30px; padding:0 3px; font-size:14px; color:#ec0d02; text-align:right;}
</style>
<script type="text/javascript">
	function gowinnerProc(jidx)
	{
		var winerprice = eval(document.getElementById("winerprice"+jidx)).value;
		var wineruserid = eval(document.getElementById("wineruserid"+jidx)).value;
		winerprice = winerprice.replace(",","");

		document.frm.winnerprice.value = winerprice;
		document.frm.winneruserid.value = wineruserid;
		document.frm.idx.value = jidx;
		document.frm.mode.value = "modify";


		if (document.frm.winnerprice.value=="")
		{
			alert("당첨금액을 입력해주세요");
			return;
		}
		else if (document.frm.winneruserid.value=="")
		{
			alert("당첨자 아이디를 입력해주세요");
			return;
		}
		else
		{
			document.frm.submit();
		}

	}
	
	//상품 초기화
	function clearevt(){
		if(confirm('※주의※ 모든상품이 삭제 됩니다\n상품을 초기화 하시겠습니까?')) {
			document.frm.mode.value = "clear";
			document.frm.submit();
		}
	}

	//상품 입력
	function insertprd(v){
		
	  var popwin = window.open('10won_insertitem.asp?idx='+v,'10woninsert','width=900,height=500,scrollbars=yes,resizable=yes');
	  popwin.focus();

	}

</script>
</head>
<body>
<p>&nbsp;</p>
<p>&nbsp;</p>

	<table class="table" style="width:90%;">
	<colgroup>
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th colspan="5"><strong>날짜</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td><a href="?returndate=2015-07-13">2015-07-13 (월)</a></td>
		<td><a href="?returndate=2015-07-14">2015-07-14 (화)</a></td>
		<td><a href="?returndate=2015-07-15">2015-07-15 (수)</a></td>
		<td><a href="?returndate=2015-07-16">2015-07-16 (목)</a></td>
		<td><a href="?returndate=2015-07-17">2015-07-17 (금)</a></td>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td><a href="?returndate=2015-07-20">2015-07-20 (월)</a></td>
		<td><a href="?returndate=2015-07-21">2015-07-21 (화)</a></td>
		<td><a href="?returndate=2015-07-22">2015-07-22 (수)</a></td>
		<td></td>
		<td></td>
	</tr>
	</table>
	<table class="table" style="width:90%;">

	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr>
		<Td colspan="8" style="text-align:center">기준일 : <%=returndate%></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>1라운드 1회</strong></th>
		<th><strong>1라운드 2회</strong></th>
		<th><strong>2라운드 1회</strong></th>
		<th><strong>2라운드 2회</strong></th>
		<th><strong>전면배너클릭</strong></th>
		<th><strong>카카오클릭</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= utotcnt %></td>
		<td bgcolor=""><%= roundnum1_1%></td>
		<td bgcolor=""><%= roundnum1_2%></td>
		<td bgcolor=""><%= roundnum2_1%></td>
		<td bgcolor=""><%= roundnum2_2%></td>
		<td bgcolor=""><%= mainbannercnt %></td>
		<td bgcolor=""><%= kakaocnt %></td>
	</tr>
</table>

	<br/>
	<br/>
	<table style="margin:0 auto;text-align:center;width:85%">
	<tr>
		<td colspan="2"><strong><span style="font-size:15pt">-최저가왕 (구)10원의 행복- 관리 페이지</span></strong></td>
	</tr>
	<tr>
		<td align="left"><input type="button" value="초기화하기" onclick="clearevt();" class="tBtn1">&nbsp;&nbsp;<strong><span style="color:red">&lt;--&nbsp;&nbsp;이벤트 최초 1번만 실행 해주세요</span></strong></td>
		<td align="right"><strong><span style="color:blue">상품추가입력&nbsp;&nbsp;--&gt;<span></strong><input type="button" value="상품입력" onclick="insertprd('');" class="tBtn2"></td>
	</tr>
	</table>
	<table class="table">
		<colgroup>
			<col width="7%" />
			<col width="8%" />
			<col width="7%" />
			<col width="*" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
		</colgroup>
		<tr align="center" bgcolor="#E6E6E6" height="20">
			<th><strong>경매시작</strong></th>
			<th><strong>경매종료</strong></th>
			<th><strong>상품코드</strong></th>
			<th><strong>상품명</strong></th>
			<th><strong>상품가격</strong></th>
			<th><strong>최저 경매가격</strong></th>
			<th><strong>최고 경매가격</strong></th>
			<th><strong>현시점최저가</strong></th>
			<th><strong>당첨금액</strong></th>
			<th><strong>당첨자아이디</strong></th>
			<th><strong>라운드</strong></th>
			<th><strong>기타</strong></th>
		</tr>
		<%
			sqlStr = "	Select * From (Select A.idx, A.sdate, A.edate, A.productCode, A.productName "&_
					" 	, A.productPrice, A.auctionMinPrice, A.auctionMaxPrice, A.winnerprice, A.winneruserid,  "&_
					" 	(  "&_
					" 		Select top 1 lprice From  "&_
					" 		(  "&_
					" 			Select lprice, count(userid) as cnt "&_
					" 			From db_temp.dbo.tbl_miracleof10won_list  "&_
					" 			Where evt_code= '"& ecode &"' And prizecode=A.idx group by lprice  "&_
					" 		)T Where cnt=1 order by lprice asc "&_
					" 	) as LowPrice , A.roundnum "&_
					" 	From db_temp.dbo.tbl_miracleof10won A where A.isusing = 'Y') T "
			rsget.Open sqlStr,dbget,1
			if Not(rsget.EOF or rsget.BOF) Then
				Do Until rsget.eof
		%>
		<tr bgcolor="<%=chkiif(CStr(Date())=CStr(Left(rsget("sdate"),10)),"#FFFF29","#FFFFFF")%>" align="center">
			<td><a href="#" onclick="insertprd('<%=rsget("idx")%>');"><%=rsget("sdate")%></a></td>
			<td><%=rsget("edate")%></td>
			<td><%=rsget("productCode")%></td>
			<td class="lt"><a href="10won_list.asp?idx=<%=rsget("idx")%>&minPrc=<%=rsget("LowPrice")%>" target="_blank"><%=rsget("productName")%></a></td>
			<td><%=FormatNumber(rsget("productPrice"),0)%>원</td>
			<td><%=FormatNumber(rsget("auctionMinPrice"),0)%>원</td>
			<td><%=FormatNumber(rsget("auctionMaxPrice"),0)%>원</td>
			<td><% If rsget("LowPrice")="" Or IsNull(rsget("LowPrice"))  Then response.write "" Else response.write FormatNumber(rsget("LowPrice"),0)&"원" End If%></td>
			<td><input type="text" name="winnerprice" id="winerprice<%=rsget("idx")%>" value="<% If rsget("winnerprice")<>"" Then response.write FormatNumber(rsget("winnerprice"), 0) End If %>" size="10"></td>
			<td><input type="text" name="winneruserid" id="wineruserid<%=rsget("idx")%>" value="<% If rsget("winneruserid")<>"" Then response.write rsget("winneruserid") End If %>" size="10"></td>
			<td><%=rsget("roundnum")%>라운드</td>
			<td><!--a href="#" onclick="window.open('10won_list.asp?idx=<%=rsget("idx")%>','','width=1100, height=700, toolbar=no, scrollbars=yes');" class="tBtn:hover">리스트</a--><a href="#" onclick="gowinnerProc('<%=rsget("idx")%>')" class="tBtn">당첨</a></td>
		</tr>

		<%
				rsget.movenext
				Loop
			End If
			rsget.close
		%>
	</table>
<form name="frm" id="frm" action="10won_management_proc.asp" method="post">
	<input type="hidden" name="mode">
	<input type="hidden" name="idx">
	<input type="hidden" name="winnerprice">
	<input type="hidden" name="winneruserid">
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->