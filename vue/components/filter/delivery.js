Vue.component('DELIVERY', {
    template : `
        <li :class="li_class">
            <input type="radio" name="dlvTp" :id="delivery_id" class="radio" :value="delivery.code"
                :checked="delivery.select_yn" @click="select_delivery"/>
            <label :for="delivery_id" :title="delivery.description">{{delivery.name}}</label>
        </li>
    `,
    props : {
        index : { type : Number, default : 0 }, // 인덱스
        delivery : {
            code : { type : String, default : '' }, // 코드
            name : { type : String, default : '' }, // 명칭
            description : { type : String, default : '' }, // 설명
            select_yn : { type : String, default : '' } // 선택 여부
        }
    },
    computed : {
        // ID
        delivery_id() {
            return 'delivery' + this.index;
        },
        // 클래스
        li_class() {
            return this.value === 'WD' ? 'abroad' : '';
        }
    },
    methods : {
        // 배송 선택/해제
        select_delivery() {
            this.$emit('select_delivery', this.delivery.code);
        }
    }
});