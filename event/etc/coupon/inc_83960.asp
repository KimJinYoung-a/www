<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'####################################################
' Description : APP 첫 구매 쿠폰
' History : 2018-01-23 이종화
'####################################################
Dim eCode, couponcnt,  getbonuscoupon1 , totalbonuscouponcountusingy1 
Dim userid :  userid = getencloginuserid()
Dim appdowncheck , itemordercheck
Dim couponImage

appdowncheck = True '// default 설치경험 있음
itemordercheck = True  '// 구매이력 있음
couponImage = "http://webimage.10x10.co.kr/eventIMG/2018/83960/img_coupon_v2.jpg"

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67488
	getbonuscoupon1 = 2863
	
Else
	eCode   =  83960
	If(datediff("d",now(),"2018-06-14") > 0) then
		getbonuscoupon1 = 1059
	Else
		getbonuscoupon1 = 1060
		couponImage = "http://webimage.10x10.co.kr/eventIMG/2018/83960/img_coupon_v3.jpg"
	End if
End If

'===============================금일 쿠폰 다운 사용자 팝업=================================================================
	dim couponRegDate 
	dim strSql
	If NOT (userid="") Then
		strSql = " SELECT REGDATE "
		strSql = strSql & "	FROM [db_user].[dbo].[tbl_user_coupon] "
		strSql = strSql & "	WHERE USERID = '"&userid&"' "		
		strSql = strSql & "	AND masteridx = '"&getbonuscoupon1&"' "		
		strSql = strSql & "	and isusing = 'N' "		
		strSql = strSql & "	and orderserial is null "				   
   
		rsget.CursorLocation = adUseClient
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly		
						
		if Not rsget.Eof Then
			couponRegDate = rsget("regdate")
		End If
		rsget.close		
	end if

'// 구매 이력 유무 (ID, 채널)
itemordercheck = fnUserGetOrderCheck(userid,"APP")
%>
<style type="text/css">
.evt83960 {background-color:#f4efe6;}
.coupon {position:relative;}
.coupon button {position:absolute; bottom:110px; left:50%; margin-left:-257px; background:transparent;}
.pop-ly {position:absolute; top:0; left:0; z-index:30; width:100%; height:100%; background-color:rgba(0, 0, 0, .7);}
.pop-ly .qr-code {position:absolute; top:280px; left:50%; margin-left:-220px;}
.pop-ly .qr-code > div{width:100%; height:100%; height:40px; background-color:#ededed;}
.pop-ly .qr-code .btnClose button{padding:15px 30px 13px 25px; background:#ededed url(http://webimage.10x10.co.kr/eventIMG/2018/83960/btn_close.png) 11px 18px no-repeat; font-size:12px; line-height:1; font-family:Dotum; font-weight:normal;}
.noti {position:relative; padding:45px 0; background-color:#ef3da9; text-align:left; color:#fff;}
.noti h3 {position:absolute; left:100px; top:50%; margin-top:-10px;}
.noti ul {margin-left:300px; padding-left:50px; line-height:25px; border-left:1px solid #f264ba;}
.noti ul li {text-indent:-10px;}
.noti ul li em{color:#ffe074;}
</style>
<script type="text/javascript">
$(function(){
	$(".pop-ly").hide();

	$(".pop-ly button").on("click", function(e){
		$(".pop-ly").hide();
	});
});

function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #01/24/2018 00:00:00# then %>
			<%' if not(itemordercheck) then  '// 두가지 조건이 모두 통과 해야 받음%>
				var str = $.ajax({
					type: "POST",
					url: "/common/appCouponIssued2.asp",
					///2015www/common/appCouponIssued.asp
					dataType: "text",
					async: false
				}).responseText;
				var str1 = str
				if(str1 == 1){
					$(".pop-ly").show();
				}else if(str1 == 77){
					alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
					return false;
				}else if(str1 == 88 || str1 == 99 ){
					alert('이벤트 대상이 아닙니다.');
					return false;
				}
				<%
				if not IsNull(couponRegDate) then
					if datediff("h", couponRegDate, now()) < 25 then
				%>
				else if(str1 == 66 || str1 == 55 || str1 == 44){
					$(".pop-ly").show();
					return false;
				}
				<%
					end if
				end if
				%>
				else if(str1 == 66 || str1 == 55 || str1 == 44){
					alert('이미 다운로드 받으셨습니다.');
					return false;
				}else{
					alert('오류가 발생했습니다.');
					return false;
				}
				// if (str1[0] == "11"){
				// 	//alert('쿠폰이 발급 되었습니다.\n24시간 이내 꼭 사용하세요.');
				// 	$(".pop-ly").show();
				// 	return false;
				// }else if (str1[0] == "12"){
				// 	alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
				// 	return false;
				// }else if (str1[0] == "13"){
				// 	//alert('이미 다운로드 받으셨습니다.');
				// 	$(".pop-ly").show();
				// 	return false;
				// }else if (str1[0] == "02"){
				// 	alert('로그인 후 쿠폰을 받을 수 있습니다!');
				// 	return false;
				// }else if (str1[0] == "01"){
				// 	alert('잘못된 접속입니다.');
				// 	return false;
				// }else if (str1[0] == "00"){
				// 	alert('정상적인 경로가 아닙니다.');
				// 	return false;
				// }else{
				// 	alert('오류가 발생했습니다.'+ str1[0]);
				// 	return false;
				// }
			<%' else %>
				// alert("죄송합니다.\n APP에서 구매 이력이 없으신 고객을 위한 이벤트 입니다.");
				// return;
			<%' end if %>
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 쿠폰을 받을 수 있습니다!")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>
<div class="evt83960">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/83960/tit_first_app.jpg" alt="APP 첫 구매 쿠폰 아직 APP에서 한번도 구매하지 않은 당신에게 보너스 쿠폰을 드립니다!" /></h2>
	<div class="coupon">
		<img src="<%=couponImage%>" alt="사용기간 : 다운로드 후 24시간 / ID당 1회 사용가능" />
		<button onclick="jsevtDownCoupon('evttosel24','<%= getbonuscoupon1 %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83960/btn_coupon.png" alt="쿠폰 다운받기" /></button>
	</div>
	<div class="pop-ly" style="display:none;">
		<div class="qr-code">
			<img src="http://webimage.10x10.co.kr/eventIMG/2018/83960/img_qr_code.jpg" alt="APP전용 쿠폰이 발급 되었습니다 텐바이텐 APP설치 후 사용하세요 QR코드 스캔하기" />
			<div><div class="btnClose ftRt"><button type="button" class="btn btnS1">닫기</button></div></div>
		</div>
	</div>
	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/83960/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 이벤트는 ID 당 1회만 참여할 수 있습니다. </li>
			<li><em>- 지급된 쿠폰은 텐바이텐 APP에서만 사용 가능 합니다.</em></li>
			<li>- 쿠폰은 발급 이후 24시간 이내 사용 가능합니다.</li>
			<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
			<li>- 이벤트는 조기 마감될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->