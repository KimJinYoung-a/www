<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css">
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css">
<script>
    $(function() {
        $('.customBgUse .brandNavV15').css('background', 'url(http://fiximage.10x10.co.kr/web2013/brand/bg_brand_header.jpg) center top no-repeat');
        $('.customBgUse .brandNavV15').css('background-size', 'cover');

        //SHOP
        $('.brDeliveryInfo').hover(function(){
            $(this).children('.contLyr').toggle();
        });

        //tab control
            $('.tabWrapV15 li').click(function(){
                $('.tabWrapV15 li').removeClass('selected');
                $(this).addClass('selected');
                $('.dFilterWrap').hide();
            });

            $('.dFilterWrap').hide();
            $('.dFilterTabV15 li').click(function(){
                $('.dFilterWrap').show();
                $('.filterSelect > div').hide();
                $("[id='"+'ft'+$(this).attr("id")+"']").show();
            });

            $('.filterLyrClose').click(function(){
                $('.dFilterWrap').hide();
                $('.dFilterTabV15 li').removeClass('selected');
                $('.sortingTabV15 li:first-child').addClass('selected');
            });

            //design filter - colorchip control
            $('.colorchipV15 li p input').click(function(){
                $(this).parent().parent().toggleClass('selected');
            });

            //design filter - price slide control
            $('#slider-range').slider({
                range:true,
                min:10000, //for dev msg : 자리수 3자리 콤마(,) 표시되게 해주세요
                max:150000, //for dev msg : 자리수 3자리 콤마(,) 표시되게 해주세요
                values:[10000, 50000],
                slide:function(event, ui) {
                    $('#amountFirst').val(ui.values[0] + "원");
                    $('#amountEnd').val(ui.values[1] + "원");
                }
            });
            $("#amountFirst").val($("#slider-range").slider("values", 0) + "원");
            $("#amountEnd").val($("#slider-range").slider("values", 1) + "원");
            $('.ui-slider a:first').append($('.amoundBox1'));
            $('.ui-slider a:last').append($('.amoundBox2'));

        // SHOP - EVENT
        $('.enjoyEvent').hide();
        if ($('.relatedEventV15 .evtItem').length > 1) {
            $('.relatedEventV15 .enjoyEvent').slidesjs({
                width:200,
                height:305,
                navigation:{effect: "fade"},
                pagination:false,
                play:{active:false, interval:3300, effect:"fade", auto:false},
                effect:{
                    fade:{speed:300, crossfade:true}
                },
                callback: {
                    complete: function(number) {
                        $('.count strong').text(number);

                    }
                }
            });
            var itemSize = $(".shopBestPrdV15 .evtItem").length;
            $('.count span').text(itemSize);
        } else {
            $(".relatedEventV15 .enjoyEvent").show();
            $('.count').hide();
        }

        // ABOUT BRAND
        $('.aboutBrandV15 h4').click(function(){
            $('.brandInfoV15').toggle();
            $(this).toggleClass('open');
        });
        $('.brandInfoV15 .closeLayer').click(function(){
            $('.brandInfoV15').hide();
        });
    });
</script>

<style>
	.shopBestPrdV15 .bestItemV15 {height:430px;}
	.shopBestPrdV15 .awardList li .pdtBox {height:370px;}
	.shopBestPrdV15 .awardList li .pdtBox .pdtActionV15 li {padding-top:0;}
	.shopBestPrdV15 .pdt200V15 ul.bestAwd > li {height:436px;}
	.shopBestPrdV15 .shopEventV15 {height:462px;}
</style>

</head>
<body>
    <div class="wrap">
        <!-- #include virtual="/lib/inc/incHeader.asp" -->
        <%
            Dim disp_categories, brand_id, group_type, page, sort_method, colors, styles, min_price, max_price, deli_type, keyword, view_type

            disp_categories = request("disp_categories") '// 카테고리코드
            group_type = request("group_type") '// 그룹 유형(n:All, sc:SALE, fv:WISH, pk:WRAPPING)
            page = request("page") '// 현재 페이지
            sort_method = request("sort_method") '// 정렬기준
            colors = request("colors") '// 필터 - 컬러
            styles = request("styles") '// 필터 - 스타일
            min_price = request("min_price") '// 필터 - 최저가격
            max_price = request("max_price") '// 필터 - 최고가격
            deli_type = request("deli_type") '// 필터 - 배송
            keyword = request("keyword")
            view_type = request("view_type")
        %>
        <script>
            const parameter = {
                'keyword' : '<%=keyword%>', // 필터 - 키워드
                'disp_categories' : '<%=disp_categories%>', // 카테고리 코드
                'brand_id' : '<%=brand_id%>', // 브랜드
                'group_type' : '<%=group_type%>' === '' ? 'n' : '<%=group_type%>', // 그룹 유형
                'page' : '<%=page%>' === '' ? '1' : '<%=page%>', // 페이지
                'sort_method' : '<%=sort_method%>' === '' ? 'best' : '<%=sort_method%>', // 정렬기준
                'deli_type' : '<%=deli_type%>', // 필터 - 배송
                'colors' : '<%=colors%>', // 필터 - 컬러
                'styles' : '<%=styles%>', // 필터 - 스타일
                'min_price' : '<%=min_price%>', // 필터 - 최저 가격
                'max_price' : '<%=max_price%>' // 필터 - 최고 가격
                , 'view_type' : '<%=view_type%>' === '' ? 'M' : '<%=view_type%>'
            }

            // Amplitude 전송
            //fnAmplitudeEventActionJsonData('view_search_brand_b2b', JSON.stringify(parameter));
        </script>

        <div id="app"></div>

        <!-- #include virtual="/lib/inc/incFooter.asp" -->
    </div>

    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
    <% IF application("Svr_Info") = "Dev" THEN %>
        <script src="/vue/vue_dev.js"></script>
    <% Else %>
        <script src="/vue/2.5/vue.min.js"></script>
    <% End If %>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.10.4/polyfill.min.js"></script>
    <script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/vuex-persistedstate/3.2.0/vuex-persistedstate.js"></script>-->

    <script src="/vue/common/common.js?v=1.00"></script>
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

    <script type="text/babel" src="/vue/components/brand/street_hello.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/brand/best_product_info.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/brand/best_product.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/brand/category_filter.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/brand/artistwork.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/brand/artistwork_slider.js?v=1.00"></script>
    <script type="text/babel" src="/vue/components/brand/lookbook.js?v=1.00"></script>

    <script type="text/babel" src="/vue/b2b/brand/store.js?v=1.00"></script>
    <script type="text/babel" src="/vue/b2b/brand/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->