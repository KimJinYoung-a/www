<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 여름에 뭐 입지?
' History : 2020-06-08 이종화
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, eventStartDate, eventEndDate, currentDate, cnt, subscriptcount
IF application("Svr_Info") = "Dev" THEN
	eCode = "102182"
Else
	eCode = "103450"
End If
eventStartDate = cdate("2020-06-16")	'이벤트 시작일
eventEndDate = cdate("2020-06-23")		'이벤트 종료일
currentDate = date()

dim userid : userid = GetEncLoginUserID()

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
end if
%>
<style>
.shpbag-evt button {background-color:transparent;}
.shpbag-evt .topic {height:1070px; padding-top:110px; background:#009dd0 url(//webimage.10x10.co.kr/fixevent/event/2020/103450/bg_top.png) no-repeat 50% 50%; box-sizing:border-box;}
.shpbag-evt .topic h2 {margin-bottom:280px;}
.shpbag-evt .logout {margin-bottom:105px;}
.shpbag-evt .login {margin-bottom:30px; color:#000; font-size:25px; line-height:1;}
.shpbag-evt .login .txt b {color:#000fd9; font-weight:500;}
.shpbag-evt .login .price {margin-top:15px; margin-bottom:60px; font-size:28px;}
.shpbag-evt .login .price b {display:inline-block; margin-right:2px; color:#ec4800; font-size:44px; font-weight:800;}
.shpbag-evt .login .price span:after {display:inline-block; position:relative; top:-4px; left:8px; width:13px; height:13px; border-style:solid; border-width:2px 2px 0 0; border-color:#ec4800; transform:rotate(45deg); content:'';}
.shpbag-evt .lyr {display:flex; align-items:center; justify-content:center; position:fixed; top:0; left:0; z-index:1000; width:100vw; height:100vh; background-color:rgba(0,0,0,.65);}
.shpbag-evt .lyr .inner {position:relative;}
.shpbag-evt .lyr .btn-close {position:absolute; top:0; right:0; width:110px; height:110px;}
.shpbag-evt .way,
.shpbag-evt .bnr-area {background-color:#7ce1ff;}
.shpbag-evt .bnr-area {display:flex; justify-content:center; padding-bottom:60px;}
.shpbag-evt .noti {position:relative; background-color:#787878;}
.wish-list {padding:65px 0; background-color:#caf3ff;}
.wish-list ul {overflow:hidden; width:1140px; margin:0 auto; text-align:left;}
.wish-list ul li {float:left; padding:50px 0; height:380px; border-top:solid 1px #fff; color:#222;}
.wish-list ul li:nth-child(1),
.wish-list ul li:nth-child(2),
.wish-list ul li:nth-child(3),
.wish-list ul li:nth-child(4) {border-top:0;}
.wish-list ul li:nth-child(4n-3) a {margin-left:30px;}
.wish-list ul li:nth-child(4n) a {margin-right:30px;}
.wish-list ul li a {display:block; width:230px; margin:0 20px;}
.wish-list ul li a:hover {text-decoration:none;}
.wish-list .thumbnail {width:230px;}
.wish-list .thumbnail img {width:100%;}
.wish-list .desc {padding-left:5px;}
.wish-list .name {height:40px; margin-top:10px; font-size:15px; line-height:1.46;}
.wish-list .price {margin-top:13px; color:#222; font-size:20px; font-weight:bold;}
.wish-list .sale {color:#ff3232; font-size:15px;}
.wish-list .btn-bag {position:relative; width:100%; padding:13px 0; margin-top:16px; padding-right:16px; background-color:#009dd0; color:#fff; font-size:16px;}
.wish-list .btn-bag:after {display:inline-block; position: absolute; top:50%; right:58px; width:8px; height:8px; margin-top:-4px; border-width:0 1px 1px 0; border-color:#fff; border-style:solid; transform:rotate(-45deg); content:'';}
</style>
<script>
$(function(){
	// 팝업레이어
	$('.lyr .btn-close').click(function(){
		$(this).closest('.lyr').fadeOut();
	})
    
    <% If IsUserLoginOK() Then %>
        getCartTotalAmount();
    <% end if %>
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
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/do_103450.asp",
            data: {
                mode: 'add'
			},
			dataType : 'JSON',
            success: function(data){
                if(data.response == 'ok'){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>')                        
                    isApply = true
                    $("#btnImg").attr("src", "//webimage.10x10.co.kr/fixevent/event/2020/103450/btn_comp.png")
                    $('#lyrComp').show();		
                }else{
                    alert(data.message);
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% else %>
        jsEventLogin();
    <% end if %>
}

function getCartTotalAmount(){
    $.ajax({
        type: "GET",
        url:"/event/etc/doeventsubscript/do_103450.asp",
        data: {
            mode: 'cart'
		},
		dataType : 'JSON',
        success: function(data){
			if(data.response == 'ok'){
				(data.cartTotalAmount > 0) ? $("#totalAmount").text(data.cartTotalAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")) : $("#totalAmount").text("0");
            }else{
                alert(data.message)
            }
        },
        error: function(data){
            alert('시스템 오류입니다.')
        }
    })    
}
</script>
<div class="shpbag-evt evt103450">
	<div class="topic">
		<h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/tit_summer.png" alt="지금 실시간으로 위시를 받은 상품들!"></h2>
		<% if not IsUserLoginOK() then %>
		<div class="logout"><a href="javascript:jsEventLogin();"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/img_login_bfr.png" alt="로그인하고 확인하기"></a></div>
		<% else %>
		<div class="login">
			<div class="txt">
				<span><b><%=GetLoginUserName()%></b>님</span>의 장바구니 금액
			</div>
			<div class="price" onclick="window.location.href='/inipay/shoppingbag.asp'" style="cursor:pointer">
				<span><b id="totalAmount"></b> 원</span>
			</div>
			<img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/img_login_aftr.png" alt="장바구니 금액">
		</div>
		<% end if %>
		<% if not IsUserLoginOK() then %>
		<button class="btn-area" onclick="jsEventLogin()"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/btn_submit_on.png" alt="응모하기 활성화"></button>
		<% else %>
			<% if subscriptcount > 0 then %>
			<div class="btn-area"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/btn_comp.png" alt="응모완료"></div>
			<% else %>
			<button class="btn-area" onclick="doAction();"><img id="btnImg" src="//webimage.10x10.co.kr/fixevent/event/2020/103450/btn_submit_on.png" alt="응모하기 활성화"></button>
			<% end if %>
		<% end if %>
	</div>
	<%'!-- 팝업레이어 --%>
	<div class="lyr" id="lyrComp" style="display:none;">
		<div class="inner">
			<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/pop_txt.jpg" alt="20만원 상품 담기 성공!"></p>
			<button class="btn-close"></button>
		</div>
	</div>
	<div class="way"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/txt_way_v2.jpg" alt="참여방법 및 당첨 상품"></div>
	<% if currentdate >= "2020-06-18" Then %>
	<div class="bnr-area">
		<a href="/event/eventmain.asp?eventid=102776"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/img_bnr1.png" alt="판도라특가전"></a>
		<a href="/event/eventmain.asp?eventid=102902"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/img_bnr2.png" alt="여름의시작"></a>
	</div>
	<% End If %>
	<div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/txt_noti.png" alt="유의사항"></div>
	<%' wishlist %>
	<script type="text/javascript" src="/event/etc/template/wish/wishlist.js?v=1.01"></script>
	<div id="getWishList"></div>
	<%' wishlist %>
	<%'!-- 위시리스트 --%>
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