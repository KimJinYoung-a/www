<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'#######################################################
'	History	: 2015.01.22 원승현 생성
'             2022.06.21 허진원 인스타그램으로 변경
'	Description : 텐바이텐 sns 가져오기
'#######################################################
%>
<style type="text/css">
	#instaGallery {
		width:100%;
		margin:3em auto;
		display: flex;
		flex-wrap: wrap;
	}
	#instaGallery li {
		width:23%;
		margin:0.7rem;
		list-style:none;
	}
	#instaGallery li img {
		width:100%;
	}
</style>
</head>
<body>
<div class="wrap snsCollect">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<ul id="instaGallery"></ul>
		</div>
		</div>
		</div>
	</div>
	<script type="text/javascript" src="https://unpkg.com/instafeed.js@2.0.0/dist/instafeed.js"></script>
	<script type="text/javascript">
		var feed = new Instafeed({
			target:'instaGallery',
			limit: 24,
			template:'<li><a href="{{link}}" target="_blank"><img title="{{caption}}" src="{{image}}" /></a><p>{{caption}}</p></li>',
			accessToken: 'IGQVJVNENXRTBZASkJpWHFXSGtNUFdoOC1SeE5OR01BY0hiSHVXN1NEbnotRFI0SzlvY1FGbXN2V0lDekhlN2JTSTJuOUQzYUhlYmFBMUxZANUZArajYwUUg1MHliOWx4S0NLLTNaemtmbnVwX2pHclI5RgZDZD'
		});
		feed.run();
	</script>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->