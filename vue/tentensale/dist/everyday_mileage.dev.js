"use strict";

Vue.component('everyday-mileage', {
  template: "\n        <section id=\"tab02\" class=\"section02\">\n            <div class=\"in_wrap\">\n                <div class=\"inner\">\n                    <h2><span>\uCD9C\uC11D\uCCB4\uD06C \uC774\uBCA4\uD2B8</span>\uB9E4\uC77C \uBC29\uBB38\uD558\uACE0<br>4,500p \uBC1B\uC544\uC694!</h2>\n                    <div class=\"gage_wrap\">\n                        <p class=\"gage_tit\">\uB0B4\uAC00 \uBC1B\uC740 \uB9C8\uC77C\uB9AC\uC9C0</p>\n                        <div class=\"gage\"><p :style=\"is_day_check_percent\"><span>{{received_mileage_sum}}p</span></p></div>\n                    </div>\n                    <div class=\"mileage_wrap\">\n                        <img src=\"//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/mileage_wrap.png\" alt=\"\">\n                        <div class=\"btnWrap\">\n                            <div v-for=\"(item, index) in 9\" :class=\"'btn0' + (index+1)\">\n                                <img v-if=\"index < received_mileage_days_count\" :src=\"'//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/btn0' + (index+1) + '_off.png?v=1.1'\"  :id=\"'day' + (index+1)\">\n                                <img v-else :src=\"'//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/btn0' + (index+1) + '_off.png?v=1.1'\" :id=\"'day' + (index+1)\" class=\"btn_off\">    \n                                <img v-if=\"index == today_index && (index+1)!=received_mileage_days_count\" :src=\"'//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/btn0' + (index+1) + '_on.png?v=1.1'\" :id=\"'day_' + (index+1)\" class=\"btn_on\">\n                                \n                            </div>\n                        </div>\n                        <div v-if=\"received_mileage_days_count==9\" class=\"finish\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/finish.png?v=1.04\" alt=\"\"></div>\t\n                    </div>\n                    <div class=\"noti_wrap\">\n                        <div v-if=\"is_login_ok\">\n                            <div v-if=\"!(received_mileage_days_count==9)\">\n                                <a href=\"javascript:void(0);\" @click=\"go_attendance\" class=\"btn_check\">\uCD9C\uC11D\uCCB4\uD06C \uD558\uAE30</a>\n                                <a href=\"javascript:void(0);\" @click=\"go_push\" class=\"alert\">\uB0B4\uC77C \uC78A\uC9C0 \uC54A\uB3C4\uB85D<span>\uC54C\uB9BC \uBC1B\uAE30</span></a>\n                            </div>\n                        </div>\n                        <div v-else>\n                            <a href=\"javascript:void(0);\" @click=\"go_login\" class=\"alert login\">\uB85C\uADF8\uC778\uD558\uAE30</a>\n                        </div>\n                        <div v-if=\"received_mileage_days_count==9\">\n                            <a href=\"javascript:void(0);\" class=\"alert check_finish\">\uCD9C\uC11D\uCCB4\uD06C \uBAA8\uB450 \uC644\uB8CC!</a>\n                        </div>\n                        <div v-if=\"!(received_mileage_days_count==9)\">\n                        <a href=\"javascript:void(0);\" @click=\"del_push\" class=\"no_alert\">\uB354\uC774\uC0C1 \uC54C\uB9BC \uBC1B\uC9C0 \uC54A\uAE30</a>\n                        </div>\n                        <p class=\"noti\">\uC120\uBB3C\uBC1B\uC740 \uB9C8\uC77C\uB9AC\uC9C0\uB294 2022\uB144 12\uC6D4 31\uC77C\uAE4C\uC9C0\uB9CC<br>\uC0AC\uC6A9\uAC00\uB2A5\uD55C \uD55C\uC815 \uB9C8\uC77C\uB9AC\uC9C0 \uC785\uB2C8\uB2E4.</p>\n                        <a href=\"\" class=\"noti_more\">\uC720\uC758\uC0AC\uD56D \uB354\uBCF4\uAE30</a>\n                    </div>\n                </div>\n            </div>\n        </section>\n    ",
  created: function created() {
    this.get_mileage_info();
    this.$nextTick(function () {
      this.is_login_ok = isUserLoginOK;

      if (!this.is_login_ok) {
        this.userid = '고객';
      } else {
        this.userid = userid;
      }

      $('.noti_wrap .noti').click(function () {
        if ($(this).hasClass('on')) {
          $(this).removeClass('on');
          $('.notice').css('display', 'none');
        } else {
          $(this).addClass('on');
          $('.notice').css('display', 'block');
        }
      });
      $(".noti_more").click(function (event) {
        $(".modalV20").addClass("show");
        return false;
      });
      $(".modal_overlay,.btn_close").click(function (event) {
        $(".modalV20").removeClass("show");
        return false;
      });
      $('.btn_close').click(function () {
        $('.bg_dim').css('display', 'none');
        $(this).parent().css('display', 'none');
        return false;
      });
      setTimeout(function () {
        $('.mEvt115806 .tit01, .mEvt115806 .tit02').addClass('on');
      }, 500);
      $(".btnWrap .btn01").addClass("up");
      $(".btnWrap .btn02").addClass("diff up");
      $(".btnWrap .btn03").addClass("up");
      $(".btnWrap .btn04").addClass("up02");
      $(".btnWrap .btn05").addClass("diff up02");
      $(".btnWrap .btn06").addClass("up02");
      $(".btnWrap .btn08").addClass("diff");
    });
  },
  mounted: function mounted() {},
  computed: {},
  data: function data() {
    return {
      userid: '',
      is_login_ok: false,
      received_mileage: 0 //오늘 받은 마일리지
      ,
      received_mileage_sum: 0 //받은 마일리지 총합
      ,
      received_mileage_days_count: 0 //마일리지를 받은 날짜 총합
      ,
      today_index: 0 //오늘자 인덱스
      ,
      is_requesting_push: false,
      is_posting_subscript: false,
      is_day_check_percent: 1
    };
  },
  methods: {
    get_mileage_info: function get_mileage_info() {
      var _this = this;

      call_apiV2('get', '/event/everyday-mileage', {
        "event_code": eventid
      }, function (data) {
        //console.log(data);
        _this.received_mileage_days_count = 0;
        _this.received_mileage_sum = data.received_mileage_sum;
        _this.today_index = data.today_index;
        _this.received_mileage_days_count = data.received_days_count;
        _this.last_yn = data.last_yn;

        if (data.received_days_count < 1) {
          _this.is_day_check_percent = "width:20%";
        } else {
          _this.is_day_check_percent = "width:" + data.received_days_count / 9 * 100 + "%";
          $("#daycheck").html(data.received_days_count + "/9회차");
        } //console.log(_this.received_mileage_days_count+"/"+_this.today_index);

      });
    },
    go_attendance: function go_attendance() {
      var _this = this;

      if (!this.is_login_ok) {
        go_login();
      } else {
        if (this.is_posting_subscript) {
          return false;
        }

        this.is_posting_subscript = true;
        call_apiV2('post', '/event/' + eventid + '/mileage/1/device/A', null, function (data) {
          _this.is_posting_subscript = false;
          _this.received_mileage = data.mileage_amount;

          _this.get_mileage_info();

          if (data.round == 9) {
            $('.bg_dim').css('display', 'block');
            $("#day" + data.round).removeClass("btn_off");
          } else if (_this.last_yn) {
            $('.bg_dim').css('display', 'block');
            $("#day" + data.round).removeClass("btn_off");
          } else {
            $('.bg_dim').css('display', 'block');
            $("#day" + data.round).removeClass("btn_off");
          }

          $("#day_" + data.round).hide(); // 마일리지 지급 앰플리튜드

          fnAmplitudeEventMultiPropertiesAction('click_event_apply', 'eventcode|actype', eventid + '|mileageok', '');
        }, function (e) {
          _this.is_posting_subscript = false;

          try {
            var error = JSON.parse(e.responseText);

            switch (error.code) {
              case -10:
              case -11:
                fnAPPpopupLogin();
                return;

              case -600:
                alert('처리과정 중 오류가 발생했습니다.\n코드:001');
                return;

              case -602:
                alert('이벤트가 종료되었습니다');
                return;

              case -608:
                alert('최대 마일리지 지급 횟수를 초과했습니다.');
                return;

              case -609:
                if (_this.last_yn) alert('오늘의 출석체크는 이미 완료했어요!\n감사합니다.');else alert('오늘의 출석체크는 이미 완료했어요.\n내일도 꼭 참여하세요!');
                return;

              default:
                alert('처리과정 중 오류가 발생했습니다.\n코드:003');
                return;
            }
          } catch (e) {
            console.log(e);
            alert('처리과정 중 오류가 발생했습니다.\n코드:002');
          }
        });
      }
    },
    go_push: function go_push() {
      if (!this.is_login_ok) {
        go_login();
      } else {
        $.ajax({
          type: "POST",
          url: "/tentensale/doalarm.asp",
          data: {
            mode: 'alarm'
          },
          dataType: "JSON",
          success: function success(data) {
            if (data.response == "ok") {
              alert(data.message);
              return false;
            } else {
              alert(data.message);
              return false;
            }
          },
          error: function error(data) {
            alert('시스템 오류입니다.');
          }
        });
      }
    },
    del_push: function del_push() {
      if (!this.is_login_ok) {
        go_login();
      } else {
        $.ajax({
          type: "POST",
          url: "/tentensale/doalarm.asp",
          data: {
            mode: 'delalarm'
          },
          dataType: "JSON",
          success: function success(data) {
            if (data.response == "ok") {
              alert(data.message);
              return false;
            } else {
              alert(data.message);
              return false;
            }
          },
          error: function error(data) {
            alert('시스템 오류입니다.');
          }
        });
      }
    },
    go_login: function go_login() {
      location.href = "/login/loginpage.asp?vType=G";
    }
  }
});