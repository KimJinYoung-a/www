Vue.component('LOOK-BOOK', {
    template : `        
        <div class="wFix">
            <h4 class="line"><img src="http://fiximage.10x10.co.kr/web2013/brand/tit_lookbook.gif" alt="LOOKBOOK" /></h4>
            <div class="nav">
                <template v-for="(item, index) in lookbook_master">
                    <a href="javascript:void(0)" @click="click_lookbook(item.idx)" :class="[{on : item.idx == active_lookbook}]">
                        {{item.title}}
                        <img v-if="item.new" src='http://fiximage.10x10.co.kr/web2013/brand/ico_new.gif' alt='NEW' />
                    </a>
                </template>
            </div>
    
            <div v-if="lookbook_detail" class="photoList">
                <a v-show="lookbook_detail.preidx" class="arrow-left" href="javascript:void(0);" @click="update_lookbook_detail(active_lookbook, lookbook_detail.preidx)"></a>
                <a v-show="lookbook_detail.nextidx" class="arrow-right" href="javascript:void(0);" @click="update_lookbook_detail(active_lookbook, lookbook_detail.nextidx)"></a>
                
                <div class="swiper-container swiper3">
                    <div class="swiper-wrapper">                                        
                        <div class="swiper-slide" :id="'a' + 999">
                            <img :src="staticImgUrl + '/brandstreet/lookbook/detail/' + lookbook_detail.lookbookimg" :alt="'LookBook Detail ' + 999" />
                        </div>
                    </div>
                </div>
            </div>
        </div>        
    `
    , props: {
        lookbook_master : {}
        , active_lookbook : {type: Number, default: 0}
        , lookbook_detail : {}
    }
    ,data(){
        return{
            staticImgUrl : getStaticImgUrl()
        }
    }
    , methods : {
        update_lookbook_detail(active_lookbook, detail_idx){
            console.log("master_idx :",active_lookbook);
            this.$emit("update_lookbook_detail", {"master_idx":active_lookbook, "detail_idx":detail_idx});
        }
        , click_lookbook(data){
            this.$emit("update_active_lookbook", data);
            this.update_lookbook_detail(data, null);

            console.log("active",this.active_lookbook);
            console.log("detail",this.lookbook_detail);
        }
    }
});