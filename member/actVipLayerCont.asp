<%@ codepage="65001" language="VBScript" %>
<% option Explicit
Response.CharSet = "UTF-8"
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/hitchhikerCls.asp" -->
<%
	'확인 안된 VIP라면 출력(DB에서 재검사)
	Dim chk: chk=false
	Dim hitch
	Set hitch = new Hitchhiker
		hitch.FUserId = GetLoginUserID
		hitch.fnGetHitchCont

		If (hitch.FUserlevel = "3" or hitch.FUserlevel = "4" or hitch.FUserId = "kjy8517" or hitch.FUserId = "dream1103" or hitch.FUserId = "star088" or hitch.FUserId = "okkang77" or hitch.FUserId = "baboytw") Then
			If isNull(hitch.FVHVol) Then
				chk=true
			Else
				chk=false
			End If
		Else
			chk=false
		End If
'chk=true
	'// DB검사 후 출력내용이 있으면 출력
	If chk=true Then
%>
<script>

function hicpagego(){
	document.location.href = '/hitchhiker/index.asp';
}

function hideLayer(due){
	document.getElementById('hBoxes').style.display = "none";
	document.getElementById('due').value = due;
	document.frm.action = '/member/VIPCookie_process.asp';
	document.frm.target = 'view';
	document.frm.submit();
}
</script>
	<div id="hitchLyr" class="hWindow hitchLyr">
		<div class="hitchLyrCont pngFix">
			<p class="lyrClose"><img src="http://fiximage.10x10.co.kr/web2013/event/hitchhiker/vip_popup_close.png" onclick="close()" alt="닫기" class="pngFix" /></p>
			<p class="txt">
				<strong>VIP 고객님! 지금 주소를 입력하고<br>텐바이텐 감성매거진 HITCHHIKER를 받아보세요!</strong>
				기간 내에 신청하신 고객분들께 히치하이커를 선물해드립니다.
			</p>
			<div class="hitchBtn">
				<a class="btn btnB1 btnRed btnW185" href="javascript:hicpagego();" onfocus="blur()">지금 주소 입력하기</a>
				<a class="btn btnB1 btnWhite btnW185" href="javascript:hideLayer('later');">다음에 하기</a>
			</div>
			<p>* 주소 입력 기간 내에 신청 필수로, 추가 발송이 진행되지 않습니다.</p>
			<div class="hitchFoot">
				<span><input type="checkbox" onclick="hideLayer('one');" id="dayClose" /> <label for="dayClose">오늘 하루 그만 보기</label></span>
				<span><input type="checkbox" onclick="hideLayer('seven');" id="weekClose" /> <label for="weekClose">1주일간 알림 그만 보기</label></span>
			</div>
		</div>
	</div>
	<div id="hMask"></div>
<iframe name="view" id="view" frameborder="0" width="0" height="0" style="display:block;"></iframe>
<form name="frm" method="post" style="margin:0px; display:inline;">
	<input type="hidden" id="due" name="due">
</form>

<%
	End If
	Set hitch = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->