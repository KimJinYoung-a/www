<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 월요쿠폰 - gatepage
' History : 2018-07-27 이종화
'####################################################
%>
<style>
.evt90776 h2 {visibility:hidden; width:0; height:0;}
.coupon {position:relative;}
.coupon .only-app {position:absolute; left:50%; top:64px; margin-left:174px; animation:bounce 1s 30;}
.evtNoti {position:relative; padding:40px 0 40px 470px; text-align:left; background:#282f39;}
.evtNoti h3 {position:absolute; left:284px; top:50%; margin-top:-10px;}
.evtNoti ul {padding:0 0 0 60px; border-left:1px solid rgba(255,255,255,0.3);}
.evtNoti li {padding:3px 0; color:#fff;}
.evtNoti li.pointcolor{color: #ff8686; font-weight: bold;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
</style>
<div class="evt90776">
    <h2>서프라이즈쿠폰</h2>
    <div class="coupon">
        <div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90776/img_coupon.png" alt="5만원 이상 구매 시 20만원 이상 구매 시 " /></div>
    </div>
    <div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90776/img_qr.png" alt="지금 QR코드로 텐바이텐 앱에서 쿠폰을 발급받으세요!" /></div>
    <div class="evtNoti">
        <h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/88275/tit_noti.png" alt="이벤트 유의사항"></h3>
        <ul>
            <li>- 본 이벤트는 ID 당 1일 1회만 참여할 수 있습니다. </li>
            <li class="pointcolor">- 쿠폰은 텐바이텐 APP에서만 발급 가능 합니다.</li>
            <li>- 쿠폰은 11/26(월) 23시 59분 59초에 종료됩니다.</li>
            <li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
            <li>- 이벤트는 조기 마감될 수 있습니다. </li>
        </ul>
    </div>
</div>
