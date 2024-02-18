<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 마니또 장바구니 이벤트
' History : 2021-03-17 정태훈
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, eventStartDate, eventEndDate, currentDate, cnt, subscriptcount, mktTest
IF application("Svr_Info") = "Dev" THEN
	eCode = "104328"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
    eCode = "110079"
    mktTest = true
Else
	eCode = "110079"
    mktTest = false
End If
eventStartDate = cdate("2021-03-22")	'이벤트 시작일
eventEndDate = cdate("2021-03-28")		'이벤트 종료일
if mktTest then
currentDate = cdate("2021-03-22")
else
currentDate = date()
end if

dim userid : userid = GetEncLoginUserID()

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
end if

%>
<style>
.evt110079 {max-width:1920px; margin:0 auto;}
.evt110079 button {background-color:transparent;}
.evt110079 .topic {position:relative; width:100%; height:1331px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110079/img_main.jpg) no-repeat 50% 0;}

.evt110079 .topic .box-logout {position:absolute; left:50%; top:62%; transform:translate(-50%,0);}
.evt110079 .topic .box-logout a {display:inline-block; width:100%; height:100%;}
.evt110079 .topic .box-login {position:absolute; left:50%; top:62%; transform:translate(-50%,0);}
.evt110079 .topic .box-login .inner-info {position:relative; color:#fff; text-align:center;}
.evt110079 .topic .box-login .pos {position:absolute; top:40px; left:0; width:100%;}
.evt110079 .topic .box-login .txt {font-size:30px; font-weight:500;}
.evt110079 .topic .box-login .txt span b {color:#fff440;}
.evt110079 .topic .box-login .price {display:flex; align-items:center; justify-content:center; height:3.5rem; margin-top:0.8rem; line-height:1.2;}
.evt110079 .topic .box-login .price span {display:flex; align-items:center; justify-content:center; font-size:64px; font-weight:700; color:#fff;}
.evt110079 .topic .box-login .price img {margin-left:32px; vertical-align:baseline;}
.evt110079 .topic .box-login .go-link {display:inline-block; width:100%; height:100%; text-decoration:none;}
.evt110079 .topic button {position:absolute; left:50%; bottom:81px; transform:translate(-50%,0); background:transparent;}
.evt110079 .topic button.apply-off {pointer-events:none;}

.evt110079 .event-info {position:relative; width:100%; height:1257px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110079/img_sub01.jpg) no-repeat 50% 0;}
.evt110079 .event-info .icon-num {position:absolute; right:50%; bottom:350px; transform:translate(273%,0); animation:updown 1s ease-in-out alternate infinite;}

.evt110079 .noti .btn-noti {position:relative; width:100%; height:191px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110079/img_noti_top.jpg) no-repeat 50% 0;}
.evt110079 .noti .hidden-noti {display:none; width:100%; height:451px; margin-top:-5px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110079/img_noti.jpg) no-repeat 50% 0;}
.evt110079 .noti .hidden-noti.on {display:block;}
.evt110079 .noti .icon {position:absolute; left:50%; top:106px; margin-left:117px; transform:rotate(180deg);}
.evt110079 .noti .icon.on {transform:rotate(0);}

.evt110079 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
.evt110079 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
.evt110079 .pop-container .pop-inner a {display:inline-block;}
.evt110079 .pop-container .pop-inner .btn-close {position:absolute; right:28px; top:28px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110079/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
.evt110079  .pop-container.apply .contents-inner {width:671px; margin:0 auto; position:relative;}

.evt110079 .wish-list {padding:65px 0; background-color:#fff; font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif;}
.evt110079 .wish-list ul {overflow:hidden; width:1140px; margin:0 auto; text-align:left;}
.evt110079 .wish-list ul li {float:left; padding:50px 0 0; height:380px; border-top:solid 1px #fff;}
.evt110079 .wish-list ul li:nth-child(1),
.evt110079 .wish-list ul li:nth-child(2),
.evt110079 .wish-list ul li:nth-child(3),
.evt110079 .wish-list ul li:nth-child(4) {border-top:0;}
.evt110079 .wish-list ul li:nth-child(4n-3) a {margin-left:30px;}
.evt110079 .wish-list ul li:nth-child(4n) a {margin-right:30px;}
.evt110079 .wish-list ul li a {display:block; width:230px; margin:0 20px;}
.evt110079 .wish-list ul li a:hover {text-decoration:none;}
.evt110079 .wish-list .thumbnail {width:230px; height:230px; overflow:hidden;}
.evt110079 .wish-list .thumbnail img {width:100%;}
.evt110079 .wish-list .desc {padding-left:5px;}
.evt110079 .wish-list .name {height:40px; margin-top:10px; font-size:14px; line-height:1.46;}
.evt110079 .wish-list .price {margin-top:13px; color:#222; font-size:16px; font-weight:bold;}
.evt110079 .wish-list .sale {color:#fe3f3f; font-size:12px;}
.evt110079 .wish-list .btn-bag {position:relative; width:100%; margin-top:16px; width:100%; height:58px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110079/btn_wish.png) no-repeat 50% 0; background-size:contain;}
@keyframes updown {
    0% {transform: translate(273%,-5%);}
    100% {transform: translate(273%,10%);}
}
</style>
<script>
$(function(){
    $(".btn-noti").on("click",function(){
        $(".hidden-noti").toggleClass("on");
        $(".btn-noti > .icon").toggleClass("on");
    });
    //팝업
    /* 응모완료 팝업 */
    $('.evt110079 .btn-apply').click(function(){
        
    })
    /* 팝업 닫기 */
    $('.evt110079 .btn-close').click(function(){
        $(".pop-container").fadeOut();
    })
});
function jsEventLogin(){
	if(confirm("로그인 하시겠습니까?")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=" & eCode)%>';
		return;
	}
}
function doAction() {
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
    <% end if %>
    <% If IsUserLoginOK() Then %>
        <% if getCartTotalAmount(userid) < 300000 then %>
            alert('장바구니에 30만원 이상 상품을 채워주세요.');
            return false;
        <% else %>
            <% if subscriptcount > 0 then %>
                alert('이미 참여 하셨습니다.\n당첨자 발표일은 3월 31일 입니다.');
                return false;
            <% else %>
                var str = $.ajax({
                    type: "GET",
                    url:"/event/etc/doeventsubscript/doEventSubScript110079.asp",
                    data: "",
                    dataType: "text",
                    async: false
                }).responseText;	
                if(!str){alert("시스템 오류입니다."); return false;}
                var reStr = str.split("|");
                if(reStr[0]=="OK"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>')
                    $('.pop-container.apply').fadeIn();
                    return false;
                }else{
                    var errorMsg = reStr[1].replace(">?n", "\n");
                    alert(errorMsg);
                    return false;
                }
            <% end if %>
        <% end if %>
    <% else %>
        jsEventLogin();
    <% end if %>
}
</script>
						<div class="evt110079">
							<div class="topic">
								<% if not IsUserLoginOK() then %>
                                <div class="box-logout"><a href="javascript:jsEventLogin();"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110079/btn_logout.png" alt="로그인하고 확인하기"></a></div>
                                <% else %>
                                <!--로그인시-->
                                <div class="box-login">
                                    <div class="inner-info">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110079/btn_login.png" alt="장바구니 금액">
                                        <div class="pos">
                                            <div class="txt">
                                                <span><b><%=GetLoginUserName()%></b>님</span>의 장바구니 금액
                                            </div>
                                            <!-- 클릭시 장바구니 페이지로 랜딩 -->
                                            <a href="/inipay/shoppingbag.asp" class="go-link">
                                                <div class="price">
                                                    <span><b><%= FormatNumber(getCartTotalAmount(userid), 0) %></b> <span>원</span></span><img src="//webimage.10x10.co.kr/fixevent/event/2021/110079/icon_arrow02.png" alt="">
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <% end if %>
                                <% if subscriptcount > 0 then %>
                                    <button type="button" class="apply-off" disabled="disabled" onclick="alert('이미 응모 완료되었습니다. 3월 31일 당첨일을 기다려주세요!');"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110079/btn_apply_done.png" alt="응모완료"></button>
                                <% else %>
                                    <button type="button" class="btn-apply" onclick="doAction();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110079/btn_apply.png" alt="응모하기"></button>
                                <% end if %>
							</div>
							<div class="event-info">
                                <div class="icon-num"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110079/icon_num.png" alt="10명"></div>
                            </div>
                            <div class="noti">
                                <button type="button" class="btn-noti">
                                    <div class="icon"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110079/m/icon_arrow.png" alt=""></div>
                                </button>
                                <div class="hidden-noti">
                                </div>
                            </div>
							<!-- 위시리스트 -->
                            <script type="text/javascript" src="/event/etc/template/wish/wishlist_110079.js?v=1.01"></script>
							<div id="getWishList"></div>
                            <!-- 팝업 - 선물보기 -->
                            <div class="pop-container apply">
                                <div class="pop-inner">
                                    <div class="pop-contents">
                                        <div class="contents-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110079/pop_done.png" alt="30만원 담기 성공!">
                                            <button type="button" class="btn-close">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
						</div>
<form name="sbagfrm" method="post" action="" style="margin:0px;">
<input type="hidden" name="mode" value="add">
<input type="hidden" name="itemid" value="">
<input type="hidden" name="sitename" value="<%= session("rd_sitename") %>">
<input type="hidden" name="itemoption" value="0000">
<input type="hidden" name="userid" value="<%= getEncLoginUserId %>">
<input type="hidden" name="itemPrice" value="">
<input type="hidden" name="isPhotobook" value="">
<input type="hidden" name="isPresentItem" value="">
<input type="hidden" name="IsSpcTravelItem" value="">
<input type="hidden" name="itemRemain" id="itemRamainLimit" value="">
<input type="hidden" name="itemea" value="1" />
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->