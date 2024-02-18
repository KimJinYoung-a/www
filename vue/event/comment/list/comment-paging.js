/**
 * 페이징 컴포넌트
 * 마크업 같을때 사용 *
 */

Vue.component('comment-paging', {
    template: '\
    <div class="paging" v-if="slotProps.pagingData.totalcount != 0">\
        <a class="prev arrow"\
            v-if="slotProps.isPreArrowButton"\
            @click="slotProps.handleClickPreArrow"\
        ><span>이전페이지로 이동</span></a>\
        \
        <a\
            v-for="i in slotProps.pageIdx"\
            @click="slotProps.handleClickPageNumber(slotProps.dispPageNumber(i) )"\
            :class="[slotProps.dispPageNumber(i) == slotProps.pagingData.currpage ? \'current\' : \'\']"\
        >\
            <span>{{ slotProps.dispPageNumber(i) }}</span>\
        </a>\
        \
        <a class="next arrow"\
            v-if="slotProps.isNextArrowButton"\
            @click="slotProps.handleClickNextArrow"\
        ><span>다음 페이지로 이동</span></a>\
    </div>\
    ',
    props: {
        slotProps: {
            type: Object,
            default: function(){
                return {}
            }
        }
    }
})
