<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  다이어리 스토리 캘린더 이벤트
' History : 2018-08-14 이종화 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2019/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2019/lib/classes/diary_class_B.asp" -->
<script>
$(function(){
    fnAmplitudeEventMultiPropertiesAction('view_diary_calendar_event','','');
});
</script>
<div id="contentWrap" class="diary-calendar">
    <!-- #include virtual="/diarystory2019/inc/head.asp" -->
    <div class="calendar-top">
        <h2><img src="http://fiximage.10x10.co.kr/web2018/diary2019/tit_calendar.png" alt="Hello, Calendar" /></h2>
    </div>

    <div class="section section1">
        <img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_calendar_1_v2.jpg" alt="데스크 캘린더" />
        <a href="#groupBar1"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/btn_calendar_1_v2.png" alt="more view" /></a>
    </div>

    <div class="section section2">
        <img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_calendar_2_v2.jpg" alt="벽걸이 캘린더 " />
        <a href="#groupBar2"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/btn_calendar_2_v2.png" alt="more view" /></a>
    </div>

    <div class="section section3">
        <img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_calendar_3_v2.jpg" alt="엽서 & 포스터 캘린더" />
        <a href="#groupBar3"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/btn_calendar_3_v2.png" alt="more view" /></a>
    </div>

    <div class="section section4">
        <img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_calendar_4.jpg" alt="목표 달력" />
        <a href="#groupBar4"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/btn_calendar_4.png" alt="more view" /></a>
    </div>
</div>