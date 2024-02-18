Vue.component('Menu-Component', {
    template : `
        <div class="sect01_link">
            <div class="title">
                <a href="/diarystory2023/index.asp">
                    <p class="title_g">today's</p>
                    <p class="title_b">놓치면 안될<br>텐텐다꾸</p>
                </a>
            </div>
            <div :class="['ranking', active_category == 'ranking' ? 'on' : '']">
                <p><a @click="send_amplitude('click_diarystory_menu', {'menu' : 'best'})" href="/diarystory2023/ranking.asp">📈 베스트셀러</a></p>
            </div>
            <div class="eventlink">
                <p v-for="(item, index) in events_link"><a @click="go_event(item.evt_code, index)" href="javascript:void(0)" v-html="item.title"></a></p>
            </div>
            <div :class="['category', active_category == 'category' ? 'on' : '']">
                <p><a @click="send_amplitude('click_diarystory_menu', {'menu' : 'category'})" href="/diarystory2023/category.asp">📖 모든 다꾸템 보기</a></p>
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
    , methods : {
        go_event(evt_code, index){
            this.send_amplitude('click_diary2023_mainmenu', {'index' : index+3, 'type' : 'event', "eventcode" : evt_code});
            parent.location.href='/event/eventmain.asp?eventid='+evt_code + '&diarystory=true';
        }
        , send_amplitude(name, data){
            fnAmplitudeEventActionJsonData(name, JSON.stringify(data));
        }
    }
});