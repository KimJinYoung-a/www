<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 캐릭터마을 이벤트
' History : 2022-04-26 김형태 생성
'####################################################
%>

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">

<style type="text/css">
.evt118301 {position:relative; max-width:1920px; margin:0 auto; overflow:hidden; background:#fafafa;}
.evt118301 .relaitve {position:relative;}
.evt118301 .content {width:1140px; margin:0 auto;}
.evt118301 .tab-area.fixed {position:fixed; left:0; top:0;}
.evt118301 .tab-area {width:100%; padding:1.11rem 2.43rem 0.81rem; background:#fff; overflow:hidden; border-bottom:0.09rem solid #D8D8D8; z-index:50;}
.evt118301 .tab-area ul {display:flex; align-items:center; justify-content:space-between; width:710px; margin:0 auto;}
.evt118301 .tab-area .img {position:relative; width:110px; height:110px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118301//bg_gnb_01.png) no-repeat 0 0; background-size:100%;}
.evt118301 .tab-area ul li:nth-child(2) .img {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/118301//bg_gnb_05.png?v=2);}
.evt118301 .tab-area ul li:nth-child(3) .img {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/118301//bg_gnb_02.png?v=2);}
.evt118301 .tab-area ul li:nth-child(4) .img {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/118301//bg_gnb_03.png?v=2);}
.evt118301 .tab-area ul li:nth-child(5) .img {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/118301//bg_gnb_04.png?v=2);}
.evt118301 .tab-area .tit {margin-top:8px; color:#6B6B6B; font-size:17px; text-align:center; line-height:29.92px; letter-spacing:-0.01em;}
.evt118301 .tab-area ul li {position:relative;}
.evt118301 .tab-area ul li a {text-decoration:none;}
.evt118301 .tab-area ul li a.on .tit {color:#313131;}
.evt118301 .tab-area ul li a.on::before {content:""; width:18px; height:18px; position:absolute; left:50%; bottom:-22px; margin-left:-9px; background:#FC335E; border-radius:50%;}
.evt118301 .tab-area ul li a.on .img::before {content:""; position:absolute; left:0; top:0; width:110px; height:110px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118301//bg_selet.png) no-repeat 0 0; background-size:100%; z-index:2;}
.evt118301 .headline {padding:69px 0 60px;}
.evt118301 .line {margin-top:40px; border-bottom: 2px solid #E9E9E9;}
.evt118301 .tab-wrap.fixed {position:fixed; left:0; top:0; z-index:50; width:100%;}
.evt118301 .section04 {padding-bottom:6.83rem;}

.prdtitswiper {padding:10px; background:#FC335E;}
.prdtitswiper .swiper-slide:first-child {margin-left:0;}
.prdtitswiper .swiper-slide {width:auto; margin-left:40px;}
.prdtitswiper .swiper-slide span {color:#FFCBD6; font-size:16px; font-weight:500; line-height:28.16px; cursor:pointer;}
.prdtitswiper .swiper-slide.on span {position:relative; color:#fff; font-size:16px; font-weight:700;}
.prdtitswiper .swiper-slide.on span::before {content:''; position:absolute; right:-11px; top:0; display:inline-block; width:6px; height:6px; background:#fff; border-radius:100%;}
.prdlistswiper {padding:20px 0 26px; background:#fff;}
.prdlistswiper .swiper-slide {width:auto; margin-right:0.64rem;}
.prdlistswiper .swiper-slide span {display:inline-block; height:32px; padding:0 20px; line-height:32px; border:0.09rem solid #EBEBEB; border-radius:50px; color:#7A7A7A; font-size:15px; font-weight:700; cursor:pointer;}
.prdlistswiper .swiper-slide.on span {color:#fff; background:#FC335E; border-color:#FC335E;}
.prdlistswiper .swiper-wrapper {justify-content:center;}
.evt118301 .tab-wrap {border-bottom: 1px solid #EBEBEB;}
.evt118301 .tab-brand {background:#FC335E;}
.evt118301 .tab-category {background:#fff;}

.prd-list .item_list {display:flex; flex-wrap:wrap; justify-content:flex-start;}
.prd-bottom-list .prd-list .item_list li {height:430px;}
.prd-list .item_list li a {text-decoration:none;}
.prd-list .item_list li {position:relative; width:240px; height:400px; margin:0 22.5px;}
.prd-list .item_list li .thumbnail {width:240px; height:240px; margin-bottom:25px; overflow: hidden;display: flex;align-items: center; background:#eee;}
.prd-list .item_list li .thumbnail img {width:100%;}
.prd-list .item_list li .desc .brand {font-size:20px; text-align:left;}
.prd-list .item_list li .desc .name {margin-bottom:5px; font-size:20px; line-height: 1.4; text-align:left; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;}
.prd-list .item_list li .desc .price {margin-top:5px; font-size:20px; font-weight: bold; display: flex; align-items: flex-end;}
.prd-list .item_list li .desc .price s {font-size:18px; color: #888; font-weight: normal; margin-right:10px;}
.prd-list .item_list li .desc .price .sale {font-size:20px; color: #ff7a31;margin-left:10px;}
.prd-list .item_list li .wish {z-index: 9; display: block !important; width:40px; height:40px; position:absolute; background: url(//webimage.10x10.co.kr/fixevent/event/2022/117415/m/heart_off.png) no-repeat 0 0; background-size:100%; text-indent:-99999px; top:195px; right:10px; cursor:pointer;}
.prd-list .item_list li .wish.on {background: url(//webimage.10x10.co.kr/fixevent/event/2022/117415/m/heart.png) no-repeat 0 0;background-size: 100%;}
.prd-bottom-list {padding-bottom:198px;}
.prd-bottom-list h2 {padding:92px 0 29px; font-size:36px; font-weight:700; color:#000; line-height:63.36px;}

.evt118301 .etc {margin-top:5px; font-weight:300; font-size:15px; color:#666;}
.evt118301 .etc::after {content:' '; display:block; clear:both; float:none;}
.evt118301 .etc .review {font-size:inherit;}
.evt118301 .tag {float:left; margin-right:10px;}
.evt118301 .icon {position:relative; display:inline-block; vertical-align:middle;}
.evt118301 .icon:before {content:' '; position:absolute; top:0; left:0;}
.evt118301 .icon-rating {width:82px; height:16px;}
.evt118301 .icon-rating:before {width:100%; height:100%; background-position: left center; background-repeat:repeat-x; background-size: auto 100%; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3e%3cpath fill='none' stroke='%23FF214F' stroke-width='2' d='M24.006 5c.026 0 .052.008.074.024h0l6.442 12.24 13.856 1.943c.221.042.4.109.52.22.062.06.097.133.101.212.009.152-.056.308-.153.457-.154.235-.398.446-.712.613h0l-9.46 8.752 1.965 11.632c.133.594.187 1.082.14 1.466-.02.155-.035.3-.134.377-.11.087-.272.072-.449.058-.396-.03-.87-.175-1.422-.41h0L23.97 37.007l-10.71 5.58c-.551.233-1.025.377-1.42.408-.177.014-.34.03-.45-.058-.098-.077-.113-.222-.132-.377-.048-.384.005-.872.139-1.466h0L13.36 29.46l-9.459-8.75a2.02 2.02 0 01-.74-.635c-.1-.15-.169-.305-.16-.457a.266.266 0 01.093-.185c.128-.114.32-.181.558-.224h0l13.865-1.945 6.209-12.045a.533.533 0 01.162-.179.227.227 0 01.118-.039z'/%3e%3c/svg%3e");}
.evt118301 .icon-rating i {position:absolute; left:0; top:0; text-indent:-999px; background-size: auto 100%; background-position: left center; width:100%; height:100%; background-repeat:repeat-x; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3e%3cpath fill='%23FF214F' fill-rule='evenodd' d='M25.093 4.737l6.077 11.608 13.369 1.875c1.963.357 1.87 2.322.187 3.304l-8.975 8.304 1.87 11.073c.654 2.946-.561 3.75-3.273 2.59l-10.377-5.359-10.284 5.358c-2.712 1.16-3.927.357-3.273-2.59l1.87-11.072-8.975-8.304c-1.683-.982-1.87-2.947.187-3.304l13.37-1.875 5.983-11.608c.56-.983 1.776-.983 2.244 0z'/%3e%3c/svg%3e");}
.evt118301 .counting {margin-left:5px; font-size:1rem; color:#666; vertical-align:middle; line-height:normal;}
.evt118301 .btn-more {margin:50px auto 0; text-align:center;}
.evt118301 .btn-more button {background:transparent;}

</style>
<style>
    [v-cloak] { display: none; }
</style>
</head>

<body>
    <div v-cloak id="app"></div>
    <script type="text/javascript">
        const loginUserLevel = "<%= GetLoginUserLevel %>";
        const loginUserID = "<%= GetLoginUserID %>";
        const server_info = "<%= application("Svr_Info") %>";
        let isUserLoginOK = false;
        <% IF IsUserLoginOK THEN %>
            isUserLoginOK = true;
        <% END IF %>


        function goProduct(itemid) {
            parent.location.href='/shopping/category_prd.asp?itemid='+itemid;
            return false;
        }
        let _jquery_this = $(this);

        function fnWishAdd(itemid){
            <% If Not(IsUserLoginOK) Then %>
                alert("로그인 후 사용해주세요.");
            <% else %>
                var data={
                    mode: "wish",
                    itemcode: itemid
                }
                $.ajax({
                    type:"POST",
                    url:"/event/etc/doEventSubscript116917.asp",
                    data: data,
                    dataType: "JSON",
                    success : function(res){
                        if(res!="") {
                            if(res.response == "ok"){
                                console.log(res, $("#wish"+itemid));
                                $("#wish"+itemid).toggleClass('on');
                            }else{
                                alert(res.faildesc);
                            }
                        } else {
                            alert("잘못된 접근 입니다.");
                            document.location.reload();
                        }
                    },
                    error:function(err){
                        console.log(err)
                        alert("잘못된 접근 입니다.");
                        return false;
                    }
                });
            <% End If %>
        }
    </script>

    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.10.4/polyfill.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>

    <script src="/vue/common/common.js?v=1.00"></script>
    <script src="/vue/components/common/functions/common.js?v=1.00"></script>
    <script src="/vue/components/common/functions/event_common.js?v=1.0"></script>

    <script src="/vue/event/family/js_applyItemInfo.js?v=1.00"></script>
    <script type="text/babel" src="/vue/event/character_town/store.js?v=1.00"></script>
    <script type="text/babel" src="/vue/event/character_town/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->