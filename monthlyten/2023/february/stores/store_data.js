const BRAND_DETAIL_CODE = {
    LUCALAB: 700,
    SANRIO: 701,
    DECOVIEW: 702,
    PEANUTS: 703,
    DRETEC: 704,
    SUKEYDOKEY: 705,
    RECORDER_FACTORY: 706,
    GALAXY: 707,
    KODAK: 708,
    RHINO: 709,
    HOMES_LIVING: 710,
    ARPEGGIO_BASIC: 712,
    ROYCHE: 713,
    MOSH: 714,
    ZANMANG_LOOPY: 715,
    DISNEY: 716,
    NINTENDO: 717,
    GLOBAL_BRAND: 718,
};

const CATEGORY_CODE = {
    DESIGN_STATIONERY: "101",
    TOY_AND_HOBBY: "104",
    KITCHEN: "112",
    FASHION_ACCESSORIES: "116",
    FABRIC_AND_LIFE: "120",
    DECOR_AND_LIGHTING: "122",
    DESIGN_APPLIANCES: "124",
    DIGITAL: "102",
};

const DISCOUNT_DETAIL_CODE = {
    DESIGN_STATIONERY: 601,
    TOY_AND_HOBBY: 604,
    KITCHEN: 606,
    FASHION_ACCESSORIES: 607,
    FABRIC_AND_LIFE: 611,
    DECOR_AND_LIGHTING: 613,
    DESIGN_APPLIANCES: 614,
    DIGITAL: 615,
};

const reconstructBrandItem = (target, itemCountList) => {
    if (target.length > 0) {
        const item = target[0];
        let brandKrName = "";
        let itemCount = 4;
        for (let i = 0; i < itemCountList.length; i++) {
            if (item.makerid.toLowerCase() === itemCountList[i].makerid) {
                itemCount = itemCountList[i].itemCount;
                break;
            }
        }

        switch (item.detailcode) {
            case BRAND_DETAIL_CODE.LUCALAB:
                brandKrName = "루카랩";
                break;
            case BRAND_DETAIL_CODE.GLOBAL_BRAND:
                brandKrName = "글로벌 브랜드";
                break;
            case BRAND_DETAIL_CODE.NINTENDO:
                brandKrName = "닌텐도";
                break;
            case BRAND_DETAIL_CODE.HOMES_LIVING:
                brandKrName = "홈즈리빙";
                break;
            case BRAND_DETAIL_CODE.DRETEC:
                brandKrName = "드레텍";
                break;
            case BRAND_DETAIL_CODE.SUKEYDOKEY:
                brandKrName = "수키도키";
                break;
            case BRAND_DETAIL_CODE.RECORDER_FACTORY:
                brandKrName = "리코더팩토리";
                break;
            case BRAND_DETAIL_CODE.GALAXY:
                brandKrName = "갤럭시";
                break;
            case BRAND_DETAIL_CODE.KODAK:
                brandKrName = "코닥";
                break;
            case BRAND_DETAIL_CODE.RHINO:
                brandKrName = "라이노";
                break;
            case BRAND_DETAIL_CODE.DECOVIEW:
                brandKrName = "데코뷰";
                break;
            case BRAND_DETAIL_CODE.ARPEGGIO_BASIC:
                brandKrName = "아르페지오베이직";
                break;
            case BRAND_DETAIL_CODE.ROYCHE:
                brandKrName = "로이체";
                break;
            case BRAND_DETAIL_CODE.MOSH:
                brandKrName = "모슈";
                break;
            case BRAND_DETAIL_CODE.ZANMANG_LOOPY:
                brandKrName = "잔망루피";
                break;
            case BRAND_DETAIL_CODE.DISNEY:
                brandKrName = "디즈니";
                break;
            case BRAND_DETAIL_CODE.PEANUTS:
                brandKrName = "피너츠";
                break;
            case BRAND_DETAIL_CODE.SANRIO:
                brandKrName = "산리오";
        }

        return {
            brand_id: item.makerid,
            brand_name_kr: brandKrName,
            brand_name_en: item.brandname,
            itemCount: itemCount,
            products: target,
        };
    }

    return null;
};

const reconstructDiscountItem = (target, itemCountList) => {
    if (target.length > 0) {
        const item = target[0];
        let categoryCode = "";
        let categoryKrName = "";
        let itemCount = 4;
        for (let i = 0; i < itemCountList.length; i++) {
            if (`${item.detailcode}` === itemCountList[i].detailCode) {
                itemCount = itemCountList[i].itemCount;
                break;
            }
        }

        switch (item.detailcode) {
            case DISCOUNT_DETAIL_CODE.DESIGN_STATIONERY:
                categoryCode = CATEGORY_CODE.DESIGN_STATIONERY;
                categoryKrName = "디자인문구";
                break;
            case DISCOUNT_DETAIL_CODE.TOY_AND_HOBBY:
                categoryCode = CATEGORY_CODE.TOY_AND_HOBBY;
                categoryKrName = "토이/취미";
                break;
            case DISCOUNT_DETAIL_CODE.KITCHEN:
                categoryCode = CATEGORY_CODE.KITCHEN;
                categoryKrName = "키친";
                break;
            case DISCOUNT_DETAIL_CODE.FASHION_ACCESSORIES:
                categoryCode = CATEGORY_CODE.FASHION_ACCESSORIES;
                categoryKrName = "패션잡화";
                break;
            case DISCOUNT_DETAIL_CODE.FABRIC_AND_LIFE:
                categoryCode = CATEGORY_CODE.FABRIC_AND_LIFE;
                categoryKrName = "패브릭/생활";
                break;
            case DISCOUNT_DETAIL_CODE.DECOR_AND_LIGHTING:
                categoryCode = CATEGORY_CODE.DECOR_AND_LIGHTING;
                categoryKrName = "데코/조명";
                break;
            case DISCOUNT_DETAIL_CODE.DESIGN_APPLIANCES:
                categoryCode = CATEGORY_CODE.DESIGN_APPLIANCES;
                categoryKrName = "디자인가전";
                break;
            case DISCOUNT_DETAIL_CODE.DIGITAL:
                categoryCode = CATEGORY_CODE.DIGITAL;
                categoryKrName = "디지털";
        }

        return {
            category_id: item.detailcode,
            category_name_kr: categoryKrName,
            code: categoryCode,
            itemCount: itemCount,
            products: target,
        };
    }

    return null;
};

const getAssignList = (origin, payload) => {
    const partList = [];
    for (let i = 0; i < origin.length; i++) {
        const originItem = origin[i];
        for (let j = 0; j < payload.length; j++) {
            const retrivedItem = payload[j];
            if (originItem.itemId === retrivedItem.itemid) {
                const newItem = Object.assign(originItem, {
                    itemName: retrivedItem.itemname,
                    discountRate: !!retrivedItem.saleper.length
                        ? retrivedItem.saleper.replace(/%/g, "")
                        : "0",
                    soldout: retrivedItem.soldout,
                });

                partList.push(newItem);
                break;
            }
        }
    }

    return partList;
};

const dataStore = new Vuex.Store({
    state: {
        signInUser: { userName: '', agreeCheck: false },
        isPublishedCoupon: false,
        itemListPart1: [],
        itemListPart2: [],
        takePartBrandList: [],
        todayBrandItemList: [],
        brandItemListGroup: [],
        discountItemListGroup: [],
        eventList: [],
        isApp: false,
        hasCoupon: false,
        brandItemCountList: [],
        categoryItemCountList: [],
    },
    getters: {
        signInUser(state) {
            return state.signInUser;
        },
        isPublishedCoupon(state) {
            return state.isPublishedCoupon;
        },
        itemListPart1(state) {
            return state.itemListPart1;
        },
        itemListPart2(state) {
            return state.itemListPart2;
        },
        takePartBrandList(state) {
            return state.takePartBrandList;
        },
        todayBrandItemList(state) {
            return state.todayBrandItemList;
        },
        brandItemListGroup(state) {
            return state.brandItemListGroup;
        },
        discountItemListGroup(state) {
            return state.discountItemListGroup;
        },
        eventList(state) {
            return state.eventList;
        },
        isApp(state) {
            return state.isApp;
        },
        hasCoupon(state) {
            return state.hasCoupon;
        },
        brandItemCountList(state) {
            return state.brandItemCountList;
        },
        categoryItemCountList(state) {
            return state.categoryItemCountList;
        },
    },
    mutations: {
        SET_TRAILER(state, payload) {
            const imagePrefixUrl =
                "https://webimage.10x10.co.kr/fixevent/event/2023/monthly/feburary/pc/intro/part";
            const originPart1 = [
                {
                    itemId: "3231841",
                    itemImage: `${imagePrefixUrl}1__item01.png`,
                },
                {
                    itemId: "4207531",
                    itemImage: `${imagePrefixUrl}1__item02.png`,
                },
                {
                    itemId: "2543542",
                    itemImage: `${imagePrefixUrl}1__item03.png`,
                },
                {
                    itemId: "5154008",
                    itemImage: `${imagePrefixUrl}1__item04.png`,
                },
            ];

            const originPart2 = [
                {
                    itemId: "4342209",
                    itemImage: `${imagePrefixUrl}2__item01.png`,
                },
                {
                    itemId: "2887074",
                    itemImage: `${imagePrefixUrl}2__item02.png`,
                },
                {
                    itemId: "4722047",
                    itemImage: `${imagePrefixUrl}2__item03.png`,
                },
                {
                    itemId: "4764294",
                    itemImage: `${imagePrefixUrl}2__item04.png`,
                },
                {
                    itemId: "2857622",
                    itemImage: `${imagePrefixUrl}2__item05.png`,
                },
            ];

            state.itemListPart1 = getAssignList(originPart1, payload);
            state.itemListPart2 = getAssignList(originPart2, payload);
        },
        SET_TODAY_BRAND_ITEM_LIST(state, payload) {
            state.todayBrandItemList = payload;
        },
        SET_BRAND_ITEM_LIST_GROUP(state, payload) {
            state.brandItemListGroup = payload;
        },
        SET_DISCOUNT_ITEM_LIST_GROUP(state, payload) {
            state.discountItemListGroup = payload;
        },
        SET_HAS_COUPON(state, payload) {
            state.hasCoupon = payload;
        },
        SET_EVENT_LIST(state, payload) {
            state.eventList = payload;
        },
        SET_HAS_COUPON(state, payload) {
            state.hasCoupon = payload;
        },
        SET_USER_INFO(state, payload) {
            let info = { userName: username, agreeCheck: payload };
            state.signInUser = info;
        },
        SET_BRAND_ITEM_COUNT_LIST(state, payload) {
            state.brandItemCountList = payload;
        },
        SET_CATEGORY_ITEM_COUNT_LIST(state, payload) {
            state.categoryItemCountList = payload;
        },
    },
    actions: {
        async GET_TRAILER(context) {
            try {
                const preFetchUrl = `https://fapi.10x10.co.kr/api/web/v1/event/sub-category-of-items?masterCode=${24}&detailCodes=${500}`;
                const preFetching = await fetch(preFetchUrl);
                if (preFetching.ok) {
                    const toPreJson = await preFetching.json();
                    const arriid = toPreJson.map((item) => item.itemid).join(",");
                    const wrappedDataFetchUrl = `/event/etc/json/act_getItemInfo6.asp?arriid=${arriid}`;
                    const wrappedDataFetching = await fetch(wrappedDataFetchUrl);
                    if (wrappedDataFetching.ok) {
                        const toPostJson = await wrappedDataFetching.json();
                        context.commit("SET_TRAILER", toPostJson.items);
                    }
                }
            } catch (e) {}
        },
        async GET_TODAY_BRAND_ITEM_LIST(context) {
            try {
                const targetUrl = `https://fapi.10x10.co.kr/api/web/v1/event/events-slidebanner?detailCode=500&deviceType=PC&mastercode=24`;
                const response = await fetch(targetUrl);
                if (response.ok) {
                    const json = await response.json();
                    const arriid = [];
                    json.map((item) => {
                        let params = {};
                        item.linkurl.replace(
                            /[?&]+([^=&]+)=([^&]*)/gi,
                            (str, key, value) => {
                                params[key] = value;
                            }
                        );

                        if (params.hasOwnProperty("itemid")) {
                            arriid.push(params.itemid);
                        }
                    });

                    const iidQuery = arriid.join(",");
                    const itemRefetchUrl = `/event/etc/json/act_getItemInfo6.asp?arriid=${iidQuery}`;
                    const itemRefetching = await fetch(itemRefetchUrl);
                    if (itemRefetching.ok) {
                        const toPostJson = await itemRefetching.json();
                        context.commit("SET_TODAY_BRAND_ITEM_LIST", toPostJson.items);
                    }
                }
            } catch (e) {}
        },
        async GET_BRAND_ITEM_LIST_GROUP(context) {
            try {
                const itemCountAllUrl = "/event/etc/brandListCount.asp?mastercode=24";
                const itemCountAllResponse = await fetch(itemCountAllUrl);
                if (itemCountAllResponse.ok) {
                    const itemCountJson = await itemCountAllResponse.json();
                    context.commit("SET_BRAND_ITEM_COUNT_LIST", itemCountJson.brandlist);
                    let detailCodes = Object.values(BRAND_DETAIL_CODE)
                        .map((code) => code)
                        .join(",");
                    const targetUrl = `https://fapi.10x10.co.kr/api/web/v1/event/sub-category-of-items?masterCode=${24}&detailCodes=${detailCodes}&deviceType=MOBILE`;
                    const response = await fetch(targetUrl);
                    if (response.ok) {
                        const json = await response.json();
                        const first = [],
                              second = [],
                              third = [],
                              fourth = [],
                              fifth = [],
                              sixth = [],
                              seventh = [],
                              eighth = [],
                              nineth = [],
                              tenth = [],
                              eleventh = [],
                              twelveth = [],
                              thirteenth = [],
                              fourteenth = [],
                              fifteenth = [],
                              sixteenth = [],
                              seventeenth = [],
                              eighteenth = [];

                        json.map((item) => {
                            switch (item.detailcode) {
                                case BRAND_DETAIL_CODE.LUCALAB:
                                    if (first.length < 4) {
                                        first.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.SANRIO:
                                    if (second.length < 4) {
                                        second.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.DECOVIEW:
                                    if (third.length < 4) {
                                        third.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.PEANUTS:
                                    if (fourth.length < 4) {
                                        fourth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.DRETEC:
                                    if (fifth.length < 4) {
                                        fifth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.SUKEYDOKEY:
                                    if (sixth.length < 4) {
                                        sixth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.RECORDER_FACTORY:
                                    if (seventh.length < 4) {
                                        seventh.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.GALAXY:
                                    if (eighth.length < 4) {
                                        eighth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.KODAK:
                                    if (nineth.length < 4) {
                                        nineth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.RHINO:
                                    if (tenth.length < 4) {
                                        tenth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.HOMES_LIVING:
                                    if (eleventh.length < 4) {
                                        eleventh.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.ARPEGGIO_BASIC:
                                    if (twelveth.length < 4) {
                                        twelveth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.ROYCHE:
                                    if (thirteenth.length < 4) {
                                        thirteenth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.MOSH:
                                    if (fourteenth.length < 4) {
                                        fourteenth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.ZANMANG_LOOPY:
                                    if (fifteenth.length < 4) {
                                        fifteenth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.DISNEY:
                                    if (sixteenth.length < 4) {
                                        sixteenth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.NINTENDO:
                                    if (seventeenth.length < 4) {
                                        seventeenth.push(item);
                                    }

                                    break;
                                case BRAND_DETAIL_CODE.GLOBAL_BRAND:
                                    if (eighteenth.length < 4) {
                                        eighteenth.push(item);
                                    }

                                    break;
                            }
                        });

                        const group = [];
                        const itemCountList = itemCountJson.brandlist;
                        group.push(reconstructBrandItem(first, itemCountList));
                        group.push(reconstructBrandItem(second, itemCountList));
                        group.push(reconstructBrandItem(third, itemCountList));
                        group.push(reconstructBrandItem(fourth, itemCountList));
                        group.push(reconstructBrandItem(fifth, itemCountList));
                        group.push(reconstructBrandItem(sixth, itemCountList));
                        group.push(reconstructBrandItem(seventh, itemCountList));
                        group.push(reconstructBrandItem(eighth, itemCountList));
                        group.push(reconstructBrandItem(nineth, itemCountList));
                        group.push(reconstructBrandItem(tenth, itemCountList));
                        group.push(reconstructBrandItem(eleventh, itemCountList));
                        group.push(reconstructBrandItem(twelveth, itemCountList));
                        group.push(reconstructBrandItem(thirteenth, itemCountList));
                        group.push(reconstructBrandItem(fourteenth, itemCountList));
                        group.push(reconstructBrandItem(fifteenth, itemCountList));
                        group.push(reconstructBrandItem(sixteenth, itemCountList));
                        group.push(reconstructBrandItem(seventeenth, itemCountList));
                        group.push(reconstructBrandItem(eighteenth, itemCountList));
                        context.commit(
                            "SET_BRAND_ITEM_LIST_GROUP",
                            group.filter((object) => object !== null)
                        );
                    }
                } else {
                    throw new Error('');
                }
            } catch (e) {}
        },
        async GET_DISCOUNT_ITEM_LIST_GROUP(context) {
            try {
                const itemCountAllUrl = "/event/etc/brandListCount.asp?mastercode=24";
                const itemCountAllResponse = await fetch(itemCountAllUrl);
                if (itemCountAllResponse.ok) {
                    const itemCountJson = await itemCountAllResponse.json();
                    context.commit("SET_CATEGORY_ITEM_COUNT_LIST", itemCountJson.categorylist);
                    let detailCodes = Object.values(DISCOUNT_DETAIL_CODE)
                        .map((code) => code)
                        .join(",");
                    const targetUrl = `https://fapi.10x10.co.kr/api/web/v1/event/sub-category-of-items?masterCode=${24}&detailCodes=${detailCodes}&deviceType=MOBILE`;
                    const response = await fetch(targetUrl);
                    if (response.ok) {
                        const json = await response.json();
                        const designStationeryList = [],
                              toyAndHobbyList = [],
                              kitchenList = [],
                              fashionAccessoriesList = [],
                              fabricAndLifeList = [],
                              decorAndLightingList = [],
                              designAppliancesList = [],
                              digitalList = [];

                        json.map((item) => {
                            switch (item.detailcode) {
                                case DISCOUNT_DETAIL_CODE.DESIGN_STATIONERY:
                                    if (designStationeryList.length < 4) {
                                        designStationeryList.push(item);
                                    }

                                    break;
                                case DISCOUNT_DETAIL_CODE.TOY_AND_HOBBY:
                                    if (toyAndHobbyList.length < 4) {
                                        toyAndHobbyList.push(item);
                                    }

                                    break;
                                case DISCOUNT_DETAIL_CODE.KITCHEN:
                                    if (kitchenList.length < 4) {
                                        kitchenList.push(item);
                                    }

                                    break;
                                case DISCOUNT_DETAIL_CODE.FASHION_ACCESSORIES:
                                    if (fashionAccessoriesList.length < 4) {
                                        fashionAccessoriesList.push(item);
                                    }

                                    break;
                                case DISCOUNT_DETAIL_CODE.FABRIC_AND_LIFE:
                                    if (fabricAndLifeList.length < 4) {
                                        fabricAndLifeList.push(item);
                                    }

                                    break;
                                case DISCOUNT_DETAIL_CODE.DECOR_AND_LIGHTING:
                                    if (decorAndLightingList.length < 4) {
                                        decorAndLightingList.push(item);
                                    }

                                    break;
                                case DISCOUNT_DETAIL_CODE.DESIGN_APPLIANCES:
                                    if (designAppliancesList.length < 4) {
                                        designAppliancesList.push(item);
                                    }

                                    break;
                                case DISCOUNT_DETAIL_CODE.DIGITAL:
                                    if (digitalList.length < 4) {
                                        digitalList.push(item);
                                    }

                                    break;
                            }
                        });

                        const group = [];
                        const itemCountList = itemCountJson.categorylist;
                        group.push(
                            reconstructDiscountItem(designStationeryList, itemCountList)
                        );
                        group.push(reconstructDiscountItem(toyAndHobbyList, itemCountList));
                        group.push(reconstructDiscountItem(kitchenList, itemCountList));
                        group.push(
                            reconstructDiscountItem(fashionAccessoriesList, itemCountList)
                        );
                        group.push(reconstructDiscountItem(fabricAndLifeList, itemCountList));
                        group.push(
                            reconstructDiscountItem(decorAndLightingList, itemCountList)
                        );
                        group.push(
                            reconstructDiscountItem(designAppliancesList, itemCountList)
                        );
                        group.push(reconstructDiscountItem(digitalList, itemCountList));
                        context.commit(
                            "SET_DISCOUNT_ITEM_LIST_GROUP",
                            group.filter((object) => object !== null)
                        );
                    }
                } else {
                  throw new Error('');
                }
            } catch (e) {}
        },
        async GET_EVENT_LIST(context) {
            try {
                const targetUrl = `https://gateway.10x10.co.kr/v1/event/apis/exhibition-event-group/24`;
                const response = await fetch(targetUrl);
                if (response.ok) {
                    const json = await response.json();
                    if (json.status === 200) {
                        context.commit(
                            "SET_EVENT_LIST",
                            json.result.filter((event) => event.eventCode != 122361)
                        );
                    }
                }
            } catch (e) {}
        },
        GET_CHECK_HAS_COUPON_STATE(context) {
            fetch(`/event/etc/checkCouponDownload.asp?mode=bonuscoupon&couponCode=${couponCodeFebruaryMonthlyten}`)
            .then((response) => {
                if (response.ok) {
                    return response.json();
                }

                throw new Error("Network response was not ok");
            })
            .then((json) => {
                if (json.response === 'ok') {
                    if (json.coupondown) {
                        context.commit("SET_HAS_COUPON", true);
                    } else {
                        context.commit("SET_HAS_COUPON", false);
                    }
                } else {
                    context.commit("SET_HAS_COUPON", false);
                }
            })
            .catch((error) => {
                console.log(error);
            });
        },
        async DOWNLOAD_COUPON(context) {
            try {
                const fetchOptions = {
                    method: "GET",
                    credentials: "include",
                    headers: {
                        "Content-Type": "application/json",
                    },
                }

                const response = await fetch(
                    `//fapi.10x10.co.kr/api/web/v1/event/bonus-coupon-all-download?bonusCoupons=${couponCodeFebruaryMonthlyten}`,
                    fetchOptions,
                );

                if (response.ok) {
                    const object = await response.json();
                    if (isNaN(object)) {
                        if (object.code === -10) {
                            alert(
                                "로그인이 필요한 서비스 입니다. 로그인 페이지로 이동합니다."
                            );

                            location.href = `/login/loginpage.asp?backpath=/monthlyten/2023/february/index.asp`;
                        }
                    } else {
                        if (object === 0) {
                            context.commit("SET_HAS_COUPON", true);
                            alert("쿠폰이 발급되었습니다. 결제 시 사용해 주세요.");
                            getFrontApiData(
                                'PUT',
                                '/user/smart-alarm',
                                {},
                                function (data) {
                                    return data;
                                }
                            );
                        } else if (object === 1) {
                            alert("쿠폰 지급 시 문제가 발생했습니다.");
                        } else if (object === 2) {
                            alert("발급받을 쿠폰이 없습니다.");
                        } else {
                            alert("이미 발급 받은 쿠폰입니다.");
                        }
                    }
                }
            } catch (e) {}
        },
    },
});
