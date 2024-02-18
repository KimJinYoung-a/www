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
' Description : 텐텐선물
' History : 2022-05-30 전제현
'####################################################

dim eCode : eCode   = requestCheckVar(Request("eventid"),10) '이벤트 코드번호

IF application("Svr_Info") = "Dev" THEN
    eCode = "118178"
End If

%>

<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>

<style>
div.fullEvt #contentWrap .eventWrapV15{width:unset; left:unset; transform:unset;}
.evt118569 .section{position:relative;}
.evt118569 a{display:block; width:100%; height:100%;}
.evt118569 a:hover{text-decoration:none;}

/* section01 */
.evt118569 .section01{height:800px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/120828/top.jpg) no-repeat 50% 0;}

.evt118569 .tab-area{width:100%; background:#111;}
.evt118569 .tab-area.fixed{position:fixed; left:0; top:0; z-index:50; width:100%;}
.evt118569 .tab{width:100%; background:#111; height:73px;}
.evt118569 .tab ul{display:flex; width:1140px; margin:0 auto; justify-content:center; height:100%; align-items:center;}
.evt118569 .tab li{margin:0 30px;}
.evt118569 .tab li.on .tit{color:#fff;}
.evt118569 .tab .tit{color:#666; font-size:23px; font-weight:500; line-height:28.16px; cursor:pointer;}
.evt118569 .tab-category{background:#fff; width:100%;}
.evt118569 .category-list{display:none; margin:0 auto; padding:25px 0;}
.evt118569 .category-list.on{display:block;}
.evt118569 .category-list ul{display:flex; justify-content:center; flex-wrap:nowrap; width:100%;}
.evt118569 .tab-category .category{background:#fff; width:fit-content; white-space:nowrap; padding:0 20px; border-radius:50px; color:#717171; font-size:22px; border:1px solid #eaeaea; display:inline-block; margin:0 7px;}
.evt118569 .tab-category .category.on{background:#111; border:1px solid #111;}
.evt118569 .tab-category .category a{color:#717171;}
.evt118569 .tab-category .category.on a{color:#fff;}

/* section03 */
.evt118569 .section03{background:#fff;}
.evt118569 .prd-bottom-list{width:1140px; margin:0 auto; display:none; padding-bottom:100px;}
.evt118569 .prd-bottom-list.on{display:block;}
.evt118569 .prd-bottom-list h2 {padding:92px 0 29px; font-size:36px; font-weight:700; color:#000; line-height:63.36px;}
.evt118569 .prd-bottom-list.brand{padding:0 0 93px;}
.evt118569 .prd-bottom-list.brand .brand_banner{width:670px; margin:auto; margin-bottom:20px;}
.evt118569 .prd-bottom-list.brand .brand_banner:nth-of-type(1){padding-top:70px;}
.evt118569 .prd-list .item_list {display:flex; flex-wrap:wrap; justify-content:flex-start;}
.evt118569 .prd-list .item_list li {height:430px;}
.evt118569 .prd-list .item_list li a {text-decoration:none; height:auto;}
.evt118569 .prd-list .item_list li {position:relative; width:240px; height:400px; margin:0 22.5px;}
.evt118569 .prd-list .item_list li .thumbnail {width:240px; height:240px; margin-bottom:25px; overflow: hidden;display: flex;align-items: center; background:#eee;}
.evt118569 .prd-list .item_list li .thumbnail img {width:100%;}
.evt118569 .prd-list .item_list li .desc .brand {font-size:20px; text-align:left;}
.evt118569 .prd-list .item_list li .desc .name {margin-bottom:5px; font-size:20px; line-height: 1.4; text-align:left; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;}
.evt118569 .prd-list .item_list li .desc .price {margin-top:5px; font-size:20px; font-weight: bold; display: flex; align-items: flex-end;}
.evt118569 .prd-list .item_list li .desc .price s {font-size:18px; color: #888; font-weight: normal; margin-right:10px;}
.evt118569 .prd-list .item_list li .desc .price .sale {font-size:20px; color: #ff7a31;margin-left:10px;}
.evt118569 .prd-list .item_list li .wish {z-index: 9; display: block !important; width:40px; height:40px; position:absolute; background: url(//webimage.10x10.co.kr/fixevent/event/2022/117415/m/heart_off.png) no-repeat 0 0; background-size:100%; text-indent:-99999px; top:195px; right:10px; cursor:pointer;}
.evt118569 .prd-list .item_list li .wish.on {background: url(//webimage.10x10.co.kr/fixevent/event/2022/117415/m/heart.png) no-repeat 0 0;background-size: 100%;}

.evt118569 .etc {margin-top:5px; font-weight:300; font-size:15px; color:#666;}
.evt118569 .etc::after {content:' '; display:block; clear:both; float:none;}
.evt118569 .etc .review {font-size:inherit;}
.evt118569 .tag {float:left; margin-right:10px;}
.evt118569 .icon {position:relative; display:inline-block; vertical-align:middle;}
.evt118569 .icon:before {content:' '; position:absolute; top:0; left:0;}
.evt118569 .icon-rating {width:82px; height:16px;}
.evt118569 .icon-rating:before {width:100%; height:100%; background-position: left center; background-repeat:repeat-x; background-size: auto 100%; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3e%3cpath fill='none' stroke='%23FF214F' stroke-width='2' d='M24.006 5c.026 0 .052.008.074.024h0l6.442 12.24 13.856 1.943c.221.042.4.109.52.22.062.06.097.133.101.212.009.152-.056.308-.153.457-.154.235-.398.446-.712.613h0l-9.46 8.752 1.965 11.632c.133.594.187 1.082.14 1.466-.02.155-.035.3-.134.377-.11.087-.272.072-.449.058-.396-.03-.87-.175-1.422-.41h0L23.97 37.007l-10.71 5.58c-.551.233-1.025.377-1.42.408-.177.014-.34.03-.45-.058-.098-.077-.113-.222-.132-.377-.048-.384.005-.872.139-1.466h0L13.36 29.46l-9.459-8.75a2.02 2.02 0 01-.74-.635c-.1-.15-.169-.305-.16-.457a.266.266 0 01.093-.185c.128-.114.32-.181.558-.224h0l13.865-1.945 6.209-12.045a.533.533 0 01.162-.179.227.227 0 01.118-.039z'/%3e%3c/svg%3e");}
.evt118569 .icon-rating i {position:absolute; left:0; top:0; text-indent:-999px; background-size: auto 100%; background-position: left center; width:100%; height:100%; background-repeat:repeat-x; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3e%3cpath fill='%23FF214F' fill-rule='evenodd' d='M25.093 4.737l6.077 11.608 13.369 1.875c1.963.357 1.87 2.322.187 3.304l-8.975 8.304 1.87 11.073c.654 2.946-.561 3.75-3.273 2.59l-10.377-5.359-10.284 5.358c-2.712 1.16-3.927.357-3.273-2.59l1.87-11.072-8.975-8.304c-1.683-.982-1.87-2.947.187-3.304l13.37-1.875 5.983-11.608c.56-.983 1.776-.983 2.244 0z'/%3e%3c/svg%3e");}
.evt118569 .counting {margin-left:5px; font-size:1rem; color:#666; vertical-align:middle; line-height:normal;}
</style>

<script>
$(function() {
    $('.wish').on('click',function(){
        $(this).toggleClass('on');
    });
    // /* scroll 이벤트 */
    $(window).scroll(function(){
        var header = $('#header').outerHeight();
        var tabHeight = $('.tab-area').outerHeight();
        var fixHeight = tabHeight + header;
        var st = $(this).scrollTop();
        var startFix = $('.section03').offset().top - fixHeight;

        if(st > startFix) {
            $('.tab-area').addClass('fixed').css('top',header)
        } else {
            $('.tab-area').removeClass('fixed')
        }
    });

});
</script>

<div id="app"></div>
<script type="text/javascript">
   const loginUserLevel = "<%= GetLoginUserLevel %>";
   const loginUserID = "<%= GetLoginUserID %>";
   const server_info = "<%= application("Svr_Info") %>";
   let isUserLoginOK = false;
   <% IF IsUserLoginOK THEN %>
       isUserLoginOK = true;
   <% END IF %>
   let eCode = 0;
    <% if eCode > 0 then %>
        eCode = <%=eCode%>
    <% End if%>


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

<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js" ></script>

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
<script src="/vue/components/common/functions/common.js?v=1.00"></script>
<script type="text/babel" src="/vue/common/mixins/common_mixins.js?v=1.00"></script>
<script src="/vue/event/family/js_applyItemInfo.js?v=1.00"></script>

<script src="/vue/event/etc/118569/store.js?v=1.00"></script>
<script src="/vue/event/etc/118569/index.js?v=1.1"></script>