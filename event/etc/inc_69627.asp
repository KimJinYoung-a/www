<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 방가방가 첫 구매&연속구매 진입 페이지 WWW
' History : 2016.03.11 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<% '<!-- #include virtual="/lib/inc/head.asp" --> %>
<style type="text/css">
img {vertical-align:top;}
.door {position:relative; height:515px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69627/bg_wall.png) repeat-y 0 0;}
.door div {position:absolute; top:0;}
.door .room01 {left:220px;}
.door .room02 {left:646px;}
</style>
<script type="text/javascript">
$(function(){
	$('.addInfo').mouseover(function(){
		$(this).children('.contLyr').show();
	});
	$('.addInfo').mouseleave(function(){
		$(this).children('.contLyr').hide();
	});
});

function jsevtgo(e){
	var str = $.ajax({
		type: "POST",
		url: "/event/etc/doeventsubscript/doEventSubscript69627.asp",
		data: "mode=evtgo&ecode="+e,
		dataType: "text",
		async: false
	}).responseText;
	var str1 = str.split("||")
	if (str1[0] == "11"){
		document.location.href = "/event/eventmain.asp?eventid="+e;
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
</script>
<div class="evt69627">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/69627/tit_shout_spell.png" alt="주문을 외쳐방 - 고객님께 해당하는 주문을 외쳐보세요! 맞춤형 혜택이 당신을 기다립니다!" /></h2>
	<div class="door">
		<div class="room01"><a href="" onclick="jsevtgo('69628'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69627/img_door_first.gif" alt="열려라 첫 구매! - 한번도 구매하지 않았다면 이 문을 열어방" /></a></div>
		<div class="room02"><a href="" onclick="jsevtgo('69634'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69627/img_door_again.gif" alt="열려라 또 구매! - 주문내역이 있다면 이 문을 열어방" /></a></div>
	</div>
	<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69627/txt_open.gif" alt="" /></p>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
