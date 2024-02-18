<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
'####################################################
' Description : 69220-시리즈
' History : 2016-02-19 유태욱 생성
'####################################################
%>
<style type="text/css">
img {vertical-align:top;}
.earlyBirdSale .title {position:relative; height:263px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69220/bg_title.png) no-repeat 0 0;}
.earlyBirdSale .title h2 {overflow:hidden; position:absolute; left:50%; top:127px; width:782px; height:70px; margin-left:-385px; z-index:10;}
.earlyBirdSale .title h2 em {display:block; float:left; height:70px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69220/tit_early_bird_sale.png) no-repeat 0 -35px; text-indent:-9999px;}
.earlyBirdSale .title h2 em.t01 {width:310px;}
.earlyBirdSale .title h2 em.t02 {width:220px; background-position:-310px -35px;}
.earlyBirdSale .title h2 em.t03 {width:252px; background-position:100% -35px;}
.earlyBirdSale .title .spring {position:absolute; left:170px; top:83px; z-index:20;}
.earlyBirdSale .title .date {position:absolute; right:25px; top:25px;}
.earlyBirdSale .title .copy {position:absolute; left:50%; top:218px; z-index:20; margin-left:-156px;}
</style>
<script type="text/javascript">
$(function(){
	/* title animation */
	$(".title .spring").css({"margin-top":"-3px", "opacity":"0"});
	$(".title h2 em.t01,.title h2 em.t03").css({"margin-top":"68px", "opacity":"0"});
	$(".title h2 em.t02").css({"margin-top":"-68px", "opacity":"0"});
	function animation() {
		$(".title .spring").delay(200).animate({"margin-top":"3px", "opacity":"1"},500).animate({"margin-top":"0"},500);
		$(".title h2 em").delay(300).animate({"margin-top":"0","opacity":"1"},800);
	}
	animation();

	$(".goTrain").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
});
</script>
</head>
<body>
<style>
.earlyBirdTab {width:1140px; height:275px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69220/bg_tab.png) no-repeat 0 0;}
.earlyBirdTab ul {width:852px; margin:0 auto; padding-top:27px;}
.earlyBirdTab ul:after {content:' '; display:block; clear:both;}
.earlyBirdTab li {position:relative; float:left; width:210px; height:75px; margin:1px 1px 2px 2px;}
.earlyBirdTab li a {display:block; height:75px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/69220/txt_tab_brand.png); background-repeat:no-repeat; text-indent:-9999px;}
.earlyBirdTab li.current a {position:relative; top:-27px; height:102px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/69220/txt_tab_brand_on_v2.png);}
.earlyBirdTab li.day0222 {margin-left:108px;}
.earlyBirdTab li.day0222 a {background-position:0 0;}
.earlyBirdTab li.day0223 a {background-position:-210px 0;}
.earlyBirdTab li.day0224 a {background-position:-420px 0;}
.earlyBirdTab li.day0225 a {background-position:-630px 0;}
.earlyBirdTab li.day0226 a {background-position:0 100%;}
.earlyBirdTab li.day0227 a {background-position:-210px 100%;}
.earlyBirdTab li.day0228 a {background-position:-420px 100%;}
</style>
<div class="earlyBirdTab">
	<ul>
		<% If Date() >="2016-02-22" then %>
			<li class="day0222 <%=chkiif(Date()="2016-02-22","current","")%>"><a href="/event/eventmain.asp?eventid=69220" target="_top">2월 22일(월)-DAILY LOOK</a></li>
		<% else %>
			<li class="day0222"><a href="javascript:;">2월 22일(월)-DAILY LOOK</a></li>
		<% end if %>

		<% If Date() >="2016-02-23" then %>
			<li class="day0223 <%=chkiif(Date()="2016-02-23","current","")%>"><a href="/event/eventmain.asp?eventid=69281" target="_top">2월 23일(화)-S/S INTERIOR</a></li>
		<% else %>
			<li class="day0223"><a href="javascript:;">2월 23일(화)-S/S INTERIOR</a></li>
		<% end if %>

		<% If Date() >="2016-02-24" then %>
			<li class="day0224 <%=chkiif(Date()="2016-02-24","current","")%>"><a href="/event/eventmain.asp?eventid=69282" target="_top">2월 24일(수)-GO OUT</a></li>
		<% else %>
			<li class="day0224"><a href="javascript:;">2월 24일(수)-GO OUT</a></li>
		<% end if %>

		<% If Date() >="2016-02-25" then %>
			<li class="day0225 <%=chkiif(Date()="2016-02-25","current","")%>"><a href="/event/eventmain.asp?eventid=69283" target="_top">2월 25일(목)-CLEAN HOME</a></li>
		<% else %>
			<li class="day0225"><a href="javascript:;">2월 25일(목)-CLEAN HOME</a></li>
		<% end if %>

		<% If Date() >="2016-02-26" then %>
			<li class="day0226 <%=chkiif(Date()="2016-02-26","current","")%>"><a href="/event/eventmain.asp?eventid=69284" target="_top">2월 26일(금)-NEW START</a></li>
		<% else %>
			<li class="day0226"><a href="javascript:;">2월 26일(금)-NEW START</a></li>
		<% end if %>

		<% If Date() >="2016-02-27" then %>
			<li class="day0227 <%=chkiif(Date()="2016-02-27","current","")%>"><a href="/event/eventmain.asp?eventid=69285" target="_top">2월 27일(토)-GARDENING</a></li>
		<% else %>
			<li class="day0227"><a href="javascript:;">2월 27일(토)-GARDENING</a></li>
		<% end if %>

		<% If Date() >="2016-02-28" then %>
			<li class="day0228 <%=chkiif(Date()="2016-02-28","current","")%>"><a href="/event/eventmain.asp?eventid=69286" target="_top">2월 28일(일)-BEAUTY</a></li>
		<% else %>
			<li class="day0228"><a href="javascript:;">2월 28일(일)-BEAUT</a></li>
		<% end if %>
	</ul>
</div>
