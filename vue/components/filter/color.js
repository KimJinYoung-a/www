/**
 * 컬러 필터
 */
Vue.component('COLOR', {
    template : `
        <li :class="li_class" @click="select_color">
            <p>
                <input type="checkbox" :id="color_id" :value="color_code" :checked="select_yn"/>
            </p>
            <label :for="color_id">{{color_name}}</label>
        </li>
    `,
    props : {
        color_code : { type : String, default : '' }, // 색 코드
        color_name : { type : String, default : '' }, // 색 이름
        select_yn : { type : Boolean, default : false }, // 선택 여부
    },
    computed : {
        li_class() {
            return [
                this.color_name.toLowerCase(),
                { 'selected' : this.select_yn }
            ];
        },
        color_id() {
            return 'col' + this.color_code;
        }
    },
    methods : {
        select_color() {
            this.$emit('select_color', !this.select_yn, this.color_code);
        }
    }
});