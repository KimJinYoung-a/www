<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<%
    if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
        if Not(Request("mfg")="pc" or session("mfg")="pc") then
            if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
                Response.Redirect "//m.10x10.co.kr/universal/"
                REsponse.End
            end if
        end if
    end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">

<style>
.tMar15 {margin-top:0;}
.univarsal {background:#fff;}
.w1060 {width:1060px; margin:0 auto;}
.w1140 {width:1140px; margin:0 auto;}
.w1300 {width:1300px; margin:0 auto;}
.relative {position:relative;}	
.main-bnr {position:relative; height:600px; margin:0 auto; overflow:hidden; background:#111;}
.main-contents {background:#fff;}
.main-bnr .logo {position:absolute; left:50%; top:24px; transform:translateX(-50%); width:82px; height:44px; overflow: hidden;}
.main-bnr .logo img {width:100%;}
.main-swiper {position:relative;}
.main-swiper.on {animation:translateY .3s;}
.main-swiper .swiper-container {width:1060px; margin:0 auto;}
.main-swiper .swiper-wrapper {width:100%; height:600px!important; align-items:center;}
.main-swiper .swiper-slide {position:relative; width:306px; height:418px;border-radius:20px; overflow:hidden; transition:all .5s ease-out;}
.main-swiper .swiper-slide .thumbnail {visibility:hidden; width:306px; height:0; border-radius:20px;}
.main-swiper .swiper-slide .thumbnail img,
.main-swiper .swiper-slide .thumbnail-hidden img {width:100%; border-radius:20px;}
.main-swiper .swiper-slide .thumbnail-hidden {visibility:hidden; width:306px; height:0; border-radius:20px;}
.main-swiper .swiper-slide .thumbnail.on,
.main-swiper .swiper-slide .thumbnail-hidden.on {visibility:visible; height:418px; transform: rotateY(360deg); transition: all .3s ease-out;}
.main-swiper .bg-left {position:absolute; left:0; top:0; width:240px; height:100%; background: linear-gradient(270deg, rgba(17, 17, 17, 0) 0%, #111111 100%); z-index:1;}
.main-swiper .bg-right {position:absolute; right:0; top:0; width:240px; height:100%; background: linear-gradient(270deg, #111111 0%, rgba(17, 17, 17, 0) 100%); z-index:1;}
.swiper-container.two .bg-right {position:absolute; right:0; top:-1px; width:123px; height:100%; background: linear-gradient(270deg, rgba(255, 255, 255, 0) 0%, #FFFFFF 100%); transform: rotate(180deg); z-index:1;}
.swiper-container.two .bg-left {position:absolute; left:-53px; top:-1px; width:123px; height:100%; background:#fff; z-index:1;}
.main-prd-view {position:absolute; left:0; top:0; z-index:5; width:100%; height:100%;}
.main-prd-view a {display:inline-block; width:100%; height:100%; transform:rotateY(0); -webkit-transform:rotateY(0); -webkit-transition:transform .3s ease-out; transition:transform .3s ease-out;}
.main-prd-view .view-all {position:absolute; left:50%; bottom:32px; transform:translateX(-50%); display:inline-block; height:32px; padding:0 16px; line-height:32px; font-size:14px; font-weight:500; color:#111; border-radius:16px; background:#fff; white-space:nowrap;} 
.main-prd-view.on a {transform:rotateY(360deg); -webkit-transform:rotateY(360deg); -webkit-transition:transform .3s ease-out; transition:transform .3s ease-out;}
.main-bnr .bnr-type-area {position:absolute; left:50%; bottom:28px; transform:translateX(-50%); display:flex; align-items:center; justify-content:center; width:100%; z-index:10;}
.main-bnr .bnr-type-area button {position:relative; margin:0 0.68rem; font-size:13px; font-weight:700; color:rgba(255,255,255,0.45); background:transparent;}
.main-bnr .bnr-type-area button::before {content:""; width:8.96rem; height:3.5rem; position:absolute; left:50%; top:50%; transform:translate(-50%,-50%);}
.main-bnr .bnr-type-area .icon {display:inline-block; margin-right:6px; background-repeat:no-repeat;}
.main-bnr .bnr-type-area button.on {height:26px; line-height:26px; padding:0 10px; border-radius:33px; background:rgba(255, 255, 255, 0.5); color:#111;}
.main-bnr .bnr-type-area .btn-big .icon {width:10px; height:11px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/m/icon_view01_off.png);}
.main-bnr .bnr-type-area .btn-big.on .icon {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/m/icon_view01_on.png);}
.main-bnr .bnr-type-area .btn-many .icon {width:10px; height:10px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/m/icon_view02_off.png);}
.main-bnr .bnr-type-area .btn-many.on .icon {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/m/icon_view02_on.png);}
.main-bnr .btn-reverse {position:absolute; right:-10px; top:-12px; width:80px; height:80px; padding:24px; z-index:6; background:transparent; -webkit-transform: translate3d(0,0,0); -webkit-backface-visibility: hidden;}
.main-bnr .btn-reverse img {width:100%; transform:rotateY(0) translate3d(0, 0, 0); -webkit-transform:rotateY(0) translate3d(0, 0, 0); transition:transform .3s ease-out; -webkit-transition:transform .3s ease-out;}
.main-bnr .btn-reverse.on img {transform:rotateY(360deg) translate3d(0, 0, 0); -webkit-transform:rotateY(360deg) translate3d(0, 0, 0); -webkit-transition:transform .3s ease-out; transition:transform .3s ease-out;}
@keyframes translateY {
	0% {transform:translateY(150px);}
	100% {transform:translateY(0);}
}
@keyframes scaleSize {
	0% {transform:scale(0.3);}
	100% {transform:scale(1);}
}
.h-group {margin-bottom:32px; font-size:28px; font-weight:700; color:#000; text-align:left;}
.h-group.top {margin-top:150px;}
.h-group .icon {display:inline-block; width:32px; height:40px; margin:-5px 0 0 8px; vertical-align:middle; background-size:100%!important; background:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/icon_good.png) no-repeat 0 0;}
.main-sm-bnr.on {animation:translateY .3s;}
.main-sm-bnr {position:relative; height:600px;}
.main-sm-bnr .ch-list {display:flex; align-items:flex-start; justify-content:center; flex-wrap:wrap; width:1092px; margin:0 auto; padding-top:116px;}
.main-sm-bnr .ch-list li {width:124px; height:168px; margin:0 16px 32px; cursor:pointer; overflow:hidden; border-radius:20px;}
.main-sm-bnr .ch-list li img {width:100%;}
.main-bnr .bg {position:absolute; left:0; bottom:-1.7rem; width:100%; height:10.16rem; background: linear-gradient(180deg, rgba(0, 0, 0, 0) 0%, #000000 100%); z-index:5;}
.main-ch-detail {visibility:hidden; position:absolute; left:0; top:0; width:100%; height:43.35rem; transition: visibility .3s;}
.main-ch-detail .dim {position:absolute; left:0; top:0; width:100%; height:43.35rem; background:rgba(0, 0, 0, 0.8);  -webkit-backdrop-filter: blur(10px); backdrop-filter: blur(10px); z-index:4;}
.main-ch-detail.on {visibility:visible; transition:visibility .3s;}
.main-ch-detail.on .main-sm-detail {transform:scale(1);}
.main-sm-detail {position:absolute; left:50%; top:104px; width:306px; height:420px; margin-left:-153px; z-index:5; transform:scale(0.4); transition:transform .3s;}
.main-sm-detail .info {width:306px; height:420px; z-index:5; overflow:hidden;}
.main-sm-detail .info img {border-radius:20px; width:100%; background:#fff;}
.main-sm-detail .btn-close {position:absolute; right:0; top:0; width:56px; height:56px; padding:12px; background:transparent; z-index:6;}
.universal-md-pick {padding-top:80px;}
.universal-list ul {display:flex; align-items:flex-start; justify-content:space-between; flex-wrap:wrap;}
.universal-list ul li {width:340px; margin-bottom:47px;}
.universal-list ul li:nth-child(4),
.universal-list ul li:nth-child(5),
.universal-list ul li:nth-child(6) {margin-bottom:0;}
.universal-list ul li a {text-decoration:none;}
.universal-list .desc {text-align:left;}
.universal-list .thumbnail {position:relative; width:340px; height:340px; border-radius:10px; overflow:hidden;}
.universal-list .thumbnail img {width:100%; border-radius:10px;}
.universal-list .thumbnail .badge {display:inline-block; position:absolute; left:0; top:0; padding:4px 11px; background:#fff; font-size:16px; font-weight:500; color:#111; border-radius:0 0 10px 0;}
.universal-list .thumbnail::after {content: '';position: absolute;top: 0;left: 0;z-index: 15;width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.01);}
.universal-list .price {margin-top:16px;}
.universal-list .price span {font-size:16px; color:#111; font-weight:600;}
.universal-list .price .discount {margin-left:4px; font-size:14px; color:#FF214F; font-weight:600;}
.universal-list .txt {margin-top:4px; font-size:14px; font-weight:400; color:#111; line-height:20px; overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;}
.universal-list .user_side {margin-top:16px;}
.universal-list .user_eval {display: inline-block; width: 50px; height: 10px; position: relative; overflow: hidden;}
.universal-list .user_eval::before,
.universal-list .user_eval i {position:absolute; top:0; left:0; height:100%; background-position:left center; background-repeat:repeat-x; background-size:auto 100%;}
.universal-list .user_eval::before {width:100%; content:' '; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3e%3cpath fill='none' stroke='%23FF214F' stroke-width='2' d='M24.006 5c.026 0 .052.008.074.024h0l6.442 12.24 13.856 1.943c.221.042.4.109.52.22.062.06.097.133.101.212.009.152-.056.308-.153.457-.154.235-.398.446-.712.613h0l-9.46 8.752 1.965 11.632c.133.594.187 1.082.14 1.466-.02.155-.035.3-.134.377-.11.087-.272.072-.449.058-.396-.03-.87-.175-1.422-.41h0L23.97 37.007l-10.71 5.58c-.551.233-1.025.377-1.42.408-.177.014-.34.03-.45-.058-.098-.077-.113-.222-.132-.377-.048-.384.005-.872.139-1.466h0L13.36 29.46l-9.459-8.75a2.02 2.02 0 01-.74-.635c-.1-.15-.169-.305-.16-.457a.266.266 0 01.093-.185c.128-.114.32-.181.558-.224h0l13.865-1.945 6.209-12.045a.533.533 0 01.162-.179.227.227 0 01.118-.039z'/%3e%3c/svg%3e");}
.universal-list .user_eval i {font-size:0; color:transparent; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3e%3cpath fill='%23FF214F' fill-rule='evenodd' d='M25.093 4.737l6.077 11.608 13.369 1.875c1.963.357 1.87 2.322.187 3.304l-8.975 8.304 1.87 11.073c.654 2.946-.561 3.75-3.273 2.59l-10.377-5.359-10.284 5.358c-2.712 1.16-3.927.357-3.273-2.59l1.87-11.072-8.975-8.304c-1.683-.982-1.87-2.947.187-3.304l13.37-1.875 5.983-11.608c.56-.983 1.776-.983 2.244 0z'/%3e%3c/svg%3e");}
.universal-list dfn {overflow: hidden;position: absolute;width: 0;height: 0;font-size: 0;color: transparent;}
.universal-list .user_comment {font-size:12px; color:#999;}
.universal-exhibition .exhibition-wrap {width:520px;}
.universal-exhibition  li {position:relative; margin-right:20px;}
.universal-exhibition  li:last-child {margin-right:0;}
.universal-exhibition  a {display:inline-block; width:100%; height:100%; text-decoration:none;}
.universal-exhibition .thumbnail {width:520px; height:340px; border-radius:10px; overflow:hidden;}
.universal-exhibition .thumbnail img {position:relative; width:100%; height:100%; object-fit:cover; border-radius:10px; overflow:hidden;}
.universal-exhibition .thumbnail::after {content: '';position: absolute;top: 0;left: 0;z-index: 1;width: 100%;height:340px;background-color: rgba(0, 0, 0, 0.01);border-radius:10px;}
.universal-exhibition .desc {position:relative;}
.universal-exhibition .badge span {vertical-align:top;}
.universal-exhibition .badge {position:absolute; right:1.37rem; top:1.71rem; z-index:5;}
.universal-exhibition .badge .coupon {position:relative; display:inline-block; min-width:2.14rem; height:1.878rem; margin:0.01rem 0.51rem 0; line-height:2.08rem; text-align:center; background:#FF214F; font-size:1.02rem; font-family:var(--bd); box-shadow: 0px 8px 12px -4px rgba(192, 0, 40, 0.25); color:#fff;}
.universal-exhibition .badge .coupon::before {content:''; position:absolute; left:-0.68rem; top:50%; width:0.68rem; height:1.878rem; transform:translateY(-50%); background-image:url(//fiximage.10x10.co.kr/m/2022/main/m/bg_coupon02.png); background-repeat:no-repeat; background-position:left; background-size:2.73rem 1.88rem;}
.universal-exhibition .badge .coupon::after {content:''; position:absolute; right:-0.68rem; top:50%; width:0.68rem; height:1.878rem; transform:translateY(-50%); background-image:url(//fiximage.10x10.co.kr/m/2022/main/m/bg_coupon02.png); background-repeat:no-repeat; background-position:right; background-size:2.73rem 1.88rem;}
.universal-exhibition .badge .only {display:inline-block; height:1.88rem; margin-left:0.3rem; padding:0 0.34rem; line-height:2.08rem; font-size:1.02rem; background:#111; box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.25); border-radius:0.34rem; color:#fff; font-family:var(--bd);}
.universal-exhibition .badge .coupon {position: relative;display: inline-block;min-width: 2.14rem;height: 1.878rem;margin: 0.01rem 0.51rem 0;line-height: 2.08rem;text-align: center;background: #FF214F;font-size: 1.02rem;font-family: var(--bd);box-shadow: 0px 8px 12px -4px rgb(192 0 40 / 25%);color: #fff;}
.universal-exhibition .desc .headline {margin:28px 2.05rem 0 13px; text-align:left;}
.universal-exhibition .headline {margin:15px 2.05rem 0 13px;}
.universal-exhibition .headline .tit {display:flex; align-items:center; font-size:20px; color:#111; font-weight:700; line-height:28px;}
.universal-exhibition .headline .tit span:nth-child(1) {max-width: 24rem; overflow: hidden; white-space:nowrap; text-overflow:ellipsis;}
.universal-exhibition .headline .sub {padding-top:4px; font-size:14px; color:#111; line-height:20px; overflow: hidden; display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;}
.universal-exhibition .headline .tit .discount {margin-left:4px; color:#FF214F; font-size:18px; font-weight:700;}
.universal-exhibition .headline .key-word {display:flex; align-items:flex-start; flex-wrap:wrap;}
.universal-exhibition .headline .key-word li {height:22px; padding:0 4px; margin-right:8px; line-height:22px; font-size:12px; color:#999; font-weight:400; background:#F5F6F7; border-radius:4px;}
.universal-exhibition .headline .key-word li .tag {color:#ccc;}
.universal-exhibition .headline .key-word li:active {background: linear-gradient(0deg, rgba(0, 0, 0, 0.03), rgba(0, 0, 0, 0.03)), #F5F6F7;}
.universal-exhibition .headline .key-word li a {display:inline-block; color:#999;}
.universal-exhibition .character-line {position:absolute; left:18px; top:322px; z-index:5; display:flex; align-items:center;}
.universal-exhibition .character-line .proflie {position:relative; width:32px; height:32px; margin-left:-7px; border:2px solid #fff; background:#eee; border-radius: 100%; overflow: hidden;}
.universal-exhibition .character-line .proflie img {width:100%; border-radius:100%;}
.universal-exhibition .character-line div:nth-child(1) {z-index:5;}
.universal-exhibition .character-line div:nth-child(2) {z-index:4;}
.universal-exhibition .character-line div:nth-child(3) {z-index:3;}
.universal-exhibition .character-line div:nth-child(4) {z-index:2;}
.universal-exhibition .character-line div:nth-child(4)::before {content:""; position:absolute; left:50%; top:50%; transform:translate(-50%,-50%); width:1.28rem; height:0.26rem; background:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/m/icon_empty.png) no-repeat 0 0; background-size:100%;}
.btn-area {margin-top:60px; text-align:center;}
.btn-area a {display:inline-block; width:412px; height:60px; line-height:60px; background:#F5F6F7; border-radius:60px; font-size:16px; font-weight:500; color:#666; text-align:center; text-decoration:none;}
.universal-best {position:relative;}
.universal-best .swiper-slide button {display:flex; align-items:center; min-width:74px; height:32px; line-height:32px; padding:0 12px; font-size:14px; font-weight:500; color:#999; border:1px solid #eee; border-radius:32px; background:transparent;}
.universal-best .swiper-container.three ul {justify-content:flex-start;}
.universal-best .swiper-container.three ul li {width:auto; margin:0 8px 0 0;}
.universal-best .swiper-container.three ul li:last-child {margin-right:0;}
.universal-best .swiper-container.three ul li.active button {color:#FF214F; font-weight:700; border:1.5px solid #FF214F;}
.universal-best .swiper-container.three {position:absolute; right:0; top:51px; width:auto;} 
.universal-best .swiper-container.three li .icon {display:inline-block; margin-right:4px; background-repeat:no-repeat; background-size:24px; width:24px; height:24px;}
.universal-best .swiper-container.three li.slide01 .icon {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/img_sm_thum01.png);}
.universal-best .swiper-container.three li.slide02 .icon {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/img_sm_thum02.png);}
.universal-best .swiper-container.three li.slide03 .icon {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/img_sm_thum03.png);}
.universal-best .swiper-container.three li.slide04 .icon {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/img_sm_thum04.png);}
.universal-best .swiper-container.three li.slide05 .icon {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/img_sm_thum05.png);}
.universal-best .swiper-container.three li.slide06 .icon {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/img_sm_thum06.png);}
.universal-best .swiper-container.three li.slide07 .icon {background-image:url(//webimage.10x10.co.kr/fixevent/event/2022/universal/img_sm_thum07.png);}
.universal-type01 .visual-area {width:1300px; height:380px; position:absolute; left:50%; top:0; margin-left:-650px; overflow:hidden;}
.universal-type01 .visual-area .bg-left {position:absolute; left:0; top:0; width:240px; height:100%; background: linear-gradient(270deg, rgba(255, 255, 255, 0) 0%, #FFFFFF 100%); z-index:1;}
.universal-type01 .visual-area .bg-right {position:absolute; right:0; top:0; width:240px; height:100%; background: linear-gradient(270deg, rgba(255, 255, 255, 0) 0%, #FFFFFF 100%); transform: rotate(180deg); z-index:1;}
.universal-type01 .contents {padding-top:415px;}
.universal-type01.universal-type02 .contents {padding-top:33px;}
.universal-type01 .contents ul {display:flex; align-items:center;}
.universal-type01 .contents li {margin-right:17px;}
.universal-type01 .contents li:last-child {margin-right:0;}
.universal-type01 .contents li a {display:flex; align-items:center; width:342px; text-decoration:none;}
.universal-type01 .contents li .prd_img {position: relative; width:130px; height:130px; margin:0; overflow:hidden;}
.universal-type01 .contents li .prd_img img {width:100%;}
.universal-type01 .contents li .prd_img::after {content: '';position: absolute;top: 0;left: 0;z-index: 15;width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.01);}
.universal-type01 .contents li .prd_name {margin-top:4px; font-size:14px; font-weight:400; line-height:20px; color:#111; overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;}
.universal-type01 .contents li .set_price {font-size:16px; color:#111; font-weight:600;}
.universal-type01 .contents li .discount {font-size:14px; font-weight:600; color:#FF214F;}
.universal-type01 .contents li .prd_info {flex:1; margin-left:12px; text-align:left;}
.universal-type01 .contents li dfn {font-size:0;}
.universal-type01 .h-group {position:absolute; left:0; top:-67px; z-index:5;}
.universal-type01.universal-type02 .h-group {top:0; left:35px;}
.universal-type01.top {margin-top:240px;}
.universal-type02.top {margin-top:180px;}
.universal-type01.universal-type02 .contents li .prd_img {border-radius:100%;}
.universal-type02 .banner {position:relative; border-bottom:1px solid #eee; overflow:hidden;}
.universal-type02 .banner img {width:100%;}
/* product unit */
.universal-tyoe03 .prd_list.type_basic .prd_item {width:246px; margin:0 25px 40px 0;}
.universal-tyoe03 .prd_list.type_basic .prd_item:nth-child(4n) {margin-right:0;}
.universal-tyoe03 .prd_item {position:relative;}
.universal-tyoe03 .prd_img {position:relative; width:246px; height:246px; padding:0; margin:0; overflow:hidden;}
.universal-tyoe03 .prd_img > img {width:100%; height:100%; object-fit:cover;}
.universal-tyoe03 .prd_img::after {content: '';position: absolute;top: 0;left: 0;z-index: 5;width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.01);}
.universal-tyoe03 .prd_list.type_basic {display:flex; flex-wrap:wrap;}
.universal-tyoe03 .prd_list.type_basic .prd_item .prd_info {margin-top:20px;}
.universal-tyoe03 .prd_list.type_basic .prd_item .prd_name {margin-top:4px; font-size:14px; color:#111; font-weight:400; text-align:left;  overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;}
.universal-tyoe03 .prd_list.type_basic .prd_item [class^="btn_wish"] {top:0; right:0; width:32px; height:32px; margin-top:calc(100% - 32px);}
.universal-tyoe03 .prd_item .prd_price {display:flex; align-items:center; overflow-wrap:break-word;}
.universal-tyoe03 .prd_item .set_price {font-weight:600; font-size:18px; color:#111; letter-spacing:-0.05em;}
.universal-tyoe03 .prd_item .discount {margin-left:4px; font-weight:600; font-size:14px; color:#FF214F; letter-spacing:-0.05em;}
.universal-tyoe03 .prd_item .user_comment {font-size:1rem; color:var(--c_666);}
.universal-tyoe03 .prd_item .prd_link {position:absolute; top:0; right:0; bottom:0; left:0; z-index:10;}
.universal-tyoe03 .prd_item .btn_more {position:relative; display:block; width:100%; margin-top:1.45rem; text-align:left; font-size:1.19rem; color:var(--c_999); white-space:nowrap;}
.universal-tyoe03 .prd_item .btn_more .i_arw_r2 {margin-left:.3em;}
.universal-tyoe03 .user_side {margin-top:10px; text-align:left;}
.universal-tyoe03 .user_side .user_eval {display: inline-block;position: relative;width: 50px;height: 10px;}
.universal-tyoe03 .user_side .user_eval::before {width:100%; content:' '; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3e%3cpath fill='none' stroke='%23FF214F' stroke-width='2' d='M24.006 5c.026 0 .052.008.074.024h0l6.442 12.24 13.856 1.943c.221.042.4.109.52.22.062.06.097.133.101.212.009.152-.056.308-.153.457-.154.235-.398.446-.712.613h0l-9.46 8.752 1.965 11.632c.133.594.187 1.082.14 1.466-.02.155-.035.3-.134.377-.11.087-.272.072-.449.058-.396-.03-.87-.175-1.422-.41h0L23.97 37.007l-10.71 5.58c-.551.233-1.025.377-1.42.408-.177.014-.34.03-.45-.058-.098-.077-.113-.222-.132-.377-.048-.384.005-.872.139-1.466h0L13.36 29.46l-9.459-8.75a2.02 2.02 0 01-.74-.635c-.1-.15-.169-.305-.16-.457a.266.266 0 01.093-.185c.128-.114.32-.181.558-.224h0l13.865-1.945 6.209-12.045a.533.533 0 01.162-.179.227.227 0 01.118-.039z'/%3e%3c/svg%3e");}
.universal-tyoe03 .user_side {margin-top:10px;}
.universal-tyoe03 .user_side .user_eval i {font-size:0; color:transparent; background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3e%3cpath fill='%23FF214F' fill-rule='evenodd' d='M25.093 4.737l6.077 11.608 13.369 1.875c1.963.357 1.87 2.322.187 3.304l-8.975 8.304 1.87 11.073c.654 2.946-.561 3.75-3.273 2.59l-10.377-5.359-10.284 5.358c-2.712 1.16-3.927.357-3.273-2.59l1.87-11.072-8.975-8.304c-1.683-.982-1.87-2.947.187-3.304l13.37-1.875 5.983-11.608c.56-.983 1.776-.983 2.244 0z'/%3e%3c/svg%3e");}
.universal-tyoe03 .user_side .user_comment {font-size:12px; font-weight:300; color:#666;}
.universal-tyoe03 .user_side .user_eval i {position:absolute; top:0; left:0; height:100%; background-position:left center; background-repeat:repeat-x; background-size:auto 100%;}
.universal-tyoe03 dfn {display:none;}
[class^="btn_wish"] {position:absolute; z-index:10; font-size:0; background-color:transparent; background-position:center; background-repeat:no-repeat; background-size:2.05rem;}
.btn_wish .ico_wish {margin:0;}
.universal-tyoe03 .blind {font-size:0; text-indent:-9999px;}
.uni-footer {width:100%; max-width:100%; height:100px; margin:0 auto; display:flex; align-items:center; justify-content:center; margin-top:90px; background:#111; text-align:center;}
.uni-footer img {width:461px; height:44px;}
.banner-area {width:1059px; height:64px; margin:20px auto 0;}
.banner-area .swiper-bnr {padding-bottom:25px;}
.banner-area .swiper-slide {width:100%; height:64px; overflow:hidden;}
.banner-area .swiper-slide img {width:100%; border-radius:10px;}
.swiper-horizontal>.swiper-pagination-bullets, 
.swiper-pagination-bullets.swiper-pagination-horizontal, 
.swiper-pagination-custom, 
.swiper-pagination-fraction {bottom:0!important;}
.swiper-pagination {margin-top:12px; text-align:center;}
.swiper-pagination span {display:inline-block; width:4px; height:4px; margin:0 4px!important; border-radius:100%; background:rgba(0, 0, 0, 0.5)!important;}
.swiper-pagination span.swiper-pagination-bullet-active {background:#000!important;}
/* swiper */
.slick-track {display:flex; align-items:center;}
.swiper-button-prev,
.swiper-container-rtl .swiper-button-prev {
    background-image: url(//webimage.10x10.co.kr/fixevent/event/2022/universal/icon_arrow.png);
    left:10px!important;
    right: auto;
	width:50px!important;
	height:50px!important;
}
.swiper-button-next,
.swiper-container-rtl .swiper-button-next {
    background-image: url(//webimage.10x10.co.kr/fixevent/event/2022/universal/icon_arrow.png);
    right:10px!important;
    left: auto;
	width:50px!important;
	height:50px!important;
	transform:rotate(180deg);
}
.swiper-container.two .swiper-button-next,
.swiper-container.two .swiper-container-rtl .swiper-container.two .swiper-button-next {
    background-image: url(//webimage.10x10.co.kr/fixevent/event/2022/universal/icon_arrow_white.png?v=2);
    left: 10px;
    right: auto;
	width:50px!important;
	height:50px!important;
	transform:rotate(0);
}
.swiper-container.two .swiper-button-prev,
.swiper-container.two .swiper-container-rtl .swiper-container.two .swiper-button-prev {
    background-image: url(//webimage.10x10.co.kr/fixevent/event/2022/universal/icon_arrow_white.png?v=2);
    right:0;
    left:35px!important;
	width:50px!important;
	height:50px!important;
	transform:rotate(180deg);
}
.swiper-button-prev:after, .swiper-rtl .swiper-button-next:after,
.swiper-button-next:after, .swiper-rtl .swiper-button-prev:after {content:""!important;}
.swiper-container.two .swiper-button-next {top:170px; left:unset; right:107px!important; filter: drop-shadow(4px 12px 24px rgba(0, 0, 0, 0.1));}
.swiper-container.two .swiper-button-prev {display:none; top:170px; right:unset; left:10px; filter: drop-shadow(4px 12px 24px rgba(0, 0, 0, 0.1));}
.swiper-container.two .swiper-button-prev.swiper-button-disabled.show {display:none;}
.swiper-container.two .swiper-button-prev.show {display:block;}
.swiper-container.two {padding:0 143px 0 70px; margin-left:-70px;}
.fade-swiper .slider {display:flex;}
.swiper-container.one::before {content:""; position: absolute;left: 0;top: 0;width: 240px;height: 100%;background: linear-gradient(270deg, rgba(17, 17, 17, 0) 0%, #111111 100%);z-index:2;}
.swiper-container.one::after {content:""; position: absolute;right: 0;top: 0;width: 240px;height: 100%;background: linear-gradient(270deg, #111111 0%, rgba(17, 17, 17, 0) 100%);z-index:2;}
</style>
<style>[v-cloak] { display: none; }</style>
</head>
<body>
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <div class="eventContV15 tMar15">
        <div class="contF contW">
            <div id="app" v-cloak></div>
        </div>
    </div>
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

        function goEventLink(evt) {
        	parent.location.href='/event/eventmain.asp?eventid='+evt;
        }
    </script>

    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
    <link rel="stylesheet"href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>

    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue-awesome-swiper@4.1.1/dist/vue-awesome-swiper.min.js"></script>

    <script src="/vue/common/common.js?v=1.00"></script>

    <script src="/vue/universal/store.js?v=1.00"></script>
    <script src="/vue/universal/index.js?v=1.00"></script>
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->