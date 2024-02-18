Vue.component('everyday-mileage',{
    template : `
        <section id="tab02" class="section02">
            <div class="in_wrap">
                <div class="inner">
                    <h2><span>출석체크 이벤트</span>매일 방문하고<br>4,500p 받아요!</h2>
                    <div class="gage_wrap">
                        <p class="gage_tit">내가 받은 마일리지</p>
                        <div class="gage"><p :style="is_day_check_percent"><span>{{received_mileage_sum}}p</span></p></div>
                    </div>
                    <div class="mileage_wrap">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/mileage_wrap.png" alt="">
                        <div class="btnWrap">
                            <div v-for="(item, index) in 9" :class="'btn0' + (index+1)">
                                <img v-if="index < received_mileage_days_count" :src="'//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/btn0' + (index+1) + '_off.png?v=1.1'" :id="'day' + (index+1)" class="btn_off">
                                <img v-else :src="'//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/btn0' + (index+1) + '_off.png?v=1.1'" :id="'day' + (index+1)" class="btn_off" style="display:none">    
                                <img v-if="index == today_index && (index+1)!=received_mileage_days_count" :src="'//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/btn0' + (index+1) + '_on.png?v=1.1'" :id="'day_' + (index+1)" class="btn_on">
                                
                            </div>
                        </div>
                        <div v-if="received_mileage_days_count==9" class="finish"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/finish.png?v=1.04" alt=""></div>	
                    </div>
                    <div class="noti_wrap">
                        <div v-if="is_login_ok">
                            <div v-if="!(received_mileage_days_count==9)">
                                <a href="javascript:void(0);" @click="go_attendance" class="btn_check">출석체크 하기</a>
                                <a href="javascript:void(0);" @click="go_push" class="alert">내일 잊지 않도록<span>알림 받기</span></a>
                            </div>
                        </div>
                        <div v-else>
                            <a href="javascript:void(0);" @click="go_login" class="alert login">로그인하기</a>
                        </div>
                        <div v-if="received_mileage_days_count==9">
                            <a href="javascript:void(0);" class="alert check_finish">출석체크 모두 완료!</a>
                        </div>
                        <div v-if="is_login_ok">
                        <a href="javascript:void(0);" @click="del_push" class="no_alert">더이상 알림 받지 않기</a>
                        </div>
                        <p class="noti">선물받은 마일리지는 2022년 12월 31일까지만<br>사용가능한 한정 마일리지 입니다.</p>
                        <a href="" class="noti_more">유의사항 더보기</a>
                    </div>
                </div>
            </div>
        </section>
    `
    , created() {
        this.get_mileage_info()
        this.$nextTick(function() {
            this.is_login_ok = isUserLoginOK;
            if(!this.is_login_ok){
                this.userid = '고객';
            }else{
                this.userid = userid;
            }

            $('.noti_wrap .noti').click(function(){
                if($(this).hasClass('on')){
                    $(this).removeClass('on');
                    $('.notice').css('display','none');
                }else{
                    $(this).addClass('on');
                    $('.notice').css('display','block');
                }
            });

            $(".noti_more").click(function (event) {
                $(".modalV20").addClass("show");
                return false;
            })
            $(".modal_overlay,.btn_close").click(function (event) {
                $(".modalV20").removeClass("show");
                return false;
            })
            $('.btn_close').click(function(){
                $('.bg_dim').css('display','none');
                $(this).parent().css('display','none');
                return false;
            });

            setTimeout(function(){
                $('.mEvt115806 .tit01, .mEvt115806 .tit02').addClass('on');
            }, 500);
            $(".btnWrap .btn01").addClass("up");
            $(".btnWrap .btn02").addClass("diff up");
            $(".btnWrap .btn03").addClass("up");
            $(".btnWrap .btn04").addClass("up02");
            $(".btnWrap .btn05").addClass("diff up02");
            $(".btnWrap .btn06").addClass("up02");
            $(".btnWrap .btn08").addClass("diff");
        });
    }
    , mounted(){

    }
    , computed : {

    }
    , data(){
        return {
            userid : ''
            , is_login_ok : false
            , received_mileage : 0 //오늘 받은 마일리지
            , received_mileage_sum : 0 //받은 마일리지 총합
            , received_mileage_days_count : 0 //마일리지를 받은 날짜 총합
            , today_index : 0 //오늘자 인덱스
            , is_requesting_push : false
            , is_posting_subscript : false
            , is_day_check_percent : 1
        }
    }
    , methods : {
        get_mileage_info(){
            const _this = this;
            //console.log(userid);
            if(userid){
                call_apiV2('get', '/event/everyday-mileage', {"event_code" : eventid}, data => {
                    //console.log(data);
                    _this.received_mileage_days_count = 0;
                    _this.received_mileage_sum = data.received_mileage_sum;
                    _this.today_index = data.today_index;
                    _this.received_mileage_days_count = data.received_days_count
                    _this.last_yn = data.last_yn;
                    if(data.received_days_count < 1){
                        _this.is_day_check_percent = "width:10%";
                    }else{
                        _this.is_day_check_percent = "width:"+(data.received_days_count/9)*100+"%";
                        $("#daycheck").html(data.received_days_count+"/9회차");
                    }
                    //console.log(_this.received_mileage_days_count+"/"+_this.today_index);
                });
            }
        }
        , go_attendance(){
            const _this = this;
            
            if(!this.is_login_ok){
                go_login();
            }else {
                if (this.is_posting_subscript) {
                    return false;
                }

                this.is_posting_subscript = true;
                call_apiV2('post', '/event/' + eventid + '/mileage/1/device/A'
                    , null, data => {
                        _this.is_posting_subscript = false;

                        _this.received_mileage = data.mileage_amount;
                        _this.get_mileage_info();

                        if(data.round == 9){
                            $('.bg_dim').css('display','block');
                            //$("#day" + data.round).removeClass("btn_off");
                            $("#day" + data.round).show();
                        }else if(_this.last_yn){
                            $('.bg_dim').css('display','block');
                            //$("#day" + data.round).removeClass("btn_off");
                            $("#day" + data.round).show();
                        }else{
                            $('.bg_dim').css('display','block');
                            //$("#day"+data.round).removeClass("btn_off");
                            $("#day" + data.round).show();
                        }
                        $("#day_" + data.round).hide();
                        // 마일리지 지급 앰플리튜드
                        fnAmplitudeEventMultiPropertiesAction('click_event_apply','eventcode|actype', eventid + '|mileageok','');
                    },
                    e => {
                        _this.is_posting_subscript = false;

                        try {
                            const error = JSON.parse(e.responseText);
                            switch(error.code) {
                                case -10: case -11: fnAPPpopupLogin(); return;
                                case -600: alert('처리과정 중 오류가 발생했습니다.\n코드:001'); return;
                                case -602: alert('이벤트가 종료되었습니다'); return;
                                case -608:  alert('최대 마일리지 지급 횟수를 초과했습니다.'); return;
                                case -609:
                                    if( _this.last_yn )
                                        alert('오늘의 출석체크는 이미 완료했어요!\n감사합니다.');
                                    else
                                        alert('오늘의 출석체크는 이미 완료했어요.\n내일도 꼭 참여하세요!');
                                    return;
                                default:
                                    alert('처리과정 중 오류가 발생했습니다.\n코드:003');
                                    return;
                            }
                        } catch(e) {
                            console.log(e);
                            alert('처리과정 중 오류가 발생했습니다.\n코드:002');
                        }
                    }
                );
            }
        }
        , go_push(){
            if(!this.is_login_ok){
                go_login();
            }else {
                $.ajax({
                    type: "POST",
                    url:"/tentensale/doalarm.asp",
                    data: {
                        mode: 'alarm'
                    },
                    dataType: "JSON",
                    success: function(data){
                        if(data.response == "ok"){
                            alert(data.message);
                            return false;
                        }else{
                            alert(data.message);
                            return false;
                        }
                    },
                    error: function(data){
                        alert('시스템 오류입니다.');
                    }
                });
            }
        }
        , del_push(){
            if(!this.is_login_ok){
                go_login();
            }else {
                $.ajax({
                    type: "POST",
                    url:"/tentensale/doalarm.asp",
                    data: {
                        mode: 'delalarm'
                    },
                    dataType: "JSON",
                    success: function(data){
                        if(data.response == "ok"){
                            alert(data.message);
                            return false;
                        }else{
                            alert(data.message);
                            return false;
                        }
                    },
                    error: function(data){
                        alert('시스템 오류입니다.');
                    }
                });
            }
        }
        , go_login(){
            location.href="/login/loginpage.asp?vType=G";
        }
    }
});