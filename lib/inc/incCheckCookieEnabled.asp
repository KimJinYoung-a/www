<%

if (Request.Cookies("cce") = "") then
    '' 원본 ============================================
    ''
    '' <script>
    '' if (navigator.cookieEnabled == true) {
    ''     var d = new Date();
    ''     d.setDate(d.getDate() + 30);
    ''     document.cookie = "cce=Y; path=/; expires=" + d.toGMTString() + ";";
    ''     setTimeout(function() {
    ''         document.location.reload();
    ''     }, 200);
    '' } else {
    ''     document.write('현재 사용 중인 브라우저는 쿠키를 지원하지 않거나, 해당 기능이 활성화되어 있지 않습니다.<br />');
    ''     document.write('보다 자세한 사항은 <a href="/cscenter/">고객센터</a>로 문의주시기 바립니다.');
    '' }
    '' </script>
    ''
    '' 스크립트 난독화 =================================
    ''
    '' https://obfuscator.io/
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
    <title>텐바이텐 10X10</title>
</head>
<body>
    <script>
    function _0x8cb0(){var _0x24ef64=['208902jaRWbY','cookie','getDate','cce=Y;\x20path=/;\x20expires=','634943rAuQde','3542268JnXFnK','1018928hPYpKJ','location','261LNBVqP','cookieEnabled','setDate','5oaClIX','3487048qOZHiI','write','5020644iJzyDh','9876321IvpHoZ','toGMTString'];_0x8cb0=function(){return _0x24ef64;};return _0x8cb0();}var _0x44de78=_0x8860;function _0x8860(_0x43beaf,_0x3f0733){var _0x8cb0aa=_0x8cb0();return _0x8860=function(_0x886078,_0x16b1ed){_0x886078=_0x886078-0x135;var _0x5cfa6d=_0x8cb0aa[_0x886078];return _0x5cfa6d;},_0x8860(_0x43beaf,_0x3f0733);}(function(_0x2fa485,_0x38423a){var _0x14a7d0=_0x8860,_0x4c121=_0x2fa485();while(!![]){try{var _0x56b394=parseInt(_0x14a7d0(0x139))/0x1+-parseInt(_0x14a7d0(0x135))/0x2+-parseInt(_0x14a7d0(0x143))/0x3+-parseInt(_0x14a7d0(0x141))/0x4*(parseInt(_0x14a7d0(0x140))/0x5)+parseInt(_0x14a7d0(0x13a))/0x6+-parseInt(_0x14a7d0(0x144))/0x7+-parseInt(_0x14a7d0(0x13b))/0x8*(-parseInt(_0x14a7d0(0x13d))/0x9);if(_0x56b394===_0x38423a)break;else _0x4c121['push'](_0x4c121['shift']());}catch(_0xadca6c){_0x4c121['push'](_0x4c121['shift']());}}}(_0x8cb0,0xd189f));if(navigator[_0x44de78(0x13e)]==!![]){var d=new Date();d[_0x44de78(0x13f)](d[_0x44de78(0x137)]()+0x1e),document[_0x44de78(0x136)]=_0x44de78(0x138)+d[_0x44de78(0x145)]()+';',setTimeout(function(){var _0x40e154=_0x44de78;document[_0x40e154(0x13c)]['reload']();},0xc8);}else document[_0x44de78(0x142)]('현재\x20사용\x20중인\x20브라우저는\x20쿠키를\x20지원하지\x20않거나,\x20해당\x20기능이\x20활성화되어\x20있지\x20않습니다.<br\x20/>'),document[_0x44de78(0x142)]('보다\x20자세한\x20사항은\x20<a\x20href=\x22/cscenter/\x22>고객센터</a>로\x20문의주시기\x20바립니다.');
    </script>
    <noscript>
        현재 사용 중인 브라우저는 스크립트를 지원하지 않거나, 해당 기능이 활성화되어 있지 않습니다.<br />
        보다 자세한 사항은 <a href="/cscenter/">고객센터</a>로 문의주시기 바립니다.
    </noscript>
</body>
</html>
    <%
    Response.Status = "239 Check browser"
    response.end
end if

%>
