<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/instagrameventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, userid , strSql, vArr
Dim lastusercnt '앱마지막 로그인 카운트
Dim logusercnt '로그인내역 카운트
Dim evt_pass : evt_pass = False '이벤트 응모 여부 chkflag

	IF application("Svr_Info") = "Dev" THEN
		eCode = "66173"
	Else
		eCode = "72088"
	End If

userid = getEncLoginUserID

strSql = "select top 5 userid, regdate, sub_opt2 from [db_event].[dbo].[tbl_event_subscript] where evt_code = '" & eCode & "' order by sub_idx desc"
rsget.CursorLocation = adUseClient
rsget.Open strSql,dbget,adOpenForwardOnly,adLockReadOnly
if not rsget.eof then
	vArr = rsget.getRows()
end if
rsget.close


'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
dim snpTitle, snpLink, snpImg
snpTitle = Server.URLEncode("[텐바이텐] 오벤져스")
snpLink = Server.URLEncode("http://m.10x10.co.kr/event/eventmain.asp?eventid=72088")
snpImg = Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2016/70686/etcitemban20160512185825.jpeg")

'// 카카오링크 변수
Dim kakaotitle : kakaotitle = "[텐바이텐] 봉.투.맨2\n\n당신의 휴가를 도와 줄\n올 여름 보너스를 결정한다!\n\n최대 10만원의 보너스 쿠폰이\n당신을 기다립니다.\n\n지금 도전하세요!\n오직 텐바이텐에서!"
Dim kakaoimage : kakaoimage = "http://webimage.10x10.co.kr/eventIMG/2016/72088/m/img_kakao.jpg"
Dim kakaoimg_width : kakaoimg_width = "200"
Dim kakaoimg_height : kakaoimg_height = "200"
Dim kakaolink_url : kakaolink_url = "http://m.10x10.co.kr/event/eventmain.asp?eventid="&eCode
%>
<style type="text/css">
img {vertical-align:top;}

.envelopeMan {position:relative; overflow:hidden;}
.envelopeMan button {background-color:transparent;}
.envelopeMan h2 {position:relative; z-index:10;}

.selectEnvelope {position:relative; height:792px; background:#cde6f2 url(http://webimage.10x10.co.kr/eventIMG/2016/72088/bg_btm.jpg) no-repeat 50% 0;}
.selectEnvelope .openDrawer {position:absolute; top:0; left:50%; margin-left:-320px;}
.selectEnvelope .openDrawer .click {position:absolute; top:240px; left:50%; z-index:5; margin-left:-56px;}
.selectEnvelope .openDrawer .click {animation-name:flash; animation-duration:2s; animation-fill-mode:both; animation-iteration-count:infinite; animation-delay:3s;}
@keyframes flash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}
.selectEnvelope .openDrawer .btnEnvelope {position:absolute; top:83px; left:127px;}
.selectEnvelope .openDrawer .btnEnvelope2 {top:152px; left:334px;}
.selectEnvelope .openDrawer .coin {position:absolute; top:280px; right:140px;}

.lyWin {display:none; position:absolute; top:0; left:50%; z-index:105; width:501px; margin-left:-250px;}
.lyWin .btnClose {position:absolute; top:172px; right:0;}
.lyWin .btnConfirm {position:absolute; bottom:70px; left:50%; margin-left:-199px;}
#dimmed {display:none; position:absolute; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71111/bg_mask.png);}

.winnerList {overflow:hidden; position:absolute; bottom:278px; left:50%; width:998px; height:110px; margin-left:-499px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72088/bg_box.png) no-repeat 50% 0;}
.winnerList h3 {position:absolute; left:61px; top:46px;}
.winnerList .winSwipe {overflow:hidden; position:relative; width:638px; height:50px; margin-left:327px; margin-top:30px;}
.winnerList .winSwipe .swiper-container {width:638px; height:50px; text-align:left;}
.winnerList .winSwipe .swiper-slide {position:relative; font-size:16px; line-height:50px; color:#000; font-weight:bold;}
.winnerList .winSwipe .swiper-slide b {color:#fff;}
.winnerList .winSwipe .swiper-slide span {position:absolute; right:70px; top:0; color:#fff; font-size:14px; font-family:verdana; font-weight:normal;}
.winnerList .winSwipe button {display:block; position:absolute; right:0; width:32px; height:25px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72088/btn_nav.png) no-repeat 50% 0; text-indent:-9999em;}
.winnerList .winSwipe .btn-prev {top:0;}
.winnerList .winSwipe .btn-next {bottom:0; background-position:50% 100%;}

.noti {position:relative; padding:45px 0 44px; background-color:#f5f5f5; text-align:left;}
.noti h3 {position:absolute; top:50%; left:98px; margin-top:-36px;}
.noti ul {margin-left:271px; padding-left:45px; border-left:1px solid #fff;}
.noti ul li {position:relative; margin-bottom:9px; padding-left:10px; color:#8d8d8d; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#8d8d8d;}
.noti .bnr {position:absolute; top:50%; right:100px; margin-top:-52px;}
</style>
<script type="text/javascript">
$(function(){
	/* open drawer animation */
	openDrawer();
	$(".selectEnvelope .openDrawer").css({"top":"-487px"},1000);
	function openDrawer() {
		$(".selectEnvelope").find(".openDrawer").delay(1000).animate({"top":"0"},1000);
		$(".selectEnvelope .btnEnvelope1 img").delay(2400).effect("shake", {direction:"up", times:2, distance:10}, 900);
		$(".selectEnvelope .btnEnvelope2 img").delay(1600).effect("shake", {direction:"up", times:2, distance:10}, 900);
	}

	/* layer popup */
	$.fn.layerOpen = function(options) {
		return this.each(function() {
			var $this = $(this);
			var $layer = $($this.attr("href") || null);
			$this.click(function() {
				$layer.attr("tabindex",0).show().focus();
				$("#dimmed").show();
				$layer.find(".btnConfirm, .btnClose").one("click",function () {
					$layer.hide();
					$this.focus();
					$("#dimmed").hide();
				});
			});
		});
	}
	$(".layer").layerOpen();

	/* 당첨자 */
	if ($(".winSwipe .swiper-container .swiper-slide").length > 1) {
		var swiper1 = new Swiper('.winSwipe .swiper-container',{
			mode :'vertical',
			loop:true,
			speed:800,
			autoplay:2500,
			pagination:false,
			onSlideChangeStart: function () {
				$('.btn-prev').show();
				$('.btn-next').show();
			}
		});
	} else {
		$(".winSwipe .btn-prev").hide();
		$(".winSwipe .btn-next").hide();
	}

	$(".winSwipe .btn-prev").on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	})
	$(".winSwipe .btn-next").on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});
});

function fnCloseLayer(){
	$("#lyWin").hide();
	$("#dimmed").hide();
}

function fnCloseLayer(){
	$("#lyWin").hide();
	$("#dimmed").hide();
}

function fnCheckHero(){
<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/event/etc/doeventsubscript/doEventSubscript72088.asp",
		data: "mode=G",
		cache: false,
		success: function(str) {
			str = str.replace("undefined","");
			res = str.split("|");
			if (res[0]=="OK") {
				$("#dimmed").show();
				$("#btn11, #btn22").addClass("layer");
				$("#lyWin").empty().html(res[1]);
				$("#lyWin").fadeIn();
				window.parent.$('html,body').animate({scrollTop:$("#lyWin").offset().top-0}, 300);
			} else {
				$("#btn11, #btn22").removeClass("layer");
				errorMsg = res[1].replace(">?n", "\n");
				alert(errorMsg );

				return false;
			}
		}
		,error: function(err) {
			console.log(err.responseText);
			alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
		}
	});
<% else %>
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
<% end if %>
}
</script>
<div class="evt72088 envelopeMan">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/72088/tit_envelope_man.jpg" alt="당신의 휴가를 도와줄 보너스를 결정한다 봉투맨2 서랍 속 봉투를 확인해 보세요! 최대10만원의 보너스쿠폰이 찾아갑니다!" /></h2>
	<div class="selectEnvelope">
		<div class="openDrawer">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72088/txt_select.png" alt="아래 봉투 중 하나만 골라주세요!" /></p>
			<p class="click"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72088/txt_click.png" alt="Click" /></p>
			<a href="" id="btn11" onClick="fnCheckHero();return false;" class="btnEnvelope btnEnvelope1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72088/img_envelope_01.png" alt="첫번째 봉투" /></a>
			<a href="" id="btn22" onClick="fnCheckHero();return false;" class="btnEnvelope btnEnvelope2 yer"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72088/img_envelope_02.png" alt="두번째 봉투" /></a>
			<span class="coin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72088/img_coin.png" alt="" /></span>
		</div>
	</div>
	<div id="lyWin" class="lyWin">
	</div>
	<div class="winnerList">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72088/tit_win.png" alt="당첨자 소식" /></h3>
		<div class="winSwipe">
			<div class="swiper-container">
				<ul class="swiper-wrapper">
				<%
					Dim i
					If isArray(vArr) THEN
						For i =0 To UBound(vArr,2)
							Response.Write "<li class=""swiper-slide""><b>" & CHKIIF(Len(vArr(0,i))<3,vArr(0,i),Left(vArr(0,i),3)) & "**</b>님이 <b>" & fnCouponname11(vArr(2,i)) & "</b>의 보너스쿠폰을 받았습니다. <span class=""date"">" & vArr(1,i) & "</span></li>"
						Next
					Else
						Response.Write "<li class=""swiper-slide"">아직 보너스 당첨자가 없습니다.</li>"
					End If
				%>
				</ul>
			</div>
			<button type="button" class="btn-nav btn-prev">이전</button>
			<button type="button" class="btn-nav btn-next">다음</button>
		</div>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72088/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li><span></span>이벤트는 ID당 1일 1회만 참여할 수 있습니다.</li>
			<li><span></span>지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
			<li><span></span>쿠폰은 지급 당일 23시 59분 59초에 종료됩니다.</li>
			<li><span></span>주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
			<li><span></span>이벤트는 조기 마감될 수 있습니다.</li>
		</ul>
		<div class="bnr">
			<a href="/event/eventmain.asp?eventid=72109"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72088/img_bnr.png" alt="여름에 없으면 서운해~ 즐거운 여름을 위해 꼭 필요한 아이템들 기획전 보러가기" /></a>
		</div>
	</div>

	<div id="dimmed"></div>
</div>

<%
If userid = "okkang77" or userid = "greenteenz" or userid = "helele223" Then
	dim vQuery, vAry, j
	vQuery = "select s.sub_opt1, s.sub_opt2, count(s.sub_idx), (select count(idx) from [db_user].[dbo].tbl_user_coupon where masteridx = s.sub_opt2 and isusing = 'Y' and startdate = s.sub_opt1) as cnt"
	vQuery = vQuery & " from [db_event].[dbo].[tbl_event_subscript] as s where s.evt_code = '"&eCode&"' group by s.sub_opt1, s.sub_opt2 order by s.sub_opt1 asc, s.sub_opt2 asc"
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
	if not rsget.eof then
		vAry = rsget.getRows()
	end if
	rsget.close
	
	If isArray(vAry) THEN
		For j =0 To UBound(vAry,2)
			Response.Write vAry(0,j) & " " & fnCouponname11(vAry(1,j)) & "(" & vAry(1,j) & ") " & vAry(2,j) & "개 발급 " & vAry(3,j) & "개 사용<br />"
		Next
	End If
End If
function fnCouponname11(c)
select case c
	case "885" : fnCouponname11 = "10만원"
	case "886" : fnCouponname11 = "3만원"
	case "887" : fnCouponname11 = "1만원"
	case "888" : fnCouponname11 = "5천원"
end select
end function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->