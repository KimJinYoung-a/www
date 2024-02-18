<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 이왕 이렇게 된 거! 코멘트 이벤트
' History : 2021.07.22 정태훈 생성
'####################################################
%>
<style>
.evt113090 {position:relative; overflow:hidden;}
.evt113090 .topic { width:100%; height:702px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113090/bg_main.jpg) no-repeat 50% 0; }
.evt113090 .sub-01 { width:100%; height:876px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113090/bg_sub.jpg) no-repeat 50% 0; }
.evt113090 .sub-02 { width:100%; height:906px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113090/bg_sub02.jpg) no-repeat 50% 0; }
.evt113090 .sub-03 { width:100%; height:331px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113090/bg_kakao.jpg) no-repeat 50% 0; position:relative; }
.evt113090 .sub-03 a {width:100%; height:100%; display:inline-block; left:0; top:0;}
.evt113090 .section-01  { width:100%; height:576px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113090/bg_push.jpg) no-repeat 50% 0; position:relative;}
.evt113090 .section-01 .link-wrap {position:absolute; display:flex; justify-content:space-between; flex-wrap:wrap; width:1106px; height:355px; top:116px; left:50%; margin-left:-553px;}
.evt113090 .section-01 .link-wrap .push-wrap { width:49%; height:160px; position:relative; }
.evt113090 .section-01 .link-wrap .push-wrap .event-btn {position:absolute; bottom:0; left:50%; margin-left:17%; width:180px; height:160px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113090/btn_start.png) no-repeat 0 0; background-size:100%; text-indent:-9999px; }
.evt113090 .section-01 .link-wrap .push-wrap .event-btn.end {position:absolute; bottom:0; left:50%; margin-left:17%; width:180px; height:160px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113090/btn_end.png) no-repeat 0 0; background-size:100%; text-indent:-9999px; }
.evt113090 .section-01 .link-wrap .push-wrap .push-dim { display:none; position:absolute; background-color:rgba(0, 0, 0,0.6); z-index:10; width:100%; height:100%; top:0; left:0;}

.evt113090 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(0, 0, 0,0.6); z-index:150; overflow-y:auto;}
.evt113090 .pop-contents {position:relative; left:50%; top:50%; transform:translate(-50%, -50%);}
.evt113090 .pop-contents .btn-close {width:94px; height:94px; position:absolute; top:0; left:50%; margin-left:242px; text-indent:-9999px; background:transparent;}
.evt113090 .pop-contents .btn-push {width:330px; height:80px; position:absolute; bottom:15%; left:50%; margin-left:-160px;  text-indent:-9999px; background:transparent; }

.evt113090 .prd-wrap { position:relative;}
.evt113090 .prd-wrap .first-item {position:absolute; top:160px; left:50%; margin-left:-762px; width:1340px; height:570px; }
.evt113090 .prd-wrap .first-item a {width:100%; height:100%; display:inline-block;}
.evt113090 .prd-wrap .sub-item {position:absolute; top:815px; left:50%; margin-left:-596px; width:1186px; height:370px; display:flex; justify-content:space-between;}
.evt113090 .prd-wrap .sub-item a {width:286px; height:100%; display:inline-block;  }

.evt113090 .section-02 { width:100%; height:1393px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113090/bg_item01.jpg) no-repeat 50% 0;}
.evt113090 .section-03 { width:100%; height:1365px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113090/bg_item02.jpg) no-repeat 50% 0;}
.evt113090 .section-04 { width:100%; height:1336px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113090/bg_item03.jpg) no-repeat 50% 0;}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script>
$(function(){
    // 팝업
     $('.evt113090 .event-btn').on('click', function () {
      $('.pop-container').fadeIn();
    });
  
    // 팝업 닫기
      $('.evt113090 .btn-close').on('click', function () {
      $('.pop-container').fadeOut();
    });
});
</script>
        				<div class="evt113090">
                            <div class="topic"></div>
                            <div class="sub-01"></div>
                            <!-- push 알림 영역 -->
							 
                            <div class="sub-02"></div>      
                            <div class="section-02 prd-wrap">
                                <div class="first-item">
                                    <a href="/shopping/category_prd.asp?itemid=3132568&petr=113090"></a>
                                </div>
                                <div class="sub-item">
                                    <a href="/shopping/category_prd.asp?itemid=3747619&petr=113090"></a>
                                    <a href="/shopping/category_prd.asp?itemid=3784999&petr=113090"></a>
                                    <a href="/shopping/category_prd.asp?itemid=3499091&petr=113090"></a>
                                    <a href="/shopping/category_prd.asp?itemid=3608355&petr=113090"></a>
                                </div>
							</div>
                            <div class="section-03 prd-wrap">
                                <div class="first-item">
                                    <a href="/shopping/category_prd.asp?itemid=3958412&petr=113090"></a>
                                </div>
                                <div class="sub-item">
                                    <a href="/shopping/category_prd.asp?itemid=3784998&petr=113090"></a>
                                    <a href="/shopping/category_prd.asp?itemid=3132575&petr=113090"></a>
                                    <a href="/shopping/category_prd.asp?itemid=2503440&petr=113090"></a>
                                    <a href="/shopping/category_prd.asp?itemid=2503448&petr=113090"></a>
                                </div>
							</div>
                            <div class="section-04 prd-wrap">
                                <div class="first-item">
                                    <a href="/shopping/category_prd.asp?itemid=3935851&petr=113090"></a>
                                </div>
                                <div class="sub-item">
                                    <a href="/shopping/category_prd.asp?itemid=3910242&petr=113090"></a>
                                    <a href="/shopping/category_prd.asp?itemid=3796624&petr=113090"></a>
                                    <a href="/shopping/category_prd.asp?itemid=3747616&petr=113090"></a>
                                    <a href="/shopping/category_prd.asp?itemid=2967384&petr=113090"></a>
                                </div>
							</div>
                            <div class="sub-03">
                                <a href="/street/street_brand_sub06.asp?makerid=kakaofriends1010"></a>
                            </div>
						</div>