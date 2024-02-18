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
<script>
    const parameter = {
        'category_code' : '<%=disp%>', // 카테고리 코드
        'group_type' : '<%=sflag%>' === '' ? 'n' : '<%=sflag%>', // 그룹 유형
        'page' : '<%=cpg%>' === '' ? '1' : '<%=cpg%>', // 페이지
        'view_type' : '<%=icoSize%>' === '' ? 'M' : '<%=icoSize%>', // 뷰타입
        'sort_method' : '<%=srm%>' === '' ? 'ne' : '<%=srm%>', // 정렬기준
        'except_sold_out_yn' : '<%=sscp%>' === '' ? 'N' : '<%=sscp%>', // 품절상품 제외 여부
        'deli_type' : '<%=deliType%>', // 필터 - 배송
        'color' : '<%=iccd%>', // 필터 - 컬러
        'style' : '<%=styleCd%>', // 필터 - 스타일
        'min_price' : '<%=minPrc%>', // 필터 - 최저 가격
        'max_price' : '<%=maxPrc%>', // 필터 - 최고 가격
        'keyword' : '<%=rect%>' // 필터 - 키워드
    }

    // Amplitude 전송
    fnAmplitudeEventActionJsonData('view_category_list_b2b', JSON.stringify(parameter))
</script>
<style>
    #contentWrap a { cursor:pointer; }
</style>
</head>
<body>
    <div class="wrap tenBiz">
        <!-- #include virtual="/lib/inc/incHeader.asp" -->
        <div class="container">
            <div id="contentWrap">
                <div id="app"></div>
            </div>
        </div>
        <!-- #include virtual="/lib/inc/incFooter.asp" -->
    </div>

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

    <script type="text/babel" src="/vue/common/common.js?v=1.00"></script>
    <script type="text/babel" src="/vue/common/mixins/common_mixins.js?v=1.00"></script>

    <script type="text/babel" src="/vue/components/common/page.js?v=1.00"></script>

    <script type="text/babel" src="/vue/components/filter/color.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/filter/style.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/filter/price.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/filter/delivery.js?v=1.00"></script>

    <script type="text/babel" src="/vue/components/product/prd_info.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/product/prd_action.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/product/prd_image.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/product/prd_basic.js?v=1.00"></script>

    <script type="text/babel" src="/vue/b2b/Category/store.js?v=1.00"></script>
    <script type="text/babel" src="/vue/b2b/Category/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->