<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 누구나 가슴속에 여행을 품고 산다 이벤트
' History : 2021.08.03 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eventStartDate, eventEndDate, LoginUserid, mktTest
dim eCode, currentDate

IF application("Svr_Info") = "Dev" THEN
	eCode = "108385"
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
	eCode = "113211"
    mktTest = True
Else
	eCode = "113211"
    mktTest = False
End If

eventStartDate  = cdate("2021-08-04")		'이벤트 시작일
eventEndDate 	= cdate("2021-08-17")		'이벤트 종료일

LoginUserid		= getencLoginUserid()

if mktTest then
    currentDate = cdate("2021-08-04")
else
    currentDate = date()
end if
%>
<style type="text/css">
.evt113211 {background:#fff;}
.evt113211 .topic {position:relative;}
.evt113211 .topic .parasol-thumb {width:332px; height:215px; position:absolute; left:50%; top:295px; transform:translate(-50%,0);}
.evt113211 .topic .parasol-thumb img {width:100%; height:100%;}
.evt113211 .section-01 {position:relative;}
.evt113211 .section-01 .item01 {position:absolute; left:50%; top:350px; margin-left:170px; transition:all 1s .5s;}
.evt113211 .section-01 .item02 {position:absolute; left:50%; top:350px; margin-left:-80px; transition:all 1s .7s;}
.evt113211 .section-01 .item03 {position:absolute; left:50%; top:350px; margin-left:-340px; transition:all 1s .9s;}
.evt113211 .section-02 {position:relative;}
.evt113211 .section-02 .item01 {position:absolute; left:50%; top:34px; margin-left:-180px; animation:show 1s infinite alternate;}
.evt113211 .section-02 .item02 {position:absolute; left:50%; top:100px; margin-left:-1px; animation:show 1s .3s infinite alternate;}
.evt113211 .section-02 .item03 {position:absolute; left:50%; top:280px; margin-left:-273px; animation:show 1s .5s infinite alternate;}
.evt113211 .section-02 .item04 {position:absolute; left:50%; top:300px; margin-left:-8px; animation:show 1s .2s infinite alternate;}
.evt113211 .btn-area {width:1140px; margin:0 auto; background:#ffa025;}
.evt113211 .basket-price a {text-decoration:none;}
.evt113211 .basket-price {width:1140px; margin:0 auto; background:#ffa025;}
.evt113211 .basket-price .name {color:#272420; font-size:26px; font-weight:700; text-align:center;}
.evt113211 .basket-price .name span {text-decoration:underline;}
.evt113211 .basket-price .txt {padding-top:10px; color:#272420; font-size:20px; text-align:center;}
.evt113211 .basket-price .price {width:430px; height:97px; line-height:97px; margin:1.28rem auto 0; padding-right:1.28rem; font-size:42px; color:#787878; text-align:right; background:#fff; font-weight:500;}
.evt113211 .basket-price .price span {padding-left:0.38rem; font-size:24px;}
.evt113211 .btn-detail {position:relative;}
.evt113211 .btn-detail .icon {height:10px; position:absolute; left:50%; top:32px; margin-left:86px;}
.evt113211 .noti {display:none;}
.evt113211 .noti.on {display:block;}
.evt113211 .icon.on {transform: rotate(180deg);}
.evt113211 .icon {transform: rotate(0);}
.evt113211 .animate {opacity:0; transform:translateY(-2rem); transition:all 1s;}
.evt113211 .animate.on {opacity:1; transform:translateY(0);}
@keyframes updown {
    0% {transform:translateY(-1rem);}
    100% {transform:translateY(0rem);}
}
@keyframes show {
    0% {opacity:0;}
    100% {opacity:1;}
}
</style>
<script>
$(function(){
	// changing img
	(function changingImg(){
		var i=1;
		var repeat = setInterval(function(){
			i++;
			if(i>3){i=1;}
			$('.evt113211 .topic .parasol-thumb img').attr('src','//webimage.10x10.co.kr/fixevent/event/2021/113211/img_item0'+ i +'.png?v=2');
		},260);
	})();
    $(window).scroll(function(){
        $('.animate').each(function(){
			var y = $(window).scrollTop() + $(window).height() * 1;
			var imgTop = $(this).offset().top;
			if(y > imgTop) {
				$(this).addClass('on');
			}
		});
    });
	// btn more
	$('.evt113211 .btn-detail').click(function (e) { 
		$(this).next().toggleClass('on');
        $(this).find('.icon').toggleClass('on');
	});
});
</script>
						<div class="evt113211">
							<div class="topic">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/bg_top.jpg?v=2" alt="" />
                                <div class="parasol-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/img_item01.png?v=2" alt=""></div>
                            </div>
							<div class="section-01">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/bg_sub01.jpg" alt="" />
                                <div class="item01 animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/img_prd01.png" alt=""></div>
                                <div class="item02 animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/img_prd02.png" alt=""></div>
                                <div class="item03 animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/img_prd03.png" alt=""></div>
                            </div>
                            <div class="section-02">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/bg_sub02.jpg?v=2" alt="" />
                                <div class="item01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/img_prd04.png" alt=""></div>
                                <div class="item02"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/img_prd05.png" alt=""></div>
                                <div class="item03"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/img_prd06.png" alt=""></div>
                                <div class="item04"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/img_prd07.png" alt=""></div>
                            </div>
                            <div class="section-03">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/bg_sub03.jpg" alt="" />
                            </div>
                            <!-- 장바구니 금액 -->
                            <div class="basket-price">
                                <a href="/inipay/shoppingbag.asp">
                                    <% if IsUserLoginOK() then %>
                                    <p class="name"><span><%=GetLoginUserName()%></span>님의 장바구니 금액</p>
                                    <div class="price"><%= FormatNumber(getCartTotalAmount(LoginUserid), 0) %><span>원</span></div>
                                    <p class="txt">*위 금액은 품절 상품 및 배송비를 제외한 금액입니다.</p>
                                    <% else %>
                                    <p class="name"><span>고객</span>님의 장바구니 금액</p>
                                    <div class="price">100,000<span>원</span></div>
                                    <p class="txt">*로그인 후 확인하세요</p>
                                    <% end if %>
                                </a>
                            </div>
                            <div class="section-04">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/bg_sub04.jpg" alt="" />
                            </div>
                            <div class="btn-area">
                                <button type="button" class="btn-detail">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/btn_01.jpg" alt="" />
                                    <span class="icon"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/icon_arrow.png" alt=""></span>
                                </button>
                                <div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/img_detail01.jpg" alt="" /></div>
                            </div>
                            <div class="btn-area">
                                <button type="button" class="btn-detail">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/btn_02.jpg" alt="" />
                                    <span class="icon"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/icon_arrow.png" alt=""></span>
                                </button>
                                <div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/img_detail02.jpg" alt="" /></div>
                            </div>
                            <div class="section-05">
                                <a href="/event/eventmain.asp?eventid=112115"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113211/bg_sub05.jpg" alt="" /></a>
                            </div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->