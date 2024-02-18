<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  텐바이텐 체크카드 밀키머그 이벤트
' History : 2018-05-15 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/ItemOptionCls.asp" -->
<%
Dim eCode, userid, oItem, itemid

IF application("Svr_Info") = "Dev" THEN
	eCode   =  68519
	itemid = 834339
Else
	eCode   =  86505
	itemid=1967223
End If

userid = GetEncLoginUserID()

Dim sqlStr, TotalCnt
sqlStr = "SELECT limitsold FROM [db_item].[dbo].[tbl_item] WHERE itemid = '" & itemid & "'"
rsget.CursorLocation = adUseClient
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	TotalCnt = rsget(0)
Else
	TotalCnt=0
End IF
rsget.close

%>
<style type="text/css">
.slide-wrap {position:relative; height:568px; padding-top:8px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/86505/bg_slide.png) repeat 50% 0;}
.slide-wrap .slide {position:relative; width:850px; height:560px; margin-left:144px;}
.slide-wrap .slide .slidesjs-pagination {position:absolute; left:0; bottom:20px; z-index:30; width:100%; height:10px;}
.slide-wrap .slide .slidesjs-pagination li {display:inline-block; padding:0 5px;}
.slide-wrap .slide .slidesjs-pagination li a {display:inline-block; width:10px; height:10px; background:#fff; border-radius:50%; text-indent:-999em; box-shadow:0 0 13px 0 rgba(0,0,0,.2); transition:all .3s;}
.slide-wrap .slide .slidesjs-pagination li a.active {width:19px; background:#26a672; border-radius:64px;}
.slide-wrap .limit {position:absolute; right:70px; top:-38px; z-index:30; animation:bounce 1s 50;}
.item {padding-bottom:50px; background:#ffe282; text-align:center;}
.item a {text-decoration:none;}
.noti {position:relative; padding:50px 0; background:#08b26d;}
.noti h3 {position:absolute; left:333px; top:50%; margin-top:-10px;}
.noti ul {padding-left:445px; color:#fff; line-height:25px; text-align:left;}
@keyframes bounce {
    from, to {transform:translateY(0); animation-timing-function:ease-out;}
    50% {transform:translateY(8px); animation-timing-function:ease-in;}
}
</style>
<script style="text/javascript">
$(function(){
	$('.slide-wrap .slide').slidesjs({
		width:850,
		height:560,
		pagination:{effect:'fade'},
		navigation:false,
		play:{interval:3000, effect:'fade', auto:false},
		effect:{fade: {speed:700, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide-wrap .slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
});
</script>
						<!-- 텐카찬스 프로젝트 01 - 밀키머그 -->
						<div class="evt86505">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/tit_mug.png" alt="텐카찬스 프로젝트 01 - 밀키머그" /></h2>
							<div class="slide-wrap">
								<p class="limit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/txt_limit.png" alt="선착순 1,000명" /></p>
								<div class="slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/img_slide_1.jpg" alt="" />
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/img_slide_2.jpg" alt="" />
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/img_slide_3.jpg" alt="" />
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/img_slide_4.jpg" alt="" />
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/img_slide_5.jpg" alt="" />
								</div>
							</div>
							<!-- 구매하기 -->
							<div class="item">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/txt_item.png?v=1" alt="텐바이텐 체크카드 할인가 2,000원" /></p>
								<% If TotalCnt >= 1000 Then %>
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/btn_soldout.png" alt="SOLD OUT" />
								<% Else %>
								<a href="/shopping/category_prd.asp?itemid=<%=itemid%>&pEtr=<%=eCode%>">
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/btn_buy.png" alt="지금 구매하러 가기" />
								</a>
								<% End If %>
								<p class="tPad10"><img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/txt_free.png" alt="*본 상품은 무료배송입니다*" /></p>
							</div>
							<div><a href="/event/eventmain.asp?eventid=85155" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/bnr_event.png" alt="지금, 텐바이텐 체크카드로 3만원 이상 결제하면 카드홀더를 드려요!" /></a></div>
							<div class="noti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/86505/tit_noti.png" alt="유의사항" /></h3>
								<ul>
									<li>- <strong>본 이벤트는 '텐바이텐 체크카드'로만 결제가 가능합니다.</strong></li>
									<li>- <strong>구매는 ID당 최대 1개까지 구매할 수 있습니다.</strong></li>
									<li>- 본 상품은 다른 상품과 함께 구매하실 수 없습니다.</li>
									<li>- 이벤트는 선착순 수량(1,000개) 품절 시 조기 마감될 수 있습니다.</li>
								</ul>
							</div>
						</div>
						<!--// 텐카찬스 프로젝트 01 - 밀키머그 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->