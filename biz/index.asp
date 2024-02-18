<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
    Dim disp, rect, icoSize, deliType, minPrc, maxPrc, iccd, srm, styleCd, cpg, sscp, sflag

    disp = request("disp") '// 카테고리코드
    sflag = request("sflag") '// 그룹 유형(n:All, sc:SALE, fv:WISH, pk:WRAPPING)
    cpg = request("cpg") '// 현재 페이지
    rect = request("rect") '// 필터 - 키워드
    icoSize = request("icoSize") '// 뷰타입
    srm = request("srm") '// 정렬기준
    iccd = request("iccd") '// 필터 - 컬러
    styleCd = request("styleCd") '// 필터 - 스타일
    minPrc = request("minPrc") '// 필터 - 최저가격
    maxPrc = request("maxPrc") '// 필터 - 최고가격
    deliType = request("deliType") '// 필터 - 배송
    sscp = request("sscp") '// 품절상품 제외 여부

%>
<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>
<script>
    $(function() {
        // biz 상품 큐레이터 탭
        $('.biz-pd-curator .tab-nav button').on('click',function(){
            $(this).addClass('on').siblings().removeClass('on');
        });
    });
</script>
</head>
<body>
    <div class="wrap mainV18 tenBiz" id="mainWrapV18">
        <!-- #include virtual="/lib/inc/incHeader.asp" -->
        <div class="container">
            <div id="contentWrap">
                <div id="app"></div>

                <% If session("ssnuserbizconfirm") = "S" Then %>
                    <div id="confirmLayer" class="popApplying">
                        <h3>가입 승인<br/>대기중입니다</h3>
                        <div class="progressStep">
                            <div class="imgBar">
                                <img src="//fiximage.10x10.co.kr/web2021/biz/bar_progress.png" alt="progress bar">
                            </div>
                            <div class="applyStep">
                                <div>가입신청</div>
                                <div>승인대기</div>
                                <div>가입완료</div>
                            </div>
                        </div>
                        <div class="notice">
                            <ul>
                                <li>회원가입 승인 후 텐바이텐 BIZ 상품을 구매하실 수 있어요!</li>
                                <li>가입 승인은 최대 24시간 내 이루어집니다.</li>
                            </ul>
                        </div>
                        <button onclick="closeConfirmLayer()" type="button" class="btnClose"><img src="//fiximage.10x10.co.kr/web2021/biz/icon_pop_close.png" alt="팝업 닫기"></button>
                    </div>
                <% End If %>
            </div>
        </div>
        <!-- #include virtual="/lib/inc/incFooter.asp" -->
    </div>
    <script>
        // 5초 후 승인 레이어 팝업 닫음
        $(function() {
            setTimeout(closeConfirmLayer, 20000);
        });
        function closeConfirmLayer() {
            $('#confirmLayer').fadeOut(200);
        }
    </script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.10.4/polyfill.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
    <% IF application("Svr_Info") = "Dev" THEN %>
        <script src="/vue/vue_dev.js"></script>
    <% Else %>
        <script src="/vue/2.5/vue.min.js"></script>
    <% End If %>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>

    <script src="/vue/common/common.js?v=1.00"></script>
    <script type="text/babel" src="/vue/common/mixins/common_mixins.js?v=1.00"></script>

    <script type="text/babel" src="/vue/components/common/page.js?v=1.00"></script>

    <script type="text/babel" src="/vue/components/product/prd_info.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/product/prd_action.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/product/prd_image.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/product/prd_basic.js?v=1.00"></script>

    <script type="text/babel" src="/vue/components/home/slide_banner.js?v=1.00"></script>

    <script type="text/babel" src="/vue/b2b/home/store.js?v=1.01"></script>
    <script type="text/babel" src="/vue/b2b/home/index.js?v=1.01"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->