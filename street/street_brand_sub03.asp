<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description :  브랜드스트리트 tenbytenand
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
	$(function() {
		var id = "<%=slidecode%>";
		if ( id > "0" )
		{
			$('html,body').animate({scrollTop: $("#section0"+id).offset().top},'slow');
		}

		//TENBYTEN&
		$('.brBnrArea .bnrArea').hide();
		$('#vbrImg01').show();
		$('.brBnrArea .linkList li').click(function(){
			$('.brBnrArea .bnrArea').hide();
			$('.brBnrArea .linkList li').removeClass('current');
			$(this).addClass('current');
			$("div[class='bnrArea'][id='"+'v'+$(this).attr("id")+"']").show();
		});
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

				<!-- TENBYTEN& -->
				<div class="tenbytenAnd" id="section03" <% if tenbytenand_yn<>"Y" then response.write " style='padding:0px;'" %>>
					<!-- #include virtual="/street/inc_tenbytenand.asp" -->
				</div>
				<!-- //TENBYTEN& -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->