<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%

userid = getloginuserid()

If userid = "motions" or userid = "greenteenz" Or userid = "cogusdk" Then

Else

	response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
	response.End

End If

dim sqlstr, i, userid, contentstext, titletext, mode, idx, winnerprice, winneruserid
Dim sdate, edate, productCode, productName, productPrice, auctionMinPrice, auctionMaxPrice , productBigImg , productSmallImg
Dim sviewdate , eviewdate , roundnum

	idx = request("idx")
	winnerprice = request("winnerprice")
	winneruserid = request("winneruserid")
	mode = request("mode")

	sdate			= request("sdate")
	edate			= request("edate")
	sviewdate		= request("sviewdate")
	eviewdate		= request("eviewdate")
	productCode		= request("itemid")
	productName		= request("itemname")
	productBigImg	= request("bigimg")
	productSmallImg	= request("smallimg")
	productPrice	= request("prdprice")
	auctionMinPrice	= request("minPrice")
	auctionMaxPrice	= request("maxPrice")
	roundnum		= request("roundnum")


'	response.write idx&"<br>"&winnerprice&"<br>"&winneruserid
'	response.End

'	Response.write idx &"<br>"
'	Response.write dateconvert(sdate) &"<br>"
'	Response.write mode &"<br>"
'	Response.write edate &"<br>"
'	Response.write productCode &"<br>"
'	Response.write productName &"<br>"
'	Response.write productBigImg &"<br>" 
'	Response.write productSmallImg &"<br>"
'	Response.write productPrice &"<br>"
'	Response.write auctionMinPrice &"<br>"
'	Response.write auctionMaxPrice &"<br>" 
'	Response.write eviewdate &"<br>" 
'	Response.end

If mode = "modify" Then '// 당첨 입력

	sqlstr = " update db_temp.dbo.tbl_miracleof10won set winnerPrice='"&winnerprice&"', winneruserid='"&winneruserid&"' Where idx='"&idx&"' "
	'response.write sqlstr
	dbget.execute sqlstr
	
	Response.write "<script>alert('수정되었습니다.');</script>"
	Response.write "<script>parent.location.href='10won_management.asp';</script>"
	response.End
	
ElseIf mode = "clear" Then '//1회실행 경매 초기화

	sqlstr = " update db_temp.dbo.tbl_miracleof10won set isusing = 'N' "
	dbget.execute sqlstr

	Response.write "<script>alert('모든상품이 초기화 되었습니다.');</script>"
	Response.write "<script>parent.location.href='10won_management.asp';</script>"
	response.End

ElseIf mode = "insert" Then '//상품 등록

	sqlstr = " insert into "
	sqlstr = sqlstr & " db_temp.dbo.tbl_miracleof10won "
	sqlstr = sqlstr & " (sdate,edate,sviewdate,eviewdate,productCode,productName,productBigImg,productSmallImg,productPrice,auctionMinPrice,auctionMaxPrice,regdate , roundnum) "
	sqlstr = sqlstr & "  values "
	sqlstr = sqlstr & " ('"&sdate&"','"&edate&"','"&sviewdate&"','"&eviewdate&"','"&productCode&"','"&productName&"','"&productBigImg&"','"&productSmallImg&"','"&Replace(productPrice,",","")&"','"&Replace(auctionMinPrice,",","")&"','"&Replace(auctionMaxPrice,",","")&"',getdate(), '"& roundnum &"') "
'	response.write sqlstr
'	Response.end
	dbget.execute sqlstr

	Response.write "<script>alert('상품등록 완료!');</script>"
	Response.write "<script>opener.location.reload();self.close();</script>"
	response.End


ElseIf mode = "update" Then '//상품 수정

	sqlstr = " update db_temp.dbo.tbl_miracleof10won set "
	sqlstr = sqlstr & " sdate = '"&dateconvert(sdate)&"' "
	sqlstr = sqlstr & " ,edate = '"&dateconvert(edate)&"'"
	sqlstr = sqlstr & " ,sviewdate = '"& dateconvert(sviewdate) &"'"
	sqlstr = sqlstr & " ,eviewdate = '"& dateconvert(eviewdate) &"'"
	sqlstr = sqlstr & " ,productCode = '"&productCode&"' "
	sqlstr = sqlstr & " ,productName = '"&productName&"' "
	sqlstr = sqlstr & " ,productBigImg = '"&productBigImg&"' "
	sqlstr = sqlstr & " ,productSmallImg = '"&productSmallImg&"' "
	sqlstr = sqlstr & " ,productPrice = '"&Replace(productPrice,",","")&"' "
	sqlstr = sqlstr & " ,auctionMinPrice = '"&Replace(auctionMinPrice,",","")&"' "
	sqlstr = sqlstr & " ,auctionMaxPrice = '"&Replace(auctionMaxPrice,",","")&"' "
	sqlstr = sqlstr & " ,roundnum = '"& roundnum &"' "
	sqlstr = sqlstr & " where idx = '"& idx &"' "
	
'	Response.write sqlstr
'	Response.end
	
	dbget.execute sqlstr

	Response.write "<script>alert('상품수정 완료!');</script>"
	Response.write "<script>opener.location.reload();self.close();</script>"
	response.End

End If 
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->