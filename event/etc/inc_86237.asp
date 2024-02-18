<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 5월 매일리지
' History : 2018-05-11 원승현 생성
'###########################################################
%>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim eCode, userid

IF application("Svr_Info") = "Dev" THEN
	eCode   =  68518
Else
	eCode   =  86237
End If

userid = GetEncLoginUserID()

%>
<style type="text/css">
.maeileage .inner {position:relative; width:1140px; margin:0 auto;}
.maeileage button {background-color:transparent; vertical-align:top;}

.maeileage {background-color:#46b9e4;}
.maeileage h2 {position:relative; padding-top:100px; z-index:2;}
.maeileage i {position:absolute; left:50%; top:120px; margin-left:-287px; animation:bounce .8s 30; z-index:1;}
.maeileage .app-down {margin-top:75px;}
.maeileage .noti {padding:80px 0; background:#a04bfe;}
.maeileage .noti h3 {position:absolute; left:135px; top:50%; margin-top:-14px;}
.maeileage .noti ul {padding-left:332px; text-align:left;}
.maeileage .noti li {color:#fff; padding:18px 0 0 11px; line-height:16px; text-indent:-11px;}
.maeileage .noti li:first-child {padding-top:0;}
@keyframes bounce {
	from, to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(8px); animation-timing-function:ease-in;}
}
</style>
<%' 매일리지 %>
<div class="evt86236 maeileage">
	<div class="inner">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/86236/tit_maeileage.png" alt="매일 오면 점점 커지는 혜택!" /></h2>
		<i><img src="http://webimage.10x10.co.kr/eventIMG/2018/86236/img_badge.png" alt="모바일 앱에서만 참여가능!" /></i>
		<p class="app-down"><img src="http://webimage.10x10.co.kr/eventIMG/2018/86236/img_app_download.png" alt="텐바이텐 APP 다운받기" usemap="#map" /></p>
	</div>
	<map name="map" id="map">
	<area  title="" href="javascript:alert('텐바이텐 APP에서 참여가능한 이벤트입니다.');" shape="rect" coords="599,58,975,246" />
	</map>
	<%' 유의사항 %>
	<div class="noti">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/86236/tit_noti.png" alt="유의사항" /></h3>
			<ul>
				<li>- 본 이벤트는 모바일 앱에서만 참여할 수 있습니다.</li>
				<li>- 본 이벤트는 하루에 한 번씩만 참여할 수 있습니다.</li>
				<li>- 이벤트 참여 이후에 연속으로 출석하지 않았을 시, 100p부터 다시 시작됩니다.</li>
			</ul>
		</div>
	</div>
</div>
<%'// 매일리지 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->