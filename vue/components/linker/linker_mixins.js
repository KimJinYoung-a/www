const linker_mixin = Vue.mixin({
    computed : {
        //region 개발환경
        isDevelop() {
            return unescape(location.href).includes('//localhost') || unescape(location.href).includes('//testwww') || unescape(location.href).includes('//localwww');
        },
        isStaging() {
            return unescape(location.href).includes('//stgwww');
        },
        isProduction() {
            return unescape(location.href).includes('//www');
        },
        //endregion
        //region apiUrl FrontApi URL
        apiUrl() {
            if( this.isDevelop ) {
                return '//testfapi.10x10.co.kr/api/web/v1';
            } else if( this.isStaging ) {
                return '//fapi.10x10.co.kr/api/web/v1';
            } else if( this.isProduction ) {
                return '//fapi.10x10.co.kr/api/web/v1';
            } else {
                return '//fapi.10x10.co.kr/api/web/v1';
            }
        },
        //endregion
        //region apiUrlV2 FrontApi V2 URL
        apiUrlV2() {
            if( this.isDevelop ) {
                return '//testfapi.10x10.co.kr/api/web/v2';
            } else if( this.isStaging ) {
                return '//fapi.10x10.co.kr/api/web/v2';
            } else if( this.isProduction ) {
                return '//fapi.10x10.co.kr/api/web/v2';
            } else {
                return '//fapi.10x10.co.kr/api/web/v2';
            }
        },
        //endregion
    },
    methods: {
        //region goLoginPage 로그인 페이지 이동
        goLoginPage() {
            location.href = '/login/loginpage.asp?backpath=' + encodeURIComponent(location.pathname + location.search);
        },
        //endregion
        commonApiError(e) {
            console.log(e);
        },
        //region getFrontApiData FrontApi 호출
        getFrontApiData(method, uri, data, success, error) {
            if( error == null ) {
                error = function(xhr) {
                    console.log(xhr.responseText);
                }
            }

            $.ajax({
                type: method,
                url: this.apiUrl + uri,
                data: data,
                ContentType: "json",
                crossDomain: true,
                xhrFields: {
                    withCredentials: true
                },
                success: success,
                error: error
            });
        },
        //endregion
        //region getFrontApiDataV2 FrontApi V2 호출
        getFrontApiDataV2 (method, uri, data, success, error) {
            if( error == null ) {
                error = function(xhr) {
                    console.log(xhr.responseText);
                }
            }

            $.ajax({
                type: method,
                url: this.apiUrlV2 + uri,
                data: data,
                ContentType: "json",
                crossDomain: true,
                xhrFields: {
                    withCredentials: true
                },
                success: success,
                error: error
            });
        },
        //endregion
        //region decodeBase64 Base64 디코딩
        decodeBase64 (str) {
            if( str == null ) return null;
            return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
        },
        //endregion
        //region numberFormat 숫자 foramt
        numberFormat(number) {
            if( number == null || isNaN(number) )
                return '';
            else
                return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        },
        //endregion
    }
});