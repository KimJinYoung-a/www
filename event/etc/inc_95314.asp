<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 100원 자판기
' History : 2019-06-17 최종원 생성
'###########################################################
%>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
 <style type="text/css">
.evt95316 {padding-top:80px; background:#ffc6ce url(//webimage.10x10.co.kr/fixevent/event/2019/95316/bg_cont.jpg?v=1.01) repeat 50% 0;}
.machine {position:relative; width:788px; margin:0 auto; padding-bottom:90px;}
.machine .btn-list {position:absolute; top:0; left:0; border:solid 1px red;}
.machine .btn-list li {position:absolute; width:35px; height:10px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/95316/img_button_off.png);}
.machine .btn-list li.on {width:43px; height:18px; margin-top:-4px; margin-left:-4px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/95316/img_button_on.png);}
.machine .btn-list li:nth-child(1) {top:220px; left:140px;}
.machine .btn-list li:nth-child(2) {top:220px; left:355px;}
.machine .btn-list li:nth-child(3) {top:434px; left:105px;}
.machine .btn-list li:nth-child(4) {top:434px; left:240px;}
.machine .btn-list li:nth-child(5) {top:434px; left:375px;}
.machine .btn-list li:nth-child(6) {top:626px; left:140px;}
.machine .btn-list li:nth-child(7) {top:626px; left:338px;}
.evt95316 h2 {margin-bottom:53px;}
.evt95316 .noti {position:relative; padding:45px 0; background-color:#8b70ff; text-align:left;}
.evt95316 .noti h3 {position:absolute; top:50%;  left:50%; margin-top:-11px; margin-left:-400px;}
.evt95316 .noti ul {width:780px; margin:0 auto; padding-left:360px;}
.evt95316 .noti ul li {color:#fefefe; font-size:15px; line-height:1; padding:12px 0; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif;}
</style>
<script>
$(function(){
    // https://msm8994.tistory.com/34
    function pickNow(){
        var numbers = [];
        var pickNumbers = 3;
        for(insertCur = 0; insertCur < pickNumbers ; insertCur++){
            numbers[insertCur] = Math.floor(Math.random() * 6) + 1;
            for(searchCur = 0; searchCur < insertCur; searchCur ++){
                if(numbers[insertCur] == numbers[searchCur]){
                    insertCur--;
                    break;
                }
            }
        }
        var result = "";
        for(i = 0; i < pickNumbers; i ++){
            if(i > 0){
                result += ",";
            }
            result += numbers[i];
        }
        $('.btn-list li').removeClass('on');
        $('.btn-list li').eq(result[0]).addClass('on');
        $('.btn-list li').eq(result[2]).addClass('on');
        $('.btn-list li').eq(result[4]).addClass('on')
    }
    var pushBtn=setInterval(pickNow,1000);
});
</script>

<!-- 95316 100원자판기 -->
<div class="evt95316">
	<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/95316/tit_100won.png" alt="100원 자판기"></h2>
	<div class="machine">
		<img src="//webimage.10x10.co.kr/fixevent/event/2019/95316/img_machine.png" alt="상품 목록" usemap="#item-list">
		<ul class="btn-list">
			<li></li>
			<li class="on"></li>
			<li></li>
			<li></li>
			<li class="on"></li>
			<li class="on"></li>
			<li></li>
		</ul>
		<map id="item-list" name="item-list">
			<area shape="rect" alt="맥북" coords="56,84,248,206" href="/shopping/category_prd.asp?itemid=2230980&pEtr=95316" target="_blank" onfocus="this.blur();"/>
			<area shape="rect" alt="아이패드" coords="297,59,429,206" href="/shopping/category_prd.asp?itemid=2211392&pEtr=95316" target="_blank" onfocus="this.blur();" />
			<area shape="rect" alt="에어팟" coords="71,268,168,424" href="/shopping/category_prd.asp?itemid=2389237&pEtr=95316" target="_blank" onfocus="this.blur();" />
			<area shape="rect" alt="아이폰" coords="204,263,311,423" href="/shopping/category_prd.asp?itemid=2336252&pEtr=95316" target="_blank" onfocus="this.blur();" />
			<area shape="rect" alt="마스크" coords="335,265,448,424" href="/shopping/category_prd.asp?itemid=2024516&pEtr=95316" target="_blank" onfocus="this.blur();" />
			<area shape="rect" alt="네스프레소" coords="104,459,212,617" href="/shopping/category_prd.asp?itemid=2368857&pEtr=95316" target="_blank" onfocus="this.blur();" />
		</map>
	</div>
	<div class="noti">
		<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/95316/tit_noti.png" alt="유의사항"></h3>
		<ul>
			<li>- 본 이벤트는 텐바이텐 APP에서 로그인 후 참여 가능합니다.</li>
			<li>- ID당 1일 1회만 응모 가능하며, 친구에게 공유 시 한 번 더 응모 기회가 주어집니다. (하루 최대 2번 응모 가능)</li>
			<li>- 모든 상품의 당첨자가 결정되면 이벤트는 조기 마감될 수 있습니다. </li>
			<li>- 5만 원 이상의 상품을 받으신 분께는 세무 신고를 위해 개인 정보를 요청할 수 있습니다. </li>
			<li>- 제세공과금은 텐바이텐 부담입니다. </li>
			<li>- 당첨자에게는 상품 수령 후, 인증 사진을 요청할 예정입니다.</li>
		</ul>
	</div>
</div>
<!--// 95316 100원자판기 -->

<!-- #include virtual="/lib/db/dbclose.asp" -->