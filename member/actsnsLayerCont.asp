<%@ codepage="65001" language="VBScript" %>
<% option Explicit
Response.CharSet = "UTF-8"
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	dim snsrdsite
	snsrdsite = requestCheckVar(request("snsrdsite"),32)
%>
<script type="text/javascript">
function hideLayer(due, ref, snsrdsite){
	if(ref != ""){
		$(".snsLyr").hide();
		$('#mask').hide();
		document.getElementById('hBoxes').style.display = "none";
		document.getElementById('due').value = due;
		document.getElementById('gourl').value = ref;
		document.getElementById('snsrdsite').value = snsrdsite;
		document.frm.action = '/member/snsCookie_process.asp';
		document.frm.target = 'view';
		document.frm.submit();
	}else{
		$(".snsLyr").hide();
		$('#mask').hide();
		document.getElementById('hBoxes').style.display = "none";
		document.getElementById('due').value = due;
		document.getElementById('gourl').value = "";
		document.getElementById('snsrdsite').value = snsrdsite;
		document.frm.action = '/member/snsCookie_process.asp';
		document.frm.target = 'view';
		document.frm.submit();
	}
}
</script>
<div class="bnrNavSignUp" id="snsLyr">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/naver/0626/txt_bnr_naver_sign_up.jpg" alt="네이버 아이디만 있으면 빠르고 쉬운 회원가입! 1.회원가입 시 네이버 로그인 클릭 팝업창에서 네이버 로그인 정보입력 후 회원가입 완료" /></h2>
		<p class="bntSignUp"><a href="/member/join.asp" class="btn btnB3 btnRed">회원가입 하러가기</a></p>
	<div class="todayNomore tMar35"><input type="checkbox" id="todayNomore" onclick="hideLayer('one', '', '<%= snsrdsite %>');" class="check" /> <label for="todayNomore">다시 보지 않기</label></div>
</div>
<iframe name="view" id="view" frameborder="0" width="0" height="0" style="display:block;"></iframe>
<form name="frm" method="post" style="margin:0px; display:inline;">
	<input type="hidden" id="due" name="due">
	<input type="hidden" id="gourl" name="gourl">
	<input type="hidden" id="snsrdsite" name="snsrdsite">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->