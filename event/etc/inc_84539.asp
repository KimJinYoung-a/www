<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/instagrameventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'####################################################
' Description : 헬로우 텐바이텐
' History : 2018-02-13 정태훈
'####################################################
Dim eCode, userid

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67508
Else
	eCode   =  84539
End If

userid = GetEncLoginUserID()

Dim sqlStr, CheckCode, CheckCnt
sqlStr = "SELECT hellokey FROM [db_temp].[dbo].[tbl_event_84539] WHERE userid='" & userid & "'"
rsget.CursorLocation = adUseClient
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	CheckCode = rsget(0)
Else
	CheckCode=""
End IF
rsget.close

sqlStr = "SELECT count(hellokey) FROM [db_temp].[dbo].[tbl_event_84539] WHERE left(usedate,10)=left(getdate(),10) and isusing='N'"
rsget.CursorLocation = adUseClient
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	CheckCnt = rsget(0)
End IF
rsget.close
%>
<style type="text/css">
.evt84539 h2 {position:relative;}
.evt84539 h2:after {content:''; display:inline-block; position:absolute; left:455px; top:152px; z-index:10; width:95px; height:95px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84539/img_character.gif) 0 0 no-repeat;}
.evt84539 .slidewrap {background:#ffda2a;}
.evt84539 .slide {overflow:visible !important; position:relative; width:830px; height:550px; margin:0 auto;}
.evt84539 .slide .slidesjs-pagination {overflow:hidden; position:absolute; left:50%; bottom:24px; width:72px; margin-left:-36px;}
.evt84539 .slide .slidesjs-pagination li {float:left; width:12px; height:12px; margin:0 6px;}
.evt84539 .slide .slidesjs-pagination li a {display:block; position:relative; z-index:30; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84539/btn_pagination.png) 0 0 no-repeat; text-indent:-999em;}
.evt84539 .slide .slidesjs-pagination li a.active {background-position:100% 0;}
.evt84539 .slide .slidesjs-navigation {display:inline-block; position:absolute; top:50%; z-index:40; width:48px; height:95px; margin-top:-47px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84539/btn_nav.png) 0 0 no-repeat; text-indent:-999em;}
.evt84539 .slide .slidesjs-previous {left:-46px;}
.evt84539 .slide .slidesjs-next {right:-46px; background-position:100% 0;}
.evt84539 .get-number {position:relative; padding:73px 0 72px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84539/bg_noise.png) 0 0 repeat;}
.evt84539 .get-number .soldout {position:absolute; left:0; top:0; z-index:20;}
.evt84539 .get-number .inner {position:relative; width:774px; height:113px; margin:0 auto; padding:10px 0 0 10px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84539/bg_number.png) 0 0 repeat;}
.evt84539 .get-number .inner input {width:450px; height:93px; font-size:29px; text-align:center; color:#000;}
.evt84539 .get-number .inner input::-ms-clear {display:none;}
.evt84539 .get-number .inner button {display:block; position:absolute; right:0; top:0; width:307px; height:123px; background-color:transparent; outline:none; animation:bounce1 1.2s 20;}
.evt84539 .noti {position:relative; padding:55px 0 55px 486px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84539/bg_noti.png) 0 0 repeat;}
.evt84539 .noti h3 {position:absolute; left:275px; top:50%; margin-top:-35px;}
.evt84539 .noti ul {padding-left:82px; color:#333; line-height:23px; border-left:1px solid #989b95; text-align:left;}
@keyframes bounce1 {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(5px); animation-timing-function:ease-in;}
}
</style>
<script style="text/javascript">
$(function(){
	$(".slide").slidesjs({
		width:"830",
		height:"550",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:600, crossfade:true}}
	});
	$("#clip").click(function(){
		$("#hellokey").select();
		document.execCommand('copy');
		alert("복사가 완료되었습니다.");
	});
});

function fnClipBoard(){
	$("#hellokey").select();
	document.execCommand('copy');
	alert("복사가 완료되었습니다.");
}

function fnGoEnter(){
<% If IsUserLoginOK() Then %>
	<% If now() > #02/13/2018 00:00:00# and now() < #02/19/2018 23:59:59# then %>
		var str = $.ajax({
			type: "POST",
			url: "/event/etc/doEventSubscript84539.asp",
			data: "mode=add",
			dataType: "text",
			async: false
		}).responseText;
		var str1 = str.split("|")
		if (str1[0] == "11"){
			//location.reload();
			$(".get-number").empty().append("<div class='inner'><input type='text' id='hellokey' value='" + str1[1] + "' readonly /><button type='button' onclick='fnClipBoard()'><img src='http://webimage.10x10.co.kr/eventIMG/2018/84539/btn_copy.png' alt='비밀번호 복사하기' /></button></div>");
			return false;
		}else if (str1[0] == "12"){
			alert('이벤트 기간이 아닙니다.');
			return false;
		}else if (str1[0] == "13"){
			alert('오류가 발생했습니다. 다시 한번 시도해 주세요.');
			location.reload();
			return false;
		}else if (str1[0] == "02"){
			alert('로그인 후 참여 가능합니다.');
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
	<% Else %>
		alert("이벤트 기간이 아닙니다.");
		return;
	<% End If %>
<% Else %>
	if(confirm("로그인 하시겠습니까?"))
	{
		top.location.href="/login/loginpage.asp?vType=G";
	}
	return false;
<% End If %>
}
</script>
						<div class="evt84539">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/84539/tit_hello.png" alt="헬로우 텐바이텐" /></h2>
							<div class="slidewrap">
								<div class="slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/84539/img_slide_1.png" alt="" />
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/84539/img_slide_2.png" alt="" />
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/84539/img_slide_3.png" alt="" />
								</div>
							</div>
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84539/txt_process.png?v=1" alt="텐바이텐에서 비밀번호 받기!→헬로우봇 앱에 접속한다→라마마에게 '헬로우 텐바이텐'이라고 말을 건다→비밀번호 입력해서 하트 받기!" /></div>
							<div class="get-number">
							<% If CheckCode<>"" Then %>
								<div class="inner">
									<input type="text" id="hellokey" value="<%=CheckCode%>" readonly />
									<button type="button" id="clip"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84539/btn_copy.png" alt="비밀번호 복사하기" /></button>
								</div>
							<% Else %>
								<% If CheckCnt>0 Then %>
									<div class="inner">
										<input type="text" value="?" readonly />
										<button type="button" onClick="fnGoEnter()"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84539/btn_get.png" alt="비밀번호 받기" /></button>
									</div>
								<% Else %>
									<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84539/txt_soldout.png" alt="오늘 비밀번호를 모두 소진 되었습니다. 내일 다시 참여해주세요!" /></p>
										<div class="inner">
											<input type="text" value="?" readonly />
											<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84539/btn_get.png" alt="비밀번호 받기" /></button>
										</div>
								<% End If %>
							<% End If %>

							</div>
							<div class="noti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/84539/tit_noti.png" alt="이벤트 유의사항" /></h3>
								<ul>
									<li>- 본 이벤트는 로그인 후 참여할 수 있습니다.</li>
									<li>- 이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
									<li>- 헬로우봇 내에서 비밀번호는 1회 입력할 수 있습니다.</li>
									<li>- 매일 선착순 1,000명에게만 비밀번호가 지급됩니다.</li>
									<li>- iOS 10.0 이상, 안드로이드 4.4 킷캣 이상만 지원됩니다.</li>
									<li>- 2월 15~18일 이내에 이벤트 오류가 있을시, 1:1 게시판을 이용해주세요.</li>
								</ul>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->