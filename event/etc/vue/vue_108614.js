var app = new Vue({
    el      : '#app',
    template: `
        <!-- MKT 108614 -->
        <div class="evt108614">
            <div class="topic">
                <!-- 이미지아이콘 영역 -->
                <div class="item-area">
                    <div class="thumb item1"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108614/img_item01.png" alt="item" class="item1"></div>
                </div>
                <!-- // -->
                <!-- 기획전 이동 -->
                <a href="/event/eventmain.asp?eventid=108338" class="banner"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108614/img_banner.png" alt="선물 찾기 어렵다면 여기 클릭!"></a>
                <div class="number"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108614/img_num.png" alt="50명"></div>
            </div>
            <div class="section-01">
                <button @click="sub_event" type="button" class="btn-join"></button>
            </div>
            <div class="section-02"></div>
            <div class="section-03">
                <div class="tit">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2020/108614/img_sub_tit.jpg" alt="2020 랜선 송년회">
                    <div class="count">
                        <p>현재 참석 인원</p>
                        <p class="num">: <span>{{number_format(subscription_count)}}명</span></p>
                    </div>
                </div>
                <!-- for dev msg : wish 상품 리스트 -->
                <div class="view-wish">
                    <ul>
                        <li v-for="product in products">
                            <a :href="'/shopping/category_prd.asp?itemid=' + product.item_id">
                                <div class="thum"><img :src="product.item_image" alt=""></div>
                                <p class="id">{{product.user_id}}</p>
                                <p class="name">{{product.item_name}}</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- 참여 하기 클릭시 노출 팝업 -->
            <div class="pop-container detail">
                <div class="pop-inner">
                    <div class="pop-content">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108614/img_popup.png" alt="참여 성공 안내">
                        <button @click="close_pop" type="button" class="btn-close">닫기</button>
                    </div>
                </div>
            </div>
        </div>
    `,
    data() {
        return {
            is_page_loading   : true, // 페이지 로딩 중 여부
            is_complete       : false, // 리스트 조회 종료 여부
            current_page      : 0, // 현재 페이지
            products          : [], // 상품 리스트
            subscription_count: 0, // 참석인원 수
            is_called         : false, // 참여 호출 여부
        }
    },
    mounted() {
        const _this = this;
        _this.get_products(true);

        setTimeout(function () {
            _this.scroll_event();
        }, 1000);

        /* slide */
        
    /* slide */
        changingImg();
        function changingImg(){
            var i=1;
            var repeat = setInterval(function(){
                i++;
                if(i>5){i=1;}
                $('.evt108614 .item-area .thumb img').attr('src','//webimage.10x10.co.kr/fixevent/event/2020/108614/m/img_item0'+ i +'.png').attr('class','item' + i);
                /* if(i == 5) {
                    clearInterval(repeat);
                } */
            },1000);
        }
    },
    computed : {
        apiurl() {
            let apiUrl
            if( unescape(location.href).includes('//localhost') || unescape(location.href).includes('//2015www')) {
                apiUrl =  '//testfapi.10x10.co.kr/api/web/v1'
            } else {
                apiUrl =  '//fapi.10x10.co.kr/api/web/v1'
            }

            return apiUrl;
        }
    },
    methods : {
        sub_event() { // 이벤트 응모
            if(this.is_called)
                return false;

            const _this = this;
            _this.is_called = true;

            const url = this.apiurl + '/event/common/wish/subscription?event_code=' + _this.get_event_code()
                + '&folder_name=쓸데없는 선물&device=W';

            $.ajax({
                type       : "POST",
                url        : url,
                ContentType: "json",
                crossDomain: true,
                xhrFields  : {
                    withCredentials: true
                },
                success    : function (data) {
                    _this.is_called = false;
                    console.log(data);
                    if (data) {
                        fnAmplitudeEventMultiPropertiesAction('click_event_apply', 'eventid', _this.get_event_code());
                        $('.pop-container').fadeIn();
                    } else {
                        alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 002)');
                    }
                },
                error      : function (xhr) {
                    _this.is_called = false;
                    console.log(xhr.responseText);
                    try {
                        const err = JSON.parse(xhr.responseText);
                        if(err.code == -10) {
                            alert('이벤트에 응모를 하려면 로그인이 필요합니다.');
                        } else if (err.code == -601 || err.code == -602 || err.code == -604) {
                            alert(err.message);
                        } else {
                            alert(`데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : ${err.code})`);
                        }
                    } catch (e) {
                        alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 001)');
                    }
                }
            });
        },
        close_pop() { // 팝업 닫기
            $(".pop-container").fadeOut();
        },
        scroll_event() {
            const _this = this;
            window.onscroll = function () {
                if (!_this.is_page_loading && !_this.is_complete && ($(window).scrollTop() >= ($(document).height() - $(window).height()) - 1000)) {
                    _this.is_page_loading = true;
                    _this.get_products(false);
                }
            }
        },
        get_products(is_first) {
            const _this = this;
            const url = this.apiurl + '/event/common/wish/products?event_code=' + _this.get_event_code()
                + '&current_page=' + (_this.current_page + 1)
                + '&row_count=40';
            $.ajax({
                type       : "GET",
                url        : url,
                ContentType: "json",
                crossDomain: true,
                xhrFields  : {
                    withCredentials: true
                },
                success    : function (data) {
                    console.log(data);
                    if (is_first) {
                        _this.subscription_count = data.subscription_count;
                    }
                    if (data.products != null) {
                        function decodeBase64(str) {
                            return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
                        }

                        data.products.forEach(p => {
                            p.item_image = decodeBase64(p.item_image);
                            _this.products.push(p);
                        });
                        _this.is_page_loading = false;
                        _this.current_page++;
                        if (_this.current_page === data.last_page) {
                            _this.is_complete = true;
                        }
                    }
                },
                error      : function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        },
        get_event_code() {
            let event_code;
            const parameter_arr = location.search.substr(1).split('&');
            parameter_arr.forEach(p => {
                const keyValue = p.split('=');
                if (keyValue[0] === 'eventid') {
                    event_code = keyValue[1];
                }
            });
            return event_code;
        },
        number_format(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
    }
});