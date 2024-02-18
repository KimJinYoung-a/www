const app = new Vue({
    el: '#app'
    , store : store
    , template : `
<div class="evt118569">
    <div class="section section01">
        <!-- <div class="title"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/title.png?v=3" alt="텐텐선물"></div>
        <div class="top">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/top02_01.png" alt="">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/top02_02.png" alt="">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/top02_03.png" alt="">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/top02_04.png" alt="">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/top02_05.png" alt="">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/top02_06.png" alt="">
        </div> -->
    </div>
    <!-- <div class="section section02">
        <div class="tit"></div>
        <div class="recommend">
            <div class="reco01">
                <a href="/shopping/category_prd.asp?itemid=4783815&pEtr=118569">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/reco02_01.jpg" alt="">
                </a>
            </div>
            <div class="reco02">
                <a href="/shopping/category_prd.asp?itemid=4868398&pEtr=118569">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/reco02_02.jpg" alt="">
                </a>
            </div>
            <div class="reco03">
                <a href="/shopping/category_prd.asp?itemid=4856248&pEtr=118569">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/reco02_03.jpg" alt="">
                </a>
            </div>
            <div class="reco04">
                <a href="/shopping/category_prd.asp?itemid=4490128&pEtr=118569">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/reco02_04.jpg" alt="">
                </a>
            </div>
            <div class="reco05">
                <a href="/shopping/category_prd.asp?itemid=4839955&pEtr=118569">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/reco02_05.jpg" alt="">
                </a>
            </div>
            <div class="reco06">
                <a href="/shopping/category_prd.asp?itemid=2074090&pEtr=118569">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/118569/reco02_06.jpg" alt="">
                </a>
            </div>
        </div>
    </div> -->
    <div class="tab-area">
        <div class="tab">
            <ul>
                <template v-for="(data,index) in eventGroup">
                    <li :data-tab="'tab-'+(index+1)" :class="index == 0 ? 'on' : ''">
                        <a>
                            <div class="tit">{{data.evtgroup_desc}}</div>
                        </a>
                    </li>                                        
                </template>
                    <li data-tab="tab-3">
                        <a>
                            <div class="tit">브랜드 추천</div>
                        </a>
                    </li>
                    <li>
                        <a href="https://www.10x10.co.kr/giftcard/?gaparam=main_giftcard">
                            <div class="tit">텐텐상품권</div>
                        </a>
                    </li>
            </ul>
        </div>
        <div class="tab-category">
            <template v-for="(data,index) in eventGroup">
                <div :class="['category-list' ,index == 0 ? 'on' : '']" :id="'tab-'+(index+1)">
                    <ul>
                        <template v-for="(child,index2) in data.child_group">
                            <div :class="['category' ,index == 0 && index2 ==0 ? 'on' : '']"><a href="javascript:void(0)" @click="clickCategory(child)"><span>{{child.evtgroup_desc}}</span></a></div>                                                
                        </template>
                    </ul>
                </div>
            </template>                                
        </div>
    </div>
    <div class="section section03">
        <div class="prd-bottom-list on">
            <div id="prdList1-01">
                <h2 class="title" id="itemListTitle"></h2>
                <div class="content">
                    <div class="prd-list">
                        <ul id="itemList" class="item_list">                                                   
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div id="prd-bottom-list"></div>
        <div class="prd-bottom-list brand">
            <div class="brand_banner">
                <a href="https://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=actionlcd"><img src="//webimage.10x10.co.kr/fixevent/event/2022/120828/brand01.png" alt="" /></a>
            </div>
            <div class="brand_banner">
                <a href="https://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=romane"><img src="//webimage.10x10.co.kr/fixevent/event/2022/120828/brand02.png" alt="" /></a>
            </div>
            <div class="brand_banner">
                <a href="https://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=ffroi10"><img src="//webimage.10x10.co.kr/fixevent/event/2022/120828/brand03.png" alt="" /></a>
            </div>
            <div class="brand_banner">
                <a href="https://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=cncglobalkr"><img src="//webimage.10x10.co.kr/fixevent/event/2022/120828/brand04.png" alt="" /></a>
            </div>
            <div class="brand_banner">
                <a href="https://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=wigglewiggle"><img src="//webimage.10x10.co.kr/fixevent/event/2022/120828/brand05.png" alt="" /></a>
            </div>
            <div class="brand_banner">
                <a href="https://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=Theflowermarket"><img src="//webimage.10x10.co.kr/fixevent/event/2022/120828/brand06.png" alt="" /></a>
            </div>
        </div>
    </div>
</div>    
    `
    , created() {
        this.$store.dispatch('GET_EVENT_GROUP',this.eventCode);
    }
    , computed : {
        eventGroup(){
            return this.$store.getters.eventGroup;
        }
    }
    , data(){
        return {
            is_saving : false
            , tmp_opt2 : 1
            , second_start_flag : false
            , eventCode : isDevelop ? 118178 : eCode
            , isVisible : true
            , pageNum : 1
            , evtgroup_desc : ''
            , page_size : 100
        }
    }
    , methods : {
        clickCategory(data) {
            let href = $('.prd-bottom-list.on').find('div').eq(0);
            let tabHeight = $('.tab').outerHeight();
            $('html, body').animate({
                scrollTop: href.offset().top-tabHeight
            }, 500);
            this.setDate(data);
        },
        setDate(data) {
            $('#itemListTitle').html(data.evtgroup_desc);
            this.pageNum = 1;
            this.evtgroup_desc = data.evtgroup_code;
            this.setItemList();
        },
        setItemList() {
            let _this = this;
            let param = {
                "evt_code" : this.eventCode
                , "evtgroup_code" : this.evtgroup_desc
                , "page" : this.pageNum
                , "page_size" : _this.page_size
            };
            console.log('param',param);
            getFrontApiData('GET', '/event/common/display-none-event-item', param,
                data => {
                    const $rootEl = $("#itemList");
                    let tmpEl = "";
                    let itemEle = "";

                    if(param.page == 1){
                        $rootEl.empty();
                    }

                    data.items.forEach(function(item){
                        tmpEl = `
                            <li>
                                <a onclick="goProduct('` + item + `');" href="javascript:void(0)">
                                    <div class="thumbnail"><img src="" alt=""></div>
                                    <div class="desc">
                                        <p class="name">상품명</p>
                                        <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                    </div>                                                                        
                                </a>
                                <div class="etc">
                                    <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                                </div>
                                <div class="wish" id="wish` + item + `" onclick="fnWishAdd('` + item + `');"></div>
                            </li>
                        `;
                        itemEle += tmpEl;
                    });
                    $rootEl.append(itemEle);

                    fnDisplayNoneEventItems({
                        items: data.items
                        , target:"itemList"
                        , fields:["image","name","price","sale","wish","evaluate"]
                        , unit:"none"
                        , saleBracket:false
                        , page : param.page
                        , page_size : param.page_size
                    });

                    if(data.items.length == param.page_size) {
                        _this.isVisible=false;
                    }
            });
        },
        checkVisible( elm, eval ) {
            eval = eval || "object visible";
            var viewportHeight = $(window).height(), // Viewport Height
                scrolltop = $(window).scrollTop(), // Scroll Top
                y = $(elm).offset().top,
                elementHeight = $(elm).height();

            if (eval == "object visible") return ((y < (viewportHeight + scrolltop)) && (y > (scrolltop - elementHeight)));
            if (eval == "above") return ((y < (viewportHeight + scrolltop)));

            this.isVisible = true;
        }
    }
    ,updated() {
        this.$nextTick(function () {
            let _this = this;
            // /* tab 활성화 */
            $('.tab-area .tab li').on('click',function(){
                $('.tab-area .tab li').removeClass('on')
                $(this).addClass('on');
                var tabHeight = $('.tab').outerHeight();
                var tabAreaHeight = $('.tab-area').outerHeight();
                var href = $('.prd-bottom-list.on').find('div').eq(0);
                var tab_id = $(this).attr('data-tab');
                if(tab_id == 'tab-3'){
                    $('html, body').animate({
                        scrollTop: href.offset().top-tabHeight+1
                    }, 500);
                }else{
                    $('html, body').animate({
                        scrollTop: href.offset().top-tabHeight
                    }, 500);
                }
                if(tab_id == 'tab-1'){
                    _this.clickCategory(_this.eventGroup[0].child_group[0]);
                    $('.category-list').removeClass('on');
                    $('#' + tab_id).addClass('on');
                    $('#' + tab_id).find('.category').removeClass('on');
                    $('#' + tab_id).find('.category').eq(0).addClass('on');
                    $('.prd-bottom-list').eq(0).addClass('on').siblings().removeClass('on');
                }if(tab_id == 'tab-2'){
                    _this.clickCategory(_this.eventGroup[1].child_group[0]);
                    $('.category-list').removeClass('on');
                    $('#' + tab_id).addClass('on');
                    $('#' + tab_id).find('.category').removeClass('on');
                    $('#' + tab_id).find('.category').eq(0).addClass('on');
                    $('.prd-bottom-list').eq(0).addClass('on').siblings().removeClass('on');
                }else if(tab_id == 'tab-3'){
                    $('.category-list').removeClass('on');
                    $('.prd-bottom-list').eq(1).addClass('on').siblings().removeClass('on');
                }
            });

            // tab-category 활성화
            $('.tab-category .category a').on('click', function (event) {
                $('.tab-category .category').removeClass('on');
                $(this).parent('.category').addClass('on');
            });

            window.addEventListener('scroll', function() {
                if ( _this.checkVisible($('#prd-bottom-list')) && !_this.isVisible) {
                    _this.isVisible = true;
                    _this.pageNum = _this.pageNum + 1;
                    _this.setItemList();
                }
            });

            _this.setDate(_this.eventGroup[0].child_group[0]);
        })

    }
});