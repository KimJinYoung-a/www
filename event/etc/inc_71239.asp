<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'###########################################################
' Description : 지구를 멈춰라 WWW
' History : 2016.06.16 유태욱
'###########################################################
Dim eCode, cnt, sqlStr, i, totalsum, irdsite20, vUserID, currenttime, contemp, worldname

currenttime = date()
'															currenttime = "2016-06-20"

If application("Svr_Info") = "Dev" Then
	eCode 		= "66153"
Else
	eCode 		= "71239"
End If

irdsite20	= requestCheckVar(request("rdsite"), 32)
vUserID		= GetEncLoginUserID

'// 실시간 당첨자 id
sqlstr = "SELECT top 10 userid, sub_opt2, regdate"
sqlstr = sqlstr & " From [db_event].[dbo].[tbl_event_subscript]"
sqlstr = sqlstr & " where evt_code="& eCode &" and datediff(day,regdate,getdate()) = 0 And sub_opt2<>0 "
sqlstr = sqlstr & " order by regdate desc"
'response.write sqlstr & "<Br>"
rsget.Open sqlstr,dbget
IF not rsget.EOF THEN
	contemp = rsget.getrows()
END IF
rsget.close

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] 지구를 멈춰라!")
snpLink		= Server.URLEncode("http://m.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
'// 카카오링크 변수
'Dim kakaotitle : kakaotitle = "[텐바이텐] TEST"
'Dim kakaoimage : kakaoimage = "http://webimage.10x10.co.kr/eventIMG/2015/67929/01/img_bnr_kakao.png"
'Dim kakaoimg_width : kakaoimg_width = "200"
'Dim kakaoimg_height : kakaoimg_height = "200"
'Dim kakaolink_url 
'If isapp = "1" Then '앱일경우
'	kakaolink_url = "http://m.10x10.co.kr/apps/appcom/wish/web2014/event/eventmain.asp?eventid="&eCode
'Else '앱이 아닐경우
'	kakaolink_url = "http://m.10x10.co.kr/event/eventmain.asp?eventid="&eCode
'End If
%>
<style type="text/css">
img {vertical-align:top;}
.evt71239 {position:relative;}
.stopEarth {position:relative;}
.stopEarth .btnClick {display:block; position:absolute; left:50%; top:237px; margin-left:-77px; background:transparent;}
.resultLayer {position:absolute; left:0; top:0; z-index:100; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71239/bg_mask.png) repeat 0 0;}
.resultLayer .layerCont {position:absolute; left:50%; top:332px; margin-left:-196px;}
.resultLayer .layerCont .btnClose {display:block; position:absolute; right:20px; top:20px; z-index:110;  background:transparent;}
.resultLayer .layerCont .btnGo {display:block; position:absolute; left:0; bottom:0; width:100%; height:80px; background:transparent; text-indent:-999em;}
.resultLayer .worldTravel .item {display:block; position:absolute; left:0; top:131px; z-index:110;}
.resultLayer .worldTravel .code {position:absolute; left:0; bottom:88px; width:100%; z-index:110; font-size:11px; text-align:center; color:#999;}
.winWrap {height:110px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71239/bg_win.png) repeat 0 0;}
.winWrap .winList {position:relative; overflow:hidden; width:998px; height:110px; margin:0 auto;}
.winWrap .winList h3 {position:absolute; left:61px; top:46px;}
.winWrap .winList .winSwipe {overflow:hidden; position:absolute; left:370px; top:30px; width:604px; height:50px;}
.winWrap .winList .swiper-container {width:604px; height:50px;  text-align:left;}
.winWrap .winList .swiper-slide {position:relative; font-size:16px; line-height:52px; color:#000; font-weight:bold;}
.winWrap .winList .swiper-slide em {color:#fff;}
.winWrap .winList .swiper-slide span {position:absolute; right:70px; top:0; color:#fff; font-size:14px; font-family:verdana; font-weight:normal;}
.winWrap .winList button {display:block; position:absolute; right:0; background:transparent;}
.winWrap .winList .prev {top:0;}
.winWrap .winList .next {bottom:0;}
.vacationGift {position:relative;}
.vacationGift .btnMore {display:block; position:absolute; right:112px; bottom:150px; width:160px; height:158px; background:transparent; text-indent:-999em;}
.evtNoti {position:relative; padding:30px 0; background:#dad5cc;}
.evtNoti div {position:relative; text-align:left; padding:0 0 0 270px;}
.evtNoti h3 {position:absolute; left:88px; top:50%; margin-top:-36px;}
.evtNoti ul {padding-left:40px; font-size:12px; line-height:20px; color:#74726d; border-left:1px solid #edeae6;}
.evtNoti li {padding:0 0 3px 10px; text-indent:-10px;}
.evtNoti .btnShare {position:absolute; right:50px; top:65px; z-index:50; }
.giftLayer {position:absolute; left:0; top:0; z-index:100; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71239/bg_mask.png) repeat 0 0;}
.giftLayer .layerCont {position:absolute; left:50%; top:100px; margin-left:-317px;}
.giftLayer .layerCont .giftClose {display:block; position:absolute; right:20px; top:20px; z-index:110;  background:transparent;}
.zoom {animation-name:zoom; animation-duration:1.5s; animation-iteration-count:20; animation-fill-mode:both;}
@keyframes zoom {
	from, to{transform: scale(1); animation-timing-function:ease-out;}
	50% {transform: scale(1.1); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
$(function(){
	// 당첨자소식
	var swiper1 = new Swiper('.winSwipe .swiper-container',{
		mode :'vertical',
		loop:true,
		speed:800,
		autoplay:2500,
		pagination:false
	});
	$('.winList .prev').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	})
	$('.winList .next').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	// 선물 레이어
	$('.btnMore').click(function(){
		$('.giftLayer').fadeIn();
		window.parent.$('html,body').animate({scrollTop:$(".giftLayer").offset().top}, 300);
	});
	$('.giftClose').click(function(){
		$('.giftLayer').fadeOut();
	});
});

function checkform(){
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
		<% If currenttime >= "2016-06-20" And currenttime < "2016-06-25" Then %>
			$.ajax({
				type:"GET",
				url:"/event/etc/doeventsubscript/doEventSubscript71239.asp",
				data: "mode=add",
				dataType: "text",
				async:false,
				cache:true,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								for(var i in Data){
									 if(Data.hasOwnProperty(i)){
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
//alert(res[1]);
//return;
								if (res[0]=="OK"){
									$("#resultLayer").empty().html(res[1]);
									$('.resultLayer').fadeIn();
									window.parent.$('html,body').animate({scrollTop:$(".resultLayer").offset().top}, 300);
								} else {
									errorMsg = res[1].replace(">?n", "\n");
									alert(errorMsg);
									document.location.reload();
									return false;
								}
							} else {
								alert("잘못된 접근 입니다.");
								document.location.reload();
								return false;
							}
						}
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					alert("잘못된 접근 입니다.");
					document.location.reload();
					return false;
				}
			});
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;				
		<% End If %>
	<% End If %>
}

//쿠폰Process
function get_coupon(){
<% If IsUserLoginOK Then %>
	<% if not( currenttime>="2016-06-20" and currenttime<"2016-06-25" ) then %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% else %>
		var rstStr = $.ajax({
			type: "POST",
			url: "/event/etc/doeventsubscript/doEventSubscript71239.asp",
			data: "mode=coupon",
			dataType: "text",
			async: false
		}).responseText;
		if (rstStr == "SUCCESS"){
			alert('쿠폰이 발급되었습니다.');
			location.reload();
			return false;
		}else if (rstStr == "MAXCOUPON"){
			alert('오늘의 응모는 모두 완료! 내일 또 도전해 주세요!');
			return false;
		}else if (rstStr == "NOT1"){
			alert('응모후 다운로드가 가능합니다.');
			return false;
		}else if (rstStr == "DATENOT"){
			alert('이벤트 응모 기간이 아닙니다.');
			return false;
		}else if (rstStr == "USERNOT"){
			alert('로그인을 해주세요.');
			return false;
		}else{
			alert('관리자에게 문의');
			return false;
		}
	<% end if %>
<% Else %>
	if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
		var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
		winLogin.focus();
		return;
	}
<% end if %>
}

function fnClosemask()
{
	$('.resultLayer').fadeOut();
	document.location.reload();
}

function snschk(snsnum) {
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
		var reStr;
		var str = $.ajax({
			type: "GET",
			url:"/event/etc/doeventsubscript/doEventSubscript71239.asp",
			data: "mode=snschk&snsnum="+snsnum,
			dataType: "text",
			async: false
		}).responseText;
			reStr = str.split("|");
			if(reStr[1] == "tw") {
				popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
			}else if(reStr[1]=="fb"){
				popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
			}else if(reStr[1] == "none"){
				alert('참여 이력이 없습니다.\n응모후 이용 하세요');
				return false;
			}else if(reStr[1] == "end"){
				alert('오늘 응모를 모두 하셨습니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
	<% End If %>
}
</script>
	<!-- 지구를 멈춰라 -->
	<div class="evt71239">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/tit_stop_earth.png" alt="지구를 멈춰라" /></h2>
		<!-- 지구 클릭 -->
		<div class="stopEarth">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/img_earth.gif" alt="" /></div>
			<button type="button" onclick="checkform();return false;" class="btnClick zoom"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/btn_click.png" alt="CLICK" /></button>
		</div>

		<!-- 응모 결과 -->
		<div id="resultLayer" class="resultLayer" style="display:none;">

		</div>

		<!-- 당첨자 내역 -->
		<div class="winWrap">
			<div class="winList">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/tit_win.png" alt="당첨자 소식" /></h3>
				<div class="winSwipe">
					<div class="swiper-container">
						<div class="swiper-wrapper">
						<% if isarray(contemp) then %>
							<% for i = 0 to ubound(contemp,2) %>
							<%
								Select Case contemp(1,i)
									Case "1","2","3","4","41","42","44"
										worldname = "한국"
									Case "5","6","7","8"
										worldname = "파리"
									Case "9"
										worldname = "덴마크"
									Case "10","11","12"
										worldname = "미국"
									Case "13","20","27","30"
										worldname = "오사카"
									Case "14","15","22","29"
										worldname = "다낭"
									Case "16","23","35","38"
										worldname = "세부"
									Case "17","24","36","39"
										worldname = "괌"
									Case "18","25","31","33"
										worldname = "홍콩"
									Case "19","26","37","40"
										worldname = "호놀룰루"
									Case "21","28","32","34"
										worldname = "타이베이"
									Case "43"
										worldname = "여행상품권"
									Case Else
										worldname = ""
								End Select
							%>
								<div class="swiper-slide"><p><em><%= printUserId(Left(contemp(0,i),13),2,"*")%>님</em>이 <em><%= worldname %></em>에 당첨되셨습니다.<span><%= Left(contemp(2,i),22) %></span></p></div>
							<% next %>
						<% else %>
							<div class="swiper-slide"><p>아직 당첨자가 없습니다.</p></div>
						<% end if %>
						</div>
					</div>
					<button type="button" class="prev"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/btn_prev.png" alt="이전" /></button>
					<button type="button" class="next"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/btn_next.png" alt="다음" /></button>
				</div>
			</div>
		</div>

		<!-- 선물 리스트 -->
		<div class="vacationGift">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/img_gift_v1.jpg" alt="선물 리스트" /></div>
			<button type="button" class="btnMore">그 외 사은품 더보기</button>
		</div>

		<!-- 선물 레이어 -->
		<div id="giftLayer" class="giftLayer" style="display:none;">
			<div class="layerCont">
				<button type="button" class="giftClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/btn_close.png" alt="닫기" /></button>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/img_layer_gift.png" alt="사은품 리스트" /></div>
			</div>
		</div>

		<div class="evtNoti">
			<a href="" onclick="snschk('fb'); return false;" class="btnShare"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/btn_fb.png" alt="친구들에게 공유하고 한번 더 도전하자!" /></a>
			<div>
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71239/tit_noti.png" alt="이벤트 유의사항" /></h3>
				<ul>
					<li>- 본 이벤트는 텐바이텐에서만 참여 가능합니다.</li>
					<li>- 5만원 이상의 상품을 받으신 분께는 세무신고를 위해 개인정보를 요청할 수 있습니다.<br />제세공과금은 텐바이텐 부담입니다.</li>
					<li>- 당첨된 고객께는 익일 당첨안내 문자가 전송될 예정입니다.</li>
					<li>- 당첨된 상품은 당첨안내 확인 후에 발송됩니다!<br />(차주 월요일부터 순차적으로 배송)</li>
					<li>- 이벤트 내 모든 상품의 컬러는 랜덤으로 발송되며, 선택이 불가능합니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<!--// 지구를 멈춰라 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->