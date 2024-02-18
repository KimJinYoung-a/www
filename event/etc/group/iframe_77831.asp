<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 꽃길만 걷게 해줄게요
' History : 2017-05-04 조경애 생성
'####################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim currentdate
	currentdate = date()
%>
<style type="text/css">
img {vertical-align:top;}
.just1Week {position:relative; height:543px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77831/bg_item.jpg) 50% 0 no-repeat;}
.just1Week h3 {position:absolute; left:50%; top:45px; margin-left:-105px; z-index:30;}
.just1Week .item {position:relative; width:850px; height:480px; margin:0 auto;}
.just1Week .item .goMore {position:absolute; right:0; bottom:0; z-index:30;}
</style>
</head>
<body>
<div>
	<!-- 1주차 -->
	<% If currentdate <= "2017-05-14" Then %>
	<div class="just1Week">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/txt_1week_01.png" alt="JUST 1 WEEK" /></h3>
		<div class="item">
			<a href="/shopping/category_prd.asp?itemid=1469907&pEtr=77831" target="_top">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/img_item_01.jpg" alt="KELLY SNEAKERS" /></div>
				<span class="goMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/btn_more.png" alt="상품 보러가기" /></span>
			</a>
		</div>
	</div>

	<!-- 2주차 -->
	<% ElseIf currentdate >= "2017-05-15" AND currentdate <= "2017-05-21" Then %>
	<div class="just1Week">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/txt_1week_02.png" alt="JUST 1 WEEK" /></h3>
		<div class="item">
			<a href="/shopping/category_prd.asp?itemid=1664880&pEtr=77831" target="_top">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/img_item_02.jpg" alt="GRAM" /></div>
				<span class="goMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/btn_more.png" alt="상품 보러가기" /></span>
			</a>
		</div>
	</div>

	<!-- 3주차 -->
	<% ElseIf currentdate >= "2017-05-22" AND currentdate <= "2017-05-28" Then %>
	<div class="just1Week">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/txt_1week_03.png" alt="JUST 1 WEEK" /></h3>
		<div class="item">
			<a href="/shopping/category_prd.asp?itemid=1696742&pEtr=77831" target="_top">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/img_item_03.jpg" alt="ROCKFISH" /></div>
				<span class="goMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/btn_more.png" alt="상품 보러가기" /></span>
			</a>
		</div>
	</div>


	<!-- 4주차 -->
	<% ElseIf currentdate >= "2017-05-29" Then %>
	<div class="just1Week">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/txt_1week_04.png" alt="JUST 1 WEEK" /></h3>
		<div class="item">
			<a href="/shopping/category_prd.asp?itemid=1618488&pEtr=77831" target="_top">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/img_item_04.jpg" alt="STARE" /></div>
				<span class="goMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77831/btn_more.png" alt="상품 보러가기" /></span>
			</a>
		</div>
	</div>
	<% End If %>
</div>
</body>
</html>