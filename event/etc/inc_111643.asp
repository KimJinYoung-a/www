<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2021 캠핑 마일리지 혜택 이벤트
' History : 2021-05-20 정태훈
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
	eCode = "106359"
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
	eCode = "111643"
    mktTest = True
Else
	eCode = "111643"
    mktTest = False
End If

if mktTest then
    currentDate = cdate("2021-05-24")
else
    currentDate = date()
end if

eventStartDate  = cdate("2021-05-24")		'이벤트 시작일
eventEndDate	= cdate("2021-06-02")		'이벤트 종료일

userid = GetEncLoginUserID()

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
end if
%>
<style type="text/css">
.evt111584 {background-color:#fff;}
.evt111584 .tab {display:flex; height:50px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111643/tab_event02.jpg) 50% 0 no-repeat;}
.evt111584 .tab a {display:inline-block; width:50%;}
.evt111584 .topic {position:relative; height:612px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111643/bg_main.jpg) 50% 0 no-repeat;}
.evt111584 .section-01 {height:615px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111643/bg_apply.jpg) 50% 0 no-repeat;}
.evt111584 .section-01 .apply-area {width:1140px; height:100%; margin:0 auto;}
.evt111584 .section-01 .apply-area button {width:550px; height:95px; margin-top:100px; background:transparent;}
.evt111584 .section-02 {height:653px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111643/bg_noti.jpg) 50% 0 no-repeat;}
.evt111584 .section-link {display:flex; height:124px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111585/img_link.jpg) 50% 0 no-repeat;}
.evt111584 .section-link a {display:inline-block; width:50%;}
</style>
<script>
var numOfTry = "<%=subscriptcount%>";
function eventTry(){
	<% If Not(IsUserLoginOK) Then %>
        jsEventLogin();
		return false;
	<% else %>
		<% If (currentDate >= eventStartDate And currentDate <= eventEndDate) Then %>
		if(numOfTry >= 1){
			// 한번 시도
			alert("이미 신청하셨습니다.");
			return false;
		}
		var returnCode, itemid, data
		var data={
			mode: "add"
		}
		$.ajax({
			type:"POST",
			url:"/event/etc/doEventSubscript111643.asp",
			data: data,
			dataType: "JSON",
			success : function(res){
				fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>')
					if(res!="") {
						// console.log(res)
						if(res.response == "ok"){
                            numOfTry++;
							alert('신청이 완료되었습니다.\n참여방법을 자세히 확인해주세요.');
							return false;
						}else{
							alert(res.faildesc);
							return false;
						}
					} else {
						alert("잘못된 접근 입니다.");
						document.location.reload();
						return false;
					}
			},
			error:function(err){
				console.log(err)
				alert("잘못된 접근 입니다.");
				return false;
			}
		});
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% End If %>
	<% End If %>
}
function jsEventLogin(){
    if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
        location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
        return;
    }
}
</script>
						<div class="evt111584">
                            <div class="tab">
                                <a href="/event/eventmain.asp?eventid=111584"></a>
                                <a href="/event/eventmain.asp?eventid=111643"></a>
                            </div>
                            <div class="topic"></div>
                            <div class="section-01">
                                <div class="apply-area">
                                    <!-- 신청하기 버튼 -->
                                    <button type="button" onClick="eventTry();"></button>
                                </div>
                            </div>
                            <div class="section-02"></div>
                            <div class="section-link">
                                <a href="/event/eventmain.asp?eventid=111230"></a>
                                <a href="/event/eventmain.asp?eventid=111188"></a>
                            </div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->