<%
'///// 첫구매자에게 개인추천(YOU)이벤트 안내 배너 노출 (로그인 필수); 2017-09-08; 허진원 /////
If Date() >="2017-09-08" And  Date() <= "2017-12-31" Then 
If not( InStr(Request.ServerVariables("url"),"79281") > 0) Then '//이벤트 페이지 내에선 안뜸 그외엔 다뜸
If request.Cookies("evt79281")<>"x" then

'// 첫구매자 확인!!
dim sSql, chkFirstOrdUsr
chkFirstOrdUsr = false

If Trim(request.cookies("Evt79281FirstOrder")) = "1" Then
	If IsUserLoginOK Then
		chkFirstOrdUsr = True
	End If
End If

if chkFirstOrdUsr then
%>
<style type="text/css">
.youBnr {position:fixed; left:50%; top:50%; z-index:99999; width:446px; height:656px; margin:-332px 0 0 -223px;}
.youBnr a {display:block; position:absolute; left:50%; top:5px; width:390px; height:600px; margin-left:-195px; background:transparent; text-indent:-999em;}
.youBnr button {position:absolute; background:transparent;}
.youBnr .btnClose {right:28px; top:-25px; }
.youBnr .btnNomore {left:28px; bottom:15px;}
</style>
<script type="text/javascript">
$(function(){
	// 첫구매 레이어팝업
	var maskHeight = $(document).height();
	var maskWidth = $(document).width();
	$('#mask').css({'width':maskWidth,'height':maskHeight});
	$('#boxes').show();
	$('#mask').show();
	$('#mask').click(function(){
		$(".youBnr").hide();
		var todayDate = new Date('2018/01/01 00:00:00'); 
		document.cookie = "evt79281=x; path=/; domain=10x10.co.kr; expires=" + todayDate.toGMTString() + ";" 
	});
	$('.youBnr .btnClose').click(function(){
		$(".youBnr").hide();
		$('#mask').hide();
		var todayDate = new Date('2018/01/01 00:00:00'); 
		document.cookie = "evt79281=x; path=/; domain=10x10.co.kr; expires=" + todayDate.toGMTString() + ";" 
	});
});

function hideLayer79281(){
	$('#boxes79281').hide();
	$('#boxes79281 .window').hide();
	$('#mask').hide();

    var todayDate = new Date('2018/01/01 00:00:00'); 
    document.cookie = "evt79281=x; path=/; domain=10x10.co.kr; expires=" + todayDate.toGMTString() + ";" 
}

function go79281Move()
{
    var todayDate = new Date('2018/01/01 00:00:00'); 
    document.cookie = "evt79281=x; path=/; domain=10x10.co.kr; expires=" + todayDate.toGMTString() + ";" 
	top.location.href='/event/eventmain.asp?eventid=79281';
}
</script>
<div id="boxes79281">
	<div id="mask79281"></div>
	<div class="window">
		<div class="youBnr">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79281/txt_first.png" alt="텐바이텐에서의 첫 구매는 만족하셨나요?" /></p>
			<a href="" onclick="go79281Move();return false;">확인하러 가기</a>
			<button type="button" class="btnNomore" onclick="hideLayer79281();"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79281/txt_close.png" alt="다시보지않기" /></button>
			<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79281/btn_close.png" alt="닫기" /></button>
		</div>
	</div>
</div>
<%
End If
End If
End If 
End If 
%>