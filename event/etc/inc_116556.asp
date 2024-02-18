<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위글위글
' History : 2022.01.20 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
dim eCode, vUserID, cMil, vMileValue, vMileArr
dim eventStartDate, eventEndDate, currentDate, mktTest
vUserID = GetEncLoginUserID()
'vUserID = "10x10yellow"

IF application("Svr_Info") = "Dev" THEN
	eCode = "109450"
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
	eCode = "116556"
    mktTest = True
Else
	eCode = "116556"
    mktTest = False
End If

eventStartDate  = cdate("2022-01-21")		'이벤트 시작일
eventEndDate 	= cdate("2022-01-23")		'이벤트 종료일

if mktTest then
currentDate = cdate("2022-01-21")
else
currentDate = date()
end if
%>
<style>
.evt116556{background:url(//webimage.10x10.co.kr/fixevent/event/2022/116556/wiggle.jpg?v=1.02)no-repeat 50% 0;height:2285px;position:relative;}
.evt116556 .rotate01{position:absolute;top:320px;left:50%;margin-left:336px;animation: rotate 6s infinite;}
.evt116556 .rotate02{position:absolute;top:595px;left:50%;margin-left:-466px;animation: rotate 7s .5s infinite;}
.evt116556 .rotate03{position:absolute;top:980px;left:50%;margin-left:530px;animation: rotate 8s .6s infinite;}
.evt116556 .btn_alert{position:absolute;bottom:230px;left:50%;transform: translateX(-50%);}
@keyframes rotate {
    0% {
    transform: rotate(0deg)
    }
    8.33%, 25% {
        transform: rotate(90deg)
    }
    33.33%, 50% {
        transform: rotate(180deg)
    }
    58.33%, 75% {
        transform: rotate(270deg)
    }
    83.33%, 100% {
        transform: rotate(360deg)
    }
}
</style>
<script>
function doAlarm() {
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>
    <% If IsUserLoginOK() Then %>
        $.ajax({
            type: "POST",
            url:"/event/etc/doEventSubscript116556.asp",
            data: {
                mode: 'alarm'
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    alert(data.message);
                }else{
                    alert(data.message);
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% else %>
        jsSubmitlogin();
		return false;
    <% end if %>
}

function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}
</script>
						<div class="evt116556">
							<p class="rotate01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116556/flower01.png?v=1.01" alt=""></p>
							<p class="rotate02"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116556/flower02.png?v=1.01" alt=""></p>
							<p class="rotate03"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116556/flower03.png?v=1.01" alt=""></p>
                            <a href="" onclick="doAlarm();return false;" class="btn_alert"><img src="//webimage.10x10.co.kr/fixevent/event/2022/116556/btn_alert.png?v=1.01" alt=""></a>
                        </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->