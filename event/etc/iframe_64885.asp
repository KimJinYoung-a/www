<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  ## 미니언즈가 텐바이텐에 떴다!
' History : 2015-07-13 원승현 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/event/appdown/appdownCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode, rstWishItem, rstWishCnt
dim cEvent, cEvent50277, intI, iTotCnt, rstArrItemid, blnitempriceyn, sBadges, smssubscriptcount, usercell, userid
	eCode  = getevt_code
	userid = getloginuserid()

iTotCnt=0
rstArrItemid=""
rstWishItem=""
rstWishCnt=""
intI = 0
smssubscriptcount=0
usercell=""

smssubscriptcount = getevent_subscriptexistscount(eCode, userid, "SMS_W", "", "")
usercell = getusercell(userid)


	IF application("Svr_Info") = "Dev" THEN
		eCode = 64827
	Else
		eCode = 64885
	End If
%>

<style type="text/css">
#contentWrap {padding-bottom:0;}
img {vertical-align:top;}
.evt64885 {border-top:11px solid #42738d; text-align:center;}
.evt64885 .topic {position:relative;height:428px;background:#e1e1e1 url(http://webimage.10x10.co.kr/eventIMG/2015/64885/bg_flash_pattern.png) no-repeat 50%;}
.evt64885 .topic .minions {position:absolute; top:282px; left:50%; margin-left:324px;}

.evt64885 .item {background-color:#ffdd00;}
.evt64885 .movie {background-color:#42738d;}
.evt64885 .movie .inner {position:relative; width:1140px; margin:0 auto; padding:80px 0 292px;}
.evt64885 .movie .youtube {width:544px; height:363px; margin-left:85px; padding:8px; background-color:#fff;}
.evt64885 .movie .desc {position:absolute; top:88px; left:690px; text-align:left;}
.evt64885 .movie .desc p {margin-bottom:20px;}
.evt64885 .tentenapp {background-color:#000;}
.evt64885 .tentenapp .inner {position:relative; width:1140px; margin:0 auto; padding:87px 0 65px 0;}
.evt64885 .tentenapp .gift {position:absolute; top:-210px; left:50%; margin-left:-514px;}
.evt64885 .tentenapp .field {position:relative; width:966px; margin:0 auto; border:1px solid #ccc; text-align:left;}
.evt64885 .tentenapp .field .itext {width:390px; margin-top:14px; margin-left:19px; padding:0 22px; height:46px; color:#000; font-size:12px; font-family:'Dotum', 'Verdana'; font-weight:bold; line-height:46px;}
.evt64885 .tentenapp .field .btnurl {position:absolute; top:14px; right:14px;}
.evt64885 .tentenapp .field p {text-align:center;}
</style>
<script type="text/javascript">

function jsSubmitsms(frm){
	<% If IsUserLoginOK() Then %>
		<% If Now() > #12/31/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If getnowdate>="2014-04-01" and getnowdate<"2015-12-31" Then %>
				<% if smssubscriptcount < 3 then %>
					if(frm.usercellnum.value =="로그인 해주세요. (1일 3회)"){
						jsChklogin('<%=IsUserLoginOK%>');
						return false;
					}
					if (frm.usercellnum.value == ''){
						alert("휴대폰 번호가 정확하지 않습니다.\n마이텐바이텐에서 개인정보를 수정해 주세요.!");
						return;
					}

					frm.mode.value="addsms";
					frm.action="/event/etc/doEventSubscript64885.asp";
					frm.submit();
					return;
				<% else %>
					alert("메세지는 3회까지 발송 가능 합니다.");
					return;
				<% end if %>
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>				
		<% End If %>
	<% Else %>
		jsChklogin('<%=IsUserLoginOK%>');
	<% End IF %>
}	

</script>


<form name="evtfrm" action="" onsubmit="return false;" method="post" style="margin:0px;">
<input type="hidden" name="mode">
	<!-- [W] 미니언즈 -->
	<div class="evt64885">
		<div class="topic">
			<h1><img src="http://webimage.10x10.co.kr/eventIMG/2015/64885/tit_minions.png" alt="텐바이텐X미니언즈 미니언즈 텐바이텐에 떴다!" /></h1>
			<div class="minions running"><img src="http://webimage.10x10.co.kr/eventIMG/2015/64885/img_minions.png" alt="" /></div>
		</div>

		<div class="item">
			<div class="inner">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/64885/img_item_v2.jpg" alt="텐바이텐에 찾아온 미니언즈를 여러분에게 소개합니다!" usemap="#link" /></p>
				<map name="link" id="link">
					<area shape="rect" coords="87,150,317,496" href="/shopping/category_prd.asp?itemid=1316654" alt="미니언 플레이세트 나는 핫도그 미니언 &amp; 스쿠터 탈출 미니언" />
					<area shape="rect" coords="333,152,563,496" href="/shopping/category_prd.asp?itemid=1316653" alt="미니언 무비팩 눈싸움 하는 미니언 &amp; 엉뚱한 tv와 노는 미니언" />
					<area shape="rect" coords="574,154,806,496" href="/shopping/category_prd.asp?itemid=1316651" alt="미니언 미스테리팩 2 12가지 영화 속 테마로 연출된 미니언 블록 피규어!" />
					<area shape="rect" coords="822,155,1052,496" href="/shopping/category_prd.asp?itemid=1316652" alt="미니언 미스테리팩 3 미리 겨울을 준비하는 패셔니스타 미니언즈 피규어!" />
				</map>
			</div>
		</div>

		<div class="movie">
			<div class="inner">
				<div class="youtube">
					<iframe src="https://www.youtube.com/embed/Fjr2-f5ZfSo?list=PLFatQWnQA_1oEkeVXYQN3gZK3bUAQ_uRI" frameborder="0" title="미니언즈 예고편" allowfullscreen width="544" height="363" ></iframe>
				</div>
				<div class="desc">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/64885/txt_movie.png" alt="영화 미니언즈 비켜, 이 구역의 주인공은 나야! 최고의 악당을 찾아 떠나는 슈퍼배드 원정대의 모험이 시작된다!" /></p>
					<a href="/culturestation/culturestation_event.asp?evt_code=3019"><img src="http://webimage.10x10.co.kr/eventIMG/2015/64885/btn_more.gif" alt="영화 미니언즈 더 자세히 보러 가기" /></a>
				</div>
			</div>
		</div>

		<!-- for dev msg : 앱 설치 url 문자 메시지 받기 -->
		<div class="tentenapp">
			<div class="inner">
				<p class="gift"><img src="http://webimage.10x10.co.kr/eventIMG/2015/64885/txt_gift.png" alt="지금 텐바이텐 APP에서 총 1,000명에게 선물을 쏜다! 미니언즈 피규어, 쇼퍼백, 비치볼, 우산, 영화 전용 예매권 그리고 텐바이텐 할인쿠폰까지!" /></p>
				<div class="field">
						<fieldset>
						<legend>앱 설치 url 문자 메시지 받기</legend>
							<label for="receivemsg"><img src="http://webimage.10x10.co.kr/eventIMG/2015/64885/txt_url.png" alt="앱 설치 url 문자 메시지 받기" /></label>
							<input type="text" id="receivemsg" name="usercellnum" class="itext" readonly value="<%IF NOT IsUserLoginOK THEN%>로그인 해주세요. (1일 3회)<% else %><%=usercell%><%END IF%>" />
							<div class="btnurl"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/64885/btn_url.png" alt="URL 받기" onclick="jsSubmitsms(evtfrm); return false;" /></div>
						</fieldset>
				</div>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/64885/txt_free.png" alt="※ 마이 텐바이텐에 등록된 번호로 전송되며 (1일 최대 3회), 비용은 무료입니다" /></p>
			</div>
		</div>
	</div>
	<!-- //[W] 미니언즈 -->
</form>

<script type="text/javascript">
$(function(){
	$(".running").css({"left":"100%"});
	function running() {
		$(".running").animate({"left":"50%"},2000, running);
	}
	running();
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->