"use strict";

var app = new Vue({
  el: '#app',
  store: store,
  template: "\n        <div class=\"anniversary\">\n            <section class=\"main\" v-if=\"randomMainNumber === 0\"></section>\n            <section class=\"main02\" v-if=\"randomMainNumber === 1\">\n                <img class=\"anni_top\" src=\"//webimage.10x10.co.kr/fixevent/event/2022/anniversary/main01.jpg\" alt=\"\">\n            </section>\n            <section class=\"tab-area\">\n                <ul class=\"tab_wrap\">\n                    <p class=\"tab prd01 active\"><a href=\"#tab01\"><span>\uD150\uD150\uD61C\uD0DD</span></a></p>\n                    <p class=\"tab prd02\"><a href=\"#tab02\"><span>\uD150\uD150\uD2B9\uAC00</span></a></p>\n                    <p class=\"tab prd03\"><a href=\"#tab03\"><span>\uD150\uD150x\uC720\uD29C\uBC84</span></a></p>\n                    <p class=\"tab prd04\"><a href=\"#tab04\"><span>\uC774\uBCA4\uD2B8</span></a></p>\n                </ul>\n            </section>\n            <!-- \uD61C\uD0DD -->\n            <BENEFIT></BENEFIT>\n            <!-- \uD2B9\uAC00 -->\n            <SPECIAL-PRICE></SPECIAL-PRICE>\n            <!-- \uD150\uD150x\uC720\uD29C\uBC84 -->\n            <YOUTUBE></YOUTUBE>\n            <!-- \uC774\uBCA4\uD2B8 -->\n            <EVENT></EVENT>\n        </div>\n    ",
  data: function data() {
    return {
      tabType: tabType,
      mainNumber: -1
    };
  },
  created: function created() {},
  computed: {
    randomMainNumber: function randomMainNumber() {
      var _this = this;

      _this.mainNumber = Math.floor(Math.random() * 2);
      return _this.mainNumber;
    }
  },
  mounted: function mounted() {
    var _this = this;

    _this.$nextTick(function () {
      $(window).scroll(function () {
        $('.youtube').each(function () {
          var y = $(window).scrollTop() + $(window).height() + 5;
          var imgTop = $(this).offset().top;

          if (y > imgTop) {
            $(this).addClass('on');
          }
        });
      });
      var i = 0;
      setInterval(function () {
        i++;

        if (i > 7) {
          i = 1;
        }

        $('.anniversary .main02 .anni_top').attr("src", "//webimage.10x10.co.kr/fixevent/event/2022/anniversary/main0" + i + ".jpg");
      }, 800); // link smooth 이동 

      $('.tab-area').on('click', 'a[href^="#"]', function (event) {
        var tabHeight = $('.tab-area').outerHeight();
        event.preventDefault();
        $('html, body').animate({
          scrollTop: $($.attr(this, 'href')).offset().top - tabHeight
        }, 500);
      }); // 스크롤 이벤트

      var lastScroll = 0;
      $(window).scroll(function () {
        var tabHeight = $('.tab-area').outerHeight();
        var fixHeight = tabHeight;
        var st = $(this).scrollTop();
        var startFix = $('.tab01').offset().top - fixHeight;

        if (st > startFix) {
          $('.tab-area').addClass('fixed').css('top', 0);
        } else {
          $('.tab-area').removeClass('fixed');
        }

        lastScroll = st; // 스크롤시 특정위치서 탭 활성화

        var scrollPos = $(document).scrollTop();
        $('.tab-area a').each(function () {
          var tab01 = $('#tab01');
          var tab02 = $('#tab02');
          var tab03 = $('#tab03');
          var tab04 = $('#tab04');

          if (tab01.position().top <= scrollPos && tab01.position().top + tab01.height() >= scrollPos - 70) {
            $('.tab-area .tab').removeClass("active");
            $('.prd01').addClass("active");
          } else if (tab02.position().top <= scrollPos && tab02.position().top + tab02.height() >= scrollPos - 70) {
            $('.tab-area .tab').removeClass("active");
            $('.prd02').addClass("active");
          } else if (tab03.position().top <= scrollPos && tab03.position().top + tab03.height() >= scrollPos - 70) {
            $('.tab-area .tab').removeClass("active");
            $('.prd03').addClass("active");
          } else if (tab04.position().top <= scrollPos && tab04.position().top + tab04.height() >= scrollPos - 70) {
            $('.tab-area .tab').removeClass("active");
            $('.prd04').addClass("active");
          }
        });
      });
    });
  },
  methods: {}
});