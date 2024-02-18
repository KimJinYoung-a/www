const app = new Vue({
    el: '#app',
    template: `
      <div class="evt119859">
        <section class="section01"></section>
        <section class="section02 open">
            <div class="open01">
                <a class="btn_open" href="/shopping/category_prd.asp?itemid=4794329&pEtr=119859"></a>
            </div>
            <div class="open02">
                <a class="btn_open" href="/shopping/category_prd.asp?itemid=4794364&pEtr=119859"></a>
            </div>
            <div class="open03">
                <a class="btn_open" href="/shopping/category_prd.asp?itemid=4794582&pEtr=119859"></a>
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
  }
});