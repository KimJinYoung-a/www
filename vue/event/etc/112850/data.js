const isDevelop = function() {
    return unescape(location.href).includes('//localhost') || unescape(location.href).includes('//testwww') || unescape(location.href).includes('//localwww');
}();
const isStaging = function() {
    return unescape(location.href).includes('//stgwww');
}();
const isProduction = function() {
    return unescape(location.href).includes('//www');
}();

let eventData;
if( isDevelop ) {
    eventData = {
        // 배너 이벤트 리스트
        "bannerEvents" : [113007, 113008, 113009],
        "bannerBackImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_eventlist0727.jpg",
        // Top 7
        "top7Item1" : {
            "titleImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_top_0727.jpg",
            "itemIds" : [
                2147023, 2147051, 2147067, 2147275, 1202098, 2147303, 1202102
            ]
        },
        "top7Item2" : {
            "titleImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_top02_0727.jpg",
            "itemIds" : [
                2445377, 3140159, 3256902, 2365294, 2785591, 2445376, 3279814
            ]
        }
    };
} else {
    const now = new Date();

    if( isStaging ) { // staging에선 다음날 것 보여줌
        now.setDate(now.getDate() + 1);
    }

    // 29일까지
    if( (now - new Date('2021-07-30 00:00:00')) < 0 ) {
        eventData = {
            // 배너 이벤트 리스트
            "bannerEvents" : [113083, 113084, 112949],
            "bannerBackImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_eventlist0729.jpg",
            // Top 7
            "top7Item1" : {
                "titleImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_top_0729.jpg",
                "itemIds" : [
                    3811441, 2843719, 3942785, 3801530, 3592347, 3527498, 3746444
                ]
            },
            "top7Item2" : {
                "titleImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_top02_0729.jpg",
                "itemIds" : [
                    3811442, 3256902, 3513471, 3668316, 3942783, 3697778, 3866299
                ]
            }
        };
    }

    // 30일까지
    else if( (now - new Date('2021-07-31 00:00:00')) < 0 ) {
        eventData = {
            // 배너 이벤트 리스트
            "bannerEvents" : [113085, 112970, 112624],
            "bannerBackImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_eventlist0730.jpg",
            // Top 7
            "top7Item1" : {
                "titleImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_top_0730.jpg",
                "itemIds" : [
                    3687737, 3109375, 3787840, 3725065, 2868933, 3527455, 3826609
                ]
            },
            "top7Item2" : {
                "titleImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_top02_0730.jpg",
                "itemIds" : [
                    3852437, 3724811, 3911350, 3884509, 3911371, 3811316, 3930516
                ]
            }
        };
    }

    else {
        eventData = {
            // 배너 이벤트 리스트
            "bannerEvents" : [112854, 112855, 113007],
            "bannerBackImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_eventlist0731.jpg",
            // Top 7
            "top7Item1" : {
                "titleImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_top_0731.jpg",
                "itemIds" : [
                    3958139, 3602937, 3332369, 3955067, 3785302, 3461785, 3687737
                ]
            },
            "top7Item2" : {
                "titleImage" : "//webimage.10x10.co.kr/fixevent/event/2021/112850/bg_top02_0731.jpg",
                "itemIds" : [
                    3696783, 3957925, 3958138, 2104155, 3312981, 3922264, 3852437
                ]
            }
        };
    }
}