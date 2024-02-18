var gourpItemSort = new Vue({
    el : "#selSrtMetDiv"
    , data(){
        return {
            groupItemSortDisplayFlag : true
        }
    }
    , created(){
        const _this = this;
        call_api("GET", "/event/common/display-event-item-count", {"evt_code" : evt_code}, function(data){
            if(data < 1){
                _this.groupItemSortDisplayFlag = false;
            }
        });
    }
});