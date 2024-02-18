<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 마니또가 대신 결제해드립니다.
' History : 2020.05.19 정태훈
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
	eCode = "102170"
Else
	eCode = "102808"
End If
eventStartDate = cdate("2020-05-20")	'이벤트 시작일
eventEndDate = cdate("2020-05-26")		'이벤트 종료일
currentDate = date()

dim userid : userid = GetEncLoginUserID()

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
end if

if userId="ley330" or userId="greenteenz" or userId="rnldusgpfla" or userId="cjw0515" or userId="thensi7" or userId = "motions" or userId = "jj999a" or userId = "phsman1" or userId = "jjia94" or userId = "seojb1983" or userId = "kny9480" or userId = "bestksy0527" or userId = "mame234" or userid = "corpse2" then
	currentDate = #05/20/2020 09:00:00#
end if
%>
<style>
.evt102808 button {background-color:transparent;}
.topic {height:1000px; padding-top:120px; background:#3ea3e4 url(//webimage.10x10.co.kr/fixevent/event/2020/102808/bg_top.jpg) no-repeat 50% 50%; box-sizing:border-box;}
.topic h2 {margin-bottom:340px;}
.non {margin-bottom:105px;}
.mem {margin-bottom:30px; color:#fff; font-size:25px; line-height:1;}
.mem .txt b {color:#11ff33;}
.mem .price {margin-top:15px; margin-bottom:45px; font-size:30px;}
.mem .price b {font-size:45px; font-weight:800;}
.mem .price span:after {display:inline-block; width:13px; height:13px; border-style:solid; border-width:2px 2px 0 0; border-color:#fff; transform:rotate(45deg); content:'';}
.lyr {display:flex; align-items:center; justify-content:center; position:fixed; top:0; left:0; z-index:1000; width:100vw; height:100vh; background-color:rgba(0,0,0,.85);}
.lyr .inner {position:relative;}
.lyr .btn-close {position:absolute; top:-8px; right:-8px; width:50px; height:50px;}
.way {background-color:#a2daff;}
.bnr-group {position:relative; background-color:#c68926; height:117px;}
.bnr-group:after {display:block; position:absolute; top:0; left:50%; z-index:1; width:50vw; height:100%; background-color:#702aff; content:'';}
.bnr-group img {position:relative; z-index:3;}
.noti {position:relative; background-color:#818181;}
.noti .btn-share {position:absolute; top:245px; left:50%; width:52px; height:52px; margin-left:410px; text-indent:-999em;}
.noti .btn-kakao {margin-left:465px;}
.wish-list {padding:65px 0; background-color:#e0f2ff; font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif;}
.wish-list ul {overflow:hidden; width:1140px; margin:0 auto; text-align:left;}
.wish-list ul li {float:left; padding:50px 0; height:380px; border-top:solid 1px #fff;}
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
.wish-list .name {height:40px; margin-top:10px; font-size:14px; line-height:1.46;}
.wish-list .price {margin-top:13px; color:#222; font-size:16px; font-weight:bold;}
.wish-list .sale {color:#fe3f3f; font-size:12px;}
.wish-list .btn-bag {position:relative; width:100%; padding:13px 0; margin-top:16px; padding-right:10px; background-color:#1b87ce; color:#fff; font-size:15px;}
.wish-list .btn-bag:after {display:inline-block; position: absolute; top:50%; right:58px; width:8px; height:8px; margin-top:-4px; border-width:0 1px 1px 0; border-color:#fff; border-style:solid; transform:rotate(-45deg); content:'';}
</style>
<script>
$(function(){
	// 팝업레이어
	$('.lyr .btn-close').click(function(){
			$(this).closest('.lyr').fadeOut();
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
        <% if getCartTotalAmount(userid) < 200000 then %>
            alert('장바구니에 20만원 이상 상품을 채워주세요.');
            return false;
        <% else %>
            <% if subscriptcount > 0 then %>
                alert('이미 참여 하셨습니다.\n당첨자 발표일은 5월 27일 입니다.');
                return false;
            <% else %>
                var str = $.ajax({
                    type: "GET",
                    url:"/event/etc/doeventsubscript/doEventSubScript102808.asp",
                    data: "",
                    dataType: "text",
                    async: false
                }).responseText;	
                if(!str){alert("시스템 오류입니다."); return false;}
                var reStr = str.split("|");
                if(reStr[0]=="OK"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>')
                    $('#lyrComp').show();
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
						<div class="evt102808">
							<div class="topic">
								<h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/tit_manito.png" alt="지금 실시간으로 위시를 받은 상품들!"></h2>
                                <% if not IsUserLoginOK() then %>
								<div class="box non"><a href="javascript:jsEventLogin();"><img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/img_login_bfr.png" alt="로그인하고 확인하기"></a></div>
                                <% else %>
								<div class="box mem">
									<div class="txt">
										<span><b><%=GetLoginUserName()%></b>님</span>의 장바구니 금액
									</div>
									<div class="price" onclick="window.location.href='/inipay/shoppingbag.asp'" style="cursor:pointer">
										<span><b><%= FormatNumber(getCartTotalAmount(userid), 0) %></b> 원</span>
									</div>
									<img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/img_login_aftr.png" alt="장바구니 금액">
								</div>
                                <% end if %>
                                <% if not IsUserLoginOK() then %>
								<div class="btn-area"><img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/btn_submit_off.png" alt="응모하기 비활성화"></div>
                                <% else %>
								    <% if subscriptcount > 0 then %>
                                    <div class="btn-area"><a href="javascript:alert('이미 응모 완료되었습니다. 5월 27일 당첨일을 기다려주세요!');"><img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/btn_comp.png" alt="응모완료"></a></div>
                                    <% else %>
								    <button class="btn-area btn-submit" onclick="doAction();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/btn_submit_on.png" alt="응모하기 활성화"></button>
                                    <% end if %>
                                <% end if %>
							</div>
							<!-- 팝업레이어 -->
							<div class="lyr lyr-fin" id="lyrComp" style="display:none;">
								<div class="inner">
									<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/pop_txt.png" alt="20만원 상품 담기 성공!" usemap="#image-map"></p>
									<button class="btn-close"></button>
									<map name="image-map">
										<area alt="best셀러로 이동" href="/award/awardlist.asp" coords="161,499,714,564" shape="rect">
									</map>
								</div>
							</div>
							<div class="way"><img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/txt_way.jpg" alt="지금 실시간으로 위시를 받은 상품들!"></div>
							<div class="bnr-group">
								<a href="/event/eventmain.asp?eventid=102358"><img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/img_bnr1.jpg" alt=""></a>
								<a href="/event/eventmain.asp?eventid=102582"><img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/img_bnr2.jpg" alt=""></a>
							</div>
							<div class="noti">
								<img src="//webimage.10x10.co.kr/fixevent/event/2020/102808/img_noti.jpg?v=1.03" alt="유의사항">
							</div>
                            <%' wishlist %>
                            <script type="text/javascript" src="/event/etc/template/wish/wishlist.js?v=1.01"></script>
                            <div id="getWishList"></div>
                            <%' wishlist %>
							<!-- 위시리스트 -->
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