<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  더블 마일리지
' History : 2022.01.11 정태훈 생성
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
mktTest = True
ElseIf application("Svr_Info")="staging" Then
mktTest = True
Else
mktTest = False
End If
eventStartDate  = cdate("2022-01-12")		'이벤트 시작일
eventEndDate 	= cdate("2022-01-18")		'이벤트 종료일

if mktTest then
currentDate = cdate("2022-01-12")
else
currentDate = date()
end if

If currentDate >= eventStartDate And currentDate <= eventEndDate Then
    vMileValue = 400
Else
    vMileValue = 100
End If

Set cMil = New CEvaluateSearcher
cMil.FRectUserID = vUserID
cMil.FRectMileage = vMileValue

If vUserID <> "" Then
    vMileArr = cMil.getDoubleEvtEvaluatedTotalMileCnt
End If
Set cMil = Nothing
%>
<style>
.double-mileage {position:relative; background:#a234dd;}
.my-mileage {position:absolute; top:1249px; left:0; right:0; margin:auto; width:910px; padding-top:63px;}
.my-mileage h3 {height:18px; font-size:18px;}
.my-mileage h3 .txt {color:#a234dd;}
.my-mileage .user-id {display:inline-block; position:relative; top:-2px; padding:0 3px; margin-right:5px; line-height:18px; font-size:15px; color:#393939; font-weight:600; border-bottom:1px solid #686868;}
.my-mileage .overHidden {width:760px; margin:0 auto; padding-top:50px;}
.my-mileage ul {float:left;}
.my-mileage ul li {position:relative; overflow:hidden; width:293px;}
.my-mileage ul li + li {margin-top:14px;}
.my-mileage ul li .tit {position:absolute; font-size:0; color:transparent;}
.my-mileage ul li .num {display:block; height:36px; line-height:38px; font-size:21px; font-weight:700; text-align:right; cursor:default;}
.my-mileage ul li.m01 .num {color:#686868}
.my-mileage ul li.m02 .num {color:#f6424a;}
.my-mileage .btn-group {float:right; width:342px;}
.double-mileage .sec-aram {position:relative;}
.double-mileage .sec-aram button {width:400px; height:100px; position:absolute; left:50%; top:75%; transform:translate(-50%,0); background:transparent;}
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
			url:"/event/etc/doEventSubscript116558.asp",
			data: data,
			dataType: "JSON",
			success : function(res){
					if(res!="") {
						// console.log(res)
						if(res.response == "ok"){
							alert('신청이 완료되었습니다.\n1월 19일에 마일리지가 지급되면 알림톡이 발송됩니다.');
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
			alert("이벤트 참여기간이 아닙니다.");
			return;
		<% End If %>
	<% End If %>
}
</script>
						<div class="evt111791 double-mileage">
							<h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/116558/img_main.jpg" alt="더블 마일리지"></h2>
							<p><img src="//webimage.10x10.co.kr/fixevent/event/2021/116558/img_mge.jpg" alt=""></p>
							<div class="my-mileage">
								<% If IsUserLoginOK Then %>
								<h3>지금 <span class="user-id"><%= vUserID %></span>님이 <span class="txt">후기 작성하면 받을 수 있는 혜택</span></h3>
                                <% Else %>
                                <h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/100241/txt_check.png" alt="나의 예상 적립 마일리지를 확인하세요"></h3>
                                <% End If %>
								<div class="overHidden">
									<ul>
										<li class="m01">
											<strong class="tit">작성 가능한 후기 개수</strong>
											<span class="num"><% If IsUserLoginOK Then %><%=vMileArr(0,0)%><% End if %></span>
										</li>
										<li class="m02">
											<strong class="tit">예상 마일리지</strong>
											<span class="num"><% If IsUserLoginOK Then %><%=FormatNumber(vMileArr(1,0),0)%><% End if %></span>
										</li>
									</ul>
									<div class="btn-group">
										<% If IsUserLoginOK Then %>
										<a href="/my10x10/goodsusing.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2021/116558/btn_goprd.png" alt="상품 후기 쓰러 가기"></a>
                                        <% Else %>
                                        <a href="" onclick="jsSubmitlogin(); return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/114763/btn_gologin.png" alt="로그인 하기"></a>
                                        <% End If %>
									</div>
								</div>
							</div>
                            <div class="sec-aram">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/116558/img_aram.jpg" alt="이벤트 안내">
                                <!-- 알림 받기 -->
                                <button type="button" onclick="eventTry();"></button>
                            </div>
							<p><img src="//webimage.10x10.co.kr/fixevent/event/2021/116558/img_noti.jpg" alt="이벤트 유의사항"></p>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->