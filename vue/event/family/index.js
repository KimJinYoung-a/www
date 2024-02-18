const app = new Vue({
    el: '#app'
    , store : store
    , template : `
        <div class="evt117931">
            <section class="section01">
                <p class="title01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/tit.png" alt=""></p>
                <div class="pre_wrap">
                    <p class="present"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/present.png" alt=""></p>
                    <div class="deco_wrap">
                        <p class="deco01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/deco01.png" alt=""></p>
                        <p class="deco02"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/deco02.png" alt=""></p>
                        <p class="deco03"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/deco03.png" alt=""></p>
                        <p class="deco04"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/deco04.png" alt=""></p>
                    </div>
                    <div class="overwrap">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/overwrap.png?v=1.02" alt="">
                        <p class="sale" id="section01_sale">~<span>90</span>%</p>
                        <p class="coupon" id="section01_coupon">~<span>50</span>%</p>
                    </div>
            </section>
            <section class="section02"></section>
            <section class="section03">
                <div class="prd_wrap">
                    <ul id="item01">
                        <li>
                            <a onclick="goProduct('4530311')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('2820179')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4548268')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('2805630')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </section>
            <section class="section04">
                <div class="swiper mySwiper">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll01_01.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll01_02.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll01_03.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll01_04.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll01_05.png" alt=""></div>
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
            </section>
            <section class="section05">
                <div class="prd_wrap">
                    <ul id="item02">
                        <li>
                            <a onclick="goProduct('4521579')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3687781')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4538189')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3761224')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4535944')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4548336')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4535946')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3733127')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </section>
            <section class="section06">
                <div class="swiper mySwiper">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll02_01.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll02_02.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll02_03.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll02_04.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll02_05.png" alt=""></div>
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
            </section>
            <section class="section07">
                <div class="prd_wrap">
                    <ul id="item03">
                        <li>
                            <a onclick="goProduct('4531517')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4535903')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('2336227')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3420878')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3175412')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3652964')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3627654')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('2445744')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </section>
            <section class="section08">
                <div class="swiper mySwiper">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll03_01.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll03_02.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll03_03.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll03_04.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll03_05.png" alt=""></div>
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
            </section>
            <section class="section09">
                <div class="prd_wrap">
                    <ul id="item04">
                        <li>
                            <a onclick="goProduct('4113008')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('2063632')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4315489')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4412021')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4185384')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3992593')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3152949')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4108916')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </section>
            <section class="section10">
                <div class="swiper mySwiper">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll04_01.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll04_02.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll04_03.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll04_04.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll04_05.png" alt=""></div>
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
            </section>
            <section class="section11">
                <div class="prd_wrap">
                    <ul id="item05">
                        <li>
                            <a onclick="goProduct('2552091')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3770621')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3516003')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3670030')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4379535')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3293813')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('2986474')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4421789')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </section>
            <section class="section12">
                <div class="swiper mySwiper">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll05_01.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll05_02.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll05_03.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll05_04.png" alt=""></div>
                        <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/roll05_05.png" alt=""></div>
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
            </section>
            <section class="section13">
                <div class="prd_wrap">
                    <ul id="item06">
                        <li>
                            <a onclick="goProduct('4509539')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('1381184')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4442797')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4536548')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('2179672')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4373124')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('3812523')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a onclick="goProduct('4493575')" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </section>
            <section class="section14">
                <div class="evt_wrap">
                    <a onclick="goEventLink('117972');" href="javascript:void(0)" class="evt01"></a>
                    <a onclick="goEventLink('118145');" href="javascript:void(0)" class="evt02"></a>
                    <a onclick="goEventLink('118146');" href="javascript:void(0)" class="evt03"></a>
                    <a onclick="goEventLink('117911');" href="javascript:void(0)" class="evt04"></a>
                </div>
            </section>
            <section class="category-wrap">
                <h3><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/section10_tit.png" alt="5월의 선물 키워드"></h3>
                <div class="type">
                    <ul>
                        <li>
                            <input type="radio" name="type" id="type1" />
                            <label @click="show_tab_item('400945')" for="type1"><span>Carnations</span><strong>카네이션</strong></label>
                        </li>
                        <li>
                            <input type="radio" name="type" id="type2" />
                            <label @click="show_tab_item('400946')" for="type2"><span>Pocket</span><strong>센스있는선물</strong></label>
                        </li>
                        <li>
                            <input type="radio" name="type" id="type3" />
                            <label @click="show_tab_item('400947')" for="type3"><span>Parents</span><strong>건강&효도</strong></label>
                        </li>
                        <li>
                            <input type="radio" name="type" id="type4" />
                            <label @click="show_tab_item('400948')" for="type4"><span>Toys</span><strong>뷰티&리빙</strong></label>
                        </li>
                        <li>
                            <input type="radio" name="type" id="type5" />
                            <label @click="show_tab_item('400949')" for="type5"><span>Devices</span><strong>어린이날</strong></label>
                        </li>                        
                    </ul>
                </div>
                <div class="item-box">
                    <div class="items type-thumb item-240 prd_wrap">
                        <ul id="itemList"></ul>
                    </div>
                    <a v-if="last_page > page" @click="show_more" href="javascript:void(0)" class="more"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117931/btn_more.png" alt=""></a>
                </div>
                
            </section>
        </div>
    `
    , created() {
        this.$store.commit("SET_EVT_CODE", this.get_url_param("eventid"));
        this.$store.dispatch("GET_EVENT_ITEM");

        this.$nextTick(function() {
            let swiper_image = new Swiper(".mySwiper", {
                autoplay:true,
                loop:true,
                speed:500,
                pagination: {
                    el: ".swiper-pagination"
                },
            });

            getEvtSalePer(117931, 'section01_sale');
            getEvtCouponSalePer(117931, 'section01_coupon');

            fnApplyItemInfoList({
                items:"4530311,2820179,4548268,2805630",      // 상품코드
                target:"item01",
                fields:["image","price","brand","name", "sale"],
                unit:"hw",
                saleBracket:true
            });

            fnApplyItemInfoList({
                items:"4521579,3687781,4538189,3761224,4535944,4548336,4535946,3733127",      // 상품코드
                target:"item02",
                fields:["image","price","brand","name", "sale"],
                unit:"hw",
                saleBracket:true
            });

            fnApplyItemInfoList({
                items:"4531517,4535903,2336227,3420878,3175412,3652964,3627654,2445744",      // 상품코드
                target:"item03",
                fields:["image","price","brand","name", "sale"],
                unit:"hw",
                saleBracket:true
            });

            fnApplyItemInfoList({
                items:"4113008,2063632,4315489,4412021,4185384,3992593,3152949,4108916",      // 상품코드
                target:"item04",
                fields:["image","price","brand","name", "sale"],
                unit:"hw",
                saleBracket:true
            });

            fnApplyItemInfoList({
                items:"2552091,3770621,3516003,3670030,4379535,3293813,2986474,4421789",      // 상품코드
                target:"item05",
                fields:["image","price","brand","name", "sale"],
                unit:"hw",
                saleBracket:true
            });

            fnApplyItemInfoList({
                items:"4509539,1381184,4442797,4536548,2179672,4373124,3812523,4493575",      // 상품코드
                target:"item06",
                fields:["image","price","brand","name", "sale"],
                unit:"hw",
                saleBracket:true
            });
        });
    }
    , mounted(){
        const _this = this;
    }
    , computed : {
        evt_code(){
            return this.$store.getters.evt_code;
        }
        , page(){
            return this.$store.getters.page;
        }
        , event_item(){
            return this.$store.getters.event_item;
        }
        , last_page(){
            return this.$store.getters.last_page;
        }
        , evtgroup_code(){
            return this.$store.getters.evtgroup_code;
        }
        , evtgroup_index(){
            return this.$store.getters.evtgroup_index;
        }
    }
    , data(){
        return {
            is_saving : false
        }
    }
    , methods : {
        format_price(price){
            if(price){
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
        }
        , get_url_param(param_name){
            let now_url = location.search.substr(location.search.indexOf("?") + 1);
            now_url = now_url.split("&");
            let result = "";
            for(let i = 0; i < now_url.length; i++){
                let temp_param = now_url[i].split("=");
                if(temp_param[0] == param_name){
                    result = temp_param[1].replace("%20", " ");
                }
            }

            return result;
        }
        , show_tab_item(group_id){
            this.$store.commit("SET_PAGE", 1);
            this.$store.commit("SET_EVTGROUP_CODE", group_id);
            this.$store.dispatch("GET_EVENT_ITEM");
        }
        , show_more(){
            this.$store.commit("SET_PAGE", this.page + 1);
            this.$store.dispatch("GET_EVENT_ITEM");
        }
    }
    , watch : {

    }
});