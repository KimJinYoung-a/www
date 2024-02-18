<%
    dim curDate
    curDate = date()
    'TEST
    'curDate = Cdate("2019-10-30")
%>
<!-- 취향 -->
<div class="taste" id="taste">
    <div class="inner">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/tit_taste.png" alt="오늘, 당신의 취향"></h3>
        <div class="qr-code"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_qr_code.png" alt="qr 코드"></div>
        <div class="bnfit"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/txt_benefit.png" alt="special gift, gift card"></div>
    </div>
</div>
<!--// 취향 -->

<!-- 마케팅 배너 -->
    <div class="bnr-mkt">
    <div class="inner">
        <%'1. 스케줄 표 참고 https://docs.google.com/spreadsheets/d/1qx1xo7_lmVjMp0FsJpgLlyzJ7ENP3_Hib3Q1_qPIvSE/edit#gid=1539300381 %>            
        <%'2. '10/11~''  배너는 추후 시안 전달 예정 %>            
        <% if ( curDate >= Cdate("2019-09-27") and curDate <= Cdate("2019-10-10") ) then %>
        <!-- 10/1-10 -->
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/bnr_mkt_evt.jpg" alt="마케팅 배너" usemap="#bnr-map">
        <map name="bnr-map">
            <area onfocus="this.blur();" alt="지금 즉시 사용하는 할인 쿠폰" href="/my10x10/couponbook.asp" coords="3,2,380,158" shape="rect">
            <area onfocus="this.blur();" alt="뽑기에 성공하면 이 상품들이 100원!?" href="/event/eventmain.asp?eventid=97449" coords="381,2,759,159" shape="rect">
            <area onfocus="this.blur();" alt="메일 수신 동의하고 10,000 마일리지 받자!" href="/event/eventmain.asp?eventid=96333" coords="761,1,1139,158" shape="rect">
        </map>
        <% end if %>

        <% if ( curDate >= Cdate("2019-10-11") and curDate <= Cdate("2019-10-13") ) then %>
        <!-- 10/11-13 -->
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/bnr_mkt_evt2.jpg" alt="마케팅 배너" usemap="#bnr-map">
        <map name="bnr-map">
            <area target="_blank" onfocus="this.blur();"alt="매일리지 1차" href="/event/eventmain.asp?eventid=97540" coords="3,2,380,158" shape="rect">
            <area target="_blank" onfocus="this.blur();"alt="지금 즉시 사용하는 할인 쿠폰" href="/my10x10/couponbook.asp" coords="381,2,759,159" shape="rect">
            <area target="_blank" onfocus="this.blur();"alt="메일 수신 동의하고 10,000 마일리지 받자!" href="/event/eventmain.asp?eventid=96333" coords="761,1,1139,158" shape="rect">
        </map>
        <% end if %>

        <% if ( curDate >= Cdate("2019-10-14") and curDate <= Cdate("2019-10-19") ) then %>
        <!-- 10/14-19 -->
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/bnr_mkt_evt3.jpg" alt="마케팅 배너" usemap="#bnr-map">
        <map name="bnr-map">
            <area target="_blank" onfocus="this.blur();"alt="비밀번호" href="/event/eventmain.asp?eventid=97805" coords="3,2,380,158" shape="rect">
            <area target="_blank" onfocus="this.blur();"alt="매일리지 1차" href="/event/eventmain.asp?eventid=97540" coords="381,2,759,159" shape="rect">
            <area target="_blank" onfocus="this.blur();"alt="지금 즉시 사용하는 할인 쿠폰" href="/my10x10/couponbook.asp" coords="761,1,1139,158" shape="rect">
        </map>
        <% end if %>

        <% if ( curDate >= Cdate("2019-10-20") and curDate <= Cdate("2019-10-20") ) then %>
        <!-- 10/20 -->
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/bnr_mkt_evt4.jpg" alt="마케팅 배너" usemap="#bnr-map">
        <map name="bnr-map">
            <area target="_blank" onfocus="this.blur();"alt="지금 즉시 사용하는 할인 쿠폰" href="/my10x10/couponbook.asp" coords="3,2,380,158" shape="rect">
            <area target="_blank" onfocus="this.blur();"alt="비밀번호" href="/event/eventmain.asp?eventid=97805" coords="381,2,759,159" shape="rect">
            <area target="_blank" onfocus="this.blur();"alt="메일 수신 동의하고 10,000 마일리지 받자!" href="/event/eventmain.asp?eventid=96333" coords="761,1,1139,158" shape="rect">
        </map>
        <% end if %>

        <% if ( curDate >= Cdate("2019-10-21") and curDate <= Cdate("2019-10-29") ) then %>
        <!-- 10/21-29 -->
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/bnr_mkt_evt5.jpg" alt="마케팅 배너" usemap="#bnr-map">
        <map name="bnr-map">
            <area target="_blank" onfocus="this.blur();"alt="매일리지 2차" href="/event/eventmain.asp?eventid=97566" coords="3,2,380,158" shape="rect">
            <area target="_blank" onfocus="this.blur();"alt="지금 즉시 사용하는 할인 쿠폰" href="/my10x10/couponbook.asp" coords="381,2,759,159" shape="rect">
            <area target="_blank" onfocus="this.blur();"alt="비밀번호" href="/event/eventmain.asp?eventid=97805" coords="761,1,1139,158" shape="rect">
        </map>
        <% end if %>


        <% if ( curDate >= Cdate("2019-10-30") and curDate <= Cdate("2019-10-31") ) then %>
        <!-- 10/30-31 -->
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/bnr_mkt_evt6.jpg" alt="마케팅 배너" usemap="#bnr-map">
        <map name="bnr-map">
            <area target="_blank" onfocus="this.blur();"alt="지금 즉시 사용하는 할인 쿠폰" href="/my10x10/couponbook.asp" coords="3,2,380,158" shape="rect">
            <area target="_blank" onfocus="this.blur();"alt="매일리지 2차" href="/event/eventmain.asp?eventid=97566" coords="381,2,759,159" shape="rect">
            <area target="_blank" onfocus="this.blur();"alt="비밀번호" href="/event/eventmain.asp?eventid=97805" coords="761,1,1139,158" shape="rect">
        </map>
        <% end if %>
    </div>
</div>
<!--// 마케팅 배너 -->