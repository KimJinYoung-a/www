/**
 * 가격 필터
 * 슬라이더 사용
 *
 * 가격 변경 시 change_filter_price 이벤트 전송(최저가격, 최고가격)
 */
Vue.component('PRICE', {
    template : `
        <div class="ftPrice" id="fttabPrice">
            <div class="amoundBox1"><input type="text" :value="min_price_format" readonly class="amoundRange" /><span></span></div>
            <div class="amoundBox2"><input type="text" :value="max_price_format" readonly class="amoundRange" /><span></span></div>
            <div class="sliderWrap"><div id="slider-range"></div></div>
            <p class="amountLt amountView">{{number_format(bar_min_price)}}원</p>
            <p class="amountRt amountView">{{number_format(bar_max_price)}}원</p>
        </div>
    `,
    data() {return {
        slider : null,
        min_price : 0,
        max_price : 1000
    }},
    props : {
        bar_min_price : { type : Number, default : 0 }, // 가격바 최저 가격
        bar_max_price : { type : Number, default : 0 }, // 가격바 최고 가격
        search_min_price : { type : Number, default : 0 }, // 검색 최저 가격
        search_max_price : { type : Number, default : 0 }, // 검색 최저 가격
    },
    computed : {
        min_price_format() {
            return this.number_format(this.min_price) + '원';
        },
        max_price_format() {
            return this.number_format(this.max_price) + '원';
        }
    },
    methods : {
        // 가격바 슬라이더 생성
        create_slider() {
            if( this.slider != null ) {
                this.slider.slider('destroy');
            }
            this.min_price = this.search_min_price;
            this.max_price = this.search_max_price;

            const _this = this;
            this.slider = $('#slider-range').slider({
                range:true,
                min: this.bar_min_price,
                max: this.bar_max_price,
                values: [this.min_price, this.max_price],
                step: 100,
                slide: (e, ui) => {
                    _this.min_price = ui.values[0];
                    _this.max_price = ui.values[1];
                },
                stop: (e, ui) => {
                    _this.$emit('change_filter_price', ui.values[0], ui.values[1]);
                }
            });
            $('.ui-slider a:first').append($('.amoundBox1'));
            $('.ui-slider a:last').append($('.amoundBox2'));
        },
        clear() {
            this.min_price = this.bar_min_price;
            this.max_price = this.bar_max_price;
            if( this.slider != null ) {
                this.set_slider_values();
            }
        },
        set_slider_values() {
            this.slider.slider('values', [this.min_price, this.max_price]);
        }
    }
});