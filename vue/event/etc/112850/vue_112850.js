var app = new Vue({
    el: '#app',
    template: `
        <div class="evt112850">
            <div class="topic">
                <div class="icon"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/icon_arrow.png" alt="박스"></div>
            </div>
            <!-- 이벤트 응모 영역 -->
            <div class="section-01">
                <div class="img-01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/popup_box02.png" alt="박스"></div>
                <div class="img-02 animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/event_heart02.png" alt="하트"></div>
                <button type="button" class="event-btn" @click="subscriptEvent">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/event_btn.png" alt="지금은 언박싱 타임!">
                </button>
            </div>
            <!-- 적립완료 팝업 -->
            <transition name="fade">
                <div v-show="isPopModal" class="pop-container">
                    <div :class="['pop-contents', {'last-day' : isLastDay}]">
                        <!-- 포인트 -->
                        <div class="pop-point">
                            <p>{{numberFormat(mileage)}}P</p>
                        </div>
                        <div class="img-03"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/popup_box.png" alt="박스"></div>
                        <div class="img-04"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/popup_coin.png" alt="코인"></div>
                        <img :src="'//webimage.10x10.co.kr/fixevent/event/2021/112850/' + (isLastDay ? 'bg_lastpopup.png' : 'bg_popup.png')" alt="포인트로 스티커 사러 가자">
                        <button @click="isPopModal = false;" type="button" class="btn-close">닫기</button>
                    </div>
                </div>
            </transition>    
              
            <div class="section-02" :style="bannerSectionStyle">
                <div v-for="(event, index) in bannerEvents" :class="{left : index === 0}">
                    <a :href="'/event/eventmain.asp?eventid=' + event"></a>
                </div>
            </div>
            <div class="list-price section-03" :style="top7Section1Style">
                <div class="list-conts">
                    <Spetival-Item v-for="(item, index) in top7Items1" v-if="index < 4" :item="item"/>
                </div>
                <div class="list-conts type2">
                    <Spetival-Item v-for="(item, index) in top7Items1" v-if="index >= 4" :item="item"/>
                </div>
            </div>
            <div class="list-price section-04" :style="top7Section2Style">
                <div class="list-conts">
                    <Spetival-Item v-for="(item, index) in top7Items2" v-if="index < 4" :item="item"/>
                </div>
                <div class="list-conts type2">
                    <Spetival-Item v-for="(item, index) in top7Items2" v-if="index >= 4" :item="item"/>
                </div>
            </div>
            <div class="section-05 prd-wrap">
                <div><a href="/shopping/category_prd.asp?itemid=3666165&petr=112850"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/list01_01.png" alt=""></a></div>
                <div><a href="/shopping/category_prd.asp?itemid=3895597&petr=112850"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/list01_02.png" alt=""></a></div>
                <div><a href="/shopping/category_prd.asp?itemid=3603641&petr=112850"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/list01_03.png" alt=""></a></div>
                <div><a href="/shopping/category_prd.asp?itemid=3816493&petr=112850"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/list01_04.png" alt=""></a></div>
            </div>
            <div class="section-06 prd-wrap">
                <div><a href="/shopping/category_prd.asp?itemid=2682613&petr=112850"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/list02_01.png" alt=""></a></div>
                <div><a href="/shopping/category_prd.asp?itemid=3789290&petr=112850"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/list02_02.png" alt=""></a></div>
            </div>
            <div class="section-07 prd-wrap">
                <div><a href="/shopping/category_prd.asp?itemid=3900384&petr=112850"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/list03_02.png" alt=""></a></div>
                <div><a href="/shopping/category_prd.asp?itemid=3903293&petr=112850"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/list03_01.png" alt=""></a></div>
            </div>
            <div class="section-08 prd-wrap">
                <div><a href="/shopping/category_prd.asp?itemid=3640712&petr=112850"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/list04_01.png" alt=""></a></div>
                <div><a href="/shopping/category_prd.asp?itemid=2469706&petr=112850"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112850/list04_02.png" alt=""></a></div>
            </div>
            <div class="section-09">
                <div class="link-conts">
                    <div><a href="#mapGroup375167"></a></div>
                    <div><a href="#mapGroup375168"></a></div>
                    <div><a href="#mapGroup375169"></a></div>
                    <div><a href="#mapGroup375170"></a></div>
                </div>
                 <div class="link-conts list-wrap">
                    <div><a href="#mapGroup375171"></a></div>
                    <div><a href="#mapGroup375172"></a></div>
                    <div><a href="#mapGroup375173"></a></div>
                    <div><a href="#mapGroup375174"></a></div>
                    <div><a href="#mapGroup375175"></a></div>
                </div>
            </div>
        </div>
    `,
    data() {return {
        mileage : 0, // 지급받은 마일리지
        isCalled : false, // 신청 중 여부
        isLastDay : false, // 마지막날 여부
        isPopModal : false, // 팝업 노출 여부
        isDevelop : unescape(location.href).includes('//localhost') || unescape(location.href).includes('//testwww') || unescape(location.href).includes('//localwww'),
        bannerEvents: [],
        bannerBackImage: '',
        top7ItemImage1 : '',
        top7ItemImage2 : '',
        top7Items1 : [],
        top7Items2 : []
    }},
    computed : {
        spetivalApiUrl() {
            return '//' + (this.isDevelop ? 'test' : '') + 'fapi.10x10.co.kr/api/web/v2/event/temp/spetival';
        },
        bannerSectionStyle() {
            return {
                'background' : 'url(' + this.bannerBackImage + ') no-repeat 50% 0'
            }
        },
        top7Section1Style() {
            return {
                'background' : 'url(' + this.top7ItemImage1 + ') no-repeat 50% 0'
            }
        },
        top7Section2Style() {
            return {
                'background' : 'url(' + this.top7ItemImage2 + ') no-repeat 50% 0'
            }
        }
    },
    mounted() {
        $('.topic .tit').addClass('on');
        $(window).scroll(function(){
            $('.animate').each(function(){
                var y = $(window).scrollTop() + $(window).height() * 1;
                var imgTop = $(this).offset().top;
                if(y > imgTop) {
                    $(this).addClass('on');
                }
            });
        });

        const _this = this;

        this.bannerEvents = eventData.bannerEvents;
        this.bannerBackImage = eventData.bannerBackImage;

        this.top7ItemImage1 = eventData.top7Item1.titleImage;
        let top7ItemData1 = {'itemIds' : eventData.top7Item1.itemIds.join(',')}
        this.getFrontApiData('GET', '/items', top7ItemData1,
            data => {
                data.forEach(item => {
                    item.itemImage = _this.decodeBase64(item.itemImage);
                    this.top7Items1.push(item);
                });
            },
            xhr => {
                console.log(xhr.responseText);
            }
        );
        this.top7ItemImage2 = eventData.top7Item2.titleImage;
        let top7ItemData2 = {'itemIds' : eventData.top7Item2.itemIds.join(',')}
        _this.getFrontApiData('GET', '/items', top7ItemData2,
            data => {
                data.forEach(item => {
                    item.itemImage = _this.decodeBase64(item.itemImage);
                    this.top7Items2.push(item);
                });
            },
            xhr => {
                console.log(xhr.responseText);
            }
        );

    },
    methods : {
        subscriptEvent() {
            const _this = this;
            this.isCalled = false;

            const sendData = {
                'deviceType' : 'PC'
            }
            this.getFrontApiData('POST', '/subscript', sendData,
                data => {
                    _this.isCalled = false;
                    _this.mileage = data;
                    _this.isPopModal = true;
                },
                xhr => {
                    console.log(xhr.responseText);
                    _this.isCalled = false;

                    try {
                        const err = JSON.parse(xhr.responseText);
                        _this.handleError(err);
                    } catch (e) {
                        alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 001)');
                    }
                }
            );
        },
        handleError(err) {
            if(err.code === -10) {
                alert('언박싱 하려면 로그인이 필요합니다.');
                location.href = '/login/loginpage.asp?vType=G&backpath=' + encodeURIComponent(location.pathname + location.search);
            } else if (err.code === -603) {
                alert('이미 언박싱 하셨습니다.\n매일 한번씩만 가능합니다.');
            } else if (err.code === -601 || err.code === -602 || err.code === -615) {
                alert(err.message);
            } else {
                alert(`데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : ${err.code})`);
            }
        },
        numberFormat(number) {
            if( number == null || isNaN(number) )
                return '';
            else
                return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        },
        getFrontApiData(method, uri, data, success, error) {
            $.ajax({
                type: method,
                url: this.spetivalApiUrl + uri,
                data: data,
                ContentType: "json",
                crossDomain: true,
                xhrFields: {
                    withCredentials: true
                },
                success: success,
                error: error
            });
        },
        decodeBase64(str) {
            if (str == null) return null;
            return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
        }
    }
});