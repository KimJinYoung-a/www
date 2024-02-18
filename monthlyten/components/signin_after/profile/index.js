/**회원 정보 + 혜택 안내 */
Vue.component('profile', {
    template: `
    <article class="profile">
        <img src="//webimage.10x10.co.kr/fixevent/event/2023/monthly/feburary/pc/benefit_discount.png" alt="회원 할인 혜택" />
        <div class="profile-info">
            <p>지금</p>
            <p v-if="februaryLoginCheck === 'True'">{{userName}}님이</p>
            <p class="profile-info__emph">받을 수 있는 한정할인</p>
        </div>
    </article>
    `,
    computed: {
      userName:function() {
         let userName = this.$store[0].getters.signInUser.userName
         if(userName.length>10){
           return userName.substr(0,9)+'...'
         }
      return userName
     }
    }
 });
