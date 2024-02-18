<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  선착순 마일리지
' History : 2022.02.15 정태훈 생성
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
    eCode = "109492"
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
    eCode = "116996"
    mktTest = True
Else
    eCode = "116996"
    mktTest = False
End If

eventStartDate  = cdate("2022-02-16")		'이벤트 시작일
eventEndDate 	= cdate("2022-02-17")		'이벤트 종료일

if mktTest then
currentDate = cdate("2022-02-16")
else
currentDate = date()
end if
%>
<style>
.evt116996 {max-width:1920px; margin:0 auto; background:#fff;}
.evt116996 .topic {position:relative; width:1140px; margin:0 auto;}
.evt116996 .topic .btn-milige {position:absolute; left:50%; bottom:110px; width:500px; height:166px; margin-left:-250px; background:transparent; font-size:0; text-indent:-9999px;}
</style>
<script type="text/javascript">
function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}
function eventTry(){
	<% If Not(IsUserLoginOK) Then %>
        jsSubmitlogin();
		return false;
	<% else %>
		<% If (currentDate >= eventStartDate And currentDate <= eventEndDate) Then %>
		var returnCode, itemid, data
		var data={
			mode: "add"
		}
		$.ajax({
			type:"POST",
			url:"/event/etc/doEventSubscript116996.asp",
			data: data,
			dataType: "JSON",
			success : function(res){
					if(res!="") {
						// console.log(res)
						if(res.response == "ok"){
							alert('마일리지가 지급 되었습니다.');
							return false;
						}else{
							alert(res.message);
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
			alert("이벤트 참여기간이 아닙니다.");
			return;
		<% End If %>
	<% End If %>
}
</script>
						<div class="evt116996">
							<div class="topic">
								<img src="http://webimage.10x10.co.kr/fixevent/event/2021/116996/img_main.jpg" alt="선착순 마일리지 지급" />
                                <button type="button" onclick="eventTry();" class="btn-milige">마일리지 받기</button>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->