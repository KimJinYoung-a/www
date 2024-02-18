<%'<!-- 티저 (12/14~12/15 23:59) -->%>
<div class="time-teaser">
    <div class="time-top">
        <div class="inner">
            <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/tit_time_deal<%=chkIIF(DateDiff("d", evtDate, date()) = -1, "_2", "" )%>.jpg" alt="이건 기회야 내일 단 하루 오전9시 부터 오후 12시까지 단 4번의 타임세일"></h2>
            <div id="slideshow" class="slideshow">
                <div class="active"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_item1.png" alt="am9"></div>
                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_item2.png" alt="pm12"></div>
                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_item3.png" alt="pm4"></div>
                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_item4.png" alt="pm8"></div>
            </div>
        </div>
    </div>
    <div class="teaser-item"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/img_teaser_item.jpg" alt="각 시간대별 상품 리스트"></div>
    <div class="alarm">
        <div class="inner">
            <div>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_timer.png" alt="하루, 단 4번의 세일찬스. 놓치면 정말정말 아깝다구요!"></p>
                <div class="sale-timer"><span>-</span><span id="countdown">00:00:00</span></div>
            </div>
            <button class="btn-alarm btn-alarm1">세일 시작전 알림받기</button>
        </div>
    </div>
</div>