/**
 * 스타일 필터
 */
Vue.component('STYLE', {
    template : `
        <li>
            <input type="checkbox" :id="style_id" :value="style_code" :checked="select_yn" @click="select_style"/>
            <label :for="style_id">{{style_name}}</label>
        </li>
    `,
    props : {
        style_code : { type : String, default : '' }, // 스타일 코드
        style_name : { type : String, default : '' }, // 스타일 이름
        select_yn : { type : Boolean, default : false }, // 선택 여부
    },
    computed : {
        // DOM ID
        style_id() {
            return 'stl' + this.style_code;
        }
    },
    methods : {
        // 스타일 선택/해제
        select_style() {
            this.$emit('select_style', !this.select_yn, this.style_code);
        }
    }
});