Vue.component('surprise',{
	template : `
        <section id="tab04" class="section04">
            <div class="in_wrap">
                <div class="inner">
                    <h2><span>언제 사라질지 모르는 오늘의 혜택​</span>저희도 깜짝선물​<br>드릴게요!</h2>
                    <div :class="'surprise ' + [showSurprizeMileage ? 'two': 'one'] ">
                        <div class="coupon" v-if="is_login_ok"><a href="/my10x10/couponbook.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/coupon.png" alt=""></a></div>
                        <div v-else class="coupon"><a href="javascript:void(0);" @click="go_login"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/coupon_logout.png" alt="깜짝쿠폰 로그인"></a></div>

                        <div v-if="showSurprizeMileage">
                            <div v-if="is_login_ok" class="mileage login">
                                <a href="javascript:void(0);" @click="goEventPage" v-if="surpriseMileageLoginImageFind">
                                    <img v-for="name in surpriseMileageLoginImage" :src=name alt="">
                                </a>
                            </div>
                            <div v-else class="mileage logout"><a href="javascript:void(0);" @click="go_login"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/milege_logout.png" alt=""></a></div>
                        </div>
                    </div>
                    <div v-if="showSurprizeSale" class="limit_price">										
                        <div class="bene_prd" v-for="(item, index) in supriseItems">
                            <a href="javascript:void(0);" @click="prdDetailPage(item)" :class="'supriseItems' + item">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="right">
                                    <div class="bene_tit">
                                        <h4><span>깜짝</span> 최저가</h4>
                                        <p class="bene_copy">오늘만! 어디서도 볼 수 없는 가격으로<br>만들었어요. 놓치지 마세요 :)</p>
                                    </div>
                                    <div class="desc">
                                        <p class="price"><s></s> <span class="sale"></span></p>
                                        <p class="name"></p>														
                                    </div>
                                </div>                                               
                            </a>
                        </div> 
                    </div>
                    <div v-if="showSurprizeFreeDelivery" class="free_delivery">
                        <div class="bene_tit">
                            <h4><span>깜짝</span> 다이어리 무배</h4>
                            <p class="bene_copy">하나만 사도 배송비가 0원!</p>
                        </div>
                        <div class="swiper mySwiper">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide" v-for="(items, index) in surpiseFreeDeliveryItems">
                                    <a href="javascript:void(0);" @click="prdDetailPage2(items)" :class="'surpiseFreeDeliveryItems' + items">
                                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <a href="javascript:void(0);" @click="goEventPage2" class="free_more">무료배송 아이템 더 보기</a>
                    </div>
                </div>
            </div>
        </section>
	`
    , created() {
        this.$nextTick(function() {
            this.is_login_ok = isUserLoginOK;
            if(!this.is_login_ok){
                this.userid = '고객';
            }else{
                this.userid = userid;
            }
        });
    }
    , data() {
        return {
            itemList: [],
            is_login_ok : false,
            surpriseEventMileage: "",
            surpriseMileageLoginImage: [],
            surpriseEventFreeDelivery: "",
            surpriseSaleItem : [],
            surpriseFreeDeliveryItem : []
        }
    }
    , updated() {

    }
    , mounted() {
        const _this = this;
        _this.$nextTick(function() {
            if(this.surpriseEventMileage!=""){
                $("#surprisetxt").html("2,000p");
            }
        })
        
    }
    , computed : {
        showSurprizeMileage() {
            if (this.showSurprizeFirstMilegae || this.showSurprizeSecondMilegae) {
                if(this.showSurprizeFirstMilegae){
                    this.surpriseEventMileage = "121347";
                }else if(this.showSurprizeSecondMilegae){
                    this.surpriseEventMileage = "121584";
                }
                return true;
            } else {
                return false;
            }
        },
        surpriseMileageLoginImageFind() {
            if (this.showSurprizeFirstMilegae) {
                this.surpriseMileageLoginImage = ["https://webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/milege_login.png"];
            }else if(this.showSurprizeSecondMilegae) {
                this.surpriseMileageLoginImage = ["https://webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/milege_login02.png"];
            }
            return this.surpriseMileageLoginImage;
        },
        showSurprizeFirstMilegae() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 8, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 9, 23, 59, 59).getTime();

            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showSurprizeSecondMilegae() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 15, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 16, 23, 59, 59).getTime();

            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showSurprizeSale() {
            if (this.showSurprizeFirstSale || this.showSurprizeSecondSale || this.showSurprizeThirdSale || this.showSurprizeFourthSale) {
                if(this.showSurprizeFirstSale){
                    this.surpriseSaleItem=[4814000];
                    //this.surpriseSaleItem=[4548548];
                }else if(this.showSurprizeSecondSale){
                    this.surpriseSaleItem=[4921892];
                }else if(this.showSurprizeThirdSale){
                    this.surpriseSaleItem=[4813997];
                }else if(this.showSurprizeFourthSale){
                    this.surpriseSaleItem=[4898834];
                }
                return true;
            } else {
                return false;
            }
        },
        showSurprizeFirstSale() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 4, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 5, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showSurprizeSecondSale() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 7, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 7, 23, 59, 59).getTime();

            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showSurprizeThirdSale() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 12, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 12, 23, 59, 59).getTime();

            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showSurprizeFourthSale() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 14, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 14, 23, 59, 59).getTime();

            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        supriseItems() { 
            const items = this.surpriseSaleItem;
            this.setItemInit('supriseItems', items);
            return this.surpriseSaleItem;
        },
        showSurprizeFreeDelivery() {
            if (this.showSurprizeFirstFreeDelivery || this.showSurprizeSecondFreeDelivery) {
                if(this.showSurprizeFirstFreeDelivery){
                    this.surpriseFreeDeliveryItem=[4866384,4820641,4834773,4907999];
                    this.surpriseEventFreeDelivery = "121454";
                }else if(this.showSurprizeSecondFreeDelivery){
                    this.surpriseFreeDeliveryItem=[4975399,4877096,4166621,4907998];
                    this.surpriseEventFreeDelivery = "121455";
                }
                return true;
            } else {
                return false;
            }
        },
        showSurprizeFirstFreeDelivery() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 4, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 6, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showSurprizeSecondFreeDelivery() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 12, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 13, 23, 59, 59).getTime();

            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        surpiseFreeDeliveryItems() { 
            const items = this.surpriseFreeDeliveryItem;
            this.setItemInit2('surpiseFreeDeliveryItems', items);
            return this.surpriseFreeDeliveryItem;
        },
    },
    methods : {
        /**
         * 상품 정보 연동
         * @param target 클래스명
         * @param items 상품아이디
         * @param fields 상품 정보 필드명
         */
        setItemInfo(target, items, fields){
            fnApplyItemInfoEach({
                items: items,
                target: target,
                fields:fields,
                unit:"none",
                saleBracket:false
            });
        },
        setItemInit(target, e) {
            const _this = this;
            let items = e[0];
            _this.setItemInfo(target, items, ["image", "name", "price", "sale"]);
        },
        setItemInit2(target, e) {
            const _this = this;
            let items = e.map(i => i);
            _this.setItemInfo(target, items, ["image"]);
        },
        prdDetailPage(itemid){
            fnAmplitudeEventAction('click_tentensale_sp_lowprice', '', '');
            location.href = "/shopping/category_prd.asp?itemid=" + itemid;
        },
        prdDetailPage2(itemid){
            fnAmplitudeEventAction('click_tentensale_sp_freedelivery', 'item_id', itemid);
            location.href = "/shopping/category_prd.asp?itemid=" + itemid;
        },
        goEventPage() {
            fnAmplitudeEventAction('click_tentensale_sp_mileage', '', '');
            location.href = "/my10x10/mymileage.asp?dType=B";
        },
        goEventPage2() {
            let code = "";
            code = this.surpriseEventFreeDelivery;
            fnAmplitudeEventAction('click_tentensale_sp_freedelivery_button', '', '');
            location.href = "/event/eventmain.asp?eventid=" + code;;
        },
        go_login(){
            location.href="/login/loginpage.asp?vType=G";
        },
        goMyBonusCouponPage() {
            fnAmplitudeEventAction('click_tentensale_couponpack', '', '');
            location.href = "/my10x10/couponbook.asp";
        }
    }
})