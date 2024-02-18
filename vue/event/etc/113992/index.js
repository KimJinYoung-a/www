const app = new Vue({
    el: '#app'
    , template : `
        <div class="evt113992">
            <div class="section section01">
                <p class="slide01 slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113992/on01.png" alt=""></p>
                <p class="slide02 slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113992/on02.png" alt=""></p>
                <p class="slide03 slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113992/on03.png" alt=""></p>
            </div>
            <div class="section section02">
                <p class="slide04 slides"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113992/on04.png" alt=""></p>
                <p class="slide05 slides"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113992/on05.png" alt=""></p>
                <p class="slide06 slides"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113992/on06.png" alt=""></p>
            </div>
            <div class="section section03">
                <div class="copy">
                    <p @click="click_candidate(1, candidates.candidate1)" :class="[{on : candidates.candidate1 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy01_' + (candidates.candidate1 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(2, candidates.candidate2)" :class="[{on : candidates.candidate2 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy02_' + (candidates.candidate2 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(3, candidates.candidate3)" :class="[{on : candidates.candidate3 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy03_' + (candidates.candidate3 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(4, candidates.candidate4)" :class="[{on : candidates.candidate4 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy04_' + (candidates.candidate4 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(5, candidates.candidate5)" :class="[{on : candidates.candidate5 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy05_' + (candidates.candidate5 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(6, candidates.candidate6)" :class="[{on : candidates.candidate6 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy06_' + (candidates.candidate6 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(7, candidates.candidate7)" :class="[{on : candidates.candidate7 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy07_' + (candidates.candidate7 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(8, candidates.candidate8)" :class="[{on : candidates.candidate8 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy08_' + (candidates.candidate8 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(9, candidates.candidate9)" :class="[{on : candidates.candidate9 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy09_' + (candidates.candidate9 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(10, candidates.candidate10)" :class="[{on : candidates.candidate10 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy10_' + (candidates.candidate10 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(11, candidates.candidate11)" :class="[{on : candidates.candidate11 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy11_' + (candidates.candidate11 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(12, candidates.candidate12)" :class="[{on : candidates.candidate12 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy12_' + (candidates.candidate12 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(13, candidates.candidate13)" :class="[{on : candidates.candidate13 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy13_' + (candidates.candidate13 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(14, candidates.candidate14)" :class="[{on : candidates.candidate14 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy14_' + (candidates.candidate14 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(15, candidates.candidate15)" :class="[{on : candidates.candidate15 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy15_' + (candidates.candidate15 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(16, candidates.candidate16)" :class="[{on : candidates.candidate16 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy16_' + (candidates.candidate16 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(17, candidates.candidate17)" :class="[{on : candidates.candidate17 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy17_' + (candidates.candidate17 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(18, candidates.candidate18)" :class="[{on : candidates.candidate18 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy18_' + (candidates.candidate18 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(19, candidates.candidate19)" :class="[{on : candidates.candidate19 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy19_' + (candidates.candidate19 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(20, candidates.candidate20)" :class="[{on : candidates.candidate20 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy20_' + (candidates.candidate20 == true ? 'on' : 'off') + '.png'" alt=""></p>
                    <p @click="click_candidate(21, candidates.candidate21)" :class="[{on : candidates.candidate21 ? 'on' : ''}]"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113992/copy21_' + (candidates.candidate21 == true ? 'on' : 'off') + '.png'" alt=""></p>
                </div>
                <button @click="go_save()" class="submit">투표완료</button>
            </div>
            <div class="section section04"></div>
            <div class="section section05"></div>
        </div>
    `
    , data : function(){
        return {
            candidates : {
                candidate1 : false
                , candidate2 : false
                , candidate3 : false
                , candidate4 : false
                , candidate5 : false
                , candidate6 : false
                , candidate7 : false
                , candidate8 : false
                , candidate9 : false
                , candidate10 : false
                , candidate11 : false
                , candidate12 : false
                , candidate13 : false
                , candidate14 : false
                , candidate15 : false
                , candidate16 : false
                , candidate17 : false
                , candidate18 : false
                , candidate19 : false
                , candidate20 : false
                , candidate21 : false
            }
            , selected_candi_count : 0

            , ing_save : false
        }
    }
    , mounted(){
        $('.section .slide').addClass('on');
        /* 글자,이미지 스르륵 모션 */
        $(window).scroll(function(){
            $('.slides').each(function(){
                var y = $(window).scrollTop() + $(window).height() * 1;
                var imgTop = $(this).offset().top;
                if(y > imgTop) {
                    $(this).addClass('on');
                }
            });
        });
    }
    , computed : {
        is_develop() { // 개발서버 여부
            return !unescape(location.href).includes('//stgwww') && !unescape(location.href).includes('//www');
        }
        , api_url() { // API url
            if( this.is_develop ) {
                return '//localhost:8080/api/web/v1';
            } else {
                return '//fapi.10x10.co.kr/api/web/v1';
            }
        }
    }
    , methods : {
        click_candidate : function(candi_index, go_unactive){
            if(this.selected_candi_count >= 3 && !go_unactive){
                alert("최대 3개까지 선택하실 수 있습니다.");
                return false;
            }

            if(go_unactive){
                this.selected_candi_count -= 1;
            }else{
                this.selected_candi_count += 1;
            }

            if(candi_index == 1){
                this.candidates.candidate1 = !this.candidates.candidate1
            }else if(candi_index == 2){
                this.candidates.candidate2 = !this.candidates.candidate2
            }else if(candi_index == 3){
                this.candidates.candidate3 = !this.candidates.candidate3
            }else if(candi_index == 4){
                this.candidates.candidate4 = !this.candidates.candidate4
            }else if(candi_index == 5){
                this.candidates.candidate5 = !this.candidates.candidate5
            }else if(candi_index == 6){
                this.candidates.candidate6 = !this.candidates.candidate6
            }else if(candi_index == 7){
                this.candidates.candidate7 = !this.candidates.candidate7
            }else if(candi_index == 8){
                this.candidates.candidate8 = !this.candidates.candidate8
            }else if(candi_index == 9){
                this.candidates.candidate9 = !this.candidates.candidate9
            }else if(candi_index == 10){
                this.candidates.candidate10 = !this.candidates.candidate10
            }else if(candi_index == 11){
                this.candidates.candidate11 = !this.candidates.candidate11
            }else if(candi_index == 12){
                this.candidates.candidate12 = !this.candidates.candidate12
            }else if(candi_index == 13){
                this.candidates.candidate13 = !this.candidates.candidate13
            }else if(candi_index == 14){
                this.candidates.candidate14 = !this.candidates.candidate14
            }else if(candi_index == 15){
                this.candidates.candidate15 = !this.candidates.candidate15
            }else if(candi_index == 16){
                this.candidates.candidate16 = !this.candidates.candidate16
            }else if(candi_index == 17){
                this.candidates.candidate17 = !this.candidates.candidate17
            }else if(candi_index == 18){
                this.candidates.candidate18 = !this.candidates.candidate18
            }else if(candi_index == 19){
                this.candidates.candidate19 = !this.candidates.candidate19
            }else if(candi_index == 20){
                this.candidates.candidate20 = !this.candidates.candidate20
            }else if(candi_index == 21){
                this.candidates.candidate21 = !this.candidates.candidate21
            }
        }
        , go_save(){
            const _this = this;

            if(this.selected_candi_count != 3){
                alert("3개를 선택해주세요.");
                return false;
            }

            if(!isLoginOk) {
                jsChklogin();
            }else{
                if (this.ing_save) {
                    return false;
                }

                _this.ing_save = true;

                let option_list = [];
                if(this.candidates.candidate1){
                    option_list.push(1);
                }
                if(this.candidates.candidate2){
                    option_list.push(2);
                }
                if(this.candidates.candidate3){
                    option_list.push(3);
                }
                if(this.candidates.candidate4){
                    option_list.push(4);
                }
                if(this.candidates.candidate5){
                    option_list.push(5);
                }
                if(this.candidates.candidate6){
                    option_list.push(6);
                }
                if(this.candidates.candidate7){
                    option_list.push(7);
                }
                if(this.candidates.candidate8){
                    option_list.push(8);
                }
                if(this.candidates.candidate9){
                    option_list.push(9);
                }
                if(this.candidates.candidate10){
                    option_list.push(10);
                }
                if(this.candidates.candidate11){
                    option_list.push(11);
                }
                if(this.candidates.candidate12){
                    option_list.push(12);
                }
                if(this.candidates.candidate13){
                    option_list.push(13);
                }
                if(this.candidates.candidate14){
                    option_list.push(14);
                }
                if(this.candidates.candidate15){
                    option_list.push(15);
                }
                if(this.candidates.candidate16){
                    option_list.push(16);
                }
                if(this.candidates.candidate17){
                    option_list.push(17);
                }
                if(this.candidates.candidate18){
                    option_list.push(18);
                }
                if(this.candidates.candidate19){
                    option_list.push(19);
                }
                if(this.candidates.candidate20){
                    option_list.push(20);
                }
                if(this.candidates.candidate21){
                    option_list.push(21);
                }

                let api_data = {
                    "event_code" : "113992"
                    , "event_option1" : option_list[0]
                    , check_option1: false
                    , "event_option2" : option_list[1]
                    , check_option2 : false
                    , "event_option3" : option_list[2]
                    , check_option3 : false
                };
                this.call_api("POST", "/event/common/subscription", api_data
                    , function (data){
                        if( data.result ) {
                            alert("투표가 완료됐습니다.");

                            fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode', "113992");
                        } else {
                            alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 001)');
                        }
                    }, function(xhr){
                        console.log(xhr.responseText);
                        try {
                            const err_obj = JSON.parse(xhr.responseText);
                            console.log(err_obj);
                            switch (err_obj.code) {
                                case -10: alert('이벤트에 응모를 하려면 로그인이 필요합니다.'); return false;
                                case -603 :
                                    alert("이미 투표를 하셨습니다.");
                                    break;
                                default: alert(err_obj.message); return false;
                            }
                        }catch(error) {
                            console.log(error);
                            alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 002)');
                        }
                    }, () => {
                        _this.ing_save = false;
                    }
                );
            }
        }
        , call_api(method, uri, data, success, error, complete) {
            if( error == null ) {
                error = function(xhr) {
                    console.log(xhr.responseText);
                }
            }

            $.ajax({
                type: method,
                url: this.api_url + uri,
                data: data,
                ContentType: "json",
                crossDomain: true,
                xhrFields: {
                    withCredentials: true
                },
                success: success,
                error: error,
                complete: complete
            });
        }
    }
});