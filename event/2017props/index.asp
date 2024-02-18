<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : 2017 소품전 - index
' History : 2017-03-28 이종화
'####################################################
dim nowdate
nowdate = now()

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=77059" & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

Dim vCouponMaxCount , vIsEnd , vState , vQuery , vNowTime
	vCouponMaxCount = 10 '// 일별 한정수량

'####### 쿠폰
' vState = "0" ### 이벤트 종료됨.
' vState = "1" ### 쿠폰다운가능.
' vState = "2" ### 다운 가능 시간 아님.
' vState = "3" ### 이미 받음.
' vState = "4" ### 한정수량 오버됨.
' vState = "5" ### 로그인안됨.
If IsUserLoginOK() Then
	If Now() > #04/17/2017 23:59:59# Then
		vIsEnd = True
		vState = "0"	'### 이벤트 종료됨. 0
	Else
		vIsEnd = False
	End If
	
	If Not vIsEnd Then	'### 이벤트 종료안됨.
		vQuery = "select convert(int,replace(convert(char(8),getdate(),8),':',''))"
		rsget.CursorLocation = adUseClient
		rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
		vNowTime = rsget(0)	'### DB시간받아옴.
		rsget.close

		'If vNowTime > 100000 AND vNowTime < 235959 Then	'### 10시에서 24시 사이 다운가능. 1
		If vNowTime > 100000 AND vNowTime < 235959 Then	'### 10시에서 24시 사이 다운가능. 1
			vQuery = "select count(sub_idx) from [db_event].[dbo].[tbl_event_subscript] where userid = '" & getencLoginUserid() & "' and evt_code = '77059'"
			rsget.CursorLocation = adUseClient
			rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
			If rsget(0) > 0 Then	' ### 이미 받음. 3
				vState = "3"
			End IF
			rsget.close
			
			If vState <> "3" Then	'### 한정수량 계산
				vQuery = "select count(sub_idx) from [db_event].[dbo].[tbl_event_subscript] where evt_code = '77059' and sub_opt1 = convert(varchar(10),getdate(),120)"
				rsget.CursorLocation = adUseClient
				rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
				If rsget(0) >= vCouponMaxCount Then	' 한정수량 10 오버됨. 4
					vState = "4"
				Else
					vState = "1"	'### 쿠폰다운가능.
				End IF
				rsget.close
			End IF
		Else	' ### 다운 가능 시간 아님. 2
			vState = "2"
		End IF
	End IF
Else
	vState = "5"	'### 로그인안됨.
End If
%>
<!-- #include virtual="/event/2017props/sns.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* common */
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}

.sopum .sns {height:149px; background:#85c56a url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/common/bg_pattern_green.png) 0 0 repeat-x;}
.sopum .sns .inner {position:relative; width:1140px; margin:0 auto; padding-top:53px; text-align:left; border:}
.sopum .sns h3 {padding-left:101px;}
.sopum .sns ul {position:absolute; top:49px; right:113px; float:none;}
.sopum .sns ul li {margin-left:16px; padding:0;}
.sopum .sns ul li a:hover img {animation:bouncing 2s cubic-bezier(0.19, 1, 0.22, 1) forwards;}
@keyframes bouncing {
	0% {transform:translateY(10px);}
	100% {transform:translateY(0);}
}

/* index */
.sopum button {background-color:transparent;}
.sopum .artcle {position:relative; height:1589px; background:#faf6c7 url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/bg_mountain.jpg) 50% 0 no-repeat;}
.sopum h2 {position:relative; z-index:10; padding-top:80px;}
.sopum h2 img {margin-left:-16px;}
.sopum .date {position:absolute; top:23px; left:50%; margin-left:405px;}

.bnr {overflow:hidden; position:relative; z-index:15; width:1116px; margin:0 auto; padding:369px 4px 0 20px; text-align:left;}
.bnr .friend, .bnr .gift {float:left;}
.bnr .gift {clear:left; margin-top:13px;}
.bnr .treasure {position:relative; z-index:10; float:right;}
.bnr .coupon, .bnr .land {position:absolute; top:97px; left:50%; margin-left:-209px;}
.bnr .coupon {width:434px; height:370px;}
.bnr .coupon a {height:100%;}
.bnr .coupon span {position:absolute;}
.bnr .coupon .coupon1 {top:0; left:0; z-index:5;}
.bnr .coupon .coupon2 {top:56px; right:0;}
.bnr .coupon .coupon2 span {top:0; right:0;}
.bnr .coupon .btndownload {bottom:1px; left:86px; z-index:10;}
.bnr .land {top:449px; width:369px; margin-left:-181px;}
.bnr .sticker {position:absolute; bottom:0; right:0; margin-top:13px;}
.bnr li {width:339px;}
.bnr li a {display:block; position:relative;}
.bnr .ani {*display:none; position:absolute; top:155px; left:23px;}
.bnr .land .ani {top:272px; left:40px;}

.festival {position:absolute; bottom:61px; left:50%; margin-left:-150px;}

.object {position:absolute; left:50%;}
.flame1 {top:103px; margin-left:-261px;}
.flame2 {top:50px; margin-left:122px;}
.flame3 {top:916px; margin-left:-712px;}
.flame4 {top:1063px; margin-left:-897px;}
.flame5 {top:767px; margin-left:481px;}
.flame6 {top:1048px; margin-left:660px;}
.pot {top:207px; z-index:5; margin-left:-381px;}
.toaster {top:56px; margin-left:246px;}
.balloon1 {top:69px; margin-left:-817px;}
.balloon2 {top:103px; margin-left:418px; animation:meteor 8s linear infinite; animation-delay:0.5s; opacity:0; filter:alpha(opacity=100);}
.balloon3 {top:68px; margin-left:-758px; animation:meteor 10s linear infinite; animation-delay:3s; opacity:0; filter:alpha(opacity=0);}
.balloon4 {top:153px; margin-left:458px; animation:meteor 9s linear infinite; animation-delay:4s; opacity:0; filter:alpha(opacity=0);}
.balloon5 {top:866px; margin-left:-700px; animation:meteor 10s linear infinite; animation-delay:1s;}
.balloon6 {top:968px; margin-left:766px; animation:meteor 5s linear infinite;}
.sofa {top:247px; margin-left:550px; animation:up 1.8s infinite; animation-delay:0.5s;}
.bed {top:1196px; margin-left:-643px;}
.air {top:1161px; margin-left:660px; animation:up 2s infinite; animation-delay:0.5s;}

.lyContent {display:none; position:fixed; *position:absolute; top:50%; left:50%; z-index:110; width:899px; height:598px; margin:-299px 0 0 -449px;}
.lyContent .btnGroup {position:absolute; bottom:126px; left:0; width:100%;}
.lyContent .btnGroup button,
.lyContent .btnGroup span {margin:0 50px;}
.lyContent .btnGroup button:hover img {animation:bouncing2 2s cubic-bezier(0.19, 1, 0.22, 1) forwards;}
@keyframes bouncing2 {
	0% {transform:translateY(10px); opacity:0.5;}
	100% {transform:translateY(0); opacity:1;}
}

.lyContent .btnClose {position:absolute; top:78px; right:98px;}
.lyContent .btnClose img {transition:transform .7s ease;}
.lyContent .btnClose:active img {transform:rotate(-180deg);}
#dimmed {display:none; *display:none !important; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background-color:#000; opacity:0.6; filter:alpha(opacity=60);}

/* css3 animation */
.bounce {animation:bounce 1.5s infinite alternate;}
@keyframes bounce {
	0% {transform:translateY(0);}
	100% {transform:translateY(-30px);}
}
.up {animation:up 1s infinite;}
@keyframes up {
	from, to {margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:7px; animation-timing-function:ease-in;}
}
.shake {animation:shake 1.5s infinite alternate;}
@keyframes shake {
	0% {transform:translateX(10px) translateY(5px);}
	100% {transform:translateX(0) translateY(0);}
}
.meteor {animation:meteor 10s linear infinite;}
@keyframes meteor {
	0% {margin-top:150px; opacity:1;}
	20% {margin-top:0; opacity:0;}
	100% {opacity:0;}
}
.swing {animation:swing 3s infinite;  animation-fill-mode:both; transform-origin:50% 50%;}
@keyframes swing {
	0% {transform:rotateZ(0deg);}
	30% {transform:rotateZ(5deg);}
	60% {transform:rotateZ(5deg);}
	100% {transform:rotateZ(0deg);}
}
</style>
<script type="text/javascript">
$(function(){
	/* layer */
	var wrapHeight = $(document).height();
	$(".bnr .coupon a").click(function(){
		$("#lyCoupon").show();
		$("#dimmed").show();
		$("#dimmed").css("height",wrapHeight);
	});

	$("#lyCoupon .btnClose, #dimmed").click(function(){
		$("#lyCoupon").hide();
		$("#dimmed").fadeOut();
	});
});

function propsCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If not( left(nowdate,10)>="2017-04-03" and left(nowdate,10)<"2017-04-18" ) Then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/2017props/coupon_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('쿠폰이 발급 되었습니다.\n금일 자정 까지 사용 하실 수 있습니다.');
				return false;
			}else if (str1[0] == "12"){
				alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
				return false;
			}else if (str1[0] == "13"){
				alert('이미 다운로드 받으셨습니다.');
				return false;
			}else if (str1[0] == "14"){
				alert('오늘의 한정수량이 모두 소진 되었습니다.');
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
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<%'' event area(이미지만 등록될때 / 수작업일때)  %>
					<%
						'//통계용
						If getencLoginUserid() = "greenteenz" Or getencLoginUserid() = "helele223" Or getencLoginUserid() = "ksy92630" Or getencLoginUserid() = "motions" Or getencLoginUserid() = "durida22" Then 
							Dim sqlStr
							sqlStr = " select convert(varchar(10),regdate,120) as regdate, sum(case when isusing = 'Y' then 1 else 0 end) as useY, sum(case when isusing = 'N' then 1 else 0 end) as useN , max(regdate) as endtime	from db_user.dbo.tbl_user_coupon where masteridx = '968' group by convert(varchar(10),regdate,120) "

							rsget.Open sqlStr,dbget,1
								if Not(rsget.EOF or rsget.BOF) Then
									Do Until rsget.eof
										Response.write "날짜 : "&rsget("regdate") &"<br/>"
										Response.write "사용 : "&rsget("useY") &"&nbsp;//&nbsp;"
										Response.write " 미사용 : "&rsget("useN") &"&nbsp;//&nbsp;"
										Response.write " 전체 발급 : "&(rsget("useY")+rsget("useN")) &"<br/>"
										Response.write " 타임쿠폰 발급 마감시간 : "&rsget("endtime") &"<br/>"
									rsget.movenext
									Loop
								End If
							rsget.close
						End If 
					%>
					<div class="contF contW">
						<%'' 4월 정기세일 소품전 [77059] 메인 %>
						<div class="sopum">
							<div class="artcle">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/tit_sopum.png" alt="텐바이텐 소품전 4월, 여러분의 일상을 채워드립니다!" /></h2>
								<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/txt_date.png" alt="2017년 4월 3일부터 17일 15일간" /></p>

								<ul class="bnr">
									<li class="coupon">
										<a href="#lyCoupon">
											<span class="coupon1 bounce"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_coupon_01.png" alt="쿠폰 최대 30%" /></span>
											<span class="coupon2 shake"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_coupon_02.png" alt="타임쿠폰 매일 아침 10시" /></span>
											<span class="btndownload"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/btn_download.png" alt="쿠폰 다운받기" /></span>
										</a>
									</li>
									<li class="land">
										<a href="sopumland.asp">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_sopum_land.png" alt="테마기획전 Welcome to 15가지 다양한 테마의 상품을 확인하세요!" />
											<span class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_ani_sopumland.gif" alt="" /></span>
										</a>
									</li>
									<li class="friend">
										<a href="friend.asp">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_sopum_friend.png" alt="출석체크 내 친구를 소개합니다 하루에 한번 카드를 확인하고 15가지 피규어에 응모하세요!" />
											<span class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_ani_friend.gif" alt="" /></span>
										</a>
									</li>
									<li class="treasure">
										<a href="treasure.asp">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_sopum_treasure.png" alt="상품찾기 숨은 보물 찾기 숨어있는 보물을 찾고 기프트카드 1만원권에 도전하세요!" />
											<span class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_ani_treasure.gif" alt="" /></span>
										</a>
									</li>
									<li class="gift">
										<a href="gift.asp">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_sopum_gift.png" alt="구매사은품 4월에 쇼핑하면 금액대별 구매사은품이!" />
											<span class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_ani_gift.gif" alt="" /></span>
										</a>
									</li>
									<li class="sticker">
										<a href="sticker.asp">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_sopum_sticker.png" alt="배송박스 반짝반짝 내친구 여러분의 일상 속에 반짝반짝 스티커를 붙여 주세요!" />
											<span class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_ani_sticker.gif" alt="" /></span>
										</a>
									</li>
								</ul>

								<div id="lyCoupon" class="lyContent">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/txt_coupon.png" alt="다양한 할인이 가득한 상품 쿠폰 최대 30%과 1일 한정수량 10장 매일 아침 10시에 찾아오는 타임 쿠폰 (2만원 이상 구매 시 만원 할인 사용기한 금일 자정까지)" /></p>
									<div class="btnGroup">
										<button type="button" onclick="propsCoupon('prd,prd,prd,prd,prd','12456,12457,12458,12459,12460');"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/btn_get.png" alt="상품 쿠폰 발급받기" /></button>
										<% If vIsEnd Or vState = "2" Or vState = "3" Or vState = "4" Then %>
											<% If vState = "2" Then %>
										<span onclick="alert('오전 10시부터 다운로드 가능합니다.');">
											<% ElseIf vState = "3" Then %>
										<span onclick="alert('이미 다운로드 하셨습니다.');">
											<% ElseIf vState = "4" Then %>
										<span onclick="alert('오늘의 한정수량이 모두 소진 되었습니다.');">
											<% Else %>
										<span onclick="alert('이벤트 기간이 아닙니다.');">
											<% End If %>
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/btn_done.png" alt="타임 쿠폰 발급완료" /></span>
										<% Else %>
										<button type="button" onclick="propsCoupon('evtseltoday','<%=chkiif(application("Svr_Info") = "Dev","2840","968")%>');"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/btn_get.png" alt="타임 쿠폰 발급받기" /></button>
										<% End If %>
									</div>
									<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/btn_close.png" alt="닫기" /></button>
								</div>

								<p class="festival"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/txt_sopum_festival.png" alt="Sopum Festival Characters Illustration by 더푸리빌리지" /></p>

								<span class="object flame flame1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_flame_01.gif" alt="" /></span>
								<span class="object flame flame2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_flame_02.gif" alt="" /></span>
								<span class="object flame flame3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_flame_03.gif" alt="" /></span>
								<span class="object flame flame4"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_flame_04.gif" alt="" /></span>
								<span class="object flame flame5"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_flame_05.gif" alt="" /></span>
								<span class="object flame flame6"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_flame_06.gif" alt="" /></span>
								<span class="object pot swing"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_pot.png" alt="" /></span>
								<span class="object toaster"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_electric_toaster.gif" alt="" /></span>
								<span class="object balloon balloon1 meteor"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_balloon_01.png" alt="" /></span>
								<span class="object balloon balloon2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_balloon_02.png" alt="" /></span>
								<span class="object balloon balloon3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_balloon_01.png" alt="" /></span>
								<span class="object balloon balloon4"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_balloon_02.png" alt="" /></span>
								<span class="object balloon balloon5"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_balloon_03.png" alt="" /></span>
								<span class="object balloon balloon6"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_balloon_04.png" alt="" /></span>
								<span class="object sofa"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_sofa.png" alt="" /></span>
								<span class="object air"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_hot_air_balloon.png" alt="" /></span>
								<span class="object bed bounce"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77059/img_bed.png" alt="" /></span>
							</div>
							<%'!-- sns -- include 파일 확인%>
							<div class="sns"><%=snsHtml%></div>
							<div id="dimmed"></div>
						</div>
						<%'!--// 소품전 --%>
					</div>
					<%'' //event area(이미지만 등록될때 / 수작업일때) %>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->