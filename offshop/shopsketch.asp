<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/shopqna.asp
' Description : 오프라인샾 QnA
' History : 2009.07.14 강준구 생성
'           2009.08.13 허진원 탑배너 및 내용 크기 수정
'           2018.06.14 정태훈 리뉴얼
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/inc/offshopCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/offshopcls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/offshop/inc/commonFunction.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'매장 정보 가져오기
Dim offshopinfo, shopid, offshopgallery, arrGallery
shopid = requestCheckVar(request("shopid"),16)

'Response.write shopid
'Response.end
Set  offshopinfo = New COffShop
offshopinfo.FRectShopID=shopid
offshopinfo.GetOneOffShopContents

Set  offshopgallery = New COffShopGallery
offshopgallery.FCPage=1
offshopgallery.FPSize=18
offshopgallery.FShopId=shopid
arrGallery = offshopgallery.fnGetShopGallery
%>
<script type="text/javascript">
$(function(){
	// gallery
	var offSwiper = new Swiper('.offshop-sketch .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:false,
		simulateTouch:false,
		pagination:'.offshop-sketch .pagination',
		paginationClickable:true,
		nextButton:'.offshop-sketch .btn-next',
		prevButton:'.offshop-sketch .btn-prev'
	})
	$('.offshop-sketch .btn-prev').on('click', function(e){
		e.preventDefault();
		offSwiper.swipePrev();
	})
	$('.offshop-sketch .btn-next').on('click', function(e){
		e.preventDefault();
		offSwiper.swipeNext();
	});

	// small-thumb background-image
	<% If isArray(arrGallery) Then %>
		<% For ix = 0 To UBound(arrGallery,2) %>
		<% If ix=0 Then %>
		$('.offshop-sketch .pagination span').css({"background-image":"url(<%=arrGallery(2,ix)%>)"});
		<% else %>
		$('.offshop-sketch .pagination span:nth-child(<%=ix+1%>)').css({"background-image":"url(<%=arrGallery(2,ix)%>)"});
		<% End If %>
		<% Next %>
	<% End If %>
});
</script>
</head>
<body>
<div class="wrap fullEvt">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container offshopV18">
		<div id="contentWrap">
			<!-- #include virtual="/offshop/inc/incHeader.asp" -->

			<div class="offshop-sketch">
				<!-- gallery -->
				<div class="gallery">
					<div class="swiper-container">
						<div class="swiper-wrapper">
						<% If isArray(arrGallery) Then %>
							<% For ix = 0 To UBound(arrGallery,2) %>
							<div class="swiper-slide"><img src="<%=arrGallery(2,ix)%>" alt="" /></div>
							<% Next %>
						<% Else %>
							<div class="swiper-slide"></div>
						<% End If %>
						</div>
						<button class="rolling-nav btn-prev" onfocus="this.blur();">이전</button>
						<button class="rolling-nav btn-next" onfocus="this.blur();">다음</button>
					</div>
					<div class="pagination"></div>
				</div>
				<!--// gallery -->
			</div>

		</div>
	</div>
</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

</body>
</html>
<%
Set  offshopinfo = Nothing
Set  offshopgallery = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->