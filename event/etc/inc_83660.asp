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
<%
'####################################################
' Description : 서울가요대상
' History : 2018-01-11 정태훈
'####################################################
Dim eCode, userid

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67501
Else
	eCode   =  83660
End If

userid = GetEncLoginUserID()

Dim signUpCheck, sqlStr
sqlStr = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And userid='"&userid&"'"
rsget.CursorLocation = adUseClient
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	signUpCheck = rsget(0)
End IF
rsget.close
%>
<style type="text/css">
.evt83660 .top-cont {height:790px; background:#205394 url(http://webimage.10x10.co.kr/eventIMG/2018/83660/bg_top.jpg) 50% 0 no-repeat; }
.evt83660 .top-cont h2 {padding-top:118px;}
.evt83660 .top-cont .sub {padding:28px 0;}
.evt83660 .conts {padding-bottom:126px; background-color:#371c5f;}
.evt83660 .conts .seoul-awards {padding:80px 0 10px;}
.noti {position:relative; padding:55px 0; text-align:left; color:#3f3f3f; background-color:#e5e5e5; font-size:12px; line-height:24px;}
.noti h3 {position:absolute; left:50%; top:50%; margin-left:-468px; margin-top:-12px;}
.noti ul {width:816px; margin:0 auto; padding-left:324px;}
.noti ul li {text-indent:-10px;}
.noti ul li em {color:#d515cd; font-weight:bold;}
</style>
<script type="text/javascript">
<!--
	function fnGoEnter(){
	<% If now() > #01/11/2018 00:00:00# and now() < #01/18/2018 23:59:59# then %>
		var str = $.ajax({
			type: "POST",
			url: "/event/etc/doEventSubscript83660.asp",
			data: "mode=add&eCode=<%=eCode%>",
			dataType: "text",
			async: false
		}).responseText;
		var str1 = str.split("|")
		if (str1[0] == "11"){
			$(".submit").empty().html("<img src='http://webimage.10x10.co.kr/eventIMG/2017/83156/bg_btn.jpg' /><div class='comp'><img src='http://webimage.10x10.co.kr/eventIMG/2017/83156/txt_submit_comp.png' alt='응모완료' /></div>");
			alert('응모가 완료되었습니다.');
			return false;
		}else if (str1[0] == "12"){
			alert('이벤트 기간이 아닙니다.');
			return false;
		}else if (str1[0] == "13"){
			alert('이미 응모하셨습니다.');
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
	}
//-->
</script>
					<div class="contF contW">
						<div class="evt83660">
							<div class="top-cont">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/83660/tit_seou_awards.png" alt="27th seoul music awards" /></h2>
								<p class="sub"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83660/txt_sub.png" alt="텐바이텐이 준비한 신나는 서울가요대상 초대권! 추첨을 통해 총 10분께 드립니다!" /></p>
								<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83660/txt_date.png" alt="이벤트 기간 : 1.15 ~ 1.18 ㅣ 당첨자 발표 : 1.19 (금)" /></p>
							</div>
							<div class="conts">
								<div class="seoul-awards"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83660/txt_conts.png" alt="SEOUL MUSIC AWARDS 서울가요대상 2017년 한 해 동안 대중들의 사랑을 가장 많이 받은 가수를 선정하여 시상하는 한국의 그래미어워즈. @고척 스카이돔" /></div>
								<% If userid<>"" Then %>
								<button onClick="fnGoEnter();"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83660/btn_submit.png" alt="초대권 응모 하기" /></button>
								<% Else %>
								<button onclick="top.location.href='/login/loginpage.asp?vType=G';"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83660/btn_submit.png" alt="초대권 응모 하기" /></button>
								<% End If %>
							</div>
							<div class="noti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/83660/tit_noti.png" alt="이벤트 유의사항" /></h3>
								<ul>
									<li>- 본 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 응모 불가)</li>
									<li>- 본 이벤트는 ID당 1회만 응모할 수 있습니다.</li>
									<li><em>- 초대권 배포방식: 모바일 초대권 전송 (휴대폰 MMS)</em></li>
									<li><em>- 행사 일시: 2018년 1월 25일 오후 7시</em></li>
									<li><em>- 행사 시간: 오후 7시 ~ 10시 30분 (공연순서 및 상황에 따라 변동될 수 있음)</li>
									<li><em>- 입장 시간: 공연시작 30분 전까지 입장 </em></li>
									<li><em>- 오후 6시 전까지 좌석표로 교환가능</em></li>
									<li><em>- 티켓 교환 시간: 행사 당일 오후 12시 30분 ~ 오후 6시</em></li>
									<li>- 공연 시작 후, 입장이 제한될 수 있습니다.</li>
									<li>- 당첨자 정보와 본인 확인이 일치하지 않을 경우, 티켓 교환 불가 </li>
									<li>- 티켓 (좌석표) 교환 시, 본인 신분증과 MMS (모바일 초대권 이미지, 문자 메시지)를 꼭 지참해야 교환 가능</li>
									<li>- 신분증 지참 필수 (미성년자 경우, 본인 사진이 있는 학생증)</li>
									<li>- 14세 미만은 보호자 동반 시 티켓 교환 가능 (12세 미만 / 미취학 아동은 보호자 동반 입장) </li>
									<li>- 공연 중 사진촬영 및 영상 녹화를 위한 카메라, 사다리 등 일체의 촬영장비 반입이 불가, 관람을 방해 하는 경우 강제 퇴장 될 수 있음</li>
								</ul>
							</div>
						</div>
					</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->