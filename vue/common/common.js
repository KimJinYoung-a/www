const isLocal = function() {
    return unescape(location.href).includes('//localhost') || unescape(location.href).includes('//localwww');
}();
const is_develop = function() {
    return unescape(location.href).includes('//localhost') || unescape(location.href).includes('//2015www');
}();

const is_staging = function() {
    return unescape(location.href).includes('//stgwww');
}();

const is_production = function() {
    return unescape(location.href).includes('//www');
}();

const api_url = function() {
    let apiUrl
    if( isLocal ) {
        //apiUrl =  '//localfapi.10x10.co.kr:8080/api/web/v1';
        apiUrl =  '//testfapi.10x10.co.kr/api/web/v1';
    }else if( is_develop ) {
        apiUrl =  '//testfapi.10x10.co.kr/api/web/v1'
    } else if( is_staging ) {
        apiUrl =  '//fapi.10x10.co.kr/api/web/v1';
    } else {
        apiUrl =  '//fapi.10x10.co.kr/api/web/v1';
    }
    return apiUrl;
}();

const api_urlV2 = function() {
    let apiUrl
    if( isLocal ) {
        //apiUrl =  '//localhost:8080/api/web/v2'
        apiUrl =  '//testfapi.10x10.co.kr/api/web/v2';
    } else if( is_develop ) {
        apiUrl =  '//testfapi.10x10.co.kr/api/web/v2';
    } else if( is_staging ) {
        apiUrl =  '//fapi.10x10.co.kr/api/web/v2';
    } else {
        apiUrl =  '//fapi.10x10.co.kr/api/web/v2';
    }
    return apiUrl;
}();

const apiurlv3 = function() {
    let apiUrl
    if( isLocal ) {
        //apiUrl =  '//localfapi.10x10.co.kr:8080/api/web/v3';
        apiUrl =  '//testfapi.10x10.co.kr/api/web/v3';
    }else if( is_develop ) {
        apiUrl =  '//testfapi.10x10.co.kr/api/web/v3';
    }else{
        apiUrl =  '//fapi.10x10.co.kr/api/web/v3';
    }

    return apiUrl;
}();

const uploadUrl = function() {
    let uploadUrl
    if( is_develop ) {
        uploadUrl =  '//testupload.10x10.co.kr'
    } else {
        uploadUrl =  '//upload.10x10.co.kr'
    }

    return uploadUrl;
}();

// API Call
function call_api(method, uri, data, success, error) {
    if( error == null ) {
        error = function(xhr) {
            console.log(xhr.responseText);
        }
    }

    $.ajax({
        type: method,
        url: api_url + uri,
        data: data,
        ContentType: "json",
        crossDomain: true,
        traditional : true,
        xhrFields: {
            withCredentials: true
        },
        success: success,
        error: error
    });
}

// API Call
function call_apiV2(method, uri, data, success, error) {
    if( error == null ) {
        error = function(xhr) {
            console.log(xhr.responseText);
        }
    }

    $.ajax({
        type: method,
        url: api_urlV2 + uri,
        data: data,
        ContentType: "json",
        crossDomain: true,
        xhrFields: {
            withCredentials: true
        },
        success: success,
        error: error
    });
}

function call_api_v3(method, uri, data, success, error) {
    if( error == null ) {
        error = function(xhr) {
            console.log(xhr.responseText);
        }
    }

    $.ajax({
        type: method,
        url: apiurlv3 + uri,
        data: data,
        ContentType: "json",
        crossDomain: true,
        xhrFields: {
            withCredentials: true
        },
        traditional : true,
        success: success,
        error: error
    });
}

// base64 decode
function decode_base64(str) {
    if( str == null ) return null;
    return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
}

// 쇼셜네트워크로 글보내기
function popSNSPost(svc,tit,link,pre,tag,img) {
    // tit, img 및 link는 반드시 UTF8로 변환하여 호출요망! (2013.10.02; 허진원 UTF8 처리 문제로 APPS서버 경유)
    var popwin = window.open("http://apps.10x10.co.kr/snsPost/goSNSposts.asp?svc=" + svc + "&link="+link + "&tit="+tit + "&pre="+pre + "&tag="+tag + "&img="+img,'popSNSpost');
    popwin.focus();
}

function getStaticImgUrl(){
    let staticImgUrl;
    if( is_develop ) {
        staticImgUrl = "http://testimgstatic.10x10.co.kr";
    }else{
        staticImgUrl = "http://imgstatic.10x10.co.kr";
    }

    return staticImgUrl;
}

