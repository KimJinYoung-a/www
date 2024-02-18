<% if giftCheck then %>
<section class="sect-bnf">
	<h2><span class="sub">텐바이텐이 준비한</span> 특별한 선물</h2>
	<% If Date<="2020-12-31" Then %>
	<div class="bnf-cont">
		<div class="bnf1">
			<a href="/diarystory2021/special_benefit.asp" onclick="window.open(this.href, 'popbenefit', 'width=800,height=800,left=300,scrollbars=auto,resizable=yes'); return false;" target="_blank">
				<ul class="bnf-item">
					<li>
						<figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_gift1.png" alt=""></figure>
						<div class="bnf-info">
							<p>15,000원 이상</p>
							<div class="bnf-name">다꾸파우치</div>
						</div>
					</li>
					<li>
						<figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_gift2.png" alt=""></figure>
						<div class="bnf-info">
							<p>30,000원 이상</p>
							<div class="bnf-name">스티커북</div>
						</div>
					</li>
					<li>
						<figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_gift3.png" alt=""></figure>
						<div class="bnf-info">
							<p>60,000원</p>
							<div class="bnf-name">다꾸라벨기</div>
						</div>
					</li>
				</ul>
			</a>
			<p class="tip"><strong><i class="badge-gift">선물</i>선물스티커</strong>가 붙은 상품 포함하여 구매시 금액대별 사은품 증정!</p>
			<a href="/diarystory2021/special_benefit.asp" onclick="window.open(this.href, 'popbenefit', 'width=800,height=800,left=300,scrollbars=auto,resizable=yes'); return false;" class="btn-benefit">선물 자세히 보기</a>
		</div>
		<div class="bnf2">
			<div class="bnf-item">
				<figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_delivery.png" alt=""></figure>
				<div class="bnf-info">
					<p>신속하고 안전하게</p>
					<div class="bnf-name">무료배송</div>
				</div>
			</div>
			<p class="tip"><strong><i class="badge-delivery">무료배송</i>무료배송스티커</strong>가 붙은 상품 구매시 무료배송!</p>
		</div>
	</div>
	<% Else %>
	<div class="bnf-cont">
		<div class="bnf1">
			<a href="/diarystory2021/special_benefit.asp" onclick="window.open(this.href, 'popbenefit', 'width=800,height=800,left=300,scrollbars=auto,resizable=yes'); return false;" target="_blank">
				<ul class="bnf-item" style="width:800px; justify-content:space-evenly;">
					<li>
						<figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_gift1.png" alt=""></figure>
						<div class="bnf-info" style="font-size:15px;">
							<p>15,000원 이상</p>
							<div class="bnf-name">다꾸파우치</div>
						</div>
					</li>
					<li>
						<figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_gift2.png" alt=""></figure>
						<div class="bnf-info" style="font-size:15px;">
							<p>30,000원 이상</p>
							<div class="bnf-name">스티커북</div>
						</div>
					</li>
					<li>
						<figure class="bnf-img"><img src="//fiximage.10x10.co.kr/web2020/diary2021/img_gift3.png" alt=""></figure>
						<div class="bnf-info" style="font-size:15px;">
							<p>60,000원</p>
							<div class="bnf-name">다꾸라벨기</div>
						</div>
					</li>
				</ul>
			</a>
			<p class="tip">
				<strong><i class="badge-gift">선물</i>선물스티커</strong>가 붙은 상품 포함하여 구매시 금액대별 사은품 증정!
				<a href="/diarystory2021/special_benefit.asp" onclick="window.open(this.href, 'popbenefit', 'width=800,height=800,left=300,scrollbars=auto,resizable=yes'); return false;" class="btn-benefit" style="margin:0 0 0 5px;">선물 자세히 보기</a>
			</p>
		</div>
	</div>
	<% End If %>
</section>
<% end if %>