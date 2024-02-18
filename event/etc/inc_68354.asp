<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 고객님, 질문 있어요
' History : 2015.12.21 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, userid, currenttime
	IF application("Svr_Info") = "Dev" THEN
		eCode = "65997"
	Else
		eCode = "68354"
	End If

	currenttime = now()
	'currenttime = #01/08/2016 10:06:00#

	userid = GetEncLoginUserID()

dim subscriptcount, subscriptcountcurrentdate, subscriptcountend
subscriptcount=0
subscriptcountcurrentdate=0
subscriptcountend=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "1", "")
	subscriptcountcurrentdate = getevent_subscriptexistscount(eCode, userid, left(currenttime,10), "1", "")
	subscriptcountend = getevent_subscriptexistscount(eCode, userid, "", "2", "")
end if

dim datelimit
	datelimit=0

if left(currenttime,10) < "2016-01-05" then
	datelimit = 1
elseif left(currenttime,10) = "2016-01-05" then
	datelimit = 2
elseif left(currenttime,10) = "2016-01-06" then
	datelimit = 3
elseif left(currenttime,10) = "2016-01-07" then
	datelimit = 4
elseif left(currenttime,10) = "2016-01-08" then
	datelimit = 5		
end if
%>

<% '<!-- #include virtual="/lib/inc/head.asp" --> %>

<style type="text/css"> 
img {vertical-align:top;}

.contF {background-color:#fff;}
.evt68354 {background-color:#b4dfd5;}
.evt68354 .hidden {visibility:hidden; width:0; height:0;}
.evt68354 button {background-color:transparent;}

.topic {position:relative; height:344px;}
.topic .person {position:absolute; bottom:-40px; left:104px; z-index:55;}

.shake {animation-name:shake; animation-iteration-count:infinite; animation-duration:1s;}
@keyframes shake {
	from, to{margin-left:10px; animation-timing-function:ease;}
	50% {margin-left:0px; animation-timing-function:ease;}
}

.question {position:relative;}
.question .navigator {overflow:hidden; position:absolute; top:12px; right:110px; z-index:10;}
.question .navigator li {float:left; width:40px; width:40px; margin-left:5px;}
.question .navigator li a {display:block; width:40px; height:40px; background-color:#000; opacity:0; filter:alpha(opacity=0); color:#e3e9e8; font-size:9px;}
.question .navigator li a:hover {text-decoration:none;}

.question .coming {position:absolute; top:0; left:66px; z-index:50; width:1011px; height:558px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68354/bg_green_paper.png) no-repeat 50% 0;}
.question .coming span {position:absolute; top:205px; left:50%;}
.question .coming .letter1 {margin-left:-223px;}
.question .coming .letter2 {top:313px; margin-left:-175px;}
.question .thanku img {position:absolute; top:223px; left:50%; margin-left:-290px;}

.effect span {-webkit-animation-name:floater; -webkit-animation-timing-function:ease-in-out; -webkit-animation-iteration-count:infinite; -webkit-animation-duration:5s; -webkit-animation-direction:alternate; animation-name:floater; animation-timing-function:ease-in-out; animation-iteration-count:infinite; animation-duration:5s; animation-direction:alternate;}
.effect .letter2 {-webkit-animation-delay:.25s; animation-delay:.25s;}

@-webkit-keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}
@-moz-keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}
@-ms-keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}
@-o-keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}
@keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}

.question .field {position:absolute; top:153px; left:0; width:1140px; height:436px; text-align:left;}
.question .itext {margin-top:91px; margin-left:415px;}
.question .itext input {width:359px; height:40px; padding:15px 20px; background-color:transparent; line-height:40px;}
.question .itext input, .question .itext textarea {color:#1c7a66; font-family:'Dotum', 'Verdana'; font-size:24px; font-weight:bold;}
.question .btnsubmit {position:absolute; bottom:64px; left:50%; margin-left:-166px;}
.question .all {position:relative;}
.question .all .btnEnter {position:absolute; top:63px; left:50%; margin-left:-270px;}
.question .open {position:absolute; top:-20px; right:284px;}

#tabcont2 .itext {margin-left:398px;}
#tabcont2 .open {right:243px;}
#tabcont3 {text-align:left;}
#tabcont3 .item {overflow:hidden; width:914px; margin:72px auto 0;}
#tabcont3 .item ul {float:left; width:445px; margin-left:12px;}
#tabcont3 .item ul li {position:relative; height:30px; margin-bottom:38px;}
#tabcont3 .item ul li.last {margin-top:41px;}
#tabcont3 .item ul li .itext {position:absolute; top:0; left:0; margin:0;}
#tabcont3 .item ul li .itext input {position:absolute; top:0; left:0; width:30px; height:30px; padding:0;}
#tabcont3 .open {right:195px;}
#tabcont3 .item ul li label {display:block; width:415px; padding-left:30px; font-size:30px; line-height:30px; text-indent:-999em;}
#tabcont4 .itext {margin-top:152px; margin-left:342px;}
#tabcont4 .open {right:150px;}
#tabcont5 .itext {margin-top:69px; margin-left:124px;}
#tabcont5 .itext textarea {overflow:hidden; width:849px; height:133px; padding:20px; border:none; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68354/bg_textarea.png) no-repeat 50% 0;}
#tabcont5 .open {right:100px;}

.lyDone {display:none; position:fixed; top:50%; left:50%; z-index:110; margin-top:-260px; margin-left:-397px;}
.lyDone .btnClose {position:absolute; bottom:86px; left:50%; width:613px; height:82px; margin-left:-306px; color:#1c7a66; text-align:left;}

#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68354/bg_mask.png);}

.gift {position:relative;}
.gift .giftcard {position:absolute; top:32px; right:92px;}
.gift .giftcard {animation-name:bounce; animation-iteration-count:5; animation-duration:0.8s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.noti {position:relative; text-align:left;}
.noti ul {position:absolute; top:35px; left:326px;}
.noti ul li {margin-top:2px; color:#727272; font-family:'Verdana', 'Dotum';}
</style>
<script type="text/javascript">

function jseventSubmit(frm,cntval){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-01-04" and left(currenttime,10)<"2016-01-09" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcountend>0 then %>
				alert("이미 응모 하셨습니다.");
				return;
			<% else %>
				<% 'if Hour(currenttime) < 10 then %>
					//alert("쿠폰은 오전 10시부터 다운 받으실수 있습니다.");
					//return;
				<% 'else %>
					if (cntval==''){
						alert('구분자가 지정되지 않았습니다.');
						return false;
					}else if (cntval=='1' || cntval=='2' || cntval=='4'){
						if (frm.comment.value==''){
							alert('답변을 입력해 주세요.');
							frm.comment.focus();
							return false;
						}
					}else if (cntval=='3'){
						var selectedtype="";
						var selectedtypecnt="";
						for (var i=0; i < frm.commenttype.length; i++){
							if (frm.commenttype[i].checked){
								selectedtype = frm.commenttype[i].value;
								selectedtypecnt = parseInt(selectedtypecnt+ 1) ;
							}
						}
						if (selectedtype==''){
							alert('답변을 선택해 주세요.');
							frm.comment.focus();
							return false;
						}
						if (selectedtypecnt>1){
							alert('답변은 하나만 선택 하실수 있습니다.');
							frm.comment.focus();
							return false;
						}
						frm.comment.value = selectedtype;
					}else if (cntval=='5'){
						if (frm.comment.value==''){
							alert('답변을 입력해 주세요.');
							frm.comment.focus();
							return false;
						}
					}else{
						alert('정상적인 구분자가 아닙니다.');
						return;
					}

					frm.action="/event/etc/doeventsubscript/doEventSubscript68354.asp";
					frm.target="evtFrmProc";
					frm.mode.value='cnt';
					frm.cntval.value=cntval;
					frm.submit();
				<% 'end if %>
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

function jseventend(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-01-04" and left(currenttime,10)<"2016-01-09" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcountend>0 then %>
				alert("이미 응모 하셨습니다.");
				return;
			<% else %>
				<% 'if Hour(currenttime) < 10 then %>
					//alert("쿠폰은 오전 10시부터 다운 받으실수 있습니다.");
					//return;
				<% 'else %>
					var str = $.ajax({
						type: "POST",
						url: "/event/etc/doeventsubscript/doEventSubscript68354.asp",
						data: "mode=end",
						dataType: "text",
						async: false
					}).responseText;
					//alert(str);
					var str1 = str.split("||")
					//alert(str1[0]);
					if (str1[0] == "05"){
						/* layer */
						var wrapHeight = $(document).height();
						$("#lyDone").show();
						$("#dimmed").show();
						$("#dimmed").css("height",wrapHeight);
						return false;
					}else if (str1[0] == "04"){
						alert('다섯가지 답변을 모두 해주셔야 응모가 가능 합니다.');
						return false;
					}else if (str1[0] == "03"){
						alert('이미 응모 하셨습니다.');
						return false;
					}else if (str1[0] == "02"){
						alert('이벤트 응모 기간이 아닙니다.');
						return false;
					}else if (str1[0] == "01"){
						alert('로그인을 해주세요.');
						return false;
					}else{
						alert('오류가 발생했습니다.');
						return false;
					}
				<% 'end if %>
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

</script>

<!-- [W] 68354 고객님, 질문있어요! -->
<form name="evtFrm1" action="" onsubmit="return false;" method="post" style="margin:0px;">
<input type="hidden" name="mode">
<input type="hidden" name="cntval">
<div class="evt68354">
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/tit_have_a_question_v1.png" alt="고객님, 질문있어요!" /></h2>
		<p class="hidden">매일매일 질문에 답해주신 분들 중 추첨을 통해 선물을 드려요!</p>
		<span class="person shake"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/img_person.png" alt="" /></span>
	</div>

	<div id="question" class="question">
		<h3 class="hidden">다섯가지 질문</h3>
		<% '<!--for dev msg : 해당 일자에 질문에 답변하면 보여주세요 txt_coming_soon_0105 ~ txt_coming_soon_0108 --> %>
		<%
		'/응모횟수
		if subscriptcount>0 then
			'/응모 완료
			if subscriptcountend>0 then
		%>
				<% '<!--for dev msg : 5번 질문 답변하고 저장하면 아래 레이어로 보여주세요 --> %>
				<p class="coming thanku">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_thank_u.png" alt="감사합니다! 1월 12일 당첨자 발표를 확인하세요!" />
				</p>
			<% else %>
				<%
				if subscriptcount >= datelimit then
				%>
				<%
					'/오늘응모여부
					if subscriptcountcurrentdate>0 then
						if subscriptcount<5 then

				%>
							<p class="coming effect">
								<span class="letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_coming_soon.png" alt="COMING SOON" /></span>
								<span class="letter2">
									<% if subscriptcount>0 then %>
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_see_u.png" alt="내일 또 응모해주세요" />
									<% elseif subscriptcount>1 then %>
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_see_u.png" alt="내일 또 응모해주세요" />
									<% elseif subscriptcount>2 then %>
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_see_u.png" alt="내일 또 응모해주세요" />
									<% elseif subscriptcount>3 then %>
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_see_u.png" alt="내일 또 응모해주세요" />
									<% end if %>
								</span>
							</p>
						<% elseif subscriptcount>=5 then %>
							<% '<!--for dev msg : 5번 질문 답변하고 저장하면 아래 레이어로 보여주세요 --> %>
							<p class="coming thanku">
								<img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_thank_u.png" alt="감사합니다! 1월 12일 당첨자 발표를 확인하세요!" />
							</p>
						<% end if %>
					<% else %>
						<% if subscriptcount>=5 then %>
							<% '<!--for dev msg : 5번 질문 답변하고 저장하면 아래 레이어로 보여주세요 --> %>
							<p class="coming thanku">
								<img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_thank_u.png" alt="감사합니다! 1월 12일 당첨자 발표를 확인하세요!" />
							</p>
						<% end if %>
					<% end if %>

				<% end if %>
			<% end if %>
		<% end if %>

		<div id="tabcontainer" class="tabcontainer">
			<% if subscriptcount=0 then %>
				<% '<!--Q1 --> %>
				<div id="tabcont1" class="tabcont">
					<fieldset>
					<legend>텐바이텐은 무엇을 파는 곳</legend>
						<span class="open" id="close1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/ico_open.png" alt="오픈" /></span>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_question_01.png" alt="텐바이텐은 무엇을 파는 곳인가요? 텐바이텐은 을(를) 파는 곳이에요" /></p>
						<div class="field">
							<div class="itext"><input type="text" name="comment" maxlength="15" title="답변쓰기" /></div>
							<div class="btnsubmit" onclick="jseventSubmit(evtFrm1,'1'); return false;"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/68354/btn_submit.png" alt="답변 저장하기" /></div>
						</div>
					</fieldset>
				</div>
			<% elseif subscriptcount=1 then %>
				<% '<!--Q2 --> %>
				<div id="tabcont2" class="tabcont">
					<fieldset>
					<legend>텐바이텐이 선물을 준다면</legend>
						<span class="open" id="close2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/ico_open.png" alt="오픈" /></span>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_question_02.png" alt="텐바이텐이 선물을 준다면 무엇을 받고 싶나요? 저는 가 갖고 싶어요!" /></p>
						<div class="field">
							<div class="itext"><input type="text" name="comment" maxlength="15" title="답변쓰기" /></div>
							<div class="btnsubmit" onclick="jseventSubmit(evtFrm1,'2'); return false;"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/68354/btn_submit.png" alt="답변 저장하기" /></div>
						</div>
					</fieldset>
				</div>
			<% elseif subscriptcount=2 then %>
				<% '<!--Q3 --> %>
				<input type="hidden" name="comment">
				<div id="tabcont3" class="tabcont">
					<fieldset>
					<legend>텐바이텐하면 생각나는 단어</legend>
						<span class="open" id="close3"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/ico_open.png" alt="오픈" /></span>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_question_03_v1.png" alt="텐바이텐은 어떤 장르의 영화가 어울릴까요?" /></p>
						<div class="field">
							<div class="item">
								<ul>
									<li><span class="itext"><input type="checkbox" name="commenttype" value="배꼽아 나 살려라 코미디" id="genre01" /></span><label for="genre01"><span></span>배꼽아 나 살려라 코미디</label></li>
									<li><span class="itext"><input type="checkbox" name="commenttype" value="예측불가 스릴러" id="genre02" /></span><label for="genre02"><span></span>예측불가 스릴러</label></li>
									<li class="last"><span class="itext"><input type="checkbox" name="commenttype" value="감성실화 휴먼 다큐" id="genre03" /></span><label for="genre03"><span></span>감성실화 휴먼 다큐</label></li>
								</ul>
								<ul>
									<li><span class="itext"><input type="checkbox" name="commenttype" value="알콩달콩 로맨스" id="genre04" /></span><label for="genre04"><span></span>알콩달콩 로맨스</label></li>
									<li><span class="itext"><input type="checkbox" name="commenttype" value="만화보다는 애니메이션" id="genre05" /></span><label for="genre05"><span></span>만화보다는 애니메이션</label></li>
									<li class="last"><span class="itext"><input type="checkbox" name="commenttype" value="윙가르디움 판타지" id="genre06" /></span><label for="genre06"><span></span>윙가르디움 판타지</label></li>
								</ul>
							</div>
							<div class="btnsubmit" onclick="jseventSubmit(evtFrm1,'3'); return false;"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/68354/btn_submit.png" alt="답변 저장하기" /></div>
						</div>
					</fieldset>
				</div>
			<% elseif subscriptcount=3 then %>
				<% '<!--Q4 --> %>
				<div id="tabcont4" class="tabcont">
					<fieldset>
					<legend>텐바이텐하면 생각나는 단어</legend>
						<span class="open" id="close4"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/ico_open.png" alt="오픈" /></span>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_question_04.png" alt="텐바이텐하면 생각나는 단어는? 텐바이텐은 이지!" /></p>
						<div class="field">
							<div class="itext"><input type="text" name="comment" maxlength="15" title="답변쓰기" /></div>
							<div class="btnsubmit" onclick="jseventSubmit(evtFrm1,'4'); return false;"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/68354/btn_submit.png" alt="답변 저장하기" /></div>
						</div>
					</fieldset>
				</div>
			<% elseif subscriptcount>3 then %>
				<% '<!--Q5 --> %>
				<div id="tabcont5" class="tabcont">
					<fieldset>
					<legend>텐바이텐하면 생각나는 단어</legend>
						<span class="open" id="close5"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/ico_open.png" alt="오픈" /></span>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_question_05.png" alt="2016년, 텐바이텐에 바라는 한가지!" /></p>
						<div class="field">
							<div class="itext"><textarea name="comment" maxlength="100" cols="60" rows="5" title="텐바이텐에 바라는 한가지 쓰기"></textarea></div>
							<div class="btnsubmit" onclick="jseventSubmit(evtFrm1,'5'); return false;"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/68354/btn_submit.png" alt="답변 저장하기" /></div>
						</div>
					</fieldset>
				</div>
			<% end if %>
		</div>

		<div class="all">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_all.png" alt="* 모든 질문에 답해주신 분들께 응모하기 버튼이 활성화 됩니다." /></p>

			<%
			'/응모횟수
			if subscriptcount>4 then
			%>
				<% '<!--  모든 질문 답변 후 --> %>
				<button type="button" onclick="jseventend(); return false;" id="btnEnter" class="btnEnter">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/btn_enter_after.png" alt="응모하기" />
				</button>
			<% else %>
				<% '<!--  모든 질문 답변 전 --> %>
				<button type="button" class="btnEnter" style="cursor:default; outline:none;">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/btn_enter_before.png" alt="응모하기" />
				</button>
			<% end if %>
		</div>
	</div>

	<% '<!-- for dev msg : 응모하기 버튼 클릭시 나오는 팝업 --> %>
	<div id="lyDone" class="lyDone">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_done.png" alt="고객님의 소중한 의견 감사합니다" /></p>
		<button type="button" class="btnClose"><span></span>확인</button>
	</div>

	<div class="gift">
		<h3 class="hidden">멋진 답변을 해주신 당신에게 드리는 선물</h3>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/txt_gift.png" alt="* 당첨자 발표는 1월 12일 공지사항을 참고해주세요" /></p>
		<p id="animation" class="giftcard"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/img_giftcard.png" alt="16명을 추천해 텐바이텐 기프트카드 5만원을 드립니다." /></p>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68354/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 본 이벤트는 텐바이텐에서만 참여 가능합니다.</li>
			<li>- 5만원 이상의 상품을 받으신 분께는 세무신고를 위해 개인정보를 요청할 수 있습니다. 제세공과금은 텐바이텐 부담입니다.</li>
		</ul>
	</div>

	<div id="dimmed"></div>
</div>
</form>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>

<script type="text/javascript">
$(function(){
	$("#lyDone .btnClose, #dimmed").click(function(){
		$("#lyDone").slideUp();
		$("#dimmed").fadeOut();
		location.reload();
	});

	<% if subscriptcountend>0 then %>
		$("#close5").hide();
	<% elseif subscriptcount=0 then %>
		$("#close1").hide();
	<% elseif subscriptcount=1 then %>
		$("#close2").hide();
	<% elseif subscriptcount=2 then %>
		$("#close3").hide();
	<% elseif subscriptcount=3 then %>
		$("#close4").hide();
	<% elseif subscriptcount>3 then %>
		$("#close5").hide();
	<% end if %>
});
</script>

<!-- #include virtual="/lib/db/dbclose.asp" -->