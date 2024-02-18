<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
	'// XML 형식임을 http header에 추가
	Response.AddHeader "Content-type","text/xml"
	Response.Write "<?xml version=""1.0"" encoding=""UTF-8"" ?>"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<%
	'// 변수 선언
	dim vDisp
	dim searchFlag 	: searchFlag = "newitem"
	vDisp = getNumeric(RequestCheckVar(Request("disp"),3))

	dim oDoc,iLp
	set oDoc = new SearchItemCls
	oDoc.FListDiv = "newlist"
	'oDoc.FListDiv = "list"
	oDoc.FRectSearchItemDiv = "y"		'기본카테고리만
	oDoc.FRectSearchCateDep = "T"		'하위카테고리 모두 검색
	oDoc.FRectSearchFlag = searchFlag
	oDoc.FSellScope="Y"
	oDoc.FRectCateCode = vDisp
	oDoc.FPageSize 	= 50

	oDoc.getSearchList
%>
	<!--// RSS2.0 -->
	<rss version="2.0"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:dc="http://purl.org/dc/elements/1.1/"
		xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/" >
	<channel>
		<!--// 채널 시작 -->
			<title><![CDATA[텐바이텐 신상품 채널]]></title>
			<link>http://www.10x10.co.kr/shoppingtoday/shoppingchance_newitem.asp</link>
			<description><![CDATA[텐바이텐 신상품 RSS채널입니다. 남보다 쉽고 빠르게 신상품 정보를 받아보세요.]]></description>
			<language>ko</language>
			<copyright>Copyright(c) (주)텐바이텐. All Rights Reserved.</copyright>
			<pubDate><%=RFC1123Date(now())%></pubDate>
			<webmaster>customer@10x10.co.kr</webmaster>
		<!--// 채널 끝 -->
		<!--// 아이템 시작 -->
<%
	If oDoc.FResultCount > 0 then
		for iLp=0 to oDoc.FResultCount-1
%>
		<item>
		<category><![CDATA[<%=CategoryNameUseLeftMenu(left(oDoc.FItemList(iLp).FcateCode,3))%>]]></category>
		<title><![CDATA[<%=oDoc.FItemList(iLp).FItemName%>]]></title>
		<link><%="http://www.10x10.co.kr/shopping/category_prd.asp?itemid=" & oDoc.FItemList(iLp).FItemID %></link>
		<description><![CDATA[
			<table cellpadding=1 cellspacing=0 border=0>
			<tr>
				<td width=100><img src="<% = oDoc.FItemList(iLp).FImageList %>" width="100" height="100" border="0" style='border:solid 1pt #CCCCCC' align=left><td>
				<td valign="top">
					[<%=oDoc.FItemList(iLp).FBrandName%>] <%=oDoc.FItemList(iLp).FItemName%><br>
					<% if oDoc.FItemList(iLp).IsSaleItem then %>
						<font style="text-decoration:line-through"><%= FormatNumber(oDoc.FItemList(iLp).getOrgPrice,0) %> won</font>(<% = oDoc.FItemList(iLp).getSalePro %>)
						→ <%= FormatNumber(oDoc.FItemList(iLp).getRealPrice,0) %> won<br>
					<% Else %>
						<%= FormatNumber(oDoc.FItemList(iLp).getRealPrice,0) %> won<br>
					<% End If %>
				  	<%
				  		If Not (oDoc.FItemList(iLp).IsSoldOut) Then
				  			if oDoc.FItemList(iLp).IsSaleItem then
				  	%>
						<img src="http://fiximage.10x10.co.kr/web2009/common/icon_sale.gif" width="26" height="11" border="0"><br>
					<%
							end if
							if oDoc.FItemList(iLp).Fitemcouponyn="Y" then
					%>
						<img src="http://fiximage.10x10.co.kr/web2009/common/icon_coupon.gif" width="26" height="11" border="0"><br>
					<%
							end if
						end if
						If oDoc.FItemList(iLp).IsSoldOut Then
					%>
				  		<img src="http://fiximage.10x10.co.kr/web2009/common/icon_soldout.gif" width="26" height="11" border="0"><br>
				  	<%
				  		else
				  			if oDoc.FItemList(iLp).FLimityn="Y"  then
				  	%>
				  		<img src="http://fiximage.10x10.co.kr/web2009/common/icon_limit.gif" width="26" height="11" border="0"><br>
				  	<%
				  			end if
				  		end if
				  	%>
				</td>
			</tr>
			</table>
		]]></description>
		<pubDate><%=RFC1123Date(oDoc.FItemList(iLp).FRegdate)%></pubDate>
		</item>
<%
		Next
	end if
%>
		<!--// 아이템 끝 -->
	</channel>
	</rss>
<%
	set oDoc = Nothing

	'// GMT 표준시 표기법으로 변환
	Function RFC1123Date(dateSpec)
		Dim astrDay
		Dim astrNum
		Dim astrMonth

		astrDay = Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
		astrNum = Array( "00", _
		"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", _
		"11", "12", "13", "14", "15", "16", "17", "18", "19", "20", _
		"21", "22", "23", "24", "25", "26", "27", "28", "29", "30", _
		"31", "32", "33", "34", "35", "36", "37", "38", "39", "40", _
		"41", "42", "43", "44", "45", "46", "47", "48", "49", "50", _
		"51", "52", "53", "54", "55", "56", "57", "58", "59", "60")
		astrMonth = Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", _
		"Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
		RFC1123Date = astrDay(WeekDay(dateSpec) - 1) & ", " & astrNum(Day(dateSpec)) _
		& " " & astrMonth(Month(dateSpec) - 1) & " " & Year(dateSpec) _
		& " " & astrNum(Hour(dateSpec)) & ":" & astrNum(Minute(dateSpec)) _
		& ":" & astrNum(Second(dateSpec)) & " +0900"
	End Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->