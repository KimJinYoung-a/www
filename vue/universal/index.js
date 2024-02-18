Vue.use(VueAwesomeSwiper);
Vue.use(VueLazyload, {
    preLoad: 1.3,
    loading : false,
    attempt : 1
});

const app = new Vue({
    el: '#app'
    , store : store
    , template : `
        <div class="univarsal">
            <article class="main-bnr">
                <div class="logo"><img src="//webimage.10x10.co.kr/fixevent/event/2022/universal/img_logo.png?v=2" alt="logo"></div>
                <!-- 크게보기 화면 -->
                <div v-show="child_character_show_type == 'big'" class="main-swiper w1060">
                    <swiper v-if="child_character_tab.length" :options="character_swiper" class="swiper-container one">
                        <swiper-slide v-for="item in child_character_tab" :key="item.attribCd">
                            <button type="button" class="btn-reverse">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/universal/m/icon_reverse.png" alt="카드 뒤집기">
                            </button>
                            <div class="thumbnail on"><img :src="item.image1 + '/10x10/resize/306/format/jpg'" alt=""></div>
                            <div class="thumbnail-hidden"><img v-lazy="item.image2 + '/10x10/resize/306/format/jpg'" class="lazyload" alt=""></div>
                            <div class="main-prd-view">
                                <a @click="go_detail(item.attribDiv, item.attribName, '배너')" href="javascript:void(0)">
                                    <span class="view-all">{{item.attribName}} 상품 전체보기</span>
                                </a>
                            </div>
                        </swiper-slide>
                        
                        <div class="swiper-button-next" slot="button-next"></div>
                        <div class="swiper-button-prev" slot="button-prev"></div>
                    </swiper>
                </div>
                <!-- 많이보기 화면 -->
                <div v-show="child_character_show_type == 'small'" class="main-sm-bnr">
                    <ul class="ch-list">
                        <li v-for="(item, index) in child_character_tab" :class="'ch-0' + (index+1)">
                            <img @click="active_banner_character = item" v-lazy="item.image3" alt="캐릭터">
                        </li>
                    </ul>
                </div>
                <!-- 많이보기 캐릭터 디테일 -->
                <div class="main-ch-detail">
                    <div class="dim"></div>
                    <div class="main-sm-detail">
                        <div class="info ch-01">
                            <img v-if="active_banner_character.image2" v-lazy="active_banner_character.image2" alt="">
                            <div class="main-prd-view">
                                <a @click="go_detail(active_banner_character.attribDiv, active_banner_character.attribName, '배너')" href="javascript:void(0)">
                                    <span class="view-all">{{active_banner_character.attribName}} 상품 전체보기</span>
                                </a>
                            </div>
                        </div>
                        <button type="button" class="btn-close"><img v-lazy="'//webimage.10x10.co.kr/fixevent/event/2022/universal/m/icon_close.png'" class="lazyload" alt="닫기"></button>
                    </div>
                </div>
                <div class="bnr-type-area">
                    <button @click="click_showtype('big')" type="button" class="btn-big on"><span class="icon"></span>크게 보기</button>
                    <button @click="click_showtype('small')" type="button" class="btn-many"><span class="icon"></span>많이 보기</button>
                </div>
            </article>
            <article class="main-contents">
                <section class="banner-area">
                    <div class="swiper-container swiper-bnr">
                        <div class="swiper-wrapper">
                            <div v-for="(item, index) in events_slidebanner" class="swiper-slide">
                                <a @click="go_slidebanner(item.linkurl, index)" href="javascript:void(0)"><img v-lazy="item.imageurl" alt="banner"></a>
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                </section>
                
                <!-- MD가 추천해요 -->
                <section class="universal-md-pick universal-list w1060">
                    <div class="h-group">MD가 추천해요<span class="icon"></span></div>
                    <ul>
                        <li v-for="(item, index) in mdpick">
                            <a @click="send_amplitude('click_universal_mdpick', '{&quot;number&quot; : ' + (index+1) + ', &quot;itemid&quot; : ' + item.itemid + '}')" :onclick="'goProduct(' + item.itemid + ')'" href="javascript:void(0)">
                                <div class="desc">
                                    <div class="thumbnail"><img v-lazy="decodeBase64(item.itemimage)" alt="더미 이미지"></div>
                                    <div class="price"><span class="sum">{{format_price(item.sellcash)}}</span><span v-show="item.salePer > 0" class="discount">{{parseInt(item.salePer)}}%</span></div>
                                    <div class="txt">{{item.itemname}}</div>
                                    <div v-if="item.favcount > 0 && item.totalpoint >= 4" class="user_side">
                                        <span class="user_eval"><dfn>평점</dfn><i :style="'width: ' + (item.totalpoint*20) + '%;'"></i></span> 
                                        <span class="user_comment"><dfn>상품평</dfn>{{format_price(item.evalcnt)}}</span>
                                    </div>
                                </div>
                            </a>
                        </li>                        
                    </ul>
                </section>
                
                <!-- 놓치면 아쉬운 기획전이에요 -->
                <section v-if="events_eventbanner.length > 0" class="universal-exhibition w1060">
                    <div class="h-group top">놓치면 아쉬운<br/>기획전이에요</div>
                    <div class="swiper-container two">
                        <ul class="exhibition-wrap swiper-wrapper">
                            <li v-for="(item, index) in events_eventbanner" class="swiper-slide">
                                <a @click="send_amplitude('click_universal_event', '{&quot;number&quot; : ' + (index+1) + ', &quot;eventid&quot; : ' + item.evt_code + '}')" :onclick="'goEventLink(' + item.evt_code + ')'" href="javascript:void(0)">
                                    <div class="desc">
                                        <div class="thumbnail"><img v-lazy="item.bannerImage" alt="더미 이미지"></div>
                                        <div class="headline">
                                            <p class="tit"><span>{{item.evt_name}}</span> <span v-show="item.salePer > 0" class="discount">~{{item.salePer}}%</span></p>
                                            <p class="sub">{{item.evt_subcopyK}}</p>
                                        </div>
                                    </div>
                                </a>
                                <div class="headline">
                                    <ul class="key-word">
                                        <li v-for="tagItem in item.evt_tag"><a href="javascript:void(0)"><span class="tag">#</span>{{tagItem}}</a></li>
                                    </ul>
                                </div>
                                <div class="character-line">
                                    <template v-for="(attribCdItem, attribCdIndex) in item.attribCd">
                                        <div v-if="attribCdIndex < 3" class="proflie"><img v-lazy="attribCdItem" alt=""></div>
                                    </template>
                                    <div v-show="item.attribCd && item.attribCd.length > 3" class="proflie"></div>
                                </div>
                            </li>                            
                        </ul>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                        <div class="bg-right"></div>
                        <div class="bg-left"></div>
                    </div>
                </section>
                <!-- 캐릭터 별 제일 잘 나가요 -->
                <section class="universal-best universal-list w1060">
                    <!-- 캐릭터 선택 메뉴 -->
                    <div class="swiper-container three">
                        <ul class="swiper-wrapper">
                            <li class="swiper-slide slide01 active">
                                <button @click="go_bestitem(0, '', '전체')" type="button"><span class="icon"></span> 전체</button>
                            </li>
                            <li v-for="(item, index) in parents_character_tab" :class="['swiper-slide', 'slide0' + (index+2)]">
                                <button @click="go_bestitem(index+1, item.attribDiv, item.attribDivName)" type="button"><span class="icon"></span> {{item.attribDivName}}</button>
                            </li>
                        </ul>
                    </div>
                    <div class="h-group top">캐릭터 별<br/>제일 잘 나가요</div>
                    <!-- 상품 리스트 -->
                    <div class="best-list">
                        <ul>
                            <li v-for="(item, index) in bestitem" :key="item.item_id">
                                <a @click="click_bestitem(index, item.item_id)" :onclick="'goProduct('  + item.item_id + ')'" href="javascript:void(0)">
                                    <div class="desc">
                                        <div class="thumbnail">
                                            <img v-lazy="decodeBase64(item.list_image)" alt="더미 이미지">
                                            <!-- 2022-06-10추가 -->
                                            <span class="badge">{{index+1}}</span>
                                            <!-- // -->
                                        </div>
                                        <div class="price">
                                            <span class="sum">{{format_price(item.item_price)}}</span>
                                            <span v-show="item.sale_percent > 0" class="discount">{{item.sale_percent}}%</span>
                                        </div>
                                        <div class="txt">{{item.item_name}}</div>
                                        <div v-if="item.review_cnt > 0 && item.totalpoint >= 4" class="user_side">
                                            <span class="user_eval"><dfn>평점</dfn><i :style="'width: ' + (item.review_rating*20) + '%;'"></i></span> 
                                            <span class="user_comment"><dfn>상품평</dfn>{{item.review_cnt}}</span>
                                        </div>
                                    </div>
                                </a>
                            </li>                            
                        </ul>
                    </div>
                    <!-- // -->
                    <div class="btn-area">
                        <a @click="go_detail(active_best_character.attribDiv, null, '베스트')" href="javascript:void(0)" class="click-area">{{active_best_character.attribDivName}} 상품 더보기</a>
                    </div>
                </section>
                
                <!-- 하늘 아래 똑같은 미니언은 없다! -->
                <section class="universal-type01 top w1060 relative">
                    <div class="h-group">하늘 아래<br/>똑같은 미니언은 없다!</div>
                    <div class="visual-area">
                        <div class="fade-swiper">
                            <!-- slide -->
                            <div class="slider">
                                <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/universal/img_loop.jpg/10x10/resize/3117/optimize" alt="미니언즈"></div>
                                <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/universal/img_loop.jpg/10x10/resize/3117/optimize" alt="미니언즈"></div>
                            </div>
                        </div>
                        <!-- 2022-06-10추가 -->
                        <div class="bg-left"></div>
                        <div class="bg-right"></div>
                        <!-- // -->
                    </div>
                    <div v-if="character_item.length > 0" class="contents">
                        <ul>
                            <li v-for="item in character_item[0].items.items" class="prd_item">
                                <a @click="send_amplitude('click_universal_introduce', '{&quot;character&quot; : &quot;미니언즈&quot;, &quot;itemid&quot; : ' + item.item_id + '}')" :onclick="'goProduct(' + item.item_id + ')'" href="javascript:void(0)">
                                    <figure class="prd_img">
                                        <img v-lazy="decodeBase64(item.list_image)" alt="상품명">
                                    </figure>
                                    <div class="prd_info">
                                        <div class="prd_price">
                                            <span class="set_price"><dfn>판매가</dfn>{{format_price(item.item_price)}}</span>
                                            <span v-show="item.sale_percent > 0" class="discount"><dfn>할인율</dfn>{{item.sale_percent}}%</span>
                                        </div>
                                        <div class="prd_name">{{item.item_name}}</div>
                                    </div>
                                </a>
                            </li>                            
                        </ul>
                    </div>
                    <div class="btn-area">
                        <a @click="go_detail(character_item[0].attribDiv, null, '캐릭터 소개')" href="javascript:void(0)" class="click-area">미니언즈 상품 더보기</a>
                    </div>
                </section>
                <!-- 유니버설 클래식 친구들을 소개합니다! -->
                <section v-if="character_item.length > 0" class="universal-type01 universal-type02 top w1140">
                    <div class="banner">
                        <div class="h-group">유니버설 클래식<br/>친구들을 소개합니다!</div>
                        <img v-lazy="'//webimage.10x10.co.kr/fixevent/event/2022/universal/img_uni_classic.jpg/10x10/resize/1140/optimize'" alt="유니버설 클래식 친구들을 소개합니다!">
                    </div>
                    <div class="contents w1060">
                        <ul>
                            <li v-for="item in character_item[3].items.items" class="prd_item">
                                <a @click="send_amplitude('click_universal_introduce', '{&quot;character&quot; : &quot;유니버설 클래식&quot;, &quot;itemid&quot; : ' + item.item_id + '}')" :onclick="'goProduct(' + item.item_id + ')'" href="javascript:void(0)">
                                    <figure class="prd_img">
                                        <img v-lazy="decodeBase64(item.list_image)" alt="상품명">
                                    </figure>
                                    <div class="prd_info">
                                        <div class="prd_price">
                                            <span class="set_price"><dfn>판매가</dfn>{{format_price(item.item_price)}}</span>
                                            <span v-show="item.sale_percent > 0" class="discount"><dfn>할인율</dfn>{{item.sale_percent}}%</span>
                                        </div>
                                        <div class="prd_name">{{item.item_name}}</div>
                                    </div>
                                </a>
                            </li>   
                        </ul>
                    </div>
                    <div class="btn-area">
                        <a @click="go_detail(character_item[3].attribDiv, null, '캐릭터 소개')" href="javascript:void(0)" class="click-area">유니버설 클래식 상품 더보기</a>
                    </div>
                </section>
                <!-- 환상의 모험가 월리를 찾아보세요! -->
                <section class="universal-type01 top w1060 relative">
                    <div class="h-group">환상의 모험가<br/>월리를 찾아보세요!</div>
                    <div class="visual-area">
                        <div class="fade-swiper">
                            <!-- slide -->
                            <div class="slider">
                                <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/universal/img_loop02.jpg/10x10/resize/3117/optimize" alt="월리를 찾아라"></div>
                                <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/universal/img_loop02.jpg/10x10/resize/3117/optimize" alt="월리를 찾아라"></div>
                            </div>
                        </div>
                        <!-- 2022-06-10추가 -->
                        <div class="bg-left"></div>
                        <div class="bg-right"></div>
                        <!-- // -->
                    </div>
                    <div v-if="character_item.length > 0" class="contents">
                        <ul>
                            <li v-for="item in character_item[2].items.items" class="prd_item">
                                <a @click="send_amplitude('click_universal_introduce', '{&quot;character&quot; : &quot;월리&quot;, &quot;itemid&quot; : ' + item.item_id + '}')" :onclick="'goProduct(' + item.item_id + ')'" href="javascript:void(0)">
                                    <figure class="prd_img">
                                        <img v-lazy="decodeBase64(item.list_image)" alt="상품명">
                                    </figure>
                                    <div class="prd_info">
                                        <div class="prd_price">
                                            <span class="set_price"><dfn>판매가</dfn>{{format_price(item.item_price)}}</span>
                                            <span v-show="item.sale_percent > 0" class="discount"><dfn>할인율</dfn>{{item.sale_percent}}%</span>
                                        </div>
                                        <div class="prd_name">{{item.item_name}}</div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="btn-area">
                        <a @click="go_detail(character_item[2].attribDiv, null, '캐릭터 소개')" href="javascript:void(0)" class="click-area">월리 상품 더보기</a>
                    </div>
                </section>
                <!-- 드림웍스에는 어떤 친구들이 있을까? -->
                <section v-if="character_item.length > 0" class="universal-type01 universal-type02 top w1140">
                    <div class="banner">
                        <div class="h-group">드림웍스에는<br/>어떤 친구들이 있을까?</div>
                        <img v-lazy="'//webimage.10x10.co.kr/fixevent/event/2022/universal/img_uni_dream.jpg/10x10/resize/1140/optimize'" alt="드림웍스에는 어떤 친구들이 있을까?">
                    </div>
                    <div class="contents w1060">
                        <ul>
                            <li v-for="item in character_item[4].items.items" class="prd_item">
                                <a @click="send_amplitude('click_universal_introduce', '{&quot;character&quot; : &quot;드림웍스&quot;, &quot;itemid&quot; : ' + item.item_id + '}')" :onclick="'goProduct(' + item.item_id + ')'" href="javascript:void(0)">
                                    <figure class="prd_img">
                                        <img v-lazy="decodeBase64(item.list_image)" alt="상품명">
                                    </figure>
                                    <div class="prd_info">
                                        <div class="prd_price">
                                            <span class="set_price"><dfn>판매가</dfn>{{format_price(item.item_price)}}</span>
                                            <span v-show="item.sale_percent > 0" class="discount"><dfn>할인율</dfn>{{item.sale_percent}}%</span>
                                        </div>
                                        <div class="prd_name">{{item.item_name}}</div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="btn-area">
                        <a @click="go_detail(character_item[4].attribDiv, null, '캐릭터 소개')" href="javascript:void(0)" class="click-area">드림웍스 상품 더보기</a>
                    </div>
                </section>
                <!-- 돌아온 공룡의 세계? 쥬라기 월드! -->
                <section class="universal-type01 top w1060 relative">
                    <div class="h-group">돌아온 공룡의 세계,<br/>쥬라기 월드!</div>
                    <div class="visual-area">
                        <div class="fade-swiper">
                            <!-- slide -->
                            <div class="slider">
                                <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/universal/img_loop03.jpg/10x10/resize/3117/optimize" alt="쥬라기 월드"></div>
                                <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/universal/img_loop03.jpg/10x10/resize/3117/optimize" alt="쥬라기 월드"></div>
                            </div>
                        </div>
                        <!-- 2022-06-10추가 -->
                        <div class="bg-left"></div>
                        <div class="bg-right"></div>
                        <!-- // -->
                    </div>
                    <div v-if="character_item.length > 0" class="contents">
                        <ul>
                            <li v-for="item in character_item[1].items.items" class="prd_item">
                                <a @click="send_amplitude('click_universal_introduce', '{&quot;character&quot; : &quot;쥬라기월드&quot;, &quot;itemid&quot; : ' + item.item_id + '}')" :onclick="'goProduct(' + item.item_id + ')'" href="javascript:void(0)">
                                    <figure class="prd_img">
                                        <img v-lazy="decodeBase64(item.list_image)" alt="상품명">
                                    </figure>
                                    <div class="prd_info">
                                        <div class="prd_price">
                                            <span class="set_price"><dfn>판매가</dfn>{{format_price(item.item_price)}}</span>
                                            <span v-show="item.sale_percent > 0" class="discount"><dfn>할인율</dfn>{{item.sale_percent}}%</span>
                                        </div>
                                        <div class="prd_name">{{item.item_name}}</div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="btn-area">
                        <a @click="go_detail(character_item[1].attribDiv, null, '캐릭터 소개')" href="javascript:void(0)" class="click-area">쥬라기 월드 상품 더보기</a>
                    </div>
                </section>
                
                <!-- 마음껏 둘러보세요! -->
                <section class="universal-tyoe03 w1060">
                    <div class="h-group top">마음껏 둘러보세요!</div>
                    <div class="prd_list type_basic">
                        <article v-for="item in random_item" class="prd_item">
                            <figure class="prd_img">
                                <img v-lazy="decodeBase64(item.list_image)" alt="">
                            </figure>
                            <div class="prd_info">
                                <div class="prd_price">
                                    <span class="set_price">{{format_price(item.item_price)}}</span>
                                    <span v-show="item.sale_percent > 0" class="discount">{{item.sale_percent}}%</span>
                                </div>
                                <div class="prd_name">{{item.item_name}}</div>
                            </div>
                            <div v-if="item.review_cnt > 0 && item.review_rating" class="user_side">
                                <span class="user_eval"><dfn>평점</dfn><i :style="'width:' + (item.review_rating*20) + '%;'"></i></span> 
                                <span v-show="item.review_cnt > 4" class="user_comment"><dfn>상품평</dfn>{{format_price(item.review_cnt)}}</span>
                            </div>
                            <a @click="send_amplitude('click_universal_product', '{&quot;itemid&quot; : ' + item.itemid + '}')" :onclick="'goProduct(' + item.item_id + ')'" href="javascript:void(0)" class="prd_link"><span class="blind">상품 바로가기</span></a>
                            <!-- wish 버튼 -->
                            <button id="btn_id" type="button" class="btn_wish">
                                <figure class="ico_wish"><lottie-player class="player" src="https://assets4.lottiefiles.com/private_files/lf30_n9czk9v0.json"></lottie-player></figure>
                            </button>
                        </article>                        
                    </div>
                </section>
                <div class="uni-footer">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/universal/img_footer.png?v=2" alt="@universal city studios LLC. all rights reserved.">
                </div>
            </article>	
        </div>
    `
    , created() {
        const _this = this;

        this.$store.dispatch("GET_ATTRIBUTE_GROUP").then(function(){
            /* 캐릭터 별 제일 자 나가요 swiper */
            var chSwiper = new Swiper( '.swiper-container.three', {
                slidesPerView: 'auto',
            });

            /* 캐릭터 별 제일 잘 나가요 menu 선택 */
            $('.swiper-container.three .swiper-slide').on('click',function(){
                if($(this).hasClass('active')) {
                    $(this).siblings().removeClass('active');
                } else {
                    $(this).addClass('active');
                    $(this).siblings().removeClass('active');
                }
            });

            _this.$store.dispatch("GET_BESTITEM").then(function(){
                _this.bestitem = _this.bestitem_list[0].items;
                _this.$forceUpdate();
                _this.$store.dispatch("GET_RANDOM_ITEM");
            });

            _this.$store.dispatch("GET_CHARACTER_ITEM").then(function(){
                _this.$forceUpdate();
            });
        });
        this.$store.dispatch("GET_EVENTS_EVENTBANNER");
        this.$store.dispatch("GET_EVENTS_SLIDEBANNER");
        this.$store.dispatch("GET_MDPICK");

        this.$nextTick(function() {
            fnAmplitudeEventActionJsonData('view_universal_main', JSON.stringify({}));

            /* 크게보기,많이보기 버튼 활성화 및 노출 */
            $('.bnr-type-area button').on('click',function(){
                if($(this).hasClass('on')) {
                    showBnr();
                } else {
                    $('.bnr-type-area button').removeClass('on');
                    $(this).addClass('on');
                    showBnr();
                }
            });
            function showBnr(){
                if($('.btn-big').hasClass('on')) {
                    $('.main-swiper').show().addClass('on');
                    $('.main-sm-bnr').hide().removeClass('on');
                    $('.main-ch-detail').hide().removeClass('on');
                } else if($('.btn-many').hasClass('on')) {
                    $('.main-swiper').hide().removeClass('on');
                    $('.main-sm-bnr').show().addClass('on');
                    $('.main-ch-detail').show();
                }
            };

            setTimeout(function(){
                /* 카드 뒤집기 */
                $('.btn-reverse').on('click',function(){
                    if($(this).parent().find('.thumbnail').hasClass('on')) {
                        $(this).addClass('on');
                        $(this).nextAll('.main-prd-view').addClass('on');
                        $(this).parent().find('.thumbnail').removeClass('on')
                        $(this).parent().find('.thumbnail-hidden').addClass('on');
                    } else {
                        $(this).removeClass('on');
                        $(this).nextAll('.main-prd-view').removeClass('on');
                        $(this).parent().find('.thumbnail').addClass('on');
                        $(this).parent().find('.thumbnail-hidden').removeClass('on');
                    }
                });

                /* 많이보기 영역 캐릭터카드 클릭시 캐릭터설명 노출 */
                $('.main-sm-bnr .ch-list li').on('click',function(){
                    $('.main-ch-detail').addClass('on');
                });
                /* 닫기 */
                $('.btn-close,.main-ch-detail .dim').on('click',function(){
                    $('.main-ch-detail').removeClass('on');
                });

                var options = {};
                if ( $(".swiper-bnr .swiper-slide").length == 1 ) {
                    options = {
                        slidesPerView: 1,
                        loop:false,
                        autoplay:false,
                    }
                } else {
                    options = {
                        slidesPerView:1,
                        speed:500,
                        autoplay:true,
                        loop:false,
                        pagination: {
                            el: '.swiper-pagination',
                            type: 'bullets',
                        },
                        spaceBetween:12,
                    }
                }
                var bnrSwiper = new Swiper('.swiper-bnr', options);

                /* 놓치면 아쉬은 기획전 swiper */
                var exSwiper = new Swiper( '.swiper-container.two', {
                    slidesPerView: 'auto',
                    navigation: {
                        nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev',
                    },
                    on: {
                        reachEnd : function() {
                            $('.swiper-button-prev').addClass('show');
                        }
                    }
                });

                /* slick slider */
                $('.fade-swiper .slider').slick({
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    autoplay: true,
                    autoplaySpeed: 0,
                    speed: 35000,
                    pauseOnHover: false,
                    pauseOnFocus: false,
                    cssEase: 'linear',
                    arrows:false,
                    dots:false,
                    variableWidth: true,
                    loop:true
                });
            }, 1500);
        });
    }
    , mounted(){
        const _this = this;
    }
    , computed : {
        child_character_tab(){
            return this.$store.getters.child_character_tab;
        }
        , parents_character_tab(){
            return this.$store.getters.parents_character_tab;
        }
        , events_eventbanner(){
            return this.$store.getters.events_eventbanner;
        }
        , events_slidebanner(){
            return this.$store.getters.events_slidebanner;
        }
        , mdpick(){
            return this.$store.getters.mdpick;
        }
        , bestitem_list(){
            return this.$store.getters.bestitem_list;
        }
        , random_item(){
            return this.$store.getters.random_item;
        }
        , character_item(){
            return this.$store.getters.character_item;
        }
    }
    , data(){
        return {
            child_character_show_type : "big"
            , character_best_item : []
            , is_app : false
            , active_banner_character : {}
            , active_best_character : {
                "attribDiv" : ""
                , "attribDivName" : "전체"
            }
            , bestitem : []
            , character_swiper : {
                effect: 'coverflow',
                loop: true,
                centeredSlides: true,
                slidesPerView: 'auto',
                coverflowEffect: {
                    rotate:0,
                    stretch:50,
                    depth:150,
                    modifier:1,
                    slideShadows : false,
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                slideToClickedSlide:false,
                touchRatio: 0,
                on: {
                    slideChange: function () {
                        $('.main-bnr .thumbnail').addClass('on');
                        $('.main-bnr .thumbnail-hidden').removeClass('on');
                    },
                }
            }
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
        , decodeBase64(str) {
            if( str == null ) return null;
            return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
        }

        , go_detail(attribDiv, attribName, referrer){
            if(attribName){
                let click_universal_character = {
                    'type' : this.child_character_show_type == 'small' ? 'grid' : 'big'
                    , 'character' : attribName
                };
                fnAmplitudeEventActionJsonData('click_universal_character', JSON.stringify(click_universal_character));
            }

            parent.location.href = "/universal/detail.asp?attribDiv=" + attribDiv + "&referrer=" + referrer;
        }
        , go_bestitem(index, attribDiv, attribDivName){
            //this.$store.dispatch("GET_BESTITEM", attribCd);
            this.bestitem = this.bestitem_list[index].items;
            this.active_best_character.attribDiv = attribDiv
            this.active_best_character.attribDivName = attribDivName;
        }
        , go_slidebanner(url, index){
            let click_universal_banner = {
                'number' : index+1
            };
            fnAmplitudeEventActionJsonData('click_universal_banner', JSON.stringify(click_universal_banner));

            parent.location.href = url;
        }
        , click_showtype(type){
            this.child_character_show_type = type;

            let click_universal_view_type = {
                'type' : type == 'small' ? 'grid' : 'big'
            };
            fnAmplitudeEventActionJsonData('click_universal_view_type', JSON.stringify(click_universal_view_type));
        }
        , click_bestitem(index, itemid){
            let click_universal_best = {
                "character" : $(".universal-best .three .swiper-slide.active").find("button").html().replace('<span class="icon"></span> ', '')
                , "ranking" : index + 1
                , "itemid" : itemid
            };
            fnAmplitudeEventActionJsonData('click_universal_best', JSON.stringify(click_universal_best));
        }
        , send_amplitude(name, data){
            fnAmplitudeEventActionJsonData(name, data);
        }
    }
    , watch : {

    }
});