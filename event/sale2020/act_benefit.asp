<%
dim currentDate
currentDate = date()
'currentDate = "2020-04-20"
%>
<% if currentDate >= "2020-04-10" and currentDate <= "2020-04-17" then %>
<li>
	<a href="/event/eventmain.asp?eventid=101990" target="_blank">
		<img src="//webimage.10x10.co.kr/fixevent/event/2020/sale2020/index/img_benefit9.jpg" alt="백원자판기">
	</a>
</li>
<% end if %>

<% if currentDate <= "2020-04-10" then %>
<li>
	<a href="/my10x10/goodsusing.asp" target="_blank">
		<img src="//webimage.10x10.co.kr/fixevent/event/2020/sale2020/index/img_benefit8_v3.jpg" alt="포토후기 작성하면 +500P를 드려요!">
	</a>
</li>
<% elseif currentDate >= "2020-04-13" then %>
<li>
	<a href="/my10x10/goodsusing.asp" target="_blank">
		<img src="//webimage.10x10.co.kr/fixevent/event/2020/sale2020/index/img_benefit8_v4.jpg" alt="포토후기 작성하면 +500P를 드려요!">
	</a>
</li>
<% end if %>

<% if currentDate <= "2020-04-12" then %>
<li>
	<a href="/event/eventmain.asp?eventid=101391" target="_blank">
		<img src="//webimage.10x10.co.kr/fixevent/event/2020/sale2020/index/img_benefit2.jpg?v=1.01" alt="APP푸시 동의하면 최대 1,000p 를 드려요!">
	</a>
</li>
<% elseif currentDate >= "2020-04-13" and currentDate <= "2020-04-18" then %>
<li>
	<a href="/event/eventmain.asp?eventid=101391" target="_blank">
		<img src="//webimage.10x10.co.kr/fixevent/event/2020/sale2020/index/img_benefit2_v2.jpg" alt="APP푸시 동의하면 최대 1,000p 를 드려요!">
	</a>
</li>
<% end if %>

<li>
	<a href="/event/eventmain.asp?eventid=101305" target="_blank">
		<img src="//webimage.10x10.co.kr/fixevent/event/2020/sale2020/index/img_benefit3.jpg?v=1.01" alt="지금 토스로 6만원이상 결제하면 5천원 즉시할인">
	</a>
</li>
<li>
	<a href="/event/eventmain.asp?eventid=96333" target="_blank">
		<img src="//webimage.10x10.co.kr/fixevent/event/2020/sale2020/index/img_benefit5.jpg?v=1.01" alt="이메일 동의하고 매달 10,000p에 도전하세요!">
	</a>
</li>
<li>
	<a href="/clearancesale/" target="_blank">
		<img src="//webimage.10x10.co.kr/fixevent/event/2020/sale2020/index/img_benefit6.jpg?v=1.01" alt="최대 90% 숨겨져 있는 보물같은 할인 상품들">
	</a>
</li>
<li>
  <button onclick="{$('html, body').animate({scrollTop: $('.tab-wrap').offset().top}, 0);initTabDisplay('dt');init('dt',1,''); return false;}">
    <img src="//webimage.10x10.co.kr/fixevent/event/2020/sale2020/index/btn_best.jpg" alt="잠깐만요, 베스트상품보셨어요?">
	</button>
</li>