<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 천원의기적
' History : 2018-11-02 원승현 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
%>
<style type="text/css">
.gpimg {display:none;}
.evt90303 {width:1140px; margin:0 auto;}
.evt90303 .inner {position:relative;}
.evt90303 .inner span {position:absolute; right:280px; top:78px; animation:shake 1.5s linear infinite;}
@keyframes shake { 0%{transform:translateY(10px);} 50%{transform:translateY(0);} 100%{transform:translateY(10px);} }
.evt90303 .bnr-evt {margin-top:10px;}
.evt90303 .btn-deposit {display:block; position:absolute; left:598px; top:699px;}
</style>
<div class="evt90303">
	<div class="inner">
		<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90303/img_miracle.jpg?v=1.2" alt="" /></p>
		<span><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90303/img_only_app.png" alt="" /></span>
		<a href="/my10x10/myTenCash.asp" class="btn-deposit"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90303/btn_deposit.gif" alt="예치금이란?" /></a>
	</div>
	<div class="bnr-evt"><a href="/event/eventmain.asp?eventid=90248"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90303/btn_event.jpg" alt="" /></a></div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->