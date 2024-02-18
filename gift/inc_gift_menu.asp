<%
'###########################################################
' Description :  기프트
' History : 2015.02.02 한용민 생성
'###########################################################

'# 현재 페이지명 접수
dim nowViewPage_hint
nowViewPage_hint = request.ServerVariables("SCRIPT_NAME")
%>
<div class="inner">
	<h2><a href="/gift/talk/?gaparam=main_menu_gift"><img src="http://fiximage.10x10.co.kr/web2018/gift/tit_gift.png" alt="gift talk"></a></h2>
	<div class="navigator">
		<a href="/shoppingtoday/gift_recommend.asp" class="giftguide">선물포장 서비스</a>
		<a href="/gift/WRAPPING.asp" class="wrapping<% if lcase(nowViewPage_hint)=lcase("/gift/WRAPPING.asp") then response.write " on" %>">WRAPPING</a>
		<a href="/cscenter/giftcard/index.asp" class="giftcard<% if lcase(nowViewPage_hint)=lcase("/cscenter/giftcard/index.asp") then response.write " on" %>">GIFT CARD</a>
	</div>
</div>