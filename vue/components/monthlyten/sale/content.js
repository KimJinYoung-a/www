Vue.component('CONTENT', {
    template : `
        <div :style="contentStyle">
            <h3>
                <span>{{categoryName}}</span>
                {{categoryTag}}
            </h3>
            <div class="prd_wrap">
                <ul id="lyrItemlist" class="item_list"><!-- target의 ID 지정 -->
                    <li v-for="(item, idx) in items">
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="categoryCode + '_items' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <p class="name">상품명상품명상품명상품명상품명상품명</p>
                                <div class="price"><s>15,000</s> 11,000<span class="sale">30%</span></div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="ten_mask" v-if="showMask(items)">
                <a v-if="showMask(items)" href="javascript:void(0);" class="btn_more" @click="moreItem">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/btn_more.png" alt="">
                </a>
            </div>
        </div>
    `
    , created() {
        
    }
    , mounted() {
        
    }
    , updated() {
        const _this = this;
        _this.setInit();
    }
    , props : {
        items: {
            type: Array,
            default: []
        },
        categoryCode: {
            type: Number,
            default: 0
        },
        categoryName: {
            type: String,
            default: ""
        },
        categoryTag: {
            type: String,
            default: ""
        }
    }
    , methods : {
        /**
         * 상품 정보 연동
         * @param target 클래스명
         * @param items 상품아이디
         * @param fields 상품 정보 필드명
         */
         setItemInfo(target, items, fields){
            fnApplyItemInfoEach({
                items: items,
                target: target,
                fields:fields,
                unit:"none",
                saleBracket:false
            });
        },
        setItemInit(target, e) {
            const _this = this;
            let items = e.map(i => i.itemid);
            _this.setItemInfo(target, items, ["image", "name", "price", "sale"]);
        },
        showMask(items) {
            let isShow = false;
            if (items != null && items.length > 8) {
                isShow = true;
            }
            return isShow;
        },
        moreItem(e) {
            const _target = e.target;
            $(_target).parent().parent().siblings('.prd_wrap').find('ul').addClass('more');
            $(_target).parent().parent('.ten_mask').addClass('more');
            $(_target).parent().parent().siblings('.prd_wrap').find('li:hidden').slice(0, 8).show(); 
            if ($(_target).parent().parent().siblings('.prd_wrap').find('li:hidden').length == 0) { 
                $(_target).parent().parent('.ten_mask').hide();
                $(_target).parent().parent().siblings('.prd_wrap').find('ul').css('paddingBottom','80px')
            } 
        },
        /**
         * 상품상세 페이지 이동
         * @param itemid
         */
         prdDetailPage(itemid){
            location.href = "/shopping/category_prd.asp?itemid=" + itemid + "&petr="+this.eventCode;
        },
        setInit() {
            const _this = this;
            let items = _this.items.map(i => i.itemid);
            this.$emit('setInit', _this.categoryCode + '_items', items, ["image", "name", "price", "sale"]);
        }

    }
    , computed : {
        contentStyle() {
            if (this.items.length <= 4) {
                return {
                    'margin-bottom': '10vw'  
                };
            } else {
                return '';
            }
        }
    }
})