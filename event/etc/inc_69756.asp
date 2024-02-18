<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : just 1 week big gate page
' History : 2016-03-25 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" --> 
<%
	If date() >= "2016-03-28" and date() < "2016-04-04" Then
		response.redirect("/event/eventmain.asp?eventid=69757")
	elseif date() >= "2016-04-04" and date() < "2016-04-11" Then
		response.redirect("/event/eventmain.asp?eventid=69758")
	elseif date() >= "2016-04-11" and date() < "2016-04-18" Then
		response.redirect("/event/eventmain.asp?eventid=69759")
	elseif date() >= "2016-04-18" Then
		response.redirect("/event/eventmain.asp?eventid=69760")
	End If
%>
<style type="text/css">
img {vertical-align:top;}

#contentWrap {padding-bottom:0;}

.weddingJust1week {}

.topic {position:relative; height:490px; background:#fcf9f5 url(http://webimage.10x10.co.kr/eventIMG/2016/69756/bg_pattern.png) repeat-x 0 0;}
.topic .bnr {position:absolute; top:36px; left:50%; margin-left:335px;}
.topic h2 {padding-top:70px;}

/* navigator */
.navigatorWrap {width:1140px; height:195px; position:absolute; top:414px; left:50%; z-index:10; margin-left:-570px;}

.item {position:relative; height:2430px; padding-top:170px; background-color:#eadfcc;}
.item .bg {position:absolute; top:330px; left:50%; margin-left:-751px; width:1528px; height:2099px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69756/bg_flower.png) no-repeat 0 0;}
.item .link {position:relative; z-index:5;}
</style>
<script type="text/javascript">
$(function(){
	function swing () {
		$(".bnr").animate({"top":"36px"},1000).animate({"top":"50px"},2000, swing);
	}
	swing();
});
</script>
	<!-- [W] 2016 S/S 웨딩 / 이벤트 코드 : 69756 -->
	<div class="evt69756 weddingJust1week">
		<div class="topic">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/tit_just_one_week_big_sale.png" alt="Just 1 week big sale 매주 달라지는 일주일의 특가!" /></h2>

			<div class="bnr"><a href="/event/eventmain.asp?eventid=69755"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/img_bnr_wedding.png" alt="2016 웨딩 이벤트 바로가기" /></a></div>

			<!-- navigator -->
			<!--
					69757 JUST 1 WEEK BIG SALE #1
					69758 JUST 1 WEEK BIG SALE #2
					69756 JUST 1 WEEK BIG SALE #3
					69760 JUST 1 WEEK BIG SALE #4
			-->
			<div class="navigatorWrap">
				<iframe id="iframe_69756" src="/event/etc/group/iframe_69756.asp?eventid=69756" width="1140" height="195" frameborder="0" scrolling="no" class="" title="Just 1 week big sale" allowtransparency="true"></iframe>
			</div>
		</div>

		<div class="item">
			<div class="bg"></div>
			<div class="link">
				<div>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/69757/img_item_01.jpg" width="1139" height="977" alt="" usemap="#itemlink01" />
					<map name="itemlink01" id="itemlink01">
						<area shape="rect" coords="2,1,258,463" href="/shopping/category_prd.asp?itemid=1360159&amp;pEtr=69757" alt="화이트 LED 벽시계" />
						<area shape="rect" coords="294,-2,552,462" href="/shopping/category_prd.asp?itemid=1191473&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="587,1,844,462" href="/shopping/category_prd.asp?itemid=1191473&amp;pEtr=69757" alt="발뮤다 에어엔진 EJT-1100SD 그레이" />
						<area shape="rect" coords="880,-1,1139,464" href="/shopping/category_prd.asp?itemid=1388109&amp;pEtr=69757" alt="엘리 1140 화장대 세트" />
						<area shape="rect" coords="2,504,258,935" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="293,506,551,937" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="587,505,844,934" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="881,506,1140,935" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
					</map>
				</div>

				<div>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/69757/img_item_02.jpg" width="1139" height="1374" alt="" usemap="#itemlink02" />
					<map name="itemlink02" id="itemlink02">
						<area shape="rect" coords="2,-2,258,433" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="293,2,550,429" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="585,1,844,429" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="880,2,1139,432" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="2,472,259,903" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="292,471,551,902" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="586,472,846,904" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="879,471,1136,902" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="1,943,258,1373" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="293,943,550,1374" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="586,944,848,1374" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
						<area shape="rect" coords="881,944,1144,1373" href="/shopping/category_prd.asp?itemid=1400027&amp;pEtr=69757" alt="" />
					</map>
				</div>
			</div>
		</div>
	</div>
	<!-- //2016 S/S 웨딩 -->
