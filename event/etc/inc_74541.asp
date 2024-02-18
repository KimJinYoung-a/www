<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 그린 크리스박스-이니스프리
' History : 2016-11-23 유태욱 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim eCode, userid

IF application("Svr_Info") = "Dev" THEN
	eCode = "66243"
Else
	eCode = "74541"
End If

userid = getEncLoginUserID

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] 그린 크리스박스")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=74541")
snpPre		= Server.URLEncode("10x10 크리스박스 이벤트")

%>
<style type="text/css">
#contentWrap {padding-bottom:0;}

.greenChrisbox img {vertical-align:top;}
.greenChrisbox button {background-color:transparent;}

.greenChrisbox .event {background:#1b6242 url(http://webimage.10x10.co.kr/eventIMG/2016/74541/bg_green.png) repeat 0 0;}
.greenChrisbox .event .inner {position:relative; height:952px; padding-top:129px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74541/bg_green_chrisbox.jpg) no-repeat 50% 0;}
.greenChrisbox .event .hgroup {position:relative; width:1140px; height:188px; margin:0 auto;}
.greenChrisbox .event .hgroup p {margin-top:9px;}
.greenChrisbox .event .hgroup .star {position:absolute; top:42px; left:638px;}
.greenChrisbox .event .hgroup .star2 {left:791px;}
.greenChrisbox .event .hgroup .star1 {animation-name:twinkle1; animation-iteration-count:infinite; animation-duration:3s; animation-fill-mode:both;}
.greenChrisbox .event .hgroup .star2 {animation-name:twinkle2; animation-iteration-count:infinite; animation-duration:3s; animation-fill-mode:both;}
@keyframes twinkle1 {
	0% {opacity:0.3;}
	50% {opacity:1;}
	100% {opacity:0.3;}
}
@keyframes twinkle2 {
	0% {opacity:1;}
	50% {opacity:0.3;}
	100% {opacity:1;}
}

.greenChrisbox .event .date {position:absolute; top:50px; left:50%; margin-left:-594px;}

.greenChrisbox .event .item {position:relative; width:1140px; margin:0 auto;}
.greenChrisbox .event .item .figure {overflow:hidden;}
.greenChrisbox .event .item .btnView {display:block; position:absolute; top:67px; right:113px; width:157px; height:106px; padding:94px 0 0 43px; text-align:left;}
.greenChrisbox .event .item .btnView .plus img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1s; transition:transform .7s ease;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.greenChrisbox .event .item .btnView .word {position:absolute; top:67px; left:85px;}
.greenChrisbox .event .item .btnView .plus img {transition:transform .7s ease;}
.greenChrisbox .event .item .btnView:hover .plus img {transform:rotate(-360deg);}

.greenChrisbox .event .item .btnGet {position:absolute; left:50%; top:538px; margin-left:-260px;}
.greenChrisbox .event .item .btnGet:hover img {animation-name:moveUp; animation-iteration-count:infinite; animation-duration:0.7s;}
@keyframes moveUp {
	from, to{transform:translateY(5px); animation-timing-function:ease-out;}
	50% {transform:translateY(0); animation-timing-function:ease-in;}
}

.greenChrisbox .event .item .random {position:absolute; left:50%; top:660px; margin-left:-168px;}

.lyContent {display:none; position:fixed; top:50%; left:50%; z-index:105; width:906px; height:807px; margin:-403px 0 0 -453px;}
.lyContent .btnClick, 
.lyContent .btnDownload {position:absolute; bottom:77px; left:50%; margin-left:-161px;}
.lyContent .btnDownload {bottom:110px;}
.lyContent .btnClose {position:absolute; top:57px; right:67px;}
.lyContent .btnClose img {transition:transform .7s ease;}
.lyContent .btnClose:active img {transform:rotate(-180deg);}
#lyWin {width:504px; height:552px; margin:-252px 0 0 -276px;}
#lyWin .btnClose {top:43px; right:48px;}
#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74541/bg_mask_blank_40.png);}

.greenChrisbox .innisfree {padding-top:10px; background:#bb2b15 url(http://webimage.10x10.co.kr/eventIMG/2016/74541/bg_pattern_wave.jpg) repeat-x 0 0;}
.greenChrisbox .innisfree .outer {padding-bottom:40px; background:#bb2b15 url(http://webimage.10x10.co.kr/eventIMG/2016/74541/bg_light.jpg) no-repeat 50% 0;}
.greenChrisbox .innisfree .inner {width:1140px; margin:0 auto; padding-top:85px;}
.greenChrisbox .innisfree .group {overflow:hidden;}
.greenChrisbox .innisfree .group .desc {float:left; width:449px;}
.greenChrisbox .innisfree .group .campaign {padding:60px 99px 0 18px;}
.greenChrisbox .innisfree .group .campaign .btnMore {display:block; width:214px; margin:27px auto 0;}
.greenChrisbox .innisfree .group .video {width:574px;}
.greenChrisbox .innisfree .group .video iframe {padding:8px; background-color:#e8462f;}
.greenChrisbox .innisfree .group + p {margin-top:65px; margin-left:-5px;}

.noti {padding:34px 0 35px; background-color:#681b10;}
.noti .inner {position:relative; width:1140px; margin:0 auto; text-align:left;}
.noti h3 {position:absolute; top:50%; left:90px; margin-top:-40px;}
.noti ul {margin-left:302px;}
.noti ul li {position:relative; margin-top:8px; padding-left:15px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74541/blt_square.png) no-repeat 0 5px; color:#fff; font-family:'Dotum', '돋움', 'Verdana'; font-size:11px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#fff;}

.greenChrisbox .sns {position:absolute; top:133px; left:50%; margin-left:527px; width:45px;}
.greenChrisbox .sns ul li {overflow:hidden; height:46px; margin-top:20px; padding:0;}
.greenChrisbox .sns ul li:first-child {margin-top:0;}
.greenChrisbox .sns ul li.twitter img {margin-top:-65px;}
</style>
<script type="text/javascript">
$(function(){
	/* sns */
	var $win = $(window);
	var top = $(window).scrollTop(); // 현재 스크롤바의 위치값

	/*사용자 설정 값 시작*/
	var speed = 'slow'; // 따라다닐 속도 : "slow", "normal", or "fast" or numeric(단위:msec)
	var easing = 'swing'; // 따라다니는 방법 기본 두가지 linear, swing
	var $layer = $("#snsGreenChrisbox"); // 레이어 셀렉팅
	var layerTopOffset = 0; // 레이어 높이 상한선, 단위:px
	$layer.css('position', 'absolute');
	/*사용자 설정 값 끝*/

	// 스크롤 바를 내린 상태에서 리프레시 했을 경우를 위해
	if (top > 0 )
		$win.scrollTop(layerTopOffset+top);
	else
		$win.scrollTop(0);

	//스크롤이벤트가 발생하면
	$(window).scroll(function(){
		yPosition = $win.scrollTop() - 200;
		if (yPosition < 133) {
			yPosition = 133;
		}
		$layer.animate({"top":yPosition }, {duration:500, easing:easing, queue:false});
	});

	/* layer */
	var wrapHeight = $(document).height();
	$("#btnView").click(function(){
		$("#lyItem").show();
		$("#dimmed").show();
		$("#dimmed").css("height",wrapHeight);
	});

	$("#lyItem .btnClose, #lyWin .btnDownload, #dimmed").click(function(){
		$("#lyItem").hide();
		$("#lyWin").hide();
		$("#dimmed").fadeOut();
	});
});
///////////////////////////////////////////////////////
function btnClose(){
	$("#lyWin").hide();
	$("#dimmed").hide();
	$("#dimmed").fadeOut();
}

function getcoupon(){
<% If IsUserLoginOK() Then %>
	<% If Now() > #11/23/2016 10:00:00# and Now() < #12/02/2016 23:59:59# Then %>
		var result;
			$.ajax({
				type:"GET",
				url:"/event/etc/doeventsubscript/doEventSubscript74541.asp",
				data: "mode=I",
				dataType: "text",
				async:false,
				success : function(Data){
					result = jQuery.parseJSON(Data);
					if (result.resultcode=="11"){
						$("#lyWin").empty().html(result.lypop);
						$("#lyWin").show();
						$("#dimmed").show();
						$("#dimmed").css("height",wrapHeight);
					}
					else if (result.resultcode=="00"){
						alert('잠시 후 다시 시도해 주세요.');
						return;
					}
					else if (result.resultcode=="99"){
						alert('오늘은 이미 응모 하셨습니다.');
						return;
					}
					else if (result.resultcode=="33"){
						alert('이벤트 응모 기간이 아닙니다.');
						return;
					}
					else if (result.resultcode=="44"){
						alert('로그인후 이용하실 수 있습니다.');
						return;
					}
					else if (result.resultcode=="88"){
						alert('잘못된 접근 입니다.');
						return;
					}
					else if (result.resultcode=="E0"){
						alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해주십시오.');
						return;
					}
					else if (result.resultcode=="ER"){
						alert('데이터 처리에 예외 상황이 발생하였습니다. 관리자에게 문의해주십시오.');
						return;
					}
					else if (result.resultcode=="999"){
						alert('오류가 발생했습니다.');
						return false;
					}else{
						alert('오류가 발생했습니다..');
						return false;
					}
				}
			});
	<% else %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% end if %>
<% Else %>
	if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
		top.location.href="/login/loginpage.asp?vType=G";
		return false;
	}
<% End IF %>
}


function goDirOrdItem(tm){
<% If IsUserLoginOK() Then %>
	<% If Now() > #11/23/2016 10:00:00# and Now() < #12/02/2016 23:59:59# Then %>
		$("#itemid").val(tm);
		document.directOrd.submit();
	<% else %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% end if %>
<% Else %>
	if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
		top.location.href="/login/loginpage.asp?vType=G";
		return false;
	}
<% End IF %>
}

function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="ka"){
		alert('잘못된 접속 입니다.');
		return false;
	}
}
</script>
	<div class="evt7454 greenChrisbox">
		<div class="section event">
			<div class="inner">
				<div class="hgroup">
					<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/tit_green_christmas.png" alt="텐바이텐과 이니스프리가 함께하는 그린 크리스박스" /></h2>
					<span class="star star1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/img_star.png" alt="" /></span>
					<span class="star star2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/img_star.png" alt="" /></span>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/txt_get.png" alt="배송비 2,000원만 결제하면 그린 크리스박스가 갑니다!" /></p>
				</div>

				<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/txt_date.png" alt="이벤트 기간은 2016년 11월 20일부터 12월 2일까지" /></p>

				<div class="item">
					<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/img_green_chrisbox_v2.jpg" alt="그린 크리스박스" /></div>
					<a href="#lyItem" id="btnView" class="btnView">
						<span class="word"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/txt_view.png" alt="자세히 보러가기" /></span>
						<span class="plus"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/btn_view.png" alt="" /></span>
					</a>

					<%' for dev msg : 응모하기 버튼 %>
					<button type="button" id="btnGet" onclick="getcoupon(); return false;" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/btn_get.png" alt="응모하기" /></button>
					<p class="random"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/txt_random.png" alt="그린 크리스박스는 배송비만 결제하면 위 상품 중 한가지 상품이 랜덤으로 담겨 발송됩니다" /></p>
				</div>
			</div>
		</div>

		<%' for dev msg : 당첨 상품 리스트 %>
		<div id="lyItem" class="lyContent">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/txt_gift.png" alt="당첨 상품 리스트 2016 그린크리스마스 DIY 뮤직박스, 센티드 캔들 100g, 비즈왁스 타블렛, 세컨드 스킨 마스크 4종 세트, 마이바디 미니어처 세트, 제주 퍼퓸드 핸드크림 3동 기프트 세트, 마이쿠션 케이스" /></p>
			<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/btn_close_01.png" alt="당첨 상품 리스트 레이어팝업 닫기" /></button>
		</div>

		<%' for dev msg : 당첨 레이어 팝업 %>
		<div id="lyWin" class="lyContent" style="display:none">
		</div>

		<div class="section innisfree">
			<div class="outer">
				<div class="inner">
					<div class="group">
						<div class="desc campaign">
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/txt_campaign.png" alt="2016 이니스프리 그린 크리스마스 My Green Christmas 이니스프리 그린 크리스마스는 나의 즐거움이 누군가에게 따뜻함으로 전해지도록DIY키트를 통해 행복을 나누는 캠페인입니다" /></p>
							<a href="http://innisfree.co.kr/event/greenchristmas2016/gatePc.jsp" target="_blank" title="My Green Christmas 캠페인으로 이동 새창" class="btnMore"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/btn_campaign.png" alt="캠페인 자세히 보기" /></a>
						</div>

						<div class="desc video">
							<iframe width="560" height="315" src="https://www.youtube.com/embed/mildxmge27Q?list=PLQ629BV8uoazzUT3JhWmQ696pTI8Arg0N" title="이니스프리 My Green Christmas 민호의 그린 크리스마스 이야기" frameborder="0" allowfullscreen></iframe>
						</div>
					</div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/txt_campaign_process.png" alt="이니스프리 크리스마스 LTD 에디션을 사면 DIY 뮤직박스 할인가 2,000원에 구매 가능 DIY 뮤직박스 판매금 중 일부는 세이브더칠드런에 기부" /></p>
				</div>
			</div>
		</div>

		<div class="section noti">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/tit_noti.png" alt="이벤트 유의사항" /></h3>
				<ul>
					<li>본 이벤트는 텐바이텐에서만 참여 가능합니다.</li>
					<li>본 이벤트는 로그인 후에 참여할 수 있습니다.</li>
					<li>ID당 1일 1회만 응모 가능합니다.</li>
					<li>무료배송쿠폰은 발급 당일 자정 기준으로 자동 소멸됩니다. (텐바이텐 배송 상품 1만원 이상 구매 시 사용 가능)</li>
					<li>이벤트 내 모든 상품의 컬러는 랜덤으로 발송되며, 선택이 불가능합니다.</li>
					<li>이벤트는 상품 품절 시 조기 마감될 수 있습니다.</li>
					<li>이벤트는 즉시 결제로만 구매가 가능하며, 배송 후 반품/교환/구매취소가 불가능합니다.</li>
					<li>당첨된 상품은 당첨 당일 구매하셔야 결제 가능합니다. (익일 결제불가)</li>
				</ul>
			</div>
		</div>

		<!-- for dev msg : sns -->
		<div id="snsGreenChrisbox" class="sns">
			<ul>
				<li class="facebook"><a href="" target="_blank" onclick="snschk('fb');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/ico_sns.png" alt="그린 크리스박스 페이스북에 공유하기" /></a></li>
				<li class="twitter"><a href="" target="_blank" onclick="snschk('tw');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74541/ico_sns.png" alt="그린 크리스박스 트위터에 공유하기" /></a></li>
			</ul>
		</div>

		<div id="dimmed"></div>
	</div>
<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
	<input type="hidden" name="itemid" id="itemid" value="">
	<input type="hidden" name="itemoption" value="0000">
	<input type="hidden" name="itemea" value="1">
	<input type="hidden" name="mode" value="DO1">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->