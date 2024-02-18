var app = new Vue({
    el: '#app',
    template: `
        <div class="evt114117">
            <section class="section01">
                <p class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2021/114117/txt.png?v=2" alt=""></p>
                <p class="app_float"><img src="//webimage.10x10.co.kr/fixevent/event/2021/114117/app_float.png" alt=""></p>
            </section>
            <section class="section02">
                <div class="submit">
                    <p class="float01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/114117/float01.png" alt=""></p>
                    <a @click="onOffPrecaution" class="info"><span :class="{'on':showPrecaution}"><img src="//webimage.10x10.co.kr/fixevent/event/2021/114117/arrow_down.png" alt=""></span></a>
                </div>
                <transition name="fade">
                    <div v-show="showPrecaution" class="notice"></div>
                </transition>
            </section>
            <section class="section03"></section>
            <section class="section04">
                <p class="float02"><img src="//webimage.10x10.co.kr/fixevent/event/2021/114117/float02.png" alt=""></p>
                <div class="item01">
                    <a href="/shopping/category_prd.asp?itemid=3812529&pEtr=114117" class="prd01"></a>
                    <a href="https://www.10x10.co.kr/search/search_result.asp?rect=%EB%AC%B4%EB%93%9C%EB%93%B1" class="url01"></a>
                    <a href="/shopping/category_prd.asp?itemid=3767177&pEtr=114117" class="prd02"></a>
                    <a href="/shopping/category_prd.asp?itemid=3987474&pEtr=114117" class="prd03"></a>
                    <a href="https://www.10x10.co.kr/search/search_result.asp?rect=%EC%BA%94%EB%93%A4" class="url02"></a>
                </div>
                <div class="item02">
                    <a href="/shopping/category_prd.asp?itemid=3855587&pEtr=114117" class="prd01"></a>
                    <a href="https://www.10x10.co.kr/search/search_result.asp?rect=%EC%99%80%EC%9D%B8%EC%9E%94" class="url01"></a>
                    <a href="/shopping/category_prd.asp?itemid=3507415&pEtr=114117" class="prd02"></a>
                    <a href="https://www.10x10.co.kr/event/eventmain.asp?eventid=113987" class="url02"></a>
                    <a href="/shopping/category_prd.asp?itemid=4017518&pEtr=114117" class="prd03"></a>
                    <a href="https://www.10x10.co.kr/search/search_result.asp?rect=%EB%A8%B8%EA%B7%B8%EC%BB%B5" class="url03"></a>
                </div>
                <div class="item03">
                    <a href="/shopping/category_prd.asp?itemid=3997620&pEtr=114117" class="prd01"></a>
                    <a href="https://www.10x10.co.kr/event/eventmain.asp?eventid=113899" class="url01"></a>
                    <a href="/shopping/category_prd.asp?itemid=3852495&pEtr=114117" class="prd02"></a>
                    <a href="https://www.10x10.co.kr/search/search_result.asp?rect=%EB%85%B8%ED%8A%B8" class="url02"></a>
                </div>
            </section>
        </div>
    `,
    data() {return {
        showPrecaution : false, // 유의사항 노출 여부
    }},
    computed : {

    },
    mounted() {
        this.transTitleSection();
    },
    methods : {
        //region transTitleSection 타이틀 섹션 transaction 적용
        transTitleSection() {
            $(function() {$('.evt114117 .section01 .txt').addClass('on');});
        },
        //endregion
        //region onOffPrecaution 유의사항 on/off
        onOffPrecaution() {
            this.showPrecaution = !this.showPrecaution;
        },
        //endregion
    }
});