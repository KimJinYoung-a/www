<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
	'// XML 형식임을 http header에 추가
	Response.AddHeader "Content-type","text/xml"
	Response.Write "<?xml version=""1.0"" encoding=""UTF-8"" ?>"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/enjoy/Just1DayCls.asp" -->
<%
'#######################################################
'	History	:  2008.07.09 허진원 생성
'	Description : Just One Day RSS Feed
'#######################################################

	'// 변수 선언
	dim oJustItem, JustDate
	JustDate = cStr(Date())

	'// 오늘의 상품 접수
	set oJustItem = New CJustOneDay
	oJustItem.FRectDate = JustDate
	oJustItem.GetJustOneDayItemInfo
%>
	<!--// RSS2.0 -->
	<rss version="2.0"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:dc="http://purl.org/dc/elements/1.1/"
		xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/" >
	<channel>
		<!--// 채널 시작 -->
			<title><![CDATA[텐바이텐 Just 1 Day 채널]]></title>
			<link>http://www.10x10.co.kr/Just1Day/</link>
			<description><![CDATA[텐바이텐 Just 1 Day RSS채널입니다. 하루에 한가지 특별 할인되는 상품 정보를 받아보세요.]]></description>
			<language>ko</language>
			<copyright>Copyright(c) (주)텐바이텐. All Rights Reserved.</copyright>
			<pubDate><%=RFC1123Date(now())%></pubDate>
			<webmaster>customer@10x10.co.kr</webmaster>
		<!--// 채널 끝 -->
		<!--// 아이템 시작 -->
<%
	if oJustItem.FResultCount>0 then
		JustDate = oJustItem.FItemList(0).FJustDate
%>
		<item>
		<title><![CDATA[<%= FormatDatetime(JustDate,1) & " - " & oJustItem.FItemList(0).FItemName %>]]></title>
		<link><%="http://www.10x10.co.kr/shopping/category_prd.asp?itemid=" & oJustItem.FItemList(0).FItemID %></link>
		<description><![CDATA[
			<table cellpadding=1 cellspacing=0 border=0>
			<tr>
				<td width=100><img src="<% = oJustItem.FItemList(0).Flistimage %>" width="100" height="100" border="0" style='border:solid 1pt #CCCCCC' align=left><td>
				<td valign="top">
					[<%=oJustItem.FItemList(0).FBrandName%>] <%=oJustItem.FItemList(0).FItemName%><br>
					<% if (oJustItem.FItemList(0).ForgPrice>oJustItem.FItemList(0).FsalePrice) then %>
						<font style="text-decoration:line-through"><%= FormatNumber(oJustItem.FItemList(0).ForgPrice,0) %>원</font>
						→ <%= FormatNumber(oJustItem.FItemList(0).FsalePrice,0) %>원 (<%=formatpercent(1-oJustItem.FItemList(0).FsalePrice/oJustItem.FItemList(0).ForgPrice,0)%>)<br>
					<% Else %>
						<%= FormatNumber(oJustItem.FItemList(0).ForgPrice,0) %>원<br>
					<% End If %>
				  	<%
			  			if oJustItem.FItemList(0).FLimityn="Y"  then
				  	%>
				  		<img src="http://fiximage.10x10.co.kr/shopping/limit_icon2.gif" width="22" height="11" border="0"><br>
				  	<%
			  			end if
				  	%>
				</td>
			</tr>
			</table>
		]]></description>
		<pubDate><%=RFC1123Date(JustDate)%></pubDate>
		</item>
<%
	end if
%>
		<!--// 아이템 끝 -->
	</channel>
	</rss>
<%
	set oJustItem = Nothing

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