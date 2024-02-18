<%@ codepage="65001" language="VBScript" %>
<% option Explicit
Response.CharSet = "UTF-8"
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<script type="text/javascript">
function hideLayer(due, ref){
	if(ref != ""){
		document.getElementById('hBoxes').style.display = "none";
		document.getElementById('due').value = due;
		document.getElementById('gourl').value = ref;
		document.frm.action = '/member/nvshopCookie_process.asp';
		document.frm.target = 'view';
		document.frm.submit();
	}else{
		document.getElementById('hBoxes').style.display = "none";
		document.getElementById('due').value = due;
		document.getElementById('gourl').value = "";
		document.frm.action = '/member/nvshopCookie_process.asp';
		document.frm.target = 'view';
		document.frm.submit();
	}
}
</script>
<div id="nvshopLyr" class="hWindow nvshopLyr">
	<div class="nvshopCont pngFix">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/naver/0808/txt_naver_pay_pc.png" alt="텐바이텐에서 네이버페이로 첫 결제 시 네이버 포인트 2,000 포인트 적립!" /></p>
		<p>이벤트 기간 : 2016년 08월 12일 ~ 08월 25일<br /> 1인당 기간 내 1회에 한하여 적용</p>
		<div class="btnArea">
			<%' for dev msg : N-pay OPEN EVENT! 이벤트로 연결 / 이벤트 코드 72336 %>
			<a href="/event/eventmain.asp?eventid=72336" class="btn btnB1 btnRed btnW220" title="네이버페이 오픈 이벤트로 이동">이벤트 자세히 보기</a>
		</div>
		<div class="todayNomore"><input type="checkbox" id="todayNomore" class="check" onclick="hideLayer('one', '');"/> <label for="todayNomore">오늘 하루 그만 보기</label></div>
		<div class="closeArea"><button type="button" class="lyrClose">닫기</button></div>
	</div>
</div>
<div id="hMask"></div>
<iframe name="view" id="view" frameborder="0" width="0" height="0" style="display:block;"></iframe>
<form name="frm" method="post" style="margin:0px; display:inline;">
	<input type="hidden" id="due" name="due">
	<input type="hidden" id="gourl" name="gourl">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->