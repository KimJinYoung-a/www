Vue.component("SLIDE-BANNER", {
    template: `
        <div class="section main-banner">
            <div class="rolling">
                <div v-for="(item, index) in banners" :key="index" :class="['rolling-item', {'first-slide' : banners_count == 1}]" :id="'banner' + index" :style="'background-image:url(' + item.imageurl + ');'">
                    <a :href="item.linkurl">
                        <div class="desc" :id="'slide-desc' + index">
                            <div class="copy">
                                <p v-html="item.titlename"></p>
                            </div>
                            <p class="subcopy" v-html="item.subtitlename"></p>
                        </div>
                    </a>
                    
                    <div class="bg-color left" :style="'background-color:#' + item.lcolor"></div>
                    <div class="bg-color right" :style="'background-color:#' + item.rcolor"></div>
                </div>
            </div>
            <div id="slidesjs-log" class="slidesjs-num">
                <span class="slidesjs-slide-number">0</span>/<span class="total" v-html="banners_count"></span
            ></div><!-- for dev msg : 배너 1장만 노출시 네비게이터는 노출되지 않음-->
        </div>
    `
    , props : {
        banners : {
            imageurl: {type:String, default:""}
            , linkurl: {type:String, default:""}
            , titlename: {type:String, default:""}
            , subtitlename: {type:String, default:""}
            , lcolor : {type:String, default:""}
            , rcolor : {type:String, default:""}
        }
        , banners_count:{type:Number, default:0}
    }
    , mounted(){
        const _this = this;
        $('.main-banner .rolling').slidesjs({
            height: 400,
            navigation: {active: _this.banners_count > 1 ? true : false, effect: "fade"},
            pagination: {active: false, effect: "slide"},
            play: {active: false, interval: 3000, effect: "fade", auto: _this.banners_count > 1 ? true : false, pauseOnHover: true},
            effect: {fade: {speed: 750, crossfade: true}},
            callback: {
                loaded: function (number) {
                    $('.mainV18 .main-banner #banner0 #slide-desc0').animate({
                        "margin-left": "0",
                        "opacity": "1"
                    }, 100);
                    $('#slidesjs-log .slidesjs-slide-number').text(number);
                },
                start: function (number) {
                    $('.mainV18 .main-banner .rolling-item .desc').animate({
                        "margin-left": "5px",
                        "opacity": "0"
                    }, 100);
                },
                complete: function (number) {
                    $('.mainV18 .main-banner .rolling-item .desc').animate({
                        "margin-left": "0",
                        "opacity": "1"
                    }, 100);
                    $('#slidesjs-log .slidesjs-slide-number').text(number);
                }
            }
        });

        if(this.banners_count == 1){
            $("#slidesjs-log").css("display", "none");
        }
    }
});