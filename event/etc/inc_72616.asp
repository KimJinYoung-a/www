<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
dim eCode, vIsEnd
	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "66186"
	Else
		eCode 		= "72616"
	End If
	
	
If Now() > #09/06/2016 00:00:00# Then
	vIsEnd = True
Else
	vIsEnd = False
End IF
%>
<style type="text/css">
img {vertical-align:top;}
.evt72616 {overflow:hidden; text-align:center; background:#fff;}
.aliceHead {position:relative; height:507px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72616/bg_title.png) no-repeat 0 0;}
.aliceHead h2 {position:absolute; left:425px; top:60px; z-index:40;}
.aliceHead .in10x10 {position:absolute; left:723px; top:316px; z-index:40;}
.aliceHead .travel {position:absolute; left:50%; top:408px; z-index:40; margin-left:-229px;}
.aliceHead .bnr {position:absolute; top:0; right:80px;}
.aliceCont {height:591px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72616/bg_movie.png) no-repeat 0 0;}
.aliceCont .movie {width:750px; height:406px; margin:0 auto 40px;}
.aliceCont .btnApply {vertical-align:top; background:transparent;}
</style>
<script type="text/javascript">
$(function(){
	function swing () {
		$("#bnr").animate({"top":"-10px"},1000).animate({"top":"0"},1000, swing);
	}
	swing();
});

function jsSaveTicket(){

<% If vIsEnd Then %>
	alert("이벤트가 종료되었습니다.");
	return false;
<% End If %>

<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/event/etc/doeventsubscript/doEventSubscript72616.asp",
		data: "mode=G",
		cache: false,
		success: function(str) {
			str = str.replace("undefined","");
			res = str.split("|");
			if (res[0]=="OK") {
				alert(res[1]);
				return false;
			} else {
				errorMsg = res[1].replace(">?n", "\n");
				alert(errorMsg );
				return false;
			}
		}
		,error: function(err) {
			console.log(err.responseText);
			alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
		}
	});
<% else %>
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
<% end if %>
}
</script>
<form name="frm1" id="frm1" action="doEventSubscript72616.asp" method="post" style="margin:0px;">
</form>
<div class="evt72616">
	<div class="aliceHead">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/72616/tit_alice.png" alt="거울 나라의 앨리스" /></h2>
		<p class="in10x10"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72616/txt_in_10x10.png" alt="IN 텐바이텐" /></p>
		<p class="travel"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72616/txt_travel.png" alt="영화 ‘거울 나라의 앨리스’ 예매권에 응모하고, 이상한 나라로 여행을 떠나보세요!" /></p>
		<div id="bnr" class="bnr"><a href="http://www.10x10.co.kr/culturestation/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72616/btn_culture.png" alt="컬쳐스테이션 이벤트 보러가기" /></a></div>
	</div>
	<div class="aliceCont">
		<div class="movie"><iframe width="750" height="406" src="https://www.youtube.com/embed/M6u7BN2FO54" frameborder="0" allowfullscreen></iframe></div>
		<button type="button" class="btnApply" onClick="jsSaveTicket();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72616/btn_apply.png" alt="예매권 응모하기" /></button>
	</div>
	<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/72616/txt_story.jpg" alt="BULBUL" /></div>
</div>