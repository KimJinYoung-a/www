Vue.use(VueAwesomeSwiper)

const app = new Vue({
    el: '#app'
    , template : `
        <div class="evt116051">
            <div class="topic">
                <div class="tit"><img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_tit.jpg" alt="선착순 무료 배포 2차 텐바이텐이 다이어리 쏜다! 여러분의 2021년을 응원하며, 텐바이텐이 내년 다이어리를 무료로 쏩니다!"></div>
                <div class="float"><img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_number.png" alt="총 1,000개"></div>
                <div class="slide-area">
                    <swiper :options="swiperOption">
                        <swiper-slide>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_slide01.png" alt="diary">
                        </swiper-slide>
                        <swiper-slide>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_slide02.png" alt="diary">
                        </swiper-slide>
                        <swiper-slide>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_slide03.png" alt="diary">
                        </swiper-slide>
                        <swiper-slide>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_slide04.png" alt="diary">
                        </swiper-slide>
                        <swiper-slide>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_slide05.png" alt="diary">
                        </swiper-slide>
                        <swiper-slide>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_slide06.png" alt="diary">
                        </swiper-slide>
                        <swiper-slide>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_slide07.png" alt="diary">
                        </swiper-slide>
                        <swiper-slide>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_slide08.png" alt="diary">
                        </swiper-slide>
                        <swiper-slide>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_slide09.png" alt="diary">
                        </swiper-slide>
                        <swiper-slide>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_slide10.png" alt="diary">
                        </swiper-slide>
                    </swiper>
                </div>
            </div>
            <div class="section-01">
                <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_qrcode.jpg" alt="지금 텐바이텐APP에서 확인하세요!">
                <a href="http://www.10x10.co.kr/diarystory2021/"><img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_diary.jpg" alt="텐바이텐에서 28,487 개의 다이어리 중 나만의 다이어리를 찾아보세요!"></a>
            </div>
            <div class="section-01">
                <img src="//webimage.10x10.co.kr/fixevent/event/2021/116051/img_noti.jpg" alt="지금 텐바이텐APP에서 확인하세요!">
            </div>
        </div>
    `
    , created() {
        this.setting_time = this.get_url_param("setting_time");
    }
    , data(){
        return{
            setting_time : ""
            , swiperOption: {
                slidesPerView: 'auto'
                , speed: 5000
                , autoplay: 1
                , loop:true
                , loopedSlides:10
            }
        }
    }
    , methods : {
        maxLengthCheck(object){
            //console.log(object.target);
            if (object.target.value.length > object.target.maxLength){
                object.target.value = object.target.value.slice(0, object.target.maxLength);
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
    }
});