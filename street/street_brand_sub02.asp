<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description :  브랜드스트리트 interview
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/street/BrandStreetCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/street/inc_street_lib.asp" --><!-- 공통권한 -->
<%
	dim slidecode : slidecode = getNumeric(requestCheckVar(request("slidecode"),1))
	
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/css/numSpinner.css" />
<script type="text/javascript">
	$(function(){
		var id = "<%=slidecode%>";
		if ( id > "0" )
		{
			$('html,body').animate({scrollTop: $("#section0"+id).offset().top},'slow');
		}

		//Interview
		var mySwiper = new Swiper('.swiper1',{
			//pagination:'.pagination',
			pagination:false,
			loop:true,
			grabCursor:false,
			paginationClickable:true
		});
		$('.articleList .arrow-left').on('click', function(e){
			e.preventDefault()
			mySwiper.swipePrev()
		});
		$('.articleList .arrow-right').on('click', function(e){
			e.preventDefault()
			mySwiper.swipeNext()
		});

		$(".magazine").show();
		$(".articleList .swiper-slide").click(function(){
			$(".magazineList .mArticle").hide();
			$(".magazine").show();
			$("div[class='mArticle'][id='"+'m'+$(this).attr("id")+"']").show();
		});

		// 2013.11.11 INTERVIEW
		var itemSize = $(".interviewList .interviewCont").length;

		$(".interviewList .interviewCont").hide();
		$(".interviewList .interviewCont:first").show();

		$(".interviewList .prevBtn").click(function(){
			$(".interviewList .interviewCont:last").prependTo(".interviewList");
			$(".interviewList .interviewCont").hide().eq(0).show();
		});

		$(".interviewList .nextBtn").click(function(){
			$(".interviewList .interviewCont:first").appendTo(".interviewList");
			$(".interviewList .interviewCont").hide().eq(0).show();
		});

		if ( itemSize > 1 ) {
			$(".interviewList .prevBtn").show();
			$(".interviewList .nextBtn").show();
		} else {
			$(".interviewList .prevBtn").hide();
			$(".interviewList .nextBtn").hide();
		}
	});

</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container brandV15">
		<div id="contentWrap">
			<!-- #include virtual="/street/inc_topnavi.asp" -->
		</div>
		
		<div class='brandContWrapV15'>
			<!-- #include virtual="/street/inc_topmenu.asp" -->

			<div class="brandSection">
				<% If hello_yn="Y" Then %>
					<!-- ABOUT BRAND-->
					<div class="aboutBrandV15">
						<!-- #include virtual="/street/inc_aboutbrand.asp" -->
					</div>
					<!-- //ABOUT BRAND -->
				<% end if %>

				<!-- INTERVIEW -->
				<div class="interview" id="section02" <% if interview_yn<>"Y" then response.write " style='padding:0px;'" %>>
					<!-- #include virtual="/street/act_interview_new.asp" -->
				</div>
				<!-- //INTERVIEW -->

				<iframe id="iframeview" name="iframeview" width=0 height=0 frameborder="0"></iframe>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->