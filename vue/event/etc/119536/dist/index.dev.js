"use strict";

var app = new Vue({
  el: '#app',
  template: "\n            <div class=\"evt119536\">\n               <section class=\"section section01\">\n                <div class=\"float\">\n                 <img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/float01.png\" alt=\"\" class=\"float01\">\n                 <div class=\"progress-bar\">\n\t\t\t\t\t\t\t\t\t\t<span class=\"bar\">\n\t\t\t\t\t\t\t\t\t\t\t<span class=\"progress\"></span>\n\t\t\t\t\t\t\t\t\t\t</span>\n\t\t\t\t\t\t\t\t\t</div>\n                </div>\n               </section>\n              <!-- \uC624\uB298\uC758 \uD0C0\uC784 \uB51C -->\n              <section class=\"timesale\">\n                <div :class=\"'main_time todayTimeDeal'+todayTimeDeal.itemid\" v-if=\"todayTimeDeal\">\n                  <article class=\"prd_item\">\n                    <figure class=\"prd_img thumbnail\">\n                      <img src=\"http://fiximage.10x10.co.kr/web2017/my10x10/bnr_offline.png\" alt=\"\uC0C1\uD488\uBA85\">\n                      <span class=\"prd_mask\"></span>\n                    </figure>\n                    <div class=\"prd_info\">\n                      <div class=\"prd_date\">\n                        <p class=\"date\"><span><b>{{getTimeDealDate(currentDate)}}</b> {{getDayOfWeek(currentDate)}}</span>\uC624\uB298\uC758 \uD0C0\uC784\uD2B9\uAC00</p>\n                        <p class=\"time\" id=\"countdown\">23:59:59</p>\n                      </div>\n                      <div class=\"prd_name name\"></div>\n\t\t\t\t\t  <div class=\"prd_price price\"><s>39,000</s> 33,000<span>30%</span></div>\n                    </div>\n                  </article>\n                  <a href=\"javascript:void(0)\" class=\"prd_link\" @click=\"prdPage(todayTimeDeal.itemid)\">\uBC14\uB85C \uAD6C\uB9E4\uD558\uAE30</a>\n                </div>\n                \n                <!-- \uC624\uD508\uC608\uC815 \uD0C0\uC784\uB51C -->\n                <div class=\"sub_time\">\n                  <ul class=\"time_list\">\n                    <li><img src=\"//webimage.10x10.co.kr/fixevent/event/2021/115376/preview.png\" alt=\"\"></li>\n                    <li :class=\"['timeDealList'+item.itemid, item.openDate < currentDate ? 'close' : 'open']\" v-for=\"item in timeDealItems\">\n                      <figure class=\"thumbnail\">\n                        <img src=\"http://fiximage.10x10.co.kr/web2017/my10x10/bnr_offline.png\" alt=\"\">                        \n                        <div class=\"mask\"></div>\n                      </figure>\n                      <p class=\"time_date\"><span>{{getTimeDealDate(item.openDate)}}</span>{{item.openDate < currentDate ? '\uC885\uB8CC' : item.brandName}}</p>\n                      <a href=\"javascript:void(0)\" class=\"more layer\" @click=\"setItemInfo(item)\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2021/115376/more.png\" alt=\"\"></a>\n                    </li>                                        \n                  </ul>\n                </div>\n              </section>\n              \n               <section class=\"section section02\">\n                <div class=\"section section02_01\">\n                  <div class=\"content\">\n                    <ul>\n                      <li class=\"item4391073\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4391073&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd01.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                      <li class=\"item4691422\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4691422&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd02.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                      <li class=\"item4419706\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4419706&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd03.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                      <li class=\"item4651149\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4651149&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd04.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                    </ul>\n                  </div>\n                </div>\n                \n               </section>\n               <section class=\"section section03\">\n                <div class=\"section section03_01\">\n                  <div class=\"content\">\n                    <ul>\n                      <li class=\"item4725229\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4725229&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd05.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                      <li class=\"item4344130\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4344130&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd06.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                      <li class=\"item4771801\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4771801&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd07.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                      <li class=\"item3824454\">\n                        <a href=\"/shopping/category_prd.asp?itemid=3824454&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd08.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                    </ul>\n                  </div>\n                </div>\n                \n               </section>\n               <section class=\"section section04\">\n                <div class=\"section section04_01\">\n                  <div class=\"content\">\n                    <ul>\n                      <li class=\"item4610948\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4610948&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd09.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                      <li class=\"item4439719\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4439719&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd10.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                      <li class=\"item4350146\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4350146&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd11.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                      <li class=\"item4773962\">\n                        <a href=\"/shopping/category_prd.asp?itemid=4773962&pEtr=119536\">\n                        <div class=\"thumbnail\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/119536/prd12.png\" alt=\"\"></div>\n                        <div class=\"desc\">\n                          <p class=\"brand\">PEANUTS</p>\n                          <p class=\"name\">\uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85 \uC0C1\uD488\uBA85</p>\n                          <div class=\"price\"><s>1,500,000</s> <span>10%</span>999,999</div>\n                        </div>\n                        </a>\n                      </li>\n                    </ul>\n                  </div>\n                </div>\n                \n               </section>\n               <section class=\"section section05\"> \n                <a href=\"#mapGroup410524\"><p class=\"link01\"></p></a>\n                <a href=\"/shopping/category_prd.asp?itemid=4044016&pEtr=119536\"><p class=\"link02\"></p></a>\n               </section>\n              \n              <!-- \uC0C1\uD488\uC0C1\uC138 \uD31D\uC5C5 -->\n              <div id=\"layerDeal\" class=\"layerDeal\">\n                <div class=\"slideWrap\">\n                  <div class=\"slide\">\n                    <p class=\"title\">\n<!--                        <span><b>12.7</b> \uD654\uC694\uC77C</span> \uC81C\uD488 \uBBF8\uB9AC\uBCF4\uAE30-->\n                    </p>\n                    <div class=\"contents\">\n                      <div class=\"itemArea itemDeal\">\n                        <div class=\"pdtInfo\">\n                          <p class=\"pdtBrand\">{{itemDetail.brandName}}</p>\n                          <p class=\"tit_pdtName\">{{itemDetail.itemName}}</p>\n                        </div>                        \n                      </div>\n                      <!-- \uC77C\uBC18 \uC0C1\uD488 \uC0C1\uC138 -->\n                      <div class=\"deal_detail\" v-if=\"dealItemDetails.length < 1\">\n                        <!-- \uC0C1\uC138 \uC774\uBBF8\uC9C0 \uC601\uC5ED -->\n                        <div class=\"imgArea\" id=\"imgArea\">\n                           <!-- \uC0C1\uD488 \uC124\uBA85 -->\n                           <div v-html=\"change_nr(itemDetail.itemContent)\"></div>\n                           <!-- \uCD94\uAC00 \uC774\uBBF8\uC9C0 -->\n                           <template v-for=\"addImg in itemDetail.itemAddImages_pc\">\n                                <img :src=\"addImg\" alt=\"\">\n                           </template>\n                           <template v-if=\"itemDetail.mainImage != null\"><img :src=\"itemDetail.mainImage\" alt=\"\"></template>\n                           <template v-if=\"itemDetail.mainImage2 != null\"><img :src=\"itemDetail.mainImage2\" alt=\"\"></template>\n                           <template v-if=\"itemDetail.mainImage3 != null\"><img :src=\"itemDetail.mainImage3\" alt=\"\"></template>\n                        </div>\n              \n                        <!-- \uC0C1\uD488\uC815\uBCF4 -->\n                        <div class=\"infoArea\">\n                          <h3>\uC0C1\uD488 \uD544\uC218 \uC815\uBCF4 <span class=\"fn cGy0V15 lPad05\">\uC804\uC790\uC0C1\uAC70\uB798 \uB4F1\uC5D0\uC11C\uC758 \uC0C1\uD488\uC815\uBCF4 \uC81C\uACF5 \uACE0\uC2DC\uC5D0 \uB530\uB77C \uC791\uC131 \uB418\uC5C8\uC2B5\uB2C8\uB2E4.</span></h3>\n                          <div class=\"pdtInforBox tMar05\">\n                            <div class=\"pdtInforList\">\n                              <template v-if=\"itemDetail.categoryPrdAddExplains && itemDetail.categoryPrdAddExplains.length < 1\">\n                                  <span><em>\uC7AC\uB8CC</em> : {{itemDetail.itemSource}}</span>\n                                  <span><em>\uD06C\uAE30</em> : {{itemDetail.itemSize}}</span>\n                                  <span><em>\uC81C\uC870\uC0AC/\uC6D0\uC0B0\uC9C0</em> : {{itemDetail.makerName}} / {{itemDetail.sourceArea}}</span>                              \n                              </template>\n                              <template v-for=\"info in itemDetail.categoryPrdAddExplains\">\n                                  <span><em>{{info.infoItemName}}</em> : {{info.infoContent}}</span>\n                              </template>                              \n                            </div>\n                            <!-- \uD574\uC678\uBC30\uC1A1 \uC77C\uB54C\uB9CC \uCD94\uAC00 -->\n                            <div class=\"pdtInforList abroadMsg\" v-if=\"itemDetail.aboardBeasongYn == 'Y'\">\n                              <span><em>\uD574\uC678\uBC30\uC1A1 \uAE30\uC900 \uC911\uB7C9</em> : {{itemDetail.itemWeight}}g(1\uCC28 \uD3EC\uC7A5\uC744 \uD3EC\uD568\uD55C \uC911\uB7C9)</span>\n                            </div>\n                            <!-- //\uD574\uC678\uBC30\uC1A1 \uC77C\uB54C\uB9CC \uCD94\uAC00 -->\n                          </div>\n                        </div>\n              \n                        <!-- \uC548\uC804\uC778\uC99D \uC815\uBCF4 \uB178\uCD9C -->\n                        <div class=\"safety-mark-area\" v-if=\"itemDetail.itemSafetyCerts && itemDetail.itemSafetyCerts.length > 0\">                            \n                            <h3 class=\"tMar50\" v-if=\"itemDetail.itemSafetyCerts[0].safetyYn != 'N'\">\n                                \uC81C\uD488 \uC548\uC804 \uC778\uC99D \uC815\uBCF4 <span class=\"fn fs11 cGy0V15 lPad05\">\uBCF8 \uB0B4\uC6A9\uC740 \uD310\uB9E4\uC790\uAC00 \uC9C1\uC811 \uB4F1\uB85D\uD55C \uAC83\uC73C\uB85C \uD574\uB2F9 \uC815\uBCF4\uC5D0 \uB300\uD55C \uCC45\uC784\uC740 \uD310\uB9E4\uC790\uC5D0\uAC8C \uC788\uC2B5\uB2C8\uB2E4.</span>\n                            </h3>\n                            <template v-if=\"itemDetail.itemSafetyCerts[0].safetyYn == 'Y'\" v-for=\"safety in itemDetail.itemSafetyCerts\">\n                                  <!-- case1 -->\n                                  <div class=\"pdtInforBox tMar05 safety-mark\" v-if=\"safety.certDiv != null && safety.certDiv != ''\">\n                                    <span class=\"ico\"></span>\n                                    <p><strong>{{safety.safetyDiv}} : </strong><a :href=\"'http://www.safetykorea.kr/release/certDetail?certNum='+safety.certNum+'&certUid='+safety.certUid\">{{safety.certNum}}</a></p>\n                                    <p>\uAD6C\uB9E4 \uC804\uC5D0 \uC548\uC804 \uC778\uC99D \uC815\uBCF4\uB97C \uAF2D \uD655\uC778\uD558\uC138\uC694.</p>\n                                  </div>\n                                  <!-- case2 -->\n                                  <div class=\"pdtInforBox tMar05 safety-mark\" v-if=\"safety.certDiv == null || safety.certDiv == ''\">\n                                    <span class=\"ico\"></span>\n                                    <p><strong>\uC804\uAE30\uC6A9\uD488 \u2013 \uACF5\uAE09\uC790 \uC801\uD569\uC131 \uD655\uC778 : </strong>\uACF5\uAE09\uC790 \uC801\uD569\uC131 \uD655\uC778 \uB300\uC0C1 \uD488\uBAA9\uC73C\uB85C \uC778\uC99D\uBC88\uD638 \uC5C6\uC74C</p>\n                                    <p>\uAD6C\uB9E4 \uC804\uC5D0 \uC548\uC804 \uC778\uC99D \uC815\uBCF4\uB97C \uAF2D \uD655\uC778\uD558\uC138\uC694.</p>\n                                  </div>                            \n                            </template>\n                            <!-- case3 -->\n                            <div class=\"pdtInforBox tMar05\" v-if=\"itemDetail.itemSafetyCerts[0].safetyYn != 'Y'\">\n                              <div class=\"pdtInforList\">\n                                <span>\uD574\uB2F9 \uC0C1\uD488 \uC778\uC99D \uC815\uBCF4\uB294 \uD310\uB9E4\uC790\uAC00 \uB4F1\uB85D\uD55C \uC0C1\uD488 \uC0C1\uC138 \uC124\uBA85\uC744 \uCC38\uC870\uD558\uC2DC\uAE30 \uBC14\uB78D\uB2C8\uB2E4.</span>\n                              </div>\n                            </div>\n                        </div>\n                      </div>\n                      \n                      <!-- \uB51C \uC0C1\uD488 \uC0C1\uC138 -->\n                      <div class=\"deal_list\" v-if=\"dealItemDetails.length > 0\">\n                        <div class=\"section pdtExplanV15\" id=\"detail01\">\n                          <div class=\"item itemDeal\">\n                            <ul class=\"pdtList\">\n                              <!-- for dev msg : 2\uC5F4\uD0C0\uC785\uC5D0\uB294 \uD074\uB798\uC2A4\uBA85 half, 1\uC5F4 \uD0C0\uC785\uC5D0\uB294 \uD074\uB798\uC2A4\uBA85 full \uBD99\uC5EC\uC8FC\uC138\uC694 -->\n                              <li class=\"half\" v-for=\"(item,index) in dealItemDetails\">\n                                <a href=\"#layerDeal\" class=\"layer\">\n                                  <!-- for dev msg : \uC194\uB4DC\uC544\uC6C3 -->\n                                  <div class=\"pdtBox\">\n                                    <div class=\"pdtPhoto\">\n                                      <img :src=\"item.basicImageImageUrl\" alt=\"\"><!-- for dev msg : \uC774\uBBF8\uC9C0 alt=\"\"\uC73C\uB85C \uCC98\uB9AC\uD574\uC8FC\uC138\uC694 -->\n                                    </div>\n                                    <div class=\"pdtInfo\">\n                                      <span class=\"no\">\uC0C1\uD488 <span>{{index+1}}</span></span>\n                                      <p class=\"pdtName\">{{item.itemName}}</p>\n                                    </div>\n                                  </div>\n                                </a>\n                              </li>\n                            </ul>\n                          </div>\n                        </div>\n                      </div>\n                    </div>\n                  </div>\n                </div>\n                <button type=\"button\" class=\"btnClose\" @click=\"detailPopup('close')\"><span>\uB2EB\uAE30</span></button>\n              </div>\n            <div id=\"dimmed\" style=\"display:none; position:fixed; top:0; left:0; z-index:1005; width:100%; height:100%; background:url(//fiximage.10x10.co.kr/web2016/playing/bg_mask_black_50.png) 0 0 repeat;\"></div>              \n            </div>\n    ",
  data: function data() {
    return {
      eventCode: eCode,
      currentDate: this.getToday(),
      timeDealItems: [{
        itemid: '4812890',
        openDate: '20220810',
        brandName: '띵동'
      }, {
        itemid: '4812746',
        openDate: '20220811',
        brandName: '댄스댄스데이'
      }, {
        itemid: '4483164',
        openDate: '20220812',
        brandName: '러버스픽미'
      }, {
        itemid: '4812740',
        openDate: '20220813',
        brandName: '더필셋'
      }, {
        itemid: '4813877',
        openDate: '20220814',
        brandName: '유보라'
      }, {
        itemid: '4812741',
        openDate: '20220815',
        brandName: '냥냥빔'
      }, {
        itemid: '4813964',
        openDate: '20220816',
        brandName: '멜리팩토리'
      }],
      groupItems: [{
        items: '4391073,4691422,4419706,4651149'
      }, {
        items: '4725229,4344130,4771801,3824454'
      }, {
        items: '4610948,4439719,4350146,4773962'
      }],
      todayTimeDeal: {},
      itemDetail: {},
      dealItemDetails: []
    };
  },
  created: function created() {
    var _this2 = this;

    // 타임딜 세팅
    this.todayTimeDeal = this.timeDealItems.find(function (v) {
      return v.openDate == _this2.currentDate;
    });

    if (this.todayTimeDeal) {
      this.setTodayTimeDeal();
    }

    this.setSubTimeDeal();
    this.groupItems.forEach(function (v) {
      fnApplyItemInfoEach({
        items: v.items,
        // 상품코드
        target: "item",
        fields: ["image", "brand", "name", "price", "sale"],
        unit: "none"
      });
    });
  },
  methods: {
    /**
     * 상품 상세 페이지 이동
     * @param itemid
     */
    prdPage: function prdPage(itemid) {
      location.href = '/shopping/category_prd.asp?itemid=' + itemid + '&pEtr=' + this.eventCode;
    },

    /**
     * 오픈된 타임특가 세팅
     */
    setTodayTimeDeal: function setTodayTimeDeal() {
      var _this = this;

      var itemid = this.todayTimeDeal.itemid;
      var url = '/item-week/deal/' + itemid + '/price';
      var method = 'GET';

      var success = function success(data) {
        var fields = ["image", "name", "price", "sale"];

        if (data.dealitemid) {
          fields = ["image", "name"];

          var orgPrice = _this.number_format(data.orgPrice);

          var sellCash = _this.number_format(data.sellCash);

          $('.prd_price').html('<s>~' + orgPrice + '원</s> ' + sellCash + '원~<span>~' + data.discountRate + '%</span>');
        }

        _this.setTimeDealItemInfo('todayTimeDeal', itemid, fields);

        _this.setCountDown();
      };

      call_api(method, url, '', success, _this.error);
    },

    /**
     * 오픈 예정 타임특가 세팅
     */
    setSubTimeDeal: function setSubTimeDeal() {
      var items = this.timeDealItems.map(function (v) {
        return v.itemid;
      });

      if (items) {
        this.setTimeDealItemInfo('timeDealList', items, ["image"]);
      }
    },

    /**
     * 상품 정보 연동
     * @param target
     * @param items
     * @param fields
     */
    setTimeDealItemInfo: function setTimeDealItemInfo(target, items, fields) {
      fnApplyToTalPriceItem({
        items: items,
        target: target,
        fields: fields,
        unit: "none",
        saleBracket: false
      });
    },

    /**
     * 오늘 날짜 조회
     * @returns {string}
     */
    getToday: function getToday() {
      var date = new Date();
      var year = date.getFullYear();
      var month = ("0" + (1 + date.getMonth())).slice(-2);
      var day = ("0" + date.getDate()).slice(-2);
      return year + month + day;
    },

    /**
     * 특정날짜 요일 구하기
     * @param date
     * @returns {string}
     */
    getDayOfWeek: function getDayOfWeek(date) {
      var yyyy = date.substr(0, 4);
      var mm = date.substr(4, 2);
      var dd = date.substr(6, 2);
      var week_array = new Array('일', '월', '화', '수', '목', '금', '토');
      var today_num = new Date(yyyy + '-' + mm + '-' + dd).getDay();
      return week_array[today_num] + '요일';
    },

    /**
     * 타임딜 날짜 mm.dd 형태로 반환
     * @param date
     * @returns {string}
     */
    getTimeDealDate: function getTimeDealDate(date) {
      var mm = date.substr(4, 2);
      var dd = date.substr(6, 2);
      mm = mm.indexOf(0) == 0 ? mm.substr(1, 1) : mm;
      dd = dd.indexOf(0) == 0 ? dd.substr(1, 1) : dd;
      return mm + '.' + dd;
    },

    /**
     * 타임딜 카운트 다운 세팅
     */
    setCountDown: function setCountDown() {
      var openDate = this.todayTimeDeal.openDate;
      countDownTimer(openDate.substr(0, 4), openDate.substr(4, 2), openDate.substr(6, 2), 23, 59, 59, new Date());
    },

    /**
     * 팝업 타이틀 세팅
     * @param openDate
     */
    setPopupTitle: function setPopupTitle(openDate) {
      var date = this.getTimeDealDate(openDate);
      var week = this.getDayOfWeek(openDate);
      $('.title').html('<span><b>' + date + '</b> ' + week + '</span> 제품 미리보기</p>');
    },

    /**
     * ajax 공통오류
     * @param xhr
     */
    error: function error(xhr) {
      var e = JSON.parse(xhr.responseText);

      if (xhr.status == 400) {
        alert(e.message);
      } else {
        alert('서버에 오류가 발생하였습니다.');
      }
    },

    /**
     * 상품 상세 페이지 조회
     * @param item
     */
    setItemInfo: function setItemInfo(item) {
      var _this = this; // 팝업 타이틀 세팅


      _this.setPopupTitle(item.openDate); // 딜 상세 초기화


      _this.dealItemDetails = [];
      var data = {
        'itemIds': item.itemid
      };
      var url = '/item-week/items';
      var method = 'GET';

      var success = function success(data) {
        if (data.length < 1) {
          alert('존재하지 않는 상품입니다.');
          return;
        } else if (data[0].itemDiv == '21') {
          _this.setDealItenInfo(item.itemid);
        }

        _this.itemDetail = data[0];

        _this.detailPopup('open');
      };

      call_api(method, url, data, success, this.error);
    },

    /**
     * 딜 상세 페이지 조회
     * @param itemid
     */
    setDealItenInfo: function setDealItenInfo(itemid) {
      var _this = this;

      var data = {
        'dealItemId': itemid
      };
      var url = '/item-week/deal/items';
      var method = 'GET';

      var success = function success(data) {
        if (data.length < 1) {
          alert('존재하지 않는 상품입니다.');
          return;
        }

        _this.dealItemDetails = data;

        _this.detailPopup('open');
      };

      call_api(method, url, data, success, this.error);
    },

    /**
     * 상품 상세 팝업 열기/닫기
     * @param type
     */
    detailPopup: function detailPopup(type) {
      if (type == 'open') {
        $('#layerDeal').show();
        $("#dimmed").show();
      } else {
        $('#layerDeal').hide();
        $("#dimmed").hide();
      }
    },

    /**
     * 엔터 치환
     * @param text
     * @returns {*}
     */
    change_nr: function change_nr(text) {
      if (text) {
        return text.replaceAll("\n", "<br />");
      }
    },

    /**
     * 안전 인증 카테고리 조회
     * @param code
     * @returns {string}
     */
    getSafetyDivCodeName: function getSafetyDivCodeName(code) {
      switch (code) {
        case "20":
          return "전기용품 > 안전확인 신고";

        case "30":
          return "전기용품 > 공급자 적합성 확인";

        case "40":
          return "생활제품 > 안전인증";

        case "50":
          return "생활제품 > 안전확인";

        case "60":
          return "생활제품 > 공급자 적합성 확인";

        case "70":
          return "어린이제품 > 안전인증";

        case "80":
          return "어린이제품 > 안전확인";

        case "90":
          return "어린이제품 > 공급자 적합성 확인";

        default:
          return '';
      }
    },
    number_format: function number_format(number) {
      return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  }
});