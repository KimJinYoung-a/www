var app = new Vue({
    el      : '#app',
    template: `
                <div class="view-wish">
                    <ul>
                        <li v-for="product in products">
                            <a :href="'/shopping/category_prd.asp?itemid=' + product.item_id">
                                <div class="thum"><img :src="product.item_image" alt=""></div>
                                <p class="name">{{product.item_name}}</p>
                            </a>
                        </li>
                    </ul>
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

    },
    methods : {
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
            const url = '/event/etc/wishlist/act_wishlist.asp?current_page=' + (_this.current_page + 1) + '&row_count=20';
            $.ajax({
                type       : "GET",
                url        : url,
                ContentType: "json",
                crossDomain: true,
                xhrFields  : {
                    withCredentials: true
                },
                success    : function (data) {
                    //console.log(data);
                    if (is_first) {
                        _this.subscription_count = data.subscription_count;
                    }
                    if (data.products != null) {

                        data.products.forEach(p => {
                            p.item_image = p.item_image;
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