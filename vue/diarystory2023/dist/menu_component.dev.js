"use strict";

Vue.component('Menu-Component', {
  template: "\n        <div class=\"sect01_link\">\n            <div :class=\"['date', active_category == 'main' ? 'on' : '']\">\n                <p><a @click=\"send_amplitude('click_diary2023_mainmenu', {'index' : 1, 'type' : 'basic'})\" href=\"/diarystory2023/index.asp\">{{today}}</a></p>\n            </div>\n            <div :class=\"['ranking', active_category == 'ranking' ? 'on' : '']\">\n                <p><a href=\"/diarystory2023/ranking.asp\">\uD83D\uDCC8 \uBCA0\uC2A4\uD2B8\uC140\uB7EC</a></p>\n            </div>\n            <div class=\"eventlink\">\n                <p v-for=\"(item, index) in events_link\"><a @click=\"go_event(item.evt_code, index)\" href=\"javascript:void(0)\" v-html=\"item.title\"></a></p>\n            </div>\n            <div :class=\"['category', active_category == 'category' ? 'on' : '']\">\n                <p><a href=\"/diarystory2023/category.asp\">\uD83D\uDCD6 \uBAA8\uB4E0 \uB2E4\uAFB8\uD15C \uBCF4\uAE30</a></p>\n            </div>\n            <div class=\"search\">\n                <ul class=\"input_box\">\n                    <a href=\"\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/search.png\" alt=\"\" class=\"ico_search\"></a>\n                    <input @keyup.enter=\"go_search()\" v-model=\"search_keyword\" type=\"text\" placeholder=\"\uD150\uD150\uB2E4\uAFB8 \uC0C1\uD488 \uAC80\uC0C9\uD558\uAE30\">\n                </ul>\n                <ul class=\"reco_search\">\n                    <p><a @click=\"go_search('\uCE98\uB9B0\uB354')\" href=\"javascript:void(0)\">\uCE98\uB9B0\uB354</a></p>\n                    <p><a @click=\"go_search('\uD50C\uB798\uB108')\" href=\"javascript:void(0)\">\uD50C\uB798\uB108</a></p>\n                    <p><a @click=\"go_search('\uC5EC\uD589\uAE30\uB85D')\" href=\"javascript:void(0)\">\uC5EC\uD589\uAE30\uB85D</a></p>\n                    <p><a @click=\"go_search('\uC2A4\uD2F0\uCEE4')\" href=\"javascript:void(0)\">\uC2A4\uD2F0\uCEE4</a></p>\n                    <p><a @click=\"go_search('\uAD7F\uB178\uD2B8\uC18D\uC9C0')\" href=\"javascript:void(0)\">\uAD7F\uB178\uD2B8\uC18D\uC9C0</a></p>\n                </ul>\n            </div>\n        </div>\n    ",
  created: function created() {
    var _this = this;

    call_api("GET", "/event/events-link", {
      "mastercode": 10
    }, function (data) {
      _this.events_link = data.slice(0, 5);
    });
    var pathname = window.location.pathname;

    switch (pathname) {
      case "/diarystory2023/index.asp":
      default:
        _this.active_category = "main";
        break;

      case "/diarystory2023/category.asp":
        _this.active_category = "category";
        break;

      case "/diarystory2023/ranking.asp":
        _this.active_category = "ranking";
        break;
    }
  },
  data: function data() {
    return {
      events_link: [],
      today: new Date().getMonth() + 1 + "/" + new Date().getDate(),
      active_category: "main",
      search_keyword: ""
    };
  },
  methods: {
    go_event: function go_event(evt_code, index) {
      this.send_amplitude('click_diary2023_mainmenu', {
        'index': index + 3,
        'type': 'event',
        "eventcode": evt_code
      });
      parent.location.href = '/event/eventmain.asp?eventid=' + evt_code + '&diarystory=true';
    },
    set_active_category: function set_active_category(evt_code) {
      this.active_category = evt_code;
    },
    go_search: function go_search(keyword) {
      if (keyword) {
        this.send_amplitude('click_diary2023_searchmain_keyword', {
          "keyword": keyword
        });
        location.href = "/search/search_result.asp?rect=" + keyword + "&diarystoryitem=R";
      } else {
        this.send_amplitude('click_diary2023_searchmain', "");
        location.href = "/search/search_result.asp?rect=" + this.search_keyword + "&diarystoryitem=R";
      }
    },
    send_amplitude: function send_amplitude(name, data) {
      fnAmplitudeEventActionJsonData(name, JSON.stringify(data));
    }
  }
});