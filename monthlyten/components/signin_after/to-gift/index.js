/**선물하기 */
Vue.component('to-gift', {
    template: `
        <article class="to_gift">
            <div class="to_gift__wrap">
                <img src="//webimage.10x10.co.kr/fixevent/event/2023/monthly/feburary/heart_bnr.png?v=1.01" alt="사랑 가득한 2월, 달콤한 선물을 고민중인가요? 텐텐이 큐레이팅한 선물로 설레는 마음을 전해보세요!" />
                <button @click="goGift()">확인하러 가기</button>
            </div>
        </article>
    `,
    methods :{
        goGift(){
            location.href = "http://www.10x10.co.kr/event/heart_gift/index.asp";
        }
    }
});