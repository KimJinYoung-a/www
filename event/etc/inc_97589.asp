<link rel="stylesheet" type="text/css" href="/lib/css/anniversary18th.css?v=3.00">
<script>
$(function(){
    // 스크롤
    $('.scrollD a').click(function(event){
        event.preventDefault();
        window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
    });
    
    $('.shape').slick({
        pauseOnHover: false,
        dots: true,
        fade: true
    })
    $('.rolling').slick({
        pauseOnHover: false,
        dots: true,
        autoplay: true,
    })
})
</script>


                            <!-- 18주년사은이벤트:스누피의선물 -->
                            <div class="anniversary18th gift">
                                <!-- 주년 헤드 -->
                                <div class="intro">
                                    <div class="inner">
                                        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/tit_18th.png" alt="18th Your 10X10"></h2>
                                        <ul class="nav">
                                            <li class="scrollD"><a href="#taste">오늘의 취향? <span class="icon-chev"></span></a></li>
                                            <li><a href="/event/eventmain.asp?eventid=97588">나에게 텐바이텐은? <span class="icon-chev"></span></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <!--// 주년 헤드 -->

                                <!-- 스누피의선물 -->
                                <span class="img-bg"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_top.jpg?v=1.01" alt="스누피의 선물"></span>
                                <div class="guide">
                                    <div class="shape">
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_price_frt.jpg" alt="front"></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_price_bk.jpg" alt="back"></div>
                                    </div>
                                    <span class="img-bg"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_price_bottom_v2.jpg" alt="구매 금액별 스누피 선물"></span>
                                </div>
                                <div class="prd-area">
                                    <span class="img-bg"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_prd_1.jpg" alt="18th 10X10 Edition Peanuts hug Mug"></span>
                                    <div class="rolling">
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_1.jpg" alt=""></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_2.jpg" alt=""></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_3.jpg" alt=""></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_4.jpg" alt=""></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_5.jpg" alt=""></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_6.jpg" alt=""></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_7.jpg" alt=""></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_8.jpg" alt=""></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_9.jpg" alt=""></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_10.jpg" alt=""></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_slide_11.jpg" alt=""></div>
                                    </div>
                                </div>
                                <% ' 10월7일00시부터 노출
                                'If date() < "2019-10-01" Then 
                                If date() > "2019-10-06" Then 
                                %>
                                <div class="buy-area">
                                    <span class="img-bg"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_prd_2.jpg" alt="같이 쓰면 더 좋은 피넛츠 허그 머그 할인"></span>
                                    <a href="/event/eventmain.asp?eventid=97535" class="btn_buy"></a>
                                </div>
                                <% End if %>
                                <div class="noti">
                                    <div class="inner">
                                        <div>
                                            <h3>꼭 읽어보세요! </h3>
                                            <ul>
                                                <li>텐바이텐 사은 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 구매 시, 증정 불가) </li>
                                                <li>텐바이텐 배송 상품을 포함해야 사은품 선택이 가능합니다. <br>
                                                    <a href="/event/eventmain.asp?eventid=89269" style="color:#fff">텐바이텐 배송상품 보러가기 &gt;</a></li>
                                                <li>업체배송 상품으로만 구매 시 마일리지만 선택 가능합니다. </li>
                                                <li>상품 쿠폰, 보너스 쿠폰 등의 사용 후 구매 확정액이 4/25만원 이상이어야 합니다. <br />(단일주문건 구매 확정액) </li>
                                                <li>마일리지, 예치금, Gift카드를 사용하신 사용하신 경우는 구매확정 금액에 포함되어 <br />사은품을 받으실 수 있습니다.</li>
                                            </ul>
                                        </div>
                                        <div>
                                            <ul>
                                                <li>텐바이텐 Gift카드를 구매하신 경우에는 사은품 증정이 되지 않습니다. </li>
                                                <li>마일리지는 차후 일괄 지급됩니다. <br>1차 : 10월 01일 ~ 11일 구매자 (21일 지급)<br>2차 : 10월 12일 ~ 22일 구매자 (30일 지급)<br>3차 : 10월 23일 ~ 31일(11월 8일 지급)</li>
                                                <li>본 마일리지는 11월 30일 23시 59분 59초까지 사용가능한 스페셜 마일리지입니다. </li>
                                                <li>기간 내에 사용하지 않은 마일리지는 자동 소멸됩니다.   </li>
                                                <li>환불이나 교환 시, 최종 구매가격이 사은품 수령 가능금액 미만일 경우 <br />사은품과 함께 반품해야 합니다. </li>
                                                <li>구매 금액별 선물은 한정 수량으로 조기 소진될 수 있습니다.</li>
                                                <li>[18th edition] Peanuts hug mug set(4P) 10월 10일부터 별도 배송될 예정입니다.</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- 스누피의선물 -->
                                
                                <!-- 주년 마케팅 배너 -->
                                <!-- #include virtual="/event/18th/inc_banner.asp" -->
                                <!--// 주년 마케팅 배너 -->
                            </div>
                            <!-- // 18주년사은이벤트:스누피의선물 -->

