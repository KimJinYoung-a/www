const app = new Vue({
  el: '#app',
  template: `
            <div class="evt121752">
              <div class="daccu_link">
                <a href="/diarystory2023/index.asp">
                  <img src="//webimage.10x10.co.kr/fixevent/event/2022/121483/diarybn_PC.jpg" alt=""/>
                </a>
              </div>
              <section class="top">
                <div class="float">
                  <img class="float_d" src="//webimage.10x10.co.kr/fixevent/event/2022/121752/m/d.png" alt=""/>
                  <img class="float_i" src="//webimage.10x10.co.kr/fixevent/event/2022/121752/m/i.png" alt=""/>
                  <img class="float_y" src="//webimage.10x10.co.kr/fixevent/event/2022/121752/m/y.png" alt=""/>
                  <img class="float_r" src="//webimage.10x10.co.kr/fixevent/event/2022/121752/m/r.png" alt=""/>
                  <img class="float_a" src="//webimage.10x10.co.kr/fixevent/event/2022/121752/m/a.png" alt=""/>
                </div>
              </section>
              <!-- 오늘의 타임 딜 -->
              <section class="timesale">
                <div :class="'main_time todayTimeDeal'+todayTimeDeal.itemid" v-if="todayTimeDeal">
                  <article class="prd_item">
                    <figure class="prd_img thumbnail">
                      <img src="http://fiximage.10x10.co.kr/web2017/my10x10/bnr_offline.png" alt="상품명"/>
                      <span class="prd_mask"></span>
                    </figure>
                    <div class="prd_info">
                      <div class="prd_date">
                        <p class="date"><span><b>{{getTimeDealDate(currentDate)}}</b> {{getDayOfWeek(currentDate)}}</span>오늘의 타임특가</p>
                        <p class="time" id="countdown">23:59:59</p>
                      </div>
                      <div class="prd_name name"></div>
					            <div class="prd_price price"><s>39,000</s> 33,000<span>30%</span></div>
                    </div>
                  </article>
                  <a href="javascript:void(0)" class="prd_link" @click="prdPage(todayTimeDeal.itemid)">바로 구매하기</a>
                </div>
                
                <!-- 오픈예정 타임딜 -->
                <div class="sub_time">
                  <ul class="time_list">
                    <li><img src="//webimage.10x10.co.kr/fixevent/event/2021/115376/preview.png" alt=""/></li>
                    <li :class="['timeDealList'+item.itemid, item.openDate < currentDate ? 'close' : 'open']" v-for="item in timeDealItems">
                      <figure class="thumbnail">
                        <img src="http://fiximage.10x10.co.kr/web2017/my10x10/bnr_offline.png" alt=""/>                        
                        <div class="mask"></div>
                      </figure>
                      <p class="time_date"><span>{{getTimeDealDate(item.openDate)}}</span>{{item.openDate < currentDate ? '종료' : item.brandName}}</p>
                      <a href="javascript:void(0)" class="more layer" @click="setItemInfo(item)"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115376/more.png" alt=""/></a>
                    </li>                                        
                  </ul>
                </div>
              </section>
              <section class="top_sub">
              </section>
							<section class="item_list">
                <div class="item_link">
                  <p class="item01"><a href="/shopping/category_prd.asp?itemid=4910543&pEtr=121752"></a></p>
                  <p class="item02"><a href="/shopping/category_prd.asp?itemid=5020220&pEtr=121752"></a></p>
                  <p class="item03"><a href="/shopping/category_prd.asp?itemid=4908794&pEtr=121752"></a></p>
                </div>
                <a class="item_more" href="#mapGroup422436"></a>
							</section>
							<section class="awards_list">
								<div class="prd_area prdlist01">
									<ul>
										<li class="item4908000">
											<a href="/shopping/category_prd.asp?itemid=4908000&pEtr=121752">
												<div class="thumbnail"><img src="" alt=""/></div>
												<div class="desc">
													<p class="brand">PEANUTS</p>
													<p class="name">상품명 상품명 상품명 상품명</p>
													<div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
												</div>
											</a>
										</li>
										<li class="item4976812">
											<a href="/shopping/category_prd.asp?itemid=4976812&pEtr=121752">
												<div class="thumbnail"><img src="" alt=""/></div>
												<div class="desc">
													<p class="brand">PEANUTS</p>
													<p class="name">상품명 상품명 상품명 상품명</p>
													<div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
												</div>
											</a>
										</li>
									</ul>
								</div>
								<div class="prd_area prdlist02">
									<ul>
										<li class="item4820641">
											<a href="/shopping/category_prd.asp?itemid=4820641&pEtr=121752">
												<div class="thumbnail"><img src="" alt=""/></div>
												<div class="desc">
													<p class="brand">PEANUTS</p>
													<p class="name">상품명 상품명 상품명 상품명 상품명 상품명 상품명 상품명 상품명 상품명 상품명 상품명</p>
													<div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
												</div>
											</a>
										</li>
										<li class="item4975399">
											<a href="/shopping/category_prd.asp?itemid=4975399&pEtr=121752">
												<div class="thumbnail"><img src="" alt=""/></div>
												<div class="desc">
													<p class="brand">PEANUTS</p>
													<p class="name">상품명 상품명 상품명 상품명</p>
													<div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
												</div>
											</a>
										</li>
									</ul>
								</div>
								<div class="prd_area prdlist03">
									<ul>
										<li class="item4877096">
											<a href="/shopping/category_prd.asp?itemid=4877096&pEtr=121752">
												<div class="thumbnail"><img src="" alt=""/></div>
												<div class="desc">
													<p class="brand">PEANUTS</p>
													<p class="name">상품명 상품명 상품명 상품명</p>
													<div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
												</div>
											</a>
										</li>
										<li class="item4912117">
											<a href="/shopping/category_prd.asp?itemid=4912117&pEtr=121752">
												<div class="thumbnail"><img src="" alt=""/></div>
												<div class="desc">
													<p class="brand">PEANUTS</p>
													<p class="name">상품명 상품명 상품명 상품명</p>
													<div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
												</div>
											</a>
										</li>
									</ul>
								</div>
								<div class="prd_area prdlist04">
									<ul>
										<li class="item4735685">
											<a href="/shopping/category_prd.asp?itemid=4735685&pEtr=121752">
												<div class="thumbnail"><img src="" alt=""/></div>
												<div class="desc">
													<p class="brand">PEANUTS</p>
													<p class="name">상품명 상품명 상품명 상품명</p>
													<div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
												</div>
											</a>
										</li>
										<li class="item4898001">
											<a href="/shopping/category_prd.asp?itemid=4898001&pEtr=121752">
												<div class="thumbnail"><img src="" alt=""/></div>
												<div class="desc">
													<p class="brand">PEANUTS</p>
													<p class="name">상품명 상품명 상품명 상품명</p>
													<div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
												</div>
											</a>
										</li>
									</ul>
								</div>
							</section>
              <section class="event_list"> 
                <div class="event_link">
                  <a href="/event/eventmain.asp?eventid=121755" class="link01"></a>
                  <a href="/event/eventmain.asp?eventid=121633" class="link02"></a>
                  <a href="/event/eventmain.asp?eventid=121483" class="link03"></a>
                </div>
							</section>
              
              <div id="layerDeal" class="layerDeal">
                <div class="slideWrap">
                  <div class="slide">
                    <p class="title">
                    </p>
                    <div v-if="itemDetail" class="contents">
                      <div class="itemArea itemDeal">
                        <div class="pdtInfo">
                          <p class="pdtBrand">{{itemDetail.brandName}}</p>
                          <p class="tit_pdtName">{{itemDetail.itemName}}</p>
                        </div>                        
                      </div>
                      <div class="deal_detail" v-if="dealItemDetails.length < 1">
                        <div class="imgArea" id="imgArea">
                           <div v-html="change_nr(itemDetail.itemContent)"></div>
                           <template v-for="addImg in itemDetail.itemAddImages_pc">
                                <img :src="addImg" alt=""/>
                           </template>
                           <template v-if="itemDetail.mainImage"><img :src="itemDetail.mainImage" alt=""/></template>
                           <template v-if="itemDetail.mainImage2"><img :src="itemDetail.mainImage2" alt=""/></template>
                           <template v-if="itemDetail.mainImage3"><img :src="itemDetail.mainImage3" alt=""/></template>
                        </div>
              
                        <div class="infoArea">
                          <h3>상품 필수 정보 <span class="fn cGy0V15 lPad05">전자상거래 등에서의 상품정보 제공 고시에 따라 작성 되었습니다.</span></h3>
                          <div class="pdtInforBox tMar05">
                            <div class="pdtInforList">
                              <template v-if="itemDetail.categoryPrdAddExplains && itemDetail.categoryPrdAddExplains.length < 1">
                                  <span><em>재료</em> : {{itemDetail.itemSource}}</span>
                                  <span><em>크기</em> : {{itemDetail.itemSize}}</span>
                                  <span><em>제조사/원산지</em> : {{itemDetail.makerName}} / {{itemDetail.sourceArea}}</span>                              
                              </template>
                              <template v-for="info in itemDetail.categoryPrdAddExplains">
                                  <span><em>{{info.infoItemName}}</em> : {{info.infoContent}}</span>
                              </template>                              
                            </div>
                            <div class="pdtInforList abroadMsg" v-if="itemDetail.aboardBeasongYn === 'Y'">
                              <span><em>해외배송 기준 중량</em> : {{itemDetail.itemWeight}}g(1차 포장을 포함한 중량)</span>
                            </div>
                          </div>
                        </div>
              
                        <div class="safety-mark-area" v-if="itemDetail.itemSafetyCerts && itemDetail.itemSafetyCerts.length > 0">                            
                            <h3 class="tMar50" v-if="itemDetail.itemSafetyCerts[0].safetyYn !== 'N'">
                                제품 안전 인증 정보 <span class="fn fs11 cGy0V15 lPad05">본 내용은 판매자가 직접 등록한 것으로 해당 정보에 대한 책임은 판매자에게 있습니다.</span>
                            </h3>
                            <template v-if="itemDetail.itemSafetyCerts[0].safetyYn === 'Y'" v-for="safety in itemDetail.itemSafetyCerts">
                                  <!-- case1 -->
                                  <div class="pdtInforBox tMar05 safety-mark" v-if="safety.certDiv && safety.certDiv !== ''">
                                    <span class="ico"></span>
                                    <p><strong>{{safety.safetyDiv}} : </strong><a :href="'http://www.safetykorea.kr/release/certDetail?certNum='+safety.certNum+'&certUid='+safety.certUid">{{safety.certNum}}</a></p>
                                    <p>구매 전에 안전 인증 정보를 꼭 확인하세요.</p>
                                  </div>
                                  <!-- case2 -->
                                  <div class="pdtInforBox tMar05 safety-mark" v-if="safety.certDiv === null || safety.certDiv === ''">
                                    <span class="ico"></span>
                                    <p><strong>전기용품 – 공급자 적합성 확인 : </strong>공급자 적합성 확인 대상 품목으로 인증번호 없음</p>
                                    <p>구매 전에 안전 인증 정보를 꼭 확인하세요.</p>
                                  </div>                            
                            </template>
                            <!-- case3 -->
                            <div class="pdtInforBox tMar05" v-if="itemDetail.itemSafetyCerts[0].safetyYn !== 'Y'">
                              <div class="pdtInforList">
                                <span>해당 상품 인증 정보는 판매자가 등록한 상품 상세 설명을 참조하시기 바랍니다.</span>
                              </div>
                            </div>
                        </div>
                      </div>
                      
                      <div class="deal_list" v-if="dealItemDetails.length > 0">
                        <div class="section pdtExplanV15" id="detail01">
                          <div class="item itemDeal">
                            <ul class="pdtList">
                              <li class="half" v-for="(item, index) in dealItemDetails">
                                <a href="#layerDeal" class="layer">
                                  <div class="pdtBox">
                                    <div class="pdtPhoto">
                                      <img :src="item.basicImageImageUrl" alt="" />
                                    </div>
                                    <div class="pdtInfo">
                                      <span class="no">상품 <span>{{index+1}}</span></span>
                                      <p class="pdtName">{{item.itemName}}</p>
                                    </div>
                                  </div>
                                </a>
                              </li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <button type="button" class="btnClose" @click="detailPopup('close')"><span>닫기</span></button>
              </div>
            <div id="dimmed" style="display:none; position:fixed; top:0; left:0; z-index:1005; width:100%; height:100%; background:url(//fiximage.10x10.co.kr/web2016/playing/bg_mask_black_50.png) 0 0 repeat;"></div>              
            </div>
    `,
  data: function () {
    return {
      eventCode: eCode,
      currentDate: this.getToday(),
      timeDealItems: [{
          itemid: '4908000',
          openDate: '20221226',
          brandName: '워너디스'
        },
        {
          itemid: '4915148',
          openDate: '20221227',
          brandName: '플레픽'
        },
        {
          itemid: '4894583',
          openDate: '20221228',
          brandName: '라이브워크'
        },
        {
          itemid: '4773984',
          openDate: '20221229',
          brandName: '인디고'
        },
        {
          itemid: '4875215',
          openDate: '20221230',
          brandName: '아이코닉'
        },
        {
          itemid: '4917469',
          openDate: '20221231',
          brandName: '데일리라이크'
        },
        {
          itemid: '4924101',
          openDate: '20230101',
          brandName: '비온뒤'
        }
      ],
      groupItems: [{
          items: '4908000,4976812,4820641,4975399'
        },
        {
          items: '4877096,4912117,4735685,4898001'
        },
      ],
      todayTimeDeal: null,
      itemDetail: null,
      dealItemDetails: []
    }
  },
  created() {

    // 타임딜 세팅
    this.todayTimeDeal = this.timeDealItems.find(v => v.openDate == this.currentDate);
    if (this.todayTimeDeal) {
      this.setTodayTimeDeal();
    }
    this.setSubTimeDeal();

    this.groupItems.forEach(v => {
      fnApplyItemInfoEach({
        items: v.items, // 상품코드
        target: "item",
        fields: ["image","brand", "name", "price", "sale"],
        unit: "none"
      });
    });
  },
  methods: {
    /**
     * 상품 상세 페이지 이동
     * @param itemid
     */
    prdPage(itemid) {
      location.href = '/shopping/category_prd.asp?itemid=' + itemid + '&pEtr=' + this.eventCode;
    },
    /**
     * 오픈된 타임특가 세팅
     */
    setTodayTimeDeal() {
      let _this = this;
      let itemid = this.todayTimeDeal.itemid;
      let url = '/item-week/deal/' + itemid + '/price';
      let method = 'GET';
      let success = function (data) {
        let fields = ["image", "name", "price", "sale"];
        if (data.dealitemid) {
          fields = ["image", "name"];
          let orgPrice = _this.number_format(data.orgPrice);
          let sellCash = _this.number_format(data.sellCash);
          $('.prd_price').html('<s>~' + orgPrice + '원</s> ' + sellCash + '원~<span>~' + data.discountRate + '%</span>');
        }
        _this.setTimeDealItemInfo('todayTimeDeal', itemid, fields);
        _this.setCountDown();
      }
      call_api(method, url, '', success, _this.error);
    },
    /**
     * 오픈 예정 타임특가 세팅
     */
    setSubTimeDeal() {
      let items = this.timeDealItems.map(v => v.itemid);
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
    setTimeDealItemInfo(target, items, fields) {
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
    getToday() {
      let date = new Date();
      let year = date.getFullYear();
      let month = ("0" + (1 + date.getMonth())).slice(-2);
      let day = ("0" + date.getDate()).slice(-2);
      return year + month + day;
    },
    /**
     * 특정날짜 요일 구하기
     * @param date
     * @returns {string}
     */
    getDayOfWeek(date) {
      let yyyy = date.substr(0, 4);
      let mm = date.substr(4, 2);
      let dd = date.substr(6, 2);
      let week_array = new Array('일', '월', '화', '수', '목', '금', '토');
      let today_num = new Date(yyyy + '-' + mm + '-' + dd).getDay();
      return week_array[today_num] + '요일';
    },
    /**
     * 타임딜 날짜 mm.dd 형태로 반환
     * @param date
     * @returns {string}
     */
    getTimeDealDate(date) {
      let mm = date.substr(4, 2);
      let dd = date.substr(6, 2);
      mm = mm.indexOf(0) == 0 ? mm.substr(1, 1) : mm;
      dd = dd.indexOf(0) == 0 ? dd.substr(1, 1) : dd;
      return mm + '.' + dd;
    },
    /**
     * 타임딜 카운트 다운 세팅
     */
    setCountDown() {
      let openDate = this.todayTimeDeal.openDate;
      countDownTimer(openDate.substr(0, 4), openDate.substr(4, 2), openDate.substr(6, 2), 23, 59, 59, new Date());
    },
    /**
     * 팝업 타이틀 세팅
     * @param openDate
     */
    setPopupTitle(openDate) {
      let date = this.getTimeDealDate(openDate);
      let week = this.getDayOfWeek(openDate);
      $('.title').html('<span><b>' + date + '</b> ' + week + '</span> 제품 미리보기</p>');
    },
    /**
     * ajax 공통오류
     * @param xhr
     */
    error(xhr) {
      let e = JSON.parse(xhr.responseText);
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
    setItemInfo(item) {
      let _this = this;
      // 팝업 타이틀 세팅
      _this.setPopupTitle(item.openDate);
      // 딜 상세 초기화
      _this.dealItemDetails = [];
      let data = {
        'itemIds': item.itemid
      };
      let url = '/item-week/items';
      let method = 'GET';
      let success = function (data) {
        if (data.length < 1) {
          alert('존재하지 않는 상품입니다.');
          return;
        } else if (data[0].itemDiv == '21') {
          _this.setDealItenInfo(item.itemid);
        }
        _this.itemDetail = data[0];
        _this.detailPopup('open');
      }
      call_api(method, url, data, success, this.error);
    },
    /**
     * 딜 상세 페이지 조회
     * @param itemid
     */
    setDealItenInfo(itemid) {
      let _this = this;
      let data = {
        'dealItemId': itemid
      };
      let url = '/item-week/deal/items';
      let method = 'GET';
      let success = function (data) {
        if (data.length < 1) {
          alert('존재하지 않는 상품입니다.');
          return;
        }
        _this.dealItemDetails = data;
        _this.detailPopup('open');
      }
      call_api(method, url, data, success, this.error);
    },
    /**
     * 상품 상세 팝업 열기/닫기
     * @param type
     */
    detailPopup(type) {
      if (type === 'open') {
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
    change_nr(text) {
      if (text) {
        return text.replaceAll("\n", "<br />");
      }
    },
    /**
     * 안전 인증 카테고리 조회
     * @param code
     * @returns {string}
     */
    getSafetyDivCodeName(code) {
      switch (code) {
        case "20":
          return "전기용품 > 안전확인 신고"
        case "30":
          return "전기용품 > 공급자 적합성 확인"
        case "40":
          return "생활제품 > 안전인증"
        case "50":
          return "생활제품 > 안전확인"
        case "60":
          return "생활제품 > 공급자 적합성 확인"
        case "70":
          return "어린이제품 > 안전인증"
        case "80":
          return "어린이제품 > 안전확인"
        case "90":
          return "어린이제품 > 공급자 적합성 확인"
        default:
          return '';
      }
    },
    number_format(number) {
      return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  }
});