<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 바람이 불어왕 WWW
' History : 2016.05.19 김진영 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<% '<!-- #include virtual="/lib/inc/head.asp" --> %>
<%
Dim eCode, userid, currenttime, i, couponidx,  selectitemid
currenttime = now()
userid = GetEncLoginUserID()

If application("Svr_Info") = "Dev" Then
	eCode			= "66133"
	couponidx		= "11135"
	selectitemid	= "1238955"
Else
	eCode			= "70794"
	couponidx		= "11649"
	selectitemid	= "1492386"
End If

Dim subscriptcount, itemcouponcount
subscriptcount	= 0
itemcouponcount	= 0

'//본인 참여 여부
If userid <> "" Then
	subscriptcount	= getevent_subscriptexistscount(eCode, userid, "", "", "")
	itemcouponcount	= getitemcouponexistscount(userid, couponidx, "", "")
End If
'response.write GetUserStrlarge(GetLoginUserLevel) & "/" & GetLoginUserLevel

Dim administrator
	administrator = FALSE

If GetLoginUserID = "greenteenz" or GetLoginUserID = "djjung" or GetLoginUserID = "bborami" or GetLoginUserID = "kyungae13" or GetLoginUserID = "jinyeonmi" or GetLoginUserID = "thensi7" or GetLoginUserID = "baboytw" or GetLoginUserID = "kjy8517" Then
	administrator = TRUE
End If
%>
<style type="text/css">
img {vertical-align:top;}

.rolling {position:relative; padding-bottom:226px; background:#c3f0f6 url(http://webimage.10x10.co.kr/eventIMG/2016/70794/bg_sky.jpg) no-repeat 50% 0;}
.rolling p {position:absolute; bottom:77px; left:50%; margin-left:-465px;}
.slide {position:relative; width:930px; margin:0 auto;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:40px; height:67px; margin-top:-33px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70794/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:20px;}
.slide .slidesjs-next {right:20px; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:18px; left:50%; z-index:10; width:96px; margin-left:-48px;}
.slidesjs-pagination li {float:left;}
.slidesjs-pagination li a {display:block; width:24px; height:24px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70794/btn_pagination.png) no-repeat 50% 0; transition:0.5s ease; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:50% 100%;}
.slide .desc {position:absolute; top:265px; left:50%; z-index:50; margin-left:-118px;}

.guide {position:relative;}
.guide .btnGet {position:absolute; top:132px; right:121px;}
.guide .btnGet img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.8s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:3px; animation-timing-function:ease-in;}
}

.lyView {display:none; position:fixed; top:50%; left:50%; z-index:105; width:483px; height:482px; margin-top:-241px; margin-left:-241px;}
.lyView .btnClose {position:absolute; top:-2px; right:3px; background-color:transparent;}
#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68354/bg_mask.png);}

.noti {position:relative; padding:33px 0 32px; background-color:#5bcad7; text-align:left;}
.noti h3 {position:absolute; top:50%; left:105px; margin-top:-12px;}
.noti ul {margin-left:356px; padding-left:70px; border-left:1px solid #7fdfe7;}
.noti ul li {position:relative; margin-top:7px; padding-left:10px; color:#fff; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#fff;}
.noti ul li .btnGrade {margin-left:11px;}
.noti ul li .btnGrade img {margin-top:-3px; vertical-align:top;}
</style>
<script type="text/javascript">
$(function(){
	$("#slide").slidesjs({
		width:"930",
		height:"575",
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
});

function jscoupondown(){
	var wrapHeight = $(document).height();
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10) >= "2016-05-19" and left(currenttime,10) < "2016-05-30" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if GetLoginUserLevel<>"5" and not(administrator) then %>
				alert("고객님은 쿠폰발급 대상이 아닙니다.");
				return;
			<% else %>
				<% if administrator then %>
					alert("[관리자] 특별히 관리자님이니까 오렌지 등급이 아니여도 다음 단계로 진행 시켜 드릴께요!");
				<% end if %>
				var str = $.ajax({
					type: "POST",
					url: "/event/etc/doeventsubscript/doEventSubscript70794.asp",
					data: "mode=coupondown",
					dataType: "text",
					async: false
				}).responseText;
				//alert(str);
				var str1 = str.split("||")
				//alert(str1[0]);
				if (str1[0] == "11"){
					$("#lyView").empty().html(str1[1]);
					$("#lyView").show();
					$("#dimmed").show();
					$("#dimmed").css("height",wrapHeight);
					return false;
				}else if (str1[0] == "10"){
					alert('데이터 처리에 예외 상황이 발생하였습니다. 관리자에게 문의해주십시오.');
					return false;
				}else if (str1[0] == "09"){
					$("#lyView").empty().html(str1[1]);
					$("#lyView").show();
					$("#dimmed").show();
					$("#dimmed").css("height",wrapHeight);
					return false;
				}else if (str1[0] == "08"){
					alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
					return false;
				}else if (str1[0] == "07"){
					alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해주십시오.');
					return false;
				}else if (str1[0] == "06"){
					alert('쿠폰은 오전 10시부터 다운 받으실수 있습니다.');
					return false;
				}else if (str1[0] == "05"){
					alert('고객님은 쿠폰발급 대상이 아닙니다.');
					return false;
				}else if (str1[0] == "04"){
					$("#lyView").empty().html(str1[1]);
					$("#lyView").show();
					$("#dimmed").show();
					$("#dimmed").css("height",wrapHeight);
					return false;
				}else if (str1[0] == "03"){
					alert('이벤트 응모 기간이 아닙니다.');
					return false;
				}else if (str1[0] == "02"){
					alert('로그인을 해주세요.');
					return false;
				}else if (str1[0] == "01"){
					alert('잘못된 접속입니다.');
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
}
function goDirOrdItem()
{
	alert('본 쿠폰은 상품쿠폰에서 선택 후에 사용 가능합니다.');
	document.directOrd.submit();
}

function poplayerclose(){
	$("#lyView").hide();
	$("#dimmed").fadeOut();
}
</script>
<%'' 방가방가 첫 구매 %>
<div class="evt70794">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/70794/tit_wind.gif" alt="바람이 불어왕 아직 한번도 구매하지 않은 당신에게 귀여운 미니선풍기를 소개합니다!" /></h2>
	<div class="rolling">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70794/txt_item.png" alt="아이리뷰 USB 선풍기 쿠폰할인가 3천원 색상은 랜덤 발송됩니다." /></p>
		<div id="slide" class="slide">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70794/img_slide_01.jpg" alt="아이리뷰 USB 선풍기" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70794/img_slide_02.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70794/img_slide_03.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70794/img_slide_04.jpg" alt="" /></div>
		</div>
	</div>
	<div class="guide">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70794/txt_guide.png" alt="먼저 쿠폰을 발급 받고 구매하러 가기 후 쿠폰을 사용하여 결제합니다. 오늘 당신만을 위한 엄청난 쿠폰으로 첫 구매에 도전하세요!" /></p>
		<a href="" id="btnGet" class="btnGet" onclick="jscoupondown(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70794/btn_get.png" alt="쿠폰 받고 구매하러 가기" /></a>
	</div>
	<%' for dev msg : 레이어 팝업 %>
	<div id="lyView" class="lyView" style="display:none;"></div>
	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70794/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li><span></span>텐바이텐에서 한번도 구매이력이 없는 오렌지등급 고객님을 위한 이벤트입니다.
				<!-- for dev msg : 회원혜택 보기 -->
				<a href="/my10x10/special_info.asp" class="btnGrade"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70794/btn_grade.png" alt="회원등급 보러가기" /></a>
			</li>
			<li><span></span>본 이벤트는 로그인 후에 참여가 가능합니다.</li>
			<li><span></span>ID 당 1회만 구매가 가능합니다.</li>
			<li><span></span>이벤트는 상품 품절 시 조기 마감 될 수 있습니다.</li>
			<li><span></span>이벤트틑 즉시결제로만 구매가 가능하며, 배송 후 반품/교환/구매취소가 불가능합니다.</li>
		</ul>
	</div>
	<div id="dimmed"></div>
</div>
<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
	<input type="hidden" name="itemid" value="<%=selectitemid%>">
	<input type="hidden" name="itemoption" value="0000">
	<input type="hidden" name="itemea" value="1">
	<input type="hidden" name="mode" value="DO1">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->