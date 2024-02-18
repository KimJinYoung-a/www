<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/instagrameventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/ItemOptionCls.asp" -->
<%
'####################################################
' Description : 봄을 사랑한 초코파이
' History : 2018-03-15 정태훈
'####################################################
Dim eCode, userid, oItem, itemid, IsPresentItem, IsSpcTravelItem, ISFujiPhotobook, GiftNotice, DateCheck

DateCheck=now()
'DateCheck=#03/19/2018 10:00:00#

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67515
	itemid = 834339
Else
	eCode   =  85005
	If DateCheck >= #03/15/2018 00:00:00# And DateCheck <= #03/25/2018 23:59:59# Then
		itemid=1922485
	ElseIf DateCheck >= #03/26/2018 00:00:00# And DateCheck <= #03/26/2018 23:59:59# Then
		itemid=1922486
	Else
		itemid=1922486
	End If
End If

userid = GetEncLoginUserID()

set oItem = new CatePrdCls
oItem.GetItemData itemid
IsPresentItem = (oItem.Prd.FItemDiv = "09")
IsSpcTravelItem = oitem.Prd.IsTravelItem and oItem.Prd.Fmakerid = "10x10Jinair"
ISFujiPhotobook = oItem.Prd.FMakerid="fdiphoto"
GiftNotice=false '사은품 소진 메세지 출력 유무

Dim sqlStr, OrderCnt, TotalCnt, TotalCheckCnt
sqlStr = "SELECT limitsold FROM [db_item].[dbo].[tbl_item] WHERE itemid = '" & itemid & "'"
rsget.CursorLocation = adUseClient
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	TotalCnt = rsget(0)
Else
	TotalCnt=0
End IF
rsget.close

If DateCheck >= #03/15/2018 00:00:00# And DateCheck <= #03/25/2018 23:59:59# Then
TotalCheckCnt=500
ElseIf DateCheck >= #03/26/2018 00:00:00# And DateCheck <= #03/26/2018 23:59:59# Then
TotalCheckCnt=1000
Else
TotalCheckCnt=500
End If
TotalCnt=1000
OrderCnt=4
%>
<style type="text/css">
.evt85005 {background:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/bg_pink_1.png) 0 0 repeat;}
.evt85005 .topic {background:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/bg_pink_2.png?v=1) 0 0 repeat;}
.evt85005 .topic .inner {position:relative;height:602px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/bg_topic.jpg) 50% 0 no-repeat;}
.evt85005 .topic .deco {position:absolute; left:0; bottom:0; width:100%; height:33px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/bg_wave.png?v=1) 0 0 repeat-x;}
.evt85005 .topic h2 {position:absolute; left:50%; top:137px; margin-left:-50px; z-index:20;}
.evt85005 .topic .limit {position:absolute; left:50%; top:198px; margin-left:400px; z-index:10; animation:move1 .6s infinite alternate;}
.evt85005 .spring-edition {height:1262px; padding-top:115px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/bg_blossom.jpg) 50% 0 no-repeat;}
.evt85005 .spring-edition .txt {position:relative; width:844px; margin:0 auto;}
.evt85005 .spring-edition .txt span {position:absolute; left:456px; top:6px; width:51px; height:50px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/img_flower.png) 0 0 no-repeat; animation:move2 2s infinite;}
.evt85005 .spring-edition .item {position:relative; width:1128px; height:758px; margin:79px auto 0;}
.evt85005 .spring-edition .item .btn {position:absolute; left:50%; bottom:163px; width:446px; margin-left:-252px;}
.evt85005 .spring-edition .item .btn a {display:block; animation:move1 .6s infinite alternate;}
.evt85005 .spring-edition .soldout {position:absolute; left:0; top:0;}
.evt85005 .spring-edition .btn-info {position:absolute; left:50%; bottom:116px; margin-left:-124px; background:transparent; outline:none;}
.evt85005 .wideSwipe .swiper-container {height:630px;}
.evt85005 .wideSwipe .swiper-slide {width:980px;}
.evt85005 .wideSwipe .swiper-slide img {height:630px;}
.evt85005 .wideSwipe .slideNav {width:46px; height:76px; margin-top:-38px;}
.evt85005 .wideSwipe .btnPrev,.evt85005 .wideSwipe .btnPrev:hover {margin-left:-550px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_prev.png);}
.evt85005 .wideSwipe .btnNext,.evt85005 .wideSwipe .btnNext:hover {margin-left:500px;background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_next.png); background-position:0 0; }
.evt85005 .wideSwipe .pagination {bottom:31px; height:33px;}
.evt85005 .wideSwipe .pagination span {width:33px; height:33px;background-IMAGE:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_pagination.png);}
.evt85005 .wideSwipe .mask {background:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/bg_mask.png) 0 0 repeat;}
.evt85005 .wideSwipe .mask.left {margin-left:-490px;}
.evt85005 .wideSwipe .mask.right {margin-left:490px;}
.evt85005 .noti {padding:60px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2018/85005/bg_noti.png) 0 0 repeat;}
.evt85005 .noti .inner {position:relative; width:1140px; margin:0 auto;}
.evt85005 .noti h3 {position:absolute; left:233px; top:50%; margin-top:-15px;}
.evt85005 .noti ul {padding-left:500px; text-align:left; color:#fff; line-height:25px;}
.layer {position:absolute !important; left:50% !important; top:1300px !important; z-index:99999; width:1080px; margin-left:-540px;}
.layer .btn-close {display:block; position:absolute; right:30px; top:30px; outline:none; background:transparent;}
@keyframes move1 {
	from {transform:translateY(0);}
	to {transform:translateY(8px);}
}
@keyframes move2 {
	from {transform:rotate(0);}
	to {transform:rotate(360deg);}
}
</style>
<script type="text/javascript" src="/lib/js/category_prd.js?v=1.1"></script>
<script style="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.wideSwipe .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:3500,
		simulateTouch:false,
		pagination:'.wideSwipe .pagination',
		paginationClickable:true,
		nextButton:'.wideSwipe .btnNext',
		prevButton:'.wideSwipe .btnPrev'
	})
	$('.wideSwipe .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.wideSwipe .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});

	$('.btn-info').click(function(){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$('.layer').offset().top},600);
	});
});
</script>
						<!-- 봄을 사랑한 초코파이 -->
						<div class="evt85005">
							<div class="topic">
								<div class="inner">
									<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/tit_spring.png" alt="봄을 사랑한 초코파이" /></h2>
									<p class="limit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/txt_limit.png" alt="선착순 1000명" /></p>
									<div class="deco"></div>
								</div>
							</div>
							<div class="spring-edition">
								<p class="txt"><span></span><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/txt_edition.png" alt="올봄에만 만날 수 있는 오리온 봄&amp;봄 한정판 2종과 초코파이가 재해석한 핑크빛 봄봄 에코백과 보틀까지!" /></p>
								<!-- 구매하기 -->
								<form name="sbagfrm" method="post" action="" style="margin:0px;">
								<input type="hidden" name="mode" value="add">
								<input type="hidden" name="itemid" value="<% = oitem.Prd.FItemid %>">
								<input type="hidden" name="sitename" value="<%= session("rd_sitename") %>">
								<input type="hidden" name="itemoption" value="">
								<input type="hidden" name="itemea" value="1" />
								<input type="hidden" name="userid" value="<%= userid %>">
								<input type="hidden" name="itemPrice" value="<%= oItem.Prd.getRealPrice %>">
								<input type="hidden" name="isPhotobook" value="<%= ISFujiPhotobook %>">
								<input type="hidden" name="isPresentItem" value="<%= isPresentItem %>">
								<input type="hidden" name="IsSpcTravelItem" value="<%= IsSpcTravelItem %>">
								<input type="hidden" name="itemRemain" id="itemRamainLimit" value="<%=chkIIF(oItem.Prd.IsLimitItemReal,CHKIIF(oItem.Prd.FRemainCount<=oItem.Prd.ForderMaxNum,oItem.Prd.FRemainCount,oItem.Prd.ForderMaxNum),oItem.Prd.ForderMaxNum)%>">
								<div class="item">
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/img_item.png" alt="초코파이 딸기&amp;요거트, 후레쉬베리 복숭아&amp;요거트, 초코파이 봄봄 보틀, 초코파이 봄봄 에코백을 20,000원에 만나보세요!" /></div>
									<div class="btn">
									<% If DateCheck >= #03/15/2018 00:00:00# And DateCheck < #03/19/2018 10:00:00# Then %>
										<img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_soon_1.png" alt="3.19(월) 오전 10시 잠시후에 오픈됩니다!" />
									<% ElseIf DateCheck >= #03/26/2018 00:00:00# And DateCheck < #03/26/2018 10:00:00# Then %>
										<img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_soon_2.png" alt="3.26(월) 오전 10시 잠시후에 오픈됩니다!" />
									<% Else %>
										<% If TotalCnt >= 500 And DateCheck < #03/26/2018 00:00:00# Then %>
											<img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_soldout.png" alt="품절" />
										<% Else %>
											<% If IsUserLoginOK() Then %>
												<% If OrderCnt>=5 Then %>
												<a href="javascript:alert('구매는 ID 당 최대 5개까지 구매할 수 있습니다.');" class="buy"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_buy.png" alt="바로 구매하기" /></a>
												<% Else %>
												<a href="javascript:FnAddShoppingBag();" class="buy"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_buy.png" alt="바로 구매하기" /></a>
												<% End If %>
											<% Else %>
												<a href="javascript:top.location.href='/login/loginpage.asp?vType=G';" class="buy"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_buy.png" alt="바로 구매하기" /></a>
											<% End If %>
										<% End If %>
									<% End If %>
									</div>
									<% If TotalCnt >= 1000 Then %>
									<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/txt_soldout.png" alt="SOLDOUT" /></p>
									<% End If %>
									<button class="btn-info" onclick="viewPoupLayer('modal',$('#lyrInfo').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_view.png" alt="상품 필수 정보 보러가기" /></button>
									<div id="lyrInfo" style="display:none;">
										<div class="layer">
											<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/txt_item_info.png" alt="상품 필수 정보" /></div>
											<button type="button" class="btn-close" onclick="ClosePopLayer()"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/btn_close.png" alt="닫기" /></button>
										</div>
									</div>
								</div>
								</form>
								<form name="BagArrFrm" method="post" action="" onsubmit="return false;" >
								<input type="hidden" name="mode" value="arr">
								<input type="hidden" name="bagarr" value="">
								<input type="hidden" name="giftnotice" value="<%=GiftNotice%>">
								</form>
								<!--// 구매하기 -->
							</div>
							<div class="slideTemplateV15 wideSwipe">
								<div class="swiper-container">
									<div class="swiper-wrapper">
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/img_slide_1.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/img_slide_2.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/img_slide_3.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/img_slide_4.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/img_slide_5.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/img_slide_6.jpg" alt="" /></div>
									</div>
									<div class="pagination"></div>
									<button class="slideNav btnPrev">이전</button>
									<button class="slideNav btnNext">다음</button>
									<div class="mask left"></div>
									<div class="mask right"></div>
								</div>
							</div>
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/85005/tit_noti.png" alt="이벤트 유의사항" /></h3>
									<ul>
										<li>- 해당 상품은 3월 19일과 26일, 총 이틀에 걸쳐 선착순 1000개가 판매됩니다.</li>
										<li style="color:#ffadc8;">- 1차(3월 19일) 상품은 20일부터 배송됩니다.</li>
										<li>- 초코파이 봄봄에디션은 로그인 후 구매 가능합니다.</li>
										<li>- 구매는 ID 당 최대 5개까지 구매할 수 있습니다.</li>
										<li>- 이벤트는 상품 품절 시 조기 마감될 수 있습니다.</li>
										<li>- 이벤트는 즉시 결제로만 구매할 수 있습니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<!--// 봄을 사랑한 초코파이 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->