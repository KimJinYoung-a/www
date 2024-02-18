<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 10원의 기적 관리자 페이지(참여자 리스트)
' History : 2014.07.23 원승현 생성
' History : 2015-07-08 이종화 추가 전화번호 검색
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->

<%
dim eCode, subscriptcount, userid, evtTotalCnt, sqlStr

IF application("Svr_Info") = "Dev" THEN
	eCode 		= "64819" 
Else
	'eCode 		= "55527" 
	eCode 		= "64636" '//2015/07
End If


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
Dim blnitempriceyn, clsEvt, isMyFavEvent, favCnt, vDateView, vidx
dim minPrc, sUid , sUcell

	vidx = request("idx")
	minPrc = getNumeric(request("minPrc"))
	sUid = request("searchuid")
	sUcell = Trim(request("ucell"))
	if minPrc="" then minPrc="0"


'/// 카운팅
dim vTotalCnt, vUserCnt
sqlStr = " Select count(*) tt, count(distinct userid) ucnt "&_
		" From db_temp.dbo.tbl_MiracleOf10Won_list "&_
		" Where evt_code = "& eCode &" And prizecode='"&vidx&"' "
rsget.Open sqlStr,dbget,1
	vTotalCnt = rsget("tt")
	vUserCnt = rsget("ucnt")
rsget.Close
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

.table {width:95%; margin:0 auto; font-family:'malgun gothic'; border-collapse:collapse;}
.table th {padding:12px 0; font-size:13px; font-weight:bold;  color:#fff; background:#444;}
.table td {padding:12px 3px; font-size:12px; border:1px solid #ddd; border-bottom:2px solid #ddd;}
.table td.lt {text-align:left; padding:12px 10px;}
.tBtn {display:inline-block; border:1px solid #2b90b6; background:#03a0db; padding:0 10px 2px; line-height:26px; height:26px; font-weight:bold; border-radius:5px; color:#fff !important;}
.tBtn:hover {text-decoration:none;}
.table td input {border:1px solid #ddd; height:30px; padding:0 3px; font-size:14px; color:#ec0d02; text-align:right;}
</style>
</head>
<body>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
	<table class="table" id="listTable">
		<colgroup>
			<col width="3%" />
			<col width="8%" />
			<col width="8%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="10%" />
		</colgroup>
		<tr>
			<td colspan="2" style="border-right:1px solid #FFFFFF;">
				<b><%=FormatNumber(vTotalCnt,0)%></b>건 / <b><%=FormatNumber(vUserCnt,0)%></b>명 응모
			</td>
			<td colspan="5" align="right">
				<form name="frm" method="get" action="10won_list.asp">
				<input type="hidden" name="idx" value="<%=vidx%>">
				전화번호 : <input type="text" name="ucell" value="<%=sUcell%>" size="20"> /
				회원ID : <input type="text" name="searchuid" value="<%=sUid%>" size="10"> /
				최저가격 : <input type="text" name="minPrc" value="<%=minPrc%>" size="8">원 이상 &nbsp;
				<input type="submit" value=" 검색 ">
				</form>
			</td>
		</tr>
		<tr align="center" bgcolor="#E6E6E6" height="30">
			<th><strong>번호</strong></th>
			<th><strong>상품명</strong></th>
			<th><strong>아이디</strong></th>
			<th><strong>전화번호</strong></th>
			<th><strong>회원레벨</strong></th>
			<th><strong>입력가격</strong></th>
			<th><strong>회차</strong></th>
		</tr>
		<%

			Dim num
			num = 1
			sqlStr = "	Select top 100 prizename, userid, usercell, "&_
					"	case when userlevel=5 then 'ORANGE' when userlevel=0 then 'YELLOW'  "&_
					"	when userlevel=1 then 'GREEN' when userlevel=2 then 'BLUE' "&_
					"	when userlevel=3 then 'VIP SILVER' when userlevel=4 then 'VIP GOLD'  "&_
					"	when userlevel=7 then 'STAFF' when userlevel=6 then 'FRIENDS'  "&_
					"	when userlevel=8 then 'FAMILY' when userlevel=9 then 'MANIA'  "&_
					"	else 'ORANGE' end as level, "&_
					"	lprice , "&_
					"	case when roundnum = 11 or roundnum = 21 then '1회차' "&_
					"		when roundnum = 12 or roundnum = 22 then '2회차' "&_
					"	end as roundnum "&_
					"	From db_temp.dbo.tbl_miracleof10won_list A  "&_
					"	Where evt_code = '"& eCode &"' And prizecode = '"&vidx&"' "
				if minPrc>0 then
					sqlStr = sqlStr & " and lprice >=" & minPrc & " "
				end if
				if sUid<>"" then
					sqlStr = sqlStr & " and userid='" & sUid & "' "
				end If
				If sUcell <> "" Then
					sqlStr = sqlStr & " and usercell='" & sUcell & "' "
				End If 
				sqlStr = sqlStr & " order by lprice asc "
			'Response.write sqlStr
			rsget.Open sqlStr,dbget,1
			if Not(rsget.EOF or rsget.BOF) Then
				Do Until rsget.eof
		%>
		<tr bgcolor="#FFFFFF" align="center">
			<td><%=num%></td>
			<td class="lt"><%=rsget("prizename")%></td>
			<td><%=rsget("userid")%></td>
			<td><%=rsget("usercell")%></td>
			<td><%=rsget("level")%></td>
			<td><%=rsget("lprice")%></td>
			<td><%=rsget("roundnum")%></td>
		</tr>
		<%
				rsget.movenext
				num = num + 1
				Loop
			End If
			rsget.close
		%>
	</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->