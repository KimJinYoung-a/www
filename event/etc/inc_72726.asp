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
		eCode = "66188"
	Else
		eCode = "72726"
	End If

userid = getEncLoginUserID

'strSql = "select top 5 userid, regdate, sub_opt2 from [db_event].[dbo].[tbl_event_subscript] where evt_code = '" & eCode & "' order by sub_idx desc"
'rsget.CursorLocation = adUseClient
'rsget.Open strSql,dbget,adOpenForwardOnly,adLockReadOnly
'if not rsget.eof then
'	vArr = rsget.getRows()
'end if
'rsget.close


'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] 프리티켓")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
%>
<style type="text/css">
img {vertical-align:top;}

#contentWrap {padding-bottom:0;}

.prettyTicket .topic {position:relative; height:741px; background:#fcd3d0 url(http://webimage.10x10.co.kr/eventIMG/2016/72726/bg_pink_sky.jpg) no-repeat 50% 0;}
.prettyTicket .topic .hashtag {position:absolute; top:0; left:50%; z-index:5; margin-left:-199px;}
.prettyTicket .topic .hgroup {position:absolute; top:108px; left:50%; z-index:5; width:362px; height:495px; margin-left:-532px;}
.prettyTicket .topic .hgroup span {position:absolute; top:0; left:109px;}
.prettyTicket .topic .hgroup p {position:absolute; bottom:0; left:0;}
.prettyTicket .topic .item {position:absolute; top:0; left:50%; margin-left:-570px;}
.prettyTicket .topic .item .date {position:absolute; bottom:101px; right:362px;}
.prettyTicket .topic .item .date {animation-name:up; animation-timing-function:ease-out; animation-duration:0.5s; animation-fill-mode:both; animation-iteration-count:1; animation-delay:1.2s;}
.prettyTicket .topic .item .date img {animation-delay:3s;}
.prettyTicket .topic .item strong {position:absolute; bottom:100px; right:21px; width:317px; height:74px;}
.prettyTicket .topic .item strong span {display:block; position:absolute;}
.prettyTicket .topic .item strong .letter {top:0; left:0; width:45px; height:74px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_price_v1.png) no-repeat 0 0; text-indent:-999em;}
.prettyTicket .topic .item strong .letter2 {left:45px; width:42px; background-position:-45px 0;}
.prettyTicket .topic .item strong .letter3 {left:87px; width:21px; background-position:-87px 0;}
.prettyTicket .topic .item strong .letter4 {left:109px; width:46px; background-position:-108px 0;}
.prettyTicket .topic .item strong .letter5 {left:156px; width:52px; background-position:-154px 0;}
.prettyTicket .topic .item strong .letter6 {left:209px; width:50px; background-position:-206px 0;}
.prettyTicket .topic .item strong .letter7 {left:256px; width:58px; background-position:-256px 0;}
.prettyTicket .topic .item strong .limited {position:absolute; top:-50px; right:0; width:63px;}

.prettyTicket .topic .item strong span {animation-name:up; animation-timing-function:ease-out; animation-duration:0.5s; animation-fill-mode:both; animation-iteration-count:1; animation-delay:1.4s;}
.prettyTicket .topic .item strong .letter2 {animation-delay:1.6s;}
.prettyTicket .topic .item strong .letter3 {animation-delay:1.8s;}
.prettyTicket .topic .item strong .letter4 {animation-delay:2s;}
.prettyTicket .topic .item strong .letter5 {animation-delay:2.1s;}
.prettyTicket .topic .item strong .letter6 {animation-delay:2.4s;}
.prettyTicket .topic .item strong .letter7 {animation-delay:2.6s;}
.prettyTicket .topic .item strong .limited {animation-delay:2.8s;}
@keyframes up {
	0% {transform:translateY(-30px); opacity:0;}
	100% {transform:translateY(0%); opacity:1;}
}

.shake {animation-name:shake; animation-iteration-count:infinite; animation-duration:4s;}
@keyframes shake {
	from, to{ margin-left:10px; animation-timing-function:ease-out;}
	50% {margin-left:0; animation-timing-function:ease-in;}
}
.updown {animation-name:updown; animation-iteration-count:infinite; animation-duration:1.5s; animation-delay:4s;}
@keyframes updown {
	from, to{margin-top:0; animation-timing-function:linear;}
	50% {margin-top:5px; animation-timing-function:linear;}
}
.flip {animation-name:flip; animation-duration:1.5s; animation-iteration-count:1; backface-visibility:visible;}
@keyframes flip {
	0% {transform:rotateY(120deg) translateY(30px); opacity:0.5; animation-timing-function:ease-out;}
	100% {transform:rotateY(360deg) translateY(0); opacity:1; animation-timing-function:ease-in;}
}
.flash {animation-name:flash; animation-duration:2s; animation-iteration-count:infinite; animation-fill-mode:both;}
@keyframes flash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}

.prettyTicket .share {position:relative; height:138px; background:#ed759a url(http://webimage.10x10.co.kr/eventIMG/2016/72726/bg_pink.jpg) no-repeat 50% 0;}
.prettyTicket .share h3 {position:absolute; top:63px; left:50%; margin-left:-452px;}
.prettyTicket .share ul {position:absolute; top:49px; left:50%; width:382px; margin-left:88px;}
.prettyTicket .share ul li {float:left; margin-right:16px;}
.prettyTicket .share ul li a:hover img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.5s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

/* 구매편 */
.getTicket {background:#fcd3d0 url(http://webimage.10x10.co.kr/eventIMG/2016/72726/bg_pink_sky_v1.jpg) no-repeat 50% 0;}
.getTicket .topic {height:710px; background:none;}
.getTicket .topic .item strong {position:absolute; bottom:66px; right:120px; width:368px;}

.getTicket .ticket {width:1140px; height:541px; margin:0 auto; text-align:left;}
.getTicket .ticket .month {position:relative; padding:72px 0 0 57px;}
.getTicket .ticket .november {padding-top:48px;}
.getTicket .ticket .btnGet {position:absolute; top:103px; right:0;}
.getTicket .ticket .november .btnGet {top:80px;}

.getTicket .share {height:132px; background:none;}

.thankYou {height:131px;}
.thankYou p {padding-top:57px;}
</style>
<script type="text/javascript">
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


<% 
	'// 오픈시 적용해줘야 되는 날짜
	If Now() >= #08/23/2016 00:00:00# And now() < #09/01/2016 10:00:00# Then 

	'// 요건 테스트용 날짜
'	If Now() >= #08/23/2016 00:00:00# And now() < #08/30/2016 10:00:00# Then 
%>
<%' 요건 티저 %>
	<div class="evt72726 prettyTicket">
		<div class="topic">
			<p class="hashtag"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_hash_tag.png" alt="#텐바이텐과 함께 #재미있게진에어" /></p>
			<div class="hgroup flip">
				<span class="updown"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/ico_doll.png" alt="" /></span>
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/tit_pretty_ticket.png" alt="두번째 스페셜 티켓 프리티켓" /></h2>
				<p class="shake"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_tokyo.png" alt="도쿄 나리타공항 전 일정 2박 3일" /></p>
			</div>
			<div class="item">
				<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_date_01.png" alt="9월 1일 10시 티켓판매 오픈!" class="flash" /></p>
				<strong>
					<span class="letter letter1">5</span>
					<span class="letter letter2">5</span>
					<span class="letter letter3">,</span>
					<span class="letter letter4">8</span>
					<span class="letter letter5">0</span>
					<span class="letter letter6">0</span>
					<span class="letter letter7">원부터</span>
					<span class="limited"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_limited.png" alt="" /></span>
				</strong>
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/img_item_01_v2.jpg" alt="프리티켓은 200개 한정수량으로 파우치, 기름종이, 티나롤과 왕복티켓으로 구성되어있습니다" />
			</div>
		</div>

		<%' for dev msg : sns %>
		<div class="share">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/tit_sns.png" alt="친구와 함께 텐바이텐과 진에어의 콜라보레이션 프리티켓에 도전하세요!" /></h3>
			<ul>
				<li class="facebook"><a href="" onclick="snschk('fb');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/ico_facebook.png" alt="페이스북에 공유하기" /></a></li>
				<li class="twitter"><a href="" onclick="snschk('tw');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/ico_twitter.png" alt="트위터에 공유하기" /></a></li>
			</ul>
		</div>

		<div class="thankYou">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_thank_you.png" alt="친구와 함께 텐바이텐과 진에어의 콜라보레이션 프리티켓이 조기마감 되었습니다! 감사합니다." /></p>
		</div>
	</div>

<% 
	'// 오픈시 적용해줘야 되는 날짜
	ElseIf Now() >= #09/01/2016 10:00:00# And now() < #09/11/2016 00:00:00# Then 

	'// 요건 테스트용 날짜
'	ElseIf Now() >= #08/31/2016 10:00:00# And now() < #09/14/2016 00:00:00# Then 

%>
<%' 요건 상품구매 %>
	<div class="evt72726 prettyTicket getTicket">
		<div class="topic">
			<p class="hashtag"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_hash_tag.png" alt="#텐바이텐과 함께 #재미있게진에어" /></p>
			<div class="hgroup flip">
				<span class="updown"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/ico_doll.png" alt="" /></span>
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/tit_pretty_ticket.png" alt="두번째 스페셜 티켓 프리티켓" /></h2>
				<p class="shake"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_tokyo.png" alt="도쿄 나리타공항 전 일정 2박 3일" /></p>
			</div>
			<div class="item">
				<strong>
					<span class="letter letter1">5</span>
					<span class="letter letter2">5</span>
					<span class="letter letter3">,</span>
					<span class="letter letter4">8</span>
					<span class="letter letter5">0</span>
					<span class="letter letter6">0</span>
					<span class="letter letter7">원부터</span>
					<span class="limited"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_limited_02.png" alt="" class="flash" /></span>
				</strong>
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/img_item_02.jpg" alt="프리티켓은 한정수량으로 파우치, 기름종이, 티나롤과 왕복티켓으로 구성되어있습니다" />
			</div>
		</div>

		<%' for dev msg : 티켓 구매 %>
		<div class="ticket">
			<div class="month october">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_month_october.png" alt="10월 100석 한정 전 일정 2박 3일! 3일, 5일, 11일, 16일, 19일, 23일, 24일 출발은 55,800원, 6일, 13일 출발은 75,800원, 28일 출발 은 95,800원입니다. 인천 출발 오전 7시 25분 나리타 오전 9시 50분 도착, 나리타 출발 17시 55분 인천 도착 20시 25분, 나리타 출발 
				20시 인천 도착 22시 40분 도착 스케쥴로 모든 노선별 운임은 무료 수하물이 포함된 왕복 총액운임입니다." /></p>
				<% 	
					'// 개발서버 코드
'					If getitemlimitcnt("1239277") < 1 Then 
					'// 실서버 코드
					If getitemlimitcnt("1556864") < 1 Then 
				%>
					<%' for dev msg : 매진될 경우 %>
					<strong class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/btn_soldout.png" alt="매진" /></strong>
				<% Else %>
					<%
						'// 스탭은 참여제한
						If GetLoginUserLevel=7 Then
					%>
						<a href="" onclick="alert('텐바이텐 스탭은 참여가 불가 합니다.');return false;" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/btn_get.png" alt="최소분 일부 오픈! 구매하러 가기" /></a>
					<% Else %>
						<a href="/shopping/category_prd.asp?itemid=1556864&amp;pEtr=72726" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/btn_get.png" alt="최소분 일부 오픈! 구매하러 가기" /></a>
					<% End If %>

				<% End If %>
			</div>

			<div class="month november">
				<%' for dev msg : 오픈 전 / 9월 5일 오전 10시 오픈 후 이미지는 txt_month_november.png입니다. %>
				<%
					'// 오픈시 적용날짜
						If Now() >= #09/05/2016 10:00:00# And now() < #09/11/2016 00:00:00# Then 

					'// 테스트용 적용날짜
'					If Now() >= #08/31/2016 10:00:00# And now() < #09/11/2016 00:00:00# Then 
				%>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_month_november.png" alt="11월 100석 한정 전 일정 2박 3일! 6일, 8일, 13일, 15일, 20일, 22일 출발은 55,800원, 17일, 19일, 24일 출발은 75,800원, 25일 출발 은 95,800원입니다. 인천 출발 오전 7시 25분 나리타 오전 9시 50분 도착, 나리타 출발 20시 인천 도착 22시 40분 도착 스케쥴로 모든 노선별 운임은 무료 수하물이 포함된 왕복 총액운임입니다." /></p>
					<% 	If getitemlimitcnt("1557950") < 1 Then %>
						<%' for dev msg : 매진될 경우 %>
						<strong class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/btn_soldout.png" alt="매진" /></strong>
					<% Else %>
						<%' for dev msg : 오픈 후 %>
						<%
							'// 스탭은 참여제한
							If GetLoginUserLevel=7 Then
						%>
							<a href="" onclick="alert('텐바이텐 스탭은 참여가 불가 합니다.');return false;" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/btn_get_november.png" alt="11월 일정 예약하러 가기" /></a>
						<% Else %>
							<a href="/shopping/category_prd.asp?itemid=1557950&amp;pEtr=72726" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/btn_get_november.png" alt="11월 일정 예약하러 가기" /></a>
						<% End If %>
					<% End If %>
				<% Else %>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_month_november_coming.png" alt="11월 100석 한정 전 일정 2박 3일! 6일, 8일, 13일, 15일, 20일, 22일 출발은 55,800원, 17일, 19일, 24일 출발은 75,800원, 25일 출발 은 95,800원입니다. 인천 출발 오전 7시 25분 나리타 오전 9시 50분 도착, 나리타 출발 20시 인천 도착 22시 40분 도착 스케쥴로 모든 노선별 운임은 무료 수하물이 포함된 왕복 총액운임입니다." /></p>
					<%' for dev msg : 오픈 전 %>
					<div class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/btn_get_november_coming.png" alt="9월 5일 티켓 판매 오픈!" /></div>
				<% End If %>
			</div>
		</div>

		<%' for dev msg : sns %>
		<div class="share" style="display:none;">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/tit_sns.png" alt="친구와 함께 텐바이텐과 진에어의 콜라보레이션 프리티켓에 도전하세요!" /></h3>
			<ul>
				<li class="facebook"><a href="" onclick="snschk('fb');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/ico_facebook.png" alt="페이스북에 공유하기" /></a></li>
				<li class="twitter"><a href="" onclick="snschk('tw');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/ico_twitter.png" alt="트위터에 공유하기" /></a></li>
			</ul>
		</div>

		<div class="thankYou">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72726/txt_thank_you.png" alt="친구와 함께 텐바이텐과 진에어의 콜라보레이션 프리티켓이 조기마감 되었습니다! 감사합니다." /></p>
		</div>
	</div>
<% Else %>

<% End If %>



<!-- #include virtual="/lib/db/dbclose.asp" -->