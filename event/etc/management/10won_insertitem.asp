<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 10원의 기적 관리자 페이지
' History : 2014.07.23 이종화 추가 - 상품 입력
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->

<%
dim eCode, subscriptcount, userid, evtTotalCnt, sqlStr

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
Dim mode , roundnum


IF application("Svr_Info") = "Dev" THEN
	'eCode 		= "21279" '7월
	'eCode 		= "21342" '10월
	eCode 		= "64819" '2015/07
Else
	'eCode 		= "53592" '7월
	'eCode 		= "55525" '10월
	eCode 		= "64636" '//2015/07
End If

bidx = request("idx")

If bidx = "" Then 
	mode = "insert"
Else
	mode = "update"
End If 

Dim addsqlstr
Dim sdate , edate ,sviewdate ,eviewdate , productCode ,productName ,productPrice ,auctionMinPrice ,auctionMaxPrice , bigimg , smallimg

If mode = "update" Then
	addsqlstr = " and A.idx = "& bidx

	sqlStr = " Select top 1 A.idx, A.sdate, A.edate, A.sviewdate , A.eviewdate , A.productCode, A.productName, A.productPrice, A.auctionMinPrice, A.auctionMaxPrice , A.productBigImg , A.productSmallImg , A.roundnum "&_
			" From db_temp.dbo.tbl_miracleof10won A where A.isusing = 'Y'" & addsqlstr
	rsget.Open sqlStr,dbget,1
		if Not(rsget.EOF or rsget.BOF) Then
		 sdate				= rsget("sdate")
		 edate				= rsget("edate")
		 sviewdate			= rsget("sviewdate")
		 eviewdate			= rsget("eviewdate")
		 productCode		= rsget("productCode")
		 productName		= rsget("productName")
		 productPrice		= rsget("productPrice")
		 auctionMinPrice	= rsget("auctionMinPrice")
		 auctionMaxPrice	= rsget("auctionMaxPrice")
		 bigimg				= rsget("productBigImg")
		 smallimg			= rsget("productSmallImg")
		 roundnum			= rsget("roundnum")
		End If
	rsget.close
End If 
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.table {width:95%; margin:0 auto; font-family:'malgun gothic'; border-collapse:collapse;}
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
	function checkform()
	{
		if (document.frm.sdate.value=="")
		{
			alert("경매시작일을 입력해주세요");
			document.frm.sdate.focus();
			return;
		}

		if (document.frm.edate.value=="")
		{
			alert("경매종료일을 입력해주세요");
			document.frm.sdate.focus();
			return;
		}

		if (document.frm.sviewdate.value=="")
		{
			alert("노출시작일을 입력해주세요");
			document.frm.sviewdate.focus();
			return;
		}

		if (document.frm.eviewdate.value=="")
		{
			alert("노출종료일을 입력해주세요");
			document.frm.eviewdate.focus();
			return;
		}

//		if (document.frm.itemid.value=="")
//		{
//			alert("상품코드를 입력해주세요");
//			document.frm.itemid.focus();
//			return;
//		}

		if (document.frm.itemname.value=="")
		{
			alert("상품명을 입력해주세요");
			document.frm.itemname.focus();
			return;
		}

//		if (document.frm.bigimg.value=="")
//		{
//			alert("큰이미지를 입력해주세요");
//			document.frm.bigimg.focus();
//			return;
//		}

//		if (document.frm.smallimg.value=="")
//		{
//			alert("작은이미지를 입력해주세요");
//			document.frm.smallimg.focus();
//			return;
//		}

		if (document.frm.prdprice.value=="")
		{
			alert("상품가격을 입력해주세요");
			document.frm.prdprice.focus();
			return;
		}

		if (document.frm.minPrice.value=="")
		{
			alert("최저 경매가격을 입력해주세요");
			document.frm.minPrice.focus();
			return;
		}

		if (document.frm.maxPrice.value=="")
		{
			alert("최고 경매가격을 입력해주세요");
			document.frm.maxPrice.focus();
			return;
		}

		<% if bidx = "" then %>
		document.frm.mode.value = "insert";	
		<% else %>
		document.frm.mode.value = "update";	
		<% end if %>
		document.frm.submit();
	}
</script>
</head>
<body>
<p>&nbsp;</p>
<p>&nbsp;</p>

	<table style="margin:0 auto;text-align:center;width:85%">
	<tr>
		<td colspan="2"><strong><span style="font-size:15pt">-10원의 행복 상품 입력-</span></strong></td>
	</tr>
	</table>
	<form name="frm" id="frm" action="10won_management_proc.asp" method="post">
	<input type="hidden" name="mode">
	<input type="hidden" name="idx" value="<%=bidx%>">
	<table class="table">
		<colgroup>
			<col width="17%" />
			<col width="17%" />
			<col width="17%" />
			<col width="17%" />
		</colgroup>
		<tr align="center" bgcolor="#E6E6E6" height="20">
			<th><strong>경매시작</strong></th>
			<th><strong>경매종료</strong></th>
			<th><strong>노출시작</strong></th>
			<th><strong>노출종료</strong></th>
		</td>
		<tr bgcolor="#FFFFFF" align="center">
			<td><input type="text" name="sdate" value="<%=dateconvert(sdate)%>" size="25"/></td>
			<td><input type="text" name="edate" value="<%=dateconvert(edate)%>" size="25"/></td>
			<td><input type="text" name="sviewdate" value="<%=dateconvert(sviewdate)%>" size="25"/></td>
			<td><input type="text" name="eviewdate" value="<%=dateconvert(eviewdate)%>" size="25"/></td>
		</tr>

		<tr align="center" bgcolor="#E6E6E6" height="20">
			<th><strong>상품코드</strong></th>
			<th><strong>상품명</strong></th>
			<th><strong>큰 이미지</strong></th>
			<th><strong>작은 이미지</strong></th>
		</td>

		<tr bgcolor="#FFFFFF" align="center">
			<td><input type="text" name="itemid" value="<%=productCode%>" size="10"/></td>
			<td><input type="text" name="itemname" value="<%=productName%>" size="20"/></td>
			<td><input type="text" name="bigimg" value="<%=bigimg%>" size="20"/></td>
			<td><input type="text" name="smallimg" value="<%=smallimg%>" size="20"/></td>
		</tr>

		<tr align="center" bgcolor="#E6E6E6" height="20">
			<th><strong>상품가격</strong></th>
			<th><strong>최저 경매가격</strong></th>
			<th><strong>최고 경매가격</strong></th>
			<th><strong>라운드</strong></th>
		</tr>

		<tr bgcolor="#FFFFFF" align="center">
			<td><input type="text" name="prdprice" value="<%=FormatNumber(productPrice,0)%>" size="8"/></td>
			<td><input type="text" name="minPrice" value="<%=FormatNumber(auctionMinPrice,0)%>" size="8"/></td>
			<td><input type="text" name="maxPrice" value="<%=FormatNumber(auctionMaxPrice,0)%>" size="8"/></td>
			<td><input type="text" name="roundnum" value="<%=roundnum%>" size="8"/></td>
		</tr>
	</table>
	<table style="margin:0 auto;text-align:center;width:95%;">
		<tr>
			<td><input type="button" value="취소" onclick="self.close();" class="tBtn1">&nbsp;&nbsp;<input type="button" value="상품입력" class="tBtn2" onclick="checkform();return false;"></td>
		</tr>
	</table>
	</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->