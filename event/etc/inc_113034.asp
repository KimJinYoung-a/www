<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 미리 추석
' History : 2021.08.18 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eventStartDate, eventEndDate, LoginUserid, mktTest
dim eCode, currentDate

IF application("Svr_Info") = "Dev" THEN
	eCode = "108390"
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
	eCode = "113034"
    mktTest = True
Else
	eCode = "113034"
    mktTest = False
End If

eventStartDate  = cdate("2021-08-16")		'이벤트 시작일
eventEndDate 	= cdate("2021-08-22")		'이벤트 종료일

LoginUserid		= getencLoginUserid()

if mktTest then
    currentDate = cdate("2021-08-16")
else
    currentDate = date()
end if
%>
<style>
.evt113034 .alert_area{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113034/113034_w_04.jpg)no-repeat 50% 0;height:895px;position:relative;}
.evt113034 .alert_area .alert{width:500px;height:100px;display:block;position:absolute;top:680px;left:50%;margin-left:-250px;}

.evt113034 .section{position:relative;}
.evt113034 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113034/top.jpg)no-repeat 50% 0;height:1839px;}
.evt113034 .section02{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113034/product.jpg)no-repeat 50% 0;height:2945px;}
.evt113034 .section02 .pro{width:1140px;margin-left:-570px;height:auto;position:absolute;top:136px;left:50%;}
.evt113034 .section02 .pro a{width:570px;height:450px;display:block;float:left;}
.evt113034 .section03{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113034/bottom.jpg)no-repeat 50% 0;height:1564px;}
.evt113034 .section03 a{width:500px;height:100px;position:absolute;bottom:122px;left:50%;margin-left:-250px;display:block;}
</style>
<script>
function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}
function doAlarm() {
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>
    <% If IsUserLoginOK() Then %>
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/doEventSubscript113034.asp",
            data: {
                mode: 'alarm'
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    alert("알림신청이 완료되었습니다.");
                }else{
                    alert(data.faildesc);
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
</script>
						<div class="evt113034">
							<section class="section section01"></section>
							<section class="section section02">
								<div class="pro">
									<a href="/shopping/category_prd.asp?itemid=3977897&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=3985028&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=3986060&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=3965810&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=3992137&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=3992094&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=3992093&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=2172278&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=3985857&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=3523266&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=3988801&pEtr=113034"></a>
									<a href="/shopping/category_prd.asp?itemid=3771537&pEtr=113034"></a>
								</div>
							</section>
							<div class="alert_area">
								<img src="//webimage.10x10.co.kr/fixevent/event/2021/113034/113034_w_1140_04.gif" alt="">
								<a href="" onclick="doAlarm();return false;" class="alert"></a>
							</div>
							<section class="section section03">
								<a href="#commentarea"></a>
							</section>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->