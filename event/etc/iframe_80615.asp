<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'배너는 상품배너인데 링크는 이벤트로...

Dim renloop, itemimg, itemcode, itemname, ecode
dim currdate, enddate, ddaydate
currdate = date()

randomize
renloop=int(Rnd*5)+1

'response.write renloop

if renloop = "1" then
	if currdate < "2017-10-19" then
		itemimg = "http://webimage.10x10.co.kr/image/List/156/L001562806.jpg"
		itemcode = "1562806"
		itemname = "이메텍 전기요"
		ecode = "80618"
	elseif currdate >= "2017-10-19" and currdate < "2017-10-26" then
		itemimg = "http://webimage.10x10.co.kr/image/List/166/L001665813.jpg"
		itemcode = "1665813"
		itemname = "클레어링 공기청정기"
		ecode = "80618"
	elseif currdate >= "2017-10-26" and currdate < "2017-11-02" then
		itemimg = "http://webimage.10x10.co.kr/image/List/157/L001579689.jpg"
		itemcode = "1579689"
		itemname = "빈티지코튼 테이블매트"
		ecode = "80618"
	else
		itemimg = ""
		itemcode = ""
		itemname = ""
		ecode = ""
	end if
elseif renloop = "2" then
	if currdate < "2017-10-19" then
		itemimg = "http://webimage.10x10.co.kr/image/List/175/L001757631.jpg"
		itemcode = "1757631"
		itemname = "다이슨 v6 코드프리 프로"
		ecode = "80618"
	elseif currdate >= "2017-10-19" and currdate < "2017-10-26" then
		itemimg = "http://webimage.10x10.co.kr/image/List/178/L001787590.jpg"
		itemcode = "1787590"
		itemname = "철제 책장3단 800"
		ecode = "80618"
	elseif currdate >= "2017-10-26" and currdate < "2017-11-02" then
		itemimg = "http://webimage.10x10.co.kr/image/List/156/L001562807.jpg"
		itemcode = "1562807"
		itemname = "이메텍 전기요 2017년형"
		ecode = "80618"
	else
		itemimg = ""
		itemcode = ""
		itemname = ""
		ecode = ""
	end if
elseif renloop = "3" then
	if currdate < "2017-10-19" then
		itemimg = "http://webimage.10x10.co.kr/image/List/126/L001260092-9.jpg"
		itemcode = "1260092"
		itemname = "캔빌리지 원형수납장"
		ecode = "80618"
	elseif currdate >= "2017-10-19" and currdate < "2017-10-26" then
		itemimg = "http://webimage.10x10.co.kr/image/List/160/L001603439.jpg"
		itemcode = "1603439"
		itemname = "목화 윈터 디퓨저"
		ecode = "80618"
	elseif currdate >= "2017-10-26" and currdate < "2017-11-02" then
		itemimg = "http://webimage.10x10.co.kr/image/List/181/L001812399.jpg"
		itemcode = "1812399"
		itemname = "두닷모노 1500 전신거울"
		ecode = "80618"
	else
		itemimg = ""
		itemcode = ""
		itemname = ""
		ecode = ""
	end if
elseif renloop = "4" then
	if currdate < "2017-10-19" then
		itemimg = "http://webimage.10x10.co.kr/image/List/155/L001557519.jpg"
		itemcode = "1557519"
		itemname = "무아스 미니 LED 클락"
		ecode = "80618"
	elseif currdate >= "2017-10-19" and currdate < "2017-10-26" then
		itemimg = "http://webimage.10x10.co.kr/image/List/131/L001311289-1.jpg"
		itemcode = "1311289"
		itemname = "사계절 롱티팟 1200ml"
		ecode = "80618"
	elseif currdate >= "2017-10-26" and currdate < "2017-11-02" then
		itemimg = "http://webimage.10x10.co.kr/image/List/178/L001782462.jpg"
		itemcode = "1782462"
		itemname = "푸링 LED램프 1+1"
		ecode = "80618"
	else
		itemimg = ""
		itemcode = ""
		itemname = ""
		ecode = ""
	end if
elseif renloop = "5" then
	if currdate < "2017-10-19" then
		itemimg = "http://webimage.10x10.co.kr/image/List/171/L001715454.jpg"
		itemcode = "1715454"
		itemname = "실리콘 냄비받침 5종"
		ecode = "80618"
	elseif currdate >= "2017-10-19" and currdate < "2017-10-26" then
		itemimg = "http://webimage.10x10.co.kr/image/List/172/L001722666.jpg"
		itemcode = "1722666"
		itemname = "파벡스 온도계 전기주전자 커피포트"
		ecode = "80618"
	elseif currdate >= "2017-10-26" and currdate < "2017-11-02" then
		itemimg = "http://webimage.10x10.co.kr/image/List/25/L000256712-3.jpg"
		itemcode = "256712"
		itemname = "갤러리프레임 10P세트"
		ecode = "80618"
	else
		itemimg = ""
		itemcode = ""
		itemname = ""
		ecode = ""
	end if
else
	itemimg = "http://webimage.10x10.co.kr/image/List/156/L001562806.jpg"
	itemcode = "1562806"
	itemname = "이메텍 전기요"
	ecode = "80618"
end if

if itemimg = "" then itemimg = "http://webimage.10x10.co.kr/image/List/156/L001562806.jpg"
if itemcode = "" then itemcode = "1562806"
if itemname = "" then itemname = "이메텍 전기요"
if ecode = "" then ecode = "80618"

if currdate < "2017-10-19" then
	enddate = "2017-10-18"
elseif currdate >= "2017-10-19" and currdate < "2017-10-26" then
	enddate = "2017-10-25"
elseif currdate >= "2017-10-26" and currdate < "2017-11-02" then
	enddate = "2017-11-01"
else
	enddate = "2017-11-08"
end if

ddaydate = datediff("D",currdate, CDate(enddate))
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.week-sale {text-align:center;}
.week-sale .day {position:absolute; top:194px; left:75px; width:61px; height:23px; background:#f28578; font-size:12px; line-height:23px; color:#fff; border-radius:10px; font-weight:bold;}
.week-sale a {display:inline-block; position:absolute; top:229px; left:47px; width:115px; height:115px;}
.week-sale .thumb,
.week-sale .thumb img {width:100%; height:100%;}
.week-sale .name {display: inline-block; width:115px; margin-top:8px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size:11px; line-height:1.5; font-weight:bold;}
.swing{animation:swing 2.3s 100 forwards ease-in-out; transform-origin:50% 0;}
@keyframes swing { 0%,100%{transform:rotate(2deg);} 50% {transform:rotate(-2deg);}}
</style>
</head>
<body>
	<!-- 1week big sale -->
	<div class="week-sale swing">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80615/tit_big_sale.png" alt="1WEEK BIG SALE" /></h3>
		<p class="day"><span>D-</span><em><%=ddaydate%></em></p>
		<a href="/event/eventmain.asp?eventid=<%= ecode %>" target="_top">
			<div class="thumb"><img src="<%= itemimg %>" alt="<%= itemname %>" /></div>
			<p class="name"><%= itemname %></p>
		</a>
	</div>
	<!-- //1week big sale -->
</body>
</html>