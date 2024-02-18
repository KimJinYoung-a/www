<%
	'sCurrUrl 변수 sns.asp 파일에 있음
%>
<style type="text/css">
/* common */
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}

.sopum .head { position:relative; z-index:30; height:199px; margin-bottom:-4px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/common/bg_pattern_blue.png) 0 0 repeat-x;}
.sopum .head .inner {overflow:hidden; width:1140px; margin:0 auto; text-align:left;}
.sopum .head h2 {float:left; width:299px; padding:17px 0 0 53px;}
.sopum .navigator {overflow:hidden; float:left;}
.sopum .navigator li {float:left; width:149px; height:211px;}

.navigator li a {overflow:hidden; display:block; position:relative; width:100%; height:100%; color:#000; font-size:12px; line-height:226px; text-align:center; cursor:pointer;}
.navigator li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/common/img_navigator.png) no-repeat 0 0;}
.navigator li a:hover span,
.navigator li a.on span {background-position:0 100%;}
.navigator li.nav2 a span {background-position:-149px 0;}
.navigator li.nav2 a:hover span,
.navigator li.nav2 a.on span {background-position:-149px 100%;}
.navigator li.nav3 a span {background-position:-298px 0;}
.navigator li.nav3 a:hover span,
.navigator li.nav3 a.on span {background-position:-298px 100%;}
.navigator li.nav4 a span {background-position:-447px 0;}
.navigator li.nav4 a:hover span,
.navigator li.nav4 a.on span {background-position:-447px 100%;}
.navigator li.nav5 {width:152px;}
.navigator li.nav5 a span {background-position:-596px 0;}
.navigator li.nav5 a:hover span,
.navigator li.nav5 a.on span {background-position:-596px 100%;}

.sopum .sns {height:149px; background:#85c56a url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/common/bg_pattern_green.png) 0 0 repeat-x;}
.sopum .sns .inner {position:relative; width:1140px; margin:0 auto; padding-top:53px; text-align:left; border:}
.sopum .sns h3 {padding-left:101px;}
.sopum .sns ul {position:absolute; top:49px; right:113px; float:none;}
.sopum .sns ul li {margin-left:16px; padding:0;}
.sopum .sns ul li a:hover img {animation:bouncing 2s cubic-bezier(0.19, 1, 0.22, 1) forwards;}

.sopum .evtNoti .inner {position:relative; width:820px; margin:0 auto;}
.sopum .evtNoti h3 {position:absolute; left:0; top:50%; margin-top:-14px;}
.sopum .evtNoti ul {padding:50px 0 45px 180px;}
.sopum .evtNoti li {line-height:19px; padding:0 0 4px 15px; color:#505050; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/blt_round.png) 0 7px no-repeat;}
@keyframes bouncing {
	0% {transform:translateY(10px);}
	100% {transform:translateY(0);}
}
</style>

<div class="head">
	<div class="inner">
		<h2><a href="index.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/common/txt_sopum.png" alt="텐바이텐 소품전 나만을 위한 소품이 가득한 곳! 2017년 4월 3일부터 17일 15일간" /></a></h2>
		<ul class="navigator">
			<li class="nav1"><a href="sopumland.asp" <%=chkiif(inStr(sCurrUrl,"sopumland.asp")>0,"class=""on""","")%>><span></span>다양한 테마기획전</a></li>
			<li class="nav2"><a href="friend.asp" <%=chkiif(inStr(sCurrUrl,"friend.asp")>0,"class=""on""","")%>><span></span>매일매일 출석체크</a></li>
			<li class="nav3"><a href="treasure.asp" <%=chkiif(inStr(sCurrUrl,"treasure.asp")>0,"class=""on""","")%>><span></span>숨어있는 보물을 찾아라</a></li>
			<li class="nav4"><a href="gift.asp" <%=chkiif(inStr(sCurrUrl,"gift.asp")>0,"class=""on""","")%>><span></span>구매하고 선물받자</a></li>
			<li class="nav5"><a href="sticker.asp" <%=chkiif(inStr(sCurrUrl,"sticker.asp")>0,"class=""on""","")%>><span></span>스티커를 붙여주세요</a></li>
		</ul>
	</div>
</div>