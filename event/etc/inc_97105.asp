<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 이벤트 위시리스트
' History : 2019-09-05 이종화 
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, currentDate , subscriptcount , eventStartDate , eventEndDate
IF application("Svr_Info") = "Dev" THEN
	eCode = "90381"
Else
	eCode = "97105"
End If

eventStartDate = cdate("2019-09-05")	'이벤트 시작일
eventEndDate = cdate("2019-09-18")		'이벤트 종료일
currentDate = date()

userid = GetEncLoginUserID()

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
end if

'공유관련
'// 쇼셜서비스로 글보내기 
Dim strPageTitle, strPageDesc, strPageUrl, strHeaderAddMetaTag, strPageImage, strPageKeyword
Dim strRecoPickMeta		'RecoPick환경변수
Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[달님 소원을 들어주세요!]")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/97105/m/img_bnr_kakao.jpg")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[달님 소원을 들어주세요!]"
strPageKeyword = "달님 소원을 들어주세요!"
strPageDesc = "100만원 이상 상품을 장바구니에 담으면 달님이 대신 결제해드립니다!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/97105/m/img_bnr_kakao.jpg"
%>
<style>
.evt97105 {background:#c4caec url(//webimage.10x10.co.kr/fixevent/event/2019/97105/bg_evt.jpg) repeat-x 50% 0;}
.evt97105 button {background-color:transparent;}
.top {position: relative;}
.top:after,
.top:before {position: absolute; top:0; left:50%; width:100%; height: 100%; margin-left:-50%; background:url(//webimage.10x10.co.kr/fixevent/event/2019/97105/img_star1.png) repeat-x 50% 0; content:'';  opacity:0; animation-name:twinkle1; animation-duration:1.8s; animation-iteration-count:infinite; animation-delay:1s;}
.top:after {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97105/img_star2.png); animation-delay:1.5s;}
.top .thumb-moon {overflow:hidden; display: inline-block; width:432px; height:432px; margin-top:37px;}
.top .thumb-moon img {margin-top:432px; transition:all 1.2s;}
.top .thumb-moon.rise img {margin-top:0;}
.top h2 {margin-top:-58px;}
.top .num {position:absolute; top:380px; left:50%; margin-left:148px; animation:.5s swing ease-in-out infinite alternate; transform-origin:50% 100%;}
.top .btn-apply {position:relative; z-index:10; margin-top:32px; animation-name:pulse; animation-duration:1.2s; animation-fill-mode:both; animation-iteration-count:infinite;}
@keyframes pulse { 0% {transform:scale(1);} 50% {transform:scale(0.8);} 100% {transform:scale(1);} }
@keyframes twinkle1 { from,to {opacity:.2;} 50% {opacity:1;} }
@keyframes swing { 0% {transform:rotate(7deg);} 100% {transform:rotate(-7deg);} } .conts .way {margin:205px 0 90px;}
.conts .tip {margin-top:250px;}
.conts .tip .evt {position: relative;  width:908px; height:117px; margin:35px auto 32px;}
.tip .evt ul {display:flex; position: absolute; top:0; left:0; width:100%; height:100%;}
.tip .evt ul li {flex-basis:50%;}
.tip .evt ul li a {display: block; width:100%; height:100%; text-indent:-999em;}
.layer {position:fixed; left:50% !important; top:50% !important; z-index:99999; width:661px; margin:-276px 0 0 -330px; line-height:0;}
.layer .btn-close {display:block; position:absolute; left:50%; top:15px; width:48px; height:48px; margin-left:270px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/97105/btn_close.png) no-repeat 0 0; text-indent:-999em; outline:none;}
.layer .evt {position: relative;}
.noti {display:flex; align-items:center; width:1140px; margin:0 auto; padding:40px 0; font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif;}
.noti h3 {width:280px; text-align:right;}
.noti ul {width:860px; padding-left:75px; text-align:left;}
.noti ul li {margin:13px 0; color:#2e3365; font-size:14px; font-weight:bold; text-indent:-10px; padding-left:10px;}
.noti ul li strong {text-decoration:underline;}
.wish-list {padding:65px 0; background-color:#f6f7fc; font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif;}
.wish-list ul {overflow:hidden; width:1140px; margin:0 auto; text-align:left;}
.wish-list ul li {float:left; padding:50px 0; height:380px; border-top:solid 1px #e5e7f1;}
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
.wish-list .btn-bag {position:relative; width:100%; padding:13px 0; margin-top:16px; padding-right:10px; background-color:#2e3365; color:#fff; font-size:15px;}
.wish-list .btn-bag:after {display:inline-block; position: absolute; top:50%; right:58px; width:8px; height:8px; margin-top:-4px; border-width:0 1px 1px 0; border-color:#fff; border-style:solid; transform:rotate(-45deg); content:'';}
</style>
<script type="text/javascript">
$(function(){
    $('.thumb-moon').addClass('rise');
});

function jsEventLogin(){
	if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}

function doAction() {
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
    <% end if %>
    <% If IsUserLoginOK() Then %>
        <% if subscriptcount > 0 then %>
            alert('이미 참여 하셨습니다.\n장바구니에 100만원 이상 상품을 채워주세요.\n당첨자 발표일은 9월 20일 입니다.');
            return false;
        <% else %>
            var str = $.ajax({
                type: "GET",
                url:"/event/etc/doeventsubscript/doEventSubscript97105.asp",
                data: "",
                dataType: "text",
                async: false
            }).responseText;	
            if(!str){alert("시스템 오류입니다."); return false;}
            var reStr = str.split("|");
            if(reStr[0]=="OK"){
                fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>')
                viewPoupLayer('modal',$('#lyrComp').html());
                return false;
            }else{
                var errorMsg = reStr[1].replace(">?n", "\n");
                alert(errorMsg);
                return false;
            }
        <% end if %>
    <% else %>
        jsEventLogin();
    <% end if %>
}

function snschk() {
	popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
}
</script>
<div class="evt97105">
    <div class="top">
        <span class="thumb-moon"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/img_moon.png" alt=""></span>
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/tit_moon.png?v=1.01" alt="달님 소원을 들어주세요!"></h2>
        <span class="num"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/txt_num.png" alt="10명"></span>
        <button type="button" class="btn-apply" onclick="doAction();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/btn_apply.png?v=1.01" alt="참여하기"></button>

        <%'!-- 응모 완료 레이어 --%>
        <div id="lyrComp" style="display:none;">
            <div class="layer">
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/txt_comp.jpg?v=1.01" alt="신청되었습니다! 이제 장바구니를 채우면 자동 응모됩니다. 100만원이상 장바구니에 상품을 담아주세요!" /></p>
                <div class="tip">
                        <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/txt_tip2.png" alt="장바구니 간단하게 채우는 방법! " /></p>
                        <div class="evt">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/img_evt2.png" alt="">
                            <ul>
                                <li><a href="/event/eventmain.asp?eventid=91839">텐바이텐은 처음이지?</a></li>
                                <li><a href="/event/eventmain.asp?eventid=97011">두근두근 새출발 집꾸미기</a></li>
                            </ul>
                        </div>
                </div>
                <button type="button" class="btn-close" onclick="ClosePopLayer()">닫기</button>
            </div>
        </div>
        <%'!--// 응모 완료 레이어 --%>
    </div>
    <div class="conts">
        <div class="way"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/txt_way.png" alt="참여 방법  신청하기 버튼을 클릭한 후 상품을 100만 원 이상 장바구니에 담는다 당첨일 9월 20일을 기다린다!"></div>
        <div class="prize"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/txt_prize.png?v=1.02" alt="소원을 들어주는 기프트카드 100만 원 권 (10명)"></div>
        <div class="tip">
            <p class="tit"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/tit_tip.png" alt="장바구니를 쉽게 채우는 방법"></p>
            <div class="evt">
                <img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/img_evt.png" alt="">
                <ul>
                    <li><a href="/event/eventmain.asp?eventid=91839">텐바이텐은 처음이지?</a></li>
                    <li><a href="/event/eventmain.asp?eventid=97011">두근두근 새출발 집꾸미기</a></li>
                </ul>
            </div>
        </div>
        <div class="fb">
            <a href="javascript:snschk();"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/btn_fb.png" alt="친구들에게 이벤트 소문내기"></a>
        </div>
    </div>
    <div class="noti">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/97105/tit_noti.png" alt="유의사항"></h3>
        <ul>
            <li>- 모바일에서 장바구니 버튼은 상품 '구매하기' 버튼을 클릭했을 때 확인할 수 있습니다.</li>
            <li>- 이벤트 기간은 9월 6일(금)부터 9월 18일(수) 자정까지입니다.</li>
            <li>- 장바구니에 담은 모든 상품의 결제 금액(상품 총금액 + 배송비)이 <strong>1,000,000원 이상이면 자동 응모되며, <br>최대 금액은 제한이 없습니다.</strong></li>
            <li>- <strong>9월 18일 자정 기준</strong>으로 1,000,000원 이상이어야 합니다.</li>
            <li>- 당첨자는 9월 20일 공지사항에 기재 및 개별 연락드릴 예정입니다.</li>
            <li>- 당첨자 10분에게는 텐바이텐에서 사용 가능한 기프트카드 1,000,000원 권이 지급됩니다.</li>
            <li>- 당첨자에게는 세무신고를 위해 개인정보를 요청할 예정이며, 제세공과금은 텐바이텐 부담입니다.</li>
        </ul>
    </div>
    <%' wishlist %>
    <script type="text/javascript" src="/event/etc/template/wish/wishlist.js?v=1.01"></script>
    <div id="getWishList"></div>
    <%' wishlist %>
<form name="sbagfrm" method="post" action="" style="margin:0px;">
<input type="hidden" name="mode" value="add">
<input type="hidden" name="itemid" value="">
<input type="hidden" name="sitename" value="<%= session("rd_sitename") %>">
<input type="hidden" name="itemoption" value="0000">
<input type="hidden" name="userid" value="<%= getEncLoginUserId %>">
<input type="hidden" name="itemPrice" value="">
<input type="hidden" name="isPhotobook" value="">
<input type="hidden" name="isPresentItem" value="">
<input type="hidden" name="IsSpcTravelItem" value="">1
<input type="hidden" name="itemRemain" id="itemRamainLimit" value="">
<input type="hidden" name="itemea" value="1" />
</form>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->