const app = new Vue({
    el: '#app',
    template: `
            <div class="evt116455">
               <section class="section section01">
                <div class="float">
                 <img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/float01.png" alt="" class="float01">
                 <img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/float02.png" alt="" class="float02">
                </div>
               </section>
              <!-- 오늘의 타임 딜 -->
              <section class="timesale">
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
                  <a href="javascript:void(0)" class="prd_link" @click="prdPage(todayTimeDeal.itemid)">바로 구매하기</a>
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
                      <p class="time_date"><span>{{getTimeDealDate(item.openDate)}}</span>{{item.openDate < currentDate ? '종료' : item.brandName}}</p>
                      <a href="javascript:void(0)" class="more layer" @click="setItemInfo(item)"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115376/more.png" alt=""></a>
                    </li>                                        
                  </ul>
                </div>
              </section>
              
               <section class="section section02">
                <div class="section section02_01">
                 <p class="prd_main"><a href="/shopping/category_prd.asp?itemid=4378552&pEtr=116455"></a></p>
                </div>
                <div class="content">
                 <ul>
                  <li class="item3852438">
                   <a href="/shopping/category_prd.asp?itemid=3852438&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd01.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                  <li class="item3725065">
                   <a href="/shopping/category_prd.asp?itemid=3725065&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd02.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                  <li class="item4123554">
                   <a href="/shopping/category_prd.asp?itemid=4123554&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd03.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                  <li class="item4359214">
                   <a href="/shopping/category_prd.asp?itemid=4359214&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd04.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                 </ul>
                 <a href="#mapGroup393160">
                  <img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/btn01.png" alt="" class="btn">
                 </a>
                </div>
               </section>
               <section class="section section03">
                <div class="section section03_01">
                 <p class="prd_main"><a href="/shopping/category_prd.asp?itemid=3903293&pEtr=116455"></a></p>
                </div>
                <div class="content">
                 <ul>
                  <li class="item4291977">
                   <a href="/shopping/category_prd.asp?itemid=4291977&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd05.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                  <li class="item3332369">
                   <a href="/shopping/category_prd.asp?itemid=3332369&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd06.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                  <li class="item4338279">
                   <a href="/shopping/category_prd.asp?itemid=4338279&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd07.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                  <li class="item4150009">
                   <a href="/shopping/category_prd.asp?itemid=4150009&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd08.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                 </ul>
                 <a href="#mapGroup393162">
                  <img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/btn02.png" alt="" class="btn">
                 </a>
                </div>
               </section>
               <section class="section section04">
                <div class="section section04_01">
                 <p class="prd_main"><a href="/shopping/category_prd.asp?itemid=4337960&pEtr=116455"></a></p>
                </div>
                <div class="content">
                 <ul>
                  <li class="item3436295">
                   <a href="/shopping/category_prd.asp?itemid=3436295&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd09.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                  <li class="item4364402">
                   <a href="/shopping/category_prd.asp?itemid=4364402&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd10.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                  <li class="item4344130">
                   <a href="/shopping/category_prd.asp?itemid=4344130&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd11.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                  <li class="item3811442">
                   <a href="/shopping/category_prd.asp?itemid=3811442&pEtr=116455">
                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/prd12.png" alt=""></div>
                    <div class="desc">
                     <p class="brand">PEANUTS</p>
                     <p class="name">상품명 상품명 상품명 상품명</p>
                     <div class="price"><s>1,500,000</s> <span>10%</span>999,999</div>
                    </div>
                   </a>
                  </li>
                 </ul>
                 <a href="#mapGroup393163">
                  <img src="//webimage.10x10.co.kr/fixevent/event/2022/116455/btn03.png" alt="" class="btn">
                 </a>
                </div>
               </section>
               <section class="section section05"> 
                <a href="#mapGroup393164"><p class="link01"></p></a>
                <a href="/shopping/category_prd.asp?itemid=4193426&pEtr=116455"><p class="link02"></p></a>
               </section>
              
              <!-- 상품상세 팝업 -->
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
            eventCode: eCode,
            currentDate: this.getToday(),
            timeDealItems : [
                {itemid: '4379521', openDate: '20220124', brandName: 'iconic'},
                {itemid: '4379626', openDate: '20220125', brandName: 'PPOMPPOM STUDIO'},
                {itemid: '4379520', openDate: '20220126', brandName: '7321 Design'},
                {itemid: '4379512', openDate: '20220127', brandName: 'Wannathis'},
                {itemid: '4379509', openDate: '20220128', brandName: 'JellyCrew'},
                {itemid: '4379485', openDate: '20220129', brandName: 'heeheeclub'},
                {itemid: '4388967', openDate: '20220130', brandName: 'LIVEWORK'}
            ],
            groupItems : [
                {items: '3852438,3725065,4123554,4359214'},
                {items: '4291977,3332369,4338279,4150009'},
                {items: '3436295,4364402,4344130,3811442'},
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

        this.groupItems.forEach(v => {
            fnApplyItemInfoEach({
                items:v.items,      // 상품코드
                target:"item",
                fields:["brand","name","price","sale"],
                unit:"none"
            });
        });
    },
    methods : {
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
        }
    }
});