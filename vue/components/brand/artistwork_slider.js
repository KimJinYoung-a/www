Vue.component('ARTIST-WORK-SLIDER', {
    template : `
        <div class="galleryArea tMar40">
            <div class="galleryView" :id="type">
                <a @click="click_swiper('prev')" class="arrow-left" href="javascript:void(0);"></a>
                <a @click="click_swiper('next')" class="arrow-right" href="javascript:void(0);"></a>
                <div class="swiper-container swiper2">
                    <div class="swiper-wrapper">
                        <p v-for="(item, index) in now_tap_data" class="bigPic swiper-slide">
                            <img :src="staticImgUrl + '/contents/artistGallery/' + item.gal_img400" :alt="item.designerid + index" width="400px" height="400px" />
                        </p>
                    </div>
                </div>
            </div>
            <div class="tabs">
                <a v-for="(item, index) in now_tap_data" :class="[{active : active_taps == index}]" href="javascript:void(0);" >
                    <img :src="'http://thumbnail.10x10.co.kr/imgstatic/contents/artistGallery/' + item.gal_img400 + '?cmd=thumb&w=72&h=72&fit=true&ws=false'" :alt="item.designerid + index" width="72px" height="72px" 
                        @click="click_tabs(index)"
                    />
                    <dfn v-if="active_taps == index"></dfn>
                </a>
            </div>
        </div>
    `
    , props: {
        tap_data : {}
        , type : ""
    }
    , data(){
        return{
            staticImgUrl : getStaticImgUrl()
            , swiper : null
            , active_taps : 0
            , now_tap_data : {}
        }
    }
    , mounted(){
        const _this = this;
        this.$nextTick(function () {
            _this.swiper = new Swiper('.swiper-container', {
                speed: 500
            });
        });

        this.now_tap_data = this.tap_data.work;
    }
    , methods : {
        click_swiper(btn_type){
            if(btn_type == 'prev'){
                this.swiper.swipePrev();
            }else{
                this.swiper.swipeNext();
            }
        }
        , click_tabs(index){
            this.active_taps = index;
            this.swiper.swipeTo(index);
        }
    }
    , watch : {
        type(){
            if(this.type == "work"){
                this.now_tap_data = this.tap_data.work;
            }else if(this.type == "drawing"){
                this.now_tap_data = this.tap_data.drawing;
            }else{
                this.now_tap_data = this.tap_data.photo;
            }
            this.active_taps = 0;
            this.swiper.swipeTo(0);
        }
    }
});