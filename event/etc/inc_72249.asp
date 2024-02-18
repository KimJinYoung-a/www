<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 모기잡이 이벤트 W
' History : 2016-08-04 김진영 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
Dim eCode, vUserId, eventPossibleDate
Dim strSql, totcnt, todaycnt
Dim prize1 : prize1 = 0
Dim prize2 : prize2 = 0 
Dim prize3 : prize3 = 0 
dim currenttime, toDate
currenttime =  now()
toDate		= date()
vUserId = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
	eCode 		= "66179"
	If not( left(currenttime,10) >= "2016-08-04" and left(currenttime,10) <= "2016-08-14" ) Then 
		eventPossibleDate = False
	Else
		eventPossibleDate = True
	End If
Else
	eCode 		= "72249"
	If not( left(currenttime,10) >= "2016-08-08" and left(currenttime,10) <= "2016-08-14" ) Then 
		eventPossibleDate = False
	Else
		eventPossibleDate = True
	End If
End If

If IsUserLoginOK Then 
	'// 출석 여부
	strSql = ""
	strSql = strSql & " SELECT isnull(sum(CASE WHEN convert(varchar(10), t.regdate, 120) = '"& toDate &"' THEN 1 ELSE 0 END ),0) as todaycnt "
	strSql = strSql & " ,count(*) as totcnt "
	strSql = strSql & " FROM db_temp.[dbo].[tbl_event_attendance] as t "
	strSql = strSql & " INNER JOIN db_event.dbo.tbl_event as e "
	strSql = strSql & " on t.evt_code = e.evt_code and convert(varchar(10),t.regdate,120) between convert(varchar(10),e.evt_startdate,120) and convert(varchar(10),e.evt_enddate,120) "
	strSql = strSql & "	WHERE t.userid = '"& vUserId &"' and t.evt_code = '"& eCode &"' " 
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		todaycnt = rsget("todaycnt") '// 오늘 출석 여부 1-ture 0-false
		totcnt = rsget("totcnt") '// 내 전체 출석수
	End IF
	rsget.close()

	'// 각 상품 응모 여부
	strSql = ""
	strSql = strSql & " SELECT "
	strSql = strSql & "	isnull(sum(case when sub_opt1 = 2 THEN 1 else 0 end),0) as prize1 "
	strSql = strSql & "	,isnull(sum(case when sub_opt1 = 5 THEN 1 else 0 end),0) as prize2 "
	strSql = strSql & "	,isnull(sum(case when sub_opt1 = 7 THEN 1 else 0 end),0) as prize3  "
	strSql = strSql & "	FROM db_event.dbo.tbl_event_subscript "
	strSql = strSql & "	WHERE evt_code = '"& eCode &"' and userid = '"& vUserId &"' "
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		prize1	= rsget("prize1")	'// 2일차 응모
		prize2	= rsget("prize2")	'//	5일차 응모
		prize3	= rsget("prize3")	'//	7일차 응모
	End IF
	rsget.close()
End If 
%>
<style type="text/css">
img {vertical-align:top;}

.catchMosquito button {background-color:transparent;}

.catch {position:relative; height:993px; background:#202639 url(http://webimage.10x10.co.kr/eventIMG/2016/72249/bg_room.jpg) no-repeat 50% 0;}
.catch h2 {position:absolute; top:101px; left:342px;}
.catch h3 {position:absolute; bottom:95px; left:50%; margin-left:-217px;}
.catch .light {position:absolute; top:288px; left:70px;}
.catch .light {animation-name:move; animation-iteration-count:infinite; animation-duration:10s; animation-delay:5s;}
@keyframes move {
	from, to{left:60px;}
	50% {left:620px;}
}

.catch .light2 {top:250px; left:650px;}
.catch .light3 {top:288px; left:370px;}
.catch .mosquito {position:absolute; top:508px; left:128px; width:84px; height:64px;}
.catch .mosquito span {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72249/img_mosquito.png) no-repeat 0 -179px; text-indent:-9999em;}
.catch .mosquito1 .on {background-position:0 -522px;}
.catch .mosquito2 {top:419px; left:221px; animation-delay:2.2s;}
.catch .mosquito2 span {top:419px; left:222px; background-position:-94px -91px;}
.catch .mosquito2 .on {background-position:-94px -434px;}
.catch .mosquito3 {top:430px; left:370px;}
.catch .mosquito3 span {top:430px; left:263px; background-position:-250px -102px;}
.catch .mosquito3 .on {background-position:-250px -445px;}
.catch .mosquito4 {top:613px; left:295px;}
.catch .mosquito4 span {top:430px; left:263px; background-position:-168px -285px;}
.catch .mosquito4 .on {background-position:-168px 100%;}
.catch .mosquito5 {top:400px; left:700px;}
.catch .mosquito5 span {top:430px; left:263px; background-position:-573px -72px;}
.catch .mosquito5 .on {background-position:-573px -415px;}
.catch .mosquito6 {top:382px; left:934px;}
.catch .mosquito6 span {top:430px; left:263px; background-position:100% 0;}
.catch .mosquito6 .on {background-position:100% -343px;}
.catch .mosquito7 {top:549px; left:797px;}
.catch .mosquito7 span {top:430px; left:263px; background-position:-670px -221px;}
.catch .mosquito7 .on {background-position:-670px -564px;}

.flying {animation-name:flying; animation-iteration-count:infinite; animation-duration:1.5s;}
@keyframes flying {
	from, to{margin-left:0; animation-timing-function:ease-out;}
	50% {margin-left:5px; animation-timing-function:ease-in;}
}
.flying2 {animation-name:flying2; animation-iteration-count:infinite; animation-duration:1.5s;}
@keyframes flying2 {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.catch .btnClick {position:absolute; top:466px; left:500px;}
.catch .btnClick .flyswatter img {animation-name:pulse; animation-duration:1s; animation-iteration-count:2; animation-delay:2s;}
.catch .btnClick:hover img {animation-name:pulse; animation-duration:1s; animation-iteration-count:infinite;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(0.9);}
	100% {transform:scale(1);}
}

.catch .btnClick .word {position:absolute; top:59px; left:31px; z-index:5;}
.catch .btnClick .word {animation-name:flash; animation-duration:2s; animation-fill-mode:both; animation-iteration-count:infinite;}
@keyframes flash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}

.catch .count {position:absolute; bottom:51px; left:0; width:100%;}
.catch .count p {margin-top:21px;}
.catch .count p b {color:#ffef68; padding-bottom:2px; border-bottom:1px solid #ffef68; font-family:'Dotum', '돋움', 'Verdana'; font-size:18px; line-height:19px;}

.gift {padding-bottom:47px; background-color:#a6dce6;}
.gift ol {overflow:hidden; width:1035px; margin:0 auto;}
.gift ol li {float:left; position:relative; margin:0 1px;}
.gift ol li button {position:absolute; bottom:57px; right:43px;}

.noti {position:relative; padding:50px 0; background-color:#ececec; text-align:left;}
.noti h3 {position:absolute; top:50%; left:96px; margin-top:-33px;}
.noti ul {margin-left:271px; padding-left:45px; border-left:1px solid #dbdbdb;}
.noti ul li {position:relative; margin-top:6px; padding-left:10px; color:#6d6d6d; font-family:'굴림', 'Gulim', 'Arial'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#6d6d6d;}
.noti ul li b {color:#213f9e; font-weight:normal;}
.noti .bnr {position:absolute; top:50%; right:69px; margin-top:-54px;}
</style>
<script type="text/javascript">
$(function(){
	/* title animation */
	function animation() {
		$("#animation").delay(100).effect("shake", {direction:"center", times:5, easing:"easeInOutCubic"},800);
	}
	animation();
});

<%''// 출석체크 %>
function jsdailychk(){
<% If IsUserLoginOK() Then %>
	<% If eventPossibleDate = False Then %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% Else %>
		var result;
		$.ajax({
			type:"GET",
			url:"/event/etc/doeventsubscript/doEventSubscript72249.asp",
			data: "mode=daily",
			dataType: "text",
			async:false,
			cache:false,
			success : function(Data){
				result = jQuery.parseJSON(Data);
				if (result.resultcode=="22"){
					alert('하루에 한번만 모기를 잡을 수 있습니다.');
					return;
				}else if (result.resultcode=="44"){
					alert('로그인이 필요한 서비스 입니다.');
					return;
				}else if (result.resultcode=="11"){
					alert('오늘의 모기를 잡았습니다.');
					location.reload();
					return;
				}else if (result.resultcode=="88"){
					alert('이벤트 응모 기간이 아닙니다.');
					return;
				}
			}
		});
	<% End If %>
<% Else %>
	if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
		var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
		winLogin.focus();
		return false;
	}
	return false;
<% End IF %>
	
}

<%''// 응모 %>
function jsCatches(v){
<% If IsUserLoginOK() Then %>
	<% If eventPossibleDate = False Then %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% Else %>
		var result;
		$.ajax({
			type:"GET",
			url:"/event/etc/doeventsubscript/doEventSubscript72249.asp",
			data: "mode=mogis&catches="+v,
			dataType: "text",
			async:false,
			cache:false,
			success : function(Data){
				result = jQuery.parseJSON(Data);
				if (result.resultcode=="77"){
					alert('응모가 완료 되었습니다.\n마일리지는 8월 17일에\n일괄 지급될 예정입니다.');
					location.reload();
					return;
				} else if (result.resultcode=="11"){
					alert('응모가 완료되었습니다.\n당첨자는 추첨을통해\n8월 17일에 발표할 예정입니다.');
					location.reload();
					return;
				} else if (result.resultcode=="33"){
					alert('모기를 더 잡아주세요.');
					return;
				} else if (result.resultcode=="88"){
					alert('이벤트 응모 기간이 아닙니다.');
					return;
				} else if (result.resultcode=="99"){
					alert('이미 응모 하셨습니다.\n감사합니다.');
					return;
				}else if (result.resultcode=="44"){
					alert('로그인이 필요한 서비스 입니다.');
					return;
				}else if (result.resultcode=="66"){
					alert('잘못된 접속입니다.');
					return;
				}
			}
		});
	<% End If %>
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
<div class="evt72249 catchMosquito">
	<div class="catch">
		<h2 id="animation"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/tit_catch_mosquito.png" alt="매일 모기잡고 다양한 경품에 응모하세요! 모기다잉~" /></h2>
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/tit_click_everyday.png" alt="매일 한 번씩 모기채를 클릭해주세요!" /></h3>

		<div class="light"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/img_light.png" alt="" /></div>
<%
	If eventPossibleDate = False Then 
%>
		<button type="button" class="btnClick">
			<span class="flyswatter"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_fly_swatter.png" alt="모기채" /></span>
		</button>
<%
	Else 
		If todaycnt = 0 then 
		' for dev msg : 버튼 클릭 후 버튼은 숨겨주세요. 
%>
		<button type="button" class="btnClick" onclick="jsdailychk(); return false;">
			<span class="word"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/txt_click.png" alt="Click" /></span>
			<span class="flyswatter"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_fly_swatter.png" alt="" /></span>
		</button>
<%
		Else
%>
		<button type="button" class="btnClick">
			<span class="flyswatter"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_fly_swatter.png" alt="모기채" /></span>
		</button>
<%
		End If
	End If
%>

		<%' for dev msg : 버튼 클릭시 모기에 클래스 on 붙여주세요 %>
		<span class="mosquito mosquito1 flying2"><span <%= Chkiif(totcnt >= 1, " class='on'", "") %>>모기 하나</span></span>
		<span class="mosquito mosquito2 flying"><span <%= Chkiif(totcnt >= 2, " class='on'", "") %>>모기 둘</span></span>
		<span class="mosquito mosquito3"><span <%= Chkiif(totcnt >= 3, " class='on'", "") %>>모기 셋</span></span>
		<span class="mosquito mosquito4"><span <%= Chkiif(totcnt >= 4, " class='on'", "") %>>모기 넷</span></span>
		<span class="mosquito mosquito5 flying"><span <%= Chkiif(totcnt >= 5, " class='on'", "") %>>모기 다섯</span></span>
		<span class="mosquito mosquito6"><span <%= Chkiif(totcnt >= 6, " class='on'", "") %>>모기 여섯</span></span>
		<span class="mosquito mosquito7 flying2"><span <%= Chkiif(totcnt >= 7, " class='on'", "") %>>모기 일곱</span></span>
		<%' for dev msg : 모기 잡은 횟수 카운트 %>
		<div class="count">
		<% If vUserId <> "" Then %>
			<p>
				<b><%= vUserId %></b>
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/txt_count_01.png" alt="님이 총" />
				<b><%= totcnt %></b>
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/txt_count_02.png" alt="마리의 모기를 잡았습니다." />
			</p>
		<% End If %>
		</div>
	</div>

	<div class="gift">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/tit_gift.png" alt="모기 잡고 선물 받기 잡은 모기의 수만큼 응모하실 수 있어요!" /></h3>
		<ol>
			<li>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/img_gift_01.jpg" alt="모기 2마리를 잡고 응모하신 모든 분께 100마일리지를 드립니다." /></p>
		<% If totcnt < 2 Then %>
				<button type="button" onclick="alert('모기를 더 잡아주세요.');"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_apply_disable.png" alt="신청하기x" /></button>
		<% Else %>
			<% If prize1 = 1 Then %>
				<button type="button" onclick="alert('이미 신청하셨습니다.\n감사합니다.');"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_apply_done.png" alt="신청완료" /></button>
			<% Else %>
				<button type="button" onclick="jsCatches('2'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_apply.png" alt="신청하기" /></button>
			<% End If %>
		<% End If %>
			</li>
			<li>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/img_gift_02.jpg" alt="모기 5마리를 잡고 응모하신 분께는 추첨을 통해 500분께 모기 기피제를 드립니다." /></p>
		<% If totcnt < 5 then %>
			<button type="button" onclick="alert('모기를 더 잡아주세요.');"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_enter_disable.png" alt="응모하기x" /></button>
		<% Else %>
			<% If prize2 = 1 Then %>
				<button type="button" onclick="alert('이미 응모하셨습니다.\n감사합니다.');"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_enter_done.png" alt="응모완료" /></button>
			<% Else %>
				<button type="button" onclick="jsCatches('5'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_enter.png" alt="응모하기" /></button>
			<% End If %>
		<% End If %>
			</li>
			<li>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/img_gift_03.jpg" alt="모기 7마리를 잡고 응모하신 모든 분께 700마일리지를 드립니다." /></p>
		<% If totcnt < 7 Then %>
				<button type="button" onclick="alert('모기를 더 잡아주세요.');"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_apply_disable.png" alt="신청하기x" /></button>
		<% Else %>
			<% If prize3 = 1 Then %>
				<button type="button" onclick="alert('이미 신청하셨습니다.\n감사합니다.');"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_apply_done.png" alt="신청완료" /></button>
			<% Else %>
				<button type="button" onclick="jsCatches('7'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/btn_apply.png" alt="신청하기" /></button>
			<% End If %>
		<% End If %>
			</li>
		</ol>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li><span></span><b>하루 한 마리</b>의 모기만 잡을 수 있습니다.</li>
			<li><span></span>모기 잡은 개수에 따라서 각 경품에 응모 및 신청할 수 있습니다.</li>
			<li><span></span>이벤트 기간 후에 응모하실 수 없습니다.</li>
			<li><span></span>이벤트를 통해 받으실 마일리지는 <b>2016년 8월 17일(수요일)에 일괄 지급</b>됩니다.</li>
			<li><span></span>당첨자 안내 공지는 2016년 8월 17일(수요일)에 진행됩니다.</li>
		</ul>
		<div class="bnr">
			<a href="/event/eventmain.asp?eventid=72307"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72249/img_bnr.jpg" alt="트래블 시즌오프 기획전으로 이동" /></a>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->