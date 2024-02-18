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
		eCode 		= "66178"
	Else
		eCode 		= "72271"
	End If
	
	
If Now() > #08/11/2016 00:00:00# Then
	vIsEnd = True
Else
	vIsEnd = False
End IF
%>
<style type="text/css">
img {vertical-align:top;}
.evt72271 {position:relative;}
.evt72271 h2 {visibility:hidden; width:0; height:0; overflow:hidden; position:absolute; top:-1000%; line-height:0;}
.evt72271 .btnEnter {display:none; position:absolute; left:50%; top:1210px; margin-left:-189px; background-color:transparent; z-index:10; outline:none;}
.evt72271 .noti {position:relative; margin-top:-6px; z-index:10;}
.evt72271 .deco {position:relative; display:block; width:1140px; height:12px; margin-bottom:-6px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72271/img_deco1.png) no-repeat 50% 0; z-index:20;}
.evt72271 .txt {display:block; position:absolute; left:50%; top:296px; width:369px; height:90px; margin-left:-184px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72271/tit_time_txt.png) no-repeat 50% -90px; z-index:20;}
.evt72271 .bnr {display:block; position:absolute; right:23px; top:0; width:161px; height:186px; z-index:20;}

div.evtIng .txt {background-position:50% 0;}
div.evtIng .btnEnter {display:block;}

.rolling {position:relative;}
.slide {position:relative; width:1140px; height:1345px;}
.slide .slidesjs-slide {height:1260px; padding-top:85px;}
.slide .slidesjs-slide p {padding-top:157px;}
.slide .slidesjs-navigation {position:absolute; top:50%; z-index:10; width:44px; height:87px; margin-top:-43px; background-repeat:no-repeat; background-position:50% 50%; text-indent:-999em; z-index:20;}
.slide .slidesjs-previous {left:96px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72271/btn_slide_prev.png);}
.slide .slidesjs-next {right:96px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72271/btn_slide_next.png);}
.slide .s01 {background-color:#ffd5d7;}
.slide .s02 {background-color:#f8f2ac;}
.slide .s03 {background-color:#ffd6b8;}
.slide .s04 {background-color:#ffd5ed;}
.slide .s05 {background-color:#e3dcff;}
.slide .s06 {background-color:#cdf4f7;}

.slidesjs-pagination {overflow:hidden; position:absolute; bottom:180px; left:50%; z-index:50; width:1010px; height:232px; margin-left:-505px; background-color:#fff;}
.slidesjs-pagination li {float:left; width:168px; height:232px;}
.slidesjs-pagination li a {overflow:hidden; display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72271/img_slide_thumb.jpg) no-repeat 0 0; text-indent:-999em;}
.slidesjs-pagination li.no1 a.active {background-position:0 -232px;}
.slidesjs-pagination li.no2 {width:169px;}
.slidesjs-pagination li.no2 a {background-position:-168px 0;}
.slidesjs-pagination li.no2 a.active {background-position:-168px -232px;}
.slidesjs-pagination li.no3 a {background-position:-337px 0;}
.slidesjs-pagination li.no3 a.active {background-position:-337px -232px;}
.slidesjs-pagination li.no4 a {background-position:-505px 0;}
.slidesjs-pagination li.no4 a.active {background-position:-505px -232px;}
.slidesjs-pagination li.no5 {width:169px;}
.slidesjs-pagination li.no5 a {background-position:-673px 0;}
.slidesjs-pagination li.no5 a.active {background-position:-673px -232px;}
.slidesjs-pagination li.no6 a {background-position:-842px 0;}
.slidesjs-pagination li.no6 a.active {background-position:-842px -232px;}
</style>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"1345",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:false},
		effect:{fade: {speed:800, crossfade:true}}
	});

	$("#slide .slidesjs-pagination li:nth-child(1)").addClass("no1");
	$("#slide .slidesjs-pagination li:nth-child(2)").addClass("no2");
	$("#slide .slidesjs-pagination li:nth-child(3)").addClass("no3");
	$("#slide .slidesjs-pagination li:nth-child(4)").addClass("no4");
	$("#slide .slidesjs-pagination li:nth-child(5)").addClass("no5");
	$("#slide .slidesjs-pagination li:nth-child(6)").addClass("no6");

	$(".no1").click (function() { $("#bookno").val("1"); });
	$(".no2").click (function() { $("#bookno").val("2"); });
	$(".no3").click (function() { $("#bookno").val("3"); });
	$(".no4").click (function() { $("#bookno").val("4"); });
	$(".no5").click (function() { $("#bookno").val("5"); });
	$(".no6").click (function() { $("#bookno").val("6"); });
});

function jsSaveBook(){
	if($("#bookno").val() == ""){
		alert("6개의 도서 중 원하는 도서를 선택해주세요.");
		return false;
	}
	
<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/event/etc/doeventsubscript/doEventSubscript72271.asp",
		data: "mode=G&bookno="+$("#bookno").val()+"",
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
<form name="frm1" id="frm1" action="doEventSubscript72271.asp" method="post" style="margin:0px;">
<input type="hidden" name="bookno" id="bookno" value="1">
</form>
<div class="evt72271 <%=CHKIIF(vIsEnd,"","evtIng")%>">
	<h2>나를 위한 시간</h2>
	<p class="txt"></p><span class="deco"></span>
	<span class="bnr"><a href="http://www.10x10.co.kr/culturestation/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/bnr_time.png" alt="더 많은 컬쳐스테이션 이벤트 만나기" /></a></span>
	<div class="rolling">
		<div id="slide" class="slide">
			<div class="s01">
				<strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/tit_time1.png" alt="그리고, 쓰고, 만들고 - 나를 위한 시간" /></strong>
				<p><a href="/shopping/category_prd.asp?itemid=1542470" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/img_slide01.jpg" alt="일상 드로잉, 손그림 푸드 일러스트 - 나누고 싶은 맛있는 그림!" /></a></p>
			</div>
			<div class="s02">
				<strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/tit_time2.png" alt="그리고, 쓰고, 만들고 - 나를 위한 시간" /></strong>
				<p><a href="/shopping/category_prd.asp?itemid=1488427" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/img_slide02.jpg" alt="캘리그라피, 처음이세요? - 손글씨 맨 처음 연습장" /></a></p>
			</div>
			<div class="s03">
				<strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/tit_time3.png" alt="그리고, 쓰고, 만들고 - 나를 위한 시간" /></strong>
				<p><a href="/shopping/category_prd.asp?itemid=1455610" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/img_slide03.jpg" alt="누가 그려도 예쁜 감성 수채화! - 작고 예쁜 그림 한 장" /></a></p>
			</div>
			<div class="s04">
				<strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/tit_time4.png" alt="그리고, 쓰고, 만들고 - 나를 위한 시간" /></strong>
				<p><a href="/shopping/category_prd.asp?itemid=1452398" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/img_slide04.jpg" alt="드라이플라워에 대해 알고 싶었던 모든 것 - 꽃보다 드라이 플라워" /></a></p>
			</div>
			<div class="s05">
				<strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/tit_time5.png" alt="그리고, 쓰고, 만들고 - 나를 위한 시간" /></strong>
				<p><a href="/shopping/category_prd.asp?itemid=1488426" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/img_slide05.jpg" alt="당신의 손글씨는 아직도 ‘흑백’인가요? - 수채 손글씨는 예뻐요" /></a></p>
			</div>
			<div class="s06">
				<strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/tit_time6.png" alt="그리고, 쓰고, 만들고 - 나를 위한 시간" /></strong>
				<p><a href="/shopping/category_prd.asp?itemid=1452397" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/img_slide06.jpg" alt="따라 쓰고 싶은 손글씨체 66가지 - 손글씨 나혼자 조금씩" /></a></p>
			</div>
		</div>
	</div>
	<button class="btnEnter" onClick="jsSaveBook();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/btn_time.png" alt="응모하기" /></button>
	<p class="noti"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72271/txt_noti.png" alt="이벤트 유의사항" /></p>
</div>