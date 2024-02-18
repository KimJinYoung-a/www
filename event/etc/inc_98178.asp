<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : [MD] SPAO X 텐바이텐 상륙 (98178)
' History : 2019.10.25 임보라 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim currentDate : currentDate = date()
dim testDate
testDate = request("testdate")

if testDate <> "" then
    currentDate = Cdate(testDate)
end if
%>
<style type="text/css">
.evt98178 {position:relative; padding-bottom:150px; background:#1d1d1d url(//webimage.10x10.co.kr/fixevent/event/2019/98178/bg_con.jpg) 50% 100% no-repeat;}
.evt98178 .intro {position:relative; overflow:hidden; height:633px; padding:240px 0 0; background:#5b170c url(//webimage.10x10.co.kr/fixevent/event/2019/98178/bg_top.jpg) 50% 0 no-repeat;}
.evt98178 .intro:after {content:' '; position:absolute; top:490px; left:50%; width:80px; height:80px; margin-left:-40px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98178/ico_arrow.png) 50% no-repeat; animation:dongdong 1s 20;}
.evt98178 .intro .txt1 {overflow:hidden;}
.evt98178 .intro .txt1 img {transform:translateY(100%); opacity:0; transition:all 1s;}
.evt98178 .intro .txt2 {opacity:0; transition:all 1s 0.5s;}
.evt98178.action .intro .txt1 img {transform:translateY(0px); opacity:1;}
.evt98178.action .intro .txt2 {opacity:1;}
.evt98178 .inner {position:relative; width:1140px; padding:0 155px 70px; margin:-224px auto 0; background-color:#ae342a;}
.evt98178 .inner h2 {opacity:0; transition:all 1s;}
.evt98178 .inner.on h2 {opacity:1;}
.evt98178 .item-list {position:relative; width:1138px; margin:0 auto;}
.evt98178 .item-list:after {content:' '; display:block; clear:both;}
.evt98178 .item-list li {position:relative; width:569px; height:839px; float:left;}
.evt98178 .item-list li > a {display:block; position:relative;}
.evt98178 .item-list li > a:hover {z-index:1;}
.evt98178 .item-list li > a:hover .thumbnail {box-shadow:0 48px 49px 0 rgba(0,0,0,0.55);}
.evt98178 .item-list .badge {overflow:hidden; position:absolute; left:30px; top:560px; width:80px; height:87px;}
.evt98178 .item-list .end .badge img {position:relative; top:-87px;}
@keyframes dongdong {
	0%,100% {transform:translateY(0px); animation-timing-function:ease-in;}
	50% {transform:translateY(10px); animation-timing-function:ease-out;}
}
</style>
<script type="text/javascript">
$(function(){
	$('.evt98178').addClass('action');
	$(window).scroll(function(){
		var y = $(this).scrollTop() + $(window).height() / 2;
		var target = $('.evt98178 .inner');
		if ( y > target.offset().top ) {
			target.addClass('on');
		}
	});
});
</script>
<div class="evt98178">
	<div class="intro">
		<p class="txt1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_intro1.png" alt="얼마나 좋을까"></p>
		<p class="txt2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_intro2.png" alt="해답은"></p>
	</div>
	<div class="inner">
		<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/tit_spao.png" alt="SPAO 스파오"></h2>
		<ul class="item-list">
			<li class="item1">
				<a href="/event/eventmain.asp?eventid=98192">
					<div class="open">
						<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/img_item1.jpg" alt=""></div>
						<div class="desc"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_item1.png" alt=""></div>
					</div>
					<span class="badge"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_gift.jpg" alt="Gift"></span>
				</a>
				<!-- 선착순 재고 소진시
					<div class="out"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/img_item1_out.png" alt=""></div>
					<span class="badge"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_gift.jpg" alt="Gift"></span>
				-->
			</li>
			<li class="item2 <% if currentDate < "2019-10-31" then %>ing<% else %>end<% end if %>">
				<% if currentDate < "2019-10-31" then %>
				<a href="/event/eventmain.asp?eventid=98193">
					<div class="open">
						<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/img_item2.jpg" alt=""></div>
						<div class="desc"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_item2.png" alt=""></div>
					</div>
					<span class="badge"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_sale.jpg" alt="Sale"></span>
				</a>
				<% Else %>
				<div class="out"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/img_item2_out.png" alt=""></div>
				<span class="badge"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_sale.jpg" alt="Sale"></span>
				<% End If %>
			</li>
			<li class="item3">
				<a href="/event/eventmain.asp?eventid=98194">
					<div class="open">
						<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/img_item3.jpg" alt=""></div>
						<div class="desc"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_item3.png" alt=""></div>
					</div>
					<span class="badge"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_sale.jpg" alt="Sale"></span>
				</a>
			</li>
			<li class="item4">
				<% if currentDate < "2019-10-31" then %>
				<div class="coming"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/img_item4_coming.png?v=1.01" alt=""></div>
				<span class="badge"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_sale.jpg" alt="SALE"></span>
				<% Else %>
				<a href="/event/eventmain.asp?eventid=98195">
					<div class="open">
						<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/img_item4.jpg" alt=""></div>
						<div class="desc"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_item4.png?v=1.01" alt=""></div>
					</div>
					<span class="badge"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98178/txt_sale.jpg" alt="SALE"></span>
				</a>
				<% End If %>
			</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->