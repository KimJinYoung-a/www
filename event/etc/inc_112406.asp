<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 나만의 여름별장 이벤트
' History : 2021-06-29 정태훈
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim currentDate, eventStartDate, eventEndDate
dim eCode, userid, mktTest, subscriptcount, sqlstr, myTeaSet

IF application("Svr_Info") = "Dev" THEN
	eCode = "108373"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "112407"
    mktTest = true
Else
	eCode = "112407"
    mktTest = false
End If

eventStartDate = cdate("2021-06-30")	'이벤트 시작일
eventEndDate = cdate("2021-07-11")		'이벤트 종료일
if mktTest then
currentDate = cdate("2021-06-30")
else
currentDate = date()
end if

userid = GetEncLoginUserID()
%>
<style>
.evt112406 {background:#fff;}
.evt112406 .txt-hidden {text-indent:-9999px; font-size:0;}
.evt112406 .topic {position:relative; width:100%; height:948px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112406/bg_main.jpg) no-repeat 50% 0;}
.evt112406 .topic h2 {position:absolute; left:50%; top:174px; transform:translate(-50%,0); opacity:0; transition:all 1s;}
.evt112406 .topic h2.on {opacity:1; top:154px;}
.evt112406 .section-01 {position:relative; display:flex; align-items:center; justify-content:center; width:100%; height:316px; background:#fffc00;}
.evt112406 .section-01 .item01 {position:absolute; left:50%; top:-50px; margin-left:-596px;}
.evt112406 .section-01 .item02 {position:absolute; left:50%; top:276px; margin-left:613px;}
.evt112406 .section-02 {height:685px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112406/bg_sub01.jpg) no-repeat 50% 0;}
.evt112406 .section-03 {position:relative; height:1866px; background:#fff;}
.evt112406 .section-03 .item01 {position:absolute; left:50%; top:-160px; margin-left:218px;}
.evt112406 .section-03 .item02 {position:absolute; left:50%; top:250px; margin-left:-405px;}
.evt112406 .section-03 .item03 {position:absolute; left:50%; top:387px; margin-left:-831px; z-index:5;}
.evt112406 .section-03 .item04 {position:absolute; left:0; top:746px;}
.evt112406 .section-03 .item05 {position:absolute; left:50%; top:1612px; margin-left:-157px;}
.evt112406 .section-04 {position:relative; height:520px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112406/bg_sub02.jpg) no-repeat 50% 0;}
.evt112406 .section-04 .item01 {position:absolute; left:50%; top:-260px; margin-left:400px;}
.evt112406 .section-04 .item02 {position:absolute; left:50%; top:-94px; margin-left:-773px;}
.evt112406 .section-05 {position:relative; height:325px; background:#fffc00; display:flex; align-items:center; justify-content:center;}
.evt112406 .section-06 {padding-bottom:70px; background:#3b7bff;}
.evt112406 .section-06 .event-inner {width:837px; margin:0 auto;}
.evt112406 .section-07 {position:relative; height:1017px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/112406/bg_link.jpg) no-repeat 50% 0;}
.evt112406 .section-07 .link-list {width:837px; height:545px; padding-top:296px; margin:0 auto; display:flex; align-items:flex-start; flex-wrap:wrap;}
.evt112406 .section-07 .link-list a {display:inline-block; width:50%; height:170px; flex-wrap:wrap;}
.evt112406 .basket-price {padding:0 206px; background:#3b7bff;}
.evt112406 .basket-price .name {height:72px; line-height:72px; font-size:23px; letter-spacing:-1.5px; background:#fffc00; color:#3b7bff; text-align:center;}
.evt112406 .basket-price .name span {text-decoration-color: #3b7bff; text-decoration: underline;}
.evt112406 .basket-price .price {height:111px; line-height:111px; font-size:46px; letter-spacing:-1.5px; background:#fff; color:#282828; text-align:right; font-weight:700;}
.evt112406 .basket-price .price span {padding-left:8px; padding-right:38px; font-size:22px;}
.evt112406 .basket-price a {display:inline-block; width:100%; height:100%; text-decoration:none;}
.evt112406 .btn-detail {position:relative;}
.evt112406 .btn-detail span {position:absolute; right:330px; top:6px; width:15px; height:10px; transform:rotate(180deg);}
.evt112406 .btn-detail.noti span {right:313px; top:40px;}
.evt112406 .detail-info {display:none;}
.evt112406 .detail-info.on {display:block;}
.evt112406 .animate {opacity:0; transform:translateY(15%); transition:all 1s;}
.evt112406 .animate.on {opacity:1; transform:translateY(0);}

</style>
<script>
$(function(){
    /* 글자,이미지 스르륵 모션 */
    $(".topic > h2").addClass("on");

    $(window).scroll(function(){
        $('.animate').each(function(){
        var y = $(window).scrollTop() + $(window).height() * 1;
        var imgTop = $(this).offset().top;
        if(y > imgTop) {
            $(this).addClass('on');
        }
        });
    });
    $('.btn-detail').on('click',function(){
        if($(this).next('.detail-info').hasClass('on')) {
            $(this).next('.detail-info').removeClass('on');
            $(this).children('.arrow').css('transform','rotate(180deg)');
        } else {
            $(this).next('.detail-info').removeClass('on');
            $(this).next('.detail-info').addClass('on');
            $(this).children('.arrow').css('transform','rotate(0)');
        }
    });
});
</script>
						<div class="evt112406">
                            <div class="topic">
                                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/tit_main.png" alt="나만의 여름별장"></h2>
                            </div>
							<div class="section-01">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/tit_sub01.png" alt="이번 여름은 온전히 나를 위한 휴식의 시간" class="animate">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/icon_flower01.png" alt="꽃" class="item01">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/icon_flower02.png" alt="꽃" class="item02">
                            </div>
                            <div class="section-02"></div>
                            <div class="section-03">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/img_item01.png" alt="" class="item01 animate">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/img_item02.png" alt="" class="item02 animate">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/img_item03.png" alt="" class="item03 animate">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/img_item04.png" alt="" class="item04 animate">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/img_item05.png" alt="" class="item05 animate">
                            </div>
                            <div class="section-04">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/img_item06.png" alt="" class="item01 animate">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/icon_flower03.png" alt="" class="item02">
                            </div>
                            <div class="section-05">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/tit_sub02.png" alt="당신의 이번 여름별장은 어디인가요?" class="animate">
                            </div>
                            <div class="section-06">
                                <div class="event-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/tit_event.jpg" alt="여름별장을 꿈꾸는 당신에게 30만원의 지원금을 드립니다.">

                                    <div class="basket-price">
                                        <a href="/inipay/shoppingbag.asp">
                                            <% if IsUserLoginOK() then %>
                                            <div class="name">
                                                <span><%=GetLoginUserName()%></span>님의 장바구니 금액
                                            </div>
                                            <div class="price">
                                                <%= FormatNumber(getCartTotalAmount(userid), 0) %><span>원</span>
                                            </div>
                                            <% else %>
                                            <div class="name">
                                                로그인하고 응모하기
                                            </div>
                                            <div class="price">
                                                300,000<span>원</span>
                                            </div>
                                            <% end if %>
                                        </a>
                                    </div>

                                    <% if IsUserLoginOK() then %>
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/img_event_logout.jpg" alt="위 금액은 품절 상품 및 배송비를 제외한 금액입니다.">
                                    <% else %>
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/img_event_login.jpg" alt="로그인 후 확인하세요">
                                    <% end if %>
                                    <button type="button" class="btn-detail">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/btn_detail01.jpg" alt="응모방법 자세히 보기">
                                        <span class="arrow"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/icon_arrow.png" alt="화살표"></span>
                                    </button>
                                    <div class="detail-info">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/img_detail_info01.jpg" alt="응모방법">
                                    </div>
                                    <button type="button" class="btn-detail noti">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/btn_detail02.jpg" alt="응모방법 자세히 보기">
                                        <span class="arrow"><img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/icon_arrow.png" alt="화살표"></span>
                                    </button>
                                    <div class="detail-info">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/112406/img_detail_info02.jpg" alt="응모방법">
                                    </div>
                                </div>
                            </div>
                            <div class="section-07">
                                <div class="link-list">
                                    <a href="#mapGroup372064"></a>
                                    <a href="#mapGroup372067"></a>
                                    <a href="#mapGroup372065"></a>
                                    <a href="/event/eventmain.asp?eventid=112115"></a>
                                    <a href="#mapGroup372066"></a>
                                    <a href="#commentarea"></a>
                                </div>
                            </div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->