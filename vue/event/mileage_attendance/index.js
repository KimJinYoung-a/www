const app = new Vue({
    el: '#app'
    , template : `
        <div class="evt113635">
            <div class="topic">
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/tit_main.png" alt=""></h2>
                <p class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/txt_main.png" alt=""></p>
            </div>
            <div class="event-wrap">
                <div class="event-area">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/bg_family.jpg" alt="">
                    <div class="ph01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_01_off.png" alt=""></div>
                    <div class="ph02"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_02_off.png" alt=""></div>
                    <div class="ph03"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_03_off.png" alt=""></div>
                    <div class="ph04"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_04_off.png?v=4" alt=""></div>
                    <div class="ph05"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_05_off.png" alt=""></div>
                    <div class="ph06"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_06_off.png" alt=""></div>
                    <div class="ph07"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_07_off.png" alt=""></div>
                    <div class="ph08"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_08_off.png" alt=""></div>
                    <div class="ph09"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_09_off.png" alt=""></div>

                    <div class="ph01-01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_01_on.png" alt=""></div>
                    <div class="ph02-02"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_02_on.png?v=2" alt=""></div>
                    <div class="ph03-03"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_03_on.png" alt=""></div>
                    <div class="ph04-04"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_04_on.png" alt=""></div>
                    <div class="ph05-05"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_05_on.png" alt=""></div>
                    <div class="ph06-06"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_06_on.png" alt=""></div>
                    <div class="ph07-07"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_07_on.png" alt=""></div>
                    <div class="ph08-08"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_08_on.png" alt=""></div>
                    <div class="ph09-09"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/img_family_09_on.png" alt=""></div>
                    <div class="bar"></div>
                    <div class="bar02"></div>
                </div>
            </div>
            <div class="qr-area"></div>
            <div class="point-area">
                <div class="id">
                    <p><span>{{userid}}</span> 님이</p>
                    <p>받을 수 있는 마일리지</p>
                </div>
                <!-- 클릭시 마일리지 페이지로 이동 -->
                <a href="/my10x10/mymileage.asp" class="btn-point"></a>
            </div>
            <div class="noti-area">
                <button type="button" class="btn-detail">
                    <span class="icon"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113634/icon_arrow.png" alt=""></span>
                </button>
                <div class="noti"></div>
            </div>
            <div class="bnr-area">
                <div class="pd01"><a href="/shopping/category_prd.asp?itemid=3988801&pEtr=113635"></a></div>
                <div class="pd02"><a href="/shopping/category_prd.asp?itemid=2591592&pEtr=113635"></a></div>
                <div class="pd03"><a href="/shopping/category_prd.asp?itemid=2172278&pEtr=113635"></a></div>
                <div class="pd04"><a href="/shopping/category_prd.asp?itemid=3986060&pEtr=113635"></a></div>
                <div class="pd05"><a href="/shopping/category_prd.asp?itemid=3977897&pEtr=113635"></a></div>
                <div class="pd06"><a href="/shopping/category_prd.asp?itemid=3992093&pEtr=113635"></a></div>
                <a href="/event/eventmain.asp?eventid=113035" class="btn-go"></a>
            </div>
        </div>
    `
    , created() {
        if(isUserLoginOK){
            this.userid = userid;
        }else{
            this.userid = '고객';
        }
    }
    , mounted(){
        // btn more
        $('.evt113635 .btn-detail').click(function (e) {
            $(this).next().toggleClass('on');
            $(this).find('.icon').toggleClass('on');
        });
    }
    , data(){
        return{
            userid : ''
        }
    }
});