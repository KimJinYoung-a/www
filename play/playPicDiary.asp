<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
'#############################################
' 그림일기 - 이종화
' 2013-09-09 
'#############################################
%>
<%
	Dim idx , CurrPage , viewno , loginuserid
	idx = getNumeric(requestCheckVar(request("idx"),8))
	viewno = getNumeric(requestCheckVar(request("viewno"),8))
	CurrPage = getNumeric(requestCheckVar(request("cpg"),8))

	if CurrPage = "" then CurrPage = 1

	strPageTitle = "텐바이텐 10X10 : 그림일기"
	strPageDesc = "텐바이텐 PLAY - 그림일기"
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/play/playPicDiary.asp" 	'페이지 URL(SNS 퍼가기용)

	loginuserid = GetLoginUserID()

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('img').load(function(){
			$(".diaryList").masonry({
				itemSelector: '.box'
			});
		});
		$(".diaryList").masonry({
			itemSelector: '.box'
		});

		jsGoPage(1);

		<% if idx <>"" and viewno <> "" then%>
			Showview();
		<% end if %>

	});
	//list ajax
	function jsGoPage(iP){
		var str = $.ajax({
					type: "GET",
					url: "playPicDiary_ajax.asp?cpg="+iP+"&uid=<%=loginuserid%>",
					dataType: "text",
					async: false
					,error: function(err) {
					alert(err.responseText);
				}
			}).responseText;

		if(str!="") {
			$("#diarylist").empty().append(str);
		}
	}
	//viewer ajax
	function jsGoView(val,val2){
		var str = $.ajax({
					type: "GET",
					url: "playPicDiaryView_ajax.asp?idx="+val+"&viewno="+val2+"&uid=<%=loginuserid%>",
					dataType: "text",
					async: false
					,error: function(err) {
					alert(err.responseText);
				}
			}).responseText;
		if(str!="") {
			$("#diaryview").empty().append(str);
		}
	}
	//view layer
	function Showview(){
		var id = "#playDiaryLyr"; //$('a[name=lyrPopup]').attr('href');
		var relval = "<%=idx%>";
		var relval2 = "<%=viewno%>";
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		$('#lyrPop').show();
		$('.window').show();

		jsGoView(relval,relval2);

		var winH = $(window).height();
		var winW = $(window).width();
		$(id).css('top', winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);
		$(id).show();
	}
</script>
</head>
<body>
<div class="wrap playWrapV15" id="playSub">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- #include virtual="/lib/inc/incPlayHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="playTit">
				<h2 class="ftLt"><a href="/play/playPicDiary.asp"><img src="http://fiximage.10x10.co.kr/web2013/play/tit_pic_diary.gif" alt="그림 일기" /></a></h2>
			</div>
			<div id="diarylist"></div><!-- ajaxlist -->
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
