<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 로지텍 스토리 오픈
' History : 2021-10-13 정태훈
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim currentDate, eventStartDate, eventEndDate
dim eCode, userid, mktTest, subscriptcount, sqlstr, myTeaSet

IF application("Svr_Info") = "Dev" THEN
	eCode = "108373"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "114332"
    mktTest = true
Else
	eCode = "114332"
    mktTest = false
End If

eventStartDate = cdate("2021-10-14")	'이벤트 시작일
eventEndDate = cdate("2021-10-17")		'이벤트 종료일
if mktTest then
currentDate = cdate("2021-10-14")
else
currentDate = date()
end if

userid = GetEncLoginUserID()
%>
<style>
.section01{width:1920px;position:relative;top:0;left:50%;margin-left:-960px;}
.section02{background:url(//webimage.10x10.co.kr/fixevent/event/2021/114332/section01.jpg)no-repeat 50% 0;height:419px;}
.section03{position:relative;height:820px;background:#fff;}
.section03 .wrap-vod{width:1140px;position:absolute;top:0;left:50%;margin-left:-570px;}
.section03 .wrap-vod video{width:1140px}
.section03 .sound{text-align: center;color:#cecba6;font-size:19pt;font-weight:bold;position:absolute;width:100%;bottom:102px;}
.section04{background:url(//webimage.10x10.co.kr/fixevent/event/2021/114332/section02.jpg)no-repeat 50% 0;height:1004px;}
.section05{background:url(//webimage.10x10.co.kr/fixevent/event/2021/114332/section03.jpg)no-repeat 50% 0;height:775px;position:relative;}
.section05 a.alert{width:465px;height:105px;display:block;position:absolute;top:557px;left:50%;margin-left:-234.5px;}
</style>
<script>
$(function() {
	var myImage=document.getElementById("title_img");
	var imageArray=[
		"//webimage.10x10.co.kr/fixevent/event/2021/114332/on.png",
		"//webimage.10x10.co.kr/fixevent/event/2021/114332/off.png"];
	var imageIndex=0;

	function changeImage(){
	myImage.setAttribute("src",imageArray[imageIndex]);
	imageIndex++;
	if(imageIndex>=imageArray.length){
	imageIndex=0;
	}
	}
	setInterval(changeImage,2000);
   
});
function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}
function goPushScript(evt_code, pushTime){
<% If Not(IsUserLoginOK) Then %>
    jsSubmitlogin();
    return false;
<% else %>
    <% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>
        alert("이벤트 참여기간이 아닙니다.");
        return false;
    <% end if %>

    if(pushTime == 0){
        alert("푸시 신청 기간이 아닙니다.");
        return false;
    }else{
        $.ajax({
            type:"GET",
            url:"/event/etc/doeventsubscript/doEventSubscript114332.asp?mode=pushadd&evt_code=" + evt_code,
            dataType: "json",
            success : function(result){
                if(result.response == "ok"){
                    alert("푸시 알림 신청이 완료 되었습니다.");
                    return false;
                }else{
                    alert(result.faildesc);
                    return false;
                }
            },
            error:function(err){
                console.log(err);
                return false;
            }
        });
    }
<% end if %>
}
</script>
						<div class="evt114332">
							<section class="section01">
								<img id="title_img" src="" alt="">
							</section>
							<section class="section02"></section>
							<section class="section03">
								<div class="wrap-vod">
                                    <video poster="//webimage.10x10.co.kr/fixevent/event/2021/114332/poster.jpg" src="//webimage.10x10.co.kr/fixevent/event/2021/114332/logitech_ts.mp4" preload="auto" autoplay="autoplay" loop="loop" muted="muted" volume="0" controls></video>
                                </div>
                                <p class="sound">소리를 켜고 감상해 주세요</p>
							</section>
							<section class="section04"></section>
							<section class="section05">
								<a href="" onclick="goPushScript('<%=eCode%>', '2021-10-18');return false;" class="alert"></a>
							</section>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->