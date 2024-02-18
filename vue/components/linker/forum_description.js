Vue.component('FORUM-DESCRIPTION',{
    template: `
        <!-- 컨텐츠 영역 -->
        <div class="img_area" v-html="content"></div>
    `
    ,
    props: {
        content: {
            type: String,
            default: ''
        }
    },
})