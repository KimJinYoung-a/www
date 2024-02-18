const app = new Vue({
    el: '#app',
    template: `
      <div class="evt119092">
        <section class="section01"></section>
        <section class="section02 open">
            <div class="open07">
                <a href="/shopping/category_prd.asp?itemid=4730641&pEtr=119092"></a>
            </div>
            <div class="open06">
                <a href="/shopping/category_prd.asp?itemid=4622753&pEtr=119092"></a>
            </div>
            <div class="open05">
                <a href="/shopping/category_prd.asp?itemid=4622752&pEtr=119092"></a>
            </div>
            <div class="open04">
                <a href="/shopping/category_prd.asp?itemid=4622750&pEtr=119092"></a>
            </div>
            <div class="open03">
                <a href="/shopping/category_prd.asp?itemid=4640159&pEtr=119092"></a>
            </div>
            <div class="open02">
                <a href="/shopping/category_prd.asp?itemid=4622742&pEtr=119092"></a>
            </div>
            <div class="open01">
                <a href="/shopping/category_prd.asp?itemid=4622636&pEtr=119092"></a>
            </div>
        </section>
        <section class="section03">
          <a href="javascript:void(0);" class="btn_alert" @click="alarmApply()"></a>
        </section>
      </div>
    `,
    created() {
      let query_param = new URLSearchParams(window.location.search);
      this.event_code = query_param.get("eventid");
      this.isUserLoginOK = isUserLoginOK;
  },
  data(){
      return {
          event_code: 0,
          isUserLoginOK : false
      }
  },
  mounted() {
      const _this = this;
      this.$nextTick(function() {
          _this.itemOpenDate();
      })
  },
  methods : {
      alarmApply() {
          const _this = this;
          let api_data = {
              "event_code" : _this.event_code
              , "check_option3" : true
              , "event_option3" : "alarm"
              , "device" : "W"
          };
          if (!_this.isUserLoginOK) {
              if (confirm("로그인 후 신청이 가능해요. 새로운 상품이 오픈되면 빠르게 알려드릴게요!")) {
                  _this.callLoginPage();
              }
          } else {
              call_subscription_api(api_data)
                  .then(function(data){
                      if(data.result){
                          if(api_data.event_option3 == "alarm"){
                              alert("알림 신청이 완료되었습니다. 새로운 굿즈가 오픈되면 빠르게 알려드릴게요!");
                          }
                      } else {
                          if(data.reason == "already"){
                              if(api_data.event_option3 == "alarm"){
                                  alert("이미 신청이 완료되었습니다. 다음 오픈시간이 다가오면 빠르게 알려드릴게요!");
                              }
                          }
                      }
                  });
          }
      }
      , callLoginPage() {
          let url = '/login/loginpage.asp?vType=G';
          let param = '&backpath=' + location.pathname + location.search;
          location.href = url + param;
      }
      , itemOpenDate() {
          const _this = this;
          let openClassNumber = _this.getOpenClassNumber();
          $(".section02 div").hide();
          for (var i = 1; i <= openClassNumber; i++) {
              $(".section02 div.open0" + i).show();
          }
      }
      , getOpenClassNumber() {
          let todayDate = new Date();
          const firstOpenNumber = new Date(2022, 6, 06, 11, 00, 00);
          const secondOpenNumber = new Date(2022, 6, 13, 12, 00, 00);
          const thirdOpenNumber = new Date(2022, 6, 20, 12, 00, 00);
          const fourthOpenNumber = new Date(2022, 6, 27, 12, 00, 00);
          const fifthOpenNumber = new Date(2022, 7, 03, 12, 00, 00);
          const sixthOpenNumber = new Date(2022, 7, 10, 12, 00, 00);
          const seventhOpenNumber = new Date(2022, 7, 17, 14, 00, 00);
          // const eighthOpenNumber = new Date(2022, 7, 24, 14, 00, 00);
          let resultNumber = 0;
          if (firstOpenNumber.getTime() <= todayDate.getTime() && todayDate.getTime() <= secondOpenNumber.getTime()) {
              resultNumber = 1;
          } else if (secondOpenNumber.getTime() <= todayDate.getTime() && todayDate.getTime() <= thirdOpenNumber.getTime()) {
              resultNumber = 2;
          } else if (thirdOpenNumber.getTime() <= todayDate.getTime() && todayDate.getTime() <= fourthOpenNumber.getTime()) {
              resultNumber = 3;
          } else if (fourthOpenNumber.getTime() <= todayDate.getTime() && todayDate.getTime() <= fifthOpenNumber.getTime()){
              resultNumber = 4;
          } else if (fifthOpenNumber.getTime() <= todayDate.getTime() && todayDate.getTime() <= sixthOpenNumber.getTime()){
              resultNumber = 5;
          } else if (sixthOpenNumber.getTime() <= todayDate.getTime() && todayDate.getTime() <= seventhOpenNumber.getTime()){
              resultNumber = 6;
          } else if (seventhOpenNumber.getTime() <= todayDate.getTime()){
              resultNumber = 7;
          }

          return resultNumber;
      }      
  }
});