const app = new Vue({
    el: '#app'
    , store : store
    , mixin : [common_mixin]
    , template : `
        <div class="evt113056">
            <div class="topic">
                <div class="cut01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113056/img_cut01.png" alt="앗 저아우라는 뭐지?"></div>
                <div class="cut02"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113056/img_cut02.png" alt="산라오 펜인가?"></div>
                <div class="cut03"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113056/img_cut03.png" alt="산리오 찐펜이다!"></div>
                <div class="txt animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113056/txt_main.png" alt="산리오 찐펜특징"></div>
            </div>
            <div class="section-01"></div>
            <div class="section-02">
                <div class="check-area">
                    <button @click="change_character(1)" type="button" :class="['btn-ch01', {on : selected_character == 1}]"></button>
                    <button @click="change_character(2)" type="button" :class="['btn-ch02', {on : selected_character == 2}]"></button>
                    <button @click="change_character(3)" type="button" :class="['btn-ch03', {on : selected_character == 3}]"></button>
                    <button @click="change_character(4)" type="button" :class="['btn-ch04', {on : selected_character == 4}]"></button>
                    <button @click="change_character(5)" type="button" :class="['btn-ch05', {on : selected_character == 5}]"></button>
                    <button @click="change_character(6)" type="button" :class="['btn-ch06', {on : selected_character == 6}]"></button>
                    <button @click="change_character(7)" type="button" :class="['btn-ch07', {on : selected_character == 7}]"></button>
                </div>
            </div>
            <div class="section-03">
                <!-- 코멘트 영역 -->
                <div class="top">
                    <textarea v-model="comment_text" @input="change_comment_text" maxlength="60" placeholder="띄어쓰기 포함 60자 이내 작성"></textarea>
                </div>
                <!-- for dev msg : 사진 첨부시 노출 -->
                <div v-show="image_add_flag" class="md">   
                    <!-- 첨부이미지 영역 -->
                    <div class="img-view">
                        <div class="wraps">
                            <div class="img"><img :src="preview_image" alt=""></div>
                            <button @click="delete_image" type="button" class="btn-close"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113056/icon_close.png" alt="닫기"></button>
                        </div>
                    </div>
                </div>
                <div class="bottom">
                    <!-- 사진첨부 버튼 -->   
                    <button @click="go_add_photo" type="button" class="btn-photo"></button>
                    <input @change="change_image_add_flag" type="file" id="add_photo" style="display:none;"/>
                    <!-- 글자수 체크 -->
                    <div class="count-num">
                        <div>공백포함 <span>{{comment_text_length}}</span>/60자</div>
                    </div>
                    
                    <button @click="go_save" type="button" class="btn-apply"></button>
                </div>
            </div>
            <div class="section-04">
                <!-- 코멘트 노출 영역 -->
                <div class="comment-list">
                    <div v-for="item in comment_list" class="list-area">
                        <div class="img">
                            <img :src="item.image_url" alt="고객 등록 이미지">
                        </div>
                        <div class="info">
                            <div class="num">No. {{item.rownum < 10 ? '0' + item.rownum : item.rownum}}</div>
                            <div class="id">{{change_userid(item.userid)}}</div>
                        </div>
                        <div class="comment" v-html="change_nr(item.evtcom_txt)"></div>
                        <!-- 캐릭터 종류 7개 -->
                        <div class="ch-view"><img :src="'//webimage.10x10.co.kr/fixevent/event/2021/113056/img_ch0' + item.character_idx + '.png'"></div>
                    </div>                    
                </div>
                <!-- pagenation -->
                <div class="pageWrapV15">
                    <div class="paging pagingV15a">
                        <span class="arrow prevBtn"><a @click="go_page(current_page_list_start-1)" href="javascript:void(0)">prev</a></span>
                        <template v-for="item in 6">
                            <span v-if="(item-1) + current_page_list_start <= totalpage" @click="go_page((item-1) + current_page_list_start)" :class="[current_page == (item-1) + current_page_list_start ? 'current' : '']"><a>{{(item-1) + current_page_list_start}}</a></span>
                        </template>    
                        <span class="arrow nextBtn"><a @click="go_page(current_page_list_start+6)" href="javascript:void(0)">next</a></span>
                    </div>
                </div>
            </div>
            <div class="noti"></div>
        </div>
    `
    , created() {
        let query_param = new URLSearchParams(window.location.search);
        this.$store.commit("SET_EVT_CODE", query_param.get("eventid"));
        this.$store.dispatch("GET_COMMENT");

        this.isUserLoginOK = isUserLoginOK;
    }
    , mounted(){
        $('.topic .cut01,.topic .cut02,.topic .cut03').addClass('check');
        /* 글자,이미지 스르륵 모션 */
        $(window).scroll(function(){
            $('.topic .txt').each(function(){
                var y = $(window).scrollTop() + $(window).height() * 1;
                var imgTop = $(this).offset().top;
                if(y > imgTop) {
                    $(this).addClass('on');
                }
            });
        });
    }
    , computed : {
        comment_list(){
            return this.$store.getters.comment_list;
        }
        , evt_code(){
            return this.$store.getters.evt_code;
        }
        , totalpage(){
            return this.$store.getters.totalpage;
        }
        , current_page(){
            return this.$store.getters.current_page;
        }
        , current_page_list_start(){
            return this.$store.getters.current_page_list_start;
        }
    }
    , data(){
        return {
            isUserLoginOK : false
            , selected_character : 1
            , comment_text : ""
            , comment_text_length : 0
            , image_add_flag : false
            , preview_image : ""

            , ing_reg : false
        }
    }
    , methods : {
        change_character(idx){
            this.selected_character = idx;
        }
        , go_add_photo(){
            $("#add_photo").click();
        }
        , go_save(){
            const _this = this;

            if(isUserLoginOK) {
                if(_this.ing_reg){
                    return false;
                }else if(_this.comment_text == null || _this.comment_text == ""){
                    alert("내용을 입력해 주세요");
                    return false;
                }else if(!document.getElementById("add_photo").files[0]){
                    alert("사진을 첨부해 주세요");
                    return false;
                }

                this.save_image().then(function (data) {
                    let api_data = {
                        "event_code": _this.evt_code
                        , "character_idx": _this.selected_character
                        , "evtcom_txt": _this.comment_text
                        , "image_url": data.photo1
                    };
                    call_api("POST", "/tempEvent/sanrio", api_data, function (data) {
                        alert("응모가 완료되었습니다.");

                        _this.comment_text = "";
                        _this.comment_text_length = 0;
                        _this.delete_image();

                        _this.$store.dispatch("GET_COMMENT");
                    });
                });
            }else{
                alert("이벤트에 응모를 하려면 로그인이 필요합니다.");
            }
        }
        , save_image(){
            const _this = this;
            return new Promise(function (resolve, reject) {
                //리스트 이미지 저장
                const imgData = new FormData();
                imgData.append('folderName', "113056");
                imgData.append('photo1', document.getElementById("add_photo").files[0]);

                $.ajax({
                    url: uploadUrl + "/linkweb/etc_event/etc_event_reg_json.asp"
                    , type: "POST"
                    , processData: false
                    , contentType: false
                    , data: imgData
                    , crossDomain: true
                    , success: function (data) {
                        const response = JSON.parse(data);

                        if (response.response === 'ok') {
                            return resolve(response);
                        } else {
                            alert('이미지 저장 중 오류가 발생했습니다. (Err: 001)');
                            return reject();
                        }
                    }
                    , error(e){
                        console.log(e);
                    }
                });
            });
        }
        , go_page(page){
            if(page < this.totalpage && page > 0){
                this.$store.commit("SET_CURRENT_PAGE", page);
                this.$store.dispatch("GET_COMMENT");
            }
        }
        , change_image_add_flag(){
            const _this = this;
            const file =document.getElementById("add_photo").files[0];

            if (!file.type.match("image.*")) {
                return alert("이미지 파일만 등록하실 수 있습니다.");
            }else if(file.size > 4194304){
                this.delete_image();
                alert("4MB 이하의 이미지를 등록해주세요");
                return false;
            }

            let reader = new FileReader();
            reader.readAsDataURL(file);

            reader.onload = function(e){
                _this.preview_image = e.target.result;
                _this.image_add_flag = true;
            }
        }
        , delete_image(){
            $("#add_photo").val("");
            this.image_add_flag = false;
            this.preview_image = "";
        }
        , change_comment_text(e){
            this.comment_text_length = e.target.value.length;
        }
        , change_nr(text){
            return text.replaceAll("\n", "<br />");
        }
        , change_userid(userid){
            return userid.slice(0, userid.length - 3) + "***";
        }
    }
});