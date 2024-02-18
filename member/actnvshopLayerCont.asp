<%@ codepage="65001" language="VBScript" %>
<% option Explicit
Response.CharSet = "UTF-8"
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
If request("nvitemid") <> "" Then
	Dim nvitemid 
	nvitemid  = "?backpath="&Server.URLEncode("/shopping/category_prd.asp?itemid=")&request("nvitemid")
End If
%>
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
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/naver/common/txt_naver_shopping_pc.png" alt="네이버 전용 텐바이텐 할인쿠폰! 텐바이텐 COUPON 3,000원 3만원 이상 구매 시" /></p>
		<p>2018. 01. 01 ~ 01. 07까지 사용가능<br /> 일부 상품 제외 <span class="symbol">|</span> 중복발행 불가</p>
		<div class="btnArea">
			<% If IsUserLoginOK() Then %>
			<span class="btn btnB1 btnRed btnW220" onclick="hideLayer('lg', '')">쿠폰 다운받기</span>
			<% Else %>
			<span class="btn btnB1 btnRed btnW220" onclick="hideLayer('one', '/login/loginpage.asp<%=nvitemid%>')">쿠폰 다운받기</span>
			<% End If %>
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