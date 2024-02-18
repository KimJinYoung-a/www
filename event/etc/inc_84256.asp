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
' Description : 메달 개수를 맞춰라!
' History : 2018-02-07 정태훈
'####################################################
Dim eCode, userid, SubIdx, KorMedalCnt

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67504
	SubIdx	=	3819675
Else
	eCode   =  84256
	SubIdx	=	9260329
End If

userid = GetEncLoginUserID()

Dim strSql, MedalInfoArr
strSql ="select top 1 sub_opt2 from [db_event].[dbo].[tbl_event_subscript] where sub_idx='"&SubIdx&"'"
dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"EVTMEDAL",strSql,60*5)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	MedalInfoArr = rsMem.GetRows()
	if isArray(MedalInfoArr) Then
		KorMedalCnt=MedalInfoArr(0,0)
	End If
Else
	KorMedalCnt=0
END IF
rsMem.close

Dim sqlStr, MedalCnt
sqlStr = "SELECT sub_opt2 FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And userid='"&userid&"'"
rsget.CursorLocation = adUseClient
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	MedalCnt = rsget(0)
Else
	MedalCnt=0
End IF
rsget.close
%>
<script type="text/javascript" src="/lib/js/jquery.rollingCounter.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easing.js"></script>
<style>
.evt84256 {background:#1a176b url(http://webimage.10x10.co.kr/eventIMG/2018/84256/bg_medal.png) no-repeat 0 0;}
.headline {position:relative; width:100%; padding-top:333px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84256/deco_title_line.png) no-repeat 50% 171px;}
.headline h2 {position:absolute; left:50%; top:134px; margin-left:-317px; animation:fly .8s 1 forwards; -webkit-animation:fly .8s 1 forwards;}
.headline .deco {display:block; position:absolute; left:50%; top:82px; margin-left:217px; width:268px; height:196px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84256/deco_title_ski.png) no-repeat 0 0; animation:ski 1.5s; -webkit-animation:ski 1.5s;}
.event-view {overflow:hidden; padding:40px 120px 0;}
.event-view .count-view {position:relative; float:left; width:450px; height:585px; background-position:50% 0; background-repeat:no-repeat;}
.event-view .count-view strong {display:none; visibility:hidden; position:absolute; font-size:0; height:0;}
.event-view .count-view .counter-area {overflow:hidden; position:absolute; left:0px; top:323px; width:227px; height:86px; text-align:right;}
.event-view .count-view .counter-holder {padding:15px 0; text-align:right;}
.event-view .count-view .counter-holder span {position:relative; display:inline-block; vertical-align:top; line-height:56px;}
.event-view .count-view .counter .digit {overflow:hidden; height:56px; padding:0; margin:0; text-align:center; font-weight:bold; font-size:56px; font-family:verdana, sans-serif;}
.event-view div.real-num {color:#000; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84256/img_real.png);}
.event-view div.real-num .counter .digit {color:#000;}
.event-view div.real-num p {position:absolute; left:0; top:427px; width:100%; color:#7a7a7a; font-family:dotum, sans-serif;}
.event-view div.mine-num {color:#fff; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84256/img_mine.png);}
.event-view div.mine-num .counter-area {width:234px;}
.event-input {padding-bottom:88px;}
.event-input .input-box {position:relative; width:456px; height:120px; margin:35px auto 20px auto; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84256/bg_input.png) no-repeat 50% 0; text-align:left; vertical-align:top;}
.event-input .input-box p {padding:45px 40px;}
.event-input .input-box input[type=number] {height:33px; padding-right:10px; font-size:40px; line-height:4px; font-family:verdana, sans-serif; color:#000; text-align:right; font-weight:600; cursor:none;}
.event-input .input-box button {position:absolute; right:0; top:0; background-color:transparent; outline:none;}
.noti {position:relative; padding:70px 0 70px 383px; text-align:left;}
.noti h3 {position:absolute; left:285px; top:80px;}
.noti ul {padding:0 0 0 30px; border-left:2px solid #3b379a;}
.noti li {padding:2px 0; color:#fff; font-family:dotum, sans-serif;}
@keyframes fly {
	from {top:200px; margin-left:-700px; opacity:0;}
	to {top:134px; margin-left:-317px; opacity:1;}
}
@keyframes ski {
	from {top:0px; margin-left:500px; animation-timing-function:ease-in;}
	37% {top:30px; margin-left:300px; transform:skewY(3deg); animation-timing-function:linear;}
	65% {top:58px; margin-left:353px; transform:skewY(-2deg); animation-timing-function:ease-in;}
	to {top:82px; margin-left:217px; animation-timing-function:linear;}
}
</style>
<script type="text/javascript">
<!--
	function fnGoEnter(){
	<% If IsUserLoginOK() Then %>
		<% If now() > #02/07/2018 00:00:00# and now() < #02/22/2018 23:59:59# then %>
		var medalcnt=$("#counting").val();
		var options = {
			animate : true,
			attrCount : 'data-count',
			delayTime : 30 ,
			waitTime : 15 ,
			easing : 'easeOutBounce',
			duration : 700
		};
			if(medalcnt<1)
			{
				alert("매달 개수를 입력해주세요.");
			}
			else
			{
				var str = $.ajax({
					type: "POST",
					url: "/event/etc/doEventSubscript84256.asp",
					data: "mode=add&medalcnt="+medalcnt,
					dataType: "text",
					async: false
				}).responseText;
				var str1 = str.split("|")
				if (str1[0] == "11"){
					alert('응모가 완료되었습니다.');
					$("#mymedal").empty().append('<div id="medalrolling" data-count="' + medalcnt + '"></div>');
					$("#medalrolling").rollingCounter(options);
					return false;
				}else if (str1[0] == "12"){
					alert('이벤트 기간이 아닙니다.');
					return false;
				}else if (str1[0] == "13"){
					alert('메달 개수는 하루에 한번 수정 가능합니다.');
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
			}
		<% Else %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% End If %>
	<% Else %>
		top.location.href="/login/loginpage.asp?vType=G";
		return false;
	<% End If %>
	}
//-->
</script>
						<!-- 메달갯수를 맞혀라 -->
						<div class="evt84256">
							<div class="headline">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/84256/tit_medal.png" alt="메달갯수를 맞혀라" /></h2>
								<i class="deco"></i>
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/84256/txt_event.png" alt="우리나라 메달 개수를 맞춰주세요! 총 개수를 맞추신 분들께 메달 개수 x 100마일리지를 드립니다." /></p>
							</div>
							<div class="event-view">
								<div class="count-view real-num">
									<strong>현재 우리나라 총 메달 개수</strong>
									<div class="counter-area">
										<div class="counter" data-count="<%=KorMedalCnt%>"></div>
									</div>
									<p>
									<% If hour(now()) >= 10 Then %>
										2월 <%=day(now())%>일 오전 10시 기준
									<% Else %>
										2월 <%=day(dateadd("d",-1,now()))%>일 오전 10시 기준
									<% End If %>
									</p>
								</div>
								<div class="count-view mine-num">
									<strong>내가 예상하는 메달 개수</strong>
									<div class="counter-area" id="mymedal">
										<div class="counter" data-count="<%=MedalCnt%>"></div>
									</div>
								</div>
							</div>
							<div class="event-input">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/84256/txt_question.png" alt="예상하는 우리나라 최종 메달 개수는?" /></p>
								<form action="" method="" name="" id="">
									<div class="input-box">
										<p><input type="number" id="counting" name="medalcnt" maxlength="3" style="width:100px; background:url('http://webimage.10x10.co.kr/eventIMG/2018/84256/cursor.gif') 100px 50% no-repeat;" onFocus="this.style.backgroundImage='url(none)';" /><img src="http://webimage.10x10.co.kr/eventIMG/2018/84256/txt_count.png" alt="개" /></p>
										<% If MedalCnt <> 0 Then %>
											<button type="button" onClick="fnGoEnter();"><img src="http://webimage.10x10.co.kr/eventimg/2018/84256/btn_edit.png" alt="수정하기" /></button>
										<% Else %>
											<button type="button" onClick="fnGoEnter();"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84256/btn_input.png" alt="입력하기" /></button>
										<% End If %>
									</div>
								</form>
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/84256/txt_edit.png" alt="* 메달 개수는 하루에 한 번 수정 가능합니다 *" /></p>
							</div>
							<div class="noti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/84256/txt_noti.png" alt="유의사항" /></h3>
								<ul>
									<li>· 우리나라 총 메달 개수는 매일 오전 10시에 집계됩니다. (휴일 제외)</li>
									<li>· 예상하는 메달 개수는 2월 22일 목요일 자정까지 최종 수정 가능합니다.</li>
									<li>· 우리나라 총 메달 개수는 2월 25일까지 집계된 우리나라의 금, 은, 동메달의 개수로 결과를 냅니다.</li>
									<li>· 이벤트 당첨자는 2월 26일, 마일리지가 지급 될 예정입니다.</li>
								</ul>
							</div>
						</div>

						<script type="text/javascript">
						$(function() {
							var position = $('.event-view').offset();
							$('html,body').delay(1550).animate({ scrollTop : position.top },1200);

							$(".counter").rollingCounter({
								animate : true,
								attrCount : 'data-count',
								delayTime : 30 ,
								waitTime : 15 ,
								duration : 700
							});
						});
						</script>
						<!--// 메달갯수를 맞혀라-->
<!-- #include virtual="/lib/db/dbclose.asp" -->