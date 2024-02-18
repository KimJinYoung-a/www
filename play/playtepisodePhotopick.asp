<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
'#############################################
' T-episode - 김진영
' 2013-10-01
'#############################################
%>
<%
Dim idx , CurrPage 
idx = getNumeric(requestCheckVar(request("idx"),8))
CurrPage = getNumeric(requestCheckVar(request("cpg"),8))
If CurrPage = "" then CurrPage = 1
strPageTitle = "텐바이텐 10X10 : T-episode PHOTO PICK"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".photoPickList .box a .description").hide();
		$(".photoPickList .box a").mouseover(function () {
			$(".photoPickList .box a .description").hide();
			$(this).children().show();
		});

		$(".photoPickList .box a").mouseleave(function () {
			$(".photoPickList .box a .description").hide();
		});
	});
	$(document).ready(function(){
		jsGoPage(1);
	});
	//list ajax
	function jsGoPage(iP){
		var str = $.ajax({
					type: "GET",
					url: "playtepisodePhotopick_ajax.asp?cpg="+iP,
					dataType: "text",
					async: false
					,error: function(err) {
					alert(err.responseText);
				}
			}).responseText;
		if(str!="") {
			$("#photoPickList").empty().append(str);
		}
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
				<h2 class="ftLt" style="margin-bottom:-8px;"><a href="/play/playtEpisodePhotopick.asp"><img src="http://fiximage.10x10.co.kr/web2013/play/tit_t_episode.gif" alt="T-episode 뜻밖의 선물" /></a></h2>
				<ul class="episodeNav">
					<!-- #include virtual="/play/lib/playtepisode_top.asp" -->
				</ul>
			</div>
			<div id="photoPickList"></div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>