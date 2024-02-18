<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2021 사은품 안내
' History : 2020-09-02 정태훈
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "//m.10x10.co.kr/diarystory2022/"
			REsponse.End
		end if
	end if
end if

dim masterCode
dim i

IF application("Svr_Info") = "Dev" THEN
    masterCode = "3"
else
    masterCode = "10"
end if
%>
<style>
.gift-popup .btn-close {position: fixed !important;top: 0;right: 0;}
</style>
<script>
$(function(){
	fnAmplitudeEventAction('view_diarystory_gift','','');
});
</script>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/diary2021.css">
</head>
<body>
	<div class="heightgird diary2021">
		<div class="dr-benefit sect-bnf new-type">
			<div class="section-01">
                <img src="//fiximage.10x10.co.kr/web2021/diary2022/img_popup01.jpg?v=2" alt="">
                <div class="section-wrap">
                    <div class="benefit-wrap">
                        <div class="benefit-01">
                            <p class="tip"><strong>선물스티커 <i class="badge-gift">선물</i></strong>가 붙은 상품 포함하여</p>
                            <p class="tip type01">구매하시면 금액대별 사은품을 함께 드려요!</p>
                            <ul class="bnf-item">
                                <li>
                                    <figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_gift1_02.png?v=2" alt=""></figure>
                                    <!-- <figure class="bnf-img-soldout"><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_gift1_soldout_02.png?v=2" alt=""></figure>-->
                                    <div class="bnf-info">
                                        <p><em>20,000원</em> 이상 구매 시</p>
                                        <div class="bnf-name">위글위글 스템프 볼펜<br><span>or</span> 1,000 마일리지</div>
                                    </div>
                                </li>
                                <li class="last-prd">
                                    <figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_benefit2_02.gif" alt=""></figure>
                                    <!-- <figure class="bnf-img-soldout"><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_gift2_soldout_02.png?v=2" alt=""></figure>-->
                                    <div class="bnf-info">
                                        <p><em>50,000원</em> 이상 구매 시</p>
                                        <div class="bnf-name">위글위글 피크닉백<br><span>or</span> 3,000 마일리지</div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="benefit-01 type01">
                            <p class="tip"><strong>무료배송스티커<i class="badge-delivery">선물</i></strong>가 붙은 상품은</p>
                            <p class="tip type01">모두 무료로 배송해드려요!!</p>
                            <ul class="bnf-item">
                                <li>
                                    <figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_gift_delivery.png?v=2" alt=""></figure>
                                    <div class="bnf-info">
                                        <p>배송비 걱정 마세요!</p>
                                        <div class="bnf-name">금액과 상관없이 <br>무료배송</div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section-01">
                <img src="//fiximage.10x10.co.kr/web2021/diary2022/img_popup02.jpg" alt="">
            </div>
			<div class="bnf-detail type01">
				<div class="bnf-rolling">
					<div><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_slide1_1.jpg" alt=""></div>
					<div><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_slide1_2.jpg" alt=""></div>
                    <div><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_slide1_3.jpg" alt=""></div>
				</div>
				<div class="bnf-desc">
					<div class="bnf-info">
						<p><em>20,000원</em> 이상 구매시</p>
						<div class="bnf-name">위글위글 스템프펜 증정</div>
                        <p class="bnf-random">(랜덤증정)</p>
					</div>
					<div class="bnf-note"><p>귀염뽀짝 스템프와 볼펜이 만났습니다!</p><p>원하는 곳에 자유롭게 콩, 콩 찍어서</p><p>나만의 다꾸를 완성해보세요!</p></div>
				</div>
			</div>
			<div class="bnf-detail type01"> 
				<div class="bnf-rolling">
					<div><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_slide2_1.jpg" alt=""></div>
					<div><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_slide2_2.jpg" alt=""></div>
                    <div><img src="//fiximage.10x10.co.kr/web2021/diary2022/img_slide2_3.jpg" alt=""></div>
				</div>
				<div class="bnf-desc">
					<div class="bnf-info">
						<p><em>50,000원</em> 이상 구매시</p>
						<div class="bnf-name">위글위글 피크닉백 <span class="bnf-random">(랜덤증정)</span></div>
                        <a href="/shopping/category_prd.asp?itemid=2456816" target="_blank" class="btn-benefit">사은품 자세히보기</a>
					</div>
					<div class="bnf-note"><p>톡톡 튀는 컬러의 개성 넘치는 피크닉백!</p><p>주머니에 쏙- 들어가는 콤팩트한 사이즈로</p><p>언제 어디서든 가볍게 들어보세요!</p></div>
				</div>
			</div>
			<div class="noti">
				<ul>
					<li>- 선물 스티커가 붙은 다이어리 상품 포함 20,000원 이상 구매시 구매금액별 사은품을 받으실  수 있습니다.</li>
					<li>- 선물스티커는 2022 다이어리 스토리 페이지에서 확인 가능합니다.</li>
					<li>- 사은품은 한정수량으로 조기 품절 될 수 있으며, 하위 금액대의 상품을 선택할 수 있습니다.</li>
					<li>- 사은품은 주문건당 1개 증정됩니다.</li>
					<li>- 구매 상품을 취소하거나 반품하였을 경우 사은품을 반품해주셔야 하며, 마일리지의 경우 회수됩니다.</li>
					<li>- 사은품으로 마일리지를 선택하실 경우 모든 상품 출고 완료 후 익일에 지급됩니다.</li>
					<li>- 마일리지는 지급일로부터 30일 동안 사용 가능합니다. 사용기한 이후에는 자동 소멸됩니다.</li>
					<li>- 비회원 구매시 사은품이 증정되지 않습니다</li>
				</ul>
			</div>
		</div>
	</div>
<script>
$('.bnf-rolling').slick();
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->