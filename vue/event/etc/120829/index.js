const app = new Vue({
  el: '#app',
  template: `
  <div class="evt118248">
            <section class="section01">
              <div class="float">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/120829/float01.png" class="float01" alt="">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/120829/float02.png" class="float02" alt="">
              </div>
            </section>
            <section class="section02 timesale">
                  <div :class="'main_time todayTimeDeal'+todayTimeDeal.itemid" v-if="todayTimeDeal">
                    <article class="prd_item">
                      <figure class="prd_img thumbnail">
                        <img src="http://fiximage.10x10.co.kr/web2017/my10x10/bnr_offline.png" alt="상품명">
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
                    <a href="javascript:void(0)" class="prd_link" @click="prdPage(todayTimeDeal.itemid, todayTimeDeal.popup)">바로 구매하기</a>
                  </div>
                  
                  <!-- 오픈예정 타임딜 -->
                  <div class="sub_time">
                    <ul class="time_list">
                      <li><img src="//webimage.10x10.co.kr/fixevent/event/2021/115376/preview.png" alt=""></li>
                      <li :class="['timeDealList'+item.itemid, item.openDate < currentDate ? 'close' : 'open']" v-for="item in timeDealItems">
                        <figure class="thumbnail">
                          <img src="http://fiximage.10x10.co.kr/web2017/my10x10/bnr_offline.png" alt="">                        
                          <div class="mask"></div>
                        </figure>
                        <p class="time_date"><span>{{getTimeDealDate(item.openDate)}}</span>{{item.openDate < currentDate ? '종료' : getDayOfWeek(item.openDate)}}</p>
                        <a href="javascript:void(0)" class="more layer" @click="setItemInfo(item)"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115376/more.png" alt=""></a>
                      </li>                                        
                    </ul>
                  </div>
            </section>
            <section class="section03">
								<div class="section03_01 sect_group">
									<a href="#mapGroup416471" class="group_link"></a>
								</div>
								<div class="section03_02 sect_item">
									<ul id="lyrItemlist" class="item_list">
										<li class="item4966267">
											<a href="/shopping/category_prd.asp?itemid=4966267">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4976766">
											<a href="/shopping/category_prd.asp?itemid=4976766">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4817493">
											<a href="/shopping/category_prd.asp?itemid=4817493">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4812967">
											<a href="/shopping/category_prd.asp?itemid=4812967">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
									</ul>
								</div>
							</section>
							<section class="section04">
								 <div class="section04_01 sect_group">
									<a href="#mapGroup416472" class="group_link"></a>
								</div>
								<div class="section04_02 sect_item">
									<ul id="lyrItemlist" class="item_list">
										<li class="item4915158">
											<a href="/shopping/category_prd.asp?itemid=4915158">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4824064">
											<a href="/shopping/category_prd.asp?itemid=4824064">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4982724">
											<a href="/shopping/category_prd.asp?itemid=4982724">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4648242">
											<a href="/shopping/category_prd.asp?itemid=4648242">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
									</ul>
								</div>
							</section>
							<section class="section05">
								 <div class="section05_01 sect_group">
									<a href="#mapGroup416473" class="group_link"></a>
								</div>
								<div class="section05_02 sect_item">
									<ul id="lyrItemlist" class="item_list">
										<li class="item4956974">
											<a href="/shopping/category_prd.asp?itemid=4956974">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4473297">
											<a href="/shopping/category_prd.asp?itemid=4473297">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4583313">
											<a href="/shopping/category_prd.asp?itemid=4583313">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4884043">
											<a href="/shopping/category_prd.asp?itemid=4884043">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
									</ul>
								</div>
							</section>
							<section class="section06">
								 <div class="section06_01 sect_group">
									<a href="#mapGroup416474" class="group_link"></a>
								</div>
								<div class="section06_02 sect_item">
									<ul id="lyrItemlist" class="item_list">
										<li class="item3724805">
											<a href="/shopping/category_prd.asp?itemid=3724805">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4911095">
											<a href="/shopping/category_prd.asp?itemid=4911095">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item4824063">
											<a href="/shopping/category_prd.asp?itemid=4824063">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
										<li class="item2810736">
											<a href="/shopping/category_prd.asp?itemid=2810736">
												<div class="thumbnail"><img src="" alt=""></div>
												<div class="desc">
													<p class="brand">브랜드명</p>
													<p class="name">상품명상품명상품명상품명상품명상품명</p>
													<div class="price"><s>15,000</s><span class="sale">30%</span>11,000</div>
												</div>
											</a>
										</li>
									</ul>
								</div>
							</section>
            <section class="section07"></section>
            <div id="layerDeal" class="layerDeal">
              <div class="slideWrap">
                <div class="slide">
                  <p class="title">
<!--                        <span><b>12.7</b> 화요일</span> 제품 미리보기-->
                  </p>
                  <div class="contents">
                    <div class="itemArea itemDeal">
                      <div class="pdtInfo">
                        <p class="pdtBrand">{{itemDetail.brandName}}</p>
                        <p class="tit_pdtName">{{itemDetail.itemName}}</p>
                      </div>                        
                    </div>
                    <!-- 일반 상품 상세 -->
                    <div class="deal_detail" v-if="dealItemDetails.length < 1">
                      <!-- 상세 이미지 영역 -->
                      <div class="imgArea" id="imgArea">
                         <!-- 상품 설명 -->
                         <div v-html="change_nr(itemDetail.itemContent)"></div>
                         <!-- 추가 이미지 -->
                         <template v-for="addImg in itemDetail.itemAddImages_pc">
                              <img :src="addImg" alt="">
                         </template>
                         <template v-if="itemDetail.mainImage != null"><img :src="itemDetail.mainImage" alt=""></template>
                         <template v-if="itemDetail.mainImage2 != null"><img :src="itemDetail.mainImage2" alt=""></template>
                         <template v-if="itemDetail.mainImage3 != null"><img :src="itemDetail.mainImage3" alt=""></template>
                      </div>
            
                      <!-- 상품정보 -->
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
                          <!-- 해외배송 일때만 추가 -->
                          <div class="pdtInforList abroadMsg" v-if="itemDetail.aboardBeasongYn == 'Y'">
                            <span><em>해외배송 기준 중량</em> : {{itemDetail.itemWeight}}g(1차 포장을 포함한 중량)</span>
                          </div>
                          <!-- //해외배송 일때만 추가 -->
                        </div>
                      </div>
            
                      <!-- 안전인증 정보 노출 -->
                      <div class="safety-mark-area" v-if="itemDetail.itemSafetyCerts && itemDetail.itemSafetyCerts.length > 0">                            
                          <h3 class="tMar50" v-if="itemDetail.itemSafetyCerts[0].safetyYn != 'N'">
                              제품 안전 인증 정보 <span class="fn fs11 cGy0V15 lPad05">본 내용은 판매자가 직접 등록한 것으로 해당 정보에 대한 책임은 판매자에게 있습니다.</span>
                          </h3>
                          <template v-if="itemDetail.itemSafetyCerts[0].safetyYn == 'Y'" v-for="safety in itemDetail.itemSafetyCerts">
                                <!-- case1 -->
                                <div class="pdtInforBox tMar05 safety-mark" v-if="safety.certDiv != null && safety.certDiv != ''">
                                  <span class="ico"></span>
                                  <p><strong>{{safety.safetyDiv}} : </strong><a :href="'http://www.safetykorea.kr/release/certDetail?certNum='+safety.certNum+'&certUid='+safety.certUid">{{safety.certNum}}</a></p>
                                  <p>구매 전에 안전 인증 정보를 꼭 확인하세요.</p>
                                </div>
                                <!-- case2 -->
                                <div class="pdtInforBox tMar05 safety-mark" v-if="safety.certDiv == null || safety.certDiv == ''">
                                  <span class="ico"></span>
                                  <p><strong>전기용품 – 공급자 적합성 확인 : </strong>공급자 적합성 확인 대상 품목으로 인증번호 없음</p>
                                  <p>구매 전에 안전 인증 정보를 꼭 확인하세요.</p>
                                </div>                            
                          </template>
                          <!-- case3 -->
                          <div class="pdtInforBox tMar05" v-if="itemDetail.itemSafetyCerts[0].safetyYn != 'Y'">
                            <div class="pdtInforList">
                              <span>해당 상품 인증 정보는 판매자가 등록한 상품 상세 설명을 참조하시기 바랍니다.</span>
                            </div>
                          </div>
                      </div>
                    </div>
                    
                    <!-- 딜 상품 상세 -->
                    <div class="deal_list" v-if="dealItemDetails.length > 0">
                      <div class="section pdtExplanV15" id="detail01">
                        <div class="item itemDeal">
                          <ul class="pdtList">
                            <!-- for dev msg : 2열타입에는 클래스명 half, 1열 타입에는 클래스명 full 붙여주세요 -->
                            <li class="half" v-for="(item,index) in dealItemDetails">
                              <a href="#layerDeal" class="layer">
                                <!-- for dev msg : 솔드아웃 -->
                                <div class="pdtBox">
                                  <div class="pdtPhoto">
                                    <img :src="item.basicImageImageUrl" alt=""><!-- for dev msg : 이미지 alt=""으로 처리해주세요 -->
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
          currentDate: this.getToday(),
          timeDealItems : [
              {itemid: '4993489', openDate: '20221107'},
              {itemid: '4990985', openDate: '20221108'},
              {itemid: '4987987', openDate: '20221109'},
              {itemid: '4993490', openDate: '20221110'},
              {itemid: '4993491', openDate: '20221111'},
              {itemid: '4993492', openDate: '20221112'},
              {itemid: '4992211', openDate: '20221113'}
          ],
          todayTimeDeal: {},
          itemDetail: {},
          dealItemDetails: []
      }
  },
  created() {
      // 타임딜 세팅
      this.todayTimeDeal = this.timeDealItems.find(v => v.openDate == this.currentDate);
      if(this.todayTimeDeal){
          this.setTodayTimeDeal();
      }
      this.setSubTimeDeal();

      fnApplyItemInfoEach({
          items:"4966267,4976766,4817493,4812967",
          target:"item",
          fields:["price","sale","name","image","brand"],
          unit:"none",
          saleBracket:false
      });    

      fnApplyItemInfoEach({
          items:"4915158,4824064,4982724,4648242",
          target:"item",
          fields:["price","sale","name","image","brand"],
          unit:"none",
          saleBracket:false
      });
                  
      fnApplyItemInfoEach({
          items:"4956974,4473297,4583313,4884043",
          target:"item",
          fields:["price","sale","name","image","brand"],
          unit:"none",
          saleBracket:false
      });
                  
      fnApplyItemInfoEach({
          items:"3724805,4911095,4824063,2810736",
          target:"item",
          fields:["price","sale","name","image","brand"],
          unit:"none",
          saleBracket:false
      });
  },
  methods : {
      prdPopup() {
          this.productPopup = !this.productPopup;
      },
      setConceptItemInit() {
          this.conceptItems.forEach(v => {
              let items = v.subItems.map(i => i.itemid);
              this.setItemInfoEach('conceptSubItems', items, ["image", "name", "price", "sale"]);
          });
          let mainItems = this.conceptItems.map(v => v.mainItemId);
          this.setItemInfoEach('conceptItems', mainItems, ["image", "name", "price", "sale"]);
      },
      /**
       * 이미지 경로 조회
       * @param imgName
       * @returns {*}
       */
      getBackgroundImg(imgName) {
          return this.commonImagePath + imgName + this.imgVer;
      },
      /**
       * 상품 상세 페이지 이동
       * @param itemid
       */
      prdPage(itemid) {
          location.href = '/shopping/category_prd.asp?itemid=' + itemid + '&pEtr=' + this.eventCode;
      },
      /**
       * 해시태그검색
       * @param tag
       */
      searchHashTag(tag) {
          location.href = '/search/search_result.asp?rect=' + tag;
      },
      /**
       * 오픈된 타임특가 세팅
       */
      setTodayTimeDeal(){
          let _this = this;
          let itemid =  this.todayTimeDeal.itemid;
          let url = '/item-week/deal/'+itemid+'/price';
          let method = 'GET';
          let success = function (data) {
              let fields = ["image", "name", "price", "sale"];
              if(data.dealitemid){
                  fields = ["image", "name"];
                  let orgPrice = _this.number_format(data.orgPrice);
                  let sellCash = _this.number_format(data.sellCash);
                  $('.prd_price').html('<s>~'+orgPrice+'원</s> '+sellCash+'원~<span>~'+data.discountRate+'%</span>');
              }
              _this.setTimeDealItemInfo('todayTimeDeal', itemid, fields);
              _this.setCountDown();
          }
          call_api(method, url, '', success, _this.error);
      },
      /**
       * 오픈 예정 타임특가 세팅
       */
      setSubTimeDeal(){
          let items = this.timeDealItems.map(v => v.itemid);
          if(items){
              this.setTimeDealItemInfo('timeDealList', items, ["image"]);
          }
      },
      /**
       * 상품 정보 연동
       * @param target
       * @param items
       * @param fields
       */
      setTimeDealItemInfo(target, items, fields){
          fnApplyToTalPriceItem({
              items: items,
              target: target,
              fields:fields,
              unit:"none",
              saleBracket:false
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
          countDownTimer(openDate.substr(0, 4)
              , openDate.substr(4, 2)
              , openDate.substr(6, 2)
              , 23
              , 59
              , 59
              , new Date()
          );
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
          if (xhr.status == 400){
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
          if(type == 'open'){
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
          if (text){
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
              case "20" :
                  return "전기용품 > 안전확인 신고"
              case "30" :
                  return "전기용품 > 공급자 적합성 확인"
              case "40" :
                  return "생활제품 > 안전인증"
              case "50" :
                  return "생활제품 > 안전확인"
              case "60" :
                  return "생활제품 > 공급자 적합성 확인"
              case "70" :
                  return "어린이제품 > 안전인증"
              case "80" :
                  return "어린이제품 > 안전확인"
              case "90" :
                  return "어린이제품 > 공급자 적합성 확인"
              default :
                  return '';
          }
      },
      number_format(number) {
          return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      },
      /**
       * 상품 정보 연동
       * @param target
       * @param items
       * @param fields
       */
      setItemInfoEach(target, items, fields){
          fnApplyItemInfoEach({
              items: items,
              target: target,
              fields:fields,
              unit:"none",
              saleBracket:false
          });
      },
  }
});