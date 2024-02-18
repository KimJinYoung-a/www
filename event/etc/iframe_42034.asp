<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/popheader.asp" -->

	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title> 42034 </title>
	<!--
	<link rel="stylesheet" type="text/css" href="http://www.10x10.co.kr/lib/css/tenbyten2012style.css" />
	<link rel="stylesheet" type="text/css" href="http://www.10x10.co.kr/lib/css/tenbyten2012style2.css" />
	-->
	<style type="text/css">
	body {margin:0;}
	.evt42034Wrap {padding:0; margin:0; width:100%; text-align:center; background:#fafafa;}
	.evt42034 * {padding:0; margin:0;}
	.evt42034 {width:960px; margin:0 auto ; background:#fff;}
	.evt42034 img {vertical-align:top; display:inline; border:0;}
	.evt42034 .hitcShare {padding:20px; text-align:right;}
	.evt42034 .hitcShare a {margin-left:5px;}
	.evt42034 .hitcShare img {vertical-align:middle; display:inline-block;}
	</style>
<div class="evt42034Wrap">
	<div class="evt42034">
		<p>
			<img src="http://webimage.10x10.co.kr/eventIMG/2013/42034/42034_img01.jpg" alt="감성충전을 위한 히치하이킹" usemap="#hiker01" />
			<map name="hiker01">
			<!--	<area shape="rect" coords="43,456,309,523" href="https://itunes.apple.com/kr/app/10x10-hichihaikeo/id635127946?mt=8" target="_blank" alt="Download on the App Store" />	-->
					<area shape="rect" coords="42,407,310,476" href="https://itunes.apple.com/kr/app/10x10-hichihaikeo/id635127946?mt=8 " target="_blank" alt="앱스토어연결" />
					<area shape="rect" coords="43,490,311,558" href="https://play.google.com/store/apps/details?id=kr.tenbyten.hitchhiker&feature=search_result#?t=W251bGwsMSwyLDEsImtyLnRlbmJ5dGVuLmhpdGNoaGlrZXIiXQ.." target="_blank" alt="구글플레이연결" />
			</map>
		</p>
		<p>
			<img src="http://webimage.10x10.co.kr/eventIMG/2013/42034/42034_img02.jpg" alt="이야기로 힘을 얻고, 이야기에 힘이 되는 히치하이커" usemap="#hiker02" />
			<map name="hiker02">
				<area shape="rect" coords="372,163,589,203" target="_top" href="http://www.10x10.co.kr/street/street_brand.asp?makerid=hitchhiker" alt="HICHHIKER 구매하기" />
			</map>
		</p>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2013/42034/42034_img03.jpg" alt="주요기능1. 북마크" /></p>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2013/42034/42034_img04.jpg" alt="주요기능2. 공유하기" /></p>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2013/42034/42034_img05.jpg" alt="주요기능3. 배경음악" /></p>
			<%	'// 쇼셜서비스로 글보내기
				dim snpTitle, snpLink, snpPre, snpTag, snpTag2
				snpTitle = Server.URLEncode("감성충전을 위한 히치하이킹")
				snpLink = Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=42034")

				'기본 태그
				snpPre = Server.URLEncode("텐바이텐")
				snpTag = Server.URLEncode("텐바이텐 HITCHHIKER E-BOOK APP OPEN")
				snpTag2 = Server.URLEncode("#10x10")
			%>
		<div class="hitcShare">
			<img src="http://webimage.10x10.co.kr/eventIMG/2013/42034/42034_img06.jpg" alt="히치하이커 앱 출시소식! 친구들에게도 전해주세요" class="rMar10" />
			<img src="http://webimage.10x10.co.kr/eventIMG/2013/42034/42034_sns01.jpg" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>')" alt="미투데이" style="cursor:pointer;" />
			<img src="http://webimage.10x10.co.kr/eventIMG/2013/42034/42034_sns02.jpg" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>')" alt="트위터" style="cursor:pointer;" />
			<img src="http://webimage.10x10.co.kr/eventIMG/2013/42034/42034_sns03.jpg" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','')" alt="페이스북" style="cursor:pointer;" />
		</div>
		<!-- <p><img src="http://webimage.10x10.co.kr/eventIMG/2013/42034/42034_img07.jpg" alt="히치하이커는 여러분의 이야기를 기다리고 있습니다." /></p> -->
	</div>
</div>
<!-- #include virtual="/lib/poptailer.asp" -->