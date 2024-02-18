<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 쿠폰전 이벤트
' History : 2019-07-05 최종원
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode, userid, couponIdx1, couponIdx2, couponIdx3, couponIdx4
IF application("Svr_Info") = "Dev" THEN
	eCode = "90327"
	couponIdx1 = "2903"     
	couponIdx2 = "2903"     
	couponIdx3 = "2903"     
	couponIdx4 = "2903"     
Else
	eCode = "95871"
	couponIdx1 = "1165"
	couponIdx2 = "1166"
	couponIdx3 = "1167"
	couponIdx4 = "1168"
End If

userid = GetEncLoginUserID()

dim eventEndDate, currentDate, eventStartDate
dim subscriptcount  
dim evtinfo : evtinfo = getEventDate(eCode)

if not isArray(evtinfo) then
	Call Alert_Return("잘못된 이벤트번호입니다.")
	dbget.close()	:	response.End
end if

'변수 초기화
eventStartDate = cdate(evtinfo(0,0))
eventEndDate = cdate(evtinfo(1,0))
currentDate = date()
'currentDate = Cdate("2019-05-04")
eventStartDate = cdate("2019-07-05")
%>
<style>
.evt95871 {width: 100%; height: 1712px; padding-top: 423px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/95871/img.jpg) no-repeat #fcf0e2 50% 0 /1920px auto; box-sizing: border-box;}
.evt95871 li a {display: block; width: 100%; height: 100%; text-indent: -9999px;}
.coupon-area {position: relative; width: 727px; height: 815px; margin: auto;}
.coupon-area li {position: absolute; }
.coupon-area li:nth-child(1) {top: 48px; left: 94px; width: 325px; height: 197px;}
.coupon-area li:nth-child(2) {top: 0; right: 34px; width: 223px; height: 356px;}
.coupon-area li:nth-child(3) {top: 300px; left: -35px; width: 260px; height: 220px;}
.coupon-area li:nth-child(4) {top: 395px; right: 92px; width: 360px; height: 212px;}
.bnr-area li {display: inline-block; width: 292px; height: 186px;}
</style>
<script type="text/javascript">
function jsDownCoupon(idx){
	<% if Not(IsUserLoginOK) then %>
		jsEventLogin();
	<% else %>
	$.ajax({
		type: "post",
		url: "/event/etc/doeventsubscript/doEvenSubscript95871.asp",		
		data: {
			eCode: '<%=eCode%>',
			couponIdx: idx
		},
		cache: false,
		success: function(resultData) {
			fnAmplitudeEventMultiPropertiesAction('click_coupon_btn','evtcode|idx','<%=eCode%>|'+idx)
			var reStr = resultData.split("|");				
			
			if(reStr[0]=="OK"){		
				alert('쿠폰이 발급되었습니다.\n마이텐바이텐에서 확인해보세요.')
			}else{
				var errorMsg = reStr[1].replace(">?n", "\n");
				alert(errorMsg);					
			}			
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
	<% end if %>
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
</script>        
	<!-- 쿠폰전 -->
	<div class="evt95871">
		<div class="coupon-area">
			<ul>
				<li><a href="javascript:jsDownCoupon('<%=couponIdx1%>')">3만원 이상 구매 시 삼천원</a></li>
				<li><a href="javascript:jsDownCoupon('<%=couponIdx2%>')">6만원 구매 시 8천원</a></li>
				<li><a href="javascript:jsDownCoupon('<%=couponIdx3%>')">25만원 구매 시 사만원</a></li>
				<li><a href="javascript:jsDownCoupon('<%=couponIdx4%>')">10만원 이상 구매 시 만오천원</a></li>
			</ul>
		</div>
		<div class="bnr-area">
			<ul>
				<li><a href="/event/eventmain.asp?eventid=95660">내가 꿈꾸는 드림하우스</a></li>
				<li><a href="/event/eventmain.asp?eventid=95659">주고받는 우리사이</a></li>
				<li><a href="/event/eventmain.asp?eventid=95664">바람직한 쿠폰 사용법</a></li>
			</ul>
		</div>
	</div>
	<!-- // 쿠폰전 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->