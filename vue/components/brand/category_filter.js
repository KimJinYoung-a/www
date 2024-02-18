Vue.component('CATEGORY-FILTER', {
    template : `
        <div>
            <div class="schDetailBox tMar20">
                <!-- 카테고리 검색 결과 -->
                <table>
                    <colgroup>
                        <col width="212"><col width="">
                    </colgroup>
                    <tbody>
                        <!-- for dev msg : 3 Depth 추가로 마크업 변경 부분입니다. -->
                        <tr v-for="(item, index) in cate_filter" :class="{more : index > 2}"><!-- for dev msg : 검색결과가 많을 경우 tr 3줄까지 우선 보이고 더보기 버튼 클릭 후 전체 보이게 해주세요 -->
                            <th>
                                <input type="checkbox" class="check" :id="'cate' + item.cateCode" @change="check_cate_1depth" name="parentCheckbox" :value="item.cateCode" v-model="checked_cate_list" /> 
                                <a href="javascript:void(0);">{{item.cateName}}</a> 
                                <span class="fn">({{item.cateCount}})</span>
                            </th>
                            <td>       
                                <div class="category" v-for="(item2, index2) in item.subCate">                         
                                     <span v-for="(item3, index3) in item2">
                                        <input type="checkbox" class="check" :id="'cate' + item3.cateCode" @change="check_cate_2depth" name="cateCheckbox" :value="item3.cateCode" v-model="checked_cate_list"/> 
                                        <a href="javascript:void(0);">{{item3.cateName}} ({{item3.cateCount}})</a>
                                    </span>
                                    
                                    <template v-for="(item2, index2) in item.subCate">
                                        <div v-for="(item3, index3) in item2" class="depthWrap" v-if="item3.cateCode == visible_sub_cate">
                                            <div :class="'depth active0' + index3">
                                                <a v-for="(item4, index4) in item3.subCate" href="#">{{item4.cateName}} ({{item4.cateCount}})</a>
                                            </div>
                                        </div>
                                    </template>                                    
                                </div>                   
                            </td>
                        </tr>                 
                        <!-- //for dev msg : 3 Depth 추가로 마크업 변경 부분입니다. -->
                    </tbody>
                </table>
                <!-- //카테고리 검색 결과 -->
                <p v-if="cate_filter.length > 3" class="schMoreView" @click="show_cate_filter_more">더보기</p>
            </div>
            <div class="tPad10 rPad10 rt">
                <button @click="clear_cate_search" type="button" class="btn btnW130 btnS1 btnGry">선택 조건 해제</button>
                <input @click="go_cate_search" type="button" class="btn btnW130 btnS1 btnRed" value="선택 조건 검색">
            </div>
        </div>
    `,
    data(){
        return{
            show_cate_filter_more_f : false
            , checked_cate_list : []
            , visible_sub_cate : ""
        }
    }
    ,props: {
        cate_filter : {
            cateCode : {type:String, default:""}
            , cateCount : {type:String, default:""}
            , cateName : {type:String, default:""}
            , subCate : []
        }
        , checked_cate_filter : {}
    },
    mounted(){
        const _this = this;
        this.$nextTick(function() {
           $(".more").css("display", "none");
        });

        this.$nextTick(function() {
            if(_this.checked_cate_filter){
                _this.checked_cate_list = _this.checked_cate_filter;

                if(_this.checked_cate_list.length == 1){
                    _this.visible_sub_cate = _this.checked_cate_list[0];
                }
            }
        });
    }
    , methods : {
        show_cate_filter_more(){
            this.show_cate_filter_more_f = true;
        }
        , check_cate_1depth(event){
            const _this = this;

            if(event.target.checked){
                $("input[name=cateCheckbox]").each(function () {
                    if (this.value.startsWith(event.target.value) && !this.checked) {
                        _this.checked_cate_list.push(this.value);
                    }
                });
            }else{
                //console.log("delete 1", _this.checked_cate_list)
                let size = _this.checked_cate_list.length;
                for(let i = 0; i < size; i++){
                    let value = _this.checked_cate_list[i];
                    let tmpArr = [];
                    if(value.startsWith(event.target.value)){
                        tmpArr = tmpArr.concat(_this.checked_cate_list.slice(0, i), _this.checked_cate_list.slice(i+1));
                        _this.checked_cate_list = tmpArr;

                        size--;
                        i--;
                    }
                }
                //console.log("delete 3", _this.checked_cate_list)
            }
        }
        , check_cate_2depth(event){
            const _this = this;
            const parentId = event.target.id.substr(0,7);

            if(!event.target.checked && $("#"+ parentId)[0].checked){
                //console.log("delete 1", _this.checked_cate_list)
                let size = _this.checked_cate_list.length;
                for(let i = 0; i < size; i++){
                    let value = _this.checked_cate_list[i];
                    let tmpArr = [];
                    if(value == event.target.value.substr(0, 3) || value == event.target.value){
                        tmpArr = tmpArr.concat(_this.checked_cate_list.slice(0, i), _this.checked_cate_list.slice(i+1));
                        _this.checked_cate_list = tmpArr;

                        size--;
                        i--;
                    }
                }
                //console.log("delete 3", _this.checked_cate_list)
            }
        }
        , go_cate_search(){
            this.update_cate_filter();
            this.$emit("go_cate_search");
        }
        , update_cate_filter(){
            this.$emit("update_cate_filter", this.checked_cate_list);
        }
        , clear_cate_search(){
            this.checked_cate_list = [];
        }
    }
});