const common_mixin = Vue.mixin({
    methods : {
        // 숫자 , 추가
        number_format(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        },
        // 숫자 , 제거
        remove_commas(number) {
            return number.toString().replace(/,/gi,'');
        }
    }
});