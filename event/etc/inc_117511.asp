<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  디지털 스티커 무료 배포
' History : 2022.03.17 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, vUserID
dim eventStartDate, eventEndDate, currentDate, mktTest
vUserID = GetEncLoginUserID()
'vUserID = "10x10yellow"

IF application("Svr_Info") = "Dev" THEN
    eCode = "109504"
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
    eCode = "117511"
    mktTest = True
Else
    eCode = "117511"
    mktTest = False
End If

eventStartDate  = cdate("2022-03-18")		'이벤트 시작일
eventEndDate 	= cdate("2022-09-16")		'이벤트 종료일

if mktTest then
currentDate = cdate("2022-03-18")
else
currentDate = date()
end if
%>
<style type="text/css">
.evt117511 {max-width:1920px; margin:0 auto;}
.evt117511 .relative {position:relative;}
.evt117511 .txt-hidden {font-size:0; text-indent:-9999px;}
.evt117511 .topic {width:100%; height:1580px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/117511/main.jpg) no-repeat 50% 0;}
.evt117511 .topic h2 {position:absolute; left:50%; top:153px; margin-left:-281px; opacity:0; transition:.8s; transform:translateY(0)}
.evt117511 .topic h2.on {opacity: 1; transform:translateY(20px)}
.evt117511 .txt01 {position:absolute; left:50%; top:481px; margin-left:-185px; animation:updown 1s ease-in-out alternate infinite;}
.evt117511 .btn-download {width:440px; height:135px; position:absolute; left:50%; bottom:102px; transform:translateX(-50%); background:transparent;}
.evt117511 .btn-brand {width:440px; height:135px; position:absolute; left:50%; bottom:112px; transform:translateX(-50%); background:transparent;}

@keyframes updown {
    0% {transform:translateY(0);}
    100% {transform:translateY(15px);}
}
</style>
<script>
$(function(){
	$('h2').addClass('on')
});

function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}

function fnDownloadFile(){
	<% If Not(IsUserLoginOK) Then %>
        jsSubmitlogin();
		return false;
	<% else %>
        $.ajax({
            type: "POST",
            url:"/event/etc/doEventSubscript117511.asp",
            data: {
                mode: 'down'
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('goodnote_event_download','evtcode','<%=eCode%>');
                }else if(data.response == "err"){
                    alert(data.message);
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
        fileDownload(5240);
    <% end if %>
}
function fnMoveBrand(){
    top.location.href="/street/street_brand_sub06.asp?makerid=BRMA";
	return false;
}
</script>
						<div class="evt117511">
							<div class="topic">
                                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2022/117511/tit.png" alt="디지털 스티커 무료 배포"></h2>
                            </div>
                            <div class="relative">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/117511/sub01.jpg" alt="스티커 구성">
                                <div class="txt01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117511/txt01.png" alt="6종으로 구성되어 있습니다."></div>
                                <button type="button" class="btn-download txt-hidden" onclick="fnDownloadFile();">다운로드 받기</button>
                            </div>
                            <div class="relative">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/117511/sub02.jpg" alt="사용방법">
                                <button type="button" class="btn-brand" onclick="fnMoveBrand();">
                                    <a href="#" class="txt-hidden">브랜드 바로가기</a>
                                </button>
                            </div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->