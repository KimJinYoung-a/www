<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  텐텐쇼퍼
' History : 2019-02-19 최종원 
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eventStartDate, eventEndDate, currentDate, LoginUserid, eCode

IF application("Svr_Info") = "Dev" THEN
	eCode = "90225"		
Else
	eCode = "92632"	
End If

eventStartDate  = cdate("2019-02-20")		'이벤트 시작일
eventEndDate 	= cdate("2019-03-03")		'이벤트 종료일
currentDate = date()
%>
<style type="text/css">
.evt92632 .section {position: relative;}
.evt92632 .section a {position: absolute; display: block; left: 50%; bottom: 0; text-indent: -9999px;}
.evt92632 .section .inner {width: 1140px; margin: 0 auto;}
.evt92632 .topic {background: url(//webimage.10x10.co.kr/fixevent/event/2019/92632/bg_top.jpg) 50% 0; }
.evt92632 .benefit {background-color: #4adcab;}
.evt92632 .guide {padding-bottom: 121px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/92632/bg_guide.jpg) 50% 0; }
.evt92632 .guide a {bottom: 120px; width: 430px; height: 100px; margin-left: -215px;}
.evt92632 .alarm {background-color: #66d2f9;}
.evt92632 .alarm a {bottom: 60px; width: 325px; height: 75px; margin-left: -162px;}
.evt92632 .notice {padding: 70px 0; background-color: #2c2829; text-align: left;}
.evt92632 .notice h3,
.evt92632 .notice ul {display: inline-block; vertical-align: middle;}
.evt92632 .notice li {color: #fff; line-height: 23px; text-align: left;}
.evt92632 .notice li:before {content:'-';display:inline-block; width:8px; margin-left:-12px; font-weight: bold;}
.evt92632 .notice li.bold {color: #fbd568; font-weight: bold;}
.evt92632 .bnr-area {background-color: #454545; padding: 35px 0; text-align: center;}
.evt92632 .bnr-area a {margin: 0 10px;}
</style>
<script type="text/javascript" src="/event/etc/json/js_regAlram.js"></script>
<!-- 92632 텐텐쇼퍼 6기 -->
<div class="evt92632">
    <div class="topic">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/92632/tit_tenshoper.png" alt="텐텐쇼퍼 모여라"></h2>
    </div>
    <div class="section benefit">
        <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/92632/img_benefit.jpg" alt="2개월간 50만원 상당 지원"></p>
    </div>
    <div class="section guide">
        <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/92632/img_guide.jpg" alt="신청절차"></p>
        <a href="https://goo.gl/forms/qU6kSSNuJUedg2Ur2">신청서 작성하기</a>
    </div>
    <div class="section alarm">
        <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/92632/img_alram.jpg" alt="푸시 수신 설정 방법"></p>
        <a href="javascript:regAlram();">텐텐쇼퍼 발표 알림 받기</a>
    </div>
    <div class="section notice">
        <div class="inner">
            <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/92632/tit_notice.jpg" alt=""></h3>
            <ul>
                <li class="bold">개인 SNS는 블로그, 인스타그램, 유튜브입니다.</li>
                <li>본 이벤트의 일정 및 세부 내용은 당사의 사정에 따라 예고 없이 변동될 수 있습니다.</li>
                <li>지원서 양식에 입력하신 정보는 텐바이텐 텐텐쇼퍼 운영, 관리를 위해서만 활용되며, 활동 기간이 끝나면 폐기됩니다.</li>
                <li>텐텐쇼퍼 활동 시 개인 SNS에 올려주신 내용은 텐바이텐에 귀속되며, 홍보를 위한 자료로 활용될 수 있습니다.</li>
            </ul>
        </div>
    </div>
    <div class="bnr-area">
        <a href="/event/eventmain.asp?eventid=92315"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92632/bnr_evt_01.jpg" alt="신학기 begin again"></a>
        <a href="/event/eventmain.asp?eventid=92579"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92632/bnr_evt_02.jpg" alt="fashion & beauty new arrival"></a>
    </div>
</div>
<!-- // 92632 텐텐쇼퍼 6기 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->