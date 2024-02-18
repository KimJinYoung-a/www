Vue.component('Menu-Component', {
    template : `
        <div class="sect01_link">
            <div :class="['date', active_category == 'main' ? 'on' : '']">
                <p><a @click="send_amplitude('click_diary2023_mainmenu', {'index' : 1, 'type' : 'basic'})" href="/diarystory2023/index.asp">{{getToday}}</a></p>
            </div>
            <div :class="['ranking', active_category == 'ranking' ? 'on' : '']">
                <p><a @click="send_amplitude('click_diarystory_menu', {'menu' : 'best'})" href="/diarystory2023/ranking.asp">📈 베스트셀러</a></p>
            </div>
            <div class="eventlink">
                <p v-for="(item, index) in events_link">
                    <a @click="send_amplitude('click_diary2023_mainmenu', {'index' : index+3, 'type' : 'event', 'eventcode' : item.evt_code})" 
                        :href="'/event/eventmain.asp?eventid=' + item.evt_code + '&diarystory=true'" v-html="item.title">
                    </a>
                </p>
            </div>
            <div :class="['category', active_category == 'category' ? 'on' : '']">
                <p><a @click="send_amplitude('click_diarystory_menu', {'menu' : 'category'})" href="/diarystory2023/category.asp">📖 모든 다꾸템 보기</a></p>
            </div>
            <div class="search">
                <ul class="input_box">
                    <a href="javascript:void(0)" @click="go_search()"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/search.png" alt="" class="ico_search"></a>
                    <input @keyup.enter="go_search()" v-model="search_keyword" type="text" placeholder="텐텐다꾸 상품 검색하기">
                </ul>
                <ul class="reco_search">
                    <p><a @click="go_search('캘린더')" href="javascript:void(0)">캘린더</a></p>
                    <p><a @click="go_search('플래너')" href="javascript:void(0)">플래너</a></p>
                    <p><a @click="go_search('여행기록')" href="javascript:void(0)">여행기록</a></p>
                    <p><a @click="go_search('스티커')" href="javascript:void(0)">스티커</a></p>
                    <p><a @click="go_search('굿노트속지')" href="javascript:void(0)">굿노트속지</a></p>
                </ul>
            </div>
        </div>
    `
    , created(){
        const _this = this;
        call_api("GET", "/event/events-link", {"mastercode" : 10}, function(data){
            _this.events_link = data.slice(0,6);
        });

        let pathname = window.location.pathname;
        switch (pathname){
            case "/diarystory2023/index.asp" : default :
                _this.active_category = "main";
                break;
            case "/diarystory2023/category.asp" :
                _this.active_category = "category";
                break;
            case "/diarystory2023/ranking.asp" :
                _this.active_category = "ranking";
                break;
        }
    }
    , data(){
        return {
            events_link : []
            , today : new Date().getMonth()+1 + "/" + new Date().getDate()
            , active_category : "main"
            , search_keyword : ""
        }
    }
    , computed: {
        getToday() {
            let now = new Date();
            let month = now.getMonth() + 1;
            let day = now.getDate() < 10 ? "0" + now.getDate() : now.getDate();
            return month + "." + day;
        }
    }
    , methods : {
        go_event(evt_code, index){
            this.send_amplitude('click_diary2023_mainmenu', {'index' : index+3, 'type' : 'event', "eventcode" : evt_code});
            parent.location.href='/event/eventmain.asp?eventid='+evt_code + '&diarystory=true';
        }
        , set_active_category(evt_code){
            this.active_category = evt_code;
        }
        , go_search(keyword){
            if(keyword){
                this.send_amplitude('click_diary2023_searchmain_keyword', {"keyword" : keyword});
                location.href = "/search/search_result.asp?rect=" + keyword + "&diarystoryitem=R"
            }else{
                this.send_amplitude('click_diary2023_searchmain', "");
                location.href = "/search/search_result.asp?rect=" + this.search_keyword + "&diarystoryitem=R"
            }
        }

        , send_amplitude(name, data){
            fnAmplitudeEventActionJsonData(name, JSON.stringify(data));
        }
    }
});