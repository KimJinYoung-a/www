<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 스냅스 사진을 보다가 WWW
' History : 2016.05.20 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, currenttime, subscriptcoun, totalcnt, subscriptcount, systemok, evtUserCell
	IF application("Svr_Info") = "Dev" THEN
		eCode = "66135"
	Else
		eCode = "70839"
	end if

currenttime = now()
'															currenttime = #05/20/2016 10:05:00#

userid = GetEncLoginUserID()
evtUserCell = get10x10onlineusercell(userid) '// 참여한 회원 핸드폰번호


subscriptcount=0
'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
end if

totalcnt = getevent_subscripttotalcount(eCode, "", "", "")

''응모 차단시 X로 변경
	'systemok="X"
	systemok="O"

if left(currenttime,10)<"2016-05-23" then
	systemok="X"
	if userid = "baboytw" or userid = "greenteenz" then
		systemok="O"
	end if
end if

%>
<style type="text/css">
img {vertical-align:top;}

.snaps {width:1140px; margin:0 auto;}

.topic {position:relative;}
.topic h2 {position:absolute; top:89px; left:50%; width:585px; height:191px; margin-left:-292px;}
.topic h2 span {position:absolute; left:50%;}
.topic h2 .letter1 {top:0; margin-left:-127px;}
.topic h2 .letter2 {bottom:0; margin-left:-292px;}

.rolling {position:relative;}
.slide {position:relative;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:253px; width:90px; height:90px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70839/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:107px;}
.slide .slidesjs-next {right:107px; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:241px; left:50%; z-index:10; width:96px; margin-left:-48px;}
.slidesjs-pagination li {float:left; margin:0 7px;}
.slidesjs-pagination li a {display:block; width:10px; height:10px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70839/btn_pagination.png) no-repeat 50% 0; transition:0.5s ease; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:50% 100%;}
.rolling .btnGet {position:absolute; top:797px; right:142px;}

.lyView {display:none; position:fixed; top:50%; left:50%; z-index:105; width:401px; height:486px; margin-top:-243px; margin-left:-200px;}
.lyView .btnClose {position:absolute; top:3px; right:10px; background-color:transparent;}
.lyView .phone {position:absolute; bottom:55px; left:37px; width:314px;}
.lyView .phone span {display:block; width:222px; height:42px; background-color:#f8f8f8; color:#000; font-family:'Verdana'; font-size:20px; line-height:42px;}
.lyView .phone .btnmodify {position:absolute; top:0; right:0;}
#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68354/bg_mask.png);}

.noti {position:relative; padding:33px 0 32px; background-color:#384669; text-align:left;}
.noti h3 {position:absolute; top:50%; left:101px; margin-top:-12px;}
.noti ul {margin-left:356px; padding-left:70px; border-left:1px solid #4e6293;}
.noti ul li {position:relative; margin-top:7px; padding-left:10px; color:#fff; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#fff;}
.noti ul li .btnGrade {margin-left:11px;}
.noti ul li .btnGrade img {margin-top:-3px; vertical-align:top;}

@keyframes flip {
	0% {transform:rotateY(0deg); animation-timing-function:ease-out;}
	100% {transform:rotateY(360deg); animation-timing-function:ease-in;}
}
.flip {animation-name:flip; animation-duration:1.2s; animation-iteration-count:1; backface-visibility:visible;}
</style>
<script type="text/javascript">
$(function(){
	animation();
	$("#animation span").css({"opacity":"0"});
	$("#animation .letter2").css({"margin-bottom":"5px", "opacity":"0"});
	function animation() {
		$("#animation .letter1").delay(100).animate({"opacity":"1",},100);
		$("#animation .letter1 img").addClass("flip");
		$("#animation .letter2").delay(700).animate({"margin-bottom":"0", "opacity":"1",},600);
	}

	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"759",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1200}},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$("#lyView .btnClose, #dimmed").click(function(){
		$("#lyView").hide();
		$("#dimmed").fadeOut();
	});
});

function jsevtgo(e){
<% if systemok = "O" then %>
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-05-20" and left(currenttime,10)<"2016-05-30" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount > 0 then %>
				alert('이미 신청 하셨습니다.');
				return;
			<% else %>
				var str = $.ajax({
					type: "POST",
					url: "/event/etc/doeventsubscript/doEventSubscript70839.asp",
					data: "mode=evtgo",
					dataType: "text",
					async: false
				}).responseText;
				var str1 = str.split("||")
				if (str1[0] == "11"){
					var wrapHeight = $(document).height();
					$("#lyView").show();
					$("#dimmed").show();
					$("#dimmed").css("height",wrapHeight);
					return false;
				}else if (str1[0] == "01"){
					alert('잘못된 접속입니다.');
					return false;
				}else if (str1[0] == "02"){
					alert('로그인을 해야\n이벤트에 참여할 수 있어요.');
					return false;
				}else if (str1[0] == "03"){
					alert('이벤트 기간이 아닙니다.');
					return false;		
				}else if (str1[0] == "04"){
					alert('이미 신청 하셨습니다.');
					return false;
				}else if (str1[0] == "00"){
					alert('정상적인 경로가 아닙니다.');
					return false;
				}else{
					alert('오류가 발생했습니다.');
					return false;
				}
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
<% else %>
	alert('잠시 후 다시 시도해 주세요!!');
	return;
<% end if %>
}
</script>
	<!-- [W] 70839 스냅스 이벤트 - 사진을 보다가 -->
	<div class="evt70839 snaps">
		<div class="topic">
			<h2 id="animation">
				<span class="letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/tit_snaps_01.png" alt="텐바이텐과 스냅스 콜라보레이션" /></span>
				<span class="letter2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/tit_snaps_02.png" alt="사진을 보다가" /></span>
			</h2>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/txt_snaps.jpg" alt="스냅스 포토북을 무료로 이용할 수 있는 쿠폰을 선착순으로 드립니다!" /></p>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/txt_intro.jpg" alt="이렇게 사랑스러운 포토북을 본 적 있나요? 소중한 추억을 누구보다 예쁘게 간직하세요!" /></p>
		</div>

		<div class="rolling">
			<div id="slide" class="slide">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/img_slide_01.jpg" alt="스냅스 포토북 11,900원이 0원! 선착순 한정수량" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/img_slide_02.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/img_slide_03.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/img_slide_04.jpg" alt="" /></div>
			</div>

			<a href="#lyView" id="btnGet" onclick="jsevtgo(); return false;" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/btn_get.png" alt="포토북 신청하기" /></a>

			<div id="lyView" class="lyView">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/txt_done.png" alt="스냅스 포토북 신청이 완료되었습니다! * 쿠폰은 다음날 SMS를 통해 발송될 예정입니다. * 개인정보에 있는 휴대폰 번호를 확인해 주세요!" /></p>
				<div class="phone">
					<span><%= evtUserCell %></span>
					<a href="/my10x10/userinfo/confirmuser.asp" class="btnmodify"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/btn_modify.png" alt="수정" /></a>
				</div>
				<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/btn_close.png" alt="레이어팝업 닫기" /></button>
			</div>

			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/txt_way.png" alt="이벤트 참여 방법은 포토북 신청한 후 다음날 SMS를 확인하신 후 스냅스에서 쿠폰을 사용하세요" /></p>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/txt_coupon.jpg" alt="쿠폰 등록 방법은 스냅스앱을 실행 후 좌측 메뉴의 쿠폰관리에서 텐바이텐 쿠폰 선택 후 쿠폰번호를 등록하시면 됩니다. 포토북을 선택하고 원하는 디자인을 선택한 후, 6x6 사이즈 소프트커버 선택 합니다. 옵션 변경 및 페이지 추가 시 추가 비용 발생합니다. 편집 후 장바구니 담기 후 주문 결제 시, 쿠폰 적용을 하시면 쿠폰을 사용 하실 수 있습니다." /></p>
		</div>

		<div class="noti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70839/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li><span></span>본 이벤트는 ID 당 1회만 신청이 가능하며, 발급받은 쿠폰은 모바일 기기당 1개만 사용 가능합니다.</li>
				<li><span></span>이벤트는 상품 품절 시 조기 마감 될 수 있습니다. (이용권 유효기간 : 2016. 6. 5까지 )</li>
				<li><span></span>스냅스 앱에서 쿠폰번호 등록 후 바로 사용 가능합니다.</li>
				<li><span></span>6X6 포토북 이용권은 모바일 전용상품으로 스냅스 앱에서만 사용 가능합니다.</li>
				<li><span></span>본 이용권은 포토북 6X6/소프트커버/기본21p 무료 이용권이며, 페이지 추가 및 커버 변경 시, 추가 비용이 발생됩니다.</li>
				<li><span></span>5만원 미만 상품 주문 시, 별도의 배송료가 추가 됩니다.</li>
			</ul>
		</div>

		<div id="dimmed"></div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->