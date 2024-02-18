<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 귀여움 저장소 이벤트
' History : 2021.04.29 정태훈 생성
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
	eCode = "105352"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "110972"
    mktTest = true    
Else
	eCode = "110972"
    mktTest = false
End If

if mktTest then
    currentDate = #05/03/2021 09:00:00#
else
    currentDate = date()
end if

eventStartDate = cdate("2021-05-03")		'이벤트 시작일
eventEndDate = cdate("2021-05-16")		'이벤트 종료일

userid = GetEncLoginUserID()

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
end if
%>
<style>
.evt110972{position: relative;overflow: hidden;}
.evt110972 .inner{width: 1140px;margin: 0 auto;position: relative;}
.evt110972 .topic{position: relative;background: url('//webimage.10x10.co.kr/fixevent/event/2021/110972/bg_top.jpg') center top repeat-x;}
.evt110972 .ani-txt{position: absolute;top: 192px;left: 50%;margin-left: -175px;animation: fade-in-top 1s linear both;}
.evt110972 .cont-how{position: relative;background: #4f34c3;}
.evt110972 .cont-how .btn-popopen{position: absolute;top: 285px;left: 60px;width: 275px;height: 75px;text-indent: -9999px;background:none;}
.evt110972 .cont-how .ani-heart{position:absolute;display: block;
background-image: url('//webimage.10x10.co.kr/fixevent/event/2021/110972/ico_heart.gif');
background-repeat: no-repeat;
background-position: 0 0;
background-size: cover;text-indent: -9999px;left: 50%;width: 27px;height: 23px;z-index: 10;top: 50%;left: 50%;margin-left: -110px;margin-top: 33px;}
.evt110972 .cont-how .ani-heart.active{background-position: center right;}
@keyframes fade-in-top {
	from {transform: translateY(-50px);opacity: 0;}
  to {transform: translateY(0);opacity: 1;}
}
.evt110972 .cont-btns li{width:100%;}
.evt110972 .cont-btns li a {display:block;}
.evt110972 .cont-btns li:first-child{text-align:center; background:#4ee1d1;}
.evt110972 .cont-btns li:first-child + li{text-align: left;background: #ffe812;}
.evt110972 .cont-notice{background: #10172a;}
.evt110972 .cont-wish {position:relative; background:#fff;}
.evt110972 .cont-wish .tit{padding: 100px 0 50px;}
.evt110972 .cont-wish .count {width:100%; position:absolute; left:50%; /*top:105px;*/ transform: translate(-50%,0); text-align:center;}
.evt110972 .cont-wish .count p {font-size:55px; color:#fff; line-height:normal;}
.evt110972 .cont-wish .count .num {font-weight:700; line-height:1;}
.evt110972 .view-wish {width:800px; margin:0 auto; background:#fff;}
.evt110972 .view-wish ul {overflow: hidden;}
.evt110972 .view-wish ul li {width:calc(100% / 4 - 26px); margin:0 13px 40px; float:left;}
.evt110972 .view-wish ul li a {display:inline-block; width:100%; text-decoration:none;}
.evt110972 .view-wish ul li .thum {width:100%; height:180px; background:#fff;}
.evt110972 .view-wish ul li .thum img {width:100%;}
.evt110972 .view-wish ul li .id {padding:10px 0 14px; font-size:13px; color:#000; text-align:right; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;}
.evt110972 .view-wish ul li .name {height:2.8rem; font-size:18px; color:#000; line-height:1.5rem; overflow:hidden; text-align:left; word-break: break-word;}
/* popup */
.layer-pop {position: fixed;left: 0;top: 0;bottom: 0;width: 100vw;height: 100vh;z-index: 9999;display: none;overflow-y: auto;}
.layer-pop .bg {position: fixed;left: 0;top: 0;width: 100vw;height: 100vh;z-index: 1;background: #000;opacity: 0.6;-ms-filter: 'progid:DXImageTransform.Microsoft.Alpha(Opacity=60)';filter: alpha(opacity=60);}
.layer-pop .pop-in {position: relative;margin: 0 auto;left: 0;width: 100%;z-index: 2;text-align: center;}
.layer-pop .pop-cont{position: relative;margin: 98px auto;width: 846px;}
.layer-pop .pop-in .close-pop {position: absolute;right: 1.7rem;top: 1.7rem;z-index: 40;width: 1.62rem;height: 1.62rem;background: url('//webimage.10x10.co.kr/fixevent/event/2021/110972/btn_close.png')no-repeat;background-size:cover;text-indent: -9999px;}
.layer-pop .pop-in .btn-apply{background:none;position: absolute;left: 50%;width: 350px;margin-left: -175px;bottom: 98px;}
</style>
<script>
$(function () {
    // 하트 on/off 
    function ani_heart() {
        $('.ani-heart').toggleClass('active');
    }
    setInterval(ani_heart, 600);
    // layer-pop close
    $('.close-pop').on('click', function () {
        $('.layer-pop').fadeOut();
    });
});

var numOfTry="<%=subscriptcount%>";
function doAction() {
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>
    <% If IsUserLoginOK() Then %>
        if(numOfTry == "1"){
			alert("이미 신청하셨습니다! 위시에 상품을 5개 이상 담으셨다면 자동으로 응모됩니다.");
			return false;
		};
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/doEventSubscript110972.asp",
            data: {
                mode: 'add'
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>')
                    $('.layer-pop').fadeIn();
                }else if(data.response == "retry"){
                    alert("이미 신청하셨습니다! 위시에 상품을 5개 이상 담으셨다면 자동으로 응모됩니다.");
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% else %>
        jsEventLogin();
        return false;
    <% end if %>
}

function jsEventLogin(){
    if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
        location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
        return;
    }
}

function fnGoToWishlist(){
    var offset = $("#wishlist").offset();
    $('html, body').animate({scrollTop : offset.top}, 400);
    $('.layer-pop').fadeOut();
}
</script>
              <div class="evt110972">
                <div class="topic">
                  <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/110972/tit_top.png" alt="귀여움 페스티벌"></h2>
                  <span class="ani-txt"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110972/ani_cute.png" alt="귀여움 저장소"></span>
                </div>
                <div class="cont-how">
                  <div class="inner">
                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2021/110972/tit_wish.png" alt="참여방법"></h3>
                    <button type="button" class="btn-popopen" onclick="doAction();">참여하기</button>
                    <span class="ani-heart">좋아요</span>
                  </div>
                </div>
                <!--<div class="cont-btns">
                  <ul>
                    <li><a href="/event/eventmain.asp?eventid=110936"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110972/btn_see.jpg?v=2.1" alt="귀여운 페스티벌 구경하기"></a></li>
                  </ul>
                </div> -->
                <div class="cont-notice">
                  <img src="//webimage.10x10.co.kr/fixevent/event/2021/110972/txt_notice.jpg" alt="유의사항">
                </div>
                <div class="cont-wish" id="wishlist">
                  <div class="tit">
                      <img src="//webimage.10x10.co.kr/fixevent/event/2021/110972/tit_wishlist.png" alt="위시리스트">
                  </div>
                  <!-- for dev msg : wish 상품 리스트 -->
                  <div id="app"></div>

                <div class="layer-pop apply">
                  <div class="bg"></div>
                  <div class="pop-in">
                    <div class="pop-cont">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/110972/pop_apply.png" alt="신청되었습니다.">
                    <button type="button" class="close-pop">닫기</button>
                    <button type="button" class="btn-apply" onclick="fnGoToWishlist();">
                      <img src="//webimage.10x10.co.kr/fixevent/event/2021/110972/btn_more.png" alt="담으러가기">
                    </button>
                    </div>
                  </div>
                </div>
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

<script src="/event/etc/vue/vue_110972.js"></script>
<!-- #include virtual="/lib/db/dbclose.asp" -->