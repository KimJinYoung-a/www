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
			Response.Redirect "//m.10x10.co.kr/diarystory2021/"
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
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/diary2021.css">
</head>
<body>
<div class="heightgird diary2021">
	<div class="popWrap">
		<div class="dr-benefit sect-bnf">
			<div class="dr-top">
				<h2><span class="sub">텐바이텐이 준비한</span>선물 받아가세요!</h2>
				<p class="tip"><strong>선물스티커<i class="badge-gift">선물</i></strong>가 붙은 상품 포함하여 구매시, 금액대별 사은품을 드립니다.</p>
				<div class="bnf1">
					<ul class="bnf-item">
						<li>
							<figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_benefit1.png" alt=""></figure>
							<div class="bnf-info">
								<p><em>15,000원</em> 이상 구매시</p>
								<div class="bnf-name">다꾸파우치<span>(컬러 랜덤증정)</span></div>
							</div>
						</li>
						<li>
							<figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_benefit2.png" alt=""></figure>
							<div class="bnf-info">
								<p><em>30,000원</em> 이상 구매시</p>
								<div class="bnf-name">히치하이커 스티커북<br/><span>또는</span>1,000마일리지</div>
							</div>
						</li>
						<li>
							<figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_benefit3.png?v=1.01" alt=""></figure>
							<div class="bnf-info">
								<p><em>60,000원</em> 이상 구매시</p>
								<div class="bnf-name">다꾸 라벨기<br/><span>또는</span>3,000마일리지</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<a href="/diarystory2021/" target="_balnk" class="btn-more">2021 다이어리 스토리 바로가기</a>
			<div class="bnf-detail">
				<div class="bnf-rolling">
					<div><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_slide1_1.jpg" alt=""></div>
					<div><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_slide1_2.jpg" alt=""></div>
				</div>
				<div class="bnf-desc">
					<div class="bnf-info">
						<p><em>15,000원</em> 이상 구매시</p>
						<div class="bnf-name">다꾸파우치 <span>(컬러 랜덤증정)</span></div>
					</div>
					<div class="bnf-note"><p>오늘은 다꾸하는 날!</p><p>컬러풀한 다꾸 파우치에 다꾸 아이템을 쏙 - 넣어!</p><p>가까운 공원에서 다꾸를 해보면 어떨까요?</p></div>
				</div>
			</div>
			<div class="bnf-detail">
				<div class="bnf-rolling">
					<div><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_slide2_1.jpg" alt=""></div>
					<div><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_slide2_2.jpg" alt=""></div>
				</div>
				<div class="bnf-desc">
					<div class="bnf-info">
						<p><em>30,000원</em> 이상 구매시</p>
						<div class="bnf-name">히치하이커 스티커북 증정</span></div>
						<a href="/shopping/category_prd.asp?itemid=3109375" target="_blank" class="btn-prd">구매하러 가기</a>
					</div>
					<div class="bnf-note"><p>일상의 풍경을 담은 매거진 히치하이커,</p><p>나의 일상과 닮은 히치하이커 일러스트와</p><p>감성적인 포토 스티커로 하루를 기록해보세요.</p></div>
				</div>
			</div>
			<div class="bnf-detail">
				<div class="bnf-rolling">
					<div><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_slide3_1.jpg" alt=""></div>
					<div><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_slide3_2.jpg" alt=""></div>
				</div>
				<div class="bnf-desc">
					<div class="bnf-info">
						<p><em>60,000원</em> 이상 구매시</p>
						<div class="bnf-name">다꾸 라벨기 증정</div>
					</div>
					<div class="bnf-note"><p>사랑스러운 핑크 컬러의 다꾸 라벨기와</p><p>함께 드리는 테이프로 전하고 싶은 말을 꾹꾹</p><p>눌러담아 나만의 DIY 다꾸, 폴꾸에 도전해보세요!</p></div>
				</div>
			</div>
			<div class="insta"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_insta.png" alt="special event"></div>
			<a href="/event/eventmain.asp?eventid=105489" target="_balnk" class="btn-evt"><img src="//fiximage.10x10.co.kr/web2020/diary2021/btn_daccutem.png" alt="함께 구매하면 좋은 찰떡 다꾸템 보러가기"></a>
			<div class="noti">
				<ul>
					<li>- 선물 스티커가 붙은 다이어리 상품 포함 15,000원 이상 구매시 구매금액별 사은품을 받으실  수 있습니다.</li>
					<li>- 선물스티커는 2021 다이어리 스토리 페이지에서 확인 가능합니다.</li>
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
</div>
<script>
$('.bnf-rolling').slick();
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->