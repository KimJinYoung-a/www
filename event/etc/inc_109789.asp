<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
'####################################################
' Description : 텐텐문구페어
' History : 2021-03-02 이전도
'####################################################
Dim eCode, brandListMasterIdx

IF application("Svr_Info") = "Dev" THEN
	eCode = 104322
    brandListMasterIdx = 2
Else
	eCode = 109789
    brandListMasterIdx = 4
End If
%>
<style>
.stationery-fair {position:relative; overflow:hidden; background:#fff;}
.stationery-fair .topic {position:relative; height:766px; background:#fff04b url(//webimage.10x10.co.kr/fixevent/event/2021/109789/bg_topic.jpg) no-repeat 50% 0;}
.stationery-fair .topic .deco {position:absolute; left:50%;}
.stationery-fair .topic .deco:nth-of-type(1) {top:118px; width:101px; height:101px; margin-left:-360px; background:#00b0e9; animation:slideY 1s 10 alternate linear;}
.stationery-fair .topic .deco:nth-of-type(2) {top:265px; margin-left:-50px; border:solid transparent; border-width:56px 0 56px 98px; border-left-color:#00b0e9; animation:pulse 1s 10 alternate linear;}
.stationery-fair .topic .deco:nth-of-type(3) {top:402px; margin-left:85px; border:solid transparent; border-width:0 70px 70px; border-bottom-color:#00b0e9; animation:slideY 1s 10 alternate linear;}
.stationery-fair .topic .deco:nth-of-type(3)::after {content:' '; position:absolute; top:70px; left:-70px; border:solid transparent; border-width:70px 70px 0; border-top-color:#00b0e9;}
.stationery-fair .intro {position:relative; height:1088px; background:#f7f4df url(//webimage.10x10.co.kr/fixevent/event/2021/109789/bg_intro.jpg) no-repeat 50% 0;}
.stationery-fair .intro .btn-brand {position:absolute; top:520px; right:50%; margin-right:-530px; background:none; animation:bounce 1s 20 both;}

.section-oneday {position:relative; padding:120px 0; background:#fff04b;}
.section-oneday .item {position:relative; width:1140px; margin:50px auto 0;}
.section-oneday .item > a {text-decoration:none;}
.section-oneday .desc {position:absolute; top:0; left:60px; display:-webkit-box; display:-ms-flexbox; display:flex; -webkit-box-orient:vertical; -webkit-box-direction:normal; -ms-flex-direction:column; flex-direction:column; -webkit-box-pack:center; -ms-flex-pack:center; justify-content:center; height:100%; text-align:left; letter-spacing:-.1em;}
.section-oneday .headline {font-size:40px; line-height:1.3; color:#000; font-weight:800;}
.section-oneday .subcopy {font-size:22px; line-height:1.6; color:#444; margin-top:15px;}

.section-special {position:relative; min-height:830px; padding-top:275px; background:#f7f4df url(//webimage.10x10.co.kr/fixevent/event/2021/109789/bg_special.jpg) no-repeat 50% 0;}
.section-special .evt-slider {position:relative; width:750px; margin:0 auto;}
.section-special .evt-slider a {text-decoration:none;}
.section-special .thumbnail img {width:750px; height:512px;}
.section-special .desc {position:relative; margin-top:55px; text-align:left; letter-spacing:-.1em;}
.section-special .headline {font-size:36px; line-height:1.4; color:#000; font-weight:700; margin-right:100px; word-break:break-all;}
.section-special .subcopy {font-size:22px; line-height:1.5; color:#444; font-weight:500; margin-top:8px;}
.section-special .discount {position:absolute; right:0; top:0; font-weight:500; font-size:38px; line-height:1.2; color:#ff335a;}
.section-special .pagination-progressbar {position:absolute; left:0; top:512px; z-index:10; width:100%; height:14px; background:#fff;}
.section-special .pagination-progressbar-fill {position:absolute; left:0; top:0; width:100%; height:100%; transform:scaleX(0); transform-origin:left top; transition-duration:300ms; background:#00b0e9;}
.section-special .slick-arrow {position:absolute; top:220px; z-index:10; width:40px; height:72px; background:url(//fiximage.10x10.co.kr/web2018/common/sp_icon.png?v=1.12) no-repeat;}
.section-special .slick-prev {left:30px; right:auto; background-position:0 -110px;}
.section-special .slick-next {left:auto; right:30px; background-position:-50px -110px;}

.section-justsold {position:relative; padding-top:120px; background:#00b0e9;}
.section-justsold h3 {width:1140px; margin:0 auto 110px; padding-bottom:40px; text-align:left; border-bottom:4px solid #000;}
.section-justsold .items-list {width:1140px; margin:0 auto;}
.section-justsold .items-list ul {display:-webkit-box; display:-ms-flexbox; display:flex; -webkit-box-orient:horizontal; -webkit-box-direction:normal; -ms-flex-flow:row wrap; flex-flow:row wrap; -webkit-box-pack:center; -ms-flex-pack:center; justify-content:center;}
.section-justsold .items-list ul::after {content:' '; display:block; clear:both;}
.section-justsold .items-list li {position:relative; float:left; width:270px; height:500px; margin:0 5px;}
.section-justsold .items-list li > a {display:block; position:relative; text-decoration:none;}
.section-justsold .items-list .label-time {position:absolute; left:0; top:-22px; z-index:10; height:48px; padding:0 15px; font-size:22px; line-height:51px; color:#fff; background:#000; border-radius:10px 10px 10px 0;}
.section-justsold .items-list .label-time::after {content:' '; position:absolute; left:0; bottom:-6px; border:solid transparent; border-width:6px 10px 0 0; border-top-color:#000;}
.section-justsold .items-list .thumbnail img {width:270px;}
.section-justsold .items-list .desc {padding-top:20px; text-align:left; font-weight:500; font-size:22px; line-height:1.4; color:#fff; word-break:break-all;}
.section-justsold .items-list .won {font-weight:300;}
.section-justsold .items-list .discount {padding-left:15px; color:#f3df02;}
.section-justsold .items-list .name {padding:8px 5px 0 0; font-size:21px;}

.section-brand {position:relative; padding-bottom:120px; background:#fff;}
.section-brand h3 {width:1140px; padding:120px 0 80px; margin:0 auto; text-align:left;}
.section-brand .tab {display:-webkit-box; display:-ms-flexbox; display:flex; -webkit-box-pack:justify; -ms-flex-pack:justify; justify-content:space-between; width:1140px; margin:0 auto 20px;}
.section-brand .tab button {width:560px; height:80px; font-weight:500; font-size:28px; color:#222; letter-spacing:-1px; background:none; border:2px solid #222;}
.section-brand .tab button.active {color:#fff; background:#444;}
.section-brand .brand-list {width:1140px; margin:0 auto; font-weight:500; font-size:21px; line-height:1.2;color:rgba(0,0,0,.9); word-break:break-all;}
.section-brand .brand-list ul {display:-webkit-box; display:-ms-flexbox; display:flex; -webkit-box-orient:horizontal; -webkit-box-direction:normal; -ms-flex-flow:row wrap; flex-flow:row wrap;}
.section-brand .brand-list ul::after {content:' '; display:block; clear:both;}
.section-brand .brand-list li {position:relative; float:left; width:20%; padding:20px 0;}
.section-brand .brand-list li > a {overflow:hidden; display:block; width:80%; text-align:left; text-decoration:none; white-space:nowrap; text-overflow:ellipsis;}

@keyframes pulse {
	0% {transform:scale3d(.9,.9,.9);}
	100% {transform:scale3d(1.1,1.1,1.1);}
}
@keyframes slideY {
	0% {transform:translateY(-10px);}
	100% {transform:translateY(10px);}
}
@keyframes bounce {
	from, to {transform:none; animation-timing-function:ease-in;}
	50% {transform:translateY(20px); animation-timing-function:ease-out;}
}
</style>
<script>
    // 개발 여부
    const is_develop = unescape(location.href).includes('//testm') || unescape(location.href).includes('//localm');
    // API 공통url
    const apiurl = function() {
        let apiUrl
        if( is_develop ) {
            apiUrl =  '//testfapi.10x10.co.kr/api/web/v1'
        } else {
            apiUrl =  '//fapi.10x10.co.kr/api/web/v1'
        }
        return apiUrl;
    }();
</script>
<!-- MD 텐텐 문구 페어 109789 -->
<div class="stationery-fair">
    <div class="topic">
        <i class="deco"></i><i class="deco"></i><i class="deco"></i>
    </div>
    <div class="intro">
        <!-- for dev msg : 개발 완료 시 노출 -->
        <a href="#brand" class="btn-brand"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109789/btn_brand.png" alt="참여브랜드 보러가기"></a>
    </div>

    <!-- 원데이, 롤링배너 -->
    <!-- #include virtual="/event/etc/StationeryFair/inc_oneday_rolling.asp" -->
	<!-- 방금 판매된 상품 -->
	<!-- #include virtual="/event/etc/StationeryFair/inc_justsold_list.asp" -->
	<!-- 브랜드 -->
	<!-- #include virtual="/event/etc/StationeryFair/inc_brand_list.asp" -->
</div>