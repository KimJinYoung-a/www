/*
* 2021-11-03 김형태
* 이벤트 관련 공통 스크립트
* */

const give_coupon = function(coupon_type, coupon_code, event_code){
    /*
    *---coupon_type---
    * prd    : 상품쿠폰
    * event  : 이벤트 쿠폰
    * evtsel : 선택이벤트 쿠폰
    *
    *---coupon_code---
    * 콤마로 이어써도 split으로 처리된다. But!! stype과 pair로 써줘야한다.
    * ex) coupon_type : prd,prd
    *     coupon_code : 123,456
    *
    *     pair가 아니면 에러발생
    * */
    return new Promise(function(resolve, reject){
        const ajax_data = {"stype" : coupon_type, "idx" : coupon_code};

        $.ajax({
            type: "POST"
            , url: "/shoppingtoday/act_couponshop_process.asp"
            , data: ajax_data
            , cache: false
            , success: function(message) {
                fnAmplitudeEventMultiPropertiesAction('click_coupon_btn','evtcode', event_code);

                if(typeof(message)=="object") {
                    if(message.response=="Ok") {
                        alert("쿠폰이 발급되었습니다. \n쿠폰함을 확인해보세요!");
                        return resolve();
                    } else {
                        alert(message.message);
                        return reject();
                    }
                } else {
                    alert("처리중 오류가 발생했습니다.");
                    return reject();
                }
            }
            , error: function(err) {
                console.log(err.responseText);
                return reject();
            }
        });
    });
}

/*
* 마일리지 지급
* */
const give_mileage = function(event_code){
    return new Promise(function(resolve, reject){
        call_apiV2('post', `/event/` + event_code + `/mileage/1/device/W`
            , null, data => {
                // 마일리지 지급 앰플리튜드
                fnAmplitudeEventMultiPropertiesAction('click_event_apply','eventcode|actype', event_code + '|mileageok','');

                return resolve({"result" : true});
            },
            e => {
                try {
                    const error = JSON.parse(e.responseText);
                    switch(error.code) {
                        case -10: case -11: alert("로그인이 필요합니다."); break;
                        case -600: alert('처리과정 중 오류가 발생했습니다.\n코드:001'); break;
                        case -602: alert('이벤트가 종료되었습니다'); break;
                        case -609:
                            return resolve({"result" : false, "type" : "end", "message" : error.message});
                        default:
                            alert('처리과정 중 오류가 발생했습니다.\n코드:003');
                            break;
                    }

                    return resolve({"result" : false, "type" : "alert", "message" : error.message});
                } catch(e) {
                    console.log(e);
                    alert('처리과정 중 오류가 발생했습니다.\n코드:002');

                    return reject(e);
                }
            }
        );
    });
}

/*
* 이벤트 참여
* */
const call_subscription_api = function(api_data){
    return new Promise(function(resolve, reject){
        call_api("POST", "/event/common/subscription", api_data, function (data){
            return resolve({"result" : true});
        }, function(xhr){
            try {
                const err_obj = JSON.parse(xhr.responseText);
                console.log(err_obj);
                switch (err_obj.code) {
                    case -10: alert('로그인이 필요합니다.'); break;
                    case -603: return resolve({"result" : false, "reason" : "already"});
                    default: alert(err_obj.message); break;
                }

                return resolve({"result" : false});
            }catch(error) {
                console.log(error);
                alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 002)');

                return reject(error);
            }
        });
    });
}
