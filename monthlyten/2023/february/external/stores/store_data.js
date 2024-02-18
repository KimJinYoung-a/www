const getAssignList = (origin, payload) => {
    const partList = [];
    for (let i = 0; i < origin.length; i++) {
        const originItem = origin[i];
        for (let j = 0; j < payload.length; j++) {
            const retrivedItem = payload[j];
            if (originItem.itemId === retrivedItem.itemid) {
                const newItem = Object.assign(originItem, {
                    itemName: retrivedItem.itemname,
                    discountRate: !!retrivedItem.saleper.length ? retrivedItem.saleper.replace(/%/g, '') : '0',
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
        itemListPart1: [],
        itemListPart2: [],
	},
    getters: {
        itemListPart1(state) {
            return state.itemListPart1;
        },
        itemListPart2(state) {
            return state.itemListPart2;
        },
    },
    mutations: {
        SET_TRAILER(state, payload) {
            const imagePrefixUrl = 'https://webimage.10x10.co.kr/fixevent/event/2023/monthly/feburary/pc/intro/part';
            const originPart1 = [
                {
                    itemId: '3231841',
                    itemImage: `${imagePrefixUrl}1__item01.png`,
                },
                {
                    itemId: '4207531',
                    itemImage: `${imagePrefixUrl}1__item02.png`,
                },
                {
                    itemId: '2543542',
                    itemImage: `${imagePrefixUrl}1__item03.png`,
                },
                {
                    itemId: '5154008',
                    itemImage: `${imagePrefixUrl}1__item04.png`,
                },
            ];
            
            const originPart2 = [
                {
                    itemId: '4342209',
                    itemImage: `${imagePrefixUrl}2__item01.png`,
                },
                {
                    itemId: '2887074',
                    itemImage: `${imagePrefixUrl}2__item02.png`,
                },
                {
                    itemId: '4722047',
                    itemImage: `${imagePrefixUrl}2__item03.png`,
                },
                {
                    itemId: '4764294',
                    itemImage: `${imagePrefixUrl}2__item04.png`,
                },
                {
                    itemId: '2857622',
                    itemImage: `${imagePrefixUrl}2__item05.png`,
                }
            ];

            state.itemListPart1 = getAssignList(originPart1, payload);
            state.itemListPart2 = getAssignList(originPart2, payload);
        },
    },
    actions: {
        async GET_TRAILER(context) {
            try {
                const preFetchUrl = `https://fapi.10x10.co.kr/api/web/v1/event/sub-category-of-items?masterCode=${24}&detailCodes=${500}`;
                const preFetching = await fetch(preFetchUrl);
                if (preFetching.ok) {
                    const toPreJson = await preFetching.json();
                    const arriid = toPreJson.map(item => item.itemid).join(',');
                    const wrappedDataFetchUrl = `/event/etc/json/act_getItemInfo6.asp?arriid=${arriid}`;
                    const wrappedDataFetching = await fetch(wrappedDataFetchUrl);
                    if (wrappedDataFetching.ok) {
                        const toPostJson = await wrappedDataFetching.json();
                        context.commit('SET_TRAILER', toPostJson.items);
                    }
                }
            } catch (e) {}
        },
    },
});